Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4655643BDB0
	for <xenomai@lists.linux.dev>; Tue, 11 Aug 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446400; cv=none; b=N4uBLl0W4Qks4KH0NbB+4f/CYyrNUaLjgfXXhLP5qVGLqRn3FyUbr4GViI5fRslciWOaJKbj8qV9Jl/fYTLZ03mE+qb/QYS391kbLKAWWc0IZjThg3ci7jyEiJqkBwSvGXRT4n7ICllFh12Rw0cLl2VEs1ZZedzCDDgiQEFGNaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446400; c=relaxed/simple;
	bh=d1vQ4eAQ9S2uPbyDv4zOxfU3o+Wg0XIbpaLkR1jMNxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GxLiBsTtDF6CO+TfS7mbn03ZwaiKykj4e/Nx27yqQ6qpjWvd1hDSsjI7PRp7WjRmQUIFVVOM5DIVTEU9WXIe72Kz3GjmXsGQWWFc50ijaNcECW/9FucMUUY3RKRo1RpvHKWt2bQ1FfkHREQK5kBw/xXcMVaNeOiqbGITCNpy2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QJh0ZYhR; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QJh0ZYhR"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260811110623159da25fbb00020712
        for <xenomai@lists.linux.dev>;
        Tue, 11 Aug 2026 13:06:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=d1vQ4eAQ9S2uPbyDv4zOxfU3o+Wg0XIbpaLkR1jMNxU=;
 b=QJh0ZYhR0wfnQGHSqmbVh1gOewUXECRn2LhWxr7xWoHz/HSTPUjEZuFQk0XhwS4Ksgk466
 CkP7SlVz2IF+V03aFzzp7Eq7YlmIyQ3YgXTMyB4l/YEtnEx/AgpRZTcbDQfhLU+1oTbbdm/a
 MDf8L1B9XyxfIi5SJ4FmOr8X0j9sFRcbz8tQS02jwzntgBnj+PsTqNnUxy90SpaPHXqoirQL
 pojkuGWKALdt0V+bPqzDbgi+h2By5WAo7GZ8ghR1ht1g8pA+BJkvxX75EIpn1Kymqq93FIts
 lP5mz4QZpioWHUEURjg4C8+iU2kWVbfRs1uZa/h66s8dHGMDihL4nznQ==;
Message-ID: <8ecdb047ca8e563fa7d118ad2d709ab86b0c066d.camel@siemens.com>
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel
 Ultra 5 125H
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?=E5=88=98=E6=9D=A8?=
	 <liuyang@sinsegye.com.cn>
Cc: Philippe Gerum <rpm@xenomai.org>, xenomai <xenomai@lists.linux.dev>, 
 =?UTF-8?Q?=E5=AE=8B=E5=81=A5=E7=8E=AE?=
	 <songjianwei@sinsegye.com.cn>, =?UTF-8?Q?=E6=9D=8E=E5=B0=8F=E5=AE=81?=
	 <lixiaoning@sinsegye.com.cn>, =?UTF-8?Q?=E9=A9=AC=E5=90=9B?=
	 <majun@sinsegye.com.cn>
Date: Tue, 11 Aug 2026 13:06:23 +0200
In-Reply-To: <911efba1-3f55-4486-8b57-4bcd4b17c2b5@siemens.com>
References: =?US-ASCII?Q?=09<ed7c43ef85386e7d9b7bfcd289530?=
 =?US-ASCII?Q?7dc2948cb81.3e5e7d15.7682.47ce.?=
 =?US-ASCII?Q?94bc.841347b177b8@feishu.cn>=09_<?=
 =?US-ASCII?Q?ed7c43ef85386e7d9b7bfcd2895307d?=
 =?US-ASCII?Q?c2948cb81.06d37e0f.d9fe.473b.a9?=
 =?US-ASCII?Q?55.bacccbca8173@feishu.cn>=09_<ed?=
 =?US-ASCII?Q?7c43ef85386e7d9b7bfcd2895307dc2?=
 =?US-ASCII?Q?948cb81.8107967f.ab56.4b5f.bc5e.?=
 =?US-ASCII?Q?7ddd5ae2be4c@feishu.cn>=09_<1c7d4?=
 =?US-ASCII?Q?293-6754-4690-bf73-aba6e17d0c0e?=
 =?US-ASCII?Q?@siemens.com>=09_<ed7c43ef85386e7?=
 =?US-ASCII?Q?d9b7bfcd2895307dc2948cb81.c6997?=
 =?US-ASCII?Q?37c.9d30.43b7.9ed8.a2a9042fb8f3?=
 =?US-ASCII?Q?@feishu.cn>=09_<67ed5d8f-0a4c-432?=
 =?US-ASCII?Q?b-ab59-a4cbcbe91a34@siemens.com?=
 =?US-ASCII?Q?>=09_<ed7c43ef85386e7d9b7bfcd28953?=
 =?US-ASCII?Q?07dc2948cb81.feee15f9.216e.4b39?=
 =?US-ASCII?Q?.b573.9ad554d5eb50@feishu.cn>=09_?=
 =?US-ASCII?Q?<ed7c43ef85386e7d9b7bfcd2895307?=
 =?US-ASCII?Q?dc2948cb81.30d266af.c20f.4e5e.b?=
 =?US-ASCII?Q?7f2.5899ed8cff1b@feishu.cn>=09_<e?=
 =?US-ASCII?Q?d7c43ef85386e7d9b7bfcd2895307dc?=
 =?US-ASCII?Q?2948cb81.016f3d46.7d4b.4b85.be4?=
 =?US-ASCII?Q?a.b6c524f3b5d7@feishu.cn>=09_<b1da?=
 =?US-ASCII?Q?1fc4a8a4e44d3b398ef4d514bdb738f?=
 =?US-ASCII?Q?0598d.camel@siemens.com>=09_<e6ca?=
 =?US-ASCII?Q?f0a7-8a76-48dd-a523-3c6fcf8fbf3?=
 =?US-ASCII?Q?b@siemens.com>=09_<ed7c43ef85386e7?=
 =?US-ASCII?Q?d9b7bfcd2895307dc2948cb81.b20dd?=
 =?US-ASCII?Q?c61.4e2f.4a01.970c.b8487512fe9f?=
 =?US-ASCII?Q?@feishu.cn>=09_<911efba1-3f55-448?=
 =?US-ASCII?Q?6-8b57-4bcd4b17c2b5@siemens.com>?=
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

On Tue, 2026-08-11 at 12:12 +0200, Jan Kiszka wrote:
> On 11.08.26 11:14, =E5=88=98=E6=9D=A8 wrote:
> > Hi,
> > Thanks for the feedback.
> > We agree an oob thermal handler is unlikely. The board can still run ho=
t (we have seen package temperatures around 100=C2=B0C and many TRM interru=
pts). We have not changed the cooling yet; we will also address this on the=
 hardware side later.
> > We only adjusted the software thermal handling path for now. With that =
change, the system has been under test for over 72 hours without any freeze=
 or RCU stall.
> > Do you think a software fix for the thermal handling path is still
> > necessary, or is solving the overheating on the hardware side enough?
> >=20
>=20
> If a thermal interrupt is coming, if "normal" or not, we should handle
> it correctly, rather than causing even more problems this way. So, yes,
> we need your patch.

No question, we should fix the software part of it. Maybe I didn't
express that clearly.

The reason for the CPU stalls is most likely the broken acknowledgment
of the thermal IRQ / vector. apic_eio() in sysvec_thermal is a no-op
when pipelining is enabled, so the vector is never "cleared" at the IRQ
chip (APIC), stalling all vectors with lower priority.

Delaying the handling to the inband stage - as you proposed - fixes the
issue.

Could you please send out a formal patch for the 7.1-dovetail-rebase
branch? Backporting will be done afterwards.

Thanks!

Florian

>=20
> Jan
>=20
> > Best regards,
> > liuyang
> >=20
> > > From: "Jan Kiszka"<jan.kiszka@siemens.com>
> > > Date:=C2=A0 Tue, Aug 11, 2026, 15:36
> > > Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.=
3.1 on Intel Ultra 5 125H
> > > To: "Florian Bezdeka"<florian.bezdeka@siemens.com>, "=E5=88=98=E6=9D=
=A8"<liuyang@sinsegye.com.cn>, "Philippe Gerum"<rpm@xenomai.org>
> > > Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"=
<songjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@sin=
segye.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> > > On 11.08.26 09:19, Florian Bezdeka wrote:
> > > > On Tue, 2026-08-11 at 10:17 +0800, =E5=88=98=E6=9D=A8 wrote:
> > > > > Hi,
> > > > > We captured the following on the serial console during an RCU sta=
ll. CPU 4 was interrupted in the idle/nohz path and spun on the timer lock =
inside the thermal handler:
> > > > >=20
> > > > > [ 2205.999617] Sending NMI from CPU 8 to CPUs 4:
> > > > > [ 2205.999619] NMI backtrace for cpu 4
> > > > > [ 2205.999620] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G =
=C2=A0 =C2=A0 U=C2=A0 W=C2=A0 OE =C2=A0 =C2=A0=C2=A0 6.12.90-13-rkernel-cip=
24-x64-industry #metaOS
> > > > > [ 2205.999621] Tainted: [U]=3DUSER, [W]=3DWARN, [O]=3DOOT_MODULE,=
 [E]=3DUNSIGNED_MODULE
> > > > > [ 2205.999622] Hardware name: Sinsegye SP8000-C340/SP8000-C340, B=
IOS SP80000020260708B 07/08/2026
> > > > > [ 2205.999622] IRQ stage: Linux
> > > > > [ 2205.999623] RIP: 0010:native_queued_spin_lock_slowpath+0x78/0x=
380
> > > > > [ 2205.999625] Code: 2c 24 08 0f 92 c2 41 8b 04 24 0f b6 d2 c1 e2=
 08 30 e4 09 d0 a9 00 01 ff ff 75 5c 85 c0 74 14 41 0f b6 04 24 84 c0 74 0b=
 f3 90 <41> 0f b6 04 24 84 c0 75 f5 b8 01 00 00 00 66 41 89 04 24 5b 41 5c
> > > > > [ 2205.999626] RSP: 0018:ffffb065802dce38 EFLAGS: 00000002
> > > > > [ 2205.999627] RAX: 0000000000000001 RBX: ffff9334dfaaa428 RCX: 0=
000000000000000
> > > > > [ 2205.999627] RDX: 0000000000000000 RSI: 0000000000000000 RDI: f=
fff9334dfa53580
> > > > > [ 2205.999628] RBP: ffffb065802dce58 R08: 0000000000000001 R09: 0=
000000000000000
> > > > > [ 2205.999629] R10: 0000000000000000 R11: ffffb065802dcff8 R12: f=
fff9334dfa53580
> > > > > [ 2205.999629] R13: 0000000000000000 R14: 0000000029f00004 R15: f=
fff9334dfa53580
> > > > > [ 2205.999630] FS:=C2=A0 0000000000000000(0000) GS:ffff9334dfa000=
00(0000) knlGS:0000000000000000
> > > > > [ 2205.999631] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> > > > > [ 2205.999631] CR2: 00007f56540d1b68 CR3: 00000001637a8005 CR4: 0=
000000000772ef0
> > > > > [ 2205.999632] PKRU: 55555554
> > > > > [ 2205.999633] Call Trace:
> > > > > [ 2205.999633]=C2=A0 <IRQ>
> > > > > [ 2205.999634]=C2=A0 do_raw_spin_lock+0xbe/0xd0
> > > > > [ 2205.999636]=C2=A0 _raw_spin_lock_irqsave+0x59/0x70
> > > > > [ 2205.999638]=C2=A0 ? lock_timer_base+0x7b/0xa0
> > > > > [ 2205.999641]=C2=A0 lock_timer_base+0x7b/0xa0
> > > > > [ 2205.999643]=C2=A0 add_timer_on+0x70/0x140
> > > > > [ 2205.999646]=C2=A0 __queue_delayed_work+0xac/0x110
> > > > > [ 2205.999648]=C2=A0 queue_delayed_work_on+0x94/0xb0
> > > > > [ 2205.999650]=C2=A0 therm_throt_process+0x164/0x180
> > > > > [ 2205.999653]=C2=A0 intel_thermal_interrupt+0x12b/0x350
> > > > > [ 2205.999655]=C2=A0 __sysvec_thermal+0x46/0x180
> > > > > [ 2205.999658]=C2=A0 sysvec_thermal+0x9f/0xc0
> > > > > [ 2205.999660]=C2=A0 </IRQ>
> > > > > [ 2205.999660]=C2=A0 <TASK>
> > > > > [ 2205.999661]=C2=A0 asm_sysvec_thermal+0x1f/0x30
> > > > > [ 2205.999663] RIP: 0010:_raw_spin_unlock+0x0/0x50
> > > > > [ 2205.999665] Code: 01 00 00 00 31 c9 ba 01 00 00 00 31 f6 41 bc=
 01 00 00 00 e8 32 04 2c ff 58 48 8d 65 f0 44 89 e0 5b 41 5c 5d c3 0f 1f 44=
 00 00 <f3> 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 fc 48 83 c7 18
> > > > > [ 2205.999666] RSP: 0018:ffffb065801c3e00 EFLAGS: 00000246
> > > > > [ 2205.999666] RAX: 0000000000000001 RBX: 0000000100161a47 RCX: 0=
000000000000001
> > > > > [ 2205.999667] RDX: 0000000000000004 RSI: ffffffff90217c1e RDI: f=
fff9334dfa54840
> > > > > [ 2205.999668] RBP: ffffb065801c3e58 R08: 0000000000000001 R09: 0=
000000000000000
> > > > > [ 2205.999668] R10: 0000000000000001 R11: 0000000000000c2c R12: f=
fff9334dfa53580
> > > > > [ 2205.999669] R13: ffff9334dfa54840 R14: 00000197236c7580 R15: f=
fffb065801c3e7f
> > > > > [ 2205.999672]=C2=A0 ? __get_next_timer_interrupt+0x132/0x380
> > > > > [ 2205.999676]=C2=A0 timer_base_try_to_set_idle+0x17/0x30
> > > > > [ 2205.999678]=C2=A0 tick_nohz_stop_tick+0x70/0x370
> > > > > [ 2205.999681]=C2=A0 tick_nohz_idle_stop_tick+0x72/0xd0
> > > > > [ 2205.999683]=C2=A0 do_idle+0xb8/0x150
> > > > > [ 2205.999685]=C2=A0 cpu_startup_entry+0x30/0x40
> > > > > [ 2205.999688]=C2=A0 start_secondary+0x10e/0x130
> > > > > [ 2205.999690]=C2=A0 common_startup_64+0x13e/0x141
> > > > > [ 2205.999694]=C2=A0 </TASK>
> > > > >=20
> > > > > We addressed this with a local kernel patch, and the issue no lon=
ger reproduces on our side after applying it.
> > > > > Could you please review whether this change is correct and accept=
able upstream?
> > > > >=20
> > > > > diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/a=
sm/idtentry.h
> > > > > index 1b9264e5b..bbd20cfe2 100644
> > > > > --- a/arch/x86/include/asm/idtentry.h
> > > > > +++ b/arch/x86/include/asm/idtentry.h
> > > > > @@ -803,7 +803,7 @@ DECLARE_IDTENTRY_SYSVEC(DEFERRED_ERROR_VECTOR=
, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 sysvec_deferred_error);
> > > > > =C2=A0# endif
> > > > >=20
> > > > > =C2=A0# ifdef CONFIG_X86_THERMAL_VECTOR
> > > > > -DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VECTOR, =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 sysvec_thermal);
> > > > > +DECLARE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR, =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 sysvec_thermal);
> > > > > =C2=A0# else
> > > > > =C2=A0# define fred_sysvec_thermal =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL
> > > > > =C2=A0# endif
> > > > > diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> > > > > index aecdb2d02..c432c22ed 100644
> > > > > --- a/arch/x86/kernel/irq.c
> > > > > +++ b/arch/x86/kernel/irq.c
> > > > > @@ -605,7 +605,8 @@ static void smp_thermal_vector(void)
> > > > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 smp_processor_id());
> > > > > =C2=A0}
> > > > >=20
> > > > > -DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
> > > > > +DEFINE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR,
> > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysvec_thermal)
> > > > > =C2=A0{
> > > > > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 trace_thermal_apic_entry(THERMAL=
_APIC_VECTOR);
> > > > > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 inc_irq_stat(irq_thermal_count);
> > > > > diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq=
_pipeline.c
> > > > > index 8c9d587bf..c7ade9c2c 100644
> > > > > --- a/arch/x86/kernel/irq_pipeline.c
> > > > > +++ b/arch/x86/kernel/irq_pipeline.c
> > > > > @@ -164,6 +164,11 @@ static void do_sysvec_inband(struct irq_desc=
 *desc, struct pt_regs *regs)
> > > > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 run_=
sysvec_on_irqstack_cond(__sysvec_apic_timer_interrupt,
> > > > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=C2=A0 regs);
> > > > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 brea=
k;
> > > > > +#ifdef CONFIG_X86_THERMAL_VECTOR
> > > > > + =C2=A0 =C2=A0 =C2=A0 case THERMAL_APIC_VECTOR:
> > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 run_sysvec_on_=
irqstack_cond(__sysvec_thermal, regs);
> > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > > > > +#endif
> > > > > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 default:
> > > > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 prin=
tk_once(KERN_ERR "irq_pipeline: unexpected event"
> > > > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0 " on vector #%.2x (irq=3D%u)", vector, irq);
> > > > >=20
> > > > =C2=A0
> > > > Yes, the THERMAL_APIC_VECTOR implementation has a pipelining proble=
m.
> > > > =C2=A0
> > > > Main question: Should the event handling take place in-band (Linux)=
 or
> > > > out-of-band (cobalt/evl)?
> > > > =C2=A0
> > > > You selected the first option, which looks sane to me. You now dela=
y the
> > > > handling to the in-band stage.
> > > =C2=A0
> > > It's rather unlikely that there will be any oob handler for the therm=
al
> > > thing.
> > > =C2=A0
> > > At the same time, the occurrence of a thermal event is very likely
> > > already a problem of its own (which does not mean we should not fix i=
ts
> > > handling). Is your system overheated? Will it possibly die soon when =
you
> > > continue like that? At least, it may go into thermal throttling, and
> > > that will not make your RT workload happier.
> > > =C2=A0
> > > Jan
> > > =C2=A0
> > > --=C2=A0
> > > Siemens AG, Foundational Technologies
> > > Linux Expert Center
> > > =C2=A0
>=20
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
