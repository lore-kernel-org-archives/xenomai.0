Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5063C0
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 16:10:29 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id E9A45C6C4D
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 15:58:04 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 661391C0004;
	Wed, 30 Nov 2022 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1669823877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GGC50BHgL/x0liIIwE0vvYplJJKpyXTKPrO/h40NILU=;
	b=S4O1IKNwWooN94BVG7/z4/2wSZcwTNa6JQelSzgUXvn7W2WaYt2ZqT1pTZVHQPs9Gxp5cS
	LWbf6RtQv12CdJhZIoSoUk8ZRwdYE3RYGbuJwJ3xZ3T0deWL/Tkigy0//84wuO27R4gSD1
	urFTY5bbqTp8oONOwgLDwp/avYhJraDsx2GAWJ530KTPyeApf4oMua7naUXIsAGePNno5R
	N9PtEfgzuhOOBJUwGUuatZWv/db90ZfiwXp8cRGXsrqLepJwxOK72lDJ++J8jpZlTVilrs
	mLHnQ2cw7IBkPCPigWK/LN+N1vjSB5rUXKKqHAA0I/USTQJcRDzWtiAheuHzrw==
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
 <877czothz0.fsf@xenomai.org>
 <BN2P110MB1288677543F1950D08808B3B8F0A9@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10502B0F1F62BFBA1CE3D3EBE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h6yj6mvg.fsf@xenomai.org>
 <PH1P110MB1050D4E123EE6368D98E071AE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <0082bff2d91b0125ac60050159d3003e64b45bffa35e0c4f0ed9799e38b97b8c@mu>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>, Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Wed, 30 Nov 2022 16:57:40 +0100
In-reply-to: <0082bff2d91b0125ac60050159d3003e64b45bffa35e0c4f0ed9799e38b97b8c@mu>
Message-ID: <87h6ygwi2l.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Russell Johnson <russell.johnson@kratosdefense.com> writes:
>
>> [[S/MIME Signed Part:Undecided]]
>> Sounds good. I built the latest kernel (with lock debugging re-enabled). I
>> am running our test case as we speak. I have not encountered a crash yet,
>> but there was a little bit of debug output from the kernel that I have
>> attached in this email. Also, I am definitely still seeing a lot of the
>> threads be priority boosted forever. Let me know if you can think of other
>> ways to help debug that priority issue.
>>
>>
>

Working on it.

-- 
Philippe.
