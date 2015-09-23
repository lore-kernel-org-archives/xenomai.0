MIME-Version: 1.0
In-Reply-To: <20150923065657.GH13976@hermes.click-hack.org>
References: <CAFkYNwZV3xY_QU5E+zdFNGeeM=O4jo897wppbGCg40HumoojBQ@mail.gmail.com>
 <5600F8DE.30705@xenomai.org>
 <CAFkYNwaW5+nnDmumwt_zFFn01oWY5CsS5Fbmj1wB0aPF7om-4w@mail.gmail.com>
 <20150922174455.GA13976@hermes.click-hack.org>
 <CAFkYNwa-XGD+JM-5w6EGepO8XG2Ki9Tt+ocqgcd_zNmPCngdyA@mail.gmail.com>
 <CAFkYNwazPQ1D98f5xEyAh0CgYfE1ddkxxK_paF4v7YN_hbkT5Q@mail.gmail.com>
 <20150923054319.GE13976@hermes.click-hack.org>
 <20150923055416.GF13976@hermes.click-hack.org>
 <CAFkYNwYJ8sm5LbKZZ1e-kKdSZr-L16NTVKOpKpmu2LoKnc9tOg@mail.gmail.com>
 <20150923065657.GH13976@hermes.click-hack.org>
Date: Wed, 23 Sep 2015 22:38:05 +1200
Message-ID: <CAFkYNwZ-m6JU4_JN7dQGMNj6id4HFkTXijd5mwU5Ujhn2o=9Ug@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 23 September 2015 at 18:56, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Wed, Sep 23, 2015 at 06:33:57PM +1200, vibnwis wrote:
> > On 23 September 2015 at 17:54, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> > > On Wed, Sep 23, 2015 at 07:43:19AM +0200, Gilles Chanteperdrix wrote:
> > > > On Wed, Sep 23, 2015 at 01:21:55PM +1200, vibnwis wrote:
> > > > > On 23 September 2015 at 12:41, vibnwis <vibnwis@gmail.com> wrote:
> > > > >
> > > > > >
> > > > > >
> > > > > > On 23 September 2015 at 05:44, Gilles Chanteperdrix <
> > > > > > gilles.chanteperdrix@xenomai.org> wrote:
> > > > > >
> > > > > >> On Wed, Sep 23, 2015 at 12:32:11AM +1200, vibnwis wrote:
> > > > > >> > By regenerating ./configure using autoreconf -fi, I managed to
> > > compile
> > > > > >> > xenomai-3-3.0-rc7 natively on PandaBoard. All things are put
> in
> > > their
> > > > > >> own
> > > > > >> > place by make install. However, when running latency, it
> produces
> > > > > >> >
> > > > > >> > > latency
> > > > > >> > 0"000.000| BUG in low_init(): [main] mlockall: Cannot allocate
> > > memory
> > > > > >>
> > > > > >> You should either run the latency test as root, or have a look
> at
> > > > > >> this page:
> > > > > >>
> > > > > >>
> > >
> http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-user/
> > > > > >
> > > > > >
> > > > > Referring to the link, I have the following outcomes.
> > > > > /dev/rtpipe <- not exist
> > > > >
> > > > > /sys/module/xenomai/parameters/allowed_group <- not exist as
> > > > well
> > >
> > > So, this is probably because you are not running a kernel with
> > > xenomai support.
> > >
> > Since there isn't any 3.18.20 patch, should I use 3.18.12. It is still
> > 3.8.x. Should be alright ? I will give it a go.
>
> Please see my answer to your previous mail. You can use the patch
> for 3.18.20 with xenomai 3.0-rc7. I will revert back to 3.18.12.
>

Tried it, but failed. See below.

./scripts/prepare-kernel.sh --arch=arm --linux=../linux-3.18.20
--ipipe=./kernel/cobalt/arch/arm/patches/ipipe-core-3.18.12-arm-4.patch

 Hunk #1 succeeded at 1804 (offset -3 lines).
Hunk #2 succeeded at 1864 (offset -3 lines).
Hunk #3 succeeded at 1934 (offset -3 lines).
checking file kernel/sched/core.c
Hunk #15 FAILED at 3650.
Hunk #16 succeeded at 4773 (offset 4 lines).
Hunk #17 succeeded at 8298 (offset 4 lines).
1 out of 17 hunks FAILED
checking file kernel/sched/wait.c
checking file kernel/signal.c
checking file kernel/time/clockevents.c
checking file kernel/time/clocksource.c
checking file kernel/time/tick-common.c
checking file kernel/time/tick-sched.c
checking file kernel/time/timekeeping.c
checking file kernel/time/timer.c
checking file kernel/timer.c
checking file kernel/trace/Kconfig
checking file kernel/trace/ftrace.c
checking file kernel/trace/ring_buffer.c
Hunk #1 FAILED at 2684.
Hunk #2 FAILED at 2697.
2 out of 2 hunks FAILED
checking file kernel/trace/trace.c
checking file kernel/trace/trace_clock.c
checking file kernel/trace/trace_functions.c
checking file kernel/trace/trace_functions_graph.c
checking file lib/Kconfig.debug
checking file lib/atomic64.c
checking file lib/bust_spinlocks.c
checking file lib/ioremap.c
checking file lib/smp_processor_id.c
checking file mm/Kconfig
checking file mm/memory.c
checking file mm/mlock.c
checking file mm/mmap.c
checking file mm/mmu_context.c
checking file mm/mprotect.c
checking file mm/vmalloc.c
prepare-kernel.sh: Unable to patch kernel 3.18.20 with
ipipe-core-3.18.12-arm-4.patch.

>
> --
>                                             Gilles.
> https://click-hack.org
>
