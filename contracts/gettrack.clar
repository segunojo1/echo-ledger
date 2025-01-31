(define-read-only (get-track-details (track_id uint))
  (let ((track (map-get? audio-registry { track_id: track_id })))
    (match track
      some (ok track)
      none (err u107))))  ;; Track does not exist
