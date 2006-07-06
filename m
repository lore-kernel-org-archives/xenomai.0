Message-ID: <44ACB82A.5010503@domain.hid>
Date: Thu, 06 Jul 2006 09:13:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] FPU not available in user-space programs
References: <44AC8482.6000902@domain.hid>
In-Reply-To: <44AC8482.6000902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDA958F916841CA64A1BD2040"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDA958F916841CA64A1BD2040
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi,
>=20
> I was looking at /proc/xenomai/faults and noticed that the only errors
> were on TRAP 7 (FPU not available).
>=20
> Each time I run the user-space program using the native skin, I
> increment the fault by one. I don't understand why this happens. From
> documentation, FPU should be enabled automatically for user-space progr=
ams.
>=20
> Any ideas why I'm getting this error and what does it mean? Should I do=

> some float-point operation before creating my real-time tasks?
>=20

Watch out for the thread "T_FPU without effect" on xenomai-core, I
stumbled over this some time ago as well. It's an initial fault that
happens only on first FPU usage from user-space.

I'm not up-to-date with its current state, i.e. if there are plans to
solve this differently. Maybe Gilles or Philippe can comment on it.

Jan


--------------enigDA958F916841CA64A1BD2040
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErLgqniDOoMHTA+kRAp5oAKCB6ac1VHe7PCf/0WRCWvT9Biok9ACeIHVg
Tx7spKqj4IPKUnNeianFMo0=
=cUrE
-----END PGP SIGNATURE-----

--------------enigDA958F916841CA64A1BD2040--

