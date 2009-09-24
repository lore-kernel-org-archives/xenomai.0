Message-ID: <4ABBC143.8000005@domain.hid>
Date: Thu, 24 Sep 2009 20:58:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9aa019ba0909150827u38360ec1m7b749838ab0c54c4@domain.hid>	<1253116044.2676.153.camel@domain.hid>	<9aa019ba0909171026i51de25a7g6e0c5fd60273747@domain.hid>	<4AB2745E.3030106@domain.hid>	<9aa019ba0909171345t4a2996eavc950fa4de543fd6d@domain.hid>	<4AB2A308.4010508@domain.hid>
	<9aa019ba0909241146y9a97988m8aca04540e2289a1@domain.hid>
In-Reply-To: <9aa019ba0909241146y9a97988m8aca04540e2289a1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt only runs once
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: James Kilts <jameskilts@domain.hid>
Cc: xenomai@xenomai.org

James Kilts wrote:
>> you should really upgrade to 2.4.9.1.
> 
> I'm now running Xenomai 2.4.9.1 on Linux 2.6.28.9.
> 
> 
>>>> I had a look at handle_prio_irq in arch/arm/mach-ns9xxx/irq.c. What
>>>> this irq handler does is bad, really bad. If you care about interrupt
>>>> latencies, you should really use handle_level_irq. That is, replace the
>>>> #if 0 with a #if 1.
> 
> Interrupt latency in the Linux kernel is not important to me, but
> Xenomai interrupt latency is critical.  Just for the fun of it, I
> tried switching to handle_level_irq() and then adding an irq_finish()
> function similar to the AT91, but Linux locks up during the boot
> sequence while initializing the Ethernet stack.  The timing of ACK/EOI
> on this chip is sensitive.

Using irq_finish was a bad advice, handle_level_irq should be ok.
Anyway, the point is that the interrupt handler which does the
acknowledge after the invocation of the ISR also delays the real-time
interrupts, which is why you should not use it.

> 
> Currently the problem is that a Xenomai ISR on this system needs to
> respond to interrupts consistently under 50 microseconds.  When the
> system is running idle or when running "dd if=/dev/zero of=/dev/zero",
> it's able to respond to an IRQ trigger by toggling a GPIO within 35
> microseconds.  But if I run "top" and then flood the serial input
> buffer with carriage returns (holding down the enter key) the oscope
> occasionally shows a large delay, in about 1 out of every 30 ISR calls
> the GPIO toggles late on the order of 100-300 microseconds.  The
> timing is worse when I flood the system with pings, upwards of 3
> milliseconds to respond, although the majority remain under 35
> microseconds.
> 
> These tests have been run using a LeCroy 1 GHz Oscilloscope.
> 
> I've been through the Troubleshooting and verified that all power
> management, frequency modulation, etc. are disabled.  The serial port
> driver does not appear to be masking the interrupts.  Any ideas as to
> what could be causing these delays?

To improve things, you should either enable FCSE in guaranteed mode, or
use Xenomai head, and enable unlocked context switches. What latency do
you get with the klatency test?

-- 
					    Gilles.

