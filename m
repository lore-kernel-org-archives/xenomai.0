Message-ID: <4AFACA6E.8000301@domain.hid>
Date: Wed, 11 Nov 2009 15:30:06 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <200911111422.11402.anisha.kaul@domain.hid>	<4AFA8197.7070005@domain.hid>
	<200911111932.10783.anisha.kaul@domain.hid>
In-Reply-To: <200911111932.10783.anisha.kaul@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9360095453A104693FA000C6"
Subject: Re: [Xenomai-help] unable to open serial port from a kernel module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anisha Kaul <anisha.kaul@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9360095453A104693FA000C6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

> int main ()
> {
>     mlockall (MCL_CURRENT|MCL_FUTURE);

you need to call rt_task_shadow(...) here (see docs),
which turns the current Linux task into a native Xenomai task.

>     rt_heap_bind  (&heap_desc, "MyHeap", TM_NONBLOCK);
>     rt_heap_alloc (&heap_desc, 1, TM_NONBLOCK, &shmem);

check all return values. I guess its -19 too without rt_task_shadow.

> /***************************************/
>     int result =3D rt_dev_open  ("rtdev0", 0);
>=20
>     printf ("\n%d passed ", result);
>=20
>     rt_dev_write (result, "abcd", 4);
> /***************************************/
> }

good luck,
kisda


Anisha Kaul schrieb:
> On Wednesday November 11 2009 14  : 49  : 19 you wrote:
>> Anisha Kaul wrote:
>>> hi,
>>>
>>> when i use rt_dev_open ("/dev/ttyS0", 0); from the function init_modu=
le
>>> () of a self written kernel module, it returns -19 ! What must be the=

>>> reason, can't a file be opened from a kernel module ?
>> Please read documentation and examples more carefully: "rtdev0" is the=

>> answer.
>>
>> Jan
>=20
> Hi,
>=20
> I forgot to attach the kernel module file as well as the user space fil=
e in=20
> the previous mail. Hereby I have included both of them !
>=20
> kernel module file: serialPortISR.c
> user space file   : userSpace.c
>=20
> thanks,
> anisha
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
>=20
>=20
> -------------------------------------
> Hi-Tech Gears Limited, Gurgaon, India
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



--------------enig9360095453A104693FA000C6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFK+sp0IPTw9rIdn6oRAsxqAJ9bp5OtYixm2M2UeIH/YDa9gbhFngCfZiKu
APnOOokhiYvhD2exvmGVXJA=
=U6Bj
-----END PGP SIGNATURE-----

--------------enig9360095453A104693FA000C6--

