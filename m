Message-ID: <43FAFE58.5060201@domain.hid>
Date: Tue, 21 Feb 2006 12:49:44 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>		<b647ffbd0602160558i4112313an@domain.hid>		<43F48832.7060804@domain.hid>		<b647ffbd0602161128t70d1f08ax@domain.hid>		<43F4E2D3.4010705@domain.hid>		<b647ffbd0602181204u518296fev@domain.hid>		<43F793AF.4080805@domain.hid>
	<43F9C9C1.60101@domain.hid>		<b647ffbd0602200840v5f066d0bv@domain.hid>		<43FAD322.4060001@domain.hid>	<b647ffbd0602210254p19086a0au@domain.hid>
	<43FAF94C.4080709@domain.hid>
In-Reply-To: <43FAF94C.4080709@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig53F129BDF94983C7D4135309"
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
--------------enig53F129BDF94983C7D4135309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Anders Blomdell wrote:
> Dmitry Adamushko wrote:
>>
>> On 21/02/06, *Anders Blomdell* <anders.blomdell@domain.hid
>> <mailto:anders.blomdell@domain.hid>> wrote:
>>
>>     Dmitry Adamushko wrote:
>>      >
>>      > N.B. Amongst other things, some thoughts about CHAINED with sha=
red
>>      > interrupts.
>>      >
>>      >
>>      > On 20/02/06, *Anders Blomdell* < anders.blomdell@domain.hid=

>>     <mailto:anders.blomdell@domain.hid>
>>      > <mailto:anders.blomdell@domain.hid
>>     <mailto:anders.blomdell@domain.hid>>> wrote:
>>      >
>>      >
>>      >
>>      >     A number of questions arise:
>>      >
>>      >     1. What happens if one of the shared handlers leaves the
>>     interrupt
>>      >     asserted,
>>      >     returns NOENABLE|HANDLED and another return only HANDLED?
>>      >
>>      >     2. What happens if one returns PROPAGATE and another return=
s
>>     HANDLED?
>>      >
>>      >
>>      > Yep, each ISR may return a different value and all of them are
>>      > accumulated in the "s" variable ( s |=3D intr->isr(intr); ).
>>      >
>>      > So the loop may end up with "s" which contains all of the
>>     possible bits:
>>      >
>>      > (e.g.
>>      >
>>      > isr1 - HANDLED | ENABLE
>>      > isr2 - HANDLED (don't want the irq to be enabled)
>>      > isr3 - CHAINED
>>      >
>>      > )
>>      >
>>      > s =3D HANDLED | ENABLE | CHAINED;
>>      >
>>      > Then CHAINED will be ignored because of the following code :
>>      >
>>      > +    if (s & XN_ISR_ENABLE)
>>      > +       xnarch_end_irq(irq);
>>      > +    else if (s & XN_ISR_CHAINED)    (*)
>>      > +       xnarch_chain_irq(irq);
>>     Which is the worst way possible of prioritizing them, if a Linux
>>     interrupt is
>>     active when we get there with ENABLE|CHAINED, interrupts will be
>>     enabled with
>>     the Linux interrupt still asserted -> the IRQ-handlers will be
>>     called once more,
>>     probably returning ENABLE|CHAINED again -> infinite loop...
>>
>>      >
>>      > the current code in the CVS doen not contain "else" in (*), so
>> that
>>      > ENABLE | CHAINED is possible, though it's a wrong combination.
>>      >
>>      > This said, we suppose that one knows what he is doing.
>>      >
>>      > In the case of a single ISR per line, it's not that difficult t=
o
>>      > achieve. But if there are a few ISRs, then one should analize a=
nd
>>     take
>>      > into account all possible return values of all the ISRs, as eac=
h
>>     of them
>>      > may affect others (e.g. if one returns CHAINED when another -
>>     HANDLED |
>>      > ENABLE).
>>     Which is somewhat contrary to the concept of shared interrupts, if=

>>     we have to
>>     take care of the global picture, why make them shared in the first=

>>     place?
>>     (I like the concept of shared interrupts, but it is important that=

>>     the framework
>>     gives a separation of concerns)
>>
>>
>> Unfortunately, it looks to me that the current picture (even with your=

>> scalar values) requires from the user who develops a given IRQ to take=

>> into account the possible return values of other ISRs.
>>
>> As I pointed out, the situation when 2 ISRs return HANDLED_NOENABLE
>> may lead to problems on some archs.
> Good point, leaves us with 2 possible return values for shared handlers=
:
>=20
>   HANDLED
>   NOT_HANDLED
>=20
> i.e. shared handlers should never defer the end'ing of the interrupt
> (which makes sense, since this would affect the other [shared] handlers=
).
>=20

Yes, "should". And this "should" is best be handled by

a) Documenting the potential conflict in the same place when describing
the return values

b) Placing some debug warning in the nucleus' IRQ trampoline function to
bail out (once per line) when running into such situation

But I'm against any further runtime restrictions, especially as most
drivers will never return anything else than NOT_HANDLED or HANDLED.
Actually, this was the reason why I tried to separate the NO_ENABLE and
PROPAGATE features as *additional* bits from HANDLED and
NOT_HANDLED/UNHANDLED/NOINT. But I acknowledge that having all valid bit
combination present as constants can be more helpful for the user. We
just have to draw some line between the standard values and the
additional gurus return codes (documentation: "don't use NO_ENABLE or
PROPAGATE unless you understand their side-effects and pitfalls precisely=
").

Jan


--------------enig53F129BDF94983C7D4135309
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD+v5YncNeS9Q0k+IRAmO2AJ9/theu1sIbqKir97HactD70WzeMACfV/RX
4WgS3TI+GdYFoCAnPjNCJBE=
=nps7
-----END PGP SIGNATURE-----

--------------enig53F129BDF94983C7D4135309--

