Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EBF18F
	for <xenomai@lists.linux.dev>; Thu, 14 Jul 2022 08:31:58 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id DA3251C0002;
	Thu, 14 Jul 2022 08:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1657787511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lQX/9dhhVfqsOWKjQEAhMX2b+PHXMNX+NMGAaa44H0=;
	b=lyPBT0mIF6Hn93/sNjHLqsZ/ytBTyXcz7ScgfYZV/TuVkBVysILbHklrnteq/dFWDvbdq8
	xcT8zpD49gU51Mu4qXDwXwIJtJJnsnIPsEidlgnNbyyP23E0tJBNf8nGOWVd0tGpI4+ihj
	evX9jfaVMjxnZ9J3m8acueqq2RD4A/bUXUrDnqKJUTTIz3zjURc6TaCXI0AaxLdue10G5R
	EYCkD17vkuXKECqiQrr0Ftk0SnIv8aOQRXVkA1UncfVYSJgtyWpCerEMR+RbvNgGuKLV8X
	tTOhvr8cZD/gD6CdFMvP3pSSRHhfsRdn+m+6VI7p5SwViu69/qXD/6CWEokYrw==
References: <PH1P110MB1050DA45ACEDB22C7EFA31C0E2839@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: More details on health monitoring notifications
Date: Thu, 14 Jul 2022 10:19:41 +0200
In-reply-to: <PH1P110MB1050DA45ACEDB22C7EFA31C0E2839@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87bktsdrih.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Correct, it is running on x86. I am not sure what would be causing a page 
>
> fault in the EVL threads as I figured the mlockall call by evl_init would take 
>
> care of preventing that from happening.
>

We may have a clue by knowing which type of memory is being referred
to.

- Did you trace the offending access using gdb, is it regular memory?

- Does your application fork() in any way prior to running into this
  issue?

>  
>
> I have tried to run the app with gdb (used to work fine pre-EVL), but now I 
>

Which previous environment was this? Xenomai 3.x + I-pipe?

> get all sorts off exceptions and error codes when trying to run in the 
>
> debugger. I quite frequently see EPERM issues with evl mutex unlock/lock (even 
>
> though it works fine when not run through a debugger). Also, when I swap the 
>
> thread mode flag from T_HMOBS to T_HMSIG and run in the debugger, I get a 
>
> "11776 CPU time limit exceeded (core dumped)" error on the create call for an 
>
> evl event in one of my threads.
> I am not sure why I am seeing such different 
>
> behavior in the debugger versus the normal run when it comes to the evl API 
>
> calls. Any ideas?
>

SIGXCPU is an alias of SIGDEBUG, the signal the EVL core uses to warn
you about something wrong in general. e.g. if CONFIG_EVL_DEBUG_WOLI is
set in the kernel configuration and the application is doing something
wrong wrt mutex-based locking patterns, the core would notify it using
SIGDEBUG. The causes are described for the T_WOLI bit at [1]. The core
might also issue SIGDEBUG when the watchdog triggers for the current
thread (CONFIG_EVL_WATCHDOG).

[1] https://evlproject.org/core/user-api/thread/#health-monitoring

-- 
Philippe.
