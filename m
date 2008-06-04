Message-ID: <48470FC7.9090706@domain.hid>
Date: Wed, 04 Jun 2008 23:57:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <14864600.1212570529651.JavaMail.ngmail@domain.hid>
In-Reply-To: <14864600.1212570529651.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3D87A3F8DBF63402B347A0D9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] RT Application on isolated core
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
--------------enig3D87A3F8DBF63402B347A0D9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi!
>=20
> I am doing some experiments on a Core2Duo CPU and I have some question =
on it.
> My setup is the following:
> I have Xenomai 2.3.3 and kernel 2.6.20.4, SMP enabled.
> I start the kernel with the option isolcpus=3D1 which works as all linu=
x tasks run on
> CPU 0 (i.e. core 0).
> Now, I start a very small Xenomai (native skin) application with on rea=
l time task=20
> on CPU 1 (core 1).=20
> This application realizes an endless loop that does some dummy math ope=
rations=20
> (to burn CPU power...).

Won't work as there is no such thing as perfect CPU isolation with
Linux, at least so far. Please see related discussion and patches on LKML=
=2E

There is currently a thread running regarding the removal of isolcpus -
cpusets are supposed to be used now. But more needs to be done, I'm just
lacking references to the postings (somewhere in February). Google
should help.

Jan


--------------enig3D87A3F8DBF63402B347A0D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIRw/RniDOoMHTA+kRAob+AJ9yPnnSdfVYoK+b7hDBdtfl7FJAxwCfTTa9
4j900ZBsz9OKS/xs2x57Kb8=
=QliL
-----END PGP SIGNATURE-----

--------------enig3D87A3F8DBF63402B347A0D9--

