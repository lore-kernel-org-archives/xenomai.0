MIME-Version: 1.0
In-Reply-To: <4BF190D7.9060804@domain.hid>
References: <AANLkTil1N6ULXXuv4nx5n_amHqE61tZNuSaw6ndLPdPL@mail.gmail.com>
	<4BF18A00.706@domain.hid>
	<AANLkTinkr4vDIHFMJigC7i9dCXjoG2d_gNG11txXrjpd@domain.hid>
	<4BF190D7.9060804@domain.hid>
Date: Mon, 17 May 2010 11:56:43 -0700
Message-ID: <AANLkTika8p5ipR1KERlFSh0ZFXEhN0PZSatM-qC-PDNC@mail.gmail.com>
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

On Mon, May 17, 2010 at 11:54 AM, Gilles Chanteperdrix
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
> Compile with -O2 please

        .syntax unified
        .arch armv7-a
        .eabi_attribute 27, 3
        .fpu vfpv3-d16
        .eabi_attribute 20, 1
        .eabi_attribute 21, 1
        .eabi_attribute 23, 3
        .eabi_attribute 24, 1
        .eabi_attribute 25, 1
        .eabi_attribute 26, 2
        .eabi_attribute 30, 6
        .eabi_attribute 18, 4
        .thumb
        .file   "foo.c"
        .text
        .align  2
        .global foo
        .thumb
        .thumb_func
        .type   foo, %function
foo:
        @ args =3D 0, pretend =3D 0, frame =3D 8
        @ frame_needed =3D 1, uses_anonymous_args =3D 0
        @ link register save eliminated.
        push    {r7}
        sub     sp, sp, #12
        add     r7, sp, #0
        strd    r0, [r7]
        ldrd    r0, [r7]
        negs    r2, r0
        sbc     r3, r1, r1, lsl #1
        mov     r0, r2
        mov     r1, r3
        add     r7, r7, #12
        mov     sp, r7
        pop     {r7}
        bx      lr
        .size   foo, .-foo
        .ident  "GCC: (Ubuntu 4.4.3-4ubuntu5) 4.4.3"
        .section        .note.GNU-stack,"",%progbits

