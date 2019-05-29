Subject: Re: SAMA5D2 Xplained kernel panic
References: <cca1a283-5dae-8c91-568d-3abf641fbfdc@rsi-elektrotechnik.de>
 <d8f665fd-d9f5-19ee-ea81-eafd59a8f5cd@xenomai.org>
 <e840b709-8801-846b-2e5d-fbc082dfa6b1@rsi-elektrotechnik.de>
 <2963de7d-72c0-c524-e29d-bba1e2b69d94@xenomai.org>
From: Jan Leupold <leupold@rsi-elektrotechnik.de>
Message-ID: <9db33088-e0e7-c627-3be8-6ae26d292c6e@rsi-elektrotechnik.de>
Date: Wed, 29 May 2019 14:58:13 +0200
MIME-Version: 1.0
In-Reply-To: <2963de7d-72c0-c524-e29d-bba1e2b69d94@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

Thanks again for your help: the board is booting now with CONFIG_IPIPE and
CONFIG_XENOMAI !

But ... I still have two issues.
BTW: the kernel is now based on ipipe-core-4.19.33-arm-2

1.

When starting latency (or switchtest) with CONFIG_STACKPROTECTOR_STRONG
set, then I get the following output:

[   35.146000] Kernel panic - not syncing: stack-protector: Kernel stack is
corrupted in: __schedule+0x658/0x660
[   35.146000]
[   35.146000] CPU: 0 PID: 1108 Comm: latency Not tainted 4.19.33 #254
[   35.146000] Hardware name: Atmel SAMA5
[   35.146000] I-pipe domain: Xenomai
[   35.146000] [<c011024c>] (unwind_backtrace) from [<c010d150>]
(show_stack+0x20/0x24)
[   35.146000] [<c010d150>] (show_stack) from [<c06779e4>]
(dump_stack+0x24/0x28)
[   35.146000] [<c06779e4>] (dump_stack) from [<c011cb44>] (panic+0xec/0x26c)
[   35.146000] [<c011cb44>] (panic) from [<c011c824>] (print_tainted+0x0/0xa8)
[   35.146000] ---[ end Kernel panic - not syncing: stack-protector: Kernel
stack is corrupted in: __schedule+0x658/0x660
[   35.146000]  ]---

Without the strong stack protector latency/switchtest just work fine.
Is this something I should be worried/take care about?

2.

The pinctrl driver seems to work, but not with level-triggered interrupts
(in this case also chained).
The interrupt source in my case is an active_low line from the PHY, and the
PHY will raise the line level only after reading one of its registers. When
ipipe_handle_demuxed_irq() is called, only the interrupt log is updated,
but the interrupt is never masked nor the PHY register is read. This leads
to an endless storm of interrupt handler calls (and the system appears to
be dead).
My simple workaround was to change from level to edge triggered. Another
quick fix was to mask the interrupt next to where
ipipe_handle_demuxed_irq() was called, but now the interrupts are never
unmasked ... (so this is not a solution).
Is there any good advice/example driver how to deal with level-triggered
interrupts in a chained interrupt handler?

Regards,
Jan

Am 24.05.19 um 16:13 schrieb Philippe Gerum:
> On 5/24/19 1:42 PM, Jan Leupold via Xenomai wrote:
>> Am 22.05.19 um 18:44 schrieb Philippe Gerum:
>>> On 5/20/19 12:27 PM, Jan Leupold via Xenomai wrote:
>>>> Hi all,
>>>>
>>>> I am trying to boot Linux on a SAMA5D2 Xplained board with
>>>> * Kernel ipipe-arm branch stable/4.14.96-arm
>>>>   (HEAD plus my modifications)
>>>> * Xenomai-3 on tag v3.0.8
>>>> * following instructions on
>>>> https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_Xenomai_To_A_New_Arm_Soc
>>>>
>>>> On most kernel boots I get a kernel panic. Can anyone point me in the right
>>>> direction where to look for my bugs? I added code for
>>>> * the hardware timer (tcb_clksrc.c)
>>>> * the high resolution counter (tcb_clksrc.c)
>>>> * GPIOs as interrupt sources (pinctrl-at91-pio4.c)
>>>> * checked interrupt controller (irq-atmel-aic5.c)
>>>> * added "select IPIPE_ARM_KUSER_TSC" for SOC_SAMA5D2
>>>>
>>>> I have no idea if there is only one problem (causing all the other
>>>> warnings), or if these are separate problems, that can be handeled
>>>> independently.
>>>>
>>>
>>> The first warning means that IRQs are enabled in the CPU when reaching a
>>> portion of code where it should definitely not be so. This code path
>>> starts from the actual receipt of an interrupt by the kernel from
>>> __ipipe_grab_irq(), which indirectly calls atmel_gpio_irq_handler() for
>>> decoding the cascaded interrupt number. Once decoded, this IRQ is set
>>> pending in the pipeline log.
>>>
>>> There is no reason for this particular code path to re-enable interrupts
>>> in the CPU, and doing so is actually harmful. Inferring anything beyond
>>> this point is pretty much useless until this is fixed. Preventing this
>>> from happening would likely be a significant step forward.
>>
>> Fine, got this fixed, at least the warnings do not appear any more. Thanks!
>>
>> Now it seems I still have some issues, as the kernel comes to a complete
>> stop when trying to access the root filesystem. Both, NFS or SD-card
>> access.
>> As the kernel messages always stop after a certain time stamp value, which
>> is about 4.3 seconds, my best theory is that my tsc and/or timer code is
>> still not OK. When I change the frequency or mask values, these 4.3 seconds
>> change. Maybe my system does not detect a wrap of the tsc counter value and
>> simply stops scheduling kernel tasks?
>> Any ideas? (CONFIG_IPIPE=y, CONFIG_XENOMAI is not set)
>>
> 
> TSC emulation won't come into play until CONFIG_XENOMAI is enabled,
> timer is most likely at fault. You may want to check whether you still
> receive timer IRQs (__ipipe_grab_irq()). If you don't, then you need to
> check the timer IRQ handler feeding the clockevent framework.
> 


-- 
_____________________________________________________________
R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
Fon: +49 8444 9204-0
Fax: +49 8444 9204-50
www.rsi-elektrotechnik.de

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548


