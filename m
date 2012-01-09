From: Arnout Vandecappelle <arnout@domain.hid>
Date: Mon, 9 Jan 2012 11:26:51 +0100
References: <201112211526.08983.arnout@domain.hid>
In-Reply-To: <201112211526.08983.arnout@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201201091126.51694.arnout@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and SMP load balancing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Wednesday 21 December 2011 15:26:08 Arnout Vandecappelle wrote:
>  [Please keep me in CC]
> 
>  Hoi all,
> 
>  I have a Xenomai application that I run on an SMP processor (i3 or i5).  
> It takes about 90% load on one of the cores (cpu0).  The rest of the system 
> is usually idle, except for occasional runs of some compute-intensive batch 
> processes (that run in the non-RT Linux domain).
> 
>  The problem is that the Linux load balancer doesn't know about the
> Xenomai thread.  It therefore tends to select cpu0 as well for the
> batch processes.  That means that the batch processes take much longer
> then needed.
> 
>  I can solve this by reserving one complete core for the Xenomai thread
> (by setting /proc/xenomai/affinity to 1 and giving the isolcpus=0 at boot
> time).  But this makes it difficult to move to a non-SMT platform, or
> to run several Xenomai applications on different cores.
> 
>  Is there a better way to let the Linux load balancer take into account
> the load of the Xenomai threads?

 Ping?

 Also, for the benefit of others, I now have a more flexible way to assign
separate cpus to Xenomai and Linux.  Below is a scriptlet that implements
it.

 I have also seen that something like this is really needed to get reasonable
predictability on x86 processors.  Without it, the jitter on latency is much
higher if there is even the slightest amount of work to be done in the Linux
domain (in my case, just sending the output of the latency benchmark over ssh 
once per second increases the jitter on latency tenfold).  I guess this is due
to cache effects when a Linux thread gets scheduled between runs of a Xenomai
task.

 Also note that this does not remove all Linux work from the CPU that is
reserved for Xenomai: I found that the following kernel work may still run
on it.

- Some kernel threads are created per CPU.  These cannot be (re)moved.  They
may execute due to e.g. interrupts.

- All kernel threads that are created later on will be schedulable on any
CPU, because the CPU mask is not inherited for kernel threads.  The only
work-around I found is to reassign the kernel thread back to the root cpuset
and again to the other cpuset after it is created.  E.g., after mounting a
journalling filesystem I move the kjournald thread back to / and again to
/other.  Hugely annoying, that.

- It looks like some per-cpu administration has to execute per cpu as well.
As a result, when a CPU is completely occupied by Xenomai tasks (which means
no Linux code ever executes on it), the entire Linux domain will freeze.
Of course, occupying a CPU 100% with Xenomai work is usually not a good idea
anyway.


 Hopefully this information will be useful for other people using Xenomai on
x86 SMP processors.

 Regards,
 Arnout



---------------------------------------------------------------------------
# Setup processor allocation
# We define two CPU sets: 'xenomai' and 'other'.
# For a single model, the 'xenomai' CPU set contains a single cpu
# All existing tasks are migrated to the 'other' CPU set
cpulist=$(echo /sys/devices/system/cpu/cpu[0-9]* | sed 's%/sys/devices/system/cpu/cpu%%g' | tr ' ' ,)
last_cpu=$(echo $cpulist | sed s/.*,//)
# Skip the whole cpuset thing if there is only one cpu
if [ $last_cpu != 0 ]; then
	echo "Preparing cpu sets for Xenomai on cpu $last_cpu"
	mkdir -p /dev/cpuset
	mount -t cgroup -ocpuset cgroup /dev/cpuset

	# other: all except last_cpu, mem is same as root
	mkdir /dev/cpuset/other
	/bin/echo $cpulist | sed s/,$last_cpu// > /dev/cpuset/other/cpuset.cpus
	cat /dev/cpuset/cpuset.mems > /dev/cpuset/other/cpuset.mems

	# Move all existing tasks to the 'other' cgroup
	for task in `cat /dev/cpuset/tasks`; do
		/bin/echo $task > /dev/cpuset/other/tasks || echo "Failed to move PID $task"
	done

	# Reset the Xenomai CPU to make sure that all kernel threads are moved off it
	# *** This must be done before xenomai modules are loaded ***
	# I'm not sure if this is needed at all.
	echo "Resetting cpu $last_cpu"
	echo 0 > /sys/devices/system/cpu/cpu${last_cpu}/online
	echo 1 > /sys/devices/system/cpu/cpu${last_cpu}/online

	# xenomai: only last_cpu
	# This must be done after resetting, because offline cpus are removed from cpusets
	mkdir /dev/cpuset/xenomai
	/bin/echo $last_cpu > /dev/cpuset/xenomai/cpuset.cpus
	/bin/echo 1 > /dev/cpuset/xenomai/cpuset.cpu_exclusive
	cat /dev/cpuset/cpuset.mems > /dev/cpuset/xenomai/cpuset.mems
	# FIXME disable the thread siblings of the Xenomai cores /sys/devices/cpu/cpu$last_cpu/topology/thread_siblings

	# Move self to the 'xenomai' cgroup
	/bin/echo $$ > /dev/cpuset/xenomai/tasks || echo "Failed to move self (PID $$)"
fi

# load xenomai kernel modules (=realtime environment)
modprobe xeno_nucleus
modprobe xeno_native
modprobe xeno_rtdm
modprobe xeno_posix

# Set Xenomai affinity
let 'last_cpu_mask = 1 << last_cpu'
echo $last_cpu_mask > /proc/xenomai/affinity
echo -n "Set affinity to "; cat /proc/xenomai/affinity

# Start Xenomai applications
...

# Move back to other cpuset
if [ -d /dev/cpuset/other ]; then
	/bin/echo $$ > /dev/cpuset/other/tasks || echo "Failed to move self (PID $$)"
fi


-- 
Arnout Vandecappelle                               arnout at mind be
Senior Embedded Software Architect                 +32-16-286540
Essensium/Mind                                     http://www.mind.be
G.Geenslaan 9, 3001 Leuven, Belgium                BE 872 984 063 RPR Leuven
LinkedIn profile: http://www.linkedin.com/in/arnoutvandecappelle
GPG fingerprint:  7CB5 E4CC 6C2E EFD4 6E3D A754 F963 ECAB 2450 2F1F

