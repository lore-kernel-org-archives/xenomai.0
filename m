Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0EE1841
	for <xenomai@lists.linux.dev>; Tue, 15 Nov 2022 09:09:16 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 7BAAA240012;
	Tue, 15 Nov 2022 09:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668503354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nnXqXXGF63bMo0WZzKVo6JmCX+9hT+JXy6hiTw5WL3w=;
	b=lSTieZdq7MsY63Dzqg3bXtwsIo0lsLLYBEA4OhTHCyvI/unV7ZsF7GjVIrDx8PLmwiWezw
	3IwJO291ZA9JYvNRVNBJjOoa1tlJ6NB5nlOZPmUw/K9LsP+CBybcAMdPbZ/9S44ea2Aj72
	F7oPEZCXyRS2cRMNPB0ULtnU29AEP2/gScDCLVtwzq1xGbVaLZ+Z2t3L2bMVSBEH1q5TdJ
	XivD0nz4oKD+TbtHTe660aw9eO2LZaFegVeAguuIF7bgzfTXtqm9REYgYmWDuAr1v3s3RE
	x3ziEEVotHAFO69UyF///qNqWjxpg4K0r8qxa2Wt839JQQz2AeQbsSkPeFTJbg==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87leodn9kv.fsf@xenomai.org>
 <PH1P110MB105002FA12DD4C10060A7B59E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Tue, 15 Nov 2022 09:33:35 +0100
In-reply-to: <PH1P110MB105002FA12DD4C10060A7B59E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87zgcs4ma1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Hi Russell,

Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hi Philippe,
>
> I went ahead and tested out your changes on the "next" branch. Looks like it
> runs better (so definitely progress), but it still hangs eventually. I
> have

How long does it take to hit this bug?

> attached the output from
> the debug kernel (a couple runs because the output was different both
> times).
>
> Thanks,
>
> Russell
>
> [2. text/plain; stack_trace_1.txt]...
>

This is the log which has the best information so far. There is a lot of
noise added by multiple subsystems though, could you try reproducing the
issue, but this time with the following kernel options set as mentioned
below?

# CONFIG_FTRACE is off
# CONFIG_KASAN is off
# CONFIG_JUMP_LABEL is off
# CONFIG_EVL_DEBUG_WOLI is off
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_HARD_LOCKS=y
CONFIG_EVL_DEBUG_CORE=y

Thanks,

-- 
Philippe.
