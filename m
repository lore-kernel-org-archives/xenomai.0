Message-ID: <4368C789.1090605@domain.hid>
Date: Wed, 02 Nov 2005 15:04:57 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
References: <OF28F322D2.5578F6D9-ONC12570AD.003C7FD4-C12570AD.00491DDF@datacon.at>
In-Reply-To: <OF28F322D2.5578F6D9-ONC12570AD.003C7FD4-C12570AD.00491DDF@datacon.at>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC592AEFC9EC80D20B1535D9F"
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
--------------enigC592AEFC9EC80D20B1535D9F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
>>>> [...]
>=20
>>>> e.g.
>>>>
>>>> the "cookie" remains opaque for the ipipe but when requested by
>>>> HAL::rthal_irq_request() or NUCLEUS::xnintr_irq_handler() it's treat=
ed
> as a
>>>> chain of ISR handlers.
>>>>
>>>
>>> Yep, that's also what I had in mind about potential ipipe changes and=

>>> their use in the nucleus.
>>>
>> Ok, let's go for those changes this way:
>>
>> 1. The I-pipe series needs to be updated so that an opaque cookie
> ispassed to
>> the handler; since we have a change in the interface, the 1.1 seriesha=
s
> to be
>> started for this purpose.
>>
>> 2. In order to let the people running the legacy RTAI/fusion and
>> Xenomai 2.0.x
>> series a reasonable amount of time to upgrade their patchset, the IRQ
> layer
>> updates (sharing and trampoline suppression) will go to the Xenomai 2.=
1
> dev
>> branch. IOW, Xenomai 2.1 will be exclusively based on the I-pipe 1.1
> series,
>> which also means that Xenomai support for the oldgen Adeos and I-pipe =
1.0
>=20
>> patches will be discontinued after the Xenomai 2.0.x series is closed.=

>>
>> 3. Changes in the IRQ layer will be made at nucleus level, which is th=
e
> most
>> efficient way to provide them.
>>
>=20
> Ok, I'd take this task (err.. since I'm not doing anything useful for
> Xenomai at the moment). Although, I may start not earlier than next wee=
k.
> Jan, since you have come up with the initial proposol and maybe you nee=
d
> get that new code working asap, it's up to you to handle it on your own=
 :o)
> Just let me know in that case.
>=20

Thanks for the helping hand. I will be really happy if you could realise
this.

It's also not yet burning on our side. I guess we will be busy enough to
get a few devices running, to have ALL running with potentially shared
IRQs can be scheduled later.

Hope we will be able to continue with more detailed discussions tomorrow
evening!

Jan


--------------enigC592AEFC9EC80D20B1535D9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDaMeJncNeS9Q0k+IRAgkkAJ9U4Jg14jnPHc071tjMKMsRm/i3UgCdFcNB
A5BIZ1+wYEYBBrOPtLL1efs=
=YMpY
-----END PGP SIGNATURE-----

--------------enigC592AEFC9EC80D20B1535D9F--

