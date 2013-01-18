From: Paul <paul_c@tuxcnc.org>
Date: Fri, 18 Jan 2013 22:11:26 +0000
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
In-Reply-To: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201301182211.27006.paul_c@tuxcnc.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Pierre LE COZ <peter.le.coz@gmail.com>

On Friday 18 January 2013, Pierre LE COZ wrote:
> I have simple program to manage the GPIO of my raspberry Pi using
> RTDM.
>
> I use :
> "rtdm_irq_request(& irq_exemple, num_irq, exemple_handler,
> RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE, "MyProgram", NULL);"
> in order to detect interrupts.

rtdm_irq_request does not explicitly enable the interrupts on a gpio pin 
with ian_cim's patch - This could probably be done, but I don't have 
the time for it. In the meantime, in kernel space, use the following 
calls in conjunction with rtdm_irq_request:

        // To enable an interrupt.
        gpio_request_one(gpio_pin, GPIOF_DIR_IN, "module name");
        irq_number = gpio_to_irq(gpio_pin);
        irq_set_irq_type(irq_number,  IRQF_TRIGGER_RISING);
        enable_irq(irq_number);


        // To disable an interrupt and clean up.
        disable_irq(irq_number);
        free_irq(irq_number, NULL);
        gpio_free(gpio_pin);

In user space, I'd suggest looking at the source code for Mike 
McCauley's bcm2835 library <http://www.open.com.au/mikem/bcm2835/>

> After repeated presses on a pushbutton linking my input GPIO to 3,3v,
> I run
>
> # cat /proc/xenomai/irq
> IRQ CPU0
> 3: 1134 [timer]
> 108: 0 MyProgram
> 259: 0 [virtual]
>
> No interrupt is taken into account.

As Gilles has already pointed out, you are missing a call to 
ipipe_handle_demuxed_irq() - See attached patch.


Regards, Paul.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: bcm2708_gpio.diff
Type: text/x-diff
Size: 605 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130118/331ef7d4/attachment.diff>
