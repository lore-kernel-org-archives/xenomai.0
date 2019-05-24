Subject: Re: SAMA5D2 Xplained kernel panic
References: <cca1a283-5dae-8c91-568d-3abf641fbfdc@rsi-elektrotechnik.de>
 <d8f665fd-d9f5-19ee-ea81-eafd59a8f5cd@xenomai.org>
 <e840b709-8801-846b-2e5d-fbc082dfa6b1@rsi-elektrotechnik.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2963de7d-72c0-c524-e29d-bba1e2b69d94@xenomai.org>
Date: Fri, 24 May 2019 16:13:44 +0200
MIME-Version: 1.0
In-Reply-To: <e840b709-8801-846b-2e5d-fbc082dfa6b1@rsi-elektrotechnik.de>
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

On 5/24/19 1:42 PM, Jan Leupold via Xenomai wrote:
> Am 22.05.19 um 18:44 schrieb Philippe Gerum:
>> On 5/20/19 12:27 PM, Jan Leupold via Xenomai wrote:
>>> Hi all,
>>>
>>> I am trying to boot Linux on a SAMA5D2 Xplained board with
>>> * Kernel ipipe-arm branch stable/4.14.96-arm
>>>   (HEAD plus my modifications)
>>> * Xenomai-3 on tag v3.0.8
>>> * following instructions on
>>> https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_Xenomai_To_A_New_Arm_Soc
>>>
>>> On most kernel boots I get a kernel panic. Can anyone point me in the right
>>> direction where to look for my bugs? I added code for
>>> * the hardware timer (tcb_clksrc.c)
>>> * the high resolution counter (tcb_clksrc.c)
>>> * GPIOs as interrupt sources (pinctrl-at91-pio4.c)
>>> * checked interrupt controller (irq-atmel-aic5.c)
>>> * added "select IPIPE_ARM_KUSER_TSC" for SOC_SAMA5D2
>>>
>>> I have no idea if there is only one problem (causing all the other
>>> warnings), or if these are separate problems, that can be handeled
>>> independently.
>>>
>>
>> The first warning means that IRQs are enabled in the CPU when reaching a
>> portion of code where it should definitely not be so. This code path
>> starts from the actual receipt of an interrupt by the kernel from
>> __ipipe_grab_irq(), which indirectly calls atmel_gpio_irq_handler() for
>> decoding the cascaded interrupt number. Once decoded, this IRQ is set
>> pending in the pipeline log.
>>
>> There is no reason for this particular code path to re-enable interrupts
>> in the CPU, and doing so is actually harmful. Inferring anything beyond
>> this point is pretty much useless until this is fixed. Preventing this
>> from happening would likely be a significant step forward.
> 
> Fine, got this fixed, at least the warnings do not appear any more. Thanks!
> 
> Now it seems I still have some issues, as the kernel comes to a complete
> stop when trying to access the root filesystem. Both, NFS or SD-card
> access.
> As the kernel messages always stop after a certain time stamp value, which
> is about 4.3 seconds, my best theory is that my tsc and/or timer code is
> still not OK. When I change the frequency or mask values, these 4.3 seconds
> change. Maybe my system does not detect a wrap of the tsc counter value and
> simply stops scheduling kernel tasks?
> Any ideas? (CONFIG_IPIPE=y, CONFIG_XENOMAI is not set)
> 

TSC emulation won't come into play until CONFIG_XENOMAI is enabled,
timer is most likely at fault. You may want to check whether you still
receive timer IRQs (__ipipe_grab_irq()). If you don't, then you need to
check the timer IRQ handler feeding the clockevent framework.

-- 
Philippe.

