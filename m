Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E5154BF0
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731919234; cv=none; b=EMj/aUd6rCTRf76ypA0iR7+rBj1i8nlIYBH9DqWnmVqnFr6ZlmComY55Mjmmg7K7IEyv2mmSimWfpRv8Ktt4Hh2Ht1Xahq/SWkBUDpk3FLUKqKM0vUNiqocZbPP6sx0dm429Q+ua+LI8//KH3iUw3CfFNf7mL7e0hQEvhJo2vOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731919234; c=relaxed/simple;
	bh=7uwpbkXi7MTFeHr4ynqfTdpBhpT7qKOIiTWYYRH9nWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GlWCl4tVewcJlP84CuwZ/5wWIU+VRBeUPZzSEtLUJJq1WstdCg0xpSV8sFrApFTW4SnVqU6joJt9/Bh7AwD/BdBc9p39Y5kOTk31V8eY5/Y+rWve1g3r8BdVgMLMUKa5Sxf+G1bV0325X4nY/CC3f/kuEpr2aSNGurZ1QmcrEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-382325b0508so1318880f8f.3
        for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 00:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731919231; x=1732524031;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/zTbK3fOo7aYPTT9KP0f7N35Q9G7C7pRVLtRLEfxDE=;
        b=mLh/SsdFV2rIOvcETlBu6YFAVwu7hd3XoB6NtkHxOjr1X3/gG9LOvsQDEYM+7HCL/y
         Z9aF4JmXegA5rMSI3qHKKKvrno1847Kxpu2KLSxcQTvWIUZSBucQ5tCCf4zLAOqGhwqx
         Ekq69N8BsDmlWzULjQU7KU0jM3gxDrqMG6bem+EkQbx4QYKcXYW9bXc5dRst7tOyTCTz
         V+w8T+PTlpHil7BBy7OaXTNCX7SVM1W6lD+v7ABxTx7tadWb43r5+VPBn8IS/l+L5NN6
         qZhckPAf3sw+qecN7PUf9p2hV24ATYJ6D2/ciq5QcutW3XAVVbwa9lslea3Iy+HmPoM6
         g2Yg==
X-Gm-Message-State: AOJu0YwQNm2yqPK78WD4RjAtQvDMgy0ZANOdr/L1JmUYi9VXxdhEipfE
	5Ww13CTvsOso0xnQIT0K5XHi/VP+imOcBRKqNJwWdHCOXaOk/z1/
X-Google-Smtp-Source: AGHT+IEs3rAGXimWFGC/nBKENAJ+Ny06TLVY8eA609nonvJlbUdq1eHooWjsbA8k0vUISQtbduGzCA==
X-Received: by 2002:a05:6000:701:b0:382:4926:98e0 with SMTP id ffacd0b85a97d-38249269a19mr1202689f8f.52.1731919230484;
        Mon, 18 Nov 2024 00:40:30 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824aad691csm308352f8f.1.2024.11.18.00.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:40:29 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Pierre FICHEUX
 <pierre.ficheux@smile.fr>
Subject: Re: [xenomai-images][PATCH] libevl: Add build dependencies for r50
 and above
In-Reply-To: <a0d95b09-b050-48a3-a9fb-68af212ab1ba@siemens.com> (Jan Kiszka's
	message of "Mon, 18 Nov 2024 09:02:36 +0100")
References: <a0d95b09-b050-48a3-a9fb-68af212ab1ba@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 09:40:29 +0100
Message-ID: <87ttc5j5oi.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> libbpf is needed now to support the networking stack, and that is found
> via pkg-config my meson.
>
> Reported-by: Pierre FICHEUX <pierre.ficheux@smile.fr>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  recipes-xenomai/libevl/libevl.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/recipes-xenomai/libevl/libevl.inc b/recipes-xenomai/libevl/libevl.inc
> index 405be8b..fb82d09 100644
> --- a/recipes-xenomai/libevl/libevl.inc
> +++ b/recipes-xenomai/libevl/libevl.inc
> @@ -17,7 +17,7 @@ DESCRIPTION ?= "libevl libraries and tools"
>  SRC_URI += "file://debian"
>  
>  DEPENDS = "linux-xenomai-4"
> -DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson"
> +DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson, pkg-config, libbpf-dev"
>  
>  TEMPLATE_FILES = "debian/control.tmpl"
>  TEMPLATE_VARS += "DEBIAN_BUILD_DEPENDS"

For those interested, the reason for this new dependency is explained
here [1].

[1] https://v4.xenomai.org/core/net/#evl-input-diversion

-- 
Philippe.
