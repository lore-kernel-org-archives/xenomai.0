From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/4] x86/fault: dovetail: unbreak irqflags tracing
Date: Sat, 31 Jul 2021 11:49:33 +0200
Message-Id: <20210731094934.1799307-4-rpm@xenomai.org>
In-Reply-To: <20210731094934.1799307-1-rpm@xenomai.org>
References: <20210731094934.1799307-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Conditional irq enabling/disabling helpers must inform the irq tracer
about the change, so that lockdep does not complain about inconsistent
irq state. Fixing up the stall bit using the common
local_irq_enable/disable() helpers ensures this.

CAUTION: we make sure to always have hard irqs on before calling
local_irq_enable(), so that we won't trigger the corresponding
pipeline debug assertion.

Failing to do so may cause such warning:

[    5.489344] DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
[    5.489345] WARNING: CPU: 1 PID: 1 at kernel/locking/lockdep.c:5525 check_flags+0x193/0x1c0
[    5.489345] Modules linked in:
[    5.489346] CPU: 1 PID: 1 Comm: init Not tainted 5.14.0-rc1+ #48
[    5.489346] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
[    5.489347] IRQ stage: Linux
[    5.489347] RIP: 0010:check_flags+0x193/0x1c0
[    5.489348] Code: ff ff e8 c0 16 ab ff 85 c0 74 21 44 8b 05 6d bb bd 00 45 85 c0 75 15 48 c7 c6 47 80 2d 82 48 c7 c7 60 ea 2b 82 e8 41 7c fb ff <0f> 0b 48 c7 c7 00 96 2d 82 e8 42 ed fb ff e9 5c ff ff ff 65 48 8b
[    5.489349] RSP: 0018:ffffc90000013b98 EFLAGS: 00010092
[    5.489349] RAX: 0000000000000030 RBX: ffffffff8255c720 RCX: 0000000000000023
[    5.489350] RDX: 0000000000000023 RSI: ffffffff822bea76 RDI: ffff8882343e9a70
[    5.489350] RBP: ffff888100278000 R08: ffff8882343eba60 R09: ffff8883343e9aba
[    5.489351] R10: ffffffffffffffff R11: 284e4f5f4e524157 R12: ffff888100278940
[    5.489351] R13: 0000000000000200 R14: 0000000000000000 R15: 0000000000000000
[    5.489352] FS:  0000000000000000(0000) GS:ffff888234200000(0000) knlGS:0000000000000000
[    5.489352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.489353] CR2: 000000000050edeb CR3: 000000010004c000 CR4: 00000000000406e0
[    5.489353] Call Trace:
[    5.489353]  lock_is_held_type+0x6b/0x140
[    5.489354]  rcu_read_lock_sched_held+0x57/0x80
[    5.489354]  lock_acquire+0x11c/0x2c0
[    5.489355]  ? add_chain_cache+0x212/0x4a0
[    5.489355]  down_read_trylock+0x73/0xf0
[    5.489355]  ? do_user_addr_fault+0x156/0x720
[    5.489356]  do_user_addr_fault+0x156/0x720
[    5.489356]  exc_page_fault+0x78/0x100
[    5.489356]  asm_exc_page_fault+0x1e/0x30
[    5.489357] RIP: 0010:__clear_user+0x40/0x70
[    5.489357] Code: 00 00 00 e8 52 2a d2 ff 0f 1f 00 48 89 d8 48 c1 eb 03 48 89 ef 83 e0 07 48 89 d9 48 85 c9 74 19 66 2e 0f 1f 84 00 00 00 00 00 <48> c7 07 00 00 00 00 48 83 c7 08 ff c9 75 f1 48 89 c1 85 c9 74 0a
[    5.489358] RSP: 0018:ffffc90000013da8 EFLAGS: 00010206
[    5.489359] RAX: 0000000000000005 RBX: 0000000000000042 RCX: 0000000000000042
[    5.489359] RDX: ffff888100278000 RSI: ffffffff822d2f72 RDI: 000000000050edeb
[    5.489360] RBP: 000000000050edeb R08: 0000000000000000 R09: 00000000ffffffff
[    5.489360] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[    5.489361] R13: ffff888102628200 R14: ffff88810262eaa0 R15: ffff8881008b1940
[    5.489361]  ? __clear_user+0x1e/0x70
[    5.489361]  load_elf_binary+0xc0c/0xd80
[    5.489362]  search_binary_handler+0xc7/0x230
[    5.489362]  exec_binprm+0xa8/0x2f0
[    5.489362]  bprm_execve.part.0+0x1c0/0x2e0
[    5.489363]  ? rest_init+0x250/0x250
[    5.489363]  kernel_execve+0x12e/0x1b0
[    5.489363]  try_to_run_init_process+0x10/0x34
[    5.489364]  kernel_init+0xc7/0x110
[    5.489364]  ret_from_fork+0x22/0x30
[    5.489364] irq event stamp: 13468052
[    5.489365] hardirqs last  enabled at (13468051): [<ffffffff812efe0e>] free_unref_page_list+0x44e/0x590
[    5.489365] hardirqs last disabled at (13468052): [<ffffffff81aa98fa>] exc_page_fault+0x3a/0x100
[    5.489366] softirqs last  enabled at (13467850): [<ffffffff81a17fa3>] xs_tcp_send_request+0x143/0x210
[    5.489367] softirqs last disabled at (13467848): [<ffffffff81855479>] release_sock+0x19/0xa0
[    5.489367] ---[ end trace d0075380c74bdffc ]---
[    5.489368] possible reason: unannotated irqs-on.
[    5.489368] irq event stamp: 13468052
[    5.489368] hardirqs last  enabled at (13468051): [<ffffffff812efe0e>] free_unref_page_list+0x44e/0x590
[    5.489369] hardirqs last disabled at (13468052): [<ffffffff81aa98fa>] exc_page_fault+0x3a/0x100
[    5.489370] softirqs last  enabled at (13467850): [<ffffffff81a17fa3>] xs_tcp_send_request+0x143/0x210
[    5.489370] softirqs last disabled at (13467848): [<ffffffff81855479>] release_sock+0x19/0xa0

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/x86/mm/fault.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f37098aa4e58655..0f042e72a11e449 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -803,19 +803,19 @@ static bool is_vsyscall_vaddr(unsigned long vaddr)
 
 static inline void cond_reenable_irqs_user(void)
 {
-	if (running_inband())
-		unstall_inband_nocheck();
-
 	hard_local_irq_enable();
+
+	if (running_inband())
+		local_irq_enable();
 }
 
 static inline void cond_reenable_irqs_kernel(irqentry_state_t state,
 					struct pt_regs *regs)
 {
 	if (regs->flags & X86_EFLAGS_IF) {
-		if (state.stage_info == IRQENTRY_INBAND_UNSTALLED)
-			unstall_inband_nocheck();
 		hard_local_irq_enable();
+		if (state.stage_info == IRQENTRY_INBAND_UNSTALLED)
+			local_irq_enable();
 	}
 }
 
@@ -824,7 +824,7 @@ static inline void cond_disable_irqs(void)
 	hard_local_irq_disable();
 
 	if (running_inband())
-		stall_inband_nocheck();
+		local_irq_disable();
 }
 
 #else  /* !CONFIG_IRQ_PIPELINE */
-- 
2.31.1


