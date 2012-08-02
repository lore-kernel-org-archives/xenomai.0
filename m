Message-ID: <501B08FA.5090909@xenomai.org>
Date: Fri, 03 Aug 2012 01:10:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] I-pipe core 3.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <Xenomai@xenomai.org>


Hi Philippe,

please find at the usual place:

git://git.xenomai.org/ipipe-gch.git, branch for-core-3.4

The current state of the I-pipe core patch for Linux 3.4 running on x86
and ARM. Compared to the last mail:
* several issues were fixed on ARM (with a severe one in switch_mm)
* some optimizations were made on x86 reducing drastically the latencies
on atom N230:
- the irq_hold handler for ioapic masks the irq line before sending the
eoi, avoiding the irq to be retriggered when the irq is of the level type
- the fpu is never restored during linux context switches, as it
increases the context switch irq masking time. I tried to further
decrease the context switch critical section by splitting the context
switch in three parts, and even by trying to run the context switch with
irqs on, to no avail.
* the I-pipe core API was changed, so the API revision was incremented
from 1 to 2:
- ipipe_timers_request now takes a cpumask argument specifying on which
cpus the timers should be requested
- the delay passed to ipipe_timer_set is now converted from clock
frequency to timer frequency, without a division, by the I-pipe.

Issues observed:
- when running with the I-pipe tracer on on x86, and
CONFIG_IPIPE_TRACE_IRQSOFF is enabled, we get a kernel oops. That is
because the definition of the "interrupt" macros makes use of the "rbp"
register to restore some other registers values after the call to the
interrupt function, but rbp is set to 0 on irq entry starting with linux 3.4
- pic muting has an issue with unlocked context switches: when a context
swich from xenomai domain to root domain happens, low priorities irqs
are unmasked before the unmasked context switch, so may trigger, with a
timer interrupt at the same time triggering in fact a re-switch to the
xenomai domain. The cure seems to be, in __xnpod_schedule, to only call
xnarch_reenter_root after the test at the end of the unlocked switch, I
tried that, but got lockups on AT91. So, I must be missing something.

-- 
                                                                Gilles.

