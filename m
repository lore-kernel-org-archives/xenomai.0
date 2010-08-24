MIME-Version: 1.0
In-Reply-To: <AANLkTinAp-kyQ9DLqhaMoc9nML7PF4yOmYDXF2850d5G@mail.gmail.com>
References: <AANLkTikjB1vF+0Ldnc_80_+TJeG2MKo5i42hE5Ah3nj9@domain.hid>
	<4C6BD747.1090304@domain.hid>
	<AANLkTimiofme9duMMyiqe3snHmGxWFxGf7AJDaaAGE6b@domain.hid>
	<AANLkTinYt1Gj+Vsm1NXCXyDPa92KS+DMFVhpNcVvYjgw@domain.hid>
	<4C6D4BDE.1050605@domain.hid>
	<AANLkTi=-7yEyDLn1tBmzkxMK+=Tr4F-7XNGdtzoespod@domain.hid>
	<4C7260B4.4070100@domain.hid> <4C726911.6050201@domain.hid>
	<AANLkTik4KoHd9ni1DYuUej01uh8c7X8Tb0vgqf8ou93=@mail.gmail.com>
	<4C72749A.5000506@domain.hid>
	<AANLkTinAp-kyQ9DLqhaMoc9nML7PF4yOmYDXF2850d5G@mail.gmail.com>
Date: Tue, 24 Aug 2010 12:03:19 -0300
Message-ID: <AANLkTin5X6wk2L2Kuk7c4EeiDo2_bk3nZspq0QJovv_L@mail.gmail.com>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
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
To: xenomai@xenomai.org

The TI patches were done for which kernel version?

Maybe that's the best version to work with adeos patches.

I use to work with git just when there is in the repository the same
configuration of the board that I am working on. My first tries are
always with the vanilla kernel from kernel.org and the patches from
adeos and the manufactures.

Best regards,

Flavio

2010/8/24 marc doz <doz.marc@domain.hid>:
> Hi,
>
> You are right ! =A0The texas kernel comes from this repository :
> http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.git;a=
=3Dshortlog;h=3Drefs/heads/pm
> Ti gives also a TI patch to apply on this kernel.
> This is a 2.6.32 kernel. Actualy, I work with a ipipe patch for 2.6.33
> kernel =A0but I get compilation errors with this patch.
> --> I am trying to get the a good ipipe patch for this kernel.
>
> This repository contains also a 2.6.31 kernel and I have got the TI
> patch corresponding to this kernel (old TI delivery)
> I patch with =A0adeos-ipipe-2.6.31-arm-1.16-02.patch. I have got 2 rej
> file. They are easy to solve.
> arch/arm/mach-omap2/timer-gp.c.rej
> arch/arm/mach-omap2/irq.c.rej
> --> This kernel compiles without error and I am testing this solution
> on my target
>
> Thank you for your patience and the =A0lesson with git
>
> It seems that kernel for my card is not a vanilla kernel and it is not
> compatible to adeos/ipipe patch but I will try to continue.
>
> l will keep you updated
>
> best regards,
> Marc
>
> 2010/8/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>> marc doz wrote:
>>> 03.00.00.05 is version of the SDK. =A0TI said that their kernel is the
>>> result of patches that were applied to the open source kernel 2.6.32 .
>>> But I find some differences with the vanilia kernel.
>>
>> I don't get it, if patches are applied, then it is not a vanilla kernel.
>> Period.
>>
>>> I don't get response from TI about this subject ... I'm waiting informa=
tion.
>>> I don't access to the vendor git ...
>>
>> I doubt that, TI git repositories are public.
>>
>>>
>>> I restarted with your advices :
>>>
>>> #git clone git://git.denx.de/ipipe-2.6.git
>>> #git checkout -branch -b ipipe-2.6.32-noarch origin/ipipe-2.6.32-noarch
>>> #git checkout -b vendor
>>> #rm -rf
>>> #cp -vR ../TI_linux/* ./
>>
>>> #git add *
>>
>> Still not good. You have to git rm the files which no longer exist.
>>
>>> #git commit
>>> #git checkout ipipe-2.6.32-noarch
>>> #git merge vendor
>>> #git branch -m ipipe-2.6.32-noarch vendor+ipipe-2.6.32-noarch
>>> #git diff origin/ipipe-2.6.33-noarch origin/ipipe-2.6.33-arm > ../resul=
t.patch
>>> #cat ../result.patch | patch -p1
>>> #find ./ -name '*.rej'
>>>
>>> ./init/main.c.rej
>>> ./kernel/ipipe/core.c.rej
>>> ./arch/arm/vfp/vfpmodule.c.rej
>>> ./arch/arm/plat-omap/gpio.c.rej
>>> ./arch/arm/mach-mx25/devices.c.rej
>>> ./include/linux/ipipe.h.rej
>>> ./include/linux/ipipe_percpu.h.rej
>>> ./include/linux/ipipe_base.h.rej
>>>
>>> It seem easier with 2.6.33. I will try to resolve manualy these rejectf=
ile.
>>
>> --
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

