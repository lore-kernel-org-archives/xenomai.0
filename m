Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855A1E0DD1
	for <xenomai@lists.linux.dev>; Tue,  8 Oct 2024 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411752; cv=none; b=i3y0yr4AUdIr3TwNbWGSGEt2eclExdTQ8mYs6tcsqT17tnlvn/FYkhSmc1516cANrQ8R/e3c9oPPdBYFkitaRzOGdUoL3DM5hVTbJ3ZEdPcbliJKqJLSzkwFRUfiWQvcHYqOXsUah3E2dPw9nKVuUIoskcT6gYWn8/g6Uh6EXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411752; c=relaxed/simple;
	bh=hVeB65zhjyN1+rf4MsryZLdZuW0h+JsvFwUXi1d81bE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XnMLkHrLYHNap/v3PPX5fF1azC8SDOEWn8RuPKTcEX55b5d9Im2AYSrgXdVThGgA9aiaVG6GNKwCxEk1IvR9J71AtkU84Br8rPCMqiXiRPAzD5HI7qtCageoOojRBF8N+dYII7mCE873WGK4qBcsGOAO5UhjX+JwRdqKhT55WAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 6075A80002
	for <xenomai@lists.linux.dev>; Tue,  8 Oct 2024 18:22:27 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 9810B740038
	for <xenomai@xenomai.org>; Tue,  8 Oct 2024 18:22:26 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ccd81de57so62328f8f.0
        for <xenomai@xenomai.org>; Tue, 08 Oct 2024 11:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411746; x=1729016546;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRbTn+EB/qcsxl/WSujlxQtKgUD7UiGbZvJUuusEXUM=;
        b=k5T4+vZV6SKH5xzSJ7U5nGzh22QMwhMabyr/qeJNFval7oPrdtMnKc71Nn9K60lxAM
         UG5QFve5QiRnD3vZf0S+9mE9Gm+8gVRI+v5EqJysUwjW93qf3lXZr/lO+uFj0Wj2hRCn
         qRkhofrHlszUtVGSckoDDDFY9p27R87BoYnKa3ViNZiELVNELPgmbBGVeWHxwHs4WDQN
         sdTk7Zx4BP5zvFc3Ei5NkppDaVOHvWPIrU2Mvp3U2Kdq0vlNoyrtW2six4yAnwNwsji0
         xsE4FWhQFi8qTyEpZB5W1R028QUrMKTdZAPjHRajK1+8uD6WZ8V2wuTnZpy0ynH+Xp7p
         mSKg==
X-Gm-Message-State: AOJu0YyN2dpXYoHyx6mk7VV94pdCgRI2dT5gWY9uXTTAdX9Z3OyfLFkR
	Y+uXy4eGWmpfGgcgHHQdD2V05OHW04MjcT1RNBVfjamtmYoa/iZjOYGsWg==
X-Google-Smtp-Source: AGHT+IFH28whPd23quetrxAWMp0sDJQOs16Ilb4JdPgoM5mvJyAstaREsZznrkrKNCmJZ4upNFLRnw==
X-Received: by 2002:a5d:5407:0:b0:374:c4c2:5ad5 with SMTP id ffacd0b85a97d-37d38b20b1bmr819580f8f.27.1728411745863;
        Tue, 08 Oct 2024 11:22:25 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972b97sm8582933f8f.99.2024.10.08.11.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:22:25 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai <xenomai@xenomai.org>
Subject: Re: POSIX API for EVL
In-Reply-To: <CAFc1U0vYfF_aj5a0zz7GwpjZATgB9td4Usc6JivATCe6tmoSLQ@mail.gmail.com>
	(Pierre FICHEUX's message of "Fri, 20 Sep 2024 07:57:22 +0200")
References: <CAFc1U0vYfF_aj5a0zz7GwpjZATgB9td4Usc6JivATCe6tmoSLQ@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 08 Oct 2024 20:22:21 +0200
Message-ID: <87set6lajm.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.221.51 as permitted sender) smtp.mailfrom=philippegerum@gmail.com

Pierre FICHEUX <pierre.ficheux@smile.fr> writes:

> Hi all,
>
> I've read some discussions (may 2024) about the lack of POSIX skin in
> EVL.  Supporting several skins just like for Xenomai 3 is not
> really useful but POSIX is an industrial standard and so for people
> willing to use Xenomai instead of PREEMPT_RT.
>
> In the EVL documentation
> (https://evlproject.org/core/user-api/thread/) I can read :
>
> The main kernel=E2=80=99s thread is the basic execution unit in EVL.
> The most common kind of EVL threads is a regular POSIX thread started
> by pthread_create(3) which has attached itself to the EVL core by a
> call to evl_attach_self().
>
> Don't you think a kind of POSIX "wrapper" could be useful or is that a
> silly question ? Did I miss anything ?
>
> I'm about to start a study for a big industrial company and the lack
> of POSIX support is a real issue.
>

Years ago, there has been a proposal for a Common Xenomai Platform
effort (aka CXP). Its purpose was to establish bridges between the
xenomai3 and xenomai4 systems, user space (e.g. POSIX interface for evl)
and kernel space (e.g. RTDM emulation over the evl kernel API)
included. AFAIR, this proposal did not get any traction, no user
feedback showing interest on this list, so it had to be ditched as a
consequence. The only way to revive this effort is contributing detailed
ideas, a plan and some code.

--=20
Philippe.
