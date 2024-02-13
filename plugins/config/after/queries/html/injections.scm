;; extends
; Alpine.js
(attribute
  (
    [
      ((attribute_name) @alpine.simple
        (#any-of? @alpine.simple
          "x-data"
          "x-effect"
          "x-for"
          "x-html"
          "x-id"
          "x-if"
          "x-init"
          "x-model"
          "x-modelable"
          "x-ref"
          "x-show"
          "x-teleport"
          "x-text"
          ":class"
          ":id"
          ":placeholder"
          ":selected"
          ":style"
        ))
      ((attribute_name) @alpine.at-shortcut
        (#match? @alpine.at-shortcut "^\\@.*$"))
      ((attribute_name) @alpine.x-on
        (#match? @alpine.x-on "^x-on:.+$"))
      ((attribute_name) @alpine.x-bind
        (#match? @alpine.x-bind "^x-bind:.+$"))
    ]
    (quoted_attribute_value
      (attribute_value) @injection.content (#set! injection.language "javascript")
    )
  )
)
