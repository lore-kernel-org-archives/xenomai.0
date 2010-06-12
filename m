Message-ID: <4C136558.4070002@domain.hid>
Date: Sat, 12 Jun 2010 12:45:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTim0tClnDQPN3u5ozJSEU6BcX--Xf9Ekw00ADvgy@domain.hid>	<4C1353D8.2060507@domain.hid>
	<AANLkTik39wezPyRC-myOQi_etA5EPAg-LgzSqyO40IX7@domain.hid>
In-Reply-To: <AANLkTik39wezPyRC-myOQi_etA5EPAg-LgzSqyO40IX7@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF177C0D38657AD4C49AC0BD3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] error on rt_dev_read, code Success,
	what does it  mean?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF177C0D38657AD4C49AC0BD3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Everett Wang wrote:
> Thanks. I looked my code again, which is modified from example
> cross-link.c. The section looks like:
>=20
> ...
>                  irq_time =3D rx_event.rxpend_timestamp;
>                 read =3D rt_dev_read(read_fd, &write_time, sz);
>                 if (read =3D=3D sz) {
>                         read_time =3D rt_timer_read();
>                         printf("%3d |%16llu |%16llu |%16llu\n", nr,
>                                irq_time  - write_time,
>                                read_time - irq_time,
>                                read_time - write_time);
>                         nr++;
>                 } else if (read < 0 ) {
>                         printf(RTASK_PREFIX "error on rt_dev_read, code=
 %s\n",
>                                strerror(-err)); <<<<<<<=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>                         break;
>                 } else {
>                         printf(RTASK_PREFIX "only %d / %d byte received=
 \n",
>                                read, sz);
>                         break;
>                 }
> ...
> I guess I should change the strerror(-err) to strerror(-read).

Indeed, the example suffers from some copy&paste mistakes. Same for the
write path. And closing in a loop is no longer required. A cleanup is
needed.

> If I do
> that, I some
> times get a " code input/output error". That is better. What can cause
> input/output error?

Try RTSER_RTIOC_GET_STATUS to learn more.

> I get my serial port in that state consistently
> when I
> finish running my GPS program. I can reset it to a usable serial port
> again by remove and re-load xeno-16550A module.

Re-opening the rtser port, ie. restarting your program doesn't help?
Does re-plugging the GPS mouse change the picture? If yes, you may have
to reset its hardware somehow. If no, there might be a sticky state in
our serial driver, ie. a bug.

> But setserial -G can't
> see anything unusual. Could it be some unclosed serial port?
>=20
> My simple code is attached.
>=20
> Thanks,
>=20
> Everett
>=20

Jan


--------------enigF177C0D38657AD4C49AC0BD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwTZV0ACgkQitSsb3rl5xRIgQCgiL/pmzqKMnA68lzmeZn99eU9
cr4AoIp/8NJT1N0mHOi6zCzCOtIece2S
=1MXh
-----END PGP SIGNATURE-----

--------------enigF177C0D38657AD4C49AC0BD3--

