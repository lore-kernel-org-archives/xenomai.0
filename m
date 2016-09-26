Message-ID: <1474911440.25736.16.camel@henry-ThinkCentre-M93p>
From: Henry Bausley <hbausley@deltatau.com>
Date: Mon, 26 Sep 2016 10:37:20 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Taint while running Xenomai Application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

After about a week of running I had a customer see the following crash
while running our user mode xenomai application.  I am trying to
determine if this is an Xenomai issue or application problem.  We are
using an ARM LS1021A with 3.14.28-ipipe and Xenomai 2.6.4.  Can anyone
provide where we should look based on the info we were provided.


INFO: rcu_sched self-detected stall on CPU { 0}  (t=6825324 jiffies
g=16719 c=16718 q=7229)
CPU: 0 PID: 2196 Comm: RAS Server Acce Tainted: G           O
3.14.28-ipipe #37
Backtrace:
[<800118c4>] (dump_backtrace) from [<80011c54>] (show_stack+0x18/0x1c)
 r6:00001c3d r5:806ee100 r4:00000000 r3:00400140
[<80011c3c>] (show_stack) from [<8051ae7c>] (dump_stack+0x70/0x8c)
[<8051ae0c>] (dump_stack) from [<8005f40c>] (print_cpu_stall+0xc0/0x144)
 r4:806fa840 r3:806fa574
[<8005f34c>] (print_cpu_stall) from [<80060ac8>] (check_cpu_stall
+0x9c/0xcc)
 r8:c3a49f00 r7:806face4 r6:0000414e r5:0000414e r4:00000001
[<80060a2c>] (check_cpu_stall) from [<80060b20>] (__rcu_pending
+0x28/0x120)
 r6:806fa840 r5:806fa840 r4:bffd6540 r3:15b7999c
[<80060af8>] (__rcu_pending) from [<8006214c>] (rcu_check_callbacks
+0xa0/0xdc)
 r6:806f474c r5:00000000 r4:806fa840 r3:806e6540
[<800620ac>] (rcu_check_callbacks) from [<80029e88>]
(update_process_times+0x40/0x60)
 r7:00000000 r6:00000000 r5:bd269c00 r4:a598e000
[<80029e48>] (update_process_times) from [<80029ed4>]
(update_root_process_times+0x2c/0x58)
 r7:00000000 r6:806ee180 r5:00000000 r4:000f4240
[<80029ea8>] (update_root_process_times) from [<80069388>]
(tick_periodic+0x98/0xb8)
 r5:00000000 r4:000f4240
[<800692f0>] (tick_periodic) from [<80069680>] (tick_handle_periodic
+0x80/0x9c)
 r6:00000000 r5:80745f08 r4:bffdcd40 r3:80745c40
[<80069600>] (tick_handle_periodic) from [<80429a8c>]
(arch_timer_handler_phys+0x64/0x78)
 r9:807460c0 r8:80746880 r7:0000001e r6:0ed584d5 r5:0000001e r4:bffdcd40
[<80429a28>] (arch_timer_handler_phys) from [<8005ab50>]
(handle_percpu_devid_irq+0x7c/0xfc)
 r5:00000000 r4:be0076c0
[<8005aad4>] (handle_percpu_devid_irq) from [<80057fb4>]
(generic_handle_irq+0x28/0x38)
 r6:806fb47c r5:bffd8ba4 r4:0000001e r3:8005aad4
[<80057f8c>] (generic_handle_irq) from [<8000efb0>] (handle_IRQ
+0x90/0xd8)
 r4:0000001e r3:00000102
[<8000ef20>] (handle_IRQ) from [<80014f98>] (__ipipe_do_IRQ+0x30/0x40)
 r5:80746080 r4:807460c0
[<80014f68>] (__ipipe_do_IRQ) from [<800779ac>] (__ipipe_do_sync_stage
+0x21c/0x288)
[<80077790>] (__ipipe_do_sync_stage) from [<80077d9c>]
(ipipe_unstall_root+0x4c/0x60)
 r10:ffffffff r9:80015708 r8:806ee100 r7:00200200 r6:00000000
r5:a598f920
 r4:80722280
[<80077d50>] (ipipe_unstall_root) from [<80522264>]
(_raw_spin_unlock_irq+0x14/0x18)
[<80522250>] (_raw_spin_unlock_irq) from [<80029bec>] (run_timer_softirq
+0x16c/0x1cc)
[<80029a80>] (run_timer_softirq) from [<800229c4>] (__do_softirq
+0xe8/0x240)
 r10:806ee0c4 r9:a598e000 r8:00000001 r7:00000100 r6:806ee0c0
r5:000002ca
 r4:a598e000
[<800228dc>] (__do_softirq) from [<80022d84>] (irq_exit+0x8c/0xe4)
 r10:00000004 r9:807460c0 r8:80746880 r7:0000001e r6:806fb47c
r5:00000000
 r4:a598e000
[<80022cf8>] (irq_exit) from [<8000efb4>] (handle_IRQ+0x94/0xd8)
 r4:0000001e r3:00000102
[<8000ef20>] (handle_IRQ) from [<80014f98>] (__ipipe_do_IRQ+0x30/0x40)
 r5:80746080 r4:807460c0
[<80014f68>] (__ipipe_do_IRQ) from [<800779ac>] (__ipipe_do_sync_stage
+0x21c/0x288)
[<80077790>] (__ipipe_do_sync_stage) from [<80077a84>]
(__ipipe_do_sync_pipeline+0x6c/0xe4)
 r10:a687f900 r9:00000000 r8:80746080 r7:807460c0 r6:806f474c
r5:807215c0
 r4:806e6860
[<80077a18>] (__ipipe_do_sync_pipeline) from [<80077c70>]
(dispatch_irq_head+0x174/0x188)
 r8:00000000 r7:00000000 r6:bffd7a00 r5:bffd6860 r4:80756a40 r3:bffd8ba0
[<80077afc>] (dispatch_irq_head) from [<8007817c>] (__ipipe_dispatch_irq
+0x110/0x20c)
 r7:a598faf4 r6:00000000 r5:00000000 r4:0000001e
[<8007806c>] (__ipipe_dispatch_irq) from [<800084e8>] (__ipipe_grab_irq
+0x78/0x90)
 r6:806f48d0 r5:a598fac0 r4:a598fac0 r3:bffd6860
[<80008470>] (__ipipe_grab_irq) from [<8000875c>] (gic_handle_irq
+0x3c/0x60)
Exception stack(0xa598faa0 to 0xa598fae8)
faa0: 8014bf90 8044b3b0 60000013 ffffffff a598fb24 a598fac0 80012400
8000872c
fac0: a687f900 a598fb8c bd071080 8044b390 00000000 a598fb8c bd8981c0
a687f900
fae0: 00000000 00000000
 r4:c0802000 r3:00000100
[<80008720>] (gic_handle_irq) from [<80012400>] (__irq_svc+0x40/0x4c)
Exception stack(0xa598fac0 to 0xa598fb08)
fac0: a687f900 a598fb8c bd071080 8044b390 00000000 a598fb8c bd8981c0
a687f900
fae0: 00000000 00000000 a687f900 a598fb24 a598fb28 a598fb08 8014bf90
8044b3b0
fb00: 60000013 ffffffff
 r6:ffffffff r5:60000013 r4:8044b3b0 r3:8014bf90
[<8044b390>] (sock_poll) from [<8014bf90>] (do_select+0x210/0x44c)
 r7:00000008 r6:00000100 r5:00000000 r4:00000000
[<8014bd80>] (do_select) from [<8014c410>] (core_sys_select+0x244/0x308)
 r10:00000000 r9:00000001 r8:00000000 r7:00000009 r6:a598fe20
r5:00000004
 r4:6178ec18
[<8014c1cc>] (core_sys_select) from [<8014c78c>] (SyS_select+0xdc/0x10c)
 r10:00000000 r8:00000000 r7:00000000 r6:00000009 r5:6178ec18
r4:6178ebe0
[<8014c6b0>] (SyS_select) from [<8000e500>] (ret_fast_syscall+0x0/0x30)
 r10:00000000 r9:a598e000 r8:8000e6e8 r7:0000008e r6:00020000
r5:6178ebe0
 r4:6178ebe0




Outbound scan for Spam or Virus by Barracuda at Delta Tau


