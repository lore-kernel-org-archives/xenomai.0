From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmail.com>
References: <AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmail.com>
Date: Mon, 20 Dec 2010 16:40:41 +0100
Message-Id: <20101220154041.48C75CDE29A@gemini.denx.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai on Freescale iMX35
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marten Lootsma <m.lootsma@domain.hid>
Cc: xenomai@xenomai.org

Dear Marten Lootsma,

In message <AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmail.com>=
 you wrote:
>
> We have a platform with a Freescale iMX35 processor and we would like t=
o use
> Xenomai. We have kernel versions 2.6.28 and 2.6.31 running (customized =
with
> Freescale and our own patches for hardware support). I read that suppor=
t is
> included for the iMX31 and 51 which are closely related. In the trac I =
saw
> some iMX35 related commits as well.
>=20
> 1. What is the status of the support for iMX35?

Normally there is not support at all available for the LTIB kernels
provided by Freescale.  Xenomai focusses on support for the mainline
kernel tree.

> 2. And if needed what is a good starting point for implementing/contrib=
uting
> the port to iMX35?

In the first step, support for the i.MX35 needs to be added for
mainline Linux, and pushed upstream.

[Please feel free to contact me if you need help doing this.]

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
"A fractal is by definition a set for which the Hausdorff Besicovitch
dimension strictly exceeds the topological dimension."
- Mandelbrot, _The Fractal Geometry of Nature_

