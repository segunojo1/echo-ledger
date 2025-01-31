(define-map license-purchases
  { track_id: uint, buyer: principal }
  { purchase_timestamp: uint })

(define-public (buy-license (track_id uint))
  (begin
    (let ((license (map-get? audio-licenses { track_id: track_id })))
      (match license
        some (let ((price (get price license)))
               (asserts! (>= (stx-transfer? price tx-sender) true) (err u102)) ;; Ensure transfer is successful
               (map-set license-purchases { track_id: track_id, buyer: tx-sender } { purchase_timestamp: (get-block-height) })
               (ok "License purchased successfully!"))
        none (err u103)))))  ;; Track does not exist or is not available for purchase
