Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A43CF50
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931426; cv=none; b=TGNV0VOzqy1HCKZ4FDn2/gIvSnRbA9bHDhwq7YyX9nJysWBCIrvShFpgFj1QseEIw4ZpwuQ4JLhizp19DFZnXOlwHojhAwgy0lsRp4r/8Qof8OfWnKORzcxjb2YwDx6LrHIQWZPy6qUtB0f9SVHGChews9cQcOoEiYhSb8hEhVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931426; c=relaxed/simple;
	bh=KDQrqCCYGyXim9ruHU2xS+ISiB5us5J15SzwpzbYhSM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=JQNfG6jsmGq5zsS7IA2d/+xRdNKf5QzaTrWbTEe7UuzRTqmO564x52iKkVS47+VqvnSYX64uTvg3d3PFRF/w8ar4zXAlhfyupQSW9uCFv+mAydGOVH7TD2nqZm51IbSMHkGkcZyb6c8yFtczygeesiImj3gsbWUMIV9pC+dAYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso24928355e9.3
        for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 05:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931422; x=1706536222;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM62AR6Vprunq1jkEAtIPqLeSP6ZivsO5gaJ9gyQ8FU=;
        b=rLGUuDdGpLGKTWk5CprmQ1D6L9GkUOKmu7gewEzJr1cvqUHKgzPyC2a5XzyuHF+AWW
         dC3Kls5ibaRgBl5uAMrKflAbIRa+feA/HxJVUpRSHcPOU1XmlKeIO/vE8nhSrErPPW3b
         LWaprzJoPy9AP0CObRfyUAJ1yQ9XhJDML1SeZtFFAKextm+8a2LU/JDVFnzJVmc1pQI+
         /wz64MRJ7bH8urbg2KzYGW1WzD3rgwlswZ9TLNc32k7CbENxhR4P0g9kSdbNc/Uz/deZ
         LGbeId4+KXWsZZUpenu7xuVrqe02TjXbmodR/jiOg0ZU97gj1GfNe5q19wd9a+X+/yFJ
         01Ig==
X-Gm-Message-State: AOJu0YzjIKbrFFzaNAortoUAIFkrfhaM++HL3Lkgt1Ki9gY+lY567a24
	ZNWGJKbWO0rnaenQMwwEREcBnIEfqMaXFXpd0E7xI0ddsR0VntmluMzrH2FOSsI=
X-Google-Smtp-Source: AGHT+IEDkP1zz28HKqwzxpy0vYHP029xl0AEYay0O/iYQ2SQE+z/XCDqK8skLkCzb1J/3JUMIAXgGw==
X-Received: by 2002:a05:600c:1c82:b0:40e:b05f:6f75 with SMTP id k2-20020a05600c1c8200b0040eb05f6f75mr399020wms.115.1705931421908;
        Mon, 22 Jan 2024 05:50:21 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b0040eaebc4e8fsm2858795wms.1.2024.01.22.05.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:50:21 -0800 (PST)
References: <37d6d286847eb0126c938a1c5826ed13@rtxi.org>
 <34ba04db1b45f6c546a2195f0a8e0ad3@rtxi.org>
 <e70b0272-8c4a-479e-b7f9-2dbfc6771389@siemens.com>
 <ce6d6d1504bb7d589daa14d03fd81d76@rtxi.org>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: ivan@rtxi.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Subject: Re: Troubleshooting x86_64 evl bootup
Date: Mon, 22 Jan 2024 14:43:07 +0100
In-reply-to: <ce6d6d1504bb7d589daa14d03fd81d76@rtxi.org>
Message-ID: <87plxtfper.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


ivan@rtxi.org writes:

> Hello,
>
> On 2024-01-18 01:51, Jan Kiszka wrote:
>> Hi,
>> On 18.01.24 00:22, ivan@rtxi.org wrote:
>>> On 2024-01-04 13:34, ivan@rtxi.org wrote:
>>> Hello everyone,
>>> I tried building and installing with a newer kernel version
>>> (v6.6.y-evl-rebase) and i get the same error during bootup. This time
>>> however, there is an additional message:
>>> clocksource: Switched to clocksource tsc
>>> After which it hangs for a minute then the same output previously
>>> described is printed. Am I doing something wrong? What additional
>>> information do you need?
>>> 
>> Yes, kernel config, to begin with. A complete boot log would also be
>> nice (catch via UART, please).
>
> Attached is the kernel config for the build. Unfortunately I don't
> have a
> way to capture early printk logs through UART, but I will attempt
> other ways.
>
>> There is now a demo image, also for x86, generated via
>> xenomai-images
>> (currently only in 'next'). That config ([1] + [2]) may be lacking some
>> bits you need driver-wise, but maybe it's worth to check and try if
>> that
>> one makes any differences.
>
> I will try this as well and let you know if anything changes.
>
>> Do you see this boot issue only on the Phenom hardware or also on
>> others?
>> 
>
> There are a few our old machines that show similar issues:
>   1. Intel Xeon w3680 (Used to have XENOMAI+IPIPE)
>   2. Intel Core 2 Duo (No xenomai/testing laptop)
>

I successfully booted 6.6-evl on the legacy hardware below, so there is
hope:
https://ark.intel.com/content/www/us/en/ark/products/34687/intel-desktop-board-dq45cb.html

An issue with virtualizing the tick device is indeed very likely, this
would also match the init sequence following the tsc calibration.

You may want to disable EVL entirely, only keeping the interrupt
pipeline enabled along with its basic testsuite at bootup. That would
be:

CONFIG_IRQ_PIPELINE
CONFIG_DEBUG_IRQ_PIPELINE
CONFIG_IRQ_PIPELINE_TORTURE

# CONFIG_EVL
# CONFIG_DOVETAIL

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Core(TM)2 Duo CPU     E7200  @ 2.53GHz
stepping	: 6
microcode	: 0x60c
cpu MHz		: 1600.175
cache size	: 3072 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl cpuid aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm sse4_1 lahf_lm pti dtherm
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit mmio_unknown
bogomips	: 5066.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Core(TM)2 Duo CPU     E7200  @ 2.53GHz
stepping	: 6
microcode	: 0x60c
cpu MHz		: 1705.682
cache size	: 3072 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl cpuid aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm sse4_1 lahf_lm pti dtherm
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit mmio_unknown
bogomips	: 5066.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:


-- 
Philippe.
