Date: Mon, 1 Oct 2018 16:51:12 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20181001165112.18eafb36@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180927144203.5e7d006b@md1pvb1c.ad001.siemens.net>
References: <20180925103809.4932-1-rpm@xenomai.org>
 <20180927144203.5e7d006b@md1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [I-PIPE][PATCH 00/32] 4.14.71/x86_64 port (split
 series)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Am Thu, 27 Sep 2018 14:42:03 +0200
schrieb "[ext] Henning Schild" <henning.schild@siemens.com>:

> Thanks! I just tried it on my test setup. All looking good except for
> one smokey test.
> 
> >  ./smokey --trace --run=sigdebug  
> 
> Crashes the box without any further feedback, also nothing on the
> serial.
> 
> Will look into that.

I already found that the page-fault caused by sigdebug is causing the
problem.

./smokey --verbose=42 --trace=42 --run=sigdebug

Gave me more output. The "*mem = 0xff;" is the last thing it does. Did
not look into the kernel(s) and the page-fault handler yet.

Henning

> Henning
> 
> Am Tue, 25 Sep 2018 12:37:37 +0200
> schrieb Philippe Gerum <rpm@xenomai.org>:
> 
> > This is a port of the interrupt pipeline to kernel 4.14.71 for
> > x86_64, based on the split series published earlier this year [1].
> > 
> > The architecture-specific bits have been reworked to become a series
> > of incremental changes on top of the -noarch tree [2], enabling a
> > feature one at a time, which should ease future kernel upgrades.
> > 
> > The topmost patch disables native 32bit support which was not
> > ported. Support for x32 and ia32 emulation ABIs over long mode is
> > still there and working though.
> > 
> > [1] https://www.xenomai.org/pipermail/xenomai/2018-July/039302.html
> > [2] https://git.xenomai.org/ipipe-noarch
> > 
> > 
> > Henning Schild (2):
> >   x86: fix include for drivers
> >   x86: ipipe fpu support
> > 
> > Philippe Gerum (30):
> >   x86: lockdep: ipipe: make the logic aware of interrupt pipelining
> >   x86: ipipe: add pipeline core
> >   x86: context_tracking: disable if CONFIG_IPIPE
> >   x86: paravirt: disable if CONFIG_IPIPE
> >   x86/iommu: enable interrupt pipelining
> >   x86/htirq: ipipe: enable interrupt pipelining
> >   x86/i8259: ipipe: enable interrupt pipelining
> >   x86/mm: enable PTE pinning
> >   x86: ipipe: share context switch code with head domain
> >   x86/mtrr: ipipe: protect against preemption from head stage
> >   x86/tsc: ipipe: keep calibration accurate
> >   x86: ipipe: notify about GTOD update
> >   x86/kgdb: ipipe: enable support from head domain
> >   x86/vm86_32: ipipe: protect against preemption from head domain
> >   x86/kvm: ipipe: enable shared control with head domain
> >   x86/mmx32: ipipe: use slow copy from head domain
> >   x86/nmi: ipipe: disallow user copy from head domain
> >   x86: ipipe: route traps to co-kernel
> >   x86: ipipe: route syscalls to co-kernel
> >   x86/irq: ipipe: map the cleanup vector to a legit IRQ number
> >   x86/fpu: ipipe: add inline qualifier to kernel_fpu_*() helpers
> >   x86: ipipe: fix interrupt state in syscall routing
> >   x86/irq: ipipe: reconcile lockdep tracing with virtual IRQ state
> >   x86/mm: ipipe: fix lockdep tracing upon PF
> >   x86/msi: ipipe: advertise pipelining support
> >   x86: ipipe: fix stack overflow detection
> >   x86: ipipe: restrict WARN_ON_IN_IRQ() to the root domain
> >   x86: ipipe: remove 32bit support from shared context switch code
> >   x86: ipipe: drop (obsolete) declarations
> >   x86: ipipe: disable 32bit support
> > 
> >  arch/x86/Kconfig                        |  10 +-
> >  arch/x86/entry/common.c                 |  98 +++++-
> >  arch/x86/entry/entry_64.S               | 145 +++++++--
> >  arch/x86/entry/thunk_32.S               |   1 +
> >  arch/x86/entry/thunk_64.S               |   1 +
> >  arch/x86/entry/vsyscall/vsyscall_gtod.c |   4 +
> >  arch/x86/include/asm/apic.h             |  10 +
> >  arch/x86/include/asm/debugreg.h         |   2 +-
> >  arch/x86/include/asm/desc.h             |   2 +-
> >  arch/x86/include/asm/fpu/internal.h     |  20 ++
> >  arch/x86/include/asm/i8259.h            |   2 +-
> >  arch/x86/include/asm/ipipe.h            |  73 +++++
> >  arch/x86/include/asm/ipipe_base.h       | 151 +++++++++
> >  arch/x86/include/asm/irq_vectors.h      |  17 +-
> >  arch/x86/include/asm/irqflags.h         | 198 +++++++++++-
> >  arch/x86/include/asm/mmu_context.h      |   6 +-
> >  arch/x86/include/asm/thread_info.h      |  14 +
> >  arch/x86/include/asm/tsc.h              |   1 +
> >  arch/x86/include/asm/uaccess.h          |   3 +-
> >  arch/x86/kernel/Makefile                |   1 +
> >  arch/x86/kernel/apic/apic.c             |  46 ++-
> >  arch/x86/kernel/apic/apic_flat_64.c     |   4 +-
> >  arch/x86/kernel/apic/htirq.c            |   5 +-
> >  arch/x86/kernel/apic/io_apic.c          | 182 ++++++++++-
> >  arch/x86/kernel/apic/ipi.c              |  29 +-
> >  arch/x86/kernel/apic/msi.c              |  20 +-
> >  arch/x86/kernel/apic/vector.c           |  13 +-
> >  arch/x86/kernel/apic/x2apic_cluster.c   |   4 +-
> >  arch/x86/kernel/apic/x2apic_phys.c      |   4 +-
> >  arch/x86/kernel/asm-offsets.c           |   3 +
> >  arch/x86/kernel/cpu/common.c            |   2 +
> >  arch/x86/kernel/cpu/mtrr/cyrix.c        |  12 +-
> >  arch/x86/kernel/cpu/mtrr/generic.c      |  12 +-
> >  arch/x86/kernel/fpu/core.c              |  58 ++--
> >  arch/x86/kernel/i8259.c                 |  31 +-
> >  arch/x86/kernel/idt.c                   |  24 ++
> >  arch/x86/kernel/ipipe.c                 | 528
> > ++++++++++++++++++++++++++++++++
> > arch/x86/kernel/irq.c                   |   5 +-
> > arch/x86/kernel/irq_64.c                |  12 +-
> > arch/x86/kernel/kgdb.c                  |   4 +-
> > arch/x86/kernel/process.c               |  20 +-
> > arch/x86/kernel/process_32.c            |   2 +-
> > arch/x86/kernel/process_64.c            |   2 +-
> > arch/x86/kernel/smp.c                   |   4 +-
> > arch/x86/kernel/smpboot.c               |   8 +-
> > arch/x86/kernel/traps.c                 |   9 +-
> > arch/x86/kernel/tsc.c                   |  12 +-
> > arch/x86/kernel/vm86_32.c               |   4 +
> > arch/x86/kvm/svm.c                      |   5 +-
> > arch/x86/kvm/vmx.c                      |  13 +-
> > arch/x86/kvm/x86.c                      |  66 +++-
> > arch/x86/lib/mmx_32.c                   |   2 +-
> > arch/x86/lib/usercopy.c                 |   3 +-
> > arch/x86/mm/fault.c                     |  53 ++++
> > arch/x86/mm/tlb.c                       |  14 +-
> > drivers/iommu/irq_remapping.c           |   2 +-
> > drivers/pci/htirq.c                     |   2 +-
> > include/linux/gpio.h                    |   1 + 58 files changed,
> > 1787 insertions(+), 192 deletions(-) create mode 100644
> > arch/x86/include/asm/ipipe.h create mode 100644
> > arch/x86/include/asm/ipipe_base.h create mode 100644
> > arch/x86/kernel/ipipe.c
> >   
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


