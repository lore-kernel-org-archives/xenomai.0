Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
From: Michael Haberler <mail17@mah.priv.at>
Date: Sat, 1 Jun 2013 18:57:27 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <E921A3FF-ED99-4D82-8FB8-92F061A97E42@mah.priv.at>
References: <51AA23BC.2080501@steinkuehler.net>
Subject: [Xenomai] BeagleBone + BeBoPr 3D Printing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

things are coming together:

Anfang der weitergeleiteten Nachricht:

> Von: Charles Steinkuehler <charles@steinkuehler.net>
> Betreff: [Emc-users] BeagleBone + BeBoPr 3D Printing
> Datum: 01. Juni 2013 18:39:24 MESZ
> An: "Enhanced Machine Controller (EMC)" =
<emc-users@lists.sourceforge.net>
> Antwort an: "Enhanced Machine Controller \(EMC\)" =
<emc-users@lists.sourceforge.net>
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> So I finally got enough of the pieces put together to run a print on
> my MendelMax 3D printer using the BeagleBone with the BeBoPr cape and
> LinuxCNC.  This is using the 3.2 Xenomai kernel from Michael Haberler
> to get LinuxCNC working well on the 'Bone, and custom PRU code doing
> step/dir and pwm generation.  Thanks also to Ian for the bb_gpio
> module, which came in very handy.
>=20
> Video or it didn't happen...
>=20
> My first ever 3D print from the BeagleBone, second print using
> LinuxCNC (the first LinuxCNC print used an x86 running preempt-rt).
> The X axis is mirrored and the configuration and slicing settings need
> to be tweaked to improve print quality, but overall it came out pretty
> good:
>=20
> http://www.youtube.com/watch?v=3Dn2IoHOZipLU
>=20
> ...I particularly like the acceleration control in LinuxCNC.  It seems
> smoother than the Arduino code.  Now if I could just get a slicing
> program that outputs true arcs and nurbs...  :)
>=20
> Code is in the arm335x-hal-pru-tasks branch of Michael's git =
repository:
>=20
> =
http://git.mah.priv.at/gitweb?p=3Demc2-dev.git;a=3Dshortlog;h=3Drefs/heads=
/arm335x-hal-pru-tasks
>=20
> Up next is the great migration to a 3.8 kernel, where I get to craft
> the magic device tree fragments necessary to get this all working =
again.
>=20
> - --=20
> Charles Steinkuehler
> charles@steinkuehler.net
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (MingW32)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>=20
> iEYEARECAAYFAlGqI7sACgkQLywbqEHdNFwEkwCgw6n50qq9fP9lQLltBwTTp/0u
> rm8AoMU5hhohJljA6gpu5T+wsE/sOAES
> =3D6IRC
> -----END PGP SIGNATURE-----
>=20
> =
--------------------------------------------------------------------------=
----
> Get 100% visibility into Java/.NET code with AppDynamics Lite
> It's a free troubleshooting tool designed for production
> Get down to code-level detail for bottlenecks, with <2% overhead.
> Download for free and get started troubleshooting in minutes.
> http://p.sf.net/sfu/appdyn_d2d_ap2
> _______________________________________________
> Emc-users mailing list
> Emc-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/emc-users


