Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2007 11:22:01 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01903C10@domain.hid>
In-Reply-To: <b647ffbd0701240208r1db2372end68276616cbebd69@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: [Xenomai-help] Patching latest Denx 2.4.25-devel kernel with
	xenomai-2.3.0 fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hi,

I want to patch the latest Denx 2.4.25 kernel with Xenomai-2.3.0

The prepare-kernel.sh skript fails with the following message:

[root@domain.hid xenomai-2.3.0]# scripts/prepare-kernel.sh --arch=3Dppc
--adeos=3Dksrc/arch/powerpc/patches/adeos-ipipe-2.4.25-ppc-CVS-20060707-1=
.
2-01.patch --linux=3D../linuxppc_2_4_devel-git-xenomai-2.3.0
patching file arch/ppc/config.in
Hunk #1 succeeded at 858 (offset 40 lines).
patching file arch/ppc/kernel/Makefile
patching file arch/ppc/kernel/entry.S
patching file arch/ppc/kernel/head.S
patching file arch/ppc/kernel/head_440.S
patching file arch/ppc/kernel/head_44x.S
patching file arch/ppc/kernel/head_4xx.S
patching file arch/ppc/kernel/head_8xx.S
patching file arch/ppc/kernel/head_e500.S
patching file arch/ppc/kernel/idle.c
patching file arch/ppc/kernel/ipipe-core.c
patching file arch/ppc/kernel/ipipe-root.c
patching file arch/ppc/kernel/irq.c
patching file arch/ppc/kernel/ppc_ksyms.c
patching file arch/ppc/kernel/traps.c
patching file arch/ppc/mm/fault.c
patching file include/asm-ppc/hw_irq.h
patching file include/asm-ppc/ipipe.h
patching file include/asm-ppc/mmu_context.h
patching file include/asm-ppc/system.h
patching file include/linux/ipipe.h
patching file include/linux/sched.h
Hunk #3 succeeded at 424 with fuzz 1.
patching file init/main.c
Hunk #1 succeeded at 412 (offset 3 lines).
patching file kernel/Makefile
patching file kernel/exit.c
patching file kernel/fork.c
patching file kernel/ipipe/Makefile
patching file kernel/ipipe/core.c
patching file kernel/ipipe/generic.c
patching file kernel/printk.c
patching file kernel/sched.c
patching file kernel/signal.c
?


Then the script unexpectedly exits without error (but a ?).


Any hints appreciated.



Best regards,

Daniel Schnell.



