Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5570210942
	for <xenomai@lists.linux.dev>; Tue,  2 Jan 2024 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3367a304091so9233433f8f.3
        for <xenomai@lists.linux.dev>; Tue, 02 Jan 2024 06:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704205378; x=1704810178;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3pyR7TvbZe+a/HjqkvOzbXp4vuzn9HkTbLpAM/B7FY=;
        b=FrZLID41xqYOg3IOQgom3a2xsQqAiYBbTJuzE5c0GVt9XVJ5kBt2mKjWoW+JPkDQRx
         vlcuKzFRRgli6q6cLxfRFFU+iuhSVWEMiYMl+KrgRYz0J9CaDhCG0b3HwwFmkMiB2YAr
         fMuZiPVcnL2HSyf9q2S3rePqz0GNDNuqsDhChUlfWdawtztdzIHOGShBFKNpN9HnqqYv
         vHAWEn/QhH3agVlN/i+OT4HNYKbJ0oY90QMUkbKuca5RaBn1KmU050mDAKcROmwoSaEC
         rdiOBQwDZe5Aiv/VW192w/EFFhuw/mFjJONqK+M9p8XOZ3/1xC1nfbMR3yxukdFs1nR2
         sqpg==
X-Gm-Message-State: AOJu0YwGll7yd9WfDl2XyHrFT2QRJF3lzz87XRyGyPEaTB8dZIovbjSJ
	GO/0C76T9ol7/gyoOaxwW08SmIzsoZvfeA==
X-Google-Smtp-Source: AGHT+IG19E8IxswSGDUqsQ/u6WoeIHJr25qiPbyDza/DGhEixT5eCgB/oB7Pk/JP7mgh2ueuFMcHaQ==
X-Received: by 2002:adf:ec43:0:b0:333:4ac2:fe35 with SMTP id w3-20020adfec43000000b003334ac2fe35mr6107517wrn.118.1704205378259;
        Tue, 02 Jan 2024 06:22:58 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b00333359b522dsm28796076wrm.77.2024.01.02.06.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:22:57 -0800 (PST)
References: <2f68d6bd-a3f2-4602-a72a-9d9ba5ced50c@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>, Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH v2] meson: setup-uapi: Take Debian multiarch
 into account
Date: Tue, 02 Jan 2024 15:22:45 +0100
In-reply-to: <2f68d6bd-a3f2-4602-a72a-9d9ba5ced50c@siemens.com>
Message-ID: <87zfxn24sj.fsf@xenomai.org>
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
> Check also the Debian multiarch include path for the chosen architecture
> so that we can support (self-built) linux-libc-dev packages that contain
> the evl headers.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Changes in v2:
>  - fix typo in DEB_HOST_ARCH spotted by Clara
>
>  meson/setup-uapi.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
> index f2d0774..633c5ed 100644
> --- a/meson/setup-uapi.sh
> +++ b/meson/setup-uapi.sh
> @@ -17,7 +17,17 @@ if test -r $UAPI/Kbuild; then
>      link_dir $UAPI/arch/$ARCH/include/uapi/asm/evl asm
>      link_dir $UAPI/include/uapi/asm-generic .
>  else
> +    DEB_HOST_ARCH=$ARCH
> +    if [ "$DEB_HOST_ARCH" = "x86" ]; then
> +        DEB_HOST_ARCH=amd64
> +    fi
> +    DEB_HOST_MULTIARCH=$( \
> +        dpkg-architecture -q DEB_HOST_MULTIARCH -a $DEB_HOST_ARCH 2>/dev/null)
>      link_dir $UAPI/evl .
> -    link_dir $UAPI/asm/evl asm
> +    if [ -d $UAPI/$DEB_HOST_MULTIARCH/asm/evl ]; then
> +        link_dir $UAPI/$DEB_HOST_MULTIARCH/asm/evl asm
> +    else
> +        link_dir $UAPI/asm/evl asm
> +    fi
>      link_dir $UAPI/asm-generic .
>  fi

Merged, thanks.

-- 
Philippe.
