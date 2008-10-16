Message-ID: <48F7C5D1.3010500@domain.hid>
Date: Fri, 17 Oct 2008 00:53:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.644116499@domain.hid>
	<48F7A064.20404@domain.hid>
In-Reply-To: <48F7A064.20404@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig45AEB6426887A06792809819"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 08/12] Use fast xnsynch with native skin
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig45AEB6426887A06792809819
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>=20
> Same remark for the #ifdefs.

Yes, but most cases (maybe except for owner checking) are unavoidable
due to heavy differences. I hope that we may have only FASTXNSYCH archs
one day.

> I also do not understand your modification
> of rt_cond_wait_inner, this code is very tense; posix and native had th=
e
> same bug in this area at different times, so this change should probabl=
y
> be made separately.

Which modification precisely (damn, I need to find out what makes quilt
cause this attachment confusion)? Note that lockcnt tracking changed
with this patch: the lock owner himself is in charge of maintaining it,
not some thread handing the lock over.

That said, I would happily analyse the case that broke before. I will
also check if I can break out the lockcnt maintenance change, but I
think to recall that it was coupled to the fast path changes.

Jan


--------------enig45AEB6426887A06792809819
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj3xdMACgkQniDOoMHTA+mAawCfbQ2RnWpVsMw8SGI4OBhGfKm3
hysAn3x06PmLBdbF5ptkus4UTKCL7KD2
=pW5Z
-----END PGP SIGNATURE-----

--------------enig45AEB6426887A06792809819--

