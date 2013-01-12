Message-ID: <50F19EFA.9070203@xenomai.org>
Date: Sat, 12 Jan 2013 18:35:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50EFC153.8030406@web.de> <50EFC336.3000509@web.de>
In-Reply-To: <50EFC336.3000509@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] x86/ipipe: restore warning with AMD erratum
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 01/11/2013 08:45 AM, Jan Kiszka wrote:

> On 2013-01-11 08:37, Jan Kiszka wrote:
>>> From acc3c57390d275a1b28d66f1ec88c85e0f8c0890 Mon Sep 17 00:00:00 2001
>>> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>> Date: Sat, 29 Dec 2012 17:48:20 +0100
>>> Subject: [PATCH] x86/ipipe: restore warning with AMD erratum
>>>
>>> ---
>>>  arch/x86/kernel/apic/apic.c |   16 ++++++++++------
>>>  1 files changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
>>> index 7f07610..91531bb 100644
>>> --- a/arch/x86/kernel/apic/apic.c
>>> +++ b/arch/x86/kernel/apic/apic.c
>>> @@ -545,14 +545,18 @@ static void __cpuinit setup_APIC_timer(void)
>>>  	memcpy(levt, &lapic_clockevent, sizeof(*levt));
>>>  	levt->cpumask = cpumask_of(smp_processor_id());
>>>  #ifdef CONFIG_IPIPE
>>> -	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY))
>>> +	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY)
>>> +	    && !cpu_has_amd_erratum(amd_erratum_400))
>>>  		levt->ipipe_timer = &__get_cpu_var(lapic_itimer);
>>>  	else {
>>> -	       printk(KERN_INFO
>>> -		      "I-pipe: cannot use LAPIC as a tick device\n");
>>> -	       if (cpu_has_amd_erratum(amd_erratum_400))
>>> -		       printk(KERN_INFO
>>> -			      "I-pipe: disable C1E power state in your BIOS\n");
>>> +		static atomic_t printed = ATOMIC_INIT(-1);
>>> +		printk(KERN_INFO
>>> +		       "I-pipe: cannot use LAPIC on cpu #%d as a tick device\n",
>>> +		       smp_processor_id());
>>> +		if (cpu_has_amd_erratum(amd_erratum_400)
>>> +		    && atomic_inc_and_test(&printed))
>>> +			printk(KERN_INFO
>>> +			       "I-pipe: disable C1E power state in your BIOS\n");
>>
>> printk_once should do the trick as well.
> 
> In fact, it should actually do what you likely intended: print on first
> occurrence, not on second or later. ;)


Not quite, printk_once is not protected from the code running
concurrently on multiple cpus. So, atomic_inc_and_test is better, except
the ATOMIC_INIT needs to be set to 0.

> 
> Jan
> 



-- 
                                                                Gilles.

