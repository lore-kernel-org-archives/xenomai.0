Message-ID: <4CA6DC58.1050505@domain.hid>
Date: Sat, 02 Oct 2010 09:16:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7425F726FF6C7E69E5B939FD"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [git pull] 2.6.35-x86 support
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7425F726FF6C7E69E5B939FD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit 71ee75169e2fa3cadf439256b598c24999435d=
c5:

  Merge commit 'v2.6.35.7' into queues/2.6.35-noarch (2010-09-30 10:59:07=
 +0200)

are available in the git repository at:

  git://git.kiszka.org/ipipe-2.6 queues/2.6.35-x86

Besides 2.6.35.7 base support for x86, this branch includes
 - Wolfgang's CLOCK_HOST_REALTIME support
 - generic & fixed critical sync services
 - some smaller fixes

It does not yet include KVM-over-ipipe support as there is some
stability issue remaining that is still waiting to be analyzed.

Jan Kiszka (18):
      ipipe: Fix ipipe_safe_current definition for !CONFIG_IPIPE
      ipipe: Report enabled IRQs on ipipe_restore_pipeline_head entry
      ipipe: Add ipi parameter check to ipipe_send_ipi
      ipipe: Generic, deadlock-safe ipipe_critical_enter/exit
      ipipe: x86: arch-specific part of I-pipe for 2.6.35
      ipipe: x86-64: Update root pipeline state on TRACE_IRQ_ON/OFF
      ipipe: x86-32: Do not TRACE_IRQS_OFF on exception entry
      ipipe: x86: Update comment regarding __fixup_if
      ipipe: x86: Provide ipipe_ipi_p()
      Merge branch 'queues/2.6.35-noarch' (early part) into queues/2.6.35=
-x86
      Merge branch 'queues/2.6.35-noarch' (early part) into queues/2.6.35=
-x86
      ipipe: x86: Switch to generic ipipe_critical_enter/exit
      Merge branch 'queues/2.6.35-noarch' (early part) into queues/2.6.35=
-x86
      ipipe: x86-32: Drop preemption prevention for ret_from_intr
      ipipe: Convert !__ipipe_root_domain_p to context checks
      ipipe: Introduce ipipe_prepare_panic
      Merge branch 'queues/2.6.35-noarch' (early part) into queues/2.6.35=
-x86
      ipipe: x86-64: Fix CONFIG_PREEMPT build

Wolfgang Mauerer (2):
      ipipe: Pass NTP-corrected time information from Linux to higher dom=
ains
      ipipe: x86: arch-specific part of CLOCK_HOST_REALTIME

 arch/x86/Kconfig                      |    5 +
 arch/x86/include/asm/apic.h           |    6 +
 arch/x86/include/asm/apicdef.h        |    4 +
 arch/x86/include/asm/entry_arch.h     |    2 +
 arch/x86/include/asm/hw_irq.h         |    8 +
 arch/x86/include/asm/i387.h           |    3 +
 arch/x86/include/asm/i8259.h          |    2 +-
 arch/x86/include/asm/ipi.h            |    5 +
 arch/x86/include/asm/ipipe.h          |  183 +++++++
 arch/x86/include/asm/ipipe_32.h       |  131 +++++
 arch/x86/include/asm/ipipe_64.h       |  136 +++++
 arch/x86/include/asm/ipipe_base.h     |  216 ++++++++
 arch/x86/include/asm/irq_vectors.h    |   10 +
 arch/x86/include/asm/irqflags.h       |  148 +++++-
 arch/x86/include/asm/mmu_context.h    |   22 +-
 arch/x86/include/asm/nmi.h            |    2 +-
 arch/x86/include/asm/processor.h      |    1 +
 arch/x86/include/asm/system.h         |   12 +-
 arch/x86/include/asm/traps.h          |    2 +-
 arch/x86/include/asm/tsc.h            |    1 +
 arch/x86/kernel/Makefile              |    1 +
 arch/x86/kernel/apic/apic.c           |   24 +-
 arch/x86/kernel/apic/apic_flat_64.c   |    4 +-
 arch/x86/kernel/apic/io_apic.c        |  116 ++++-
 arch/x86/kernel/apic/ipi.c            |   20 +-
 arch/x86/kernel/apic/nmi.c            |    6 +-
 arch/x86/kernel/apic/x2apic_cluster.c |   12 +-
 arch/x86/kernel/apic/x2apic_phys.c    |   12 +-
 arch/x86/kernel/cpu/mtrr/cyrix.c      |   12 +-
 arch/x86/kernel/cpu/mtrr/generic.c    |   10 +-
 arch/x86/kernel/dumpstack.c           |    1 +
 arch/x86/kernel/dumpstack_32.c        |    3 +
 arch/x86/kernel/dumpstack_64.c        |    5 +
 arch/x86/kernel/entry_32.S            |  166 +++++-
 arch/x86/kernel/entry_64.S            |  239 ++++++++--
 arch/x86/kernel/i8253.c               |    7 +
 arch/x86/kernel/i8259.c               |   30 +-
 arch/x86/kernel/ipipe.c               |  947 +++++++++++++++++++++++++++=
++++++
 arch/x86/kernel/irq.c                 |    7 +-
 arch/x86/kernel/irqinit.c             |   12 +
 arch/x86/kernel/process.c             |   21 +-
 arch/x86/kernel/process_32.c          |    4 +-
 arch/x86/kernel/process_64.c          |    7 +-
 arch/x86/kernel/smp.c                 |    4 +-
 arch/x86/kernel/smpboot.c             |    8 +-
 arch/x86/kernel/time.c                |    6 +-
 arch/x86/kernel/traps.c               |    4 +
 arch/x86/kernel/tsc.c                 |    4 +-
 arch/x86/kernel/vm86_32.c             |    4 +
 arch/x86/kernel/vsyscall_64.c         |    4 +
 arch/x86/lib/mmx_32.c                 |    2 +-
 arch/x86/lib/thunk_64.S               |    4 +
 arch/x86/mm/fault.c                   |   54 ++-
 arch/x86/mm/tlb.c                     |    7 +
 include/linux/ipipe.h                 |   11 +-
 include/linux/ipipe_base.h            |   14 +-
 include/linux/ipipe_tickdev.h         |   25 +
 kernel/ipipe/Kconfig                  |    3 +
 kernel/ipipe/core.c                   |  198 +++++++-
 59 files changed, 2757 insertions(+), 160 deletions(-)
 create mode 100644 arch/x86/include/asm/ipipe.h
 create mode 100644 arch/x86/include/asm/ipipe_32.h
 create mode 100644 arch/x86/include/asm/ipipe_64.h
 create mode 100644 arch/x86/include/asm/ipipe_base.h
 create mode 100644 arch/x86/kernel/ipipe.c


--------------enig7425F726FF6C7E69E5B939FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkym3FgACgkQitSsb3rl5xRCGwCghAjBra8sImtF7+xZ1CGF294o
6vkAn0vTKVbHNccgaBCErDxqpSvaMrj+
=8TL1
-----END PGP SIGNATURE-----

--------------enig7425F726FF6C7E69E5B939FD--

