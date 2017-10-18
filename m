References: <79642a26-d54d-7362-9ea5-872a5f82f0ed@iit.it>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1b9798ae-fa9e-6604-a4ef-43028b727a8b@xenomai.org>
Date: Wed, 18 Oct 2017 18:57:47 +0200
MIME-Version: 1.0
In-Reply-To: <79642a26-d54d-7362-9ea5-872a5f82f0ed@iit.it>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai 3 migration bitmask for calls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Camurri <marco.camurri@iit.it>, xenomai@xenomai.org

On 10/18/2017 08:50 AM, Marco Camurri wrote:
> Dear all,
> I'm migrating a mission critical system based on the native skin of
> Xenomai 2 to Xenomai 3.
> 
> I read from the migration guide that now this skin is called Alchemy,
> therefore I did the modification in header includes and other things.
> 
> However, some bitmask variables some xenomai calls have been removed.
> I would like to replicate the exact behavior I had on Xenomai 2
> in the new system.
> In particular, the calls I have in the previous system are:
> 
> 1) rt_task_spawn(&servo_ptr, name, servo_stack_size, servo_priority,
>                  T_FPU | T_JOINABLE | T_CPU(cpuID), motor_servo, NULL)
> 
>    T_FPU and T_CPU are removed, who do I make the new call?
>    Just with T_JOINABLE?

T_FPU was dropped since any userland thread has fpu enabled implicitly
(even in 2.6). So omitting it brings no change.

T_CPU() should be replaced by an explicit call to rt_task_set_affinity().

> 
> 2) rt_heap_create(&heap,name,(size_t)(elemNum*elemSize), H_SHARED)
> 
>    H_SHARED has been removed.

Heaps shared between kernel and userland apps should be implemented by a
memory mapping instantiated by a RTDM driver.

If sharing is between userland processes, then you only need to pass
--enable-pshared when configuring userland libs for build, then specify
a common session name (--session=<name>) when starting any process which
should have access to shared resources (i.e. including those heaps). Or
you can create a POSIX shared memory segment over tmpfs directly.

>    The only options I have now are: H_FIFO, H_PRIO, H_SINGLE.
>    What should I choose?
> 

Depends on what you need:
http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__heap.html#ga1d19ad24dc9f94b969aa0f574170bdc4

> 3) rt_timer_set_mode((RTIME) TM_ONESHOT)
> 
>    TM_ONESHOT does not exist anymore.  What should I set in the
>    rt_set_mode function?
>    The documentation only says to set 0 for no op, but it does not tell
>    anything about the other options.

As mentioned in the migration guide, that call is obsolete, there is no
other option, you don't need it. Oneshot timing is the default, use
--alchemy-clock-resolution=<ns> to turn on periodic ticking for the
application process.

-- 
Philippe.

