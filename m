Message-ID: <4B471B48.6040301@domain.hid>
Date: Fri, 08 Jan 2010 12:47:20 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B45F088.9010603@domain.hid> <4B45F163.4000504@domain.hid>
	<4B460255.30200@domain.hid> <4B46125D.4010602@domain.hid>
In-Reply-To: <4B46125D.4010602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8D9D4F0727DF9C2400055A98"
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
--------------enig8D9D4F0727DF9C2400055A98
Content-Type: multipart/mixed;
 boundary="------------030007070505000808060307"

This is a multi-part message in MIME format.
--------------030007070505000808060307
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 07.01.2010 17:57, schrieb Gilles Chanteperdrix:
> Stefan Kisdaroczi wrote:
>> Am 07.01.2010 15:36, schrieb Gilles Chanteperdrix:
>>> Stefan Kisdaroczi wrote:
>>>> hi,
>>>>
>>>> i have upgraded xenomai to 2.5.0 (x86,32bit). My application segfaul=
ts when I
>>>> try to create a task with stacksize 2048, this worked with 2.4.10.
>>>> Because my app is written in pascal i have reproduced the problem wi=
th the
>>>> xenomai trivial-periodic.c example:
>>>>
>>>> -	rt_task_create(&demo_task, "trivial", 0, 99, 0);
>>>> +	rt_task_create(&demo_task, "trivial",16911, 99, 0);
>>>>
>>>> Stacksize 0 -> default stack size : ok
>>>> Stacksize > 0 and <=3D 16911 : Segmentation fault
>>>> Stacksize >=3D 16912 : ok
>>>>
>>>> Any hints ?
>>> What does the task do? If it uses printf, printf needs a lot of room =
on
>>> the stack.
>>>
>>
>> To clarify:
>> It does not depend on the task body, the task is not even started.
>> The segfault happens when calling rt_task_create(), before rt_task_sta=
rt()
>> is called.
>=20
> Actually, when calling rt_task_create, the thread is created, under the=

> hood, and waits to be started. So the segmentation fault is most
> certainly due to a stack overflow in the newly created thread.
>=20
> And I am afraid I know why it happens: the newly merged user-space
> signals support requires roughly 16 * sizeof(struct siginfo) on stack.
> But this amounts to two Kbytes here. Could you run the following progra=
m
> on your target ?

salut gilles,

as the stacksize is already checked and increased to PTHREAD_STACK_MIN if=

the value is too small, i suggest to take the stacksize needed by xenomai=

into account too. The attached patch is clearly wrong, but it solved the
problem for me.

kisda

--------------030007070505000808060307
Content-Type: text/plain;
 name="stacksize.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stacksize.diff"

LS0tIHhlbm9tYWktMi41LjAub3JpZy9zcmMvc2tpbnMvbmF0aXZlL3Rhc2suYworKysgeGVu
b21haS0yLjUuMC9zcmMvc2tpbnMvbmF0aXZlL3Rhc2suYwpAQCAtMTQ4LDkgKzE0OCw5IEBA
CiAKIAlpZiAoIXN0a3NpemUpCiAJCXN0a3NpemUgPSAzMiAqIDEwMjQ7Ci0JaWYgKHN0a3Np
emUgPCBQVEhSRUFEX1NUQUNLX01JTikKLQkJc3Rrc2l6ZSA9IFBUSFJFQURfU1RBQ0tfTUlO
OwotCisJaWYgKHN0a3NpemUgPCAoUFRIUkVBRF9TVEFDS19NSU4gKyBzaXplb2Yoc3RydWN0
IHhuc2lnKSkpCisJCXN0a3NpemUgPSBQVEhSRUFEX1NUQUNLX01JTiArIHNpemVvZihzdHJ1
Y3QgeG5zaWcpOworCQogCXB0aHJlYWRfYXR0cl9zZXRpbmhlcml0c2NoZWQoJnRoYXR0ciwg
UFRIUkVBRF9FWFBMSUNJVF9TQ0hFRCk7CiAJbWVtc2V0KCZwYXJhbSwgMCwgc2l6ZW9mKHBh
cmFtKSk7CiAJaWYgKHByaW8gPiAwKSB7Cg==
--------------030007070505000808060307--

--------------enig8D9D4F0727DF9C2400055A98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLRxtOIPTw9rIdn6oRAiUAAJ4yht7JOSxX+I/HuLJIm/9yUGhZ6wCcCFa9
fflr9wkQrVMbGkc2AN7FtfE=
=JydX
-----END PGP SIGNATURE-----

--------------enig8D9D4F0727DF9C2400055A98--

