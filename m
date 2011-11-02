MIME-Version: 1.0
In-Reply-To: <CAAeYjMk6hguN557FBgFMwi2VnVgpBT6dy8Nyhf_OD0q38OHarA@mail.gmail.com>
References: <CAAeYjMko1nqaFX4xvL_j9GoS_wT5SxOFtCjfLgN8T=CGrL2Cvw@domain.hid>
	<CAAeYjMkVuQLzq-B+Nh1xOXFSHR4K74cwGGCVsZoJaT3GP2mHFA@mail.gmail.com>
	<4EB16266.5090704@domain.hid> <4EB163C5.9000302@domain.hid>
	<CAAeYjMk6hguN557FBgFMwi2VnVgpBT6dy8Nyhf_OD0q38OHarA@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Date: Thu, 3 Nov 2011 00:24:09 +0100
Message-ID: <CAAeYjM=gbnctwNXzxhZd8+wGHMtwRh4RUNOMFuriZaXp1wzKFA@mail.gmail.com>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Nov 3, 2011 at 00:15, =C5=81ukasz Sacha <dragilla@domain.hid> wrote:
> On Wed, Nov 2, 2011 at 16:37, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 11/02/2011 04:31 PM, Gilles Chanteperdrix wrote:
>>> On 11/01/2011 01:42 PM, =C5=81ukasz Sacha wrote:
>>>> On Tue, Nov 1, 2011 at 12:34, =C5=81ukasz Sacha <dragilla@domain.hid> w=
rote:
>>>>> Hello again:
>>>>>
>>>>> luke@domain.hid$ make ARCH=3Darm
>>>>> CROSS_COMPILE=3Darm-none-linux-gnueabi-
>>>>> ...
>>>>> =C2=A0CC =C2=A0 =C2=A0 =C2=A0arch/arm/kernel/fiq.o
>>>>> arch/arm/kernel/fiq.c: In function 'set_fiq_handler':
>>>>> arch/arm/kernel/fiq.c:87: error: dereferencing pointer to incomplete =
type
>>>>> arch/arm/kernel/fiq.c:87: error: dereferencing pointer to incomplete =
type
>>>>> arch/arm/kernel/fiq.c:89: error: dereferencing pointer to incomplete =
type
>>>>> arch/arm/kernel/fiq.c:89: error: dereferencing pointer to incomplete =
type
>>>>> make[1]: *** [arch/arm/kernel/fiq.o] Error 1
>>>>> make: *** [arch/arm/kernel] Error 2
>>>>> luke@domain.hid$
>>>>>
>>>>> This is how it looks like
>>>>> 80:void set_fiq_handler(void *start, unsigned int length)
>>>>> 81:{
>>>>> 82:#if defined(CONFIG_CPU_USE_DOMAINS)
>>>>> 83: =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((void *)0xffff001c, start, leng=
th);
>>>>> 84:#else
>>>>> 85: =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(vectors_page + 0x1c, start, len=
gth);
>>>>> 86:#endif
>>>>> 87: =C2=A0 =C2=A0 =C2=A0 =C2=A0flush_icache_range(0xffff001c, 0xffff0=
01c + length);
>>>>> 88: =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vectors_high())
>>>>> 89: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flush_icac=
he_range(0x1c, 0x1c + length);
>>>>> 90:}
>>>>>
>>>>> Any ideas?
>>>>
>>>> Please take a look at this as this is piece of code the adeos i-pipe
>>>> patch (./ksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.18-03.patch)
>>>> modifies : in line 819.
>>>
>>> Indeed, we need the definition of struct task_struct in
>>> asm/cacheflush.h, the following patch should help:
>>> http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommitdiff;h=3Dca2793e18d=
538d07a648583c47d40fff405c4778;hp=3De68e48bebdc551a534ecd6fdbd839eb9ee2637f=
7
>>>
>>> A new patch will be out soon.

I get two section mismatches compiling the kernel.
--- cut here ---

WARNING: arch/arm/mach-s3c2440/built-in.o(.text+0x8e0): Section
mismatch in reference from the function
mini2440_parse_features.clone.0() to the (unknown reference)
.init.data:(unknown)
The function mini2440_parse_features.clone.0() references
the (unknown reference) __initdata (unknown).
This is often because mini2440_parse_features.clone.0 lacks a __initdata
annotation or the annotation of (unknown) is wrong.

WARNING: arch/arm/mach-s3c2440/built-in.o(.data+0x184): Section
mismatch in reference from the variable s3c2440_dma_driver to the
function .init.text:s3c2440_dma_add()
The variable s3c2440_dma_driver references
the function __init s3c2440_dma_add()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
--- cut here ---

Is this something to worry about?

regards,
--=20
LS

