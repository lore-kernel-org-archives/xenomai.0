Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569533D9C
	for <xenomai@lists.linux.dev>; Fri, 29 Jul 2022 13:11:11 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 57D48CB93D
	for <xenomai@lists.linux.dev>; Fri, 29 Jul 2022 12:59:47 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id A4E8020003;
	Fri, 29 Jul 2022 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1659099578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAeVEyU+j2NesFS82UMdER+B0hJxBv8AfhYW9ZUSVUQ=;
	b=irqwvI12hzE4TZ49RYzURGAg/BCJyYPOlqskQOny+7ezMQ31XdHxTZ82H7El1Rg/FuKUQ/
	yqO4YkH4YJyWT8jHCSFVYiSv2f2Du/ywOd7pyhZqcv47Swq/+OUP/YITcislxRErdOvf7N
	vHxt4r8UO6KlLKzs8j67+l9DkUTMLnIjxBh+AuDjgohKoMTlC1ZNt+q3e/lPytN8Exsvk4
	MOc014nSc6T+G8smX79D+GUeacjVWrnWw/o1/NmcwJxErlJJiGqKcYavqDv0JYgOJjhMxK
	XzIrtvIuvLqi8FMGPovDzkbEPlOrAGvU+7gBKv1zdH5M1tjwuzFkuE/Ml7nypw==
References: <PH1P110MB10504D2EE4A93A220F7F0946E2969@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: EVL Heap
Date: Fri, 29 Jul 2022 14:48:53 +0200
In-reply-to: <PH1P110MB10504D2EE4A93A220F7F0946E2969@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87ilngjcqt.fsf@xenomai.org>
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
>  
>
> From what I understand about the EVL Heap, only EVL threads should be accessing it in order to allocate and free memory (along with some
> other operations). At the very least because those functions use an EVL mutex behind the scenes which you definitely need to be an EVL
> thread to use. At the moment, I noticed that at least in the evl_alloc_block and evl_free_block functions in libevl, the return value of the
> lock/unlock calls on the EVL heap is not checked. So technically you could have a non-EVL thread call alloc or free and appear to work (even
> though the mutex lock/unlock fails). Is it worth catching the error codes from the lock/unlock calls in those functions and setting errno or
> erroring in some way so that the user knows exactly what the problem is (mutex failed due to not being an EVL thread)? I am assuming there
> was probably a reason for not doing this, but I was just curious. 
>

There was no reason aside of sloppiness. In fact, we should check
evl_lock_mutex(), we may assume unlock is going to work if locking did,
unless the situation is desperate with a rampant memory corruption at
work or a kernel bug of some sort, in which case we'd be toast anyway
(besides, unlocking happens after the allocation/deallocation has
succeeded, so returning an error code there would be confusing, and
logically wrong).

There may be another aspect to consider: should we leave
locking/unlocking to the caller instead? Originally, I thought that the
heap code would know better about fine grained locking. Now, looking at
the actual code, it looks like only a small lightweight portion of the
code escapes the locked sections, so we could leave locking to the
caller/user, which would also allow the application to define lockless
heaps.

-- 
Philippe.
