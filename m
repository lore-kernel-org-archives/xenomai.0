Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B01FC8
	for <xenomai@lists.linux.dev>; Wed, 29 Jul 2026 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305120; cv=none; b=HzSfTiUNBWaAs2WFsirsO6GS/ospeqffLKGRdjaWjqHyOd1Di1K13npdvsTpElEf4e7z9CHzzB7VG3oQvaFEv+HSdEnvgGk1WJ55ylpm/nYYL4Mb0o7VJ1GbH5iEESOoiSi+/iMfjvvnZSUCdlTEcVeNHNePc0nL43bgbRKR/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305120; c=relaxed/simple;
	bh=fG90kGDAC4z0gu7XoyD9mX3yrYB6DFYrQukMz53j4S8=;
	h=In-Reply-To:Date:Message-Id:Cc:From:Content-Type:To:Subject:
	 Mime-Version:References; b=uXspknV5MVB13ULWpXSz/Jc5DiBZY4AmLvjQtmP/xLBfzmepE2+wFFtyE7hOQfBqJXnWD1i3jNUSh5x6PSqQgnmHdYWObPp9ecZIBtKcCr+NyX1iwoZWJ3F+JggmbGW/cRX9qoaWzio7IuCc9rTzssynx+tajBYNOX1H5CBZG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07469732|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.050069-0.000670291-0.949261;FP=12169492638769771643|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.iY5ZfgP_1785305104;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.iY5ZfgP_1785305104 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 14:05:04 +0800
X-Lms-Return-Path: <lba+16a69980d+aa6fa3+siemens.com+liuyang@sinsegye.com.cn>
In-Reply-To: <480ff592-a77e-4d9b-957b-aa856e41821e@siemens.com>
Date: Wed, 29 Jul 2026 14:05:00 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5571d0ff.0b5a.4df0.8cd4.bf262a5fca73@feishu.cn>
Cc: "xenomai" <xenomai@lists.linux.dev>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel Ultra 5 125H
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.38eb388a.cbef.4959.96f3.b61a0b0ee8f9@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5cc6cb43.b732.48d7.97db.585e1489779a@feishu.cn>
	<480ff592-a77e-4d9b-957b-aa856e41821e@siemens.com>

Hi.
=C2=A0=C2=A0 =C2=A0I have already performed the following tests:
1. Linux 6.18.20 + Xenomai 3.3.1: the system hangs during boot, but SSH log=
in is still possible.
2. Linux 6.12.90 + Xenomai 3.3.1: the system completely freezes (hard lock)=
.
3. Linux 6.12.55 + GRUB configuration with xenomai.state=3Ddisabled: the sy=
stem freezes.
4. Linux 6.12.55 without Dovetail and Cobalt: the system runs normally.
5.Linux 6.12.55 + xenomai 3.3.1=C2=A0 Using the Xe driver instead of i915 =
=C2=A0 the system freezes.
6.Linux 6.12.55 + xenomai 3.3.1 and nvidia_uvn.ko with uvm_disable_hmm=3D1 =
uvm_perf_prefetch_enable=3D0 =C2=A0=C2=A0 the system freezes.

CONFIG_XENO_OPT_WATCHDOG is enbale and set to 30.

On Ubuntu 24.04, I monitored the CPU; the CPU utilisation is around 30%. A =
Gemini 360L camera is connected to the USB controller. I ran nvidia-smi=C2=
=A0and obtained the following output (please provide the output if you need=
 further analysis).
There is also an f81601a CAN interface connected to the machine, which uses=
 CAN FD to connect six motors.
+--------------------------------------------------------------------------=
---------------+
| NVIDIA-SMI 580.173.02 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Driver Ve=
rsion: 580.173.02 =C2=A0 =C2=A0 CUDA Version: 13.0 =C2=A0 =C2=A0 |
+-----------------------------------------+------------------------+-------=
---------------+
| GPU=C2=A0 Name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Pe=
rsistence-M | Bus-Id =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 Disp.A | Volatile Un=
corr. ECC |
| Fan=C2=A0 Temp =C2=A0 Perf =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 Pwr:Usage/Ca=
p | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory-Usage | GPU-Util=C2=A0 Comput=
e M. |
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIG M. |
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
| =C2=A0 0=C2=A0 NVIDIA GeForce RTX 4060 ... =C2=A0=C2=A0 Off | =C2=A0 0000=
0000:01:00.0 Off | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=C2=A0 N/A |
| N/A =C2=A0 37C =C2=A0=C2=A0 P0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
27W /=C2=A0 115W | =C2=A0 =C2=A0 141MiB / =C2=A0 8188MiB | =C2=A0 =C2=A0=C2=
=A0 1% =C2=A0 =C2=A0=C2=A0 Default |
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 N/A |
+-----------------------------------------+------------------------+-------=
---------------+

+--------------------------------------------------------------------------=
---------------+
| Processes: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 |
|=C2=A0 GPU =C2=A0 GI =C2=A0 CI =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=C2=A0 PID =C2=A0 Type =C2=A0 Process name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 GPU Memory |
| =C2=A0 =C2=A0 =C2=A0=C2=A0 ID =C2=A0 ID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Usage =C2=A0 =C2=A0=C2=A0 |
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
| =C2=A0=C2=A0 0 =C2=A0 N/A=C2=A0 N/A =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0 1892 =C2=A0 =C2=A0=C2=A0 C =C2=A0 /usr/NX/bin/nxnode.bin =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 131MiB |
+--------------------------------------------------------------------------=
---------------+



> From: "Jan Kiszka"<jan.kiszka@siemens.com>
> Date:=C2=A0 Wed, Jul 29, 2026, 13:30
> Subject:=C2=A0 Re: Fw: Random system freezes with Linux 6.12 + Xenomai 3.=
3.1 on Intel Ultra 5 125H
> To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>, "xenomai"<xenomai@list=
s.linux.dev>
> Cc: "=E5=AE=8B=E5=81=A5=E7=8E=AE"<songjianwei@sinsegye.com.cn>
> On 29.07.26 01:38, =E5=88=98=E6=9D=A8 wrote:
> > Hi Xenomai team,
> > I am using Linux 6.12 with Xenomai 3.3.1 on an Intel Ultra 5 125H platf=
orm. The kernel randomly freezes, causing the entire system to hang. Below =
is my environment.
> > =E2=80=A2 Platform: Intel Ultra 5 125H + NVIDIA 4060 GPU
> > =E2=80=A2 Linux version: 6.12.55
> > =E2=80=A2 Xenomai=C2=A0version: 3.3.1
>=C2=A0
> Already tried to update to latest versions? Also if varying the major
> kernel version makes any difference?
>=C2=A0
> > =E2=80=A2 Linux grub parameters:
> > isolcpus=3D0,1 nohz=3D0,1 nohz_full=3D0,1 rcu_nocbs=3D0,1 rcu_nocb_poll=
 acpi_irq_nobalance noirqbalance processor.max_cstate=3D0 processor_idle.ma=
x_cstate=3D0 intel_idle.max_cstate=3D0 clocksource=3Dtsc tsc=3Dreliable hpe=
t=3Ddisable nmi_watchdog=3D0 nowatchdog nosoftlockup softlockup_panic=3D0 s=
elinux=3D0 enforcing=3D0 intel_pstate=3Ddisable idle=3Dpoll cpuidle.off=3D1=
 nohalt nosmap pcie_port_pm=3Doff pcie_aspm.policy=3Dperformance ahci.mobil=
e_lpm_policy=3D1 mce=3Doff numa_balancing=3Ddisable apparmor=3D1 mem_sleep_=
default=3Ddeep console=3Dtty console=3DttyS0,115200n8 splash ibt=3Doff usbc=
ore.usbfs_memory_mb=3D512 vt.handoff=3D7
> > =E2=80=A2 Use case: Humanoid robot
> > =E2=80=A2 Applications: ROS2, CUDA 13
>=C2=A0
> Okay... CUDA. Implies you are using an Nvidia driver - which one, binary
> or OSS?
>=C2=A0
> > The following is the log captured via serial port before the system fro=
ze:
> > =C2=A0=C2=A0 =C2=A0fiveages@W2-0000:~$ [34822.953313] i915 0000:00:02.0=
: [drm] *ERROR* GT0: GUC: TLB invalidation response timed out for seqno 686=
39
> > [34824.808351] xhci_hcd 0000:00:0d.0: xHCI host controller not respondi=
ng, assume dead
> > [34824.816041] xhci_hcd 0000:00:0d.0: HC died; cleaning up
> > [34825.000349] i915 0000:00:02.0: [drm] *ERROR* GT0: GUC: TLB invalidat=
ion response timed out for seqno 68640
> > [34870.898076] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [34870.904192] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x400000000000=
0000 softirq=3D12697480/12697481 fqs=3D15002
> > [34870.913954] rcu: (detected by 1, t=3D60017 jiffies, g=3D24464761, q=
=3D13288 ncpus=3D12)
>=C2=A0
> What is the systems's workload at this point? Is there possibly some RT
> thread running 100% of the time on some core? Do you have
> CONFIG_XENO_OPT_WATCHDOG enabled?
>=C2=A0
> Also, can you only reproduce this when the CUDA stack is in use?
>=C2=A0
> Jan
>=C2=A0
> --=C2=A0
> Siemens AG, Foundational Technologies
> Linux Expert Center
>=C2=A0
