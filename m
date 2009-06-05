Message-ID: <4A28E5E0.9020805@domain.hid>
Date: Fri, 05 Jun 2009 11:31:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A28F029020000F80002DB14@domain.hid>	<4A28FAD4020000F80002DB27@domain.hid>
	<4A28FAD7.3E52.00F8.0@domain.hid>
In-Reply-To: <4A28FAD7.3E52.00F8.0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Tyss <tyss.k@domain.hid>
Cc: xenomai@xenomai.org

Karl Tyss wrote:
> Hi,
> 
> I am running Xenomai 2.4.7 and linux-2.6.28 on ATMELs AT91SAM9G20-EK. I
> noticed a strange thing while measuring IRQ latency with a logic
> analyser. Basically I just insert a module with insmod into the kernel.
> The module creates an interrupt with "rt_intr_create" and the isr only
> triggers a gpio pin up and down.
> 
> I also turned I- and D-caches off to avoid the effects of cache-flushes
> on a context switch. If the kernel runs the idle process (cpu_idle) the

This is a bad idea, cache helps to improve the overall performance of
your system. If you are worried about cache flushes during context
switches, you should enable the FCSE option (in guaranteed mode, if you
do not intend to create more than 95 processes or use more than 32
Mbytes per process).

> latency is about 2us larger than with a load. It seems be irrelevant
> what kind of load I generate. To generate load I am now using a "stress"
> application I found. The simplest case is that it runs a loop and calls
> the rand() function.

That is hardly sufficient. What we use to correctly stress the system
during our tests is based on a cocktail of LTP (the Linux testing
project), network load with netcat, process creation with an infinite
loop of cat /proc/interrupts and ps.

> 
> The "idle"-latency is about 25us in this case and the "stressed" one
> about 23 us.

Xenomai is about improving the worst case latency of the system, under
load, not about improving the best case latency. So, this difference is
irrelevant.


-- 
					    Gilles.

