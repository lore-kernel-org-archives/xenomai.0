Message-ID: <44A8E555.3080800@domain.hid>
Date: Mon, 03 Jul 2006 11:37:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator
	vs.	PXA)
References: <44A3919C.596DFDAE@vollmann.ch>	<1151592402.19389.31.camel@domain.hid>	<44A4C4CB.5F24DA68@domain.hid>	<1151657621.3060.26.camel@domain.hid>
	<44A8B191.3DCC39C2@domain.hid> <44A8BA2E.9090106@domain.hid>
	<44A8D7A1.4E4E9D27@domain.hid>
In-Reply-To: <44A8D7A1.4E4E9D27@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5F83E09E521DF10879B353BF"
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
--------------enig5F83E09E521DF10879B353BF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Detlef Vollmann wrote:
> Jan Kiszka wrote:
>> Detlef Vollmann wrote:
>>>>> Now I have another question on this: on the PXA I have a hardware
>>>>> problem so that I must sometimes set the next match value to the
>>>>> match value after the next one, so effectively loosing one
>>>>> interrupt.
>> Just out of curiosity: What is the technical background of this issue?=

>> Does it mean that the hardware is not able to trigger a timer event ov=
er
>> a certain period of time and you therefore have to defer the event unt=
il
>> this is possible again? Do you know ahead of time when this will happe=
n?
>> Or only when you try to set the timer and the hardware tells you about=

>> it somehow?
> Here's the original comment and code from
>  linux/arch/arm/mach-pxa/time.c:
>=20
>     /* Loop until we get ahead of the free running timer.
>      *
>      * HACK ALERT: it seems that the PXA timer regs aren't updated righ=
t
>      * away in all cases when a write occurs.  We therefore compare wit=
h
>      * 8 instead of 0 in the while() condition below to avoid missing a=

>      * match if OSCR has already reached the next OSMR value.
>      * Experience has shown that up to 6 ticks are needed to work aroun=
d
>      * this problem, but let's use 8 to be conservative.  Note that thi=
s
>      * affect things only when the timer IRQ has been delayed by nearly=

>      * exactly one tick period which should be a pretty rare event.
>      */
>     do {
>         timer_tick(regs);
>         OSSR =3D OSSR_M0;  /* Clear match on timer 0 */
>         next_match =3D (OSMR0 +=3D LATCH);
>     } while( (signed long)(next_match - OSCR) <=3D 8 );
>=20
>> Looks like designing a real-time application around such a quirk isn't=

>> that easy.
> It's not so difficult to work around the problem for a single system.
> What's difficult is to find a solution in a framework that wasn't
> built with such a problem in mind.

Indeed, but it should only require minimal changes to
rthal_timer_program_shot on arm (handle a potential return code of
__ipipe_mach_set_dec() as already suggested). Take a look at the i386
variant [1], how this one handles re-triggering of near-by ticks. I
don't see why busy-waiting should be required here to get the same
characteristics like the Linux code above. Or does Linux miss ticks even
with that "hack"?

Jan

[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/include/asm-i386/hal=
=2Eh?v=3DSVN-trunk#L178


--------------enig5F83E09E521DF10879B353BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqOVbniDOoMHTA+kRAr9iAJ9TxeI2AbYyiuwOvlp8XSF8bysk1gCfTOHs
gTFvA9W4TbJSJVCFxhw+Cg8=
=2GAJ
-----END PGP SIGNATURE-----

--------------enig5F83E09E521DF10879B353BF--

