Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084237C
	for <xenomai@lists.linux.dev>; Fri, 18 Nov 2022 08:07:25 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 11386100008;
	Fri, 18 Nov 2022 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668758838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OEGBWtfDJ8De0Erf3dBNAsygI3jJBJz6CsKDMl+CXBQ=;
	b=Myi3A1rRncYIPPOCF1d5gUw7lS/707GbDsFHICzGdG6VVodc7YHMzglBG4jj+WXkhFc03V
	wFloEo4PU8CerZGezkKEBVsuDTucEkMD0VUjbQBL8ohfTr4WgXIWKyViEMyWRAWU+SDS1j
	XJ8SptXQaOVAQO4d1iRJNA4piYr9QzhqNucvjlBSP6mRALNdidNGXFvkfVUewyzUZSD7Zm
	3/k7ww4aLFZUv/pPghBTEGt+Xa2C28tDxDm5fpsCZAyFbWJqXbd9pllxEhHGqaln3V3jWf
	vWUcmo8w9Z6kP/Q1cgRm//oMucbeE21LcObtdEqTJQLyxMfoEKICEvhLBukMNQ==
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
 <PH1P110MB1050175A9DBC1F6E7F4E868DE2069@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Fri, 18 Nov 2022 09:06:47 +0100
In-reply-to: <PH1P110MB1050175A9DBC1F6E7F4E868DE2069@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87h6ywbs97.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> This is actually a fresh clone/build of the EVL kernel which is what makes
> it weird...
>
> [[End of S/MIME Signed Part]]

Any error log produced by your build system would help.

-- 
Philippe.
