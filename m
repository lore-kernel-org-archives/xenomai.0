Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CDE1A70F
	for <xenomai@lists.linux.dev>; Tue, 31 Oct 2023 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40806e4106dso32911155e9.1
        for <xenomai@lists.linux.dev>; Tue, 31 Oct 2023 04:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698751447; x=1699356247;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXthWMIBDp9BGqpxlykHnyu78UioTw1e2sHxQ15rqjA=;
        b=cZWO71nKn/QwsMg+ofjW7OTIxbwewAWmlKvHa0pRI4YltfoovMEBONtCWJgn2YMaOd
         TyLHht0VEajvv2hC8Hh2n6otb0AheMxp8TJHQeSsUJg/zR8nC6BxW3VnU9Zw0CqiBReT
         0Dl3U/t5Co22GfncQnrDu5b1vY2btIFzWQUCnX3SK8mKmuZGnDEHJtdjFw4XRmORyztS
         TRKK95HaSmelD7BLKzOMe+5ftPrq+zpOZl1l0JeNmYQrOmkg3DAyjyEuQfTs2ILEiESs
         kPgYWSeFSvl99NAc8lb9SU5lp/GR1jJQqgTNd9m1A0DjAWu7vDW2T7+OxMFfO5I5CYvR
         wmgw==
X-Gm-Message-State: AOJu0Yzc++W3Fd2ZXE/dXZ+jnfLxyqCVhwPfVYmWLyMTlztoJ+r1IG7M
	q4zZtfp1dqDf6CauubQc/RTXB4ZMYJijRg==
X-Google-Smtp-Source: AGHT+IG5aHkf1EoDZP4FVtqKEN9LYwxzqmhyjlx2GmC9x5KvGFwcx+iY0W5P0wD7/2rYjThMS+MJwg==
X-Received: by 2002:a05:600c:510b:b0:408:3634:b81e with SMTP id o11-20020a05600c510b00b004083634b81emr2258190wms.13.1698751447075;
        Tue, 31 Oct 2023 04:24:07 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600c4e0300b00406447b798bsm1498910wmq.37.2023.10.31.04.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 04:24:06 -0700 (PDT)
References: <20231024093242.1077831-1-clara.kowalsky@siemens.com>
 <87lebjgi5x.fsf@xenomai.org>
 <bfc296acb34deccc3615edc828779592c68346c7.camel@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Subject: Re: [PATCH v3][Dovetail 6.6] arm64: dovetail: Fix undefinstr/break
 trap handling
Date: Tue, 31 Oct 2023 12:23:20 +0100
In-reply-to: <bfc296acb34deccc3615edc828779592c68346c7.camel@siemens.com>
Message-ID: <87h6m7ghm1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2023-10-31 at 11:46 +0100, Philippe Gerum wrote:
>> Ack. I initially thought we could postpone the in-band switch until
>> after some of the emulation code paths have been considered (typically
>> the MRS stuff), but that would involve convoluted logic for no obvious
>> gain, so let's take the straightforward approach instead. The assumption
>> here is that issuing an (emulated) MRS read request from a userland
>> application should not happen from a time-critical context anyway, so
>> doing this in-band should be acceptable. We'll see from complains if its
>> not..
>> 
>> IOW, patch merged to v6.6, thanks.
>
> Nice! Thanks!
>
>> 
>> PS: There are three Dovetail branches to maintain concurrently ATM,
>> twice that number when including the EVL trees. So please always mention
>> the kernel release any patch sent my way applies to, this may help
>> speeding up the process on my end (e.g. this patch conflicts, needs
>> manual backport to v5.10, v6.1.y).
>
> We had [Dovetail 6.6] in the subject. I thought that should be
> sufficient. Seems it's not. How should we make that clear?

No, that's perfect. PEBKAC detected locally.

-- 
Philippe.
