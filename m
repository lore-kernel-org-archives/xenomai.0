Message-ID: <521D1E9F.9090808@xenomai.org>
Date: Tue, 27 Aug 2013 23:48:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5215C4FE.707@inmess.de> <521871FD.30705@web.de>
	<521C8A19.3080102@xenomai.org> <521CB022.3080703@inmess.de>
In-Reply-To: <521CB022.3080703@inmess.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] two dd processes: soft lockup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Benedikt Boeck <benedikt.boeck@inmess.de>
Cc: Jan Kiszka <jan.kiszka@web.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/27/2013 03:56 PM, Benedikt Boeck wrote:
> On 08/27/2013 01:14 PM, Gilles Chanteperdrix wrote:
>> On 08/27/2013 12:47 PM, Benedikt Boeck wrote:
>>> On 08/24/2013 10:42 AM, Jan Kiszka wrote:
>>>> On 2013-08-22 09:59, Benedikt Boeck wrote:
>>>>> Hello,
>>>>>
>>>>> I got a problem. After starting two dd processes (if=/dev/zero
>>>>> of=/dev/null), I get first a few messages about soft lockup:
>>>>> kernel:[...] BUG: soft lockup - CPU#. stuck for ..s! [dd:...]
>>>>> and little later a
>>>>> Kernel panic - not syncing: Fatal exception in interrupt
>>>>>
>>>>> But if I had running xeno-test before and then starting two dd processes
>>>>> I don't get a soft lockup. Strange?
>>>>>
>>>>> Also there is no soft lockup with a kernel identical till a deactivated
>>>>> CONFIG_XENOMAI.
>>>>> A deactivated CONFIG_SMP also prevent the error. But I like to have both
>>>>> cores. Trying all four variants of CONFIG_SCHED_SMT=y/n and
>>>>> CONFIG_SCHED_MC=y/n didn't effect the error.
>>>>>
>>>>> Tested with different kernel versions (3.4.6, 3.5.7, 3.8) always with
>>>>> matching ipipe patch.  I think with 3.8 I didn't get a kernel panic but
>>>>> still soft lockups.
>>>>> Using Xenomai 2.6.2.1 and haven't tried other versions yet. The
>>>>> processor is a Celeron Dual-Core T3100.
>>>>>
>>>>> Does somebody have a idea? Maybe I just made a simple (but effective)
>>>>> mistake.
>>>> I've tried your configuration on ipipe-3.8 [1] but wasn't able to
>>>> reproduced it in a 2-cpu VM with 2 dd instances. Could you provide the
>>>> 3.8 config as well that generates the warnings for you? And please
>>>> provide the information Gilles asked for,
>>>>
>>>> Thanks,
>>>> Jan
>>>>
>>>> [1] http://git.xenomai.org/?p=ipipe.git;a=shortlog;h=refs/heads/ipipe-3.8
>>>>
>>>>
>>> Thanks for your replys
>>>
>>> Tested a 3.8 kernel again. I'm using
>>> http://download.gna.org/adeos/patches/v3.x/x86/ipipe-core-3.8-x86-1.patch as
>>> patch. Now I'm know for sure the dd processes generate soft lockups but
>>> no kernel panic occurs (running two hours). Attached todays 3.8 config.
>>>
>>> In my VM (VirtualBox) I can't produce the error either. But the host has
>>> a different CPU (Core 2 Quad Q6600, reduced numbers of cores for guest).
>>> Unfortunately I haven't got another System for testing here.
>>>
>>> Tested yesterday the 3.5.7 config with disabled CONFIG_NO_HZ: got the
>>> same behavior.
>>> Attached content of /proc/xenomai/timer and /proc/timer_list before
>>> starting dd or xeno-test (enabled NO_HZ). If needed i can also provide
>>> the content after calling xeno-test.
>> Yes please, the contents of the kernel boot logs would help too, as well
>> as /proc/interrupts before and after xeno-test.
>>
>> You have the HPET timer in broadcast mode, but the LAPIC timers are
>> started, now it would be interesting to know whether they ticked, cat
>> /proc/interrupts will tell us that.
>>
> 
> For the purpose  to get related output, I got also the timer and 
> timer_list new. Here are the boot log, interrupts (after/before), timer 
> (after/before), timer_list (after/before)

Please try the following patch:

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index b60af5d..dacb305 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2204,7 +2204,7 @@ static unsigned int startup_ioapic_irq(struct irq_data *data)
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
 	if (irq < legacy_pic->nr_legacy_irqs) {
-		legacy_pic->mask(irq);
+		mask_legacy_irq(irq);
 		if (legacy_pic->irq_pending(irq))
 			was_pending = 1;
 	}




-- 
                                                                Gilles.

