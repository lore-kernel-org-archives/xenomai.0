Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926753AEF49
	for <xenomai@lists.linux.dev>; Thu, 10 Sep 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044582; cv=pass; b=OGYrdHq7GQfE6GuxZwi5Y40F0sMmtLGOGzQmI7fGAng6tO0T6SAwR4OPp3jscjs954U/SaKUNhJ8kCoin31U3dIGgo4e2GMCy0t1EtJnWLGJkKMOMTt7CLFb2Tlt+XxakvvRKX4H+g8+vXBsUruyan0Nls3CADHlHyi5A2wna/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044582; c=relaxed/simple;
	bh=5v4gQJxvg4CiujGK3zneJoEkRq3V1NGaPoCz1t0V7g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/x3oa4DpuyqdV5494xHuEfXaPrFkZY2OY2KdPfbGskzacF68q4q4H8KiYhqAJalwCjX0i7kqJPhzCpvC0k/1glrjR6nbuUao+rQe0QvLg2Cr4WHa3JyX2M3c18ecXRu2gfAC7P/eWZBLMqHk6CCITM6Oilkgv/s/gXCFF+lQz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio; spf=fail smtp.mailfrom=elk.audio; dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b=c+5j+I60; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=elk.audio
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b="c+5j+I60"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85902346891so3001777b3.1
        for <xenomai@lists.linux.dev>; Thu, 10 Sep 2026 05:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789044579; cv=none;
        d=google.com; s=arc-20260327;
        b=GjSiXOaskEDUdr3Ugdq+WmYkDFChuW2KWHQsC35QeAIZWRV3LxRuEcDWuI8zUiV9jc
         FecXtKS2LDmt24jJNs2DRr1BdqJX5ZT8HTpmi04Sk8tZCbSVfx0XbQTMSFo8Kbx64xK/
         H5tE0luYFXOY+peol1NBx1J/JLePcBHk9RdQ7cpddTSYAnnr9feaDUTrBhgBv9JyDHCd
         PCiUNnNDJ5SVrIOvr1HbofdnSkEWmSFFH+OpkTcYmvdi1zoF6rXU4LNelW9y4gZSALTh
         LJD0fAd66712OKGV3TkvB5bzeB3M9Tx4fF1KMLVK1/ZoqYPuuvbbPI4mj5QClD0m1fBq
         nyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=45Fsz++Lbfh6eZMxA6SxaTbUHX9fB9tLFJo6J3f6wFQ=;
        fh=/8uP8f4XmGePkw+6r7sOUN5HY7uOcsK3h+LBTu4bcIM=;
        b=J8D7Bxzxn1dBQGO7L8FGEkGoDwZXxzpESsX/SR+NASHLAsFx22ilmm0skR/j3CxCJx
         e1TF9LWIDkH4UgC02wPBVvPPtzpUuN8ACN6YjuQcqusBetjs25jvYP+Ewa1i+N3Q/1XC
         BI9MiOYoseOIPhem0aCOa0FCBWx6KdwHsbEI/JVlSQFhxHCyRavTdpbZVuEIYK82AIN5
         3I8T8U+tdal65mZ1wV3nFdEx8OFwsthFrytrhq3+woK1h5+3O3ZfzuIkjrQqz2NE+gL8
         sh+jh+rZPvecOBoV5YZci6RVhedc7WXVZ4rko9/uLmmf9DCqmudCOeAbiVS0zQu6G9TQ
         M89Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elk-audio.20251104.gappssmtp.com; s=20251104; t=1789044579; x=1789649379; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45Fsz++Lbfh6eZMxA6SxaTbUHX9fB9tLFJo6J3f6wFQ=;
        b=c+5j+I60eXEQLWab7xW9bXjTBELoYyzoXPKFy5X5NeXwo8JAKi4HE6znkogVrxDrRR
         yzAKIHJndMJA6n2VPb15B9lP2qYkxeKMRncCLx55z4ysL+a9XkyHMt1OMgTXxwqY+y0p
         xbg6njhDGBGTGfrItJSjju8554114T1swSwrZK0lzgs7REMI2irUHGX2vFTPUmR2JQUx
         UFAk45JA9ywpx4ZZlxP301J6yK4FEu16l7rUte8gh7cWlr3b0/8OMu/FBHj1TcPrQjPy
         k4LYfCYAfbfa67r3ayl+zp3gQo4DfZGFOcbMk6Xx865wcgClg7xrBBOmRkFWQCWC+05j
         zGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789044579; x=1789649379;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=45Fsz++Lbfh6eZMxA6SxaTbUHX9fB9tLFJo6J3f6wFQ=;
        b=RO39viZLvFPDEsefGWab7odw//j1NrkEJo2UbFp3Jy/jff6Mx8yJ1SdH+zQurjNZAx
         8N58K0iOffci/MdEEs/iqgXB83hSVS+ATPtZG6RT0AkbhfDoOhRSeUSa+fPhUtAJnm6h
         t6qgicP8YNmq5sCJh9dSV9fGJNWDILhyxlRt101mk0nXl25zTnAzph6mNENICPjpg8+T
         I4bkNsT2ph+QkbY5uqloYtbIgMTeHn6SorYEJ0yV7T7zTXff3PGrIyJVMD8Vi8HXF5Rt
         YEMHDDI+3ydFfJov3c1PXUyp+6MGr7mOThtcXLWijypkAUevokQBRxqfKEdfq2+w1N2W
         8OGw==
X-Gm-Message-State: AFuF++n3Znqmug7/uB06MPxEl/JkRaruS2mxltPPSfamRQUPPrUOzJKy
	fO9l1wN/+wgFVgO/i/zhpgcQmESJdqCXOd5sFQG+hhxqSMcHgk/LjIagY63hjp7gEyZq6OCR3QZ
	sH4kVT9KjLGDEtdGxnwPDZCGP7yCgauWeB6/SViMwJQ==
X-Gm-Gg: AYBFou1YFYqu87fnw6HhQtQq7IZhkS3ia4eNPjOzRnl4G9H6HjaMKHO+zTOlP5OiDxa
	aHGGwBSWlFYNojY5wGIIq4dcMFbC9J53YUlEZGgBOHTDxVfhH4XSN9BPsbs3ufiLYMdMXTVFxs3
	7tomGtECUDxgmqBdOKCMdbytvNpgsNMhDh5dsEjSqZRfgOwH23VjQDcPA3hUqNBlygZB8d1Xa79
	KoQDY4CJa1uSIJqq04l0Nls8S3iErREsezVz4lLPASoobJrpKeoMoRkEdYhtvtVyAO1XtkFOWj3
	wIiT27fHZSQNbiKCiK/YE8Tys3AjYvH6y6c7m08YpP+ihqVdPwfAb4M=
X-Received: by 2002:a05:690c:4b02:b0:871:3e81:955f with SMTP id
 00721157ae682-873ed26abbemr130048647b3.1.1789044578982; Thu, 10 Sep 2026
 05:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
In-Reply-To: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
From: Andrew MacPherson <andrew@elk.audio>
Date: Thu, 10 Sep 2026 14:49:28 +0200
X-Gm-Features: AcwNN1VtTySArGdwvFbhj_lh73-dz_Vv5LX_AANFA4tHzeHgceBpG45b0p4y5t4
Message-ID: <CACiVkwnKDck51TD6jC1K9CJoF05X9hd8xRKiskzdAd4dcj7FQg@mail.gmail.com>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>, 
	Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Content-Type: text/plain; charset="UTF-8"

Hi Florian,

On Wed, 9 Sept 2026 at 16:33, Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
>
> Hi all,
>
> The following is the try to fix the problems reported by Gerte and Andrew.
> We forgot to add the IRQF_TIMER to some of the arm/arm64 clocksource
> drivers.
>
> While the patch provided by Andrew [3] is correct, I tried to find a way
> to get rid of this Dovetail specific IRQF_TIMER marking, as it could
> easily be forgotten.
>
> Review comments and intensive testing is highly appreciated.
> Tests were done on qemu for arm, arm64 and x86.
>
> If accepted / merged we should clean up the dovetail IRQF_TIMER markers
> afterwards.
>
> Best regards,
> Florian
>
> [1] https://lore.kernel.org/xenomai/CAKndYJF00RPbfD7U8YCAn_vzxDFdtwz5m9O=JVqhH5fdXHxY9w@mail.gmail.com/T/
> [2] https://lore.kernel.org/xenomai/CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com/
> [3] https://lore.kernel.org/xenomai/20260907083708.2566-1-andrew@elk.audio/T/#u
>
> To: Xenomai <xenomai@lists.linux.dev>
> Cc: Philippe Gerum <rpm@xenomai.org>
> Cc: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
> Cc: Andrew MacPherson <andrew@elk.audio>
>
> Suggested-by: Philippe Gerum <rpm@xenomai.org>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (2):
>       genirq: irq_pipeline: Remove irq_is_oob()
>       irq_pipeline: Introduce IRQ_TICK to obsolete IRQF_TIMER on tick IRQs
>
>  include/linux/irq.h       | 11 +++++++++--
>  include/linux/irqdesc.h   |  5 -----
>  kernel/irq/debug.h        |  1 +
>  kernel/irq/manage.c       | 11 +++++++++++
>  kernel/irq/pipeline.c     |  3 ++-
>  kernel/irq/settings.h     | 17 +++++++++++++++++
>  kernel/time/clockevents.c |  3 +++
>  kernel/time/tick-common.c |  5 +++++
>  8 files changed, 48 insertions(+), 8 deletions(-)
> ---
> base-commit: 58e8e0f74c2b20f6228b7d327ec2e955ffd5b491
> change-id: 20260907-wip-flo-v7-2-irq-cleanup-65fb73c34f9c
>
> Best regards,
> --
> Florian Bezdeka <florian.bezdeka@siemens.com>
>

Thanks for looking into this! I backported the patch to the older
kernel (6.6.48) we're using since it would be difficult to quickly try
on 7.2 and realized that my earlier testing didn't go far enough.

What I really want to run is "perf record -g --call-graph dwarf"
against a running process, however in testing I was just using "perf
top" as a quick proxy. With both your patch and the one I submitted
earlier "perf top" starts returning valid results (not all 0s as
before). However, both patches result in a kernel panic when trying to
use them to get a call graph.

A snapshot of the panic looks like this:

Unable to handle kernel NULL pointer dereference at virtual address
00000000 when read
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
CPU: 0 PID: 762 Comm: XXXXXX Tainted: G           O       6.6.48 #2
PC is at unwind_exec_insn+0x2dc/0x47c
LR is at unwind_frame+0x18c/0x424

 unwind_exec_insn from unwind_frame+0x18c/0x424
 unwind_frame from walk_stackframe+0x30/0x3c
 walk_stackframe from perf_callchain_kernel+0x60/0x84
 perf_callchain_kernel from get_perf_callchain+0xa8/0x220
 get_perf_callchain from perf_callchain+0x84/0x98
 perf_callchain from perf_prepare_sample+0x4ec/0x650
 perf_prepare_sample from perf_event_output_forward+0x58/0xd0
 perf_event_output_forward from __perf_event_overflow+0x98/0x25c
 __perf_event_overflow from armv7pmu_handle_irq+0x11c/0x150
 armv7pmu_handle_irq from armpmu_dispatch_irq+0x28/0x80
 armpmu_dispatch_irq from __handle_irq_event_percpu+0x68/0x224
 __handle_irq_event_percpu from handle_irq_event+0x58/0xf8
 handle_irq_event from handle_fasteoi_irq+0x154/0x2f4
 handle_fasteoi_irq from handle_irq_desc+0x20/0x30
 handle_irq_desc from arch_do_IRQ_pipelined+0x58/0x98
 arch_do_IRQ_pipelined from sync_current_irq_stage+0x90/0xc0
 sync_current_irq_stage from handle_irq_pipelined_finish+0xa0/0x198
 handle_irq_pipelined_finish from __irq_usr+0x60/0x80

Kernel panic - not syncing: Fatal exception in interrupt

As before this could just be due to the older kernel and maybe this is
fixed in the 7.2 branch. I also tried hacking around this issue with
the help of an LLM, basically to skip unwinding frames that would
trigger it, which lead to another panic:

kernel BUG at kernel/irq_work.c:245!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
CPU: 0 PID: 520 Comm: XXXXXX Tainted: G           O       6.6.48 #4
PC is at irq_work_run_list+0x14/0x64
LR is at irq_work_run_list+0xc/0x64

 irq_work_run_list from irq_work_run+0x28/0x3c
 irq_work_run from armv7pmu_handle_irq+0x148/0x150
 armv7pmu_handle_irq from armpmu_dispatch_irq+0x28/0x80
 armpmu_dispatch_irq from __handle_irq_event_percpu+0x68/0x224
 __handle_irq_event_percpu from handle_irq_event+0x58/0xf8
 handle_irq_event from handle_fasteoi_irq+0x154/0x2f4
 handle_fasteoi_irq from handle_irq_desc+0x20/0x30
 handle_irq_desc from arch_do_IRQ_pipelined+0x58/0x90
 arch_do_IRQ_pipelined from sync_current_irq_stage+0xac/0xe0
 sync_current_irq_stage from handle_irq_pipelined_finish+0xa0/0x198
 handle_irq_pipelined_finish from __irq_usr+0x60/0x80

Kernel panic - not syncing: Fatal exception in interrupt

Hacking also around this one I do get expected call graph results from
perf, ignoring some bogus sample frames caused by the hacks.

Let me know if I can provide any more detail here, I didn't want to
post patches that are obviously incorrect but if they're useful for
debugging in any way then I can.

Thanks again,

Andrew
