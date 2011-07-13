Message-ID: <4E1D9A14.5040901@domain.hid>
Date: Wed, 13 Jul 2011 14:13:56 +0100
From: Jakub Nowacki <j.s.nowacki@domain.hid>
MIME-Version: 1.0
References: <4E1D8389.7050305@domain.hid> <4E1D84FD.7050307@domain.hid>
In-Reply-To: <4E1D84FD.7050307@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stack size of created task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

On 07/13/2011 12:43 PM, Gilles Chanteperdrix wrote:
>
> The stack size of a task is highly dependent on what the task does, and
> a little bit less on the architecture. There is no generic answer.
>
Yes, that is understandable.

I've found in xenomai/inclues/arm-generic/stack.h that xeno_stack, which 
is used in rt_task_create have a default value of __WORDSIZE*1024, 
hence, 64kB on 64-bit system. So using 0 stack size in rt_create_stack 
means that it'll be 64kB in my case, which seems to be a lot compared to 
the previous version. Am I correct?

I'm still not sure should I assume that stack size 0, which is 
(probably) __WORDSIZE*1024, is large enough for the vast majority of 
practical cases or put it as a variable. Also, is there any way to 
measure/asses the size of stack that is needed for a particular task or 
just when it sudden crashes increase the stack size has to be increased? 
I don't think that in RTXI very complicated RT tasks are used, so 
default size should be more than enough, but I'm still not sure what 
might indicate how large stack should be. As I understand it is related 
to the amounts of memory being used by a task, which is put on the stack 
during task switching, am I right?

 > The problem with switchtest was not the task size, but the number of
 > kernel stacks which were available in the kernel threads stacks pool.
 > That is an entirely different issue.
 >
I understand. I was referring to it because some 'safe' value of 8kB 
appeared there.

Cheers,

Jakub

