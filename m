Date: Tue, 20 Jun 2017 10:30:09 -0400
Message-ID: <20170620143009.GB18556@csclub.uwaterloo.ca>
References: <DB6PR0701MB24567D7382C2C3C1C6BBB0A3B5C60@DB6PR0701MB2456.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0701MB24567D7382C2C3C1C6BBB0A3B5C60@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] Gpio: IRQ handler is called ~4ms after state change
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, Jun 17, 2017 at 04:52:18PM +0000, Giulio Moro wrote:
> Hi,
> I ported this GPIO driver from Xenomai 2.6 to Xenomai 3 and I run it on the Beaglebone Black: https://github.com/giuliomoro/gpio-irq-rtdm/
> 
> TheRTDM  irq_handler (in gpio_irq_rtdm.c) toggles a pin "kernel timingpin" as soon as the IRQ is received.
> The test program registers a pin to monitor and sleeps in a ioctl() waiting for the pin to go low. When the kernel unblocks it from the ioctl(), the task toggles another pin "user timingpin".
> 
> The original authors claims that, on the BeagleBone Black, with Xenomai 2.6:
> * the kernel timingpin will change roughly 5us after the test pin is toggled by an external clock
> *  the user timingpin will change roughly 5-10us after the kernel timingpin
> 
> The above values make sense to me.
> 
> My observations, on the BeagleBone Black, Linux 4.4.65 with Xenomai 3.0.5:
> * the kernel timingpin will change roughly 4ms (milliseconds) after the test pin is toggled by an external clock
> * the user timingpin will change 40 to 60us (microseconds) after the kernel timingpin
> 
> So it seems that in my case it takes a long time for the irq_handler() to be called after the test pin is toggled.
> Am I doing something wrong in the kernel module ?
> 
> See in particular irq_handler() and gpio_irq_ioctl_rt() in gpio_irq_rtdm.c
> and demo() in gpio-irq-test.c

The 4ms delay reminds me of a problem I had on the am57xx with a gpio irq.
Turns out that in that case smartidle was enabled and the gpio bank
would go into sleep mode and it took 4ms to wake up before the irq would
show up.  Turning off the smartidle on the gpio bank so that it never
could go to sleep solved the problem.  Maybe this TI chip has a similar
feature.

-- 
Len Sorensen

