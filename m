Message-ID: <5048ACDE.2080308@xenomai.org>
Date: Thu, 06 Sep 2012 16:02:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>	<5022B5E4.7040101@xenomai.org>	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>	<50339840.1070202@xenomai.org>	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>	<CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>	<504503DC.4040908@xenomai.org>	<CAHue_TX3+pr39Mso1SXA83NWVRNoeocD-zDcLPk5mKn-XCkQKQ@mail.gmail.com>	<50453DCE.5020601@xenomai.org>	<CAHue_TUfY4f4CdCXyEYQ5mPFNiCazwZLgv9yy29W5r78tfftYA@mail.gmail.com>	<50485E80.6050800@xenomai.org>
	<CAHue_TX6R8i_8HSNNeBi-JLBv4MGMjtQH6JxGvgj5xqWzU3kkQ@mail.gmail.com>
In-Reply-To: <CAHue_TX6R8i_8HSNNeBi-JLBv4MGMjtQH6JxGvgj5xqWzU3kkQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Cortex-a9 - please fix xenomai-fix-lfs-issue.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?TWFyY2luIEt1xZtrYQ==?= <marckuska@gmail.com>
Cc: xenomai@xenomai.org

On 09/06/2012 03:31 PM, Marcin Kuśka wrote:
>>
>> Like what, no kernel message ?
>>
> 
> Sory it must have been pasted wrong:
> d1Xenomai: suspending kernel thread c9502128 ('rtk4/0') at 0xc00672ac after
> exception #0x0

That is still the same problem. All you need to do is
arm-none-linux-gnueabi-objdump -d vmlinux | less
And look for 'c00672ac'


> rtuBoU_Gu:f pMAX_LOCK_DEPTH too low!

No need to investigate on this before we know what happens at the
address above.


> The message was:
> WARNING: at mm/slab.c:2264 kmem_cache_create+0x6a4/0x6f4()
> 
> In the slab.c:2264 line there is
> 
> #if DEBUG
> WARN_ON(strchr(name, ' '));    /* It confuses parsers */
> So the isp1760 urb_listitem does have a space in its name and that's all
> warning. That's not serious is it?

No, we do not care, but investigating it was needed.


> I'm not really sure about physical address of the global timer (the first
> parameter of gt_setup). In mach-versatile/include/mach/platform.h file I
> can find defines but using for example gt_setup(VERSATILE_WATCHDOG_BASE -
> 0x400,64) it ends up with a kernel panic:

The physical address is the physical address of the twd minus 0x400.
The virtual address of the twd is MMIO_P2V(A9_MPCORE_TWD) (file
arch/arm/mach-vexpress/ct-ca9x4.c, line 57), so I would use
A9_MPCORE_TWD - 0x400
As physical address for the global timer.


> Probably you noticed that I managed to run all 4 cores - as it turned out
> that was trivial, simply include asm/smp_twd.h in mach/irqs.h according to
> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting.

It is even simpler in the patch for 3.4, gt_setup is called
automatically, and including asm/smp_twd.h is no longer needed.

-- 
					    Gilles.

