MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Nov 2012 20:34:42 +0100
From: WONG Sheng Chao <wong@isir.upmc.fr>
In-Reply-To: <50B65EAE.8080902@xenomai.org>
References: <04934a1da80b9542fe5e0375b07d3663@isir.upmc.fr>
	<50AF48DA.9010200@xenomai.org>
	<80c97c7c58b1c913fd0fb2ec83a86b3d@isir.upmc.fr>
	<50AFA44E.4070506@xenomai.org>
	<b5d8fc2c77444a0bf20a3446d6a7edd0@isir.upmc.fr>
	<50AFB64E.4030702@xenomai.org>
	<b6df56ed969c01a5916ff3efc3ce4c87@isir.upmc.fr>
	<50B4FFBE.20204@xenomai.org>
	<db62a2cc790904728c13fca4beffd559@isir.upmc.fr>
	<8230f5b2d86c368c49f1ce75ce93d097@isir.upmc.fr>
	<50B65491.60005@xenomai.org>
	<4e8167f1cebe6c6e79543a573c2ea773@isir.upmc.fr>
	<50B65EAE.8080902@xenomai.org>
Message-ID: <e2fc1139f60bc3e194a28bbd3d5fd6b3@isir.upmc.fr>
Subject: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone from
 Angstrom branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 28 Nov 2012 19:57:50 +0100, Gilles Chanteperdrix wrote:
> On 11/28/2012 07:49 PM, WONG Sheng Chao wrote:
>
>> On Wed, 28 Nov 2012 19:14:41 +0100, Gilles Chanteperdrix wrote:
>>> On 11/28/2012 06:40 PM, WONG Sheng Chao wrote:
>>>> On Wed, 28 Nov 2012 16:12:58 +0100, WONG Sheng Chao wrote:
>>>>> On Tue, 27 Nov 2012 19:00:30 +0100, Gilles Chanteperdrix wrote:
>>>>>> On 11/27/2012 05:40 PM, WONG Sheng Chao wrote:
>>>>>>> Hi Gilles
>>>>>>>
>>>>>>> Following your advice i tracked down the include files which 
>>>>>>> need
>>>>>>> to be
>>>>>>> included to remove the error. The kernel now compiles without
>>>>>>> errors. I
>>>>>>> followed the instructions in
>>>>>>>
>>>>>>> http://www.xenomai.org/pipermail/xenomai/2012-July/000481.html
>>>>>>>
>>>>>>> to change the timer.c and also changing the .handle_irq with
>>>>>>> ipipe_handle_multi_irq
>>>>>>>
>>>>>>>  From the serial terminal i noticed that with CONFIG_IPIPE = ON
>>>>>>> the
>>>>>>> timer is used correctly as in the above post but it hangs at
>>>>>>
>>>>>> Are you sure the timer is running correctly?
>>>>>>
>>>>>>
>>>>>>> Any advice on how to proceed to debug this problem? I attach 
>>>>>>> the
>>>>>>> config files of two cases for your reference.
>>>>>>
>>>>>> I would put a printk in linux timer irq handler.
>>>>>
>>>>> How should i come about debugging the timer irq handler?
>>>>
>>>> Refering to this,
>>>>
>>>> http://www.xenomai.org/pipermail/xenomai/2012-May/025838.html
>>>>
>>>> I believe that i should be put a printk in the function
>>>> ipipe_mach_acktimer, as it is called when the linux timer 
>>>> interrupt,
>>>> but
>>>> I after checking in these files, i still couldn't find it.
>>>
>>> ipipe_mach_acktimer disappeared, it is in the pre I-pipe core
>>> patches.
>>> The documentation for the I-pipe core patches on the ARM 
>>> architecture
>>> is
>>> here:
>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
>>>
>>> The linux timer interrupt handler given as example in this
>>> documentation
>>> is "omap2_gp_timer_interrupt" function, and is probably the same 
>>> for
>>> your omap3 derivative.
>>
>> Thanks for the information. So to proceed i looked at the function
>>
>> static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
>> {
>> 	struct clock_event_device *evt = &clockevent_gpt;
>>
>> 	if (!clockevent_ipipe_stolen(evt))
>> 		omap2_gp_timer_ack();
>>
>> 	if (num_online_cpus() == 1)
>> 		__ipipe_tsc_update();
>>
>> 	evt->event_handler(evt);
>> 	return IRQ_HANDLED;
>> }
>>
>> when clockevent_ipipe_stolen == 0
>> the omap2_gp_timer_ack is called to acknowledge the linux timer
>> interrupt (with CONFIG_XENOMAI = no)
>>
>> I put a printk in omap2_gp_timer_ack and i notice that in both cases 
>> of
>> CONFIG_IPIPE = yes and CONFIG_IPIPE = no
>>
>> the omap2_gp_timer_ack function get called.
>>
>> But i am not sure how to interrupt this. I guess this means that the
>> timer interrupt is being handled. But it still does not tell me why 
>> the
>> kernel does not boot properly when CONFIG_IPIPE = yes.
>
>
> Put a static counter in the timer_ack function to only emit a printk
> every HZ ticks, and check whether the timer is ticking when you get 
> the
> freeze in the at24c driver initialization.

Yes the timer is still ticking after the freeze in the at24c driver 
initialization. Does this means that  the ipipe_handle_multi_irq in 
omap_intc_handle_irq is not handling the multiple irq properly?



