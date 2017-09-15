References: <CAB6vvjke_16vivYH6+6QJiDR__5zcUBihvAe5+0S+CVKt1Qx8g@mail.gmail.com>
 <cda6fe24-2a17-03af-b6b0-58b63dc82a82@xenomai.org>
 <CAB6vvjno8Ysd6k7fKpEkyfU-S+myKNd517ju0-X0nAOiQPJMPw@mail.gmail.com>
 <16d2a2b6-388b-bbe8-6196-397735d5b2cb@xenomai.org>
 <CAB6vvjmJX9P8c=bAdb7n3Li2WUx=m9xgdZrkYhKF0CeRsAZjbA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ea33bb43-a83c-5b35-6e4b-37ab81cde74a@xenomai.org>
Date: Fri, 15 Sep 2017 12:23:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAB6vvjmJX9P8c=bAdb7n3Li2WUx=m9xgdZrkYhKF0CeRsAZjbA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Can't wait on conditions on 3.0.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Hoarau <hoarau.robotics@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/14/2017 07:34 PM, Antoine Hoarau wrote:
> 2017-09-14 18:29 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:
>>
>> On 09/14/2017 06:08 PM, Antoine Hoarau wrote:
>>> Le jeu. 14 sept. 2017 à 16:30, Philippe Gerum <rpm@xenomai.org> a écrit :
>>>
>>>> On 09/14/2017 02:03 PM, Antoine Hoarau wrote:
>>>>> Hello,
>>>>> I'm porting a library that uses Xenomai 2.6.5 native to 3.0.5 alchemy on
>>>> an
>>>>> x64 Ubuntu 16.04 + Cobalt kernel 4.9.38.
>>>>>
>>>>> I'm stuck on conditions that do not wait signals to be emitted :
>>>>>
>>>>> int ret = rt_cond_wait_until(cond, mutex, rt_timer_ns2ticks(abs_time) )
>>>>> returns -ETIMEDOUT immediately.
>>>>>
>>>>> >From the documentation : -ETIMEDOUT is returned if abs_timeout is reached
>>>>> before the condition variable is signaled. But I verified that
>>>>> rt_timer_ns2ticks(abs_time)  > rt_timer_read(), so it should wait.
>>>>>
>>>>
>>>> You may want to check your calling args, e.g. wait for a second before
>>>> timeout:
>>>>
>>>>         ret = rt_cond_wait_until(&cond, &mutex, rt_timer_read() +
>>>> 1000000000ULL);
>>>>         if (ret)
>>>>                 error(1, -ret, "rt_cond_wait_until");
>>>>
>>>> Same. It returns directly with -ETIMEDOUT.
>>
>> This code works as expected here. You may want to provide a simple test
>> case illustrating the bug on your end.
>>
> 
> It does not wait one 1 sec, it returns directly.
> 
>>>
>>>
>>>>> This lead me to beleive that something was wrong with the mutex.
>>>>>
>>>>
>>>> I'm unsure to understand why.
>>>>
>>>> If I look at the code, the return value can be the return of the mutex if
>>> something is wrong :
>>> https://git.xenomai.org/xenomai-3.git/tree/lib/alchemy/cond.c#n382
>>
>> You must have locked the mutex before calling rt_cond_wait*(), so if you
>> did so, then such mutex has to be valid at the time of the call. The
>> code you refer to can only return -EINVAL if invalid, so this can't be.
>>
> 
> Here's a minimal example :
> 
> #include <stdio.h>
> #include <xeno_config.h>
> #include <xenomai/init.h>
> #include <alchemy/mutex.h>
> #include <alchemy/cond.h>
> #include <alchemy/task.h>
> #include <alchemy/timer.h>
> 
> RT_MUTEX mutex;
> RT_COND cond;
> RT_TASK demo_task;
> 
> void demo(void *arg)
> {
>     RTIME now = rt_timer_read();
>     int ret = rt_cond_wait_until(&cond,&mutex,now + 10000000000ULL);
>     RTIME then = rt_timer_read();
> 
>     printf("rt_cond_wait_until took %lld ticks, ret %d\n",then-now,ret);
> 
>     rt_task_sleep(rt_timer_ns2ticks(2E9));
> }
> 
> int main(int argc, char* argv[])
> {
>     printf("rt_mutex_create -> %d\n",rt_mutex_create(&mutex,"Mutex"));
>     printf("rt_cond_create  -> %d\n",rt_cond_create(&cond,"Cond"));
>     int prio = 0;
>     printf("rt_task_spawn   -> %d\n",rt_task_spawn(&demo_task,
> "TestCond", 0, prio, T_JOINABLE,&demo,NULL));
>     printf("rt_task_join    -> %d\n",rt_task_join(&demo_task));
>     return 0;
> }
> 
> 
> It returns :
>    rt_mutex_create -> 0
>    rt_cond_create  -> 0
>    rt_task_spawn   -> 0
>    rt_cond_wait_until took 22047 ticks, ret -110
>    rt_task_join    -> 0
> 
> It should wait 10 seconds, but returns immediately with ETIMEOUT.
> 

Nailed it. The issue stems from the nptl's pthread_condattr_setclock()
routine not accepting CLOCK_MONOTONIC_RAW, but only CLOCK_REALTIME or
CLOCK_MONOTONIC. Unfortunately, libalchemy attempts to set condvar
clocks either to CLOCK_MONOTONIC_RAW (aliased from CLOCK_COPPERPLATE) if
--enable-clock-monotonic-raw was passed to the configure script, or
falls back to CLOCK_MONOTONIC otherwise.

IOW, alchemy timed services don't work if --enable-clock-monotonic-raw
was given to configure. You have two options:

- omit --enable-clock-monotonic-raw, switching back to the default off
setting.

- apply the patch below, which is the long-term solution. Only Mercury
might be affected by NTP adjustments, not Cobalt anyway.

diff --git a/include/copperplate/clockobj.h b/include/copperplate/clockobj.h
index 2807d69..1652c52 100644
--- a/include/copperplate/clockobj.h
+++ b/include/copperplate/clockobj.h
@@ -41,11 +41,7 @@
  * different emulators can have different (virtual) system dates.
  */
 #ifndef CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED
-#ifdef CONFIG_XENO_RAW_CLOCK_ENABLED
-#define CLOCK_COPPERPLATE  CLOCK_MONOTONIC_RAW
-#else
 #define CLOCK_COPPERPLATE  CLOCK_MONOTONIC
-#endif
 #else /* CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED */
 #define CLOCK_COPPERPLATE  CLOCK_REALTIME
 #endif /* CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED */

-- 
Philippe.

