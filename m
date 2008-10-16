Message-ID: <48F7BF9A.4070305@domain.hid>
Date: Fri, 17 Oct 2008 00:26:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.802426487@domain.hid>
	<48F7A1A2.3050201@domain.hid>
In-Reply-To: <48F7A1A2.3050201@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1CC4A6E3331EF61090981745"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 09/12] Optionally replace
 pthread_getspecific with TLS variables
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
--------------enig1CC4A6E3331EF61090981745
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>=20
> The real downside here is a lot of #ifdef clutter. What about the idea
> of defining an API to abstract the differences between
> pthread_get/setspecific and __thread and have #ifdef only in one header=
 ?

Sometimes you only store a value that way, sometimes you also have to
provide the object that is stored. Then its initialisation is fairly
specific.

Everything can be abstracted, but I'm not that optimistic that the
result will be better readable, just look at the patched users. Or what
abstractions do you have in mind?

Jan


--------------enig1CC4A6E3331EF61090981745
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj3v54ACgkQniDOoMHTA+l58gCfXSGODvRtp1SyXNgsec9EjrqZ
kisAnjIyBA90I0CdAGTXMN9fXqigfnnw
=oPlG
-----END PGP SIGNATURE-----

--------------enig1CC4A6E3331EF61090981745--

