MIME-Version: 1.0
In-Reply-To: <4BF18A00.706@domain.hid>
References: <AANLkTil1N6ULXXuv4nx5n_amHqE61tZNuSaw6ndLPdPL@mail.gmail.com>
	<4BF18A00.706@domain.hid>
Date: Mon, 17 May 2010 11:51:46 -0700
Message-ID: <AANLkTinkr4vDIHFMJigC7i9dCXjoG2d_gNG11txXrjpd@domain.hid>
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

On Mon, May 17, 2010 at 11:25 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Jeremy Brown wrote:
> > {standard input}: Assembler messages:
> > {standard input}:140: Error: selected processor does not support `rsc
> > r7,r7,#0'
> > {standard input}:159: Error: selected processor does not support `rsc
> > r1,r1,#0'
> > make: *** [libxenomai_la-timeconv.lo] Error 1
>
> Ok. Could you try and compile the following piece of code with your
> toolchain and show me the disassembly ?
>
> long long foo(long long x)
> {
> =A0 =A0 =A0 =A0return -x;
> }
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.

Thanks for the quick reply!  Here's the complete contents of foo.s:

=A0=A0 =A0 =A0 =A0.syntax unified
=A0=A0 =A0 =A0 =A0.arch armv7-a
=A0=A0 =A0 =A0 =A0.eabi_attribute 27, 3
=A0=A0 =A0 =A0 =A0.fpu vfpv3-d16
=A0=A0 =A0 =A0 =A0.eabi_attribute 20, 1
=A0=A0 =A0 =A0 =A0.eabi_attribute 21, 1
=A0=A0 =A0 =A0 =A0.eabi_attribute 23, 3
=A0=A0 =A0 =A0 =A0.eabi_attribute 24, 1
=A0=A0 =A0 =A0 =A0.eabi_attribute 25, 1
=A0=A0 =A0 =A0 =A0.eabi_attribute 26, 2
=A0=A0 =A0 =A0 =A0.eabi_attribute 30, 6
=A0=A0 =A0 =A0 =A0.eabi_attribute 18, 4
=A0=A0 =A0 =A0 =A0.thumb
=A0=A0 =A0 =A0 =A0.file =A0 "foo.c"
=A0=A0 =A0 =A0 =A0.text
=A0=A0 =A0 =A0 =A0.align =A02
=A0=A0 =A0 =A0 =A0.global foo
=A0=A0 =A0 =A0 =A0.thumb
=A0=A0 =A0 =A0 =A0.thumb_func
=A0=A0 =A0 =A0 =A0.type =A0 foo, %function
foo:
=A0=A0 =A0 =A0 =A0@ args =3D 0, pretend =3D 0, frame =3D 8
=A0=A0 =A0 =A0 =A0@ frame_needed =3D 1, uses_anonymous_args =3D 0
=A0=A0 =A0 =A0 =A0@ link register save eliminated.
=A0=A0 =A0 =A0 =A0push =A0 =A0{r7}
=A0=A0 =A0 =A0 =A0sub =A0 =A0 sp, sp, #12
=A0=A0 =A0 =A0 =A0add =A0 =A0 r7, sp, #0
=A0=A0 =A0 =A0 =A0strd =A0 =A0r0, [r7]
=A0=A0 =A0 =A0 =A0ldrd =A0 =A0r0, [r7]
=A0=A0 =A0 =A0 =A0negs =A0 =A0r2, r0
=A0=A0 =A0 =A0 =A0sbc =A0 =A0 r3, r1, r1, lsl #1
=A0=A0 =A0 =A0 =A0mov =A0 =A0 r0, r2
=A0=A0 =A0 =A0 =A0mov =A0 =A0 r1, r3
=A0=A0 =A0 =A0 =A0add =A0 =A0 r7, r7, #12
=A0=A0 =A0 =A0 =A0mov =A0 =A0 sp, r7
=A0=A0 =A0 =A0 =A0pop =A0 =A0 {r7}
=A0=A0 =A0 =A0 =A0bx =A0 =A0 =A0lr
=A0=A0 =A0 =A0 =A0.size =A0 foo, .-foo
=A0=A0 =A0 =A0 =A0.ident =A0"GCC: (Ubuntu 4.4.3-4ubuntu5) 4.4.3"
=A0=A0 =A0 =A0 =A0.section =A0 =A0 =A0 =A0.note.GNU-stack,"",%progbits

