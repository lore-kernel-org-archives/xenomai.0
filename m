Message-ID: <44B52214.7050009@domain.hid>
Date: Wed, 12 Jul 2006 18:23:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] handling threads within a pod
References: <44B51D2C.10508@domain.hid>
In-Reply-To: <44B51D2C.10508@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig540DC2349CDAAFB197D24C8C"
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
To: Khalil GHORBAL <kg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig540DC2349CDAAFB197D24C8C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Khalil GHORBAL wrote:
> Hi,
>=20
> I'm trying to implement a new skin (IMA380) using xenomai framework.

Cool. Just learned that IMA380 is similar to ARNIC 653. Sounds quite
interesting. Will there be real partitioning? Will we get the chance to
see/use the result some day?

>=20
> When creating multiple xnthreads within a pod,
> I didn't found a way to access or handle these threads.
> Threads are linked to the global queue of a pod but how can I access to=

> the other fields of xnthread structure ?
>=20
> hope it was clear :)

Not really. Do you mean how to handle references to those threads, how
to pass them to the user and accept them back? Or do you mean how to
manipulate fields of the xnthread structure directly. The latter is
risky as you bypass the nucleus interface. Better check if some service
of the nucleus layer provide the required access. If not, elaborate what
kind of access you need.

Jan


--------------enig540DC2349CDAAFB197D24C8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEtSIUniDOoMHTA+kRArPOAJ9PKUnX8x1OyyqbdDFAWkFU15NJAwCeJXf9
V73ptfGhC/liJEs7tc4yqi8=
=BwTG
-----END PGP SIGNATURE-----

--------------enig540DC2349CDAAFB197D24C8C--

