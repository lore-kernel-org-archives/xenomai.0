Message-ID: <4BBA61AD.5020100@domain.hid>
Date: Tue, 06 Apr 2010 00:18:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BBA5480.9090608@domain.hid>
In-Reply-To: <4BBA5480.9090608@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos patch interference with Angstrom 2.6.29-r46
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
> First, thanks for the help getting me started with Xenomai in 
> openembedded. Special thanks to Felipe Brandao Cavalcanti for the files 
> he posted. (I was sidetracked on another project, so I could not 
> follow-up sooner.)
> 
> I added  adeos-ipipe-2.6.29-arm-1.13-04.patch to the end of the normal 
> set of kernel patches to be applied against Angstrom 
> linux-omap-2.6.29.bb recipe file (it builds the -r46 revision). There 
> are conflicts with four Angstrom patches. There are two conflicts that I 
> am concerned about. (The first two below.)

Hi,

first of all, the Adeos patch is made for the vanilla kernel, not for
patched versions, and validated with that kernel. So, I would recommend
you to upgrade the kernel, instead of using a kernel with backported
changes. Maintaining the Adeos patch is enough time consuming.

Second, on what processor do you intend to run Xenomai? Some of the
patches may not be needed at all for the processor you want to use, so
you should not even bother to try and apply them.

> 
> Conflict with 
> '0001-implement-TIF_RESTORE_SIGMASK-support-and-enable-the.patch'.
> patching file arch/arm/include/asm/thread_info.h
> Hunk #1 FAILED at 136.
> Hunk #2 FAILED at 146.
> 2 out of 2 hunks FAILED -- rejects in file 
> arch/arm/include/asm/thread_info.h
> Adeos wants TIF_MMSWITCH_INT   20, but the other patch wants 
> TIF_RESTORE_SIGMASK   20.
> Can I define TIF_MMSWITCH_INT  as 21? Will that bother anything?

You need to inspect the code carefully to see if 21 is not used for
anything else.

> 
> Conflict with 'no-cortex-deadlock.patch'.
> patching file arch/arm/kernel/entry-common.S
> Hunk #5 FAILED at 82.
> Hunk #6 succeeded at 272 (offset 4 lines).
> Hunk #8 succeeded at 494 (offset -6 lines).
> 1 out of 8 hunks FAILED -- rejects in file arch/arm/kernel/entry-common.S
> Some Arm silicon require the "dmb" instruction in this fix to avoid 
> deadlock. Does Xenomai account for this elsewhere?

What you see is what you get. All the changes made by Xenomai are
available in the Adeos patch. Without seeing the code I can not tell. Is
the processor you want to use affected by this patch?

> 
> Conflict with '/cache/l1cache-shift.patch'
> patching file arch/arm/mm/Kconfig
> Hunk #1 FAILED at 717.
> 1 out of 1 hunk FAILED -- rejects in file arch/arm/mm/Kconfig
> No real conflict, the other patch just added a config entry that the 
> Adeos patch wasn't expecting.
> 
> Conflict with 'vfp/03-vfp-corruption.patch'
> patching file arch/arm/vfp/vfphw.S
> Hunk #5 succeeded at 136 with fuzz 1.
> Hunk #6 FAILED at 156.
> 1 out of 6 hunks FAILED -- rejects in file arch/arm/vfp/vfphw.S
> I allowed the #ifdef CONFIG_PREEMPT segment to match before the Adeos 
> insertion.

Risky business, we patch a bit the vfp support, and are going to patch
it even further in next revisions. Here again, without the code, I can
not tell.

-- 
					    Gilles.

