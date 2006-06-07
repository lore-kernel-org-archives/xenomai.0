Message-ID: <44869F86.4090106@domain.hid>
Date: Wed, 07 Jun 2006 11:42:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai: binding failed: Operation not permitted.
References: 446C264A.7040206@domain.hid>	<200605181426.8240@domain.hid>	<446C6C1C.2010902@domain.hid>	<200605190943.31667@domain.hid>	<446D7DE6.10402@domain.hid>
	<44859D3F.50800@domain.hid> <44858228.40508@domain.hid>
	<448696E8.10405@domain.hid>
In-Reply-To: <448696E8.10405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig70A18F6E4902E63F961FC82D"
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
To: "s.a." <sancelot@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig70A18F6E4902E63F961FC82D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

s.a. wrote:
> Hi,
>=20
> In my mind , one or more rt process manages everything critical, need
> root access for resources reasons , other processes are things like gui=

> to interact with realtime world, including  X11 applications (I know , =
I
> will hurt some people, but this is the truth : X11 !) .....
>=20

My point is: what do you gain by separating the RT core from the logging
or gui application? Not much as long as the interface is not robust.
This means that your uncritical part must not be able to interfere with
the critical one, e.g. by acquiring some common lock or messing up a
shared memory which is used blindly by the RT code. If your application
design can guarantee this, ok.

But then note that Xenomai heaps are unsuited for being shared with not
fully trusted parties: management structures reside next to the data,
write permission is always acquired (and is required for
allocation/release operations), access control beyond go/no-go is not
supported. Better use "standard" (Linux) shared memory for this: Invoke
shm_open("myshm", ...), adapt the access rights of the newly created
/dev/shm/myshm, and let the unprivileged process attach to it.

Jan


--------------enig70A18F6E4902E63F961FC82D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEhp+GniDOoMHTA+kRAg7RAJ9RNQ1bCB57V1Ugpc+VhVOa/H8mLwCfdVz8
FFDBHOHitTC2P9nkNGOtxt0=
=8vw2
-----END PGP SIGNATURE-----

--------------enig70A18F6E4902E63F961FC82D--

