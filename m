Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC17C
	for <xenomai@lists.linux.dev>; Fri, 18 Nov 2022 08:06:40 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id AFE291BF206;
	Fri, 18 Nov 2022 08:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668758798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JY8z6vujZbB84LeuYaduuWMOb9Jo56NlwmwzmvQckJI=;
	b=YQ9vgOO3fQLiaBqqscCcF2wMuVTXJOjBwKzUF7m3sTDRjXFXX2ChZYdTG+vpH2NTK1jsdm
	hxp6sEdxHq3Te2tVjgHXaOwbxdcpS0nDSC7ux9FFVno7YmBkvTTrBd69sKVrhQ197t+9pa
	X9EqpTyVfutVej8ntTeJH43HQfOl9Xz3b9mdTvPzIC9VdBFmiOWnu1irggi52IxHle5Tzq
	bnfw+KY3F/Zhf7ra3pPYvhwtZXE1DH8CvHeYW05lgY4yCV+/ytyzCwpB4eu+r5S3maj2VU
	GRDFCRki174lLiJ4+HwSBmRgwrjd7ykPG3YXiylaic40bwc9tW9gh/vKPVtCWA==
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
 <87tu2xbk5k.fsf@xenomai.org>
 <PH1P110MB10501A307D34D09C49EEBB74E2069@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmdlbjg7.fsf@xenomai.org>
 <PH1P110MB105036766C938742737AC56EE2069@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Fri, 18 Nov 2022 09:02:41 +0100
In-reply-to: <PH1P110MB105036766C938742737AC56EE2069@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87leo8bsab.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> So I can build v5.15.y-evl-rebase just fine on multiple systems (using plain
> make and using make rpm-pkg). I cannot build the latest next-evl-rebase
> branch on any of my systems (using plain make and using make rpm-pkg). There
> must have been something that changed in recent commits.. Any ideas?
>
>

You may have to resolve conflicts between your custom kernel and these
commits which update the RCU code shared with upstream:

402b2c85f52fa rcu: irq_pipeline: deny strict grace periods from out-of-band context
03d19b028241d rcu: irq_pipeline: enable read lock sections from out-of-band context

-- 
Philippe.
