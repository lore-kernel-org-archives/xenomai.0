Date: Mon, 11 Apr 2022 14:15:34 +0800
Subject: rcu_preempt detected expedited stalls on CPUs/tasks
From: Ivan Jiang <jcgeforce@aliyun.com>
Message-ID: <066DE2BF-5884-4333-9E1D-5ACF7B904181@aliyun.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai--- via Xenomai <xenomai@xenomai.org>
Cc: Xenomai <xenomai-bounces@xenomai.org>

    Dear xenomais=EF=BC=9A

        When I used Intel I211 Ethernet chip (pcie 2 Gigibit) met rcu error=
 like below=EF=BC=9A
    	rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 5-..=
. } 5335 jiffies s: 37 root: 0x20/.
    	[  392.174721] rcu: blocking rcu_node structures:
    	[  392.179174] Task dump for CPU 5:
    	[  392.182411] kworker/5:2     R  running task        0   263      2 0=
x0000022a
    	[  392.189479] Workqueue: events igb_watchdog_task
    	[  392.194018] Call trace:
    	[  392.196471]  __switch_to+0xe8/0x138
    	[  392.199961]  0xffff800639210000

		Environment like this:
		Cobalt 3.1 ipipe 4.19.106 or 4.19.198 ARM64
		Starting commands isolcpus=3D1,2 xenomai.supported_cpus=3D0x06 nohz_full=3D1,2 =
rcu_nocbs=3D1,2 irqaffinity=3D0,3,4,5 nmi_interrupt=3D0
		Because I set irqaffinity on NRT cpus: CPU0 CPU3 CPU4 CPU5, so Task dump =
for CPU 0 3 4 5 randomly.
		And when the error messages appeared after 10 minutes, the system 's no l=
onger responded anything and I haven't done any threads with this Ethernet p=
ort just ping command.
		.config file contains such options:
    	CONFIG_NO_HZ_FULL =3D y
    	CONFIG_RCU_NOCB_CPU=3Dy
    	CONFIG_PREEMPT=3Dy
    	CONFIG_CPU_IDLE=3Dn
    	CONFIG_ARM_CPUIDLE=3Dn
    	CONFIG_CPU_FREQ=3Dn
    	Could you be pleased help me what could be the problem.
		
		Thank you.

    Best Regards=EF=BC=8C
    Ivan	







