Message-ID: <44C3B1DB.2040807@domain.hid>
Date: Sun, 23 Jul 2006 19:28:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDB201E23020683AEB3E71BD0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] x86 TSC emulation broken
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDB201E23020683AEB3E71BD0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I happened to switch on some CPU type that enabled the Xenomai's TSC
emulation code. The result was an ugly lock-up: endless loop in the
timer IRQ handler.

The reason: the TSC emulation collides with the VT sound output / the PC
speaker driver. Over 2.6, one can easily avoid this my switching off
CONFIG_INPUT_PCSPKR. 2.4 requires to export and than manipulate
kb_mksound (the pointer to the sound generating code).

The latter pointer rang some bell. I once fixed a broken RTAI build due
to that code. So I pulled out vulcano and actually found the related
code + an extension of the original ipipe patch to export kb_mksound. I
guess it would have been too complicated for Paolo to explain the reason
of this export to us...

Anyway, this digging revealed another potential breakage in the
emulation code: RTAI takes care to read the emulated TSC at least once
per 50 ms, to avoid overflows I assume. Xenomai does not.

Before spending "some" time on a clean (in contrast to what I just read
in foreign code...) fix for Xenomai, I would like to cross-check if this
emulation is still considered useful. No one seems to use it, otherwise
we should have received complaints much earlier.

Fix it or drop it?

Jan


--------------enigDB201E23020683AEB3E71BD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEw7HbniDOoMHTA+kRAsi/AJ9u1bvSjOcDjIQgPHUkTYEp3BLScwCfXrC0
dPAiQ9jiMkfh+9F6bVpJZvA=
=im58
-----END PGP SIGNATURE-----

--------------enigDB201E23020683AEB3E71BD0--

