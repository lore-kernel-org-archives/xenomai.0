Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14F368D73
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570394; cv=pass; b=EFUYFChdRr7HCTibcJzchRjlSkK16fJdixSTK4glzCAgjSogv2BKPN8a9xcKKJTsjjdbLuC1goGxxbVAyysCz2LdKoMcmuRafvKmAiUIQcE1wYnWM9ufYSWyPC4+wGeU/8TvMC12DrDUyzdvFb+e2rKJr5d6ToCGWALzVX3hwvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570394; c=relaxed/simple;
	bh=idueE0wGTelFdLF6j4RS0ar/R+mIfb7xSBd1ma/IjsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f07Tn5G61i6mawnmDZViQjLCeGMRmBdiUvJ+lS3R2GrtIChCYiNM7DfCBLDHwyy5ZhxgNYBTCZWF4vARjyHCddBGkbQHBO2lf++4V+K1+kXsckdBE4M40lgHPnp6TPdivD5FRVx7DL0caVPQgDAsMCMCvaa0ZZmaC6zOevoWjbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtfospr7; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtfospr7"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-366375c4076so2362549a91.3
        for <xenomai@lists.linux.dev>; Tue, 12 May 2026 00:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778570391; cv=none;
        d=google.com; s=arc-20240605;
        b=TTq6ckZjhq/xeeoP0rPj8pbI5NISvRjINvzo4lDjSTl8zIx9jIWiIWI1pmbaFn5t99
         bF6ORqYJIZwZaUZAEQyL6nM7avMW3YmEQ3kBhgRCrChZcIhyDrpAagqrNvtHZj0fHEcJ
         AxW/6Vts53YYOiabzWJ9/xWqSC4AgLKQGUaedvkIh24F39z3ZOOYEN00dItpJGbGH+A2
         E2VcnKnhdRCUztE+9BAIR8pnfX4rBHdAXizvqOWEGKpbCjDC/PTKn/IsSbk2GRK4nppI
         Gt4WgpgXTso38dgeHOe/gwd0Ce9dHpHN8ONT74UxeVRkC+uK3lwvXarWbIgkJOtGK/Gs
         ZU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yv57xE2aHeEu30wnsHtZLf1+qWJJ+nKBFkibodpbJsY=;
        fh=Gbokv2cqjXipI/isbuuM2AkWdnz5ZRsDr4BAyqPfOQ0=;
        b=bvlDnQLUP89kQKIaCRKMcgcqg0MPyROmPn136qnzOdwy4I4Cv1p4KfU7wsVY6uEE70
         C8Em1pc9vDX4GlQPfe9FYFZe1jryBJ4fuettV58WLjLQtq0P6x+TEMpPoItBw+4btQoY
         ujki4gUlZtZqkXAhBxlf7OvZ9nkejN8wkPm/IAKSGXEyVOLuNrqUOKeBpRRQOwQmb5WE
         mPkENRkYRwB1ZAxJZ3xAWn8Kv1zg5VP85cmLNtGM/3tcoL8S2XVJzWNfhHQ44vFkuSCq
         gXi2VNnUmY+wno+snUJDWl39r2NRx0kG0R/UDeqWTe3LRbRP8A55oyCIq42mG+skmlsq
         humQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778570391; x=1779175191; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv57xE2aHeEu30wnsHtZLf1+qWJJ+nKBFkibodpbJsY=;
        b=Wtfospr7eP0arlWJskmmi6ozciyTGAw3rqEkT9GoTJM8hwTEGqn3x1YU9oTU2n/xRv
         bdsJefMWzq1iVtR7NtuF2AO/PF5kw9fwlnRm4/DUnT4GzDV+M9vuTNdT4S9m+g848so8
         7n4bFDw0jiebP8acYFmgm/mmurzfWHnSt8nBtKqKEyINf1F7MEndLItQUkM+/giWdZaA
         JBOTg/i7dsUq+UsOZXj6+ASu0VWWzLn0Svig301HMLMvJFcqA1cyNxGefH/J3YybEbgT
         rs9RIuKfWaRZX+JtuQe3e7BdEhqwsc59gxuICjy9+Bbhse3tTLxPFnAm9Uer9Z7rqBKW
         Gz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778570391; x=1779175191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yv57xE2aHeEu30wnsHtZLf1+qWJJ+nKBFkibodpbJsY=;
        b=V/Q8vd8qE45MZMcfM9LUrz294gMcFOWvNd+wB989ndY1a0PVOJFhqm1ardIINt+4Dn
         /y+si41rhivpCU0LgCcsZ1iE3V7blPgZJ8vw1QhOcwfJy/0q4FWgV0xHm0HC3/wasa88
         ezoH6DnMe2AQVcsUYZx+pcX18xndPX9kz2iOTWETPKtGmQ3a1GMj0ucfF6sXoCDqbh5t
         BxAFBcAFKWqQdv2DYxyJQHL8STlnRBrrfDPoKR0lJXOyuBUQ8e/mOv5xzmlOVwlvP2wv
         R3jMabTWJbWg1kCcDKLV+TUFe9czdROh894agl/OQVelZHAUj5xMYyrMmxZXE4B/Jl1A
         aosw==
X-Gm-Message-State: AOJu0Yy2C/UsGyXqutRjpCFFjYz8ldI6nwITwpG1Ya3NSeJOk0ahvdKD
	pKOVDe5IqBbgvb/TetlW6M8oDgAlPlqQIOwBvoMf5OmnfD0GP6MdosuZlNLBroT0Co0+UbsG3cj
	/ld/Mhy19QEoa7rIXaZ6iyGYTePXLrBM=
X-Gm-Gg: Acq92OGve2SyHxYOTQ1FwkgI3Qrt7M0advjHSWz7In40mTYisaGYJZPkZXukjV0H6Y2
	l4TLpQQrBi+ZhmDgo+lpYMYnhMAMbXJsE1dKD5vBoopQwXDDQ7jhxFKmkMCVUPd3t/v9qgilRIw
	F+XY9RmYIgy4ph3CyBhjzNDdMg6SFg/SnhvWmQmb9uVp9Jik4OKrK4HqIedzBvMj3SLsKGgsblP
	5lQaeGo+iRNUtrPCRL/2PeXIUY1/VopPBG43Wgk4kvtnlxHRssi/pYmNebrNxi7pLeprbVTFLMb
	bnL+Dg==
X-Received: by 2002:a17:90a:e7c4:b0:367:b819:2214 with SMTP id
 98e67ed59e1d1-367d4890aaemr12166483a91.13.1778570390503; Tue, 12 May 2026
 00:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvw_cRpJbBKg2YG9_oi5Bv_DU39OB41nPyJcq7hv7hK6YQ@mail.gmail.com>
 <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com>
In-Reply-To: <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 12 May 2026 09:19:37 +0200
X-Gm-Features: AVHnY4KcdgSk5QwVcvHni2rXKyWxz72bndmhkRM5t1eexpLbsGHGLJUo6X9qQCA
Message-ID: <CAFLxGvyUZWXEYdvKynRhJEkJGnEKomCmKYvZg3+Z7DJUM+SUPQ@mail.gmail.com>
Subject: Re: Spurious task resume due to SIGSHADOW
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 7:50=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 11.05.26 23:49, Richard Weinberger wrote:
> > I'm currently debugging an issue on a very old Xenomai system, while
> > reading the source I noticed that the very same issue could also exist
> > on recent Xenomai releases.
> >
> > What I see is the following:
> > - A task gets suspended and unblocked using rt_task_suspend() and
> > rt_task_unblock()
>
> This is intentionally rt_task_unblock instead of rt_task_resume?

From what I can tell, yes.

> Because:
>
> "A nesting count is maintained so that rt_task_suspend() and
> rt_task_resume() must be used in pairs."

The application has non-trivial thread management, from what I can
tell, it's fine.

> > - In some cases it happens that the task resumes to execute
> > - It resumes because a Linux signal is pending, being SIGSHADOW
> >
> > Since SIGSHADOW is internally used to suspend a task, this alerted me.
> > So, I suspect the following issue:
> > When xnthread_suspend() fires SIGSHADOW using
> > __xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN); nothing
> > seems to prevent the case where the target task enters the primary
> > domain right before it sees SIGSHADOW. In the next step
> > do_sigwake_event() causes it to resume instead of sleeping.
> >
> > Hmm?
> >
>
> Traces to confirm this theory would be good. But it could indeed be
> problematic that the target state (__THREAD_S_SUSPENDED) is only tracked
> in userspace where the scheduler has no access to while waking a task.

I think I found a reproducer. See next patch in this mail thread.

This quick and dirty change seems to mitigate the problem, but I consider i=
t
a sledge hammer:
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/keve=
nts.c
index 7402e2ef6..d72c3788b 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -145,6 +145,14 @@ static int handle_sigwake_event(struct task_struct *p)
       if (xnthread_test_state(thread, XNRELAX))
               goto out;

+       if (sigismember(&p->pending.signal, SIGSHADOW))
+               goto out;
+
+       if (sigismember(&p->signal->shared_pending.signal, SIGSHADOW))
+               goto out;
+
       /*
        * Allow a thread stopped for debugging to resume briefly in order t=
o
        * migrate to secondary mode. xnthread_relax will reapply XNDBGSTOP.
--=20
Thanks,
//richard
