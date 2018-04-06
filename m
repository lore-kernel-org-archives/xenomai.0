From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <edde814a-56f9-1853-22fe-d3b28c1aadc6@siemens.com>
Date: Fri, 6 Apr 2018 19:21:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] ipipe 4.9 update
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 3d21f886ffae3ffdef54a19ec53393482626a84c:

  ipipe-core-4.9.90-x86-6 (2018-03-26 17:36:13 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki 

for you to fetch changes up to 3fac4646875dbbab6969cf080a02467b578c55be:

  Merge tag 'v4.9.92' into for-upstream/4.9 (2018-04-06 18:45:31 +0200)

----------------------------------------------------------------
(excluding stable merge)
Jan Kiszka (4):
      arm/ipipe: Avoid open-coded __ipipe_call_mayday
      ipipe: Fix root domain guard in preempt_schedule_notrace
      x86/ipipe: Deny JUMP_LABEL over I-pipe
      x86/ipipe: Disable access_ok context under I-pipe

 arch/arm/kernel/ipipe.c        | 3 +--
 arch/x86/Kconfig               | 2 +-
 arch/x86/include/asm/uaccess.h | 2 +-
 kernel/sched/core.c            | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/ipipe.c b/arch/arm/kernel/ipipe.c
index b95c8128c5de..e7642bd28871 100644
--- a/arch/arm/kernel/ipipe.c
+++ b/arch/arm/kernel/ipipe.c
@@ -354,8 +354,7 @@ void __ipipe_exit_irq(struct pt_regs *regs)
 		 * so prefer test then maybe clear over
 		 * test_and_clear.
 		 */
-		ipipe_clear_thread_flag(TIP_MAYDAY);
-		__ipipe_notify_trap(IPIPE_TRAP_MAYDAY, regs);
+		__ipipe_call_mayday(regs);
 	}
 }
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1bc073333b02..f553d85db062 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -83,7 +83,7 @@ config X86
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HARDENED_USERCOPY
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
-	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL		if !IPIPE
 	select HAVE_ARCH_KASAN			if X86_64 && SPARSEMEM_VMEMMAP
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_KMEMCHECK
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index a8d85a687cf4..bffa3f09067e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -68,7 +68,7 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 	__chk_range_not_ok((unsigned long __force)(addr), size, limit); \
 })
 
-#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+#if defined(CONFIG_DEBUG_ATOMIC_SLEEP) && !defined(CONFIG_IPIPE)
 # define WARN_ON_IN_IRQ()	WARN_ON_ONCE(!in_task())
 #else
 # define WARN_ON_IN_IRQ()
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 37a9420059e3..2f781dcede7a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3582,7 +3582,7 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 {
 	enum ctx_state prev_ctx;
 
-	if (likely(!preemptible() || !ipipe_root_p))
+	if (likely(!preemptible() || !ipipe_root_p || hard_irqs_disabled()))
 		return;
 
 	do {

