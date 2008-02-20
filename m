Message-ID: <32609074.1203511813520.JavaMail.ngmail@domain.hid>
Date: Wed, 20 Feb 2008 13:50:13 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD3816B@rennsmail04.eu.thmulti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <0B45E93C5FF65740AEAE690BF3848B7AD3816B@rennsmail04.eu.thmulti.com>
Subject: Re: [Xenomai-help] Atomic 64 bit write access on PCIe device
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: stephane.fillod@domain.hid, mathias_koehrer@domain.hid, xenomai@xenomai.org

Hi Stephane,

thanks for your mail.
>=20
> I'm no expert, but did you tried already using FP instructions, which is
> a common
> trick to make use of 64 bits I/O in code optimization (before SIMD era).
>=20
> How about the following:
>=20
> void do_write64(void *p, unsigned long long x)
> {
>         volatile union {
>                 unsigned long long ull;
>                 double d;
>         } u;
>=20
>         u.ull =3D x;
>         *(volatile double *)p =3D u.d;
> }
>=20
> Disassemble that code, you should see some fldl and fstpl.

First I thought of using the FPU for this issue.
Hoever, I am not sure if it is allowed to use the FPU here as I think there=
 are some 64 bit integer values
that will be modified by fldl (e.g. if they represent some kind of NaN).
According to Intel's instruction set reference for fld:

"Pushes the source operand onto the FPU register stack. The source operand =
can be in
single-precision, double-precision, or double extended-precision floating-p=
oint
format. If the source operand is in single-precision or double-precision fl=
oating-point
format, it is automatically converted to the double extended-precision floa=
ting-point
format before being pushed on the stack."

In my case I have a double precision which will be converted to the double =
extended-precision
format.
Thus, I can imagine that there are some 64 bit long longs that will not be =
handled correctly.


Regards

Mathias


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT F=DCR ALLE NEUEINSTEIGER
Jetzt bei Arcor: g=FCnstig und schnell mit DSL - das All-Inclusive-Paket
f=FCr clevere Doppel-Sparer, nur  29,95 Euro  inkl. DSL- und ISDN-Grundgeb=
=FChr!
http://www.arcor.de/rd/emf-dsl-2

