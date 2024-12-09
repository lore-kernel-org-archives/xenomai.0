Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999641BEF8C
	for <xenomai@lists.linux.dev>; Mon,  9 Dec 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757102; cv=none; b=qPWIW0cr6pbLAehYC3Nh3gSNzBSh4UqrvxVzNAA2pk83ZxPI5qhdp/TCIT93kkGBVcqILHJ8xiCZnmnDjBPrwwpTO9ZgR646JI+Lg6glV53c6ElN8ubciMEbLvvKCA6kdhMefPC+GsPxDyXYNjqGgh3FcNUzRyYuKCEnf+Zs0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757102; c=relaxed/simple;
	bh=U5D9NrmURvfng1+RdY69vSBG5CccCp47QcDdAgOzptg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MA2YlN4hFSVudJviE7LDT4oAM/6gFUSae3Uk/VRqnZrmDW8vwh95pKUXNX1YZ64OVU+eQLxX/lCIK2GOGaon3xukTUP0utt4OWhIopivXQAfUmZy+EdM3W/kEvAxGIaC7AFw+AjVw4Nm3j2Q6E5KLgov0stVHjbtZeyDCUoWxBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-435004228c0so2597925e9.0
        for <xenomai@lists.linux.dev>; Mon, 09 Dec 2024 07:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733757099; x=1734361899;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMMbsHWyRNs8+Qh5ntNr804I0hHr3oWw9e8/ckcKzNc=;
        b=vwhbv8fj3OlByc+Tc8gS91jPC/CcalfmMxOa06gUN+LpxUiUYqrpbYxe7FihVtWB+7
         ZUboGm/Fr7464MPlLdFagvIATvJ/wU0Mna+a6PT1szwllaAE0Hch7o0n/k8jl+nHkWKq
         fv58bMBxhyAAKOipHpYqkaStOVfrOv2aZcEbsNzuLKeBoE3iAfmWOfSeM2ruwrtYRWaX
         PcmCW6F6ydePwISYM8uHGXjmtTXB82G3hbSTAfV1430+8DMqXTFLpfR7UPBFDQ63nFrz
         pN7pk60rhD57w7WdGj7qymZWW8o4MKwvY7mODVFuAwK5NZ9B3tml6wCx8F4R8fcRG3HC
         z7/A==
X-Forwarded-Encrypted: i=1; AJvYcCW+8AexArvEMlVxSWygPuiDRwF0pJyyY+dMYNSzxqdkWvDAMmWKCQKJf/E6p2bIRQB8V06lXGeG@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc3nnsuwg54rL2pMG00s0IhEgkQpLrAfjweW9tQopC1pppkqU2
	7uDx357zNQnsdWEqrfV3U/nGO0KCEA100IVHVkfGzL8MafWJe/TeojqUQg==
X-Gm-Gg: ASbGncsizKU96haHvHw7RvnaCvxrfdovNqaW/PEi8i5a2NuQXePA2/b3291/s8DdSLm
	Yx/x+JwycvfWm2OdSI1GOwzSgpg2FlJaXOOVU5sW7ZI7dcTHm90vKX3oIhnN1oX2amWbOfggPLn
	qS258DggF54CHJ4t7FQcSExknIrWTpXeMzNVs3epg7cGRCHddnb+CkRcsc7dhxFpB/tUyFC2G+x
	LEZaTtTgKF+bBBHT1QNqGWlSrp0j/X0kkk=
X-Google-Smtp-Source: AGHT+IHK4f5mlJtFOHtuTPoa+I4+bulJkImb2WnNAU9TcWdFNI/VBW0t7MFD8xl0yJPhCL3BIQGiYA==
X-Received: by 2002:a05:600c:3b9d:b0:431:4f29:9539 with SMTP id 5b1f17b1804b1-434fffba867mr9429485e9.32.1733757097040;
        Mon, 09 Dec 2024 07:11:37 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4350159f6a4sm1606805e9.21.2024.12.09.07.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:11:36 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Qichen Qiu <ruiqurm@gmail.com>,  xenomai@lists.linux.dev
Subject: Re: [PATCH] evl: fix the gdb accessing control buffer issue.
In-Reply-To: <1a1ba081bad39a548d0ca0b1bce44b7c9643d9ce.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 09 Dec 2024 10:25:57 +0100")
References: <20241209083746.672587-1-ruiqurm@gmail.com>
	<1a1ba081bad39a548d0ca0b1bce44b7c9643d9ce.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 09 Dec 2024 16:11:35 +0100
Message-ID: <87plm0ao2g.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2024-12-09 at 08:37 +0000, Qichen Qiu wrote:
>> Currently, EVL maps the control buffer using remap_pfn_range, tagging 
>> the memory with VM_IO. However, this prevents access by gdb.
>> 
>> This patch introduces the control_mmap_access function for the control 
>> VMA, enabling gdb access when CONFIG_HAVE_IOREMAP_PROT is supported on 
>> the target architecture.
>
> @Philippe: I haven't checked the details yet, but the memory mapping is
> different for Xenomai 3? Just wondering why this is necessary at all.
>

Cobalt gets the u-mmapped heaps from the vmalloc space
(cobalt_umm_init), so we can populate the vma using vm_insert_page()
there (mmap_kmem_helper), which should not set VM_IO. EVL currently
obtains the heap from kmalloc instead, hence remap_pfn_range() to map a
range from the logical memory space. IOW, "that should be fine already"
(famous last words).

> Does that mean that gdb did not work? On which platforms/architectures?
> Is there no test for gdb like the gdb test in smokey?
>

The existing gdb test only checks the synchronous stop feature I
believe, not accessing the memory behind those mappings.

-- 
Philippe.
