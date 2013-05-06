Message-ID: <5188059C.9030106@xenomai.org>
Date: Mon, 06 May 2013 21:33:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi8eBtvVn9PcLSsrpHN+4YSCgHiGgacFgOeWjm6cQe6hsg@mail.gmail.com>
	<5187F3AA.6040801@xenomai.org> <51880134.1000208@gmail.com>
In-Reply-To: <51880134.1000208@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Doubts about priorities with periodic tasks (Posix
 Skin)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/06/2013 09:15 PM, Sebastian Pavez wrote:

> El 06/05/2013 14:17 p.m., Gilles Chanteperdrix escribió:
>> On 05/06/2013 07:14 PM, Sebastian Pavez wrote:
>>
>>> Hi,
>>>
>>> I've previously asked a question related to this topic:
>>> http://www.mail-archive.com/xenomai@xenomai.org/msg03134.html
>>>
>>> But now I have more specific doubts (I think) and hopefully someone could
>>> help me with this.
>>>
>>> Like I said in my other question I have two tasks, one to control a DC
>>> motor and the other one acting like a perturbation. I attached a simplify
>>> code of this program (without the code of the control and other stuff).
>>> When I execute it (the real one) and try 'cat /proc/xenomai/sched' I get:
>>>
>>> CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>>>    0         0      idle      -1                 -         master
>>> R          ROOT/0
>>>    1         0      idle      -1                 -         master
>>> R          ROOT/1
>>>    2         0      idle      -1                 -         master
>>> R          ROOT/2
>>>    3         0      idle      -1                 -         master
>>> R          ROOT/3
>>>    4         0      idle      -1                 -         master
>>> R          ROOT/4
>>>    5         0      idle      -1                 -         master
>>> R          ROOT/5
>>>    6         0      idle      -1                 -         master
>>> R          ROOT/6
>>>    7         0      idle      -1                 -         master
>>> R          ROOT/7
>>>    0    2339         rt       0                 -         master
>>> X          control
>>>    0    2341         rt       1              23us      master
>>> D          control
>>>    0    2342         rt       2               8us       master
>>> D          control
>>>
>>> So, one of my worries is answered, the threads are executed on the same
>>> CPU. When I try cat /proc/xenomai/stat I get:
>>>
>>> CPU  PID    MSW        CSW        PF    STAT         %CPU  NAME
>>>    0       0      0          23906158        0     00500080     17.8  ROOT/0
>>>    1       0      0                    0          0     00500080    100.0
>>> ROOT/1
>>>    2       0      0                    0          0     00500080    100.0
>>> ROOT/2
>>>    3       0      0                    0          0     00500080    100.0
>>> ROOT/3
>>>    4       0      0                    0          0     00500080    100.0
>>> ROOT/4
>>>    5       0      0                    0          0     00500080    100.0
>>> ROOT/5
>>>    6       0      0                    0          0     00500080    100.0
>>> ROOT/6
>>>    7       0      0                    0          0     00500080    100.0
>>> ROOT/7
>>>    0  2339      3                    3          0     00b00380       0.0
>>> control
>>>    0  2341      1          10157707        0     00300184     31.7  control
>>>    0  2342      1          10157706        0     00300184     48.6  control
>>>    0       0      0          70802151        0     00000000       1.6
>>> IRQ2312: [timer]
>>
>> Under Linux, every task has an "affinity" defining on which cpus it may
>> run, you can set affinity at task creation with some recent glibcs with
>> pthread_attr_setaffinity_np, or later with pthread_setaffinity or the
>> older service sched_setaffinity. See the glibc documentation for more
>> details.
>>
>>> I have 1 MSW, does this mean that the threads are being executed on a
>>> secondary mode? If is so, is there a way to avoid this?
>>
>> If you want to be informed of the switches to secondary mode, see
>> pthread_set_mode_np documentation.
>>
>>> I've been trying to increment the execution time of the perturbation thread
>>> (which have the highest priority) and see how the control is degrade
>>> (because my goal is to get practical results related with my professor
>>> simulations) but I get nothing.
>>
>> I may have misread your code, but it seems to me that in the code you
>> sent to this list, you do not control the execution time: each thread
>> keeps suspending itself in its inner loop by calling pthread_wait_np.
>>
>> In general, however, a Xenomai system where a real-time task consumes a
>> lot of cpu does tend to crash, it is recommended to let linux run (by
>> having all your real-time tasks suspended at some point) from time to
>> time. A safe solution is to let it run at least for its timer tick, so
>> every millisecond, 4 milliseconds, or 10 milliseconds depending on
>> CONFIG_HZ value.
>>
>>> The idea after getting this is change the
>>> priority, giving the control thread the highest one, and have system
>>> working ok, in simple words we would like to prove the theory of real time
>>> approach in practice. All this by having the same period for both tasks, I
>>> would like to have a bigger period, something like 1ms, but I'm trying to
>>> get the test to the edge first.
>>>
>>> Sometimes when I increment the execution time of the perturbation the
>>> computer hangs up before the control could even fail
>>
>> That is not normal. What version of Xenomai are you running, what
>> versino of the I-pipe patch, on what hardware, with what kernel
>> configuration? If you are running in graphic mode, could you try running
>> in text mode to see if you get a kernel error? If not, could you enable
>> the I-pipe and Xenomai debugging options to see if one trigs?
>>
> Hi Gilles,
> 
> Thanks for your answer. About the execution time issue I'll explain better:
> - How I see the code works:
>      - I set the period of each thread 'control' and 'pert1'
>      - After the initialization of variables and DAQ card the code 
> inside 'while(1)' is executed periodically
>      - I determined the time take it by this 'while(1)' via direct 
> measure (activating a signal before the code and disbling it after, and 
> measuring the width of the 'pulse')
>      - I get something like 18us for the control thread. So In the pert1 
> thread I use a 'for' loop inside the while(1), when I increment the 
> interations number I get a higher execution time
> - What I'm trying to test:
>      - For the same period for both tasks and the higher priority for 
> the pert1 thread I incremente the number of iterations inside the for loop
>      - I expect, with a execution time of pert1 over 35us, to see a 
> malfunctioning in the DC motor following the reference (via some signals 
> I get in the oscillo) because the control will not have
>        enough time to be executed properly before the next period in 
> wich the pert1 thread will resume his execution ... (is this correct?)
>      - All this is done to confirm the results obtained in simulation
> 
> Now, what I'm doing (the structure of my code) is in order with the 
> results I would like to test? or I'm misinterpreting something. I would 
> like to clarify this in order to know if the problems are about the 
> theory or the implementation ... or, sadly, both.


I do not see all this in the code you sent to the list, what I see is
two threads which sleep on pthread_wait_np and do nothing else. So,
execution time virtually 0. You can use rt_timer_spin to simulate some
load. Some point you may have missed too, is that Xenomai timer runs in
one-shot mode by default, which means the thread periods will not elapse
at the same time, except if you synchronize them by using the first
argument of pthread_make_periodic_np.

> 
> In general, however, a Xenomai system where a real-time task consumes a
> lot of cpu does tend to crash, it is recommended to let linux run (by
> having all your real-time tasks suspended at some point) from time to
> time. A safe solution is to let it run at least for its timer tick, so
> every millisecond, 4 milliseconds, or 10 milliseconds depending on
> CONFIG_HZ value.
> 
> How could I do this?


Arrange for every thread to not run more than the time of the period
corresponding to CONFIG_HZ.

> 
> That is not normal. What version of Xenomai are you running, what
> versino of the I-pipe patch, on what hardware, with what kernel
> configuration? If you are running in graphic mode, could you try running
> in text mode to see if you get a kernel error? If not, could you enable
> the I-pipe and Xenomai debugging options to see if one trigs?
> 
> I have xenomai-2.6.1 with kernel 3.2.32. The ipipe is 
> ipipe-core-3.2.21-x86-1.patch


Xenomai 2.6.1 is not the latest stable release, xenomai 2.6.2.1 is, and
the ipipe patch for linux 3.2.21 is known to have some issues, better
upgrading to 3.4 or 3.5.

> I have a Intel core i7 @ 3.4GHZ


It does not seem like a good idea to run a 32 bits kernel on such a
processor.

> I'm working in graphic mode, is there another way of seeing the kernel 
> error without working on text mode? (newbie in linux too)


Yes, newer drivers (nouveau, intel), are able to display oops text on
graphic mode, but I am not sure it really works when the I-pipe is in
the mix, so, starting in text mode is really the easy way out. Simply do
not start the X server.

> How could I enable debugging options? Should I have to configure the 
> kernel again?


Yes. The debug options are in the "Real-time" menu, and the "kernel
hacking" menu. But please a 3.4 or 3.5 kernel before doing that.


-- 
                                                                Gilles.

