
#include "share/atspre_staload.hats"

#define ATS_DYNLOADFLAG 0

fn
  test1(): void = {
  val ls = $list_vt( 0, 1, 2)
  val _ = ls
}

implement main0() = {
  val () = test1()
}