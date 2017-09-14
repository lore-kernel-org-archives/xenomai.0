References: <CAB6vvjke_16vivYH6+6QJiDR__5zcUBihvAe5+0S+CVKt1Qx8g@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cda6fe24-2a17-03af-b6b0-58b63dc82a82@xenomai.org>
Date: Thu, 14 Sep 2017 16:30:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAB6vvjke_16vivYH6+6QJiDR__5zcUBihvAe5+0S+CVKt1Qx8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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

On 09/14/2017 02:03 PM, Antoine Hoarau wrote:
> Hello,
> I'm porting a library that uses Xenomai 2.6.5 native to 3.0.5 alchemy on an
> x64 Ubuntu 16.04 + Cobalt kernel 4.9.38.
> 
> I'm stuck on conditions that do not wait signals to be emitted :
> 
> int ret = rt_cond_wait_until(cond, mutex, rt_timer_ns2ticks(abs_time) )
> returns -ETIMEDOUT immediately.
> 
>>From the documentation : -ETIMEDOUT is returned if abs_timeout is reached
> before the condition variable is signaled. But I verified that
> rt_timer_ns2ticks(abs_time)  > rt_timer_read(), so it should wait.
> 

You may want to check your calling args, e.g. wait for a second before
timeout:

	ret = rt_cond_wait_until(&cond, &mutex, rt_timer_read() + 1000000000ULL);
	if (ret)
		error(1, -ret, "rt_cond_wait_until");

> This lead me to beleive that something was wrong with the mutex.
> 

I'm unsure to understand why.

> 1) Can rt_cond_wait return -ETIMEDOUT with the mutex ?
> 2)  How would you implement a trylock() on a mutex ?
> 
>         struct RT_MUTEX_INFO info;
>         rt_mutex_inquire(mutex, &info );
>         RT_TASK no_task = NO_ALCHEMY_TASK;
>         rt_task_same(&info.owner,&no_task) == 0 -> not locked !
>           --> rt_mutex_acquire(mutex,TM_NONBLOCK)

rt_mutex_acquire(mutex,TM_NONBLOCK) does mean trylock(), you don't need
further checks. Besides, the code above would be racy.

-- 
Philippe.

