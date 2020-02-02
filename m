From: song <chensong@kylinos.cn>
Subject: some ftrace events are missed
Message-ID: <5e7d13d1-ee38-b1ee-3392-4bc19ff8cc4a@kylinos.cn>+FAD0AF27CFDEBD83
Date: Sun, 2 Feb 2020 20:22:06 +0800
MIME-Version: 1.0
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
To: xenomai@xenomai.org

hi guys,

I'm working on an issue with ftrace events, the call stack is like that:

__cobalt_clock_nanosleep
     xnthread_suspend
         xntimer_start
             xnclock_core_ns_to_ticks
                 xntimer_enqueue_and_program
                     xnclock_program_shot()
                         xnclock_core_local_shot
                             ipipe_timer_set


I tried to enable ftrace event with "-f" in cyclictest,however, i can 
only find:

cobalt_clock_entry: clock_irq=4
cobalt_timer_expire: timer=ffffffc07ffd5800
cobalt_clock_exit: clock_irq=4
cobalt_timer_start ....

event traces like trace_cobalt_clock_nanosleep or 
trace_cobalt_thread_suspend are missed, they are all defined in 
cobalt_core.h/cobalt_posix.h and visible in 
/sys/kernel/debugfs/tracing/events/cobalt-core(cobalt-posix).

Does anyone have the same problem before and i would appreciate it if 
you could let me know the way to solve it,many thanks

BR

Song








