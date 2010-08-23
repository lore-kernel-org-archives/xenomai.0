MIME-Version: 1.0
In-Reply-To: <4C6D4BDE.1050605@domain.hid>
References: <AANLkTikjB1vF+0Ldnc_80_+TJeG2MKo5i42hE5Ah3nj9@domain.hid>
	<4C6BD747.1090304@domain.hid>
	<AANLkTimiofme9duMMyiqe3snHmGxWFxGf7AJDaaAGE6b@domain.hid>
	<AANLkTinYt1Gj+Vsm1NXCXyDPa92KS+DMFVhpNcVvYjgw@domain.hid>
	<4C6D4BDE.1050605@domain.hid>
Date: Mon, 23 Aug 2010 13:39:15 +0200
Message-ID: <AANLkTi=-7yEyDLn1tBmzkxMK+=Tr4F-7XNGdtzoespod@domain.hid>
From: marc doz <doz.marc@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] kernel compilation problem with a Cortex A8,
 AM3517 EVM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,
I don't know where do you from my vendor kernel but it seems that it
is a 2.6.32 kernel.
This is my first time with git ! so I will need that you valid my
method, please.

I test with these commands :

#git clone git://git.denx.de/ipipe-2.6.git
#git checkout -branch -b ipipe-2.6.32-noarch origin/ipipe-2.6.32-noarch
#git checkout -b vendor
#cp -vR ../TI_linux/* ./
#git add *
#git commit
#git checkout ipipe-2.6.32-noarch
#git merge vendor
--> no error, no warning
#git checkout -branch -b ipipe-2.6.31-noarch origin/ipipe-2.6.31-noarch
#git checkout -branch -b ipipe-2.6.31-arm origin/ipipe-2.6.31-arm
#git checkout ipipe-2.6.32-noarch
#cat ../result.patch | patch -p1
#find . -name '*.reji'
./arch/arm/mach-sa1100/time.c.rej
./arch/arm/plat-mxc/gpio.c.rej
./arch/arm/mach-omap2/irq.c.rej
./arch/arm/mach-omap2/timer-gp.c.rej
./arch/arm/Kconfig.rej
./arch/arm/kernel/entry-common.S.rej
./arch/arm/kernel/smp.c.rej
./arch/arm/kernel/Makefile.rej
./arch/arm/kernel/entry-armv.S.rej
./arch/arm/kernel/entry-header.S.rej
./arch/arm/vfp/vfpmodule.c.rej
./arch/arm/mach-at91/at91sam9261.c.rej
./arch/arm/include/asm/mmu_context.h.rej
./arch/arm/include/asm/cacheflush.h.rej
./arch/arm/include/asm/thread_info.h.rej
./arch/arm/mm/Kconfig.rej
./arch/arm/mm/flush.c.rej

I will try to resolve manualy these rejectfile :
./arch/arm/mach-omap2/irq.c.rej
./arch/arm/mach-omap2/timer-gp.c.rej
./arch/arm/Kconfig.rej
./arch/arm/kernel/entry-common.S.rej
./arch/arm/kernel/smp.c.rej
./arch/arm/kernel/Makefile.rej
./arch/arm/kernel/entry-armv.S.rej
./arch/arm/kernel/entry-header.S.rej
./arch/arm/vfp/vfpmodule.c.rej
./arch/arm/include/asm/mmu_context.h.rej
./arch/arm/include/asm/cacheflush.h.rej
./arch/arm/include/asm/thread_info.h.rej
./arch/arm/mm/Kconfig.rej
./arch/arm/mm/flush.c.rej


2010/8/19 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> marc doz wrote:
>> The compilation is a sucess without the line 172 and 193. It seem that
>> spin lock management is different between kernel 2.6.32 ans 2.6.33.
>>
>> So I think that my realy problem is that is need a adeos patch =A0for
>> kernel 2.6.32 adeos-ipipe-2.6.32-arm* . I have 298 patchs of Texas
>> Instrument for the kernel 2.6.32 and my board. So I can't upgrade to
>> 2.6.33 or downgrade to 2.6.31.
>>
>> The 2.6.32 adeos-ipipe-2.6.32-arm* patch is not present in the
>> downloading section of the adeos website
>
> Yes, I did not produce this patch. If you want to do it, you should use
> the I-pipe git: git://git.denx.de/ipipe-2.6.git, then merge the
> ipipe-2.6.32-noarch branch with your vendor branch, then try and apply
> the diff between ipipe-2.6.31-noarch and ipipe-2.6.31-arm or
> ipipe-2.6.33-noarch and ipipe-2.6.33-arm.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

regards,
Marc

