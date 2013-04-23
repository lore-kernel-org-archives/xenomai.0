Message-ID: <5176410F.1060100@gmail.com>
Date: Tue, 23 Apr 2013 10:06:39 +0200
From: Victor Hiairrassary <victor.hiairrassary.ml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] xenomai "does not" ISO C, C99 and C++ standard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

We use xenomai 2.6.2.1 with g++ 4.7.2 from buildroot on a Armadeus apf27
board. This works really fine, but if we add "-W -Werror -Wall -pedantic
-pedantic-errors" in compiler command line, g++ detects some warnings for
a code as simple as :

#include <native/task.h>
int main() {
     return 0;
}

The complete log of the compilation is attached with this email.

The compiler complains about various things, in differents files. I have =

not
tested other xenomai's headers like native/queue.h, etc. yet.

Do you have any plans to fix them?

Best regards,
Victor Hiairrassary
-------------- next part --------------
arm-g++ -o main.o -c main.cpp -W -Werror -Wall -pedantic -pedantic-errors -=
I sysroot/usr/include/xenomai/ -std=3Dc++11
In file included from sysroot/usr/include/xenomai/nucleus/trace.h:52:0,
                 from sysroot/usr/include/xenomai/nucleus/system.h:27,
                 from sysroot/usr/include/xenomai/asm/xenomai/system.h:260,
                 from sysroot/usr/include/xenomai/nucleus/types.h:36,
                 from sysroot/usr/include/xenomai/nucleus/thread.h:25,
                 from sysroot/usr/include/xenomai/nucleus/sched.h:31,
                 from sysroot/usr/include/xenomai/native/task.h:25,
                 from main.cpp:1:
sysroot/usr/include/xenomai/asm/xenomai/syscall.h:108:34: error: ISO C does=
 not permit named variadic macros [-Wvariadic-macros]
sysroot/usr/include/xenomai/asm/xenomai/syscall.h:178:52: error: ISO C does=
 not permit named variadic macros [-Wvariadic-macros]
In file included from sysroot/usr/include/xenomai/nucleus/system.h:27:0,
                 from sysroot/usr/include/xenomai/asm/xenomai/system.h:260,
                 from sysroot/usr/include/xenomai/nucleus/types.h:36,
                 from sysroot/usr/include/xenomai/nucleus/thread.h:25,
                 from sysroot/usr/include/xenomai/nucleus/sched.h:31,
                 from sysroot/usr/include/xenomai/native/task.h:25,
                 from main.cpp:1:
sysroot/usr/include/xenomai/nucleus/trace.h:56:1: error: ISO C99 requires r=
est arguments to be used
sysroot/usr/include/xenomai/nucleus/trace.h:61:1: error: ISO C99 requires r=
est arguments to be used
sysroot/usr/include/xenomai/nucleus/trace.h:66:1: error: ISO C99 requires r=
est arguments to be used
sysroot/usr/include/xenomai/nucleus/trace.h:71:1: error: ISO C99 requires r=
est arguments to be used
sysroot/usr/include/xenomai/nucleus/trace.h:76:1: error: ISO C99 requires r=
est arguments to be used
sysroot/usr/include/xenomai/nucleus/trace.h:82:1: error: ISO C99 requires r=
est arguments to be used
sysroot/usr/include/xenomai/nucleus/trace.h:87:1: error: ISO C99 requires r=
est arguments to be used
sysroot/usr/include/xenomai/nucleus/trace.h:94:1: error: ISO C99 requires r=
est arguments to be used
In file included from sysroot/usr/include/xenomai/nucleus/thread.h:25:0,
                 from sysroot/usr/include/xenomai/nucleus/sched.h:31,
                 from sysroot/usr/include/xenomai/native/task.h:25,
                 from main.cpp:1:
sysroot/usr/include/xenomai/nucleus/types.h:133:26: error: ISO C does not p=
ermit named variadic macros [-Wvariadic-macros]
sysroot/usr/include/xenomai/nucleus/types.h:134:27: error: ISO C does not p=
ermit named variadic macros [-Wvariadic-macros]
sysroot/usr/include/xenomai/nucleus/types.h:135:27: error: ISO C does not p=
ermit named variadic macros [-Wvariadic-macros]
sysroot/usr/include/xenomai/nucleus/types.h:136:26: error: ISO C does not p=
ermit named variadic macros [-Wvariadic-macros]
sysroot/usr/include/xenomai/nucleus/types.h:137:35: error: ISO C does not p=
ermit named variadic macros [-Wvariadic-macros]
sysroot/usr/include/xenomai/nucleus/types.h:139:32: error: ISO C does not p=
ermit named variadic macros [-Wvariadic-macros]
In file included from sysroot/usr/include/xenomai/nucleus/system.h:27:0,
                 from sysroot/usr/include/xenomai/asm/xenomai/system.h:260,
                 from sysroot/usr/include/xenomai/nucleus/types.h:36,
                 from sysroot/usr/include/xenomai/nucleus/thread.h:25,
                 from sysroot/usr/include/xenomai/nucleus/sched.h:31,
                 from sysroot/usr/include/xenomai/native/task.h:25,
                 from main.cpp:1:
sysroot/usr/include/xenomai/nucleus/trace.h: In function 'int xntrace_max_b=
egin(long unsigned int)':
sysroot/usr/include/xenomai/nucleus/trace.h:56:9: error: ISO C++ forbids br=
aced-groups within expressions [-pedantic]
sysroot/usr/include/xenomai/nucleus/trace.h: In function 'int xntrace_max_e=
nd(long unsigned int)':
sysroot/usr/include/xenomai/nucleus/trace.h:61:9: error: ISO C++ forbids br=
aced-groups within expressions [-pedantic]
sysroot/usr/include/xenomai/nucleus/trace.h: In function 'int xntrace_max_r=
eset()':
sysroot/usr/include/xenomai/nucleus/trace.h:66:9: error: ISO C++ forbids br=
aced-groups within expressions [-pedantic]
sysroot/usr/include/xenomai/nucleus/trace.h: In function 'int xntrace_user_=
start()':
sysroot/usr/include/xenomai/nucleus/trace.h:71:9: error: ISO C++ forbids br=
aced-groups within expressions [-pedantic]
sysroot/usr/include/xenomai/nucleus/trace.h: In function 'int xntrace_user_=
stop(long unsigned int)':
sysroot/usr/include/xenomai/nucleus/trace.h:76:9: error: ISO C++ forbids br=
aced-groups within expressions [-pedantic]
sysroot/usr/include/xenomai/nucleus/trace.h: In function 'int xntrace_user_=
freeze(long unsigned int, int)':
sysroot/usr/include/xenomai/nucleus/trace.h:81:9: error: ISO C++ forbids br=
aced-groups within expressions [-pedantic]
sysroot/usr/include/xenomai/nucleus/trace.h: In function 'int xntrace_speci=
al(unsigned char, long unsigned int)':
sysroot/usr/include/xenomai/nucleus/trace.h:87:9: error: ISO C++ forbids br=
aced-groups within expressions [-pedantic]
sysroot/usr/include/xenomai/nucleus/trace.h: In function 'int xntrace_speci=
al_u64(unsigned char, long long unsigned int)':
sysroot/usr/include/xenomai/nucleus/trace.h:92:9: error: ISO C++ forbids br=
aced-groups within expressions [-pedantic]
make: *** [main.o] Error 1
