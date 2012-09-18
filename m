Message-ID: <50588110.6030701@siemens.com>
Date: Tue, 18 Sep 2012 16:11:28 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [GIT PULL] core-5 for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>

Dear all,

here's a rebase of the x86-specific bits of core-4 to core-5. I've
included all x86 specific changes that are not yet in core-5, and
also added the patches I sent earlier for core-4. I did not include a
separate patch for the mechanical changes required to apply the
x86 base patch on top of core-5, but can surely do so if desired.

Cheers, Wolfgang

The following changes since commit 9f90a923093f411908e3536088dfdb1d936f3fe8:                                                

  ipipe: ipipe_timers_request -> ipipe_select_timers (2012-09-03 11:19:15 +0200)

are available in the git repository at:
  https://github.com/siemens/ipipe.git core-3.5_for-upstream

Gilles Chanteperdrix (5):
      ipipe/x86: provide ipipe_head_switch_mm
      ipipe/x86: do not restore during context switch
      ipipe/x86: mask io_apic EOI irq before EOI     
      ipipe/x86: fix IOAPIC with CONFIG_IRQ_REMAP    
      ipipe/x86: fix compilation for AMD processors  

Philippe Gerum (1):
      x86/ipipe: ipipe_head_switch_mm -> ipipe_switch_mm_head

Wolfgang Mauerer (5):
      ipipe-core4-x86 applied to core-5
      x86/ipipe: Make io_apic_level_ack_pending available for ipipe
      ipipe: Remove superfluous symbol export of irq_to_desc       
      ipipe,x86: Introduce hard_irqs_disabled_flags                
      Fix IRQs-off-tracer for x86_64                               

 .gitignore                            |    1 +
 arch/x86/Kconfig                      |   26 +-
 arch/x86/include/asm/apic.h           |    6 + 
 arch/x86/include/asm/apicdef.h        |    3 + 
 arch/x86/include/asm/fpu-internal.h   |   10 + 
 arch/x86/include/asm/hw_irq.h         |   10 + 
 arch/x86/include/asm/i8259.h          |    2 +-
 arch/x86/include/asm/ipi.h            |   23 +-
 arch/x86/include/asm/ipipe.h          |  105 ++++++
 arch/x86/include/asm/ipipe_32.h       |   86 +++++ 
 arch/x86/include/asm/ipipe_64.h       |   90 +++++ 
 arch/x86/include/asm/ipipe_base.h     |  226 +++++++++++
 arch/x86/include/asm/irq_vectors.h    |   11 +          
 arch/x86/include/asm/irqflags.h       |  210 +++++++++++
 arch/x86/include/asm/mmu_context.h    |   21 +-         
 arch/x86/include/asm/page_64_types.h  |    4 +          
 arch/x86/include/asm/processor.h      |    1 +          
 arch/x86/include/asm/special_insns.h  |   12 +          
 arch/x86/include/asm/switch_to.h      |    7 +-         
 arch/x86/include/asm/thread_info.h    |    2 +          
 arch/x86/include/asm/traps.h          |    2 +-         
 arch/x86/include/asm/tsc.h            |    1 +          
 arch/x86/kernel/Makefile              |    1 +          
 arch/x86/kernel/apic/apic.c           |   39 ++-        
 arch/x86/kernel/apic/apic_flat_64.c   |    4 +-         
 arch/x86/kernel/apic/io_apic.c        |  219 ++++++++++--
 arch/x86/kernel/apic/ipi.c            |   20 +-          
 arch/x86/kernel/apic/x2apic_cluster.c |    4 +-          
 arch/x86/kernel/apic/x2apic_phys.c    |    4 +-          
 arch/x86/kernel/cpu/mtrr/cyrix.c      |   12 +-          
 arch/x86/kernel/cpu/mtrr/generic.c    |   12 +-          
 arch/x86/kernel/dumpstack_32.c        |    3 +           
 arch/x86/kernel/dumpstack_64.c        |    5 +           
 arch/x86/kernel/entry_32.S            |  147 ++++++--    
 arch/x86/kernel/entry_64.S            |  247 +++++++++++--
 arch/x86/kernel/hpet.c                |   27 ++-          
 arch/x86/kernel/i387.c                |    3 +
 arch/x86/kernel/i8259.c               |   30 ++-
 arch/x86/kernel/ipipe.c               |  664 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/irq.c                 |    7 +-
 arch/x86/kernel/irqinit.c             |    7 +
 arch/x86/kernel/process.c             |   21 +-
 arch/x86/kernel/process_32.c          |    4 +-
 arch/x86/kernel/process_64.c          |    9 +-
 arch/x86/kernel/ptrace.c              |    5 +
 arch/x86/kernel/smp.c                 |    4 +-
 arch/x86/kernel/smpboot.c             |   10 +-
 arch/x86/kernel/traps.c               |    4 +
 arch/x86/kernel/tsc.c                 |   12 +-
 arch/x86/kernel/vm86_32.c             |    4 +
 arch/x86/kernel/vsyscall_64.c         |    4 +
 arch/x86/kvm/svm.c                    |    4 +-
 arch/x86/kvm/vmx.c                    |   13 +-
 arch/x86/kvm/x86.c                    |   69 +++-
 arch/x86/lib/mmx_32.c                 |    2 +-
 arch/x86/lib/thunk_64.S               |   21 +
 arch/x86/mm/fault.c                   |   56 +++-
 arch/x86/mm/tlb.c                     |    7 +
 arch/x86/platform/uv/tlb_uv.c         |    5 +
 59 files changed, 2384 insertions(+), 184 deletions(-)
 create mode 100644 arch/x86/include/asm/ipipe.h
 create mode 100644 arch/x86/include/asm/ipipe_32.h
 create mode 100644 arch/x86/include/asm/ipipe_64.h
 create mode 100644 arch/x86/include/asm/ipipe_base.h
 create mode 100644 arch/x86/kernel/ipipe.c

