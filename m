Message-ID: <43D8891D.7000405@domain.hid>
Date: Thu, 26 Jan 2006 09:32:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200601251552.10271.lbocseg@domain.hid>
	<43D7D7E3.3040804@domain.hid> <43D81B11.2020809@domain.hid>
In-Reply-To: <43D81B11.2020809@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCF25DEB3A52B753780A91353"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: RTDM and udelay
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
--------------enigCF25DEB3A52B753780A91353
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Rodrigo Rosenfeld Rosas wrote:
>=20
>>> Is there any alternative to udelay on RTDM?
>>>
>>> Or should I do something like:
>>>
>>> void rt_udelay(unsigned int usec) {
>>>  uint64_t timeout =3D rtdm_clock_read () + usec;
>>>  while (rtdm_clock_read () < timeout);
>>> }
>>>  =20
>>
>> You mean something like this: =3D:)
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/rtdm/drvl=
ib.c?v=3DSVN-trunk#L366
>>
>> =20
>>
> Yes, but it seemed too complex for me, since it disables IRQ and I do
> not need this feature. It will no problem if, instead of waiting 2us, I=


Are we talking about the same function??? Don't think so.

> have to wait 100us because some interrupt has occurred. After I write t=
o
> the board i2c registers, I need to wait *at least*, say, 2us before
> writing another i2c cycle.

Then this is the perfect choice for you.

>=20
> One more thing: although the name of the function has the word "task", =
I
> think it is not task specific. Documentation even says it can be called=

> from initialization/cleanup code. But it doesn't say if it can be calle=
d
> from an ioctl handler or any other context, although I see no problem
> when reviewing the code. Thus, I think a better name would be something=

> like rtdm_busy_sleep() or rtdm_ns_delay(). Just a suggestion.

The idea is to put most functions into some related group. As
rtdm_task_busy_sleep() is an alternative to rtdm_task_sleep(), I placed
them close to each other in the doc, i.e. in the same group (rtdm_task_xx=
x).

Note that an ioctl handler (just like any device operation handler) has
no separate context. Depending on if we are talking about the _rt or the
_nrt handler, it either executes in a RT task or in non-RT context,
invoked by a user space or kernel space caller. All this is covered by
the environments listed for rtdm_task_busy_sleep.

>=20
>>> Or maybe my design is wrong.
>>>
>>> I have a function, say WriteI2C(...). Should I create it as a task
>>> and call rtdm_task_sleep?
>>>  =20
>>
>> Depending on how long you would like to sleep and if you are not insid=
e
>> an IRQ handler, a re-scheduling call like rtdm_task_sleep() can be
>> better. If it's just about a few microseconds, busy sleeping should be=

>> preferred.
>> =20
>>
> Exactly what I had in mind, thanks.
>=20
> Best regards,
>=20
> Rodrigo.
>=20

Jan


--------------enigCF25DEB3A52B753780A91353
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD2IkjniDOoMHTA+kRAtxKAJ0bnwFKxwu9djtpf+HYhVpo1bADpQCdFNQS
CeBXH4hyveok1fQ0bQLwfIg=
=tXet
-----END PGP SIGNATURE-----

--------------enigCF25DEB3A52B753780A91353--

