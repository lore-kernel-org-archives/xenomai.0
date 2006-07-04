Message-ID: <44AA76AD.6010804@domain.hid>
Date: Tue, 04 Jul 2006 16:09:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator
	vs.	PXA)
References: <44A3919C.596DFDAE@vollmann.ch>		<1151592402.19389.31.camel@domain.hid>		<44A4C4CB.5F24DA68@domain.hid>		<1151657621.3060.26.camel@domain.hid>		<44A8B191.3DCC39C2@domain.hid>		<44A8BA2E.9090106@domain.hid>		<44A8D7A1.4E4E9D27@domain.hid>		<17577.4096.436840.354535@domain.hid>
	<17577.5372.702355.432641@domain.hid>
	<44AA0E21.3F17401F@vollmann.ch>
In-Reply-To: <44AA0E21.3F17401F@vollmann.ch>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF318FB4C9964A007B28059F4"
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
--------------enigF318FB4C9964A007B28059F4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Detlef Vollmann wrote:
> Gilles Chanteperdrix wrote:
>> You can even do this in __ipipe_mach_set_dec, this avoid the need to
>> modify I-ipipe non-machine specific code. Something like:
>>
>> void __ipipe_mach_set_dec(unsigned long delay)
>> {
>>     if (delay < 8)
>>         ipipe_trigger_irq(__ipipe_mach_timerint);
>>     else
>>         OSMR0 =3D OSCR + delay;
>> }
>=20
> Thanks, ipipe_trigger_irq() is exactly what I was looking for.
>=20
> I'll just add another test after the update of OSMR0 for the
> case that we got interrupted between the comparison and the
> assignment.  And in that (probably very rare) case I accept that
> I loose a timer tick :-(

It's this piece of code always running under IRQ-lock?

>=20
> Also, this way the timer comes a bit early, so any handler that
> checks the TSC might think that this is the wrong interrupt --
> and wait forever for the correct one.
> But the only other option would be the busy wait...
>=20
> The question about recursion remains:
> If a domain decides in its timer interrupt handler to reprogram
> the timer by calling __ipipe_mach_set_dec() (indirectly), and
> we already are too close to the next match, then that interrupt
> handler is called recursively.
> Is every ipipe domain expected to cope with this?
>=20

The IRQ is marked pending for the receiving domain if
ipipe_trigger_irq() is called when that domain is stalled - and that
should always be the case for ipipe_mach_set_dec(), at least when called
from the timer handler. The timer IRQ will then be handled once the
stall is removed again (on handler return e.g.).

Jan


--------------enigF318FB4C9964A007B28059F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqnatniDOoMHTA+kRAjQIAJ9fejV9kLULYHo5I5RLSAACeMewGwCeLaHK
AMe8oAo3BOtPyvY64wPuOv0=
=LsuF
-----END PGP SIGNATURE-----

--------------enigF318FB4C9964A007B28059F4--

