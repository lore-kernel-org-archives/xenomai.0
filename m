Message-ID: <4B657977.6050906@domain.hid>
Date: Sun, 31 Jan 2010 13:37:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <201001292104.42395.lux-integ@domain.hid>
In-Reply-To: <201001292104.42395.lux-integ@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA074B2CF35A116D2E5C5CF72"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] help with xenomai-2.5.0 on pure64bit linux x86_64
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: lux-integ <lux-integ@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA074B2CF35A116D2E5C5CF72
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

lux-integ wrote:
> Greetings
>=20
>  I am new to xenomai and I am attempting to   install    a RT-kernel on=
 a pure=20
> 64-bit  (not multilib) amd64 linux setup.  The machine has a Sempron CP=
U and=20
> 2 GBytes of RAM.  The distribution is cross-lfs  compiled from sources.=
  This=20
> is what I have done:-
>=20
> a) I   fetched fresh kernel2.6.32.2  source-code   and placed it=20
> in /usr/src/linux like so:-
> `linux' -> `linux-2.6.32.2'
>=20
> b) ..I then  applied  the  xenomai patch as such:-
> $SOURCES/xenomai-2.5.0/scripts/prepare-kernel.sh --linux=3D/usr/src/lin=
ux  --adeos=3D$SOURCES/xenomai-2.5.0/ksrc/arch/x86/patches/adeos-ipipe-2.=
6.32.2-x86-2.5-00.patch  --arch=3Dx86_64
>=20
> patching file arch/x86/Kconfig
> patching file arch/x86/include/asm/apic.h
> patching file arch/x86/include/asm/apicdef.h
> patching file arch/x86/include/asm/entry_arch.h
> patching file arch/x86/include/asm/hw_irq.h
> patching file arch/x86/include/asm/i387.h
> patching file arch/x86/include/asm/i8259.h
> patching file arch/x86/include/asm/ipi.h
> patching file arch/x86/include/asm/ipipe.h
> patching file arch/x86/include/asm/ipipe_32.h
> patching file arch/x86/include/asm/ipipe_64.h
> patching file arch/x86/include/asm/ipipe_base.h
> patching file arch/x86/include/asm/irq_vectors.h
> patching file arch/x86/include/asm/irqflags.h
> patching file arch/x86/include/asm/mmu_context.h
> patching file arch/x86/include/asm/nmi.h
> patching file arch/x86/include/asm/processor.h
> patching file arch/x86/include/asm/system.h
> patching file arch/x86/include/asm/traps.h
> patching file arch/x86/kernel/Makefile
> patching file arch/x86/kernel/apic/apic.c
> patching file arch/x86/kernel/apic/apic_flat_64.c
> patching file arch/x86/kernel/apic/io_apic.c
> patching file arch/x86/kernel/apic/ipi.c
> patching file arch/x86/kernel/apic/nmi.c
> patching file arch/x86/kernel/apic/x2apic_cluster.c
> patching file arch/x86/kernel/apic/x2apic_phys.c
> patching file arch/x86/kernel/cpu/mtrr/cyrix.c
> patching file arch/x86/kernel/cpu/mtrr/generic.c
> patching file arch/x86/kernel/dumpstack.c
> patching file arch/x86/kernel/dumpstack_32.c
> patching file arch/x86/kernel/dumpstack_64.c
> patching file arch/x86/kernel/entry_32.S
> patching file arch/x86/kernel/entry_64.S
> patching file arch/x86/kernel/i8253.c
> patching file arch/x86/kernel/i8259.c
> patching file arch/x86/kernel/ipipe.c
> patching file arch/x86/kernel/irq.c
> patching file arch/x86/kernel/irqinit.c
> patching file arch/x86/kernel/process.c
> patching file arch/x86/kernel/process_32.c
> patching file arch/x86/kernel/process_64.c
> patching file arch/x86/kernel/smp.c
> patching file arch/x86/kernel/smpboot.c
> patching file arch/x86/kernel/time.c
> patching file arch/x86/kernel/traps.c
> patching file arch/x86/kernel/vm86_32.c
> patching file arch/x86/lib/mmx_32.c
> patching file arch/x86/lib/thunk_64.S
> patching file arch/x86/mm/fault.c
> patching file arch/x86/mm/tlb.c
> patching file drivers/pci/htirq.c
> patching file drivers/serial/8250.c
> patching file fs/exec.c
> patching file include/asm-generic/atomic.h
> patching file include/asm-generic/bitops/atomic.h
> patching file include/asm-generic/cmpxchg-local.h
> patching file include/asm-generic/percpu.h
> patching file include/linux/hardirq.h
> patching file include/linux/ipipe.h
> patching file include/linux/ipipe_base.h
> patching file include/linux/ipipe_compat.h
> patching file include/linux/ipipe_lock.h
> patching file include/linux/ipipe_percpu.h
> patching file include/linux/ipipe_tickdev.h
> patching file include/linux/ipipe_trace.h
> patching file include/linux/irq.h
> patching file include/linux/kernel.h
> patching file include/linux/preempt.h
> patching file include/linux/sched.h
> patching file include/linux/spinlock.h
> patching file include/linux/spinlock_api_smp.h
> patching file init/Kconfig
> patching file init/main.c
> patching file kernel/Makefile
> patching file kernel/exit.c
> patching file kernel/fork.c
> patching file kernel/ipipe/Kconfig
> patching file kernel/ipipe/Kconfig.debug
> patching file kernel/ipipe/Makefile
> patching file kernel/ipipe/core.c
> patching file kernel/ipipe/tracer.c
> patching file kernel/irq/chip.c
> patching file kernel/irq/handle.c
> patching file kernel/lockdep.c
> patching file kernel/panic.c
> patching file kernel/power/hibernate.c
> patching file kernel/printk.c
> patching file kernel/sched.c
> patching file kernel/signal.c
> patching file kernel/spinlock.c
> patching file kernel/time/tick-common.c
> patching file kernel/time/tick-sched.c
> patching file kernel/timer.c
> patching file kernel/trace/ftrace.c
> patching file lib/Kconfig.debug
> patching file lib/bust_spinlocks.c
> patching file lib/ioremap.c
> patching file lib/smp_processor_id.c
> patching file mm/memory.c
> patching file mm/mmu_context.c
> patching file mm/vmalloc.c
>=20
> c) I configured the kernel using make menuconfig  disabling smp support=
  (here=20
> is the relevent section of my kernel configuration):-
> # CONFIG_X86_DS is not set
> CONFIG_HPET_TIMER=3Dy
> CONFIG_HPET_EMULATE_RTC=3Dy
> CONFIG_DMI=3Dy
> CONFIG_GART_IOMMU=3Dy
> CONFIG_CALGARY_IOMMU=3Dy
> CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=3Dy
> CONFIG_AMD_IOMMU=3Dy
> CONFIG_AMD_IOMMU_STATS=3Dy
> CONFIG_SWIOTLB=3Dy
> CONFIG_IOMMU_HELPER=3Dy
> CONFIG_IOMMU_API=3Dy
> CONFIG_NR_CPUS=3D1
>=20

Please provide your full .config so that we can reproduce this build erro=
r.

[ BTW, if you plan to use some PCI device with DMA under Xenomai,
enabling IOMMU is not a good idea. Reprogramming the IOMMU will then
become part of the critical path, but that code is not prepared for
real-time use. Better disable it during the build or on boot-up. ]

>=20
> d) but when I type make  I encountered a failure  like so:-
>=20
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/docproc
>   HOSTCC  scripts/basic/hash
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/kxgettext.o
>   SHIPPED scripts/kconfig/zconf.tab.c
>   SHIPPED scripts/kconfig/lex.zconf.c
>   SHIPPED scripts/kconfig/zconf.hash.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf -s arch/x86/Kconfig
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   UPD     include/linux/utsrelease.h
>   SYMLINK include/asm -> include/asm-x86
>   CC      kernel/bounds.s
>   GEN     include/linux/bounds.h
>   CC      arch/x86/kernel/asm-offsets.s
> In file included from include/linux/sched.h:62,
>                  from arch/x86/kernel/asm-offsets_64.c:8,
>                  from arch/x86/kernel/asm-offsets.c:4:
> include/linux/ipipe.h:76:2: error: #error "CONFIG_NR_CPUS is too large,=
 please=20
> lower it."
> make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
>=20
>=20
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D
> help would be appreciated

Jan


--------------enigA074B2CF35A116D2E5C5CF72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktleYMACgkQitSsb3rl5xQAFwCcCsBx4sfALS1Rb9kIZTkJK6sw
ZRAAoKe3nulk+O+Lq7aHcMACWUUIM8Kb
=DTEQ
-----END PGP SIGNATURE-----

--------------enigA074B2CF35A116D2E5C5CF72--

