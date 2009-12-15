Message-ID: <4B27C3E2.7090902@domain.hid>
Date: Tue, 15 Dec 2009 18:14:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [pull request extension #2] x86-64: Fix scheduling
	over irq stack
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

That was obviously the major CONFIG_PREEMPT bug for x86-64. My test VM
is running now without problems, also in SMP mode, and the fix makes
sense /wrt the traces I got. Uff, that was hard...


The following changes since commit 5f0fb9e88fd1ece94e6391971d5e4e9fc6b9ab9d:
  Philippe Gerum (1):
        Merge branch 'ipipe-2.6.31-noarch' into ipipe-2.6.31-x86

are available in the git repository at:

  git://git.kiszka.org/ipipe-2.6 queues/2.6.31-x86

Jan Kiszka (4):
      x86: Properly virtualize native_safe_halt
      x86: Drop redundant ipipe_suspend_domain from cpu_idle
      x86-64: Make stack switch in call_softirq atomic
      x86-64: Avoid calling preempt_schedule_irq over the irq stack

 arch/x86/include/asm/ipipe_base.h |    2 ++
 arch/x86/include/asm/irqflags.h   |   10 +++++++---
 arch/x86/kernel/entry_64.S        |   12 ++++++++++++
 arch/x86/kernel/ipipe.c           |   23 +++++++++++++++++++++++
 arch/x86/kernel/process_32.c      |    2 --
 arch/x86/kernel/process_64.c      |    3 ---
 6 files changed, 44 insertions(+), 8 deletions(-)

-------

x86-64: Avoid calling preempt_schedule_irq over the irq stack

A subtle race existed between call_softirq and __do_softirq on the one
side and the preempt_schedule_irq invocation on the other:

If we preempted the stack switch of call_softirq while the preemption
counter was not properly set, we ended up scheduling out the interrupt
stack. And that caused severe corruptions when the stack was reused
before we returned.

Fix it by catching this case based on irq_count.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kernel/entry_64.S |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 5237029..57798d5 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1011,6 +1011,14 @@ ENTRY(retint_kernel)
 	jnc  retint_restore_args
 	bt   $9,EFLAGS-ARGOFFSET(%rsp)	/* interrupts off? */
 	jnc  retint_restore_args
+#ifdef CONFIG_IPIPE
+	/*
+	 * We may have preempted call_softirq before __do_softirq raised or
+	 * after it lowered the preemption counter.
+	 */
+	cmpl $0,PER_CPU_VAR(irq_count)
+	jge  retint_restore_args
+#endif
 	PREEMPT_SCHEDULE_IRQ
 	jmp exit_intr
 #endif
-- 
1.6.0.2

