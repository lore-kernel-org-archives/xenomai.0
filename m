Message-ID: <441E71BB.6010906@domain.hid>
Date: Mon, 20 Mar 2006 10:11:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 2.6.16-rc6 support
References: <441DD358.8010307@domain.hid>
In-Reply-To: <441DD358.8010307@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4C607EB1BA5927ED9335726E"
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
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4C607EB1BA5927ED9335726E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> Jeroen reported success much earlier, now I had to rebase my box on
> upcoming 2.6.16. So I would like to post the result, maybe others are
> interested in starting an early test as well. Attached is a cleanly
> applying Ipipe patch for -rc6 and a fix for a name collision in
> posix/syscall.c (there are other mutex functions in the kernel now...).=

>=20

Uups, someone must have whispered to me that 2.6.16 will come out very
soon, and now it happened. The final patch seems to cause no problems to
the ipipe patch as well.

Jan


--------------enig4C607EB1BA5927ED9335726E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHnG7niDOoMHTA+kRAv4dAJ9Vdp+vJBDzn16OCx71i6xsffe8RQCfT3qv
eudp/a/SgovJVPVzZRHCuIU=
=hCmz
-----END PGP SIGNATURE-----

--------------enig4C607EB1BA5927ED9335726E--

