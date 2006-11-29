Message-ID: <456D6164.4090400@domain.hid>
Date: Wed, 29 Nov 2006 11:31:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [RFC][PATCH 2/2] global CPU affinity control
References: <456C3EFB.7030303@domain.hid> <456C887D.9040008@domain.hid>
	<456C983E.70408@domain.hid> <456D5EE7.80507@domain.hid>
In-Reply-To: <456D5EE7.80507@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4286849EBFFF8C6BE813DE03"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4286849EBFFF8C6BE813DE03
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Nope, that's intentional (forgot to repeat this fact, was explained
>> earlier): Users can always override nkaffinity by their own mask. Only=

>> the "I-don't-care" XNPOD_ALL_CPUS activates this new selection mechani=
sm.
>=20
> Ok. But there is still something wrong: if the affinity is empty, it
> will remain empty whereas it was replaced by XNARCH_CPU_MASK_ALL in the=

> current version.
>=20

The policy is that no skin should invoke xnshadow_map or
xnpod_start_thread with an empty mask anymore. So far only the native
skin made use of this, and that is changed by the patch.



--------------enig4286849EBFFF8C6BE813DE03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbWFkniDOoMHTA+kRAs9bAJ4gYGad0AYyZcwI5GHoA5mZ/11vGgCfYQXT
iT0CIh667dZZotkShwhUTu4=
=b5ah
-----END PGP SIGNATURE-----

--------------enig4286849EBFFF8C6BE813DE03--

