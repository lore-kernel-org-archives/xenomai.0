Message-ID: <43677A2B.20600@domain.hid>
Date: Tue, 01 Nov 2005 15:22:35 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
	<200510312121.14160.dmitry.adamushko@domain.hid>
	<43675853.1000209@domain.hid>
	<200511011431.12506.dmitry.adamushko@domain.hid>
In-Reply-To: <200511011431.12506.dmitry.adamushko@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2DDB6F8AA54112640E64D7CD"
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
--------------enig2DDB6F8AA54112640E64D7CD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On Tuesday 01 November 2005 12:58, you wrote:
>=20
>>> as "cockie" to the xnintr_irq_handler().
>>>
>>> The analogy is irq_desc_t vs. irqaction structures in Linux.
>>>
>>> This way, xnintr_irq_handler() can be called from adeos-ipipe layer
>>> directly without the [2] layer.
>>>
>>> But that change looks quite invasive to me so far since
>>> ipipe_domain::irqs::handler(irq - with a single parameter) is used al=
l
>>> over the map.
>> I'd really prefer making one invasive change early in the process of
>> addressing the issue than several kludges later to work around structu=
ral
>> shortcomings, so no problem, go wild, I'm all ears.
>>
>=20
> If we only want to get rid of the trampoline-thing then [2] + [3] would=
 work=20
> out (btw, I have sent a message this morning where I tried to provide e=
ven=20
> some pseudo-code :)=20
>=20
> But if we want to (think that we may) gain the adventage of having a mo=
re=20
> flexible irq-related support from the ipipe layer, then yep, those chan=
ges=20
> might look worthy. I thought that this way, we would even get rid of an=
other=20
> per-irq (rthal_realtime_irq) array in hal/generic.c, maybe even from=20
> rthal_linux_irq too. The sole one is provided by the ipipe_domain struc=
ture=20
> and a set of generic interfaces e.g. via system.h so that the HAL or an=
other=20
> layer may get access of it.
>=20
> e.g.
>=20
> the "cookie" remains opaque for the ipipe but when requested by=20
> HAL::rthal_irq_request() or NUCLEUS::xnintr_irq_handler() it's treated =
as a=20
> chain of ISR handlers.
>=20

Yep, that's also what I had in mind about potential ipipe changes and
their use in the nucleus.

Jan



--------------enig2DDB6F8AA54112640E64D7CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDZ3orncNeS9Q0k+IRAubLAJ0cuV8oI/9zqv5x/y8NYbXpXMQ9JQCeO2ZF
KrTapiPmlSrsJoKMsbH8kWE=
=p9nO
-----END PGP SIGNATURE-----

--------------enig2DDB6F8AA54112640E64D7CD--

