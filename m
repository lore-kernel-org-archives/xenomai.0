From: Leopold Palomo Avellaneda <lepalom@domain.hid>
Date: Thu, 15 Nov 2007 00:13:46 +0100
References: <4739E07B.1000608@domain.hid>
	<200711141637.30166.paul_c@domain.hid>
	<200711142214.17651.paul_c@domain.hid>
In-Reply-To: <200711142214.17651.paul_c@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4769075.zMH4RTuL6e";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200711150013.51123.lepalom@domain.hid>
Subject: Re: [Xenomai-help] [Xenomai-core]  Xenomai v2.4-rc6
Reply-To: lepalom@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

--nextPart4769075.zMH4RTuL6e
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A Dimecres 14 Novembre 2007, Paul va escriure:
> On Wednesday 14 November 2007 16:37, Paul wrote:
> > I'm right in the middle of looking at the packaging scripts, so expect a
> > patch within the next few days.
>
> Attached, one patch for the Debian rules. The debian/changelog version wi=
ll
> need to be bumped up to 2.4.0-1 once we get out of the -rc phase. I'll
> submit a trivial patch at that point and build a set of i386 & amd64
> packages.
>
Thank's,

the patch has worked well for me (amd64), however I should say that the=20
packages are not lintian free. I can mention:

package xenomai-dev
=2D------------------------------------------------------------------------=
=2D-----
W: xenomai-dev: symlink-is-self-recursive=20
usr/include/xenomai/asm-sim/xenomai .
N:
N:   The symbolic link is recursive to a higher directory of the symlink
N:   itself. This means, that you can infinitely chdir with this symlink.
N:   This is usually not okay, but sometimes wanted behaviour.
N:
W: xenomai-dev: symlink-is-self-recursive usr/include/xenomai/asm-sim/asm .
W: xenomai-dev: symlink-is-self-recursive=20
usr/include/xenomai/asm-x86/xenomai .
W: xenomai-dev: symlink-is-self-recursive usr/include/xenomai/xenomai .
W: xenomai-dev: symlink-is-self-recursive=20
usr/include/xenomai/asm-generic/xenomai .

package xenomai
=2D------------------------------------------------------------------------=
=2D-----
E: xenomai: shell-script-fails-syntax-check ./usr/bin/xeno-test
W: xenomai:=20
executable-not-elf-or-script ./usr/share/xenomai/testsuite/cyclic/run
W: xenomai:=20
executable-not-elf-or-script ./usr/share/xenomai/testsuite/irqbench/run
W: xenomai:=20
executable-not-elf-or-script ./usr/share/xenomai/testsuite/switchtest/run
W: xenomai:=20
executable-not-elf-or-script ./usr/share/xenomai/testsuite/latency/run
W: xenomai:=20
executable-not-elf-or-script ./usr/share/xenomai/testsuite/clocktest/run
W: xenomai:=20
executable-not-elf-or-script ./usr/share/xenomai/testsuite/switchbench/run
W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libpsos.so.0.0.0=20
usr/lib/libpsos.so
W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/librtai.so.0.0.0=20
usr/lib/librtai.so
W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libnative.so.1.0.0=20
usr/lib/libnative.so
W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libuitron.so.0.0.0=20
usr/lib/libuitron.so
W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/librtdm.so.1.0.0=20
usr/lib/librtdm.so
W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libpthread_rt.so.1.0.0=20
usr/lib/libpthread_rt.so
W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libvxworks.so.1.0.0=20
usr/lib/libvxworks.so
W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/librtdk.so.0.0.0=20
usr/lib/librtdk.so
W: xenomai: non-dev-pkg-with-shlib-symlink usr/lib/libvrtx.so.0.0.0=20
usr/lib/libvrtx.so
E: xenomai: postinst-must-call-ldconfig usr/lib/librtdk.so.0.0.0
W: xenomai: postrm-should-call-ldconfig usr/lib/librtdk.so.0.0.0
E: xenomai: description-starts-with-package-name
W: xenomai: description-synopsis-might-not-be-phrased-properly
W: xenomai: package-name-doesnt-match-sonames libpsos0 librtdm1 libvxworks1=
=20
libuitron0 librtdk0 librtai0 libnative1 libvrtx0 libpthread-rt1


lintian linux-patch-xenomai_2.4.0-0+rc6_all.deb
internal error: syntax error in section 1 after the tag description: =20
Patch-file: adeos-ipipe-2.6.15-arm-1.5-08.patch

regards,

Leo

=2D-=20
=2D-
Linux User 152692
PGP: 0xF944807E
Catalonia

--nextPart4769075.zMH4RTuL6e
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHO4EvaC7AnPlEgH4RAtbbAJ9Q0egMN3rN5eCTf6CxVAKVO/iadACeMLP5
1hiN/OnPzS7IkEp5Bir6Vik=
=dUQ7
-----END PGP SIGNATURE-----

--nextPart4769075.zMH4RTuL6e--

