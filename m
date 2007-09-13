Message-ID: <46E8D55B.3090806@domain.hid>
Date: Thu, 13 Sep 2007 08:14:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>		<46E58BE4.9090109@domain.hid>		<1ce16a2c0709101142r6cf2d624oe443807575eadcfa@domain.hid>		<46E59235.2060506@domain.hid>		<1ce16a2c0709110837r52eedac7vcc970d5c3b4e2d53@domain.hid>		<46E6F290.9090901@domain.hid>	<1ce16a2c0709120702m1d4cc503vb045f3d2e0814d67@domain.hid>
	<46E87584.9020301@domain.hid>
In-Reply-To: <46E87584.9020301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA0232667FAAD03A21341E55E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] adding PCI support to 16550A.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bachman Kharazmi <bahkha@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA0232667FAAD03A21341E55E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Bachman Kharazmi wrote:
>>> You can copy this code almost unmodified into an application and comp=
ile
>>> it against the Xenomai POSIX skin. The serial port configuration apar=
t
>>> (same under Linux, though), it will open "rtser<whatever>", even if
>>> given like "/dev/rtser...", and work on that port as if it where a Li=
nux
>>> one. Life can be simple, sometimes.
>> Simple? ;)
>> I've tried to write a c-program which basiclly should open the device
>> rtser0 and write 100x to it and then close.
>>
>> The simple program can be found here: http://pastebin.ca/693873
>>
>> I've connected the serial cable to a reading terminal, but there's no
>> data at all, when I run the binary. :/
>>
>=20
> [Untested late-night hack after some Ma=DF of beer - please excuse
> potential nonsense.]
>=20
> POSIX skin
> ----------
> (use xeno-config --posix-cflags --posix-ldflags as compiler args)
>=20
> #include bla bla bla
>=20
> static const struct rtser_config write_config =3D {
>         .config_mask       =3D RTSER_SET_BAUD,
>         .baud_rate         =3D 115200,
> };
>=20
> int main(int argc, char *argv[])
> {
> 	int fd;
>=20
> 	fd =3D open("/dev/rtser0", O_RDWR);
> 	ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
> 	write(fd, argv[1], strlen(argv[1]));
> 	close(fd);
>=20
> 	return 0;
> }
>=20
>=20
> Native skin
> -----------
>=20
> ...
> int main(int argc, char *argv[])
> {
> 	int fd;
> 	RT_TASK task;
>=20
> 	fd =3D rt_dev_open("/dev/rtser0", O_RDWR);

The first error, copy&paste: This must be just "rtser0".

> 	rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
>=20
> 	rt_task_shadow(&task, NULL, 0, 0); /* may be done earlier,
>                                               but not later */
>=20
> 	rt_dev_write(fd, argv[1], strlen(argv[1]));
> 	rt_dev_close(fd);
>=20
> 	return 0;
> }
>=20
>=20
> Similar is imaginable for reading from the serial port.
>=20
> Completed and tested versions, maybe also taking the baudrate as
> argument, will be happily accepted to the examples or tools repos.

BTW, a generic serial dump tool should, of course, also take the port
number as parameter.

Jan


--------------enigA0232667FAAD03A21341E55E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG6NVbniDOoMHTA+kRAkQIAJ0WaEYRqq4I0BFsFyq3EMSqa/JEVgCfU3mv
WnrR93PJX/LDTGrZE4NE0L8=
=ZPtU
-----END PGP SIGNATURE-----

--------------enigA0232667FAAD03A21341E55E--

