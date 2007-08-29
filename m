Message-ID: <46D531A4.4020108@domain.hid>
Date: Wed, 29 Aug 2007 10:43:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <715959.48066.qm@domain.hid>
In-Reply-To: <715959.48066.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3E16C485955F443724FFB915"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] sqrt() function in xenomai kernel module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E16C485955F443724FFB915
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Mathieu JOINIE-MAURIN wrote:
> Hi,
>=20
> I need to use a sqrt() function in a kernel module code. I am a beginne=
r with Xenomai. Is there any math_module which already exists ?

Counter question: Why do you need to use math in kernel code? It is
generally a sign something is not well split-up between kernel-based
driver code and user-space RT applications.

To answer your question: No, Xenomai does not come with a kernel math
lib because there is not much use for it - generally. Porting the app to
user-space is recommended.

Jan


--------------enig3E16C485955F443724FFB915
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1TGkniDOoMHTA+kRAqXlAJ4yn9JagMLomqfNGeqxZ+jc656sAACeI4Fr
7WODa7ky0CMg8YflFxe+S4c=
=qdQU
-----END PGP SIGNATURE-----

--------------enig3E16C485955F443724FFB915--

