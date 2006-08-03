From: Bart Jonkers <jonkersbart@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Thu, 03 Aug 2006 16:30:59 +0200
Message-Id: <1154615459.9835.62.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] testing interrupt latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hey,

I have written a small module to test the interrupt response time of
Xenomai to compare it with the time of Linux.

I generate an interrupt on a GPIO pin and toggles another GPIO pin in
the interrupt service routine. (code below)
The time between the generated interrupt and the value change on the
GPIO pin is taken as interrupt response time.

Everything works well, but I notice a strange behavior.
I thought that the interrupt response time of xenomai should be (as good
as) constant all the time. But I see that this is not the case.

Did I do something wrong in my code or did I made a wrong assumption?


Thanks, Bart



#include <linux/init.h>
#include <linux/module.h>

#include <asm/arch/pxa-regs.h>
#include <asm/arch/xsilo.h>

#include <native/intr.h>
#include <native/timer.h>

MODULE_LICENSE("Dual BSD/GPL");

RT_INTR intr_desc_but;

static int xsilo_irq_measure_irq_handler_but(struct xnintr *intr)
{
	/* Make GPIO pin low */
	GPCR(XSILO_JOYSTICK_UP_GPIO) |= GPIO_bit(XSILO_JOYSTICK_UP_GPIO);
	/* Wait 50µs */
	rt_timer_spin(50000);
	/* Make GPIO pin high */
	GPSR(XSILO_JOYSTICK_UP_GPIO) |= GPIO_bit(XSILO_JOYSTICK_UP_GPIO);
	return RT_INTR_HANDLED;
}

static int __init xsilo_irq_measure_init(void)
{
	int retval;
	/* initialize output GPIO pin */
	GPSR(XSILO_JOYSTICK_UP_GPIO) |= GPIO_bit(XSILO_JOYSTICK_UP_GPIO);
	GPDR(XSILO_JOYSTICK_UP_GPIO) |= GPIO_bit(XSILO_JOYSTICK_UP_GPIO);
	
	/* initialize interrupt and the receiving GPIO pin */
	retval = rt_intr_create(&intr_desc_but,"RT_measure_irq_but",
XSILO_MENU_IRQ,xsilo_irq_measure_irq_handler_but,NULL,I_EDGE);
	if (!retval){
		GPDR(XSILO_MENU_GPIO) |= GPIO_bit(XSILO_MENU_GPIO);
		set_irq_type(XSILO_MENU_IRQ, IRQT_RISING);
		rt_intr_enable(&intr_desc_but);
	}
	return 0;
}

static void __exit xsilo_irq_measure_exit(void)
{
	rt_intr_delete(&intr_desc_but);
}

module_init(xsilo_irq_measure_init);
module_exit(xsilo_irq_measure_exit);



