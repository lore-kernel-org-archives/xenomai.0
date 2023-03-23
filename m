Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45BA950
	for <xenomai@lists.linux.dev>; Thu, 23 Mar 2023 17:20:43 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id BB9CE20004;
	Thu, 23 Mar 2023 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1679592036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4k1RlOdM4Yqj6sqB4jL31WvTWJcMnWpZTVIaHzUSS7g=;
	b=iMyWGbi+gGdUsuwWkj5apUT4DubvjwyxOM6wGapT1VVo+jHcfXM46bS/PZUekq9FrpC2xg
	6VVJsVvMnEpUjeQdQ/oHpKnR/r/aVQXK+oNifBquX3Wc3IXrIxu1dB9XQLwqA721lUjC+o
	yBypJiBI/baykfU5adGZEvAvKbN04/mRoscj3XQQrNrM2lTzhFQhZvSn5RhEpYsmgS8P3O
	mnBuknzmLwpfNDLh6j6WwsPcSdh9YaSL7JArC09pqRubWbU11/RGhqVim1lCyrFV9clB1U
	u+MkHGtB61yRRHnq3j6H3C+aaDuqDLueclrnoxEOm8Zu5ZP/09HxUa3fddEtAw==
References: <PH1P110MB105092F3657F368FA123D4A5E2879@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Issue with evl_wait_event on startup
Date: Thu, 23 Mar 2023 18:03:36 +0100
In-reply-to: <PH1P110MB105092F3657F368FA123D4A5E2879@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87wn37bd0d.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Sometimes on startup of my EVL application, I get an EIDRM error returned from a evl_wait_event call. When this happens, we create a new
> event to replace the old invalid one. Then any successive calls to evl_wait_event seem to return EPERM.. First of all, what could be causing the
> EIDRM error? Is creating a new event the correct solution when you receive that error? And why would I be getting EPERM after creating a new
> event?
>

Normally, this would mean that something along these lines happens:

[Ta]  ret = evl_timedwait_event(&event, ...)
      <...blocks...>

[Tb]  evl_close_event(&event)
      <unblock Ta>

[Ta]  <resumes>
      ret = -EIDRM


The alternative explanation would be that I screwed up something,
somewhere.

Receiving -EPERM next is likely a consequence of the first issue, maybe
some bad mutex state, assuming the caller did not detach itself from the
core.

At any rate, we are not expected to receive EIDRM under normal
circumstances, so re-creating the event when this happens is only
papering over the issue. Could you reproduce it in a simple test case?

-- 
Philippe.
