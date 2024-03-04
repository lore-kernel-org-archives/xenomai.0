Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8268620DD2
	for <xenomai@lists.linux.dev>; Mon,  4 Mar 2024 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545423; cv=none; b=u/rBATKo8v6YlF0OWboxx+N6WxRt7w6hCAiBLdHruK80CeQAkahjAZJeh9QHaq+kd4v/FMdo9m3jjt0v1SRYidnslgQIudg0USqOPMqaUfjPDG42lZTU306YsEOO6PclPAUyx6zH4bVd5usZzgdGThA8wlcRZ323of2mJVVWzHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545423; c=relaxed/simple;
	bh=/WVre4qi+2XhzxhvmGWyrgOP/kkTpymMprE3pSmmBCI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=J3kAy9YS6uErea75WBSE3KZBAjH48ii/ULrPWC7t+JmSS7urZIO4gjuuBzb/kpPu65oM6oAHHe3dkW1Svwq7atgpFSWZp9lRNIuEkeSV8max07bTdKvxuIrvmTGqvNirT0EsnCNt7Udyh+GDUpQAjijjaql/rgvvg+Qt0sHAiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513382f40e9so2191167e87.2
        for <xenomai@lists.linux.dev>; Mon, 04 Mar 2024 01:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545419; x=1710150219;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoQkiHcVPnqns5OMTR4IJzHfEnOtP58rKX45x0+1W44=;
        b=SAgnEV07ZAnxVzNpPeSMNNDInxXoWaPI+LL57EtNl7D/Wbr4OTrDotokkANNaiVgZH
         9HREJn889nHx7n/BFBSydddN+cuB1+8oI3TqzNHa5nvfqDEpckWi4QYLsk4JmhJqt2ls
         61pMnoJoyyzvD8KqT22ai772NB33T0xh3XLDvk+nxHyt4tjPlQD+pxTgBLR0GZo4jauk
         /TQgZgjFYiplnt/TDKq7FlGSk8ShA1qlNIjMU0U0XGuQMl+R0z3id5hG2iS2glllnqRl
         srP7Y3PpnMFDecSl4GUV126B1XhyiIdkxOada0iPXTNXcokae9HWE347ypuwvA0q01Ps
         NzwA==
X-Gm-Message-State: AOJu0Yy/tJiyIzRyLXGWcR1WC4AowZCh94THtIqAa08KLwMdtk7QWOUs
	9WE2rHwFu0FBrugKyJDP82ujR2wTL46qR4Bi1UbxqsRpSbf713ae9AKmDyT7
X-Google-Smtp-Source: AGHT+IENfONzLv3yhWraM8HiWMpkEZE/NItC+9kv3aCNJz8MWp6p+Z/O/dri3+RQviX5TRcx7IwmjQ==
X-Received: by 2002:a05:6512:1395:b0:513:2347:4988 with SMTP id fc21-20020a056512139500b0051323474988mr7725201lfb.12.1709545418350;
        Mon, 04 Mar 2024 01:43:38 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d50ce000000b0033b66c2d61esm11690178wrt.48.2024.03.04.01.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:43:37 -0800 (PST)
References: <20240226-v6-7-dovetail-rebase-v2-0-7d457d60d376@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.2
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH dovetail 6.7-6.1 v2 0/2] dovetail: x86: Fix handling of
 prctl based compat syscalls
Date: Mon, 04 Mar 2024 10:41:21 +0100
In-reply-to: <20240226-v6-7-dovetail-rebase-v2-0-7d457d60d376@siemens.com>
Message-ID: <878r2yfi2j.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe, Hi Jan, Hi all,
>
> while switching to prctl based syscalls on Xenomai 3 I found some issues
> in dovetail. Seems the compt support for x86 is not fully tested here.
>
> The patches apply to the 6.7, 6.6 and 6.1 branches. 5.10 will need some
> backporting. I think I can provide backports once this series was applied.
>
> Best regards,
> Florian
>
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> CC: Philippe Gerum <rpm@xenomai.org>
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v2:
> - Addressed review comments from Philippe 
> - Link to v1: https://lore.kernel.org/r/20240226-v6-7-dovetail-rebase-v1-0-2962213b5e9c@siemens.com
>
> ---
> Florian Bezdeka (2):
>       dovetail: x86: Fix detection of prctl based compat syscalls
>       dovetail: x86: Fix fetching of the first syscall argument from compat tasks
>
>  arch/arm/include/asm/syscall.h   | 3 ++-
>  arch/arm64/include/asm/syscall.h | 3 ++-
>  arch/x86/include/asm/dovetail.h  | 9 +++++++++
>  arch/x86/include/asm/syscall.h   | 7 ++++++-
>  kernel/dovetail.c                | 5 ++++-
>  5 files changed, 23 insertions(+), 4 deletions(-)
> ---
> base-commit: 2e3ed248f02a47dba4e5077031d285ff5c397372
> change-id: 20240226-v6-7-dovetail-rebase-ea22554608c0
>
> Best regards,

Merged, thanks. Slightly changed the short log of the last commit for
practical reasons.

-- 
Philippe.
