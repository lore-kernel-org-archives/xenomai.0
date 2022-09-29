Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA810F7
	for <xenomai@lists.linux.dev>; Thu, 29 Sep 2022 07:07:21 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C3F2860006;
	Thu, 29 Sep 2022 07:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1664435239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Tl67zKxelgg8Sve260MGzPr86JG4SP/FioRdJiEwkU=;
	b=M7RDYLNi76AEbBFGWrWkfCQhHb1PD1dz7VJpcyJPJiTxvtlPvasU2b3VFeSprFeqj5CVQG
	ioJLmnHtwkjk9aytb9AwIxNzFrW6n6wGPLofmYUOlQppGBidyE9RcVlYuUqBSZBV956pdq
	VswDpBHyrym3ONHPIRWIgPnrllETKw4fUI5BSsCeXmS2z7R4Mf59+TTAhJ/Fb/+ccnI9jw
	FmI5WG4rOeJoH+n/ScKjpEbL93/KvwjLSCzw2ao3h7efHQtlAkZCKllWojPMgQJnWGNq1Z
	D5LmiQ5sHiY4QK94WZccB3SFpuuVCme8X5Przd7/ZM29+VpX3+QHngXDALEAHQ==
References: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h70r7r0m.fsf@xenomai.org>
 <PH1P110MB1050C74BE6BB64AD707616BAE2549@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: [External] - Re: System hanging when using condition variables
Date: Thu, 29 Sep 2022 09:04:14 +0200
In-reply-to: <PH1P110MB1050C74BE6BB64AD707616BAE2549@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87r0zu7j6i.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
>>Could you enable CONFIG_PROVE_LOCKING, CONFIG_EXPERT then 
>>CONFIG_DEBUG_HARD_LOCKS for testing? Maybe lockdep is going 
>>to help us (this will wreck the timings with a significant slowdown, 
>>hopefully the app can still run in a degraded mode in that case).
>
> I have done as you asked and have attached all the dump I get from the
> kernel leading up to and after the hang.
>

Thanks. These reports show that an assertion spuriously trips in the
lock validator due to a missing fix up in the Dovetail support for that
code. Please apply [1].

[1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/4a69fe36119511dc429e6239eeec53f17843d8e8

-- 
Philippe.
