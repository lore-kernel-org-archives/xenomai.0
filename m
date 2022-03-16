Date: Wed, 16 Mar 2022 16:02:02 +0800
Subject: Re: CONFIG_NO_HZ_FULL = y but still have arch-timer on isolation CPUs
From: Ivan Jiang <jcgeforce@aliyun.com>
Message-ID: <56C9C417-F4FC-49F6-AA67-3302DDEBFEE6@aliyun.com>
References: <16D8A720-E151-430B-AA1E-573A0F850121@aliyun.com>
 <MN2PR11MB42859CF57293F0BED314F2F6F2119@MN2PR11MB4285.namprd11.prod.outlook.com>
 <2521493B-7AD1-481A-BDB0-BC8225411986@aliyun.com>
 <MN2PR11MB4285C119BB085CE57D6AEA3CF2119@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB4285C119BB085CE57D6AEA3CF2119@MN2PR11MB4285.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Hongzhan=EF=BC=9A

	Seems the tsc=3Dreliable doesn't have effect.
	BTW tsc is the clock source of x86, I was wandering if it's the same usage=
 for ARM64?

Thank you.
Ivan

=EF=BB=BF=E5=9C=A8 2022/3/16 14:16=EF=BC=8C=E2=80=9CChen, Hongzhan=E2=80=9D<hongzhan.chen@intel.com> =E5=86=99=E5=
=85=A5:

    Hi Ivan

    According to the description "@sevko I found that I didn't need the noh=
z_full=3D (I think it's redundant given the isolcpus=3Dnohz) but I had to add ts=
c=3Dreliable, on CentOS 8 with kernel 4.18. =E2=80=93 Joshua Chia" , it seems that t=
here is solution with 4.18 , which should  work with 4.19?

    Regards

    Hongzhan Chen


    -----Original Message-----
    From: Ivan Jiang <jcgeforce@aliyun.com>=20
    Sent: Wednesday, March 16, 2022 1:55 PM
    To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
    Subject: Re: CONFIG_NO_HZ_FULL =3D y but still have arch-timer on isolati=
on CPUs

    Dear Hongzhan=EF=BC=9A

    	My kernel is 4.19.165, indeed remove xenomai, the phenomenon is the sa=
me.
    	Maybe it=E2=80=99s a bug in this kernel, and how can I trace this bug if it =
is fixed in some patch?
    	Thank you.

    Ivan

    =EF=BB=BF=E5=9C=A8 2022/3/16 11:30=EF=BC=8C=E2=80=9CChen, Hongzhan=E2=80=9D<hongzhan.chen@intel.com> =
=E5=86=99=E5=85=A5:

        Hi Ivan

        Hope that what discussed in  https://stackoverflow.com/questions/60=
322119/completely-eliminating-the-timer-tick-in-modern-linux-5-0 may help yo=
u.
        Seems that there need  do more settings for kernel parameters per y=
our requirement but I have not tried myself.  When you remove Xenomai,  the =
phenomenon is the same?

        Regards

        Hongzhan Chen

        -----Original Message-----
        From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Ivan Jiang=
 via Xenomai
        Sent: Tuesday, March 15, 2022 12:01 PM
        To: xenomai@xenomai.org
        Subject: CONFIG_NO_HZ_FULL =3D y but still have arch-timer on isolati=
on CPUs

        Dear Guys:



               I=E2=80=99ve set the configs like this

               CONFIG_NO_HZ_FULL =3D y

        CONFIG_RCU_NOCB_CPU=3Dy

        CONFIG_PREEMPT=3Dy

        CONFIG_CPU_IDLE=3Dn

        CONFIG_ARM_CPUIDLE=3Dn

        CONFIG_CPU_FREQ=3Dn=20

        And setenv isolcpus=3D1 xenomai.supported_cpus=3D0x02 nohz_full=3D1  irqa=
ffinity=3D0   rcu_nocbs=3D1

        The CPU is Cortex-A55 Dual core and I use CPU 0 as Linux CPU and CP=
U1 for isolation core.

        But cat /proc/interrupts still the arch_timers are increasing the s=
ame time on both CPUs.

        Seems NO_HZ_FULL =3D y has no effect.

        The boot log as below:

        [    0.000000] rcu: Preemptible hierarchical RCU implementation.

        [    0.000000] rcu:     RCU dyntick-idle grace-period acceleration =
is enabled.

        [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D8 to nr_c=
pu_ids=3D2.

        [    0.000000] rcu:     RCU priority boosting: priority 1 delay 500=
 ms.

        [    0.000000]  Tasks RCU enabled.

        [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_c=
pu_ids=3D2

        [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0

        [    0.000000] GICv3: Distributor has no Range Selector support

        [    0.000000] GICv3: no VLPI support, no direct LPI support

        [    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000=
0011940000

        [    0.000000] NO_HZ: Full dynticks CPUs: 1.

        [    0.000000] rcu:     Offload RCU callbacks from CPUs: 1.

        [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt)=
.

        Please help me to analysis this situation.



        Very appreciate,

        Chen.












