MIME-Version: 1.0
In-Reply-To: <CAHz_r8DdqD_jRhr452riik5wu55hDmjOr3T4ap8r3PwAaWAPpw@mail.gmail.com>
References: <CAHz_r8DdqD_jRhr452riik5wu55hDmjOr3T4ap8r3PwAaWAPpw@mail.gmail.com>
From: Benjamin Alix <alixbenjamin53@gmail.com>
Date: Fri, 31 Mar 2017 15:49:13 +0200
Message-ID: <CAHz_r8DUdsE7HEDWQk1mULAEw1xZ4GqgNW71ggWUHn1_ZGtfQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Fwd:  Compilation error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---------- Forwarded message ----------
From: Benjamin Alix <alixbenjamin53@gmail.com>
Date: 2017-03-30 17:56 GMT+02:00
Subject: [Xenomai] Compilation error
To: xenomai@xenomai.org


Hi,

I'm compiling Xenomai 3.0.3 with a cross toolchain built with
buildroot (based on gcc 6.3.0) and when it comes to build xenomai I
get the following errors :

make[5]: Entering directory
`/free/stagiaire/buildroot-2017.02/output/build/xenomai-3.0.3/lib/boilerplate/init'
  CC       libbootstrap_a-bootstrap.o
  CC       libbootstrap_pic_la-bootstrap.lo
In file included from
/free/stagiaire/buildroot-2017.02/output/build/xenomai-3.0.3/include/cobalt/time.h:26:0,
                 from
/free/stagiaire/buildroot-2017.02/output/host/usr/powerpc-buildroot-linux-uclibc/sysroot/usr/include/sys/types.h:132,
                 from bootstrap.c:18:
/free/stagiaire/buildroot-2017.02/output/build/xenomai-3.0.3/include/cobalt/stdio.h:68:1:
error: pasting "__cobalt_" and "(" does not give a valid preprocessing
token
 COBALT_DECL(int, fputc(int c, FILE *stream));
 ^
/free/stagiaire/buildroot-2017.02/output/build/xenomai-3.0.3/include/cobalt/stdio.h:68:18:
error: expected declaration specifiers or '...' before '(' token
 COBALT_DECL(int, fputc(int c, FILE *stream));
                  ^
/free/stagiaire/buildroot-2017.02/output/build/xenomai-3.0.3/include/cobalt/stdio.h:68:18:
error: expected declaration specifiers or '...' before '(' token
 COBALT_DECL(int, fputc(int c, FILE *stream));
                  ^
/free/stagiaire/buildroot-2017.02/output/build/xenomai-3.0.3/include/cobalt/stdio.h:68:1:
error: pasting "__real_" and "(" does not give a valid preprocessing
token
 COBALT_DECL(int, fputc(int c, FILE *stream));
 ^
/free/stagiaire/buildroot-2017.02/output/build/xenomai-3.0.3/include/cobalt/stdio.h:68:18:
error: expected declaration specifiers or '...' before '(' token
 COBALT_DECL(int, fputc(int c, FILE *stream));

I think it has something to do with token concatenation in
preprocessors in include/cobalt/wrappers.h but I'm not even sure. I

Sorry, I mistakingly sent the email earlier than I wanted and could'nt
correct it until now.

More context : I'm compiling for a powerpc 32 bits architecture. The
configuration is :
[...]build/xenomai-3.0.3 > ./scripts/xeno-config --info
Xenomai version: 3.0.3
Cobalt core is NOT present on this system
Compiler: gcc version 6.3.0 (Buildroot 2017.02)
Build args: --target=powerpc-buildroot-linux-uclibc
--host=powerpc-buildroot-linux-uclibc --build=x86_64-pc-linux-gnu
--prefix=/usr --exec-prefix=/usr --sysconfdir=/etc
--localstatedir=/var --program-prefix= --disable-gtk-doc
--disable-gtk-doc-html --disable-doc --disable-docs
--disable-documentation --with-xmlto=no --with-fop=no
--disable-dependency-tracking --enable-ipv6 --disable-nls
--disable-static --enable-shared --includedir=/usr/include/xenomai/
--disable-doc-install build_alias=x86_64-pc-linux-gnu
host_alias=powerpc-buildroot-linux-uclibc
target_alias=powerpc-buildroot-linux-uclibc
CC=/buildroot-2017.02/output/host/usr/bin/powerpc-buildroot-linux-uclibc-gcc
CFLAGS=-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
-D_FILE_OFFSET_BITS=64  -O2  LDFLAGS= CPPFLAGS=-D_LARGEFILE_SOURCE
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
CPP=/buildroot-2017.02/output/host/usr/bin/powerpc-buildroot-linux-uclibc-cpp
PKG_CONFIG=/buildroot-2017.02/output/host/usr/bin/pkg-config

Buildroot adds a lot of configuration options, anyway I tried to
compile outside buildroot and still got the same error message.

Thanks for your attention.

Regards,

Benjamin

