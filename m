Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81001839EB
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666484; cv=none; b=VOHx5S99yf84BkaO/DU0AFXraealM1mGuWG6oLnU2wEUaRP1s+rBk3La1ZrAy5TQOkqkNsIhcVbO9TfVkQM9ycUk0pVYvBUr9bUHY7oJbHcNyGG2uV7JpKCl7xYX8Q+ihSGBEA8OSfKc879yq7TnnV2631IEQrkoKg+WMHbPx4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666484; c=relaxed/simple;
	bh=46AL7pk1v8z7nkNPk0aG4jcP7mhPZjyy/zQFGdZpeQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqn610i6wPP0Cnl7wqPeL5OQypyHWxefwoIJcwg+9oNjD1Px5xjm9lRW3HNv6xujLHYgpjXK+nkR4Np8bwG5E0NdXNx0ffKsLIs0QGMg+OjspMFvHTJnoyEZzm4t6LpL5+/iusmwu0kYRbTqzCaV8vuNZWNeK70x10zYCet5tt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZM3UhB4; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZM3UhB4"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6dbb24ee34dso20124477b3.2
        for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728666481; x=1729271281; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slGfS/Qzv+8yf85L60VvJGsM57Qc4C6udwjepvdN7VI=;
        b=HZM3UhB4Y0YoJW95hkknl/YeXNvOPSLszQh3xTUkVcVsH2D/d2SdbKsSWkH0WEtxq2
         kZ/NaVO754yE6ZJT3nJBOA2NqIS/CfSSSJOagwJIgaSeJ9rJMWYUTT6kgiLA8twlhrIU
         l4jO6BtSa2yIarcy4zfMaXVjC9Xxj4MIcWnhEzreDVoKC+KiW8ZC4NcAiH/cKjuA1TxW
         wzfFUOgWao+bgY9ROC4lEzGH8fWck/6c3wkTWO/ww64Td1c5vc5IoDnczEpZCij3MQOd
         i4zWZtl0onUYXc/vLUr8UEdOEp+EEQaiusV9qdv3YJSZHLxKfI+5XF+EHVklbCGKqJr+
         RpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666481; x=1729271281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slGfS/Qzv+8yf85L60VvJGsM57Qc4C6udwjepvdN7VI=;
        b=id0UA6lnDu9rU0Kf5Klxtrho8Zr+V8W4LBPMRvF3ERAUxeVQ5Zv0dCGQkIJisGIcSM
         1NUV0FFkCptSYhPn7rUHytHuWsy5AQD5+OwuJYGTB4GtlHeugJdbq+gJOUCxTlF2IyQz
         8sUxxBQGGz/sUyyQdpOPpfvlLYd7+oVRhIyLaAq6d0MeaUzto+IpXcd4YU+pGctMyK67
         7ymLrIffegr5nODgbb+kD+oU3TYSr4TyqLA/2GuKLIGPzm8aoUsKs50bOhRmp4naIPg1
         lQ0hsrmOAbjh3bQ+oe/vsQjn2UyiqUaNNPKgyKuHxQ+zV2d2Egvvrw3DoGv6g99Qmg1Z
         sx/g==
X-Forwarded-Encrypted: i=1; AJvYcCU04kzTWgnDbot5k+bxyXqCb4Iln2E2+EOJGz+IJ7aeOhLjiSFaSisPmjyaKr5mWTGhg/DrTTnN@lists.linux.dev
X-Gm-Message-State: AOJu0YwAl+8RxH2NjJFWETUPfU1fsKhmRvaHAtAe1R3ztewT6qShikdh
	7Vnc331DI33cTiJYHgQgHX48KMm/asJNDcBpWNXJ4nVhZ3hA7UlkvzVa2kPqGWw7XwXBZiIXCD9
	QXsQSOk3NXCpvOGGS3OksKqaiXFF4ilDILoOZgn98
X-Google-Smtp-Source: AGHT+IGFf+e03vR/DpU2dMdg0G7xVwGIIF48fq37Fw6pbwrcCZDwwclL02vIwb2Knw1WNgDNl5s6Caoq74KdoFXrsUc=
X-Received: by 2002:a05:690c:660a:b0:6db:de99:28ae with SMTP id
 00721157ae682-6e3479b64e9mr26306707b3.17.1728666480732; Fri, 11 Oct 2024
 10:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241011063730.310568-1-shanmu1901@gmail.com> <20241011063730.310568-2-shanmu1901@gmail.com>
 <bf826225-8056-47d8-8a9c-f71f368dc26c@siemens.com> <a59c3c6d97a76ea423dcdc283694f9c5baaac9be.camel@siemens.com>
 <87zfnb84tu.fsf@xenomai.org>
In-Reply-To: <87zfnb84tu.fsf@xenomai.org>
From: shanmu <shanmu1901@gmail.com>
Date: Sat, 12 Oct 2024 01:07:52 +0800
Message-ID: <CALt0BK+o1CWxxvCb5QAaC6iuooPibkWf5_-XyFCcpeb4BkySyQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] RISC-V: enable IRQ-PIPELINE
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	xenomai@lists.linux.dev, 
	"Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply and since I'm not very familiar with how the
mailing list works, I accidentally replied only to Jan and Florian
without copying the entire mailing list.

Thank you for the community's feedback!

> Could you explain how these bits compare
> to what Tobias sent earlier [1]?

As Florian Bezdeka mentioned, the main difference
between my work and Tobias's is that we're based on
different branches. As for the differences in the code,
I'll need some time to carefully review Tobias's patch.
From my quick glance, I recall that our
virtual interrupt functions are slightly different.

> Is it possible to combine your work
> with that to ensure nothing relevant is missed?

My patches haven't passed the SMP tests yet.
I tested using QEMU under smp, and it seems that
all cores except the boot CPU are not active.
Once I fix this part, I would be happy to combine our work.
This would reduce the community's review/test efforts
and also ensure more consistency in architecture-related
code changes across different branches.

Philippe Gerum <rpm@xenomai.org> =E4=BA=8E2024=E5=B9=B410=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=BA=94 15:41=E5=86=99=E9=81=93=EF=BC=9A
>
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
> > On Fri, 2024-10-11 at 09:15 +0200, Jan Kiszka wrote:
> >> On 11.10.24 08:37, shannmu wrote:
> >> > This adds virtual interrupt functions `arch_xxx`,
> >> > irq-pipelined top-level interrupt handler `handle_riscv_irq`
> >> > and `handle_arch_irq_pipelined`,
> >> > real interrupt-flags functions `native_xxx`,
> >> > `mark_trap_entry` and `mark_trap_exit` in trap functions,
> >> > multiplexed ipi_message_type `IPI_RESCHEDULE` for in-band ipi.
> >> >
> >> > Signed-off-by: shannmu <shanmu1901@gmail.com>
> >> > ---
> >> >  arch/riscv/Kconfig                    |   5 +
> >> >  arch/riscv/include/asm/dovetail.h     |  58 +++++++
> >> >  arch/riscv/include/asm/irq_pipeline.h | 173 +++++++++++++++++++++
> >> >  arch/riscv/include/asm/irqflags.h     |  26 ++--
> >> >  arch/riscv/include/asm/mmu_context.h  |  21 ++-
> >> >  arch/riscv/include/asm/syscall.h      |   6 +
> >> >  arch/riscv/kernel/Makefile            |   1 +
> >> >  arch/riscv/kernel/irq.c               |  72 ++++++---
> >> >  arch/riscv/kernel/irq_pipeline.c      |  46 ++++++
> >> >  arch/riscv/kernel/smp.c               | 135 ++++++++++++----
> >> >  arch/riscv/kernel/smpboot.c           |   2 +-
> >> >  arch/riscv/kernel/traps.c             | 212 +++++++++++++++--------=
---
> >> >  arch/riscv/mm/fault.c                 |  46 +++---
> >> >  13 files changed, 633 insertions(+), 170 deletions(-)
> >> >  create mode 100644 arch/riscv/include/asm/dovetail.h
> >> >  create mode 100644 arch/riscv/include/asm/irq_pipeline.h
> >> >  create mode 100644 arch/riscv/kernel/irq_pipeline.c
> >> >
> >>
> >> Thanks for sharing your work! Could you explain how these bits compare
> >> to what Tobias sent earlier [1]? Is it possible to combine your work
> >> with that to ensure nothing relevant is missed?
> >
> > Thanks for sharing +1. One major difference is the base branch. Tobias
> > was working on 6.11 while this one is based on 6.6.
> >
> > As we now have two different works streams it makes sense to
> > synchronize and ideally align on a roadmap / work sharing plan. That
> > would help to minimize review / testing efforts - at least on my side.
> >
>
> Agreed. For the record, I'm willing to merge the RISC-V architecture
> support into Dovetail and the EVL core. We'd just need to merge both
> ongoing efforts to get this done faster.
>
> --
> Philippe.
