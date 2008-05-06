Message-ID: <48200048.7010604@domain.hid>
Date: Tue, 06 May 2008 08:52:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <481F6C7D.1050908@domain.hid> <481F884E.5080201@domain.hid>
	<481F9B32.9060003@domain.hid>
In-Reply-To: <481F9B32.9060003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB6F232CB66118DCF597ACCE5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Loosing serial interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6F232CB66118DCF597ACCE5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Tomas Kalibera wrote:
> Hi Jan,
>> Try to pass I_EDGE to rt_intr_create. The UART IRQs are edge-triggered=
,
>> so you have to enable the appropriate handling at kernel IRQ handler=20
>> level.
>>
>> Jan
>>  =20
>=20
> I'm calling rt_intr_create from user space, so I cannot specify I_EDGE.=
=20
> But even if I could, looking at the code I assumed that I_EDGE was only=
=20
> applicable together with I_SHARED, and should be only used when I need =

> to share and edge IRQ among multiple rt_intr objects/interrupt=20
> handlers.  Is that correct ?

Yeah, that was nonsense. It's a shared-IRQ thing, and those won't work=20
via the native API anyway.

If you can identify a point when something interesting just happened=20
(which means much less than 10 seconds ago), try placing a=20
xntrace_user_freeze() at that location and use the I-pipe tracer to=20
analyse the history of the system (of the last few milliseconds). That=20
can help to understand what does or does not go on at lower levels. Find =

more infos on the tracer in the wiki.

BTW, there is also a test case available for IRQ delivery via=20
null-modem, check irqbench. It doesn't use the rt_intr API, but the same =

hardware.

Jan


--------------enigB6F232CB66118DCF597ACCE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkggAE4ACgkQniDOoMHTA+lu4wCcCjrhg90xS9GKp9j5eeh2SLyP
IeUAn3/tNW1vVC28ue4pA1mMNqCcJu2U
=GAEn
-----END PGP SIGNATURE-----

--------------enigB6F232CB66118DCF597ACCE5--

