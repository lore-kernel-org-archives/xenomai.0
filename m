Message-ID: <46973753.6010206@domain.hid>
Date: Fri, 13 Jul 2007 10:26:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4694ED98.6000000@domain.hid>
	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	<1982070.1184078400928.JavaMail.ngmail@domain.hid>	<4693A702.1010604@domain.hid>
	<913919.1184311634860.JavaMail.ngmail@domain.hid>
In-Reply-To: <913919.1184311634860.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7581B8EFE69D548FEE0FA1FA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Sporadic PC freeze after rt_task_start
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7581B8EFE69D548FEE0FA1FA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> I did another test to identify the freeze. I have plugged in a POST-COD=
E 80 PCI board into the PC
> and instrumented the code to write to port 80 to find out where the fre=
eze actually happens.
> It seems not to return for rt_task_start as the last written POST code =
(see source code below)  is 0x30.
> I hope to find a time slot to modify the kernel to do another test.

Again: Please consider NMI watchdog and nucleus debugging support for
those tests as well. Maybe (I dare to say: likely on SMP) they catch
where the CPUs hang around instead of doing their work.

> The bad thing is that it takes really long to get the freeze (up to a c=
ouple of hours).

Your effort is appreciated even more!

Jan


--------------enig7581B8EFE69D548FEE0FA1FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGlzdTniDOoMHTA+kRAl6GAJ91ifZKPzcnK29TJMnnh6VKN/OLJgCfZSw3
S/7t0Yv69baO/mrKKnukN/8=
=UMpT
-----END PGP SIGNATURE-----

--------------enig7581B8EFE69D548FEE0FA1FA--

