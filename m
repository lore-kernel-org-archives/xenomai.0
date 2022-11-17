Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA38BE0
	for <xenomai@lists.linux.dev>; Thu, 17 Nov 2022 17:05:15 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 949E624000E;
	Thu, 17 Nov 2022 17:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668704714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqm52XkCaf1g88TSOWnVNyvz5l1QBXMFGfFS3BeLBgc=;
	b=ObtQU3+FL/J3SC4uvrxR91IZPlTgY6gxL72PpXyG3zbW3OvG+zbpSQzvJsOV3oVBi/9kVT
	odWAKqZFcfX+EEA3MnQgXS1hzcAOQ8CVPyCQgTNUFpP+8eB59odZwjdLx//7xAIau/aLZO
	Ld0fiLXZlZkuPHEcJrkBirwffijhzlxPR4G6dtXEGmNYiprBGMyYymLUOmvzVdLJMe3PZ9
	d0wpmW7u4078ShERpy6NwTcP2bAtjhhc3foos6t1mC8QTzQtHpr7u7pWu/tCQVjWCYt8Ek
	XP96GYubvhMGcJ9gKSBEHqtTA/qV/7Klh9tN6/GdmNdPtbRApCYlxnYsPkbSXw==
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
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Thu, 17 Nov 2022 18:03:50 +0100
In-reply-to: <PH1P110MB10501A307D34D09C49EEBB74E2069@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87pmdlbjg7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Will do. I am currently fighting a weird build issue since pulling the
> latest commit of the kernel. I can try to build on a different system next. 
>
> AR      drivers/built-in.a
> error: Bad exit status from /var/tmp/rpm-tmp.2BRlM1 (%build)
>

Patching issue? If you apply the EVL patch series on top of a different
kernel they are based on, maybe some conflicts have appeared with the
latest release, causing make-pkg to break.

> I typically run "make rpm-pkg" so that I can install the built kernel on
> other systems. I am going to assume the issue is on my end for now... Will
> let you know what I find once I can get this to build.
>
> Thanks,
>
> Russell
>
> [[End of S/MIME Signed Part]]


-- 
Philippe.
