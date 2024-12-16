Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7F204585
	for <xenomai@lists.linux.dev>; Mon, 16 Dec 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358931; cv=none; b=pe/FwpucSHQvTtlBrzFMXjk/MhemHSTliMQIaa5HPKYN5lGIofaqc14SzAf3lGudyo1ssnK1eknElyd4RCJUo1JGbGBhyfb+HTgC3tmeSUlX+mR4SliUPvW2fHop+6ChWHEXMMJ/A0s1ExNlMe8a1Sy+cu9mUCCVaXJza3l8qp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358931; c=relaxed/simple;
	bh=UuoeZxHWAypxFHUmTYrw8ltDOFJjt7RK3Ix0Byd6knk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VJWPsbMDYlo3ucZJ89Lwxf6bIWujr2c1ZfJczxw0lS37+CumMFaPFCc1DrrLc7KVsLOiuy2j1lpZPy1StkVH0eJL4EoxhRwuCyvO7V8LP90UuYsNlkXYsF+p0LrK2GK7JCBKvpxvhoKX9ul0z2CJP0z2m5bc1kyXL6sexsZkVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e06af753so2178862f8f.2
        for <xenomai@lists.linux.dev>; Mon, 16 Dec 2024 06:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358928; x=1734963728;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wxag6Z0q0KjhxwXw5tf6KxJYQwQg+Zt4g/XVXi5qk/c=;
        b=Nl3BvaP8T9u3BVa99VVJFiZhX3vcTjlvJrwDPHqMf27Eyee07AIGxzJeJfYrrZBozx
         Myiyv7z+UWExsnx8PIRFpwYKMwUTbux0/djL3wT8GjJGtd2lC9mL0GzwLtH4NF/xCFrJ
         4WYvGcDsDrxJZkE3Eehjai6j6j5pYZXwIZnbLFL2he8Jl5BfWJqCfyi4HSswh8GDIVuH
         mUMC1nH3J4HhyRsJENo/lT6sakmH6U6F21AHX5UycnUaC7b9tCV+EdLjc5wgAr9oWlpr
         QcyOWE+B3UWkrUm8ViwsFb5skWysvgHhejD1X8hYipkKSWfsYDlj96IjgUJZBodfJyEB
         iLNg==
X-Gm-Message-State: AOJu0Yx3ecHhDJLR+ARKqLedP/AuFeZJ7F+ES922ptkeVUQ0lCmUWqNm
	FjIEAXrL9lYaeQVSJ3rx0diDISx2SZJq25QRMVqt9QUeh0G+PVw6X1dyhw==
X-Gm-Gg: ASbGncs1eusTnSaWSzQCMEscA9hbfzYiOeonNQVZS+j+VzdF2WTDdp2wmgUXWjE06dX
	ZS+e01zaEhwmZ2tUI40qf6YrnjYKbBE/irNcPsj4xg8p9V8NuSA7lJny5RT+j8kq41HBmywjQgr
	O80BQNSTjxFxGeN8ThDH5I+K0j7QJU1b0QIIlLtU8a39veZOV5DShy3AXtIKcWs3gva0f3aG0+X
	5VkLc9Lal8Iw/cnZNnkCOFIXJPUFSBc1/jC2X80cA==
X-Google-Smtp-Source: AGHT+IEx7EAokEPyhTKXrg/f2WigdTdVt/WXs/6fYhvnOf3OmoeWkE4Yj4HaaIbKNKKoqtQ9tYhtvA==
X-Received: by 2002:a5d:64a3:0:b0:386:32ca:aa0e with SMTP id ffacd0b85a97d-38880af1610mr11379619f8f.5.1734358927590;
        Mon, 16 Dec 2024 06:22:07 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801a6cfsm8207461f8f.50.2024.12.16.06.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:22:06 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Qichen Qiu <ruiqurm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] evl: replace `remap_pfn_range` with `vm_insert_page` in
 control_mmap.
In-Reply-To: <20241211152730.864059-1-ruiqurm@gmail.com> (Qichen Qiu's message
	of "Wed, 11 Dec 2024 15:27:30 +0000")
References: <8734iwc334.fsf@xenomai.org>
	<20241211152730.864059-1-ruiqurm@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 16 Dec 2024 15:22:02 +0100
Message-ID: <87ed27emid.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Qichen Qiu <ruiqurm@gmail.com> writes:

> Hi, I used vm_insert_page to map the area to user space, and it 
> successfully resolved the issue.
>

Thanks for the patch. A few observations:

- for this to work, you definitely need to update the system heap
  allocation method accordingly in the same patch, i.e. using vzalloc
  instead of kzalloc. This patch is incomplete.

- Why eagerly clearing the VM_WRITE flag from the vma?

- the short log should refer to what is being fixed as perceived by
  $user, not how we do that. The latter should be part of the long log
  instead. In this case, that would be something like
  evl/memory: allow system heap inspection using GDB
  The long log could then give a few details about GDB, ptracing, the
  VM_IO issue, and the reasoning behind the change of interface from
  remap_pfn_range to vm_insert_page.

> Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
> ---
>  kernel/evl/control.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/evl/control.c b/kernel/evl/control.c
> index 2d1b44f3b0dc..eee4bcaad390 100644
> --- a/kernel/evl/control.c
> +++ b/kernel/evl/control.c
> @@ -338,13 +338,22 @@ static long control_ioctl(struct file *filp, unsigned int cmd,
>  static int control_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>  	void *p = evl_get_heap_base(&evl_shared_heap);
> -	unsigned long pfn = __pa(p) >> PAGE_SHIFT;
>  	size_t len = vma->vm_end - vma->vm_start;
> +	unsigned long addr = vma->vm_start;
> +	int err;
>  
>  	if (len != evl_shm_size)
>  		return -EINVAL;
> +
> +	vm_flags_clear(vma, VM_WRITE);
> +
> +	while (addr < vma->vm_end) {
> +		err = vm_insert_page(vma, addr, virt_to_page(p));
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

-- 
Philippe.
