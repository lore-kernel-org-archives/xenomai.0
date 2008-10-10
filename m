Message-ID: <8227750.1223626784795.JavaMail.ngmail@domain.hid>
Date: Fri, 10 Oct 2008 10:19:44 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <3298865.1223620599925.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <3298865.1223620599925.JavaMail.ngmail@domain.hid>
	<48EE2BF6.60300@domain.hid>
	<15875130.1223557641586.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Bug with Xenomai and xeno_heap: Eeek!
 page_mapcount(page) went negative!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Hello Gilles,

I tried a couple of Xenomai/Kernel combinations.
The result is the following:

Xeno 2.4.4 and kernel 2.6.25: ok=20
Xeno 2.4.5 and kernel 2.6.25: ok=20
Xeno 2.4.5 and kernel 2.6.26: crash
(In all tests, I used the adeos patch that was part of the release Xenomai =
version).

Thus, some rmap code in kernel 2.6.26 seems to be different than with 2.6.2=
5.

I hope that helps to find out what is wrong...

Best regards

Mathias


> I attach the full dmesg dump from booting up to the crash of the system.=
=20
> Bootparameters are=20
> root=3D/dev/sda5 vga=3Dext quiet isolcpus=3D1-7
> Also, I attach the linux .config file.
>=20
> Of course I can try with other Xenomai/Kernel version if it helps...
>=20
> Thanks a lot
>=20
> Regards
>=20
> Mathias
>=20
>=20
> > Ok. Could you send us more details, such as the full boot logs and your
> > kernel configuration ?
> >=20
> > On your side, is it possible for you to do a bisection with Xenomai
> > versions ?
> >=20
>=20
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Jetzt komfortabel bei Arcor-Digital TV einsteigen: Mehr Happy Ends, mehr He=
rzschmerz, mehr Fernsehen! Erleben Sie 50 digitale TV Programme und optiona=
l 60 Pay TV Sender, einen elektronischen Programmf=FChrer mit Movie Star Be=
wertungen von TV Movie. Au=DFerdem, aktuelle Filmhits und spannende Dokus i=
n der Arcor-Videothek. Infos unter www.arcor.de/tv

