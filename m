From: Steve Pavao <stevep@korgrd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Tue, 19 Dec 2017 11:51:00 -0500
Message-Id: <0CF46CB0-D92C-4DCE-B93F-4291374D8328@korgrd.com>
Subject: [Xenomai] Cobalt core and Yocto
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello -

How should I adapt my Yocto poky recipes to make sure that Cobalt core =
boots?  Right now, the only relevant information that appears on dmesg =
is:

"Interrupt pipeline (release #4)=E2=80=9D

Here are my recipes, which work fine, but Cobalt core does not boot.  I =
must need something else in my recipe(s).

For I-PIPE Patch, my recipe file is linux-intel_4.9.bbappend:

FILESEXTRAPATHS_prepend :=3D "${THISDIR}/files:"
SRC_URI +=3D "file://ipipe-core-4.9.51-x86-4.patch"


For Xenomai 3 user libs, my recipe file is xenomai_3.0.6.bb:

DESCRIPTION =3D "Provides userspace xenomai support and libraries needed =
to for \
real-time applications using the xenomai RTOS implementation (v3)"
LICENSE =3D "MIT"
LIC_FILES_CHKSUM =3D =
"file://include/COPYING;md5=3D79ed705ccb9481bf9e7026b99f4e2b0e"
SECTION =3D "xenomai"
HOMEPAGE =3D "http://www.xenomai.org/"
PR =3D "r0"

SRC_URI =3D =
"http://xenomai.org/downloads/xenomai/stable/latest/xenomai-3.0.6.tar.bz2"=


S =3D "${WORKDIR}/xenomai-${PV}"

inherit autotools pkgconfig

includedir =3D "/usr/include/xenomai"

#Fixes QA Issues: non debug package contains .debug directory
#FILES_${PN}-dbg +=3D "/usr/bin/regression/posix/.debug"
#FILES_${PN}-dbg +=3D "/usr/bin/regression/native/.debug"
#FILES_${PN}-dbg +=3D "/usr/bin/regression/native+posix/.debug"
#FILES_${PN}-dbg +=3D "/usr/demo/.debug/*"

#Fixes QA Error - Non-dev package contains symlink .so
FILES_${PN}-dev +=3D "/usr/lib/*.se"

#Add directories to package for shipping
FILES_${PN} +=3D "/dev"
FILES_${PN} +=3D "/dev/*"
FILES_${PN} +=3D "/usr/bin/*"
FILES_${PN} +=3D "/usr/lib/*"
FILES_${PN} +=3D "/usr/sbin/*"
FILES_${PN} +=3D "/usr/include/*"
FILES_${PN} +=3D "/usr/lib/*"
FILES_${PN} +=3D "/usr/share/doc/*"
FILES_${PN} +=3D "/usr/share/man/*"
FILES_${PN} +=3D "/usr/demo/*"

SRC_URI[md5sum] =3D "6017203d0992bb5334498c196bf6f25d"
SRC_URI[sha256sum] =3D =
"2c0dd3f0e36e4a10f97e0028989bb873e80f4d1ce212ac55fd3b28857c464f94"

TARGET_CC_ARCH +=3D "${LDFLAGS}=E2=80=9D=20


Thanks for any ideas.  Hopefully, I am pretty close with these recipes.

- Steve Pavao
Korg R&D
















