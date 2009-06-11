Message-ID: <4A30D969.6080501@domain.hid>
Date: Thu, 11 Jun 2009 12:16:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A30CB83.5080504@domain.hid> <4A30CF49.8010007@domain.hid>
	<4A30D3CD.8050908@domain.hid>
In-Reply-To: <4A30D3CD.8050908@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE7F88C43ABF463E1C2D26CEC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] ksrc: respect struct proc_dir_entry
	changes in 2.6.30
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE7F88C43ABF463E1C2D26CEC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Vladimir Zapolskiy wrote:
> Hi Jan,
> I observed that LINUX_VERSION_CODE comparisons are common enough in
> Xenomai code. Do you propose to make a separate header, which is
> included from nucleus, drivers and arch files?

Yes, it's common, but we also keep a lot of wrapping in asm-*/wrappers.h.=


Jan

PS: Please avoid top-posts.


--------------enigE7F88C43ABF463E1C2D26CEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkow2WkACgkQniDOoMHTA+l5VwCeM8TQ92S/O+0efbY+QZL/Gh6I
q+QAn0eGnp1Av28cUfKcosXteV6Dno/G
=26Yt
-----END PGP SIGNATURE-----

--------------enigE7F88C43ABF463E1C2D26CEC--

