Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7813AD06
	for <xenomai@lists.linux.dev>; Thu,  6 Jun 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662292; cv=none; b=SpDARTtLHMnBKdN3tKNkU59SuXzvXT8s5t6wtfrsr9k56Nfc0CFfvKrcfKq3VCZG2iIdmt4caG7CHnEKKuHq8WnKwWEKF++MR3oVZcNWQhxbx2952yaXaRaKEUPJEgwXkH7vd3WKuegItkMBxWafZBXtDZd/jYfCcTtL52Un0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662292; c=relaxed/simple;
	bh=s+uS3zaS6ahXzP+UTMQQDhxPFfmR+4IUzt6jnEJXk6I=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=sWgL4TIDazhucupdcSLmZRhfx4zV/PhPzQowAeE+OW54XHRdMuJJWhKjrXW10YXJWp27KytABKYETMW3YTteIFvZgrOH5Vd3Xys8ZxGD2gf4f6rNh5pblGMsljfOG/qtvr4H6rm/USieHUCjZUCSJGa63rQEReo4t/pA+dmpBpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4215f694749so1963255e9.2
        for <xenomai@lists.linux.dev>; Thu, 06 Jun 2024 01:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662288; x=1718267088;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LvbHed4g6YfrgVeAHUwq0vRzwhWgloW9TKdW+DY1mJ4=;
        b=Hypbf9EoM7nxZ18oc04ceXk3VeD1NgPSAh0YfogZ3WAZ0AKw8ux+WZ/e7oTxuh/c0t
         GhFJJnU41v6Tdb7W0OrRonEVb5tXP4elJW6YxynGmZgoVRPHFF5az4YcuWPzCA1CAH4O
         LByVCenUIsxW5iwF5+IdZKG4cBMbAqXzYbRzz7e5ymU5QHwz42dj2BbeQxQkf9qyi9b6
         f1ZgHOLduHArKCs7W3DPNTpvu8wttfVdK9yQV1GjhP390SwcOGDOAz6ELa35e4T6AXKD
         oVaCPNxBSFwj15ef69rsovxk322SDuo/16o5FoD+7WlXgJZlewLR1DDpooR6G5fbAmzL
         PL8A==
X-Gm-Message-State: AOJu0Yx83NNNdQNQNaYJ2E7tHv1RJFf/mxU6uWXIcWnuLwobNN/aRwnH
	WuxSz6tG7kyGncZPKSW0l1tMspfOQveR+tKl7atlAsVgBH5dnXva
X-Google-Smtp-Source: AGHT+IHpLVYwISu+zlYlev7937vokBAliVPwa7vcrGb6LyUbRAh2MooUYwfHF6aMYT88H80oxNK+2w==
X-Received: by 2002:a05:600c:1c84:b0:420:173f:e1e9 with SMTP id 5b1f17b1804b1-421562dc3b6mr40807385e9.21.1717662287965;
        Thu, 06 Jun 2024 01:24:47 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d66cf6sm903411f8f.49.2024.06.06.01.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:24:47 -0700 (PDT)
References: <1a4aa9f3bfb30fe5b5955fea1486a5fb8b040ff2.camel@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Dovetail/Xenomai 3: Timer tick locking problem
Date: Thu, 06 Jun 2024 10:18:30 +0200
In-reply-to: <1a4aa9f3bfb30fe5b5955fea1486a5fb8b040ff2.camel@siemens.com>
Message-ID: <87wmn2eawl.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all,
>
> I'm searching for the root cause of the following WARNING - followed by
> a complete system hang:
>
>
> [Xenomai] lock 00000000e04e7d2d already unlocked on CPU #3
>           last owner =3D kernel/xenomai/pipeline/intr.c:26
> (xnintr_core_clock_handler(), CPU #-2)

Mm, -2 looks pretty bad. This should be either a valid CPU#, or -1 if free =
(~0).

> CPU: 3 PID: 31 Comm: ksoftirqd/3 Not tainted 6.1.34-xenomai-1 #1
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/=
2006
>
>
> Up to now I'm only able to reproduce that with VirtualBox when the PV
> spinlock infrastructure is enabled. It takes ~5 min to stall the system
> by running stress-ng with the --iomix stressor. "nopvspin" to the
> kernel cmdline "solves" this problem for now.
>
> I'm able to stall the same image with the --iomix stressor when running
> on kvm/qemu as well. Obviously there is no warning triggered. I'm using
> "pci=3Dnomsi" on the kernel cmdline to get the same IRQ routing (via
> IOAPIC) as VBox.
>
> While reading all the related code I had some questions that I would
> like to have answered.=20
>
>
> First question:
> Broken locking when Xenomai timer tick interrupts an OOB task?=C2=A0
>
> The call stack into the xnintr_core_clock_handler():
>
> #0  xnintr_host_tick (sched=3D0xffff88803e8ab060) at kernel/xenomai/pipel=
ine/intr.c:14
> #1  xnintr_core_clock_handler () at kernel/xenomai/pipeline/intr.c:40
> #2  0xffffffff81061fdc in clockevents_handle_event (ced=3D0xffff88803e89c=
280) at ./include/linux/clockchips.h:281
> #3  lapic_oob_handler (irq=3D<optimized out>, dev_id=3D<optimized out>) a=
t arch/x86/kernel/apic/apic.c:503
> #4  0xffffffff81112ecc in do_oob_irq (desc=3Ddesc@entry=3D0xffff888003929=
400) at kernel/irq/pipeline.c:933
> #5  0xffffffff8111315a in handle_oob_irq (desc=3D0xffff888003929400) at k=
ernel/irq/pipeline.c:1036
> #6  handle_oob_irq (desc=3D0xffff888003929400) at kernel/irq/pipeline.c:9=
91
> #7  0xffffffff811133ff in generic_handle_irq_desc (desc=3D0xffff888003929=
400) at ./include/linux/irqdesc.h:161
> #8  generic_pipeline_irq_desc (desc=3Ddesc@entry=3D0xffff888003929400) at=
 kernel/irq/pipeline.c:1141
> #9  0xffffffff81070e78 in arch_handle_irq (regs=3Dregs@entry=3D0xffffc900=
0009be38, vector=3Dvector@entry=3D236 '\354', irq_movable=3Dirq_movable@ent=
ry=3Dfalse) at arch/x86/kernel/irq_pipeline.c:243
> #10 0xffffffff81f48dcb in arch_pipeline_entry (regs=3D0xffffc9000009be38,=
 vector=3D236 '\354') at arch/x86/kernel/irq_pipeline.c:291
> #11 0xffffffff8200148a in asm_sysvec_apic_timer_interrupt () at ./arch/x8=
6/include/asm/idtentry.h:760
> #12 0x0000000000000000 in ?? ()
>
> To my understanding this is an OOB IRQ, interrupting any task, OOB
> tasks included. The code in xnintr_core_clock_handler():
>
> 	xnlock_get(&nklock);
> 	xnclock_tick(&nkclock);
> 	xnlock_put(&nklock);
>
> When running over an OOB task that is currently owning nklock, we will
> release the lock unconditionally, leaving the task "unprotected" /
> unsynchronized. Right?

No, the only way for a task to hold the ugly lock safely is to disable
IRQs if it has to compete with an IRQ handler. So this scenario is by
definition a usage bug on the application/driver side, not on the
infrastructure's. Meanwhile, the _irqsave() variant prevents spurious
lock release in recursion using a special marker in the saved interrupt
flags.

>
> There is no OOB task running on my system yet, so it's likely not my
> original problem.
>
>
> Second question:
> Back to the original problem. If I interpret the warning correctly
> something like
>
>     CPU #2                      CPU #3
>                                 xnlock_get(&nklock)
>     xnlock_get(&nklock)
>     xnlock_put(&nklock)
>                                 xnlock_put(&nklock) (triggers WARN)
>
> must have happened. I think we agree that the infrastructure behind
> xnlock_get() should take care that this scenario can never happen. Any
> ideas what is going on here? Might that be a bug in the VBox PV
> implementation?
>
> The vCPUs should be "parked"/"halted" instead of spinning. On x86 we
> run into kvm_wait() doing a "sti;hlt;" combination.
>
> Once kicked by the current lock holder we should wake up and continue
> after "hlt;". Even if this goes somehow wrong, some checks about
> spurious wakeups are in place.
>
> Might that be a memory "visibility problem", maybe due to a missing
> barrier?

I would address the "-2" weirdness before considering anything else.

--=20
Philippe.
