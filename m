Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECE23B992C
	for <xenomai@lists.linux.dev>; Thu, 10 Sep 2026 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045044; cv=none; b=KbHbEVBx5gopubZrawrC028b3dT9XzMe0xgV/6L791sL/8vvZpIk55JSlm1ZZ/SVPgMWVuUXrj8TDnrRZFbmZUdGr0ES3pTxpV/pE1qv7He35Vxq5jY7AmSEeVvSzMpsIcvR6RwUpoI2e6XvMVGxBxoyg+6lEHZKfxy7s+/Ev4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045044; c=relaxed/simple;
	bh=Rhj04Av+hJzLBvKF/gaEHwtZyv82gjozy8+1m/BuucI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DqvaY48oEAMcN/ynXm2AeauD+xpX3fZcld0decYVuufWD4k1bjRwCJmDZ68UJPVec/on2USPavGTM3HY7kAUc6IP4mUuLrx/qjwUb1ip8vvqhlDZhTLFuljfDgelL4NUxpnu7Ydaa9SBmKb5T74I/HGNGq5CRJHzSAxPy4d98Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dsdPk8KK; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dsdPk8KK"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260910125708266a964ee3000207f2
        for <xenomai@lists.linux.dev>;
        Thu, 10 Sep 2026 14:57:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=h7W9uGSSoaGBUOCdtu5cpDcGS+kZNT0XTykXXKbuH8w=;
 b=dsdPk8KKrBr2uojlscrqOI312yCvJpt/q+xInXvZVAZiQred2fRnxcjemiqiNwKPTS4QHk
 9BvCJrx1CtZua6LTGpC9E5Zh8dVRTdFJNnJ8R3A9NcD1BcialQrANXGyxPAjuzcQHtuBFbKx
 tJVFGwtZhlCEGVCRvMSido/V4HJ/+Crn9WYSnGOcJwao36cOuwBw6AOp+z1bNmzEtIzmTVyz
 pS+Gz8CBiR8zHC1csur6q0Oq3s7ZZp0jr7eR9FlMl51HKpJNOJtexhAAnwgiVD5AhBkHjiPd
 7RAeYDGkMRhNza2PrFMdLJYIiRKB67ou/Vx0evAPP4V38Uqdua6QS6wQ==;
Message-ID: <e10b288c461075397c67dad4ea3870cab0154239.camel@siemens.com>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Andrew MacPherson <andrew@elk.audio>
Cc: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>, 
 Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Thu, 10 Sep 2026 14:57:08 +0200
In-Reply-To: <CACiVkwnKDck51TD6jC1K9CJoF05X9hd8xRKiskzdAd4dcj7FQg@mail.gmail.com>
References: 
	<20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
	 <CACiVkwnKDck51TD6jC1K9CJoF05X9hd8xRKiskzdAd4dcj7FQg@mail.gmail.com>
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

On Thu, 2026-09-10 at 14:49 +0200, Andrew MacPherson wrote:
> Hi Florian,
>=20
> On Wed, 9 Sept 2026 at 16:33, Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> >=20
> > Hi all,
> >=20
> > The following is the try to fix the problems reported by Gerte and Andr=
ew.
> > We forgot to add the IRQF_TIMER to some of the arm/arm64 clocksource
> > drivers.
> >=20
> > While the patch provided by Andrew [3] is correct, I tried to find a wa=
y
> > to get rid of this Dovetail specific IRQF_TIMER marking, as it could
> > easily be forgotten.
> >=20
> > Review comments and intensive testing is highly appreciated.
> > Tests were done on qemu for arm, arm64 and x86.
> >=20
> > If accepted / merged we should clean up the dovetail IRQF_TIMER markers
> > afterwards.
> >=20
> > Best regards,
> > Florian
> >=20
> > [1] https://lore.kernel.org/xenomai/CAKndYJF00RPbfD7U8YCAn_vzxDFdtwz5m9=
O=3DJVqhH5fdXHxY9w@mail.gmail.com/T/
> > [2] https://lore.kernel.org/xenomai/CACiVkw=3DVs1KUgfZ=3DMq-rXU=3D4gPFD=
tmuoNoMv=3Drzy_kvV7KgpKg@mail.gmail.com/
> > [3] https://lore.kernel.org/xenomai/20260907083708.2566-1-andrew@elk.au=
dio/T/#u
> >=20
> > To: Xenomai <xenomai@lists.linux.dev>
> > Cc: Philippe Gerum <rpm@xenomai.org>
> > Cc: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
> > Cc: Andrew MacPherson <andrew@elk.audio>
> >=20
> > Suggested-by: Philippe Gerum <rpm@xenomai.org>
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> > Florian Bezdeka (2):
> >       genirq: irq_pipeline: Remove irq_is_oob()
> >       irq_pipeline: Introduce IRQ_TICK to obsolete IRQF_TIMER on tick I=
RQs
> >=20
> >  include/linux/irq.h       | 11 +++++++++--
> >  include/linux/irqdesc.h   |  5 -----
> >  kernel/irq/debug.h        |  1 +
> >  kernel/irq/manage.c       | 11 +++++++++++
> >  kernel/irq/pipeline.c     |  3 ++-
> >  kernel/irq/settings.h     | 17 +++++++++++++++++
> >  kernel/time/clockevents.c |  3 +++
> >  kernel/time/tick-common.c |  5 +++++
> >  8 files changed, 48 insertions(+), 8 deletions(-)
> > ---
> > base-commit: 58e8e0f74c2b20f6228b7d327ec2e955ffd5b491
> > change-id: 20260907-wip-flo-v7-2-irq-cleanup-65fb73c34f9c
> >=20
> > Best regards,
> > --
> > Florian Bezdeka <florian.bezdeka@siemens.com>
> >=20
>=20
> Thanks for looking into this! I backported the patch to the older
> kernel (6.6.48) we're using since it would be difficult to quickly try
> on 7.2 and realized that my earlier testing didn't go far enough.
>=20
> What I really want to run is "perf record -g --call-graph dwarf"
> against a running process, however in testing I was just using "perf
> top" as a quick proxy. With both your patch and the one I submitted
> earlier "perf top" starts returning valid results (not all 0s as
> before). However, both patches result in a kernel panic when trying to
> use them to get a call graph.
>=20
> A snapshot of the panic looks like this:
>=20
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000 when read
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> CPU: 0 PID: 762 Comm: XXXXXX Tainted: G           O       6.6.48 #2
> PC is at unwind_exec_insn+0x2dc/0x47c
> LR is at unwind_frame+0x18c/0x424
>=20
>  unwind_exec_insn from unwind_frame+0x18c/0x424
>  unwind_frame from walk_stackframe+0x30/0x3c
>  walk_stackframe from perf_callchain_kernel+0x60/0x84
>  perf_callchain_kernel from get_perf_callchain+0xa8/0x220
>  get_perf_callchain from perf_callchain+0x84/0x98
>  perf_callchain from perf_prepare_sample+0x4ec/0x650
>  perf_prepare_sample from perf_event_output_forward+0x58/0xd0
>  perf_event_output_forward from __perf_event_overflow+0x98/0x25c
>  __perf_event_overflow from armv7pmu_handle_irq+0x11c/0x150
>  armv7pmu_handle_irq from armpmu_dispatch_irq+0x28/0x80
>  armpmu_dispatch_irq from __handle_irq_event_percpu+0x68/0x224
>  __handle_irq_event_percpu from handle_irq_event+0x58/0xf8
>  handle_irq_event from handle_fasteoi_irq+0x154/0x2f4
>  handle_fasteoi_irq from handle_irq_desc+0x20/0x30
>  handle_irq_desc from arch_do_IRQ_pipelined+0x58/0x98
>  arch_do_IRQ_pipelined from sync_current_irq_stage+0x90/0xc0
>  sync_current_irq_stage from handle_irq_pipelined_finish+0xa0/0x198
>  handle_irq_pipelined_finish from __irq_usr+0x60/0x80
>=20
> Kernel panic - not syncing: Fatal exception in interrupt
>=20
> As before this could just be due to the older kernel and maybe this is
> fixed in the 7.2 branch. I also tried hacking around this issue with
> the help of an LLM, basically to skip unwinding frames that would
> trigger it, which lead to another panic:
>=20
> kernel BUG at kernel/irq_work.c:245!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> CPU: 0 PID: 520 Comm: XXXXXX Tainted: G           O       6.6.48 #4
> PC is at irq_work_run_list+0x14/0x64
> LR is at irq_work_run_list+0xc/0x64
>=20
>  irq_work_run_list from irq_work_run+0x28/0x3c
>  irq_work_run from armv7pmu_handle_irq+0x148/0x150
>  armv7pmu_handle_irq from armpmu_dispatch_irq+0x28/0x80
>  armpmu_dispatch_irq from __handle_irq_event_percpu+0x68/0x224
>  __handle_irq_event_percpu from handle_irq_event+0x58/0xf8
>  handle_irq_event from handle_fasteoi_irq+0x154/0x2f4
>  handle_fasteoi_irq from handle_irq_desc+0x20/0x30
>  handle_irq_desc from arch_do_IRQ_pipelined+0x58/0x90
>  arch_do_IRQ_pipelined from sync_current_irq_stage+0xac/0xe0
>  sync_current_irq_stage from handle_irq_pipelined_finish+0xa0/0x198
>  handle_irq_pipelined_finish from __irq_usr+0x60/0x80
>=20
> Kernel panic - not syncing: Fatal exception in interrupt
>=20
> Hacking also around this one I do get expected call graph results from
> perf, ignoring some bogus sample frames caused by the hacks.
>=20
> Let me know if I can provide any more detail here, I didn't want to
> post patches that are obviously incorrect but if they're useful for
> debugging in any way then I can.
>=20

Thanks for letting me know. Could you please try backporting=20

58e8e0f74c2b ("ARM: irq_pipeline: save registers used for walking tick
frames")

as well and try again.

That was fixed in 7.2 recently and it seems backporting did not start
yet. Your branch is EOL, so... do not expect it to land there.

HTH,
Florian

