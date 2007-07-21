From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <469FA616.9040900@domain.hid>
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>
	<469345EB.6060302@domain.hid>
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>
	<2026261.1184070574283.JavaMail.ngmail@domain.hid>
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
	<4693A702.1010604@domain.hid>
	<913919.1184311634860.JavaMail.ngmail@domain.hid>
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>
	<469F4A98.3080307@domain.hid> <1184847549.28303.46.camel@domain.hid>
	<469F5BA5.1030407@domain.hid> <1184858093.28303.85.camel@domain.hid>
	<469F84B3.6070104@domain.hid> <1184861035.28303.108.camel@domain.hid>
	<469FA616.9040900@domain.hid>
Content-Type: text/plain
Date: Sat, 21 Jul 2007 22:15:13 +0200
Message-Id: <1185048913.5998.124.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] Sporadic PC freeze after
	rt_task_start
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
Cc: xenomai@xenomai.org

On Thu, 2007-07-19 at 19:57 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > Ok, the rpilock is local, the nesting level is bearable, let's focus on
> > putting this thingy straight.
> 

Sorry, I missed this one, which in fact explains that you were referring
to Xenomai PI and not PREEMPT_RT PI (yeah, I thought for a while that
you were nuts enough to ask me to model RPI after RT-PI... so I must be
nuts myself)

> Well, redesigning things may not necessarily improve the situation, but
> reducing the amount of special RPI code might be worth a thought:
> 
> What is so special about RPI compared to standard prio inheritance?

Basically, boost propagation and priority backtracking as I previously
answered in the wrong context. This said, I still think that PI (the
Xenomai one) complexity is much higher than RPI in its current form.

>  What
> about [wild idea ahead!] modelling RPI as a virtual mutex that is
> permanently held by the ROOT thread and which relaxed threads try to
> acquire? They would never get it, rather drop the request (and thus the
> inheritance) once they are to be hardened again or Linux starts to
> schedule around.
> 
> *If* that is possible, we would
>  A) reuse existing code heavily,
>  B) lack any argument for separate locking,
>  C) make things far easier to understand and review.
> 
> Sounds too beautiful to work, I'm afraid...
> 

It would be more elegant than RPI currently is, not question. This is
the way message passing works in the native API, in order to implement
the inheritance by the server of the client priority, for instance.

The main problem with PI, is that all starts from xnsynch_sleep_on.
Since we could not use this interface to activate PI, we would have to
craft another one. Additionally, some Linux activities may change the
RPI state (e.g. sched_setscheduler()), so we would have to create a
parallel path to fix this state without resorting to the normal PI
mechanism aimed at being used over a blockable context, Xenomai-wise.
A lot of changes for the purpose of solely recycling the basics of a PI
implementation.

> Jan
> 
-- 
Philippe.



