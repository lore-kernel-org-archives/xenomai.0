Message-ID: <4B275A51.7010307@domain.hid>
Date: Tue, 15 Dec 2009 10:43:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [pull request extension] x86-64: Fix potential irq
	stack corruption
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

While this still does not heal the irq stack corruption I see here with
CONFIG_PREEMPT, it remains a bug that may have triggered severe issues,
though only very infrequently. OK, three I-pipe bugs fixed, but the big
one is still open. Sigh...


The following changes since commit b62b3fcb9ec752c89a5185e7863e15f004c32d42:
  Jan Kiszka (1):
        x86: Drop redundant ipipe_suspend_domain from cpu_idle

are available in the git repository at:

  git://git.kiszka.org/ipipe-2.6 queues/2.6.31-x86

Jan Kiszka (1):
      x86: Make stack switch in call_softirq atomic

 arch/x86/include/asm/irqflags.h |    2 ++
 arch/x86/kernel/entry_64.S      |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

------

x86: Make stack switch in call_softirq atomic

The interrupt stack must always be switched with hard IRQs disabled as
I-pipe uses it as well. If not, we risk subtle stack corruptions when
preempting call_softirq at the wrong instruction.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/include/asm/irqflags.h |    2 ++
 arch/x86/kernel/entry_64.S      |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 1baceba..da1e655 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -223,12 +223,14 @@ static inline unsigned long __raw_local_irq_save(void)
 #define ENABLE_INTERRUPTS(clobbers)	sti
 #endif /* CONFIG_X86_64 */
 #define ENABLE_INTERRUPTS_HW_COND	sti
+#define DISABLE_INTERRUPTS_HW_COND	cli
 #define DISABLE_INTERRUPTS_HW(clobbers)	cli
 #define ENABLE_INTERRUPTS_HW(clobbers)	sti
 #else /* !CONFIG_IPIPE */
 #define ENABLE_INTERRUPTS(x)		sti
 #define DISABLE_INTERRUPTS(x)		cli
 #define ENABLE_INTERRUPTS_HW_COND
+#define DISABLE_INTERRUPTS_HW_COND
 #define DISABLE_INTERRUPTS_HW(clobbers)	DISABLE_INTERRUPTS(clobbers)
 #define ENABLE_INTERRUPTS_HW(clobbers)	ENABLE_INTERRUPTS(clobbers)
 #endif /* !CONFIG_IPIPE */
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index b876c16..5237029 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1413,14 +1413,18 @@ ENTRY(call_softirq)
 	CFI_REL_OFFSET rbp,0
 	mov  %rsp,%rbp
 	CFI_DEF_CFA_REGISTER rbp
+	DISABLE_INTERRUPTS_HW_COND
 	incl PER_CPU_VAR(irq_count)
 	cmove PER_CPU_VAR(irq_stack_ptr),%rsp
+	ENABLE_INTERRUPTS_HW_COND
 	push  %rbp			# backlink for old unwinder
 	call __do_softirq
+	DISABLE_INTERRUPTS_HW_COND
 	leaveq
 	CFI_DEF_CFA_REGISTER	rsp
 	CFI_ADJUST_CFA_OFFSET   -8
 	decl PER_CPU_VAR(irq_count)
+	ENABLE_INTERRUPTS_HW_COND
 	ret
 	CFI_ENDPROC
 END(call_softirq)
-- 
1.6.0.2

