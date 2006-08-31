Message-ID: <44F72F35.4070109@domain.hid>
Date: Thu, 31 Aug 2006 20:49:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] IRQ Enable/Disable
References: <44F6E774.2000701@domain.hid>
In-Reply-To: <44F6E774.2000701@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C0BCFDF8B210127522DFD19"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcelo Coelho <mjcoelho@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C0BCFDF8B210127522DFD19
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marcelo Coelho wrote:
> Hi!
>=20
>=20
> I've found out in RTAI's 16550a driver, that uses RTDM, the following
> comment:
>=20
>     /*We should disable the line now, but this requires counting
>      * enable/disable, something not yet implemented by the core.
>      * At the moment this call could starve other users sharing the
>      * same line.
>     rtdm_irq_disable(&ctx->irq_handle);*/
>     rtdm_irq_free(&ctx->irq_handle);

In fact, you find the same in Xenomai as RTAI just mirrors the original. =
:)

>=20
> Is this still true? I mean, if i free the device at device close, shoul=
d
> i expect that i need to request the irq again?

It is still true. Xenomai does not support a nesting counter for
irq_disable/enable yet, therefore RTDM did not change its interface in
this regard as well.

>=20
> I'm trying to ckeck what to expect about these calls.
>=20

For now the situation is like this: rtdm_irq_request allocates an IRQ,
but doesn't necessarily enables it. So you have to call rtdm_irq_enable
afterwards. To release it, just switch off IRQ generation in your device
and call rtdm_irq_free.

That's true unless the IRQ is shared. Then some other driver may have
already enabled it (which doesn't releases your from the duty to do it
again - you cannot predict the load order). Therefore, if writing a
driver with shared IRQ support, you should not rely on the fact that the
IRQ line is disabled right after rtdm_irq_request. Neither should you
disable the line on release (only in the hardware). Otherwise, you would
cut off persisting users of that line.


Mmh, your question makes me wonder if we shouldn't enable the line in
rtdm_irq_request automatically. I do not recall any urging use-case for
the current behaviour... Does anyone else?

Dmitry, Philippe, what's the reason for the split up in the core? Does
any skin require this?

Jan


--------------enig7C0BCFDF8B210127522DFD19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9y81niDOoMHTA+kRAsvSAJwNLixoXBu4K5X/dJ2vclRk/RIFfwCfU//C
b4lgynzquqNPlFPYNKGyndI=
=QTRj
-----END PGP SIGNATURE-----

--------------enig7C0BCFDF8B210127522DFD19--

