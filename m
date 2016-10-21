References: <CAPUhiY0pnnBEiHzUcMcxymTWxKx48AYkLi8F=_jxE-z0W7bB5w@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b66e0569-f524-4d0c-7cdb-d1eea131f7af@xenomai.org>
Date: Fri, 21 Oct 2016 12:35:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAPUhiY0pnnBEiHzUcMcxymTWxKx48AYkLi8F=_jxE-z0W7bB5w@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting Xenomai on Odroid XU4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ugo Fabrizi <ugo.fabrizi0@gmail.com>, xenomai@xenomai.org

On 10/09/2016 03:49 PM, Ugo Fabrizi wrote:
> Hi,
> 
> I am trying to port Xenomai on Odroid XU4 following the steps I have found
> at https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/
> 
> I have never done a porting but I was used to use hard real time operating
> systems such as RTAI.
> 
> I have got stuck at the first step "Hardware timer" for the general.
> 
> I have found the code within the sources of the Odroid XU4 kernel at
> https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y/
> arch/arm/mach-exynos/mach-smdk5422.c
> 
> and at https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y/
> arch/arm/plat-samsung/samsung-time.c
> 
> Can anyone help me?
> 
> The board supports the clock event infrastucture and to start I would like
> to use shared timers between linux and xenomai. Following the guide the
> first thing I have understood it is needed to do is to add
> if (!clockevent_ipipe_stolen(evt))
>          acklowdege_the_irq_if_not_stolen
> 
> in the interrupt service routine "static irqreturn_t
> samsung_clock_event_isr(int irq, void *dev_id)"
> What low level register should I write to acknowledge the irq and with what?
> 
> I have tried to found the datasheet of the Exynos 5422 but I cannot find it.
> 
> Can anyone help me please?

The proper acknowledge code usually precedes the call to the clock event
handler in the original IRQ handler, that is the point of testing
clockevent_ipipe_stolen(evt), i.e. for skipping it in the regular IRQ
handler, because it has to run earlier from the I-pipe timer ack routine.

-- 
Philippe.

