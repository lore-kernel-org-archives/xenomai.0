Message-ID: <4549A44B.50307@domain.hid>
Date: Thu, 02 Nov 2006 08:54:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Propagating interrupts
References: <454931D5.4050507@domain.hid>
In-Reply-To: <454931D5.4050507@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE8E39E59911E8CEFF2D9FFE6"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE8E39E59911E8CEFF2D9FFE6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
>=20
> I have read that propagating interrupts to Linux is a bad idea for RT
> applications.  I am trying to understand what happens when I install an=

> interrupt handler via the userspace POSIX skin like this:
>=20
>  pthread_intr_attach_np (&ctr_intr, irq_number, PTHREAD_IPROPAGATE);
>=20
> My RT thread waits on this interrupt using:
>=20
>  pthread_intr_wait_np(ctr_intr, NULL);
>=20
> Here is my understanding of what happens when I get an interrupt on thi=
s
> IRQ.  The Xenomai interrupt handler is executed, which wakes up my RT
> thread.  The interrupt remains masked until the Linux interrupt handler=

> is executed.  The linux interrupt handler processes the interrupt, and
> then re-enables the IRQ.  Now the RT thread can receive more interrupts=
=2E
>=20
> Is this basically correct?

Yes, the Linux domain can cause priority inversion /wrt the real-time
domain trying to handle the same IRQ line. That's true for any
deterministic/indeterministic IRQ handler combination, not only under
Xenomai.

Jan


--------------enigE8E39E59911E8CEFF2D9FFE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFSaRRniDOoMHTA+kRAkVOAJ9XmR14Gch6DAk/ntaEiS+AygoSaACfbFlP
dE04WqTAPoZoj0/42VsRJUs=
=52RN
-----END PGP SIGNATURE-----

--------------enigE8E39E59911E8CEFF2D9FFE6--

