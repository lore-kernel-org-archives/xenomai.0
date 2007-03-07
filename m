From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
Date: Wed, 7 Mar 2007 10:04:14 +0100
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<17901.49981.701410.464219@domain.hid>
	<45EDD311.1060506@domain.hid>
In-Reply-To: <45EDD311.1060506@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOs43-0008OG-Ki@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: xenomai@xenomai.org

Roland Tollenaar wrote:
> Hi,
>
> Gilles Chanteperdrix wrote:
> >>> Enable the I-pipe tracer, recompile your kernel, set
> >>> /proc/ipipe/trace/back_trace_points to a larger value, and run latency
> >>> with the -f flag. Show us the contents of /proc/ipipe/trace/frozen, and
> >>> we may be able to give you an answer.
> >>>
> >>> For more details on the I-pipe tracer, see:
> >>> http://www.xenomai.org/index.php/I-pipe:Tracer
> >>
> >> Attached find the traces. The first one , frozentrace.txt is without
> >> my application running.
> >>
> >> The frozentraceApptxt with my app running and frozentrace_rtcanrecv
> >> with the node  alive but only read by rtcanrecv.
> >
> > frozentraceApp.txt:
> > :|func     -217!  rtcan_sja_interrupt (xnintr_irq_handler)
> > :|func      -96   rtcan_rcv (rtcan_sja_interrupt)
> >
> > and frozentrace_rtcanrecv.txt:
> > :|func     -164!  rtcan_sja_interrupt (xnintr_irq_handler)
> > :|func      -39   rtcan_rcv (rtcan_sja_interrupt)
> >
> > look very consistent: the call to rtcan_sja_interrupt eats more than
> > 100 us.
>
> What does this mean? This is as good as it gets?

Hm. To be more verbose on what happens between the beginning of 
rtcan_sja_interrupt and rtcan_rcv please remove the "inline" from the 
functions rtcan_sja_err_interrupt in the file 
ksrc/drivers/can/sja1000/rtcan_sja1000.c line 156 and from the function 
rtcan_sja_rx_interrupt in the same file in line 87. Compile your 
modules/kernel again and repeat the tracer/latency test.

I assume that most of the time is spent in the latter function where several 
SJA HW regs are read out. A slow access to the regs could be the explanation 
for the long time the interrupt handler has to spend.

-- 
Sebastian

