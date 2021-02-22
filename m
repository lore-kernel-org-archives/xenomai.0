Date: Sun, 21 Feb 2021 21:25:18 -0300
From: Gabriel Dinse <gabriel_dinse@hotmail.com>
Subject: Incompatible pointer type error when compiling kernel
Message-ID: <SN6PR08MB566103B99883095420349D3393819@SN6PR08MB5661.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,
I'm currently compiling linux 5.4.93 patched with xenomai 3.1,
using ipipe 5.4.93 for arm. The system is intended to run on a raspberry
pi 3 b, but I'm getting the following errors related to incompatible
pointer type:

  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      kernel/fork.o
  CC      kernel/xenomai/intr.o
In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
                 from include/xenomai/cobalt/kernel/sched.h:24,
                 from kernel/xenomai/intr.c:24:
kernel/xenomai/intr.c: In function =91inc_irqstats=92:
include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1=20
of =91atomic_long_xchg=92 from incompatible pointer type=20
[-Werror=3Dincompatible-pointer-types]
  __prev =3D (xnstat_exectime_t=20
*)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
                                                 ^
include/xenomai/cobalt/kernel/stat.h:147:2: note: in expansion of macro=20
=91xnstat_exectime_set_current=92
  xnstat_exectime_set_current(sched, new_account); \
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/xenomai/intr.c:123:2: note: in expansion of macro=20
=91xnstat_exectime_lazy_switch=92
  xnstat_exectime_lazy_switch(sched, &statp->account, start);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/atomic.h:76:0,
                 from ./include/asm-generic/bitops/lock.h:5,
                 from ./arch/arm/include/asm/bitops.h:243,
                 from ./include/linux/bitops.h:26,
                 from ./include/linux/kernel.h:12,
                 from ./include/asm-generic/bug.h:19,
                 from ./arch/arm/include/asm/bug.h:60,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:12,
                 from ./include/asm-generic/current.h:5,
                 from ./arch/arm/include/generated/asm/current.h:1,
                 from ./include/linux/mutex.h:14,
                 from kernel/xenomai/intr.c:21:
/include/asm-generic/atomic-long.h:880:1: note: expected=20
=91atomic_long_t * {aka struct <anonymous> *}=92 but argument is of=20
type =91xnstat_exectime_t ** {aka struct xnstat_exectime **}=92
 atomic_long_xchg(atomic_long_t *v, long i)
 ^~~~~~~~~~~~~~~~
In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
                 from include/xenomai/cobalt/kernel/sched.h:24,
                 from kernel/xenomai/intr.c:24:
kernel/xenomai/intr.c: In function =91switch_to_irqstats=92:
include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1=20
of =91atomic_long_xchg=92 from incompatible pointer type=20
[-Werror=3Dincompatible-pointer-types]
  __prev =3D (xnstat_exectime_t=20
*)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
                                                 ^
include/xenomai/cobalt/kernel/stat.h:139:2: note: in expansion of macro=20
=91xnstat_exectime_set_current=92
  xnstat_exectime_set_current(sched, new_account); \
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/xenomai/intr.c:132:2: note: in expansion of macro=20
=91xnstat_exectime_switch=92
  xnstat_exectime_switch(sched, &statp->account);
  ^~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/atomic.h:76:0,
                 from ./include/asm-generic/bitops/lock.h:5,
                 from ./arch/arm/include/asm/bitops.h:243,
                 from ./include/linux/bitops.h:26,
                 from ./include/linux/kernel.h:12,
                 from ./include/asm-generic/bug.h:19,
                 from ./arch/arm/include/asm/bug.h:60,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:12,
                 from ./include/asm-generic/current.h:5,
                 from ./arch/arm/include/generated/asm/current.h:1,
                 from ./include/linux/mutex.h:14,
                 from kernel/xenomai/intr.c:21:
/include/asm-generic/atomic-long.h:880:1: note: expected=20
=91atomic_long_t * {aka struct <anonymous> *}=92 but argument is of=20
type =91xnstat_exectime_t ** {aka struct xnstat_exectime **}=92
 atomic_long_xchg(atomic_long_t *v, long i)
 ^~~~~~~~~~~~~~~~
In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
                 from include/xenomai/cobalt/kernel/sched.h:24,
                 from kernel/xenomai/intr.c:24:
kernel/xenomai/intr.c: In function =91switch_from_irqstats=92:
include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1=20
of =91atomic_long_xchg=92 from incompatible pointer type=20
[-Werror=3Dincompatible-pointer-types]
  __prev =3D (xnstat_exectime_t=20
*)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
                                                 ^
include/xenomai/cobalt/kernel/stat.h:139:2: note: in expansion of macro=20
=91xnstat_exectime_set_current=92
  xnstat_exectime_set_current(sched, new_account); \
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/xenomai/intr.c:138:2: note: in expansion of macro=20
=91xnstat_exectime_switch=92
  xnstat_exectime_switch(sched, prev);
  ^~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/atomic.h:76:0,
                 from ./include/asm-generic/bitops/lock.h:5,
                 from ./arch/arm/include/asm/bitops.h:243,
                 from ./include/linux/bitops.h:26,
                 from ./include/linux/kernel.h:12,
                 from ./include/asm-generic/bug.h:19,
                 from ./arch/arm/include/asm/bug.h:60,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:12,
                 from ./include/asm-generic/current.h:5,
                 from ./arch/arm/include/generated/asm/current.h:1,
                 from ./include/linux/mutex.h:14,
                 from kernel/xenomai/intr.c:21:
/include/asm-generic/atomic-long.h:880:1: note: expected=20
=91atomic_long_t * {aka struct <anonymous> *}=92 but argument is of=20
type =91xnstat_exectime_t ** {aka struct xnstat_exectime **}=92
 atomic_long_xchg(atomic_long_t *v, long i)
 ^~~~~~~~~~~~~~~~
In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
                 from include/xenomai/cobalt/kernel/sched.h:24,
                 from kernel/xenomai/intr.c:24:
kernel/xenomai/intr.c: In function =91switch_core_irqstats=92:
include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1=20
of =91atomic_long_xchg=92 from incompatible pointer type=20
[-Werror=3Dincompatible-pointer-types]
  __prev =3D (xnstat_exectime_t=20
*)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
                                                 ^
include/xenomai/cobalt/kernel/stat.h:139:2: note: in expansion of macro=20
=91xnstat_exectime_set_current=92
  xnstat_exectime_set_current(sched, new_account); \
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/xenomai/intr.c:147:9: note: in expansion of macro=20
=91xnstat_exectime_switch=92
  prev =3D xnstat_exectime_switch(sched, &statp->account);
         ^~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/atomic.h:76:0,
                 from ./include/asm-generic/bitops/lock.h:5,
                 from ./arch/arm/include/asm/bitops.h:243,
                 from ./include/linux/bitops.h:26,
                 from ./include/linux/kernel.h:12,
                 from ./include/asm-generic/bug.h:19,
                 from ./arch/arm/include/asm/bug.h:60,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:12,
                 from ./include/asm-generic/current.h:5,
                 from ./arch/arm/include/generated/asm/current.h:1,
                 from ./include/linux/mutex.h:14,
                 from kernel/xenomai/intr.c:21:
/include/asm-generic/atomic-long.h:880:1: note: expected=20
=91atomic_long_t * {aka struct <anonymous> *}=92 but argument is of=20
type =91xnstat_exectime_t ** {aka struct xnstat_exectime **}=92
 atomic_long_xchg(atomic_long_t *v, long i)
 ^~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:262: kernel/xenomai/intr.o] Error 1
make[3]: *** [scripts/Makefile.build:496: kernel/xenomai] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [Makefile:1732: kernel] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [package/pkg-generic.mk:269:=20
/home/gabriel/Projects/buildroot/buildroot-2020.02.11-xenomai/output/build/=
linux-5462eb01503dd1ad69d9cbe9f0d51a0bd4b0f98d/.stamp_built]=20
Error 2
make: *** [Makefile:84: _all] Error 2


How can I solve this?
Thank you,
Gabriel Dinse

