; inherits: ecma


(call_expression
  function:
    ([
      (await_expression
        (member_expression
          property:
            (property_identifier) @_name))
      (member_expression
        property:
          (property_identifier) @_name)
    ] (#eq? @_name "$executeRaw"))
  arguments:
    ((template_string) @injection.content
      (#offset! @injection.content 0 1 0 -1)
      (#set! injection.include-children)
      (#set! injection.language "sql")))
(call_expression
  function:
    ([
      (await_expression
        (member_expression
          property:
            (property_identifier) @_name))
      (member_expression
        property:
          (property_identifier) @_name)
    ] (#eq? @_name "$queryRaw"))
  arguments:
    ((template_string) @injection.content
      (#offset! @injection.content 0 1 0 -1)
      (#set! injection.include-children)
      (#set! injection.language "sql")))
