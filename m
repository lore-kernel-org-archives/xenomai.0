From: Romain Lenglet <rlenglet@domain.hid>
Date: Sun, 16 Oct 2005 16:51:31 +0900
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200510161651.31795.rlenglet@domain.hid>
Subject: [Xenomai-core] Packaging issues - part 2
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,


Some more packaging issues...


There is currently no man page for binaries (xeno-config,=20
xeno-info, xeno-load and xeno-test), but there should.


It would be nice to build the documentation when building the=20
packages. Patrick, you wrote that it is not possible to build=20
the documentation using packages available in Debian. Could you=20
explain that please? This should be fixed.


In addition, I am wondering if it could be useful to package=20
every skin in a separate package, e.g. libxenomai-posix,=20
libxenomai-rtdm, etc.
What do you think about that?
This would imply to have also one module source package for every=20
skin (e.g. xenomai-posix-source, xenomai-rtdm-source, etc.), and=20
to be careful about dependencies between modules, but it can be=20
manageable.
That way, the I-am-dreaming-for packages for RTnet would directly=20
depend on xenomai-rtdm-source and libxenomai-rtdm.


There is also an issue about some compile-time flags. I think=20
that there is no risk in enabling and packaging every skin, but=20
how about --enable-x86-sep and --enable-smi-workaround ???
What should be enabled by default (in the standard package)?
Should we make several different packages compiled with the=20
different options? How about the many combinations of=20
=2D-enable-periodic-smi, --enable-intel-usb2-smi, --enable-mc-smi,=20
etc., etc.?!
=46rom a user/packager point of view, it would be much better if=20
those flags were kernel module parameters, and to have only=20
package / set of modules to deal with. Is it possible to make=20
that change? Would the runtime penalty be acceptable?
As for --enable-x86-sep, I guess that it is safe to disable it by=20
default, wether or not users use NTPL, but can someone confirm=20
this?

=2D-=20
Romain Lenglet

