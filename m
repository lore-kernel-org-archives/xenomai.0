Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558C4C89
	for <xenomai@lists.linux.dev>; Fri,  2 Dec 2022 16:52:18 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 1973210000B;
	Fri,  2 Dec 2022 16:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1669999931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7hQs5EA3KMEjRRAiun7tfW0imfaEQAuXyxAWvxFFsc=;
	b=om4UjRFQ3utKGV7CJhHv4EYyozpux1gBDuNG/5n/F1GPYVZHukDlqUsYxLkdyA/rsXjHOw
	erAWZP//hkXPEwg3/IUS7LPv7u1uwDXEcH1zI1EUxa0DoovjS5AEhqr/o8GNNzArtDtxny
	Wz2Qn3yRIgEkGZRivZgoSp7rcbdw9Rif6jy2HBt4FBxE7D77ugqgGu0hHct9azodXWu2AJ
	WYiCgRs8YfMz3fM4dKdErgbWSiuDmT71Fu19FGU7phe20dWdzBa/2u68+mriFN8zFRlwO6
	TH4+PkJMMFD+Ob8T2pC8XXZV8mKluDvelpcxykQEduojGDza4mq2nvDcdvD6CA==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
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
 <87wn797rj3.fsf@xenomai.org>
 <PH1P110MB1050356B939910A6A0406B96E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>, Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Fri, 02 Dec 2022 17:50:54 +0100
In-reply-to: <PH1P110MB1050356B939910A6A0406B96E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87lenp7npi.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Yes I have confirmed that the threads are stuck with boosted priority in
> "evl ps". I just went to re-run again with the
> kernel I used yesterday (with lockdep still enabled) - since the other
> kernel is still building - and I actually got a crash and some memory output
> from kasan. I attached the output.
>
> I just saw your new email - I will look into that as well.
>
> Thanks,
>
> Russell
>
> [2. text/plain; null_ptr.txt]...
>
> [[End of S/MIME Signed Part]]

Ok, the crash in evl_requeue_mutex_wait() visible in this log gives some
hint. I cannot reproduce this though, so this must be a very specific
pattern.

-- 
Philippe.
