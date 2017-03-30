MIME-Version: 1.0
From: Benjamin Alix <alixbenjamin53@gmail.com>
Date: Thu, 30 Mar 2017 17:56:37 +0200
Message-ID: <CAHz_r8DdqD_jRhr452riik5wu55hDmjOr3T4ap8r3PwAaWAPpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai]  Compilation error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I'm compiling Xenomai 3.0.3 with a cross toolchain built with buildroot
(based on gcc 6.3.0) and when it comes to build xenomai I get the following
errors :

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
error: pasting "__cobalt_" and "(" does not give a valid preprocessing token
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
error: pasting "__real_" and "(" does not give a valid preprocessing token
 COBALT_DECL(int, fputc(int c, FILE *stream));
 ^
/free/stagiaire/buildroot-2017.02/output/build/xenomai-3.0.3/include/cobalt/stdio.h:68:18:
error: expected declaration specifiers or '...' before '(' token
 COBALT_DECL(int, fputc(int c, FILE *stream));

I think it has something to do with token concatenation in preprocessors in
include/cobalt/wrappers.h but I'm not even sure. I
