Message-ID: <443BA12F.9020505@domain.hid>
Date: Tue, 11 Apr 2006 14:29:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Fixs doxygen doc on rt_queue_read
	in	ksrc/native/queue.c (for SVN version)
References: <200604101640.04255.lbocseg@domain.hid>
In-Reply-To: <200604101640.04255.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF25E35105147A9647E81F3DE"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF25E35105147A9647E81F3DE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> BTW, please, could someone confirm the rt_task_delete(NULL) bug in SVN?=


Half-confirmed, there is something fishy. I'm struggling with the
debugger ATM, not sure yet who's wrong ;). It tells me rt_task_delete of
the skin module is entered with task !=3D NULL...

Jan


--------------enigF25E35105147A9647E81F3DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEO6EwniDOoMHTA+kRAuuIAJwIybKFjAlHO6bcUnOlGd/fMTvLnQCfdQj3
ptZiespgEXs023DDz16+h7s=
=vWwI
-----END PGP SIGNATURE-----

--------------enigF25E35105147A9647E81F3DE--

