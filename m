Message-ID: <518A9BE9.2040105@gmail.com>
Date: Wed, 08 May 2013 14:39:37 -0400
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
MIME-Version: 1.0
References: <CANzNmi8eBtvVn9PcLSsrpHN+4YSCgHiGgacFgOeWjm6cQe6hsg@mail.gmail.com>
	<5187F3AA.6040801@xenomai.org> <51880134.1000208@gmail.com>
	<5188059C.9030106@xenomai.org> <51881CC0.5060300@gmail.com>
	<5188E58D.7070304@xenomai.org> <5188F546.5090001@gmail.com>
	<518A50D8.20709@xenomai.org>
In-Reply-To: <518A50D8.20709@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

El 08/05/2013 09:19 a.m., Gilles Chanteperdrix escribió:
> On 05/07/2013 02:36 PM, Sebastian Pavez wrote:
>
>> Hi Gilles,
>>
>> Sorry for the mess :-) I hope this is more clear:
>>
>>> Hi Gilles,
>>>
>>> Thanks for your answer. About the execution time issue I'll explain better:
>>> - How I see the code works:
>>>        - I set the period of each thread 'control' and 'pert1'
>>>        - After the initialization of variables and DAQ card the code
>>> inside 'while(1)' is executed periodically
>>>        - I determined the time take it by this 'while(1)' via direct
>>> measure (activating a signal before the code and disbling it after, and
>>> measuring the width of the 'pulse')
>>>        - I get something like 18us for the control thread. So In the pert1
>>> thread I use a 'for' loop inside the while(1), when I increment the
>>> interations number I get a higher execution time
>>> - What I'm trying to test:
>>>        - For the same period for both tasks and the higher priority for
>>> the pert1 thread I incremente the number of iterations inside the for loop
>>>        - I expect, with a execution time of pert1 over 35us, to see a
>>> malfunctioning in the DC motor following the reference (via some signals
>>> I get in the oscillo) because the control will not have
>>>          enough time to be executed properly before the next period in
>>> wich the pert1 thread will resume his execution ... (is this correct?)
>>>        - All this is done to confirm the results obtained in simulation
>>>
>>> Now, what I'm doing (the structure of my code) is in order with the
>>> results I would like to test? or I'm misinterpreting something. I would
>>> like to clarify this in order to know if the problems are about the
>>> theory or the implementation ... or, sadly, both.
>>>> I do not see all this in the code you sent to the list, what I see is
>>>> two threads which sleep on pthread_wait_np and do nothing else. So,
>>>> execution time virtually 0. You can use rt_timer_spin to simulate some
>>>> load. Some point you may have missed too, is that Xenomai timer runs in
>>>> one-shot mode by default, which means the thread periods will not elapse
>>>> at the same time, except if you synchronize them by using the first
>>>> argument of pthread_make_periodic_np.
>> Sorry for that, I now attached the code ... It's quite raw at the moment
>> but it does what is suppose to, control the DC motor.
>
> That is fine, but if you want us to be able to test your code, you
> should send code which runs anywhere, using rt_timer_spin to simulate load.
>
>> Regarding the first argument of pthread_make_periodic_np, I use
>> pthread_self() to assign to the calling thread, wht do you precisely
>> mean with "using the first
>> argument of pthread_make_periodic_np"?
>
> I mean the second argument, the start time, sorry.
>
>>>> In general, however, a Xenomai system where a real-time task consumes a
>>>> lot of cpu does tend to crash, it is recommended to let linux run (by
>>>> having all your real-time tasks suspended at some point) from time to
>>>> time. A safe solution is to let it run at least for its timer tick, so
>>>> every millisecond, 4 milliseconds, or 10 milliseconds depending on
>>>> CONFIG_HZ value.
>>>>
>>>> How could I do this?
>>> Arrange for every thread to not run more than the time of the period
>>> corresponding to CONFIG_HZ.
>>>
>> This mean, don't set a period more than 4ms for each thread? (I have a
>> configuration of 250hz)
>
> I am not talking about the period, I am talking about the cpu time
> consumed by the thread, a thread should never run for more than 4ms
> without suspending.
>
>> I tried to start in text mode by changing "quite splash" to "quite
>> splash text" in the grub ... I only get a black screen at the start.
>
> If you are using a graphic login such as xdm, gdm, kdm, simply disable
> it. On a debian system, you would do this with update-rc.d, for another
> distribution, I do not know. Anyway, as I told you, before trying to run
> in text mode, you should try to run a more recent patch, the one for
> linux 3.4 or the one for linux 3.5 which you will find in xenomai 2.6.2.1.
>
>> One more question, the results I get with 'cat /proc/xenomai/stat' and
>> 'cat /proc/xenomai/sched' prove that the threads are being executed in a
>> rel-time mode?
>> or there's something "weird" about them? or That's not enough info?
>
> I am not sure I understand your question, if you do not show me what
> problem you seem to see. "real-time mode" is ambiguous. A thread is
> present in /proc/xenomai/stat and /proc/xenomai/sched if it has a
> real-time shadow, it is then able to run either in "primary mode", under
> control of Xenomai scheduler, or in "secondary mode", under control of
> the Linux scheduler. The mode it is currently running on is shown by the
> "STAT" field. A thread running in secondary mode will have an "X" in its
> status bits in /proc/xenomai/sched.
>
> See:
> http://www.xenomai.org/index.php//proc/xenomai/stat
> http://www.xenomai.org/index.php/Proc/xenomai/sched
>
Hi Gilles,

Thank you very much for your patience and your answer. I understand 
better some things. And I think I didn't explain quite well my 
situation. However, I also think that I was trying to do something 
impossible to do, and I would like to know if it is so. The whole idea 
was to show a malfunction of the threads, and in order to do this, one 
of the task will not execute completely before the other one preempt his 
execution (higher priority). So, I should have asked this in the 
beginning: To work with Xenomai the tasks have to be absolutely 
"schedulable"? I mean, I intended to lost the execution of one task and 
I realized that the CPU was used 100% and then the execution ended. So I 
tried to prove the same thing but, instead of have two tasks in Xenomai 
with different priority, I used one with Xenomai and the other on linux 
(priority=0 and policy=OTHER). And what I was trying to prove .... 
worked (The control of the motor was degrade when this task was assign 
to linux). Then I change the priority (Control in Xenomai) and works 
fine. That's the whole point of this test. This lead me to some questions.

Obviously Xenomai can't utilize the 100% of CPU, so my question is: If I 
try to work in Xenomai, with some task that are not able to execute 
completely, the CPU will try to utilize resource that doesn't have?
In regard the changes I made, how are related the Xenomai scheduler and 
the Linux one? where I could find some detailed documentation about this 
(to put in my references)? Is there something like an scheduler of 
schedulers that take the execution of Xenomai's task and then the Linu'x 
ones?

A confirmation of why my previous test (both tasks running with Xenomai) 
was a dead end would be great. Some souce of information (more formal 
than a suggestion) would also be quite appreciated.

Best regards,
Seba. P.

