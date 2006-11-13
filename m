Message-ID: <45587B6B.6090006@domain.hid>
Date: Mon, 13 Nov 2006 15:04:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] waiting in rtdm drivers
References: <111320061400.15794.45587A600000DBC400003DB222070229339C0E0301089BD2040A969B0799@domain.hid>
In-Reply-To: <111320061400.15794.45587A600000DBC400003DB222070229339C0E0301089BD2040A969B0799@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig09A931CD0EFF41A9974AF030"
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
To: witzel.thomas@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig09A931CD0EFF41A9974AF030
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

witzel.thomas@domain.hid wrote:
> Hello all,
>=20
> I'm making slow progress with the sound driver. One question has been b=
othering me. How do I wait properly in a rtdm driver routine, i.e. I need=
 to wait a few microseconds for a register to "settle" or for the codecs =
to come back from reset. This would be required in both routines that can=
 be called from realtime as well as non-realtime tasks.

That's a typical job for rtdm_task_busy_sleep():

Jan


--------------enig09A931CD0EFF41A9974AF030
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFWHtrniDOoMHTA+kRAmhTAJ4mMFAtu7Xc786LZnwlRoimtHr8ggCbBPjL
va4MRfjCN4CEjYrCZAQl2g8=
=16HQ
-----END PGP SIGNATURE-----

--------------enig09A931CD0EFF41A9974AF030--

