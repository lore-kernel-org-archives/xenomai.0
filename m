Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8C15D5DE
	for <xenomai@lists.linux.dev>; Wed, 26 Jun 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391262; cv=none; b=KsQoO5LuYyod09Ii8KLHYkBNmvssQB3ag+YeC9ILybjyZqZ401hi0PA1flcKNTxpmtLwd2eLk2qb8D7aj52hnb5yT/FzD1ZSOAlKYH9d5VY9I2lgIJ6ATKpvKC8/nSPeIzke024SInehLJm3QNvpFpmPxsrwmB8zdXsYt+Xj4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391262; c=relaxed/simple;
	bh=83xnKs26Q3f1NxGEomRykban3uerJsGGa5F1jdtBfB4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=eExRF2wwHwLzFq5M8SXfEIQ1gpLv4YmfCbkD6SA1vjBf0bK7raerJYTbe+M9TWDcuOz2d2NJRpDk7Luxsmr/cEREY/S05xZ1BdpAMKhpp9vc2TcKB15bpBZA2dBbN0SbKjkQAfhSqFRzv3P/Ppw/QZAE0DnIxywwHVY5c1er5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217926991fso55080425e9.3
        for <xenomai@lists.linux.dev>; Wed, 26 Jun 2024 01:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391259; x=1719996059;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGcLElziJCyqGI0ri7WdOCzNrMO6HEq+PEIXKCmocKw=;
        b=bBTu1O+crPjmpdZKERnYY2CohUGEU9Dr2M4UHJdpwWF0odZ8Yw15VvR37AOuVqlo4x
         6clKE64T+3lolsIUzlQ1BqnCgeVPuYBPepnouuaHJ1Cz37tyn2ozM2bb6RbLQmJVNtOG
         anDcZTPCh6WcdR34IIsGXxH8cQ7BF6d80UiA1rKGHZ3JCsWivo0mibvzDiC03LtkPfXr
         dAO9g3vqRLIhgCNYw+KkjAIG5i9CfKqSB44ciOF0lzWnmog1EEtubu8J8Efe27vOiSRi
         x3qlQsr/C4Yphi5faTj5OQo1SigwuQA/mfL2NmaZTY8EE7kHsWZT63e6EiY3MCAH7ZNb
         E1kg==
X-Gm-Message-State: AOJu0YxWvhk/2c+3ZMdRxGOtvMHBtCDZajWuKsVwfn/mWS8tCErV3Mea
	zj99cNbstnj2sfxD4ahwjAJUFBKllNlOj3m9b4CqeHHbaoZ08rcJnlf7ma/a
X-Google-Smtp-Source: AGHT+IE7PbtQyoHIERPg4n6Nkekoh6Cvbwhb8iuFHi1hcH0l4bFlJwRbz8O+clesnRYnti5rSTLHtA==
X-Received: by 2002:a05:600c:4c22:b0:424:ac9c:71f9 with SMTP id 5b1f17b1804b1-424ac9c7bdcmr10913595e9.39.1719391258352;
        Wed, 26 Jun 2024 01:40:58 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8264891sm16991765e9.25.2024.06.26.01.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:40:57 -0700 (PDT)
References: <20240531-flo-fix-kvm-guest-for-6-9-v5-0-1efec77fe0a0@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH dovetail v5 0/2] Fix KVM guest support of dovetail
Date: Wed, 26 Jun 2024 10:40:39 +0200
In-reply-to: <20240531-flo-fix-kvm-guest-for-6-9-v5-0-1efec77fe0a0@siemens.com>
Message-ID: <875xtwcd0v.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all, 
>
> this is hopefully the final version of the dovetail KVM guest support
> enablement. Dovetail failed to boot without patch 1 and crashed without
> patch 2 under high IO load scenarios.
>
> Tested with LOCKDEP / PROVE_LOCKING enabled. Stress-Tests passed on two
> different hypervisors, namely KVM and VirtualBox.
>
> All dovetail versions (down to 5.10) are affected. Backporting would be
> required on my end, I need 6.1 to be fixed.
>
> This patches apply down to 5.15, 5.10 would need manual backporting. I
> can look into that once this series is accepted for 6.9.
>
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> CC: Philippe Gerum <rpm@xenomai.org>
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v5:
> - Patch 2: safe_halt() -> native_safe_halt()
> - Link to v4: https://lore.kernel.org/r/20240531-flo-fix-kvm-guest-for-6-9-v4-0-77471c9473d8@siemens.com
>
> Changes in v4:
> - Patch 2: Sligthly changed the patch description 
> - Patch 2: Do not stall the inband stage in task context (handle Linux
>   IRQ context and task context the same way)
> - Link to v3: https://lore.kernel.org/r/20240531-flo-fix-kvm-guest-for-6-9-v3-0-ebcf517500a3@siemens.com
>
> Changes in v3:
> - Removed RFC tag
> - Took care of review comments from Jan (patch 2) 
> - Link to v2: https://lore.kernel.org/r/20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com
>
> Changes in v2:
> - Drop patch one 
> - Now patch 1: Handle async page faults inband, rework patch subject
> - Now patch 2: Fix kvm_wait(), PV spinlocks
> - Link to v1: https://lore.kernel.org/r/20240531-flo-fix-kvm-guest-for-6-9-v1-0-1c895c256f8d@siemens.com
>
> ---
> Florian Bezdeka (2):
>       KVM: x86: dovetail: Move handling async page faults to the inband stage
>       KVM: x86: dovetail: Allow kvm_wait() to be called from any context
>
>  arch/x86/include/asm/idtentry.h |  2 +-
>  arch/x86/kernel/irq_pipeline.c  |  6 ++++++
>  arch/x86/kernel/kvm.c           | 29 ++++++++++++++++++++++-------
>  3 files changed, 29 insertions(+), 8 deletions(-)
> ---
> base-commit: 17865a05b459df6e7e7e38018b15b29a96df49af
> change-id: 20240531-flo-fix-kvm-guest-for-6-9-5ef61aac08ad
>
> Best regards,

Merged, thanks.

-- 
Philippe.
