Message-ID: <45D8987C.5080805@domain.hid>
Date: Sun, 18 Feb 2007 19:18:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Extended CAN frame filtering
References: <45D338C2.9030203@domain.hid> <45D5A56F.8080900@domain.hid>
	<45D711DF.8060802@domain.hid> <45D741AE.9020501@domain.hid>
	<45D7475E.1030504@domain.hid> <45D74F70.2090200@domain.hid>
	<45D76A71.20504@domain.hid>
In-Reply-To: <45D76A71.20504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig520B981E90D56A4A5E1967CB"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig520B981E90D56A4A5E1967CB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> ...
> Attached is a revised patch including change log entry. As this patch
> just extends the existing filter capabilities, it could be applied to
> trunk and the 2.3.x branch as well.

You are just forgetting the other changes to the filter mechanism you
implemented.

Thanks for the patch, I just merged your patch into trunk. For v2.3.x, I
applied my first patch I sent on Wednesday to align it to what was
specified on release of 2.3. No breakage inside the stable series unless
something really forces us.

Jan


--------------enig520B981E90D56A4A5E1967CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF2JiAniDOoMHTA+kRAnMqAJ9f/fl20KvA8ia2INLP2oXBZ+nFgACdGdDc
VPumxmhuUzl2maaOFEhMP14=
=kByY
-----END PGP SIGNATURE-----

--------------enig520B981E90D56A4A5E1967CB--

