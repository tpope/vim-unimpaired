Unimpaired
==========

This is a vim plugin that provides additional handy bracket maps.

Shortcuts for cycling through arguments, buffers, qlist, llist and tag matches
------------------------------------------------------------------------------

You can go through the previous/next argument with `[a`, `]a` and to first/last argument with `[A` and `]A`.
For buffers replace `a` with `b`.
For tag matches replace with `t`.
For entries in the quickfix list, replace with `q`.
For entries in the location list, replace with `l`.

Decoding/Encoding XML entities, URLs, C-strings
-----------------------------------------------

Use `[` for encoding and `]` for decoding, followed by `x` for XML entities, `u` for URL-encoding and `y` for C strings.
This is to not interfere with `[c` and `]c` that jump through changes in diff mode.

Additional shortcuts
--------------------

`[o`, `]o` : files in the current directory (in alphabetic order)
`[n`, `]n` : find conflict marker left in a SCM merge operation.
`[e`, `]e` : exchange (swap) lines with line {count} above/below
`[ `, `[ ` (spaces): add {count} blank lines above/below cursor

