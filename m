Subject: Re: some ftrace events are missed
References: <5e7d13d1-ee38-b1ee-3392-4bc19ff8cc4a@kylinos.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9429d894-9879-8266-5c36-7c566de9bf00@siemens.com>
Date: Mon, 3 Feb 2020 08:00:17 +0100
MIME-Version: 1.0
In-Reply-To: <5e7d13d1-ee38-b1ee-3392-4bc19ff8cc4a@kylinos.cn>
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
To: song <chensong@kylinos.cn>, xenomai@xenomai.org

On 02.02.20 13:22, song via Xenomai wrote:
> hi guys,
> 
> I'm working on an issue with ftrace events, the call stack is like that:
> 
> __cobalt_clock_nanosleep
>      xnthread_suspend
>          xntimer_start
>              xnclock_core_ns_to_ticks
>                  xntimer_enqueue_and_program
>                      xnclock_program_shot()
>                          xnclock_core_local_shot
>                              ipipe_timer_set
> 
> 
> I tried to enable ftrace event with "-f" in cyclictest,however, i can 
> only find:
> 
> cobalt_clock_entry: clock_irq=4
> cobalt_timer_expire: timer=ffffffc07ffd5800
> cobalt_clock_exit: clock_irq=4
> cobalt_timer_start ....
> 
> event traces like trace_cobalt_clock_nanosleep or 
> trace_cobalt_thread_suspend are missed, they are all defined in 
> cobalt_core.h/cobalt_posix.h and visible in 
> /sys/kernel/debugfs/tracing/events/cobalt-core(cobalt-posix).

Are those events also enabled when you do the tracing? Try catching them 
via "trace-cmd record -e 'cobalt*' if unsure.

Jan

> 
> Does anyone have the same problem before and i would appreciate it if 
> you could let me know the way to solve it,many thanks
> 
> BR
> 
> Song
> 
> 
> 
> 
> 
> 
> 
> 
-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

