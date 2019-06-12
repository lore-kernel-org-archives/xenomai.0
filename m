Subject: Re: linux not getting gpio interrupts on xenomai 3.0.8 on raspberrypi
 raspbian/stretch kernel 4.9
References: <4707bb12-658a-f74c-84b6-332424be2bb9@cs.ru.nl>
From: Harco Kuppens <h.kuppens@cs.ru.nl>
Message-ID: <844c96f4-191f-dd82-8a02-d3a99ac74fef@cs.ru.nl>
Date: Wed, 12 Jun 2019 23:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <4707bb12-658a-f74c-84b6-332424be2bb9@cs.ru.nl>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: nl
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


I put the raspberry pi image with xenomai2 I build for the raspberry pi 
2 and 3, also supporting the latest raspberry pi3b+ online at:

   http://www.cs.ru.nl/lab/xenomai/raspberrypi.html

I'm still wondering what the reason is that I don't receive the gpio 
interrupts in linux. Unfortunately nobody could answer my questions so 
far. If somebody knows the problem, then I will fix the image.

Except for this linux gpio interrupt problem the above image seems to 
work of for realtime xenomai gpio interrupts.

Best regards,
Harco Kuppens

Op 07/06/2019 om 12:34 schreef Harco Kuppens via Xenomai:
> Hi,
>
> In juli 2017 I managed to port xenomai 3.0.5 to rasbpian jessie on the 
> rpi3b. See https://xenomai.org/pipermail/xenomai/2017-July/037515.html
>
> But this image doesn't boot on the new raspberrypi 3b+ board. So I had 
> to build a new image. I succeeded to build this image. The 
> instructions are at:
>
> https://github.com/harcokuppens/xenomai3_rpi_gpio/blob/master/install/install_xenomai-3.0.8_on_rpi2_3_3B%2B.txt
>
>
> Xenomai and handling gpio interrupts in realtime work fine on this 
> image, however somehow handling gpio interrupts in linux don't work 
> anymore. I have several test scripts using the wiringpi library within 
> linux. Writing and reading gpio pins works fine, but somehow we don't 
> get any interrupts.
>
> Even if do not load the xeno_gpio_bcm2835 module, then xenomai doesn't 
> use the gpio pins, but still then in linux with wiringpi examples we 
> don't get any gpio interrupts.
>
> However if I boot the standard raspbian image with the standard 
> raspbian kernel which does not support xenomai/cobalt then the 
> wiringpi examples work fine, and we get the gpio interrupts.
>
> In my older image from juli 2017 both in a realtime xenomai program or 
> in a wiringpi linux program I received interrupts. (when run 
> separately at different times, so they cannot influence each other; so 
> they are not sharing interrupts!)
>
> So I wonder why do the interrupts only work in xenomai realtime, and 
> not in linux anymore?
>
> Or is there something maybe changed because we now use
>
>  * newer kernel version 4.9 instead of 4.1
>  * xenomai 3.08 instead of xenomai 3.05
>
> I would expect that it just should work, they are different points at 
> the pipeline, and either of them is only watching for interrupt it 
> should just get it. So instead maybe I did  do something wrong when 
> patching the rpi 4.9 kernel during the installation?
>
> Patching was not so easy because the raspbian os on the raspberry pi 
> comes with a customized kernel specificly tuned for the raspberry pi 
> hardware. I call this the rpi kernel. This kernel is little bit 
> different then the standard kernel from kernel.org. I call this the 
> kernel.org kernel.
>
> The ipipe patches for the kernel are made for the kernel.org kernels. 
> However I managed pretty easily to patch the rpi 4.9 kernel with the 
> the ipipe patch for the kernel.org 4.9 kernel.
> Except for the file pinctrl-bcm2835.c which is the driver for gpio 
> interrupts. In my installation patching this file for the rpi 4.9 
> kernel was difficult, but I thought I finally succeeded.
>
> However because the problem with linux not getting any interrupts I 
> wonder if something still went wrong there.
>
> So if I look at the ipipe-patched version of the pinctrl-bcm2835.c for 
> my older image using the rpi 4.1 kernel and my ipiped-patch for this 
> file for rpi-4.9 kernel I am building the image now I find some 
> differences between the files.
> The files you can find at:
>
>  * 
> https://raw.githubusercontent.com/harcokuppens/xenomai3_rpi_gpio/master/install/how_pinctrl-bcm2835_patch_for_rpi-4.9_is_derived/rpi-4.1.y.ipipe-patched/pinctrl-bcm2835.c
>  * 
> https://raw.githubusercontent.com/harcokuppens/xenomai3_rpi_gpio/master/install/how_pinctrl-bcm2835_patch_for_rpi-4.9_is_derived/rpi-4.9.y.ipipe-patched/pinctrl-bcm2835.c
>
> I found the following changes from the 4.1 to the 4.9 version:
> a) spin_lock_init/spin_lock_irqsave/spin_unlock_irqrestore are 
> replaced with
> raw_spin_lock_init/raw_spin_lock_irqsave/raw_spin_unlock_irqrestore calls
> b) in bcm2835_gpio_irq_enable function we have an extra call
>     ipipe_unlock_irq(data->irq) before calling raw_spin_unlock_irqrestore
> c) in bcm2835_gpio_irq_disable we have an extra call ipipe_lock_irq 
> before
>     calling raw_spin_unlock_irqrestore
> d) in static struct irq_chip bcm2835_gpio_irq_chip we defined extra
>    functions for hold and release
> e) in bcm2835_pinctrl_probe the call
>
>         err = devm_request_irq(dev, 
> pc->irq[i],bcm2835_gpio_irq_handler, IRQF_SHARED,name, &pc->irq_data[i]);
>
>    is replaced with
>
>         if (IS_ENABLED(CONFIG_IPIPE)) {
>                     irq_set_chained_handler(pc->irq[i], 
> gpio_irq_cascade);
>                     irq_set_handler_data(pc->irq[i], &pc->irq_data[i]);
>         } else {
>             err = devm_request_irq(dev, 
> pc->irq[i],bcm2835_gpio_irq_handler, IRQF_SHARED,name, &pc->irq_data[i]);
>             ..
>         }
>
>   where we have added an extra function
>
>          static void gpio_irq_cascade(unsigned int irq, struct 
> irq_desc *desc)
>          {
>          #ifdef CONFIG_IPIPE
>              bcm2835_gpio_irq_handler(irq, irq_get_handler_data(irq));
>          #endif
>          }
>
> If I look at e) then because I build the kernel with CONFIG_IPIPE then 
> basicly
>
>           err = devm_request_irq(dev, 
> pc->irq[i],bcm2835_gpio_irq_handler, IRQF_SHARED,name, &pc->irq_data[i]);
>
> is replaced with the two calls:
>
>           irq_set_chained_handler(pc->irq[i], gpio_irq_cascade);
>           irq_set_handler_data(pc->irq[i], &pc->irq_data[i]);
>
> with extra function
>
>             static void gpio_irq_cascade(unsigned int irq, struct 
> irq_desc *desc)
>             {
>                 bcm2835_gpio_irq_handler(irq, irq_get_handler_data(irq));
>             }
>
> Looking at this immediately I notice the  IRQF_SHARED flag.
> I found at https://notes.shichao.io/lkd/ch7/
>
>     IRQF_SHARED. This flag specifies that the interrupt line can be 
> shared
>     among multiple interrupt handlers. Each handler registered on a
>     given line must specify this flag; otherwise, only one handler can
>     exist per line.
>
>
> So as I can see IRQF_SHARED is only used on the 4.1 version in
> devm_request_irq, but it is unclear if it is used for the 4.9 version.
>
> But if I look at a newer kernel  at 
> https://github.com/raspberrypi/linux/blob/rpi-4.14.y/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> then irq_set_chained_handler+irq_set_handler_data is replaced with
>
> gpiochip_set_chained_irqchip(&pc->gpio_chip,&bcm2835_gpio_irq_chip,pc->irq[i],bcm2835_gpio_irq_handler);
>
>
> and the ipipe-core-4.14.110-arm-7.patch  seems to leave it like this.
>
> Is any that maybe somehow the cause of the problem?
>
> Or has it do with the changes in a) b) c) or d) ?
>
> So at the end this has become a very long email.
> Hopefully somebody can help me answering these questions.
>
> Best regards,
> Harco Kuppens
>


