From: "Ivan Kalatchev" <ivan.kalatchev@domain.hid>
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>
	<4B4BADDD.7070900@domain.hid>
	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>
	<4B4C84AC.3020207@domain.hid>
In-Reply-To: <4B4C84AC.3020207@domain.hid>
Date: Tue, 12 Jan 2010 10:12:03 -0500
Message-ID: <002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-ca
Subject: Re: [Xenomai-help] Viper board (ARM XScale) problems with
	Xenomai-2.4.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: 'Xenomai help' <xenomai@xenomai.org>

 Gilles,

> It comes from a macro written in assembly in include/asm-arm/arith.h.
> However, this code compiles fine here for armv5. You are probably =
using
> a toolchain that is incompatible with this assembly code. What version
> of binutils are you using? If that is not hard to you, please upgrade
> to
> a more recent toolchain. Otherwise, we will try to get your assembly =
to
> accept this code (but looking at the error messages, it looks
> hopeless).

I'm using original toolchain that came with development for Viper board =
from Arcom. That probably was time of 2.4 kernels...
Trouble with upgrading of toolchain I'm afraid of - is that all =
packages, libraries etc., that I used thus far with our embedded =
application will become obsolete and will need to be recompiled with =
this new compiler.

As to my first problem with assigning of general interrupt handler to =
chained irq acknowledgment, I'll try to change my code to go with it, as =
my real-time handler for chained interrupt does actually call some =
'acknowledgment' that is based on general interrupt handler. It's just =
it took quite a time to figure out weird behaviour of my application =
when=20
I switched to new Xenomai and couldn't find any info about how Xenomai =
changes chained interrupts handling. That caused some frustration. May =
be there should be some sort of Howto about it on Xenomai site?

Thanks a lot for you help.

Best regards,

Ivan



