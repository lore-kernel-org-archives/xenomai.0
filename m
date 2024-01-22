Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3C3D38C
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929980; cv=none; b=BVNSYopNj9Y5XIoQaG2pXgyfl962ym4KKE3b3WVowPQxeTF+eNJrGX/PqCektyEz3bJPeWjBIYxDICzSSNP4JnHS6NVHAtnzuOQHiJWAEkFbvQomCxlPrdDi3VNnUerkDYADdgnQnw7R6OLpOGQcwWYxYDegrpSKLccD7c03sS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929980; c=relaxed/simple;
	bh=D6SJRP1M7VRrLytKob4ipmiv0gxPvoLSlKHDOVPSqEw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=OvaDmIFacznhmqU4pya8azj2o78U4ZBPnYBHbMj1RCH384Gc+zitc+GOFqCc2T6qYzBMwOlR/y1y6DVfLWgAUhj9Q/JaIgyZQzfl8CcRE1ny+JKWVa8+ZGwOP0p3+QlZP596GJMH6midy9P3AvLdiW8BldSw4vKUuqyZfaTPnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eac352733so11731245e9.0
        for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 05:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705929977; x=1706534777;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JCg2X4WbzYu2HhfPS0DPlgpfDfSSkIn7n/GMenaqF2Y=;
        b=BaElg6BjX4WevQw7k3joyEbjJfwcA6MJjIDPcIk9YbEA2vD8RKeQClWNbo7dRC4+fk
         8Kl7OlQACQOTrNUrbOfA/gxAOCle1/9P7vBKEON4ZyNmTKd16slpIDB7Xh7pas9z1MgQ
         8oenwmXMINiCquTHvpf64aoaaJDnEjt4hEv1XOAw3hU1Fz65JVsBcrXvvI4m/WrIFaRE
         YszTtE4TZi4dDjiV07HS8G5F1miKi21b0KxN5rB89zh75INH5It7kdMwJbNMcJVnx7TK
         gX8+4N5N+07ydGKzuWX8HHMaWHh3u48zw1UTJlVYNF4BflKhhT59i/2m04WgIcNXWlyF
         C0+A==
X-Gm-Message-State: AOJu0YxeFokaFQBYn27yLh8n5LelpruxeTQ5bJXAdILnLq1ZQMOt57qu
	qAaZVNrMRgbpwuirodSb/Uea2ej/HliLp+pqMh5BpoS5GVCPNO/PBkAtzOElQtM=
X-Google-Smtp-Source: AGHT+IH2kSzCfTDaqNEKcpBX2ubikVfV277bNwfrrX6McwoOPoNGJSj0uuBuovXbhhcB4W+ifezJ4Q==
X-Received: by 2002:a05:600c:280b:b0:40d:5ccd:cb6f with SMTP id m11-20020a05600c280b00b0040d5ccdcb6fmr2273612wmb.158.1705929976652;
        Mon, 22 Jan 2024 05:26:16 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id p37-20020a05600c1da500b0040ea22b51cbsm9711563wms.34.2024.01.22.05.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:26:15 -0800 (PST)
References: <20231205202210.25477-1-richard@nod.at>
 <c1aa91be-a8c3-4d36-83fc-1dcce598dcef@siemens.com>
 <404252638.239962.1705393323222.JavaMail.zimbra@nod.at>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: Richard Weinberger <richard@nod.at>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@lists.linux.dev>,
 wg@denx.de
Subject: Re: [PATCH] cobalt/drvlib: Prefault io memory again
Date: Mon, 22 Jan 2024 14:14:59 +0100
In-reply-to: <404252638.239962.1705393323222.JavaMail.zimbra@nod.at>
Message-ID: <87le8hh53h.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Richard Weinberger <richard@nod.at> writes:

> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> An: "richard" <richard@nod.at>, "xenomai" <xenomai@lists.linux.dev>, "Ph=
ilippe Gerum" <rpm@xenomai.org>
>> CC: wg@denx.de
>> Gesendet: Donnerstag, 7. Dezember 2023 10:12:27
>> Betreff: Re: [PATCH] cobalt/drvlib: Prefault io memory again
>
>> On 06.12.23 04:22, Richard Weinberger wrote:
>>> This issue was fixed a long time ago by
>>> 03d5b0b0083c ("cobalt/rtdm: fix caching and page fault issues with
>>> rtdm_iomap_to_user()"),
>>> later with commit c8e9e166b ("cobalt/rtdm: introduce mmap() support")
>>> iomap code lost again the call to cobalt_machine.prefault().
>>>=20
>>> I have no idea why this took so longer to come up again.
>>> Last week, while upgrading an aarch32 setup from Xenomai 2 to Xenomai 3=
, the
>>> application
>>> failed due to massive latencies caused by page faults after writing to =
io
>>> memory.
>>>=20
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>>  kernel/cobalt/rtdm/drvlib.c | 14 ++++++++++++--
>>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
>>> index 30455c3d7..620be27fa 100644
>>> --- a/kernel/cobalt/rtdm/drvlib.c
>>> +++ b/kernel/cobalt/rtdm/drvlib.c
>>> @@ -1761,6 +1761,7 @@ static int mmap_iomem_helper(struct vm_area_struc=
t *vma,
>>> phys_addr_t pa)
>>>  {
>>>  	pgprot_t prot =3D PAGE_SHARED;
>>>  	unsigned long len;
>>> +	int ret;
>>>=20=20
>>>  	len =3D vma->vm_end - vma->vm_start;
>>>  #ifndef CONFIG_MMU
>>> @@ -1774,8 +1775,17 @@ static int mmap_iomem_helper(struct vm_area_stru=
ct *vma,
>>> phys_addr_t pa)
>>>  #endif
>>>  	vma->vm_page_prot =3D pgprot_noncached(prot);
>>>=20=20
>>> -	return remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
>>> -			       len, vma->vm_page_prot);
>>> +	ret =3D remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
>>> +			      len, vma->vm_page_prot);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +#ifdef CONFIG_MMU
>>> +	if (cobalt_machine.prefault)
>>> +		cobalt_machine.prefault(vma);
>>> +#endif
>>> +
>>> +	return 0;
>>>  }
>>>=20=20
>>>  static int mmap_buffer_helper(struct rtdm_fd *fd, struct vm_area_struc=
t *vma)
>>=20
>> This makes sense to me, specifically as c8e9e166bce43 didn't provide any
>> reason nor even mentioned the fact that it didn't add prefault to the
>> iomem_helper. Philippe, was there a reason? Are we side-effect-free /wrt
>> actual IO memory accesses when pre-faulting?
>
> *friendly ping*
>
> Thanks,
> //richard

It appears reading the patch that prefaulting may not have been
willingly removed from the new iomem helper that was just introduced,
but most likely overlooked when splitting the code from the kmem
helper. Call this a bug. I don't expect any side-effect of running the
generic mm fault handler for the MMIO area, there is no reason
justifying that such range would be actually touched.

Sidenote: Dovetail has the per-arch arch_advertise_page_mapping() hook
we could use for this purpose at some point. Only implemented for x86 so
far in order to export all mappings to the global (init) address space,
so that faulting-in vmalloc mem upon first access is disabled. For the
time being, xenomai3 should stick with its own prefault handlers though.

--=20
Philippe.
