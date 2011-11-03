Message-ID: <4EB29A97.4000009@domain.hid>
Date: Thu, 03 Nov 2011 14:43:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAeYjMko1nqaFX4xvL_j9GoS_wT5SxOFtCjfLgN8T=CGrL2Cvw@domain.hid>
	<CAAeYjMkVuQLzq-B+Nh1xOXFSHR4K74cwGGCVsZoJaT3GP2mHFA@mail.gmail.com>
	<4EB16266.5090704@domain.hid> <4EB163C5.9000302@domain.hid>
	<CAAeYjMk6hguN557FBgFMwi2VnVgpBT6dy8Nyhf_OD0q38OHarA@mail.gmail.com>
	<CAAeYjM=gbnctwNXzxhZd8+wGHMtwRh4RUNOMFuriZaXp1wzKFA@mail.gmail.com>
	<CAAeYjMnjo8dsARF887bZT4sz9R5Ye6kz9uf2C9ydwkGLOcLKXg@domain.hid>
In-Reply-To: <CAAeYjMnjo8dsARF887bZT4sz9R5Ye6kz9uf2C9ydwkGLOcLKXg@domain.hid>
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

On 11/03/2011 12:31 AM, =C5=81ukasz Sacha wrote:
> On Thu, Nov 3, 2011 at 00:24, =C5=81ukasz Sacha <dragilla@domain.hid> wr=
ote:
>> On Thu, Nov 3, 2011 at 00:15, =C5=81ukasz Sacha <dragilla@domain.hid> w=
rote:
>>> On Wed, Nov 2, 2011 at 16:37, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>> On 11/02/2011 04:31 PM, Gilles Chanteperdrix wrote:
>>>>> On 11/01/2011 01:42 PM, =C5=81ukasz Sacha wrote:
>>>>>> On Tue, Nov 1, 2011 at 12:34, =C5=81ukasz Sacha <dragilla@domain.hid=
m> wrote:
>>>>>>> Hello again:
>>>>>>>
>>>>>>> luke@domain.hid$ make ARCH=3D=
arm
>>>>>>> CROSS_COMPILE=3Darm-none-linux-gnueabi-
>>>>>>> ...
>>>>>>>  CC      arch/arm/kernel/fiq.o
>>>>>>> arch/arm/kernel/fiq.c: In function 'set_fiq_handler':
>>>>>>> arch/arm/kernel/fiq.c:87: error: dereferencing pointer to incompl=
ete type
>>>>>>> arch/arm/kernel/fiq.c:87: error: dereferencing pointer to incompl=
ete type
>>>>>>> arch/arm/kernel/fiq.c:89: error: dereferencing pointer to incompl=
ete type
>>>>>>> arch/arm/kernel/fiq.c:89: error: dereferencing pointer to incompl=
ete type
>>>>>>> make[1]: *** [arch/arm/kernel/fiq.o] Error 1
>>>>>>> make: *** [arch/arm/kernel] Error 2
>>>>>>> luke@domain.hid$
>>>>>>>
>>>>>>> This is how it looks like
>>>>>>> 80:void set_fiq_handler(void *start, unsigned int length)
>>>>>>> 81:{
>>>>>>> 82:#if defined(CONFIG_CPU_USE_DOMAINS)
>>>>>>> 83:        memcpy((void *)0xffff001c, start, length);
>>>>>>> 84:#else
>>>>>>> 85:        memcpy(vectors_page + 0x1c, start, length);
>>>>>>> 86:#endif
>>>>>>> 87:        flush_icache_range(0xffff001c, 0xffff001c + length);
>>>>>>> 88:        if (!vectors_high())
>>>>>>> 89:                flush_icache_range(0x1c, 0x1c + length);
>>>>>>> 90:}
>>>>>>>
>>>>>>> Any ideas?
>>>>>>
>>>>>> Please take a look at this as this is piece of code the adeos i-pi=
pe
>>>>>> patch (./ksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.18-03.pa=
tch)
>>>>>> modifies : in line 819.
>>>>>
>>>>> Indeed, we need the definition of struct task_struct in
>>>>> asm/cacheflush.h, the following patch should help:
>>>>> http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommitdiff;h=3Dca2793=
e18d538d07a648583c47d40fff405c4778;hp=3De68e48bebdc551a534ecd6fdbd839eb9e=
e2637f7
>>>>>
>>>>> A new patch will be out soon.
>>
>> I get two section mismatches compiling the kernel.
>> --- cut here ---
>>
>> WARNING: arch/arm/mach-s3c2440/built-in.o(.text+0x8e0): Section
>> mismatch in reference from the function
>> mini2440_parse_features.clone.0() to the (unknown reference)
>> .init.data:(unknown)
>> The function mini2440_parse_features.clone.0() references
>> the (unknown reference) __initdata (unknown).
>> This is often because mini2440_parse_features.clone.0 lacks a __initda=
ta
>> annotation or the annotation of (unknown) is wrong.
>>
>> WARNING: arch/arm/mach-s3c2440/built-in.o(.data+0x184): Section
>> mismatch in reference from the variable s3c2440_dma_driver to the
>> function .init.text:s3c2440_dma_add()
>> The variable s3c2440_dma_driver references
>> the function __init s3c2440_dma_add()
>> If the reference is valid then annotate the
>> variable with __init* or __refdata (see linux/init.h) or name the vari=
able:
>> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>> --- cut here ---
>>
>> Is this something to worry about?
> Actually there's more of this. Let me know if I should paste it here.

These issues have nothing to do with xenomai.

--=20
                                                                Gilles.


