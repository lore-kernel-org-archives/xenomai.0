MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Nov 2012 09:54:57 +0100
From: WONG Sheng Chao <wong@isir.upmc.fr>
In-Reply-To: <6F62EBB3-71FC-47B6-B6A4-9A2A7EFE793B@kabelmail.de>
References: <mailman.0.1354186801.18650.xenomai@xenomai.org>
	<6F62EBB3-71FC-47B6-B6A4-9A2A7EFE793B@kabelmail.de>
Message-ID: <bf6a998422f24fab874ae21fd0adb396@isir.upmc.fr>
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
To: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: xenomai@xenomai.org

On Thu, 29 Nov 2012 13:16:31 +0100, Stephan Kappertz wrote:
>>
>> Von: WONG Sheng Chao <wong@isir.upmc.fr>
>> Betreff: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone 
>> from Angstrom branch
>> Datum: 28. November 2012 21:22:41 MEZ
>> An: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> Kopie: xenomai@xenomai.org
>>
>>
>> On Wed, 28 Nov 2012 20:55:24 +0100, Gilles Chanteperdrix wrote:
>>> On 11/28/2012 08:34 PM, WONG Sheng Chao wrote:
>>>
>>>> On Wed, 28 Nov 2012 19:57:50 +0100, Gilles Chanteperdrix wrote:
>>>>> On 11/28/2012 07:49 PM, WONG Sheng Chao wrote:
>>>>>
>>>>>> On Wed, 28 Nov 2012 19:14:41 +0100, Gilles Chanteperdrix wrote:
>>>>>>> On 11/28/2012 06:40 PM, WONG Sheng Chao wrote:
>>>>>>>> On Wed, 28 Nov 2012 16:12:58 +0100, WONG Sheng Chao wrote:
>>>>>>>>> On Tue, 27 Nov 2012 19:00:30 +0100, Gilles Chanteperdrix 
>>>>>>>>> wrote:
>>>>>>>>>> On 11/27/2012 05:40 PM, WONG Sheng Chao wrote:
>>>>>>>>>>> Hi Gilles
>>>>>>>>>>>
>>>>>>>>>>> Following your advice i tracked down the include files 
>>>>>>>>>>> which
>>>>>>>>>>> need
>>>>>>>>>>> to be
>>>>>>>>>>> included to remove the error. The kernel now compiles 
>>>>>>>>>>> without
>>>>>>>>>>> errors. I
>>>>>>>>>>> followed the instructions in
>>>>>>>>>>>
>>>>>>>>>>> 
>>>>>>>>>>> http://www.xenomai.org/pipermail/xenomai/2012-July/000481.html
>>>>>>>>>>>
>>>>>>>>>>> to change the timer.c and also changing the .handle_irq 
>>>>>>>>>>> with
>>>>>>>>>>> ipipe_handle_multi_irq
>>>>>>>>>>>
>>>>>>>>>>> From the serial terminal i noticed that with CONFIG_IPIPE = 
>>>>>>>>>>> ON
>>>>>>>>>>> the
>>>>>>>>>>> timer is used correctly as in the above post but it hangs 
>>>>>>>>>>> at
>>>>>>>>>>
>>>>>>>>>> Are you sure the timer is running correctly
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Any advice on how to proceed to debug this problem? I 
>>>>>>>>>>> attach
>>>>>>>>>>> the
>>>>>>>>>>> config files of two cases for your reference.
>>>>>>>>>>
>>>>>>>>>> I would put a printk in linux timer irq handler.
>>>>>>>>>
>>>>>>>>> How should i come about debugging the timer irq handler?
>>>>>>>>
>>>>>>>> Refering to this,
>>>>>>>>
>>>>>>>> http://www.xenomai.org/pipermail/xenomai/2012-May/025838.html
>>>>>>>>
>>>>>>>> I believe that i should be put a printk in the function
>>>>>>>> ipipe_mach_acktimer, as it is called when the linux timer
>>>>>>>> interrupt,
>>>>>>>> but
>>>>>>>> I after checking in these files, i still couldn't find it.
>>>>>>>
>>>>>>> ipipe_mach_acktimer disappeared, it is in the pre I-pipe core
>>>>>>> patches.
>>>>>>> The documentation for the I-pipe core patches on the ARM
>>>>>>> architecture
>>>>>>> is
>>>>>>> here:
>>>>>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
>>>>>>>
>>>>>>> The linux timer interrupt handler given as example in this
>>>>>>> documentation
>>>>>>> is "omap2_gp_timer_interrupt" function, and is probably the 
>>>>>>> same
>>>>>>> for
>>>>>>> your omap3 derivative.
>>>>>>
>>>>>> Thanks for the information. So to proceed i looked at the 
>>>>>> function
>>>>>>
>>>>>> static irqreturn_t omap2_gp_timer_interrupt(int irq, void 
>>>>>> *dev_id)
>>>>>> {
>>>>>> 	struct clock_event_device *evt = &clockevent_gpt;
>>>>>>
>>>>>> 	if (!clockevent_ipipe_stolen(evt))
>>>>>> 		omap2_gp_timer_ack();
>>>>>>
>>>>>> 	if (num_online_cpus() == 1)
>>>>>> 		__ipipe_tsc_update();
>>>>>>
>>>>>> 	evt->event_handler(evt);
>>>>>> 	return IRQ_HANDLED;
>>>>>> }
>>>>>>
>>>>>> when clockevent_ipipe_stolen == 0
>>>>>> the omap2_gp_timer_ack is called to acknowledge the linux timer
>>>>>> interrupt (with CONFIG_XENOMAI = no)
>>>>>>
>>>>>> I put a printk in omap2_gp_timer_ack and i notice that in both 
>>>>>> cases
>>>>>> of
>>>>>> CONFIG_IPIPE = yes and CONFIG_IPIPE = no
>>>>>>
>>>>>> the omap2_gp_timer_ack function get called.
>>>>>>
>>>>>> But i am not sure how to interrupt this. I guess this means that 
>>>>>> the
>>>>>> timer interrupt is being handled. But it still does not tell me 
>>>>>> why
>>>>>> the
>>>>>> kernel does not boot properly when CONFIG_IPIPE = yes.
>>>>>
>>>>>
>>>>> Put a static counter in the timer_ack function to only emit a 
>>>>> printk
>>>>> every HZ ticks, and check whether the timer is ticking when you 
>>>>> get
>>>>> the
>>>>> freeze in the at24c driver initialization.
>>>>
>>>> Yes the timer is still ticking after the freeze in the at24c 
>>>> driver
>>>> initialization. Does this means that  the ipipe_handle_multi_irq 
>>>> in
>>>> omap_intc_handle_irq is not handling the multiple irq properly?
>>>
>>>
>>> No. It simply means the problem is not the timer. Next usual 
>>> suspect is
>>> the clocksource. Did you get the message about clocksource 
>>> switching to
>>> ipipe_tsc and does ipipe_tsc_get return increasing values?
>>
>> Yes the clock source did change to tsc in the boot message, I will 
>> take a look at the return value of I pipe_tsc_get.
>>
>>
>
> The problem is that you are using the wrong timer.
>
> You should have
>
> OMAP clockevent source: GPTIMER2 at 24000000 Hz
> OMAP clocksource: GPTIMER1 at 24000000 Hz
>
> in the startup console output for both the kernel with IPIPE disabled
> and with IPIPE enabled.
>
> Thus in arch/arm/mach-omap2/timer.c you need to change the timer
> definitions accordingly.
>
> What I did was:
>
> #define OMAP2_MPU_SOURCE	"sys_ck"
> #define OMAP3_MPU_SOURCE	OMAP2_MPU_SOURCE
> #define OMAP4_MPU_SOURCE	"sys_clkin_ck"
> #define OMAP2_32K_SOURCE	"func_32k_ck"
> #define OMAP3_32K_SOURCE	"omap_32k_fck"
> #define OMAP4_32K_SOURCE	"sys_32k_ck"
> #define AM33XX_CLKEV_SOURCE OMAP4_MPU_SOURCE
> #define AM33XX_RTC32K_SOURCE	"clk_32768_ck"
>
> #ifdef CONFIG_OMAP_32K_TIMER
> #define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
> #define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
> #define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
> #define AM33XX_MPU_SOURCE	AM33XX_RTC32K_SOURCE
> #define OMAP3_SECURE_TIMER	12
> #else
> #define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
> #define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
> #define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
> #define AM33XX_MPU_SOURCE	OMAP4_MPU_SOURCE
> #define OMAP3_SECURE_TIMER	1
> #endif
> ...
> ...
> ...
> #ifdef CONFIG_ARCH_OMAP3
>
> #ifndef CONFIG_SOC_OMAPAM33XX
>
> #ifndef CONFIG_IPIPE
> OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
> #else
> OMAP_SYS_TIMER_INIT(3, 2, OMAP3_CLKEV_SOURCE, 3, OMAP3_MPU_SOURCE)
> #endif
> OMAP_SYS_TIMER(3)
> OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
> 			2, OMAP3_MPU_SOURCE)
> OMAP_SYS_TIMER(3_secure)
>
> #else // #ifdef CONFIG_SOC_OMAPAM33XX
>
> OMAP_SYS_TIMER_INIT(3, 2, AM33XX_CLKEV_SOURCE, 1, AM33XX_MPU_SOURCE)
> OMAP_SYS_TIMER(3)
>
> #endif
>
> #endif
>
> - Stephan

Thanks a lot Stephan and Gilles! The kernel is now able to boot with 
both CONFIG_XENOMAI and CONFIG_IPIPE.




