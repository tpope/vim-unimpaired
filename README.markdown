Unimpaired
==========

This is a vim plugin that provides additional handy bracket maps.

Shortcuts for cycling through arguments, buffers, qlist, llist and tag matches
------------------------------------------------------------------------------

You can go through the previous/next argument with `[a`, `]a` and to first/last argument with `[A` and `]A`.  
Replace `a` with

 * `b` for buffers,
 * `t` for tag matches,
 * `q` for entries of the quickfix list,
 * `l` for entries of the location list.  

Decoding/Encoding XML entities, URLs, C-strings
-----------------------------------------------

Use `[` for encoding and `]` for decoding, followed by

 * `x` for XML entities,
 * `u` for URL-encoding and
 * `y` for C strings. (`[c` and `]c` are already used for jumping through changes in diff mode).

Additional shortcuts
--------------------

`[o`, `]o` : nagivate between files in the current directory (in alphabetic order)  
`[n`, `]n` : find previous/next conflict marker left by a SCM merge operation.  
`[e`, `]e` : exchange (swap) current line with {count}th line above/below  
`[<space>`, `]<space>` : add {count} blank lines above/below current

