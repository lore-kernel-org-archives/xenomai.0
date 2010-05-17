MIME-Version: 1.0
In-Reply-To: <4BF192A6.6080508@domain.hid>
References: <AANLkTil1N6ULXXuv4nx5n_amHqE61tZNuSaw6ndLPdPL@mail.gmail.com>
	<4BF18A00.706@domain.hid>
	<AANLkTinkr4vDIHFMJigC7i9dCXjoG2d_gNG11txXrjpd@domain.hid>
	<4BF192A6.6080508@domain.hid>
Date: Mon, 17 May 2010 12:25:04 -0700
Message-ID: <AANLkTilkPw0u4JZ5XzNrTUzOhe3nPxqaLXqiMrzqZuzp@domain.hid>
From: Jeremy Brown <jhbrown@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Error building userspace: "selected processor
	does not support `rsc r7, r7, #0'
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
Cc: xenomai-help <xenomai@xenomai.org>

On Mon, May 17, 2010 at 12:01 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Jeremy Brown wrote:
>> On Mon, May 17, 2010 at 11:25 AM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Jeremy Brown wrote:
>>>> {standard input}: Assembler messages:
>>>> {standard input}:140: Error: selected processor does not support `rsc
>>>> r7,r7,#0'
>>>> {standard input}:159: Error: selected processor does not support `rsc
>>>> r1,r1,#0'
>>>> make: *** [libxenomai_la-timeconv.lo] Error 1
>>> Ok. Could you try and compile the following piece of code with your
>>> toolchain and show me the disassembly ?
>>>
>>> long long foo(long long x)
>>> {
>>> =A0 =A0 =A0 =A0return -x;
>>> }
>>>
>>> --
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0Gilles.
>>
>> Thanks for the quick reply! =A0Here's the complete contents of foo.s:
>>
>> =A0 =A0 =A0 =A0 .syntax unified
>
> That is the key: I presume this means your compiler generates syntax
> which works both with ARM and thumb2, and rsc does not exist with
> thumb2. Note that from a performance point of view, this may not be a win=
.
>
> So be it. Try the following patch:

Thank you.  That solved this particular problem.   (Something in
cond.c is now causing a gcc internal compiler error, so I think this
toolchain is generally suspect, but that's not even vaguely a Xenomai
problem now.)

Jeremy

> diff --git a/include/asm-arm/arith.h b/include/asm-arm/arith.h
> index e86975c..72c0ab7 100644
> --- a/include/asm-arm/arith.h
> +++ b/include/asm-arm/arith.h
> @@ -103,13 +103,13 @@ rthal_arm_nodiv_llimd(const long long op,
> =A0 =A0 =A0 =A0__asm__ ("movs %[s], %[oph], lsr #30\n\t"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "beq 1f\n\t"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "rsbs =A0%[opl], %[opl], #0\n\t"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rsc =A0%[oph], %[oph], #0\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"sbc =A0%[oph], %[oph], %[oph], lsl #1\n=
"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "1:\t"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rthal_arm_nodiv_ullimd_str
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "teq %[s], #0\n\t"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "beq 2f\n\t"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "rsbs =A0%[rm], %[rm], #0\n\t"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rsc =A0%[rh], %[rh], #0\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"sbc =A0%[rh], %[rh], %[rh], lsl #1\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "2:\t"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [rl]"=3Dr"(rl), [rm]"=3Dr"(rm), [rh]"=
=3Dr"(rh),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [tl]"=3Dr"(tl), [th]"=3Dr"(th), [s]"=
=3Dr"(s)

