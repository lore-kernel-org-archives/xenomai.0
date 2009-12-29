From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1262081910.19080.363.camel@domain.hid>
References: <b88603c30912290148v7c67f028vce0a432c352ee41f@domain.hid>
	<1262081910.19080.363.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 Dec 2009 11:50:07 +0100
Message-ID: <1262083807.19080.378.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Long latency exactly every hour
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-12-29 at 11:18 +0100, Philippe Gerum wrote:
> On Tue, 2009-12-29 at 10:48 +0100, Henri Roosen wrote:
> > Hi,
> > 
> > I have a small board with a Vortex86DX processor, which is a x86
> > compatible processor. I have a Linux Xenomai kernel 2.6.30.10 running
> > with ipipe 2.4-09 and Xenomai 2.4.10. The .config file is attached to
> > this email.
> > 
> > The latency test program runs fine with latencies < 40us, but exactly
> > every hour I get one latency which is about 450us. In our system that
> > is killing.
> > 
> > I switched off all the SMI and NMI on the board so that will not cause
> > the latency. Also I don't see any NMI's or ERR interrupts in
> > /proc/interrupts.
> > 
> > I enabled the ipipe tracer and did a couple of runs. What I noticed is
> > that the long delay is happening every time at ipipe_check_context in
> > the Linux domain (see attached trace_464.log and trace2_438.log). What
> > could be blocking the next common_interrupt for so long or what is
> > happening there?
> > 
> 
> Actually, the bad guy is not ipipe_check_context(), but i8042_interrupt,
> from the serio driver, one line above in the report. For some reason, it
> spins there for quite a while.
> 
> If you look at the various interrupt statuses reported on that line, you
> will see that interrupts are still enabled at hw level, but stalled only
> for Linux. So what that interrupt handler does, seems to defer the next
> interrupt at PIC/device level, but nothing masks it at CPU level.

Well, unless some code there fiddles with the interrupt mask internally,
in a way that does not get reported to the tracer, in which case what
the tracer reports would be suspicious/incomplete wrt the hw interrupt
status.

> 
> A possible way to debug this is to add more tracepoints to the suspected
> code. You have a special tracer call for adding manual instrumentation,
> named "ipipe_trace_special()". You could use it this way, e.g.
> 
> static irqreturn_t i8042_interrupt(int irq, void *dev_id)
> {
> 	struct i8042_port *port;
> 	unsigned long flags;
> 	unsigned char str, data;
> 	unsigned int dfl;
> 	unsigned int port_no;
> 	int ret = 1;
> 
> 	spin_lock_irqsave(&i8042_lock, flags);
> +	ipipe_trace_special(0x11, 0);
> 	str = i8042_read_status();
> 	if (unlikely(~str & I8042_STR_OBF)) {
> 		spin_unlock_irqrestore(&i8042_lock, flags);
> 		if (irq) dbg("Interrupt %d, without any data", irq);
> 		ret = 0;
> + 		ipipe_trace_special(0x12, 0);
> 		goto out;
> 	}
> 	data = i8042_read_data();
> + 	ipipe_trace_special(0x13, 0);
> 	spin_unlock_irqrestore(&i8042_lock, flags);
> 
> and so on, until you think you have covered enough paths to find the
> culprit in the tracer log. The basic idea is to catch the high latency
> between two consecutive calls of the special tracepoints, ideally close
> enough from each other to allow a precise pinpointing of the faulty
> code.
> 
> See there for more:
> http://www.xenomai.org/index.php/I-pipe:Tracer
> 
> > All help for debugging and solving this problem is appreciated.
> > 
> > Thanks,
> > Henri.
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> 
> 


-- 
Philippe.



