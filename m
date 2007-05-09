Message-ID: <46416A6E.1070605@domain.hid>
Date: Wed, 09 May 2007 08:30:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1178645689.7883.9.camel@domain.hid>	<17984.50298.842145.884348@domain.hid>	<1178659440.5074.9.camel@domain.hid>
	<17984.61751.376631.920611@domain.hid>
In-Reply-To: <17984.61751.376631.920611@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFA2C43EA67078DB63F082C37"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rtser not showing up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA2C43EA67078DB63F082C37
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Brandt Erickson wrote:
>  >=20
>  > > No node will turn up in /dev, you will find the list of available =
RTDM
>  > > devices in /proc/xenomai/rtdm/named_devices.
>  >=20
>  > Okay,
>  > there is a /proc/xenomai/rtdm/rtser0.  The example opens the file
>  > "rtser0", does this default to the full path name when I use
>  > rt_dev_open?
>  >=20
>  > Right now, it appears I can open the file (rt_dev_open returns 0) an=
d
>  > configure the serial port (using rt_dev_ioctl), however, every call =
to
>  > rt_dev_write returns -1.  I'm using the configuration from the examp=
le
>  > code which basically has everything set to defaults.  Is there an
>  > equivalent of errno I can get to find out what's going wrong?  Thank=
s.
>  > -Brandt
>=20
> The errors of the serial driver are documented here:
>=20
> http://www.xenomai.org/documentation/trunk/html/api/group__rtserial.htm=
l
>=20
> -1 is -EPERM... which is not documented. -EPERM probably means that you=

> are trying to use a real-time call from a non real-time thread. See
> rt_task_shadow or rt_task_create.
>=20

That's the point. The serial driver's write operation requires real-time
context and return -EPERM otherwise. Documentation should be enhanced...

Jan


--------------enigFA2C43EA67078DB63F082C37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGQWpuniDOoMHTA+kRAtx3AJ0UNcK+GCxe5mi7/271bwV9DLJ7GwCdE6iJ
lV0XgbSQb6leLb4HdP7U7uM=
=ozIA
-----END PGP SIGNATURE-----

--------------enigFA2C43EA67078DB63F082C37--

