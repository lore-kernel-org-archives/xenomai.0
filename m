Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B4259B
	for <xenomai@lists.linux.dev>; Sun,  4 Dec 2022 11:11:11 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E0D6460003;
	Sun,  4 Dec 2022 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1670152269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jO//WSfBr08d0OeUGhC0jYZYh/sO2n/bcue5Ah14+E4=;
	b=APohDJvLIZGlNJ3LHi85VlUqbFNrcDUxEqHImLA41RF5BEnH/9/oTA1wADkoERVycTDfaY
	4LVbM25797nRbcjTxiS7O7qJOiRRoABssVERKKEqQJpVlNbmrRGlZ+iqWAGzSs4ojeUngc
	D+ZrQRVBqwudgeHo5VU8c9apvILCO+MPnQtXq2640zjLvg8OAAvey46GiSmpkdNrQpoDeS
	kXZOa5r5+KePQinSQoAIAZXn0rYzK2CoCjmD3KQnHAKUsGf3x1MBalZH6MQBREms+kATkF
	Lih6pQs11w7cwz9ALpY6O08jsdU7l9f30OVk+YMvy2JC3IWmOf1u+cgptRnSig==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
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
 <87wn797rj3.fsf@xenomai.org>
 <PH1P110MB1050356B939910A6A0406B96E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87cz917m8z.fsf@xenomai.org>
 <PH1P110MB1050E66FF8CC978CF642CDF8E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8mshg4n.fsf@xenomai.org> <87r0xgh4n2.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>, Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Sun, 04 Dec 2022 12:05:10 +0100
In-reply-to: <87r0xgh4n2.fsf@xenomai.org>
Message-ID: <87mt83zano.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

a
Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Russell Johnson <russell.johnson@kratosdefense.com> writes:
>>
>>> [[S/MIME Signed Part:Undecided]]
>>> I added in your patches and rebuilt with lockdep disabled and with ftrace
>>> disabled (since the ftrace seems to be killing the system). I did see a
>>> couple brief kernel splats that I figured I would at least ship your way to
>>> see if they are important.
>>>
>>> Thanks,
>>>
>>> Russell
>>>
>>> [2. text/plain; stack_trace.txt]...
>>>
>>> [[End of S/MIME Signed Part]]
>>
>> These warnings relate to the same deboosting bug we have been chasing
>> lately. Still trying to reproduce this here, no luck so far.
>
>
> Please try the current tip of next-evl, which includes this fix [1].
>
> [1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/722ded4782f949e95e36ffad248a8f63c6446c4c

This patch is ironing an important code path, but I just managed to
reproduce a deboosting issue for the first time. I would suggest to wait
until I can issue a patch fixing it before testing the next-evl branch.

-- 
Philippe.
