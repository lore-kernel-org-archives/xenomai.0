From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Mon, 25 Jun 2018 22:21:00 +0800
Message-ID: <1529936460-16308-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai] [PATCH] ipipe: arm_arch_timer: correct the wrong
	ipipe_timer setup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org, jan.kiszka@siemens.com, edouard.tisserant@gmail.com, xenomai@xenomai.org
Cc: zhangjianwei8@huawei.com, ouyangzhaowei@huawei.com, linqiangmin@huawei.com, yangchuanlong@huawei.com, liupeifeng3@huawei.com

The arch_timer_mem_use_virtual variable is used to judge the type
of memory-mapped timer, it can not be used to judge the type of CP15
timer, so fix this issue, otherwise it will lead to kernel panic when
running as a VM.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
How to produce:
1. Attach the Xenomai patches to arm64 I-PIPE kernel tree, and build it
2. Using below commands to run it:
   "qemu-kvm -enable-kvm -m 1024 -cpu host -machine virt,gic-version=3 \
   -smp 4  -nographic -kernel Image -append "rdinit=/init console=ttyAMA0 \
   mem=512M root=/dev/ram0 earlycon=pl011,0x9000000 rw" -initrd guestfs_new.cpio.gz"
3. Then it will happen this panic, KVM does not permit VM using physical timer, it
   should use virtual timer.
[    0.850140] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.14.4-ipipe-g3403168 #3
[    0.850141] Hardware name: linux,dummy-virt (DT)
[    0.850143] I-pipe domain: Linux
[    0.850145] task: ffff80001d9a9c00 task.stack: ffff000009278000
[    0.850160] PC is at arch_itimer_ack_phys+0x0/0x18
[    0.850166] LR is at __ipipe_ack_hrtimer_irq+0x38/0x68
[    0.850168] pc : [<ffff00000885fd10>] lr : [<ffff00000816e988>] pstate: 800001c5
[    0.850169] sp : ffff00000800bf40
[    0.850170] x29: ffff00000800bf40 x28: ffff80001d9a9c00
[    0.850173] x27: 0000000000000000 x26: ffff00000800c000
[    0.850176] x25: ffff000008008000 x24: 0000000000000000
[    0.850178] x23: ffff000008f8a000 x22: 0000000000000003
[    0.850180] x21: 0000000000000000 x20: ffff80001ef9fd28
[    0.850183] x19: ffff80001d805400 x18: 0000000000000007
[    0.850184] x17: 000000000000000e x16: 0000000000000001
[    0.850187] x15: 0000000000000019 x14: 0000000000000033
[    0.850189] x13: 000000000000004c x12: 0000000000000068
[    0.850191] x11: 0000000000000000 x10: ffff80001d9a9c80
[    0.850193] x9 : ffff000009278000 x8 : ffff80001d9aa660
[    0.850196] x7 : 00000000ffffffff x6 : 0000000000000001
[    0.850198] x5 : 0000800016049000 x4 : ffff00000a030000
[    0.850200] x3 : 0000000008000000 x2 : ffff00000840c5a0
[    0.850203] x1 : ffff00000840b8c0 x0 : ffff00000885fd10
[    0.850206] Process swapper/1 (pid: 0, stack limit = 0xffff000009278000)
[    0.850207] Call trace:
[    0.850210] Exception stack(0xffff00000800be00 to 0xffff00000800bf40)
[    0.850212] be00: ffff00000885fd10 ffff00000840b8c0 ffff00000840c5a0 0000000008000000
[    0.850214] be20: ffff00000a030000 0000800016049000 0000000000000001 00000000ffffffff
[    0.850215] be40: ffff80001d9aa660 ffff000009278000 ffff80001d9a9c80 0000000000000000
[    0.850217] be60: 0000000000000068 000000000000004c 0000000000000033 0000000000000019
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index eb18cf2..f68676f 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -753,7 +753,7 @@ static void __arch_timer_setup(unsigned type,
 		arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
 #ifdef CONFIG_IPIPE
 		clk->ipipe_timer = raw_cpu_ptr(&arch_itimer);
-		if (arch_timer_mem_use_virtual) {
+		if (arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
 			clk->ipipe_timer->irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
 			clk->ipipe_timer->ack = arch_itimer_ack_virt;
 		} else {
-- 
1.8.3.1


