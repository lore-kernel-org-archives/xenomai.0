Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA13BEA2
	for <xenomai@lists.linux.dev>; Wed, 28 Sep 2022 10:05:55 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 79D95C000D;
	Wed, 28 Sep 2022 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1664359548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKSCum9iM6SP7cB9fWWVqU/Ahbg+2tA4iSu2jSH0z48=;
	b=O8tdPPGFwxOkBDWwsx3RBVUq5NquqXoOlq9YxRqxXsjUjFGuAiLsqtyUg6QrxDK/OVF69Z
	8mofhZXFkROb3LXNb4Pn43HPkABNOmGlCp8bfbNmwNvHFQYqpC1aOheJHUBxzpJPmhaWDD
	p7TMtGAE2O4V4f4WiMo2wD3ETwsH1AjvY+t5ukX02vmAApyPmb86o164/SSMdmhpMUNmv3
	pZ+yqX3XGRmTKfZTeXdL1I4zdDrcHg39N2rKabEKE5Hr0fPdT4BQXWDEuE5ZYBqW+3WMz9
	CH8uBMAlKawdcwLmX7j9NnjKgbzQaIeyMWurWVWum7d34d8i3A5+zizaBowzyA==
References: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: [External] - Re: System hanging when using condition variables
Date: Wed, 28 Sep 2022 11:59:03 +0200
In-reply-to: <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87h70r7r0m.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> I am not sure if this is useful in the meantime but I have attached the
> kernel stack traces that we see whenever a  CPU gets stuck.
>
> Thanks,
>
> Russell
>
> [2. text/plain; stacktrace_1.txt]...
>
> [3. text/plain; stacktrace_2.txt]...
>
> [[End of S/MIME Signed Part]]

We see a NMI hitting a place where the CPU seems to attempt to grab a
lock, so this would indeed point the finger at a locking issue once
again.

Could you enable CONFIG_PROVE_LOCKING, CONFIG_EXPERT then
CONFIG_DEBUG_HARD_LOCKS for testing? Maybe lockdep is going to help us
(this will wreck the timings with a significant slowdown, hopefully the
app can still run in a degraded mode in that case).

-- 
Philippe.
