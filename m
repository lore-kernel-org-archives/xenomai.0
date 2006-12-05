Message-ID: <457559AE.5090804@domain.hid>
Date: Tue, 05 Dec 2006 12:36:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] vxworks- and posix-skin simultaneously
References: <5D63919D95F87E4D9D34FF7748CE2C2A6C63C4@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A6C63C4@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B053540000C354038F6F7B6"
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B053540000C354038F6F7B6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
>>> Can anybody tell me about the actual state of using=20
>> vxworks-skin and posix-skin simultaneously ? Is it possible,=20
>> compiling one application with vxWorks-skin and an other one=20
>> with the posix-skin and to use/execute these two applications=20
>> simultaneously on one system ?
>>
>> Yes, feasible. There are example applications available for=20
>> both skins, so setting up your own quick test will not take=20
>> you much time.
>>
>>> In an earlier posting I have read, that all skins (or at=20
>> least the native and the posix one) should be compiled as=20
>> modules, so they do not overide the timer mode. Is this still=20
>> true ? And if yes, dosn?t need the posix skin an aperiodic=20
>> timer, but the timer is set to periodic mode by the vxworks=20
>> skin ? So, can an vxworks application and an posix=20
>> applications run together ??
>>
>> It's true that the vxworks skin still forces the nucleus into=20
>> periodic timer mode. This is a known shortcoming of the=20
>> current timer subsystem.
>> As announced earlier, we are aiming at a redesign to overcome=20
>> this during the 2.4 development cycle. Ideas exist, remaining=20
>> issues are also identified. But our resources are still=20
>> limited, so there is no promise on a time-frame.
>>
>=20
>=20
>> Anyway, if you do not rely on having sub-tick timer precision=20
>> for the posix applications you are planning, the available=20
>> support should already be fine for you.
>>
>=20
> Sorry, but what does "sub-tick timer precision" mean (isn?t the timer c=
ounting ticks) ?

I mean that you can only rely on tick resolution for both skins with the
currently available timer subsystem. In the future the vxworks skin tick
will be mapped on a periodic timer in an exclusively one-shot (high
resolution) timer implementation.

> Do I have to use the posix timers in a different way, when using period=
ic mode, or is just the timer resolution changing (incremnting by 1000000=
 when the period is  1ms e.g.) ?

The time unit of posix services remain nanoseconds, just the resolution
changes.

> What is a reasonable value for the timer period in the kenrel settings =
(1ms=3D1000000 ns ?)

Depends on available CPU resources on the target (check the load under
2.3-rc2 via /proc/xenomai/stat) and the required minimal resolution
(often defined by the fastest periodic job).

Jan


--------------enig8B053540000C354038F6F7B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdVmvniDOoMHTA+kRAuM7AJ0SsZcC3TkwKAnE/yA7j9b3jNNgEwCcCSYV
/JWlbhlmgypuKVVWWT3UJBc=
=CYRt
-----END PGP SIGNATURE-----

--------------enig8B053540000C354038F6F7B6--

