(define-map audio-licenses
  { track_id: uint }
  { price: uint })

(define-public (set-licensing-price (track_id uint) (price uint))
  (begin
    (asserts! (is-eq (map-get? audio-registry { track_id: track_id }) some) (err u101))  ;; Ensure track exists
    (map-set audio-licenses { track_id: track_id } { price: price })
    (ok "Licensing price set successfully!"))
