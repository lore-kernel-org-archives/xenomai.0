Message-ID: <457D6BF1.1040507@domain.hid>
Date: Mon, 11 Dec 2006 15:32:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: [Adeos-main] [PATCH] ppc mvme5500
References: <1165537720.4578b1b879da9@domain.hid>	<45795320.5060806@domain.hid>	<1165595720.45799448b0adc@domain.hid>	<4579CD41.6060102@domain.hid>	<1165665886.457aa65e2c26e@domain.hid>	<457AAEB9.20403@domain.hid>	<1165834501.457d390514d36@domain.hid>	<457D57B4.3000802@domain.hid>	<1165843368.457d5ba8692bd@domain.hid>
	<457D609F.8030301@domain.hid>
In-Reply-To: <457D609F.8030301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBE37FF7E2C93353923767500"
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
To: barbalace@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBE37FF7E2C93353923767500
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> barbalace@domain.hid wrote:
>> Testing with the native skin I notice (Xenomai2.2.0) that mutex
>> doesn't behave
>> like I think:
>> 1. create a mutex
>> 2. lock the mutex (infinite)
>> 3. start a RT task
>> 4. lock the mutex in the RT task (infinite)
>> 5. register an interrupt
>>
>> 6a. ...wait...
>> 6. reach an interrupt and unlock the mutex
>> 6b. ...then...
>>
>> 7. start 2-times the code after the previous rt_mutex_lock [this is no=
t
>> correct!!!]
>> 8. goto 6a.
>>
>> the rt_mutex_lock is clearly in a for loop.
>> Probably I'm in truble. Using a semaphore resolve my problems.
>> When using mutex I lose the machine control.
>=20
> I don't have a quick answer but maybe somebody else can help.

Antonio, please use a recent Xenomai version (e.g. 2.2.5) to avoid that
we may hunt old issues. Next post a simple demo code to xenomai-help,
showing the misbehaviour. We could then check if other archs are
involved, if it's reproducible on further PPC boards, or if some mistake
might have slipped into the code.

=46rom your description I wonder if you lock the mutex in line 2 from the=

correct context (a Xenomai thread). If you call that lock from main,
don't forget to invoke rt_task_shadow first.

Jan


--------------enigBE37FF7E2C93353923767500
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFfWvxniDOoMHTA+kRAlXCAJ4nQ3ukma/z2SbtjjeBZiGOkOd4ngCfdPvh
EproVCPVk8E94DzJPCyH/UU=
=JwKv
-----END PGP SIGNATURE-----

--------------enigBE37FF7E2C93353923767500--

