Message-ID: <518AAA8F.6010309@gmail.com>
Date: Wed, 08 May 2013 15:42:07 -0400
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
MIME-Version: 1.0
References: <CANzNmi8eBtvVn9PcLSsrpHN+4YSCgHiGgacFgOeWjm6cQe6hsg@mail.gmail.com>
	<5187F3AA.6040801@xenomai.org> <51880134.1000208@gmail.com>
	<5188059C.9030106@xenomai.org> <51881CC0.5060300@gmail.com>
	<5188E58D.7070304@xenomai.org> <5188F546.5090001@gmail.com>
	<518A50D8.20709@xenomai.org> <518A9BE9.2040105@gmail.com>
	<518A9E20.9020400@xenomai.org>
In-Reply-To: <518A9E20.9020400@xenomai.org>
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

El 08/05/2013 14:49 p.m., Gilles Chanteperdrix escribió:
> On 05/08/2013 08:39 PM, Sebastian Pavez wrote:
>
>> Obviously Xenomai can't utilize the 100% of CPU,
>
> Xenomai can utilize 100% of the CPU, the problem is that if it does so
> for a too long time, the system crashes eventually.
Ok, thanks for the clarification
>> so my question is: If I
>> try to work in Xenomai, with some task that are not able to execute
>> completely, the CPU will try to utilize resource that doesn't have?
>
> I do not understand this question.
I will explain all again at the end of the email
>> In regard the changes I made, how are related the Xenomai scheduler and
>> the Linux one? where I could find some detailed documentation about this
>> (to put in my references)? Is there something like an scheduler of
>> schedulers that take the execution of Xenomai's task and then the Linu'x
>> ones?
>
> Linux as a whole is seen as one task by Xenomai scheduler, executed when
> Xenomai scheduler has no other task to execute.
>
>> A confirmation of why my previous test (both tasks running with Xenomai)
>> was a dead end would be great. Some souce of information (more formal
>> than a suggestion) would also be quite appreciated.
>
> You never showed a test that I could run on my machine to try and
> understand what you are trying to prove. And I still do not understand.
> Please make a test program, using rt_timer_spin to simulate the cpu
> load, and explain me, in very simple word, or with a printf in the test
> code, or with a comment in the test code, the problem you observe. Is it
> a latency problem?

Just some points to clarify,

- First of all my problem isn't with the functioning of Xenomai. That 
works jus fine ... I think.
- The whole idea of my code is to explain the theory behind a real time 
system
- In the theory if you have 2 tasks, the one with the highest priority 
(T1) will execute before the other (T2), if there's sometime left it 
will be executed
- On the other hand, if there's not enough time to execute the task with 
lowest priority (T2) it will be paused by the other one.
- I do that with a same period for both tasks and increasing the 
execution time of T1 order to reduce the time left to T2.
- So for instance, if I have a period of 50us for each task. The 
execution time for T2 is 20us, and for T1 is variable (call it 'E1').
- If 'E1' is less than 30us everything will be ok, both tasks will be 
executed entirely (Case1)
- But, when 'E' is over 30us T2 will not have enough time to complete 
(Case2)

- Whit this in mind, if I have two tasks in Xenomai (with different 
priority) is possible to see this effect, I mean for Case1 everything 
goes fine. But when I try Case2 the computer hangs up for a while and 
the execution ends. With proc/xenomai/stat I'm able to see that the 
utilization of CPU arrives closely to 100% (That explain the hang up).

All this lead me to the question: What I'm tring to do isn't possible to 
do (based on this results)? I mean, is this state true?: I'll never be 
able to see the effect I'm looking for because Xenomai won't allow me to 
have tasks that are not able to execute entirely? (If you could 
recommend some documentation to read about this would be great).

That's led me to try what I said previously, having one task with 
Xenomai and the other in Linux. This gave me the results I expected 
related with the theory, and that's all I need. But I would like to be 
sure if what I was trying to do before it (both tasks with Xenomai) were 
a dead end. And again, if you could suggest some documentation to read 
about the relation with the schedulers of Xenomai and Linux would be 
just awesome. And if there's something about the behaviour of a task 
created with (priority=0 and policy=OTHER) would be great too, because 
what I read wasn't clear enough for me.

I hope this explanation is more straight, and sorry if it isn't. Like I 
said, my problem isn´t related with a malfunction or error with Xenomai, 
it is if what I'm trying to do doesn't have a foundation.

Thanks, once again.

