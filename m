Message-ID: <45AE68CF.5080200@domain.hid>
Date: Wed, 17 Jan 2007 19:19:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Compiling Linux+Xenomai 32bits kernel
	on	FC6	x86_64?
References: <cbe23c50701170051r46cadf4cha5b144d17df2ec77@domain.hid>	<45ADE724.3010800@domain.hid>
	<45AE3ED4.7040506@domain.hid>
In-Reply-To: <45AE3ED4.7040506@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig09BDCC4B34F81F8147E43206"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig09BDCC4B34F81F8147E43206
Content-Type: multipart/mixed; boundary="------------060200090008000709080507"

This is a multi-part message in MIME format.
--------------060200090008000709080507
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> Matthias Fechner wrote:
>> Eric Noulard schrieb:
>>> Is it possible to run/boot a 32bit xenomai on a 64 bit system
>>> or should I really need to install a 32bit only system on my 64 bit
>>> machine?
>>> If yes how to do this properly?
>>> If no
>>>   - is there a planned support for 64bit in xenomai/adeos?
>>>   - what should I do to use Xenomai on my 64 bit machine?
>>
>> I had exactly the same problem and I installed a second 32-bit Linux o=
n
>> my harddisk and easily linked some dirs from my old 64-bit installatio=
n
>> to save space (e.g. /usr/src, /usr/local).
>=20
> I installed the FC6 i386 version on a second partition as well.  After
> that, I followed the steps outlined in the attached file to build kerne=
l
> and Xenomai RPMs.

Hmm, that tickles my fantasy once again: Could we derive generic .specs
from your files to include them in the Xenomai distribution? Then some
additional Makefile rules could provide a "make rpm" that generates
packages for kernel and userland (when given some kernel.tar.bz2).
Basically, your steps generalised and automated.

This would help us to provide, e.g., an i386 pre-built package with
reasonable default config, something I still consider useful. But, of
course, it must not cost any effort :). Automated rpm generation would
be a big step in that direction.

BTW, have you seen my Xenomai.spec for the SuSE packages I once posted?
Attached is an updated version. It splits the Xenomai userland in
several sub-packages to allow selective installation.

>=20
>> But the best is a Xenomai which supports 64-bit AMD processors :)
>=20
> Of course!

Yeah. Who's going to do this? ;)

[Really, it depends on someone feeling enough need to work on this (or
sponsor the work). A few pieces are already there from previous RTAI
efforts towards x86-64 support. But now it takes a clean implementation
over recent Linux/I-pipe/Xenomai.]

Jan

--------------060200090008000709080507
Content-Type: text/plain;
 name="xenomai.spec"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xenomai.spec"

#
# spec file for package xenomai (Version 2.3.0)
#
# Copyright (c) 2006 Jan Kiszka.
# This file and all modifications and additions to the pristine
# package are under the same license as the package itself.
#
# Please submit bugfixes or comments via xenomai@xenomai.org
#

# norootforbuild
# usedforbuild    aaa_base acl attr audit-libs autoconf automake bash bin=
d-libs bind-utils binutils bison bzip2 coreutils cpio cpp cracklib cvs cy=
rus-sasl db diffutils e2fsprogs file filesystem fillup findutils flex gaw=
k gcc gcc-c++ gdbm gdbm-devel gettext gettext-devel glibc glibc-devel gli=
bc-locale gpm grep groff gzip info insserv klogd less libacl libattr libc=
om_err libgcc libnscd libstdc++ libstdc++-devel libtool libxcrypt libzio =
m4 make man mktemp module-init-tools ncurses ncurses-devel net-tools netc=
fg openldap2-client openssl pam pam-modules patch perl permissions popt p=
rocinfo procps psmisc pwdutils rcs readline rpm sed strace sysvinit tar t=
cpd texinfo timezone unzip util-linux vim zlib zlib-devel

Name:           xenomai
BuildRequires:  gcc
URL:            http://www.xenomai.org/
License:        LGPL
Group:          System/Base
Summary:        Xenomai Userland (libraries, tools, tests)
Version:        2.3.0
Release:        2
Source0:        xenomai-%{version}.tar.bz2
BuildRoot:      %{_tmppath}/%{name}-%{version}-build

%description
Xenomai is a real-time development framework cooperating with the Linux k=
ernel, in order to provide a pervasive, interface-agnostic, hard real-tim=
e support to user-space applications, seamlessly integrated into the GNU/=
Linux environment.



Authors:
--------
    Philippe Gerum <rpm@xenomai.org>
    and others

%debug_package
%prep
%setup -q

%build
CFLAGS=3D"$RPM_OPT_FLAGS -Wall -DNDEBUG" \
CXXFLAGS=3D"$RPM_OPT_FLAGS -Wall -DNDEBUG" \
=2E/configure	\
	--prefix=3D%{_prefix}			\
	--libdir=3D%{_libdir}			\
	--mandir=3D%{_mandir}			\
	--enable-x86-tsc --enable-x86-sep
make %{?jobs:-j%jobs}

%install
[ "$RPM_BUILD_ROOT" !=3D "/" ] && [ -d $RPM_BUILD_ROOT ] && rm -rf $RPM_B=
UILD_ROOT
make install-user DESTDIR=3D$RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%{_bindir}/*
%{_sbindir}/*
%{_libdir}/lib*.so*
%{_mandir}/*
/usr/share/xenomai/*


%package doc
Group:          Documentation/HTML
Summary:        Xenomai API Documentation

%description doc
Xenomai API Documentation

%files doc
%defattr(-,root,root)
%docdir /usr/share/doc
/usr/share/doc/*


%package devel

Group:		Development/Libraries/C and C++
Summary:	Xenomai Headers and Libraries

%description devel
Xenomai Headers and Libraries

%files devel
%defattr(-,root,root)
/usr/include/*
%{_libdir}/lib*.a
%{_libdir}/lib*.la
%{_libdir}/posix.wrappers

%changelog -n xenomai
* Fri Jan 5 2007 - jan.kiszka@domain.hid
- rebased over 2.3 release
* Sun Dec 10 2006 - jan.kiszka@domain.hid
- move posix.wrappers to devel
- rebased over SVN + reorder-installation.patch
* Wed Nov 22 2006 - jan.kiszka@domain.hid
- initial version based on 2.3-rc2


--------------060200090008000709080507--

--------------enig09BDCC4B34F81F8147E43206
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrmjPniDOoMHTA+kRAsnKAJ9NxP6W4OfsrNdFmhkMfHdEERZcUgCeK7aZ
r4YL76VpHWE0sBCVEQDNlb0=
=Owbg
-----END PGP SIGNATURE-----

--------------enig09BDCC4B34F81F8147E43206--

