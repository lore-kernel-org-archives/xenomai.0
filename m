From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <459A6A88.8000803@domain.hid>
References: <459A31E3.40807@domain.hid> <1167744149.30347.2.camel@domain.hid>
	<459A5E92.6030504@domain.hid> <1167745769.30347.6.camel@domain.hid>
	<459A64A9.4060707@domain.hid> <1167747223.30347.10.camel@domain.hid>
	<459A6A88.8000803@domain.hid>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 15:53:08 +0100
Message-Id: <1167749589.30347.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: SVN checkin #2010
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2007-01-02 at 15:22 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2007-01-02 at 14:56 +0100, Gilles Chanteperdrix wrote:
> >> Philippe Gerum wrote:
> >>> On Tue, 2007-01-02 at 14:30 +0100, Gilles Chanteperdrix wrote:
> >>>
> >>>> Philippe Gerum wrote:
> >>>>
> >>>>> On Tue, 2007-01-02 at 11:20 +0100, Jan Kiszka wrote:
> >>>>>
> >>>>>
> >>>>>> Hi all - and happy new year,
> >>>>>>
> >>>>>> I haven't looked at all the new code yet, only the commit messages. I
> >>>>>> found something similar to my fast-forward-on-timer-overrun patch in
> >>>>>> #2010 and wondered if Gilles' original concerns on side effects for the
> >>>>>> POSIX skin were addressed [1]. I recalled that my own final summary on
> >>>>>> this was "leave it as it is" [2].
> >>>>>>
> >>>>>
> >>>>> The best approach is to update the POSIX skin so that it does not rely
> >>>>> on the timer code to act in a sub-optimal way; that's why this patch
> >>>>> found its way in. Scheduling and processing timer shots uselessly is a
> >>>>> bug, not a feature in this case.
> >>>> There is some work to be done on the posix skin anyway, this will all be
> >>>> at once. By the way, I tested the trunk on ARM, and I still get a lockup
> >>>> when the latency period is too low. I wonder if we should not compare to
> >>>> "now + nkschedlat", or even use xnarch_get_cpu_tsc() instead of "now".
> >>>
> >>> You mean as below, in order to account for the time spent in the handler(s)?	
> >>>
> >>> -	while ((xntimerh_date(&timer->aplink) += timer->interval) < now)
> >>> +	while ((xntimerh_date(&timer->aplink) += timer->interval) < xnarch_get_cpu_tsc())
> >>> 		    ;
> >>>
> >> I mean even:
> >>
> >> 	while ((xntimerh_date(&timer->aplink) += timer->interval) <
> >> 		xnarch_get_cpu_tsc() + nkschedlat)
> >>                  ;
> >>
> >> Because if the timer date is between now and now + nkschedlat, its
> >> handler will be called again.
> >>
> > 
> > Ack.
> > 
> 
> Keep in mind that this code is now a performance regression for the
> non-overflow case, specifically when xnarch_get_cpu_tsc() costs more
> than just a simple CPU register access.
> 
> My previous "leave it as it is" was also due to the consideration that
> we shouldn't pay too much in hotpaths for things that go wrong on
> misdesigned systems.

Sure, but on the other hand, it's precisely when things tend to go wrong
that one may expect the system to be resilient to sporadic issues; IOW,
people who do provide for some contingency plan in their code upon
missed deadlines should be able to rely on the timer infrastructure not
to worsen the situation.

To address your concern, nothing prevents us from providing an
arch-specific wrapper like:

#ifdef reading_tsc_is_cheap
#define xnarch_refresh_from_tsc(oldtsc)  xnarch_get_cpu_tsc()
#else
#define xnarch_refresh_from_tsc(oldtsc)  (oldtsc)
#endif

Not that I would be particularly fond of that, mm, thing, but this would
allow to fix the bogus x86+8254 setup relic, which is likely the only
one which would cause any significant delay among the supported
archs/platforms.

> 
> Jan
> 
-- 
Philippe.



