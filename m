Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D7846B8
	for <xenomai@lists.linux.dev>; Fri,  2 Dec 2022 15:29:39 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E35F7240013;
	Fri,  2 Dec 2022 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1669994977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dVbxXFGulshpJupeygL73pUsv2lC5WHZhvZVYcuIpIA=;
	b=mTwDXY47Ni/zZd4biSCvFwLQD9mzjqLAWUE10mne30xnmxz5Rn5PpwvLc2/XCRe16dGNPj
	31hrpDfVQrVl3+1zT5B5FdrGjR37uSfOFuoZm2NouDg08FEQtdcYvRHvDfUkgmncYXoflx
	e8bUmKdDSl17wHYbuOb1w4Wq7A+FDOHK+MeUAVbByWhWYD4pVzSzQM3JMjUpOAWsHt+Bgn
	q8NdoTHhlqy/arQCRZHUYSEpJIIRQKcnswlTwTSpymSnK2rElSB6ASDTp3f4Ibhtp/R6D1
	/ls8UCp4r/bgAoglLz7wHCjTaGp468Q1IE06voYD6y94laqYDFnK+8xs0RckXA==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
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
 <871qpiw3zd.fsf@xenomai.org>
 <PH1P110MB105039710BB301C7126FF2D9E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>, Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Fri, 02 Dec 2022 16:27:10 +0100
In-reply-to: <PH1P110MB105039710BB301C7126FF2D9E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87wn797rj3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> I do already have that enabled and have confirmed the proper commit shows up
> in uname. I will disable LOCKDEP and re-run.
>
> Thanks,
>
> Russell
>
> [[End of S/MIME Signed Part]]

I realized that the line information from the kernel splats was matching
the latest sources anyway, so you are definitely running the right
kernel. Can you observe that the threads are indeed stuck with a boosted
priority that never changes, using evl ps?

-- 
Philippe.
