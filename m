MIME-Version: 1.0
Date: Thu, 3 Jan 2013 13:17:41 -0500
Message-ID: <CAD1Etoj5JcMcDS8Y7eWkbfenxxyctia_T0sSysYQk7L9fv5MfA@mail.gmail.com>
From: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] building .deb for 2.6.2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am trying to run debuild to create a .deb for Xenomai 2.6.2 on kernel
3.5.3 on x86.

The install rule in xenomai-2.6.2/debian/rules says:
    cp adeos-ipipe-*.patch
$(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
but at that point in the build process adeos-ipipe-*.patch does not seem to
exist:

[ ... ]
dh_install --sourcedir=/home/dmd/build/xenomai-2.6.2/debian/tmp
# Patch collection:
mkdir -p
/home/dmd/build/xenomai-2.6.2/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
cp adeos-ipipe-*.patch
/home/dmd/build/xenomai-2.6.2/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
cp: cannot stat `adeos-ipipe-*.patch': No such file or directory
make: *** [install] Error 1
dpkg-buildpackage: error: fakeroot debian/rules binary gave error exit
status 2
debuild: fatal error at line 1350:
dpkg-buildpackage -rfakeroot -D -us -uc failed


Am I missing something, or is the package?
