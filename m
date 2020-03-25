Subject: Re: RT thread seems blocked
References: <bb4f7cd9487f411daa1f5d948761aa65@boschrexroth.nl>
 <b2a97400-db79-c156-2775-d2b67ea7ccf7@siemens.com>
 <e5b86e2706e6490fa1ceb591c9f8a9a1@boschrexroth.nl>
 <e5d0bf30-640b-2bc8-a257-00c2a5ef8637@siemens.com>
 <c85c4aeb88144795a588b4d8af1818f8@boschrexroth.nl>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c25377b7-5f6b-bef7-e3f6-7a8c23bde600@siemens.com>
Date: Wed, 25 Mar 2020 09:06:22 +0100
MIME-Version: 1.0
In-Reply-To: <c85c4aeb88144795a588b4d8af1818f8@boschrexroth.nl>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bradley Valdenebro Peter (DC-AE/ESW52)" <Peter.BradleyValdenebro@boschrexroth.nl>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 25.03.20 08:59, Bradley Valdenebro Peter (DC-AE/ESW52) wrote:
> Hello,
> 
> Thanks for your support Jan.
> 
> We have already tried with ftrace and we couldn't reproduce the issue. We think because the introduced overhead. We usually record the following events:
> 
> 	sudo trace-cmd start -e ipi -e irq -e rcu -e workqueue_execute_end -e workqueue_execute_start -e mm_page_alloc -e mm_page_free
> 			-e sched_migrate_task -e sched_switch -e cobalt_irq_exit -e cobalt_irq_entry -e cobalt_thread_migrate -e cobalt_switch_context
> 			-e cobalt_head_sysexit -e cobalt_clock_entry -e cobalt_clock_exit
> 
> Would changing to trace-cmd record -e "cobalt*" -e sched -e signal make a difference?

If you already have troubles reproducing with your reduced event set, 
this won't be easier with the extended cobalt events. I would rather try 
to reduce the set further, maybe leaving out rcu, syscalls, allocations 
and maybe even interrupts.

> 
> We have also tried using the ipipe tracer but there we also had no luck. We didn't use xntrace_user_freeze() but we monitored the trace IRQs-off times in /proc.
> Using xntrace_user_freeze() might be worth a try.

If you can reproduce under enabled ipipe trace, then this makes sense.

Jan

> 
> Best regards,
> 
> Peter Bradley
> ​
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 24 March 2020 12:53
> To: Bradley Valdenebro Peter (DC-AE/ESW52) <Peter.BradleyValdenebro@boschrexroth.nl>; xenomai@xenomai.org
> Subject: Re: RT thread seems blocked
> 
> On 24.03.20 12:43, Bradley Valdenebro Peter (DC-AE/ESW52) wrote:
>> Hello,
>>
>> We run some tests during the weekend and although we have less occurrences we still indeed see them.
>>
>> One interesting thing we see besides the 1ms stalling is that sometimes we see over 100us between IRQ and ISR start.
>> At this point we do not know how to proceed further. Any help or suggestion is greatly appreciated.
>>
> 
> That is usually where you should start to look into tracing. Option A is event-level tracing via standard ftrace. Use
> 
> trace-cmd record -e "cobalt*" -e sched -e signal
> 
> to record such a trace. Ideally instrument the point where the latency is off in your application via xnftrace_printf() (will leave a mark in that recorded trace). Check via "trace-cmd report" if the schedule around that peak is what you would expect.
> 
> For digging even deeper, down to function level:
> https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Using_The_I_Pipe_Tracer,
> specifically look into xntrace_user_freeze(), calling that from your application when you spot an excessive latency to stop the trace.
> 
> If the result is not clear to you, share it to get a community inspection.
> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Center Embedded Linux
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

