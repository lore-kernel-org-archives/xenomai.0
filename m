Message-ID: <435E2D1B.5040606@domain.hid>
Date: Tue, 25 Oct 2005 15:03:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Usage of sim with xenomai-2.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E00E6CDF@EINT11.einet.ad.eivd.ch>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E00E6CDF@EINT11.einet.ad.eivd.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> Hi xeno-workers,
>=20
> =20
>=20
> I'm trying to compile the simulator of xenomai-2.0 within a kernel 2.6.=
9=20
> but I get
>=20
> the following error when gcc-2.95.3 is being compiled:=20
> "/usr/include/bits/stdio-lock.h:24: lowlevellock.h: No such file or=20
> directory"
>=20
> (I presume that this include is not supported anymore by my current lib=
c)
>=20
> =20
>=20
> I'm pretty sure that it is not a new issue - Sorry about this - I=20
> probably missed the workaround.
>=20

This one is new actually. Could you send more information about your envi=
ronment=20
(glibc version, distro, compiler version) and the fragment of the output =
log=20
containing the error message? TIA,

> Please, would you be so kind as to help me?
>=20
> =20
>=20
> Thanks in advance
>=20
> =20
>=20
> Cheers
>=20
> Daniel
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> Dr. Daniel Rossier, Professeur
>=20
> REDS, Reconfigurable & Embedded Digital Systems, http://reds.eivd.ch/
>=20
> HES-SO
>=20
> Haute Ecole d'Ing=E9nieurs et de Gestion (HEIG-VD)
>=20
> Rte de Cheseaux 1
>=20
> =20
>=20
> CH-1774 Yverdon-les-Bains
>=20
> =20
>=20
> T=E9l. fixe:     +41 24 557 62 69
>=20
> T=E9l. mobile:   +41 79 292 54 58
>=20
> E-mail:        daniel.rossier@domain.hid <mailto:daniel.rossier@domain.hid=
.ch>
>=20
> =20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20

Philippe.

