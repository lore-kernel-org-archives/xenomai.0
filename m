References: <57B41CA5.5040103@allwinnertech.com>
 <a7e6b5c8-ba49-3b78-09a3-f8417ae4a0b9@xenomai.org>
 <458bb092-c690-e8e9-7d9b-a66969b4505f@xenomai.org>
 <57B67DAD.8060707@allwinnertech.com> <57B6FA48.4070609@allwinnertech.com>
 <3abb8d06-cf67-d90f-de3f-6e3d935d93d3@xenomai.org>
 <57BD7815.4090007@allwinnertech.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ca22a282-85ad-e601-ec7e-89263d924cae@xenomai.org>
Date: Wed, 24 Aug 2016 12:50:02 +0200
MIME-Version: 1.0
In-Reply-To: <57BD7815.4090007@allwinnertech.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai]
 =?utf-8?b?W+WPr+iDveaYr+Weg+WcvumCruS7tl0gUmU6ICBbaGVs?=
 =?utf-8?q?p=5D_porting_I-pipe_patch_on_linux-3=2E4_ARM=28cortex-a7=29_soc?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xielinfei <xielinfei@allwinnertech.com>, xenomai@xenomai.org

On 08/24/2016 12:33 PM, xielinfei wrote:
> Hi Philippe,
> 
>       Thank for your suggestion!
>       I downgraded ipipe-3.10.32 to linux-3.4.39 and it works,
>       However, I get some negative value, is this normal?

Yes, this is nothing bad. This is due to a mis-calibration of the core
timer. With Xenomai 2.x, check /proc/xenomai/latency, and decrease the
value there (writing a smaller count of nanosecs to
/proc/xenomai/latency) while the latency test is running, until the
values stay above zero.

You should do that on an idle system (beside the latency test of
course). A fine tuning may involve a bit more testing with moderate then
high load, but the one above will give you a sane setting. Negative
values mean early timer shots, so you may want to prevent them.

> --------------------------------------------------------------------------------------------
> 
> /usr/xenomai/bin # ./k /usr/xenomai/bin # ./klatency
> == Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> warming up...
> RTT|  00:00:00  (in-kernel periodic task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|      -8.459|      -8.290|      -2.918|       0| -8.459|      -2.918
> RTD|      -8.459|      -8.297|      -4.835|       0| -8.459|      -2.918
> RTD|      -8.418|      -8.247|      -0.335|       0| -8.459|      -0.335
> RTD|      -8.460|      -8.294|      -4.460|       0| -8.460|      -0.335
> RTD|      -8.460|      -8.198|      -2.002|       0| -8.460|      -0.335
> -----------------------------------------------------------------------------------------------
> 
> /usr/xenomai/bin # ./l /usr/xenomai/bin # ./latency [J
> == Sampling period: 1000 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
> best|--lat worst
> RTD|     -3.417|     -3.042|      3.041|       0|     0| -3.417|      3.041
> RTD|     -3.917|     -3.292|     19.624|       0|     0| -3.917|     19.624
> RTD|     -3.917|     -3.292|     18.541|       0|     0| -3.917|     19.624
> RTD|     -3.917|     -3.292|     17.541|       0|     0| -3.917|     19.624
> RTD|     -3.917|     -3.334|     12.124|       0|     0| -3.917|     19.624
> --------------------------------------------------------------------------------------------------
> 
> 
> On 2016年08月22日 02:27, Philippe Gerum wrote:
>> On 08/19/2016 02:23 PM, xielinfei wrote:
>>> Hi Philippe,
>>>
>>>
>>> test-3.4.6-patch: it is the official I-pipe patch
>>> ipipe-core-3.4.6-arm-4.patch
>>> <http://xenomai.org/downloads/ipipe/v3.x/arm/older/ipipe-core-3.4.6-arm-4.patch>
>>>
>>> test-3.4.v3s-patch: It is the vendor sdk with the modified I-pipe patch
>>> (mainly based on ipipe-core-3.4.6-arm-4.patch
>>> <http://xenomai.org/downloads/ipipe/v3.x/arm/older/ipipe-core-3.4.6-arm-4.patch>)
>>>
>>>
>>> The mainly differ as follow:
>>> --------------------------------------------------------------------------------------------------------------------------------------
>>>
>>> diff -r test-3.4.6-patch/arch/arm/kernel/entry-armv.S
>>> test-3.4.v3s-patch/arch/arm/kernel/entry-armv.S
>>> 269a270,282
>>>> __und_fault:
>>>>      @ Correct the PC such that it is pointing at the instruction
>>>>      @ which caused the fault.  If the faulting instruction was ARM
>>>>      @ the PC will be pointing at the next instruction, and have to
>>>>      @ subtract 4.  Otherwise, it is Thumb, and the PC will be
>>>>      @ pointing at the second half of the Thumb instruction.  We
>>>>      @ have to subtract 2.
>>>>      ldr    r2, [r0, #S_PC]
>>>>      sub    r2, r2, r1
>>>>      str    r2, [r0, #S_PC]
>>>>      b    do_undefinstr
>>>> ENDPROC(__und_fault)
>>>>
>>> 295c308
>>> < #ifndef    CONFIG_THUMB2_KERNEL
>>
>> Please always send unified diffs (diff -u) to express changes in source
>> code, this is easier to analyze than the antiquated original diff format.
>>
>> I don't see any hunks fixing up the architected timer to make it
>> pipeline-aware. Those changes should take place in
>> drivers/clocksource/arm_arch_timer.c. Some of them also allow a userland
>> code to read the MMIO registers taping into the clock source, this will
>> be required for running Xenomai apps.
>>
>> On a general note, I would not try to upgrade ipipe-3.4.6 for supporting
>> the architected timer, I would rather downgrade ipipe-3.18 to match your
>> 3.4.6 kernel. This way, the port would include all the post-3.4 fixes,
>> and the support for the arch timer as well.
>>
>> If you chose to do so, you only need to port the changes affecting the
>> devices provided by your SoC, ignoring any hunk which belong to other
>> ARM SoC/variants (e.g. timers, clock sources, irq chip controllers, gpio
>> modules etc).
>>
>> You could run splitdiff -a on the ipipe-3.18 patch, cherry-picking all
>> the needed changes.
>>
> 
> -- 
> 
> Best regards！
> —————————————————————
> 谢林菲
> 珠海全志科技股份有限公司     BU1-PSW
> 地址：广东省珠海市高新区唐家湾镇科技2路9号
> 邮编：519000
> TEL：15018321890
> 公司网址： http://www.allwinnertech.com
> 
> NOTICE: This e-mail and any included attachments are intended only for
> the sole use of named and intended recipient (s) only. If you are the
> named and intended recipient, please note that the information contained
> in this email and its embedded files are confidential and privileged. If
> you are neither the intended nor named recipient, you are hereby
> notified that any unauthorized review, use, disclosure, dissemination,
> distribution, or copying of this communication, or any of its contents,
> is strictly prohibited. Please reply to the sender and destroy the
> original message and all your records of this message (whether
> electronic or otherwise). Furthermore, you should not disclose to any
> other person, use, copy or disseminate the contents of this e-mail
> and/or the documents accompanying it.
> 


-- 
Philippe.

