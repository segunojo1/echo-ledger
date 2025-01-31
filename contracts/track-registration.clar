(define-map audio-registry
  { track_id: uint }
  { title: (buff 70), audio_fingerprint: (buff 256) })

(define-public (register-track (track_id uint) (title (buff 70)) (audio_fingerprint (buff 256)))
  (begin
    (asserts! (is-none (map-get? audio-registry { track_id: track_id })) (err u100))  ;; Ensure track isn't already registered
    (map-set audio-registry { track_id: track_id } { title: title, audio_fingerprint: audio_fingerprint })
    (ok "Track has been successfully registered!")
  ))
