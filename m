Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2568256D
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 10:04:47 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 4A071CD69C
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 09:56:27 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 591FD40004;
	Mon, 14 Nov 2022 09:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668419779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c9GsLcnN3ZhA0MgM47Xxt1KagTrnoAInt+MUK3JUWZ8=;
	b=J0Mqf+wQS+qy5S9lKxm5HgkwlG1ejfwVnwifdaSKEKqmebvW2izjh+QKNjHAtldllgWRaS
	i6JgwFeYHc+XbNBjOx37EMnMLerXjjjvzseWoFmBfJfDd1XRuuX4sFWyk2qQlmJ9Nz/7fE
	qC/ZJgDO8WfZ9lsuM9AWKMqaBIJR4vUqmE21g6kEY7QyfVAv+CWxeGB43ArWMS++ifdhT5
	6bRt332i/tomdpbuytImE5RDgHx+GN/n4I3ScEb3UOxo6pAsSG/eNK7I6pyS1gsMX5D6fB
	bP1PyMWk7ZuZo277V/4ZsmlP66ZdHmyVzbDR4LhzNZy8maEd8dmhHftmwE6kSg==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Mon, 14 Nov 2022 10:53:33 +0100
In-reply-to: <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87leodn9kv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Thanks for the quick responses to our questions, that is very helpful! After 
> more debugging we were able to find an issue on our end that got us farther 
> with the issues I mentioned at the beginning of my previous email. Now, it has 
> evolved into a something else it appears. I ran with the debug kernel and I am 
> getting a ton of kernel splat that seems concerning. The callstacks go all 
> throughout EVL, so I was wondering if you could make anything out of the 
> output.. I also see two "switched inband while holding mutex" notifications 
> from EVL along with a fault notification (grouped together) at regular 
> intervals while running. So I am sure the two are related.. Trying to get a 
> better understanding of which direction to start looking in. Any input helps - 
> thanks!
>

Clearly a bug in the core, which should be fixed in the next-evl-rebase
branch. Please confirm if that works as expected on your end.

Thanks,

-- 
Philippe.
