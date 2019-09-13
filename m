Date: Fri, 13 Sep 2019 09:58:10 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <297954754.5119650.1568386690979.JavaMail.zimbra@wolfram.com>
Subject: Warning from drvlib.c:1349 rtdm_mutex_timedlock
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Dear all

I'm trying to figure out the significance and meaning of the following warning, see [1] below . It's from when using the peak-linux-driver for their CAN devices.

This warning happens every time my software opens or closes a rtdm/pcanx device. I briefly touched upon this when talking to peak about other issues and got the impression that they hadn't seen it themselves.

Everything is working just fine with full speed and real time performance so there is no major problems that I can see. I use Yocto and thus have a quite complicated build setup which can perhaps make things slip through, so I was wondering if error in build flags could be the reason for this warning. The code calls a library (pcanlib) which in turn makes the syscall, so I was thinking that perhaps there be a problem with the linking of this library?

Any ideas?


[1]
------------------------------------------------------------------------------------------------------------------------------------------------------
[357740.718504] WARNING: CPU: 1 PID: 1993 at /usr/src/kernel/kernel/xenomai/rtdm/drvlib.c:1349 rtdm_mutex_timedlock+0x43/0x2f0
[357740.718505] Modules linked in: pcan(O) rtudp rtipv4 intel_powerclamp intel_rapl i915 coretemp rt_igb e1000e rtnet video fan thermal_sys [last unloaded: pcan]
[357740.718516] CPU: 1 PID: 1993 Comm: pcanfdtst Tainted: G        W  O    4.9.90-xeno-cobolt #1
[357740.718517] Hardware name: Default string Default string/SKYBAY, BIOS 5.0.1.1 04/18/2016
[357740.718518] I-pipe domain: Linux
[357740.718519]  ffffc90005e0fd18 ffffffff81446e18 0000000000000000 0000000000000000
[357740.718522]  ffffffff81bb1370 ffffc90005e0fd58 ffffffff810785d1 0000054505e0fdb0
[357740.718524]  ffff880262a93000 ffff88024a342800 0000000000000002 ffff880262a93380
[357740.718527] Call Trace:
[357740.718530]  [<ffffffff81446e18>] dump_stack+0xbf/0xe7
[357740.718533]  [<ffffffff810785d1>] __warn+0xe1/0x100
[357740.718534]  [<ffffffff810786bd>] warn_slowpath_null+0x1d/0x20
[357740.718536]  [<ffffffff81170c43>] rtdm_mutex_timedlock+0x43/0x2f0
[357740.718538]  [<ffffffff81170f02>] rtdm_mutex_lock+0x12/0x20
[357740.718542]  [<ffffffffa06ab2ee>] pcan_open_nrt+0x6e/0x130 [pcan]
[357740.718543]  [<ffffffff8116c913>] __rtdm_dev_open+0x123/0x360
[357740.718545]  [<ffffffff81205ce3>] ? getname_flags+0x53/0x190
[357740.718547]  [<ffffffff81178c30>] ? get_timespec+0x70/0x70
[357740.718548]  [<ffffffff81178c5a>] CoBaLt_open+0x2a/0x40
[357740.718550]  [<ffffffff81188472>] ipipe_syscall_hook+0x112/0x350
[357740.718552]  [<ffffffff810842cb>] ? recalc_sigpending+0x1b/0x50
[357740.718555]  [<ffffffff8110acb8>] __ipipe_notify_syscall+0xc8/0x190
[357740.718556]  [<ffffffff8110adaa>] ipipe_handle_syscall+0x2a/0xb0
[357740.718558]  [<ffffffff81001c3d>] do_syscall_64+0x2d/0xf0
[357740.718561]  [<ffffffff818dffbe>] entry_SYSCALL_64_after_swapgs+0x58/0xc6
[357740.718562] ---[ end trace 8c611fed369f2a4c ]---
------------------------------------------------------------------------------------------------------------------------------------------------------

