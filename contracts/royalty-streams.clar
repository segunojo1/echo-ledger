(define-map stream-royalties
  { track_id: uint }
  { stream_count: uint, total_earnings: uint })

(define-public (record-stream (track_id uint))
  (begin
    (let ((royalties (map-get? stream-royalties { track_id: track_id })))
      (match royalties
        some (let ((new_count (+ (get stream_count royalties) 1)))
               (let ((new_earnings (* new_count (get price (map-get? audio-licenses { track_id: track_id })))))
                 (map-set stream-royalties { track_id: track_id } { stream_count: new_count, total_earnings: new_earnings })
                 (ok "Stream recorded and royalties updated!")))
        none (map-set stream-royalties { track_id: track_id } { stream_count: 1, total_earnings: 0 })
               (ok "First stream recorded!")))))

(define-read-only (get-royalties (track_id uint))
  (let ((royalties (map-get? stream-royalties { track_id: track_id })))
    (match royalties
      some (ok royalties)
      none (err u108))))  ;; Track hasn't been streamed
