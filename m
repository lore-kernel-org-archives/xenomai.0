Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F414F90
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654065; cv=none; b=TA/e5wfSLO2Db+/9N9yAy87cxWPPFGdWB6DvWghKKuGku8Kpu1QMB8Dd2KgpBFuhlXP74igcWIbvnAnVPIK6j+EsM6Pn+8GZcIt6wMR0W6BSzeWGUQ2mecVS0T0sOIcVxK3qWr39wBPkPkNjY655lGjHxrAs9XA0noh9ShMX2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654065; c=relaxed/simple;
	bh=7fs9UCa+r8zo2KlDIihcX64a0ueDsf6Ubj6HXn6YnX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esTvrZ5dbdD8AstkW1vjOcGfhRoPNYqdwZ2igeBvPn+WdMz3vgd7ReuXB2U3Y3HwogQoz27AERGjZQBruQyiSmKPZq/KCka+q5bpe8HAgY9Kc3t/fauvRVlHJb6J4oMiFxfM1kwB9fORyUmsLYstWW/Q6RaIobJOe9bJMReaTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTmIsHqj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTmIsHqj"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29a5f100c1aso3484168a91.0
        for <xenomai@lists.linux.dev>; Tue, 05 Mar 2024 07:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709654063; x=1710258863; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiYr0nXyOvcCuBVeJh1x3f8RH/GeE8v8aMTGBTQN+JI=;
        b=LTmIsHqjw4G3MU3nZRQBUfB410QgxvS2FhHAYiXjhTo4RDUap1KGHMv//p9QH1bHl8
         hP2dT6J487mX86/aOELfJf9uP8NG7MjXjXlT+iP7gKhHVtoPisuzAtrszbyWlCvN40z5
         AiVP8SleesQIBnAfkJ27meGGdChkH1vp3iIi+BfoxzmdHuGIVCmSoshpo9SLOy2HlVZe
         U2rH+T0tauosNScHQg1YT0xl00msDMNP6SIAsT/j+ih5c1aZbtXHJQdPf2mr2hRhFdeI
         QVtoK5nOm3FTda/YIyPm0rqPX9V+He3k8UGnmztY/w1Yghs7XmJuShvtMy9zrV/pAeIN
         ui3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654063; x=1710258863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiYr0nXyOvcCuBVeJh1x3f8RH/GeE8v8aMTGBTQN+JI=;
        b=lw4YsMZPCLXPKYNCOF7wHo/8ZYhjPD+XiI9DprFbyVHXWIKVfMM8Ofuo3npYvl7ndF
         IogYqnsDNmz7027a4EtHz1FnEEkHjrpalqDST77dz+t0P0VjbJCLQ48e0f0IRL1nGqYM
         kWnBga8pmcwLAsMv7IE7yMcEX05NqnNx7b8JiuMv40ajB11/KZCbcifL6XuvyVMSO88g
         DYVGS2qN2fjNbRzMp3JfUPHO6CeVwPY17L6L5sDP+dK2/Rw83sywAcjmDsWSexvc1F6S
         yATHO9z7PYQz/nVp+lMt56yf4dv7Jm9q03Y7x8sNDULWdGERKNYUxnCxCe9QcDeomkeJ
         UcTA==
X-Gm-Message-State: AOJu0Yy1WA30RtLiX9jvizfiGxjvx7CKIjf8kth2kUGNppcNinUDyHZK
	qTUySiuUNyMwTtlO+wp1xOl18A7529TOVMpS3QWjFlDkdhV+Y7N7q54kliOKnoXeVHrimPilUhX
	/LaV9VegOcbyJradrdBczgUEBmKcyQKx3nNk=
X-Google-Smtp-Source: AGHT+IEoUWQiJJFE6kl+7QVIYtETRmESGMsZd1N5vwFDCVyjyJI/16lmrSLFbAlt9HjiZgbggTZmBgHrVrgYd9AV+k8=
X-Received: by 2002:a17:90a:cb97:b0:29b:154:3246 with SMTP id
 a23-20020a17090acb9700b0029b01543246mr9272733pju.48.1709654062732; Tue, 05
 Mar 2024 07:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
In-Reply-To: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 5 Mar 2024 16:54:09 +0100
Message-ID: <CAFLxGvyhP+qEfrZQVvOqrLbLmhq48k2G5aA12b9sowKXZeDtTw@mail.gmail.com>
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
To: xenomai@lists.linux.dev
Cc: "J. Kiszka" <jan.kiszka@siemens.com>, 
	"Bezdeka, Florian" <florian.bezdeka@siemens.com>, 
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 12:19=E2=80=AFPM Johannes Kirchmair
<johannes.kirchmair@sigmatek.at> wrote:
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/ke=
vents.c
> index 4da4f51b7..61417717b 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -57,6 +57,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struct =
pt_regs *regs)
>                 xnsched_run();
>         }
>
> +       if (xnthread_handle_rt_signals(trapnr, regs) =3D=3D 0)
> +               return;
> +

While continuing Johannes' work I noticed a problem with this code.
If we happen to trigger another exception while setting up the signal
frame a domain
switch could have happened and the subsequently call to
xnthread_relax() will crash the kernel
because it works only when we're in the primary domain.

e.g. if regs->sp points to a bogus memory location in userspace,
xnthread_handle_rt_signals() will
not only fail but also switch domains due to a page fault.
We'll return here relaxed.

My current workaround is a check like:
if (is_secondary_domain())
    return;

>         /*
>          * If we experienced a trap on behalf of a shadow thread
>          * running in primary mode, move it to the Linux domain,
> @@ -88,6 +91,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct =
pt_regs *regs)
>                 xnstat_counter_inc(&thread->stat.pf);
>
>         xnthread_relax(xnarch_fault_notify(trapnr), SIGDEBUG_MIGRATE_FAUL=
T);
> +
> +       return;
>  }



--=20
Thanks,
//richard
