Date: Mon, 23 Mar 2015 23:09:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150323220935.GA19836@hermes.click-hack.org>
References: <CAJT0owGYuZ8L47AKM0FdjOw5x3g0cjXcXAFPaL91TaxMun6WBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJT0owGYuZ8L47AKM0FdjOw5x3g0cjXcXAFPaL91TaxMun6WBw@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai 3.0-rc3 Interruption on Arietta G25
 (AT91SAM9G25 chip)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tianchi Huang <gz.eddie.htc@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Mar 23, 2015 at 12:07:43PM +0100, Tianchi Huang wrote:
> *Hello,*
> 
> *I'm now working on project using Arietta G25 board (AT91SAM9G25 chip) on
> which i need to capture 1000 interruptions per second of an external ADC. *
> *I have patched the kernel 3.14.17 with the patch ipipe-core-3.14.17-arm-5
> which i found on GNA. The compilation passed and Xenomai seems to run all
> right. The latency test gave me about 100us as worst value. *
> 
> *I make un modele of interruption test as below*
> #include <linux/fs.h>
> #include <linux/fcntl.h>
> #include <linux/gpio.h>
> #include <linux/interrupt.h>
> #include <linux/module.h>
> #include <rtdm/driver.h>
> 
> #define GPIO_IN  27
> static rtdm_irq_t irq_rtdm;
> static int handler_interruption(rtdm_irq_t * irq){
> printk(KERN_ALERT "IRQ received!\n");
> return RTDM_IRQ_HANDLED;
> }
> 
> static int __init exemple_init (void){
> int err;
> int num_interruption;
> if ((err = gpio_request(GPIO_IN, "test_irq")) != 0) {
> return err;
> }
> if ((err = gpio_direction_input(GPIO_IN)) != 0) {
> gpio_free(GPIO_IN);
> return err;
> }
> numero_interruption = gpio_to_irq(GPIO_IN);
> irq_set_irq_type(numero_interruption, IRQF_TRIGGER_FALLING);
> if ((err = rtdm_irq_request(& irq_rtdm, num_interruption,
> handler_interruption, RTDM_IRQTYPE_EDGE, "test_irq", NULL)) != 0) {
> gpio_free(GPIO_IN);
> return err;
> }
> printk(KERN_ALERT "Driver registed\n");
> rtdm_irq_enable(& irq_rtdm);
> return 0;
> }
> 
> static void __exit exemple_exit (void){
> rtdm_irq_disable(& irq_rtdm);
> rtdm_irq_free(&irq_rtdm);
> gpio_free(GPIO_IN);
> }
> module_init(exemple_init);
> module_exit(exemple_exit);
> MODULE_LICENSE("GPL");
> 
> 
> *It seems that it has been registed and run without no error, as you can
> see just here:*
> root@arietta:/home# cat /proc/xenomai/irq
>   IRQ         CPU0
>    17:           1         [timer/0]
>    28:           0         test_irq
>  1027:           0         [virtual]
> root@arietta:/home# cat /proc/interrupts
>            CPU0
>  16:      31031       AIC   1  at91_tick, at91_rtc, ttyS0
>  18:       1579       AIC  20  at_hdmac
>  19:          0       AIC  21  at_hdmac
>  23:      15338       AIC  12  f0008000.mmc
>  25:          0       AIC  14  f0004000.spi
>  26:      20732       AIC  23  atmel_usba_udc
>  27:       8119       AIC  22  ehci_hcd:usb1, ohci_hcd:usb2
>  28:          1      GPIO  27
> Err:          0
> 
> *But, when i generate a signal on GPIO 27, i can see the counter of
> /proc/interrupts increase but not the counter of /proc/xenomai/irq nor the
> message i put in the interrupt handler, as you can see below:*
> 
> root@arietta:/home# cat /proc/xenomai/irq
>   IRQ         CPU0
>    17:           1         [timer/0]
>    28:           0         test_irq
>  1027:           0         [virtual]
> root@arietta:/home# cat /proc/interrupts
>            CPU0
>  16:      31031       AIC   1  at91_tick, at91_rtc, ttyS0
>  18:       1579       AIC  20  at_hdmac
>  19:          0       AIC  21  at_hdmac
>  23:      15338       AIC  12  f0008000.mmc
>  25:          0       AIC  14  f0004000.spi
>  26:      20732       AIC  23  atmel_usba_udc
>  27:       8119       AIC  22  ehci_hcd:usb1, ohci_hcd:usb2
>  28:       5459      GPIO  27
> Err:          0
> 
> *Do you have any idea of that? I've tried Xenomai 2.6.4 too, but i had the
> same problem. Hope you can help me with this.*

Have you tried calling both rtdm_irq_request and request_irq in the
same driver ?

-- 
					    Gilles.

