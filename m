Message-ID: <43E313BF.2010104@domain.hid>
Date: Fri, 03 Feb 2006 09:26:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] some results on my laptop
References: <43E288AA.3050203@domain.hid>
	<43E28EE8.3020103@domain.hid>	<43E2A31D.9000807@domain.hid>
	<43E30B8D.6030507@domain.hid> <43E31186.1000007@domain.hid>
In-Reply-To: <43E31186.1000007@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8751AE5944283DAB8CD8DA16"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8751AE5944283DAB8CD8DA16
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> What about other time sources on x86? Which systems already have HPET
> these days, and does this source not suffer from frequency scaling? I
> once read that HPET is quite easy to program, is this true? IOW, would
> it be worth considering to add this to the HAL?

There are actually only few registers:

http://www.intel.com/hardwaredesign/hpetspec_1.pdf

Even a replacement for the TSC is available ("Main Counter"), but I
guess that some effort will be required to replace all direct usages of
rdtsc in the current Xenomai code, right?

Jan


--------------enig8751AE5944283DAB8CD8DA16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4xO/niDOoMHTA+kRAg4XAJ0Yp2l5Ob9UKUOEu1eJf952jHmJbwCeMb9+
fG2en4OBNZBY77GyWY3ISks=
=8Du2
-----END PGP SIGNATURE-----

--------------enig8751AE5944283DAB8CD8DA16--

