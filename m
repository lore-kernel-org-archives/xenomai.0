From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45617342.8020504@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E8D7@domain.hid>
	<1163784779.4980.47.camel@domain.hid>  <455E025B.5030906@domain.hid>
	<1163790315.4980.73.camel@domain.hid>  <455E0940.7070705@domain.hid>
	<1163800682.4980.81.camel@domain.hid>  <45617342.8020504@domain.hid>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 10:38:12 +0100
Message-Id: <1164015493.5006.44.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: XENO_OPT_DEBUG impact
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

On Mon, 2006-11-20 at 10:20 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2006-11-17 at 20:10 +0100, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Fri, 2006-11-17 at 19:41 +0100, Jan Kiszka wrote:
> >>>> I'm currently seeing two potential "misuses" of the common switch:
> >>>>
> >>>>  - the posix skin (Gilles, how heavy-weighted are those checks?)
> >>>>    => CONFIG_XENO_OPT_DEBUG_POSIX
> >>>>
> >>>>  - CONFIG_XENO_SPINLOCK_DEBUG => CONFIG_XENO_OPT_DEBUG_SPINLOCK
> >>>>
> >>>> Both should be explicitly controllable in Kconfig.
> >>>>
> >>> Nack for CONFIG_XENO_OPT_DEBUG_SPINLOCK. Most of the issue we tracked
> >>> with Gilles regarding the domain migration code had side-effects on the
> >>> nucleus lock. So having CONFIG_XENO_OPT_DEBUG enabled for identifying
> >>> internal state weirdnesses - like those triggered by migration bugs -
> >>> implies enabling the spinlock watchdogs too.
> >> Ok, if it only makes sense to have both enabled at the same time, then
> >> let us create XENO_OPT_DEBUG_NUCLEUS. It should include both, but it
> >> shall not be automatically on when, say, only XENO_OPT_DEBUG_RTDM is
> >> required.
> > 
> > No objection.
> > 
> 
> Looking at the spinlock debugging code: it serves two inseparable
> purposes, a watchdog for stuck locks + lock statistics. The latter make
> this feature pop up when XENO_OPT_STATS are set on a SMP box - rather
> surprising effect. Do we still need the stats? If not, I would kick them
> out in favour of using the latency tracer for such analysis, making
> spinlock debugging a real pure debug feature.
> 

The spinlock stats are about uncovering a problem, the latency tracer is
about finding where the problem lies. Both are orthogonal.

> Jan
> 
-- 
Philippe.



