Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A5171B0
	for <xenomai@lists.linux.dev>; Tue, 12 Dec 2023 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so31003815e9.1
        for <xenomai@lists.linux.dev>; Tue, 12 Dec 2023 00:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702370400; x=1702975200;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwjx9MbThRP4X+ujZWuaLmDNe+UF8G9VGccLRmtIo2g=;
        b=MZdzUGLC+MSskYWitKzj2ubU6B5D9smFHgfT141zI9cJFOA8anDRzrRQa+Td3Q0VKK
         M9rL2j5fTQ+FUQjA6gj6tQTtx4OhtW+aXgEh+cD32/spr1Bwuf9WGUk2HQGdUhiiHSh3
         jfOFbKQk+nFZvktUHQJknrttejOLyTTEKeiyJsdn7jzOh9EqJ6618ErlaiexXhQ8BWSa
         rnJBu1My/2EAXfxQkHMul7VPAaYLnZkqDrZAxUFyoypa5l1qVIPnxcgnBYolzt6HVgds
         QtKi/pMz0QPcmnWwGYSwSo6H/NF0tF+IAO7m7oQ3TyOQBKBmBxlwQSfDsMgTCLqRpAd/
         /erA==
X-Gm-Message-State: AOJu0YxIoifZZipDc0mYwFz2flCb343aVlNyYeNLrMCSP/H8tumxdQJr
	g3zdW0Wnjlp2BKTVeTp/25yCkhia6/Y=
X-Google-Smtp-Source: AGHT+IGMpqwlahPwEJsoWOM86KxwhIY039fbZaY/RWilcZCjSgWdtT2g8YIa7FCGxYWFoxRHRE3BBA==
X-Received: by 2002:a05:600c:1715:b0:40b:5f02:99ba with SMTP id c21-20020a05600c171500b0040b5f0299bamr1564974wmn.121.1702370399460;
        Tue, 12 Dec 2023 00:39:59 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c500a00b004094e565e71sm15717070wmr.23.2023.12.12.00.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 00:39:59 -0800 (PST)
References: <69ae4c12-197f-423e-b19f-b078573b73e6@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [dovetail-6.7][PATCH 1/2] genirq: irq_pipeline: Add lock guard
 support for hard spinlocks
Date: Tue, 12 Dec 2023 09:39:40 +0100
In-reply-to: <69ae4c12-197f-423e-b19f-b078573b73e6@siemens.com>
Message-ID: <87bkavlspx.fsf@xenomai.org>
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
> Will be needed when converting guard users of raw spinlocks to hard
> ones.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/linux/spinlock.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index d5ab32d64cab..0f01c1cce343 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -554,6 +554,26 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
>  		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
>  		    unsigned long flags)
>  
> +DEFINE_LOCK_GUARD_1(hard_spinlock, hard_spinlock_t,
> +		    hard_spin_lock((raw_spinlock_t *)_T->lock),
> +		    hard_spin_unlock((raw_spinlock_t *)_T->lock))
> +
> +DEFINE_LOCK_GUARD_1(hard_spinlock_nested, hard_spinlock_t,
> +		    hard_spin_lock_nested((raw_spinlock_t *)_T->lock,
> +					  SINGLE_DEPTH_NESTING),
> +		    hard_spin_unlock((raw_spinlock_t *)_T->lock))
> +
> +DEFINE_LOCK_GUARD_1(hard_spinlock_irq, hard_spinlock_t,
> +		    hard_spin_lock_irq((raw_spinlock_t *)_T->lock),
> +		    hard_spin_unlock_irq((raw_spinlock_t *)_T->lock))
> +
> +DEFINE_LOCK_GUARD_1(hard_spinlock_irqsave, hard_spinlock_t,
> +		    hard_spin_lock_irqsave((raw_spinlock_t *)_T->lock,
> +					   _T->flags),
> +		    hard_spin_unlock_irqrestore((raw_spinlock_t *)_T->lock,
> +						_T->flags),
> +		    unsigned long flags)
> +
>  DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
>  		    spin_lock(_T->lock),
>  		    spin_unlock(_T->lock))

Series merged, thanks.

-- 
Philippe.
