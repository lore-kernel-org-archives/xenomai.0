Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE21CEEA2
	for <xenomai@lists.linux.dev>; Wed, 23 Oct 2024 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703262; cv=none; b=XoZbii+aPDjd6VG69EHNDinfPSNHV90ZpZiD9a3GW1Q4TxsQLePx9gxhPMEe3lsQXTd2f7eqXzLHDmNS7lWEUYgNw0vLIKUeOtxjytiaclMBBvz8XenH2IKY0/RlzvhyyJDvNI0mNGPyaW4aObZr8j6NCOwPB5B4pbJt8xz8ki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703262; c=relaxed/simple;
	bh=Sp/+t7/NSvLSXDkImJS7UEDa4pfkoVRwZUxwst97apc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bE239GuxD51vvxBR0HggJSW/uJGXNq3M9bMroNtlIgBFD4IO6SgAbtQhnx1mJaeqo2xXj4VDuywuxTRlJxUFL5xmRRv9kE9mxzGaB1gXzxXMAXqmkmuyNRxPoss4Rdt1pvxaXh7iop9rjVjr2Ja3iQtYiXfHZExLFD6icPGH6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH8aKF+w; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH8aKF+w"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so65320a91.1
        for <xenomai@lists.linux.dev>; Wed, 23 Oct 2024 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729703260; x=1730308060; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pU1qeEyFgzOWltPQhBwGTqMA2n2EysfMOyBQHDk2XR8=;
        b=XH8aKF+wVUjwCJpgZ4SarCqcinomN6Vpc/25071ZBJCuzeMwxbTzhnjle/UQuvzsem
         Fn//Fn/lAUrMgZUQzb/wcJLdGD5k/+Ek0DsnyBJrFm9iOX0MabbM6Ezcg/BJGQvgPU79
         5DgoOGcIicBpb0TKycEU9nEUEz//6E0aMThIDSnMTRjjs3WO35gd227SrfZOdjkj8EcN
         l1YRgFnkd8TkLYv6VNX3fA+gGXyMDqx52f2viQk8/p43BCqCCVfAxy0yn44Ak3Iqxlga
         //If9Rm1RTaa6w1QT7UvUqFmr59sQIp3Jmw8eVrB8lmstKdFnX33PEvJ7H9jkxk+duQ+
         fnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703260; x=1730308060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU1qeEyFgzOWltPQhBwGTqMA2n2EysfMOyBQHDk2XR8=;
        b=r3pRQWrv+sDaWTTf52SrKO+yiyuczw7lEP1chBFNv4hWILBTNf4Pheqo2Iudj/E9e7
         cd8WrkyrCVA6AD1WLVCx6jWxjbzULm79srmrUCiNm38x9qqzJFN7/lMo6BxoUh3FfH0c
         JKc6eMzvwqBnI5dOw+xlGE4wJDaQjKhbuLQk6fSlgZUbkLA/BAzXBtMXKzK0tkQtZP9d
         7uI+unejj7SHhI7fPm2N182CSu/Wm3Yb+gOKNWY8eMnK4N/1PfoXwgmsJ1SED7wz3Mzh
         iobcD9wI3OBj7sqq3hKiifxuV0eOdOSI4JKbuXcGoO45a1qJquBirjIb6nMgMGsR9MGp
         2UTA==
X-Gm-Message-State: AOJu0YzfJbuHpcZd37ahrphhxJWW1RgIX4jAk72On53H0Qco9YdbO/Uo
	dwzU/mCsBAOVSWa2yhgVI46NpxDfTiDbwJwdaRebccfZREDXFkAxxOolf3kR5eVPWeaHcg2duwH
	SCOyfyhOgVUYhj8xk0Ops7mBmIMBwTNSXDYuiNQ==
X-Google-Smtp-Source: AGHT+IFhVfbo+AMEIE7997dosXhSkvERoCql3K5/Vl10kFHk9hWKK0xsgsDxNMh+j9MLWfz2VIEIkVUy5nXMweOuaeY=
X-Received: by 2002:a17:90b:4c92:b0:2d8:da35:b4d6 with SMTP id
 98e67ed59e1d1-2e76b5ddd63mr3530895a91.14.1729703260085; Wed, 23 Oct 2024
 10:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241016183505.738682-1-lz5333885@gmail.com> <22d28433-8d1e-4b29-b1bd-33eadbb24336@siemens.com>
In-Reply-To: <22d28433-8d1e-4b29-b1bd-33eadbb24336@siemens.com>
From: =?UTF-8?B?5byg5q2j?= <lz5333885@gmail.com>
Date: Thu, 24 Oct 2024 01:07:34 +0800
Message-ID: <CAGuu-bJEf70xi9H6m84fa+saM_NSOATueYcHcsycoHgtTahEfg@mail.gmail.com>
Subject: Re: [PATCH 0/6] *** Port dovetail 6.6.y to Loongarch***
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your kindly reply. Consider the missing IPI part may affect EVL
 unit test result, so I didn't patch them yet. So I'm currently working on
port the IPI part, and plane to patch EVL just after it.

Build and test the image on real hardware is definitely consider as a final=
ly
goal for me. After patch and test EVL on QEMU, I then will choose a proper
piece of hardware to test the image.

Zheng

Jan Kiszka <jan.kiszka@siemens.com> =E4=BA=8E 2024=E5=B9=B410=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=80 19:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On 16.10.24 20:34, Zheng Zhang wrote:
> > Hi all!
> >
> > This patches is base on 6.6.y-dovetail-rebase aiming to port
> > dovetail to Loongarch. Most of architecture related code has
> > already been ported, except ipi part, which I will add in
> > the later patches. This patch is tested under qemu-9.1.0 with
> > irq torture test in single core.
> >
> > If the community is interested in porting Dovetail to
> > LoongArch, I am very willing to continue improving the current
> > work and maintaining it in the future :^)
> >
> >
> > Zheng Zhang (6):
> >   dovetail: Add dovetail and irq_pipeline option to Loongarch's Kconfig
> >   dovetail: Port Architecture bits related code to Loongarch
> >   dovetail: Adapt Loongarch's clocksource
> >   dovetail: Add place holders for smp/ipi related functions
> >   dovetail: Disable irq in mm and fpu's critical area
> >   dovetail: Add more irq-chip support
> >
> >  arch/loongarch/Kconfig                    |   3 +
> >  arch/loongarch/include/asm/dovetail.h     |  44 +++++++
> >  arch/loongarch/include/asm/irq.h          |   2 +
> >  arch/loongarch/include/asm/irq_pipeline.h | 145 ++++++++++++++++++++++
> >  arch/loongarch/include/asm/irqflags.h     |  28 +++--
> >  arch/loongarch/include/asm/mmu_context.h  |  31 ++++-
> >  arch/loongarch/include/asm/ptrace.h       |   3 +-
> >  arch/loongarch/include/asm/syscall.h      |   6 +
> >  arch/loongarch/include/asm/thread_info.h  |  17 +++
> >  arch/loongarch/kernel/Makefile            |   2 +
> >  arch/loongarch/kernel/alternative.c       |   4 +-
> >  arch/loongarch/kernel/asm-offsets.c       |   1 +
> >  arch/loongarch/kernel/idle.c              |   2 +
> >  arch/loongarch/kernel/irq.c               |  23 ++++
> >  arch/loongarch/kernel/irq_pipeline.c      |  34 +++++
> >  arch/loongarch/kernel/perf_event.c        |   8 +-
> >  arch/loongarch/kernel/smp.c               |  28 ++++-
> >  arch/loongarch/kernel/time.c              |  10 +-
> >  arch/loongarch/kernel/traps.c             |  52 ++++++--
> >  arch/loongarch/mm/fault.c                 |   4 +-
> >  arch/loongarch/mm/tlb.c                   |  17 +--
> >  drivers/irqchip/irq-loongarch-cpu.c       |   1 +
> >  drivers/irqchip/irq-loongson-pch-lpc.c    |   2 +-
> >  23 files changed, 412 insertions(+), 55 deletions(-)
> >  create mode 100644 arch/loongarch/include/asm/dovetail.h
> >  create mode 100644 arch/loongarch/include/asm/irq_pipeline.h
> >  create mode 100644 arch/loongarch/kernel/irq_pipeline.c
> >
>
> Thanks a lot for this contribution! I leave the detailed review to
> others ;). Is your plan to build EVL support on top?
>
> We will eventually have to look at the testability of this, just like we
> will have for RISC-V. QEMU is a convenient starting point, but
> eventually there will be a need for real hardware as well, then also for
> building test images and finally running them on real HW as part of
> regular development jobs. But one after the other.
>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
