MIME-Version: 1.0
In-Reply-To: <4C726911.6050201@domain.hid>
References: <AANLkTikjB1vF+0Ldnc_80_+TJeG2MKo5i42hE5Ah3nj9@domain.hid>
	<4C6BD747.1090304@domain.hid>
	<AANLkTimiofme9duMMyiqe3snHmGxWFxGf7AJDaaAGE6b@domain.hid>
	<AANLkTinYt1Gj+Vsm1NXCXyDPa92KS+DMFVhpNcVvYjgw@domain.hid>
	<4C6D4BDE.1050605@domain.hid>
	<AANLkTi=-7yEyDLn1tBmzkxMK+=Tr4F-7XNGdtzoespod@domain.hid>
	<4C7260B4.4070100@domain.hid> <4C726911.6050201@domain.hid>
Date: Mon, 23 Aug 2010 15:04:58 +0200
Message-ID: <AANLkTik4KoHd9ni1DYuUej01uh8c7X8Tb0vgqf8ou93=@mail.gmail.com>
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

03.00.00.05 is version of the SDK.  TI said that their kernel is the
result of patches that were applied to the open source kernel 2.6.32 .
But I find some differences with the vanilia kernel. I don't get
response from TI about this subject ... I'm waiting information.
I don't access to the vendor git ...

I restarted with your advices :

#git clone git://git.denx.de/ipipe-2.6.git
#git checkout -branch -b ipipe-2.6.32-noarch origin/ipipe-2.6.32-noarch
#git checkout -b vendor
#rm -rf
#cp -vR ../TI_linux/* ./
#git add *
#git commit
#git checkout ipipe-2.6.32-noarch
#git merge vendor
#git branch -m ipipe-2.6.32-noarch vendor+ipipe-2.6.32-noarch
#git diff origin/ipipe-2.6.33-noarch origin/ipipe-2.6.33-arm > ../result.pa=
tch
#cat ../result.patch | patch -p1
#find ./ -name '*.rej'

./init/main.c.rej
./kernel/ipipe/core.c.rej
./arch/arm/vfp/vfpmodule.c.rej
./arch/arm/plat-omap/gpio.c.rej
./arch/arm/mach-mx25/devices.c.rej
./include/linux/ipipe.h.rej
./include/linux/ipipe_percpu.h.rej
./include/linux/ipipe_base.h.rej

It seem easier with 2.6.33. I will try to resolve manualy these rejectfile.

Best regards,
Marc

2010/8/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> Gilles Chanteperdrix wrote:
>> marc doz wrote:
>>> Hi,
>>> I don't know where do you from my vendor kernel but it seems that it
>>> is a 2.6.32 kernel.
>>
>> I have no doubt that it is a 2.6.32 kernel. The question is to know
>> whether it is a vanilla kernel, i.e. coming from kernel.org. Since in
>> your first post the kernel directory was named linux_0030 or something
>> like that, I assumed it was not. But in any case it does not change
>> anything since the I-pipe patch for arm does not exist for linux-2.6.32
>> either.
>>
>>> This is my first time with git ! so I will need that you valid my
>>> method, please.
>>>
>>> I test with these commands :
>>>
>>> #git clone git://git.denx.de/ipipe-2.6.git
>>> #git checkout -branch -b ipipe-2.6.32-noarch origin/ipipe-2.6.32-noarch
>>> #git checkout -b vendor
>>> #cp -vR ../TI_linux/* ./
>>
>> It will work better if the branch "vendor" comes from the vendor git.
>
> No, what you did does not work at all. After this cp, the "vendor"
> branch will contain a mix of files from the noarch branch with the ones
> of your vendor.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>
>

