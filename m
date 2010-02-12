Message-ID: <4B7581FF.4040304@domain.hid>
Date: Fri, 12 Feb 2010 17:29:51 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B757217.3060406@domain.hid>
	<4B757306.5070102@domain.hid>	<4B7575B9.2060707@domain.hid>
	<4B757BC8.7020305@domain.hid> <4B75802B.1030900@domain.hid>
In-Reply-To: <4B75802B.1030900@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig24E1239D5DCAEBFE4CFD8BAE"
Subject: Re: [Xenomai-core] Yet another ((weak)) bug
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24E1239D5DCAEBFE4CFD8BAE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 12.02.2010 17:22, schrieb Jan Kiszka:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Hi Gilles,
>>>>>
>>>>> this one requires some fixing too:
>>>>>
>>>>> xeno_sem_heap is marked weak. xeno_init_sem_heaps is called once pe=
r
>>>>> initialized skin. It unmaps any existing heap and creates a new one=
=2E
>>>>> That's already fragile during constructor run, but it's lethal duri=
ng
>>>>> process runtime, ie. when using dlopen.
>>>>>
>>>>> I think the solution is to handle forks separately and only remap i=
n
>>>>> that case. Digging in this direction now.
>>>>>
>>>>> BTW, what triggers the re-run of xeno_init_sem_heaps after a fork s=
o far?
>>>> It must be done for the child process to get a private heap differen=
t
>>>> from the parent process. I would guess it is handled by pthread_atfo=
rk.
>>> Ah, only the POSIX skin does that. However, sem-heaps must not be
>>> POSIX-only. OK, patch in the make.
>>
>> Ok. I am thinking more and more that you are right about making
>> libxeno_common a standalone library. Only the name stinks, we should
>> find a better one.
>=20
> libxnskin or so?
>=20
> Jan
>=20

libxenomai ?

Stefan


--------------enig24E1239D5DCAEBFE4CFD8BAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLdYIIIPTw9rIdn6oRArobAJ9rvmH+KXQ/vPwCZ3c/7T36EG90SgCcC7Nx
f3bvI3OsTwXGxyqNXVFjhmo=
=46ju
-----END PGP SIGNATURE-----

--------------enig24E1239D5DCAEBFE4CFD8BAE--

