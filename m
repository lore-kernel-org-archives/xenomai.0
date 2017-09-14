MIME-Version: 1.0
From: Antoine Hoarau <hoarau.robotics@gmail.com>
Date: Thu, 14 Sep 2017 12:03:16 +0000
Message-ID: <CAB6vvjke_16vivYH6+6QJiDR__5zcUBihvAe5+0S+CVKt1Qx8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Can't wait on conditions on 3.0.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,
I'm porting a library that uses Xenomai 2.6.5 native to 3.0.5 alchemy on an
x64 Ubuntu 16.04 + Cobalt kernel 4.9.38.

I'm stuck on conditions that do not wait signals to be emitted :

int ret = rt_cond_wait_until(cond, mutex, rt_timer_ns2ticks(abs_time) )
returns -ETIMEDOUT immediately.

>From the documentation : -ETIMEDOUT is returned if abs_timeout is reached
before the condition variable is signaled. But I verified that
rt_timer_ns2ticks(abs_time)  > rt_timer_read(), so it should wait.

This lead me to beleive that something was wrong with the mutex.

1) Can rt_cond_wait return -ETIMEDOUT with the mutex ?
2)  How would you implement a trylock() on a mutex ?

        struct RT_MUTEX_INFO info;
        rt_mutex_inquire(mutex, &info );
        RT_TASK no_task = NO_ALCHEMY_TASK;
        rt_task_same(&info.owner,&no_task) == 0 -> not locked !
          --> rt_mutex_acquire(mutex,TM_NONBLOCK)

Note : I compiled xenomai with --enable-debug --enable-dlopen-libs
--enable-smp

Thanks for your help !


-- 
Antoine Hoarau
Robotics Engineer
