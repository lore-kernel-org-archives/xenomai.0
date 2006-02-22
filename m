Message-ID: <43FCDEB0.30704@domain.hid>
Date: Wed, 22 Feb 2006 22:59:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	
	<b647ffbd0602200840v5f066d0bv@domain.hid>	
	<43FAD322.4060001@domain.hid>	
	<b647ffbd0602210254p19086a0au@domain.hid>	
	<43FAF94C.4080709@domain.hid>	
	<43FAFE58.5060201@domain.hid>	
	<b647ffbd0602210848g321ffedei@domain.hid>	
	<43FB480E.9020808@domain.hid> <43FB529B.3040207@domain.hid>	
	<43FB6102.1070004@domain.hid>
	<b647ffbd0602220445k749d630j@domain.hid>
In-Reply-To: <b647ffbd0602220445k749d630j@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2ADFE368D6EE56FDEDD52A5F"
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
--------------enig2ADFE368D6EE56FDEDD52A5F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
>> For RTDM I'm now almost determined to rework the API in way that only
>> HANDLED/UNHANDLED (or what ever their names will be) get exported, any=

>> additional guru features will remain excluded as long as we have no
>> clean usage policy for them.
>=20
> Good. Then let's go for
>=20
> HANDLED, UNHANDLED - we may consider them even as 2 scalar values

Ok, just avoid the 0.

>=20
> +
>=20
> NOENABLE, CHAINED  - additional bits.
>=20
> They are not encouraged to be used with shared interrupts
> (explained in docs + debug messages when XENO_OPT_DEBUG is on).
>=20
> Any ISR on the shared irq line should "understand" that it's
> just one among the equals. That said, it should not do anything
> that may affect other ISRs and not require any special treatment
> (like CHAINED or NOENABLE).
> If it wants it indeed, then don't declare itself as SHARED.
>=20
> We may come back to the topic about possible return values of ISRs
> a bit later maybe having got more feedback (hm.. hopefully)
> on shared irq support.
>=20
>=20
>>>> But the later one is not only about enabling the line, but
>>>> on some archs - about .end-ing it too (sending EOI).
>>>>
>>>> And to support HANDLED_NOENABLE properly, those 2 have to be
>>>> decoupled, i.e.
>>>> EOI should always be sent from xnintr_shirq_handler().
>>> But the one returning HANDLED_NOENABLE is likely to leave the interru=
pt
>>> asserted, hence we can't EOI at this point (unless NO_ENABLE means
>>> DISABLE).
>> I guess this is what Dmitry meant: explicitly call disable() if one or=

>> more ISRs returned NOENABLE - at least on archs where end !=3D enable.=

>> Will this work? We could then keep on using the existing IRQ-enable AP=
I
>>from bottom-half IRQ tasks.
>=20
> Almost.
>=20
> Let's consider the following only as anorther way of doing some things;=

> I don't propose to implement it, it's just to illustrate my thoughts.
> So one may simply ski-skip-skip it :o)
>=20
> Let's keep in mind that what is behind .end-ing the IRQ line depends on=

> archs.
> Sometimes end =3D=3D enable (EOI was sent on .ack step), while in other=
 cases
> end =3D=3D send_EOI [+ re-enabling].
>=20
> But anyway, all ISRs are running with a given IRQ line disabled.
>=20
> Supported values : HANDLED, UNHANDLED, PROPAGATE.
>=20
> nucleus :: xnintr_irq_handler()
> {
>     ret =3D 0;
>=20
>     ...
>=20
>     for each isr in isr_list[ IRQ ]
>     {
>     temp =3D isr->handler();
>=20
>     if (temp > ret)
>         ret =3D temp;
>     }
>=20
>     if (ret =3D=3D PROPAGATE)
>     {
>     // quite dengerous with shared interrupts, be sure you understand
>     // what you are doing!
>=20
>     xnarch_chain_irq(irq); // will be .end-ed in Linux domain
>     }
>     else
>     {
>     // HANDLED or UNHANDLED
>=20
>     xnarch_end_irq();
>     }
>=20
>     ...
>=20
> }
>=20
> ENABLE or NOENABLE is missing? Nop.
>=20
> let's say we have 2 rt-ISRs :
>=20
> isr1 : HANDLED
> isr2 : HANDLED + WISH
>=20
> WISH =3D=3D I want the IRQ line remain disabled until later
>         (e.g. bottom half in rt_task will enable it)
>=20
> How may isr2 express this WISH? Simply, xnarch_irq_disable/enable() sho=
uld
> support an internal counter that allows them to be called in a nested w=
ay.
>=20
> So e.g. if there are 2 consecutive calls to disable_irq(), then
> 2 calls to enable_irq() are needed to really enable the IRQ line.
>=20
> This way, the WISH is only about directly calling xnarch_irq_disable() =
in
> isr2
> and there is no need in ENABLE or NOENABLE flags.
>=20
> This way, PROPAGATE really means NOEND - the IRQ will be .end-ed in Lin=
ux
> domain;
> while WISH=3D=3DNOENABLE - has nothing to do with sending EOI, but only=
 with
> enabling/disabling the given IRQ line.
>=20
> Yes, if one isr (or a few) defers the IRQ line enabling until later, it=
 will
> affect
> all others ISR =3D> all interrupts are temporary not accepted on this l=
ine.
> This scenario is possible under Linux, but should be used with even mor=
e
> care in real-time system. At least, this way HANDLED_NOENABLE case work=
s
> and doesn't lead to lost interrupts on some archs.
>=20
> Moreover, it avoids the need for ENABLE flag even in non-shared interru=
pt
> case.
>=20

Yep, really looks like this is the best way to go.

Jan


--------------enig2ADFE368D6EE56FDEDD52A5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD/N6wniDOoMHTA+kRAt+cAJ9IiBj3IKxNK8brCOzi0fO26hO90QCfXaNh
O1zSGP+h4r6xOiej7w1zprk=
=i9NJ
-----END PGP SIGNATURE-----

--------------enig2ADFE368D6EE56FDEDD52A5F--

