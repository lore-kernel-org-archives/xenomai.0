From: "Ivan Kalatchev" <ivan.kalatchev@domain.hid>
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>	<4B4BADDD.7070900@domain.hid>	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>	<4B4C84AC.3020207@domain.hid>
	<002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>
	<4B4C96D5.7060902@domain.hid>
In-Reply-To: <4B4C96D5.7060902@domain.hid>
Date: Tue, 12 Jan 2010 11:09:36 -0500
Message-ID: <002101ca93a1$a39d4050$ead7c0f0$@kalatchev@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-ca
Subject: Re: [Xenomai-help] Viper board (ARM XScale) problems
	with	Xenomai-2.4.10
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


> Ok, what version of gcc/binutils ? You can workaround this build =
issue,
> by using the generic implementation of xnarch_nodiv_llimd. In
> incldude/asm-arm/arith.h, replace
>=20
> #if __LINUX_ARM_ARCH >=3D 4
> with
> #if __LINUX_ARM_ARCH >=3D 4 && __GNUC__ >=3D 4
>=20


my gcc is 3.3.4

I changed arith.h as you suggested, and it compiled, but then linker =
couldn't find rthal_arm_nodiv_ullimd definition, as
there is no  code for it for __GNUC__ < 4.


> Please try what I told you: replacing handle_irq with
> __ipipe_handle_irq

I need CPLD MUX interrupts (which are ISA interrupts in my case) to be =
real-time. How that should be done then - request real-time CPLD =
interrupt with empty handler and request each ISA interrupt as real-time =
handler as well?

Regard,

Ivan


