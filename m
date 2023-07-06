Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CFEA947
	for <xenomai@lists.linux.dev>; Thu,  6 Jul 2023 19:09:48 +0000 (UTC)
X-GND-Sasl: rpm@xenomai.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1688670581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnRzqeddNJmaP3dfPczEGTnfKRFRCQj2mdesHCiXhao=;
	b=KC3OctE/vS3VAZzH0MYZJLqDX1pLDuWDC3K0JRWJi3bsvcMGmWtAS9oPMWvFAhb3sMyP13
	65eYJoRSO9CTlRhHcrqytB4ZInMp+1YyEL8uy2ZsMOMtaYzwhNMnQSkOmJVg8kbF9wAUFB
	dU5ThENKcStsQBitL/Z4fG10jZ0trh6MijwiZh5RkXKkOaZo5eGvqCNCjizTaEvpQj+05W
	NxXZnBakZy89wB5QhMP5RGmOcpprahBhorbIioqIm/mzH/R2yuxOWET07CZkBp7sXQ50l3
	SODGDe0HwS2JVfxRwgkzFiZu/rbpyd5pOFPPYh5UxdJDLQw0RbvGuN5a631Dlw==
X-GND-Sasl: rpm@xenomai.org
X-GND-Sasl: rpm@xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC07D1BF207;
	Thu,  6 Jul 2023 19:09:40 +0000 (UTC)
References: <a022bab1-7fbb-3b71-3eb3-e16791f3c2be@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: v6.1.y-dovetail-rebase
Date: Thu, 06 Jul 2023 21:00:00 +0200
In-reply-to: <a022bab1-7fbb-3b71-3eb3-e16791f3c2be@siemens.com>
Message-ID: <87edlkeu1b.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Hi,

Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> quick feedback on latest rebasing:
>
> https://source.denx.de/Xenomai/linux-dovetail/-/commit/8f155631c8b51731dfc2ae5145d4dcc68f2ed7ed
>
> This was likely accidentally folded, right?
>

It looks so. This conditional statement appeared upstream during the
v6.0 cycle it seems, and was unfortunately left unfixed in the dovetail
patch for this entire series.

> Furthermore, I will factor this change out into a separate commit in 
> merging v6.1.y-dovetail, for better traceability:
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index ce8bdd804bc7..c843bf352999 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1466,7 +1466,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>  
>  	/* The fault is fully completed (including releasing mmap lock) */
>  	if (fault & VM_FAULT_COMPLETED)
> -		return;
> +		goto out;
>  
>  	/*
>  	 * If we need to retry the mmap_lock has already been released,
>
> To my understanding, this was a dovetail fix that applied to previous 
> versions as well.

Only to v6.0, however this series is not maintained dovetail-wise
anymore, so this stayed under the radar.

> Besides StackRot, another reason to update 6.1 soon.
>
> A tag on the new branch is still missing. I suspect you are still 
> testing? CI picked up the head already as well:
>

Yes, still in the process of testing the latest rebases on -stable for
5.10, 5.15, and 6.1 (armv8).

-- 
Philippe.
