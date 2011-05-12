MIME-Version: 1.0
In-Reply-To: <4DCA45CA.1020208@domain.hid>
References: <BANLkTimLY=RNyzZi7zm_Ln8iLDriEHPBUw@domain.hid>
	<4DCA45CA.1020208@domain.hid>
Date: Thu, 12 May 2011 10:37:51 +1000
Message-ID: <BANLkTim7dgHQn4seiQ+t2kSg0CHEq2oydA@mail.gmail.com>
From: AKS <aungkyas@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Adeos-main] building user space xenomai 2.5.6 for ARM
Reply-To: aungkyas@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>

Hi Gilles

Thanks and how to configure so that thumb will not be included.

I checked ./configure --help | grep -i thumb

But I did not see any hint how to omit thum2.

I can native compile kernel, drivers and user space applications on
target. But xenomai client is an issue. Please advise. Thanks!

On 5/11/11, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 05/11/2011 08:44 AM, AKS wrote:
>> Hi Gilles and other mates
>>
>> Good day! I would like to ask your help in building user space xenomai.
>>
>> I have patched Adeos-ipipe-2.6.35.9-arm-1.18-01.patch to omap 2.6.35
>> so that it will work with Xenomai 2.5.6. I have managed to compile the
>> I-piped patched Linux kernel and let the Xenomai running - I have tested
>> on the Linux by dmesg | grep -i I-pipe and dmesg | grep -i Xenomai. And
>> I can ./configure the Xenomai by
>>
>> ./configure --enable-arm-mach=omap3 --enable-arm-arch=armv7l as the
>
> You do not need enable-arm-arch, all omap3 have the same architecture,
> so configure takes care of this.
>
>> kernel returns armv7l when uname -i. But I cannot sudo make install it
>> by native compiling on my target machine. On my host machine which
>> is running Ubuntu 10.10, I can make (after ./configure as stated above)
>> and make install.
>>
>> But on my target box running omap3 processor with armv7l core - I am
>> using Gumstix - I cannot make or make install.
>>
>> It exits with error 1, giving me the message as follows
>>
>> {standard input}: Assembler messages:
>> {standard input}:47: Error: invalid swi expression
>> {standard input}:47: Error: value of 10420290 too large
>>
>> xxxxx
>>
>> Then return with Error 1. I am using Ubuntu/Linaro gcc compiler for ARM
>> gcc 4.5.2 and I will be glad if anyone can share experience to fix this
>> issue.
>> Cheers!
>
> You are probably compiling for the thumb or thumb2 instruction set. We
> do not support thumb. Compile for ARM. You should also enable EABI.
>
> --
> 					    Gilles.
>

