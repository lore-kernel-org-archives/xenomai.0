Message-ID: <45E1D317.5040305@domain.hid>
Date: Sun, 25 Feb 2007 19:19:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-1?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-core=5D_?=
	=?ISO-8859-1?Q?rtdm=2C_rtc_and_printk_driver=2E?=
References: <s5e1d71e.043@domain.hid>
In-Reply-To: <s5e1d71e.043@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB7E09AFB9B2539179970C56B"
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
To: Marc LE DOUARAIN <m.ledouarain@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7E09AFB9B2539179970C56B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Marc LE DOUARAIN wrote:
>>>>> "Nicolas BLANCHARD" <n.blanchard@domain.hid> 23/02/07 15:55
>=20
>>>>>> Jan Kiszka <jan.kiszka@domain.hid> 23.02 14:47 >>>
>>>> Nicolas BLANCHARD wrote:
>>>> Hello,
>>>> =20
>>>> I've write a little rtdm driver to r/w RealTimeClock on rtc146818
>>>> chipset.
>>> /me not having done much with rtc (hmm, a lot of years back on PCs, I=

>>> think): can this chip be found in normal PC hardware? Or is it only
> on
>>> specific embedded boards? (Means: can I actually play with your
> driver? :) )
> =20
>> Motorola 146818 circuit is a 6800 peripheral CMOS device,
>> it's often used with processors 6800 and 8085.
>> I think it's used on a lot of x86 board.
>=20
> First nice work Nicolas ! (he is my coworker)
> Time usage for us is really important in our field activity, and more
> important without too much drift. And this real-time driver let us to
> have direct access to the RTC values instead of the Linux system one
> that generally drift a lot per day...(it was already the same problem
> under RTLinux) And without a secondary mode switch...

So you need such an interface for time-stamping, or also for scheduling
events based on a RTC-provided date? I had a short look at the driver,
and it seems that there exist ideas to register an interrupt on the RTC
(it's currently freed but never acquired).

The long-term question for me is if there is a need to synchronise the
system clock (or some skin timebase in future Xenomai versions) on an
external sources like the RTC here. Not that I'm desperately locking for
work, it's just good to know user requirements whenever further design
decisions [on the time subsystem] have to be made.

>=20
> Nowadays, you will generally not find directly a 146818 chip or
> compatible (like the Dallas ones). Many CPUs (for example the SIS
> Vortex86 we use on our embedded cards) have integrated in themself, on =
a
> single chip, many antique PC peripherals like this RTC compatible
> 146818, a 8254 system timer, the dual 8259 interrupt controller. Also
> sometimes the serials 16550 UART are included !!!
>=20
> So yes, for sure on many computers you will be able to use it !
>=20

OK, thanks.

>=20
>>>> I also use this driver to write kernel message from user-space
>>>> (printk).
>>>> =20
>>>> In attachment you can find an archive with the driver and an example=

> of
>>>> use (just code).
>>>> to compil, you must change kernel sources directory
> (KERNELSOURCEDIR
>>> flag).
>>>> =20
>>>> It Based on code of Jan Kiszka found in http://www.captain.at/=20
>>>> =20
>>>> I hope it could be interesting.
>>>> All feedback are welcome.
>>>> =20
>>> You will get it. Thanks for sharing your code!
>>>
>=20
> It seems normal to us to share some possible usefull stuff like this
> one, keeping the free software spirit!
>=20

Then you shall benefit from this: :)

You may have a locking problem. Calling CMOS_READ/WRITE is not safe from
Xenomai context (I wish we had that domain violation debugging feature
already - classic scenario here). There is a locking mechanism embedded
which is based on the assumption that it can protect itself from
preemption via local_irq_save - an assumption that is not true from the
Xenomai perspective.

If there are no further RTC users in your running system, you should
just do direct hardware access and your own locking around it. But
CMOS_READ [1], e.g., is used in quite a few places in the kernel, one
would have to check under which conditions to really play safe.

Jan

[1] http://lxr.free-electrons.com/ident?i=3DCMOS_READ


--------------enigB7E09AFB9B2539179970C56B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF4dMYniDOoMHTA+kRAq0FAJ0V7rOcLN1yM9otCDlmww3d8M805ACeLBEQ
LwBZp9bycTNF4kAsYdj2jhY=
=gXD8
-----END PGP SIGNATURE-----

--------------enigB7E09AFB9B2539179970C56B--

