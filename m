From: Paul <paul_c@tuxcnc.org>
Date: Sun, 20 Jan 2013 00:13:09 +0000
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
	<201301191235.11402.paul_c@tuxcnc.org>
	<CALJOq=VS548FH3W_tWdmpW8kYu69ZaXM4WiYVQu1CTwep0VD3A@mail.gmail.com>
In-Reply-To: <CALJOq=VS548FH3W_tWdmpW8kYu69ZaXM4WiYVQu1CTwep0VD3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201301200013.09110.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre LE COZ <peter.le.coz@gmail.com>
Cc: xenomai@xenomai.org

On Saturday 19 January 2013, Pierre LE COZ wrote:
> > Add some debug messages in the areas you request resources and then
> > use dmesg - The most likely source of error is either attempting to
> > use a resource that has been claimed or not releasing when you have
> > finished with it.
>
> Here's my entire init :
>
> static int __init exemple_init (void)
> {
>         int err;
>
>         printk(KERN_INFO "Requesting GPIO %d\n",GPIO_IN);
>                 if((err = gpio_request_one(GPIO_IN, GPIOF_DIR_IN,
> THIS_MODULE->name)) !=0) {
>                 printk(KERN_INFO "error %d: could not request gpio:
> %d\n", err, GPIO_IN);
>                 return err;
>         }
>
>         printk(KERN_INFO "Setting the irq type to trigger rising\n");
>         irq_set_irq_type(BUTTON_IRQ,  IRQF_TRIGGER_RISING);
>
>
>         printk(KERN_INFO "Requesting irq %d\n", BUTTON_IRQ);
>         if((err = rtdm_irq_request(& irq_exemple, BUTTON_IRQ,
> exemple_handler, 0, THIS_MODULE->name,  NULL)) !=0) {
>                 printk(KERN_INFO "error %d: could not request irq:
> %d\n", err, GPIO_IN);
>                 gpio_free(GPIO_IN);
>                 return err;
>         }
>
>         printk(KERN_INFO "Enabling irq %d\n", BUTTON_IRQ);
>
>         // enable_irq(BUTTON_IRQ);
>         rtdm_irq_enable(& irq_exemple);
>         return 0;
> }

static int irq_func(rtdm_irq_t *arg) { /* Do stuff */ }
static rtdm_irq_t gpio_reset;

static int __init module_init(void)
{
        irq_number = gpio_to_irq(gpio_pin);
        if (gpio > 31 || irq_number < 0 || !gpio_is_valid(gpio))
                return -EINVAL;

        if (gpio_request_one(gpio_pin, GPIOF_DIR_IN, 
THIS_MODULE->name) != 0)
                return -EIO;

        if (rtdm_irq_request(&gpio_reset,irq_number, irq_func, 
RTDM_IRQTYPE_EDGE, "MODULE", NULL) ) {
                gpio_free(gpio_pin);
                return -EIO;
        }
        rtdm_irq_enable(&gpio_reset); // Should check return code.
        return 0;
}

Tested & works on my 3.2.27 kernel - Looks like I might have been 
getting mixed up with a similar module using the xeno-native API.

> The module is running well, but still no interrupt detected  :
> # insmod rpi-rtdm.ko
>  About the fact that interrupts are not detected :
>
> This may be a generic issue, which I thought was fixed, but may not
> be.
>
> > Could you try the following patch?
>
> http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=c14c79d29fed822675
>60c7bf26d628ef4d39f5b7

Gilles: Looked at the patch and got as far as the changes in 
kernel/ipipe/timer.c:ipipe_timer_stop() - Correct me if I'm wrong, but 
this patch is based on a 3.5.7 parent without GENERIC_CLOCKEVENTS ?


Regards, Paul.

