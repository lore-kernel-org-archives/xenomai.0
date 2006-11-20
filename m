From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <456193E2.8030605@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E8D7@domain.hid>
	<1163784779.4980.47.camel@domain.hid>  <455E025B.5030906@domain.hid>
	<1163790315.4980.73.camel@domain.hid>  <455E0940.7070705@domain.hid>
	<1163800682.4980.81.camel@domain.hid>  <45617342.8020504@domain.hid>
	<1164015493.5006.44.camel@domain.hid>  <45617CED.1030605@domain.hid>
	<1164019575.5006.51.camel@domain.hid>  <456193E2.8030605@domain.hid>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 14:22:57 +0100
Message-Id: <1164028977.5006.92.camel@domain.hid>
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

On Mon, 2006-11-20 at 12:39 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Mon, 2006-11-20 at 11:01 +0100, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Mon, 2006-11-20 at 10:20 +0100, Jan Kiszka wrote:
> >>>> Philippe Gerum wrote:
> >>>>> On Fri, 2006-11-17 at 20:10 +0100, Jan Kiszka wrote:
> >>>>>> Philippe Gerum wrote:
> >>>>>>> On Fri, 2006-11-17 at 19:41 +0100, Jan Kiszka wrote:
> >>>>>>>> I'm currently seeing two potential "misuses" of the common switch:
> >>>>>>>>
> >>>>>>>>  - the posix skin (Gilles, how heavy-weighted are those checks?)
> >>>>>>>>    => CONFIG_XENO_OPT_DEBUG_POSIX
> >>>>>>>>
> >>>>>>>>  - CONFIG_XENO_SPINLOCK_DEBUG => CONFIG_XENO_OPT_DEBUG_SPINLOCK
> >>>>>>>>
> >>>>>>>> Both should be explicitly controllable in Kconfig.
> >>>>>>>>
> >>>>>>> Nack for CONFIG_XENO_OPT_DEBUG_SPINLOCK. Most of the issue we tracked
> >>>>>>> with Gilles regarding the domain migration code had side-effects on the
> >>>>>>> nucleus lock. So having CONFIG_XENO_OPT_DEBUG enabled for identifying
> >>>>>>> internal state weirdnesses - like those triggered by migration bugs -
> >>>>>>> implies enabling the spinlock watchdogs too.
> >>>>>> Ok, if it only makes sense to have both enabled at the same time, then
> >>>>>> let us create XENO_OPT_DEBUG_NUCLEUS. It should include both, but it
> >>>>>> shall not be automatically on when, say, only XENO_OPT_DEBUG_RTDM is
> >>>>>> required.
> >>>>> No objection.
> >>>>>
> >>>> Looking at the spinlock debugging code: it serves two inseparable
> >>>> purposes, a watchdog for stuck locks + lock statistics. The latter make
> >>>> this feature pop up when XENO_OPT_STATS are set on a SMP box - rather
> >>>> surprising effect. Do we still need the stats? If not, I would kick them
> >>>> out in favour of using the latency tracer for such analysis, making
> >>>> spinlock debugging a real pure debug feature.
> >>>>
> >>> The spinlock stats are about uncovering a problem, the latency tracer is
> >>> about finding where the problem lies. Both are orthogonal.
> >> Not fully true: the tracer provides the same information when you enable
> >> CONFIG_IPIPE_TRACE_IRQSOFF. When you disable CONFIG_IPIPE_TRACE_MCOUNT,
> >> you even get this at comparable (if not lower) costs. I once played with
> >> the spinlock debug code before decided to invest time into the tracer. I
> >> think I even posted a patch to enable that code on UP. But I didn't find
> >> the spinlock stats useful enough, even for the scenario "lock length
> >> analysis".
> >>
> >> We basically have now two ways to get the same information (or please
> >> explain what is missing with the tracer). Besides the redundancy, there
> >> is the problem that one of this way comes in via two different,
> >> orthogonal paths (STATS+SMP || DEBUG). That's not very consistent IMHO.
> >>
> > 
> > Nothing is missing in the tracer. The point is that you don't
> > immediately know that you are having a spinlock issue which would make
> > you build the tracer support, and having those stats is a cheap way to
> > detect such problem in a lightweight manner. 
> 
> If it were cheap, we wouldn't discuss it here. Actually, due to its
> inline nature, this instrumentation is fairly costly. That's ok, as long
> as you can explicitly ask for such a feature.
> 

You are talking about different issues here:
#1 - having SMP+STAT enabling the SPINLOCK_DEBUG is suboptimal
#2 - because you don't like #1, we should kill it entirely, and only
rely on the tracer to provide spinlock latency tracing.

I agree on your conclusion regarding #1. I need to be sure that #2 is
not going to kill us too, during SMP debugging sessions.

Fixing #1 is a matter of decoupling config options, but does not require
#2. Going for #2 requires to make sure that we are not going to add some
temporal perturbations caused by the tracer. (Btw, it would be quite
easy to reduce the impact of SPINLOCK_DEBUG on the I-cache, by moving
the stamping code out of line, so this is not a bad code "by design",
it's just a suboptimal implementation).

> But now we have the situation that the (default y!) XENO_OPT_STAT
> feature on UP is far more costly than on SMP.

You mean the opposite, I guess.

>  You know that the stats
> are very useful already without any spinlock instrumentation, i.e. for
> analysing the RT-system load. My feeling is that, for SMP, we currently
> have a huge config mess here. And this is what I'm trying to address,
> /maybe/ also by removing redundant instrumentation means.
> 

I would not call a mess something you don't happen to like; it may still
serve legitimate purposes. It's just a feature after all, which has
proven to be quite useful to the people debugging SMP issues. It's not
redundant in my mind, for the reasons already given. This does not
preclude the opportunity to improve the config situation, though.

> > Running with the tracer
> > enabled usually means that you are chasing an issue you have already
> > detected.
> 
> Again, tracer != mcount. It can be used just like that spinlock stats:
> to *detect* long locking periods. Have a look.
> 

Relax, I had a look already a fair number of times, and I agree with you
that the tracer provides a very useful set of latency tracing data, but
the point is that I'm worried about the perturbations the tracer adds,
which are real, mcount or not, and I don't want to chase the wild goose
when tracking SMP latency issues.

On the other hand, only idiots never change mind, so let's move on the
smart way: please submit your ideal fix for that issue. Since Gilles and
I are usually the ones who bang their heads on SMP issues, we will
experiment with the tracer as a SMP latency tracking tool for Xenomai.
If we actually save some debug time using the tracer, or at least don't
lose any, then I will merge this patch.

> Jan
> 
-- 
Philippe.



