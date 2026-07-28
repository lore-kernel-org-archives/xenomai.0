Received: from out28-115.mail.aliyun.com (out28-115.mail.aliyun.com [115.124.28.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308C4248AE
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281935; cv=none; b=K1dM+28gZIorzZjbcX/TlopP54SiIohnkBg90QQ2Z8ntY1bm3cPIcwWleAMjCHZmw2Z8/+fJfHAc84caHJbjc0cHv/pqsbhNTOv5xQWJbwU7ckj/UvK8WfcMIE6PNaP6TequPSRtstAvWGJsZ63URYA2Jj12g5EDDFR02c7CKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281935; c=relaxed/simple;
	bh=Hb0ijP8Ge+cIrBRA3ML6hVeiEwpXVRr+pPVbwlQ6J+Q=;
	h=To:Cc:Mime-Version:In-Reply-To:Date:Message-Id:Subject:From:
	 References:Content-Type; b=qs9YmC4f7+e2An5ngf8HYgzsWE/fI5IVVWnrKIWpjTz9T5lCEjUOPK6MBSQ6DPmkhVLFWV8mNXk30L8jeWxUIfGONcGRpknRA8YiaYfJS2SZ5YSIXuZvvJIaR0rhu2R+yjRn1qsKj1L/Q/+zf8yH+/b3e/5SqMqvXaJF8Ustl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;BR=01201311R111S70rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0056039-0.000177224-0.994219;FP=7126851388505089147|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.iXo1VtM_1785281918;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.iXo1VtM_1785281918 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 07:38:38 +0800
To: "xenomai" <xenomai@lists.linux.dev>
Cc: =?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.38eb388a.cbef.4959.96f3.b61a0b0ee8f9@feishu.cn>
X-Lms-Return-Path: <lba+16a693d7c+ec280c+lists.linux.dev+liuyang@sinsegye.com.cn>
Date: Wed, 29 Jul 2026 07:38:35 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5cc6cb43.b732.48d7.97db.585e1489779a@feishu.cn>
Subject: Fw: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel Ultra 5 125H
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn>
	<ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.38eb388a.cbef.4959.96f3.b61a0b0ee8f9@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Xenomai team,
I am using Linux 6.12 with Xenomai 3.3.1 on an Intel Ultra 5 125H platform.=
 The kernel randomly freezes, causing the entire system to hang. Below is m=
y environment.
=E2=80=A2 Platform: Intel Ultra 5 125H + NVIDIA 4060 GPU
=E2=80=A2 Linux version: 6.12.55
=E2=80=A2 Xenomai=C2=A0version: 3.3.1
=E2=80=A2 Linux grub parameters:
isolcpus=3D0,1 nohz=3D0,1 nohz_full=3D0,1 rcu_nocbs=3D0,1 rcu_nocb_poll acp=
i_irq_nobalance noirqbalance processor.max_cstate=3D0 processor_idle.max_cs=
tate=3D0 intel_idle.max_cstate=3D0 clocksource=3Dtsc tsc=3Dreliable hpet=3D=
disable nmi_watchdog=3D0 nowatchdog nosoftlockup softlockup_panic=3D0 selin=
ux=3D0 enforcing=3D0 intel_pstate=3Ddisable idle=3Dpoll cpuidle.off=3D1 noh=
alt nosmap pcie_port_pm=3Doff pcie_aspm.policy=3Dperformance ahci.mobile_lp=
m_policy=3D1 mce=3Doff numa_balancing=3Ddisable apparmor=3D1 mem_sleep_defa=
ult=3Ddeep console=3Dtty console=3DttyS0,115200n8 splash ibt=3Doff usbcore.=
usbfs_memory_mb=3D512 vt.handoff=3D7
=E2=80=A2 Use case: Humanoid robot
=E2=80=A2 Applications: ROS2, CUDA 13
The following is the log captured via serial port before the system froze:
=C2=A0=C2=A0 =C2=A0fiveages@W2-0000:~$ [34822.953313] i915 0000:00:02.0: [d=
rm] *ERROR* GT0: GUC: TLB invalidation response timed out for seqno 68639
[34824.808351] xhci_hcd 0000:00:0d.0: xHCI host controller not responding, =
assume dead
[34824.816041] xhci_hcd 0000:00:0d.0: HC died; cleaning up
[34825.000349] i915 0000:00:02.0: [drm] *ERROR* GT0: GUC: TLB invalidation =
response timed out for seqno 68640
[34870.898076] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[34870.904192] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D15002
[34870.913954] rcu: (detected by 1, t=3D60017 jiffies, g=3D24464761, q=3D13=
288 ncpus=3D12)
[35050.929874] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[35050.935989] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D60007
[35050.945750] rcu: (detected by 0, t=3D240046 jiffies, g=3D24464761, q=3D1=
3578 ncpus=3D12)
[35230.957555] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[35230.963675] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D105009
[35230.973526] rcu: (detected by 9, t=3D420069 jiffies, g=3D24464761, q=3D1=
3869 ncpus=3D12)
[35410.989152] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[35410.995260] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D150015
[35411.005105] rcu: (detected by 3, t=3D600097 jiffies, g=3D24464761, q=3D1=
4133 ncpus=3D12)
[35466.699345] iwlwifi 0000:04:00.0: Microcode SW error detected. Restartin=
g 0x1FF8.
[35466.706918] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[35466.712509] iwlwifi 0000:04:00.0: Transport status: 0x0000004A, valid: 6
[35466.719233] iwlwifi 0000:04:00.0: Loaded firmware version: 89.7207fc64.0=
 ty-a0-gf-a0-89.ucode
[35466.727778] iwlwifi 0000:04:00.0: 0x000022CE | ADVANCED_SYSASSERT =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0
[35466.734763] iwlwifi 0000:04:00.0: 0x000002F0 | trm_hw_status0
[35466.740529] iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
[35466.746289] iwlwifi 0000:04:00.0: 0x004DACB4 | branchlink2
[35466.751796] iwlwifi 0000:04:00.0: 0x004D0906 | interruptlink1
[35466.757562] iwlwifi 0000:04:00.0: 0x004D0906 | interruptlink2
[35466.763322] iwlwifi 0000:04:00.0: 0x0000016C | data1
[35466.768303] iwlwifi 0000:04:00.0: 0x00000000 | data2
[35466.773283] iwlwifi 0000:04:00.0: 0x04000000 | data3
[35466.778263] iwlwifi 0000:04:00.0: 0x4C80B569 | beacon time
[35466.783763] iwlwifi 0000:04:00.0: 0xA4C0B9C7 | tsf low
[35466.788915] iwlwifi 0000:04:00.0: 0x0000003D | tsf hi
[35466.793984] iwlwifi 0000:04:00.0: 0x00000000 | time gp1
[35466.799228] iwlwifi 0000:04:00.0: 0x41360C69 | time gp2
[35466.804472] iwlwifi 0000:04:00.0: 0x00000001 | uCode revision type
[35466.810666] iwlwifi 0000:04:00.0: 0x00000059 | uCode version major
[35466.816860] iwlwifi 0000:04:00.0: 0x7207FC64 | uCode version minor
[35466.823068] iwlwifi 0000:04:00.0: 0x00000420 | hw version
[35466.828483] iwlwifi 0000:04:00.0: 0x00C80002 | board version
[35466.834166] iwlwifi 0000:04:00.0: 0x8099FC18 | hcmd
[35466.839060] iwlwifi 0000:04:00.0: 0xE2F80000=C2=A0| isr0
[35466.843968] iwlwifi 0000:04:00.0: 0x00004000 | isr1
[35466.848863] iwlwifi 0000:04:00.0: 0x40F80002 | isr2
[35466.853757] iwlwifi 0000:04:00.0: 0x44D3201C | isr3
[35466.858652] iwlwifi 0000:04:00.0: 0x00000000 | isr4
[35466.863553] iwlwifi 0000:04:00.0: 0x0404001C | last cmd Id
[35466.869059] iwlwifi 0000:04:00.0: 0x0001010E | wait_event
[35466.874474] iwlwifi 0000:04:00.0: 0x00004208 | l2p_control
[35466.879981] iwlwifi 0000:04:00.0: 0x00000022 | l2p_duration
[35466.885573] iwlwifi 0000:04:00.0: 0x0000033F | l2p_mhvalid
[35466.891080] iwlwifi 0000:04:00.0: 0x00E60898 | l2p_addr_match
[35466.896839] iwlwifi 0000:04:00.0: 0x0000000B | lmpm_pmg_sel
[35466.902438] iwlwifi 0000:04:00.0: 0x00000000 | timestamp
[35466.907774] iwlwifi 0000:04:00.0: 0x09509898 | flow_handler
[35466.913396] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[35466.918991] iwlwifi 0000:04:00.0: Transport status: 0x0000004A, valid: 7
[35466.925712] iwlwifi 0000:04:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[35466.932347] iwlwifi 0000:04:00.0: 0x00000000 | umac branchlink1
[35466.938284] iwlwifi 0000:04:00.0: 0x804838C2 | umac branchlink2
[35466.944216] iwlwifi 0000:04:00.0: 0x804A5DA6 | umac interruptlink1
[35466.950410] iwlwifi 0000:04:00.0: 0x804A5DA6 | umac interruptlink2
[35466.956604] iwlwifi 0000:04:00.0: 0x00000002 | umac data1
[35466.962019] iwlwifi 0000:04:00.0: 0x804A5DA6 | umac data2
[35466.967434] iwlwifi 0000:04:00.0: 0x00000000 | umac data3
[35466.972848] iwlwifi 0000:04:00.0: 0x00000059 | umac major
[35466.978262] iwlwifi 0000:04:00.0: 0x7207FC64 | umac minor
[35466.983678] iwlwifi 0000:04:00.0: 0x41360F3C | frame pointer
[35466.989352] iwlwifi 0000:04:00.0: 0xC0886258 | stack pointer
[35466.995034] iwlwifi 0000:04:00.0: 0x00DB010C | last host cmd
[35467.000709] iwlwifi 0000:04:00.0: 0x00000000 | isr status reg
[35467.006478] iwlwifi 0000:04:00.0: IML/ROM dump:
[35467.011026] iwlwifi 0000:04:00.0: 0x00000B03 | IML/ROM error/state
[35467.017234] iwlwifi 0000:04:00.0: 0x00007FBF | IML/ROM data1
[35467.022920] iwlwifi 0000:04:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[35467.029473] iwlwifi 0000:04:00.0: Fseq Registers:
[35467.034204] iwlwifi 0000:04:00.0: 0x60000000 | FSEQ_ERROR_CODE
[35467.040063] iwlwifi 0000:04:00.0: 0x80440007 | FSEQ_TOP_INIT_VERSION
[35467.046435] iwlwifi 0000:04:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[35467.052991] iwlwifi 0000:04:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[35467.058935] iwlwifi 0000:04:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[35467.065575] iwlwifi 0000:04:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[35467.071520] iwlwifi 0000:04:00.0: 0x00400410 | FSEQ_CNVI_ID
[35467.077119] iwlwifi 0000:04:00.0: 0x00400410 | FSEQ_CNVR_ID
[35467.082712] iwlwifi 0000:04:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[35467.088837] iwlwifi 0000:04:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[35467.094956] iwlwifi 0000:04:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[35467.102809] iwlwifi 0000:04:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[35467.111009] iwlwifi 0000:04:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[35467.117994] iwlwifi 0000:04:00.0: 0x00440007 | FSEQ_WIFI_FSEQ_VERSION
[35467.124458] iwlwifi 0000:04:00.0: 0x399EF8BA | FSEQ_BT_FSEQ_VERSION
[35467.130752] iwlwifi 0000:04:00.0: 0x000000F0 | FSEQ_CLASS_TP_VERSION
[35467.137130] iwlwifi 0000:04:00.0: UMAC CURRENT PC: 0x804a586c
[35467.142896] iwlwifi 0000:04:00.0: LMAC1 CURRENT PC: 0xd0
[35591.020689] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[35591.026804] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[35591.036653] rcu: (detected by 0, t=3D780129 jiffies, g=3D24464761, q=3D1=
4219 ncpus=3D12)
[35591.045149] rcu: rcu_preempt kthread starved for 123893 jiffies! g244647=
61 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[35591.055863] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[35591.065007] rcu: RCU grace-period kthread stack dump:
[35591.070104] rcu: Stack dump where RCU GP kthread last ran:
[35771.078187] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[35771.084300] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[35771.094144] rcu: (detected by 0, t=3D960184 jiffies, g=3D24464761, q=3D1=
4249 ncpus=3D12)
[35771.102648] rcu: rcu_preempt kthread starved for 303948 jiffies! g244647=
61 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[35771.113369] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[35771.122512] rcu: RCU grace-period kthread stack dump:
[35771.127603] rcu: Stack dump where RCU GP kthread last ran:
[35951.135658] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[35951.141771] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[35951.151615] rcu: (detected by 0, t=3D1140235 jiffies, g=3D24464761, q=3D=
14279 ncpus=3D12)
[35951.160205] rcu: rcu_preempt kthread starved for 484004 jiffies! g244647=
61 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[35951.170925] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[35951.180069] rcu: RCU grace-period kthread stack dump:
[35951.185160] rcu: Stack dump where RCU GP kthread last ran:
[36131.194105] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[36131.200211] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[36131.210057] rcu: (detected by 3, t=3D1320295 jiffies, g=3D24464761, q=3D=
14309 ncpus=3D12)
[36131.218640] rcu: rcu_preempt kthread starved for 664063 jiffies! g244647=
61 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[36131.229356] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[36131.238500] rcu: RCU grace-period kthread stack dump:
[36131.243595] rcu: Stack dump where RCU GP kthread last ran:
[36311.256539] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[36311.262652] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[36311.272497] rcu: (detected by 0, t=3D1500355 jiffies, g=3D24464761, q=3D=
14339 ncpus=3D12)
[36311.281078] rcu: rcu_preempt kthread starved for 844119 jiffies! g244647=
61 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[36311.291791] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[36311.300936] rcu: RCU grace-period kthread stack dump:
[36311.306028] rcu: Stack dump where RCU GP kthread last ran:
[36491.318965] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[36491.325077] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[36491.334930] rcu: (detected by 0, t=3D1680415 jiffies, g=3D24464761, q=3D=
14369 ncpus=3D12)
[36491.343512] rcu: rcu_preempt kthread starved for 1024179 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[36491.354311] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[36491.363455] rcu: RCU grace-period kthread stack dump:
[36491.368546] rcu: Stack dump where RCU GP kthread last ran:
[36671.381381] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[36671.387494] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[36671.397339] rcu: (detected by 0, t=3D1860475 jiffies, g=3D24464761, q=3D=
14399 ncpus=3D12)
[36671.405928] rcu: rcu_preempt kthread starved for 1204239 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[36671.416728] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[36671.425872] rcu: RCU grace-period kthread stack dump:
[36671.430964] rcu: Stack dump where RCU GP kthread last ran:
[36851.443794] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[36851.449907] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[36851.459755] rcu: (detected by 0, t=3D2040535 jiffies, g=3D24464761, q=3D=
14429 ncpus=3D12)
[36851.468336] rcu: rcu_preempt kthread starved for 1384299 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[36851.479136] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[36851.488287] rcu: RCU grace-period kthread stack dump:
[36851.493379] rcu: Stack dump where RCU GP kthread last ran:
[37031.506203] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[37031.512316] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[37031.522161] rcu: (detected by 0, t=3D2220595 jiffies, g=3D24464761, q=3D=
14459 ncpus=3D12)
[37031.530748] rcu: rcu_preempt kthread starved for 1564359 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[37031.541556] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[37031.550700] rcu: RCU grace-period kthread stack dump:
[37031.555790] rcu: Stack dump where RCU GP kthread last ran:
[37211.568611] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[37211.574725] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[37211.584576] rcu: (detected by 0, t=3D2400651 jiffies, g=3D24464761, q=3D=
14489 ncpus=3D12)
[37211.593157] rcu: rcu_preempt kthread starved for 1744420 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[37211.603957] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[37211.613109] rcu: RCU grace-period kthread stack dump:
[37211.618202] rcu: Stack dump where RCU GP kthread last ran:
[37391.627015] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[37391.633134] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[37391.642979] rcu: (detected by 0, t=3D2580711 jiffies, g=3D24464761, q=3D=
14519 ncpus=3D12)
[37391.651561] rcu: rcu_preempt kthread starved for 1924475 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[37391.662362] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[37391.671504] rcu: RCU grace-period kthread stack dump:
[37391.676596] rcu: Stack dump where RCU GP kthread last ran:
[37571.689419] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[37571.695532] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[37571.705385] rcu: (detected by 0, t=3D2760771 jiffies, g=3D24464761, q=3D=
14549 ncpus=3D12)
[37571.713974] rcu: rcu_preempt kthread starved for 2104535 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[37571.724775] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[37571.733924] rcu: RCU grace-period kthread stack dump:
[37571.739023] rcu: Stack dump where RCU GP kthread last ran:
[37751.751822] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[37751.757934] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[37751.767779] rcu: (detected by 0, t=3D2940827 jiffies, g=3D24464761, q=3D=
14579 ncpus=3D12)
[37751.776368] rcu: rcu_preempt kthread starved for 2284596 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[37751.787168] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[37751.796312] rcu: RCU grace-period kthread stack dump:
[37751.801404] rcu: Stack dump where RCU GP kthread last ran:
[37931.810222] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[37931.816333] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[37931.826181] rcu: (detected by 9, t=3D3120887 jiffies, g=3D24464761, q=3D=
14609 ncpus=3D12)
[37931.834781] rcu: rcu_preempt kthread starved for 2464655 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[37931.845592] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[37931.854745] rcu: RCU grace-period kthread stack dump:
[37931.859861] rcu: Stack dump where RCU GP kthread last ran:
[38111.873625] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[38111.879745] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[38111.889590] rcu: (detected by 6, t=3D3300948 jiffies, g=3D24464761, q=3D=
14639 ncpus=3D12)
[38111.898183] rcu: rcu_preempt kthread starved for 2644716 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[38111.908987] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[38111.918141] rcu: RCU grace-period kthread stack dump:
[38111.923248] rcu: Stack dump where RCU GP kthread last ran:
[38291.937027] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[38291.943140] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[38291.952992] rcu: (detected by 0, t=3D3481009 jiffies, g=3D24464761, q=3D=
14669 ncpus=3D12)
[38291.961573] rcu: rcu_preempt kthread starved for 2824773 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[38291.972374] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[38291.981525] rcu: RCU grace-period kthread stack dump:
[38291.986617] rcu: Stack dump where RCU GP kthread last ran:
[38471.999428] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[38472.005538] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[38472.015387] rcu: (detected by 6, t=3D3661069 jiffies, g=3D24464761, q=3D=
14699 ncpus=3D12)
[38472.023979] rcu: rcu_preempt kthread starved for 3004837 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[38472.034789] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[38472.043937] rcu: RCU grace-period kthread stack dump:
[38472.049056] rcu: Stack dump where RCU GP kthread last ran:
[38652.062829] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[38652.068950] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[38652.078794] rcu: (detected by 0, t=3D3841130 jiffies, g=3D24464761, q=3D=
14729 ncpus=3D12)
[38652.087375] rcu: rcu_preempt kthread starved for 3184894 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[38652.098175] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[38652.107319] rcu: RCU grace-period kthread stack dump:
[38652.112418] rcu: Stack dump where RCU GP kthread last ran:
[38832.125230] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[38832.131343] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[38832.141196] rcu: (detected by 3, t=3D4021190 jiffies, g=3D24464761, q=3D=
14759 ncpus=3D12)
[38832.149784] rcu: rcu_preempt kthread starved for 3364958 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[38832.160584] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[38832.169729] rcu: RCU grace-period kthread stack dump:
[38832.174821] rcu: Stack dump where RCU GP kthread last ran:
[39012.188630] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[39012.194743] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[39012.204587] rcu: (detected by 0, t=3D4201251 jiffies, g=3D24464761, q=3D=
14789 ncpus=3D12)
[39012.213169] rcu: rcu_preempt kthread starved for 3545015 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[39012.223968] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[39012.233112] rcu: RCU grace-period kthread stack dump:
[39012.238204] rcu: Stack dump where RCU GP kthread last ran:
[39192.251030] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[39192.257147] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[39192.266996] rcu: (detected by 9, t=3D4381311 jiffies, g=3D24464761, q=3D=
14819 ncpus=3D12)
[39192.275588] rcu: rcu_preempt kthread starved for 3725079 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[39192.286398] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[39192.295545] rcu: RCU grace-period kthread stack dump:
[39192.300650] rcu: Stack dump where RCU GP kthread last ran:
[39372.314432] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[39372.320538] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[39372.330390] rcu: (detected by 0, t=3D4561372 jiffies, g=3D24464761, q=3D=
14849 ncpus=3D12)
[39372.338978] rcu: rcu_preempt kthread starved for 3905136 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[39372.349786] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[39372.358929] rcu: RCU grace-period kthread stack dump:
[39372.364021] rcu: Stack dump where RCU GP kthread last ran:
[39552.376833] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[39552.382946] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[39552.392798] rcu: (detected by 0, t=3D4741428 jiffies, g=3D24464761, q=3D=
14879 ncpus=3D12)
[39552.401386] rcu: rcu_preempt kthread starved for 4085197 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[39552.412190] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[39552.421342] rcu: RCU grace-period kthread stack dump:
[39552.426441] rcu: Stack dump where RCU GP kthread last ran:
[39732.435232] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[39732.441346] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[39732.451191] rcu: (detected by 0, t=3D4921488 jiffies, g=3D24464761, q=3D=
14909 ncpus=3D12)
[39732.459778] rcu: rcu_preempt kthread starved for 4265252 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[39732.470578] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[39732.479721] rcu: RCU grace-period kthread stack dump:
[39732.484820] rcu: Stack dump where RCU GP kthread last ran:
[39912.497634] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[39912.503747] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[39912.513591] rcu: (detected by 0, t=3D5101548 jiffies, g=3D24464761, q=3D=
14939 ncpus=3D12)
[39912.522179] rcu: rcu_preempt kthread starved for 4445312 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[39912.532980] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[39912.542123] rcu: RCU grace-period kthread stack dump:
[39912.547215] rcu: Stack dump where RCU GP kthread last ran:
[40092.560033] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[40092.566146] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[40092.575991] rcu: (detected by 1, t=3D5281608 jiffies, g=3D24464761, q=3D=
14969 ncpus=3D12)
[40092.584572] rcu: rcu_preempt kthread starved for 4625376 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[40092.595371] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[40092.604514] rcu: RCU grace-period kthread stack dump:
[40092.609615] rcu: Stack dump where RCU GP kthread last ran:
[40272.623436] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[40272.629548] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[40272.639401] rcu: (detected by 0, t=3D5461669 jiffies, g=3D24464761, q=3D=
14999 ncpus=3D12)
[40272.647982] rcu: rcu_preempt kthread starved for 4805433 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[40272.658784] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[40272.667935] rcu: RCU grace-period kthread stack dump:
[40272.673034] rcu: Stack dump where RCU GP kthread last ran:
[40452.685836] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[40452.691956] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[40452.701802] rcu: (detected by 0, t=3D5641729 jiffies, g=3D24464761, q=3D=
15029 ncpus=3D12)
[40452.710390] rcu: rcu_preempt kthread starved for 4985493 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[40452.721196] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[40452.730347] rcu: RCU grace-period kthread stack dump:
[40452.735438] rcu: Stack dump where RCU GP kthread last ran:
[40632.748237] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[40632.754350] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[40632.764202] rcu: (detected by 0, t=3D5821785 jiffies, g=3D24464761, q=3D=
15059 ncpus=3D12)
[40632.772783] rcu: rcu_preempt kthread starved for 5165554 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[40632.783590] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[40632.792734] rcu: RCU grace-period kthread stack dump:
[40632.797826] rcu: Stack dump where RCU GP kthread last ran:
[40812.806636] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[40812.812748] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[40812.822597] rcu: (detected by 6, t=3D6001845 jiffies, g=3D24464761, q=3D=
15089 ncpus=3D12)
[40812.831182] rcu: rcu_preempt kthread starved for 5345613 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[40812.841992] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[40812.851140] rcu: RCU grace-period kthread stack dump:
[40812.856250] rcu: Stack dump where RCU GP kthread last ran:
[40992.870037] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[40992.876151] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[40992.886003] rcu: (detected by 0, t=3D6181906 jiffies, g=3D24464761, q=3D=
15119 ncpus=3D12)
[40992.894585] rcu: rcu_preempt kthread starved for 5525670 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[40992.905384] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[40992.914534] rcu: RCU grace-period kthread stack dump:
[40992.919626] rcu: Stack dump where RCU GP kthread last ran:
[41172.932438] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[41172.938551] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[41172.948395] rcu: (detected by 0, t=3D6361966 jiffies, g=3D24464761, q=3D=
15149 ncpus=3D12)
[41172.956984] rcu: rcu_preempt kthread starved for 5705730 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[41172.967784] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[41172.976929] rcu: RCU grace-period kthread stack dump:
[41172.982021] rcu: Stack dump where RCU GP kthread last ran:
[41352.994841] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[41353.000953] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[41353.010799] rcu: (detected by 0, t=3D6542026 jiffies, g=3D24464761, q=3D=
15179 ncpus=3D12)
[41353.019388] rcu: rcu_preempt kthread starved for 5885790 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[41353.030194] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[41353.039338] rcu: RCU grace-period kthread stack dump:
[41353.044436] rcu: Stack dump where RCU GP kthread last ran:
[41533.057240] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[41533.063354] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[41533.073205] rcu: (detected by 0, t=3D6722086 jiffies, g=3D24464761, q=3D=
15213 ncpus=3D12)
[41533.081787] rcu: rcu_preempt kthread starved for 6065850 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[41533.092587] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[41533.101731] rcu: RCU grace-period kthread stack dump:
[41533.106823] rcu: Stack dump where RCU GP kthread last ran:
[41713.119641] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[41713.125754] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[41713.135600] rcu: (detected by 0, t=3D6902146 jiffies, g=3D24464761, q=3D=
15249 ncpus=3D12)
[41713.144188] rcu: rcu_preempt kthread starved for 6245910 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[41713.154996] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[41713.164140] rcu: RCU grace-period kthread stack dump:
[41713.169232] rcu: Stack dump where RCU GP kthread last ran:
[41893.182042] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[41893.188155] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[41893.197999] rcu: (detected by 0, t=3D7082202 jiffies, g=3D24464761, q=3D=
15283 ncpus=3D12)
[41893.206588] rcu: rcu_preempt kthread starved for 6425971 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[41893.217386] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[41893.226537] rcu: RCU grace-period kthread stack dump:
[41893.231629] rcu: Stack dump where RCU GP kthread last ran:
[42073.240442] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[42073.246556] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[42073.256401] rcu: (detected by 0, t=3D7262262 jiffies, g=3D24464761, q=3D=
15317 ncpus=3D12)
[42073.264982] rcu: rcu_preempt kthread starved for 6606026 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[42073.275783] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[42073.284926] rcu: RCU grace-period kthread stack dump:
[42073.290018] rcu: Stack dump where RCU GP kthread last ran:
[42253.302842] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[42253.308955] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[42253.318800] rcu: (detected by 0, t=3D7442322 jiffies, g=3D24464761, q=3D=
15351 ncpus=3D12)
[42253.327388] rcu: rcu_preempt kthread starved for 6786086 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[42253.338195] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[42253.347347] rcu: RCU grace-period kthread stack dump:
[42253.352438] rcu: Stack dump where RCU GP kthread last ran:
[42433.365243] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[42433.371355] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[42433.381206] rcu: (detected by 0, t=3D7622382 jiffies, g=3D24464761, q=3D=
15381 ncpus=3D12)
[42433.389787] rcu: rcu_preempt kthread starved for 6966146 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[42433.400586] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[42433.409729] rcu: RCU grace-period kthread stack dump:
[42433.414820] rcu: Stack dump where RCU GP kthread last ran:
[42613.427645] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[42613.433758] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[42613.443604] rcu: (detected by 0, t=3D7802442 jiffies, g=3D24464761, q=3D=
15411 ncpus=3D12)
[42613.452185] rcu: rcu_preempt kthread starved for 7146206 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[42613.462985] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[42613.472128] rcu: RCU grace-period kthread stack dump:
[42613.477226] rcu: Stack dump where RCU GP kthread last ran:
[42793.490045] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[42793.496158] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[42793.505997] rcu: (detected by 0, t=3D7982502 jiffies, g=3D24464761, q=3D=
15441 ncpus=3D12)
[42793.514584] rcu: rcu_preempt kthread starved for 7326266 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[42793.525392] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[42793.534534] rcu: RCU grace-period kthread stack dump:
[42793.539625] rcu: Stack dump where RCU GP kthread last ran:
[42973.552446] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[42973.558564] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[42973.568409] rcu: (detected by 9, t=3D8162562 jiffies, g=3D24464761, q=3D=
15471 ncpus=3D12)
[42973.576995] rcu: rcu_preempt kthread starved for 7506330 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[42973.587805] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[42973.596953] rcu: RCU grace-period kthread stack dump:
[42973.602073] rcu: Stack dump where RCU GP kthread last ran:
[43153.615845] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[43153.621957] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[43153.631795] rcu: (detected by 0, t=3D8342623 jiffies, g=3D24464761, q=3D=
15501 ncpus=3D12)
[43153.640382] rcu: rcu_preempt kthread starved for 7686387 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[43153.651181] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[43153.660334] rcu: RCU grace-period kthread stack dump:
[43153.665424] rcu: Stack dump where RCU GP kthread last ran:
[43333.678248] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[43333.684368] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[43333.694214] rcu: (detected by 5, t=3D8522683 jiffies, g=3D24464761, q=3D=
15531 ncpus=3D12)
[43333.702800] rcu: rcu_preempt kthread starved for 7866451 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[43333.713611] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[43333.722757] rcu: RCU grace-period kthread stack dump:
[43333.727870] rcu: Stack dump where RCU GP kthread last ran:
[43513.741649] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[43513.747766] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[43513.757614] rcu: (detected by 9, t=3D8702744 jiffies, g=3D24464761, q=3D=
15561 ncpus=3D12)
[43513.766199] rcu: rcu_preempt kthread starved for 8046512 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[43513.777009] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[43513.786156] rcu: RCU grace-period kthread stack dump:
[43513.791266] rcu: Stack dump where RCU GP kthread last ran:
[43693.805049] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[43693.811163] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[43693.821002] rcu: (detected by 0, t=3D8882805 jiffies, g=3D24464761, q=3D=
15591 ncpus=3D12)
[43693.829589] rcu: rcu_preempt kthread starved for 8226569 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[43693.840395] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[43693.849539] rcu: RCU grace-period kthread stack dump:
[43693.854636] rcu: Stack dump where RCU GP kthread last ran:
[43873.867451] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[43873.873568] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[43873.883416] rcu: (detected by 9, t=3D9062865 jiffies, g=3D24464761, q=3D=
15621 ncpus=3D12)
[43873.892001] rcu: rcu_preempt kthread starved for 8406633 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[43873.902811] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[43873.911958] rcu: RCU grace-period kthread stack dump:
[43873.917069] rcu: Stack dump where RCU GP kthread last ran:
[44053.930849] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[44053.936962] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[44053.946806] rcu: (detected by 0, t=3D9242926 jiffies, g=3D24464761, q=3D=
15651 ncpus=3D12)
[44053.955386] rcu: rcu_preempt kthread starved for 8586690 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[44053.966185] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[44053.975335] rcu: RCU grace-period kthread stack dump:
[44053.980426] rcu: Stack dump where RCU GP kthread last ran:
[44233.993250] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[44233.999360] rcu: 7-...0: (1 GPs behind) idle=3D2684/1/0x4000000000000000=
 softirq=3D12697480/12697481 fqs=3D164052
[44234.009199] rcu: (detected by 9, t=3D9422986 jiffies, g=3D24464761, q=3D=
15681 ncpus=3D12)
[44234.017784] rcu: rcu_preempt kthread starved for 8766754 jiffies! g24464=
761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[44234.028594] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OO=
M is now expected behavior.
[44234.037741] rcu: RCU grace-period kthread stack dump:
[44234.042852] rcu: Stack dump where RCU GP kthread last ran:
=C2=A0=C2=A0 =C2=A0The serial console is continuously outputting RCU stall =
messages.
=C2=A0=C2=A0=C2=A0 Please let me know if you need any further information o=
r assistance in debugging this issue.
Best regards,

