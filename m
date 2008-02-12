Message-ID: <47B1633F.3090400@domain.hid>
Date: Tue, 12 Feb 2008 10:13:35 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376B33@domain.hid>
	<47B14FF9.8010207@domain.hid>
In-Reply-To: <47B14FF9.8010207@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] pit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Steven Seeger wrote:
>> I compiled the kernel for 586 and am running the PIT timer. I still get
>> the 17000-18000 context switches per second, and now the irq0 handler is
>> taking up 11% of the CPU instead of only 5% when the two 8000Hz tasks
>> are loaded but delayed on events. I think that the problem isn't with
>> pit, but with the tasks being periodic even though they are blocked. 
> 
> That makes sense: Periodic timers keep on firing. That would explain up
> to 16000 IRQ invocations per second. And the other 1000-2000 come from
> Linux?
> 
> As suggested earlier: you can reduce the number of IRQ events by basing
> your periodic tasks on the same start date. Then both will be woken up
> at the same times and their priority will decide about the execution order.
> 
>>
>> Running in PIT mode with periodic timing on uses only 9.5% of the CPU. I
>> show about 9000 context switches per second. (the 2 8000 hz tasks and
>> the 1000 hz linux interrupt.)
> 
> Do you need Linux at 1 KHz? You may even want to try NO_HZ.
> 
>>
>> With periodic timing, it's 5.4% when the tasks idle and about 9000
>> context switches a second. When one of them becomes active, the irq0
>> handler is using 10% of the CPU and the sound task is using about 8%.
>> These are two kernel tasks.
>>
>>  
>>
>> Userspace stack size is set to 64k. I forgot to mention this to Philippe
>> earlier.
>>
>>  
>>
>> Perhaps the problem is the overhead that the timer handler introduces
>> being able to support multiple skins with individual timebases. It
>> sounds like in order to save some cpu cycles, I may want to turn off
>> periodicity while threads are idle and also avoid setting threads
>> periodic when they can be driven some other way. 
> 
> I'm still wondering with what older numbers you compare all the nice
> stats you now generate. Neither older Xenomai nor RTAI provide
> comparable statistics. Are we doing fair comparisons here?
>

No, because RTAI charges interrupt load to the preempted task context.


-- 
Philippe.

