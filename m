From: Leopold Palomo Avellaneda <leo@domain.hid>
Date: Tue, 15 Jul 2008 23:46:17 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20972483.SjcGyqNBLa";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200807152346.21863.leo@domain.hid>
Subject: [Xenomai-help] OT. A question about constraints in realtime
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--nextPart20972483.SjcGyqNBLa
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear people,

first of all this is an Off topic, so please don't be angry with me. If you=
=20
don't want to answer, move this message to /dev/null. But I have a problem=
=20
with a device and maybe some people in this list could give me some idea.

I'm working in a robotics lab and we have a device (a haptic from Sensable)=
=20
that it's connected to the parallel port. Of course that the Sensable compa=
ny=20
doesn't not publish open source drivers, etc. By now it's an sterile=20
discussion.

Anyway, they provide a driver that it's a lib (.so). Also there's some libr=
ary=20
that can act with the device using that driver. Excepting the driver, for t=
he=20
other parts I have some source code.

I have had several problems with this driver. Firstly, the driver only can=
=20
works if the parport module detects the EPP mode. Sadly, the linux parport=
=20
module is more or less unmaintained and fails in many boxes to detect the E=
PP=20
mode, although the bios is configured to.

After that, you can read encoders of the device (using the driver) but when=
=20
you send forces to the engines, it suffers some kind of chattering and the=
=20
driver disable the force because the loop of control expend too much time.=
=20

Asking in some forum I have arrived to the conclusion that the driver has s=
ome=20
kind of timer and if it doesn't not receive any order in 1ms, then the forc=
e=20
is disabled.

So, my question are:
=2D Why the windows driver works so well? the scheduler in Windows do that =
if a=20
task need to have a constraint of 1ms they give it the control and that's=20
all?
=2D Why a linux driver doesn't not work? the load of the box is quiet norma=
l.=20
I'm not compiling or solving eigen systems. Or is possible that some device=
=20
is breaking some access to the parport, or whatever?
=2D I have tried to use the realtime kernel -rt but same result.=20
=2D Can I do something with xenomai to avoid it?

The sensable people claims that their driver works with some versions of Li=
nux=20
(till fedora 4 and some suse) but I'm not be able to run it in a debian etc=
h.=20
I don't know if the distros provide a kernel with some kind of modification=
s=20
that solve it, but I don't think so.


Well, thanks in advance and I'm sorry for the noise. Really, the realtime=20
stuff is something not obvious...

Best regards,

Leo


=2D-=20
=2D-
Linux User 152692
PGP: 0xF944807E
Catalonia

--nextPart20972483.SjcGyqNBLa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkh9GqoACgkQaC7AnPlEgH4wkwCeOme4MLDkwQ2jrA5Ax+Rp/9rf
degAn3ut3DqUCU60b16Waia7OMNFrrIg
=WPvk
-----END PGP SIGNATURE-----

--nextPart20972483.SjcGyqNBLa--

