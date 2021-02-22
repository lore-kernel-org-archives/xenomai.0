MIME-Version: 1.0
References: <SN6PR08MB566103B99883095420349D3393819@SN6PR08MB5661.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB566103B99883095420349D3393819@SN6PR08MB5661.namprd08.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sun, 21 Feb 2021 22:26:34 -0500
Message-ID: <CALLqZ8RM+vcpWHeZtvvfDxsa1WbOg0s_=4eGQufkPNExbHCwiw@mail.gmail.com>
Subject: Re: Incompatible pointer type error when compiling kernel
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gabriel Dinse <gabriel_dinse@hotmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Feb 21, 2021 at 7:25 PM Gabriel Dinse via Xenomai <
xenomai@xenomai.org> wrote:

> Hello,
> I'm currently compiling linux 5.4.93 patched with xenomai 3.1,
> using ipipe 5.4.93 for arm. The system is intended to run on a raspberry
> pi 3 b, but I'm getting the following errors related to incompatible
> pointer type:
>
This is a 32-bit build running on the rpi3?

>
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      kernel/fork.o
>   CC      kernel/xenomai/intr.o
> In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
>                  from include/xenomai/cobalt/kernel/sched.h:24,
>                  from kernel/xenomai/intr.c:24:
> kernel/xenomai/intr.c: In function =E2=80=98inc_irqstats=E2=80=99:
> include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1
> of =E2=80=98atomic_long_xchg=E2=80=99 from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types]
>   __prev =3D (xnstat_exectime_t
> *)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
>                                                  ^
> include/xenomai/cobalt/kernel/stat.h:147:2: note: in expansion of macro
> =E2=80=98xnstat_exectime_set_current=E2=80=99
>   xnstat_exectime_set_current(sched, new_account); \
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/xenomai/intr.c:123:2: note: in expansion of macro
> =E2=80=98xnstat_exectime_lazy_switch=E2=80=99
>   xnstat_exectime_lazy_switch(sched, &statp->account, start);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/atomic.h:76:0,
>                  from ./include/asm-generic/bitops/lock.h:5,
>                  from ./arch/arm/include/asm/bitops.h:243,
>                  from ./include/linux/bitops.h:26,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/asm-generic/bug.h:19,
>                  from ./arch/arm/include/asm/bug.h:60,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/thread_info.h:12,
>                  from ./include/asm-generic/current.h:5,
>                  from ./arch/arm/include/generated/asm/current.h:1,
>                  from ./include/linux/mutex.h:14,
>                  from kernel/xenomai/intr.c:21:
> /include/asm-generic/atomic-long.h:880:1: note: expected
> =E2=80=98atomic_long_t * {aka struct <anonymous> *}=E2=80=99 but argument=
 is of
> type =E2=80=98xnstat_exectime_t ** {aka struct xnstat_exectime **}=E2=80=
=99
>  atomic_long_xchg(atomic_long_t *v, long i)
>  ^~~~~~~~~~~~~~~~
> In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
>                  from include/xenomai/cobalt/kernel/sched.h:24,
>                  from kernel/xenomai/intr.c:24:
> kernel/xenomai/intr.c: In function =E2=80=98switch_to_irqstats=E2=80=99:
> include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1
> of =E2=80=98atomic_long_xchg=E2=80=99 from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types]
>   __prev =3D (xnstat_exectime_t
> *)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
>                                                  ^
> include/xenomai/cobalt/kernel/stat.h:139:2: note: in expansion of macro
> =E2=80=98xnstat_exectime_set_current=E2=80=99
>   xnstat_exectime_set_current(sched, new_account); \
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/xenomai/intr.c:132:2: note: in expansion of macro
> =E2=80=98xnstat_exectime_switch=E2=80=99
>   xnstat_exectime_switch(sched, &statp->account);
>   ^~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/atomic.h:76:0,
>                  from ./include/asm-generic/bitops/lock.h:5,
>                  from ./arch/arm/include/asm/bitops.h:243,
>                  from ./include/linux/bitops.h:26,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/asm-generic/bug.h:19,
>                  from ./arch/arm/include/asm/bug.h:60,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/thread_info.h:12,
>                  from ./include/asm-generic/current.h:5,
>                  from ./arch/arm/include/generated/asm/current.h:1,
>                  from ./include/linux/mutex.h:14,
>                  from kernel/xenomai/intr.c:21:
> /include/asm-generic/atomic-long.h:880:1: note: expected
> =E2=80=98atomic_long_t * {aka struct <anonymous> *}=E2=80=99 but argument=
 is of
> type =E2=80=98xnstat_exectime_t ** {aka struct xnstat_exectime **}=E2=80=
=99
>  atomic_long_xchg(atomic_long_t *v, long i)
>  ^~~~~~~~~~~~~~~~
> In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
>                  from include/xenomai/cobalt/kernel/sched.h:24,
>                  from kernel/xenomai/intr.c:24:
> kernel/xenomai/intr.c: In function =E2=80=98switch_from_irqstats=E2=80=99=
:
> include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1
> of =E2=80=98atomic_long_xchg=E2=80=99 from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types]
>   __prev =3D (xnstat_exectime_t
> *)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
>                                                  ^
> include/xenomai/cobalt/kernel/stat.h:139:2: note: in expansion of macro
> =E2=80=98xnstat_exectime_set_current=E2=80=99
>   xnstat_exectime_set_current(sched, new_account); \
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/xenomai/intr.c:138:2: note: in expansion of macro
> =E2=80=98xnstat_exectime_switch=E2=80=99
>   xnstat_exectime_switch(sched, prev);
>   ^~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/atomic.h:76:0,
>                  from ./include/asm-generic/bitops/lock.h:5,
>                  from ./arch/arm/include/asm/bitops.h:243,
>                  from ./include/linux/bitops.h:26,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/asm-generic/bug.h:19,
>                  from ./arch/arm/include/asm/bug.h:60,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/thread_info.h:12,
>                  from ./include/asm-generic/current.h:5,
>                  from ./arch/arm/include/generated/asm/current.h:1,
>                  from ./include/linux/mutex.h:14,
>                  from kernel/xenomai/intr.c:21:
> /include/asm-generic/atomic-long.h:880:1: note: expected
> =E2=80=98atomic_long_t * {aka struct <anonymous> *}=E2=80=99 but argument=
 is of
> type =E2=80=98xnstat_exectime_t ** {aka struct xnstat_exectime **}=E2=80=
=99
>  atomic_long_xchg(atomic_long_t *v, long i)
>  ^~~~~~~~~~~~~~~~
> In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
>                  from include/xenomai/cobalt/kernel/sched.h:24,
>                  from kernel/xenomai/intr.c:24:
> kernel/xenomai/intr.c: In function =E2=80=98switch_core_irqstats=E2=80=99=
:
> include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1
> of =E2=80=98atomic_long_xchg=E2=80=99 from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types]
>   __prev =3D (xnstat_exectime_t
> *)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
>                                                  ^
> include/xenomai/cobalt/kernel/stat.h:139:2: note: in expansion of macro
> =E2=80=98xnstat_exectime_set_current=E2=80=99
>   xnstat_exectime_set_current(sched, new_account); \
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/xenomai/intr.c:147:9: note: in expansion of macro
> =E2=80=98xnstat_exectime_switch=E2=80=99
>   prev =3D xnstat_exectime_switch(sched, &statp->account);
>          ^~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/atomic.h:76:0,
>                  from ./include/asm-generic/bitops/lock.h:5,
>                  from ./arch/arm/include/asm/bitops.h:243,
>                  from ./include/linux/bitops.h:26,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/asm-generic/bug.h:19,
>                  from ./arch/arm/include/asm/bug.h:60,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/thread_info.h:12,
>                  from ./include/asm-generic/current.h:5,
>                  from ./arch/arm/include/generated/asm/current.h:1,
>                  from ./include/linux/mutex.h:14,
>                  from kernel/xenomai/intr.c:21:
> /include/asm-generic/atomic-long.h:880:1: note: expected
> =E2=80=98atomic_long_t * {aka struct <anonymous> *}=E2=80=99 but argument=
 is of
> type =E2=80=98xnstat_exectime_t ** {aka struct xnstat_exectime **}=E2=80=
=99
>  atomic_long_xchg(atomic_long_t *v, long i)
>  ^~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:262: kernel/xenomai/intr.o] Error 1
> make[3]: *** [scripts/Makefile.build:496: kernel/xenomai] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [Makefile:1732: kernel] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [package/pkg-generic.mk:269:
> /home/gabriel/Projects/buildroot/buildroot-2020.02.11-xenomai/output/buil=
d/linux-5462eb01503dd1ad69d9cbe9f0d51a0bd4b0f98d/.stamp_built]
>
> Error 2
> make: *** [Makefile:84: _all] Error 2
>

I have some ipipe fixes coming, but I don't think these are ipipe related.
Can you show how you patched and built your kernel? I'll try to reproduce
on my end.  What compiler are you using?

-Greg


>
> How can I solve this?
> Thank you,
> Gabriel Dinse
>
>
