Message-ID: <43663262.80303@domain.hid>
Date: Mon, 31 Oct 2005 16:04:02 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
In-Reply-To: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig34920A1FD389E391C51E28FC"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig34920A1FD389E391C51E28FC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hi Jan,
>=20
>> I have some code hanging around here which implements IRQ sharing at
>> skin level for an experimental in-house development over Xenomai. The
>> code is smart enough to register an IRQ sharing trampoline handler onl=
y
>> in case sharing is actually practiced for a specific line.
>=20
> Could you be a bit more specific on what is meant by "...sharing is
> actually practiced for a specific line"?

Ok, one have to remind that my existing code is built on top of the
non-sharing xnintr_xxx API. This means that I had to define a trampoline
ISR which does the loop over all registered end-user ISRs. And this
intermediate handler is only involved when A) the IRQ is sharable and B)
there is actually more than one ISR registered for it.

This "smartness" becomes obsolete when we embed a doubly-linked list
into xnintr_t and already iterate over it in xnintr_irq_handler().

>=20
> To my knowledge, the matter is only about whether a certain device (dri=
ver)
> permits the earlier obtained irq line to be shared with other devices.
> i.e. a driver [1] may succeed with an irq registration request in case
> another driver [2] already holds this line but both [1] and [2] have
> specified a SA_SHIRQ flag.

Yep.

>=20
>=20
>> I think it would be possible to break this out and generate a mainline=

>> patch. Anyway, the question for me is where to put this best, at skin
>> (RTDM?) or at nucleus level? Both is technically feasible, but which w=
ay
>> is desired? (I would vote for the nucleus...)
>=20
> If we have a policy that all the drivers should be implemented on top o=
f
> RTDM, then, it can be done there. If no (and I guess so), this feature
> should be common and I'd vote for the nucleus.

Drivers should be built over RTDM, that's true. But there may still be
driver-like applications, also in user space that attach directly to the
IRQs via the various skin APIs. I think it would be good to let them
live side-by-side with RTDM drivers or other IRQ-using applications.

> It seems to me now, that some parts of the hal will be involved
> (rthal_irq_request/release()) since the nucleus itself doesn't keep tra=
ck
> of registered irqs.

That's true. And it also raises another question to me: why do we have
those two different IRQ models?

The HAL only one handler per IRQ which get called with the triggering
IRQ number. That handler will call the nucleus with an attached cookie.
And on the other side is the nucleus which works with a xnintr_t per
IRQ. The xnintr_irq_handler() deals with things like re-enabling IRQs,
rescheduling, etc.

I'm asking as this abstraction adds one trampoline call (at HAL level),
thus may lead to more I-cache misses. Isn't it worth considering some
HAL mechanisms based on more #defines and static inlines in this regard?

Jan


--------------enig34920A1FD389E391C51E28FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDZjJjncNeS9Q0k+IRAsZTAJ9y1N+ZkuuCbxop9GE1uV2aAPYa7ACghb/1
PbONjxdSFHzQl+pIxtfjKGQ=
=GTXP
-----END PGP SIGNATURE-----

--------------enig34920A1FD389E391C51E28FC--

