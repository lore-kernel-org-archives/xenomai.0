Message-ID: <518A9E74.9070902@xenomai.org>
Date: Wed, 08 May 2013 20:50:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi8eBtvVn9PcLSsrpHN+4YSCgHiGgacFgOeWjm6cQe6hsg@mail.gmail.com>	<5187F3AA.6040801@xenomai.org>
	<51880134.1000208@gmail.com>	<5188059C.9030106@xenomai.org>
	<51881CC0.5060300@gmail.com>	<5188E58D.7070304@xenomai.org>
	<5188F546.5090001@gmail.com>	<518A50D8.20709@xenomai.org>
	<518A9BE9.2040105@gmail.com> <518A9E20.9020400@xenomai.org>
In-Reply-To: <518A9E20.9020400@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 05/08/2013 08:49 PM, Gilles Chanteperdrix wrote:

> On 05/08/2013 08:39 PM, Sebastian Pavez wrote:
> 
>> Obviously Xenomai can't utilize the 100% of CPU,
> 
> 
> Xenomai can utilize 100% of the CPU, the problem is that if it does so
> for a too long time, the system crashes eventually.
> 
>> so my question is: If I 
>> try to work in Xenomai, with some task that are not able to execute 
>> completely, the CPU will try to utilize resource that doesn't have?
> 
> 
> I do not understand this question.
> 
>> In regard the changes I made, how are related the Xenomai scheduler and 
>> the Linux one? where I could find some detailed documentation about this 
>> (to put in my references)? Is there something like an scheduler of 
>> schedulers that take the execution of Xenomai's task and then the Linu'x 
>> ones?
> 
> 
> Linux as a whole is seen as one task by Xenomai scheduler, executed when
> Xenomai scheduler has no other task to execute.
> 
>>
>> A confirmation of why my previous test (both tasks running with Xenomai) 
>> was a dead end would be great. Some souce of information (more formal 
>> than a suggestion) would also be quite appreciated.
> 
> 
> You never showed a test that I could run on my machine to try and
> understand what you are trying to prove. And I still do not understand.
> Please make a test program, using rt_timer_spin to simulate the cpu
> load, and explain me, in very simple word, or with a printf in the test
> code, or with a comment in the test code, the problem you observe. Is it
> a latency problem?
> 

If you suspect the task is running in secondary mode when it should not:
- please do not use the I-pipe patch for 3.2
- use pthread_set_mode_np to be notified about mode switches.

But I already told you that.

-- 
                                                                Gilles.

