From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/4] x86/ioapic: irq_pipeline: unbreak irqflags tracing
Date: Sat, 31 Jul 2021 11:49:31 +0200
Message-Id: <20210731094934.1799307-2-rpm@xenomai.org>
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

local_irq_save/restore() pairs should be replaced by
local_irq_save_full() calls when pipelining, not
hard_local_irq_save/restore(), so that lockdep does not complain about
inconsistent irq state (the hard_* form does not invoke the trace_irq*
API).

This fixes this kind of splat at boot:

[    0.124134] Switched APIC routing to physical flat.
[    0.125066] ------------[ cut here ]------------
[    0.125353] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
[    0.125369] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5521 check_flags+0x102/0x1b0
[    0.126203] Modules linked in:
[    0.126395] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.14.0-rc1+ #31
[    0.126779] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
[    0.127302] RIP: 0010:check_flags+0x102/0x1b0
[    0.127565] Code: ff ff e8 a1 ff aa ff 85 c0 74 21 44 8b 0d 5e b0 bd 00 45 85 c9 75 15 48 c7 c6 78 73 2d 82 48 c7 c7 88 dd 2b 82 e8 b9 75 fb ff <0f> 0b 48 c7 c7 08 89 2d 82 e8 81 e6 fb ff eb 9e 85 c0 0f 85 42 ff
[    0.128670] RSP: 0000:ffffffff82403cb0 EFLAGS: 00010082
[    0.128983] RAX: 000000000000002f RBX: 0000000000000000 RCX: 0000000000000000
[    0.129409] RDX: 0000000000000003 RSI: 00000000ffffffea RDI: 00000000ffffffff
[    0.129888] RBP: 0000000000000001 R08: ffffffff825573c8 R09: 00000000ffffdfff
[    0.130318] R10: ffffffff824773e0 R11: ffffffff824773e0 R12: ffffffff82461bd8
[    0.130741] R13: 0000000000000046 R14: 0000000000000000 R15: 0000000000000000
[    0.131166] FS:  0000000000000000(0000) GS:ffff888233e00000(0000) knlGS:0000000000000000
[    0.131649] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.131993] CR2: ffff88823ffff000 CR3: 0000000002424000 CR4: 00000000000406b0
[    0.132420] Call Trace:
[    0.132572]  lock_acquire.part.0+0x52/0x1f0
[    0.132832]  ? _raw_spin_unlock_irqrestore+0x55/0x70
[    0.133134]  ? rcu_read_lock_sched_held+0xa/0x70
[    0.133419]  ? lock_acquire+0xa0/0x140
[    0.133647]  ? mask_8259A_irq+0x14/0x60
[    0.133883]  _raw_spin_lock_irqsave+0x43/0x90
[    0.134146]  ? mask_8259A_irq+0x14/0x60
[    0.134383]  mask_8259A_irq+0x14/0x60
[    0.134606]  mp_irqdomain_alloc+0x1a7/0x260
[    0.134862]  __irq_domain_alloc_irqs+0x154/0x410
[    0.135144]  alloc_isa_irq_from_domain.constprop.0+0xa0/0xe0
[    0.135486]  mp_map_pin_to_irq+0x1a9/0x310
[    0.135735]  setup_IO_APIC+0x121/0x1d0
[    0.135971]  apic_intr_mode_init+0xff/0x105
[    0.136224]  x86_late_time_init+0x20/0x30
[    0.136469]  start_kernel+0x45f/0x4f8
[    0.136692]  secondary_startup_64_no_verify+0xb0/0xbb

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/x86/kernel/apic/io_apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index febaa0f0dcd43ed..59bc9d1824e1f00 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3078,10 +3078,10 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	mp_preconfigure_entry(data);
 	mp_register_handler(virq, data->is_level);
 
-	flags = hard_local_irq_save();
+	local_irq_save_full(flags);
 	if (virq < nr_legacy_irqs())
 		legacy_pic->mask(virq);
-	hard_local_irq_restore(flags);
+	local_irq_restore_full(flags);
 
 	apic_printk(APIC_VERBOSE, KERN_DEBUG
 		    "IOAPIC[%d]: Preconfigured routing entry (%d-%d -> IRQ %d Level:%i ActiveLow:%i)\n",
-- 
2.31.1


