Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64812FB1B
	for <xenomai@lists.linux.dev>; Mon,  9 Dec 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756521; cv=none; b=VnDR/61wK6lbFS1q2OhVxqLjqJZyddskV37pl2luSlCup85vffibNzvkTNG6JLYFb03aknx3XvFTpsjOwWWTbQXsoLDzXBszBqg0Y8us1nqauP/ZSD87koY9iMCkbCMt8nhxjRA59EexgUHRETmPC2+sP3tpsUmuCApzdugHezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756521; c=relaxed/simple;
	bh=ZL0Ts6rFo9Z8hnF6C9q0f/sI9ZUQIhp4PLFn4G9zlQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZctxGEViygucmKAlJ8MgBGiRHKjHCbXsRcI95VZ0fOC9gxqxeQKtVymleYO5QmsVchFA7ox4JRqtQJyVCM3DZVBulGdWMRhp8+UJDxei2tMiFw/fiOMIp4syucn9oaia8CT73XcuvxPzBHd5RmdDqY3U4DI9SnTrv6d788nuqvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434e9716feaso11702675e9.3
        for <xenomai@lists.linux.dev>; Mon, 09 Dec 2024 07:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756517; x=1734361317;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC9hNShcX1QOENMK8HlZccew+XPEXgaofViMqFcFySY=;
        b=FcW335yoU+VpwHYYizUJoLs0b4ojZI9LA97AsuQ/Y0dUxD3LiKeJhGMIgoFeTgAhhS
         wuwtwCKG17NRgaAI2NAcZkqUqWTDHwxlG/nNnHlASTZSl2uU7L85RoATZnI//AUxc+xi
         yvRrVh9FIcaCF37jqHJw/C0FkqpZ37Qf8+w7CH9KS5SiFAwge0T1FcYmtmgKGpfECAxT
         s3zRmPaNTPBOKBhEIUEh+TERRvkuZuSB5fi7YzM+HRoV4VJoI4E8IOYvC7e6lE/Gwpnp
         OEFvgWQ+heDBGvOhKZikYufyd15AOTEpUABNhb615YfK6p87olGjZNfzi0hREV4gV4h3
         A2Xg==
X-Gm-Message-State: AOJu0YwpANd7JkPYF4ysVkcNKRyPHryB0c8J4sKZeVoSXrottr9akcls
	4maMqaZFiKu1uki4bQuHrox1DyCMHF73HS6YvkhBewSmqfPpJIMfIb5jZw==
X-Gm-Gg: ASbGnct+IBpEXGTlJcSYkWP6zTZtonfP8qlufeh7oEzCnQwiUmCSdyNI9o7OglLlYPd
	LdD+Pupb1w3/N57/jJcWYrlLoafpJ9nq/Mg1qSTU8mht42PTD0ilwXuYSTOxXV+vmztx3JzNZzm
	Jh6BXObfMzswze2r/BbtHnrHc6kxy8epKdySORDPOooID36VVjAp+IMgVVu3sRTe2fMVvGxQPQf
	rSUzkLfBt71IbaQ2xA2bBFZt8i3/YFgaGw=
X-Google-Smtp-Source: AGHT+IHMCX8rmQkUhAj1eu/LDgrIDbDzQcdPiL/cXLqkI2rAKWtlpT2VTTxszghXNo5dwslW8Jdpqg==
X-Received: by 2002:a05:600c:1d25:b0:434:f623:9ff3 with SMTP id 5b1f17b1804b1-434f623a371mr41104795e9.15.1733756516747;
        Mon, 09 Dec 2024 07:01:56 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434e8bb0390sm90460355e9.27.2024.12.09.07.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:01:56 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Qichen Qiu <ruiqurm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] evl: fix the gdb accessing control buffer issue.
In-Reply-To: <20241209083746.672587-1-ruiqurm@gmail.com> (Qichen Qiu's message
	of "Mon, 9 Dec 2024 08:37:46 +0000")
References: <20241209083746.672587-1-ruiqurm@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 09 Dec 2024 16:01:51 +0100
Message-ID: <8734iwc334.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Qichen Qiu <ruiqurm@gmail.com> writes:

> Currently, EVL maps the control buffer using remap_pfn_range, tagging 
> the memory with VM_IO. However, this prevents access by gdb.
>
> This patch introduces the control_mmap_access function for the control 
> VMA, enabling gdb access when CONFIG_HAVE_IOREMAP_PROT is supported on 
> the target architecture.
>
> Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
> ---
>  kernel/evl/control.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/evl/control.c b/kernel/evl/control.c
> index 2d1b44f3b0dc..33ec47745740 100644
> --- a/kernel/evl/control.c
> +++ b/kernel/evl/control.c
> @@ -8,6 +8,7 @@
>  #include <linux/mm.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/bitmap.h>
> +#include <linux/highmem.h>
>  #include <evl/memory.h>
>  #include <evl/factory.h>
>  #include <evl/tick.h>
> @@ -335,8 +336,52 @@ static long control_ioctl(struct file *filp, unsigned int cmd,
>  	return ret;
>  }
>  
> +static int control_mmap_access(struct vm_area_struct *vma, unsigned long addr,
> +			       void *buf, int len, int write)
> +{
> +	resource_size_t phys_addr;
> +	pte_t *ptep, pte;
> +	void *virt_addr;
> +	spinlock_t *ptl;
> +	struct page *page;
> +	int offset = offset_in_page(addr);
> +	int ret = -EINVAL;
> +
> +	if (follow_pte(vma, addr, &ptep, &ptl))

follow_pte() was deprecated in v6.12. We need to use the new
follow_pfnmap*() API from that point on.

> +		return -EINVAL;
> +
> +	pte = ptep_get(ptep);
> +	pte_unmap_unlock(ptep, ptl);
> +
> +	phys_addr = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
> +	page = pfn_to_page(PFN_DOWN(phys_addr));
> +
> +	virt_addr = kmap(page) + offset;
> +	if (!virt_addr) {

Mm, not sure about the test above.

> +		ret = -ENOMEM;
> +		goto unmap;
> +	}
> +
> +	if (write) {
> +		memcpy(virt_addr, buf, len);
> +	} else {
> +		memcpy(buf, virt_addr, len);
> +	}
> +	ret = len;
> +
> +unmap:
> +	kunmap(page);
> +
> +	return ret;
> +}
> +
> +static const struct vm_operations_struct control_mmap_ops = {
> +	.access = control_mmap_access
> +};
> +
>  static int control_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
> +	int err;
>  	void *p = evl_get_heap_base(&evl_shared_heap);
>  	unsigned long pfn = __pa(p) >> PAGE_SHIFT;
>  	size_t len = vma->vm_end - vma->vm_start;
> @@ -344,7 +389,13 @@ static int control_mmap(struct file *filp, struct vm_area_struct *vma)
>  	if (len != evl_shm_size)
>  		return -EINVAL;
>  
> -	return remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED);
> +	err = remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED);
> +	if (err < 0){
> +		return err;
> +	}
> +
> +	vma->vm_ops = &control_mmap_ops;
> +	return 0;
>  }
>  
>  static const struct file_operations control_fops = {


There may be another (version-agnostic) way: simply obtain the heap
memory from the vmalloc space instead of kmem/logical, then use
vm_insert_page() to populate the mapping, which would drop the
requirement for an access trampoline to pfn ranges. Dovetail deals with
vmalloc memory pinning appropriately.

-- 
Philippe.
