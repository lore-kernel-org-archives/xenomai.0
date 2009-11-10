Message-ID: <4AF9260E.2020805@domain.hid>
Date: Tue, 10 Nov 2009 09:36:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200911101311.12900.anisha.kaul@domain.hid>
	<4AF91F4C.7030003@domain.hid>
	<200911101343.09183.anisha.kaul@domain.hid>
In-Reply-To: <200911101343.09183.anisha.kaul@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D9EA7DF9751251DA26FEDBE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] tasklet using Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anisha Kaul <anisha.kaul@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D9EA7DF9751251DA26FEDBE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[ Please don't drop CCs! ]

Anisha Kaul wrote:
>> Anisha Kaul wrote:
>>> Dear all,
>>>
>>> How to define a tasklet using Xenomai for a serial port interrupt
>>> handler? Does 'rtdm_event_init()' function work as a tasklet in Xenom=
ai ?
>> An RTDM event is a binary semaphore for use inside a kernel driver -
>> probably not what you are looking for. What should be the semantic of
>> this tasklet, that of old RTAI? And what is the use case behind it?
>>
>> Jan
>=20
> Thanks for the prompt reply !=20
>=20
> The tasklet I am talking about is supposed to re-set the registers of t=
he=20
> serial port each time an interrupt occurs ! We can do this the followin=
g way=20
> in using Linux system calls :
>=20
> void resetRegisters (unsigned long currentlyUnused);
>=20
> DECLARE_TASKLET  (rs232Tasklet, resetRegisters, 0);
>=20
> void resetRegisters (unsigned long currentlyUnused)
> {
>         outb (0x83, PORT + 3);
>         outb (0x01, PORT + 0);
>         outb (0x00, PORT + 1);
>         outb (0x03, PORT + 3);
>         outb (0x01, PORT + 1);
>         outb (0x63, PORT + 2);
>         outb (0x08, PORT + 4);
> }

This looks like a weird use of tasklets under mainline. Moreover, they
are practically deprecated there.

>=20
> How am I supposed to do this using Xenomai ?
>=20

Have you considered simply using the rt_16550A driver for your purpose?
You didn't told us your use case from an application POV, so it's hard
to say if the driver meets your requirements. But it does not require
you fiddling with hardware directly.

Jan


--------------enig6D9EA7DF9751251DA26FEDBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkr5JhIACgkQitSsb3rl5xT38ACfWiIip0cj1t3HHKOo/ww7+JUU
mCMAoL47Debk9KTixCaqY8mzaKzRFmcv
=rXpf
-----END PGP SIGNATURE-----

--------------enig6D9EA7DF9751251DA26FEDBE--

