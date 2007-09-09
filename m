Message-ID: <46E4085F.3080509@domain.hid>
Date: Sun, 09 Sep 2007 16:51:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709081159y62fbb73bwb16d2cae7a931774@domain.hid>	<1189285467.6013.20.camel@domain.hid>
	<1ce16a2c0709090730o1a803c99r70aea4410eda49ed@domain.hid>
In-Reply-To: <1ce16a2c0709090730o1a803c99r70aea4410eda49ed@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF554F11DFDE39195D3EB195F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] serial module problems
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
--------------enigF554F11DFDE39195D3EB195F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bachman Kharazmi wrote:
> Hi, after doing some modifications as mentioned in your patch I did
> compile serial as module without problems.
>=20
> My problem is now that I don't have any /dev/rtserX devices :(
> Do I need that?

Nope. RTDM devices don't show up as Linux devices.

>=20
> My goal is to get serial communication working with xenomai for
> controlling devices.
>=20
> Linux default serial support ain't builtin to kernel anymore.
> I'm running
> Linux sandbox 2.6.22 #14 Sun Sep 9 15:01:50 CEST 2007 i686 GNU/Linux
>=20
> I've checked out xenomai using svn according to:
> svn co http://svn.gna.org/svn/xenomai/trunk xenomai
> Adeos:
> adeos-ipipe-2.6.22-i386-1.10-03.patch
>=20
> sandbox:/lib/modules/2.6.22/kernel/drivers/xenomai/serial# insmod
> ./xeno_16550A.ko io=3D0x3f8,0xbc00 irq=3D4,3 tx_fifo=3D10,20 start_inde=
x=3D0

I bet the IRQ of your external serial adapter is NOT 3. Please check the
hardware manual.

> sandbox:/lib/modules/2.6.22/kernel/drivers/xenomai/serial# ls /dev/rtse=
r*
> ls: /dev/rtser*: No such file or directory
>=20
> But I do have:
> sandbox:/lib/modules/2.6.22/kernel/drivers/xenomai/serial# find /proc/
> | grep rtser
> /proc/xenomai/rtdm/rtser1
> /proc/xenomai/rtdm/rtser1/information
> /proc/xenomai/rtdm/rtser0
> /proc/xenomai/rtdm/rtser0/information
>=20
> There's a serial example coming with xenomai, I'm unsure about
> exactlly what it's supposed to do, or how I should use it. Would be
> glad if somebody could explain more about how to use the serial ports
> with xenomai driver.
>=20
> with a crossed cable between serialport1 at mobo and serialport1 at
> sunix4066 8port controllercard I get:

Basically, you already got its usage. It is a local cross link test,
running between two serial ports on the same box, that are connected via
a null modem cable. If the test is successful, you will see some round
trip statistics (yeah, needs to be documented more explicitly...).

>=20
> sandbox:/usr/src/xenomai/examples/rtdm/profiles/serial# ./cross-link
> main : write-file opened
> main : write-config written
> main : read-file opened
> main : read-config written
> main : write-task created
> main : read-task created
> main : starting write-task
> main : starting read-task
>  Nr |   write->irq    |    irq->read    |   write->read   |
> -----------------------------------------------------------
> read_task: error on rt_dev_read, code Success
> main : rtser1 (read) -> closed
> read_task: exit

There is no output likely due to one adapter being unable to get any
IRQ. You can check the IRQ activity under /proc/xenomai/irq.

>=20
> dmesg: http://pastebin.ca/688553
> .config: http://pastebin.ca/688558

Also note that Xenomai warns you about potential SMI-related latencies.
Please see the Xenomai TROUBLESHOOTING doc on this.

Jan


--------------enigF554F11DFDE39195D3EB195F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG5AhhniDOoMHTA+kRAkqPAJ9jHsu5md7E6m0VrDnkQExPbNFUDgCfR/4e
F0Ji6WSMOqOYYZGE023PO+A=
=JweG
-----END PGP SIGNATURE-----

--------------enigF554F11DFDE39195D3EB195F--

