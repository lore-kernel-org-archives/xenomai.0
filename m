Message-ID: <43B04512.1070505@domain.hid>
Date: Mon, 26 Dec 2005 20:31:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rt shared irqs] ipipe-related changes (draft)
References: <b647ffbd0512260117n7023fb93h@domain.hid>
In-Reply-To: <b647ffbd0512260117n7023fb93h@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig149871C12B96F608D0D52BB0"
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig149871C12B96F608D0D52BB0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Dmitry Adamushko wrote:
> Hi everybody,
> 
> the enclosed patches (the first version, hence it's still raw) are
> supposed to build the basis needed on the ipipe layer for adding
> support of real-time shared interrupts. As a side effect, the
> irq_trampoline() layer has been eliminated and the irq processing
> chain has become shorter.

Great!

> 
> Some points are more likely to be changed in the next iteration (e.g.
> __ipipe_irq_cookie() vs. changing the ipipe_virtualize_irq()
> interface).
> The struct rthal_realtime_irq::hits[per-IRQ] is missed so far.
> 
> Anyway, comments are very wellcome.
> 

Only one so far: please update your Xenomai base - or is your Internet
link really /that/ slow ATM? ;)

Merry Christmas,
Jan

--------------enig149871C12B96F608D0D52BB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDsEUWniDOoMHTA+kRAvJmAJ927rCvdfqnp92BL629my+Au+5KIACfeJ6r
hSqJGt2FnyS52mFhn/D7gu0=
=rwSB
-----END PGP SIGNATURE-----

--------------enig149871C12B96F608D0D52BB0--

