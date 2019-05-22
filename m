Subject: Re: SAMA5D2 Xplained kernel panic
References: <cca1a283-5dae-8c91-568d-3abf641fbfdc@rsi-elektrotechnik.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d8f665fd-d9f5-19ee-ea81-eafd59a8f5cd@xenomai.org>
Date: Wed, 22 May 2019 18:44:13 +0200
MIME-Version: 1.0
In-Reply-To: <cca1a283-5dae-8c91-568d-3abf641fbfdc@rsi-elektrotechnik.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Leupold <leupold@rsi-elektrotechnik.de>, xenomai@xenomai.org

On 5/20/19 12:27 PM, Jan Leupold via Xenomai wrote:
> Hi all,
> 
> I am trying to boot Linux on a SAMA5D2 Xplained board with
> * Kernel ipipe-arm branch stable/4.14.96-arm
>   (HEAD plus my modifications)
> * Xenomai-3 on tag v3.0.8
> * following instructions on
> https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_Xenomai_To_A_New_Arm_Soc
> 
> On most kernel boots I get a kernel panic. Can anyone point me in the right
> direction where to look for my bugs? I added code for
> * the hardware timer (tcb_clksrc.c)
> * the high resolution counter (tcb_clksrc.c)
> * GPIOs as interrupt sources (pinctrl-at91-pio4.c)
> * checked interrupt controller (irq-atmel-aic5.c)
> * added "select IPIPE_ARM_KUSER_TSC" for SOC_SAMA5D2
> 
> I have no idea if there is only one problem (causing all the other
> warnings), or if these are separate problems, that can be handeled
> independently.
> 

The first warning means that IRQs are enabled in the CPU when reaching a
portion of code where it should definitely not be so. This code path
starts from the actual receipt of an interrupt by the kernel from
__ipipe_grab_irq(), which indirectly calls atmel_gpio_irq_handler() for
decoding the cascaded interrupt number. Once decoded, this IRQ is set
pending in the pipeline log.

There is no reason for this particular code path to re-enable interrupts
in the CPU, and doing so is actually harmful. Inferring anything beyond
this point is pretty much useless until this is fixed. Preventing this
from happening would likely be a significant step forward.

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/ipipe/core.c:624
> __ipipe_set_irq_pending+0xf8/0x110
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.96+ #46
> Hardware name: Atmel SAMA5
> I-pipe domain: Linux
> [<c010f900>] (unwind_backtrace) from [<c010c7d0>] (show_stack+0x20/0x24)
> [<c010c7d0>] (show_stack) from [<c07cea90>] (dump_stack+0x24/0x28)
> [<c07cea90>] (dump_stack) from [<c011ba30>] (__warn+0xec/0x110)
> [<c011ba30>] (__warn) from [<c011bb24>] (warn_slowpath_null+0x30/0x38)
> [<c011bb24>] (warn_slowpath_null) from [<c018452c>]
> (__ipipe_set_irq_pending+0xf8/0x110)
> [<c018452c>] (__ipipe_set_irq_pending) from [<c0185e7c>]
> (__ipipe_dispatch_irq+0xac/0x218)
> [<c0185e7c>] (__ipipe_dispatch_irq) from [<c03d894c>]
> (atmel_gpio_irq_handler+0x100/0x18c)
> [<c03d894c>] (atmel_gpio_irq_handler) from [<c0185f30>]
> (__ipipe_dispatch_irq+0x160/0x218)
> [<c0185f30>] (__ipipe_dispatch_irq) from [<c010128c>]
> (__ipipe_grab_irq+0x44/0xac)
> [<c010128c>] (__ipipe_grab_irq) from [<c01017e8>] (aic5_handle+0xa0/0xe4)


-- 
Philippe.

