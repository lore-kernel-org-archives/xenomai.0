Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5D15687D
	for <xenomai@lists.linux.dev>; Mon, 26 May 2025 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247573; cv=none; b=KyIjIM1HPjF5YsDo6xk6p7t7qsfbQ+b2Pjo4HvmkP5vmiOvMADHayNwuPVByRxTwjaA93hnI25Rcv6BNxbzCCu3nNVqpdtXU3T0isdfgMhG6jNRlpjF0rY3fIMTuOEkBrNWPaacQ6eoWi9qCjF0S/IlZq1o3y6VOZaI0yGsNzMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247573; c=relaxed/simple;
	bh=ma9cEduLTKeWzCWX9/XuL+g42N664bUB9FWnNV+v4io=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=AJEcHYS33fvSpFCnACLVcRXdOTo2y3wSKn5rP/1jjxLlEYCfIw7wQqdWrMMdTDT3sVbFAKh1efbbeAD3azfetby2nT7WI/MP0Z+upNTv/9eoyIlC5osfrDNNl8B1xMwK4liS1zhu3d69RUC9GS4kSrll5/nxkWHq6DIm/yDflxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from smtpclient.apple(mailfrom:liyinjie@sinsegye.com.cn fp:SMTPD_---.d.W4jXJ_1748247557 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 26 May 2025 16:19:17 +0800
From: =?utf-8?B?5p2O6IOk6aKJ?= <liyinjie@sinsegye.com.cn>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: =?utf-8?Q?Xenomai_3=2E2=2E3_/_Kernel_5=2E15_=E2=80=94_Periodic_ta?=
 =?utf-8?Q?sk_occasionally_stretches_from_=E2=89=8870_=C2=B5s_to_=E2=89=88?=
 =?utf-8?Q?350_=C2=B5s_=E2=80=94_is_the_OOB_LAPIC_timer_the_cause=3F?=
Message-Id: <A843D8BF-1964-4E87-A2EE-1B8D8E067BE0@sinsegye.com.cn>
Date: Mon, 26 May 2025 16:19:06 +0800
Cc: =?utf-8?B?5a6L5YGl546u?= <songjianwei@sinsegye.com.cn>,
 liuyang@sinsegye.com.cn
To: xenomai@lists.linux.dev
X-Mailer: Apple Mail (2.3776.700.51)

Hi,all

Environment
=E2=80=A2 Xenomai version: 3.2.3 (Cobalt)
=E2=80=A2 Linux kernel: 5.15.y
=E2=80=A2 CPU: Intel 6-core, 12th Gen Intel(R) Core(TM) i5-12400
=E2=80=A2 Boot parameters (relevant excerpts):
isolcpus=3D1 nohz_full=3D1 rcu_nocbs=3D1 irqaffinity=3D0,2-5
idle=3Dpoll intel_idle.max_cstate=3D0 intel_pstate=3Ddisable

Task description
PID 2780 is a periodic hard-real-time thread pinned to CPU 1.
Its period is ~3 ms; the actual work per cycle, measured in the kernel, =
is normally about 65-75 =C2=B5s.

Observed timing
Using trace-cmd (function_graph tracer) I measure the interval from the =
first
cobalt_trace_pid pid=3D2780
to the corresponding
x86_fpu_regs_deactivated
for each cycle.
Best-case: 65-75 =C2=B5s (expected)
Worst-case: 320-360 =C2=B5s (occasional)

Typical long slice (abridged):
<idle>-0     [001]   804.488903: cobalt_timer_start:   =
timer=3D0xffff93812f4ddc68([watchdog]) value=3D30000000000 interval=3D0 =
mode=3D0x0
           <...>-2780  [001]   804.488904: cobalt_trace_pid:     =
pid=3D2780, prio=3D99
           <...>-2780  [001]   804.488904: cobalt_head_sysexit:  =
result=3D0
           <...>-2780  [001]   804.488904: cobalt_head_sysentry: =
syscall=3Dsem_post
           <...>-2780  [001]   804.488904: cobalt_psem_post:     =
sem=3D0x140
           <...>-2780  [001]   804.488904: cobalt_synch_wakeup:  =
synch=3D0xffffb42c00b55208
           <...>-2780  [001]   804.488905: cobalt_thread_resume: =
name=3DSchedProcessorL pid=3D2776 mask=3D0x2
           <...>-2780  [001]   804.488905: cobalt_trace_pid:     =
pid=3D2776, prio=3D0
           <...>-2780  [001]   804.488905: cobalt_schedule:      =
status=3D0x10000000
           <...>-2780  [001]   804.488905: cobalt_trace_pid:     =
pid=3D2780, prio=3D99
           <...>-2780  [001]   804.488905: write_msr:            830, =
value 1000008ea
           <...>-2780  [001]   804.488905: cobalt_head_sysexit:  =
result=3D0
           <...>-2780  [001]   804.489153: irq_pipeline_entry:   =
irq=3D524546
           <...>-2780  [001]   804.489153: irq_handler_entry:    =
irq=3D524546 name=3DOut-of-band LAPIC timer interrupt
           <...>-2780  [001]   804.489153: local_timer_entry:    =
vector=3D236
           <...>-2780  [001]   804.489154: cobalt_timer_expire:  =
timer=3D0xffff93812f4dd318
           <...>-2780  [001]   804.489154: cobalt_tick_shot:     [FAILED =
TO PARSE] secs=3D808 nsecs=3D719099802 delta=3D4229945802
           <...>-2780  [001]   804.489154: write_msr:            6e0, =
value 1f765d1d54e
           <...>-2780  [001]   804.489154: local_timer_exit:     =
vector=3D236
           <...>-2780  [001]   804.489154: irq_handler_exit:     =
irq=3D524546 ret=3Dhandled
           <...>-2780  [001]   804.489154: irq_pipeline_exit:    =
irq=3D524546
           <...>-2780  [001]   804.489247: cobalt_head_sysentry: =
syscall=3Dclock_nanosleep
           <...>-2780  [001]   804.489247: cobalt_clock_nanosleep: =
clock_id=3D1 flags=3D0x1(TIMER_ABSTIME) rqt=3D(804.491955411)
           <...>-2780  [001]   804.489247: cobalt_thread_suspend: =
pid=3D2780 mask=3D0x4 timeout=3D804491955412 timeout_mode=3D1 =
wchan=3D(nil)
           <...>-2780  [001]   804.489247: cobalt_timer_start:   =
timer=3D0xffffb42c00b4f4b0(CMHooksTask) value=3D804491955412 interval=3D0 =
mode=3D0x1
           <...>-2780  [001]   804.489248: cobalt_tick_shot:     [FAILED =
TO PARSE] secs=3D804 nsecs=3D489901754 delta=3D654196
           <...>-2780  [001]   804.489248: write_msr:            6e0, =
value 1e5f6c5b37b
           <...>-2780  [001]   804.489248: cobalt_schedule:      =
status=3D0x10000000
           <...>-2780  [001]   804.489248: cobalt_trace_pid:     =
pid=3D2780, prio=3D99
           <...>-2780  [001]   804.489248: cobalt_switch_context: =
prev_name=3DTask1 prev_pid=3D2780 prev_prio=3D99 prev_state=3D0x48044 =
=3D=3D> next_name=3DROOT/1 next_pid=3D0 next_prio=3D-1
           <...>-2780  [001]   804.489248: cobalt_timer_stop:    =
timer=3D0xffff93812f4ddc68
           <...>-2780  [001]   804.489248: x86_fpu_regs_deactivated: =
x86/fpu: 0xffff937dd4389540 load: 0 xfeatures: 203 xcomp_bv: =
8000000000000207
<idle>-0     [001]   804.489248: cobalt_trace_pid:     pid=3D0, prio=3D-1

Questions:
1. Is the out-of-band LAPIC timer indeed what inflates some cycles to =
roughly 350 =C2=B5s?
2. What practical steps can I take to keep the cycle time from blowing =
up to roughly 350 =C2=B5s (about five times the normal 70 =C2=B5s) and =
hold it near the expected range?


