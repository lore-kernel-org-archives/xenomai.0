From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Packaging issues and licensing issues
Date: Sun, 16 Oct 2005 23:18:22 +0900
References: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>
	<17234.1633.131281.653004@domain.hid>
	<200510161500.41910.paul_c@domain.hid>
In-Reply-To: <200510161500.41910.paul_c@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vEmUDMRR1xiY9Q4"
Message-Id: <200510162318.23056.rlenglet@domain.hid>
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

--Boundary-00=_vEmUDMRR1xiY9Q4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Paul,

> Using the debian/rules I did a few weeks ago as a basis for
> further work, I can work with Romain to develop it further.
> Not sure that having separate packages for each skin is a good
> idea, but certainly m-a is worth persuing.

Yes, finally I think that one set of packages for every skin 
would be overkill.

As my 2 yen contribution, here is a debian/control file (ok, this 
is the easiest task, but someone had to do it...). ;)

As for the rules file, I think that the most difficult will be to 
generate the module source package. There is already a skeleton 
of a source package generating a module source package, in the 
documentation of package module-assistant:
/usr/share/doc/module-assistant/examples/templates-debian-dir.tar.bz2

What I did is to start with dh_make --kmod, then modify the 
control file to define the other packages. Then we should try to 
reuse module-assistant's template, that is apparently used by 
all other module source packages in Debian.

-- 
Romain Lenglet

--Boundary-00=_vEmUDMRR1xiY9Q4
Content-Type: text/plain;
  charset="iso-8859-1";
  name="control"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="control"

Source: xenomai
Section: devel
Priority: extra
Maintainer: Romain Lenglet <rlenglet@domain.hid>
Build-Depends: debhelper (>= 4.0.0), autotools-dev
Standards-Version: 3.6.2

Package: libxenomai
Architecture: i386 powerpc
Depends: ${shlibs:Depends}, ${misc:Depends}
Description: Xenomai real-time framework (libraries)
 Xenomai is a real-time development framework cooperating with the
 Linux kernel, in order to provide a pervasive, interface-agnostic,
 hard real-time support to user-space applications, seamlessly
 integrated into the GNU/Linux environment.
 .
 Xenomai is based on an abstract RTOS core, usable for building any
 kind of real-time interfaces, over a nucleus which exports a set of
 generic RTOS services. Any number of RTOS personalities called
 "skins" can then be built over the nucleus, providing their own
 specific interface to the applications, by using the services of a
 single generic core to implement it.
 .
 This package contains the runtime shared libraries.

Package: libxenomai-dev
Architecture: i386 powerpc
Depends: ${shlibs:Depends}, ${misc:Depends}
Description: Xenomai real-time framework (development)
 Xenomai is a real-time development framework cooperating with the
 Linux kernel, in order to provide a pervasive, interface-agnostic,
 hard real-time support to user-space applications, seamlessly
 integrated into the GNU/Linux environment.
 .
 Xenomai is based on an abstract RTOS core, usable for building any
 kind of real-time interfaces, over a nucleus which exports a set of
 generic RTOS services. Any number of RTOS personalities called
 "skins" can then be built over the nucleus, providing their own
 specific interface to the applications, by using the services of a
 single generic core to implement it.
 .
 This package contains the development environment.

Package: libxenomai-tools
Architecture: i386 powerpc
Depends: ${shlibs:Depends}, ${misc:Depends}
Description: Xenomai real-time framework (tools)
 Xenomai is a real-time development framework cooperating with the
 Linux kernel, in order to provide a pervasive, interface-agnostic,
 hard real-time support to user-space applications, seamlessly
 integrated into the GNU/Linux environment.
 .
 Xenomai is based on an abstract RTOS core, usable for building any
 kind of real-time interfaces, over a nucleus which exports a set of
 generic RTOS services. Any number of RTOS personalities called
 "skins" can then be built over the nucleus, providing their own
 specific interface to the applications, by using the services of a
 single generic core to implement it.
 .
 This package contains command-line tools for testing Xenomai.

Package: libxenomai-doc
Architecture: i386 powerpc
Depends: ${shlibs:Depends}, ${misc:Depends}
Description: Xenomai real-time framework (documentation)
 Xenomai is a real-time development framework cooperating with the
 Linux kernel, in order to provide a pervasive, interface-agnostic,
 hard real-time support to user-space applications, seamlessly
 integrated into the GNU/Linux environment.
 .
 Xenomai is based on an abstract RTOS core, usable for building any
 kind of real-time interfaces, over a nucleus which exports a set of
 generic RTOS services. Any number of RTOS personalities called
 "skins" can then be built over the nucleus, providing their own
 specific interface to the applications, by using the services of a
 single generic core to implement it.
 .
 This package contains documentation on the usage of the libraries.

Package: xenomai-source
Architecture: i386 powerpc
Depends: module-assistant, debhelper (>>4.0.0), make, bzip2
Recommends: kernel-patch-adeos (>=20050809)
Description: Xenomai real-time framework (kernel module source)
 Xenomai is a real-time development framework cooperating with the
 Linux kernel, in order to provide a pervasive, interface-agnostic,
 hard real-time support to user-space applications, seamlessly
 integrated into the GNU/Linux environment.
 .
 Xenomai is based on an abstract RTOS core, usable for building any
 kind of real-time interfaces, over a nucleus which exports a set of
 generic RTOS services. Any number of RTOS personalities called
 "skins" can then be built over the nucleus, providing their own
 specific interface to the applications, by using the services of a
 single generic core to implement it.
 .
 This package provides the source code for the xenomai kernel modules.
 The xenomai package is also required in order to make use of these
 modules. Kernel source or headers are required to compile these modules.

--Boundary-00=_vEmUDMRR1xiY9Q4--

