Message-ID: <5049DCD2.3020804@xenomai.org>
Date: Fri, 07 Sep 2012 13:38:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>	<5022B5E4.7040101@xenomai.org>	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>	<50339840.1070202@xenomai.org>	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>	<CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>	<504503DC.4040908@xenomai.org>	<CAHue_TX3+pr39Mso1SXA83NWVRNoeocD-zDcLPk5mKn-XCkQKQ@mail.gmail.com>	<50453DCE.5020601@xenomai.org>	<CAHue_TUfY4f4CdCXyEYQ5mPFNiCazwZLgv9yy29W5r78tfftYA@mail.gmail.com>	<50485E80.6050800@xenomai.org>	<CAHue_TX6R8i_8HSNNeBi-JLBv4MGMjtQH6JxGvgj5xqWzU3kkQ@mail.gmail.com>	<5048ACDE.2080308@xenomai.org>
	<CAHue_TW8KR_LQiruQf=ieyRz-n61smD1QUi81ZRx8fhqt2JXQA@mail.gmail.com>
In-Reply-To: <CAHue_TW8KR_LQiruQf=ieyRz-n61smD1QUi81ZRx8fhqt2JXQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On 09/07/2012 01:16 PM, Marcin Ku=C5=9Bka wrote:

>>
>> It is even simpler in the patch for 3.4, gt_setup is called
>> automatically, and including asm/smp_twd.h is no longer needed.
>>
>>
> I run the gt_setup at the very end of twd_timer_setup() and the system
> hangs:
>=20


It does not work:
- smp_twd.c is common to all platforms, so you can not include code in
it using a vexpress specific define (A9_MPCORE_TWD)
- gt_setup should be called once and only once (for two reasons, first
because ipipe_tsc_register can not be called twice, and second because
it does an ioremap, so, you do not want to remap the global timer
register 4 times).

So, what you are expected to do is to call gt_setup once, at the same
place as your SOC specific code initializes the twd_base variable. That
would be somewhere in ct-ca9x4.c.

>
> About that "arm-none-linux-gnueabi-objdump -d vmlinux | less"
> command, I can't find that address there.

The address is tied to a kernel compilation. So, if you recompiled the
kernel, you need to run the test which triggers the bug again, and use
the address it gives you.


--=20
                                                                Gilles.


