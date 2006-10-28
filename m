From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Bug in taskSuspend for user mode vxworks
Date: Sat, 28 Oct 2006 20:28:05 +0200
References: <200610252346.34150.niklaus.giger@domain.hid>
	<200610281940.10654.niklaus.giger@domain.hid>
	<1162058429.4954.34.camel@domain.hid>
In-Reply-To: <1162058429.4954.34.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610282028.05334.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Am Samstag, 28. Oktober 2006 20:00 schrieb Philippe Gerum:
> On Sat, 2006-10-28 at 19:40 +0200, Niklaus Giger wrote:
> > > I recompiled the kernel with CONFIG_XENO_OPT_DEBUG disabled and the
> > > error went away.
> >
> > Actually I think the problem did not go away, as I did see that
> > in /proc/xenomai/faults the following error is incremented when I call
> > the attache simple program.
> > TRAP         CPU0
> >   0:            5    (Data or instruction access)
> > (Btw which exception is it attached on a PPC405 system?)
>
> 0x400, e.g. page fault.
>
> > Here is the stack trace of the simplified example attached as seen by t=
he
> > BDI with a hardware breakpoint at 0x300
> > #0  0x00000300 in ?? ()
> > No symbol table info available.
> > #1  0x100b8c48 in ?? ()
> > No symbol table info available.
> > #2  0x100b8c48 in ?? ()
> > No symbol table info available.
> > Previous frame inner to this frame (corrupt stack?)
> > (gdb)
> >
> > Setting a breakpoint at xnpod_fault_handler and a full backtrace gives =
me
> > (gdb) bt full
> > #0  xnpod_fault_handler (fltinfo=3D0xc1839e18)
> > at
> > /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/include/asm-generic/xenomai/sy=
st
> >em.h:200 thread =3D (xnthread_t *) 0xc0214f40
> > #1  0xc0048e90 in xnpod_trap_fault (fltinfo=3D0xc1839e18)
> > at
> > /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/kernel/xenomai/nucleus/pod.c:2=
90
> >7 No locals.
> > #2  0xc00438f4 in xnarch_trap_fault (event=3D3246628376, domid=3D148093=
7039,
> > data=3D0xc1839f50) at include2/asm/xenomai/bits/init.h:46
> >         fltinfo =3D {exception =3D 0, regs =3D 0xc1839f50}
> > #3  0xc011ffb8 in exception_event (event=3D3221520296, ipd=3D0x58454e4f,
> > data=3D0xc1839f50)
> >     at
> > /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xenomai/hal.c:385 No
> > locals.
> > #4  0xc003fecc in __ipipe_dispatch_event (event=3D0, data=3D0xc1839f50)
> > at /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/kernel/ipipe/core.c:668
> >         start_domain =3D (struct ipipe_domain *) 0xc0214f40
> >         this_domain =3D (struct ipipe_domain *) 0xc0214f40
> >         evhand =3D (ipipe_event_handler_t) 0xc0048e90
> > <xnpod_trap_fault+100> pos =3D (struct list_head *) 0xc0214f40
> >         npos =3D (struct list_head *) 0xc01c6540
> >         flags =3D 167984
> >         propagate =3D 1
> > #5  0xc000b02c in do_page_fault (regs=3D0xc1839f50, address=3D266719224,
> > error_code=3D0)
> >     at /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/mm/fault.c:119
> >         vma =3D (struct vm_area_struct *) 0xff86120
> >         mm =3D (struct mm_struct *) 0xc0200260
> >         info =3D {si_signo =3D 1, si_errno =3D -1071644672, si_code =3D
> > -1071579136, _sifields =3D {_pad =3D {0, -1048338784, -1048338608,
> >       -1071554848, -1070595192, -1048338768, -1073423884, -1048338608,
> > -1070595192, -1048338752, -1073422700, 0, 1, -1048338704,
> >       -1073418440, -1071710208, 14, 1, -1071733764, -1071710208,
> > -1071880896, 167984, 0, 16384, -1071880896, -1048338640, -1073479988,
> >       0, 0}, _kill =3D {_pid =3D 0, _uid =3D 3246628512}, _timer =3D {_=
tid =3D 0,
> > _overrun =3D -1048338784,
> >       _pad =3D
> > 0xc1839e94
> > "=C1\203\237P=C0!^=E0=C00\003\210=C1\203\236=B0=C0\004=D9=F4=C1\203\237=
P=C00\003\210=C1\203\236=C0=C0
> >\004=DE\224", _sigval =3D {
> >         sival_int =3D -1048338608, sival_ptr =3D 0xc1839f50}, _sys_priv=
ate
> > =3D -1071554848}, _rt =3D {_pid =3D 0, _uid =3D 3246628512, _sigval =3D=
 {
> >         sival_int =3D -1048338608, sival_ptr =3D 0xc1839f50}}, _sigchld=
 =3D
> > {_pid =3D 0, _uid =3D 3246628512, _status =3D -1048338608,
> >       _utime =3D -1071554848, _stime =3D -1070595192}, _sigfault =3D {_=
addr =3D
> > 0x0}, _sigpoll =3D {_band =3D 0, _fd =3D -1048338784}}}
> >         code =3D 196609
> >         is_write =3D 0
> >         __func__ =3D "do_page_fault"
> > #6  0xc0003258 in handle_page_fault ()
> > No locals.
> > (gdb)
> >
> > But I think it has something to do with my toolchain/compiler or my root
> > file system setup. I just found out, that compiling it with the same gcc
> > 3.4 compiler for my PowerBook and linking it statically the error got
> > away.
>
> I tried to reproduce the issue on a lite5200 here, to no avail. I'm
> using gcc 4.0 from Denx's ELDK 4.0, but I've never had such problem when
> using gcc 3.3.3 from ELDK 3.1 either.
>
> I wonder if something fishy is not happening with the code gcc generates
> to emit syscalls in some place of the library support.
>
Could be. I have only a gdbserver running on the PPC405 system. I compiled=
=20
again without ld -static. Then I do the following:
> This GDB was configured as "powerpc-linux-gnu"...Using host libthread_db
> library "/lib/tls/libthread_db.so.1".
>
> (gdb) set solib-absolute-prefix /mnt/data.ng/hcu/rootfs
> (gdb) dir /mnt/data.ng/hcu/rootfs
> Source directories searched: /mnt/data.ng/hcu/rootfs:$cdir:$cwd
> (gdb) target remote 172.25.1.5:2345
> Remote debugging using 172.25.1.5:2345
> 0x3000fa18 in ?? ()
> (gdb) cont
> Continuing.
> [New thread 16384]
>
> Program received signal SIGILL, Illegal instruction.
> [Switching to thread 16384]
> 0x3000ca1c in _dl_name_match_p () from /mnt/data.ng/hcu/rootfs/lib/ld.so.1
> (gdb) bt fu
> #0  0x3000ca1c in _dl_name_match_p () from
> /mnt/data.ng/hcu/rootfs/lib/ld.so.1 No symbol table info available.
> #1  0x30008878 in do_lookup_x () from /mnt/data.ng/hcu/rootfs/lib/ld.so.1
> No symbol table info available.
> #2  0x30008cd8 in _dl_lookup_symbol_x () from
> /mnt/data.ng/hcu/rootfs/lib/ld.so.1 No symbol table info available.
> #3  0x3000b2c8 in fixup () from /mnt/data.ng/hcu/rootfs/lib/ld.so.1
> No symbol table info available.
> #4  0x3000b528 in _dl_runtime_resolve () from
> /mnt/data.ng/hcu/rootfs/lib/ld.so.1 No symbol table info available.
> #5  0x3000b528 in _dl_runtime_resolve () from
> /mnt/data.ng/hcu/rootfs/lib/ld.so.1 No symbol table info available.
> #6  0x3000b528 in _dl_runtime_resolve () from
> /mnt/data.ng/hcu/rootfs/lib/ld.so.1 No symbol table info available.
> #7  0x3000b528 in _dl_runtime_resolve () from
> /mnt/data.ng/hcu/rootfs/lib/ld.so.1 No symbol table info available.
> #8  0x3000b528 in _dl_runtime_resolve () from
> /mnt/data.ng/hcu/rootfs/lib/ld.so.1 No symbol table info available.
> #9  0x3000b528 in _dl_runtime_resolve () from
> /mnt/data.ng/hcu/rootfs/lib/ld.so.1 No symbol table info available.
> #10 0x3000b528 in _dl_runtime_resolve () from
> /mnt/data.ng/hcu/rootfs/lib/ld.so.1 No symbol table info available.
> Previous frame inner to this frame (corrupt stack?)
> (gdb)
But I have no idea why I get this behaviour.
My toolchain is not a ELDK, but was also built using crosstool.

Setting a breakpoint at _dl_runtime_resolve gives:
> 0x3000fa18 in ?? ()
> (gdb) break _dl_runtime_resolve
> Function "_dl_runtime_resolve" not defined.
> Make breakpoint pending on future shared library load? (y or [n]) y
> Breakpoint 1 (_dl_runtime_resolve) pending.
> (gdb) cont
> Continuing.
> Breakpoint 2 at 0x3000b4f4
> Pending breakpoint "_dl_runtime_resolve" resolved
> [New thread 16384]
>
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to thread 16384]
> 0x00000000 in ?? ()
> (gdb) info stack
> #0  0x00000000 in ?? ()
> Cannot access memory at address 0x4
> (gdb) bt full
> #0  0x00000000 in ?? ()
> No symbol table info available.
> Cannot access memory at address 0x4

Best regards

=2D-=20
Niklaus Giger

