Message-ID: <48103245.4010202@domain.hid>
Date: Thu, 24 Apr 2008 09:09:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18448.9649.956656.531081@domain.hid>
In-Reply-To: <18448.9649.956656.531081@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEBBC5B920DE360AC5AFC57CD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [0/9] Posix skin user-space mutexes
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
--------------enigEBBC5B920DE360AC5AFC57CD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> the patch series to come for review adds support for user-space mutexes=
 to the
> posix skin. Since I wanted this support to be available on my AT91RM920=
0, the
> patch series start with patches which are mainly for the ARM architectu=
re, to
> end with reimplementation of the kernel-space and user-space mutex serv=
ices for
> the posix skin.

Cool stuff!

>=20
> Some patches brought some questions when making them, questions which w=
ill be
> discussed in the mail accompanying the patch.
>=20
> Since I do not use quilt, some patches will inevitably mix several
> modifications, especially the patch to ksrc/skins/posix/syscall.c. I pr=
omise,
> next time I will use quilt.
>=20
> The result has only be tested in the fast (no syscall) case, to evaluat=
e its
> performance, I will start tests trying to cover the syscall case now, a=
nd keep
> you informed.

Central question (IMHO): Do you ensure that the kernel-side atomic op on
 the mutex state can _never_ raise an exception? Or do you have some
atomic mechanism that can handle faults?

Jan


--------------enigEBBC5B920DE360AC5AFC57CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIEDJFniDOoMHTA+kRAnEBAJ4i1Rjaa7llJeS9WY1tIrzddwNrqgCffOwz
U1y5gZuzLLQ+SD/weOeoovo=
=USgE
-----END PGP SIGNATURE-----

--------------enigEBBC5B920DE360AC5AFC57CD--

