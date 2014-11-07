Date: Fri, 7 Nov 2014 10:37:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141107093739.GC6724@sisyphus.hd.free.fr>
References: <545B9297.2090003@cgglobal.com>
 <20141106153738.GC30908@sisyphus.hd.free.fr>
 <545B994D.1080008@cgglobal.com>
 <20141106155503.GD30908@sisyphus.hd.free.fr>
 <545BA5D0.7010907@cgglobal.com> <545BD88B.3030700@xenomai.org>
 <545C9001.7070508@cgglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545C9001.7070508@cgglobal.com>
Subject: Re: [Xenomai] rt_task_sleep_until() miss release point?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ZIV-Alberto Ozalla Cantabrana <alberto.ozalla@cgglobal.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Nov 07, 2014 at 09:25:21AM +0000, ZIV-Alberto Ozalla Cantabrana wrote:
> 
> On 06/11/14 21:22, Philippe Gerum wrote:
> > On 11/06/2014 05:46 PM, ZIV-Alberto Ozalla Cantabrana wrote:
> >> Hi,
> >>
> >> These are the simplest examples:
> >> There are no MSW for Test_Task.
> >> The goal is to increment counter_ms each millisecond.
> >>
> >> Given that:
> >> 1000000 nanoseconds = 24000 tsc.
> >> 1 tsc = 41 ns
> >>
> > Is rt_timer_ns2tsc(1000000) actually returning 24000 on your platform?
> > Yes.
> >> void Test_Task(void *arg)
> >> {
> >>     rt_task_set_mode(0, 0, NULL);
> > This is useless and not recommended. A newly created task always starts
> > in primary mode.
> >
> > Ok. I will delete it.
> >>      while (1) {
> >>
> >>              unsigned long long before = counter_ms;
> >>              usleep(1000000);    // 1 second.
> > Although this would rather cause higher count values, this non-rt main
> > using a non-rt sleep service won't give you an accurate delay for the
> > measurement.
> >
> > It is only an example.

The problem is that so far, you have not been able to provide a
correct example which provides a proof of what you are saying. It
does not mean that what you say is wrong, just that we have reasons
to doubt it.

Anyway, I do not think you can assume that
rt_timer_tsc2ns(rt_timer_tsc()) is the same thing as
rt_timer_read(), I would say the first is equivalent to POSIX
CLOCK_MONOTONIC whereas the second is equivalent to CLOCK_REALTIME,
so, there is an offset between the two.

What rt_task_sleep_until expects, is what rt_timer_read() returns

To check that, right after the call to rt_task_sleep_until, call
rt_timer_read (and not rt_timer_tsc), and see if it is near t2. You
can use rt_printf in a real-time task to avoid switches to secondary
mode.

Also, are you running the native skin timer in periodic or aperiodic
mode?

-- 
					    Gilles.

