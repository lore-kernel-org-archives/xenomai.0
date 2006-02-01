Message-ID: <43E0CB30.7010102@domain.hid>
Date: Wed, 01 Feb 2006 15:52:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Are XN_ISR_CHAINED and XN_ISR_ENABLE mutually
	exclusive?
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>
	<43E0BEC1.2060400@domain.hid>
In-Reply-To: <43E0BEC1.2060400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5B94F7588B1E4FABBA579351"
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5B94F7588B1E4FABBA579351
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Anders Blomdell wrote:
> While looking into how to implement sharing of interrupts between
> realtime and non-realtime domains (and applying Wolfgang Grandegger's
> patch [https://mail.gna.org/public/xenomai-core/2006-01/msg00233.html],=

> which is necessary to make XN_ISR_ENABLE work at all on the PowerPC
> platform), I'm beginning to think that XN_ISR_CHAINED and XN_ISR_ENABLE=

> are mutually exclusive, since if both are set, desc->handler->end will
> be called twice:
>=20
>   1. When the realtime isr handler returns
>   2. When the Linux domain calls it in __do_IRQ

Yes, those bits are semantically exclusive. Actually, I think passing
both bits could even cause deadlocks if the RT-IRQ is raised again
before the non-RT handler got a chance to clear the IRQ source in hardwar=
e.

>=20
> In the solution I have in mind at the moment, I will:
>=20
>   1. Add an extra iend handler argument to xnintr_init
>   2. If XN_ISR_ENABLE is returned from the isr handler,
>      replace desc->handler->end with the user supplied
>      iend handler.
>=20
> Hereby I hope to be able to handle interrupts shared between realtime
> and non-realtime domain, without having the realtime domain wait for al=
l
> non-realtime interrupts to finish. This is the scenario I'm thinking of=
:
>=20
>   1. A non-RT interrupt occurs
>   2. The (RT) isr handler detects the non-RT interrupt,
>      disables further non-RT interrupts on that irq-vector, replaces

This remains vague to me. How precisely will you disable? I guess at
hardware level, i.e. in a (non-RT) device-specific way: switch off the
bit in some hardware register that says "this device can produce IRQs",
right?

>      desc->handler->end with the user supplied iend handler,
>      returns XN_ISR_CHAINED | XN_ISR_ENABLE.
>   3. RT interrupts are serviced by the (RT) isr handler,
>      returns XN_ISR_ENABLE
>   4. The Linux domain get a chance to run the chained interrupt,
>      and eventually calls desc->handler->end (supplied iend handler)
>   5. The iend handler reenables non-RT interrupts.

Then this would switch on that bit again? Note that this may require to
synchronise the hardware access with parts of the non-RT driver.

Meanwhile I recalled that my hack to realise IRQ sharing between a RT
device and a non-RT eepro100 is filed on a public archive:

https://mail.gna.org/public/xenomai-core/2005-11/msg00012.html

>=20
> Comments on the above are most welcome!
>=20

Jan


--------------enig5B94F7588B1E4FABBA579351
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4MswniDOoMHTA+kRAkB1AJ41xa7stHjsM6GZju1YWxSwC5tdsACeNf1z
1auX8wqNcbL1Bf2Dy34WjjY=
=DW7l
-----END PGP SIGNATURE-----

--------------enig5B94F7588B1E4FABBA579351--

