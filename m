Message-ID: <470C6D48.3070109@domain.hid>
Date: Wed, 10 Oct 2007 08:12:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <305035a40710091019n77e1a453gd0d349dc1eebc15d@domain.hid>	<470BC537.8010200@domain.hid>	<305035a40710091207j4038c62s5fb81903ce843910@domain.hid>	<305035a40710091207l185a8fcm8baf715e0a0ef2b3@domain.hid>	<470BDA72.8070908@domain.hid>
	<18187.63871.791885.643837@domain.hid>
In-Reply-To: <18187.63871.791885.643837@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig300FE4236FE129989B6FEF75"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Fwd: RTAI and Xenomai latency in kernel mode on
 AT91SAM9261-EK
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
--------------enig300FE4236FE129989B6FEF75
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Again, the priority should not be the issue. The issue is likely tha=
t a
>  > pending or just being handled non-RT IRQ can stall some RT IRQ at
>  > hardware level. That must not happen. I-pipe rather has to log,
>  > acknowledge, and possibly mask that line quickly so that RT IRQs can=
 be
>  > delivered again.
>=20
> Thinking a bit more about my ethernet vs timer issue. If, when an
> ethernet interrupt is pending, adeos is not aware that there is also a
> timer interrupt pending, it will call the ethernet interrupt handler
> immediately then unmask the interrupt. So, Adeos will never have a
> chance to handle the timer interrupt before another ethernet interrupt
> is handled. Ergo, giving the timer interrupt the highest priority is
> what must be done.

No. Adeos will first start to dispatch the Ethernet IRQ. It will
ack&mask it and then re-enable the IRQ delivery before calling into the
handler. At this point the hardware can report the timer IRQ, and Adeos
will immediately start to deliver that one instead.

With IRQ hardware priorities, you only optimise the case when both
interrupts are pending in the hardware at the same time. The worst-case
remains that the Ethernet IRQ comes first, Adeos starts to handle it,
and _then_ the timer IRQ arrives. This is something the hardware can in
no way avoid (without looking into the future...).

Jan


--------------enig300FE4236FE129989B6FEF75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHDG1LniDOoMHTA+kRAsK5AJ0QXOPHXSlRvDjVS8QiMQg2p9hs6gCeJ5Ld
f+8ZWiceLzaq7NsfrzUXVxo=
=3c4V
-----END PGP SIGNATURE-----

--------------enig300FE4236FE129989B6FEF75--

