Message-ID: <44ACB87B.9090204@domain.hid>
Date: Thu, 06 Jul 2006 09:15:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator
	vs.	PXA)
References: <44A3919C.596DFDAE@vollmann.ch>		<1151592402.19389.31.camel@domain.hid>		<44A4C4CB.5F24DA68@domain.hid>		<1151657621.3060.26.camel@domain.hid>		<44A8B191.3DCC39C2@domain.hid>		<44A8BA2E.9090106@domain.hid>		<44A8D7A1.4E4E9D27@domain.hid>		<17577.4096.436840.354535@domain.hid>		<17577.5372.702355.432641@domain.hid>		<44AA0E21.3F17401F@vollmann.ch>
	<17579.47238.90918.989854@domain.hid>
	<44AC4ED0.4C1BF83E@vollmann.ch>
In-Reply-To: <44AC4ED0.4C1BF83E@vollmann.ch>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1955D722809BD6EC07919413"
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
To: Detlef Vollmann <dv@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1955D722809BD6EC07919413
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Detlef Vollmann wrote:
> ...
> And I think you're correct, for Xenomai it will work.
> Unfortunately I'm trying to do a general ipipe port for PXA.
> I'm doing this for a polytech who wants to use this with their
> students, and so they probably want to use it with other domain
> on top of ipipe (rtai 3.3, Siemens' implementation of the Posix
> RT interface, and maybe even an own domain for experimenting).

I think the problem is not that some interface is "public". The point is
rather that inherent characteristics like "always called with interrupts
off" or "has to be protected with ipipe_critical" are not yet
documented. Adding such comments to your work might be a start. The same
applies to how a domain can expect soon-to-expire timer events are handle=
d.

Creating a generic patch without basing it on Xenomai-specific
assumption is a reasonable approach, for sure. Nevertheless, the first
non-Xenomai user you mentioned requires more patching and far more
cleanup/update of its core to work over ARM again. And the second one is
unfortunately still unpublished.

The third scenario is quite real. Example: I have an experimental patch
for the new irqbench pending that demonstrates how to lift simple IRQ
jobs over Xenomai in its own domain. Gives nice worst-case IRQ latencies
even on low-end, even under heavy Linux *and* Xenomai load (the latter
ATM only with a small patch against ipipe to enable preemptible IRQ
handlers for all non-heading domains, not only the root one).

Jan


--------------enig1955D722809BD6EC07919413
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErLh7niDOoMHTA+kRAgYXAJ9MavahkwmthSDFe4BqsV6oStCBVwCeKH/z
e+jd9pEVeDlYMN2Vd3yFCfM=
=KwdY
-----END PGP SIGNATURE-----

--------------enig1955D722809BD6EC07919413--

