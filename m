From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <459A64A9.4060707@domain.hid>
References: <459A31E3.40807@domain.hid> <1167744149.30347.2.camel@domain.hid>
	<459A5E92.6030504@domain.hid> <1167745769.30347.6.camel@domain.hid>
	<459A64A9.4060707@domain.hid>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 15:13:43 +0100
Message-Id: <1167747223.30347.10.camel@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Tue, 2007-01-02 at 14:56 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Tue, 2007-01-02 at 14:30 +0100, Gilles Chanteperdrix wrote:
> > 
> >>Philippe Gerum wrote:
> >>
> >>>On Tue, 2007-01-02 at 11:20 +0100, Jan Kiszka wrote:
> >>>
> >>>
> >>>>Hi all - and happy new year,
> >>>>
> >>>>I haven't looked at all the new code yet, only the commit messages. I
> >>>>found something similar to my fast-forward-on-timer-overrun patch in
> >>>>#2010 and wondered if Gilles' original concerns on side effects for the
> >>>>POSIX skin were addressed [1]. I recalled that my own final summary on
> >>>>this was "leave it as it is" [2].
> >>>>
> >>>
> >>>
> >>>The best approach is to update the POSIX skin so that it does not rely
> >>>on the timer code to act in a sub-optimal way; that's why this patch
> >>>found its way in. Scheduling and processing timer shots uselessly is a
> >>>bug, not a feature in this case.
> >>
> >>There is some work to be done on the posix skin anyway, this will all be
> >>at once. By the way, I tested the trunk on ARM, and I still get a lockup
> >>when the latency period is too low. I wonder if we should not compare to
> >>"now + nkschedlat", or even use xnarch_get_cpu_tsc() instead of "now".
> > 
> > 
> > You mean as below, in order to account for the time spent in the handler(s)?	
> > 
> > -	while ((xntimerh_date(&timer->aplink) += timer->interval) < now)
> > +	while ((xntimerh_date(&timer->aplink) += timer->interval) < xnarch_get_cpu_tsc())
> > 		    ;
> > 
> 
> I mean even:
> 
> 	while ((xntimerh_date(&timer->aplink) += timer->interval) <
> 		xnarch_get_cpu_tsc() + nkschedlat)
>                  ;
> 
> Because if the timer date is between now and now + nkschedlat, its
> handler will be called again.
> 

Ack.

-- 
Philippe.



