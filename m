Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E145FFA9
	for <xenomai@lists.linux.dev>; Fri, 11 Sep 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131207; cv=pass; b=Z/TXoU22iBu3NrisYWf24fBzBqwdUhF+gunZes3Pr9AojV0BwJkYt1bl5KlUohZOOOu64kKXoTJnykpdackwBGce1j9hen1mWOtqpp3ph6PkZJ8kvmx3SzVVh34feOt6b/mym83haAVmmojWrZoftVGcDmBb8O2et+mW136vICs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131207; c=relaxed/simple;
	bh=OFN2r88TyV6WCXeo3/nAJ9DHeVF0RMGSz3Is0n8nt68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiUe1P5GUUtybzrr9b7N4C75OuM84/RKwpP4LGAfGxdUOvAarYFyM5t/ZPsQEuN1uU1T8xkNh7MzYgbUX4ooJyw8CizwPPZ2iFTz0uO7XC2E8IveOfVRDoS+v1GvWoLhzc8fhBF/2zi4rF9OcebjFZqXqSoM+ekWY3JIFT3t/7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio; spf=fail smtp.mailfrom=elk.audio; dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b=Hk3uQLfF; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=elk.audio
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b="Hk3uQLfF"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fb7488033so124595d50.2
        for <xenomai@lists.linux.dev>; Fri, 11 Sep 2026 05:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789131204; cv=none;
        d=google.com; s=arc-20260327;
        b=NN6saw/Pi3ACOUzQIklz6H2MTnB6bOhdfCQqR8hIMdaflbyRLu+GejWezcTiG++Hfg
         3l2zhypLKeVcEY1hpFI4jWTiGoosnaxRu4i8vWbMAeBegTnJ+E4YvhPpKBP7HnFl1DrM
         aX6+PZAnJvRaVzWCHD6SADnfgGwhp6rhErDgcn7484Rhx34TKqOVsDv7/8mM1sES9Oby
         FeR+AC7I0sR1wpVP4bFT/aa25hLGpEouphi/MQAQMj/yUJv4VLE2XAMET4kcB4S2EZ55
         WKldzGH84of0OD1pzreCMBkzV5EmqdPOUFQQt9QKc5c0P/kZmYkI+hcZy3i4ELG1zE7e
         pYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7YNl7ozfoPIK6d+0/0FJy2YacQzB8MKyP7caAoM7Xt4=;
        fh=/8uP8f4XmGePkw+6r7sOUN5HY7uOcsK3h+LBTu4bcIM=;
        b=rOCHFw72xfb47XnZbsytpGV4/iJxh5ce9qJzKTC3DEzxhO93LMWP81DU7iuns7z3++
         fhjnih0f1zwL4v0GuxgYGihvKzAg9lWWUBrylHcnuwyoOm+OXvXYZ8grgM7CEcpvuffb
         aWYJer0LNZ9LGawQRveakCpqMz7oORFe9MEwT0dEUBDOFyDjGyMipdJxtpEtfA4V9LU0
         knkwmbxb1111To0E624dSQBs0xxTmA8QT3Nou55PBF/SzvZak1i7uvwhaFwl8QgGUxh7
         heMzA6LPQyHn2/GowTXdHqhSvMIQnE5+hcVL7iUa2uvdT/OBBNB8fDAz45oEyEyQ4fsu
         fzkw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elk-audio.20251104.gappssmtp.com; s=20251104; t=1789131204; x=1789736004; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YNl7ozfoPIK6d+0/0FJy2YacQzB8MKyP7caAoM7Xt4=;
        b=Hk3uQLfFNCNMtF8+yIIHgZX/6V8NsSHju3Y1+IVoOg3a3z7/nnShqQ2xNrINGU4cCG
         Ht+GexHzZIM/UhEYmsgP1QcR1UE7HlgSmKtP99A9TA2V41/59efC+YqqU/wVxZWhy2Ei
         /OkH1tMb6eXlGLUkTNdER7fMltVcdvZLNA74vxc5Ayw2ZTATUNVzNyVuHnOZWe3MyzWU
         KZaJHpjqtdKNodYukoL6ca6j3JLy/3gLXZ4ioqO5QFLm+00nndjNS93b9wghEwIrIKo/
         tSfLexEYXMfvrGvVVTEcPBh267agvTTYTptYnUSt/g5dCml26099C2XTyf4dwpxZATye
         zzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789131204; x=1789736004;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7YNl7ozfoPIK6d+0/0FJy2YacQzB8MKyP7caAoM7Xt4=;
        b=K0PtlRt+rl4vhBJ5r8i6I8KWGy6QFAYWb8v7aKaNtXjQEQvwlppd/ure5oLtjGt7BA
         7xX8f9gtklQzdz4tCVedMiVicXKYtIOzbH7mVV5xoCIpDiM8KhtA+mgrSIFXC+jxwUoL
         RIBUaYDDYZbyeEjEjhVi8nUF2pJpF/XFsbIY6tAzapoE/Rrmh7PUH6XIsb9ZOf9N00eO
         Oabj3tWcn05qqA1q42HtMUjR9KH141giDP9CwnHvVyFw7YLYpsXJo1xHHyfND9tMIwce
         xl8hqE/ceDZfkOpKCKHPGfaCNsuYxjg9eEeqz7NBfi5zLd7H6mDrvbWuTlYrd+dVXvNg
         Gqiw==
X-Gm-Message-State: AFuF++n9DyG7EHrJa1CmYWiRljw0zvyZmJC1AWKC5iai2diY6FjOr6xH
	r57In0HwZpvUoPzReRoEqEqxcQKeFJUPnyMTfaL/iHPfTyjQS+5JC842o2nCKt3CT+44ko4vC8A
	h/GN1rUXEGAGwlP6kU/ptpG5R9rd1a/0Z300B8YFi2g==
X-Gm-Gg: AYBFou34u4S0V45k3jEUjzLf4TnlgIsKgWYHFMlOWFnWfIEiusx+5pWEJLLcOFf7Jb6
	8YUSXaNaS3kOkg37Ikk5kEvqazeUblieqMfBuR7YhOjz05EDn8iFowTce6p6xEb+QaM935vzZAE
	o1TNlh1P5VzOyRjT25d/H3MjV5xnv6aqSoGIfKmgmot+lBciydsTzTDQmbU7ADyD7CSO0XvwS0y
	WMkKzehYQr97aX39KVHfpk4XUa+5X9znRY594yaPDvqPMc3PwpsOrrPu5PsEyZ3sEP5WzwzMODj
	2uPYnyh182EXBQ88TYhQq2oMR0q4QsFrQ608HK2sd3N5TVuTAJkUAfU=
X-Received: by 2002:a05:690c:6386:b0:853:bc96:d834 with SMTP id
 00721157ae682-884b0c97b70mr17615757b3.2.1789131204392; Fri, 11 Sep 2026
 05:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
 <CACiVkwnKDck51TD6jC1K9CJoF05X9hd8xRKiskzdAd4dcj7FQg@mail.gmail.com>
 <e10b288c461075397c67dad4ea3870cab0154239.camel@siemens.com>
 <CACiVkwmeN=8k=oRyusakE78uVYcz2zKws8ytRecFnL2ah8ySZA@mail.gmail.com> <6b918b0e226a2763352632f78edc4036c1a42de9.camel@siemens.com>
In-Reply-To: <6b918b0e226a2763352632f78edc4036c1a42de9.camel@siemens.com>
From: Andrew MacPherson <andrew@elk.audio>
Date: Fri, 11 Sep 2026 14:53:13 +0200
X-Gm-Features: AcwNN1XVvmgWBdl5AWf-MANauHieMmRsVI8oxFFlTIz1FzVp0kWmHj9E3USxQQk
Message-ID: <CACiVkwkY2-q2twEkuu+6oOerimz=0BLLEM43fctEG=FYAuxuuw@mail.gmail.com>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>, 
	Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Sept 2026 at 10:48, Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
>
> On Thu, 2026-09-10 at 16:38 +0200, Andrew MacPherson wrote:
> >
> > > kernel BUG at kernel/irq_work.c:245!
> > > Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > > CPU: 0 PID: 520 Comm: XXXXXX Tainted: G           O       6.6.48 #4
> > > PC is at irq_work_run_list+0x14/0x64
> > > LR is at irq_work_run_list+0xc/0x64
> > > >
> > > >  irq_work_run_list from irq_work_run+0x28/0x3c
> > > >  irq_work_run from armv7pmu_handle_irq+0x148/0x150
> > > >  armv7pmu_handle_irq from armpmu_dispatch_irq+0x28/0x80
> > > >  armpmu_dispatch_irq from __handle_irq_event_percpu+0x68/0x224
> > > >  __handle_irq_event_percpu from handle_irq_event+0x58/0xf8
> > > >  handle_irq_event from handle_fasteoi_irq+0x154/0x2f4
> > > >  handle_fasteoi_irq from handle_irq_desc+0x20/0x30
> > > >  handle_irq_desc from arch_do_IRQ_pipelined+0x58/0x90
> > > >  arch_do_IRQ_pipelined from sync_current_irq_stage+0xac/0xe0
> > > >  sync_current_irq_stage from handle_irq_pipelined_finish+0xa0/0x198
> > > >  handle_irq_pipelined_finish from __irq_usr+0x60/0x80
> > > >
> > > > Kernel panic - not syncing: Fatal exception in interrupt
> > > >
> > > >
>
> I can't reproduce that one here. Not on 7.2 nor on 6.6.49.
> Might be that this is depending on
>   - your workload (irq work)
>   - kernel configuration
>   - xenomai version (which one do you use?)
>   - qemu vs. real hw
>
> I'm quite sure that this is a different issue as we hit a BUG() in
> irq_work_run_list():
>
>         BUG_ON(!irqs_disabled() && !IS_ENABLED(CONFIG_PREEMPT_RT));
>
> On first glance that looks like a corruption of the virtual interrupt
> state. An irq_work event was waiting in the IRQ log and got applied with
> a wrong inband IRQ state.
>
> Last time we found issues on arm was probably [1]. Seems that this
> series was not backported (yet). [1] got merged into 7.1. Maybe you can
> give it a try. I don't have futher ideas at the moment.
>
> Best regards,
> Florian
>
> [1] https://lore.kernel.org/xenomai/87ik6qvqck.fsf@xenomai.org/T/#m31701ab94206574c96cc2d2b24d77d9793359892

I tried backporting the patches from [1] and they do in fact resolve
the crash! Narrowing it down somewhat it seems that specifically
patches 5+6 together are enough to do it, if I only apply those and
skip the rest the crash is still resolved. With these patches plus the
earlier one I now get clean results from a perf callgraph run.

An LLM's static analysis of the issue is: do_page_fault() checked the
raw hardware IRQ flag instead of the correct in-band-stall state
before re-enabling interrupts - and page faults are frequent enough
(routine memory access) that this wrong check fired constantly. Since
real hardware IRQs are deliberately left on during Dovetail's in-band
IRQ replay, and the stall bit that guards against reentrancy is a
single un-counted flag, that wrong early local_irq_enable() call
opened a window for a genuinely nested interrupt to corrupt the
stall/hardirq bookkeeping that irq_work_run_list()'s assertion depends
on.

Thanks again for the help tracking this down!

Cheers,
Andrew
