Message-ID: <4534E706.7070506@domain.hid>
Date: Tue, 17 Oct 2006 16:21:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Serial port support questions
References: <6C66DBDE644B9E4B9408FED33753E98E04458097@domain.hid>
In-Reply-To: <6C66DBDE644B9E4B9408FED33753E98E04458097@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE66140A1AF606FC9564F35FF"
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
To: "Lankheet, Jeroen" <jeroen.lankheet@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE66140A1AF606FC9564F35FF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Lankheet, Jeroen wrote:
> Dear all,
>=20
> I've just installed Xenomai on top of a Fedora distribution (x86).
> I'm using a Moxa industrial serial board (CP-134) in order to
> communicate through RS485.
>=20
> I tried to run the serial port example from
> http://www.rts.uni-hannover.de/rtaddon/rt_serial_uprog.tar.bz2
> It seems that my system cannot open the rtser0 device: rt_serial_uprog:=

> can't open rtser0 (write) I have some simple questions regarding this
> example.
>=20
> 1. The xen_16550A module that should be loaded is not in the xenomai
> dir? In fact, my /src/xenomai dir lacks a directory with modules. What
> went wrong with installation?

Likely nothing. xeno_16550A is in fact a kernel driver that should be
under /lib/modules/<your-version>/kernel/drivers/xenomai/serial. Or you
compiled it into the kernel. Did you enable it at all in the kernel confi=
g?

> 2. What is rtser0? Is it a wrapper around the serial hardware for
> realtime I/O? I have no devices in /dev that match rtser* 3. I have 4
> ports in my sytem, 2 of them are RS232, 2 are RS485. How should I
> address them?=20

The namespace for RTDM-based hard-RT devices is separated from normal
Linux devices, i.e. you will not find anything related under /dev. You
can open such devices via rt_dev_open (librtdm) or, when using the POSIX
skin wrapping mechanism, via normal open (libpthread_rt). In the latter
case you can even provide /dev/rtser0, the library will ignore the prefix=
=2E

>=20
> 	Oct 17 13:15:19 localhost kernel: MOXA Smartio/Industio family
> driver version 1.9.5
> 	Oct 17 13:15:19 localhost kernel: Found MOXA CP-134U series
> board(BusNo=3D5,DevNo=3D9)
> 	Oct 17 13:15:19 localhost kernel: ACPI: PCI Interrupt
> 0000:05:09.0[A] -> GSI 18 (level, low) -> IRQ 169
> 	Oct 17 13:15:19 localhost kernel:         ttyM0 - ttyM3  max.
> baud rate =3D 921600 bps.
> 4. I've run this same example under RTAI. Although it couldn't read fro=
m
> rtser1, writing was successful. So I'm not sure that my configuration i=
s
> proper. Is there a simple test, other than compiling/running example
> programs?

Did you already read <xenomai-src>/doc/txt/16550A-driver.txt? Based on
this description and the demo it must work, or we face some bug. Maybe
you should first start with testing the loopback scenario with on-board
serial ports (when available) to exclude moxa-related problems.

> 5. From the RTAI installation I have a /etc/rc.d/rc.rtai file that make=
s
> the /dev/rtf* and shm nodes. Isn't this required for Xenomai?

It is (if you make use of pipes or shared memory), check
ksrc/nucleus/udev for the required rules.

Jan


--------------enigE66140A1AF606FC9564F35FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNOcGniDOoMHTA+kRAgNyAJ9Mx+5BjeBnkBz0YX/sRIYXa6hMUwCfbLRj
MrLL2gmTSqtU6TxWaxKx5uc=
=SWSv
-----END PGP SIGNATURE-----

--------------enigE66140A1AF606FC9564F35FF--

