From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A157FD9.40106@domain.hid>
References: <4A157FD9.40106@domain.hid>
Content-Type: text/plain
Date: Tue, 02 Jun 2009 11:09:09 +0200
Message-Id: <1243933749.27443.557.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] About HARD real time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antoine Nourry <nourry@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, 2009-05-21 at 18:22 +0200, Antoine Nourry wrote: 
> Hi,
> I just wonder :
> Why can we read everywhere that PREEMPT-RT patch offer HARD real time 
> while in other papers we can read that it cannot ensure determinism  ?
> (because it only seems to permit low latencies but not constant 
> execution times, by the way why ? Is it because this patch still uses 
> undeterministic parts of the kernel ? )

Nobody is having constant execution times anyway, native or co-kernel:
CPUs are stuffed with caches and all sort of artefacts that come with
them, particularly with the current trend of multi-core architectures.
Part of the system wants throughput, many interfaces and lots of drivers
(the plain non-RT linux activities) and the other part wants absolute
priority via immediate preemption (the rt layer), all competing for the
same hardware resources at some point, none caring for the neighbour.
E.g.

- run a latency test, with some load. Fire one test with a 10Khz period,
and another one later using a 100hz period. Maybe counter-intuitively to
some, you will get lower worst-case latency with the former, because the
system will have less time/opportunity to evict the latency test from
the caches due to the higher sampling frequency.

- run a latency test while a process is causing lots of page table entry
flushes (LTP's mm stress tests do this). If your architecture has a
software-assisted MMU management, like we may find on powerpc, the
relevant code in a classic kernel is likely to operate with interrupts
disabled while flushing an entire PTE range. If your platform is
SMP-enabled, that code will probably have to exclude other CPUs while
running as well. Enable HIGHMEM to use > 1Gb memory, and you may well
end up doing that for 1024 PTE in a row. This may induce a latency
penalty > 400 us, depending on the hw. And having > 1Gb memory available
on modern embedded hardware is not that uncommon, especially with
network processors.

Regardless of -rt, co-kernel, whatever, we all have those problems with
respect to execution time, and also unbounded latency issues, that we
ought to take care of on a case-by-case basis. But even if you carefully
prevent unbounded latencies by fixing the vanilla kernel code, the PTE
range flush issue just described does still introduce uncertainty with
respect to the execution time; this jitter is only made acceptable
because we bounded it to a known maximum value (e.g. < 15 us on a dual
core 8641D). Which we measured... by observation, because a GPOS+RTOS
mix is currently too complex for any formal verification.

Therefore, the fact that some acceptable results with respect to latency
were obtained on a given sw/hw combo does not mean anything regarding a
significantly different combination, regardless of the RT approach you
have been using to collect them. Typically:

- focus on x86, enable the wrong set of option pertaining to the ACPI
kitchen-sink, and/or face SMI events, and/or run an X-server that plays
silly games with the interrupt state from userland, and both -rt and
co-kernels will have serious latency issues.

- leave the common x86 world to run -rt on embeddded platforms, enable
non-mainstream drivers, or enable HIGHMEM on platforms with
software-assisted MMUs, and you may get some reasons to get busy fixing
latency spots in the future (not to speak of the ARM VIVT cache flushing
issue causing the latency figures to skyrocket when switching task
contexts on classic kernels -- guess why Gilles enabled FCSE is Adeos
patches recently).

This makes assertions like "<blah> is able to sustain <blip> us
worst-case latency. period." without specifying the exact
characteristics of the sw and hw involved in the test, a bit suspicious,
to say the least (read: this is reaching 97 over 100 on the bs'o'meter).

> Considering this, how Xenomai 3 will be able to rely on PREEMPT-RT as 
> real time enabling technology, allowing user to bypass ADEOS ?
> 
> 

If one admits that both native preemption and dual kernel approaches
have their own set of exclusive pros and cons, while sharing the same
initial challenges brought by a mixed GPOS+RTOS environment, that
question is a no-brainer: Xenomai should be able to rely on -rt enabled
systems where no unacceptable latencies are observed regardless of the
workload. This is a case-by-case matter, which depends on a given kernel
release running on a given hw combo with a given software set enabled.

For that reason, x3 will allow users to base their RT system over -rt or
the I-pipe, as they see fit, as the requirements mandate. When running
over -rt, Xenomai will only be in charge of providing real-time APIs;
when running over the I-pipe, it will also provide the real-time bedrock
that keeps latencies low, like it already does with earlier versions.

As Paul E. McKenney puts it:
"This is not to say that hard real time is undefined or useless.
Instead, 'hard real time' is the start of a conversation rather than a
complete requirement."
http://www.linuxjournal.com/article/9361

> 
> Thanks for your work,
> Antoine
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



