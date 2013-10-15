Message-ID: <525DC044.6090201@steinkuehler.net>
Date: Tue, 15 Oct 2013 17:23:00 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Hung task on Xenomai patched ARM 3.8.13 BeagleBone Kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

There seems to be some minor issue with the Xenomai patches for the
BeagleBone 3.8.13 ARM target.  Occasionally, the eMMC task will hang for
greater than 60 seconds, causing the kernel to kill it, which basically
brings down the system (root is on the eMMC device).

I was writing this off to bad SD cards, and indeed I did have a card
that exhibited these symptoms on an x86 Linux system that had no xenomai
patches at all.  I pitched this card and didn't have any more consistent
problems, but it turns out the bug is fairly simple to 'tickle'.  Just
boot the xenomai patched kernel and run:

grep "TestConfig" /usr -r

...after a while, the mmcqd task will hang.  I have not yet had a
xenomai kernel survive this test, while a "stock" kernel has gotten
through the whole /usr directory multiple times without issue.

So...how do I go about debugging this problem?  Will testing with
different xenomai kernel configuration options (which ones?) possibly
shed any light on what's going wrong?

I'm not totally out of my depth here (I design hardware, so the
lower-level the code the easier it is for me to understand), but I don't
really do a lot of Linux Kernel hacking.  I'm muddling forward as best I
can, but any advice would be appreciated.

A typical "hung task" report follows:

> [  200.279217] INFO: task mmcqd/1:73 blocked for more than 60 seconds.
> [  200.285938] "echo 0>  /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  200.294286] mmcqd/1         D c06976c8     0    73      2 0x00000000
> [  200.301177] [<c06976c8>] (__schedule+0x5b8/0x774) from [<c0695834>] (s=
chedule_timeout+0x1c/0x21c)
> [  200.310609] [<c0695834>] (schedule_timeout+0x1c/0x21c) from [<c0697a50=
>] (wait_for_common+0x130/0x170)
> [  200.320537] [<c0697a50>] (wait_for_common+0x130/0x170) from [<c051c9a8=
>] (mmc_wait_for_req_done+0x1c/0x74)
> [  200.330791] [<c051c9a8>] (mmc_wait_for_req_done+0x1c/0x74) from [<c051=
d630>] (mmc_start_req+0x50/0x158)
> [  200.340758] [<c051d630>] (mmc_start_req+0x50/0x158) from [<c0528bf0>] =
(mmc_blk_issue_rw_rq+0xa4/0x348)
> [  200.350659] [<c0528bf0>] (mmc_blk_issue_rw_rq+0xa4/0x348) from [<c0529=
290>] (mmc_blk_issue_rq+0x3fc/0x450)
> [  200.360952] [<c0529290>] (mmc_blk_issue_rq+0x3fc/0x450) from [<c05298c=
c>] (mmc_queue_thread+0xa0/0x104)
> [  200.371017] [<c05298cc>] (mmc_queue_thread+0xa0/0x104) from [<c005a69c=
>] (kthread+0xa0/0xb0)
> [  200.380013] [<c005a69c>] (kthread+0xa0/0xb0) from [<c000dc00>] (ret_fr=
om_fork+0x18/0x38)
> [  200.388616] Kernel panic - not syncing: hung_task: blocked tasks
> [  200.395001] [<c00138dc>] (unwind_backtrace+0x0/0xe0) from [<c06905d0>]=
 (panic+0x84/0x1e0)
> [  200.403641] [<c06905d0>] (panic+0x84/0x1e0) from [<c00943d0>] (watchdo=
g+0x1d4/0x234)
> [  200.411843] [<c00943d0>] (watchdog+0x1d4/0x234) from [<c005a69c>] (kth=
read+0xa0/0xb0)
> [  200.420115] [<c005a69c>] (kthread+0xa0/0xb0) from [<c000dc00>] (ret_fr=
om_fork+0x18/0x38)
> [  200.428645] drm_kms_helper: panic occurred, switching back to text con=
sole
> [  200.435919] Rebooting in 5 seconds..

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131015/7ac57a7=
d/attachment.pgp>
