Message-ID: <5112B718.6010402@xenomai.org>
Date: Wed, 06 Feb 2013 21:03:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51128CE4.4020303@siemens.com> <51128E3E.808@xenomai.org>
	<511293EB.1080502@siemens.com> <5112945F.8080102@xenomai.org>
	<51129599.3080709@siemens.com> <51129693.1040400@xenomai.org>
	<5112974A.8050008@siemens.com> <5112982B.1020901@xenomai.org>
	<5112A06A.7030809@siemens.com> <5112A175.5010002@xenomai.org>
	<5112A269.40609@siemens.com> <5112A392.3050302@xenomai.org>
	<5112AD78.5080308@siemens.com> <5112AF72.3020201@xenomai.org>
	<5112B51A.6000207@siemens.com>
In-Reply-To: <5112B51A.6000207@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe/x86: do not restore during context switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 02/06/2013 08:55 PM, Jan Kiszka wrote:

>> To the contrary, the overhead is the cost of the fault (with the
>> user/kernel and kernel/user switches), so, the larger the context
>> switch, the smaller the overhead in proportion.
> 
> Yes, continuously faulting in FPU states of heavy Linux users is the
> problem. That must be changed.


We are talking x86 here, so, the cost of the FPU fault is not that heavy.

>>> Instead of always doing stts for the new task, we could do the restore
>>> later, after the hard_local_irq_enable of __ipipe_switch_tail. That
>>> should allow the eager model for Linux as well without making
>>> save+restore of Linux-Linux switches atomic.
>>
>>
>> That could be done, but it is probably simpler to implement unlocked
>> context switch, and split __switch_to into several atomic sections.
> 
> Yep, indeed.
> 
>> Anyway, any change in this area will probably break the work done for
>> kthreads on -forge, so, can't we postpone this?
> 
> For how long? What are the dependencies?


For the time it takes to validate FPU on kthreads with -forge.

> I thought unlocked context
> switches already exit for other archs.


That is not an issue, indeed.

> 
> At least I will need to look into this internally - we are using less
> than 10% of our CPUs for RT, the rest wants high performance.


Are you sure this is not a priori optimization of something which is not
really an issue?

-- 
                                                                Gilles.

