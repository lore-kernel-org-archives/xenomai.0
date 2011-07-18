Message-ID: <4E241A30.5060904@domain.hid>
Date: Mon, 18 Jul 2011 13:34:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PULL] Critical x86-64 fix / mprotect page fault
	avoidance
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

The following changes since commit ec31395b787f9d7d651920c1af3447bd563c6cf8:

  ipipe-2.6.38.8-x86-2.10-00 (2011-06-14 09:39:43 +0200)

are available in the git repository at:
  git://git.kiszka.org/ipipe queues/2.6.38-x86

Jan Kiszka (3):
      ipipe: Prevent unwritable pages after mprotect
      Merge branch 'queues/2.6.38-noarch' into queues/2.6.38-x86
      ipipe: x86-64: Disable interrupt stacks

 arch/x86/include/asm/page_64_types.h |    4 ++++
 arch/x86/kernel/entry_64.S           |    2 ++
 mm/mprotect.c                        |   12 +++++++++++-
 3 files changed, 17 insertions(+), 1 deletions(-)

---

ipipe: x86-64: Disable interrupt stacks

x86-64 uses interrupt stacks by default. They are activated early on
interrupt, i.e. before I-pipe and any non-root domain is called. If the
non-root domain decides to schedule over this stack, taking it to a
different CPU or leaving the interrupt nesting over a different task, we
may end up using the interrupt stack more than once. Subtle stack
corruptions, under Xenomai usually paired with system crashes, are the
result.

Fix this by raising the task kernel stack size from 8 to 16K (twice as
much as x86-32 uses in the absence of interrupt stacks) and disabling
stack switching in save_args.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/include/asm/page_64_types.h |    4 ++++
 arch/x86/kernel/entry_64.S           |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 7639dbf..e28697e 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -1,7 +1,11 @@
 #ifndef _ASM_X86_PAGE_64_DEFS_H
 #define _ASM_X86_PAGE_64_DEFS_H
 
+#ifdef CONFIG_IPIPE
+#define THREAD_ORDER	2
+#else
 #define THREAD_ORDER	1
+#endif
 #define THREAD_SIZE  (PAGE_SIZE << THREAD_ORDER)
 #define CURRENT_MASK (~(THREAD_SIZE - 1))
 
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index ed0f408..4e177f3 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -334,12 +334,14 @@ ENTRY(save_args)
 	 * moving irq_enter into assembly, which would be too much work)
 	 */
 1:	incl PER_CPU_VAR(irq_count)
+#ifndef CONFIG_IPIPE
 	jne 2f
 	popq_cfi %rax			/* move return address... */
 	mov PER_CPU_VAR(irq_stack_ptr),%rsp
 	EMPTY_FRAME 0
 	pushq_cfi %rbp			/* backlink for unwinder */
 	pushq_cfi %rax			/* ... to the new stack */
+#endif
 	/*
 	 * We entered an interrupt context - irqs are off:
 	 */
-- 
1.7.3.4

