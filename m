Message-ID: <454F125F.6040507@domain.hid>
Date: Mon, 06 Nov 2006 11:45:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Virtual CAN driver and RT Socket CAN
References: <54b161f50611060005w3f65a255qa98da9259cecee0b@domain.hid>	<454EF06A.8070207@domain.hid>
	<54b161f50611060208m44287fb6o5ac0f305e21d08d7@domain.hid>
In-Reply-To: <54b161f50611060208m44287fb6o5ac0f305e21d08d7@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2F5BBC1FD4CC8F74A714AE73"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2F5BBC1FD4CC8F74A714AE73
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Frits de Klark wrote:
> On 11/6/06, Wolfgang Grandegger <wg@domain.hid> wrote:
>>
>> Frits de Klark wrote:
>> > Hello everyone,
>> >
>> > I'm not sure this is the right place to ask about it, but is the
>> virtual
>> > CAN driver mentioned in [1] of any use if I want to develop an
>> > application using RT Socket CAN? If so, how do I set it up (just pat=
ch
>> > the xenomai-root I guess) and how do I use it?
>>
>> The virtual CAN driver is already integrated in recent versions of
>> Xenomai 2.3-devel, e.g. 2.3-rc1. Just install Xenomai as usual and
>> enable RT-Socket-CAN and the driver virtual CAN driver in the kernel
>> configuration.
>>
>> Wolfgang.
>>
>=20
> Ah, thanks. It's called the 'virtual tunneling driver' in the kernel
> config,
> right?

Yeah, it is. Probably "tunneling" is not the best term here, "Virtual
CAN bus driver" should be better - will fix.

>=20
> But now for my second question: How do I set it up? Is it possible to u=
se
> the virtual driver to run the rtcansend/recv programs? If so, what acti=
ons
> should I take to make this possible?

Load the driver and it will provide you two CAN ports that are virtually
interconnected (play with "devices" module param to gain more ports on
the bus). You will have to configure both ports with rtcanconfig, and
then tools like rtcansend/recv our your own applications can communicate
over that bus.

Jan


--------------enig2F5BBC1FD4CC8F74A714AE73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFTxJfniDOoMHTA+kRAiNbAJ4u5EpIVejRZZVsvZEyZdKnWudDVQCdEkus
JUqaG5kWiXhYa2NYC+VvPzI=
=L3Ei
-----END PGP SIGNATURE-----

--------------enig2F5BBC1FD4CC8F74A714AE73--

