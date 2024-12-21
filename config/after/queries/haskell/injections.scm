;; extends

; HTML: Text.Hamlet whamlet
(quasiquote
  (quoter) @_name
  (#eq? @_name "whamlet")
  (quasiquote_body) @injection.content
  (#set! injection.language "html"))
