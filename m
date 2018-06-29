References: <008d01d40ef4$aa152ab0$fe3f8010$@sepro-group.com>
 <f91caf3e-5b65-298a-1ac6-91697eed90c3@xenomai.org>
 <00a901d40f76$771290d0$6537b270$@sepro-group.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56e66ad7-91b7-2b6a-f953-507d2493a27e@xenomai.org>
Date: Fri, 29 Jun 2018 15:56:37 +0200
MIME-Version: 1.0
In-Reply-To: <00a901d40f76$771290d0$6537b270$@sepro-group.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Assertion current-magic 0 failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Reichert?= <sreichert@sepro-group.com>, xenomai@xenomai.org

On 06/29/2018 08:57 AM, Stéphane Reichert wrote:
> Sorry about that.
> 
> Here is a better trace:
> Mode switch (reason: triggered fault), aborting. Backtrace:
> [Xenomai] switching Reception task shmem to secondary mode after exception 
> #0 in kernel-space at 0x800aced8 (pid 327)
> Unable to handle kernel paging request at virtual address ffeccffe
> pgd = a96dc000
> [ffeccffe] *pgd=3bf5e821, *pte=00000000, *ppte=00000000
> Internal error: Oops: 17 [#2] PREEMPT SMP ARM
> Modules linked in: ctr ccm usb_f_acm u_serial usb_f_ecm g_cdc u_ether 
> libcomposite configfs wl12xx wlcore mac80211 cfg80211 rfkill flexcan 
> wlcore_sdio ci_h                             drc_imx usbmisc_imx ci_hdrc 
> udc_core can_dev
> CPU: 2 PID: 327 Comm: Reception task  Tainted: G      D         4.1.46-ipipe 
> #6
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> task: a8bfb740 ti: a9e0c000 task.ti: a9e0c000
> /lib/libc.so.6(+0x25150) [0x7P6Cdis at cobalt_signal_send+0xf8/0x1f8
> 07150]
> /lib/libcopperplate.so.0(syncobj_lock+0x84) [0x76e7e7e8]
> /lib/libcopperplate.so.0(syncluster_findobj+0x34) [0x76e7ceec]
> /lib/libalchemy.so.0(alchemy_bind_object+0x98) [0x76ea21c0]
> /lib/libalchemy.so.0(rt_heap_bind+0x30) [0x76ea51c4]
> /root/libs/lib_ipc.so(init_local_data+0x60) [0x76f7485c]
> /root/libs/lib_ipc.so(rt_shm_open+0x70) [0x76f74bfc]
> ./tests_integration_lib_ipc() [0x12de0]
> /lib/libalchemy.so.0(+0xa448) [0x76ea7448]
> /lib/libcopperplate.so.0(+0x8314) [0x76e7e314]
> /lib/libcobalt.so.2(+0x1058c) [0x76e5958c]
> LR is at 0x18
> pc : [<800acedc>]    lr : [<00000018>]    psr: 80070093
> sp : a9e0df00  ip : a94fd948  fp : 8095f680
> r10: ab71c6e0  r9 : 00000142  r8 : 8088c880
> r7 : 00000001  r6 : 00000000  r5 : 00800000  r4 : a94fd4d8
> r3 : 00000017  r2 : ffeccffa  r1 : c08f9088  r0 : c09e5800
> Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c53c7d  Table: 396dc04a  DAC: 00000015
> Process Reception task  (pid: 327, stack limit = 0xa9e0c220)
> Stack: (0xa9e0df00 to 0xa9e0e000)
> df00: 00000018 c08f9088 c09e5800 800ad534 c09e5800 00000018 00000001 
> 00000000
> df20: 8088c880 808945fc 00000018 800ad788 c09e9008 00000022 a9e0dfb0 
> 800ad71c
> df40: 808945fc 00000001 ab71c6e0 800ae248 76320e38 a9e0dfb0 808945fc 
> 20070013
> df60: 00000001 ab71b6e0 8095f680 8088b6e0 ab71c6e0 8008a14c 8095f680 
> a9e0dfb0
> df80: 8088b6e0 8088da20 00000007 76320e14 76320e38 00000000 000f0042 
> 8000f028
> dfa0: a9e0c000 00000002 761cc8cc 8000ef84 10000040 00000142 00000018 
> 00000142
> dfc0: 76320e14 76320e38 00000000 000f0042 76f87594 0001e030 761ccc74 
> 761cc8cc
> dfe0: 00000018 761cc868 00012318 76e59148 20070010 10000040 00000000 
> 00000000
> [<800acedc>] (cobalt_signal_send) from [<800ad534>] 
> (__cobalt_kill+0x190/0x1b0)
> [<800ad534>] (__cobalt_kill) from [<800ad788>] (CoBaLt_kill+0x6c/0xcc)
> [<800ad788>] (CoBaLt_kill) from [<800ae248>] (ipipe_syscall_hook+0xfc/0x270)
> [<800ae248>] (ipipe_syscall_hook) from [<8008a14c>] 
> (__ipipe_notify_syscall+0xa8/0x1a4)
> [<8008a14c>] (__ipipe_notify_syscall) from [<8000ef84>] 
> (pipeline_syscall+0x8/0x24)
> Code: e5813084 e583c000 e8bd8070 e59421b0 (e592c004)
> ---[ end trace fcd211fc12a8e501 ]---
> tests_integration_lib_ipc: threadobj.c:1344: threadobj_prologue: Assertion 
> `current->magic == 0' failed.
> 

I can't make any sense of the user backtrace, which does not seem to
match any possible code path which could be leading to the assertion
above. The kernel panic may require a separate investigation.

1. the assertion from libcopperplate. Please run your application over
GDB, then paste the backtrace reported by the debugger when the
assertion trips ("bt" command). You may want to use a non-console
terminal for running GDB, so that we can receive a clean trace unspoiled
by any kernel warning.

2. the kernel panic.

* which I-pipe patch have you been using?
* is there any specifics we should know from your kernel setup?
* is your application using kill(2), and if so, passing which signal number?
* building your kernel with CONFIG_DEBUG_INFO enabled and triggering the
bug again, please paste the output of the following command:

<your-toolchain>/bin/arm-linux-gnueabihf-addr2line -e
<path-to-kernel>/vmlinux $pc

$pc is the panic trace above would be 800acedc.

-- 
Philippe.

