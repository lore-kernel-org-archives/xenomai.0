MIME-Version: 1.0
In-Reply-To: <b16ed60f-31f2-3ef0-f7bc-a35de9629b51@xenomai.org>
References: <CADXNiGUL514kD3+aHJRRcru8E8Lz3XUd3mDF=ng4xTm4QnoKFA@mail.gmail.com>
 <b16ed60f-31f2-3ef0-f7bc-a35de9629b51@xenomai.org>
From: Jackson Jones <jackson.jones@gmail.com>
Date: Mon, 23 Jul 2018 12:44:45 -0700
Message-ID: <CADXNiGVPKAfTiqDC9isaeYOcm-orTMNdqc06cRpzx4an8SRKGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Cobalt Scheduling tasks on a single core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

We were using processor affinity and assigning the RT tasks to different
cores. The issue we ran into is that the application would lock up (causing
the whole system to freeze) after several hours of being idle
(approximately 8 hours). When we did not use processor affinity, our app
would not lock up (but then all RT task are on one core).

One thing I noticed is that currently we are designating all the CPUs to be
real time (passing xenomai.supported_cpus=0x0000000f). Could this be the
cause of the lockup? Should we leave one cpu out (of the real time group)?

We also discovered over this past weekend that if we enable these options
in the Linux kernel, our app does not lock up:

CONFIG_LOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0

These options are not something we want to ship with, but it is interesting
that they seem to prevent the lockup.




On Sat, Jul 21, 2018 at 1:47 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 07/21/2018 01:28 AM, Jackson Jones wrote:
> > We are running against xenomai 3.0.7 on a quad core arm (i.mx6).  Xenomai
> > was configured with these arguments:
> >
> > #export CFLAGS=-O2 LIBS=-lposix
> > ./configure \
> >     --with-core=cobalt \
> >     --enable-smp \
> >     --enable-registry \
> >     --enable-pshared \
> >     --enable-dlopen-libs \
> >     --enable-sanity \
> >     --disable-tls \
> >     --enable-valgrind-client \
> >     --disable-assert
> >
> > The main app spawns off several real time tasks. Cobalt is scheduling all
> > the real-time tasks on one core. Is this normal behavior for Cobalt? I
> > would expect it to take advantage of the multiple cores.
>
> Your application has to decide for this, CPU migration is costly in many
> ways, increases latency. For this reason, no Xenomai co-kernel ever has
> implemented any load balancing of any sort. On the contrary, it does pin
> each emerging thread to its current CPU precisely to prevent unexpected
> migration while the threads runs in secondary mode, before entering the
> rt processing loop - this CPU may of course be changed by the
> application afterwards.
>
> What you are seeing here is the default assignment of threads to CPUs:
> the regular kernel picked a base CPU for each newly created thread, then
> Cobalt pinned it there.
>
> The idea is to figure out the best placement of the rt threads among the
> CPUs available for rt processing, moving them accordingly using
> sched_setaffinity() during the init phase. This placement could be
> paired with setting xenomai.supported_cpus for restricting the CPUs
> dedicated to real-time duties to a subset of the available cores.
>
> --
> Philippe.
>
