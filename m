Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E814B2561F
	for <xenomai@lists.linux.dev>; Thu, 28 Mar 2024 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610898; cv=none; b=XTjnAYd2VnLFioooCBVCcGlL9h5fQdw6wnzJqpeiMQQ3F4kq2mZa8ysDwGm/uYYMmaCe/w0eJjepi8hNSPkF2ya+mfTm5Lv9xj9hzcBEj3eDSz11k9YYBlo+xgRdVUOgBmUa/J6CYl8J0FNjnI24yVOK29YKe/LhTQv9Np4tpCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610898; c=relaxed/simple;
	bh=HIp52ftvneszPDRuxnQAnuN2s4O/+UzUMCcP9uR5y9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6s+/Y9BEzNygHnEw0mLlPeRkp6yDh+iNqdJsd5txmc3EdNgK7+G3jdNA83Uo5pV1SUkmWd5ZL3c3s7aQC32ZzSixIO5nl3z7i8jqhNWlplnep1NmJicy0KL0LFZOuJ5f9RcHg7Xmau8jCad7RmFY9ZyjDsMVDK+xqtgWLu9Gj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxwObqyg; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxwObqyg"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29ddfada0d0so492929a91.3
        for <xenomai@lists.linux.dev>; Thu, 28 Mar 2024 00:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711610896; x=1712215696; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76+QiqFVYx4DwP2XNRaKro9MZWvUlufs8TApf0cI0WU=;
        b=YxwObqygh6gpKLMVyYI0fT/UxpDlb7E+uoR9p3VA5TXd6pFP/4Y1qWAO3+Ui7JHLTc
         cpK+z2hhwa5F/Ps/3nsoMILrPzfNMOaur2+6uF/U0YO4/N7iWlACmiHjOQLALJktymLM
         2Tc7FHD1o1kledKR06rIEQXWvuN2YhslCbrYkOKH9RjQcRgwZGDL+qVYwHI7iyCUdHCY
         I8UooK46LEC6nXbeHgr6vXsgoNQ25OiyIVk++0sjWX+aasf7gKc7MbZcQMpknhkmhB4u
         L+kL08sEIt8cqL877KDXuf9TDFrNZ2slnuAgr/IDgbEZ2c5bMFdY3x0qGV4d34poO/L2
         ZpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711610896; x=1712215696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76+QiqFVYx4DwP2XNRaKro9MZWvUlufs8TApf0cI0WU=;
        b=mFOsfdqHsqny7zRKng+G4qWiKQNQW30/iM+X5xgpLnf9AqR8ztxskwDrB3yNEaea3k
         8XAuyCKkQY99zeekRSf8tENlirMS+/c567FZhr95R+CxcxvSWj+VpksiJxk/gMcbKQW1
         xg7dGqfWhNS+k2qghPhuESwnmI/3dQHQ1WijcMkeLOTJCcGB27CxFHL0dEvk0OuWmWth
         gZV1zDJ+actq1bzBd1f0TtPVrVhCJ+KEQ5jRHwEyAuBUx5yMR7JL19hTuBNiU8ClHp7s
         +LCbTZxRxR+P322r1qYhcThwZ4aCzuLjADEkHHAVgDjQNipeojAlUjxMnynyHwh6bKql
         rEpA==
X-Forwarded-Encrypted: i=1; AJvYcCVRgnYFKP+EHLToxDun40nZxZbUvC08wZBpmOhxsp6WKP79ek0nyp1MocYTmu0LKFvA+vdgcEv80DSgLNvI5ry460JSjwfjKg==
X-Gm-Message-State: AOJu0YztchoANhJaLRlLqf/8cw+wxcG7n4xDedtiHwPtTfGf36an0a+7
	WYp54xdeIzlCtUXOEFWiio6hUzgn3oXNnVTBagSpkCSb1/8WerROlXFCNMXhMvXIEUXN2IXHeHa
	HphubJD/ErbEeq9MKe3WPsADYYF8=
X-Google-Smtp-Source: AGHT+IEwl3pq1kGuqt2FgtoQpkRqOlCzMVVZ4nLY2qRMWHolnFTxqAfj8M/OKdSsZ62kAF80cg7mRcXP/AC8HSAiedg=
X-Received: by 2002:a17:90a:4481:b0:29f:f619:7c2f with SMTP id
 t1-20020a17090a448100b0029ff6197c2fmr1595051pjg.27.1711610896192; Thu, 28 Mar
 2024 00:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
 <VE1PR08MB490963A18B8D61A5AF0B7AFA923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <874jv7rxb2.fsf@xenomai.org> <5809272.1B3tZ46Xf9@somecomputer>
 <3ca2aaf3-f47e-4fbf-8d46-b5da9542bc3c@siemens.com> <CAFLxGvytJP_ibg0ex4zgyahaxNJH2b_M=Nu3ZBWtrm9neRoW9w@mail.gmail.com>
 <41296dbe-5e83-4f7d-8963-5c985e83ab30@siemens.com>
In-Reply-To: <41296dbe-5e83-4f7d-8963-5c985e83ab30@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 28 Mar 2024 08:28:03 +0100
Message-ID: <CAFLxGvy0dQtnfjsgvAyv=8m4JubED7UTwdcvF_8eTkBc5+i+iQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@sigma-star.at>, Philippe Gerum <rpm@xenomai.org>, 
	Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan,

On Mon, Feb 12, 2024 at 5:12=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
> >> Yes, I do have some first hacks here as well. ARM and ARM64 is not yet
> >> ready for this, unfortunately.
> >
> > Can you please share your hacks?
> > What is missing? I'll happily continue your work.
> >
>
> Just refreshed [1], and the kernel side hacks are attached (mixture of
> Johannes and my WIP changes). Blocker is really the level of kernel
> enabling we need/want for non-x86. Those changes can be many. Also a
> problem is the information forwarding from the exception handler to the
> oob callback - missing in many cases, see also the dances needed in
> xnarch_setup_trap_info().

In commit 7e13c6997 ("rt-signal: kernel refactorings") I see the
following change:

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/keve=
nts.c
index 5394c85d0..275a9f726 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -56,7 +56,8 @@ void handle_oob_trap_entry(unsigned int trapnr,
struct pt_regs *regs)
               xnsched_run();
       }

-       if (xnthread_handle_rt_signals(trapnr, regs) =3D=3D 0)
+       if (xnthread_test_state(thread, XNUSER) &&
+           xnthread_handle_rt_signals(trapnr, regs))
               return;

       /*

I guess the idea behind is making sure we handle only faults from user mode=
.
But isn't XNUSER also present if a thread is executing a cobalt syscall?
So, I think instead of just testing for XNUSER we need to check using
user_mode(regs) too.

What do you think?

--=20
Thanks,
//richard
