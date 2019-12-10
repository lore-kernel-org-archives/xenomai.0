Date: Tue, 10 Dec 2019 16:23:46 +0000
From: Jeff Webb <jeff.webb@protonmail.com>
Reply-To: Jeff Webb <jeff.webb@protonmail.com>
Subject: RE: [ANNOUNCE] Xenomai 3.0.10 released
Message-ID: <8wpv79_me5liHbd4OzRAJqQ8h4itwxhL_-mICsJBiz8eH85PjroDi8SB8aBHhfZTyNugCjhXRkO-IwZ3OCnOdUEGfFMtQNqbZNjGSbWGdpQ=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

I had an issue when trying to configure a kernel patched using 3.0.10.  My =
process was similar to the process I used when testing other releases.  Her=
e is what I did:

Download xenomai-v3.0.10.tar.bz2 from "Download" button here:

   https://gitlab.denx.de/Xenomai/xenomai/-/tags

tar -xvf xenomai-v3.0.10.tar.bz2
cd xenomai-v3.0.10/
DEBEMAIL=3D"your@email" DEBFULLNAME=3D"Your Name" debchange -v 3.0.10 Relea=
se 3.0.10
debuild -uc -us
cd ..
sudo dpkg -i libxenomai-dev_3.0.10_amd64.deb \
   xenomai-kernel-source_3.0.10_all.deb \
   libxenomai1_3.0.10_amd64.deb  \
   xenomai-runtime_3.0.10_amd64.deb

tar -xvf linux-4.19.84.tar.xz
cd linux-4.19.84/
/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh --arch=3Dx86 --lin=
ux=3D. --adeos=3D../ipipe-core-4.19.84-x86-8.patch
make defconfig

This yields an error:

   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/kconfig/conf.o
   YACC    scripts/kconfig/zconf.tab.c
   LEX     scripts/kconfig/zconf.lex.c
   HOSTCC  scripts/kconfig/zconf.tab.o
   HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'x86_64_defconfig'
init/Kconfig:2056: can't open file "arch/$SRCARCH/xenomai/Kconfig"
scripts/kconfig/Makefile:95: recipe for target 'defconfig' failed
make[1]: *** [defconfig] Error 1
Makefile:534: recipe for target 'defconfig' failed
make: *** [defconfig] Error 2
  scripts/kconfig/conf
*** Default configuration is based on 'x86_64_defconfig'
init/Kconfig:2056: can't open file "arch/$SRCARCH/xenomai/Kconfig"
scripts/kconfig/Makefile:95: recipe for target 'defconfig' failed
make[1]: *** [defconfig] Error 1
Makefile:534: recipe for target 'defconfig' failed
make: *** [defconfig] Error 2

The main thing that is different is that I downloaded a tarball using the b=
utton on the gitlab site rather than one from the usual release location (I=
 didn't see one there).  Maybe there is an extra step I missed in this case=
.  Any ideas?

Thanks,

-Jeff

