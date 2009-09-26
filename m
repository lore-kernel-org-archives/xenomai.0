From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1253799543.12598.26.camel@domain.hid>
References: <1253799543.12598.26.camel@domain.hid>
Content-Type: text/plain
Date: Sat, 26 Sep 2009 12:03:45 +0200
Message-Id: <1253959425.7408.28.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Q about registering for an interrupt on MPC8360e
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <AndreasGlatz@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Thu, 2009-09-24 at 09:39 -0400, Andreas Glatz wrote:
> Hi,
> 
> Currently, we are trying to register for IRQ1-7 
> of our MPC8360e.
> 
> We found that we have to do the following steps to 
> get interrupts working:
> 
> 1) irq_of_parse_and_map(): To get and map the hardware interrupt
> 2) request_irq(): Installs a dummy handler
> 3) rt_intr_create(): Installs the real ISR
> 
> The application is running in user-space. 1) and 2) are 
> called from and ioctl(). 3) is called directly from the 
> user-space Xenomai application.
> 
> Is request_irq() required? IMHO it shouldn't be, right?
> 

Correct. rt_intr_enable() is required after rt_intr_create() to unmask
the interrupt line (see @note from the rt_intr_create() doc). This is
what request_irq() implicitly does by calling the startup() handler from
the relevant IRQ chip controller.

> Andreas
> 
> 
> Xenomai: 2.4.9
> Ipipe: 2.7
> Kernel: 2.6.30
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



