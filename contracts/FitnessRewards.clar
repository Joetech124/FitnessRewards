;; FitnessRewards: Workout Achievement Tracking System
;; Version: 1.0.0

(define-data-var program-admin principal tx-sender)
(define-data-var activity-pool uint u0)
(define-data-var workout-bonus uint u100) ;; bonus points added per block (example value)
(define-data-var bonus-timestamp uint u0) ;; last block when bonuses were calculated
(define-map athlete-activities principal uint)

;; Helper function to ensure only the program admin can perform certain actions
(define-private (is-admin (caller principal))
  (begin
    (asserts! (is-eq caller (var-get program-admin)) (err u100))
    (ok true)))

;; Initialize the contract
(define-public (initialize (admin principal))
  (begin
    (asserts! (is-none (map-get? athlete-activities admin)) (err u101))
    (var-set program-admin admin)
    (ok "FitnessRewards initialized")))

;; Add workout activities to the system
(define-public (add-activities (activities uint))
  (begin
    (asserts! (> activities u0) (err u102))
    (let ((current-activities (default-to u0 (map-get? athlete-activities tx-sender))))
      (map-set athlete-activities tx-sender (+ current-activities activities))
      (var-set activity-pool (+ (var-get activity-pool) activities))
      (ok (+ current-activities activities)))))

;; Calculate bonuses for all athletes
(define-public (allocate-bonuses)
  (begin
    (try! (is-admin tx-sender))
    (let ((current-block tenure-height)
          (previous-update (var-get bonus-timestamp)))
      (asserts! (> current-block previous-update) (err u103))
      ;; Calculate bonuses based on blocks elapsed
      (let ((elapsed (- current-block previous-update))
            (total-bonus (* elapsed (var-get workout-bonus))))
        (var-set bonus-timestamp current-block)
        (var-set activity-pool (+ (var-get activity-pool) total-bonus))
        (ok total-bonus)))))

;; Claim activities and bonuses
(define-public (claim)
  (begin
    (let ((athlete-achievement (default-to u0 (map-get? athlete-activities tx-sender))))
      (asserts! (> athlete-achievement u0) (err u104))
      (let ((total-activities (var-get activity-pool))
            (total-bonus (* (var-get workout-bonus) (- tenure-height (var-get bonus-timestamp))))
            (proportion (/ (* athlete-achievement u100000) total-activities)))
        ;; Update activities and calculate bonus proportion
        (let ((bonus-portion (/ (* proportion total-bonus) u100000)))
          (map-delete athlete-activities tx-sender)
          (var-set activity-pool (- (var-get activity-pool) athlete-achievement))
          (ok (+ athlete-achievement bonus-portion)))))))