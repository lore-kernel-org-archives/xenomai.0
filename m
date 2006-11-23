Message-ID: <456555A2.7020605@domain.hid>
Date: Thu, 23 Nov 2006 09:02:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB6C7C71C52841FA63A7494BD"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [ANNOUNCE] Experimental OpenSuSE packages
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6C7C71C52841FA63A7494BD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

this is a nightly hack to evaluate some possibilities for a binary
Xenomai release:

i586 rpm packages of Xenomai for OpenSuSE 10.1!

	http://www.rts.uni-hannover.de/rtaddon/rpms/

Though the packages already claim to be Xenomai 2.3, they are not newer
than our latest release candidate 2.


The kernel package is actually based on SuSE's original latest 2.6.16
kernel, which was fairly trivial work. Additionally, that kernel
contains the software-suspend-enable patch I once posted for I-pipe
(still works fine on my Thinkpad).

The user-space packages are split up like this:
 - core package with libs, tools, testsuite, and man-pages
 - devel package with headers and static linking objects
 - doc package with doxygen HTML stuff

The kernel was been successfully tested, the user packages not. Err,
I mean I haven't installed them on my notebook as they would have messed
up my Xenomai installation.


So I'm seeking now for testers - and enthusiasts interested in driving
this idea further. I'm not able to set up a regular packaging service on
my own, but help on integration work can be provided. There is no black
magic behind building such packages, it just takes its time to compile,
test, adjust, recompile, test, ...

We have now a base to start from, but there are still things that could
be improved (besides tracking the releases regularly):
 - SMP kernel builds
 - Vanilla kernel spec file
 - Target directory for the testsuite (/usr/testsuite is not that
   elegant right now)


I think such pre-built packages can be quite helpful for users who want
to start over with Xenomai quickly. And they can also be useful for us
developers in order to offer users a reference platform when hunting
(i386 or arch-independent) issues in Xenomai.

Jan


--------------enigB6C7C71C52841FA63A7494BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFZVWiniDOoMHTA+kRAsYiAJ9iEhEAZLpbrPl6dIBgOEQ7EK1kuwCfdjlo
SA9XB/d7/yJRzya6eMPFjFI=
=h6C5
-----END PGP SIGNATURE-----

--------------enigB6C7C71C52841FA63A7494BD--

