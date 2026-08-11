Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7130566B
	for <xenomai@lists.linux.dev>; Tue, 11 Aug 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432812; cv=none; b=ZGOThoP25zsXApGyjagte6iJcslxeJe0BR/fojY7lo+jec+gOeKv+EKARfCxnzuYWZenedoMjFDcDVKdTde5Q0g+BmAxQhz6/XkbKMQSQh3jyOn2/FqI8NBaCd9hRuLnqeOyQ3Rb9071lBs1eTJno25iZZFX0/kmdpFoOy212NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432812; c=relaxed/simple;
	bh=hmsVrx7acsPx82Sx+lgmfAS7BYSvFpmNxgtM6d+fghw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qatummLXwZ78Ko7AARYLXjwg/EksEV7iX1dCD+0zYBFo9z9wteewZL3Xw8HD9zTxUbCbuWHP6sld+Bb6L6KDPbrFtfmZuhagh97Yibrq5ITZE9h4yhiNYNs7aEG7QKMNic0WzTgH1XpnIvV5at9C5kgL6TLTa+FVdFKAva9kggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZjqH1HrW; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZjqH1HrW"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260811071957d8bd1e4cd10002076d
        for <xenomai@lists.linux.dev>;
        Tue, 11 Aug 2026 09:19:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hmsVrx7acsPx82Sx+lgmfAS7BYSvFpmNxgtM6d+fghw=;
 b=ZjqH1HrWGa/hbe4fwNG+YxTqVWUDUpZWO3E/4ugG91pIz1k31OUPQordaGKQrfX4hoakOE
 iJXzrCbgnDrqm3KF12PBb6UPlbuYLlpw5S5wsYAaxjokRVfWH4N2dxBAFiG3hM+pqWLUObEG
 YoKx8r+L1fVTH130Xu8TewZGhSzLKqo1HcJ6J4eG7eVXtr29x7ezztdZBEp3QgvCMinGA4Ap
 aY2V3slD3+8FhoFcTXd0Mq1DZyiohQkQSRPc9G9IQIQaV9oOTAllQu2g69YhKG+5mb9Bwl8W
 PipHEemkE3GvWgAXXa5uE2Jd5YMW0ueW5yWzCHA+XLoHbu+9A9w2Wm5Q==;
Message-ID: <b1da1fc4a8a4e44d3b398ef4d514bdb738f0598d.camel@siemens.com>
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel
 Ultra 5 125H
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?UTF-8?Q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>, Jan Kiszka
	 <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@lists.linux.dev>, 
 =?UTF-8?Q?=E5=AE=8B=E5=81=A5=E7=8E=AE?=
	 <songjianwei@sinsegye.com.cn>, =?UTF-8?Q?=E6=9D=8E=E5=B0=8F=E5=AE=81?=
	 <lixiaoning@sinsegye.com.cn>, =?UTF-8?Q?=E9=A9=AC=E5=90=9B?=
	 <majun@sinsegye.com.cn>
Date: Tue, 11 Aug 2026 09:19:57 +0200
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.016f3d46.7d4b.4b85.be4a.b6c524f3b5d7@feishu.cn>
References: =?US-ASCII?Q?=09<ed7c43ef85386e7d9b7bfcd2895307dc2948c?=
 =?US-ASCII?Q?b81.3e5e7d15.7682.47ce.94bc.841347b177b?=
 =?US-ASCII?Q?8@feishu.cn>=09_<08769a2a-4249-4dc2-a1c7-?=
 =?US-ASCII?Q?ca402de19470@siemens.com>=09_<ed7c43ef8538?=
 =?US-ASCII?Q?6e7d9b7bfcd2895307dc2948cb81.ce37a487.5?=
 =?US-ASCII?Q?a5d.42c0.8403.e19ea2d59537@feishu.cn>=09_<?=
 =?US-ASCII?Q?ed7c43ef85386e7d9b7bfcd2895307dc2948cb8?=
 =?US-ASCII?Q?1.53860c2d.1bc0.4564.872b.fffc828b78ef@f?=
 =?US-ASCII?Q?eishu.cn>=09_<5905a920-e911-48bd-9959-d87?=
 =?US-ASCII?Q?02b512272@siemens.com>=09_<ed7c43ef85386e?=
 =?US-ASCII?Q?7d9b7bfcd2895307dc2948cb81.2cdf3bbf.628?=
 =?US-ASCII?Q?8.45f6.b5d6.9760f144d99c@feishu.cn>=09_<2b?=
 =?US-ASCII?Q?95f251-e2a6-4c7f-bffc-7cbc15d9eed3@siem?=
 =?US-ASCII?Q?ens.com>=09_<ed7c43ef85386e7d9b7bfcd289530?=
 =?US-ASCII?Q?7dc2948cb81.09468bbe.a918.4120.abc3.991?=
 =?US-ASCII?Q?d1d35a187@feishu.cn>=09_<ed7c43ef85386e7d9?=
 =?US-ASCII?Q?b7bfcd2895307dc2948cb81.06d37e0f.d9fe.4?=
 =?US-ASCII?Q?73b.a955.bacccbca8173@feishu.cn>=09_<ed7c?=
 =?US-ASCII?Q?43ef85386e7d9b7bfcd2895307dc2948cb81.81?=
 =?US-ASCII?Q?07967f.ab56.4b5f.bc5e.7ddd5ae2be4c@feish?=
 =?US-ASCII?Q?u.cn>=09_<1c7d4293-6754-4690-bf73-aba6e17?=
 =?US-ASCII?Q?d0c0e@siemens.com>=09_<ed7c43ef85386e7d9b7?=
 =?US-ASCII?Q?bfcd2895307dc2948cb81.c699737c.9d30.43b?=
 =?US-ASCII?Q?7.9ed8.a2a9042fb8f3@feishu.cn>=09=09<67ed5d8?=
 =?US-ASCII?Q?f-0a4c-432b-ab59-a4cbcbe91a34@siemens.c?=
 =?US-ASCII?Q?om>=09=09<ed7c43ef85386e7d9b7bfcd2895307dc2?=
 =?US-ASCII?Q?948cb81.feee15f9.216e.4b39.b573.9ad554d?=
 =?US-ASCII?Q?5eb50@feishu.cn>=09=09<ed7c43ef85386e7d9b7bf?=
 =?US-ASCII?Q?cd2895307dc2948cb81.30d266af.c20f.4e5e.?=
 =?US-ASCII?Q?b7f2.5899ed8cff1b@feishu.cn>=09_<ed7c43ef8?=
 =?US-ASCII?Q?5386e7d9b7bfcd2895307dc2948cb81.016f3d4?=
 =?US-ASCII?Q?6.7d4b.4b85.be4a.b6c524f3b5d7@feishu.cn>?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2026-08-11 at 10:17 +0800, =E5=88=98=E6=9D=A8 wrote:
> Hi,
> We captured the following on the serial console during an RCU stall. CPU =
4 was interrupted in the idle/nohz path and spun on the timer lock inside t=
he thermal handler:
>=20
> [ 2205.999617] Sending NMI from CPU 8 to CPUs 4:
> [ 2205.999619] NMI backtrace for cpu 4
> [ 2205.999620] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G =C2=A0 =C2=
=A0 U=C2=A0 W=C2=A0 OE =C2=A0 =C2=A0=C2=A0 6.12.90-13-rkernel-cip24-x64-ind=
ustry #metaOS
> [ 2205.999621] Tainted: [U]=3DUSER, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DU=
NSIGNED_MODULE
> [ 2205.999622] Hardware name: Sinsegye SP8000-C340/SP8000-C340, BIOS SP80=
000020260708B 07/08/2026
> [ 2205.999622] IRQ stage: Linux
> [ 2205.999623] RIP: 0010:native_queued_spin_lock_slowpath+0x78/0x380
> [ 2205.999625] Code: 2c 24 08 0f 92 c2 41 8b 04 24 0f b6 d2 c1 e2 08 30 e=
4 09 d0 a9 00 01 ff ff 75 5c 85 c0 74 14 41 0f b6 04 24 84 c0 74 0b f3 90 <=
41> 0f b6 04 24 84 c0 75 f5 b8 01 00 00 00 66 41 89 04 24 5b 41 5c
> [ 2205.999626] RSP: 0018:ffffb065802dce38 EFLAGS: 00000002
> [ 2205.999627] RAX: 0000000000000001 RBX: ffff9334dfaaa428 RCX: 000000000=
0000000
> [ 2205.999627] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9334d=
fa53580
> [ 2205.999628] RBP: ffffb065802dce58 R08: 0000000000000001 R09: 000000000=
0000000
> [ 2205.999629] R10: 0000000000000000 R11: ffffb065802dcff8 R12: ffff9334d=
fa53580
> [ 2205.999629] R13: 0000000000000000 R14: 0000000029f00004 R15: ffff9334d=
fa53580
> [ 2205.999630] FS:=C2=A0 0000000000000000(0000) GS:ffff9334dfa00000(0000)=
 knlGS:0000000000000000
> [ 2205.999631] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2205.999631] CR2: 00007f56540d1b68 CR3: 00000001637a8005 CR4: 000000000=
0772ef0
> [ 2205.999632] PKRU: 55555554
> [ 2205.999633] Call Trace:
> [ 2205.999633]=C2=A0 <IRQ>
> [ 2205.999634]=C2=A0 do_raw_spin_lock+0xbe/0xd0
> [ 2205.999636]=C2=A0 _raw_spin_lock_irqsave+0x59/0x70
> [ 2205.999638]=C2=A0 ? lock_timer_base+0x7b/0xa0
> [ 2205.999641]=C2=A0 lock_timer_base+0x7b/0xa0
> [ 2205.999643]=C2=A0 add_timer_on+0x70/0x140
> [ 2205.999646]=C2=A0 __queue_delayed_work+0xac/0x110
> [ 2205.999648]=C2=A0 queue_delayed_work_on+0x94/0xb0
> [ 2205.999650]=C2=A0 therm_throt_process+0x164/0x180
> [ 2205.999653]=C2=A0 intel_thermal_interrupt+0x12b/0x350
> [ 2205.999655]=C2=A0 __sysvec_thermal+0x46/0x180
> [ 2205.999658]=C2=A0 sysvec_thermal+0x9f/0xc0
> [ 2205.999660]=C2=A0 </IRQ>
> [ 2205.999660]=C2=A0 <TASK>
> [ 2205.999661]=C2=A0 asm_sysvec_thermal+0x1f/0x30
> [ 2205.999663] RIP: 0010:_raw_spin_unlock+0x0/0x50
> [ 2205.999665] Code: 01 00 00 00 31 c9 ba 01 00 00 00 31 f6 41 bc 01 00 0=
0 00 e8 32 04 2c ff 58 48 8d 65 f0 44 89 e0 5b 41 5c 5d c3 0f 1f 44 00 00 <=
f3> 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 fc 48 83 c7 18
> [ 2205.999666] RSP: 0018:ffffb065801c3e00 EFLAGS: 00000246
> [ 2205.999666] RAX: 0000000000000001 RBX: 0000000100161a47 RCX: 000000000=
0000001
> [ 2205.999667] RDX: 0000000000000004 RSI: ffffffff90217c1e RDI: ffff9334d=
fa54840
> [ 2205.999668] RBP: ffffb065801c3e58 R08: 0000000000000001 R09: 000000000=
0000000
> [ 2205.999668] R10: 0000000000000001 R11: 0000000000000c2c R12: ffff9334d=
fa53580
> [ 2205.999669] R13: ffff9334dfa54840 R14: 00000197236c7580 R15: ffffb0658=
01c3e7f
> [ 2205.999672]=C2=A0 ? __get_next_timer_interrupt+0x132/0x380
> [ 2205.999676]=C2=A0 timer_base_try_to_set_idle+0x17/0x30
> [ 2205.999678]=C2=A0 tick_nohz_stop_tick+0x70/0x370
> [ 2205.999681]=C2=A0 tick_nohz_idle_stop_tick+0x72/0xd0
> [ 2205.999683]=C2=A0 do_idle+0xb8/0x150
> [ 2205.999685]=C2=A0 cpu_startup_entry+0x30/0x40
> [ 2205.999688]=C2=A0 start_secondary+0x10e/0x130
> [ 2205.999690]=C2=A0 common_startup_64+0x13e/0x141
> [ 2205.999694]=C2=A0 </TASK>
>=20
> We addressed this with a local kernel patch, and the issue no longer repr=
oduces on our side after applying it.
> Could you please review whether this change is correct and acceptable ups=
tream?
>=20
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idten=
try.h
> index 1b9264e5b..bbd20cfe2 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -803,7 +803,7 @@ DECLARE_IDTENTRY_SYSVEC(DEFERRED_ERROR_VECTOR, =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 sysvec_deferred_error);
> =C2=A0# endif
>=20
> =C2=A0# ifdef CONFIG_X86_THERMAL_VECTOR
> -DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VECTOR, =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sysvec_thermal);
> +DECLARE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR, =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sysvec_thermal);
> =C2=A0# else
> =C2=A0# define fred_sysvec_thermal =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL
> =C2=A0# endif
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index aecdb2d02..c432c22ed 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -605,7 +605,8 @@ static void smp_thermal_vector(void)
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 smp_processor_id());
> =C2=A0}
>=20
> -DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
> +DEFINE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysvec_thermal)
> =C2=A0{
> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 trace_thermal_apic_entry(THERMAL_APIC_VE=
CTOR);
> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 inc_irq_stat(irq_thermal_count);
> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipelin=
e.c
> index 8c9d587bf..c7ade9c2c 100644
> --- a/arch/x86/kernel/irq_pipeline.c
> +++ b/arch/x86/kernel/irq_pipeline.c
> @@ -164,6 +164,11 @@ static void do_sysvec_inband(struct irq_desc *desc, =
struct pt_regs *regs)
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 run_sysvec_o=
n_irqstack_cond(__sysvec_apic_timer_interrupt,
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 re=
gs);
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 break;
> +#ifdef CONFIG_X86_THERMAL_VECTOR
> + =C2=A0 =C2=A0 =C2=A0 case THERMAL_APIC_VECTOR:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 run_sysvec_on_irqstack=
_cond(__sysvec_thermal, regs);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +#endif
> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 default:
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 printk_once(=
KERN_ERR "irq_pipeline: unexpected event"
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0 " on vector #%.2x (irq=3D%u)", vector, irq);
>=20

Yes, the THERMAL_APIC_VECTOR implementation has a pipelining problem.

Main question: Should the event handling take place in-band (Linux) or
out-of-band (cobalt/evl)?

You selected the first option, which looks sane to me. You now delay the
handling to the in-band stage.

> Thanks
> liuyang
>=20
> > From: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> > Date:=C2=A0 Fri, Jul 31, 2026, 20:29
> > Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3.=
1 on Intel Ultra 5 125H
> > To: "Jan Kiszka"<jan.kiszka@siemens.com>
> > Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<s=
ongjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@sinse=
gye.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> > Hi
> > =C2=A0=C2=A0 =C2=A0 I used the following changes
> > =C2=A0
> > sudo=C2=A0sysctl -w kernel.panic_on_rcu_stall=3D1
> > sudo=C2=A0sysctl -w kernel.ftrace_dump_on_oops=3D1
> > sudo=C2=A0sysctl -w kernel.panic=3D0
> > sudo trace-cmd=C2=A0start \
> > =C2=A0 -e 'cobalt*' \
> > =C2=A0 -e 'sched:*' \
> > =C2=A0 -e 'irq:*' \
> > =C2=A0 -e 'irq_vectors:*' \
> > =C2=A0 -e 'signal:*' \
> > =C2=A0 -e 'rcu:rcu_stall_warning'
> > echo 'snapshot' | sudo tee /sys/kernel/debug/tracing/events/rcu/rcu_sta=
ll_warning/trigger
> > echo 'traceoff' | sudo=C2=A0tee /sys/kernel/debug/tracing/events/rcu/rc=
u_stall_warning/trigger
> > =C2=A0
> > echo 10 > /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
> > =C2=A0
> > Kernel config add=C2=A0
> > CONFIG_DEBUG_KERNEL=3Dy=C2=A0
> > CONFIG_PROVE_LOCKING=3Dy=C2=A0
> > CONFIG_PROVE_RAW_LOCK_NESTING=3Dy=C2=A0
> > CONFIG_DEBUG_PREEMPT=3Dy
> > =C2=A0
> > The log obtained is as follows:
> > =C2=A0
> > fiveages@W2-0000:~$ [18611.389806] rcu: INFO: rcu_preempt detected stal=
ls on CPUs/tasks:
> > [18611.395936] rcu: =C2=A0 =C2=A0 6-...0: (2 ticks this GP) idle=3D9d34=
/0/0x3 softirq=3D7383494/7383494 fqs=3D1876
> > [18611.404400] rcu: =C2=A0 =C2=A0 11-...0: (1 ticks this GP) idle=3D3a5=
c/1/0x4000000000000002 softirq=3D7395092/7395092 fqs=3D1876
> > [18611.414250] rcu: =C2=A0 =C2=A0 (detected by 1, t=3D15004 jiffies, g=
=3D14237693, q=3D73 ncpus=3D12)
> > [18611.423416] rcu: rcu_preempt kthread starved for 7500 jiffies! g1423=
7693 f0x0 RCU_GP_DOING_FQS(6) ->state=3D0x0 ->cpu=3D0
> > [18611.434054] rcu: =C2=A0 =C2=A0 Unless rcu_preempt kthread gets suffi=
cient CPU time, OOM is now expected behavior.
> > [18611.443210] rcu: RCU grace-period kthread stack dump:
> > [18611.448322] rcu: Stack dump where RCU GP kthread last ran:
> > [18611.454839] Kernel panic - not syncing: RCU Stall
> > [18611.454840] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G S =C2=A0=
 U=C2=A0 W=C2=A0 OE =C2=A0 =C2=A0 =C2=A0 6.18.29-13-rkernel-x64-industry #m=
etaOS PREEMPT(full)
> > [18611.454842] Tainted: [S]=3DCPU_OUT_OF_SPEC, [U]=3DUSER, [W]=3DWARN, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> > [18611.454843] Hardware name: Sinsegye SP8000-C340/SP8000-C340, BIOS SP=
80000020260708B 07/08/2026
> > [18611.454843] IRQ stage: Linux
> > [18611.454843] Call Trace:
> > [18611.454844]=C2=A0 <IRQ>
> > [18611.454844]=C2=A0 dump_stack_lvl+0x2d/0xe0
> > [18611.454847]=C2=A0 dump_stack+0x14/0x20
> > [18611.454848]=C2=A0 vpanic+0x387/0x390
> > [18611.454849]=C2=A0 panic+0x5b/0x60
> > [18611.454851]=C2=A0 ? wake_up_process+0x19/0x20
> > [18611.454853]=C2=A0 rcu_sched_clock_irq+0x17f6/0x1800
> > [18611.454855]=C2=A0 ? get_jiffies_update+0x4b/0xe0
> > [18611.454858]=C2=A0 ? get_jiffies_update+0x56/0xe0
> > [18611.454860]=C2=A0 update_process_times+0x84/0xf0
> > [18611.454862]=C2=A0 tick_nohz_handler+0xa5/0x160
> > [18611.454863]=C2=A0 ? tick_do_update_jiffies64+0x150/0x150
> > [18611.454864]=C2=A0 __hrtimer_run_queues+0x1c6/0x390
> > [18611.454867]=C2=A0 hrtimer_interrupt+0x132/0x290
> > [18611.454870]=C2=A0 proxy_irq_handler+0x21/0x30
> > [18611.454871]=C2=A0 handle_synthetic_irq+0xac/0x250
> > [18611.454873]=C2=A0 do_irq_inband+0x1d/0x20
> > [18611.454874]=C2=A0 arch_do_IRQ_pipelined+0xd8/0x840
> > [18611.454875]=C2=A0 </IRQ>
> > [18611.454876]=C2=A0 <TASK>
> > [18611.454876]=C2=A0 sync_current_irq_stage+0x1b9/0x1d0
> > [18611.454878]=C2=A0 sync_irq_stage+0xbc/0xd0
> > [18611.454879]=C2=A0 synchronize_pipeline+0x62/0x90
> > [18611.454880]=C2=A0 handle_irq_pipelined_finish+0x88/0x190
> > [18611.454882]=C2=A0 arch_pipeline_entry+0xe3/0x130
> > [18611.454884]=C2=A0 sysvec_apic_timer_interrupt+0x12/0x20
> > [18611.454885]=C2=A0 asm_sysvec_apic_timer_interrupt+0x1f/0x30
> > [18611.454886] RIP: 0010:cpu_idle_poll.isra.0+0x69/0x210
> > [18611.454888] Code: ff e8 8b f4 ff ff 48 8b 7d 08 e8 e2 e1 ff ff e8 7d=
 af 25 ff 65 48 8b 1d 85 0d fb 00 48 8b 03 a8 10 74 0b eb 1c f3 90 48 8b 03=
 <a8> 10 75 13 8b 05 21 59 cc 00 85 c0 75 ed e8 24 f1 ff ff 85=C2=A0c0 75
> > [18611.454889] RSP: 0000:ffffa8da40193ed8 EFLAGS: 00000202
> > [18611.454890] RAX: 0000000000080040 RBX: ffff8d1900d34980 RCX: 0000000=
00000001f
> > [18611.454890] RDX: ffffffff9dd1e7aa RSI: ffffffff9f0f769a RDI: fffffff=
f9dd1e7aa
> > [18611.454891] RBP: ffffa8da40193ee0 R08: 0000000000000000 R09: 0000000=
000000000
> > [18611.454891] R10:=C2=A00000000000000000 R11: 0000000000000000 R12: ff=
ff8d1900d34980
> > [18611.454892] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000=
000000000
> > [18611.454893]=C2=A0 ? do_idle+0x7a/0x170
> > [18611.454895]=C2=A0 ? do_idle+0x7a/0x170
> > [18611.454897]=C2=A0 ? cpu_idle_poll.isra.0+0x53/0x210
> > [18611.454898]=C2=A0 do_idle+0x7a/0x170
> > [18611.454899]=C2=A0 cpu_startup_entry+0x30/0x40
> > [18611.454901]=C2=A0 start_secondary+0x109/0x150
> > [18611.454902]=C2=A0 common_startup_64+0x13e/0x141
> > [18611.454905]=C2=A0 </TASK>
> > [18612.496574] Shutting down cpus with NMI
> > [18612.739167] Dumping ftrace buffer:
> > [18612.739169] =C2=A0=C2=A0 (ftrace buffer empty)
> > [18612.739171] Kernel Offset: 0x1ca00000 from 0xffffffff81000000 (reloc=
ation range: 0xffffffff80000000-0xffffffffbfffffff)
> > [18612.847320] ---[ end Kernel panic - not syncing: RCU Stall ]---
> > =C2=A0
> > > From: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> > > Date:=C2=A0 Fri, Jul 31, 2026, 14:14
> > > Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.=
3.1 on Intel Ultra 5 125H
> > > To: "Jan Kiszka"<jan.kiszka@siemens.com>
> > > Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"=
<songjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@sin=
segye.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> > > Yes, I have only installed the kernel with Dovetail and Cobalt patche=
s. No user-space programs linked against Cobalt are running.
> > > =C2=A0
> > > Liuyang
> > > =C2=A0
> > > > From: "Jan Kiszka"<jan.kiszka@siemens.com>
> > > > Date:=C2=A0 Fri, Jul 31, 2026, 14:10
> > > > Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai =
3.3.1 on Intel Ultra 5 125H
> > > > To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> > > > Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=
=AE"<songjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning=
@sinsegye.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> > > > On 31.07.26 08:01, =E5=88=98=E6=9D=A8 wrote:
> > > > > Hello Jan,
> > > > > =C2=A0=C2=A0=C2=A0 No Xenomai user=E2=80=91space programs are run=
ning on the customer=E2=80=99s system.
> > > > > =C2=A0
> > > > =C2=A0
> > > > So, you are getting a stall in the absence of any Xenomai load, but
> > > > while running a Xenomai-enabled kernel?
> > > > =C2=A0
> > > > Another thing you can try is turning on debugging switches of the
> > > > kernel, specifically
> > > > =C2=A0
> > > > https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/=
master/cfg/lock-debugging.cfg?ref_type=3Dheads
> > > > =C2=A0
> > > > Jan
> > > > =C2=A0
> > > > > > From: "Jan Kiszka"<jan.kiszka@siemens.com>
> > > > > > Date:=C2=A0 Fri, Jul 31, 2026, 13:44
> > > > > > Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xeno=
mai 3.3.1 on Intel Ultra 5 125H
> > > > > > To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> > > > > > Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=
=8E=AE"<songjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaon=
ing@sinsegye.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> > > > > > On 31.07.26 06:25, =E5=88=98=E6=9D=A8 wrote:
> > > > > > > Hello,
> > > > > > > I am using Linux kernel 6.18 with Xenomai 3.3.1. I have set i=
915.modeset=3D0=C2=A0in GRUB to prevent the i915 driver from loading.
> > > > > > > Since trace=E2=80=91cmd logs cannot be dumped when the kernel=
 hangs, I configured the following sysctl parameters:
> > > > > > > plaintext
> > > > > > > =C2=A0
> > > > > > > sudo=C2=A0sysctl -w kernel.panic_on_rcu_stall=3D1
> > > > > > > sudo=C2=A0sysctl -w kernel.ftrace_dump_on_oops=3D1
> > > > > > > sudo=C2=A0sysctl -w kernel.panic=3D0
> > > > > > > =C2=A0
> > > > > > > The full serial log is attached. Could you please help analyz=
e whether the log contains sufficient information for troubleshooting? Than=
k you.
> > > > > > =C2=A0
> > > > > > I'm missing cobalt events other cores and an annotation inside =
the trace
> > > > > > where the error was noticed. That's why I proposed a different =
recording
> > > > > > method.
> > > > > > =C2=A0
> > > > > > Also, as the RCU stall detection may be delayed too much to sti=
ll see
> > > > > > normal operation in the trace, you might have to tune the timeo=
ut
> > > > > > (https://docs.kernel.org/RCU/stallwarn.html#fine-tuning-the-rcu=
-cpu-stall-detector)
> > > > > > until we find an earlier problem indicator.
> > > > > > =C2=A0
> > > > > > Jan
> > > > > > =C2=A0
> > > > > > --=C2=A0
> > > > > > Siemens AG, Foundational Technologies
> > > > > > Linux Expert Center
> > > > > > =C2=A0
> > > > =C2=A0
> > > > =C2=A0
> > > > --=C2=A0
> > > > Siemens AG, Foundational Technologies
> > > > Linux Expert Center
> > > > =C2=A0
