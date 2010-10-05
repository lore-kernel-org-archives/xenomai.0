Message-ID: <4CAAFD2D.4050004@domain.hid>
Date: Tue, 05 Oct 2010 12:25:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CAAF0CA.7060603@domain.hid> <4CAAF648.8000001@domain.hid>
In-Reply-To: <4CAAF648.8000001@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Overcoming the "foreign" stack
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Am 05.10.2010 11:56, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> quite a few limitations and complications of using Linux services over
>> non-Linux domains relate to potentially invalid "current" and
>> "thread_info". The non-Linux domain could maintain their own kernel
>> stacks while Linux tend to derive current and thread_info from the stack
>> pointer. This is not an issue anymore on x86-64 (both states are stored
>> in per-cpu variables) but other archs (e.g. x86-32 or ARM) still use the
>> stack and may continue to do so.
> 
> On ARM vanilla tracing capabilities have way too much overhead to be
> really usable. I have tested a "standalone" version of mcount which
> calls directly the Ipipe tracer, and I get less overhead, something like
> 20%.
> 
> The philosophy of ftrace is well explained by the following sentence,
> extracted from the ftrace design text file: "Also keep in mind that this
> mcount function will be called *a lot*, so optimizing for the default
> case of no tracer will help the smooth running of your system when
> tracing is disabled."
> 
> When using the I-pipe tracer, we are interested in precisely the reverse
> optimization: we do not care about the overhead of mcount when the
> tracer is not enabled, we will not keep the tracer enabled in
> configuration when not tracint anyway, but we really want mcount to have
> as little overhead as possible when the tracer is enabled.

There are use cases for both, also on smaller embedded targets. But I
agree that it can be worth to continue optimizing mcount separately on
some archs. Still, mcount is only a smaller part of ftrace these days,
and I'm actually way more interested in event tracing (as a potential
substitution for LTTng adaptions).

> 
> Still on ARM, the perf code requires handling an interrupt when the
> performance counters overflow. So, getting this to work with the I-pipe
> would mean ironing this irq handler and all the functions it calls, and
> all the spinlocks that are involved.

On x86, perf triggers NMIs, so the code is at least conceptually
prepared for any context. We just need to provide a few states
independent of what Xenomai does. Feasible I would say.

> 
> What I am trying to say is that trying to use the vanilla
> infrastructures will probably cause many more problems than just the
> stack issue, and if we look at the I-pipe tracer example again, it is
> really not obvious what the vanilla infrastructure bring us: only the
> ftrace_register/ftrace_unregister services, at the expense of 20% more
> overhead.

 - event tracing
 - function graph tracing
 - stack tracing (including user land)
 - $your-whatever-tracer
 - consistent view on the system (if current is always valid, there are
   no more confusions between current Linux vs. Xenomai task)
 - full-blown management interface (debugfs)
 - growing user land tools (specifically Kernelshark, which has an
   interesting plugin concept)
 - reduced maintenance (hopefully)

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

