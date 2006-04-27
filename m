Message-ID: <4450B563.9020100@domain.hid>
Date: Thu, 27 Apr 2006 14:13:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Latencies for the Freescale i.MX21/CSB535FS
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD6@domain.hid>
	<4450B2B8.1060800@domain.hid>
In-Reply-To: <4450B2B8.1060800@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>, xenomai@xenomai.org

Jan Kiszka wrote:
> ROSSIER Daniel wrote:
> 
>>>I'd say that the most efficient way to reduce those latencies would
>>>require to first identify the source of the 40+ us spot observed with
>>>the -t2 form on an idle system. For that, I'm convinced that porting the
>>>I-pipe tracer to ARM would be the best option, since this tool would be
>>>of great help there.
>>>
>>
>>Thanks for the hint; we will spend some time on the tracer in the coming days. We keep you informed.
>>
> 
> 
> Cool, tracing also for ARM!
> 
> 
>>>This port basically requires 1) to code the mcount() routine supporting
>>>gcc's -pg option, 2) to solve early boot issues so that mcount() does
>>>not attempt to trace anything while the memory environment has not been
>>>fully set up. The rest is pretty generic.
>>>
> 
> 
> Regarding a mcount() implementation and other details, the original
> tracer effort by Ingo Molnar may give useful hints (at least it did for me):
> 
> http://people.redhat.com/mingo/latency-tracing-patches/
> 
> I remember the ARM part not being that simple as x86. I think this was
> also due to lacking stack unwinding support on that arch.
> 

There's a said to be working replacement for __builtin_return_address 
provided by mingo's patch.
http://people.redhat.com/mingo/latency-tracing-patches/patches/latency-tracing.patch

-- 

Philippe.

