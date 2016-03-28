From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Message-ID: <56F96800.6090301@mperpetuo.com>
Date: Mon, 28 Mar 2016 10:21:04 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] arm64: spurious timer tick
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I have noticed that when Xenomai is running on an arm64 platform that uses 
the arm architected timer, a spurious timer tick can occur.

Here is a patch to observe it:

diff --git a/drivers/clocksource/arm_arch_timer.c 
b/drivers/clocksource/arm_arch_timer.c
index 51230ee7..4a91ce6 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -148,6 +148,10 @@ static int arch_timer_ack(const int access, struct 
clock_event_device *evt)
                 arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, evt);
                 return 1;
         }
+
+       printk("spurious timer tick\n");
+       dump_stack();
+
         return 0;
  }


On the 410c, it is sufficient to apply this patch and run switchtest - the 
issue occurs quite frequently - about every 15 seconds on my board.

Below is a stack trace that I get with the above patch:

[57283.366174] [<ffffffc000089c30>] dump_backtrace+0x0/0x12c
[57283.368974] [<ffffffc000089d6c>] show_stack+0x10/0x1c
[57283.373904] [<ffffffc0007f3c3c>] dump_stack+0x88/0xd8
[57283.378910] [<ffffffc0005dc4b0>] arch_timer_ack+0x110/0x12c
[57283.383917] [<ffffffc0005dc6c8>] arch_itimer_ack_virt+0x20/0x2c
[57283.389281] [<ffffffc000139ab8>] __ipipe_ack_hrtimer_irq+0x2c/0x60
[57283.395194] [<ffffffc000139504>] __ipipe_dispatch_irq+0x88/0x1e4
[57283.401414] [<ffffffc000082350>] __ipipe_grab_irq+0x78/0x90
[57283.484836] [<ffffffc0000825c0>] gic_handle_irq+0x38/0x7c
[57283.570645] [<ffffffc0000855a8>] el1_irq+0x68/0x94
[57283.578846] [<ffffffc000156aec>] program_htick_shot+0xdc/0xfc
[57283.583516] [<ffffffc000117e08>] clockevents_program_event+0x78/0x104
[57283.589336] [<ffffffc00011a018>] tick_program_event+0x28/0x34
[57283.595797] [<ffffffc00010b860>] __remove_hrtimer+0xf4/0x100
[57283.601567] [<ffffffc00010bea4>] __hrtimer_start_range_ns+0x1ec/0x344
[57283.607364] [<ffffffc00010c028>] hrtimer_start+0x14/0x20
[57283.613726] [<ffffffc00011a9a4>] __tick_nohz_idle_enter+0x328/0x3e8
[57283.619182] [<ffffffc00011ac4c>] tick_nohz_idle_enter+0x3c/0x7c
[57283.625212] [<ffffffc0000ea3c0>] cpu_startup_entry+0x44/0x290
[57283.631157] [<ffffffc0007ee21c>] rest_init+0xc0/0xd0
[57283.637080] [<ffffffc000af79b0>] start_kernel+0x3c4/0x3dc

Any help figuring out why this is happening would be much appreciated.

Thanks,
Dmitriy

