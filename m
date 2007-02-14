Message-ID: <45D2FF1E.1080701@domain.hid>
Date: Wed, 14 Feb 2007 13:22:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CONFIG_PREEMPT & irqbench
References: <45D25145.3000407@domain.hid>	<45D2CE27.5040303@domain.hid>
	<45D2DD6E.5030800@domain.hid>
	<45D2E468.3080402@domain.hid>
	<45D2E86C.2010200@domain.hid>
In-Reply-To: <45D2E86C.2010200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC9561DF1AEB90546C57411AA"
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
To: Markus.Franke@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC9561DF1AEB90546C57411AA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Jan Kiszka wrote:
>> Of course, irqloop runs in *primary* mode to be able to handle the
>> events deterministically. So it is not directly affected by CONFIG_PRE=
EMPT.
>=20
> If I start irqloop in User-Mode, a thread is simply created via Linux
> system call pthread_create() which interacts with the
> xeno_irqbench-driver via ioctl(). But then I don't understand why
> irqloop is running in Primary (Xenomai) Mode? Because of the interactio=
n
> with the RTDM-based driver?
> I am just wondering because I can't see something like rt_task_create()=
=2E

<see Dmitry's reply>

>=20
>> Yes, if you have an RT thread that issues syscalls and wishes to have
>> them handled as fast as possible, CONFIG_PREEMPT should be enabled (an=
d
>> CONFIG_XENO_OPT_RPIDISABLE should remain off, maybe you even want to
>> consider CONFIG_XENO_OPT_ISHIELD then). Such RT application designs ar=
e
>> tricky to get correct and deterministic, so it's often better to not
>> rely on these properties and rather seek a clear separation of pure RT=

>> threads on the one side and Linux syscall issuing non-RT or RT
>> borderline threads (low-prio RT threads that are being switched back a=
nd
>> forth between primary and secondary mode) on the other.
>=20
> Ok I understand. So native kernel preemption should only provide better=

> results if you have realtime-threads issuing linux systemcalls which is=

> not really convenient.

It is for sure convenient. But it doesn't take the burden from you to
understand what is happening underneath. That's my point.

>=20
>> Shadowed by CONFIG_DEBUG=3Dn likely.
>=20
> probably by CONFIG_DEBUG_KERNEL=3Dn

Yep.

Jan


--------------enigC9561DF1AEB90546C57411AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0v8eniDOoMHTA+kRAp7NAJ97V03bVGtM5vjUbY4YG07cRaz9cgCdF2qd
FWHIbw4V+g+Fx6i+JrJhPMY=
=7ACj
-----END PGP SIGNATURE-----

--------------enigC9561DF1AEB90546C57411AA--

