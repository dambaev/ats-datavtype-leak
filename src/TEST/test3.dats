
#include "share/atspre_staload.hats"

#define ATS_DYNLOADFLAG 0

extern fn
  {a:viewt0ype}
  {env:viewt0ype}
  list_vt_foreach_funenv0
  {v:view}
  {fe:eff}
  {n:nat}
  ( pf: !v
  | A: !(list_vt(a, n))
  , env: !env
  , f: (!v | &a, !env) -<fun,fe> void
  ):<fe> void
implement {a}{env} list_vt_foreach_funenv0{v}{fe}{n}( pf | A, env, f) = loop( pf | A, env, f) where {
  fun
    loop
    {m:nat | m <= n}
    .<m>.
    ( pf: !v
    | xs: !list_vt( a, m)
    , env: !env
    , f: (!v | &a, !env) -<fun,fe> void
    ):<fun,fe> void =
    case+ xs of
    | list_vt_nil() => ()
    | list_vt_cons( head, tail) => loop( pf | tail, env, f) where {
      var vhead = head
      val () = f( pf | vhead, env)
      prval () = head := vhead
    }
}

fn
  test1(): void = {
  val kvs = $list_vt( 0, 1)
  val some = Some_vt(0)
  val env = ( g0ofg1 0, some)
  val () = list_vt_foreach_funenv0<int><(int, Option_vt(int))>{void}( () | kvs, env, foreach) where {
    fn foreach( pf: !void | x: &int, env: !( int, Option_vt(int))): void = {
    }
  }
  (* this should produce the compiler error, but it passes and produce a memory leak *)
  val (_, _) = env
  (* and this commented block should be required instead of one above *)
(*
  val (_, some1) = env
  prval () = some := some1
  val+ ~Some_vt(_) = some
*)
  val () = list_vt_freelin_fun<int> (kvs, cleaner) where {
    fn cleaner( x: &int >> int?):void = {
    }
  }

}

implement main0() = {
  val () = test1()
}