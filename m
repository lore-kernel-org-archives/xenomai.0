Subject: Re: Possible Cobalt mqueue issue
References: <5C741D7B.5080108@freyder.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1a1a8dfe-e56c-5d1f-5880-7d4100cf4a23@siemens.com>
Date: Mon, 25 Feb 2019 18:15:44 +0100
MIME-Version: 1.0
In-Reply-To: <5C741D7B.5080108@freyder.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Freyder <steve@freyder.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 25.02.19 17:53, Steve Freyder via Xenomai wrote:
> Greetings again,
> 
> Recently I have converted my codebase from using Alchemy-based queues 
> (rt_queue_xx) to Cobalt (Posix) mqueues for all inter-process communication, and 
> using rt_queue queues only for communication between threads in the same process.
> 
> This is running on Xenomai 3.0.7 built from -next (our vendor does the 
> Xenomai/kernel builds):

Was that really 3.0.7, not 3.0.8 or latest stable-3.0.x? There e.g. 
https://gitlab.denx.de/Xenomai/xenomai/commit/4924717ec5cbc694afc1b91ba7d525b80901d44d 
since 3.0.7, and you backtrace kind of looks familiar /wrt that.

Jan

> 
> Linux g3l-36 4.1.18_C01571-15S01-00.002.zimg+83fdace666 #4 SMP Tue Aug 21 
> 11:22:31 CDT 2018 armv7l GNU/Linux
> 
> This happened as my main process was starting during boot.  I have not been able 
> to reproduce this, but I thought maybe the output would be useful.
> 
> Thanks in advance,
> Best regards,
> Steve
> 
> =============================================================================
> 
> [   13.056376] I-pipe: Detected stalled head domain, probably caused by a bug.
> [   13.056376]         A critical section may have been left unterminated.
> [   13.069983] CPU: 1 PID: 1259 Comm: g2ld-main Not tainted 
> 4.1.18_C01571-15S01-00.002.zimg+83fdace666 #4
> [   13.079309] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   13.085854] Backtrace:
> [   13.088362] [<80014a64>] (dump_backtrace) from [<80014c9c>] 
> (show_stack+0x20/0x24)
> [   13.095948]  r7:00000000 r6:00000080 r5:00000000 r4:80b85c94
> [   13.101747] [<80014c7c>] (show_stack) from [<806b679c>] (dump_stack+0xa0/0xc4)
> [   13.109003] [<806b66fc>] (dump_stack) from [<800ab000>] 
> (ipipe_root_only+0x11c/0x188)
> [   13.116848]  r9:80c49380 r8:00000000 r7:80c49380 r6:80b38e6c r5:600b0113 
> r4:809afba4
> [   13.124758] [<800aaee4>] (ipipe_root_only) from [<80021bc0>] 
> (do_page_fault+0x2fc/0x4a8)
> [   13.132864]  r10:bc34da84 r9:bba50000 r8:00000004 r7:bc34da40 r6:00000817 
> r5:bb291d58
> [   13.140845]  r4:600b0093 r3:00000000
> [   13.144498] [<800218c4>] (do_page_fault) from [<800093ec>] 
> (do_DataAbort+0x44/0x1b4)
> [   13.152257]  r10:80b3da3c r9:80b38e6c r8:00000004 r7:bb291d58 r6:800218c4 
> r5:00000817
> [   13.160238]  r4:80b3dbbc
> [   13.162822] [<800093a8>] (do_DataAbort) from [<80015838>] (__dabt_svc+0x58/0x80)
> [   13.170237] Exception stack(0xbb291d58 to 0xbb291da0)
> [   13.175309] 1d40: 00000000 00100100
> [   13.183510] 1d60: 00000000 00000000 bb8efc00 00000000 809ae9a0 00000001 
> 00000000 80b38e6c
> [   13.191710] 1d80: 80b3da3c bb291dd4 bb291d58 bb291da0 800eee1c 801107dc 
> 600b0093 ffffffff
> [   13.199902]  r10:80b3da3c r9:80b38e6c r8:00000000 r7:bb291d8c r6:ffffffff 
> r5:600b0093
> [   13.207884]  r4:801107dc
> [   13.210475] [<801106dc>] (mq_unref_inner) from [<80110ab8>] (mq_unref+0x78/0xd8)
> [   13.217886]  r10:00000000 r9:80b3da3c r8:80b38e6c r7:80c49380 r6:809ae9a0 
> r5:bb8efc00
> [   13.225867]  r4:00000000
> [   13.228449] [<80110a40>] (mq_unref) from [<80110b3c>] (mqd_close+0x24/0x28)
> [   13.235426]  r7:80c49380 r6:809ae9a0 r5:600b0013 r4:bb8efc00
> [   13.241218] [<80110b18>] (mqd_close) from [<80106c58>] (__put_fd+0x35c/0x3b8)
> [   13.248369]  r5:600b0013 r4:bda592c4
> [   13.252020] [<801068fc>] (__put_fd) from [<80107a84>] 
> (rtdm_fd_close+0x190/0x2f0)
> [   13.259518]  r10:bda592c4 r9:80b3da3c r8:86860b0b r7:80b38e6c r6:809ae9a0 
> r5:00000003
> [   13.267499]  r4:bda594c8
> [   13.270086] [<801078f4>] (rtdm_fd_close) from [<801119a8>] 
> (__cobalt_mq_open+0x730/0xc4c)
> [   13.278278]  r10:ffffffef r9:80b3da3c r8:80b38e6c r7:809ae9a0 r6:bb8efc00 
> r5:00000042
> [   13.286259]  r4:00000000
> [   13.288844] [<80111278>] (__cobalt_mq_open) from [<80111f54>] 
> (CoBaLt_mq_open+0x90/0xa0)
> [   13.296949]  r10:80111ec4 r9:80c5c300 r8:80c5c300 r7:c0943808 r6:00000000 
> r5:7ee16b4c
> [   13.304930]  r4:00000042
> [   13.307517] [<80111ec4>] (CoBaLt_mq_open) from [<8011ebb8>] 
> (handle_head_syscall+0xf8/0x3a4)
> [   13.315969]  r6:00000001 r5:00000001 r4:bb291fb0
> [   13.320691] [<8011eac0>] (handle_head_syscall) from [<8011f498>] 
> (ipipe_fastcall_hook+0x20/0x28)
> [   13.329493]  r10:00000006 r9:bb290000 r8:80010928 r7:000f0042 r6:7ee16b4c 
> r5:00000000
> [   13.337474]  r4:7ee16b8c
> [   13.340065] [<8011f478>] (ipipe_fastcall_hook) from [<80010808>] 
> (local_restart+0x20/0x44)
> [   13.348359] Unable to handle kernel NULL pointer dereference at virtual 
> address 00000004
> [   13.356468] pgd = bb2fc000
> [   13.359192] [00000004] *pgd=4da75831, *pte=00000000, *ppte=00000000
> [   13.365562] Internal error: Oops: 817 [#1] SMP ARM
> [   13.370371] Modules linked in: xeno_imx_uart xeno_gpio_mxc rt_e1000e rtnet 
> fec e1000e
> [   13.378412] CPU: 1 PID: 1259 Comm: g2ld-main Not tainted 
> 4.1.18_C01571-15S01-00.002.zimg+83fdace666 #4
> [   13.387735] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   13.394281] task: bba50000 ti: bb290000 task.ti: bb290000
> [   13.399699] PC is at mq_unref_inner+0x100/0x364
> [   13.404254] LR is at xnsynch_flush+0x154/0x2a0
> [   13.408717] pc : [<801107dc>]    lr : [<800eee1c>]    psr: 600b0093
> [   13.408717] sp : bb291da0  ip : bb291d58  fp : bb291dd4
> [   13.420213] r10: 80b3da3c  r9 : 80b38e6c  r8 : 00000000
> [   13.425454] r7 : 00000001  r6 : 809ae9a0  r5 : 00000000  r4 : bb8efc00
> [   13.432000] r3 : 00000000  r2 : 00000000  r1 : 00100100  r0 : 00000000
> [   13.438549] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM Segment user
> [   13.445789] Control: 10c5387d  Table: 4b2fc04a  DAC: 00000015
> [   13.451552] Process g2ld-main (pid: 1259, stack limit = 0xbb290220)
> [   13.457836] Stack: (0xbb291da0 to 0xbb292000)
> [   13.462218] 1da0: bb291df4 00000000 80b4d7cc 00000000 bb8efc00 809ae9a0 
> 80c49380 80b38e6c
> [   13.470420] 1dc0: 80b3da3c 00000000 bb291df4 bb291dd8 80110ab8 801106e8 
> bb8efc00 600b0013
> [   13.478620] 1de0: 809ae9a0 80c49380 bb291e0c bb291df8 80110b3c 80110a4c 
> bda592c4 600b0013
> [   13.486822] 1e00: bb291e4c bb291e10 80106c58 80110b24 80169c3c 00000000 
> 80b4d7cc bb8efc00
> [   13.495022] 1e20: 80b50384 bda594c8 00000003 809ae9a0 80b38e6c 86860b0b 
> 80b3da3c bda592c4
> [   13.503223] 1e40: bb291e94 bb291e50 80107a84 80106908 bb291e74 bb291e60 
> 800a9e54 bda594c0
> [   13.511423] 1e60: bc39b40c 00000000 bb291e94 00000000 00000042 bb8efc00 
> 809ae9a0 80b38e6c
> [   13.519624] 1e80: 80b3da3c ffffffef bb291f34 bb291e98 801119a8 80107900 
> 00000000 bb291ec4
> [   13.527824] 1ea0: bb8efc30 bb8efc0c 00000000 809ae9a0 809ae9a0 809ae9a0 
> bb291f38 00000003
> [   13.536024] 1ec0: 0000000c 800f00f4 6c32672f 65645f64 00677562 00000000 
> 00000000 00000102
> [   13.544225] 1ee0: 800ac9ec 800b05d8 809ae9a0 bb291fb0 00000006 00000001 
> 80b38e6c 80114408
> [   13.552426] 1f00: c0943808 bf648800 bb291f24 00000042 7ee16b4c 00000000 
> c0943808 80c5c300
> [   13.560626] 1f20: 80c5c300 80111ec4 bb291f64 bb291f38 80111f54 80111284 
> 00000000 00000800
> [   13.568827] 1f40: 00000200 00000000 7ee16b4c bb291fb0 00000001 00000001 
> bb291f9c bb291f68
> [   13.577027] 1f60: 8011ebb8 80111ed0 00000000 809afb40 809ad800 7ee16b8c 
> 00000000 7ee16b4c
> [   13.585228] 1f80: 000f0042 80010928 bb290000 00000006 bb291fac bb291fa0 
> 8011f498 8011eacc
> [   13.593429] 1fa0: 00000000 bb291fb0 80010808 8011f484 10000025 7ee16b4c 
> 00000042 00000000
> [   13.601630] 1fc0: 7ee16b8c 00000000 7ee16b4c 000f0042 00000000 00000000 
> 4b310000 7ee16bbc
> [   13.609831] 1fe0: 7ee16b8c 7ee16b00 00000042 4b5db418 200b0010 10000025 
> 00000000 00000000
> [   13.618021] Backtrace:
> [   13.620518] [<801106dc>] (mq_unref_inner) from [<80110ab8>] (mq_unref+0x78/0xd8)
> [   13.627929]  r10:00000000 r9:80b3da3c r8:80b38e6c r7:80c49380 r6:809ae9a0 
> r5:bb8efc00
> [   13.635912]  r4:00000000
> [   13.638495] [<80110a40>] (mq_unref) from [<80110b3c>] (mqd_close+0x24/0x28)
> [   13.645472]  r7:80c49380 r6:809ae9a0 r5:600b0013 r4:bb8efc00
> [   13.651262] [<80110b18>] (mqd_close) from [<80106c58>] (__put_fd+0x35c/0x3b8)
> [   13.658412]  r5:600b0013 r4:bda592c4
> [   13.662064] [<801068fc>] (__put_fd) from [<80107a84>] 
> (rtdm_fd_close+0x190/0x2f0)
> [   13.669562]  r10:bda592c4 r9:80b3da3c r8:86860b0b r7:80b38e6c r6:809ae9a0 
> r5:00000003
> [   13.677544]  r4:bda594c8
> [   13.680127] [<801078f4>] (rtdm_fd_close) from [<801119a8>] 
> (__cobalt_mq_open+0x730/0xc4c)
> [   13.688320]  r10:ffffffef r9:80b3da3c r8:80b38e6c r7:809ae9a0 r6:bb8efc00 
> r5:00000042
> [   13.696301]  r4:00000000
> [   13.698885] [<80111278>] (__cobalt_mq_open) from [<80111f54>] 
> (CoBaLt_mq_open+0x90/0xa0)
> [   13.706990]  r10:80111ec4 r9:80c5c300 r8:80c5c300 r7:c0943808 r6:00000000 
> r5:7ee16b4c
> [   13.714971]  r4:00000042
> [   13.717553] [<80111ec4>] (CoBaLt_mq_open) from [<8011ebb8>] 
> (handle_head_syscall+0xf8/0x3a4)
> [   13.726007]  r6:00000001 r5:00000001 r4:bb291fb0
> [   13.730728] [<8011eac0>] (handle_head_syscall) from [<8011f498>] 
> (ipipe_fastcall_hook+0x20/0x28)
> [   13.739528]  r10:00000006 r9:bb290000 r8:80010928 r7:000f0042 r6:7ee16b4c 
> r5:00000000
> [   13.747510]  r4:7ee16b8c
> [   13.750095] [<8011f478>] (ipipe_fastcall_hook) from [<80010808>] 
> (local_restart+0x20/0x44)
> [   13.758382] Code: e2840030 ebff79e4 e994000c e59f1244 (e5823004)
> [   13.764501] ---[ end trace a39fc1ccbff4481b ]---
> [   13.769156] ------------[ cut here ]------------
> [   13.773800] WARNING: CPU: 1 PID: 1259 at 
> /home/developer/oe/build_c01571-15/tmp/work-shared/c01571-15/kernel-source/kernel/ipipe/core.c:1764 
> __ipipe_spin_unlock_debug+0x4c/0x64()
> [   13.789717] Modules linked in: xeno_imx_uart xeno_gpio_mxc rt_e1000e rtnet 
> fec e1000e
> [   13.797748] CPU: 1 PID: 1259 Comm: g2ld-main Tainted: G D 
> 4.1.18_C01571-15S01-00.002.zimg+83fdace666 #4
> [   13.808285] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   13.814825] Backtrace:
> [   13.817317] [<80014a64>] (dump_backtrace) from [<80014c9c>] 
> (show_stack+0x20/0x24)
> [   13.824903]  r7:00000000 r6:00000080 r5:00000000 r4:80b85c94
> [   13.830690] [<80014c7c>] (show_stack) from [<806b679c>] (dump_stack+0xa0/0xc4)
> [   13.837943] [<806b66fc>] (dump_stack) from [<80031080>] 
> (warn_slowpath_common+0x88/0xc4)
> [   13.846049]  r9:bf7cbf70 r8:800ab1fc r7:80867500 r6:000006e4 r5:00000009 
> r4:00000000
> [   13.853943] [<80030ff8>] (warn_slowpath_common) from [<80031178>] 
> (warn_slowpath_null+0x2c/0x34)
> [   13.862742]  r8:80b3da3c r7:80b38e6c r6:00000000 r5:c0943aa0 r4:80bbbee8
> [   13.869597] [<8003114c>] (warn_slowpath_null) from [<800ab1fc>] 
> (__ipipe_spin_unlock_debug+0x4c/0x64)
> [   13.878841] [<800ab1b0>] (__ipipe_spin_unlock_debug) from [<80067fa8>] 
> (complete+0x4c/0x5c)
> [   13.887206]  r5:c0943aa0 r4:c0943aa4
> [   13.890858] [<80067f5c>] (complete) from [<800f3704>] 
> (__xnthread_cleanup+0x1ac/0x338)
> [   13.898788]  r7:80b38e6c r6:809ae9a0 r5:00000001 r4:c0943808
> [   13.904578] [<800f3558>] (__xnthread_cleanup) from [<801184e0>] 
> (ipipe_kevent_hook+0x498/0x870)
> [   13.913291]  r9:bba50000 r8:00000004 r7:00000000 r6:600b0113 r5:600b0113 
> r4:bba50000
> [   13.921193] [<80118048>] (ipipe_kevent_hook) from [<800abe54>] 
> (__ipipe_notify_kevent+0x84/0x148)
> [   13.930079]  r10:801107de r9:bba50000 r8:00000004 r7:00000000 r6:600b0113 
> r5:600b0113
> [   13.938055]  r4:bf649800 r3:00000000
> [   13.941707] [<800abdd0>] (__ipipe_notify_kevent) from [<80032ca8>] 
> (do_exit+0x764/0x9cc)
> [   13.949812]  r10:801107de r9:00000001 r8:801107e0 r7:0000000b r6:00000080 
> r5:0000000b
> [   13.957786]  r4:bba50000 r3:00000002
> [   13.961434] [<80032544>] (do_exit) from [<80015070>] (die+0x3d0/0x420)
> [   13.967975]  r7:0000000b
> [   13.970557] [<80014ca0>] (die) from [<806b53a0>] 
> (__do_kernel_fault.part.0+0x64/0x84)
> [   13.978402]  r10:bc34da84 r9:bba50000 r8:00000004 r7:bc34da40 r6:00000817 
> r5:bb291d58
> [   13.986376]  r4:00000004
> [   13.988960] [<806b533c>] (__do_kernel_fault.part.0) from [<80021b8c>] 
> (do_page_fault+0x2c8/0x4a8)
> [   13.997845]  r7:bc34da40 r4:600b0093
> [   14.001495] [<800218c4>] (do_page_fault) from [<800093ec>] 
> (do_DataAbort+0x44/0x1b4)
> [   14.009252]  r10:80b3da3c r9:80b38e6c r8:00000004 r7:bb291d58 r6:800218c4 
> r5:00000817
> [   14.017227]  r4:80b3dbbc
> [   14.019807] [<800093a8>] (do_DataAbort) from [<80015838>] (__dabt_svc+0x58/0x80)
> [   14.027219] Exception stack(0xbb291d58 to 0xbb291da0)
> [   14.032289] 1d40: 00000000 00100100
> [   14.040489] 1d60: 00000000 00000000 bb8efc00 00000000 809ae9a0 00000001 
> 00000000 80b38e6c
> [   14.048688] 1d80: 80b3da3c bb291dd4 bb291d58 bb291da0 800eee1c 801107dc 
> 600b0093 ffffffff
> [   14.056879]  r10:80b3da3c r9:80b38e6c r8:00000000 r7:bb291d8c r6:ffffffff 
> r5:600b0093
> [   14.064854]  r4:801107dc
> [   14.067436] [<801106dc>] (mq_unref_inner) from [<80110ab8>] (mq_unref+0x78/0xd8)
> [   14.074846]  r10:00000000 r9:80b3da3c r8:80b38e6c r7:80c49380 r6:809ae9a0 
> r5:bb8efc00
> [   14.082822]  r4:00000000
> [   14.085403] [<80110a40>] (mq_unref) from [<80110b3c>] (mqd_close+0x24/0x28)
> [   14.092378]  r7:80c49380 r6:809ae9a0 r5:600b0013 r4:bb8efc00
> [   14.098164] [<80110b18>] (mqd_close) from [<80106c58>] (__put_fd+0x35c/0x3b8)
> [   14.105313]  r5:600b0013 r4:bda592c4
> [   14.108961] [<801068fc>] (__put_fd) from [<80107a84>] 
> (rtdm_fd_close+0x190/0x2f0)
> [   14.116458]  r10:bda592c4 r9:80b3da3c r8:86860b0b r7:80b38e6c r6:809ae9a0 
> r5:00000003
> [   14.124433]  r4:bda594c8
> [   14.127014] [<801078f4>] (rtdm_fd_close) from [<801119a8>] 
> (__cobalt_mq_open+0x730/0xc4c)
> [   14.135205]  r10:ffffffef r9:80b3da3c r8:80b38e6c r7:809ae9a0 r6:bb8efc00 
> r5:00000042
> [   14.143179]  r4:00000000
> [   14.145760] [<80111278>] (__cobalt_mq_open) from [<80111f54>] 
> (CoBaLt_mq_open+0x90/0xa0)
> [   14.153864]  r10:80111ec4 r9:80c5c300 r8:80c5c300 r7:c0943808 r6:00000000 
> r5:7ee16b4c
> [   14.161839]  r4:00000042
> [   14.164421] [<80111ec4>] (CoBaLt_mq_open) from [<8011ebb8>] 
> (handle_head_syscall+0xf8/0x3a4)
> [   14.172872]  r6:00000001 r5:00000001 r4:bb291fb0
> [   14.177589] [<8011eac0>] (handle_head_syscall) from [<8011f498>] 
> (ipipe_fastcall_hook+0x20/0x28)
> [   14.186387]  r10:00000006 r9:bb290000 r8:80010928 r7:000f0042 r6:7ee16b4c 
> r5:00000000
> [   14.194362]  r4:7ee16b8c
> [   14.196943] [<8011f478>] (ipipe_fastcall_hook) from [<80010808>] 
> (local_restart+0x20/0x44)
> [   14.205222] ---[ end trace a39fc1ccbff4481c ]---
> 
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

