Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D33FB3B
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348522; cv=none; b=nlhavY9aTq9Dm4L/pAExtFgzojJVqXdgAshtfHQsljuIjbxhJlCCumM8xnPAdd2s9EePn+YT2R5hlLh8SvLwe4Ca3kbDIaipRv9dFtK/UyZcbP6zLpgWdx3XFZ6xhgBR7Lz66BDZC9xGse8uZevlNjWy1L/i3Zbq/6Hza5ofLHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348522; c=relaxed/simple;
	bh=IdkEEY0Ifo0wTyxYJFkvlsh166vbCI4IKg37nVjFOB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLo5A418+jkOyVWzqr1JMG/fo5znV8sFdpeeeX/ZdVZ/OrbBhVN7I/GgMf1C164CrDk5KsFs82+54UhfBfs674qgVa7Jwui4Vcmft8KMk2OCGMUEY/121UE5FY7byAidUE8Lss+4+tsIbshlCqYlIL4crxTuRqrghrXRWgIaLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4362f61757fso167467235e9.2
        for <xenomai@lists.linux.dev>; Wed, 08 Jan 2025 07:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736348519; x=1736953319;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgmh2kpWnieG27Ru+jYGP7PD+4E1H4rBwY/bzUpowcY=;
        b=mDxIzeI65ZbqMjvHCiYE/cmvcXFIWMF1L+gp7BK/Bg4irI9g4CgDa/t+T97TfdHWS5
         DZJJyMjuA8389MrtvdPdgbix6804Pua/ONj/bmjkWK+1K8LvkYkVGaHj3Vi/oe+6WWxj
         AB8o9f7LIlTI0H1RFjeAzBG/I0c/kGFrM1oDZvlQvZAStCrv5/m927gJwHvO24+2NCgc
         0qEeFYzYO/NGTSwUrnbuEuOgAIiH2R8l/BUBQYDr7jC8GqiJZp+LPZ51CMkAyYegzRNg
         mVADSswZWmnfvdRrgn/67E5D5gAohDT/POoU6nHDhX8gZTYuVdTx3KV/EA0iapsuB8Ec
         MnVw==
X-Gm-Message-State: AOJu0Yy/EkvGuuAXipO/WuVZD5NZwq7qPFmImGY70NlZP/S7DgKTSn/9
	07O/nd6DqUqjskwWFb0qEZ4k7fBoiYJMmXmSXh6uInWreF8JqrJP9kk8poQ5
X-Gm-Gg: ASbGncv6eXrIqq22VklyxGL30J1piUJn8p2TNjsrExI+frqRdu4ywnzooMqT7k88Uu/
	q+YJxFDdGNFtgr7NtVKGQH7IiWmtvOOIgUvqzkPHy4Yc942DRHrJY2jUL/8/bBPs7hWUAdkNcj8
	F3FKKs8oBj9rfokwnB3z+NAGewp2fYKTPnrDSV/U3f1DUXx1VMV+H7jAydTn6QFOd1kRWWLuk5E
	X4zlSc0u6dRrIbnWtq4HTVN15CSZssixi6fgYgqCA==
X-Google-Smtp-Source: AGHT+IH61MPkkfD5MBcPwIuT4KLON3fGFcUKSO30HC4DyyDwz6Jag97bnGqlA9n/1xAlaVsaQgdLww==
X-Received: by 2002:a05:600c:46d5:b0:434:ffd7:6fd2 with SMTP id 5b1f17b1804b1-436e26aeb4emr25732735e9.7.1736348517638;
        Wed, 08 Jan 2025 07:01:57 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc14d5sm23736745e9.11.2025.01.08.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 07:01:57 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Register corruption in syscalls on Dovetail > 6.10
In-Reply-To: <9b141179a28d93ce9dfd3d1c560054efc5170a29.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 08 Jan 2025 14:46:33 +0100")
References: <9b141179a28d93ce9dfd3d1c560054efc5170a29.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 08 Jan 2025 16:01:56 +0100
Message-ID: <87frltuz6j.fsf@xenomai.org>
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
> while doing the dovetail forward porting to 6.13 we detected an issue
> within the cobalt core.
>
> CI jobs fail/crash while trying to execute the smokey testsuite.
> Philippe and I were able to reproduce locally. Here is a summary what
> we found out so far. The issue is not completely understood yet.
>
> The smokey test suite - especially the y2038 tests - are triggering
> several (page) faults. One of them triggers the following kernel splat.
> The complete test log can be found at [1].
>
> [  265.656410] Unable to handle kernel paging request at virtual address ffff0000404666c8
> [  265.656463] Mem abort info:
> [  265.656475]   ESR = 0x0000000096000005
> [  265.656529]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  265.656554]   SET = 0, FnV = 0
> [  265.656571]   EA = 0, S1PTW = 0
> [  265.656591]   FSC = 0x05: level 1 translation fault
> [  265.656619] Data abort info:
> [  265.656635]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [  265.656652]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  265.656669]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  265.656735] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000004196d000
> [  265.656764] [ffff0000404666c8] pgd=180000007ffff003, p4d=180000007ffff003, pud=0000000000000000
> [  265.657948] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> [  265.658304] Modules linked in: crct10dif_ce cfg80211 rfkill fuse drm drm_panel_orientation_quirks ip_tables x_tables ipv6 [last unloaded: xeno_rtdmtest]
> [  265.658970] CPU: 0 UID: 0 PID: 1610 Comm: smokey Not tainted 6.12.0 #1
> [  265.659072] Hardware name: linux,dummy-virt (DT)
> [  265.659213] IRQ stage: Linux
> [  265.659437] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  265.659529] pc : __pipeline_syscall+0xf0/0x23c
> [  265.659574] lr : __pipeline_syscall+0xc8/0x23c
> [  265.659608] sp : ffff800082e93d90
> [  265.659629] x29: ffff800082e93d90 x28: 0000000000000000 x27: ffff800081fedf08
> [  265.659715] x26: ffff800081574598 x25: ffff8000820066b8 x24: 0000000000000001
> [  265.659741] x23: ffff800081fedf08 x22: 0000000000000018 x21: ffff800082e93eb0
> [  265.659767] x20: ffff8000819364d0 x19: ffff00003fd964d0 x18: 0000000000000000
> [  265.659791] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [  265.659823] x14: ffff000004942e00 x13: 0000000000000000 x12: 0000000000000001
> [  265.659846] x11: ffff800082d13c08 x10: 0000000000000a70 x9 : ffff800082e93be0
> [  265.659870] x8 : ffff00000766f0d0 x7 : ffff800082006000 x6 : 0000000000000000
> [  265.659912] x5 : 0000000000000000 x4 : ffff800082e93d90 x3 : 0000000000000000
> [  265.659944] x2 : ffff0000404666b8 x1 : ffff00000766e600 x0 : ffff7fffbe460000
> [  265.660114] Call trace:
> [  265.660289]  __pipeline_syscall+0xf0/0x23c
> [  265.660485]  pipeline_syscall+0x60/0xcc
> [  265.660566]  el0_svc_common.constprop.0+0x44/0x118
> [  265.660598]  do_el0_svc+0x1c/0x28
> [  265.660615]  el0_svc+0x34/0xfc
> [  265.660632]  el0t_64_sync_handler+0x100/0x12c
> [  265.660646]  el0t_64_sync+0x190/0x194
> [  265.660879] Code: d3596442 8b020442 8b020f22 8b000042 (f9400841) 
> [  265.688100] ---[ end trace 0000000000000000 ]---
> [  265.688359] note: smokey[1610] exited with irqs disabled
>
> Findings:
>
> [ @Philippe, please correct/add if I missed something ]
>
> - The first version with that problem is Dovetail 6.11, 6.10 is fine
> - There seems to be a register corruption in syscalls

This is even worse: the stack context which underlies
current_thread_info() looks like very much broken in the syscall path,
at some point.

-- 
Philippe.
