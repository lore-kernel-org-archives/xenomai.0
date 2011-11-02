Message-ID: <4EB163C5.9000302@domain.hid>
Date: Wed, 02 Nov 2011 16:37:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAeYjMko1nqaFX4xvL_j9GoS_wT5SxOFtCjfLgN8T=CGrL2Cvw@domain.hid>	<CAAeYjMkVuQLzq-B+Nh1xOXFSHR4K74cwGGCVsZoJaT3GP2mHFA@mail.gmail.com>
	<4EB16266.5090704@domain.hid>
In-Reply-To: <4EB16266.5090704@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] kernel compilation error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?xYF1a2FzeiBTYWNoYQ==?= <dragilla@domain.hid>
Cc: xenomai@xenomai.org

On 11/02/2011 04:31 PM, Gilles Chanteperdrix wrote:
> On 11/01/2011 01:42 PM, =C5=81ukasz Sacha wrote:
>> On Tue, Nov 1, 2011 at 12:34, =C5=81ukasz Sacha <dragilla@domain.hid> w=
rote:
>>> Hello again:
>>>
>>> luke@domain.hid$ make ARCH=3Darm=

>>> CROSS_COMPILE=3Darm-none-linux-gnueabi-
>>> ...
>>>  CC      arch/arm/kernel/fiq.o
>>> arch/arm/kernel/fiq.c: In function 'set_fiq_handler':
>>> arch/arm/kernel/fiq.c:87: error: dereferencing pointer to incomplete =
type
>>> arch/arm/kernel/fiq.c:87: error: dereferencing pointer to incomplete =
type
>>> arch/arm/kernel/fiq.c:89: error: dereferencing pointer to incomplete =
type
>>> arch/arm/kernel/fiq.c:89: error: dereferencing pointer to incomplete =
type
>>> make[1]: *** [arch/arm/kernel/fiq.o] Error 1
>>> make: *** [arch/arm/kernel] Error 2
>>> luke@domain.hid$
>>>
>>> This is how it looks like
>>> 80:void set_fiq_handler(void *start, unsigned int length)
>>> 81:{
>>> 82:#if defined(CONFIG_CPU_USE_DOMAINS)
>>> 83:        memcpy((void *)0xffff001c, start, length);
>>> 84:#else
>>> 85:        memcpy(vectors_page + 0x1c, start, length);
>>> 86:#endif
>>> 87:        flush_icache_range(0xffff001c, 0xffff001c + length);
>>> 88:        if (!vectors_high())
>>> 89:                flush_icache_range(0x1c, 0x1c + length);
>>> 90:}
>>>
>>> Any ideas?
>>
>> Please take a look at this as this is piece of code the adeos i-pipe
>> patch (./ksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.18-03.patch)=

>> modifies : in line 819.
>=20
> Indeed, we need the definition of struct task_struct in=20
> asm/cacheflush.h, the following patch should help:
> http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommitdiff;h=3Dca2793e18d=
538d07a648583c47d40fff405c4778;hp=3De68e48bebdc551a534ecd6fdbd839eb9ee263=
7f7
>=20
> A new patch will be out soon.
>=20

Your configuration has FCSE disabled, enabling it improves latencies on
s3c processors.

--=20
                                                                Gilles.


