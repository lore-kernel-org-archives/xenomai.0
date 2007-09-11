Message-ID: <46E6F290.9090901@domain.hid>
Date: Tue, 11 Sep 2007 21:54:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>	
	<46E58BE4.9090109@domain.hid>	
	<1ce16a2c0709101142r6cf2d624oe443807575eadcfa@domain.hid>	
	<46E59235.2060506@domain.hid>
	<1ce16a2c0709110837r52eedac7vcc970d5c3b4e2d53@domain.hid>
In-Reply-To: <1ce16a2c0709110837r52eedac7vcc970d5c3b4e2d53@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE432646EA472675C2C23BA70"
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
--------------enigE432646EA472675C2C23BA70
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Bachman Kharazmi wrote:
> Now I've a modified crosslink (attached) which take argument and write
> to rtser0.
> I know it's ugly. But it's working and that's always good ;)
>=20
> Anyhow. From what I've heard it will be inefficient if my java code
> would call "/usr/src/xenomai/example/crosslink string" even time a
> string should be written to serial.

Yes, it is better to avoid continuous process generations/destructions
for such kind of work, rather write a native Java binding to Xenomai in
order to talk to the serial port.

Hmm... Java... that makes me wonder again if your control loop is ought
to be closed over Java and where you got/will get the RT-capable Java
engine from. Could you tell us more about the architecture?

>=20
> And as it looks now I can't even run the binary as user else than root
> (since it starts a xenmai thread?).

There is a module parameter of the nucleus called xenomai_gid. Provide a
group ID, and all users of that group will gain "Xenomai-power" (means
also the power to toast the box by spawning a CPU hog etc.). That allows
you to do at least /some/ kind of privilege separation between RT users
and root, though not a strictly secure one.

Did we already document this feature outside the code? Can't remember
right now though I hacked it... :-/

>=20
> How can I as a 'user' open a device, write to it and close it without
> keeping starting processes or threads every time?
>=20
> I would like to be able to do something like:
> file =3D  open("/dev/myTestSerialDevice");
> while (...)
> file.write(...)
> and finally close
> file.close() when there's no more to write.

You can copy this code almost unmodified into an application and compile
it against the Xenomai POSIX skin. The serial port configuration apart
(same under Linux, though), it will open "rtser<whatever>", even if
given like "/dev/rtser...", and work on that port as if it where a Linux
one. Life can be simple, sometimes.

Jan



--------------enigE432646EA472675C2C23BA70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG5vKQniDOoMHTA+kRAjoUAJkByIV8zkmF3MZajxnhS41viyOShgCeI0lE
EOvEdqnQhfCOKK0EcexNORQ=
=XzkW
-----END PGP SIGNATURE-----

--------------enigE432646EA472675C2C23BA70--

