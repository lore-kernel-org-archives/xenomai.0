Message-ID: <54243D1E.9090904@axelsw.it>
Date: Thu, 25 Sep 2014 18:04:46 +0200
From: Marco Tessore <marco.tessore@axelsw.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Problems triggering a nested interrupt to a user space
	process
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Good morning,
I'd like to manage, from user-space, the reaction to interrupts on GPIO 
pins, on a board based on processor Freescale iMX28.
I have Linux 3.11 and Xenomai 2.6.3.

In no way I can see reactions interrupt, nor from user space, where I 
call rt_intr_create, rt_intr_enable, rt_intr_wait,
nor from kernel space by attaching a handler with the rtdm_irq_request.

The interrupt type is "nested", as each bank acts as a collector for all 
gpio pin may receive interrupt.

Referring to the pin I'm using for my tests,
I have a kernel module with which I can inform userspace about the irq 
number assigned by Linux,
both as regards the controller pin (interrupt 93),
that with regard to the interrupt of the single specific pin (interrupt 98).

I did a little debugging at the kernel level and I saw that, when I take 
the interrupt,
1) is invoked __ipipe_grab_irq (irq = 93)
2) is invoked after the linux gpio interrupt handler, manifold 
(mxs_gpio_irq_handler in gpio-mxs.c)
3) Thi handler invokes the generic_handle_irq for irq 98
4) Take again the __ipipe_grab_irq for interrupt 98.
5) Nothing happens at this point.

At this point I thought that if I had engaged in user-space or 
kernel-space to interrupt 98 or 93, I could see some reaction,
unfortunately I can not see any further reaction.

Would you have any suggestions about what to look for to get the desired 
effect?

Thank you in advance
Kind regards
Marco Tessore


