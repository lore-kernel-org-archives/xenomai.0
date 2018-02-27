References: <DB6PR0701MB245683DC50B4B964F0D846AAB5C10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9a650f3c-3423-f8ce-6828-f8e93215567e@xenomai.org>
Date: Tue, 27 Feb 2018 09:34:46 +0100
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB245683DC50B4B964F0D846AAB5C10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] testsuite/smokey/dlopen fails to build when building
 out of tree
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/26/2018 10:41 PM, Giulio Moro wrote:
> git checkout stable-3.0.x
> scripts/bootstrap
> mkdir -p ../xenomai-3-build && cd ../xenomai-3-build
> ../xenomai-3/configure --with-core=cobalt --enable-pshared --host=arm-linux-gnueabihf --build=arm CFLAGS="-march=armv7-a -mfpu=vfp3" --enable-dlopen-libs
> make  V=1
> 
> will eventually result in
> arm-linux-gnueabihf-gcc -DHAVE_CONFIG_H -I. -I../../../../xenomai-3/testsuite/smokey/dlopen -I../../../include  -I/home/giulio/bela-image-builder/downloads/xenomai-3/lib/cobalt/arch/arm/include -I/home/giulio/bela-image-builder/downloads/xenomai-3/kernel/cobalt/arch/arm/include -DNDEBUG -O2 -D_GNU_SOURCE -D_REENTRANT -fasynchronous-unwind-tables -pipe -fstrict-aliasing -Wall -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__ -I/home/giulio/bela-image-builder/downloads/xenomai-3/include/cobalt -DXENO_TEST_DIR='"/usr/xenomai/bin"' -I../../../../xenomai-3   -march=armv7-a -mfpu=vfp3 -MT libdlopen_a-dlopen.o -MD -MP -MF .deps/libdlopen_a-dlopen.Tpo -c -o libdlopen_a-dlopen.o `test -f 'dlopen.c' || echo '../../../../xenomai-3/testsuite/smokey/dlopen/'`dlopen.c
> In file included from ../../../../xenomai-3/testsuite/smokey/dlopen/dlopen.c:24:0:
> /home/giulio/bela-image-builder/downloads/xenomai-3/include/cobalt/stdio.h:28:29: fatal error: cobalt/wrappers.h: No such file or directory
> 
> so it is missing a -I../../../../xenomai-3/include
> 
> 

Now fixed in the repo, thanks.

diff --git a/testsuite/smokey/dlopen/Makefile.am
b/testsuite/smokey/dlopen/Makefile.am
index b8c3ab34a..56e16b510 100644
--- a/testsuite/smokey/dlopen/Makefile.am
+++ b/testsuite/smokey/dlopen/Makefile.am
@@ -60,4 +60,4 @@ libdlopen_a_SOURCES = dlopen.c
 libdlopen_a_CPPFLAGS =				\
 	@XENO_USER_CFLAGS@			\
 	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'	\
-	-I$(top_srcdir)
+	-I$(top_srcdir)/include


-- 
Philippe.

