Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073201C7670
	for <xenomai@lists.linux.dev>; Tue,  3 Sep 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353723; cv=none; b=AdqZ1n3hyCDdv9gEqLpm9YQoNgPj/Z9hg4gj1dfK+wUmQGbuM1i6Jxe4BnsHhmzjGoC+K+6r3xXbvaqk8Yg9zmrLqXIYJtUo/3dokQ53mjzbmM+APjSh4NUZQUKA0zVpdaSoIol5CjIjmFjHnpfCa2vbGCgiBvHhVQ06RjbgVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353723; c=relaxed/simple;
	bh=2uDN1+/XHryxkYCwlebQcGzyZ3y+FhOBQ/suljjYZWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qSbYVL1P5Tzg/oyen8n1xctKdxz9/1lowhYeljZknpO5wpom0FE+YVjoA/pMIDwjb22X9ZInc9rU5m0YX5cZG4orQUEnXF0uQkd5PQfBrL02AzAFsjucOSfuHKu+NRxMxoFN228eHQEyaZWWUss2HO4+bobxFnWWwDSg7tCwWxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c962e5adso1014236f8f.1
        for <xenomai@lists.linux.dev>; Tue, 03 Sep 2024 01:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725353719; x=1725958519;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrkPxJjrc6sImgc39earaQoN3HRPCp0dzRDr44vLkps=;
        b=L9ZVue5Kid9UD0S0X7OqKlKtvcZjAS8LhrUvf5v7lvxrKW/WAs9SaVmZjy3SThFUEt
         jb0IYwbw1IDADjatWDWrG23mXYARRaFIIHN/LaIXvYUxL08qEJXU1+uGt18ZM1wkQ/YT
         uIrXzS8Ad6saeERFB44Q3+DurNdwT1hI2zBp5UwAWbCoZ4vTEqYLEuQ8HxhYyDCxZ8wx
         +P79JcVPUxn9RAyJr5R6pTr/But3FovNxqSMwNvj0iLjynFzdwDJ6qMWP8AwjmYkPe66
         9/7048clvduUQVXxVFMlHUw//di2hgFAfTS3i0BJd0Pn35Jkm4VkVRL+89mPD7KVYbEb
         5B8w==
X-Gm-Message-State: AOJu0Yy8y/mUERC5BsKOBSYfGU/x4cM+UceY9x3ZTZkI+uL0pWmDh3eM
	pkYCkEqNo19cAKxs5uwFojGAHDsJnYhUwQAzoprKCe8iaZ5cY1mAU3zamQ==
X-Google-Smtp-Source: AGHT+IESPQ6h9NZSdBsPWdohoqW8ucm/pu3SCu25JN9GFjZBUlAfp5fZmuPVAQYuDNTw1CuCEzrD7w==
X-Received: by 2002:a05:6000:2a08:b0:374:bf6b:1021 with SMTP id ffacd0b85a97d-374bf6b132dmr6455959f8f.27.1725353719030;
        Tue, 03 Sep 2024 01:55:19 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c8547c0csm6181711f8f.17.2024.09.03.01.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:55:18 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH] dovetail: Account for invalid syscall number
In-Reply-To: <24868b62-2aa9-4f06-a20a-c1c0dc2ba164@siemens.com> (Jan Kiszka's
	message of "Mon, 26 Aug 2024 08:31:49 +0200")
References: <24868b62-2aa9-4f06-a20a-c1c0dc2ba164@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 03 Sep 2024 10:55:17 +0200
Message-ID: <87h6ax9kwa.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> At least on x86, the kernel may have decided to invalidate the syscall
> number while processing it. Avoid that we process this -1 as legacy
> syscall.
>
> This was a long-pending issue in the whole dovetail series, now revealed
> by running auditd on one of the test systems. Syscall auditing was
> eventually catching an unbalanced tracing, caused by a premature syscall
> exit due to this bug.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/dovetail.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
> index 08c649d6e9d9..bcd49183f8eb 100644
> --- a/kernel/dovetail.c
> +++ b/kernel/dovetail.c
> @@ -119,7 +119,7 @@ static bool __in_oob_syscall(struct task_struct *tsk,
>  	 * a PR_OOB_SYSCALL command (new/current call form).
>  	 */
>  	if (IS_ENABLED(CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE)) {
> -		if (nr & __OOB_SYSCALL_BIT)
> +		if (nr != -1 && nr & __OOB_SYSCALL_BIT)
>  			return true;
>  	}

Merged into v6.1.y-dovetail-rebase, v6.6.y-dovetail-rebase,
v6.10-dovetail-rebase and the upcoming v6.11-dovetail-rebase.

Thanks,

-- 
Philippe.
