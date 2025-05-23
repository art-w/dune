
  $ cat >dune-project <<EOF
  > (lang dune 3.18)
  > (package (name params))
  > (package (name mylib))
  > EOF

  $ mkdir param
  $ echo 'type t = int' > param/param_intf.mli
  $ cat >param/dune <<EOF
  > (library_parameter (public_name params.intf1) (name param_intf))
  > EOF

  $ mkdir param2
  $ echo 'val foo : int -> int' > param2/param2_intf.mli
  $ cat >param2/dune <<EOF
  > (library_parameter (public_name params.intf2) (name param2_intf))
  > EOF

  $ mkdir mylib
  $ echo 'type t = Param_intf.t' > mylib/foo.ml
  $ echo 'type t = Foo.t let f = Param2_intf.foo' > mylib/mylib.ml
  $ cat >mylib/dune <<EOF
  > (library (public_name mylib) (name mylib) (parameters param_intf params.intf2))
  > EOF

  $ dune build --verbose
  Shared cache: enabled-except-user-rules
  Shared cache location: /home/arthur/.cache/dune/db
  Workspace root:
  $TESTCASE_ROOT
  Dune context:
   { name = "default"
   ; kind = "default"
   ; profile = Dev
   ; merlin = true
   ; fdo_target_exe = None
   ; build_dir = In_build_dir "default"
   ; instrument_with = []
   }
  Actual targets:
  - alias @@default
  Running[1]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamldep.opt -modules -impl mylib/mylib.ml) > _build/default/mylib/.mylib.objs/mylib.impl.d
  Running[2]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamlc.opt -w @1..3@5..28@31..39@43@46..47@49..57@61..62@67@69-40 -strict-sequence -strict-formats -short-paths -keep-locs -g -bin-annot -bin-annot-occurrences -I param/.param_intf.objs/byte -as-parameter -no-alias-deps -opaque -o param/.param_intf.objs/byte/param_intf.cmi -c -intf param/param_intf.mli)
  Running[3]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamlc.opt -w @1..3@5..28@31..39@43@46..47@49..57@61..62@67@69-40 -strict-sequence -strict-formats -short-paths -keep-locs -g -bin-annot -bin-annot-occurrences -I param2/.param2_intf.objs/byte -as-parameter -no-alias-deps -opaque -o param2/.param2_intf.objs/byte/param2_intf.cmi -c -intf param2/param2_intf.mli)
  Running[4]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamlc.opt -w @1..3@5..28@31..39@43@46..47@49..57@61..62@67@69-40 -strict-sequence -strict-formats -short-paths -keep-locs -w -49 -nopervasives -nostdlib -g -bin-annot -bin-annot-occurrences -I mylib/.mylib.objs/byte -no-alias-deps -opaque -o mylib/.mylib.objs/byte/mylib__.cmo -c -impl mylib/mylib__.ml-gen)
  Running[5]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamldep.opt -modules -impl mylib/foo.ml) > _build/default/mylib/.mylib.objs/mylib__Foo.impl.d
  Running[6]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamlopt.opt -w @1..3@5..28@31..39@43@46..47@49..57@61..62@67@69-40 -strict-sequence -strict-formats -short-paths -keep-locs -w -49 -nopervasives -nostdlib -g -I mylib/.mylib.objs/byte -I mylib/.mylib.objs/native -intf-suffix .ml-gen -no-alias-deps -opaque -o mylib/.mylib.objs/native/mylib__.cmx -c -impl mylib/mylib__.ml-gen)
  Running[7]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamlc.opt -w @1..3@5..28@31..39@43@46..47@49..57@61..62@67@69-40 -strict-sequence -strict-formats -short-paths -keep-locs -g -bin-annot -bin-annot-occurrences -I mylib/.mylib.objs/byte -I param/.param_intf.objs/byte -I param2/.param2_intf.objs/byte -parameter Param_intf -parameter Param2_intf -no-alias-deps -opaque -open Mylib__ -o mylib/.mylib.objs/byte/mylib__Foo.cmo -c -impl mylib/foo.ml)
  Running[8]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamlopt.opt -w @1..3@5..28@31..39@43@46..47@49..57@61..62@67@69-40 -strict-sequence -strict-formats -short-paths -keep-locs -g -I mylib/.mylib.objs/byte -I mylib/.mylib.objs/native -I param/.param_intf.objs/byte -I param/.param_intf.objs/native -I param2/.param2_intf.objs/byte -I param2/.param2_intf.objs/native -intf-suffix .ml -parameter Param_intf -parameter Param2_intf -no-alias-deps -opaque -open Mylib__ -o mylib/.mylib.objs/native/mylib__Foo.cmx -c -impl mylib/foo.ml)
  Running[9]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamlc.opt -w @1..3@5..28@31..39@43@46..47@49..57@61..62@67@69-40 -strict-sequence -strict-formats -short-paths -keep-locs -g -bin-annot -bin-annot-occurrences -I mylib/.mylib.objs/byte -I param/.param_intf.objs/byte -I param2/.param2_intf.objs/byte -parameter Param_intf -parameter Param2_intf -no-alias-deps -opaque -open Mylib__ -o mylib/.mylib.objs/byte/mylib.cmo -c -impl mylib/mylib.ml)
  Running[10]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamlopt.opt -w @1..3@5..28@31..39@43@46..47@49..57@61..62@67@69-40 -strict-sequence -strict-formats -short-paths -keep-locs -g -I mylib/.mylib.objs/byte -I mylib/.mylib.objs/native -I param/.param_intf.objs/byte -I param/.param_intf.objs/native -I param2/.param2_intf.objs/byte -I param2/.param2_intf.objs/native -intf-suffix .ml -parameter Param_intf -parameter Param2_intf -no-alias-deps -opaque -open Mylib__ -o mylib/.mylib.objs/native/mylib.cmx -c -impl mylib/mylib.ml)
  Running[11]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamlc.opt -w @1..3@5..28@31..39@43@46..47@49..57@61..62@67@69-40 -strict-sequence -strict-formats -short-paths -keep-locs -g -a -o mylib/mylib.cma mylib/.mylib.objs/byte/mylib__.cmo mylib/.mylib.objs/byte/mylib__Foo.cmo mylib/.mylib.objs/byte/mylib.cmo)
  Running[12]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamlopt.opt -w @1..3@5..28@31..39@43@46..47@49..57@61..62@67@69-40 -strict-sequence -strict-formats -short-paths -keep-locs -g -a -o mylib/mylib.cmxa mylib/.mylib.objs/native/mylib__.cmx mylib/.mylib.objs/native/mylib__Foo.cmx mylib/.mylib.objs/native/mylib.cmx)
  Running[13]: (cd _build/default && /home/arthur/.opam/oxcaml2/bin/ocamlopt.opt -w @1..3@5..28@31..39@43@46..47@49..57@61..62@67@69-40 -strict-sequence -strict-formats -short-paths -keep-locs -g -shared -linkall -I mylib -o mylib/mylib.cmxs mylib/mylib.cmxa)

  $ tree -a
  .
  |-- _build
  |   |-- .db
  |   |-- .digest-db
  |   |-- .filesystem-clock
  |   |-- .lock
  |   |-- default
  |   |   |-- .dune
  |   |   |   |-- configurator
  |   |   |   `-- configurator.v2
  |   |   |-- META.mylib
  |   |   |-- META.params
  |   |   |-- mylib
  |   |   |   |-- .merlin-conf
  |   |   |   |   `-- lib-mylib
  |   |   |   |-- .mylib.objs
  |   |   |   |   |-- byte
  |   |   |   |   |   |-- mylib.cmi
  |   |   |   |   |   |-- mylib.cmo
  |   |   |   |   |   |-- mylib.cmt
  |   |   |   |   |   |-- mylib__.cmi
  |   |   |   |   |   |-- mylib__.cmo
  |   |   |   |   |   |-- mylib__.cmt
  |   |   |   |   |   |-- mylib__Foo.cmi
  |   |   |   |   |   |-- mylib__Foo.cmo
  |   |   |   |   |   `-- mylib__Foo.cmt
  |   |   |   |   |-- mylib.impl.all-deps
  |   |   |   |   |-- mylib.impl.d
  |   |   |   |   |-- mylib__Foo.impl.all-deps
  |   |   |   |   |-- mylib__Foo.impl.d
  |   |   |   |   `-- native
  |   |   |   |       |-- mylib.cmx
  |   |   |   |       |-- mylib.o
  |   |   |   |       |-- mylib__.cmx
  |   |   |   |       |-- mylib__.o
  |   |   |   |       |-- mylib__Foo.cmx
  |   |   |   |       `-- mylib__Foo.o
  |   |   |   |-- foo.ml
  |   |   |   |-- mylib.a
  |   |   |   |-- mylib.cma
  |   |   |   |-- mylib.cmxa
  |   |   |   |-- mylib.cmxs
  |   |   |   |-- mylib.ml
  |   |   |   `-- mylib__.ml-gen
  |   |   |-- mylib.dune-package
  |   |   |-- mylib.install
  |   |   |-- param
  |   |   |   |-- .merlin-conf
  |   |   |   |   `-- lib-params.intf1
  |   |   |   |-- .param_intf.objs
  |   |   |   |   `-- byte
  |   |   |   |       |-- param_intf.cmi
  |   |   |   |       `-- param_intf.cmti
  |   |   |   `-- param_intf.mli
  |   |   |-- param2
  |   |   |   |-- .merlin-conf
  |   |   |   |   `-- lib-params.intf2
  |   |   |   |-- .param2_intf.objs
  |   |   |   |   `-- byte
  |   |   |   |       |-- param2_intf.cmi
  |   |   |   |       `-- param2_intf.cmti
  |   |   |   `-- param2_intf.mli
  |   |   |-- params.dune-package
  |   |   `-- params.install
  |   |-- install
  |   |   `-- default
  |   |       `-- lib
  |   |           |-- mylib
  |   |           |   |-- META -> ../../../../default/META.mylib
  |   |           |   |-- dune-package -> ../../../../default/mylib.dune-package
  |   |           |   |-- foo.ml -> ../../../../default/mylib/foo.ml
  |   |           |   |-- mylib.a -> ../../../../default/mylib/mylib.a
  |   |           |   |-- mylib.cma -> ../../../../default/mylib/mylib.cma
  |   |           |   |-- mylib.cmi -> ../../../../default/mylib/.mylib.objs/byte/mylib.cmi
  |   |           |   |-- mylib.cmt -> ../../../../default/mylib/.mylib.objs/byte/mylib.cmt
  |   |           |   |-- mylib.cmx -> ../../../../default/mylib/.mylib.objs/native/mylib.cmx
  |   |           |   |-- mylib.cmxa -> ../../../../default/mylib/mylib.cmxa
  |   |           |   |-- mylib.cmxs -> ../../../../default/mylib/mylib.cmxs
  |   |           |   |-- mylib.ml -> ../../../../default/mylib/mylib.ml
  |   |           |   |-- mylib__.cmi -> ../../../../default/mylib/.mylib.objs/byte/mylib__.cmi
  |   |           |   |-- mylib__.cmt -> ../../../../default/mylib/.mylib.objs/byte/mylib__.cmt
  |   |           |   |-- mylib__.cmx -> ../../../../default/mylib/.mylib.objs/native/mylib__.cmx
  |   |           |   |-- mylib__.ml -> ../../../../default/mylib/mylib__.ml-gen
  |   |           |   |-- mylib__Foo.cmi -> ../../../../default/mylib/.mylib.objs/byte/mylib__Foo.cmi
  |   |           |   |-- mylib__Foo.cmt -> ../../../../default/mylib/.mylib.objs/byte/mylib__Foo.cmt
  |   |           |   `-- mylib__Foo.cmx -> ../../../../default/mylib/.mylib.objs/native/mylib__Foo.cmx
  |   |           `-- params
  |   |               |-- META -> ../../../../default/META.params
  |   |               |-- dune-package -> ../../../../default/params.dune-package
  |   |               |-- intf1
  |   |               |   |-- param_intf.cmi -> ../../../../../default/param/.param_intf.objs/byte/param_intf.cmi
  |   |               |   |-- param_intf.cmti -> ../../../../../default/param/.param_intf.objs/byte/param_intf.cmti
  |   |               |   `-- param_intf.mli -> ../../../../../default/param/param_intf.mli
  |   |               `-- intf2
  |   |                   |-- param2_intf.cmi -> ../../../../../default/param2/.param2_intf.objs/byte/param2_intf.cmi
  |   |                   |-- param2_intf.cmti -> ../../../../../default/param2/.param2_intf.objs/byte/param2_intf.cmti
  |   |                   `-- param2_intf.mli -> ../../../../../default/param2/param2_intf.mli
  |   `-- log
  |-- dune-project
  |-- mylib
  |   |-- dune
  |   |-- foo.ml
  |   `-- mylib.ml
  |-- param
  |   |-- dune
  |   `-- param_intf.mli
  `-- param2
      |-- dune
      `-- param2_intf.mli
  
  26 directories, 82 files
  $ ocamlobjinfo _build/default/mylib/.mylib.objs/byte/mylib.cmo | grep -A 2 'Runtime param'
  Runtime parameters:
  	Param_intf
  	Param2_intf
  $ ocamlobjinfo _build/default/mylib/.mylib.objs/native/mylib.cmx | grep -A 2 'Runtime param'
  Runtime parameters:
  	Param_intf
  	Param2_intf

  $ dune build @install
  $ cat _build/install/default/lib/mylib/META
  description = ""
  requires = "params.intf1 params.intf2"
  archive(byte) = "mylib.cma"
  archive(native) = "mylib.cmxa"
  plugin(byte) = "mylib.cma"
  plugin(native) = "mylib.cmxs"
  $ cat _build/install/default/lib/mylib/dune-package
  (lang dune 3.19)
  (name mylib)
  (sections (lib .) (libexec .))
  (files
   (lib
    (META
     dune-package
     foo.ml
     mylib.a
     mylib.cma
     mylib.cmi
     mylib.cmt
     mylib.cmx
     mylib.cmxa
     mylib.ml
     mylib__.cmi
     mylib__.cmt
     mylib__.cmx
     mylib__.ml
     mylib__Foo.cmi
     mylib__Foo.cmt
     mylib__Foo.cmx))
   (libexec (mylib.cmxs)))
  (library
   (name mylib)
   (kind normal)
   (archives (byte mylib.cma) (native mylib.cmxa))
   (plugins (byte mylib.cma) (native mylib.cmxs))
   (native_archives mylib.a)
   (requires params.intf1 params.intf2)
   (parameters param_intf params.intf2)
   (main_module_name Mylib)
   (modes byte native)
   (modules
    (wrapped
     (group
      (alias
       (obj_name mylib__)
       (visibility public)
       (kind alias)
       (source (path Mylib__) (impl (path mylib__.ml-gen))))
      (name Mylib)
      (modules
       (module
        (obj_name mylib__Foo)
        (visibility public)
        (source (path Foo) (impl (path foo.ml))))
       (module
        (obj_name mylib)
        (visibility public)
        (source (path Mylib) (impl (path mylib.ml))))))
     (wrapped true))))
