Message-ID: <463837DE.7080704@domain.hid>
Date: Wed, 02 May 2007 09:03:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <f188q2$bsr$1@domain.hid>
In-Reply-To: <f188q2$bsr$1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBA17D0434D3EB69F1E114270"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] add tut01_skeleton
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: trem <tremyfr@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBA17D0434D3EB69F1E114270
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

trem wrote:
> Hi
>=20
> As we have already talked on xenomai-help, I've done a first example
> with rtdm. It's very simple and the goal is just to show how to registe=
r
> and use a rtdm device. This is the first release, so it isn't perfect
> (comments and feedback welcome).

On first glance it looks almost perfect. I will check it in later today
or tomorrow, cleaning up the remaining minor issues (I noticed C++
comments in C code).

Another issue should be resolved, either publicly or privately (with the
core team): In case we would ever have to answer some legal question
about code you committed, your nick name will not help us that much to
resolve the real person behind it. Could you reveal your full name to
the community or at least to us?

>=20
> If this example is good enough, I have to plane next one. I think about=

> shawdow_task (to use device in rt mode) and synchronization. If people
> have idea for others example, I would be pleased to read them.

-EBRAINBUSY, but I will surely have some suggestions later on.

Thanks again,
Jan


--------------enigBA17D0434D3EB69F1E114270
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGODfeniDOoMHTA+kRAvcIAJ0bt6k5fyEmlSO/40uNnn5cENVkcQCbB1Bq
ANXvlsQcWVHpZmBBROxMqeM=
=YZyw
-----END PGP SIGNATURE-----

--------------enigBA17D0434D3EB69F1E114270--

