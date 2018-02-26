From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Mon, 26 Feb 2018 21:41:35 +0000
Message-ID: <DB6PR0701MB245683DC50B4B964F0D846AAB5C10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] testsuite/smokey/dlopen fails to build when building out
	of tree
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

git checkout stable-3.0.x
scripts/bootstrap
mkdir -p ../xenomai-3-build && cd ../xenomai-3-build
../xenomai-3/configure --with-core=3Dcobalt --enable-pshared --host=3Darm-l=
inux-gnueabihf --build=3Darm CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" --ena=
ble-dlopen-libs
make  V=3D1

will eventually result in
arm-linux-gnueabihf-gcc -DHAVE_CONFIG_H -I. -I../../../../xenomai-3/testsui=
te/smokey/dlopen -I../../../include  -I/home/giulio/bela-image-builder/down=
loads/xenomai-3/lib/cobalt/arch/arm/include -I/home/giulio/bela-image-build=
er/downloads/xenomai-3/kernel/cobalt/arch/arm/include -DNDEBUG -O2 -D_GNU_S=
OURCE -D_REENTRANT -fasynchronous-unwind-tables -pipe -fstrict-aliasing -Wa=
ll -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long -Wno-unused-para=
meter -Werror -D__XENO__ -D__IN_XENO__ -I/home/giulio/bela-image-builder/do=
wnloads/xenomai-3/include/cobalt -DXENO_TEST_DIR=3D'"/usr/xenomai/bin"' -I.=
./../../../xenomai-3   -march=3Darmv7-a -mfpu=3Dvfp3 -MT libdlopen_a-dlopen=
.o -MD -MP -MF .deps/libdlopen_a-dlopen.Tpo -c -o libdlopen_a-dlopen.o `tes=
t -f 'dlopen.c' || echo '../../../../xenomai-3/testsuite/smokey/dlopen/'`dl=
open.c
In file included from ../../../../xenomai-3/testsuite/smokey/dlopen/dlopen.=
c:24:0:
/home/giulio/bela-image-builder/downloads/xenomai-3/include/cobalt/stdio.h:=
28:29: fatal error: cobalt/wrappers.h: No such file or directory

so it is missing a -I../../../../xenomai-3/include



