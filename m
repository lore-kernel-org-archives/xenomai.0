Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ECB171C4
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 18:08:44 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 436A5D5EEC
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 17:24:36 +0000 (UTC)
X-GND-Sasl: rpm@xenomai.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1685553870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2f6fYuHT0sd7BbfIY+8jSi7Kv7R2+Ln5ADl2Ae9Gs24=;
	b=kCc5qTWKTb3DtYx9u8wmRqvQoAI3XS8lxbmFphG/WL5G+JYl5u6d3o8NLO1UvdFzEFlcHI
	4yqMKm7u0Mrccx+XzldNQOutCbuFhA2xuTz3anPfrhb7Vyp64J4D6yxnORTGZzlMOYOdQf
	WFJPhdcbiZb1H95nbnIXyRNeWRFJ/2hN2wN0WdRiG0U2XalTcol1qyKzrA9xHjP3A9OpCy
	jRZHR0PPiyKUriRvsdE3I1ntVjxubVd6jdBvsc7WCGNBocoqQsof/45kiwlSLIwnz58Qo9
	M6Yc4mLvgL5Txqi2Kp8efIODZm/uGt6hIOE50EOAOdxCmpJciommV4dM8i7x6w==
X-GND-Sasl: rpm@xenomai.org
X-GND-Sasl: rpm@xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id F103E1BF205;
	Wed, 31 May 2023 17:24:29 +0000 (UTC)
References: <e5624d226deb4a49bbe28867e15eadf9@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
 <87jzwpxa8l.fsf@xenomai.org>
 <eb4b2a7608bf4cb1b16c75b07d095602@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Dave Rolenc <Dave.Rolenc@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Russell Johnson
 <russell.johnson@kratosdefense.com>
Subject: Re: [PATCH 0/1] rwsem_down_write_slowpath check if oob() before
 skipping schedule()
Date: Wed, 31 May 2023 18:55:57 +0200
In-reply-to: <eb4b2a7608bf4cb1b16c75b07d095602@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <877csoxvle.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Dave Rolenc <Dave.Rolenc@kratosdefense.com> writes:

>> What's even worse and the root cause of that issue is that no task on
>> the oob stage should ever run rwsem_down_write_slowpath() in the first
>> place.
>

[snip]

>
> Assuming you're correct that this code never runs out of band,  that
> just means that the schedule call will never get skipped by the goto as
> the running_oob() always returns false. The important part I observed is
> that if that goto trylock_again gets hit the task never gets out of that
> loop. If we make it so the schedule() chunk never gets skipped, things
> work fine.
>
> Empirical evidence shows that never skipping that schedule() call makes
> the problem go away. My test scenario, which is way too involved to
> package up for you and involves custom hardware, will run a couple hours
> max before getting a stuck CPU. With the patch it ran over 4 days
> without issue. Assuming running_oob always returns false, the code
> should be roughly equivalent to commenting out the lines as I did in my
> first attempt. My first attempt at commenting out the lines also worked
> fine for over 24 hours.  I wish I had more of a definitive answer to the
> other task involved, but the stack traces didn't really help there. Not
> having a fully working kernel debugger kind of limited what I could see,
> so I had to sample stack traces and figure out which code path it was
> taking by piecing together the information I had.
>
> I can definitely run your suggested test with the WARN_ONCE if you
> really want, but I don't think the cause is some oob context running
> this code. It was just my misunderstanding that this code could run in
> oob coupled with my desire to not delete those lines if at all possible.
>

Ok, got it. Adding running_oob() which should always evaluate to false
only prevents the code from spinning, papering over the issue. Replacing
running_oob() by dovetailing() would achieve the same purpose. If so, my
patch does not bring anything valuable. Besides, if the Dovetail debug
is compiled in, a bad (oob) context running strictly in-band code would
most certainly have caused some existing assertions to trigger anyway.

> Do you have any thoughts on how to proceed?
>

First thing would be to enable CONFIG_DEBUG_RWSEMS and re-run an
overnight test without any patch in, hoping for the native debug
infrastructure to give us some hint.

-- 
Philippe.
