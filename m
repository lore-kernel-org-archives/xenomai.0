Message-ID: <4FABFE02.6080509@domain.hid>
Date: Thu, 10 May 2012 19:42:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <479588872.145094722.1336670966752.JavaMail.root@domain.hid>
In-Reply-To: <479588872.145094722.1336670966752.JavaMail.root@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: aubin.rebillat@domain.hid
Cc: xenomai@xenomai.org

On 05/10/2012 07:29 PM, aubin.rebillat@domain.hid wrote:
>> Also, from the sources I could gather (snakeos-sdk), the hardware
>> timer
>> for str8100 is programmed in periodic, auto-reload mode. Obviously,
>> when
>> CONFIG_IPIPE is on, you have to change this to make the timer run in
>> one-shot mode, as required by Xenomai.
> 
> I did not know that it was required, i thought it was handy not to reprogram 
> the timer each time.

That is likely your problem. You can not assume that a decreasing
counter is all of a sudden a free-running counter with match register.
You have to find the processor datasheet and look at how its registers
must be programmed to run in one-shot mode, if at all possible.

Note that since linux 2.6.24, linux itself switched to one-shot mode,
because it allows high resolution software timers.

>>> #ifdef CONFIG_IPIPE
>>> void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
>>> {
>>>   // No cascaded interrupt using the VIC
>>> }
>>> #endif /* CONFIG_IPIPE */
>>
>> You probably do not need to define this function if you #define
>> ipipe_mach_irq_mux_p to always be 0.
>>
> 
> I do, to avoid an undefined reference.

If you #define ipipe_mach_irq_mux_p(irq) 0

The compilers optimizes away the function call, and there is no
undefined reference. At least with current compilers.

> 
> Nevertheless, thank you very much for all this.
> 
> When i developped the IPIPE code for this board i followed the
> HOWTO but it's quite vague so I mostly read what has been done 
> with other boards and what has been done with linux for this board 
> to implement it.

This HOWTO assumes that you understand what you are doing. No HOWTO
guide is a substitute for that unfortunately.

> Therefore, I'm clearly not aware of the interactions between Linux 
> and Xenomai. I will definitely read the publications available on 
> the Xenomai website.

Well, it is not all that complicated. When xenomai wants to program the
timer it calls ipipe_mach_set_dec, and when a timer interrupt happens,
ipipe_mach_acktimer is called, whether the timer is handled by Linux, or
it has been taken over by Xenomai.

-- 
					    Gilles.

