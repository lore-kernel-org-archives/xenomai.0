Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BF580F
	for <xenomai@lists.linux.dev>; Thu,  5 Jan 2023 07:54:01 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 61337240008;
	Thu,  5 Jan 2023 07:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1672905234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUkMnJogoSGnApVXvgPMppicx6W6ZRbYPMyaaEmE+Rs=;
	b=WaD7EWcAKXff4/JXamT79MgFQSJDnp3WQvo0a4oOP1WKUUIwC80o/yRxmF97JVR9lw9Fml
	/4P/cERVq+f3Orxk2SbRwjbijuhJ4waxffRs5DVuZgGzdqDpRwRO3ybaspnJScOHjCMSVr
	G7Woi/jmLTrYziKexO4VC224ex2kgrm+aZ+AyccR9TM96peTddD/c09pnOWU+K2/8mUk1i
	XKp83poGAA917yDZsWxtyuHaFS4tGGxKT93NO55cfNUlAXNZgatAHjCs1Gi/+AHYoPkNp9
	gQUDbGtv43jvigGUR7xRb3yRWXEC43Ui4wT5ss5SlSm2ZE9h10Vgi+urO8OIMA==
References: <PH1P110MB105032AE6426F4599E6A080CE2F59@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>
Subject: Re: Conflicting EVL Processing Loops
Date: Thu, 05 Jan 2023 08:49:32 +0100
In-reply-to: <PH1P110MB105032AE6426F4599E6A080CE2F59@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87k021s9gw.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hello,
>
> We have two independent processing loops, each consisting of their own set
> of EVL threads and interrupts. Each loop completes its processing and then
> performs an evl_sleep_until to delay until the next processing deadline
> occurs. If we run either loop by itself, everything is fine, and our timing
> margins are met. However, if we try to run both simultaneously, the timing
> error is increased significantly, and the loops never meet their processing
> deadlines. If we compile the code for Linux (substituting all EVL primitives
> with Linux equivalents), then we are able to run both loops simultaneously
> without issue. Any clue what could be causing us troubles or where to start
> looking?
>

In absence of any code to review, the question is too broad to figure
out what might happen. Quick check though: make sure to disable all the
kernel debug options which may be turned on for your EVL kernel
(PROVE_LOCKING, DEBUG_LIST, KASAN and others). evl check may help with
this.

-- 
Philippe.
