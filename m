From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <Pine.LNX.4.44L.0410281313070.7871-100000@domain.hid>
References: <20041027042517.19465.86755.Mailman@domain.hid>
	 <Pine.LNX.4.44L.0410271428370.21604-100000@domain.hid>
	 <1098910087.669.7.camel@domain.hid>
	 <Pine.LNX.4.44L.0410281313070.7871-100000@domain.hid>
Content-Type: text/plain
Message-Id: <1098986175.675.27.camel@domain.hid>
Mime-Version: 1.0
Date: Thu, 28 Oct 2004 19:56:15 +0200
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: Question about adeos_alloc_irq
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Currie Reid <curriereid@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2004-10-28 at 19:22, Currie Reid wrote:
> Hi Philippe,
> 
> I am basically trying to get some latency figures using Adeos, and I've
> hit a snag.  Basically, I wanted to cause an interrupt, then measure the
> time it took in the root domain to respond to the interrupt.  Then, I
> wanted to put the irq handler in a higher priority domain, and measure the
> response this latency and compare the 2.  I thought that the second one
> would be lower, as the interrupt is sure not to be masked in the higher
> priority domain, while there are no such guarantees in the root domain
> (linux).  But I'm finding the latencies higher; the average latency is
> higher and the max is higher as well - I don't know if this is because
> there is some context-switching overhead or what the problem might be.
> I'm including my module on the chance that you might spot something wrong
> with it immediately.

Calling adeos_trigger_irq() with irqs on over the root domain while a
handler exists in the same domain will immediately run the IRQ handler
on behalf of adeos_trigger_irq(), with no more CPU cost than a simple
function call. OTOH, switching to the interrupt domain will require a
full domain switch, hence the higher cost. This said, a better way to
measure the latency is not by using virtual IRQs, which exhibit the
specific behaviour above, but rather a real external IRQ, such as the
timer one.

Just hook _adeos_timer_virq on PPC in a prioritary domain, and compare
the max jitter obtained between two ticks to the same measurement in
timer_interrupt() from a vanilla kernel. The figures should confirm
what's expected.

PS: calling do_gettimeofday() outside the root domain is unsafe, since
you could have preempted any critical Linux section to enter this code.
This looks like working somewhat, but only because the caller is usually
lucky.
Using adeos_hw_tsc() to collect the TBL/U then scale the value to
nanoseconds is safe in any case.

-- 

Philippe.


