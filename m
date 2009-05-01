From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <49FA28F7.3060405@domain.hid>
References: <200904301508.29432@domain.hid> <200904301509.13094@domain.hid>
	<200904301510.8382@domain.hid> <200904301511.15875@domain.hid>
	<200904301512.9035@domain.hid> <200904301513.12716@domain.hid>
	<200904301514.6099@domain.hid> <200904301515.16182@domain.hid>
	<200904301516.696@domain.hid>  <49F9B123.7080203@domain.hid>
	<1241103352.26544.177.camel@domain.hid>  <49FA28F7.3060405@domain.hid>
Content-Type: text/plain
Date: Fri, 01 May 2009 11:34:20 +0200
Message-Id: <1241170460.26544.205.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm_event_timedwait returns -EINTR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Lockhart <Thomas.Lockhart@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-help <xenomai@xenomai.org>, "Lockhart, Thomas G" <thomas.g.lockhart@domain.hid>

On Thu, 2009-04-30 at 15:40 -0700, Thomas Lockhart wrote:
> > Xenomai always tells the kernel that blocking (Xenomai) syscalls
> > _should_ be restarted when interrupted by a Linux signal (i.e.
> > -ERESTARTSYS is passed down to the kernel by the Xenomai core in that
> > case), and the kernel will actually restart that (Xenomai) syscall if no
> > handler was installed for such signal, or if SA_RESTART is set in the
> > sigaction() flags for the signal.
> 
> Thanks for the clarification. I was hoping my reply would expose my lack 
> of understanding :)
> 
> So I'm getting what I think are great results on my system with my 
> Xenomai-enabled software (a few usec jitter, ~10usec latency or offset 
> without anything special done when building or calibrating Xenomai. The 
> system is a fairly modern dual-processor Xeon desktop machine and 
> Xenomai is 2.4.7; kernel is 2.6.26 (needed for a third party device 
> driver which breaks with 2.6.27).
> 
> When running at a very low rate (10Hz) every 30 seconds or so there is a 
> latency spike of around 50usec. Not bad (and acceptable for my system 
> even at kHz rates), but it certainly stands out from the usual case.
> 
> Could this occasional extra latency be due to this signal interrupt and 
> transparent restart? Or should I dig around elsewhere?
> 

Linux signal handling is fully preemptible by Xenomai like most of what
happens in plain kernel context, so this is most likely not related. I
mean that a task receiving a signal would not delay a real-time task
(unless both tasks are somehow logically bound, but I guess this is not
the case here).

Maybe counter-intuitively, the lower the rate, the higher the latency.
This is due to cache artifacts, since at low rate, the non-RT Linux
activity has even more opportunities to cause cache eviction of RT code
since it may run longer. This is why running a latency test at 10Khz
most often gives better results than running it at 1Khz on any
architecture (e.g. latency -p 100 vs latency -p 1000). However, bumping
from 10 to 50 us seems quite a large penalty for such situation,
especially on high-end x86 architectures.

The fact that such peak seems to occur periodically may point the finger
at an external factor, like SMI-like preemption (even if the penalty
usually observed in this case is more in the 300 us range).

In order to understand what is going on your system, I would first try
to reproduce the issue using the Xenomai latency, running at 10hz, on a
kernel enabling the I-Pipe tracer (CONFIG_IPIPE_TRACE). The latency test
provides an option that takes a snapshot of the kernel execution path at
the time the highest latency was observed (-f switch). i.e.

# echo 1 > /proc/ipipe/trace/verbose
# echo 200 > /proc/ipipe/trace/back_trace_points
# /usr/xenomai/bin/latency -p 100000 -f

Once this latency has been observed, just stop the latency test, then
read /proc/ipipe/trace/frozen to get the trace log, and post it to this
list.

HTH, 

> TIA
> 
>                            - Tom
-- 
Philippe.



