From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <960954e41003160822o5fdf99eah3744023e72cafe33@domain.hid>
References: <960954e41003160822o5fdf99eah3744023e72cafe33@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Mar 2010 16:57:39 +0100
Message-ID: <1268755059.27899.287.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Scheduling latency issues
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gerald Otter <gerald.otter@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-03-16 at 16:22 +0100, Gerald Otter wrote:
> Hello Xenomai users and developers,
> 
> for my grad. assignment I am comparing Xenomai to some other co-kernel
> implementations (all using the Linux kernel).
> The documentation of this project has been great, and the archives and
> source code has been a great help in finding my way around the system.
> 
> However, I've hit a little bump while testing some scheduling latency
> using the POSIX skin.
> The latencies I'm registering are okay, but they do differ when
> picking different periods.
> I have excluded my program from causing this issue, as the same thing
> happens when using the latency tool supplied by Xenomai.
> 
> I have run some traces to determine where the problem might be (see
> attachments), with one run using a 1 ms period and another using a 10
> ms period.
> I've noticed a big difference between __ipipe_syscall_root on offset
> 0x108 and in xnpod_resume_thread.
> The latencies get even better when using a periodicity of 100
> microseconds, and worse still at 100 milliseconds.
> 
> Of course, a latency difference of 10 microseconds isn't that bad, but
> I'm wondering why there is a difference at all? 

Cache artefact. By picking a short period, the Xenomai interrupt code is
I-cached most of the time, and not much time is left to the regular
non-rt linux activities to evict that code from the cache.

By increasing the period, more time is left to linux to cause cache
evictions from real-time code, which translates into longer latencies
due to cache misses and refills. The I-pipe tracer makes the phenomenon
even more observable, because it consumes more D-cache as well.

> I can attach my program as well if needed, but it simply loops in a
> thread and using clock_nanosleep with CLOCK_MONOTONIC, and pushing the
> results to a display thread with a message queue.
> Still, the same occurs when using the supplied latency tool.
> 

Take into account that the I-pipe tracer is inducing significant latency
on powerpc, particularly now that is based on the ftrace infrastructure.

With CONFIG_IPIPE_TRACE disabled, your 854x should exhibit latency
figures in the 20-30 us range worst-case in user-space (from the top of
my head, but I would consider higher latencies as pathological on 85xx).

> The system I'm testing this on is a MPC8548E , with Linux-2.6.29-DENX
> and Xenomai 2.5.0 .

If you plan to do measurements, make sure to always pick the latest
available release when you start working, particularly when the series
has just been started. 2.5.1 would be better, and picking 2.5.2 when
it's out would be even better, to get rid of a few but annoying issues
(read: freaking ugly monsters from the horror show) - albeit not
latency-related though.

> 
> Thanks in advance for your help.
> 
> Gerald Otter
> 
> p.s. I've read through the mailing lists and the TROUBLESHOOTING
> files, but could not find any references to a similar issue.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



