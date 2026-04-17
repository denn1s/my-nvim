; extends

; <script type="text/babel"> / <script type="text/jsx">
; Default html injection strips "text/" and tries a "babel" parser which doesn't
; exist, leaving the block unhighlighted and confusing nvim-ts-autotag.
; Route these to the tsx parser so JSX works when teaching React via CDN.
((script_element
  (start_tag
    (attribute
      (attribute_name) @_attr
      (quoted_attribute_value
        (attribute_value) @_type)))
  (raw_text) @injection.content)
  (#eq? @_attr "type")
  (#any-of? @_type "text/babel" "text/jsx" "application/babel")
  (#set! injection.language "tsx"))
