Message-ID: <444395B1.9050603@domain.hid>
Date: Mon, 17 Apr 2006 15:18:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Getting calling task id inside RTDM driver
References: <443FB205.6010400@domain.hid>	<200604142155.12772.Sebastian.Smolorz@domain.hid>
	<4443899A.4010004@domain.hid>
In-Reply-To: <4443899A.4010004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7EAFE2023DD50974A9C6F996"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7EAFE2023DD50974A9C6F996
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sean McGranaghan wrote:
> After posting I performed a two tests, first using an RTDM event and th=
en using=20
> a semaphore as described below. The synchronization worked in both case=
s, but I=20
> think I have another problem. On exit my test application generates a=20
> segmentation fault, but only occasionally. I do not get a stack dump in=
 the=20
> kernel log and the system does not seem to become unstable. I tried run=
ning my=20
> test application under strace and gdb. In both cases I could not reprod=
uce the=20
> error. I am installing the latest version of Xenomai and adding debuggi=
ng=20
> options to the build. I will post when I know more.

mlockall? That's a typical thing to forget in your application (also
happens to me from time to time...), and it may or may not hit you with
a segfault one day.

>=20
> Any suggestions on which Xenomai and kernel options to set for debuggin=
g?

The SVN contains some nice new debugging features for RTDM: catch
illegal contexts of rtdm_xxx-services and detect forgotten spinlocks
(via IRQs-on check) on return to the user. The latter already helped to
discover a bug in the xeno_16550A driver.

Moreover, if you are working on x86, the recent work on the kgdb
integration may be interesting as well. See related threads on the list.

Jan


--------------enig7EAFE2023DD50974A9C6F996
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQ5W1niDOoMHTA+kRAuNLAJ9Z1bDZXAS4YF/F28VlKEa6nZ83bwCeNGOQ
K/fYajVZvimj3f02YDMY2BU=
=Gi8Q
-----END PGP SIGNATURE-----

--------------enig7EAFE2023DD50974A9C6F996--

