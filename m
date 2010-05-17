MIME-Version: 1.0
In-Reply-To: <4BF192A6.6080508@domain.hid>
References: <AANLkTil1N6ULXXuv4nx5n_amHqE61tZNuSaw6ndLPdPL@mail.gmail.com>
	<4BF18A00.706@domain.hid>
	<AANLkTinkr4vDIHFMJigC7i9dCXjoG2d_gNG11txXrjpd@domain.hid>
	<4BF192A6.6080508@domain.hid>
Date: Mon, 17 May 2010 13:50:57 -0700
Message-ID: <AANLkTikwsGEOg6tDNA-ZiaX9P362egUat7lVthR1gzIU@mail.gmail.com>
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

Ah, success --- based on your note, a colleague of mine determined
that arranging to pass gcc the (undocumented) "-marm" flag enables the
compiler to build the unpatched Xenomai 2.5.3 sources from beginning
to end.  For posterity, I recompiled your example code with -O2 -marm,
and appended it below.

Thank you for all of your help!

Jeremy

        .arch armv7-a
        .eabi_attribute 27, 3
        .fpu vfpv3-d16
        .eabi_attribute 20, 1
        .eabi_attribute 21, 1
        .eabi_attribute 23, 3
        .eabi_attribute 24, 1
        .eabi_attribute 25, 1
        .eabi_attribute 26, 2
        .eabi_attribute 30, 2
        .eabi_attribute 18, 4
        .file   "foo.c"
        .text
        .align  2
        .global foo
        .type   foo, %function
foo:
        @ args =3D 0, pretend =3D 0, frame =3D 0
        @ frame_needed =3D 0, uses_anonymous_args =3D 0
        @ link register save eliminated.
        rsbs    r2, r0, #0
        rsc     r3, r1, #0
        mov     r1, r3
        mov     r0, r2
        bx      lr
        .size   foo, .-foo
        .ident  "GCC: (Ubuntu 4.4.3-4ubuntu5) 4.4.3"
        .section        .note.GNU-stack,"",%progbits

