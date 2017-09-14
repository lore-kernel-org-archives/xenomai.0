References: <CAB6vvjke_16vivYH6+6QJiDR__5zcUBihvAe5+0S+CVKt1Qx8g@mail.gmail.com>
 <cda6fe24-2a17-03af-b6b0-58b63dc82a82@xenomai.org>
 <CAB6vvjno8Ysd6k7fKpEkyfU-S+myKNd517ju0-X0nAOiQPJMPw@mail.gmail.com>
 <16d2a2b6-388b-bbe8-6196-397735d5b2cb@xenomai.org>
 <CAB6vvjmJX9P8c=bAdb7n3Li2WUx=m9xgdZrkYhKF0CeRsAZjbA@mail.gmail.com>
From: Florian Richer <richer@isir.upmc.fr>
Message-ID: <657caa04-19cf-45ef-ca86-0e73daf7fabc@isir.upmc.fr>
Date: Thu, 14 Sep 2017 19:49:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAB6vvjmJX9P8c=bAdb7n3Li2WUx=m9xgdZrkYhKF0CeRsAZjbA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Xenomai] Can't wait on conditions on 3.0.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Working as expected on my box (Beaglebone black, xeno 3.0.4 on linux 
4.4.68) :

rt_mutex_create -> 0
rt_cond_create  -> 0
rt_task_spawn   -> 0
rt_cond_wait_until took 9998937664 ticks, ret -110
rt_task_join    -> 0

Maybe something is wrong with your kernel config ?


On 14/09/17 19:34, Antoine Hoarau wrote:
> 2017-09-14 18:29 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:
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
>>>> You may want to check your calling args, e.g. wait for a second before
>>>> timeout:
>>>>
>>>>          ret = rt_cond_wait_until(&cond, &mutex, rt_timer_read() +
>>>> 1000000000ULL);
>>>>          if (ret)
>>>>                  error(1, -ret, "rt_cond_wait_until");
>>>>
>>>> Same. It returns directly with -ETIMEDOUT.
>> This code works as expected here. You may want to provide a simple test
>> case illustrating the bug on your end.
>>
> It does not wait one 1 sec, it returns directly.
>
>>>
>>>>> This lead me to beleive that something was wrong with the mutex.
>>>>>
>>>> I'm unsure to understand why.
>>>>
>>>> If I look at the code, the return value can be the return of the mutex if
>>> something is wrong :
>>> https://git.xenomai.org/xenomai-3.git/tree/lib/alchemy/cond.c#n382
>> You must have locked the mutex before calling rt_cond_wait*(), so if you
>> did so, then such mutex has to be valid at the time of the call. The
>> code you refer to can only return -EINVAL if invalid, so this can't be.
>>
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
>      RTIME now = rt_timer_read();
>      int ret = rt_cond_wait_until(&cond,&mutex,now + 10000000000ULL);
>      RTIME then = rt_timer_read();
>
>      printf("rt_cond_wait_until took %lld ticks, ret %d\n",then-now,ret);
>
>      rt_task_sleep(rt_timer_ns2ticks(2E9));
> }
>
> int main(int argc, char* argv[])
> {
>      printf("rt_mutex_create -> %d\n",rt_mutex_create(&mutex,"Mutex"));
>      printf("rt_cond_create  -> %d\n",rt_cond_create(&cond,"Cond"));
>      int prio = 0;
>      printf("rt_task_spawn   -> %d\n",rt_task_spawn(&demo_task,
> "TestCond", 0, prio, T_JOINABLE,&demo,NULL));
>      printf("rt_task_join    -> %d\n",rt_task_join(&demo_task));
>      return 0;
> }
>
>
> It returns :
>     rt_mutex_create -> 0
>     rt_cond_create  -> 0
>     rt_task_spawn   -> 0
>     rt_cond_wait_until took 22047 ticks, ret -110
>     rt_task_join    -> 0
>
> It should wait 10 seconds, but returns immediately with ETIMEOUT.
>
>> --
>> Philippe.
>
>
>

-- 
Florian RICHER
Institut des Systèmes Intelligents et de Robotique - CNRS
Université Pierre et Marie Curie
Pyramide - Tour 55/65 - Boite courrier 173
4 Place Jussieu - 75005 Paris
Tel. : 01.44.27.62.53


