Message-ID: <43FAD1D5.2050601@domain.hid>
Date: Tue, 21 Feb 2006 09:39:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>		<43F3C4EA.7050303@domain.hid>	<b647ffbd0602160220we254aacx@domain.hid>		<43F47705.90309@domain.hid>	<b647ffbd0602160558i4112313an@domain.hid>		<43F48832.7060804@domain.hid>		<b647ffbd0602161128t70d1f08ax@domain.hid>		<43F4E2D3.4010705@domain.hid>	<b647ffbd0602181204u518296fev@domain.hid>
	<43F793AF.4080805@domain.hid> <43F9C9C1.60101@domain.hid>
In-Reply-To: <43F9C9C1.60101@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig87EFEEE79E7CEB75A780091D"
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
--------------enig87EFEEE79E7CEB75A780091D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Anders Blomdell wrote:
> Jan Kiszka wrote:
>> Hi Dmitry,
>>
>> Dmitry Adamushko wrote:
>>
>>> Hi Jan,
>>>
>>> let's make yet another revision of the bits :
>>>
>>> new XN_ISR_HANDLED  =3D=3D old XN_ISR_HANDLED + old XN_ISR_NO_ENABLE
>>>
>>> ok.
>>>
>>> new XN_ISR_NOENABLE =3D=3D ~ old XN_ISR_ENABLE
>>>
>>> ok.
>>>
>>> new XN_ISR_PROPAGATE =3D=3D XN_ISR_CHAINED
>>>
>>> ok.
>>>
>>
>>
>> Just to make sure that you understand my weird ideas: each of the thre=
e
>> new XN_ISR_xxx above should be encoded with an individual bit
>>
>>
>>> new XN_ISR_NOINT =3D=3D ?
>>>
>>> does it suppose the interrupt line to be .end-ed (enabled) and irq
>>> not to be
>>> propagated? Should be so, I guess, if it's different from 5). Then
>>> nucleus
>>> ignores implicit IRQ enable for 5) as well as for 3).
>>>
>>> Do we really need that NOINT then, as it seems to be the same as
>>> ~HANDLED?
>>>
>>> or NOINT =3D=3D 0 and then it's a scalar value, not a bit.
>>>
>>> So one may consider HANDLED =3D=3D 1 and NOINT =3D=3D 0 as really sca=
lar values
>>>
>>> and
>>>
>>> NOENABLE and PROPAGATE as additional bits (used only if needed).
>>>
>>
>>
>> My idea is to urge the user specifying one of the base return types
>> (HANDLED or NOINT) + any of the two additional bits (NOENABLE and
>> PROPAGATE).
>>
>> For correct drivers NOINT could be 0 indeed, but to check that the use=
r
>> picked a new constant we may want to set NOINT !=3D 0. With the old AP=
I
>> "return 0" expressed HANDLED + ~ENABLE for the old API. With the new o=
ne
>> the user signals no interest and the nucleus may raise a warning that =
a
>> spurious IRQ occurred. So I would add a debug bit for NOINT here to
>> optionally (on OPT_XENO_DEBUG) detect old-style usage (return 0).
>> Moreover, we gain freedom to move bits in the future when every state =
is
>> encoded via constants. Or am I too paranoid here?
> After reading the above discussion (of which I understand very little),=

> and looking at (what I believe to be) the relevant code:
>=20
> +    intr =3D shirq->handlers;
> +
> +    while (intr)
> +        {
> +        s |=3D intr->isr(intr);
> +        ++intr->hits;
> +        intr =3D intr->next;
> +        }
> +    xnintr_shirq_unlock(shirq);
> +
> +    --sched->inesting;
> +
> +    if (s & XN_ISR_ENABLE)
> +       xnarch_end_irq(irq);
> +    else if (s & XN_ISR_CHAINED)
> +       xnarch_chain_irq(irq);
>=20
> A number of questions arise:
>=20
> 1. What happens if one of the shared handlers leaves the interrupt
> asserted, returns NOENABLE|HANDLED and another return only HANDLED?
>=20
> 2. What happens if one returns PROPAGATE and another returns HANDLED?
>=20
> As far as I can tell, after all RT handlers havve run, the following
> scenarios are possible:
>=20
> 1. The interrupt is deasserted (i.e. it was a RT interrupt)
> 2. The interrupt is still asserted, it will be deasserted later
>    by some RT task (i.e. it was a RT interrupt)
> 3. The interrupt is still asserted and will be deasserted
>    by the Linux IRQ handler.
>=20
> IMHO that leads to the conclusion that the IRQ handlers should return a=

> scalar
>=20
> #define UNHANDLED 0
> #define HANDLED_ENABLE 1
> #define HANDLED_NOENABLE 2
> #define PROPAGATE 3
>=20
> and the loop should be
>=20
>     s =3D UNHANDLED
>     while (intr) {
>       tmp =3D intr->isr(intr);
>       if (tmp > s) { s =3D tmp; }
>       intr =3D intr->next;
>     }
>     if (s =3D=3D PROPAGATE) {
>       xnarch_chain_irq(irq);
>     } else if (s =3D=3D HANDLED_ENABLE) {
>       xnarch_end_irq(irq);
>     }

This is a very useful suggestion, specifically this escalation of the
return value in the shared case. I would just let UNHANLDED start with 1
for the reasons I explained here:

https://mail.gna.org/public/xenomai-core/2006-02/msg00186.html

Ok, I would say let's got for this and finalise the patch!

>=20
> To be really honest, I think that PROPAGATE should be excluded from the=

> RT IRQ-handlers, since with the current scheme all RT-handlers has to
> test if the IRQ was a Linux interrupt (otherwise the system will only
> work when the handler that returns PROPAGATE is installed)
>=20

Indeed, but I'm with Philippe here: do not exclude the strange corner
case scenarios users may craft with the appropriate care. I could, e.g.,
imagine a scenario where an RT handler takes the arrival time stamp of a
non-RT IRQ and then propagates it.

Jsn


--------------enig87EFEEE79E7CEB75A780091D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD+tHaniDOoMHTA+kRAqBeAJwM+im6ZRJZFeEwKW8bRRS8XXIYOgCcDRW0
qS82TC/+TMtayiSnk+3ktIk=
=BMJp
-----END PGP SIGNATURE-----

--------------enig87EFEEE79E7CEB75A780091D--

