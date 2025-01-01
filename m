Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECB91854
	for <xenomai@lists.linux.dev>; Wed,  1 Jan 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735748561; cv=none; b=BQ4C1vxzycA01MDe/+mcV/Th8vMROZPIgopcRtedLrJrXyo8jJBGYnskBK8RMRfzSFBS2ESjNX0aYQOHkcIIUQBUhWvrYSLXf4XAXRhMu2zHpf86jdDRcf6V+imHOPpB2f7A7fShYaVJ6HA7ldr/AMEwB0jYEX6tX387xN7qB64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735748561; c=relaxed/simple;
	bh=gSR1GT/PAe1xWyLQ74tcGOdxfT3qCdjS+xF6AttiiyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EfDuhTnKARIfTyBZEJ5BFd88qtGZ+LpX++OnR4bbjUZcPrJNhNPrxqhU6eqGc29BvZKBmAAKJVyhaWP/JUR3sbEA64VNWLa3/ubL2brWb0GRcHEjze8rm00CfgCBmIST0Tx7kdtQZxm6rmtJGpCtOxpmfAvo/hGO4htunKQIKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so107152845e9.1
        for <xenomai@lists.linux.dev>; Wed, 01 Jan 2025 08:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735748557; x=1736353357;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keBF5Tr+JmYcd1kYCmWCf0BgwpKloZtX3IcMdf6IJ6Q=;
        b=A3P9zYy7zNvfw6DOGDHmWcaGFhm741fcaazwgRmPu+mtdneMgcEMA8qYe16Vlztxfp
         gf8bB6V7sHl/hwn+hEbzSZM6OHJxk88pzW2RcYOodaV9w9Ah7bXeKSO8MFkw0RO15CKI
         Vyi6YLU1+kKWtbwZrK6S5Zr1VeZC9IZ3Hd3zKZpntcLX2dHzIEl4zqf4G3z4PhgElzjA
         CIfU4esZkgpEdZBdbl0PXMh1kNA2Hsc5sdWyqUju+j4vhtDGDZwuEc2XcjBu6d/3hB9x
         TDbBqZ0OapgcntHYqJHFn7U01xd9zbnntLpX40NggfG6JGC8QA/Gpaz32nWketsNFF0Q
         i6+Q==
X-Gm-Message-State: AOJu0YwVIrJ6SJdtAVRjcmCddQyVxbG8gK4Fsm3b/HIaTcarn8ttvz9o
	Ygai1aBn7d2D+ODC7v3ly83hAWo9crDvBAPfEU2Ny/7lLijKgHYAyfi6yQ==
X-Gm-Gg: ASbGncs9Xk2Ry7h+m1wFn7E4wxG1in7RUmmCiuTGmULPxwr3arTIBuMJrvgzV50wwvs
	+jwLhyrEEx2JCANAbt/IuVuRHDcFTojI5ym85mLdXodz9vjQ7Ld21x40zMTA8y70fGT4rHelmZK
	GhtDaDKG6UNgPFLDI2hKftOufsAr2lX8C5Z/RUb4ceVeQkGjUUL3R//jWfkfCvtPhjZMYjZAArO
	praVaEpSpFfiCDxqSk9phsyK1uqmz6ZQAxYj1dy+A==
X-Google-Smtp-Source: AGHT+IFOQ8TwObKIo+/wN8gr7JHMcsYypu9MnmqiY49ay6cXSLHcD6YCHYXuf10K1ztJ6gI6a3nBCQ==
X-Received: by 2002:a5d:5f83:0:b0:385:ec6e:e87a with SMTP id ffacd0b85a97d-38a223ffaf7mr32420051f8f.43.1735748557235;
        Wed, 01 Jan 2025 08:22:37 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e278sm36234556f8f.75.2025.01.01.08.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 08:22:36 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Qichen Qiu <ruiqurm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] evl/memory: allow system heap inspection using GDB
In-Reply-To: <20241217144015.1879213-1-ruiqurm@gmail.com> (Qichen Qiu's
	message of "Tue, 17 Dec 2024 14:40:15 +0000")
References: <20241217144015.1879213-1-ruiqurm@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 01 Jan 2025 17:22:36 +0100
Message-ID: <87r05m8pwz.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Qichen Qiu <ruiqurm@gmail.com> writes:

> GDB was unable to inspect the evl shared heap mapping regions(i.e. 
> __current_evl_window) due to limitations imposed by the VM_IO flag when 
> ptrace accesses memory regions that were mapped using remap_pfn_range. 
> This restriction hindered effective debugging.
>
> To resolve this issue, the shared heap is now allocated using `vzalloc`, 
> and the memory is mapped with `vm_insert_page`, which work seamlessly 
> with GDB and ptrace.
>
> Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
> ---
>  kernel/evl/control.c | 15 +++++++++++++--
>  kernel/evl/memory.c  |  6 +++---
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/evl/control.c b/kernel/evl/control.c
> index 2d1b44f3b0dc..32764a9fc08b 100644
> --- a/kernel/evl/control.c
> +++ b/kernel/evl/control.c
> @@ -338,13 +338,24 @@ static long control_ioctl(struct file *filp, unsigned int cmd,
>  static int control_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>  	void *p = evl_get_heap_base(&evl_shared_heap);
> -	unsigned long pfn = __pa(p) >> PAGE_SHIFT;
>  	size_t len = vma->vm_end - vma->vm_start;
> +	unsigned long addr = vma->vm_start;
> +	int err;
> +	struct page *page;
>  
>  	if (len != evl_shm_size)
>  		return -EINVAL;
> +
> +	while (addr < vma->vm_end) {
> +		page = vmalloc_to_page(p);
> +		err = vm_insert_page(vma, addr, page);
> +		if (err < 0)
> +			return err;
> +		addr += PAGE_SIZE;
> +		p += PAGE_SIZE;
> +	}
>  
> -	return remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED);
> +	return 0;
>  }
>  
>  static const struct file_operations control_fops = {
> diff --git a/kernel/evl/memory.c b/kernel/evl/memory.c
> index 1da5be623d69..053a377396d2 100644
> --- a/kernel/evl/memory.c
> +++ b/kernel/evl/memory.c
> @@ -630,13 +630,13 @@ static int init_shared_heap(void)
>  		CONFIG_EVL_NR_MONITORS *
>  		sizeof(struct evl_monitor_state);
>  	size = PAGE_ALIGN(size);
> -	mem = kzalloc(size, GFP_KERNEL);
> +	mem = vzalloc(size);
>  	if (mem == NULL)
>  		return -ENOMEM;
>  
>  	ret = evl_init_heap(&evl_shared_heap, mem, size);
>  	if (ret) {
> -		kfree(mem);
> +		vfree(mem);
>  		return ret;
>  	}
>  
> @@ -650,7 +650,7 @@ static void cleanup_shared_heap(void)
>  	void *membase = evl_get_heap_base(&evl_shared_heap);
>  
>  	evl_destroy_heap(&evl_shared_heap);
> -	kfree(membase);
> +	vfree(membase);
>  }
>  
>  static int init_system_heap(void)

Merged (6.1.y, 6.6.y, 6.12), thanks.

-- 
Philippe.
