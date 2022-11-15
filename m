Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992EF8AA7
	for <xenomai@lists.linux.dev>; Tue, 15 Nov 2022 19:14:37 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 5A2B6CE01A
	for <xenomai@lists.linux.dev>; Tue, 15 Nov 2022 18:39:50 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 264B61C0005;
	Tue, 15 Nov 2022 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668537581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2pTQU5jWYQXhjCMEnURQ42ey88+JhO0Os9y//Dsh72E=;
	b=maqxzeVnNPCk01V8yna6M8JX4M8CI+jiUE6ZAl9JlLCgcSaZ9hfwOGflz9Jo+hB4v8dWfX
	Ktq74OGfPbU63ILIyoE6P6buHy6POw5XX180QPP2GsJKHezxC8cTLmbiovjSrN3m07Qkqx
	xE70+FST87yZ0iEaKmjMR78dI17wKNxMJI2cW8ISQKGdpaYYTkfH5OAtbRPWCBEScwyx5g
	IC8WnQ8iM9hOd9/nrtuuwB2tS9YXwW7EAZZIrm2ubhzjTsnwcl8oi7gKtnEIafteWfXf67
	FqwxnxsCn4AvVNfOh5eMgdfop+mr9k3h18sRI3gQNcwDoaAxAbaXoKSDE2px+Q==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87leodn9kv.fsf@xenomai.org>
 <PH1P110MB105002FA12DD4C10060A7B59E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87zgcs4ma1.fsf@xenomai.org>
 <PH1P110MB10500F942C9666D27F48E154E2049@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Tue, 15 Nov 2022 19:36:31 +0100
In-reply-to: <PH1P110MB10500F942C9666D27F48E154E2049@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87v8ng3vv7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Sometimes I saw this issue in seconds/minutes. However, I did just see it
> run over night on one system, and it hasn't died yet. I did see one kernel
> splat from that run though, so I attached it here.

Ok, this splat is a false positive from an assertion which should have
been removed now that the PI walk is preemptible. The case it complains
about is valid, I'll push a fix to address this tomorrow.

> I am building the kernel
> with the parameters you recommended to turn off as we speak. I will share
> with you what I see once I get it installed and running.
>

Thanks,

-- 
Philippe.
