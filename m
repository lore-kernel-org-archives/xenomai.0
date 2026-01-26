Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E22FDC30
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465164; cv=none; b=Fy8IuxuVsKD0akDPqycIq/J2Y4zvMvrg4Ng6Lx8sHWzmRIfS3JDlTLwktrRftTL8m9NiZ4PInhdLIcBl/n1DRGjjqkc5VJ9fOolaGQ3dh+tSekT5aH51GoYfSmwQlAnImzcINMKb+N7GSWVdditKBiKrjJdzR11/O+9kuQ26jco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465164; c=relaxed/simple;
	bh=BIbywO1wKrACu7GBsGRa2ijqWuHXgbewP1Q6Ag55k90=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZaeEmF8o37PQZANlclaswdvNSxsUQv7c4HPufC6f1BHThIywmy8JTCwSvpMuCu4nfRUDqCErDXfxOSiu/7ajgDXxqehysLL5wfxqy4Ak0JzoaQ/pzIJcQik2hgYDPxjOF+7au1dc4zxbkthkaM5vjLNuhguhWE3GrGYMqbY3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=uY0fOhf6; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="uY0fOhf6"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id DABCC43ECA
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 22:05:58 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 65B5F27E0DF8
	for <xenomai@xenomai.org>; Mon, 26 Jan 2026 23:05:58 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=sigma-star.at header.s=google header.b=uY0fOhf6;
	dmarc=pass (policy=none) header.from=sigma-star.at;
	spf=pass (spool.mail.gandi.net: domain of richard@sigma-star.at designates 2a00:1450:4864:20::42c as permitted sender) smtp.mailfrom=richard@sigma-star.at
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-4359108fd24so2964631f8f.2
        for <xenomai@xenomai.org>; Mon, 26 Jan 2026 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1769465158; x=1770069958; darn=xenomai.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLeswcV99a/24JXNkuU4FpA1sIJrSbdwW/Fm9xYv9Lc=;
        b=uY0fOhf65/HaswHYB0xLwRZaMYtlOq+NCn3NhZAygTiEPHFCTEtpZRYPX5vemEWjBg
         r5HUzh4tNUZ3WcoY3JDu4xix7Gbxjm1xCvCUPjY0a7mxuB67YYW3RhIxcqYN+EvfMPYL
         MKeL+UOs078CO76TpFMUimVDfUJeVtVy2xn70iJCSyR4oc7P/MmD0fSiIkkKqRjvFy3M
         jvUZ0jIAHnz+O6iCEHqghGEYMKmfh+Vr6EwilE24l4wHy1A6V5POx/h2k1VsJlbiN5Vp
         S9RVFtK1otW0uwf1FWxLXIMJj1K78NZufJQQ8mtj+t9J9cs1xj1/dA7UWxthhPVGMvao
         EUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465158; x=1770069958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OLeswcV99a/24JXNkuU4FpA1sIJrSbdwW/Fm9xYv9Lc=;
        b=MEvKyUqBvXG6v8VBdVJlA5YG4eMd9Z4jtvHR1N2F4NAghNkaK2jbkSNITWoPHPlPDF
         T6ICaODkcIk3itBaDeygS45ps14C8pwawoYvqJ48Tqj96YIqm9Qj4V1zTNskB3F6IXu6
         3ptSd8IUlXxexSedKOV1gzLQD54E7eirtrpKdybN75UhDTIjMTYTiLajQ/2cZI4vG9qs
         A6tVAUE8pfFHTGfTpwHIgRJcc7lglsNkIRBXuAhLGiKBg/kwI4GPhILy50lgIzTGVrOL
         FpW7XHQUkDf+X80kndxUKNlh6kirUYkHWNhlKLCsiZ/rsTTMPx3Vqp2K4ypp0b4fPvnV
         EZBA==
X-Forwarded-Encrypted: i=1; AJvYcCUmLJh9vfkW+bBhVLLyky7+XEmnZ+rNSRpCEuB0o/61rvFFdupzwpB8DTlSRr3NOxg94SccL+CT@xenomai.org
X-Gm-Message-State: AOJu0YzLE5Cm3brYnu864D397Hqt2FBgqE8hvuxUAgIsEHgFFHl9dHs5
	jYfwiw9zLR8nF2dkDoqtUtbsRaGR0zGoUxeguCtw7TXcDe2WjXeKDnyWw98N/za3YQE=
X-Gm-Gg: AZuq6aLCXqZw7puib7Uhcu8yO4kQNS+YahQ+benAmTKoknBaYF3M6ZM5pKTw4UtUiGW
	PWp0aLOeTw8J5KlDYDwOC+fxLb3IHmjiXs3RiO5j3Pl8t2lNdsmodAU6pExR2sG6ZLO7G1XU2nv
	irXQfVWko0OtGXSmMQUK1YJ85vtV46PHKeh72c7eJQJDK1DYlU8q9BXnpeYpqWmPuasSR03WBT7
	yn/RFBaZfwR2wVWG4VtHDy+bJeJBmnb6RzjFONNIVI2UvZvUlhQRpFLcweB8h0Qx/BsU1HySckF
	cCyQHs20fldAa5yGG6Lp6mLzm1JqYUp0o2LudbJCpBHlNXKHGD4uO/2IdLnrgp2NInw0WaMsiNo
	9QEXZ5KIJdAXrygllSg6rlUBo8rDwYnbfVVYEUBxsYxPwxyASbt1HLgKbGupj78AIHJ41wUygyx
	pad8JeSIjGthPMpNAsNQDNxdccYlaZnYPG8x0P4sH2w94F8F9K8O8G
X-Received: by 2002:a05:6000:24c1:b0:435:9a50:bbbf with SMTP id ffacd0b85a97d-435ca147449mr9718074f8f.25.1769465157719;
        Mon, 26 Jan 2026 14:05:57 -0800 (PST)
Received: from somecomputer (85-127-105-34.dsl.dynamic.surfer.at. [85.127.105.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e71730sm35721503f8f.26.2026.01.26.14.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 14:05:57 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org,
 upstream+xenomai@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] Allow changing CPU affinity of RT kernel tasks
Date: Mon, 26 Jan 2026 23:05:56 +0100
Message-ID: <8326375.4nMDBE73YP@nailgun>
In-Reply-To: <32b32829-18eb-47a2-8c7b-77e6f6733070@siemens.com>
References:
 <20260126125701.21000-1-richard@nod.at> <3016173.h6DGQjDypG@nailgun>
 <32b32829-18eb-47a2-8c7b-77e6f6733070@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthhqredttddtjeenucfhrhhomheptfhitghhrghrugcuhggvihhnsggvrhhgvghruceorhhitghhrghrugesshhighhmrgdqshhtrghrrdgrtheqnecuggftrfgrthhtvghrnhepfeefudefueefkefgjefgfeefhfehhfeivedtieejgeevheduffejtedvteetjedvnecukfhppedvudejrdejtddrudejkedrvdduuddpkeehrdduvdejrddutdehrdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvdduuddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehrihgthhgrrhgusehsihhgmhgrqdhsthgrrhdrrghtpdhqihgupeffteeuveevgeefgfevtedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh
X-GND-State: clean

On Montag, 26. J=C3=A4nner 2026 17:26 Jan Kiszka wrote:
> On 26.01.26 16:11, Richard Weinberger wrote:
> > On Montag, 26. J=C3=A4nner 2026 15:28 'Jan Kiszka' via upstream wrote:
> >> This is one issue with setting the affinity "from outside",
> >> asynchronously. The other is that it will always imply a migration of
> >> the kernel task, thus a phase of non-RT. If someone forgets about this
> >> and sets the affinity at the wrong time, it can ruin RT workloads.
> >=20
> > I assumed this is known and expected since changing the CPU affinity of=
 userspace
> > tasks as the same implications.
> >=20
>=20
> Likely true. EINTR can be a topic with some calls there as well, and
> some applications may just bail out (or because of trapping SIGDEBUG).

Yes. I did more investigation. sched_setaffinity() causes always two domain
switches but cobalt syscalls get restarted automatically due to SA_RESTART
of the SIGSHADOW handler.

> >> This tuning gap for RTDM task is rather old. I was already considering
> >> to add an explicit affinity API to RTDM to set this from the driver.
> >> That would allow to set the affinity early, right after task creation
> >> and before the driver signals it is ready. Risk of such an interface is
> >> that people start to hard-code the affinity into the drivers, rather
> >> than making it configurable to userspace.
> >=20
> > Well, the goal of my patch is improving the situation to match userspace
> > semantics.
> > People expect that sched_setaffinity() kinda works.
>=20
> At least "taskset" (script-based tuning) - we do not have an API for
> userspace to retrieve the PID of a RTDM task. Yeah, there is some truth
> in this.

=46or scripts /proc/xenomai/sched/stat should work just fine.
In my tests I'm always using it together with taskset.

Do you have a new cobalt syscall in mind to query the RTDM pid?
=20
> So we have the following issues still to consider when adding this
> capability:
>=20
>  - Driver supporting external tuning need to handle EINTR from
>    relevant blocking calls - others will fail, and that is fine.

The in-tree drivers needs only minimal changes from what I can tell.

>  - Affinity tuning by userspace should be done while the kernel thread
>    is (still) "idle" - identifying this remains driver-specific. Maybe
>    document this in rtdm_task_init?

Yes, I'll happily document this.

>  - Should we also provide a RTDM API that maps an RTDM task on
>    set_cpus_allowed* or at least officially provide the task_struct for
>    some rtdm_task_t? rtdm_task_t is opaque, xnthread_host_task is
>    internal from RTDM-perspective.

What use cases do you have in mind?

Beside of that, I have also a patch in the pipline which adds a new paramet=
er
to rtdm_task_init() to specify the target CPU instead of CPU_MASK_ALL.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


