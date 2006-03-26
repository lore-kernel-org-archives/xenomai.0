Message-ID: <4426865D.6050901@domain.hid>
Date: Sun, 26 Mar 2006 14:17:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Timer IRQ propagation
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210D6B@EINT11.einet.ad.eivd.ch>
	<FDBBB5CC70676540B3EF7CFE83FD94E004310B@EINT11.einet.ad.eivd.ch>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E004310B@EINT11.einet.ad.eivd.ch>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig891F8CAA4DE25A39F71952B9"
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
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig891F8CAA4DE25A39F71952B9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ROSSIER Daniel wrote:
> Just to stimulate some discussions, I tried to bring some pieces of
> answers.
>=20
>=20
> -----Original Message----- From: xenomai-core-bounces@domain.hid on
> behalf of ROSSIER Daniel Sent: Fri 3/24/2006 4:38 PM To:
> xenomai@xenomai.org Subject: [Xenomai-core] Timer IRQ propagation
>=20
>=20
>=20
> Hi,
>=20
>=20
>=20
> We have some doubts about how the things work between i-pipe &
> xenomai regarding the timer.
>=20
>=20
>=20
> 1-  First, when Xenomai is registered, the 10ms timer of Linux is
> stolen by the Xenomai domain. How
>=20
> is the 10ms timer preserved? is it registered as a timer by the pod ?
>=20
>=20
>=20
>> Ok, silly question: the 10ms timer (or 1ms timer) is managed by
>> Linux directly with its own list of timers; this doesn't affect
>> Xenomai's timer list.

Under Xenomai, there is the host timer (nkpod-htimer) representing the
Linux timer interrupt - with lowest prio and only propagated when the RT
domain allows it.

>=20
> 2-       When a timer IRQ is received, we understood that the IRQ is
> ack'd and masked by handle_irq() and sent to the domains through
> walk_pipeline() including Linux; but we have some doubts about that
> since the timer ISR of Linux first acknowledges the interrupt, and it
> seems that it acknowledges physically (hw ack); we expected that the
> acknowledgement would be a virtual ack in the Linux domain since the
> ack has been made previously by handle_irq(). In our case (ARM arch),
> the ack actually corresponds to a mask and therefore the timer IRQ is
> masked by Linux once it gets,  and we then suspect some loss of timer
> interrupts.
>=20
> have we understood correctly the mechanism? Any idea about this
> behaviour? Is it normal?
>=20
>=20
>> Still unclear to me; the ack would be done in the timer ISR;
>> however in the (ARM) patch we have, ipipe performs a hardware ack;
>> I've seen in the x86 patch that adeos makes nothing within
>> __ipipe_ack_system_irq(). I guess the last behaviour is correct,
>> isn't it?
>=20

That's something the ARM people here can better comment on. I would only
say that physically ack'ing the shared timer IRQ twice or masking it
under Linux would be a bug - if it actually happens this way.

Jan


--------------enig891F8CAA4DE25A39F71952B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJoZdniDOoMHTA+kRApnMAJ905mNEqxaGDHRHahFyi5gsZIEs1wCfdqRQ
WhmYNXjB4PFPXVC5gC4xXtY=
=avr9
-----END PGP SIGNATURE-----

--------------enig891F8CAA4DE25A39F71952B9--

