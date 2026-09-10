Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4037757D
	for <xenomai@lists.linux.dev>; Thu, 10 Sep 2026 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051124; cv=pass; b=jmS+cu9GlBTMjfxOgLAQsyWwxDs0/RrXCBY5VmohIDR1ig3MxXcpn0I2dI7mc/W8s4XzG24y1/WP1SciByzbcAe0ysbNtftotjhdfB+qAKOs6kk2n6SCsfgZBAUcbXUuLkPNJ5l06b/HP10gdVwXnGPRF6ppJJzm06rAQoz+gjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051124; c=relaxed/simple;
	bh=Cu+RZmLnaxhEZo4qH5Nanr4OKZeKpVNSmS6U+gpWvkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbxPKBzbf3qM98Qe45Q7hQINHPWB9SMJZkuM+9M5wJAdBSxU6/4FrbbuXeePOc//nG/7Bqt5RuTm89Tru3f5GUcqZuqiChmmLR3DmILlCkfIGPNqojxcP+5ixhf4G0AY45ruKVYzsSZsTYM+yIjD+9SbJGtp/Qo37JyHcE2ALYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio; spf=fail smtp.mailfrom=elk.audio; dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b=AmMHRDPa; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=elk.audio
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b="AmMHRDPa"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85902346891so3173757b3.1
        for <xenomai@lists.linux.dev>; Thu, 10 Sep 2026 07:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789051121; cv=none;
        d=google.com; s=arc-20260327;
        b=Pt/aCVi6uRT6KSjxsfLVR6VGEYxBgJ+gNXXIvCM4IcCTGplHEoPiPMEX5nw5mG2SYz
         e311mIxbyJIudYJW19aBZICv/B6QxJq6zHKB3YRAIRwPKtaunxV9eT/kr/Qex5gEsfgX
         CQrRwQKF9ZNtdi6zgv/m7vz+B9Gcs4SmZ6lmKKCJVzBW47tlaeXMZB0lV0/Y8lPPG7Tz
         2X/j641ZFKyCWBIVQFnq/367s0gPjVd84sLDXdD/F3ThEyjQN1dnvOkTnUM1m0WAk0I+
         yQrqcK7HSfB6DSyBERnt/C2icIvcTsxOEAl2pWzc7I3yBYtm9gka2x2YrlS1YeULDIXS
         uluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Nb1oZh8LXU4MrfIgkD6GEM/Od5Loay0xasyKplDwyvc=;
        fh=/8uP8f4XmGePkw+6r7sOUN5HY7uOcsK3h+LBTu4bcIM=;
        b=pMZ72YOuh8LlCnToYtzT4K2kZd5GX5/AjRES21uY9vrPTmfJnDTPO4BQT2nsyctK8H
         GptRIrkdpDyvPKM6iJ5BHEB+7DrhpPBtVG0lMeSD8ht5R0D6TJB7SFfmNf99fBbyTQY9
         QnfvWQm96Ip5O/D9QKXm1z/phXVYELpGFKVvHZTd7cpJ608kwcwyocp1pu8XIYpQLM8Y
         +YnvjCCg1V9c3XAn3cF3NnTlk1I+SDPdDVSP8BIK97tQ37aRwdhNCxxTfmL9zPAayXqA
         zBlrANyKKJPoHM2PjPFW9zgkIUYyxcG/YfxumrhtWAJDs2cZhqVdkphlBhlkPjXawUUI
         FxsQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elk-audio.20251104.gappssmtp.com; s=20251104; t=1789051121; x=1789655921; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nb1oZh8LXU4MrfIgkD6GEM/Od5Loay0xasyKplDwyvc=;
        b=AmMHRDPaJPfUdMtpPYmR0bJsYlLIAECEwcnAA0L4Ribm0OZHwWaAn8L4Zz4GH8dxws
         hXSfhZhbBrQ0BTuOldkEx/d97SgS5A4gjM1cDJm3lNCSONKYEdD8Qjdp9uoLmOigklYk
         BAKMR/LT2EVqCTB4fvs0Xif7xfUEFe6cnGpDgcMFleZAe1op8qoc7fXFilcsrir1rxE/
         ZsBBtyonU0Peq8aCALl09Y5RKQNdPI2uT0DcAj9kQRNBvJiNghcnp/ICQfXr/9rqwboC
         Ktr8i32M2NMLH6Hj1JI4we6hMvVZgcklOz7/GQHQuT7Eukl2RjthaKipA3R6cOUxZJzW
         k2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051121; x=1789655921;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nb1oZh8LXU4MrfIgkD6GEM/Od5Loay0xasyKplDwyvc=;
        b=gzVAlpFQNDF1mgtoo1W5Tl8JM73eImkweKj0qhCjWJ8a9dbHGYA5Q04unYoKIeh2Xl
         hCqSWIImWZhWFX7RMy4CppL+hQyItPGd5xixPktzLyMxhtM6nQjSYiEsz+LRi8ZLwfjw
         A82KdeIzstQ/J/m6GjslDb9UK/+r54lnh1jMxDu1Axd/YlMHyzxJDlQGfTKMNbjm6BhT
         4qVDu3+mMFMSFGt/kW1GXo7xVUIory0RR6Ils++ENhKTZH0EOFKyn94fHkHZxVmXSd70
         BTNg1vm+B0wBg2ss0bT28Coj1O1ISyrtgLzrmLISKb5hCcZwXh67U+Q9Ah1o7pAv6YNd
         KxFg==
X-Gm-Message-State: AFuF++kfpVgphab4Rt9J+fNBUBAqI/LzyQPxvQhsSnNoP1YAKfVVn+qt
	3iFMaTlX4nAso+QIBwUfeyz7oAOqjPZT5kL3n4MZmgJ3LmOZI3Iod1HegDVVsdc47INwUuypUyl
	nRDkoYw85LBf2hldBZDi/+RooAKOKiHW9w2fXuYcWpA==
X-Gm-Gg: AYBFou0sEbInHxjgoFe+QPbkhG8ZsnrdtRxqNJiboNPB8DHVXDyKsXCKFuuyu1/HRP9
	x2qlDRvcGOtnjv7X3FS65TnoMewVvKpmodz0O2I+tdFe0F7wennLAUeVsUp3cEceSpsl34Ek4O4
	YDiablB71vpEPSUa4gq+YctyQxwoqa4y4plnO8HROs6LCsocb5MzXYFGcqz/a4QLAHE9ZIckPld
	x1wtYA90FNn6eD3+EZpAMswkxBY2QTg45HFnXyNdkVujbQeOeHVufpBnkMp+ZrUf2Euz5DBaNWT
	419wfKZAvD/keM8XJnEtdM8TbHLtimMGo0T2uhfmivNxEFeGxzJh270oUuUispSDzyY=
X-Received: by 2002:a05:690c:9c08:b0:862:7bf8:287a with SMTP id
 00721157ae682-873f3b91410mr146242387b3.4.1789051120404; Thu, 10 Sep 2026
 07:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
 <CACiVkwnKDck51TD6jC1K9CJoF05X9hd8xRKiskzdAd4dcj7FQg@mail.gmail.com> <e10b288c461075397c67dad4ea3870cab0154239.camel@siemens.com>
In-Reply-To: <e10b288c461075397c67dad4ea3870cab0154239.camel@siemens.com>
From: Andrew MacPherson <andrew@elk.audio>
Date: Thu, 10 Sep 2026 16:38:29 +0200
X-Gm-Features: AcwNN1XOlVtKVle5HmRpNhaULpUPl8v7ym-5eoyf-6Cu1UjLrv13pGlqqrGDHFc
Message-ID: <CACiVkwmeN=8k=oRyusakE78uVYcz2zKws8ytRecFnL2ah8ySZA@mail.gmail.com>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>, 
	Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Sept 2026 at 14:57, Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
>
> On Thu, 2026-09-10 at 14:49 +0200, Andrew MacPherson wrote:
> > Hi Florian,
> >
> > On Wed, 9 Sept 2026 at 16:33, Florian Bezdeka
> > <florian.bezdeka@siemens.com> wrote:
> > >
> > > Hi all,
> > >
> > > The following is the try to fix the problems reported by Gerte and Andrew.
> > > We forgot to add the IRQF_TIMER to some of the arm/arm64 clocksource
> > > drivers.
> > >
> > > While the patch provided by Andrew [3] is correct, I tried to find a way
> > > to get rid of this Dovetail specific IRQF_TIMER marking, as it could
> > > easily be forgotten.
> > >
> > > Review comments and intensive testing is highly appreciated.
> > > Tests were done on qemu for arm, arm64 and x86.
> > >
> > > If accepted / merged we should clean up the dovetail IRQF_TIMER markers
> > > afterwards.
> > >
> > > Best regards,
> > > Florian
> > >
> > > [1] https://lore.kernel.org/xenomai/CAKndYJF00RPbfD7U8YCAn_vzxDFdtwz5m9O=JVqhH5fdXHxY9w@mail.gmail.com/T/
> > > [2] https://lore.kernel.org/xenomai/CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com/
> > > [3] https://lore.kernel.org/xenomai/20260907083708.2566-1-andrew@elk.audio/T/#u
> > >
> > > To: Xenomai <xenomai@lists.linux.dev>
> > > Cc: Philippe Gerum <rpm@xenomai.org>
> > > Cc: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
> > > Cc: Andrew MacPherson <andrew@elk.audio>
> > >
> > > Suggested-by: Philippe Gerum <rpm@xenomai.org>
> > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > ---
> > > Florian Bezdeka (2):
> > >       genirq: irq_pipeline: Remove irq_is_oob()
> > >       irq_pipeline: Introduce IRQ_TICK to obsolete IRQF_TIMER on tick IRQs
> > >
> > >  include/linux/irq.h       | 11 +++++++++--
> > >  include/linux/irqdesc.h   |  5 -----
> > >  kernel/irq/debug.h        |  1 +
> > >  kernel/irq/manage.c       | 11 +++++++++++
> > >  kernel/irq/pipeline.c     |  3 ++-
> > >  kernel/irq/settings.h     | 17 +++++++++++++++++
> > >  kernel/time/clockevents.c |  3 +++
> > >  kernel/time/tick-common.c |  5 +++++
> > >  8 files changed, 48 insertions(+), 8 deletions(-)
> > > ---
> > > base-commit: 58e8e0f74c2b20f6228b7d327ec2e955ffd5b491
> > > change-id: 20260907-wip-flo-v7-2-irq-cleanup-65fb73c34f9c
> > >
> > > Best regards,
> > > --
> > > Florian Bezdeka <florian.bezdeka@siemens.com>
> > >
> >
> > Thanks for looking into this! I backported the patch to the older
> > kernel (6.6.48) we're using since it would be difficult to quickly try
> > on 7.2 and realized that my earlier testing didn't go far enough.
> >
> > What I really want to run is "perf record -g --call-graph dwarf"
> > against a running process, however in testing I was just using "perf
> > top" as a quick proxy. With both your patch and the one I submitted
> > earlier "perf top" starts returning valid results (not all 0s as
> > before). However, both patches result in a kernel panic when trying to
> > use them to get a call graph.
> >
> > A snapshot of the panic looks like this:
> >
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000000 when read
> > Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> > CPU: 0 PID: 762 Comm: XXXXXX Tainted: G           O       6.6.48 #2
> > PC is at unwind_exec_insn+0x2dc/0x47c
> > LR is at unwind_frame+0x18c/0x424
> >
> >  unwind_exec_insn from unwind_frame+0x18c/0x424
> >  unwind_frame from walk_stackframe+0x30/0x3c
> >  walk_stackframe from perf_callchain_kernel+0x60/0x84
> >  perf_callchain_kernel from get_perf_callchain+0xa8/0x220
> >  get_perf_callchain from perf_callchain+0x84/0x98
> >  perf_callchain from perf_prepare_sample+0x4ec/0x650
> >  perf_prepare_sample from perf_event_output_forward+0x58/0xd0
> >  perf_event_output_forward from __perf_event_overflow+0x98/0x25c
> >  __perf_event_overflow from armv7pmu_handle_irq+0x11c/0x150
> >  armv7pmu_handle_irq from armpmu_dispatch_irq+0x28/0x80
> >  armpmu_dispatch_irq from __handle_irq_event_percpu+0x68/0x224
> >  __handle_irq_event_percpu from handle_irq_event+0x58/0xf8
> >  handle_irq_event from handle_fasteoi_irq+0x154/0x2f4
> >  handle_fasteoi_irq from handle_irq_desc+0x20/0x30
> >  handle_irq_desc from arch_do_IRQ_pipelined+0x58/0x98
> >  arch_do_IRQ_pipelined from sync_current_irq_stage+0x90/0xc0
> >  sync_current_irq_stage from handle_irq_pipelined_finish+0xa0/0x198
> >  handle_irq_pipelined_finish from __irq_usr+0x60/0x80
> >
> > Kernel panic - not syncing: Fatal exception in interrupt
> >
> > As before this could just be due to the older kernel and maybe this is
> > fixed in the 7.2 branch. I also tried hacking around this issue with
> > the help of an LLM, basically to skip unwinding frames that would
> > trigger it, which lead to another panic:
> >
> > kernel BUG at kernel/irq_work.c:245!
> > Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > CPU: 0 PID: 520 Comm: XXXXXX Tainted: G           O       6.6.48 #4
> > PC is at irq_work_run_list+0x14/0x64
> > LR is at irq_work_run_list+0xc/0x64
> >
> >  irq_work_run_list from irq_work_run+0x28/0x3c
> >  irq_work_run from armv7pmu_handle_irq+0x148/0x150
> >  armv7pmu_handle_irq from armpmu_dispatch_irq+0x28/0x80
> >  armpmu_dispatch_irq from __handle_irq_event_percpu+0x68/0x224
> >  __handle_irq_event_percpu from handle_irq_event+0x58/0xf8
> >  handle_irq_event from handle_fasteoi_irq+0x154/0x2f4
> >  handle_fasteoi_irq from handle_irq_desc+0x20/0x30
> >  handle_irq_desc from arch_do_IRQ_pipelined+0x58/0x90
> >  arch_do_IRQ_pipelined from sync_current_irq_stage+0xac/0xe0
> >  sync_current_irq_stage from handle_irq_pipelined_finish+0xa0/0x198
> >  handle_irq_pipelined_finish from __irq_usr+0x60/0x80
> >
> > Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Hacking also around this one I do get expected call graph results from
> > perf, ignoring some bogus sample frames caused by the hacks.
> >
> > Let me know if I can provide any more detail here, I didn't want to
> > post patches that are obviously incorrect but if they're useful for
> > debugging in any way then I can.
> >
>
> Thanks for letting me know. Could you please try backporting
>
> 58e8e0f74c2b ("ARM: irq_pipeline: save registers used for walking tick
> frames")
>
> as well and try again.
>
> That was fixed in 7.2 recently and it seems backporting did not start
> yet. Your branch is EOL, so... do not expect it to land there.
>
> HTH,
> Florian
>

That patch resolved the first crash (in unwind_exec_insn) but the
second one still remains (in irq_work_run_list).

And apologies for the older kernel, we're aware that we're on a
deprecated version and are in the process of upgrading, just wanted to
report what we're seeing here in case it's relevant in later versions.

Thanks!

Andrew
