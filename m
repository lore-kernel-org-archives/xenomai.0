Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBA38E8DF
	for <xenomai@lists.linux.dev>; Thu, 14 May 2026 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756924; cv=pass; b=lcsk5+vmAynuO+iXyO31c/vVaJhWy4exnFNtww09ScfeFhABEwxGGNmUjRgrmF7Ua6iQEx2sRUUaRO59eUeUjgXf5qACxAFDT5Rwc8J1ZSHKDjifPB2SpD5xjJFefwAh09TOP5pqlVGsN6h1K4CljqfNLLMjAZ3Cyn/uSF8dW8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756924; c=relaxed/simple;
	bh=N0Cu9zcmAGC0a95eOJtMq+TR1ka9YCCcwKaggbQtE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWFT2SGdKNQ4Mi8TtuKOVdzDYXrabMwELQAZyeo/fbzyPMf50ynOxPki0qHGdlNJSAdKCQsrwLZn4SnUOfQprJRO7fvI8FHr44RowyQMnilJ2rhFtldMsp94uUtUY/19hASBa2Gv1PEFEe2T3x0R169SX6RxLeoqcX02+7RmGgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVCMcQU9; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVCMcQU9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so5706142a91.3
        for <xenomai@lists.linux.dev>; Thu, 14 May 2026 04:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778756923; cv=none;
        d=google.com; s=arc-20240605;
        b=TvzvPJRYgc0nXlEXhqMZF7D592ys3Nd2MOVSnmH7MP+pDNUQXVHnW4tAAxCMrzDKDE
         +JcBZdU+PZbVZeIdy6bLPe4yTWTE526oJjSq53sgOCOH6ORAGjK2zTLK4mnfdC3ZySNs
         Hv7NWuDQxB81KEEpzzQHEHBTvmM5FD2ZelRJeWVNeEYpWrku7H1hD6u+dHylJrzmeiR/
         LrSjitWP3cJiAlHpcLzPphrMbSqMID++07esF6FmzSM1Vr0g1D/osDUw+bF6/y+vC/Eg
         vncIE1R0c0FNXhAvjiTAffClVD/HKsWMCgR7kka+tWpk/QGhd8wKIHONhTJsWSU/owzd
         v5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GRMIrrwDzxI6iTQjdJ52V7w7Ea9fzmUosi2y1DVtDOQ=;
        fh=Gbokv2cqjXipI/isbuuM2AkWdnz5ZRsDr4BAyqPfOQ0=;
        b=CoA8qnjdvoJ3zEJiGUZKhBQi+wdYs2ZL1oxFbyeFvsJ7BnTOw5UVz5QKw/hH4ls0v1
         yZhvTdix4xVwaIbPrvPeWXnDUU1kTJnErm4xruS40IQwKJpPwTRHLXnIOX8J+H7T5cRl
         kVkz5JjlAAjpe+b2Mjs54VGU8KJdgm0EQUlhguwWFp5bt/eg+8VaoyStB2QOzXhLhGG1
         uXFke43RHY8fqSnT9WIWFTYaNfkq45GQbIMiwK46DrRrCXwL9IHdlg0OAWKFXk0zuufs
         CSEpcIj7fuaieD5wvhVzmhBiUptvZUAvrQ6fL04AOAw/OVby8sypi3R1kd7RxB9R7hM1
         ZllQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778756923; x=1779361723; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRMIrrwDzxI6iTQjdJ52V7w7Ea9fzmUosi2y1DVtDOQ=;
        b=iVCMcQU97VifpXMqqpGOGeRC7EFg2dUOEO9JjMa5mwK8hyHoc6+xxPnZYRuCtGblGH
         KPVHUC1TXCT8HmTz20Vcn6Q+sLQLqP/gVCk2aSlLU7lcrFCIpf7J7vAyTp1WwGi5iODJ
         /gXLp+b3tvsXbAHBkACQvnPaqhmcBb0bdYRRc5G6nW75vyNUi0qyvhCbG9ZYLikM9jDt
         A3gXN0vus97ZxiNvXUv/yRoyPhjvh2/T/yPWsSOktl4vF2hazSr/JHTTpKDjFcHy57Rm
         MUtCKwc/WGxU2xvohhJTFlk2CAZWUWZ5/kkzQs5tKYtfLHmDrIiEXiFiiBl2+RY3XTve
         5hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778756923; x=1779361723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GRMIrrwDzxI6iTQjdJ52V7w7Ea9fzmUosi2y1DVtDOQ=;
        b=oGjGQJZjJTCesRbX9POqKncs+v/Q5MGZ9ug0+xXLBCN7vxFthXUJicJveLdPraUO+e
         W5unVyAZbAW1g9sVTrGQFbZEz+JRN7AQtV5jJSg/dD0qEFAfGUaeu6xF3FDN533sfzXU
         CWy4rBa0Ct7mhBZepa5bsyPMQ4twbPeRvI7EWwVDVNW/UMaR1oivwDbcedeqbVPFkMGM
         OlVFcCKwdKvk++WZd5Qs6Ei4FsEy+INCGVSCYDDJ+zLyohL+RqAhZgARIccmdOCqOS2B
         Urh1u8nUEb8SzFuwWQiBeoell/iM+sNImSPPcqACs9tUcWahhsYdOevQKUC4EpnQWqrb
         OoDQ==
X-Gm-Message-State: AOJu0Yw1zVWc84FUNTgCleHatkFuYbMnLw8x5rUO8CFNjNBoki/qVVEc
	f5iBJooo8G0FnKOfFNaDTfY8kwv+SE7xUlPR7Z1Ml/ZKE19bfjj92INYo8+2eIBGLD1yigj4PZn
	GEBsR+dVrJi4mfk01VBOvF65Qax++Sj8=
X-Gm-Gg: Acq92OGSoeAc9D2c9Nk5sTzXg7hz0UinSlE28OHjEXofh4EnepFUKEb40KhKx7l8KY1
	litlKKr3CNUo2qpF1Kn5OF5T39Gp06h/KITxzZ3Sklq+Wa1AnBBsQ8iwApf56rPc0VlvKGf5Ike
	xlim8tDSTq/kks9ZDQeKzBbsIU/RJKV3QyB5BJicejjmGMMAzn7ZzlDgawST+J9RbPkU7GBOerA
	RTmLAw2b0l8bmi2TGkgarqogr//QbnN6njD0cLK5RuDGpUbtdjrw2dktQ8ueY/7qHITI7q8lcjQ
	hhW1LEw=
X-Received: by 2002:a17:90a:2ca1:b0:369:1dcf:4a56 with SMTP id
 98e67ed59e1d1-3691dcf4d6cmr3077943a91.21.1778756922311; Thu, 14 May 2026
 04:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvw_cRpJbBKg2YG9_oi5Bv_DU39OB41nPyJcq7hv7hK6YQ@mail.gmail.com>
 <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com> <CAFLxGvyUZWXEYdvKynRhJEkJGnEKomCmKYvZg3+Z7DJUM+SUPQ@mail.gmail.com>
 <3077e418-741f-441a-91d6-a07ec6c8f2ed@siemens.com>
In-Reply-To: <3077e418-741f-441a-91d6-a07ec6c8f2ed@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 14 May 2026 13:08:28 +0200
X-Gm-Features: AVHnY4IDGmlR8NxCsF-5_uAygF5DfLU1bvUaHVhcUWTshXrhG815T_GOotRtvRg
Message-ID: <CAFLxGvw+YkAdHC5HeqcAZJ5aGpm9tHNYO7+aoguHDPaVcAwAQw@mail.gmail.com>
Subject: Re: Spurious task resume due to SIGSHADOW
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 12:00=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
> On 12.05.26 09:19, Richard Weinberger wrote:
> > On Tue, May 12, 2026 at 7:50=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.=
com> wrote:
> > diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/=
kevents.c
> > index 7402e2ef6..d72c3788b 100644
> > --- a/kernel/cobalt/dovetail/kevents.c
> > +++ b/kernel/cobalt/dovetail/kevents.c
> > @@ -145,6 +145,14 @@ static int handle_sigwake_event(struct task_struct=
 *p)
> >        if (xnthread_test_state(thread, XNRELAX))
> >                goto out;
> >
> > +       if (sigismember(&p->pending.signal, SIGSHADOW))
> > +               goto out;
> > +
> > +       if (sigismember(&p->signal->shared_pending.signal, SIGSHADOW))
> > +               goto out;
> > +
>
> None of this will work, and I'm afraid your approach that you shared
> yesterday for retired Xenomai versions will also fail. I played with
> something even more targeted than the above, and different scenarios,
> e.g. task startup, were starting to lock-up. No surprise, we are
> breaking SIGSHADOW here.

Please help me to understand why this approach is doomed.
I fully understand that unconditionally checking for SIGSHADOW and returnin=
g
from handle_sigwake_event() is wrong.
The check should happen only if task p has the state flag XNSUSP set.

What race do you see with the "fix" applied?
Maybe I'm focusing too strong on the symptom that a suspended task wakes up=
?

> The fundamental issue we need to solve with remote suspension/resumption
> is the asynchronicity of the command vs. the pending (and
> non-suppressible) signals. One idea I had is to use a separate
> SIGSHADOW_ACTION_SUSPEND and perform a self-suspension instead of just a
> hardening. That works nicely for resolving the issue you found, but it
> creates a new race between this pending signal and remote resumption.
>
> We likely rather need some additional state flag in the thread to encode
> "suspend is pending" which can do the right thing before a thread is
> returning to userland and can also be cleared from remote if suspension
> is lifted quickly again.
>
> Did I say that asynchronous thread suspension is a horrible concept to
> implement correctly?

Yeah. :-/

--=20
Thanks,
//richard
