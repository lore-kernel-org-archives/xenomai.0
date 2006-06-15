Message-ID: <449115E6.7040202@domain.hid>
Date: Thu, 15 Jun 2006 10:10:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44906584.60503@domain.hid>
In-Reply-To: <44906584.60503@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9005E960C6A4894BE3F9CCFF"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: GPIO and RTDM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9005E960C6A4894BE3F9CCFF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
>=20
> hi Jan, everyone,
>=20
> Ive worked up a patchset to add a GPIO driver for the chip on my mobo.
> I adapted an existing one, drivers/char/scx200_gpio,
> and created drivers/char/pc8736x_gpio
>=20
> When doing this, I _oversimplified_ my problem by disregarding RTDM,
> and Im hoping I can just _retrofit_ as needed.

=46rom a short glance at scx200_gpio: the only minor difference between
registering and handling a Linux GPIO char-device and doing the same
under RTDM will be the different naming. RTDM has no direct support for
major/minor identification, it uses clear-text names for its devices. So
you would have to create the device names on your own. Well, and some
locking might be required (full preemptibility!), but this seems to
apply to the Linux driver as well under certain kernel configs.

But I wonder if it is clever for GPIO devices with a significant number
of I/O lines to create a device node for each and every bit! Consider
the usage scenario where you want to talk to some n-bit bus using GPIO
lines. Would you like to open n devices and issue n writes just to put
some n-bit value on that bus?

At this chance: Did you have a look at the comedi interface as well? It
typically covers far more complexes data acquisition devices, but it
should also be usable for simple digital I/O interfaces. Moreover,
comedi is available for Linux for quite a while, and a RTDM port is on
the way.

If comedi means too much overhead for trivial I/O line manipulation, I
would welcome any suggestion for a generic GPIO device profile - both
mappable on RTDM and normal Linux character devices!

>=20
> the chip is on an ISA bus, a user-space C program can read the pins at
> (this) rate:
>=20
> Wed Jun 14 13:24:13 MDT 2006
> Linux soekris 2.6.17-rc6-gpio-sk #4 Sun Jun 11 20:43:10 MDT 2006 i586
> GNU/Linux
> opened /dev/gpio-17, for 1 loops, 1000000 samples
> read 1000000 samples in 7.8434 sec, rate: 127494.9460 samples/sec
> opened /dev/led, for 1 loops, 1000000 samples
> read 1000000 samples in 5.4116 sec, rate: 184788.5056 samples/sec
>=20
> (obviously speed isnt latency, but theres some correlation ..)
>=20
> I dont actually have a Real Question, to I'll throw out a placeholder -=

>=20
> What are the top 3-5 things to do or look at
> in order to check the compatibility of my patches with RTDM ?
>=20
>=20
>=20
>=20
> Separately..
>=20
> In this GPIO work, I concluded that I needed to add a sysfs interface
> to my driver, in order to better fit with LKML expectations.

Err, sorry for not seeing this immediately even after (cross-)reading
your second mail, but what will the sysfs interface be for? Information,
configuration? Do you see concrete usage scenarios for this?

>=20
> What I did so far works, and seems to hang together coherently, but
> insofar as it
> is the 1st time (to my knowledge) that a uniform treatment has been tri=
ed,
> I might have painted myself / all-of-us into a corner.
>=20
> Hopefully not, but you folks have a keener perception of these things.
> Ill send shortly.
>=20
> tia
> jimc

Jan


--------------enig9005E960C6A4894BE3F9CCFF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEkRXmniDOoMHTA+kRAqNnAJ0WIGBAQ+EtoUYkeuS/5zL/kwbBswCfcA7J
n4LPiQqge/zMcKoYX+WD2DA=
=3blo
-----END PGP SIGNATURE-----

--------------enig9005E960C6A4894BE3F9CCFF--

