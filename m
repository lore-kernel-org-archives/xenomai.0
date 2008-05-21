From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18484.30529.139466.446143@domain.hid>
Date: Wed, 21 May 2008 21:25:53 +0200
In-Reply-To: <76427479026b1c06e23878a4716b76d5@domain.hid>
References: <76427479026b1c06e23878a4716b76d5@domain.hid>
Subject: Re: [Xenomai-help]
	=?utf-8?q?Linux_kernel_and_RT=5Ftask_CPUs_allocati?= =?utf-8?q?on?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org


> Hello,
> 
> I'm working on a multi-cpus workstation and I allocate the execution of
> real time task to precise CPUs. As tasks are preempting linux kernel, this
> last one executes itself over non loaded CPUs. I want to strictly separate
> the executions of tasks and linux kernel overs CPUs. The reason is that the
> architecture over which I'm working is a NUMA architecture and I have
> noticed that context migrations are a little bit expensive (NUMA makes the
> cost of moving data from one processor to another more expensive). This may
> lead to increase the latency of RT_tasks. Moreover, as my current
> application runs over multiple VME CPUs, I would like the migration to
> Xenomai environment to keep this ressources cutting (for performance,
> cleanliness and abstraction reasons). I think that being able to allocate
> the execution of linux kernel to a precise CPU would be interesting.
>
> Well, I tried some manipulations in order to reach this goal. I tried to
> boot with NOSMP, MAXCPUS or CPUMASK boot options and this has no effect or
> freezes during boot. I haven't found other solution to force the allocation
> of only one CPU ressource to the linux kernel.

kernel options generally are in small caps. The option you are looking
for is "isolcpus", as described in Documetation/cpusets.txt in Linux
sources.

Xenomai allow setting the default CPU affinity with /proc/affinity. Note
however that this is only a default CPU affinity, tasks may choose
another affinity.

-- 


					    Gilles.

