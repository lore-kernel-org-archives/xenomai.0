MIME-Version: 1.0
Date: Thu, 1 Jan 2015 20:05:32 +0530
Message-ID: <CALe7ZU1ONd1p9OFOYfHHh_FfHnmyFc-UuC6kBVQw4gQrCi2KWA@mail.gmail.com>
From: JAY KOTHARI <jaikothari10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] cross compiling xenomai application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi,
    I am trying to cross compile xenomai user space application with this
command for Beagle Bone Black

arm-linux-gnueabihf-gcc -I/usr/xenomai/include -I/usr/xenomai -D_GNU_SOURCE
-D_REENTRANT -D__XENO__ -lnative -L/usr/xenomai/lib -L/usr/xenomai/
-lxenomai -lpthread -lrt -Xlinker -rpath -Xlinker /usr/xenomai/lib
1_trivial-periodic.c -o 1_trivial-periodic -lnative -lpthread -lxenomai

But I am facing linking error as follows


 In file included from /usr/xenomai/include/nucleus/trace.h:53:0,

from /usr/xenomai/include/nucleus/system.h:27,

from /usr/xenomai/include/asm/xenomai/system.h:128,

from /usr/xenomai/include/nucleus/types.h:36,

from /usr/xenomai/include/nucleus/thread.h:25,

from /usr/xenomai/include/nucleus/sched.h:31,

from /usr/xenomai/include/native/task.h:25,

from 1_trivial-periodic.c:6:

/usr/xenomai/include/asm/xenomai/tsc.h: In function =E2=80=98__xn_rdtsc=E2=
=80=99:

/usr/xenomai/include/asm/xenomai/tsc.h:37:2: warning: left shift count >=3D
width of type [enabled by default]

return ((unsigned long)__a) | (((unsigned long)__d) << 32);

^

/opt/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux/bin/../lib/gcc/arm-li=
nux-gnueabihf/4.8.3/../../../../arm-linux-gnueabihf/bin/ld:
skipping incompatible /usr/xenomai/lib/libnative.so when searching for
-lnative

/opt/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux/bin/../lib/gcc/arm-li=
nux-gnueabihf/4.8.3/../../../../arm-linux-gnueabihf/bin/ld:
skipping incompatible /usr/xenomai/lib/libnative.a when searching for
-lnative

/opt/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux/bin/../lib/gcc/arm-li=
nux-gnueabihf/4.8.3/../../../../arm-linux-gnueabihf/bin/ld:
cannot find -lnative

/opt/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux/bin/../lib/gcc/arm-li=
nux-gnueabihf/4.8.3/../../../../arm-linux-gnueabihf/bin/ld:
skipping incompatible /usr/xenomai/lib/libxenomai.so when searching for
-lxenomai

/opt/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux/bin/../lib/gcc/arm-li=
nux-gnueabihf/4.8.3/../../../../arm-linux-gnueabihf/bin/ld:
skipping incompatible /usr/xenomai/lib/libxenomai.a when searching for
-lxenomai

/opt/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux/bin/../lib/gcc/arm-li=
nux-gnueabihf/4.8.3/../../../../arm-linux-gnueabihf/bin/ld:
cannot find -lxenomai

collect2: error: ld returned 1 exit status



Can anyone help me who had faced similar problem.What might be I am
missing?Help would be Appreciated.
Thank You

Jay Kothari
