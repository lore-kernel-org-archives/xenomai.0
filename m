Date: Mon, 23 Jun 2014 11:08:57 +0200
From: Arnaud Degroote <arnaud.degroote@isae.fr>
Message-ID: <20140623090857.GA4043@dmia-degroote.isae.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Support of Beagleboard xm rev C on 3.14-ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi list,

I'm trying to deploy a 3.14 kernel on my BeagleBoard XM rev C but got
several issues. So, first question, it is supposed to be supported or am
I somewhere in a grey zone ?

Let describe more precisely the configuration and the symptom.
- linux-ipipe branch ipipe-3.14
- xenomai 2.6.3 + some patches from 2.6 branch (including
	d1d00e0acd29bb5f9023494a883a7fa0def40917 
	41cb1f73814d1094e0ea75ccbbd23ff01280787e
	7a48019268d7e1157ebb072b88f6683425f0c7c5
	f00d22eca6277e780c19a5d5ecd2ed0e23dabafe
	)

The "default" configuration hangs in the boot, but it seems to boot
properly with the option CONFIG_DEBUG_LOCK_ALLOC (or at least it mitigates the issue).

Once booted, the regression tests show several oddities:
  - clocktest does not seem to work (it does not terminate)
  - posix/xddp_test terminates "ok" but with some kind of oops

[   51.764441] I-pipe: Detected stalled head domain, probably caused by a bug.
[   51.764441]         A critical section may have been left unterminated.
[   51.778650] CPU: 0 PID: 312 Comm: xddp_test Not tainted 3.14.0-ipipe-test9 #1
[   51.786104] Backtrace: 
[   51.788700] [<c00125a8>] (dump_backtrace) from [<c00128bc>] (show_stack+0x20/0x24)
[   51.796606]  r6:c0ee9618 r5:c0ea08c0 r4:c0ea08c0 r3:00404140
[   51.802566] [<c001289c>] (show_stack) from [<c06eb96c>] (dump_stack+0x20/0x28)
[   51.810121] [<c06eb94c>] (dump_stack) from [<c00a255c>] (ipipe_root_only+0x84/0x9c)
[   51.818127] [<c00a24d8>] (ipipe_root_only) from [<c00a33b4>] (ipipe_unstall_root+0x1c/0x48)
[   51.826847]  r5:deaff250 r4:deafed80
[   51.830612] [<c00a3398>] (ipipe_unstall_root) from [<c0071080>] (debug_check_no_locks_freed+0x10c/0x148)
[   51.840524] [<c0070f74>] (debug_check_no_locks_freed) from [<c0072894>] (__raw_spin_lock_init+0x28/0x60)
[   51.850421]  r8:c0ee95a4 r7:c0eeb59c r6:c0a77dc8 r5:c08aac47 r4:c0ee9618
[   51.857473] [<c007286c>] (__raw_spin_lock_init) from [<c0069e54>] (__init_waitqueue_head+0x2c/0x58)
[   51.866918]  r6:c08b4c22 r5:c0eeaf44 r4:c0ee9618 r3:c0ee9618
[   51.872878] [<c0069e28>] (__init_waitqueue_head) from [<c00e6efc>] (xnpipe_open+0xe4/0xa28)
[   51.881597]  r6:de17d3c0 r5:00000000 r4:c0a19c18 r3:c0ee9618
[   51.887558] [<c00e6e18>] (xnpipe_open) from [<c0163c08>] (chrdev_open+0x14c/0x178)
[   51.895459]  r10:de03cc00 r9:de17d3c8 r8:de17d3c0 r7:00000000 r6:debf9d40 r5:c0a1f6f4
[   51.903679]  r4:df6eb400
[   51.906340] [<c0163abc>] (chrdev_open) from [<c015dd54>] (do_dentry_open+0x284/0x298)
[   51.914521]  r8:c0163abc r7:00000000 r6:debf9e50 r5:debf9d40 r4:de17d3c0
[   51.921570] [<c015dad0>] (do_dentry_open) from [<c015e114>] (finish_open+0x48/0x5c)
[   51.929566]  r10:de261e84 r9:de260000 r8:de17d3c0 r7:00000000 r6:de261e88 r5:de17d3c0
[   51.937789]  r4:de261e84 r3:deafed80
[   51.941551] [<c015e0cc>] (finish_open) from [<c016cc80>] (do_last.isra.31+0x870/0xad0)
[   51.949820]  r4:de261ed0 r3:de261e84
[   51.953579] [<c016c410>] (do_last.isra.31) from [<c016d100>] (path_openat+0x220/0x5cc)
[   51.961850]  r10:00000000 r9:de260000 r8:ffffff9c r7:deae9000 r6:de261f5c r5:de17d3c0
[   51.970070]  r4:de261ed0
[   51.972732] [<c016cee0>] (path_openat) from [<c016e2b4>] (do_filp_open+0x3c/0x88)
[   51.980546]  r10:00000000 r9:de260000 r8:c000e60c r7:ffffff9c r6:deae9000 r5:00000001
[   51.988768]  r4:de261f5c
[   51.991430] [<c016e278>] (do_filp_open) from [<c015f298>] (do_sys_open+0x130/0x1d0)
[   51.999426]  r7:ffffff9c r6:deae9000 r5:00000003 r4:00000002
[   52.005379] [<c015f168>] (do_sys_open) from [<c015f368>] (SyS_open+0x30/0x34)
[   52.012829]  r9:de260000 r8:c000e60c r7:00000005 r6:00000002 r5:4a4d981c r4:ffffffed
[   52.020970] [<c015f338>] (SyS_open) from [<c000e360>] (ret_fast_syscall+0x0/0x34)
[   52.028981] ------------[ cut here ]------------
[   52.033843] WARNING: CPU: 0 PID: 312 at include/linux/ipipe.h:225 xnpipe_open+0x4c0/0xa28()
[   52.042614] Modules linked in:
[   52.045854] CPU: 0 PID: 312 Comm: xddp_test Not tainted 3.14.0-ipipe-test9 #1
[   52.053320] Backtrace: 
[   52.055938] [<c00125a8>] (dump_backtrace) from [<c00128bc>] (show_stack+0x20/0x24)
[   52.063862]  r6:c08b03c7 r5:00000009 r4:00000000 r3:00404140
[   52.069859] [<c001289c>] (show_stack) from [<c06eb96c>] (dump_stack+0x20/0x28)
[   52.077458] [<c06eb94c>] (dump_stack) from [<c0038618>] (warn_slowpath_common+0x78/0x98)
[   52.085954] [<c00385a0>] (warn_slowpath_common) from [<c00386f4>] (warn_slowpath_null+0x2c/0x34)
[   52.095173]  r8:c0ee95a4 r7:c0eeb59c r6:c0a7051e r5:00000000 r4:c0a19c18
[   52.102229] [<c00386c8>] (warn_slowpath_null) from [<c00e72d8>] (xnpipe_open+0x4c0/0xa28)
[   52.110822] [<c00e6e18>] (xnpipe_open) from [<c0163c08>] (chrdev_open+0x14c/0x178)
[   52.118768]  r10:de03cc00 r9:de17d3c8 r8:de17d3c0 r7:00000000 r6:debf9d40 r5:c0a1f6f4
[   52.127029]  r4:df6eb400
[   52.129721] [<c0163abc>] (chrdev_open) from [<c015dd54>] (do_dentry_open+0x284/0x298)
[   52.137935]  r8:c0163abc r7:00000000 r6:debf9e50 r5:debf9d40 r4:de17d3c0
[   52.145035] [<c015dad0>] (do_dentry_open) from [<c015e114>] (finish_open+0x48/0x5c)
[   52.153028]  r10:de261e84 r9:de260000 r8:de17d3c0 r7:00000000 r6:de261e88 r5:de17d3c0
[   52.161289]  r4:de261e84 r3:deafed80
[   52.165104] [<c015e0cc>] (finish_open) from [<c016cc80>] (do_last.isra.31+0x870/0xad0)
[   52.173387]  r4:de261ed0 r3:de261e84
[   52.177191] [<c016c410>] (do_last.isra.31) from [<c016d100>] (path_openat+0x220/0x5cc)
[   52.185498]  r10:00000000 r9:de260000 r8:ffffff9c r7:deae9000 r6:de261f5c r5:de17d3c0
[   52.193734]  r4:de261ed0
[   52.196436] [<c016cee0>] (path_openat) from [<c016e2b4>] (do_filp_open+0x3c/0x88)
[   52.204265]  r10:00000000 r9:de260000 r8:c000e60c r7:ffffff9c r6:deae9000 r5:00000001
[   52.212527]  r4:de261f5c
[   52.215223] [<c016e278>] (do_filp_open) from [<c015f298>] (do_sys_open+0x130/0x1d0)
[   52.223237]  r7:ffffff9c r6:deae9000 r5:00000003 r4:00000002
[   52.229238] [<c015f168>] (do_sys_open) from [<c015f368>] (SyS_open+0x30/0x34)
[   52.236743]  r9:de260000 r8:c000e60c r7:00000005 r6:00000002 r5:4a4d981c r4:ffffffed
[   52.244949] [<c015f338>] (SyS_open) from [<c000e360>] (ret_fast_syscall+0x0/0x34

- latency seems to hang at some point too.

There is probably another issue in the test suite, as, individually, native
tests works ok, but hangs when launched in the full test suite.

Do you have any idea where it can come from ? Where I can I start to look to debug deeply the issue?

Thanks in advance. Best regards,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140623/6b19ede6/attachment.sig>
