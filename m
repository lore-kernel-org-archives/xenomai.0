MIME-Version: 1.0
Date: Wed, 18 Sep 2013 19:29:18 +0200
Message-ID: <CAEk6gTBsZCz4Z0N7dF1w6UEy_OVGF7_-Zbo=gVk3+N=DDpZ_VQ@mail.gmail.com>
From: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Xenomai Yocto Bitbake recipe configuration error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,
regarding chapter  3.4. Building for ARM here:
http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/
we should configure like :

$xenomai_root/configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t" \
  --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi-

I wanted to know if CFLAGS and LDFLAGS are needed only for compile
time, or maybe later for runtime also?

Because if they are needed only for compile, these can be passed
directly in invocation of Make, or copiler/linker - no explicit need
to give them to compile.

I am asking this because I am trying to compile Xenomai with Yoct
bitbake recipe, and I added :

EXTRA_OECONF += "CFLAGS=\"-march=armv7-a -mfpu=vfp3\"
LDFLAGS=\"-march=armv7-a -mfpu=vfp3\"  \
                    --build=x86_64-linux-gnu --host=arm-linux-gnueabihf"


However, bitbake wrongly passes this to shell like
'CFLAGS="-march=armv7-a' '-mfpu=vfp3"' 'LDFLAGS="-march=armv7-a'
'-mfpu=vfp3"' (see log below).

So, I wanted to know if I can configure without these flags, and later
pass them to compiler and linker with instructions to Bitbake for
compiler/linker, and not in project compile script.

Best regards,
Drasko





DEBUG: Executing python function sysroot_cleansstate
DEBUG: Python function sysroot_cleansstate finished
DEBUG: SITE files ['endian-little', 'bit-32', 'arm-common',
'common-linux', 'common-glibc', 'arm-linux', 'arm-linux-gnueabi',
'common']
DEBUG: Executing shell function autotools_preconfigure
+ cd /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
+ autotools_preconfigure

+ cd /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
+ autotools_preconfigure
DEBUG: Shell function autotools_preconfigure finished
DEBUG: Executing shell function do_configure
+ cd /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
+ do_configure
+ autotools_do_configure

+ cd /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
+ do_configure
+ autotools_do_configure
++ find /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
-name configure.in -o -name configure.ac

++ find /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
-name configure.in -o -name configure.ac
+ for ac in '`find
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
-name configure.in -o -name configure.ac`'

+ for ac in '`find
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
-name configure.in -o -name configure.ac`'
++ dirname /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure.in

++ dirname /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure.in
+ rm -f /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure

+ rm -f /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
+ '[' -e /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure.in
-o -e /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure.ac
']'

+ '[' -e /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure.in
-o -e /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure.ac
']'
++ pwd

++ pwd
+ olddir=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
+ cd /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
+ rm -rf /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/

+ olddir=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
+ cd /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
+ rm -rf /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
+ '[' xdefault = xdefault ']'
+ acpaths=

+ '[' xdefault = xdefault ']'
+ acpaths=
++ find /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
-maxdepth 2 -name '*.m4'

++ find /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
-maxdepth 2 -name '*.m4'
++ grep -v aclocal.m4
++ grep -v acinclude.m4
++ sed -e 's,\(.*/\).*$,\1,'

++ grep -v aclocal.m4
++ grep -v acinclude.m4
++ sed -e 's,\(.*/\).*$,\1,'
++ sort -u

++ sort -u
+ for i in '`find
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
-maxdepth 2 -name \*.m4|grep -v '\''aclocal.m4'\''| grep -v
'\''acinclude.m4'\'' | sed -e '\''s,\(.*/\).*$,\1,'\''|sort -u`'
+ acpaths=' -I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/'

+ for i in '`find
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
-maxdepth 2 -name \*.m4|grep -v '\''aclocal.m4'\''| grep -v
'\''acinclude.m4'\'' | sed -e '\''s,\(.*/\).*$,\1,'\''|sort -u`'
+ acpaths=' -I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/'
++ automake --version

++ automake --version
++ head -n 1
++ sed 's/.* //;s/\.[0-9]\+$//'

++ head -n 1
++ sed 's/.* //;s/\.[0-9]\+$//'
+ AUTOV=1.12
+ automake --version

+ AUTOV=1.12
+ automake --version
automake (GNU automake) 1.12.3
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv2+: GNU GPL version 2 or later
<http://gnu.org/licenses/gpl-2.0.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Tom Tromey <tromey@redhat.com>
       and Alexandre Duret-Lutz <adl@gnu.org>.

automake (GNU automake) 1.12.3
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv2+: GNU GPL version 2 or later
<http://gnu.org/licenses/gpl-2.0.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Tom Tromey <tromey@redhat.com>
       and Alexandre Duret-Lutz <adl@gnu.org>.
+ echo 'AUTOV is 1.12'
AUTOV is 1.12
+ '[' -d /home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
']'

+ echo 'AUTOV is 1.12'
AUTOV is 1.12
+ '[' -d /home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
']'
+ acpaths=' -I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12'
+ '[' -d /home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5/usr/share/aclocal
']'
+ cp-noerror /home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5/usr/share/aclocal
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/

+ acpaths=' -I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12'
+ '[' -d /home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5/usr/share/aclocal
']'
+ cp-noerror /home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5/usr/share/aclocal
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
+ acpaths=' -I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/'

+ acpaths=' -I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/'
+ echo --exclude=autopoint
+ grep -q aclocal

+ echo --exclude=autopoint
+ grep -q aclocal
+ rm -f aclocal.m4

+ rm -f aclocal.m4
+ '[' -e configure.in ']'
+ CONFIGURE_AC=configure.in

+ '[' -e configure.in ']'
+ CONFIGURE_AC=configure.in
+ echo 'CFLAGS="-march=armv7-a' '-mfpu=vfp3"'
'LDFLAGS="-march=armv7-a' '-mfpu=vfp3"' --build=x86_64-linux-gnu
--host=arm-linux-gnueabihf

+ echo 'CFLAGS="-march=armv7-a' '-mfpu=vfp3"'
'LDFLAGS="-march=armv7-a' '-mfpu=vfp3"' --build=x86_64-linux-gnu
--host=arm-linux-gnueabihf
+ grep -q '\-\-disable-nls'

+ grep -q '\-\-disable-nls'
+ grep '^[[:space:]]*AM_GLIB_GNU_GETTEXT' configure.in

+ grep '^[[:space:]]*AM_GLIB_GNU_GETTEXT' configure.in
+ grep '^[[:space:]]*AM_GNU_GETTEXT' configure.in

+ grep '^[[:space:]]*AM_GNU_GETTEXT' configure.in
+ mkdir -p m4

+ mkdir -p m4
+ grep '^[[:space:]]*[AI][CT]_PROG_INTLTOOL' configure.in

+ grep '^[[:space:]]*[AI][CT]_PROG_INTLTOOL' configure.in
+ bbnote Executing autoreconf --verbose --install --force
--exclude=autopoint -I
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
+ echo 'NOTE: Executing autoreconf --verbose --install --force
--exclude=autopoint -I
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/'
NOTE: Executing autoreconf --verbose --install --force
--exclude=autopoint -I
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/

+ bbnote Executing autoreconf --verbose --install --force
--exclude=autopoint -I
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
+ echo 'NOTE: Executing autoreconf --verbose --install --force
--exclude=autopoint -I
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/'
NOTE: Executing autoreconf --verbose --install --force
--exclude=autopoint -I
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
+ autoreconf -Wcross --verbose --install --force --exclude=autopoint
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/

+ autoreconf -Wcross --verbose --install --force --exclude=autopoint
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
autoreconf: Entering directory `.'

autoreconf: Entering directory `.'
autoreconf: configure.in: not using Gettext

autoreconf: configure.in: not using Gettext
autoreconf: running: aclocal -I
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I /home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I /home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
--force -I config

autoreconf: running: aclocal -I
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I /home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
-I /home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
-I /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
--force -I config
autoreconf: configure.in: tracing

autoreconf: configure.in: tracing
autoreconf: running: libtoolize --copy --force

autoreconf: running: libtoolize --copy --force
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `config'.

libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `config'.
libtoolize: copying file `config/ltmain.sh'

libtoolize: copying file `config/ltmain.sh'
libtoolize: putting macros in `config'.

libtoolize: putting macros in `config'.
libtoolize: copying file `config/libtool.m4'

libtoolize: copying file `config/libtool.m4'
libtoolize: copying file `config/ltoptions.m4'

libtoolize: copying file `config/ltoptions.m4'
libtoolize: copying file `config/ltsugar.m4'

libtoolize: copying file `config/ltsugar.m4'
libtoolize: copying file `config/ltversion.m4'

libtoolize: copying file `config/ltversion.m4'
libtoolize: copying file `config/lt~obsolete.m4'

libtoolize: copying file `config/lt~obsolete.m4'
libtoolize: Consider adding `AC_CONFIG_MACRO_DIR([m4])' to configure.in and
libtoolize: rerunning libtoolize, to keep the correct libtool macros in-tree.

libtoolize: Consider adding `AC_CONFIG_MACRO_DIR([m4])' to configure.in and
libtoolize: rerunning libtoolize, to keep the correct libtool macros in-tree.
autoreconf: running:
/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/bin/autoconf
--include=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
--include=/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
--include=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
--force

autoreconf: running:
/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/bin/autoconf
--include=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
--include=/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
--include=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
--force
autoreconf: running:
/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/bin/autoheader
--include=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
--include=/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
--include=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
--force

autoreconf: running:
/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/bin/autoheader
--include=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/
--include=/home/drasko/yocto/build/tmp/sysroots/x86_64-linux/usr/share/aclocal-1.12
--include=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/aclocal-copy/
--force
autoreconf: running: automake --foreign --add-missing --copy --force-missing

autoreconf: running: automake --foreign --add-missing --copy --force-missing
autoreconf: running: gnu-configize

autoreconf: running: gnu-configize
autoreconf: Leaving directory `.'

autoreconf: Leaving directory `.'
+ cd /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1

+ cd /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
+ '[' -e /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
']'
+ oe_runconf
+ cfgscript=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
+ '[' -x /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
']'
+ bbnote 'Running
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
 --build=x86_64-linux  --host=arm-poky-linux-gnueabi
--target=arm-poky-linux-gnueabi  --prefix=/usr  --exec_prefix=/usr
--bindir=/usr/bin  --sbindir=/usr/sbin  --libexecdir=/usr/libexec
--datadir=/usr/share  --sysconfdir=/etc  --sharedstatedir=/com
--localstatedir=/var  --libdir=/usr/lib  --includedir=/usr/include
--oldincludedir=/usr/include  --infodir=/usr/share/info
--mandir=/usr/share/man  --disable-silent-rules
--disable-dependency-tracking
--with-libtool-sysroot=/home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5
 CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a
-mfpu=vfp3"                      --build=x86_64-linux-gnu
--host=arm-linux-gnueabihf '

+ '[' -e /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
']'
+ oe_runconf
+ cfgscript=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
+ '[' -x /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
']'
+ bbnote 'Running
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
 --build=x86_64-linux  --host=arm-poky-linux-gnueabi
--target=arm-poky-linux-gnueabi  --prefix=/usr  --exec_prefix=/usr
--bindir=/usr/bin  --sbindir=/usr/sbin  --libexecdir=/usr/libexec
--datadir=/usr/share  --sysconfdir=/etc  --sharedstatedir=/com
--localstatedir=/var  --libdir=/usr/lib  --includedir=/usr/include
--oldincludedir=/usr/include  --infodir=/usr/share/info
--mandir=/usr/share/man  --disable-silent-rules
--disable-dependency-tracking
--with-libtool-sysroot=/home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5
 CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a
-mfpu=vfp3"                      --build=x86_64-linux-gnu
--host=arm-linux-gnueabihf '
+ echo 'NOTE: Running
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
 --build=x86_64-linux  --host=arm-poky-linux-gnueabi
--target=arm-poky-linux-gnueabi  --prefix=/usr  --exec_prefix=/usr
--bindir=/usr/bin  --sbindir=/usr/sbin  --libexecdir=/usr/libexec
--datadir=/usr/share  --sysconfdir=/etc  --sharedstatedir=/com
--localstatedir=/var  --libdir=/usr/lib  --includedir=/usr/include
--oldincludedir=/usr/include  --infodir=/usr/share/info
--mandir=/usr/share/man  --disable-silent-rules
--disable-dependency-tracking
--with-libtool-sysroot=/home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5
 CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a
-mfpu=vfp3"                      --build=x86_64-linux-gnu
--host=arm-linux-gnueabihf '
NOTE: Running /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
 --build=x86_64-linux  --host=arm-poky-linux-gnueabi
--target=arm-poky-linux-gnueabi  --prefix=/usr  --exec_prefix=/usr
--bindir=/usr/bin  --sbindir=/usr/sbin  --libexecdir=/usr/libexec
--datadir=/usr/share  --sysconfdir=/etc  --sharedstatedir=/com
--localstatedir=/var  --libdir=/usr/lib  --includedir=/usr/include
--oldincludedir=/usr/include  --infodir=/usr/share/info
--mandir=/usr/share/man  --disable-silent-rules
--disable-dependency-tracking
--with-libtool-sysroot=/home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5
 CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a
-mfpu=vfp3"                      --build=x86_64-linux-gnu
--host=arm-linux-gnueabihf
+ set +e
+ /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
--build=x86_64-linux --host=arm-poky-linux-gnueabi
--target=arm-poky-linux-gnueabi --prefix=/usr --exec_prefix=/usr
--bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/libexec
--datadir=/usr/share --sysconfdir=/etc --sharedstatedir=/com
--localstatedir=/var --libdir=/usr/lib --includedir=/usr/include
--oldincludedir=/usr/include --infodir=/usr/share/info
--mandir=/usr/share/man --disable-silent-rules
--disable-dependency-tracking
--with-libtool-sysroot=/home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5
'CFLAGS="-march=armv7-a' '-mfpu=vfp3"' 'LDFLAGS="-march=armv7-a'
'-mfpu=vfp3"' --build=x86_64-linux-gnu --host=arm-linux-gnueabihf

+ echo 'NOTE: Running
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
 --build=x86_64-linux  --host=arm-poky-linux-gnueabi
--target=arm-poky-linux-gnueabi  --prefix=/usr  --exec_prefix=/usr
--bindir=/usr/bin  --sbindir=/usr/sbin  --libexecdir=/usr/libexec
--datadir=/usr/share  --sysconfdir=/etc  --sharedstatedir=/com
--localstatedir=/var  --libdir=/usr/lib  --includedir=/usr/include
--oldincludedir=/usr/include  --infodir=/usr/share/info
--mandir=/usr/share/man  --disable-silent-rules
--disable-dependency-tracking
--with-libtool-sysroot=/home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5
 CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a
-mfpu=vfp3"                      --build=x86_64-linux-gnu
--host=arm-linux-gnueabihf '
NOTE: Running /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
 --build=x86_64-linux  --host=arm-poky-linux-gnueabi
--target=arm-poky-linux-gnueabi  --prefix=/usr  --exec_prefix=/usr
--bindir=/usr/bin  --sbindir=/usr/sbin  --libexecdir=/usr/libexec
--datadir=/usr/share  --sysconfdir=/etc  --sharedstatedir=/com
--localstatedir=/var  --libdir=/usr/lib  --includedir=/usr/include
--oldincludedir=/usr/include  --infodir=/usr/share/info
--mandir=/usr/share/man  --disable-silent-rules
--disable-dependency-tracking
--with-libtool-sysroot=/home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5
 CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a
-mfpu=vfp3"                      --build=x86_64-linux-gnu
--host=arm-linux-gnueabihf
+ set +e
+ /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
--build=x86_64-linux --host=arm-poky-linux-gnueabi
--target=arm-poky-linux-gnueabi --prefix=/usr --exec_prefix=/usr
--bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/libexec
--datadir=/usr/share --sysconfdir=/etc --sharedstatedir=/com
--localstatedir=/var --libdir=/usr/lib --includedir=/usr/include
--oldincludedir=/usr/include --infodir=/usr/share/info
--mandir=/usr/share/man --disable-silent-rules
--disable-dependency-tracking
--with-libtool-sysroot=/home/drasko/yocto/build/tmp/sysroots/socfpga_cyclone5
'CFLAGS="-march=armv7-a' '-mfpu=vfp3"' 'LDFLAGS="-march=armv7-a'
'-mfpu=vfp3"' --build=x86_64-linux-gnu --host=arm-linux-gnueabihf
configure: error: unrecognized option: `-mfpu=vfp3"'
Try `/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
--help' for more information

configure: error: unrecognized option: `-mfpu=vfp3"'
Try `/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/configure
--help' for more information
+ '[' 1 '!=' 0 ']'
+ echo 'Configure failed. The contents of all config.log files follows
to aid debugging'
Configure failed. The contents of all config.log files follows to aid debugging
+ find /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
-name config.log -print -exec cat '{}' ';'

+ '[' 1 '!=' 0 ']'
+ echo 'Configure failed. The contents of all config.log files follows
to aid debugging'
Configure failed. The contents of all config.log files follows to aid debugging
+ find /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1
-name config.log -print -exec cat '{}' ';'
+ bbfatal 'oe_runconf failed'
+ echo 'ERROR: oe_runconf failed'
ERROR: oe_runconf failed
+ exit 1

+ bbfatal 'oe_runconf failed'
+ echo 'ERROR: oe_runconf failed'
ERROR: oe_runconf failed
+ exit 1
ERROR: Function failed: do_configure (see
/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/temp/log.do_configure.8389
for further information)

