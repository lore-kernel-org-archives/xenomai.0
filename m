Subject: Re: [Xenomai-core] xenomai preempting interrupt handler ?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45EFF835.9010305@domain.hid>
References: <45EFD796.7050002@domain.hid>
	<1173346938.17515.16.camel@domain.hid>  <45EFE089.9000508@domain.hid>
	<1173349157.17515.19.camel@domain.hid>  <45EFF835.9010305@domain.hid>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 13:22:41 +0100
Message-Id: <1173356561.17515.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

On Thu, 2007-03-08 at 12:49 +0100, Steven Scholz wrote:
> Philippe,
> 
> >>>>  Thus will the duration of the
> >>>> ethernet interrupt handler add the the worst case latency?
> >>> Not from Linux IRQ handlers; you may want to check this using the
> >>> tracer. If hw interrupts are masked there, then it's a blatant bug.
> >> How could I check this using the tracer? Small hint please?
> > 
> > http://www.xenomai.org/index.php/I-pipe:Tracer
> 
> "Traces can be generated in many ways. One happens automatically when
> CONFIG_IPIPE_TRACE_IRQSOFF is enabled."
> 
> What exactly does that mean? That one trace is generated during boot?
> 

That means that several sources of trace points exist, one of them being
controlled by the IRQSOFF switch. MCOUNT cause a trace to be emitted
upon each function entry, and so on.

> "Another way is to invoke the testsuite, namely latency or irqbench with the
> option -f to trigger a freeze on each new maximum latency."
> 
> What exactly does "trigger a freeze" mean?
> 

A snapshot of the current trace log, kept from being overwritten in a
separate memory upon freeze, that you can access
through /proc/ipipe/trace/frozen.

> Steven
> 
-- 
Philippe.



