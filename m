Subject: Re: some ftrace events are missed
References: <5e7d13d1-ee38-b1ee-3392-4bc19ff8cc4a@kylinos.cn>
 <9429d894-9879-8266-5c36-7c566de9bf00@siemens.com>
From: song <chensong@kylinos.cn>
Message-ID: <d9cae73e-de46-9682-5b2c-c480dc64207f@kylinos.cn>+C9B4027D7EE3A134
Date: Mon, 10 Feb 2020 20:48:53 +0800
MIME-Version: 1.0
In-Reply-To: <9429d894-9879-8266-5c36-7c566de9bf00@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

I was pretty sure that all events were enabled before testing with "echo 
1 > events/enable", somehow, the events i cared about were missed.I used 
trace-cmd as your suggestion, it took effect, i saw what i wanted.

I haven't figured out how different they are, but at least i can 
continue my work in my hand, many thanks.

BR

/Song

On 2020/2/3 下午3:00, Jan Kiszka wrote:
> On 02.02.20 13:22, song via Xenomai wrote:
>> hi guys,
>>
>> I'm working on an issue with ftrace events, the call stack is like that:
>>
>> __cobalt_clock_nanosleep
>>      xnthread_suspend
>>          xntimer_start
>>              xnclock_core_ns_to_ticks
>>                  xntimer_enqueue_and_program
>>                      xnclock_program_shot()
>>                          xnclock_core_local_shot
>>                              ipipe_timer_set
>>
>>
>> I tried to enable ftrace event with "-f" in cyclictest,however, i can 
>> only find:
>>
>> cobalt_clock_entry: clock_irq=4
>> cobalt_timer_expire: timer=ffffffc07ffd5800
>> cobalt_clock_exit: clock_irq=4
>> cobalt_timer_start ....
>>
>> event traces like trace_cobalt_clock_nanosleep or 
>> trace_cobalt_thread_suspend are missed, they are all defined in 
>> cobalt_core.h/cobalt_posix.h and visible in 
>> /sys/kernel/debugfs/tracing/events/cobalt-core(cobalt-posix).
>
> Are those events also enabled when you do the tracing? Try catching 
> them via "trace-cmd record -e 'cobalt*' if unsure.
>
> Jan
>
>>
>> Does anyone have the same problem before and i would appreciate it if 
>> you could let me know the way to solve it,many thanks
>>
>> BR
>>
>> Song
>>
>>
>>
>>
>>
>>
>>
>>




