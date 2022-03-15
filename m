Date: Tue, 15 Mar 2022 12:01:24 +0800
Subject: CONFIG_NO_HZ_FULL = y but still have arch-timer on isolation CPUs
From: Ivan Jiang <jcgeforce@aliyun.com>
Message-ID: <16D8A720-E151-430B-AA1E-573A0F850121@aliyun.com>
Mime-version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Guys:

=20

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=E2=80=99ve set the configs like this

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_NO_HZ_FULL =3D y

CONFIG_RCU_NOCB_CPU=3Dy

CONFIG_PREEMPT=3Dy

CONFIG_CPU_IDLE=3Dn

CONFIG_ARM_CPUIDLE=3Dn

CONFIG_CPU_FREQ=3Dn=20

And setenv isolcpus=3D1 xenomai.supported_cpus=3D0x02 nohz_full=3D1=C2=A0 irqaffinity=
=3D0=C2=A0=C2=A0 rcu_nocbs=3D1

The CPU is Cortex-A55 Dual core and I use CPU 0 as Linux CPU and CPU1 for i=
solation core.

But cat /proc/interrupts still the arch_timers are increasing the same time=
 on both CPUs.

Seems NO_HZ_FULL =3D y has no effect.

The boot log as below:

[=C2=A0=C2=A0=C2=A0 0.000000] rcu: Preemptible hierarchical RCU implementation.

[=C2=A0=C2=A0=C2=A0 0.000000] rcu:=C2=A0=C2=A0=C2=A0=C2=A0 RCU dyntick-idle grace-period acceleration i=
s enabled.

[=C2=A0=C2=A0=C2=A0 0.000000] rcu:=C2=A0=C2=A0=C2=A0=C2=A0 RCU restricting CPUs from NR_CPUS=3D8 to nr_cp=
u_ids=3D2.

[=C2=A0=C2=A0=C2=A0 0.000000] rcu:=C2=A0=C2=A0=C2=A0=C2=A0 RCU priority boosting: priority 1 delay 500 =
ms.

[=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 Tasks RCU enabled.

[=C2=A0=C2=A0=C2=A0 0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_id=
s=3D2

[=C2=A0=C2=A0=C2=A0 0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0

[=C2=A0=C2=A0=C2=A0 0.000000] GICv3: Distributor has no Range Selector support

[=C2=A0=C2=A0=C2=A0 0.000000] GICv3: no VLPI support, no direct LPI support

[=C2=A0=C2=A0=C2=A0 0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000119=
40000

[=C2=A0=C2=A0=C2=A0 0.000000] NO_HZ: Full dynticks CPUs: 1.

[=C2=A0=C2=A0=C2=A0 0.000000] rcu:=C2=A0=C2=A0=C2=A0=C2=A0 Offload RCU callbacks from CPUs: 1.

[=C2=A0=C2=A0=C2=A0 0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt).

Please help me to analysis this situation.

=20

Very appreciate,

Chen.

=20

=20

=20

