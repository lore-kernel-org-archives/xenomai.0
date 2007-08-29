Message-ID: <46D585E2.70902@domain.hid>
Date: Wed, 29 Aug 2007 16:42:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <op.txtr31btt06gyn@domain.hid>
In-Reply-To: <op.txtr31btt06gyn@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD045686570C128D35D8B4F0B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] System hangs in/after rtdm_lock_put_irqrestore
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD045686570C128D35D8B4F0B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Axel Beierlein wrote:
> what could it be that an simple rt_dev_open locks up my system when it =
=20
> calls rtdm_lock_put_irqrestore?
>=20
> [...]
> if (rtdm_irq_request(&ctx->irq_handle,
> 		        MPC5xxx_PSC2_IRQ,
> 			rt_psc_interrupt,
> 			RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE,
> 				context->device->proc_name,
> 				ctx))
> 	{
> 		printk ("psc5200B.c: request_irq() failed\n");
> 		return -1;
> 	}
>=20
>      rtdm_irq_enable(&ctx->irq_handle);
>=20
>      rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
>=20
>      ctx->imr_status =3D MPC5xxx_PSC_IMR_RXRDY;
> 	out_be16(&psc->mpc5xxx_psc_imr, ctx->imr_status);

Let me guess: this line arms the related IRQ source at hw level, no?

>=20
> 	rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
> 	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	Here i get the crash

Because it enabled local IRQ delivery again, and the system ends up in
an IRQ storm, or some endless loop in the IRQ handler, or some crash
related to IRQ handling. Still just guessing...

Jan


--------------enigD045686570C128D35D8B4F0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1YXjniDOoMHTA+kRAveAAJ4r5Tu5SCkjisE0rzCqyiM0FQZ5ewCcCvd2
lz8hgOc52iIPtvAiJGmdZ3s=
=ThSi
-----END PGP SIGNATURE-----

--------------enigD045686570C128D35D8B4F0B--

