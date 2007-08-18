Message-ID: <46C692FD.4080302@domain.hid>
Date: Sat, 18 Aug 2007 08:34:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <ff1d78710708160504s3f44571fkf12f405c1e71b4f6@domain.hid>
	<46C49070.8070807@domain.hid> <46C4BAB8.20103@domain.hid>
	<46C559A2.6090807@domain.hid> <46C5E4AC.1090608@domain.hid>
In-Reply-To: <46C5E4AC.1090608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7FD741E0DD0B06B630CFB8E1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RTDM context_size question
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: trem <tremyfr@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7FD741E0DD0B06B630CFB8E1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

trem wrote:
> Jan Kiszka wrote:
>> trem wrote:
>>  =20
>>> Jan Kiszka wrote:
>>>    =20
>>>> Steven Kauffmann wrote:
>>>>      =20
>>>>> Hi
>>>>>
>>>>> When looking at the rtdm examples tut01-skeleton en tut02-skeleton,=
 I have a
>>>>> question about the context_size in the rtdm_device struct.
>>>>>
>>>>> In tut01-skeleton-drv.c, the context_size =3D sizeof(buffer_t), in =
the other
>>>>> example context_size =3D 0. Both drivers uses the
>>>>> rtdm_safe_copy_to_user/rtdm_safe_copy_from_user functions to write/=
read data
>>>>> from buffer_t(kernel space) to user_space. So I don't understand wh=
y the
>>>>> context_size in tut02 is different than in tut01. Or is the context=
_size
>>>>> only important if we open the driver several times from one or more=

>>>>> user_space programs?
>>>>>        =20
>>>> The context size is important in case you want to attach some data t=
o
>>>> each opened instance of a device. Hmm, but this is something neither=

>>>> tut01 nor tut02 deals with optimally. tut02 cannot use a context-bas=
ed
>>>> buffer, because it uses two device instances (opened by two instance=
s of
>>>> the user space program) to transfer the data. But tut01 could use so=
me
>>>> global buffer as well without loosing a feature.
>>>>
>>>> Philippe (trem), could you rework tut01 and make it use a global buf=
fer
>>>> instead? Then some tut03 would be nice to explain what per context, =
per
>>>> device, and global data means. I've seen confusion about this fairly=

>>>> often, so a dedicated tutorial would be great.
>>>>
>>>> Thanks,
>>>> Jan
>>>>
>>>>      =20
>>> Hi
>>>
>>> I've used per device buffer in tut01 and global buffer in tut02 to sh=
ow
>>> the difference between them. But it seems that it's not very clear. A=
nd
>>> as the tut01 is just here as first rtdm example, it should be as simp=
le
>>> as possible.
>>>
>>> So yes, using global buffer in tut01 and tut02 could be done, and I w=
ill
>>> add a tut03 to show the context.
>>>
>>> tutorial index :
>>> - tut01 : first rtdm program
>>> you can read and write in this device (tut01-skeleton-drv01). All dat=
a
>>> are global, so I two program read it, they will read the same thing.
>>>
>>> - tut02 : show synchronization
>>> you can only read in the device (tut02-skeleton-drv01) if a write has=

>>> been done before (by this program or another program). data and
>>> semaphore are global.
>>>
>>> - tut03 : show device context
>>> we can use tut01, and just put data to context. So a program can't re=
ad
>>> data written by another program. For example, P1 and P2 two programs.=

>>>
>>> with tut01, the sequence is :
>>> P1 : write "I'm P1" to tut01-skeleton-drv01
>>> P2 : write "I'm P2" to tut01-skeleton-drv01
>>> P1 : read  "I'm P2" from tut01-skeleton-drv01
>>> P2 : read  "I'm P2" from tut01-skeleton-drv01
>>>
>>> with tut03, the sequence is :
>>> P1 : write "I'm P1" to tut03-skeleton-drv01
>>> P2 : write "I'm P2" to tut03-skeleton-drv01
>>> P1 : read  "I'm P1" from tut03-skeleton-drv01
>>> P2 : read  "I'm P2" from tut03-skeleton-drv01
>>>
>>>
>>> I'm on the right way ?
>>>    =20
>> Basically, yes. But I would even put all three associations into the
>> same example, may be letting the tut-device user select the data
>> destination via an IOCTL: local, device, global. That would should
>> clearly the association - and would also introduce a first, simple IOC=
TL
>> mechanism.
>>
>>  =20
> First, sorry, I don't understand the 3 choice : local, device, global.
> global =3D=3D 1 buffer for a driver
> local   =3D=3D 1 buffer each open
> device =3D=3D ?

"MyDevice01", "MyDevice02", ...

Means your driver registered multiple devices of the same kind. But, as
I just realised, this is something not yet covered by the tutorials as we=
ll.

>=20
> Are you sure you want to do only one tut with all this choice ?
> People seems to have some problem to understand a simple example,
> and you want to regroup them ?
>=20
> I propose :
> tut01 =3D> really simple example, global buffer
> tut02 =3D> synchronization
> tut03 =3D> context
> tut04 =3D> ioctl
>=20
> You propose :
> tut01 =3D> really simple example (like helloworld)
> tut02 =3D> context + synchronizatio + ioctl

Nope, no ioctl for tut02 yet.

>=20
> Both of them have pros and cons, which one you prefer ?

The idea was to give that data a bit more sense so that the examples are
less abstract.

Suggestion: Splitting up into several steps is always possible, let's
write down a version that covers all aspects and THEN decide which of
them is worth a dedicated tutorial (maybe you can leave the user space
part unmodified then). This approach would have the advantage to make it
clearer where the tutorials will take us and assure that there is at
best some thread from the beginning to the end.

Thanks,
Jan


--------------enig7FD741E0DD0B06B630CFB8E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGxpL/niDOoMHTA+kRApsZAJ9N6ZqU9hQQcS3ZnGI/PxBD7SzZ7QCeJDd8
68LLB/h4jRtWYcAAdpSBHQE=
=MqZ1
-----END PGP SIGNATURE-----

--------------enig7FD741E0DD0B06B630CFB8E1--

