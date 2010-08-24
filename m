MIME-Version: 1.0
In-Reply-To: <4C72749A.5000506@domain.hid>
References: <AANLkTikjB1vF+0Ldnc_80_+TJeG2MKo5i42hE5Ah3nj9@domain.hid>
	<4C6BD747.1090304@domain.hid>
	<AANLkTimiofme9duMMyiqe3snHmGxWFxGf7AJDaaAGE6b@domain.hid>
	<AANLkTinYt1Gj+Vsm1NXCXyDPa92KS+DMFVhpNcVvYjgw@domain.hid>
	<4C6D4BDE.1050605@domain.hid>
	<AANLkTi=-7yEyDLn1tBmzkxMK+=Tr4F-7XNGdtzoespod@domain.hid>
	<4C7260B4.4070100@domain.hid> <4C726911.6050201@domain.hid>
	<AANLkTik4KoHd9ni1DYuUej01uh8c7X8Tb0vgqf8ou93=@mail.gmail.com>
	<4C72749A.5000506@domain.hid>
Date: Tue, 24 Aug 2010 10:12:01 -0300
Message-ID: <AANLkTi=B_yNWPVX_Hg0c0p1VEHeXbDjMwcJiC3KL-+iG@mail.gmail.com>
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

I believe that TI provides the patches separatelly too, but I'm not sure.


2010/8/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> marc doz wrote:
>> 03.00.00.05 is version of the SDK. =A0TI said that their kernel is the
>> result of patches that were applied to the open source kernel 2.6.32 .
>> But I find some differences with the vanilia kernel.
>
> I don't get it, if patches are applied, then it is not a vanilla kernel.
> Period.
>
>> I don't get response from TI about this subject ... I'm waiting informat=
ion.
>> I don't access to the vendor git ...
>
> I doubt that, TI git repositories are public.
>
>>
>> I restarted with your advices :
>>
>> #git clone git://git.denx.de/ipipe-2.6.git
>> #git checkout -branch -b ipipe-2.6.32-noarch origin/ipipe-2.6.32-noarch
>> #git checkout -b vendor
>> #rm -rf
>> #cp -vR ../TI_linux/* ./
>
>> #git add *
>
> Still not good. You have to git rm the files which no longer exist.
>
>> #git commit
>> #git checkout ipipe-2.6.32-noarch
>> #git merge vendor
>> #git branch -m ipipe-2.6.32-noarch vendor+ipipe-2.6.32-noarch
>> #git diff origin/ipipe-2.6.33-noarch origin/ipipe-2.6.33-arm > ../result=
.patch
>> #cat ../result.patch | patch -p1
>> #find ./ -name '*.rej'
>>
>> ./init/main.c.rej
>> ./kernel/ipipe/core.c.rej
>> ./arch/arm/vfp/vfpmodule.c.rej
>> ./arch/arm/plat-omap/gpio.c.rej
>> ./arch/arm/mach-mx25/devices.c.rej
>> ./include/linux/ipipe.h.rej
>> ./include/linux/ipipe_percpu.h.rej
>> ./include/linux/ipipe_base.h.rej
>>
>> It seem easier with 2.6.33. I will try to resolve manualy these rejectfi=
le.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

