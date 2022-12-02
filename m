Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4D1C2B
	for <xenomai@lists.linux.dev>; Fri,  2 Dec 2022 09:26:49 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 2574124000B;
	Fri,  2 Dec 2022 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1669973207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWyywMz+2HKeMs5eWJwi8m+RO5NfGmenJTGpCJdqO3s=;
	b=CquIE+7oC0YDCY3+/t3Dzb3O9cOAEDbp1eMnOhRB2Le0gzd6wIOaMYW1UnnQw7PBv9bXxM
	4rw3vU+nguGdc03Ow0Yab7HCwNqO2o9sle84o3q2hwzRkGu13ivvMFxJp2efw6UDaASS4b
	yUCs/KJSeXR1SVnq73RsuGOkH5kEaXN2XHxGtxnYDg9ywNBCOTwTgu2CPfYH/vcEM8SCaJ
	e3VlZR6J3r2zGejlZAZsIS5hKaInrX5QkT3qgpY/JnV9wjB52lViHVikblzxYdoIQ4OmJV
	J56vcNoyeGm78vlCLcNAZWINfQRfbXuPx8NgILlN9K41xnsBJlmhqs5qQAtv/g==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
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
 <87h6ygwi2l.fsf@xenomai.org> <875yevw5ln.fsf@xenomai.org>
 <PH1P110MB1050DA6B7C1C21B2866038CCE2149@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>, Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Fri, 02 Dec 2022 10:18:39 +0100
In-reply-to: <PH1P110MB1050DA6B7C1C21B2866038CCE2149@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <871qpiw3zd.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hi Philippe,
>
> I pulled your latest commit on the "next" branch (5e681f841fc3), I built it
> with the normal debug configuration parameters enabled, and ran my test case
> against it. I appear to be seeing the same behavior as before. No crashing,
> but many threads that are boosted infinitely. I did get a kernel splat
> again; it looks oddly similar to the one I sent previously with the old
> kernel.... Doesn't make much sense to me. I verified I have the latest
> commit checked out and built.
>
> Thanks,
>
> Russell
>
> [2. text/plain; stack_trace_12_1.txt]...
>
> [[End of S/MIME Signed Part]]

Could you enable CONFIG_LOCALVERSION_AUTO, then check that uname reports
the right commit, e.g.?

root@homelab-qemu-x86_64:~# uname -a
Linux homelab-qemu-x86_64 5.15.77-00732-g5e681f841fc3 #9 SMP PREEMPT IRQPIPE Thu Dec 1 15:32:38 CET 2022 x86_64 GNU/Linux
                                         ^^^^^^^^^^^^

Next, I would disable CONFIG_DEBUG_LOCKDEP for now, the first warning in
the series relates to debugging the lockdep infrastructure, which is not
directly related to EVL, I'll address that one later.

-- 
Philippe.
