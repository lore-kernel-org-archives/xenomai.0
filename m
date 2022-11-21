Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA172A2D
	for <xenomai@lists.linux.dev>; Mon, 21 Nov 2022 16:37:56 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 2631FC78BE
	for <xenomai@lists.linux.dev>; Mon, 21 Nov 2022 16:01:17 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 72300C0006;
	Mon, 21 Nov 2022 16:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1669046469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h2V0EQP5ZZR9CkTnh/2c/ZoO4ZkRUxrd9vBhVC3M1/w=;
	b=DTLCaHhufOMpnqtbVv7IcLzRKjYaPA3N+2QJ3ZVFhAJ78QfXPoYlGcULf+LPLS7EsflXaO
	d8MxleZ/SWWVVit27PWQ4u/Iiu8Zha6/syJDNdE0231OWxXWrZ21c12WDM9bjPzdw3GArl
	ju7HCviAU9WZfZNKEEH+w/D9NCXNnuRWtSrSv6G7n5NNQeB5xs1e6Jk+SXulpZo/xZV7fe
	3uB2/fW6J7KcZWfK1mIS5O15XsGSlQHAFKL3+F+ym2K+HgmLycbpaeENE26TgYrEPVBdG+
	5BJa3PBy7XgnHv7JQtgwHyyLkVZqgWxxep+82BBK6ihfqv724XiP+x2w6f+cAQ==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87leodn9kv.fsf@xenomai.org>
 <PH1P110MB105002FA12DD4C10060A7B59E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87zgcs4ma1.fsf@xenomai.org>
 <PH1P110MB10500F942C9666D27F48E154E2049@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8ng3vv7.fsf@xenomai.org> <87edu2dh2j.fsf@xenomai.org>
 <PH1P110MB10505104BB0814A3F46A86BCE2079@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87tu2xbk5k.fsf@xenomai.org> <87cz9kbrkr.fsf@xenomai.org>
 <PH1P110MB105079B5A344B300F33874E3E2089@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Mon, 21 Nov 2022 16:56:09 +0100
In-reply-to: <PH1P110MB105079B5A344B300F33874E3E2089@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <877czothz0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> After fixing that line of code that was causing errors with building the EVL
> kernel, I was able to successfully build. I am now running our scenario that
> was causing issues previously. I will let you know what issues (if any) I
> run into. 
>
> To your other point, I can confirm that the priorities that are being
> boosted are never being cleared back to the original base priorities.. What
> do you recommend looking at first in order to figure out why this is
> happening?
>

I could not reproduce this PI deboosting issue yet, however I eventually
figured out the reason for the lockup - which may translate to RCU
warnings on your system with many CPUs: this is a Dovetail issue wrt
lockdep support. IOW, the bug is in the lock debug infrastructure,
caused by adding interrupt pipelining to the picture.

You can work around this issue until fixed by disabling PROVE_LOCKING
and LOCKDEP entirely (which is also enabled by DEBUG_LOCK_ALLOC and
DEBUG_WW_MUTEX_SLOWPATH indirectly).

-- 
Philippe.
