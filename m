Message-ID: <500AF14A.30703@xenomai.org>
Date: Sat, 21 Jul 2012 20:13:30 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E2AB2206BF591546A1931EA4E7A9FBC859BAFA22@Maui.in.dynetics.com>
In-Reply-To: <E2AB2206BF591546A1931EA4E7A9FBC859BAFA22@Maui.in.dynetics.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT_TASK affinity on more than 8 CPU's
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Wolz, Troy" <Troy.Wolz@dynetics.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/16/2012 10:16 PM, Wolz, Troy wrote:
> Hello,
>
> I'm working on a project where I'd like to start more than 8 RT_TASKs each affined to their own CPU. From looking at the documentation, using the native API it appears to be possible to set affinity to a CPU from 0 to RTHAL_NR_CPUS-1. On my machine, RTHAL_NR_CPUS is 255, but when setting affinity above 7, overflow occurs and only the lower 8 CPU's are used.
>
> Looking into this, the T_CPU macro appears to only use the lower 3 bits of the value passed to it, implying that T_CPU only allows up to 8 CPU's to be used.
  Tracing through the use of this mask, it appears that the mode mask 
passed into rt_task_create uses the top 8 bits of the word as the cpu 
mask. The bits following the top 8 are used for other flags, so there is 
no room to expand the cpu mask.
>
> I see 2 solutions to this limitation for using Xenomai and affinity on more than 8 cpus.
> 1. Expand the 'mode' argument from a 32 bit int to a 64 bit long. With the extra bits, the top 32 bits could be used as a CPU mask, allowing for up to 32 cpu's to be masked simultaneously. This change would affect several files, but it should be backwards compatible with applications currently written using a 32 bit mode.
>
> 2. Pass an additional 64 bit long argument to rt_task_create that only contains the affinity mask. In this case, the mode argument would be used the same as previously, except the affinity would be ignored. This option has the disadvantage of being incompatible with existing Xenomai applications, but it is very easy to set affinity for up to 64 cpu's. We could add a preprocessor define that selects whether the existing rt_task_create method is available or whether the new method is available.
>
> We are willing to develop a patch that adds this functionality, but I wanted to talk it over with the group to determine if this would be accepted as a patch or if there's a better way to do it. Thanks.
>

The reason not to provide for more than 8 CPUs stems from our locking 
model, based on a single big lock to protect the system data structures. 
This is a design decision to keep the real-time kernel simple and 
robust, at the expense of scalability limited to few CPUs.
Our embedded bias, and the fact that CPU proliferation is not the norm 
there yet, particularly for dual kernel configurations, explains this.

Note that this setting relates to CPUs used in real-time mode, not 
necessarily to the overall number of CPUs available. E.g. you may pin 
your tasks on 4 CPUs dedicated to real-time processing, over a 64 CPUs 
system. Granted, the API currently allows real-time stuff to be pinned 
on CPUs #0-7 only. But you may change the affinity after task creation, 
using regular POSIX calls, this change will be propagated to the Xenomai 
scheduler next time the task moves back to real-time mode.
That would be the solution for Xenomai 2.x, which is exclusively based 
on a dual kernel architecture.

For the upcoming 3.x, the situation may be different, since we will have 
the same API also available on native real-time systems (e.g. 
preempt-rt). In that case, we do have a shortcoming in the way 
rt_task_create() accepts the CPU affinity setting, since there is no 
reason to restrict the range of available CPUs there.

In that case, a sane option could be to move the CPU affinity data out 
of the task mode from rt_task_create(), and provide a 
rt_task_setaffinity() call of some sort instead, receiving a cpuset map. 
This would keep the API compatible for most existing use cases, only 
requiring people who actually pin tasks to CPUs to update their code. 
However, this change won't make it in Xenomai 2.6, the API and ABI are 
frozen for this branch, which has entered the maintenance cycle.

PS: could you tune your MUA to split long lines? TIA,

> Troy
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.



