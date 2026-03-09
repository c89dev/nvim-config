; extends

(
 (comment) @_c
 (template_string) @injection.content
 (#match? @_c "html")
 (#set! injection.language "html")
)
