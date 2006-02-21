Message-ID: <43FAD26C.2030904@domain.hid>
Date: Tue, 21 Feb 2006 09:42:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	
	<b647ffbd0602160220we254aacx@domain.hid>
	<43F47705.90309@domain.hid>	
	<b647ffbd0602160558i4112313an@domain.hid>	
	<43F48832.7060804@domain.hid>	
	<b647ffbd0602161128t70d1f08ax@domain.hid>	
	<43F4E2D3.4010705@domain.hid>	
	<b647ffbd0602181204u518296fev@domain.hid>	
	<43F793AF.4080805@domain.hid> <43F9C9C1.60101@domain.hid>
	<b647ffbd0602200840v5f066d0bv@domain.hid>
In-Reply-To: <b647ffbd0602200840v5f066d0bv@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5809D7B4F2B1C5EE37C005CD"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5809D7B4F2B1C5EE37C005CD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> N.B. Amongst other things, some thoughts about CHAINED with shared
> interrupts.
>=20
>=20
> On 20/02/06, Anders Blomdell <anders.blomdell@domain.hid> wrote:
>=20
>=20
>=20
>> A number of questions arise:
>>
>> 1. What happens if one of the shared handlers leaves the interrupt
>> asserted,
>> returns NOENABLE|HANDLED and another return only HANDLED?
>>
>> 2. What happens if one returns PROPAGATE and another returns HANDLED?
>=20
>=20
> Yep, each ISR may return a different value and all of them are
> accumulated in the "s" variable ( s |=3D intr->isr(intr); ).
>=20
> So the loop may end up with "s" which contains all of the possible bits=
:
>=20
> (e.g.
>=20
> isr1 - HANDLED | ENABLE
> isr2 - HANDLED (don't want the irq to be enabled)
> isr3 - CHAINED
>=20
> )
>=20
> s =3D HANDLED | ENABLE | CHAINED;
>=20
> Then CHAINED will be ignored because of the following code :
>=20
> +    if (s & XN_ISR_ENABLE)
> +       xnarch_end_irq(irq);
> +    else if (s & XN_ISR_CHAINED)    (*)
> +       xnarch_chain_irq(irq);

Which may actually be fatal: consider one ISR intentionally not handling
an IRQ but propagating it while another ISR thinks it has to re-enable
it - bang! Anders' as well as my original suggestion were to ignore the
ENABLE in this case.

>=20
> the current code in the CVS doen not contain "else" in (*), so that ENA=
BLE |
> CHAINED is possible, though it's a wrong combination.
>=20
> This said, we suppose that one knows what he is doing.
>=20
> In the case of a single ISR per line, it's not that difficult to achiev=
e.
> But if there are a few ISRs, then one should analize and take into acco=
unt
> all possible return values of all the ISRs, as each of them may affect
> others (e.g. if one returns CHAINED when another - HANDLED | ENABLE).
>=20
> So my feeling is that CHAINED should not be used by drivers which regis=
tered
> their ISRs as SHARED.

That's true for standard drivers, but we should not prevent special
corner-case designs which can be tuned to make even shared RT-IRQs +
propagation possible. Sharing does not necessarily mean that different
RT drivers are involved...

>=20
> Moreover, I actually see the only scenario of CHAINED (I provided it be=
fore)
> :
>=20
> all ISRs in the primary domain have reported UNHANDLED  =3D>  nucleus
> propagates the interrupt down the pipeline with xnacrh_chain_irq().
> This call actually returns 1 upon successful propagation (some domain d=
own
> the pipeline was interested in this irq) and 0 otherwise.

But this only means that some handler is registered down there, it
cannot predict if that handler will actually care about the event.

>=20
> Upon 0, this is a spurious irq (none of domains was interested in its
> handling).
>=20
> ok, let's suppose now :
>=20
> we have 2 ISRs on the same shared line :
>=20
> isr1 : HANDLED (will be enabled by rt task. Note, rt task must call
> xnarch_end_irq() and not just xnarch_enable_irq()! )
>=20
> isr2 : CHAINED
>=20
> So HANDLED | CHAINED is ok for the single ISR on the line, but it may l=
ead
> to HANDLED | CHAINED | ENABLE in a case of the shared line.
>=20
> rt task that works jointly with isr1 just calls xnarch_end_irq() at som=
e
> moment of time and some ISR in the linux domain does the same later  =3D=
>  the
> line is .end-ed 2 times.
>=20
> ISR should never return CHAINED as to indicate _only_ that it is not
> interested in this irq, but ~HANDLED or NOINT (if we'll support it) ins=
tead.
>=20
> If the ISR nevertheless wants to propagate the IRQ to the Linux domain
> _explicitly_, it _must not_ register itself as SHARED, i.e. it _must_ b=
e the
> only ISR on this line, otherwise that may lead to the IRQ line being .e=
nd-ed
> twice (lost interrupts in some cases).
>=20
>=20
> #define UNHANDLED 0
>> #define HANDLED_ENABLE 1
>> #define HANDLED_NOENABLE 2
>> #define PROPAGATE 3
>=20
>=20
> Yep, I'd agree with you. Moreover, PROPAGATE should not be used for sha=
red
> interrupts.
>=20
>=20
> --
> Best regards,
> Dmitry Adamushko
>=20

Jan


--------------enig5809D7B4F2B1C5EE37C005CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD+tJsniDOoMHTA+kRAotSAJ0UHKEqDZ+IwV7GLL5HQqUkaWS5UACbB1gZ
wIADKlf3uNlqPEGs3nIH8Gg=
=vrRU
-----END PGP SIGNATURE-----

--------------enig5809D7B4F2B1C5EE37C005CD--

