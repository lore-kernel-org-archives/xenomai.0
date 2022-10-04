Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5C3D8A
	for <xenomai@lists.linux.dev>; Tue,  4 Oct 2022 16:01:21 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 5C15CE0013;
	Tue,  4 Oct 2022 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1664899272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebYj1LaJLYLsUldO414tP3ASNSLxooknrCNX1K/kGqE=;
	b=g2Mh3AbVLvP3gkGJtio8I3HvGTHxCjU+ZnQRJ0ZuU1DI/VznYoQdrCP8D1r/r2piBbWLeD
	8xr/WhGNie7xrtgVEAg8KhASXcxsZcL/ldEBFlm7el9hVuNSH45fGoCPYa13i6g3EU2zHB
	ob73kCLX9bFGWfMhS1Py5t62/jxjQJjgA+4IE0QqNzvEXC4W9KAs5M0aqN/CabDw71eanp
	1lutNp3BO9NmYhCT6u8t/XftwGDPaxUwqTCyj71gvq2Fdc9BwLqWIGilb5KpjDyE3JDUY4
	WGChaLMBCjiyzkUdDFj5trZl2zQhQdPIulAaPdmCU3+VTH9yhmHa9VVKkfQ2Ag==
References: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h70r7r0m.fsf@xenomai.org>
 <PH1P110MB1050C74BE6BB64AD707616BAE2549@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87r0zu7j6i.fsf@xenomai.org>
 <PH1P110MB1050EC5BE3C92F3A71EB8855E2599@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: [External] - Re: System hanging when using condition variables
Date: Tue, 04 Oct 2022 17:50:20 +0200
In-reply-to: <PH1P110MB1050EC5BE3C92F3A71EB8855E2599@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87fsg38to9.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Let me know if there is any additional information I can provide on this
> matter. I am a bit stuck at the moment due to this issue. Any ideas would be
> great! As always, I appreciate the help.
>
>

I can reproduce similar issues. The locking strategy in this particular
area needs more work, now that I have fully enabled the kernel lock
validator for EVL thread and mutex locks, the bug reports I get make
this obvious. Fixing this is on top of my stack ATM, work is ongoing
(tricky stuff which requires extra caution, so this won't happen
overnight though).

-- 
Philippe.
