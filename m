Message-ID: <4656C9AB.1040903@domain.hid>
Date: Fri, 25 May 2007 13:34:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4656C2D0.7000705@domain.hid> <4656C583.5040303@domain.hid>
	<4656C784.9090200@domain.hid>
In-Reply-To: <4656C784.9090200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDF1FD7F8A7915D0EACEB5552"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Problem with interrupt enabling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF1FD7F8A7915D0EACEB5552
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Johan Borkhuis wrote:
> Jan Kiszka wrote:
>> Johan Borkhuis wrote:
>> =20
>>> Hello,
>>>
>>> I am trying to create an RTDM interrupt handler for an external
>>> interrupt. I use a rtdm_irq_request, followed by a rtdm_irq_enable.
>>> This    =20
>>
>> The rtdm_irq_enable is no longer required with RTDM revision 6 and
>> higher. But that's trunk, it's rev. 5 which still comes with Xenomai
>> 2.3.x. And the enable will also cause no harm with rev. 6.
>>  =20
>=20
> I did see some references to the fact that it is no longer needed in th=
e
> future. I am running 2.3.1, so for the moment I will leave it in.
>=20
>>> caused one interrupt to be processed, but subsequent interrupts were
>>> not processed.
>>> After adding an extra rtdm_irq_enable to the ISR the interrupts are
>>> processed. When I look at the other drivers I don't see this. Is this=

>>> needed, or is there a bug/feature in the interrupt handling on my
>>> platform?
>>> (I use a MVME3100 with a ppc8540 processor and openPIC interrupt
>>> controller).
>>>    =20
>>
>> What do you return with your IRQ handler? RTDM_IRQ_HANDLED?
>>  =20
> Yes, I do return RTDM_IRQ_HANDLED.

OK, then your code should be fine. Which I-pipe patch are you using?

>=20
>> That explicit rtdm_irq_enable is not required by design, would rather =
be
>> a bug on certain platforms (where enable !=3D end IRQ), and indicates =
that
>> something else is broken, maybe in Xenomai.
>>  =20
>=20
> This driver is ported from a standard Linux driver, and in this driver
> an extra call is also not needed.

Yep. Sounds like a BUG in I-pipe for me (PPC over Xenomai in general is
known to be fine). Wolfgang, Philippe, any ideas if/why we might lack
proper IRQ ending here?

Jan


--------------enigDF1FD7F8A7915D0EACEB5552
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVsmsniDOoMHTA+kRArXOAJ0eaER02dV8QX21NtxsjPo1xlIp0QCfeWKd
YJ7SGF1wLBgup98gWLsn6iM=
=Ndju
-----END PGP SIGNATURE-----

--------------enigDF1FD7F8A7915D0EACEB5552--

