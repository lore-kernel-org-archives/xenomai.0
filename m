Message-ID: <52195702.6070802@steinkuehler.net>
Date: Sat, 24 Aug 2013 19:59:46 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <52138425.2030000@steinkuehler.net> <5213B7D3.5030606@xenomai.org>
	<5213C836.403@steinkuehler.net> <5213C9AD.2010903@xenomai.org>
	<5213D09E.80103@steinkuehler.net> <5214BDC1.30104@steinkuehler.net>
	<5215061E.6060305@xenomai.org> <5218E8F0.1050102@cantastic.org>
In-Reply-To: <5218E8F0.1050102@cantastic.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Building BeagleBone kernel from git
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ralf Roesch <xenomai@cantastic.org>
Cc: xenomai@xenomai.org

I will try to test this when I get a chance, but I'm headed out of town
so it may be a while.

This error, however, is identical to hangs I get when working with a bad
SD card.  I had a *LOT* of those for a while, mostly on one bad SD card
(that also gave hangs on x86 non-xenomai systems, so it _was_ a problem
with the SD card).  On the other SD cards I have, IIRC I got a few of
these hangs when I first started working with the BeagleBone and haven't
had any for quite some time.  Other than the one actually bad SD card,
it feels like the mmc driver can't handle the card re-mapping bad
sectors, but that's just a guess on my part.

I'm not positive if I've seen the problem on non-xenomai kernels or just
on the xenomai kernels I use for LinuxCNC.  It's quite possible there's
a bug either in the TI eMMC driver error handling, or perhaps the
xenomai patches either add a bug or 'tickle' a bug that's already
present.  Have you tried your test with a non-xenomai kernel?

On 8/24/2013 12:10 PM, Ralf Roesch wrote:
> Hi Gilles,
> Hi Charles,
> =

> I followed this thread highly interested and built my own kernel
> according your advices.
> =

> By using the linux-dev repository from Robert Nelson I have built an
> bootable kernel image for my BeagleBone Black:
> -rwxr-xr-x 1 ralf ralf  3484720 Aug 23 16:10 3.8.13-xenomai-bone26.zImage
> -rw-r--r-- 1 ralf ralf   112741 Aug 23 16:10 3.8.13-xenomai-bone26.config
> -rw-r--r-- 1 ralf ralf 11865475 Aug 23 16:10
> 3.8.13-xenomai-bone26-modules.tar.gz
> -rw-r--r-- 1 ralf ralf  1205333 Aug 23 16:10
> 3.8.13-xenomai-bone26-firmware.tar.gz
> -rw-r--r-- 1 ralf ralf    33431 Aug 23 16:10
> 3.8.13-xenomai-bone26-dtbs.tar.gz
> =

> For my tests I use following file system (also from R. Nelson):
> BBB-eMMC-flasher-debian-7.1-2013-07-22.img.xz
> found @ http://rcn-ee.net/deb/flasher/wheezy
> =

> If I execute the following commands:
> 1.) boot kernel
> (Info: uame -a Linux arm 3.8.13-xenomai-bone26 #2 SMP Sat Aug 24
> 17:14:39 CEST 2013 armv7l GNU/Linux)
> 2.) modprobe xeno_klat
> 3.) grep "TestConfig" /usr -r
> (du -h /usr 255M)
> =

> I can reproduce following error (log on serial console):
> Debian GNU/Linux 7 arm ttyO0
> =

> arm login:
> [  200.279217] INFO: task mmcqd/1:73 blocked for more than 60 seconds.
> [  200.285938] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  200.294286] mmcqd/1         D c06976c8     0    73      2 0x00000000
> [  200.301177] [<c06976c8>] (__schedule+0x5b8/0x774) from [<c0695834>]
> (schedule_timeout+0x1c/0x21c)
> [  200.310609] [<c0695834>] (schedule_timeout+0x1c/0x21c) from
> [<c0697a50>] (wait_for_common+0x130/0x170)
> [  200.320537] [<c0697a50>] (wait_for_common+0x130/0x170) from
> [<c051c9a8>] (mmc_wait_for_req_done+0x1c/0x74)
> [  200.330791] [<c051c9a8>] (mmc_wait_for_req_done+0x1c/0x74) from
> [<c051d630>] (mmc_start_req+0x50/0x158)
> [  200.340758] [<c051d630>] (mmc_start_req+0x50/0x158) from [<c0528bf0>]
> (mmc_blk_issue_rw_rq+0xa4/0x348)
> [  200.350659] [<c0528bf0>] (mmc_blk_issue_rw_rq+0xa4/0x348) from
> [<c0529290>] (mmc_blk_issue_rq+0x3fc/0x450)
> [  200.360952] [<c0529290>] (mmc_blk_issue_rq+0x3fc/0x450) from
> [<c05298cc>] (mmc_queue_thread+0xa0/0x104)
> [  200.371017] [<c05298cc>] (mmc_queue_thread+0xa0/0x104) from
> [<c005a69c>] (kthread+0xa0/0xb0)
> [  200.380013] [<c005a69c>] (kthread+0xa0/0xb0) from [<c000dc00>]
> (ret_from_fork+0x18/0x38)
> [  200.388616] Kernel panic - not syncing: hung_task: blocked tasks
> [  200.395001] [<c00138dc>] (unwind_backtrace+0x0/0xe0) from
> [<c06905d0>] (panic+0x84/0x1e0)
> [  200.403641] [<c06905d0>] (panic+0x84/0x1e0) from [<c00943d0>]
> (watchdog+0x1d4/0x234)
> [  200.411843] [<c00943d0>] (watchdog+0x1d4/0x234) from [<c005a69c>]
> (kthread+0xa0/0xb0)
> [  200.420115] [<c005a69c>] (kthread+0xa0/0xb0) from [<c000dc00>]
> (ret_from_fork+0x18/0x38)
> [  200.428645] drm_kms_helper: panic occurred, switching back to text
> console
> [  200.435919] Rebooting in 5 seconds..
> U-Boot SPL 2013.04-00017-g5c4fa11 (May 03 2013 - 10:48:32)
> =

> I have no idea if this blocking is caused by hard- or software.
> Without performing step 2, I could not reproduce this error up to now.
> =

> May be you have an idea whats going wrong here?
> If you have an BBB available it would be great if you could try to
> reproduce this error.
> =

> Thanks and best regards
> Ralf
> =

> =

> On Wed Aug 21 2013 20:25:34 GMT+0200 (CEST), Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 08/21/2013 03:16 PM, Charles Steinkuehler wrote:
>>> On 8/20/2013 3:25 PM, Charles Steinkuehler wrote:
>>>> On 8/20/2013 2:55 PM, Gilles Chanteperdrix wrote:
>>>>> On 08/20/2013 09:49 PM, Charles Steinkuehler wrote:
>>>>>> Sorry if this is a total newbie question, but I see instructions
>>>>>> for using the prepare-kernel.sh script on a kernel directory, and =

>>>>>> instructions for using the ipipe kernel source directly, but not
>>>>>> how to get from one to the other.
>>>>>>
>>>>> You want the I-pipe patch. To generate it, in the I-pipe tree, try:
>>>>>
>>>>> ./scripts/ipipe/genpatches.sh
>>>>>
>>>>> You should then find a file ipipe-core-3.8.13-arm-1.patch which you
>>>>> can try and apply to another tree, possibly additionally patching with
>>>>> pre and post patches (respectively before and after the I-pipe patch).
>>>> Yep, that sounds like exactly what I want!  Thanks for the help!!
>>>>
>>>> I'll report back if I run into more issues or if everything works out
>>>> OK.  I am trying to integrate the xenomai patches into a customized
>>>> version of Robert C. Nelson's BeagleBone kernel build scripts:
>>>>
>>>> https://github.com/cdsteinkuehler/linux-dev
>>> Thanks again for the help!
>>>
>>> I managed to get a working xenomai kernel from the automated builds.  I
>>> have only done light testing so far, but there didn't look to be any
>>> major issues with the process.
>>>
>>> Additions to the "stock" RCN kernel build:
>>>
>>> I pull the ipipe-3.8 branch from git and use it to generate an ipipe
>>> patch file
>>>
>>> The ipipe patch is applied to a BeagleBone patched kernel tree [1]
>>>
>>> I pull xenomai 2.6 (master) from git and run it's setup_kernel.sh on the
>>> ipipe patched source tree
>>>
>>> ...build continues as usual.
>>>
>>> More testing needs to be done, but it looks good so far!
>>>
>>> [1] There was one hunk I could not get to apply automatically.  The code
>>> in gpmc.c has changed extensively enough that git apply doesn't work
>>> with this file.  To work around this, I skip this file when applying the
>>> ipipe patch, and use a manual fix-up of the trivial 2-line change:
>>>
>>> https://github.com/cdsteinkuehler/linux-dev/blob/am33x-v3.8-bone26-xeno=
mai/patches/xenomai/0001-ipipe-core-3.8.13-arm-1.gpmc.patch
>>>
>>> There's probably a better way to work around this problem, but this
>>> should do until the next official xenomai release comes out...any day
>>> now, right?!?  :)  Anyway, it doesn't look like it will be that hard to
>>> roll forward with updated ipipe or xenomai patches.
>> The general way to handle the non-mainline kernels is with a pre and
>> post patch. The pre patch removes the changes which conflicts, and the
>> post patch adds the merge.
>>
>> As for the release date of 2.6.3 it should happen soon, but now that the
>> I-pipe support for 3.10 is almost there, I am going to wait for it to
>> have been tested (but not fully validated) so that 2.6.3 will be ready
>> for 3.10.
>>
>>> Thanks again!!
>>>
>>
> =

> =



-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130824/4235bdc=
5/attachment.pgp>
