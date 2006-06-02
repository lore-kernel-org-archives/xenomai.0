Message-ID: <44806253.9020805@domain.hid>
Date: Fri, 02 Jun 2006 18:07:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <447F72A0.8000000@domain.hid>	<17536.18621.302528.67077@domain.hid>	<4480515F.7050500@domain.hid>
	<17536.21805.408809.703077@domain.hid>
In-Reply-To: <17536.21805.408809.703077@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA2D6110E7CB08CBB57BADACE"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patch] static buffer for timer-bheap
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA2D6110E7CB08CBB57BADACE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > I would also prefer passing the bheaph_t** storage to bheap_init, =
and
>  > > conserve bheap_destroy (with a callback called with the bheap_t**
>  > > storage) in case the storage was dynamically allocated by the call=
er.
>  >=20
>  > Do you have a concrete usage scenario in mind where this would be
>  > required? I would rather bet that potential callers of bheap_destroy=

>  > know very well when some buffer is to be released. Looks at bit like=

>  > overkill unless someone has the real need to mix dynamically with
>  > statically allocated bheaps.
>=20
> Requesting a bheaph_t ** to be passed to bheap_init is type-safe and
> would have caught the kind of mistake you have done.

But I also did not use the macro, which avoids such mistakes now.

> bheap_destroy allow
> setting the bheap_t structure to an invalid value which, in turn, allow=

> helping upper layers in catching invalid uses of the bheap after its
> destruction.

Ok, we could make bheap_destroy pop up under XENO_OPT_DEBUG. We may then
also add assertions to the bheap functions themselves to check for
invalid usage.

>=20
> It is a low price to pay to make the interface a bit safer.
>=20

The price is also larger code in every heap runtime function due to the
additional indirection. I still vote for the combined structure and to
give its allocation completely in user hand.

Jan


--------------enigA2D6110E7CB08CBB57BADACE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEgGJTniDOoMHTA+kRAiyfAJ0XkMnDQ6vVR8qRmC991t8L9qvphACfeSbH
HJtrWm2b5nM9vllnKlvTgDs=
=oX9Z
-----END PGP SIGNATURE-----

--------------enigA2D6110E7CB08CBB57BADACE--

