
#include "share/atspre_staload.hats"

#define ATS_DYNLOADFLAG 0

#define LIBS_targetloc "../libs" (* search path for external libs *)

#include "{$LIBS}/ats-bytestring/HATS/bytestring.hats" (* overload operators *)
staload UN="prelude/SATS/unsafe.sats"

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
  val kvs = $list_vt( $BS.pack "test")
  val some = $BS.pack "test"
  val env = ( g0ofg1 0, some)
  val () = list_vt_foreach_funenv0<$BS.BytestringNSH1><(int, $BS.BytestringNSH1)>{void}( () | kvs, env, foreach) where {
    fn foreach( pf: !void | x: &($BS.BytestringNSH1), env: !( int, $BS.BytestringNSH1)): void = {
    }
  }
  (* this should produce the compiler error *)
  val (_, _) = env
  (* and this commented block should be required *)
(*
  val (_, some1) = env
  prval () = some := some1
  val () = $BS.free some
*)
  val () = list_vt_freelin_fun<$BS.BytestringNSH1> (kvs, cleaner) where {
    fn cleaner( x: &($BS.BytestringNSH1) >> $BS.BytestringNSH1?):void = {
      val () = $BS.free x
    }
  }

}

implement main0() = {
  val () = test1()
}