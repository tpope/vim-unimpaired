unimpaired.vim
==============

Much of unimpaired.vim was extracted from my vimrc when I noticed a
pattern: complementary pairs of mappings.  They mostly fall into three
categories.

There are mappings which are simply short normal mode aliases for
commonly used ex commands. `]q` is :cnext. `[q` is :cprevious. `]a` is
:next.  `[b` is :bprevious.  See the documentation for the full set of
20 mappings and mnemonics.  All of them take a count.

There are linewise mappings. `[<Space>` and `]<Space>` add newlines
before and after the cursor line. `[e` and `]e` exchange the current
line with the one above or below it.

There are mappings for encoding and decoding. `[x` and `]x` encode and
decode XML (and HTML). `[u` and `]u` encode and decode URLs. `[y` and
`]y` do C String style escaping. `[Y` and `]Y` encode and decode Base64.

And in the miscellaneous category, there's `[o` and `]o` to go to the
next/previous file in the directory, and `[n` and `]n` to jump between
SCM conflict markers.

The `.` command will work with the linewise encoding mappings if you
install [repeat.vim](https://github.com/tpope/vim-repeat).

Installation
------------

If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/tpope/vim-unimpaired.git

Once help tags have been generated, you can view the manual with
`:help unimpaired`.

Contributing
------------

See the contribution guidelines for
[pathogen.vim](https://github.com/tpope/vim-pathogen#readme).

Self-Promotion
--------------

Like unimpaired.vim? Follow the repository on
[GitHub](https://github.com/tpope/vim-unimpaired) and vote for it on
[vim.org](http://www.vim.org/scripts/script.php?script_id=1697).  And if
you're feeling especially charitable, follow [tpope](http://tpo.pe/) on
[Twitter](http://twitter.com/tpope) and
[GitHub](https://github.com/tpope).

License
-------

Copyright (c) Tim Pope.  Distributed under the same terms as Vim itself.
See `:help license`.
