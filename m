Message-ID: <517AA2AE.8040304@xenomai.org>
Date: Fri, 26 Apr 2013 17:52:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1366989762.33394.YahooMailNeo@web161406.mail.bf1.yahoo.com>
In-Reply-To: <1366989762.33394.YahooMailNeo@web161406.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] task status in Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Z <tomz30@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/26/2013 05:22 PM, Tom Z wrote:
> Hi All,
>
> Can someone please tell me where I can find the documentation regarding the
> task status transition (is there a state machine describing that)?

see include/nucleus/thread.h. Roughly, the main transitions are:

XNDORMANT ---(task_start)--> XNREADY ---(scheduled in)--> [running]

[running] ---(preemption)--> XNREADY

--(task_delete)--> XNZOMBIE --> [flushed]

--(task_suspend)--> XNSUSP --(scheduled out)->

--(wait on synchronization)--> XNPEND --(scheduled out)->

--(timed wait)--> XNDELAY --(scheduled out)->

XNSUSP, XNPEND and XNDELAY are cumulative. Waiting on a synchronization 
object with a timeout leads to XNPEND | XNDELAY, otherwise XNPEND only. 
Sleeping on a mere timeout only involves XNDELAY in the status.

  Also, how the status values are defined? By reading 
rt_task_info::status during program execution, I can get some values. 
For example, while a task is running, I got a decimal of 3146112 for the 
task's rt_task_info::status. It seems this value is OR'ed with some 
macros, but what values are used to produce this status value? Where are 
they defined?
>

check include/native/task.h, T_* bits for the native API. Most of them 
are aliases to the XN* bits discussed above. 3146112 (0x300180), would 
mean XNOTHER|XNUSER|XNMAPPED|XNSTARTED, which tags a non real-time 
userland task shadowed by a Xenomai control block, basically meaning 
that it may pend on real-time resources (sema4s, queues, condvars, 
mutexes, etc), but won't contend for the CPU with real-time (i.e. 
non-zero priority) Xenomai tasks.

>
> Thanks,
> Tom
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

