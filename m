Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF34689
	for <xenomai@lists.linux.dev>; Fri, 18 Aug 2023 09:28:33 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5234f46c6f9so859416a12.3
        for <xenomai@lists.linux.dev>; Fri, 18 Aug 2023 02:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1692350911; x=1692955711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sA19lnrM+5VClgpMjJywg1DuGw495aqgHLDSLBZ8F6k=;
        b=XbT3EroIZuxGRRL1bEaq3KIPtnxzIrlgVKWjHDjdOWPvWQ6j/XKMmtW8o4kjZ6NHGj
         i1aG1qV1E7SVbJGngW9GJTXZQ2ChRJFpdm7DFpCFltPRgRZeBKEZz204ljqvzFvzflD1
         XZXEyMQz0Ac1pib7D4yLOSgspfaaEwPf1Ldj/mbqUSXwdrDl6IAttL5YEmIvZzvcbX2X
         SgeBkITuzDEWfSBlEigb29nfju5Mv5phjxkvWx7jxKHJizFBdNtSdC1xgYVYRhbPDThL
         ZSWAhD1GhL2JlhlQe3skLT+33niMNnTUA2I6WmnHeuC+o05INwG0LYuRR0ZbWq8IjBil
         SSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692350911; x=1692955711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sA19lnrM+5VClgpMjJywg1DuGw495aqgHLDSLBZ8F6k=;
        b=KOxT4YgDxXSyicN9G9YjWbl0tqc9RLIygo+ZY2oV9q6Aqnzn0HuaqmcT3mZuTeaakO
         0iSR3ngT9mvPevQtLsZKW4uJ4YwTokFU3ZKWASAjoPkE2qICKJO2SCxA9xC11JPQqixm
         c1w5wMC5wnFGztM9QWn3W5f2QnTUQKw1a8fkZBnb3H0NOpu1twK7BuU68W0ZMkkPchhe
         Ie4uaSoy9r2v4yTzGWq/20LnatWzPWFctmjAw0DHMblHmbZC58PxvNOJUtxxxQQ0ha45
         p36pAZQe4Lu9+mKW5kP8xQF08HKLSkb8n6R7lq3c0PUAEMRNm0pFFdsUljbKr4CgJQpc
         EgDA==
X-Gm-Message-State: AOJu0Yx8H3faV7Qju6M/otd0/kRQvJ+xE/jHG72RkgtUaJwqvgkWel2M
	SrjR2B3n4/PlRVecn1egxkV9O8STVaEzfRbVI3E=
X-Google-Smtp-Source: AGHT+IE16CPwXFoGbIFDShoXnDfodh4Stvh0fcy1ESS4J5w5vqZ+jYRMHI5+YR09OSYM3blUTn0Fow==
X-Received: by 2002:a05:6402:1a33:b0:51b:e4b4:8bb0 with SMTP id be19-20020a0564021a3300b0051be4b48bb0mr1558453edb.2.1692350911414;
        Fri, 18 Aug 2023 02:28:31 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-89.cable.dynamic.surfer.at. [84.115.238.89])
        by smtp.gmail.com with ESMTPSA id p6-20020aa7d306000000b0052574ef0da1sm858453edq.28.2023.08.18.02.28.30
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:28:31 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: xenomai@lists.linux.dev
Subject: Task exit via rt_task_suspend()?
Date: Fri, 18 Aug 2023 11:28:29 +0200
Message-ID: <48358551.MN2xkq1pzW@somecomputer>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi!

I have a not yet understood deadlock in a Xenomai application on my desk.
It looks like the deadlock is caused by the fact that rt_task_suspend()
can cause the calling thread to exit.

So, a thread puts itself into suspend and never returns (and exists).
Debugging indicates that ret =3D __RT(kill(pid, SIGSUSP)); in threadobj_sus=
pend()
is the place where it enters the kernel and never return and inside the
kernel exits.

Can this be? :-S

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


