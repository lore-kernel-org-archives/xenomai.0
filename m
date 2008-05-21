MIME-Version: 1.0
Date: Wed, 21 May 2008 17:53:08 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
Message-ID: <76427479026b1c06e23878a4716b76d5@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] =?utf-8?q?Linux_kernel_and_RT=5Ftask_CPUs_allocati?=
	=?utf-8?q?on?=
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I'm working on a multi-cpus workstation and I allocate the execution of
real time task to precise CPUs. As tasks are preempting linux kernel, thi=
s
last one executes itself over non loaded CPUs. I want to strictly separat=
e
the executions of tasks and linux kernel overs CPUs. The reason is that t=
he
architecture over which I'm working is a NUMA architecture and I have
noticed that context migrations are a little bit expensive (NUMA makes th=
e
cost of moving data from one processor to another more expensive). This m=
ay
lead to increase the latency of RT_tasks. Moreover, as my current
application runs over multiple VME CPUs, I would like the migration to
Xenomai environment to keep this ressources cutting (for performance,
cleanliness and abstraction reasons). I think that being able to allocate
the execution of linux kernel to a precise CPU would be interesting.

Well, I tried some manipulations in order to reach this goal. I tried to
boot with NOSMP, MAXCPUS or CPUMASK boot options and this has no effect o=
r
freezes during boot. I haven't found other solution to force the allocati=
on
of only one CPU ressource to the linux kernel.

Thanks in advance.

Matthieu



