From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46652976.4050309@domain.hid>
References: <465ABD99.1090301@domain.hid> <1180630376.5020.131.camel@domain.hid>
	<465F3277.1080400@domain.hid> <1180651652.5020.197.camel@domain.hid>
	<465FC2FC.1010902@domain.hid> <1181032041.32137.68.camel@domain.hid>
	<46652976.4050309@domain.hid>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 11:44:02 +0200
Message-Id: <1181036642.32137.79.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [ANNOUNCE] Xenomai and	I-pipe	patch	series,
	LTTng bits
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

On Tue, 2007-06-05 at 11:14 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> ...
> >>  This
> >> is a widely orthogonal issue, so please let us come back to my original
> >> point.
> >>
> > 
> > The original proposal suggests an ad hoc solution for a specific class
> > of tracing needs (code flow analysis with low temporal invasiveness)
> > (*).
> > 
> > I suggest that we _also_ take the time to think ahead, about a common
> > infrastructure which would host the basic, well-supported tools people
> > need to debug Xenomai applications. It is always possible to work around
> > temporal invasiveness by simulating external input, there are a few
> > techniques that work pretty well for that purpose, people working with a
> > co-design approach are doing that all the time. But before this, it
> > would be great that the code one relies on does not include silly or
> > less silly basic coding issues. Valgrind is such a framework defining a
> > possible infrastructure.
> > 
> > To sum up, I'm going to follow your work on usystrace to see where it
> > leads us, even if I'm not happy with its potential impact on the code.
> > Whether it gets eventually merged or not really depends on that aspect.
> 
> I'm also in favour of a less invasive approach as sketched earlier.
> 
> > At the same time, or at least in a reasonable future, we should REALLY
> > think about making Xenomai Valgrind-compatible, so that we could cover
> > the rest of the needs for debug tools. This is something I might pick
> > when my TODO list shortens, if nobody did it before.
> 
> Well, nothing is impossible given unlimited resources. I'm just slightly
> sceptical about the impact of some Xeno-Valgrind on the target and the
> related side-effects. Ugly things also depend on timing, and simulating
> the environment accurately is often a full project of its own. Hmm, ok,
> we could help users a bit by collecting and later on replaying events
> and I/O data at standardised interfaces (IPC mechanisms, standard RTDM
> devices, etc.). We could then smartly combine Valgrind with the
> simulator to control timing precisely. Still _a lot_ of work...
> 

Well, Xenomai is the result of a much larger work since July 2001, so
there is hope.

> > 
> > (*) You could avoid passing the function name in the systrace calls, by
> > relying on the value of __FUNCTION__, with a small hack to trimm the
> > __wrap_ prefix when needed. Making tracepoints less hairy would ease my
> > pain reading this stuff.
> 
> OK, but let's not spend brain cycles on this until we know if and how we
> can separate the entry/exit tracing from the traced service. If we could
> leave existing lib code untouched, I would be happier as well.
> 

It does matter because it reduce visual clutter, and that's a
prerequisite for merging, that's why I'm suggesting it.
We already have an automated instrumentation tool for the simulator, but
I'm not sure automatically inserted tracepoints would always be relevant
in all cases.

> Jan
> 
-- 
Philippe.



