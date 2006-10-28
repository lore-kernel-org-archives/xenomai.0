Subject: Re: [Xenomai-core] Bug in taskSuspend for user mode vxworks
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200610281940.10654.niklaus.giger@domain.hid>
References: <200610252346.34150.niklaus.giger@domain.hid>
	<1161967109.4983.13.camel@domain.hid>
	<200610281454.46672.niklaus.giger@domain.hid>
	<200610281940.10654.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 28 Oct 2006 20:00:29 +0200
Message-Id: <1162058429.4954.34.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

On Sat, 2006-10-28 at 19:40 +0200, Niklaus Giger wrote:
> > I recompiled the kernel with CONFIG_XENO_OPT_DEBUG disabled and the e=
rror
> > went away.
> Actually I think the problem did not go away, as I did see that=20
> in /proc/xenomai/faults the following error is incremented when I call =
the=20
> attache simple program.
> TRAP         CPU0
>   0:            5    (Data or instruction access)
> (Btw which exception is it attached on a PPC405 system?)
>=20

0x400, e.g. page fault.

> Here is the stack trace of the simplified example attached as seen by t=
he BDI=20
> with a hardware breakpoint at 0x300
> #0  0x00000300 in ?? ()
> No symbol table info available.
> #1  0x100b8c48 in ?? ()
> No symbol table info available.
> #2  0x100b8c48 in ?? ()
> No symbol table info available.
> Previous frame inner to this frame (corrupt stack?)
> (gdb)                                    =20
>=20
> Setting a breakpoint at xnpod_fault_handler and a full backtrace gives =
me=20
> (gdb) bt full
> #0  xnpod_fault_handler (fltinfo=3D0xc1839e18)=20
> at /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/include/asm-generic/xenomai=
/system.h:200
>         thread =3D (xnthread_t *) 0xc0214f40
> #1  0xc0048e90 in xnpod_trap_fault (fltinfo=3D0xc1839e18)=20
> at /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/kernel/xenomai/nucleus/pod.=
c:2907
> No locals.
> #2  0xc00438f4 in xnarch_trap_fault (event=3D3246628376, domid=3D148093=
7039,=20
> data=3D0xc1839f50) at include2/asm/xenomai/bits/init.h:46
>         fltinfo =3D {exception =3D 0, regs =3D 0xc1839f50}
> #3  0xc011ffb8 in exception_event (event=3D3221520296, ipd=3D0x58454e4f=
,=20
> data=3D0xc1839f50)
>     at /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xenomai/hal.c:=
385
> No locals.
> #4  0xc003fecc in __ipipe_dispatch_event (event=3D0, data=3D0xc1839f50)=
=20
> at /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/kernel/ipipe/core.c:668
>         start_domain =3D (struct ipipe_domain *) 0xc0214f40
>         this_domain =3D (struct ipipe_domain *) 0xc0214f40
>         evhand =3D (ipipe_event_handler_t) 0xc0048e90 <xnpod_trap_fault=
+100>
>         pos =3D (struct list_head *) 0xc0214f40
>         npos =3D (struct list_head *) 0xc01c6540
>         flags =3D 167984
>         propagate =3D 1
> #5  0xc000b02c in do_page_fault (regs=3D0xc1839f50, address=3D266719224=
,=20
> error_code=3D0)
>     at /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/mm/fault.c:119
>         vma =3D (struct vm_area_struct *) 0xff86120
>         mm =3D (struct mm_struct *) 0xc0200260
>         info =3D {si_signo =3D 1, si_errno =3D -1071644672, si_code =3D=
 -1071579136,=20
> _sifields =3D {_pad =3D {0, -1048338784, -1048338608,
>       -1071554848, -1070595192, -1048338768, -1073423884, -1048338608, =
-1070595192, -1048338752, -1073422700,=20
> 0, 1, -1048338704,
>       -1073418440, -1071710208, 14, 1, -1071733764, -1071710208, -10718=
80896,=20
> 167984, 0, 16384, -1071880896, -1048338640, -1073479988,
>       0, 0}, _kill =3D {_pid =3D 0, _uid =3D 3246628512}, _timer =3D {_=
tid =3D 0,=20
> _overrun =3D -1048338784,
>       _pad =3D=20
> 0xc1839e94 "=C1\203\237P=C0!^=E0=C00\003\210=C1\203\236=B0=C0\004=D9=F4=
=C1\203\237P=C00\003\210=C1\203\236=C0=C0\004=DE\224",=20
> _sigval =3D {
>         sival_int =3D -1048338608, sival_ptr =3D 0xc1839f50}, _sys_priv=
ate=20
> =3D -1071554848}, _rt =3D {_pid =3D 0, _uid =3D 3246628512, _sigval =3D=
 {
>         sival_int =3D -1048338608, sival_ptr =3D 0xc1839f50}}, _sigchld=
 =3D {_pid =3D=20
> 0, _uid =3D 3246628512, _status =3D -1048338608,
>       _utime =3D -1071554848, _stime =3D -1070595192}, _sigfault =3D {_=
addr =3D 0x0},=20
> _sigpoll =3D {_band =3D 0, _fd =3D -1048338784}}}
>         code =3D 196609
>         is_write =3D 0
>         __func__ =3D "do_page_fault"
> #6  0xc0003258 in handle_page_fault ()
> No locals.
> (gdb)  =20
>=20
> But I think it has something to do with my toolchain/compiler or my roo=
t file=20
> system setup. I just found out, that compiling it with the same gcc 3.4=
=20
> compiler for my PowerBook and linking it statically the error got away.
>=20

I tried to reproduce the issue on a lite5200 here, to no avail. I'm
using gcc 4.0 from Denx's ELDK 4.0, but I've never had such problem when
using gcc 3.3.3 from ELDK 3.1 either.

I wonder if something fishy is not happening with the code gcc generates
to emit syscalls in some place of the library support.

> I think I really have to reactivate my old Walnut board to have common=20
> platform to test with Wolfgang Grandegger.
>             =20
> Best regards
>           =20
--=20
Philippe.



