Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D180A8BE0
	for <xenomai@lists.linux.dev>; Thu, 17 Nov 2022 17:05:59 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 2A116CFE37
	for <xenomai@lists.linux.dev>; Thu, 17 Nov 2022 16:50:08 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id B66BA1BF208;
	Thu, 17 Nov 2022 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668703800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00eVWco9cljIoEaGURoVlb0S4xe864T+e3VTg7i4Q5s=;
	b=SztQrgWFzeb5Z96MR5YG3eMjhEv0pfqy2pA/c3aG3A72vm2mBsssGUqVlQe9A71muhG2vB
	lDcYba9Mz7dw7cSXuKzFbSC7Y7z8vcFoMZ7x3Z1kM9O7S43NKfjNvRov0o/RwhsAvlQjyU
	0Dw5EyjNDFbgjCN4yKnpx6NuEf/sPy4E6N/apjAd9oGKwIUiTzj2afDCs9VZ00Z5FpMOdN
	4f4kNDMFBeyrMzYoMLyfC+q97nzkje9vtQzg/ftC+5pDhsCEsZ9tjZLBKM2uqLvN+3FcIN
	kv8cX/Lx+9+8E3fgGiPzNTUrZA3qoQRWQlRVpAy7RXmR+xAZ8th72eGSalr28Q==
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
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Thu, 17 Nov 2022 17:48:16 +0100
In-reply-to: <PH1P110MB10505104BB0814A3F46A86BCE2079@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87tu2xbk5k.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Sounds good. Just let me know when you want me to test, and I will pull your
> latest.
>
>

Please try the -next branch, commit #b295ac3ad51b so that we can get a
fresh status with the latest updates, and hopefully better trace dumps
if an issue arises.

Thanks,

-- 
Philippe.
