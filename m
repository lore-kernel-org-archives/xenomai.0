Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9F400995
	for <xenomai@lists.linux.dev>; Tue, 11 Aug 2026 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439696; cv=none; b=imfWeFYxccIPi+Or3Id+/ZeF7TZBGJil3Q4m1f++iveseq5dpe3VkMCcEsjYEm2yB4IDa995mGpvqcFpJCdRlDxiBqOaP9QucLV8TNoEkd7UNuYcP8gaJIT0f5vBFne2FjSVahfkS5o9rC7vTTZ7Oz+C9cU4Z8hkHkZTqla6b+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439696; c=relaxed/simple;
	bh=IeleH8PIQQd44DezH2UWLUbhi4inmNtzDVurCD+biTQ=;
	h=Content-Type:To:Subject:From:Mime-Version:Date:Message-Id:Cc:
	 References:In-Reply-To; b=B2p2rL2acxiDwVWiSN9NRrLnxE2pMgZnTPeij/TA5fAXC0LpoTf1lW+VDafI+i/ET0Tixre9WddOBEHueiHeBVteglMq2fuEx8DvrPOGLKkFXutVmMpQiVX77W11OWG01alz0JZPisPXpH6wWfw+RGoMyz6Iqxr4/PARHcfIM3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743626|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0973175-0.00345601-0.899227;FP=15919694516297931127|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.ijAoqeE_1786439681;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.ijAoqeE_1786439681 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 17:14:41 +0800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel Ultra 5 125H
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16a7ae7ff+dc9cd0+sinsegye.com.cn+liuyang@sinsegye.com.cn>
Date: Tue, 11 Aug 2026 17:14:38 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.b20ddc61.4e2f.4a01.970c.b8487512fe9f@feishu.cn>
Cc: "Florian Bezdeka" <florian.bezdeka@siemens.com>, 
	"Philippe Gerum" <rpm@xenomai.org>, "xenomai" <xenomai@lists.linux.dev>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>, 
	=?utf-8?q?=E6=9D=8E=E5=B0=8F=E5=AE=81?= <lixiaoning@sinsegye.com.cn>, 
	=?utf-8?q?=E9=A9=AC=E5=90=9B?= <majun@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn> <2b95f251-e2a6-4c7f-bffc-7cbc15d9eed3@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.09468bbe.a918.4120.abc3.991d1d35a187@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.06d37e0f.d9fe.473b.a955.bacccbca8173@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.8107967f.ab56.4b5f.bc5e.7ddd5ae2be4c@feishu.cn> <1c7d4293-6754-4690-bf73-aba6e17d0c0e@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.c699737c.9d30.43b7.9ed8.a2a9042fb8f3@feishu.cn> <67ed5d8f-0a4c-432b-ab59-a4cbcbe91a34@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.feee15f9.216e.4b39.b573.9ad554d5eb50@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.30d266af.c20f.4e5e.b7f2.5899ed8cff1b@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.016f3d46.7d4b.4b85.be4a.b6c524f3b5d7@feishu.cn> <b1da1fc4a8a4e44d3b398ef4d514bdb738f0598d.camel@siemens.com>
	<e6caf0a7-8a76-48dd-a523-3c6fcf8fbf3b@siemens.com>
In-Reply-To: <e6caf0a7-8a76-48dd-a523-3c6fcf8fbf3b@siemens.com>

Hi,
Thanks for the feedback.
We agree an oob thermal handler is unlikely. The board can still run hot (w=
e have seen package temperatures around 100=C2=B0C and many TRM interrupts)=
. We have not changed the cooling yet; we will also address this on the har=
dware side later.
We only adjusted the software thermal handling path for now. With that chan=
ge, the system has been under test for over 72 hours without any freeze or =
RCU stall.
Do you think a software fix for the thermal handling path is still
necessary, or is solving the overheating on the hardware side enough?

Best regards,
liuyang

> From: "Jan Kiszka"<jan.kiszka@siemens.com>
> Date:=C2=A0 Tue, Aug 11, 2026, 15:36
> Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 =
on Intel Ultra 5 125H
> To: "Florian Bezdeka"<florian.bezdeka@siemens.com>, "=E5=88=98=E6=9D=A8"<=
liuyang@sinsegye.com.cn>, "Philippe Gerum"<rpm@xenomai.org>
> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<son=
gjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@sinsegy=
e.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> On 11.08.26 09:19, Florian Bezdeka wrote:
> > On Tue, 2026-08-11 at 10:17 +0800, =E5=88=98=E6=9D=A8 wrote:
> >> Hi,
> >> We captured the following on the serial console during an RCU stall. C=
PU 4 was interrupted in the idle/nohz path and spun on the timer lock insid=
e the thermal handler:
> >>
> >> [ 2205.999617] Sending NMI from CPU 8 to CPUs 4:
> >> [ 2205.999619] NMI backtrace for cpu 4
> >> [ 2205.999620] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G =C2=A0 =
=C2=A0 U=C2=A0 W=C2=A0 OE =C2=A0 =C2=A0=C2=A0 6.12.90-13-rkernel-cip24-x64-=
industry #metaOS
> >> [ 2205.999621] Tainted: [U]=3DUSER, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=
=3DUNSIGNED_MODULE
> >> [ 2205.999622] Hardware name: Sinsegye SP8000-C340/SP8000-C340, BIOS S=
P80000020260708B 07/08/2026
> >> [ 2205.999622] IRQ stage: Linux
> >> [ 2205.999623] RIP: 0010:native_queued_spin_lock_slowpath+0x78/0x380
> >> [ 2205.999625] Code: 2c 24 08 0f 92 c2 41 8b 04 24 0f b6 d2 c1 e2 08 3=
0 e4 09 d0 a9 00 01 ff ff 75 5c 85 c0 74 14 41 0f b6 04 24 84 c0 74 0b f3 9=
0 <41> 0f b6 04 24 84 c0 75 f5 b8 01 00 00 00 66 41 89 04 24 5b 41 5c
> >> [ 2205.999626] RSP: 0018:ffffb065802dce38 EFLAGS: 00000002
> >> [ 2205.999627] RAX: 0000000000000001 RBX: ffff9334dfaaa428 RCX: 000000=
0000000000
> >> [ 2205.999627] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff93=
34dfa53580
> >> [ 2205.999628] RBP: ffffb065802dce58 R08: 0000000000000001 R09: 000000=
0000000000
> >> [ 2205.999629] R10: 0000000000000000 R11: ffffb065802dcff8 R12: ffff93=
34dfa53580
> >> [ 2205.999629] R13: 0000000000000000 R14: 0000000029f00004 R15: ffff93=
34dfa53580
> >> [ 2205.999630] FS:=C2=A0 0000000000000000(0000) GS:ffff9334dfa00000(00=
00) knlGS:0000000000000000
> >> [ 2205.999631] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [ 2205.999631] CR2: 00007f56540d1b68 CR3: 00000001637a8005 CR4: 000000=
0000772ef0
> >> [ 2205.999632] PKRU: 55555554
> >> [ 2205.999633] Call Trace:
> >> [ 2205.999633]=C2=A0 <IRQ>
> >> [ 2205.999634]=C2=A0 do_raw_spin_lock+0xbe/0xd0
> >> [ 2205.999636]=C2=A0 _raw_spin_lock_irqsave+0x59/0x70
> >> [ 2205.999638]=C2=A0 ? lock_timer_base+0x7b/0xa0
> >> [ 2205.999641]=C2=A0 lock_timer_base+0x7b/0xa0
> >> [ 2205.999643]=C2=A0 add_timer_on+0x70/0x140
> >> [ 2205.999646]=C2=A0 __queue_delayed_work+0xac/0x110
> >> [ 2205.999648]=C2=A0 queue_delayed_work_on+0x94/0xb0
> >> [ 2205.999650]=C2=A0 therm_throt_process+0x164/0x180
> >> [ 2205.999653]=C2=A0 intel_thermal_interrupt+0x12b/0x350
> >> [ 2205.999655]=C2=A0 __sysvec_thermal+0x46/0x180
> >> [ 2205.999658]=C2=A0 sysvec_thermal+0x9f/0xc0
> >> [ 2205.999660]=C2=A0 </IRQ>
> >> [ 2205.999660]=C2=A0 <TASK>
> >> [ 2205.999661]=C2=A0 asm_sysvec_thermal+0x1f/0x30
> >> [ 2205.999663] RIP: 0010:_raw_spin_unlock+0x0/0x50
> >> [ 2205.999665] Code: 01 00 00 00 31 c9 ba 01 00 00 00 31 f6 41 bc 01 0=
0 00 00 e8 32 04 2c ff 58 48 8d 65 f0 44 89 e0 5b 41 5c 5d c3 0f 1f 44 00 0=
0 <f3> 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 fc 48 83 c7 18
> >> [ 2205.999666] RSP: 0018:ffffb065801c3e00 EFLAGS: 00000246
> >> [ 2205.999666] RAX: 0000000000000001 RBX: 0000000100161a47 RCX: 000000=
0000000001
> >> [ 2205.999667] RDX: 0000000000000004 RSI: ffffffff90217c1e RDI: ffff93=
34dfa54840
> >> [ 2205.999668] RBP: ffffb065801c3e58 R08: 0000000000000001 R09: 000000=
0000000000
> >> [ 2205.999668] R10: 0000000000000001 R11: 0000000000000c2c R12: ffff93=
34dfa53580
> >> [ 2205.999669] R13: ffff9334dfa54840 R14: 00000197236c7580 R15: ffffb0=
65801c3e7f
> >> [ 2205.999672]=C2=A0 ? __get_next_timer_interrupt+0x132/0x380
> >> [ 2205.999676]=C2=A0 timer_base_try_to_set_idle+0x17/0x30
> >> [ 2205.999678]=C2=A0 tick_nohz_stop_tick+0x70/0x370
> >> [ 2205.999681]=C2=A0 tick_nohz_idle_stop_tick+0x72/0xd0
> >> [ 2205.999683]=C2=A0 do_idle+0xb8/0x150
> >> [ 2205.999685]=C2=A0 cpu_startup_entry+0x30/0x40
> >> [ 2205.999688]=C2=A0 start_secondary+0x10e/0x130
> >> [ 2205.999690]=C2=A0 common_startup_64+0x13e/0x141
> >> [ 2205.999694]=C2=A0 </TASK>
> >>
> >> We addressed this with a local kernel patch, and the issue no longer r=
eproduces on our side after applying it.
> >> Could you please review whether this change is correct and acceptable =
upstream?
> >>
> >> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/id=
tentry.h
> >> index 1b9264e5b..bbd20cfe2 100644
> >> --- a/arch/x86/include/asm/idtentry.h
> >> +++ b/arch/x86/include/asm/idtentry.h
> >> @@ -803,7 +803,7 @@ DECLARE_IDTENTRY_SYSVEC(DEFERRED_ERROR_VECTOR, =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 sysvec_deferred_error);
> >> =C2=A0# endif
> >>
> >> =C2=A0# ifdef CONFIG_X86_THERMAL_VECTOR
> >> -DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VECTOR, =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sysvec_thermal);
> >> +DECLARE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 sysvec_thermal);
> >> =C2=A0# else
> >> =C2=A0# define fred_sysvec_thermal =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL
> >> =C2=A0# endif
> >> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> >> index aecdb2d02..c432c22ed 100644
> >> --- a/arch/x86/kernel/irq.c
> >> +++ b/arch/x86/kernel/irq.c
> >> @@ -605,7 +605,8 @@ static void smp_thermal_vector(void)
> >> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 smp_processor_id());
> >> =C2=A0}
> >>
> >> -DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
> >> +DEFINE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR,
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysvec_thermal)
> >> =C2=A0{
> >> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 trace_thermal_apic_entry(THERMAL_APIC=
_VECTOR);
> >> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 inc_irq_stat(irq_thermal_count);
> >> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipe=
line.c
> >> index 8c9d587bf..c7ade9c2c 100644
> >> --- a/arch/x86/kernel/irq_pipeline.c
> >> +++ b/arch/x86/kernel/irq_pipeline.c
> >> @@ -164,6 +164,11 @@ static void do_sysvec_inband(struct irq_desc *des=
c, struct pt_regs *regs)
> >> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 run_sysve=
c_on_irqstack_cond(__sysvec_apic_timer_interrupt,
> >> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
 regs);
> >> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 break;
> >> +#ifdef CONFIG_X86_THERMAL_VECTOR
> >> + =C2=A0 =C2=A0 =C2=A0 case THERMAL_APIC_VECTOR:
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 run_sysvec_on_irqst=
ack_cond(__sysvec_thermal, regs);
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> >> +#endif
> >> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 default:
> >> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 printk_on=
ce(KERN_ERR "irq_pipeline: unexpected event"
> >> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0 " on vector #%.2x (irq=3D%u)", vector, irq);
> >>
> >=C2=A0
> > Yes, the THERMAL_APIC_VECTOR implementation has a pipelining problem.
> >=C2=A0
> > Main question: Should the event handling take place in-band (Linux) or
> > out-of-band (cobalt/evl)?
> >=C2=A0
> > You selected the first option, which looks sane to me. You now delay th=
e
> > handling to the in-band stage.
>=C2=A0
> It's rather unlikely that there will be any oob handler for the thermal
> thing.
>=C2=A0
> At the same time, the occurrence of a thermal event is very likely
> already a problem of its own (which does not mean we should not fix its
> handling). Is your system overheated? Will it possibly die soon when you
> continue like that? At least, it may go into thermal throttling, and
> that will not make your RT workload happier.
>=C2=A0
> Jan
>=C2=A0
> --=C2=A0
> Siemens AG, Foundational Technologies
> Linux Expert Center
>=C2=A0
