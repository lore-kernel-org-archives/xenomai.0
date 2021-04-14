MIME-Version: 1.0
References: <20210414144235.6e9d83cd@windsurf.home>
In-Reply-To: <20210414144235.6e9d83cd@windsurf.home>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 14 Apr 2021 09:47:51 -0400
Message-ID: <CALLqZ8RM++Y0DO=H0BABOJTHoquyJBbD_LRupZX9THpgxpfAzw@mail.gmail.com>
Subject: Re: ipipe 5.4.107 / 5.4.93 build issues on arm32
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
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: xenomai@xenomai.org

On Wed, Apr 14, 2021 at 8:43 AM Thomas Petazzoni via Xenomai <
xenomai@xenomai.org> wrote:

> Hello,
>
> I just tested the following ipipe patches on arm32:
>
>
> https://xenomai.org/downloads/ipipe/v5.x/arm/ipipe-core-5.4.107-arm-1.pat=
ch
>
> https://xenomai.org/downloads/ipipe/v5.x/arm/ipipe-core-5.4.93-arm-0.patc=
h
>
> applied of course on the appropriate 5.4.x code base, configured with
> the sama5_defconfig kernel configuration, and in both cases the build
> fails with:
>
> In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
>                  from include/xenomai/cobalt/kernel/sched.h:24,
>                  from kernel/xenomai/intr.c:24:
> kernel/xenomai/intr.c: In function =E2=80=98inc_irqstats=E2=80=99:
> include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1 of
> =E2=80=98atomic_long_xchg=E2=80=99 from incompatible pointer type
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
> ./include/asm-generic/atomic-long.h:880:1: note: expected =E2=80=98atomic=
_long_t *
> {aka struct <anonymous> *}=E2=80=99 but argument is of type =E2=80=98xnst=
at_exectime_t **
> {aka struct xnstat_exectime **}=E2=80=99
>  atomic_long_xchg(atomic_long_t *v, long i)
>  ^~~~~~~~~~~~~~~~
> In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
>                  from include/xenomai/cobalt/kernel/sched.h:24,
>                  from kernel/xenomai/intr.c:24:
> kernel/xenomai/intr.c: In function =E2=80=98switch_to_irqstats=E2=80=99:
> include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1 of
> =E2=80=98atomic_long_xchg=E2=80=99 from incompatible pointer type
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
> ./include/asm-generic/atomic-long.h:880:1: note: expected =E2=80=98atomic=
_long_t *
> {aka struct <anonymous> *}=E2=80=99 but argument is of type =E2=80=98xnst=
at_exectime_t **
> {aka struct xnstat_exectime **}=E2=80=99
>  atomic_long_xchg(atomic_long_t *v, long i)
>  ^~~~~~~~~~~~~~~~
> In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
>                  from include/xenomai/cobalt/kernel/sched.h:24,
>                  from kernel/xenomai/intr.c:24:
> kernel/xenomai/intr.c: In function =E2=80=98switch_from_irqstats=E2=80=99=
:
> include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1 of
> =E2=80=98atomic_long_xchg=E2=80=99 from incompatible pointer type
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
> ./include/asm-generic/atomic-long.h:880:1: note: expected =E2=80=98atomic=
_long_t *
> {aka struct <anonymous> *}=E2=80=99 but argument is of type =E2=80=98xnst=
at_exectime_t **
> {aka struct xnstat_exectime **}=E2=80=99
>  atomic_long_xchg(atomic_long_t *v, long i)
>  ^~~~~~~~~~~~~~~~
> In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
>                  from include/xenomai/cobalt/kernel/sched.h:24,
>                  from kernel/xenomai/intr.c:24:
> kernel/xenomai/intr.c: In function =E2=80=98switch_core_irqstats=E2=80=99=
:
> include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1 of
> =E2=80=98atomic_long_xchg=E2=80=99 from incompatible pointer type
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
> ./include/asm-generic/atomic-long.h:880:1: note: expected =E2=80=98atomic=
_long_t *
> {aka struct <anonymous> *}=E2=80=99 but argument is of type =E2=80=98xnst=
at_exectime_t **
> {aka struct xnstat_exectime **}=E2=80=99
>  atomic_long_xchg(atomic_long_t *v, long i)
>  ^~~~~~~~~~~~~~~~
>   CC      kernel/xenomai/registry.o
> cc1: some warnings being treated as errors
> scripts/Makefile.build:261: recipe for target 'kernel/xenomai/intr.o'
> failed
> make[2]: *** [kernel/xenomai/intr.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
>   CC      fs/iomap/apply.o
>   CC      crypto/kpp.o
>   CC      fs/fat/inode.o
>   CC      fs/iomap/buffered-io.o
> scripts/Makefile.build:496: recipe for target 'kernel/xenomai' failed
> make[1]: *** [kernel/xenomai] Error 2
> Makefile:1732: recipe for target 'kernel' failed
>
> Is this a known issue ?
>
> Best regards,
>
> Thomas Petazzoni
> --
> Thomas Petazzoni, co-owner and CEO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

Hi,
  I haven=E2=80=99t tested that defconfig, I can look into the above issue.
There is a known issue with 5.4 at the moment where we see large latencies,
it looks like an upstream changed is the cause of the issue. I should have
a week by the weekend.

Thanks

Greg

>
>
