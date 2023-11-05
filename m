Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5B1641B
	for <xenomai@lists.linux.dev>; Sun,  5 Nov 2023 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so33133765e9.3
        for <xenomai@lists.linux.dev>; Sun, 05 Nov 2023 09:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699206318; x=1699811118;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fJAHnV+yTaM4n8oWHu4nT9PUdmHvAkn+KzF74Tfd5aQ=;
        b=tFLgaN+Bo+MHGqBxkKyXpPFNT1Me39ZBbb5TUHZR8/cXPMwYNfhMz3fZy3K8CusXkt
         q0/e/fcRKJkytFQ1lYjkbogjYY4NfhFNThS+Vthlv+5bWeke4zxLttHq3NWrHiKzfG07
         uZqSKn3sNp/c5QwHUn5JhjACMspP+RbWFxX0jB0cZf9K2kTkXKQSGMgGo72CtuN4cIHt
         Xae+q1Oirapz8xn/mV0PrwRfSulGJPfXfmiU4yI7GwwBXCD6wM5hSZOyj9ggWTI0cBOh
         e49QOhC4qKB2/5KkcYOT8A8sD+r8bXk2KPSxr+nONcswQh8q/+sS4KVs5v1tEKTGpTJm
         QalQ==
X-Gm-Message-State: AOJu0YyCmXlMkLWQFcvZX6XIbewVx/Wyq+XQif8xl4cWPhlP6bIQy+e2
	jQPBsIlnXaiCaYW6H1cUL12pCSdx849bBg==
X-Google-Smtp-Source: AGHT+IGq2voslksNFbzuJf90TdgdyQxYOSgFtFtqpP5XNeLNUc/HwQIpECm9j6li9MvupiDqGfVv1w==
X-Received: by 2002:a05:600c:1f87:b0:409:5a92:470e with SMTP id je7-20020a05600c1f8700b004095a92470emr11254987wmb.28.1699206318101;
        Sun, 05 Nov 2023 09:45:18 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003fee8793911sm9674041wmq.44.2023.11.05.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 09:45:17 -0800 (PST)
References: <4481c3ac97badd74e74849a97b049f1bb5c89fb7.camel@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: clara.kowalsky@siemens.com, xenomai@lists.linux.dev
Subject: Re: evl: Problems while trying to build up a debianization
Date: Sun, 05 Nov 2023 18:23:07 +0100
In-reply-to: <4481c3ac97badd74e74849a97b049f1bb5c89fb7.camel@siemens.com>
Message-ID: <87wmuwjdqq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> we're starting with some very first steps regarding EVL here. The idea
> was to enable the xenomai-images project to generate images with EVL as
> well.
>
> Currently we're failing because there is some confusion about the UAPI
> installation here.
>
> The meson build and install steps of libevl refer to some headers
> coming from the (sources) of linux-evl.=C2=A0
>
> We're trying to integrate this meson based build into a debianization.
> As libevl depends on some headers delivered by the kernel "package" we
> would model that as a build dependency. libevl would depend on linux-
> evl-headers.
>
> Right now we're failing inside the setup-uapi.sh script because the
> sources of linux-evl are not available. We were not able to set -Duapi
> correctly.
>
> To my understanding the dance with include/ inside the meson build
> directory is necessary to limit the number of "special" include paths.
> Is that correct?
>

Correct.

> Another issue we came across is the installation of the UAPI headers by
> the libevl install step. Why is that necessary at all? The only
> component that should depend on that headers is libevl itself. No?
>

Actually, many user-facing headers from include/evl do pull bits from
inner uapi/ headers, so we need the later. However, installing the
kernel uapi/ files as part of the libevl artefacts is a relic from the
Dark Ages, when the target toolchain would not have a copy of those. In
this day and age, we build proper toolchains which do include a copy of
the exported uapi/ headers.

IOW, I agree that libevl should not be exporting the uapi/, this is
some kernel-headers package's business which some toolchain builder
would use.

> Any idea how we could fix that up without breaking your local build
> process?
>

In fact, I'm the one who needs to fix his own process here. So, I bit
the bullet eventually, fixing the way the EVL uapi/ files are referred
to by the kernel code, aligning libevl on the sanitized result.

As a by-product, CONFIG_UAPI_HEADER_TEST is now happy with the EVL uapi/
headers, which is good news for preparing a kernel-headers
package. Meanwhile, libevl does not copy the uapi/ anymore during the
installation process. I'll fix my meta layers to get them properly from
a linux-evl-headers package on my end.

Referring to a local custom copy of the kernel headers via the -Duapi
option still makes sense in maintainer mode (only), when rebuilding a
toolchain to include an updated set of exported kernel headers would be
overkill. Said differently, when working on changes involving the uapi/
on the kernel side, I don't want to have to bootstrap bitbake, so I'd
rather pull the uapi/ headers in place directly from the development
kernel tree. That is the rational for keeping this option basically.

All of the v5.10.y, v6.1.y and v6.6 EVL kernel branches have been
updated accordingly. The associated libevl changes are available from
the -next branch. I think the debianization should be easier. Let me
know if I can help in fixing other rough edge(s).

--=20
Philippe.
