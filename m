MIME-Version: 1.0
Date: Tue, 30 Dec 2014 15:29:35 +0530
Message-ID: <CA+HFbxBb=jgQc4uL0NQmjndsLQQ6B7Sa5aH9vDLcrtQX0U-+Qw@mail.gmail.com>
From: satya patel <satya087@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Compilation errors for Linux kernel 3.10.18 +
 ipipe-core-3.10.18-arm-1.patch + xenomai-3-3.0-rc2.tar.bz2.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am trying to apply =E2=80=9Cipipe-core-3.10.18-arm-1.patch=E2=80=9D to Li=
nux kernel
3.10.18. (Arm Platform, with default config file - omap2plus_defconfig)

When I apply the patch using Xenomai 2.x (xenomai-2.6-2.6.0-rc5.tar)
compilation is successful after following the instructions mentioned in the
below link:

http://xenomai.org/installing-xenomai-2-x/

i.e. compilation for - Linux kernel 3.10.18  +
ipipe-core-3.10.18-arm-1.patch + xenomai-2.6-2.6.0-rc5.tar Is OK.



However, I get compilation errors for below combination.

Linux kernel 3.10.18  + ipipe-core-3.10.18-arm-1.patch +
xenomai-3-3.0-rc2.tar.bz2 --- COMPILATION ERRORS.



In file included from include/xenomai/cobalt/kernel/vfile.h:26:0,

                 from include/xenomai/cobalt/kernel/clock.h:24,

                 from include/xenomai/cobalt/kernel/stat.h:23,

                 from include/xenomai/cobalt/kernel/thread.h:25,

                 from arch/arm/xenomai/mayday.c:22:

include/xenomai/cobalt/kernel/lock.h: In function =C3=A2__xnlock_get_irqsav=
e=C3=A2:

include/xenomai/cobalt/kernel/lock.h:216:29: error: =C3=A2ipipe_smp_p=C3=A2
undeclared (first use in this function)

#define __locking_active__  ipipe_smp_p

                             ^

include/xenomai/cobalt/kernel/lock.h:226:6: note: in expansion of macro
=C3=A2__locking_active__=C3=A2

  if (__locking_active__)

      ^

include/xenomai/cobalt/kernel/lock.h:216:29: note: each undeclared
identifier is reported only once for each function it appears in

#define __locking_active__  ipipe_smp_p

                             ^

include/xenomai/cobalt/kernel/lock.h:226:6: note: in expansion of macro
=C3=A2__locking_active__=C3=A2

  if (__locking_active__)

      ^

include/xenomai/cobalt/kernel/lock.h: In function =C3=A2__xnlock_put_irqres=
tore=C3=A2:

include/xenomai/cobalt/kernel/lock.h:216:29: error: =C3=A2ipipe_smp_p=C3=A2
undeclared (first use in this function)

#define __locking_active__  ipipe_smp_p

                             ^

include/xenomai/cobalt/kernel/lock.h:236:6: note: in expansion of macro
=C3=A2__locking_active__=C3=A2

  if (__locking_active__ && !(flags & 2))

      ^

include/xenomai/cobalt/kernel/lock.h: In function =C3=A2xnlock_is_owner=C3=
=A2:

include/xenomai/cobalt/kernel/lock.h:216:29: error: =C3=A2ipipe_smp_p=C3=A2
undeclared (first use in this function)

#define __locking_active__  ipipe_smp_p

                             ^

include/xenomai/cobalt/kernel/lock.h:244:6: note: in expansion of macro
=C3=A2__locking_active__=C3=A2

  if (__locking_active__)

      ^

include/xenomai/cobalt/kernel/lock.h: In function =C3=A2__xnlock_get=C3=A2:

include/xenomai/cobalt/kernel/lock.h:216:29: error: =C3=A2ipipe_smp_p=C3=A2
undeclared (first use in this function)

#define __locking_active__  ipipe_smp_p

                             ^

include/xenomai/cobalt/kernel/lock.h:252:6: note: in expansion of macro
=C3=A2__locking_active__=C3=A2

  if (__locking_active__)

      ^

include/xenomai/cobalt/kernel/lock.h: In function =C3=A2__xnlock_put=C3=A2:

include/xenomai/cobalt/kernel/lock.h:216:29: error: =C3=A2ipipe_smp_p=C3=A2
undeclared (first use in this function)

#define __locking_active__  ipipe_smp_p

                             ^

include/xenomai/cobalt/kernel/lock.h:260:6: note: in expansion of macro
=C3=A2__locking_active__=C3=A2

  if (__locking_active__)

      ^

make[1]: *** [arch/arm/xenomai/mayday.o] Error 1

make: *** [arch/arm/xenomai] Error 2



Please let me know how to compile for *Linux kernel 3.10.18  +
ipipe-core-3.10.18-arm-1.patch + **xenomai**-3-3.0-rc2.**tar.bz2*

Regards.
