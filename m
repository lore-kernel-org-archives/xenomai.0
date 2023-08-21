Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1D15B6
	for <xenomai@lists.linux.dev>; Mon, 21 Aug 2023 05:49:42 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8283773a12.1
        for <xenomai@lists.linux.dev>; Sun, 20 Aug 2023 22:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1692596981; x=1693201781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bysbPJTwT0QJWYwNfHe+L6jxrzC3RUXIPyXT6echOcw=;
        b=qaO6GhF3i7qXXA27KJ3QeuJkR3M6YHOsc3SJ9ehRd/SFD8iAOtEkj2+lAR4hDEdHBw
         4iVu/WFJr+jhpVBLZpcbD1yE8vLfiDNZCNuy0ctzmE5GI/MC/RFJop/fSO7QzFiWewNy
         evbmXxu/69MBNKWyivtRDUQ+Pncb/abF6sjlGdIKuNBbJhtdCXga0nlOzR58MdSUZGZA
         GtW8s3j9ItC9r4B/3zu9QV40bWCzHUklzPXNXeZ1y5pNPy1Ud01lBZbbKPv714QfdL34
         wyxPRC32uLUHLf2AYNUvRgVxheSvLzw03OoFx2+IftTvkjVT53GbRMZ55YfZN1P3CaR5
         7vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692596981; x=1693201781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bysbPJTwT0QJWYwNfHe+L6jxrzC3RUXIPyXT6echOcw=;
        b=M2jsXVm0aCFVKWMZ/MdappS9ewQEvlmpM8KCFwJuxSFlQ6ktehR2CUDKR09PEkNRhQ
         u54WySq1wf2qwf5NisRcNopTIE+GAMwgfEEfys/aURzS/qZWszRtvCotFDn2eREIwh0E
         0eppmc0ZvQ1KPyE0DxbzbYQ/CxRbc26lDSqteNWsL5vxiBV/cRz3epxEpEisUWuD6xbj
         1Exx0jaeafnHMkngrPkLvDzFvxaa36dN/HJD5fsJ712JxWA1FFICe4Yb5oww59adXXN8
         x9/4MXLJDGp/lV+m29xdy9S8/X+pAvcDI3jbkbAy+MRy6oECBkd0ZUqP35GTX3K7D7J7
         Hc1Q==
X-Gm-Message-State: AOJu0YzgRtEPbvuscM8E7eSJdfZV9RudSpbJXTzq7ELfBLejk8WcsM8o
	y86/jA5ZAWJKOFaSxomax4SYxUjiUiU3e+G9XWQ=
X-Google-Smtp-Source: AGHT+IGi/uCEAfhRgL7sqPcYx/Ew7Y3EVtppVsRRKoH0omQlyisx5Z9ilPzVphFDzX5fSe/84AU3Eg==
X-Received: by 2002:a05:6402:350e:b0:51e:5206:d69e with SMTP id b14-20020a056402350e00b0051e5206d69emr6332166edd.10.1692596980248;
        Sun, 20 Aug 2023 22:49:40 -0700 (PDT)
Received: from blindfold.localnet ([2001:4bb8:106:1052:c2f2:7443:d2b0:93b1])
        by smtp.gmail.com with ESMTPSA id d16-20020a056402001000b0052565298bedsm5463003edu.34.2023.08.20.22.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 22:49:39 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: Re: Task exit via rt_task_suspend()?
Date: Mon, 21 Aug 2023 07:49:38 +0200
Message-ID: <5802232.zQ0Gbyo6oJ@somecomputer>
In-Reply-To: <87fs4gqmu7.fsf@xenomai.org>
References: <48358551.MN2xkq1pzW@somecomputer> <87fs4gqmu7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Freitag, 18. August 2023, 19:26:15 CEST schrieb Philippe Gerum:
>=20
> Richard Weinberger <richard@sigma-star.at> writes:
>=20
> > Hi!
> >
> > I have a not yet understood deadlock in a Xenomai application on my des=
k.
> > It looks like the deadlock is caused by the fact that rt_task_suspend()
> > can cause the calling thread to exit.
> >
> > So, a thread puts itself into suspend and never returns (and exists).
> > Debugging indicates that ret =3D __RT(kill(pid, SIGSUSP)); in threadobj=
_suspend()
> > is the place where it enters the kernel and never return and inside the
> > kernel exits.
> >
> > Can this be? :-S
> >
> > Thanks,
> > //richard
>=20
> Cobalt signal handling may not be the cause of such exit, syscall
> handling could be, i.e. any code path crossing xnthread_test_cancel()
> starting from cobalt/posix/syscall.c. The best way to find out would be
> ftracing.

Thanks for the info! I'm pretty sure XNCANCELD is not used.
I'll dig deeper.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


