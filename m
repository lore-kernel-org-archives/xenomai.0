Message-ID: <46D669C9.6060805@domain.hid>
Date: Thu, 30 Aug 2007 08:55:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <op.txtr31btt06gyn@domain.hid> <46D585E2.70902@domain.hid>
	<op.txuzl2o9t06gyn@domain.hid>
In-Reply-To: <op.txuzl2o9t06gyn@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig10BAB0DF489CA761D21346BC"
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
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig10BAB0DF489CA761D21346BC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Axel Beierlein wrote:
> Am 29.08.2007, 16:42 Uhr, schrieb Jan Kiszka <jan.kiszka@domain.hid>:
>=20
>> Axel Beierlein wrote:
>>> what could it be that an simple rt_dev_open locks up my system when i=
t
>>> calls rtdm_lock_put_irqrestore?
>>>
>>> [...]
>>> if (rtdm_irq_request(&ctx->irq_handle,
>>>                 MPC5xxx_PSC2_IRQ,
>>>             rt_psc_interrupt,
>>>             RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE,
>>>                 context->device->proc_name,
>>>                 ctx))
>>>     {
>>>         printk ("psc5200B.c: request_irq() failed\n");
>>>         return -1;
>>>     }
>>>
>>>      rtdm_irq_enable(&ctx->irq_handle);
>>>
>>>      rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
>>>
>>>      ctx->imr_status =3D MPC5xxx_PSC_IMR_RXRDY;
>>>     out_be16(&psc->mpc5xxx_psc_imr, ctx->imr_status);
>>
>> Let me guess: this line arms the related IRQ source at hw level, no?
>>
>=20
> Yes you are right. This Bit enables the RX_Ready IRQ at hw level. Sorry=

> for the little Code fragment but the code relates to your 16550A.c and =
i
> don=C2=B4t want to post all the routines at the moment.
>=20
>>>
>>>     rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
>>>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>     Here i get the crash
>>
>> Because it enabled local IRQ delivery again, and the system ends up in=

>> an IRQ storm, or some endless loop in the IRQ handler, or some crash
>> related to IRQ handling. Still just guessing...
>>
>> Jan
>>
>=20
> But how your UART driver handle this Problem? I have check the Irq
> Handler an implement an printk in it to see where it hangs, but it
> doesn=C2=B4t step into this handler.

In case you have an IRQ storm or your handler runs in an endless loop,
you won't be able to read that printk even if it's executed - Linux will
have no chance to dump the message.

Start debugging with shrinking the handler down to a plain "return
RTDM_IRQ_HANDLED" (or even RTDM_IRQ_NONE so that Xenomai disables the
line), then slowly re-enabling and reviewing your code.

Jan

PS: reply-to-all


--------------enig10BAB0DF489CA761D21346BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1mnJniDOoMHTA+kRApTFAJwKiDMJ26k6K2XKiu7r2rg8MrV0SQCcCch/
2zMPaEz+bFaTfsoLXYwVmdo=
=LY+S
-----END PGP SIGNATURE-----

--------------enig10BAB0DF489CA761D21346BC--

