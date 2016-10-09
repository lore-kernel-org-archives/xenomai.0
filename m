MIME-Version: 1.0
From: Ugo Fabrizi <ugo.fabrizi0@gmail.com>
Date: Sun, 9 Oct 2016 15:49:09 +0200
Message-ID: <CAPUhiY0pnnBEiHzUcMcxymTWxKx48AYkLi8F=_jxE-z0W7bB5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Porting Xenomai on Odroid XU4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am trying to port Xenomai on Odroid XU4 following the steps I have found
at https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/

I have never done a porting but I was used to use hard real time operating
systems such as RTAI.

I have got stuck at the first step "Hardware timer" for the general.

I have found the code within the sources of the Odroid XU4 kernel at
https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y/
arch/arm/mach-exynos/mach-smdk5422.c

and at https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y/
arch/arm/plat-samsung/samsung-time.c

Can anyone help me?

The board supports the clock event infrastucture and to start I would like
to use shared timers between linux and xenomai. Following the guide the
first thing I have understood it is needed to do is to add
if (!clockevent_ipipe_stolen(evt))
         acklowdege_the_irq_if_not_stolen

in the interrupt service routine "static irqreturn_t
samsung_clock_event_isr(int irq, void *dev_id)"
What low level register should I write to acknowledge the irq and with what?

I have tried to found the datasheet of the Exynos 5422 but I cannot find it.

Can anyone help me please?

Thanks in advance.

Best Regards
Ugo Fabrizi
