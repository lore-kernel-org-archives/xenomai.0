Message-ID: <43D8E7ED.2030301@domain.hid>
Date: Thu, 26 Jan 2006 16:17:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: RTDM and udelay
References: <200601251552.10271.lbocseg@domain.hid>	<43D7D7E3.3040804@domain.hid>
	<43D81B11.2020809@domain.hid>	<43D8891D.7000405@domain.hid>
	<43D8A936.3010500@domain.hid>
In-Reply-To: <43D8A936.3010500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4197253685066AF9C8D76307"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4197253685066AF9C8D76307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
>=20
>>>>> Is there any alternative to udelay on RTDM?
>>>>>
>>>>> Or should I do something like:
>>>>>
>>>>> void rt_udelay(unsigned int usec) {
>>>>> uint64_t timeout =3D rtdm_clock_read () + usec;
>>>>> while (rtdm_clock_read () < timeout);
>>>>> }
>>>>> =20
>>>>>      =20
>>>> You mean something like this: =3D:)
>>>>
>>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/rtdm/dr=
vlib.c?v=3DSVN-trunk#L366
>>>>
>>>>    =20
>>> Yes, but it seemed too complex for me, since it disables IRQ and I do=

>>> not need this feature. It will no problem if, instead of waiting 2us,=
 I
>>>  =20
>> Are we talking about the same function??? Don't think so.
>> =20
>>
> Is there any related function that do not disable IRQ? I know it is not=


rtdm_task_busy_sleep() as it is now *does not* touch the IRQ flag,
please have a look at the provided link. But this reminds me of a
potential issue when using it on SMP: a task being migrated while
running rtdm_task_busy_sleep may suffer from inconsistent TSCs on old
and new CPU. We have to address this somehow...

> a big deal and I'll use the suggested function if there is no
> alternative, but I would prefer using some delay function that will not=

> disable interrupts when delaying.
>=20
>>> have to wait 100us because some interrupt has occurred. After I write=
 to
>>> the board i2c registers, I need to wait *at least*, say, 2us before
>>> writing another i2c cycle.
>>>  =20
>>
>> Then this is the perfect choice for you.
>>
>> =20
>>
>>> One more thing: although the name of the function has the word "task"=
, I
>>> think it is not task specific. Documentation even says it can be call=
ed
>>> from initialization/cleanup code. But it doesn't say if it can be cal=
led
>>> from an ioctl handler or any other context, although I see no problem=

>>> when reviewing the code. Thus, I think a better name would be somethi=
ng
>>> like rtdm_busy_sleep() or rtdm_ns_delay(). Just a suggestion.
>>>  =20
>>
>> The idea is to put most functions into some related group. As
>> rtdm_task_busy_sleep() is an alternative to rtdm_task_sleep(), I place=
d
>> them close to each other in the doc, i.e. in the same group
>> (rtdm_task_xxx).
>>
>> Note that an ioctl handler (just like any device operation handler) ha=
s
>> no separate context. Depending on if we are talking about the _rt or t=
he
>> _nrt handler, it either executes in a RT task or in non-RT context,
>> invoked by a user space or kernel space caller. All this is covered by=

>> the environments listed for rtdm_task_busy_sleep.
>> =20
>>
> Thanks for clarifying. One more doubt. Suppose my driver has only the
> non-RT close handler. If the user close the file descriptor from a
> RT-context, it will call the non-RT close handler? If yes, will that
> handler be called in a RT-context? If not, could I use the same handler=

> (function) for both RT and non-RT handlers?

If a RT handler is missing, the caller is migrated to secondary mode
before the non-RT handler is invoked. And yes, if your close handler is
both RT and non-RT safe, you can registered it for both entry points.

Jan


--------------enig4197253685066AF9C8D76307
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD2OftniDOoMHTA+kRAtKDAJ94kHFYHqXdTVdO16Y4ip3JlwASBwCeKy8v
UBqYbXMogBX4pFujnRKxj2w=
=wRTn
-----END PGP SIGNATURE-----

--------------enig4197253685066AF9C8D76307--

