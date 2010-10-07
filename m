From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20101007115728.GA24500@domain.hid>
References: <20101007115728.GA24500@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Oct 2010 16:07:37 +0200
Message-ID: <1286460457.13186.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Pavel Machek <pma@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2010-10-07 at 13:57 +0200, Pavel Machek wrote:
> Hi!
> 
> I have... quite an interesting setup here.
> 
> SMP machine, with special PCI card; that card has GPIOs and serial
> ports. Unfortunately, there's only one interrupt, shared between
> serials and GPIO pins, and serials are way too complex to be handled
> by realtime layer.
> 

[snip]

> 
> Unregistration is:
>         my_context->ready = 0;
>         rtdm_irq_disable(&my_context->irq_handle);
> 
> 
> Unfortunately, when the userspace app is ran and killed repeatedly (so
> that interrupt is registered/unregistered all the time), I get
> oopses in __ipipe_dispatch_wired() -- it seems to call into the NULL
> pointer.

rtdm_irq_disable() will only mask the IRQ in the PIC, not unregister the
handler from the pipeline core. In case your handler is pulled out from
the kernel as part of a module, this may explain this behavior.
rtdm_irq_free() is something you likely look after.

> 
> I decided that "wired" interrupt when the source is shared between
> Linux and Xenomai, is wrong thing, so I disable "wired" interrupts
> altogether, but that only moved oops to __virq_end. 
> 

"wired" just means "deliver to topmost domain unconditionally", this is
a way to optimize the IRQ delivery path to the real-time handler,
without going through the entire domain propagation logic. As you
already found out, this is not related to registration issues.

> I'm using 2.6.27.21-ELinOS-46 with xenomai-2.4.7 . Problem does go
> away if I boot with maxcpus=1.
> 
> Any ideas? (Besides using non-historic kernel; but that's
> unfortunately not exactly easy here.)

The I-pipe code for x86 had a number of fixes since 2.6.27, including
rather serious ones. At the very least, I would recommend to check
whether this one is in your tree:
http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=80a79bb5b0e74d75fa4a511d7b9a08a015e37f46

This may decrease worst case latency in SMP quite significantly under
load.

> 
> 								Pavel
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



