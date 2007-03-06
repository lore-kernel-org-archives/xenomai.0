From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17901.49981.701410.464219@domain.hid>
Date: Tue, 6 Mar 2007 20:38:37 +0100
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <bc4264770703061017n6b38c7d1g183a0c1866c165@domain.hid>
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<45ED84B8.3010307@domain.hid>
	<bc4264770703060753j1c67d6cat2b04e19f2ca376fa@domain.hid>
	<45ED8FC8.4090103@domain.hid>
	<bc4264770703060811p41e0dff5s80d46c0d14314a15@domain.hid>
	<45ED93AE.5050007@domain.hid>
	<bc4264770703060832x4ddab7b8mbb1d477588af8608@domain.hid>
	<45ED99E9.2000105@domain.hid>
	<bc4264770703061017n6b38c7d1g183a0c1866c165@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

> > Enable the I-pipe tracer, recompile your kernel, set
> > /proc/ipipe/trace/back_trace_points to a larger value, and run latency
> > with the -f flag. Show us the contents of /proc/ipipe/trace/frozen, and
> > we may be able to give you an answer.
> >
> > For more details on the I-pipe tracer, see:
> > http://www.xenomai.org/index.php/I-pipe:Tracer
> 
> Attached find the traces. The first one , frozentrace.txt is without
> my application running.
> 
> The frozentraceApptxt with my app running and frozentrace_rtcanrecv
> with the node  alive but only read by rtcanrecv.

frozentraceApp.txt:

:|func     -217!  rtcan_sja_interrupt (xnintr_irq_handler)
:|func      -96   rtcan_rcv (rtcan_sja_interrupt)


and frozentrace_rtcanrecv.txt:

:|func     -164!  rtcan_sja_interrupt (xnintr_irq_handler)
:|func      -39   rtcan_rcv (rtcan_sja_interrupt)

look very consistent: the call to rtcan_sja_interrupt eats more than
100 us.

-- 


					    Gilles Chanteperdrix.

