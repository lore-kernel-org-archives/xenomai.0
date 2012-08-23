Message-ID: <5035E4CD.9080302@xenomai.org>
Date: Thu, 23 Aug 2012 10:07:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50350308.8010405@openwide.fr> <50350712.4020704@xenomai.org>
In-Reply-To: <50350712.4020704@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 08/22/2012 06:21 PM, Gilles Chanteperdrix wrote:
> On 08/22/2012 06:04 PM, Romain Naour wrote:
>> Hello,
>>
>> On s3c24xx processors the interrupt source priority isn't fixed by Adeos 
>> patch (ARB_SEL bits in PRIORITY register).
>> Is it intentional ?
>> It may be possible to give priority to an interrupt simultaneously 
>> arrived that the interruption IRQ_TIMER4 (before being grabbed by 
>> Adeos). Therefore, we can have more jitter for real time applications.
> 
> This can always happen even with interrupt priorities: imagine that the
> first interrupt happens 1 microsecond before the timer interrupt, even
> with the priority, the handler for first interrupt will be executed and
> the timer interrupt will have to wait for the end of this handler before
> it is serviced.
> 
>>
>> Do we need to fix the priority at this level ?
> 
> I do not think so. However, what can be done is implement interrupt
> controller muting using the priority register, see:
> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#Priority_based_interrupt_controller_muting

Other things which could be done for s3c24xx are:
- convert the timers to clocksource/clockevent: since this platform is
the only one not to use clocksource/clockevent, we have to keep code
around for this case in xenomai-forge which could be removed. Having two
different timers for clocksource and clockevent would allow to avoid the
tsc emulation based on the decrementer, which I am not sure is really
reliable since the conversion to CONFIG_IPIPE_ARM_KUSER_TSC.
- failing that, check that the tsc emulation based on the decrementer
really works, and maybe fix it if it does not work. Or simply use a
different hardware timer for tsc emulation than for the timer.

-- 
					    Gilles.

