Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26C156C68
	for <xenomai@lists.linux.dev>; Wed, 10 Apr 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741478; cv=none; b=POP0k2CAYPrjscJ2DwE4wbyRoTB0S78Lj9r6HvbNB2JI8mp70hsRPvvfSX5uGcR394IHCLKo+rDZzFXHELkKH2BZzeZfeY1C7u7xbFdCpH990DYYusJ7pd2A2ICq+ToNyzUbCfLxqXTyyPSL4oNR5LByMo0I/7iuXie98Yez/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741478; c=relaxed/simple;
	bh=/f4iMALL4VraASzDJ71SgnbWmBvUsZZBQiMIs9yHrjI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=afAanLgNYqXQvqsFNrhdBDrPUmILp0cIIWOtaCVjhETagMZaEEbvmblSmYuV5ubNd/4+Ackha+6NLU8P8SWCa9j1J6AEcgTsatWUVzHIxincAq0+UXRbxn/tEfsL6G6dJVMuN+DUDXFqC0rF6Za0pzBYK2X36uV2pnBQCu0+g2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3465921600dso634270f8f.3
        for <xenomai@lists.linux.dev>; Wed, 10 Apr 2024 02:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712741474; x=1713346274;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyTJjZBT4fNyrW/Wkly3vGk5pODbqsZTFu83dB54Rj8=;
        b=tGOVYLSrKliWnfehmiQjhv018jEbkE/68z6wOVbrYo+1fImZTPR010YGnCeS72pEz5
         /Y9aitRXxWz+2aP3vGhi9czeiqTyUmC0mBdbtqjKfjyGve7L1LcxK4v5808tsHSpwXYu
         IGCuCv26Vd3yRJXbKY59yncV1g5NI64GIp7PSR6j/+rexqOybMkIIkSD8CzMQAc1JAr+
         XGELE5NTV9yFxU9fTqJ4hNajP0fk/Cq9wtq7vSIKRvauoatjpjbqjoPw+deEig5kCArE
         C36YQaWDs8oua8cfuV/ZAqdQMeTRqnFw+VMOYZwt7jdq2PkePbjg3TLJ2bZWzfqC1cKa
         7ZHw==
X-Forwarded-Encrypted: i=1; AJvYcCXgqoVziTi+FHk4U/jRFrGuxTmFvX3jiVKsd+qkc8626rfLJE3e74O1DGjQWHEvgRKiTKF7opibfA8oI2NvtjrEzr7C8TvFYA==
X-Gm-Message-State: AOJu0YwUAjfDgoBA1ABFC+zfo9rA16ZKh5AVVmRrAdArYYFR0cKoE5Qj
	1LXBUo4ikNGftwG3HjC1tuIb6v45jUcjLtMfC1ftJjHKDncUxsn3kipoK/C/96U=
X-Google-Smtp-Source: AGHT+IGHYkV/uYyvebpPqbwoGLDcRfCQsmIjAJFN9uEXjVJ3svoRr7od64Lq0RpbAfkJtRCSo2OP6A==
X-Received: by 2002:a5d:4a10:0:b0:343:7ed6:765b with SMTP id m16-20020a5d4a10000000b003437ed6765bmr1365238wrq.39.1712741474322;
        Wed, 10 Apr 2024 02:31:14 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id x8-20020adfffc8000000b00343c1cd5aedsm13279929wrs.52.2024.04.10.02.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:31:13 -0700 (PDT)
References: <20240304-v5-10-y-dovetail-rebase-v1-0-e8010867dbbe@siemens.com>
 <4518cde8-777f-40fb-8598-8b29400d8f51@siemens.com>
 <a7a3f155-934e-433c-b89c-e181f0bdc914@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail 5.15-5.10 0/2] dovetail: x86: Backports for
 recent compat fixes
Date: Wed, 10 Apr 2024 11:24:24 +0200
In-reply-to: <a7a3f155-934e-433c-b89c-e181f0bdc914@siemens.com>
Message-ID: <871q7dzhr7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 08.04.24 15:12, Jan Kiszka wrote:
>> On 04.03.24 14:00, Florian Bezdeka wrote:
>>> Hi Philippe, Hi Jan, Hi all,
>>>
>>> here are the backports of recent compat fixes targeting the 5.15 and 5.10 
>>> branches.
>>>
>>> The original series that made it into recent development branches was
>>> published here:
>>>
>>> Link: https://lore.kernel.org/xenomai/878r2yfi2j.fsf@xenomai.org/T/
>>>
>>> @Philippe: I think Jan is still waiting for some clarifications about
>>> maintenance topics. Would be nice if we could sort that out. The
>>> maintenance state of some branches is currently unclear - at least to
>>> me.
>>>
>>> CC: Jan Kiszka <jan.kiszka@siemens.com>
>>> CC: Philippe Gerum <rpm@xenomai.org>
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>> Florian Bezdeka (2):
>>>       dovetail: x86: Fix detection of prctl based compat syscalls
>>>       dovetail: arch: Fix fetching of the first syscall argument from compat tasks
>>>
>>>  arch/arm/include/asm/syscall.h   | 3 ++-
>>>  arch/arm64/include/asm/syscall.h | 3 ++-
>>>  arch/x86/include/asm/dovetail.h  | 9 +++++++++
>>>  arch/x86/include/asm/syscall.h   | 7 ++++++-
>>>  kernel/dovetail.c                | 5 ++++-
>>>  5 files changed, 23 insertions(+), 4 deletions(-)
>>> ---
>>> base-commit: d7226e2eecda5b73a4c8fea85226ea4444038b00
>>> change-id: 20240304-v5-10-y-dovetail-rebase-43caf7d6a2e2
>>>
>>> Best regards,
>> 
>> Those reached 5.15 via my last update from newer kernels but didn't make
>> it into 5.10 yet. Philippe, I would now take over and refresh
>> v5.10.y-dovetail[-rebase]. Or do you have anything pending for that
>> version on your side? Please let me know.
>> 
>
> OK, I moved forward and updated v5.10.y-dovetail-rebase - under test now.
>

Yep, sorry. This one slipped through the cracks while struggling with my
e-mail setup a few weeks ago. So no, I don't have anything pending for
v5.10, I stopped working on the mere dovetail support for that release.

-- 
Philippe.
