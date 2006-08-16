Message-ID: <44E2DC1C.2010304@domain.hid>
Date: Wed, 16 Aug 2006 10:49:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC3E8770131E8E4BA491A19F8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Time representation in RTDM profiles
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
--------------enigC3E8770131E8E4BA491A19F8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all,

the current representation of timeouts and timestamps in RTDM device
profiles is inconsistent. In the serial profile we use [u]int64_t
directly, the CAN profile defines its own types called
nanosecs_{abs|rel}_t (though they just wrap the int64 ones).

What is the idea of nanosecs? Having a way to redefine that type looks
nice, but it's unfortunately the ABI, so we cannot easily change it
without breaking apps.

Jan


--------------enigC3E8770131E8E4BA491A19F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE4twcniDOoMHTA+kRAuP+AJ98kbwHD8kBUHCAwkF/3UIKoqaGmwCffr7E
RvNayqpL6E8X177bvclKASc=
=ilM/
-----END PGP SIGNATURE-----

--------------enigC3E8770131E8E4BA491A19F8--

