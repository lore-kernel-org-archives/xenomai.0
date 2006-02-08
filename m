Message-ID: <43E9EEBA.1050405@domain.hid>
Date: Wed, 08 Feb 2006 14:14:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM mmap alternative
References: <20060203192739.87567.qmail@domain.hid>
	<200602061900.35411.lbocseg@domain.hid>
	<43E8DB10.5000901@domain.hid>
	<200602081043.47859.lbocseg@domain.hid>
In-Reply-To: <200602081043.47859.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5B9621BC666523A80984E92A"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5B9621BC666523A80984E92A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
>> ...
>> I tested it (after figuring out what to do at all, and how to get it
>> working then...) with a simple demo that returns a shared kernel memor=
y
>> block, mapped into user-space via an RTDM-IOCTL. I think you should
>> easily (now really!) adapt it to your needs. Please check if this
>> functions meets your requirements and works for more than one scenario=
=2E
>> If so, I will add it to official RTDM.
>>
>>
>> @all: I would be curious to hear any comment on my /dev/zero-trick to
>> invoke mmap in kernel-space. Is this an ugly hack or may it be worth
>> considering to apply on /dev/rtheap as well - to overcome the need for=

>> this device (and related user errors...)?
>=20
> Jan, actually I didn't like the /dev/zero hack. If someone else is=20
> using /dev/zero it will result in a problem... I think it would be bett=
er to=20

Why? It isn't an exclusive device. And I'm only invoking open/close on
the original instance (which even have no handlers associated, see
drivers/char/mem.c), mmap gets overloaded.

> reserve a separate file descriptor for mmaping. Maybe in a separate mod=
ule=20
> like xeno_mmap that only register a, say, /dev/xenommap or /dev/xenomai=
/mmap.=20
> I think it would be a better approach. Or maybe something like=20
>=20
> void *rtdm_mmap_to_user(void *buffer, size_t length, char *dev_to_use)
>=20
> Just some ideas...

Maybe I'm overseeing something: Did you face real problems with my approa=
ch?

Jan


--------------enig5B9621BC666523A80984E92A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD6e66niDOoMHTA+kRAt2wAJ4o9ilLYweH5stCELhc+ntlliDCDgCeKvum
MQSyBDR6xN56m3ME3zDghfE=
=3yRi
-----END PGP SIGNATURE-----

--------------enig5B9621BC666523A80984E92A--

