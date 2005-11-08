Message-ID: <4370D2B8.8070608@domain.hid>
Date: Tue, 08 Nov 2005 17:30:48 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] scheduling order of dying shadow threads
References: <4370641D.7010906@domain.hid>
	<4370C966.3030903@domain.hid>
In-Reply-To: <4370C966.3030903@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBFA81F593A9772375B47688A"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBFA81F593A9772375B47688A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi Philippe,
>>
>> I think this one is for you: ;)
>>
>> Sebastian got almost mad with his CAN driver while tracing a strange
>> scheduling behaviour during shadow thread deletion for several days(!)=
 -
>> and I was right on the way to follow him yesterday evening. Attached i=
s
>> a simplified demonstration of the effect, consisting of a RTDM driver
>> and both a kernel and user space application to trigger it.
>>
>=20
> I've spotted the issue in nucleus/shadow.c. Basically, the root thread
> priority boost was leaking to a non-shadow thread due to a missing
> priority reset in the lostage APC handler, whilst a shadow was in the
> process of relaxing. Really funky bug, thanks! :o> Fixed in the repo
> hopefully for good. The scheduling sequence is now correct with your
> demo app on my box.
>=20

Yep, looks good here as well. Great and quick work! Just don't expect
that someone can follow your explanations easily. :)

I think this issue has some similarity with the one I once stumbled over
regarding non-RT signalling to Linux. I'm not going to repeat my general
concerns regarding the priority boosting of the root thread now... ;)

Jan


--------------enigBFA81F593A9772375B47688A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDcNK4ncNeS9Q0k+IRAp0iAKDYpmCfoF+3cuaFnLpw6OPKlHNHKgCgj5BJ
reJpBjxp0D5ctkogecMwDfk=
=8I50
-----END PGP SIGNATURE-----

--------------enigBFA81F593A9772375B47688A--

