Message-ID: <4448FB62.3090107@domain.hid>
Date: Fri, 21 Apr 2006 17:33:54 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig67C9CED6CFE605D3EDD6BF33"
Subject: [Xenomai-help] [ANNOUNCE] RACK project officially started
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig67C9CED6CFE605D3EDD6BF33
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

We are proud to announce the first release of the Robotics Application
Construction Kit (RACK) project. Version 0.1.0 as well as the evolving
subversion repository can be found at

	http://developer.berlios.de/projects/rack

RACK aims at providing a framework for building robotics applications,
specifically for mobile service robots. It supports the development of
hard real-time as well as non-real-time components, it defines component
classes for sensor and actuator drivers (e.g. robot chassis, laser
scanners, cameras, odometry, GPS, or joysticks) as well as data
processing components (e.g. laser scan post-processors, navigators, or
localisation modules), and it specifies the interfaces between them.

RACK's real-time components are implemented in C++ and make use of the
real-time services Xenomai provides. Non-real-time components so far
concentrates on GUI elements which are implemented in Java, extending
this support to Linux C/C++ applications is planned. RACK comes with its
own interprocess communication mechanism called TiMS (Tiny Messaging
Service). TiMS supports both hard RT and non-RT communication via a
mailbox mechanism, locally or distributed via RTnet or standard TCP/IP.
Specifically TiMS' local exchange of larger message chunks is optimised
for both determinism and throughput, an optimisation of the non-RT path
is on our roadmap.

RACK 0.1.0 comes with support for real hardware like the popular Pioneer
platform, Sick LMS200 and Hokuyo URG laser scanners, or GPS NMEA
modules. And it also contains simulators for a robot platform with
odometry sensors and for a laser scanner. This allows to run a demo over
a real-time platform without the need for specific hardware. Check the
README for details.

Documentation is yet far from being perfect (or is simple missing), also
some quirks will certainly be hidden in the code. So, any questions on
the design or bug reports are welcome and will help to improve the
usability of RACK further.

- The RACK development team -

Daniel
Jan
Joerg (Leader)
Matthias
Marko
Oliver

University of Hannover, ISE, Real-Time Systems Group
http://www.rts.uni-hannover.de



--------------enig67C9CED6CFE605D3EDD6BF33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESPtincNeS9Q0k+IRAqcSAJ9r4/2GSEhb7vQhIjsVjls5wU9YXwCbBWRr
FhtBoex4H7IqaFHzUPKKifg=
=Hiar
-----END PGP SIGNATURE-----

--------------enig67C9CED6CFE605D3EDD6BF33--

