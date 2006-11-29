Message-ID: <456D4ED4.5040405@domain.hid>
Date: Wed, 29 Nov 2006 10:11:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [RFC][PATCH 1/2] rework shadow CPU affinity
References: <456C3EF9.30102@domain.hid> <456C8961.7060906@domain.hid>
	<456C97B9.1000402@domain.hid> <456D4C7D.2040100@domain.hid>
In-Reply-To: <456D4C7D.2040100@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0A3350A696358AAB0A4D9DD9"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A3350A696358AAB0A4D9DD9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Picking up the earlier discussion of CPU affinity of shadow threads,=

>>>> this patch now opens the possibility to assign a CPU mask on
>>>> xnshadow_map. It cleans up the related nucleus code and updates all
>>>> callers of xnshadow_map appropriately.
>>>>
>>>> Be warned, it's only tested on (q)emulated SMP. Comments and test
>>>> reports on real hardware are welcome.
>>> It is only possible to set the affinity of a user-space thread, why
>>> adding another way to do it ?
>>>
>>
>> I'm not yet completely understanding what you mean.
>>
>> So far the affinity was indirectly assigned to some xnthread by the CP=
U
>> the caller of xnshadow_map happened to run on. Now this is done
>> explicitly, thus in a more robust way (there was an undefined path in
>> the old code) and without duplicating code (/wrt skins).
>=20
> I meant "already" instead of "only", it is already possible to set the
> affinity of a user-space thread with sched_setaffinity.
>=20

OK. So you are suggesting to read out the affinity mask from task_struct
instead of passing it as an additional argument?


--------------enig0A3350A696358AAB0A4D9DD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFbU7UniDOoMHTA+kRAqdlAJ9NF5qKTQUuyUkJge12WP0UanZXywCeKwDB
JVgUyiWwxV+vups5QAqktgM=
=OY+J
-----END PGP SIGNATURE-----

--------------enig0A3350A696358AAB0A4D9DD9--

