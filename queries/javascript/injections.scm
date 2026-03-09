; extends

(call_expression
  function: (identifier) @_name
  arguments: (template_string
    (string_fragment) @injection.content)
  (#eq? @_name "html")
  (#set! injection.language "html"))
