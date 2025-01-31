(define-read-only (verify-license (track_id uint) (buyer principal))
  (let ((purchase (map-get? license-purchases { track_id: track_id, buyer: buyer })))
    (match purchase
      some (ok "License ownership verified!")
      none (err u104))))  ;; No such purchase exists
