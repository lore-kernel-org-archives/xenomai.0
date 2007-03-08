Message-ID: <45EFF835.9010305@domain.hid>
Date: Thu, 08 Mar 2007 12:49:09 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] xenomai preempting interrupt handler ?
References: <45EFD796.7050002@domain.hid>	
	<1173346938.17515.16.camel@domain.hid> <45EFE089.9000508@domain.hid>
	<1173349157.17515.19.camel@domain.hid>
In-Reply-To: <1173349157.17515.19.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-core@domain.hid

Philippe,

>>>>  Thus will the duration of the
>>>> ethernet interrupt handler add the the worst case latency?
>>> Not from Linux IRQ handlers; you may want to check this using the
>>> tracer. If hw interrupts are masked there, then it's a blatant bug.
>> How could I check this using the tracer? Small hint please?
> 
> http://www.xenomai.org/index.php/I-pipe:Tracer

"Traces can be generated in many ways. One happens automatically when
CONFIG_IPIPE_TRACE_IRQSOFF is enabled."

What exactly does that mean? That one trace is generated during boot?

"Another way is to invoke the testsuite, namely latency or irqbench with the
option -f to trigger a freeze on each new maximum latency."

What exactly does "trigger a freeze" mean?

Steven


