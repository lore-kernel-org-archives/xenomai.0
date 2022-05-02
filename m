Subject: Re: Thread's CPU time
References: <6a50f4cf-4f2a-542a-c332-4d98975e36a6@bela.io>
 <87fslvzyxa.fsf@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Message-ID: <9757c566-0198-5199-3490-b53f7fb32308@bela.io>
Date: Mon, 2 May 2022 11:42:12 +0200
MIME-Version: 1.0
In-Reply-To: <87fslvzyxa.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote on 29/04/2022 17:29:>
> Giulio Moro via Xenomai <xenomai@xenomai.org> writes:
> 
>> Hi everyone,
>>  From /proc/xenomai/sched/stat I infer there must be an internal struct
>> somewhere keeping track of how much CPU time is actually used by each
>> thread. Is there any way to access this kind of statistics from a
>> running Xenomai user space program without leaving primary mode and
>> without attempting to read this file? I am implementing an
>> infrastructure to measure the CPU time of a given block of
>> code. Currently I am using Cobalt's clock_gettime(), but this only
>> works reliably if the task does not get preempted or otherwise
>> rescheduled between the two calls.
>>
>> I have run this kind of tests offline before and that's all nice and good, but I am looking for a lightweight and non invasive way of benchmarking particular sections of large-ish programs with minimal modifications.
>>
>> Thanks,
>> Giulio
> 
> For xenomai3, you may want to have a look at cobalt_thread_stat() from
> the internal API (sys/cobalt.h). The field of interest returned in
> struct cobalt_threadstat would be 'xtime' (nsecs).
> 
Thanks, I tried to implement something based on that and it seems to carry a considerable overhead over calling Cobalt's clock_gettime(): about a 3% CPU increase (as measured by /proc/xenomai/sched/stat) for 6 calls to `cobalt_thread_stat()` during a periodic task with period 360us, which is suboptimal.

A look at COBALT_SYSCALL(thread_getstat, ...) suggests that it would be possible to get just xtime for significantly cheaper than a full clock_gettime() call, considering not only that there would be less memory to be copied around, but also that - afaict - the irqsave / irqrestore calls wouldn't be needed. I am wondering whether, to this effect, it would make sense to implement `CLOCK_THREAD_CPUTIME_ID` for Cobalt's clock_gettime(), returning the 'xtime' field of this struct, e.g. (untested and probably missing includes):

```
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 16cc8b20a..434380509 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -134,6 +134,14 @@ int __cobalt_clock_gettime(clockid_t clock_id, struct timespec64 *ts)
                 if (pipeline_get_host_time(ts) != 0)
                         return -EINVAL;
                 break;
+       case CLOCK_THREAD_CPUTIME_ID:
+               {
+                       struct xnthread *thread = xnthread_current();
+                       if (thread == NULL)
+                               return -EPERM;
+                       ns2ts(ts, xnstat_exectime_get_total(&thread->stat.account));
+               }
+               break;
         default:
                 ret = do_ext_clock(clock_id, read_monotonic, ns);
                 if (ret)
```

Or am I oversimplifying here?

