Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211231382
	for <xenomai@lists.linux.dev>; Sat, 19 Nov 2022 16:44:41 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 3569EE0002;
	Sat, 19 Nov 2022 16:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668876279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CERMSKD+ioWZ1Q7VHgq0Oaif8ny5WxYlU7hOIH7wpk0=;
	b=JnCwM+R2UWKsxNCTCKNH3ao1XbYhshrIUo98mfNfbC+ombP/CLE+buWKLp6d9CaLTwTXmS
	YEUzLH68ZeWyrs6EnJw/IFplR41u+KmB1rVY2utzxrVdXHTVMytaBKZA+dmpkMwC83kXN1
	/lzV8ppvy67hbZBXmalPXkUQjT9LPLCJbJyuWj9gXNMq6Hl/h9xgLX8yoMoqsIM65tWT0N
	sB+x/pXgYzHI6PuShIfOD6VajHwEV77Uf1SY7l4kV/02tinY69dOhfkcU+XJaCUHSqW7NH
	54RpYoFG/4yxjsf/w2kxYo/SVIeWLlVWNd39pkragdTgerGsstSrALR7mooJNQ==
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
Date: Sat, 19 Nov 2022 17:42:00 +0100
In-reply-to: <PH1P110MB105079B5A344B300F33874E3E2089@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <878rk6dhca.fsf@xenomai.org>
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

This is something going on into the core due to the scalable PI
implementation for mutexes. Please pull commit 8390add2f7 from the -next
branch, it adds a couple of debug assertions which should trigger when
the issue arises (expect a kernel splat if so).

-- 
Philippe.
