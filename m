Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C0481648
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785485; cv=pass; b=M5/n7ts9q4qEpcuxDfgpEy6noRzhimV3WyQhVhgyjtDD+tJfwTPeU9RVvgsgTgk0ty1ts+Dvw66CNniAY1CipVeptiiXacWV9ZuKQYk4hCbEE7Ql4qBlKBJryN3UhsogaiVAph/FDwefmYzkDhj94BEh5GAzBnb7zNTb5GkT1ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785485; c=relaxed/simple;
	bh=Rn02oMjOh5KkwR0hEo6kN4SHI1V+cIqTkRZokH+deWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZ6IlAO2XtaxUZE9dU5KnrCzgjgCKwiNo+ScwdEoks07nlfEv7iVjGAWuGlS179gvDJDCXR88Fzf4ZsAK8S7wnWkTKQMGE3zQWAAy5ZCdu621sgEPLBxJiDu6HkWP0OVlDKx4AOFJPyzebO15mCNnydrJ6c5ii9GWMH6ARRdpos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio; spf=fail smtp.mailfrom=elk.audio; dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b=AwSDkMKN; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=elk.audio
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b="AwSDkMKN"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66d20c35573so276580d50.1
        for <xenomai@lists.linux.dev>; Mon, 07 Sep 2026 05:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788785482; cv=none;
        d=google.com; s=arc-20260327;
        b=o1PnnWoW5n2TGyXm5FxeI5G6KN7dTXHuuMY0U/Pb7PbRtK6xZlEy88nIV7mNKcdxMg
         FuSFaCNcn7A9MrLeulYL+CDC7Dgzd3EcXCiyfo4ptwbtd9MDEna1pXbc062PL08fyKOy
         w/2NVhl/oRnfkWUNLu736pqv0DSDjscIlBTu3CHLqgZ2sEhCojbSy9JhRARsljH/tHy1
         0YWQib5ii0BPbqmKBLUXWwhsxYLO2peMT2fu950q79iJJaGA0y110kYaj3VcDa33Ism0
         obxdxnqv0+RoVf16MzI1zTDKQVubTPEBo9YVKz5O127umLjPRezESNz4AETuboRRJ3Zb
         vUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FYyD0CEd/7kgAnjNuYRLJyFKuQnWMAbHlQSKa5do9uE=;
        fh=zOOzAiozDfEnXfBrtfQ7xhiNGoTBCrCahxTPlVPjjWc=;
        b=ldmZ4mxYgTkjWVVAv+Rs1FFg0tRkXDzSetvloIt+ESY+wuDdJpjn+pAMtxu8PaPBZN
         inu+aRx20xSoWNCEY1l6tc8pkwbbxPtwEFnDebL4rvV6BfhsFnT9cru9odN58yABMT6/
         XZGPlswELznnO4wsK5NQc4htlezWO5ZYgb68g2lKa3FWVVCKZwi7t3qaGQvQ5yH2Heyp
         eOOXjRDhQHx1uVnMBMkx5P8x21lG5cf46bJKEs4+NWvGP/89ySgP5e88fFYGOEQNGO4v
         tMNnc5WKlvCy4xMIivYS213WiyVeU6NXrpU0ezDGUmHbvY6ByMqLnJfzpZEjt84K27Tk
         vhmQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elk-audio.20251104.gappssmtp.com; s=20251104; t=1788785482; x=1789390282; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FYyD0CEd/7kgAnjNuYRLJyFKuQnWMAbHlQSKa5do9uE=;
        b=AwSDkMKNdfLPDUc8K7wB4nEhKWaYarqj8huH2wGJAScR2y+lA6pc5t6yryCY3TbhMm
         1eVm9qIxO7w9bBXAJBLEVIrk8Vb70YmgpJga4230c7OtbouwGjGOxEs1kE3PtAuOSFtb
         5EaXy23hIXxyVGw2l6KmHO45Ww5fPFqg5Pq8VzNl+6RhOb2CBaKzetMm0E43s3nx3X66
         B0kKjVaJbxC+B/wKobwwi6jxF4ZscXHbWkg5LbVUsm9tALBfwGL4SYkcbzdX4iMBBUVU
         pZVXczRZxjtnhp5qHruYQbJEWowBGv0CnTcAhUXxCq/Zo7O154ZSlZqZ9mGIPdrEmZu0
         /7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788785482; x=1789390282;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FYyD0CEd/7kgAnjNuYRLJyFKuQnWMAbHlQSKa5do9uE=;
        b=Q078tYzpo1pGsLdkK+OiXCIJzRTvj+9fYGVBRujnzENCz9n60s35xLhYNmw3wEMAGD
         KLN8ffIreDExF86jhWZ2KNGfaVjNbWLKigmKZ4zMZxvFb5YwzaOT57BYYk4fh815XnB7
         X39bOqUoh0lsmWLdQezC6AyD5tHimg5Ojwa6fHgNddhxCy7b1/MMBqxsmZDs/P9C380J
         3nhDKPyZ2Ydb8Zbo5tD+g+JjVBZ6F8ugWO9TAKjgDiMJB0WH5d2tISrbV1hKjjxt+GQ7
         QN/9v3Qv3/L8vaNR9yzvu9DFycZOxCpDkcfBaJKbSgaMNf7DSKjLw7K0zNr7BrqitZZ7
         R4aA==
X-Gm-Message-State: AFuF++kqZ6iW6GThqLxbUWq3RkGSPyxmtDiHkn15/QsnmgffQlu4wWiI
	RGvgqlSn61GU+vd7JCivDiQ+jxYAaMmPO/l5x+CqKkdlM27tO6yDjIx4hFWYEGgXTuNi3ZF9okF
	D7yZ676cJwrNH3wG84FUbedVWoUG6JZLn5As3APVoftOuP1igWRMy
X-Gm-Gg: AYBFou0O2aSoxHRa1bRNOCBd2b+1srMR5aYpgAwysbn3uVypuEmrfNPxI7g9up4w0N/
	97dGwh6jGS3Y674kLokjVf+d3/CPcAy0E+BldkNxYSRn4CNUMZnq0JGIRjUecJ0niSE512hccPq
	MgtuyZYEQa1rMrEwh0WQ6FaF5qcJz25FwGjzA+PR7TgVSpcF0gnF33fzqHOx/RdQSRzXWv1u3OL
	16g8etfDI+EiwV11cyX4mMNyTePe4P0ykfw3xbJ+1bbL4p4wshDptiryIiMeJI8z32EwWNch9M/
	sK8SAnVMG8m7LpYAmAbAmX5zr2TaMnREiBu3yojfSQqiaw==
X-Received: by 2002:a05:690c:48c1:b0:862:bb29:a715 with SMTP id
 00721157ae682-873f2720d26mr45845927b3.3.1788785481955; Mon, 07 Sep 2026
 05:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
 <9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
 <CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com> <dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
In-Reply-To: <dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
From: Andrew MacPherson <andrew@elk.audio>
Date: Mon, 7 Sep 2026 14:51:11 +0200
X-Gm-Features: AcwNN1XJhv5SGEo0vRrZJKaJFX11hiAb9_KrQaqAwb1tHzAGXrvdPseFBDaDmwg
Message-ID: <CACiVkwmm_TuY_m-qqXqJ-JQOsd4eaFQ1dt1b7D+nC4cqG2R+OQ@mail.gmail.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>, 
	Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Sept 2026 at 13:34, Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
>
> On Mon, 2026-09-07 at 10:57 +0200, Andrew MacPherson wrote:
> > On Fri, 4 Sept 2026 at 16:08, Florian Bezdeka
> > <florian.bezdeka@siemens.com> wrote:
> > >
> > > Hi Andrew,
> > >
> > > [CC + Philippe]
> > >
> > > On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
> > > > Hello,
> > > >
> > > > We're working on an STM32MP1-based system running Xenomai and found
> > > > that perf top shows every symbol as "unknown [00000000]", i.e.
> > > > profiling is collecting samples, but they all point at address zero.
> > > >
> > > > I'm not a kernel developer but went through a few debug kernel builds
> > > > with an agent which eventually led to the attached patch. This change
> > > > does resolve the issue with perf, however I'm not sure if it's the
> > > > correct solution.
> > > >
> > > > The reasoning is that arm_arch_timer.c's percpu IRQ registration never
> > > > sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
> > > > tick_regs, leaving get_irq_regs() to always return an all-zero
> > > > pt_regs, which in turn breaks perf's sample IP.
> > >
> > > Yep, that is wrong. The patch you provided looks OK to me. I'm just
> > > wondering if that should be addressed in Linux as well / first.
> > >
> > > @Philippe: Any additional thoughts? Should we take it already?
> > >
> > >
> > > @Andrew: Could you please provide a formal patch with proper signed-off
> > > and LLM notice (assuming agent means AI ;-)) targeting the dovetail 7.2.
> > > branch? That should help to speed things up. Thanks!
> > >
> > > Florian
> > >
> > > --
> > > Siemens AG, Foundational Technologies
> > > Linux Expert Center
> > >
> > >
> >
> > Hi Florian,
> >
> > I've submitted a patch now against dovetail 7.2, let me know if you
> > need anything else and thanks for the help!
> >
> >
>
> Thanks! We might consider merging that while working on a better
> solution - as suggested by Philippe.
>
> The following is build + boot tested on arm, arm64 and x86 using qemu.
> Would be nice to get some early feedback.
>
> It should fix the problems reported by Andrew and Gerte.
>
> diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
> index a46872cf1384b..553243174368d 100644
> --- a/include/linux/clockchips.h
> +++ b/include/linux/clockchips.h
> @@ -16,6 +16,9 @@
>  # include <linux/ktime.h>
>  # include <linux/notifier.h>
>  # include <linux/irqstage.h>
> +# include <linux/preempt.h>
> +# include <asm-generic/irq_regs.h>
> +# include <asm/irq_pipeline.h>
>
>  struct clock_event_device;
>  struct module;
> @@ -259,9 +262,30 @@ struct clock_proxy_device {
>
>  void tick_notify_proxy(void);
>
> +static inline void copy_timer_regs(void)
> +{
> +       struct pt_regs *regs = get_irq_regs();
> +       struct irq_pipeline_data *p;
> +
> +       if (!in_pipeline())
> +               return;
> +
> +       /*
> +        * Given our deferred dispatching model for regular IRQs, we
> +        * record the preempted context registers only for the latest
> +        * timer interrupt, so that the regular tick handler charges
> +        * CPU times properly. It is assumed that no other interrupt
> +        * handler cares for such information.
> +        */
> +       p = raw_cpu_ptr(&irq_pipeline);
> +       arch_save_timer_regs(&p->tick_regs, regs);
> +}
> +
>  static inline
>  void clockevents_handle_event(struct clock_event_device *ced)
>  {
> +       copy_timer_regs();
> +
>         /*
>          * If called from the in-band stage, or for delivering a
>          * high-precision timer event to the out-of-band stage, call
> diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
> index 85ec0cbf5fb1e..d160d99e32c5f 100644
> --- a/kernel/irq/pipeline.c
> +++ b/kernel/irq/pipeline.c
> @@ -1059,24 +1059,6 @@ bool handle_oob_irq(struct irq_desc *desc)
>         return true;
>  }
>
> -static inline
> -void copy_timer_regs(struct irq_desc *desc, struct pt_regs *regs)
> -{
> -       struct irq_pipeline_data *p;
> -
> -       if (desc->action == NULL || !(desc->action->flags & __IRQF_TIMER))
> -               return;
> -       /*
> -        * Given our deferred dispatching model for regular IRQs, we
> -        * record the preempted context registers only for the latest
> -        * timer interrupt, so that the regular tick handler charges
> -        * CPU times properly. It is assumed that no other interrupt
> -        * handler cares for such information.
> -        */
> -       p = raw_cpu_ptr(&irq_pipeline);
> -       arch_save_timer_regs(&p->tick_regs, regs);
> -}
> -
>  static __always_inline
>  struct irq_stage_data *switch_stage_on_irq(void)
>  {
> @@ -1123,7 +1105,6 @@ void restore_stage_on_irq(struct irq_stage_data *prevd)
>   */
>  int generic_pipeline_irq_desc(struct irq_desc *desc)
>  {
> -       struct pt_regs *regs = get_irq_regs();
>         int irq;
>
>         if (!desc)
> @@ -1137,7 +1118,6 @@ int generic_pipeline_irq_desc(struct irq_desc *desc)
>         }
>
>         trace_irq_pipeline_entry(irq);
> -       copy_timer_regs(desc, regs);
>         generic_handle_irq_desc(desc);
>         trace_irq_pipeline_exit(irq);
>

Just adding that this patch also appears to fix our issues with perf,
tested as a backport against our 6.6.48 kernel.

Andrew
