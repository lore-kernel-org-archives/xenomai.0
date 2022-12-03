Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD802568
	for <xenomai@lists.linux.dev>; Sat,  3 Dec 2022 11:37:33 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E7E79E0004;
	Sat,  3 Dec 2022 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1670067446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNKwm1K5Celqj9LlpTChDvfiYfyHWvm41X6S1tNawl0=;
	b=neseoTFex8gfzk1izFEPMyyz9ogUSF5cHF5Vt54pzjb6cr+3/9zkZ6UxyWPoYMK8AALmBG
	a/2Uw7nf/jfdiepB7b8wCHeYIYKK4PN5gZ7wF+ia9erffYHYre3EgDy9Xhb6eobSkNLicC
	5tOlYCZKmFRYeWfXEEPuYm07EU1fQoJMjBeOpCI4Hy9pV8SgFbD/fqVGCToKbI9TDtg/IN
	mbLn0QI10+H+MD8ZRFtFppVZyW0w6uQSyo65v6DKRyUx0WWwuMkTZxtB6FJA542K/OYJzv
	1AMsk9LE0uk2mjywu0g2L2HVF65dfA2XRHpBCCc3r74/CVkAF8PYZl3VLIOl0g==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8ng3vv7.fsf@xenomai.org> <87edu2dh2j.fsf@xenomai.org>
 <PH1P110MB10505104BB0814A3F46A86BCE2079@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87tu2xbk5k.fsf@xenomai.org> <87cz9kbrkr.fsf@xenomai.org>
 <PH1P110MB105079B5A344B300F33874E3E2089@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877czothz0.fsf@xenomai.org>
 <BN2P110MB1288677543F1950D08808B3B8F0A9@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10502B0F1F62BFBA1CE3D3EBE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h6yj6mvg.fsf@xenomai.org>
 <PH1P110MB1050D4E123EE6368D98E071AE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <0082bff2d91b0125ac60050159d3003e64b45bffa35e0c4f0ed9799e38b97b8c@mu>
 <87h6ygwi2l.fsf@xenomai.org> <875yevw5ln.fsf@xenomai.org>
 <PH1P110MB1050DA6B7C1C21B2866038CCE2149@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <871qpiw3zd.fsf@xenomai.org>
 <PH1P110MB105039710BB301C7126FF2D9E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87wn797rj3.fsf@xenomai.org> <87sfhx7qta.fsf@xenomai.org>
 <PH1P110MB10508B8825B0DFE55BCC0FBDE2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>, Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Sat, 03 Dec 2022 12:37:16 +0100
In-reply-to: <PH1P110MB10508B8825B0DFE55BCC0FBDE2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87zgc4hg5n.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> I enabled all the ftrace stuff recommended by the wiki page, ran my test
> app, and the system ended up getting hung so I couldn't get the output of
> the ftrace.. I got a ton of kernel splat.
>
> Thanks,
>
> Russell
>
> [2. text/plain; ftrace_1.txt]...
>
> [[End of S/MIME Signed Part]]

Fixed in next branch.

-- 
Philippe.
