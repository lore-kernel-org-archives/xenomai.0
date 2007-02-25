Message-ID: <45E15EB4.6090107@domain.hid>
Date: Sun, 25 Feb 2007 11:02:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45D9DF65.9000300@domain.hid> <45D9E59B.8040002@domain.hid>
	<45E0AF7F.1070506@domain.hid>
In-Reply-To: <45E0AF7F.1070506@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig07948FE775B81D92B37E8470"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: RT-Socket-CAN versioning
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07948FE775B81D92B37E8470
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hi Jan,
>=20
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Hi Jan,
>>>
>>> currently the RT-Socket-CAN drivers maintains it's own version or
>>> release number. As RT-Socket-CAN is part of Xenomai, I do not see the=

>>> need for it (and so far I did not update it). What is the intended us=
e
>>> of "driver_version" in "struct rtdm_device"?
>>
>> Actually, I was thinking about this too yesterday. The idea of the
>> separate versioning for RTDM drivers is to signal the users if somethi=
ng
>> in the driver really changed. It's fairly obvious what to do with it f=
or
>> out-of-tree drivers, but for in-tree it might be worth considering the=

>> policy.
>>
>> The current model, maintained more or less properly for the existing
>> drivers, is to increment independently of Xenomai according to major o=
r
>> minor changes. One may ease this burden for the driver developer by
>> simply filling in Xenomai's version here. That would just let the
>> revisions increase on every Xenomai release, even if the driver remain=
ed
>> untouched. The tag would still have a meaning for out-of-tree drivers,=

>> but for in-tree it would be fairly meaningless.
>>
>> Well, whatever is commonly preferred, it should then be applied
>> consistently on all RTDM drivers in Xenomai. What are the opinions on
>> this list (I will comment afterwards)?
>=20
> OK, no other opinions so far. Then let's keep the current versioning

I guess everyone's busy with more serious issues.

> scheme. I'm going to boost the RT-Socket-CAN version number to 0.90.0
> with the next commit and to 1.0.0 for the next official release (2.4.x?=
).

Ack. That's preferred from my side as well.

Jan


--------------enig07948FE775B81D92B37E8470
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF4V60niDOoMHTA+kRAqfJAJ4qZ01tFMm3TPPJmo26oeWjUZd69ACfZOzM
gN72Mn+gQwckSw6O3Fnbqus=
=st8N
-----END PGP SIGNATURE-----

--------------enig07948FE775B81D92B37E8470--

