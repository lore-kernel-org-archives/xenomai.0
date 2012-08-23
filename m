Message-ID: <503641EA.2020201@xenomai.org>
Date: Thu, 23 Aug 2012 16:44:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50350308.8010405@openwide.fr> <50350712.4020704@xenomai.org>
	<5035E4CD.9080302@xenomai.org> <50364114.9090804@openwide.fr>
In-Reply-To: <50364114.9090804@openwide.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] s3c24xx: Priority rotate enable !?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 08/23/2012 04:41 PM, Romain Naour wrote:
> Le 23/08/2012 10:07, Gilles Chanteperdrix a écrit :
>> On 08/22/2012 06:21 PM, Gilles Chanteperdrix wrote:
>>> On 08/22/2012 06:04 PM, Romain Naour wrote:
>>>> Hello,
>>>>
>>>> On s3c24xx processors the interrupt source priority isn't fixed by Adeos
>>>> patch (ARB_SEL bits in PRIORITY register).
>>>> Is it intentional ?
>>>> It may be possible to give priority to an interrupt simultaneously
>>>> arrived that the interruption IRQ_TIMER4 (before being grabbed by
>>>> Adeos). Therefore, we can have more jitter for real time applications.
>>> This can always happen even with interrupt priorities: imagine that the
>>> first interrupt happens 1 microsecond before the timer interrupt, even
>>> with the priority, the handler for first interrupt will be executed and
>>> the timer interrupt will have to wait for the end of this handler before
>>> it is serviced.
>>>
>>>> Do we need to fix the priority at this level ?
>>> I do not think so. However, what can be done is implement interrupt
>>> controller muting using the priority register, see:
>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#Priority_based_interrupt_controller_muting
> The priority register can't be used for implement interrupt controller 
> muting using this method .
> The PIC hardware can't be configured with only two priority levels.
> We are obligated to choose between fixed or "rotation fashion" priority 
> with 32 levels...

What prevents us from using the "fixed" priorities, with one level for
real-time interrupts and another for non real-time interrupts ?

> 
> However, we can try to implement interrupt controller muting using 
> bit-mask method.
> But, bits mask are scattered between 4 registers:
> 32 bits in INTMSK (IRQ 16 to 47)
> 20 bits in EINTMASK (IRQ 48 to 67)
> 2 bits in LCDINTMSK (IRQ 68 and 69)
> 15 bits in INTSUBMSK (IRQ 70 to 84)
> Fortunately there are only 69 interrupts.
> 
>> Other things which could be done for s3c24xx are:
>> - convert the timers to clocksource/clockevent: since this platform is
>> the only one not to use clocksource/clockevent, we have to keep code
>> around for this case in xenomai-forge which could be removed. Having two
>> different timers for clocksource and clockevent would allow to avoid the
>> tsc emulation based on the decrementer, which I am not sure is really
>> reliable since the conversion to CONFIG_IPIPE_ARM_KUSER_TSC.
>> - failing that, check that the tsc emulation based on the decrementer
>> really works, and maybe fix it if it does not work. Or simply use a
>> different hardware timer for tsc emulation than for the timer.
>>
> I used Xenomai 2.6.0 with kernel 2.6.38.8 on mini2440 board during my 
> internship.
> I haven't seen bug with tsc emulation.

To see if there is a bug, you should read the tsc, sleep for 30 minutes,
read the tsc again, and check if the difference corresponds to 30
minutes. Have you done that test?

> 
> Xenomai-forge will not work on s3c24xx since it needs 
> CONFIG_GENERIC_CLOCKEVENTS.

It currently works. But if someone could convert s3c24xx to clockevents,
we could remove the code allowing that.

-- 
					    Gilles.

