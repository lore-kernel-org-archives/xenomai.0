Message-ID: <4B6588AC.4070105@domain.hid>
Date: Sun, 31 Jan 2010 14:42:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <201001292104.42395.lux-integ@domain.hid>	
	<4B657977.6050906@domain.hid>
	<1264944150.16492.72.camel@domain.hid>	
	<4B6584DA.2010707@domain.hid>
	<1264944906.16492.74.camel@domain.hid>
In-Reply-To: <1264944906.16492.74.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig33D793189C628A075FD0FD8F"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig33D793189C628A075FD0FD8F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2010-01-31 at 14:25 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Sun, 2010-01-31 at 13:37 +0100, Jan Kiszka wrote:
>>>> lux-integ wrote:
>>>>> Greetings
>>>>>
>>>>>  I am new to xenomai and I am attempting to   install    a RT-kerne=
l on a pure=20
>>>>> 64-bit  (not multilib) amd64 linux setup.  The machine has a Sempro=
n CPU and=20
>>>>> 2 GBytes of RAM.  The distribution is cross-lfs  compiled from sour=
ces.  This=20
>>>>> is what I have done:-
>>>>>
>>>>> a) I   fetched fresh kernel2.6.32.2  source-code   and placed it=20
>>>>> in /usr/src/linux like so:-
>>>>> `linux' -> `linux-2.6.32.2'
>>>>>
>>>>> b) ..I then  applied  the  xenomai patch as such:-
>>>>> $SOURCES/xenomai-2.5.0/scripts/prepare-kernel.sh --linux=3D/usr/src=
/linux  --adeos=3D$SOURCES/xenomai-2.5.0/ksrc/arch/x86/patches/adeos-ipip=
e-2.6.32.2-x86-2.5-00.patch  --arch=3Dx86_64
>>>>>
>>>>> patching file arch/x86/Kconfig
>>>>> patching file arch/x86/include/asm/apic.h
>>>>> patching file arch/x86/include/asm/apicdef.h
>>>>> patching file arch/x86/include/asm/entry_arch.h
>>>>> patching file arch/x86/include/asm/hw_irq.h
>>>>> patching file arch/x86/include/asm/i387.h
>>>>> patching file arch/x86/include/asm/i8259.h
>>>>> patching file arch/x86/include/asm/ipi.h
>>>>> patching file arch/x86/include/asm/ipipe.h
>>>>> patching file arch/x86/include/asm/ipipe_32.h
>>>>> patching file arch/x86/include/asm/ipipe_64.h
>>>>> patching file arch/x86/include/asm/ipipe_base.h
>>>>> patching file arch/x86/include/asm/irq_vectors.h
>>>>> patching file arch/x86/include/asm/irqflags.h
>>>>> patching file arch/x86/include/asm/mmu_context.h
>>>>> patching file arch/x86/include/asm/nmi.h
>>>>> patching file arch/x86/include/asm/processor.h
>>>>> patching file arch/x86/include/asm/system.h
>>>>> patching file arch/x86/include/asm/traps.h
>>>>> patching file arch/x86/kernel/Makefile
>>>>> patching file arch/x86/kernel/apic/apic.c
>>>>> patching file arch/x86/kernel/apic/apic_flat_64.c
>>>>> patching file arch/x86/kernel/apic/io_apic.c
>>>>> patching file arch/x86/kernel/apic/ipi.c
>>>>> patching file arch/x86/kernel/apic/nmi.c
>>>>> patching file arch/x86/kernel/apic/x2apic_cluster.c
>>>>> patching file arch/x86/kernel/apic/x2apic_phys.c
>>>>> patching file arch/x86/kernel/cpu/mtrr/cyrix.c
>>>>> patching file arch/x86/kernel/cpu/mtrr/generic.c
>>>>> patching file arch/x86/kernel/dumpstack.c
>>>>> patching file arch/x86/kernel/dumpstack_32.c
>>>>> patching file arch/x86/kernel/dumpstack_64.c
>>>>> patching file arch/x86/kernel/entry_32.S
>>>>> patching file arch/x86/kernel/entry_64.S
>>>>> patching file arch/x86/kernel/i8253.c
>>>>> patching file arch/x86/kernel/i8259.c
>>>>> patching file arch/x86/kernel/ipipe.c
>>>>> patching file arch/x86/kernel/irq.c
>>>>> patching file arch/x86/kernel/irqinit.c
>>>>> patching file arch/x86/kernel/process.c
>>>>> patching file arch/x86/kernel/process_32.c
>>>>> patching file arch/x86/kernel/process_64.c
>>>>> patching file arch/x86/kernel/smp.c
>>>>> patching file arch/x86/kernel/smpboot.c
>>>>> patching file arch/x86/kernel/time.c
>>>>> patching file arch/x86/kernel/traps.c
>>>>> patching file arch/x86/kernel/vm86_32.c
>>>>> patching file arch/x86/lib/mmx_32.c
>>>>> patching file arch/x86/lib/thunk_64.S
>>>>> patching file arch/x86/mm/fault.c
>>>>> patching file arch/x86/mm/tlb.c
>>>>> patching file drivers/pci/htirq.c
>>>>> patching file drivers/serial/8250.c
>>>>> patching file fs/exec.c
>>>>> patching file include/asm-generic/atomic.h
>>>>> patching file include/asm-generic/bitops/atomic.h
>>>>> patching file include/asm-generic/cmpxchg-local.h
>>>>> patching file include/asm-generic/percpu.h
>>>>> patching file include/linux/hardirq.h
>>>>> patching file include/linux/ipipe.h
>>>>> patching file include/linux/ipipe_base.h
>>>>> patching file include/linux/ipipe_compat.h
>>>>> patching file include/linux/ipipe_lock.h
>>>>> patching file include/linux/ipipe_percpu.h
>>>>> patching file include/linux/ipipe_tickdev.h
>>>>> patching file include/linux/ipipe_trace.h
>>>>> patching file include/linux/irq.h
>>>>> patching file include/linux/kernel.h
>>>>> patching file include/linux/preempt.h
>>>>> patching file include/linux/sched.h
>>>>> patching file include/linux/spinlock.h
>>>>> patching file include/linux/spinlock_api_smp.h
>>>>> patching file init/Kconfig
>>>>> patching file init/main.c
>>>>> patching file kernel/Makefile
>>>>> patching file kernel/exit.c
>>>>> patching file kernel/fork.c
>>>>> patching file kernel/ipipe/Kconfig
>>>>> patching file kernel/ipipe/Kconfig.debug
>>>>> patching file kernel/ipipe/Makefile
>>>>> patching file kernel/ipipe/core.c
>>>>> patching file kernel/ipipe/tracer.c
>>>>> patching file kernel/irq/chip.c
>>>>> patching file kernel/irq/handle.c
>>>>> patching file kernel/lockdep.c
>>>>> patching file kernel/panic.c
>>>>> patching file kernel/power/hibernate.c
>>>>> patching file kernel/printk.c
>>>>> patching file kernel/sched.c
>>>>> patching file kernel/signal.c
>>>>> patching file kernel/spinlock.c
>>>>> patching file kernel/time/tick-common.c
>>>>> patching file kernel/time/tick-sched.c
>>>>> patching file kernel/timer.c
>>>>> patching file kernel/trace/ftrace.c
>>>>> patching file lib/Kconfig.debug
>>>>> patching file lib/bust_spinlocks.c
>>>>> patching file lib/ioremap.c
>>>>> patching file lib/smp_processor_id.c
>>>>> patching file mm/memory.c
>>>>> patching file mm/mmu_context.c
>>>>> patching file mm/vmalloc.c
>>>>>
>>>>> c) I configured the kernel using make menuconfig  disabling smp sup=
port  (here=20
>>>>> is the relevent section of my kernel configuration):-
>>>>> # CONFIG_X86_DS is not set
>>>>> CONFIG_HPET_TIMER=3Dy
>>>>> CONFIG_HPET_EMULATE_RTC=3Dy
>>>>> CONFIG_DMI=3Dy
>>>>> CONFIG_GART_IOMMU=3Dy
>>>>> CONFIG_CALGARY_IOMMU=3Dy
>>>>> CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=3Dy
>>>>> CONFIG_AMD_IOMMU=3Dy
>>>>> CONFIG_AMD_IOMMU_STATS=3Dy
>>>>> CONFIG_SWIOTLB=3Dy
>>>>> CONFIG_IOMMU_HELPER=3Dy
>>>>> CONFIG_IOMMU_API=3Dy
>>>>> CONFIG_NR_CPUS=3D1
>>>>>
>>>> Please provide your full .config so that we can reproduce this build=
 error.
>>>>
>>> This is likely our old friend CONFIG_SPARSE_IRQ which is at work. Jus=
t
>>> disable this, until we have introduced the required changes to suppor=
t
>>> more than 1024 IRQs.
>> If that is true, then please include a simple "depends on !CONFIG_IPIP=
E"
>> in the x86 patch for the meantime.
>>
>=20
> No. Work to lift this limitation is in progress here.

That's even nicer (if 'lift' means removing any limitation of
CONFIG_NR_CPUS).

Jan


--------------enig33D793189C628A075FD0FD8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktliK8ACgkQitSsb3rl5xQxfgCfcB5iH9L/+npvL2jrriNDydm/
Or4AoLRKqz3H5Ovr+kYuzFxRD9t/VcBZ
=yGYQ
-----END PGP SIGNATURE-----

--------------enig33D793189C628A075FD0FD8F--

