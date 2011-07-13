Message-ID: <4E1D84FD.7050307@domain.hid>
Date: Wed, 13 Jul 2011 13:43:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E1D8389.7050305@domain.hid>
In-Reply-To: <4E1D8389.7050305@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: xenomai@xenomai.org

On 07/13/2011 01:37 PM, Jakub Nowacki wrote:
> Hi,
> 
> I had a slight problem with freezing tasks in RTXI using Xenomai. 
> Namely, task was working normally for some time and then froze, but just 
> RTXI/task not the whole system. I've found that it was caused by the 
> stack size of a task set to 2000B during the creation. Changing it to 0, 
> i.e., automatic stack size fixed the freezing. My question is what is a 
> preferred value there? Before on the list I asked about a problem with 
> the stack size in the kernel being to small for switchtest to run 
> properly on i7 machine. There, one of the answers was that safe bet is 
> 8kB for 64-bit machine. I'm not sure should I leave the stack size in 
> rt_task_create to 0 or to some high value or it should be machine 
> dependent? What is being put on this stack and how to determine it's 
> size depending on the complexity of the task (number of vars?)?

The stack size of a task is highly dependent on what the task does, and
a little bit less on the architecture. There is no generic answer.

The problem with switchtest was not the task size, but the number of
kernel stacks which were available in the kernel threads stacks pool.
That is an entirely different issue.

-- 
                                                                Gilles.

