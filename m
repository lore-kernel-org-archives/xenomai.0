Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E434EF04
	for <xenomai@lists.linux.dev>; Mon, 24 Aug 2026 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568122; cv=pass; b=Km+uK098VeVMannr8vWWETMG/cruDjMrkn2+pju9BE/Ftrx4A8DAImd8ltbfvyQ7AMnDHrLmZwUatBGeVqm6WrjaGol2n1aOVR5D8lIOXFzUQ8KWWe+uwk8RxgX6XaXUoRG6aTi0AtsFf0mDtMDFrsfW9ZNYrhDyAS3kgZKkwQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568122; c=relaxed/simple;
	bh=qdMolGl6+DMshD3JuEWUKi73RKSM4Q4UIwvGfB0hgGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkYAbTcmtRA7cWY9/Y1nKnkqyG4d4WGUBD3VQj2nNZe587RwFAXSt6Its74HcunQ8rfxHuWj6P7SRxoW6Zt+JoG/PwfnvY3uKS3bHAsKmEx2krEwVmUJa5caZsH4xoEv72dh5JqfW8kunm2ciGv3Mrfzq3XLzUy4Q5tphndlN+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMtwrZ34; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMtwrZ34"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so2157813a91.1
        for <xenomai@lists.linux.dev>; Mon, 24 Aug 2026 03:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787568120; cv=none;
        d=google.com; s=arc-20260327;
        b=pwqFppYgCcItRoLpkT8sb/axBWtyjpvrzCTB9hNLFZ2krKRo/ISyL6XqNk4qZOknBT
         okdUpnDJ/wJq3/c6XXpirKUocp4itaQ9iVc7n1aO6RlEGAUsE3BHtNYCP9D6pL2NAe0K
         DivXoXib5lq7cUd/qkKQR52wVqwWMx1w5GJNJ1NAeo2AeAzOyHAiAoXv4iTNNTeJOQFO
         BGcJ5hsRHGnwBaFI1A6yb0/054ikOgpoeusdQsDC1tLEtZ4T1WlAx1qgZTfjOq2QQcft
         bFra8TuQ5IteyEiLXEz1rLi6tX0ukCuPOwvc7imHVmYoS7SusREP1ihtzN+uDNSvBQw1
         imzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qdMolGl6+DMshD3JuEWUKi73RKSM4Q4UIwvGfB0hgGU=;
        fh=i6y6nzFONmY9I1tKOsgrbo3Jy/md2baaBrs1QN/6zsg=;
        b=Ec2SyCBZCAKHxzyDrQvxO6BEfG1zezhUlQz6nxpVbBUjFb0ifkd6acyzpFUrL4eI87
         wNC5VAU239r2pCX2ovZ6zKlnz3+x1q3GuMdslq18/AqYpW8mXMLsp0U65ZN0nHWD2jnX
         Ne1hIZVABRk/KxZVKLHnF7UYYgP95WhNJzyetqbb2tPMzVndVgeS+/yY5trGo9lxsAnr
         ep7PDoYcSgE42tOmD8hczrmvP1DjDHWp4MP9ov9N3w7FEqfVMb4m4hvdobBLHfVYTkDd
         ChsQ/NtMM2bgY+FitQmjvkAydKrNoS80A2TkP11ph5I09NM9RKezLY9fykYqMB9mUuXm
         n8HA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787568120; x=1788172920; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qdMolGl6+DMshD3JuEWUKi73RKSM4Q4UIwvGfB0hgGU=;
        b=rMtwrZ34cum47K/b5Oy3EKWbmPCRKdRtIwBfgkmO0g/GGcZJVqiZsDleaqjqyyXASe
         C0Kv6IfvqpwjRoJxUKVgSVhLOwC95Go6JuapewUehsL7+i1PHYHg0TAPtiCfaYrFfL1k
         67M/kMqqgPf7yl4WYdaep/v42UL04i16VNuxaIDhi0f9hn8IT7bpkPsWgujOLT8dyT7Y
         B+QWpjEHp1HL1TfYMTO4H4QqRxjL3EXqH4AI2AsesxswB8BrFssepkDncyaYHqxDN8bo
         +2H7GLQJuxtbdV9YUaHH0fHRcenceOpyQ15iJoImWKN2/3GGahMvas3hOt75Itmub7AD
         j6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787568120; x=1788172920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdMolGl6+DMshD3JuEWUKi73RKSM4Q4UIwvGfB0hgGU=;
        b=ALeJSawUK398YA5xbG1mNfAzAhYsXW20QONdl1v8D+HH4PzQ9WQJ834jX+dbVKPdJQ
         Gk+q/dj5TlAbUP+GS94FZ0CaI21Ymf9uSzqMxAr2gxkwAKf55QO1zKUH3Yg7rdRnYWgR
         hKMFaaq3XCB86CKHYTR3tngCS8viQMzt8JRVD6DN4kBHvHttwQB83lVKMus6VKmFihVM
         sPPXoPUtAGMvsJBVJRWbUbPxAuD8shKh7luf9osI9FlSDQV+okNKXUGQAeH+4TuMX4vg
         e/eZgAIWBg0b/XtXjgUKM3hIvNvl3fEKRusx83STJVKbvDJcfp8YaHOeAiyRahbp4Oly
         6JZA==
X-Forwarded-Encrypted: i=1; AHgh+RovA+ftZeHF1RVmlPKwgiXU/t55gVjL/kitXFVJM9cyUQiZsHcHo6sOZV+/XnKY267I0I8oYCb4@lists.linux.dev
X-Gm-Message-State: AFuF++mTkRO5pVMitlhUwGg18kZsobSEzlJXWWW5SAUr8bVyy2BwIc/3
	G3v4KocGHHNXyE+8rZuxcxE3Zgaciigri9EK1MWlK2m1p4anUKjJNf44lvDCaTbttyHnxSpSzGp
	ji+3zrKdajP/x0HaP+wNO1s5puGXJGqA=
X-Gm-Gg: AR+sD113h9rVzFLZ1Kq+esW4JcSBzP+GvCjECipchantcpVad+MpjsghUo1LlflTAHG
	zLc9oXcn7emCcC1gUOlMPt01JHFQB28egfiNw8wnl6u/sBGHqVdUgrmvJu4J02a2LyXKD9Q3j9Z
	5gedPpEV2R1rOJfkidb98nAKMlEH6MhXMhn45F0YQTNtVChC4knTRzCEdf/vxlDVk2YAxtMNVbp
	6WQ1hJI+DQNb3BewS3vvfT15WJ82GzFqJqPiF1om0OmUlrnBlQVP5WOzcsjjXZBm2aRb9rak/6W
	4y2WYAahDUT6b+YyLNv6wQ4xkiedoeqvxBDo6LGFhvMjKm1/
X-Received: by 2002:a17:90b:3902:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-395c3377f59mr39114381a91.2.1787568120207; Mon, 24 Aug 2026
 03:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com>
 <87bjefs6cw.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
 <a006030cc98da209b4764b5117c41d93fa3d9399.camel@siemens.com>
 <535f40eb-3af9-427e-85db-2afaf69b847e@siemens.com> <87h5nvl5ct.fsf@xenomai.org>
 <2894b9cf-09c9-44ab-945d-cb3edbe5fd60@siemens.com> <CAFLxGvwSE28X_PG2NsyhnFxq5SGjrS3WH9bhJcX4gyrroV2z1A@mail.gmail.com>
 <d8c7650d-d0cb-4fda-8664-177adec000d8@siemens.com>
In-Reply-To: <d8c7650d-d0cb-4fda-8664-177adec000d8@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 24 Aug 2026 12:41:47 +0200
X-Gm-Features: AcwNN1WLXwbXF43PJw7riIcKFy-4B3OcyZeJ_68p6V6zKZ8qNEl523unlHM3250
Message-ID: <CAFLxGvxXvMq5THr1i7u5AFUu2SB=HgBA7rikBMM=Fa0nskz8UQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Richard Weinberger <richard@nod.at>, 
	Florian Bezdeka <florian.bezdeka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 12:32=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
>
> On 24.08.26 12:20, Richard Weinberger wrote:
> > On Tue, May 26, 2026 at 2:39=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.=
com> wrote:
> >>> Finally, there is a now a fairly exhaustive test in libevl to exercis=
e
> >>> this fix which could be easily ported to v3, see [2]. It managed to
> >>> trigger several tricky issues when debugging the fix, so this may hel=
p.
> >>>
> >>
> >> Thanks for the pointers, I need to drill through them - unless $someon=
e
> >> has more time this week (I'm hanging out at Embedded Recipes).
> >
> > After some time this issue re-emerged again on my desk.
> > IIUC these two patches have been dropped.
> > If so, how was it finally fixed upstream?
> >
>
> That whole thing is stuck behind the scheduler fixes for quota &
> sporadic because it touches sporadic bits (or would benefit from those
> being dropped). Yeah, needs to be resumed...

Ok! At least I didn't miss something. :-)

The most recent issue on my desk is related to this particular patch.
It misses the case that one could suspend and resume a thread before
the SIGSHADOW
handler runs. In this case the resume operation is lost.

Just to be sure, Xenomai offers no way to wait until a thread is
finally suspended?

--=20
Thanks,
//richard
