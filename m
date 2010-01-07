Message-ID: <4B460255.30200@domain.hid>
Date: Thu, 07 Jan 2010 16:48:37 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B45F088.9010603@domain.hid> <4B45F163.4000504@domain.hid>
In-Reply-To: <4B45F163.4000504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF3781EFE9618E104D6A0ACBB"
Subject: Re: [Xenomai-help] native skin 2.5.0: rt_task_create() segfaults if
 stacksize parameter too small
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF3781EFE9618E104D6A0ACBB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 07.01.2010 15:36, schrieb Gilles Chanteperdrix:
> Stefan Kisdaroczi wrote:
>> hi,
>>
>> i have upgraded xenomai to 2.5.0 (x86,32bit). My application segfaults=
 when I
>> try to create a task with stacksize 2048, this worked with 2.4.10.
>> Because my app is written in pascal i have reproduced the problem with=
 the
>> xenomai trivial-periodic.c example:
>>
>> -	rt_task_create(&demo_task, "trivial", 0, 99, 0);
>> +	rt_task_create(&demo_task, "trivial",16911, 99, 0);
>>
>> Stacksize 0 -> default stack size : ok
>> Stacksize > 0 and <=3D 16911 : Segmentation fault
>> Stacksize >=3D 16912 : ok
>>
>> Any hints ?
>=20
> What does the task do? If it uses printf, printf needs a lot of room on=

> the stack.
>=20

To clarify:
It does not depend on the task body, the task is not even started.
The segfault happens when calling rt_task_create(), before rt_task_start(=
)
is called.

kisda


--------------enigF3781EFE9618E104D6A0ACBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLRgJaIPTw9rIdn6oRAj+kAJ0bWzPC/0pp4UjAlP8asU5LvAEQagCaA/f9
82aLAyFVNa1j5mWAfeceSuw=
=fzxL
-----END PGP SIGNATURE-----

--------------enigF3781EFE9618E104D6A0ACBB--

