Message-ID: <464C4DE4.1040402@domain.hid>
Date: Thu, 17 May 2007 14:43:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <17996.15540.824415.263562@domain.hid>
In-Reply-To: <17996.15540.824415.263562@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF1D460A0EA4341036776134C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] Use tsc for implementation of
	clock_gettime.
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
--------------enigF1D460A0EA4341036776134C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> here comes, for review, a patch which reduces the overhead of
> clock_gettime by directly reading the tsc in user-space for
> architectures that support it.

Highly welcome. But I have one concern: How and when do you propagate
wallclock_offset changes to user space?

I think we need some vsyscall-alike approach for this, some read-only
page that is mapped into every RT process, containing things like a
regularly updated offset (seqlock fashioned) or other read-only
information (shadow mode? cpu id?).

Jan


--------------enigF1D460A0EA4341036776134C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGTE3kniDOoMHTA+kRAjqPAJ9SF0hnOWxxmcpid4U9nxPWHlJhNQCfVpsd
m0KDdCgNhTPF1T7SaILUeYc=
=0v46
-----END PGP SIGNATURE-----

--------------enigF1D460A0EA4341036776134C--

