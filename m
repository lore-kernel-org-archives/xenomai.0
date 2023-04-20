Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99B3C2F
	for <xenomai@lists.linux.dev>; Thu, 20 Apr 2023 08:51:49 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 0829224000D
	for <xenomai@lists.linux.dev>; Thu, 20 Apr 2023 08:51:40 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	by spool.mail.gandi.net (Postfix) with ESMTPS id D50B2941675
	for <xenomai@xenomai.org>; Thu, 20 Apr 2023 08:51:39 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id a5so4675880ejb.6
        for <xenomai@xenomai.org>; Thu, 20 Apr 2023 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1681980699; x=1684572699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlPqqcXb/kmos/MyPeZn+bdrUdaqqp/CxGMm/Qz1awg=;
        b=YZaV9O0UwFEz2rX3PyWe1jLGmnT163SxCr9agJkShWx65czpJbc+/ZYdSxcmYldv8N
         YLntrrt8HjWcJ9YIutpx4EXAQv/0rdhy5rBC/Id8hZZ3oiGBc57eJbkDZuiHgBTyn7i9
         0NTIaxDIYSsBszQ89u0utimr9ETFyZQwCvJgI2OYK4P5fZue5zBGVY3zh8hZFY6wR5Nq
         umIPq8s+7Cgr6siB2tpkB1Ssrj5Sg+yGQgvp0Bnp9R24NAJJKqXIisseDF27okVPXyvP
         MfdevE2JXWuIhsSwyyisHYD+Uv6vgg9UQNxpwy7Mg6GaGxoLWwAMs1yONRZH8D7DX7Q3
         OZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681980699; x=1684572699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlPqqcXb/kmos/MyPeZn+bdrUdaqqp/CxGMm/Qz1awg=;
        b=RQsuuNlNLtz2BJGyQ5jWldYBy9RLQVqWkKGOTGAmMZW6zYaLGshp/SvugvwXtC3a9r
         D/6yCqfAjdxq/VPIJ82SDuKOSI4/lZ5nkivB97kNh7ajQBTAmYoMoM8uZabjINlvgRBx
         AyABOLPLyyWq/XGIOtApmxl1LySR9MTD4gx2+4UeZeqnmcIY1w6qyB2BvbKinRmT6RO6
         wA/09tlRbc19/AruuebeaijwlSM/sTtVdZu3R5wC8mhe/HvH2EeS8ZPXkku/iBKuvxqc
         w4ANevgNtaJPkoSVcrClUZf4WMlJvwAAARgdwtomtekrfNnmIBQcW6IijWlHUzhvvc2l
         Fbpw==
X-Gm-Message-State: AAQBX9c4OMpLfLwt2iEgyPNzS5mjOwNNZo82WfI0UFGZIqt9NAjZ2mGs
	4ftNHxO+fBwiYtJjzw+ebBGnEg==
X-Google-Smtp-Source: AKy350bwpED80k9wX05I9ImV7yCrQROEC+1EkF1aeneoUPbamRcmImKmkiIUE+tniZTxHhMyOxKNzQ==
X-Received: by 2002:a17:906:a402:b0:94f:29f0:edc0 with SMTP id l2-20020a170906a40200b0094f29f0edc0mr829770ejz.44.1681980699267;
        Thu, 20 Apr 2023 01:51:39 -0700 (PDT)
Received: from mail ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id p16-20020a170906615000b0094ee6b963e0sm491624ejl.60.2023.04.20.01.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 01:51:38 -0700 (PDT)
Date: Thu, 20 Apr 2023 10:51:38 +0200
From: Aaron Marcher <aaron@sigma-star.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org
Subject: Re: [PATCH] alchemy: Correctly translate return value from
 pthread_mutex_init
Message-ID: <20230420085138.c62pgvmn66qu6a5h@mail>
References: <20230416193053.22092-1-richard@nod.at>
 <51bbd78e-47d3-52ff-808c-d0212b84bac7@siemens.com>
 <9e17fba5-a2f3-95ef-2f8a-2dcc64116b4e@siemens.com>
 <8fd09c15-368d-e2c0-a6be-48c07d1ef7ce@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fd09c15-368d-e2c0-a6be-48c07d1ef7ce@siemens.com>
Received-SPF: pass (spool1: domain of sigma-star.at designates 209.85.218.51 as permitted sender) client-ip=209.85.218.51; envelope-from=aaron@sigma-star.at; helo=mail-ej1-f51.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=sigma-star.at header.s=google header.b=YZaV9O0U;
	spf=pass (spool.mail.gandi.net: domain of aaron@sigma-star.at designates 209.85.218.51 as permitted sender) smtp.mailfrom=aaron@sigma-star.at;
	dmarc=pass (policy=none) header.from=sigma-star.at

Hi Jan,

sorry for the late answer, I was pretty busy with some other stuff.
I tried reproducing the error in mutex-1 in alchemytests by building
with the same options as you:

	--enable-pshared --enable-registry

Unfortunately I cannot reproduce your issue with today's master with the
testsuite patches ontop.

On a sidenote: I had to apply following patch to make it build with
`--enable-registry` under my setup:

https://lore.kernel.org/xenomai/1b7b54e5-2087-1d4d-3820-705332699cb0@yahoo.com/T/#t

Aaron

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y

On Mon, Apr 17, 2023 at 10:39:36AM +0200, Jan Kiszka wrote:
> On 17.04.23 10:22, Jan Kiszka wrote:
> > On 16.04.23 23:14, Jan Kiszka wrote:
> >> On 16.04.23 21:30, Richard Weinberger wrote:
> >>> The alchemy API uses negative error values, so the return value from
> >>> pthread_mutex_init() needs translation.
> >>>
> >>> Cc: aaron@sigma-star.at
> >>> Signed-off-by: Richard Weinberger <richard@nod.at>
> >>> ---
> >>>  lib/alchemy/mutex.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
> >>> index f8933858647a..5836af59f05e 100644
> >>> --- a/lib/alchemy/mutex.c
> >>> +++ b/lib/alchemy/mutex.c
> >>> @@ -133,7 +133,7 @@ int rt_mutex_create(RT_MUTEX *mutex, const char *name)
> >>>  	pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE);
> >>>  	/* pthread_mutexattr_setrobust() might not be implemented. */
> >>>  	pthread_mutexattr_setrobust(&mattr, PTHREAD_MUTEX_ROBUST_NP);
> >>> -	ret = __RT(pthread_mutex_init(&mcb->lock, &mattr));
> >>> +	ret = -__RT(pthread_mutex_init(&mcb->lock, &mattr));
> >>>  	if (ret) {
> >>>  		xnfree(mcb);
> >>>  		goto out;
> >>
> >> Thanks, applied.
> >>
> > 
> > However, this didn't help with the alchemytest issue I saw, just tried.
> > 
> 
> BTW, my test setup has --enable-pshared and --enable-registry, maybe
> that has an influence.
> 
> Jan
> 
> -- 
> Siemens AG, Technology
> Competence Center Embedded Linux
> 
