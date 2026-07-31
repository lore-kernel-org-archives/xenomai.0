Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D0207A20
	for <xenomai@lists.linux.dev>; Fri, 31 Jul 2026 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500218; cv=none; b=LBPRIJ10Yag7Lmkbv7a0rozdMNyVOn2wYPp6RPp0DsNgXE6ujI8Fa5XwsVlEmNzJvrH1/w8nZ5d89AQIE1IPYtDHFchzCUv5KLnx+m6p3METYsYfBjZPgHr/IdTZMkvOz2Rz5FAQyFn+nlq66Nqxp13BWoJ95gnqQe8uebWf1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500218; c=relaxed/simple;
	bh=sR7Efl2eaWQnlNPFzYGWr5KzNi55octNs9CSXC/FgMA=;
	h=Mime-Version:References:Content-Type:Subject:From:To:Cc:
	 In-Reply-To:Date:Message-Id; b=XJlzHeuZMkWpPDobVXZHTF0ddDZ4D5/QEASjNsti6W3mxc7VC/SSzIKWbN6YR1BmVF1wIi/Se1gTEvBLH10LlCfTEmmxnZey3Ha0NZ/1Ml36V+St/0pS9i2dfH65n2y9WCfFC1T3OfaRMX3ksm2/P67lU1VwjEl7/sZB72N3GqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0095805-9.5028e-05-0.990324;FP=2515079801431993652|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.iaW85vk_1785500209;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.iaW85vk_1785500209 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 20:16:49 +0800
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn> <08769a2a-4249-4dc2-a1c7-ca402de19470@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.ce37a487.5a5d.42c0.8403.e19ea2d59537@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.53860c2d.1bc0.4564.872b.fffc828b78ef@feishu.cn> <5905a920-e911-48bd-9959-d8702b512272@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.2cdf3bbf.6288.45f6.b5d6.9760f144d99c@feishu.cn> <2b95f251-e2a6-4c7f-bffc-7cbc15d9eed3@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.09468bbe.a918.4120.abc3.991d1d35a187@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.06d37e0f.d9fe.473b.a955.bacccbca8173@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.8107967f.ab56.4b5f.bc5e.7ddd5ae2be4c@feishu.cn> <1c7d4293-6754-4690-bf73-aba6e17d0c0e@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.c699737c.9d30.43b7.9ed8.a2a9042fb8f3@feishu.cn>
	<67ed5d8f-0a4c-432b-ab59-a4cbcbe91a34@siemens.com>
	<ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.feee15f9.216e.4b39.b573.9ad554d5eb50@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel Ultra 5 125H
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: "xenomai" <xenomai@lists.linux.dev>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>, 
	=?utf-8?q?=E6=9D=8E=E5=B0=8F=E5=AE=81?= <lixiaoning@sinsegye.com.cn>, 
	=?utf-8?q?=E9=A9=AC=E5=90=9B?= <majun@sinsegye.com.cn>
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.feee15f9.216e.4b39.b573.9ad554d5eb50@feishu.cn>
X-Lms-Return-Path: <lba+16a6c922f+45f009+lists.linux.dev+liuyang@sinsegye.com.cn>
Date: Fri, 31 Jul 2026 20:16:46 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.30d266af.c20f.4e5e.b7f2.5899ed8cff1b@feishu.cn>

Hi
=C2=A0=C2=A0 =C2=A0 I used the following changes

sudo=C2=A0sysctl -w kernel.panic_on_rcu_stall=3D1
sudo=C2=A0sysctl -w kernel.ftrace_dump_on_oops=3D1
sudo=C2=A0sysctl -w kernel.panic=3D0
sudo trace-cmd=C2=A0start \
=C2=A0 -e 'cobalt*' \
=C2=A0 -e 'sched:*' \
=C2=A0 -e 'irq:*' \
=C2=A0 -e 'irq_vectors:*' \
=C2=A0 -e 'signal:*' \
=C2=A0 -e 'rcu:rcu_stall_warning'
echo 'snapshot' | sudo tee /sys/kernel/debug/tracing/events/rcu/rcu_stall_w=
arning/trigger
echo 'traceoff' | sudo=C2=A0tee /sys/kernel/debug/tracing/events/rcu/rcu_st=
all_warning/trigger

echo 10 > /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout

Kernel config add=C2=A0
CONFIG_DEBUG_KERNEL=3Dy=C2=A0
CONFIG_PROVE_LOCKING=3Dy=C2=A0
CONFIG_PROVE_RAW_LOCK_NESTING=3Dy=C2=A0
CONFIG_DEBUG_PREEMPT=3Dy

The log obtained is as follows:

fiveages@W2-0000:~$ [18611.389806] rcu: INFO: rcu_preempt detected stalls o=
n CPUs/tasks:
[18611.395936] rcu: =C2=A0 =C2=A0 6-...0: (2 ticks this GP) idle=3D9d34/0/0=
x3 softirq=3D7383494/7383494 fqs=3D1876
[18611.404400] rcu: =C2=A0 =C2=A0 11-...0: (1 ticks this GP) idle=3D3a5c/1/=
0x4000000000000002 softirq=3D7395092/7395092 fqs=3D1876
[18611.414250] rcu: =C2=A0 =C2=A0 (detected by 1, t=3D15004 jiffies, g=3D14=
237693, q=3D73 ncpus=3D12)
[18611.423416] rcu: rcu_preempt kthread starved for 7500 jiffies! g14237693=
 f0x0 RCU_GP_DOING_FQS(6) ->state=3D0x0 ->cpu=3D0
[18611.434054] rcu: =C2=A0 =C2=A0 Unless rcu_preempt kthread gets sufficien=
t CPU time, OOM is now expected behavior.
[18611.443210] rcu: RCU grace-period kthread stack dump:
[18611.448322] rcu: Stack dump where RCU GP kthread last ran:
[18611.454839] Kernel panic - not syncing: RCU Stall
[18611.454840] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G S =C2=A0 U=
=C2=A0 W=C2=A0 OE =C2=A0 =C2=A0 =C2=A0 6.18.29-13-rkernel-x64-industry #met=
aOS PREEMPT(full)
[18611.454842] Tainted: [S]=3DCPU_OUT_OF_SPEC, [U]=3DUSER, [W]=3DWARN, [O]=
=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[18611.454843] Hardware name: Sinsegye SP8000-C340/SP8000-C340, BIOS SP8000=
0020260708B 07/08/2026
[18611.454843] IRQ stage: Linux
[18611.454843] Call Trace:
[18611.454844]=C2=A0 <IRQ>
[18611.454844]=C2=A0 dump_stack_lvl+0x2d/0xe0
[18611.454847]=C2=A0 dump_stack+0x14/0x20
[18611.454848]=C2=A0 vpanic+0x387/0x390
[18611.454849]=C2=A0 panic+0x5b/0x60
[18611.454851]=C2=A0 ? wake_up_process+0x19/0x20
[18611.454853]=C2=A0 rcu_sched_clock_irq+0x17f6/0x1800
[18611.454855]=C2=A0 ? get_jiffies_update+0x4b/0xe0
[18611.454858]=C2=A0 ? get_jiffies_update+0x56/0xe0
[18611.454860]=C2=A0 update_process_times+0x84/0xf0
[18611.454862]=C2=A0 tick_nohz_handler+0xa5/0x160
[18611.454863]=C2=A0 ? tick_do_update_jiffies64+0x150/0x150
[18611.454864]=C2=A0 __hrtimer_run_queues+0x1c6/0x390
[18611.454867]=C2=A0 hrtimer_interrupt+0x132/0x290
[18611.454870]=C2=A0 proxy_irq_handler+0x21/0x30
[18611.454871]=C2=A0 handle_synthetic_irq+0xac/0x250
[18611.454873]=C2=A0 do_irq_inband+0x1d/0x20
[18611.454874]=C2=A0 arch_do_IRQ_pipelined+0xd8/0x840
[18611.454875]=C2=A0 </IRQ>
[18611.454876]=C2=A0 <TASK>
[18611.454876]=C2=A0 sync_current_irq_stage+0x1b9/0x1d0
[18611.454878]=C2=A0 sync_irq_stage+0xbc/0xd0
[18611.454879]=C2=A0 synchronize_pipeline+0x62/0x90
[18611.454880]=C2=A0 handle_irq_pipelined_finish+0x88/0x190
[18611.454882]=C2=A0 arch_pipeline_entry+0xe3/0x130
[18611.454884]=C2=A0 sysvec_apic_timer_interrupt+0x12/0x20
[18611.454885]=C2=A0 asm_sysvec_apic_timer_interrupt+0x1f/0x30
[18611.454886] RIP: 0010:cpu_idle_poll.isra.0+0x69/0x210
[18611.454888] Code: ff e8 8b f4 ff ff 48 8b 7d 08 e8 e2 e1 ff ff e8 7d af =
25 ff 65 48 8b 1d 85 0d fb 00 48 8b 03 a8 10 74 0b eb 1c f3 90 48 8b 03 <a8=
> 10 75 13 8b 05 21 59 cc 00 85 c0 75 ed e8 24 f1 ff ff 85=C2=A0c0 75
[18611.454889] RSP: 0000:ffffa8da40193ed8 EFLAGS: 00000202
[18611.454890] RAX: 0000000000080040 RBX: ffff8d1900d34980 RCX: 00000000000=
0001f
[18611.454890] RDX: ffffffff9dd1e7aa RSI: ffffffff9f0f769a RDI: ffffffff9dd=
1e7aa
[18611.454891] RBP: ffffa8da40193ee0 R08: 0000000000000000 R09: 00000000000=
00000
[18611.454891] R10:=C2=A00000000000000000 R11: 0000000000000000 R12: ffff8d=
1900d34980
[18611.454892] R13: 0000000000000001 R14: 0000000000000000 R15: 00000000000=
00000
[18611.454893]=C2=A0 ? do_idle+0x7a/0x170
[18611.454895]=C2=A0 ? do_idle+0x7a/0x170
[18611.454897]=C2=A0 ? cpu_idle_poll.isra.0+0x53/0x210
[18611.454898]=C2=A0 do_idle+0x7a/0x170
[18611.454899]=C2=A0 cpu_startup_entry+0x30/0x40
[18611.454901]=C2=A0 start_secondary+0x109/0x150
[18611.454902]=C2=A0 common_startup_64+0x13e/0x141
[18611.454905]=C2=A0 </TASK>
[18612.496574] Shutting down cpus with NMI
[18612.739167] Dumping ftrace buffer:
[18612.739169] =C2=A0=C2=A0 (ftrace buffer empty)
[18612.739171] Kernel Offset: 0x1ca00000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)
[18612.847320] ---[ end Kernel panic - not syncing: RCU Stall ]---

> From: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> Date:=C2=A0 Fri, Jul 31, 2026, 14:14
> Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 =
on Intel Ultra 5 125H
> To: "Jan Kiszka"<jan.kiszka@siemens.com>
> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<son=
gjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@sinsegy=
e.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> Yes, I have only installed the kernel with Dovetail and Cobalt patches. N=
o user-space programs linked against Cobalt are running.
>=C2=A0
> Liuyang
>=C2=A0
> > From: "Jan Kiszka"<jan.kiszka@siemens.com>
> > Date:=C2=A0 Fri, Jul 31, 2026, 14:10
> > Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3.=
1 on Intel Ultra 5 125H
> > To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> > Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<s=
ongjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@sinse=
gye.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> > On 31.07.26 08:01, =E5=88=98=E6=9D=A8 wrote:
> > > Hello Jan,
> > > =C2=A0=C2=A0=C2=A0 No Xenomai user=E2=80=91space programs are running=
 on the customer=E2=80=99s system.
> > >=C2=A0
> >=C2=A0
> > So, you are getting a stall in the absence of any Xenomai load, but
> > while running a Xenomai-enabled kernel?
> >=C2=A0
> > Another thing you can try is turning on debugging switches of the
> > kernel, specifically
> >=C2=A0
> > https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/mast=
er/cfg/lock-debugging.cfg?ref_type=3Dheads
> >=C2=A0
> > Jan
> >=C2=A0
> > >> From: "Jan Kiszka"<jan.kiszka@siemens.com>
> > >> Date:=C2=A0 Fri, Jul 31, 2026, 13:44
> > >> Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3=
.3.1 on Intel Ultra 5 125H
> > >> To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> > >> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE=
"<songjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@si=
nsegye.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> > >> On 31.07.26 06:25, =E5=88=98=E6=9D=A8 wrote:
> > >>> Hello,
> > >>> I am using Linux kernel 6.18 with Xenomai 3.3.1. I have set i915.mo=
deset=3D0=C2=A0in GRUB to prevent the i915 driver from loading.
> > >>> Since trace=E2=80=91cmd logs cannot be dumped when the kernel hangs=
, I configured the following sysctl parameters:
> > >>> plaintext
> > >>> =C2=A0
> > >>> sudo=C2=A0sysctl -w kernel.panic_on_rcu_stall=3D1
> > >>> sudo=C2=A0sysctl -w kernel.ftrace_dump_on_oops=3D1
> > >>> sudo=C2=A0sysctl -w kernel.panic=3D0
> > >>> =C2=A0
> > >>> The full serial log is attached. Could you please help analyze whet=
her the log contains sufficient information for troubleshooting? Thank you.
> > >> =C2=A0
> > >> I'm missing cobalt events other cores and an annotation inside the t=
race
> > >> where the error was noticed. That's why I proposed a different recor=
ding
> > >> method.
> > >> =C2=A0
> > >> Also, as the RCU stall detection may be delayed too much to still se=
e
> > >> normal operation in the trace, you might have to tune the timeout
> > >> (https://docs.kernel.org/RCU/stallwarn.html#fine-tuning-the-rcu-cpu-=
stall-detector)
> > >> until we find an earlier problem indicator.
> > >> =C2=A0
> > >> Jan
> > >> =C2=A0
> > >> --=C2=A0
> > >> Siemens AG, Foundational Technologies
> > >> Linux Expert Center
> > >> =C2=A0
> >=C2=A0
> >=C2=A0
> > --=C2=A0
> > Siemens AG, Foundational Technologies
> > Linux Expert Center
> >=C2=A0
