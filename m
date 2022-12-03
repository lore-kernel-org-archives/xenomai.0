Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76E2568
	for <xenomai@lists.linux.dev>; Sat,  3 Dec 2022 11:56:14 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 77D96D5C26
	for <xenomai@lists.linux.dev>; Sat,  3 Dec 2022 11:38:10 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 20BC160004;
	Sat,  3 Dec 2022 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1670067481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7huHJ7oMvSy9/GrHpCn/yN5ZFv3PDfjoubkFzVEJ7HI=;
	b=ik8YxylMjJLCiiFMg6nqI6yeZjPMPNocLOpy441KLaEwRBM68wvpunov/oK9J9T7SbwjK5
	caqMNbXjCLxfRzlZI4z25jvkBbjFHNH+g0BZVuN7rZSmA3cPrw89gtJi4Q1lEnG5UfDb2y
	Ia0vyAwjh/6EqzdO9IJ4RuFQpjPGvbHNnXhsf7/CLnDfmtyzCjTphgyxFzkxYC93qk11lu
	7AXB+msvst+dHu3pzP69QTn8OTxZ39t8yDk7kTvLnI7ez3JZwuGRQ0Oi1osozM4G7lxOj0
	gLFnEW+TqaKwralxejzAI7F5mkjEn91iE0fM4FygJPnzI8zoK8W9EMSBnmbSVw==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87edu2dh2j.fsf@xenomai.org>
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
 <87cz917m8z.fsf@xenomai.org>
 <PH1P110MB1050E66FF8CC978CF642CDF8E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>, Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Sat, 03 Dec 2022 12:37:31 +0100
In-reply-to: <PH1P110MB1050E66FF8CC978CF642CDF8E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87v8mshg4n.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> I added in your patches and rebuilt with lockdep disabled and with ftrace
> disabled (since the ftrace seems to be killing the system). I did see a
> couple brief kernel splats that I figured I would at least ship your way to
> see if they are important.
>
> Thanks,
>
> Russell
>
> [2. text/plain; stack_trace.txt]...
>
> [[End of S/MIME Signed Part]]

These warnings relate to the same deboosting bug we have been chasing
lately. Still trying to reproduce this here, no luck so far.

-- 
Philippe.
