Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE7363
	for <xenomai@lists.linux.dev>; Sun, 20 Nov 2022 08:30:12 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 32C981C0004;
	Sun, 20 Nov 2022 08:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668933004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJRHh/bHj+0x0PTdk2oSEUV6lNizOoOx7fKpzI86sg8=;
	b=ZGLQcpyuPJs47DyB7E6Knt/+pRKr2W83JqTbaB0My0LQq19jv0VbhwUAqzImwOcCGtqJ20
	Sdhzi6QO5TmFD8RNd27NnWeZ01b0IWfO0JAN63qofLRpAXXePJYCxKvGf9TASuiG8oI7Oq
	Kv96xxTxUwzU3L2uH7avLN8GupwVNL+d0uhJ9Q7cFHXS9Rdms7bCsxUIDqfYAhFySLqVVi
	OBV7mGgKRN2ehNrnKrdBex0bGs3ZjgECfGFCMF99JvYOcRU9anS2VTyqzaDUo9GTeu/qVw
	IbwrnDk/aud/utigDLWcFzvilNwgBQhnFUopE8448zmUCMiqb7eCO2XvUJLXQg==
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
 <878rk6dhca.fsf@xenomai.org>
 <PH1P110MB105043E3D11444BACF142AB6E2089@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Sun, 20 Nov 2022 09:25:52 +0100
In-reply-to: <PH1P110MB105043E3D11444BACF142AB6E2089@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87leo6owol.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> I just tried to run the app with the latest "next" branch, and it didn't
> make it long at all before I got a ton of dump in netconsole. But the
> messages look very strange to me. A lot of "printk messages dropped"...
> Thoughts?
>

Confirmed, this is the bug I'm chasing ATM, there is an assertion which
triggers in the core, so frequently that the system enters a tight loop
only issuing and (re-)producing it again and again. I discovered it by
artificially slowing down the kernel side, otherwise my board would
simply lockup with no message.

-- 
Philippe.
