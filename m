Message-ID: <46E42260.8090703@domain.hid>
Date: Sun, 09 Sep 2007 18:42:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709081159y62fbb73bwb16d2cae7a931774@domain.hid>	<1189285467.6013.20.camel@domain.hid>	<1ce16a2c0709090730o1a803c99r70aea4410eda49ed@domain.hid>	<46E4085F.3080509@domain.hid>	<1ce16a2c0709090809y5e1732adj5081fcb556734142@domain.hid>	<46E41146.1060701@domain.hid>
	<1ce16a2c0709090913u8f60b10r89651400e10a7f7d@domain.hid>
In-Reply-To: <1ce16a2c0709090913u8f60b10r89651400e10a7f7d@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig31339B4AFD50FD34479BE852"
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
--------------enig31339B4AFD50FD34479BE852
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bachman Kharazmi wrote:
> I'm trying to implement a rt java motioncontrol-platform releated to
> smerobot.org
> I need to control three drives(rs232) connected to brushless dc motors.=

>=20
> The current PC I'm working on has one builtin serial port, and I found
> a SUNIX 8port controller. So that's the reason why I'm using the pci
> controller.
>=20
> Anyhow the drivers are fetched from:
> http://sunix.com.tw/it/en/DRIVER.php?SID&classnumber=3D3&usid1=3D303&us=
id2=3D304&Psid=3D472
>=20
> I counldn't find any license releated information :/
> But source comes with the driver is copied temporarily here:
> http://bachman.tor.lindesign.se/tmp/driver/
>=20
> Are there any chance that modifications in the source will get it going=
?

Maybe we are just lacking some pci_enable_device() on the right pci_dev.
That would mean extending xeno_16550A to deal with PCI devices. Surely
feasible, but it takes time and hardware to test - I'm lacking both.

Are you willing to play a bit with it? Then, as a prototype, you could
pick up the lookup and enabling code from the snx driver and hack it
into xeno_16550A. If that works, we could discuss how to establish
something generic for PCI-based adapters.

Note that I haven't read through that driver in details. There is a
slight risk that some more bits are different. On the other hand, the
16650 UART that seems to be on that card is advertised as
16550-compatible, thus it /should/ work...

Jan


--------------enig31339B4AFD50FD34479BE852
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG5CJgniDOoMHTA+kRAmTkAJ44DQ23p3Tj57tdzsfRqH6W1xZsiQCZAf2t
PI5UU1/ke0hfwiOnJ8JenFU=
=/6hI
-----END PGP SIGNATURE-----

--------------enig31339B4AFD50FD34479BE852--

