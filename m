Date: Mon, 11 Apr 2022 16:24:05 +0800
Subject: Re: rcu_preempt detected expedited stalls on CPUs/tasks
From: Ivan Jiang <jcgeforce@aliyun.com>
Message-ID: <9F8BCB86-C218-4DBE-81B4-E5F5E25DC8AE@aliyun.com>
References: <066DE2BF-5884-4333-9E1D-5ACF7B904181@aliyun.com>
 <PH0PR11MB58801714B5C99FF4DE04C88FDAEA9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58801714B5C99FF4DE04C88FDAEA9@PH0PR11MB5880.namprd11.prod.outlook.com>
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
To: "Zhang, Qiang1" <qiang1.zhang@intel.com>, xenomai--- via Xenomai <xenomai@xenomai.org>
Cc: Xenomai <xenomai-bounces@xenomai.org>

Dear Qiang=EF=BC=9A

	Another information like this:
	[  121.127758] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  121.133887] rcu:     0-...0: (5 ticks this GP) idle=3Db5a/1/0x400000000000=
0002 softirq=3D11605/11606 fqs=3D2336
[  121.143294] rcu:     (detected by 4, t=3D5255 jiffies, g=3D4137, q=3D10)
[  121.149225] Task dump for CPU 0:
[  121.152457] tcf-agent       R  running task        0   384      1 0x0000=
020a
[  121.159520] Call trace:
[  121.161987]  __switch_to+0xe8/0x138
[  121.165481]  0xffff000008e4c000
[  220.120678] audit: type=3D1701 audit(1649325109.997:4): auid=3D4294967295 ui=
d=3D0 gid=3D0 ses=3D4294967295 pid=3D241 comm=3D"systemd-journal" exe=3D"/lib/systemd/sy=
stemd-journald" sig=3D6 res=3D1
[  280.369229] systemd[1]: systemd-udevd.service: Watchdog timeout (limit 3=
min)!
[  280.376682] systemd[1]: systemd-udevd.service: Killing process 255 (syst=
emd-udevd) with signal SIGABRT.
[  280.386241] audit: type=3D1701 audit(1649325109.997:5): auid=3D4294967295 ui=
d=3D0 gid=3D0 ses=3D4294967295 pid=3D255 comm=3D"systemd-udevd" exe=3D"/lib/systemd/syst=
emd-udevd" sig=3D6 res=3D1
[  310.369200] systemd[1]: systemd-journald.service: State 'stop-sigabrt' t=
imed out. Terminating.
[  370.619174] systemd[1]: systemd-udevd.service: State 'stop-sigabrt' time=
d out. Terminating.
[  400.619175] systemd[1]: systemd-journald.service: State 'stop-sigterm' t=
imed out. Killing.
[  400.627584] systemd[1]: systemd-journald.service: Killing process 241 (s=
ystemd-journal) with signal SIGKILL.

Thank you.
BR.,
Ivan


=EF=BB=BF=E5=9C=A8 2022/4/11 16:11=EF=BC=8C=E2=80=9CZhang, Qiang1=E2=80=9D<qiang1.zhang@intel.com> =E5=86=99=E5=85=A5=
:


        Dear xenomais=EF=BC=9A

            When I used Intel I211 Ethernet chip (pcie 2 Gigibit) met rcu e=
rror like below=EF=BC=9A
        	rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { =
5-... } 5335 jiffies s: 37 root: 0x20/.
        	[  392.174721] rcu: blocking rcu_node structures:
        	[  392.179174] Task dump for CPU 5:
        	[  392.182411] kworker/5:2     R  running task        0   263     =
 2 0x0000022a
        	[  392.189479] Workqueue: events igb_watchdog_task
        	[  392.194018] Call trace:
        	[  392.196471]  __switch_to+0xe8/0x138
        	[  392.199961]  0xffff800639210000

    Hi, Please provide full  rcu stall information, this info indicate the =
CPU5 can not notice rcu quiescent state,
    This may be because the status cannot be reported in time due to disabl=
e interrupts or preemption long time etc
     you can see Documentation/RCU/stallwarn.rst.

    Thanks
    Zqiang



    		Environment like this:
    		Cobalt 3.1 ipipe 4.19.106 or 4.19.198 ARM64
    		Starting commands isolcpus=3D1,2 xenomai.supported_cpus=3D0x06 nohz_full=3D=
1,2 rcu_nocbs=3D1,2 irqaffinity=3D0,3,4,5 nmi_interrupt=3D0
    		Because I set irqaffinity on NRT cpus: CPU0 CPU3 CPU4 CPU5, so Task d=
ump for CPU 0 3 4 5 randomly.
    		And when the error messages appeared after 10 minutes, the system 's =
no longer responded anything and I haven't done any threads with this Ethern=
et port just ping command.
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










