From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1268865353.2396.0.camel@domain.hid>
References: <1268865353.2396.0.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Mar 2010 21:56:54 +0100
Message-ID: <1268945814.27899.397.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gpio-keys with xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: peter.breuer@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2010-03-17 at 23:35 +0100, Peter Breuer wrote:
> Hello everyone,
> I am new to xenomai, so please be patient.
> I am working with an AT91SAM9621S (Board SBC6000X) and I successfully
> patched my linux 2.6.24 with xenomai 2.4.9.1. I also have a signal on on
> of the GPIOs and I want a program to react, every time the signal
> arrives (~10Hz).
> Before compiling I added some lines to the board description file
> (arch/arm/mach-at91/board-sbc9621.c):
> ...
> static struct gpio_keys_button sbc9261_buttons[] = {
> ...
> //begin changes
>     {
>         .gpio        = AT91_PIN_PC4,
>         .code        = BTN_2,
>         .desc        = "GPIO 1",
>         .active_low    = 1,
>     },
> //end changes
> };
> ...
> static void __init sbc9261_add_device_buttons(void)
> {
> ...
> //begin changes
>     at91_set_gpio_input(AT91_PIN_PC4, 1);    /* btn1 */
>     at91_set_deglitch(AT91_PIN_PC4, 1);
> //end changes
> 
>     platform_device_register(&sbc9261_button_device);
> }
> 
> Now a new event showed up in /dev/input/
> Without the xenomai patch there was an interrupt, that I could listen to
> with a program (open(/dev/input/event2) and select for listening) and
> react to the signal.
> With the xenomai patch nothing is coming trough, and even though GPIO 1
> still shows up in /proc/interrupts, it doesnt show up
> in /proc/xenomai/irq.
> I tried to use the native API (I used the usr_irq.c) to create and wait
> for the signal, but nothin happend (rt_intr_wait() returned -1).
> I would be very happy about every hint in the right direction.

rt_intr_wait() should be called from a real-time task, obtained from
rt_task_create/spawn; failure to do so causes the Xenomai core to
dismiss your request with -EPERM.

There is a simple rule of thumb to know whether a Xenomai syscall shall
be called from a real-time task: if a Xenomai service may block the
caller, or has an effect on some of its dynamic properties (like its
real-time scheduling priority, some of its runtime options or current
execution mode within the Xenomai domain etc.), then it may only be
called on behalf of a real-time task.

Additionally, you should call rt_intr_enable() to explicitly unmask the
interrupt channel, since it is left masked upon creation. Maybe that is
what is missing (user_irq.c is wrong in this respect) to get the first
IRQ.

> greetings,
> Peter 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



