Message-ID: <4777D222.7000904@domain.hid>
Date: Sun, 30 Dec 2007 18:15:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4776D47C.5090005@domain.hid> <4777770F.8060403@domain.hid>
In-Reply-To: <4777770F.8060403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC6BAF4341F0D25667776D3DD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH 3/5] avoid naming conflict around
	__ipipe_irq_handler
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC6BAF4341F0D25667776D3DD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> There is already a definition of __ipipe_irq_handler. So, we either ne=
ed
>> to more the real ipipe_irq_handler_t into ipipe_base.h, or rename this=

>> local variant to __ipipe_irq_handler_t, or simple drop this refactorin=
g.
>> This patch starts with applying the latter - the easiest one :->
>>
>=20
> There is no naming conflict, since they describe the same type with
> different even if close names on purpose. __ipipe_irq_handler is only a=


Sorry for remaining unclear: I was referring to the __ipipe_irq_handler
helper macro from linux/ipipe.h. They may happen to live happily side by
side, but it is far from being clean.

> local short-hand to reduce visual pollution; as a matter of fact, the
> assembly code itself depends on the handler prototype, despite it canno=
t
> rely on any C-defined type, so the problem - if any - starts even befor=
e
> this local definition, and if you happen to change ipipe_irq_handler_t,=

> then you could just not miss fixing __ipipe_irq_handler in the same mov=
e.
>=20
> The only sane way to avoid defining this short-hand is indeed to move
> ipipe_irq_handler_t to linux/ipipe_base.h.
>=20

Jan


--------------enigC6BAF4341F0D25667776D3DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHd9IlniDOoMHTA+kRAkMnAJwPYVlPhSqtwU/nrfSbM+ahBKP5aACfWqhE
cpZZjnzWNoVhHt5eckUanf0=
=gofh
-----END PGP SIGNATURE-----

--------------enigC6BAF4341F0D25667776D3DD--

