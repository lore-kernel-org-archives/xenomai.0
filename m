Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA31C20
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931630; cv=none; b=pYfRb0u31Of8pnod245TVSiQMwBFWtEnhkGeieQB7Zm+W3+j0PebVB8A6GmlVrSSiXTXybPiH3HZWhQ9hawHZ9rz4hdmJo58PwwvtOMcxGs1XRbD18LwXdBFu9xlit24O9H3YPtn/lbS6R2uYwNDt7eZsC9VD0Q2l/Tq+SIzOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931630; c=relaxed/simple;
	bh=Gr7x0JEeLV6LsgX9Fs5Rb19Exxfestpu31uHP2C9tNo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Z7a3KWZfgm82l7EZok4Z6VIDkI385QBbbVewrrzY+dES+/8EAVnJpyAdLTkIuvMIa7lH5jM21HNwfggqzi6bkJZUA96rFxYuM2pvo+CFrh7g/uzHvUY6F9C6aLLlxv+dQNtUwdPpBLVWp444F9CeZm6B70ssQTv2X/3tShrcSDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3367a304091so3537409f8f.3
        for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 05:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931627; x=1706536427;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmGtZqb/jSolSRvUWTbG9to3Xs3ftpFNnEDZXoOsMi8=;
        b=M3ieNresNPkThC2CARwJzoP1sXA7bAc370Urjr5rTNbItCWwGuRz//MBwhH+UVzHc4
         vUG0vwHXdMANg0h06K8MWWV/3QFP9JExXtJrODC1/v1wijGhw/kA3H9bwfZKrtw40RKW
         AX8UjisuRKvGeF2TYmQzn2yYC0YKHESppz840z1y0c48ijOMLxYN3nm0zGXHPH0Dwy2u
         IsMoJ/fdtOR6p+/LYkRRiimSkmCSBbHvaXvuryvjEkR+LX20410vYCTjKWBmn+03Sspn
         QpDe5Rg+rruMfmKRNoJ4ksDpkq1QGjxbW8kOvJL1ZAC/mGzFeu6M1InYDlBKnlf5d7nh
         9LIA==
X-Gm-Message-State: AOJu0Yw/3oCRtbaFERqAW4ESJgeEnzjE7d0c3zqBnsGhg60jz3T6aGCA
	UkmtsoNgrjbFFB1HHKiqFT34YQPgOHvUhDp3dmRtqZ1prEGJzkvKhjmyq5soLlU=
X-Google-Smtp-Source: AGHT+IEq5ctpvRcO7IyeBDiA7HVsdyCv6f0B79Evc6zz5/Aco+xXYtE9M5nODHZjz3/AxQItirVAjA==
X-Received: by 2002:adf:fd07:0:b0:333:3983:409b with SMTP id e7-20020adffd07000000b003333983409bmr1698536wrr.117.1705931626795;
        Mon, 22 Jan 2024 05:53:46 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d4a91000000b003392206c808sm8498412wrq.105.2024.01.22.05.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:53:46 -0800 (PST)
References: <cafa3048-07bb-4a72-a7ce-3de961b971f7@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH] utils/evl: Respect custom libexecdir
Date: Mon, 22 Jan 2024 14:53:41 +0100
In-reply-to: <cafa3048-07bb-4a72-a7ce-3de961b971f7@siemens.com>
Message-ID: <87le8hfp92.fsf@xenomai.org>
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
> This fixes execution of evl on Debian which uses multiarch-compatible
> paths for libexecdir.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  utils/evl.c       | 2 +-
>  utils/meson.build | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/utils/evl.c b/utils/evl.c
> index bb6aeb7..d14fce4 100644
> --- a/utils/evl.c
> +++ b/utils/evl.c
> @@ -118,7 +118,7 @@ int main(int argc, char *const argv[])
>  		error(1, ENOMEM, "%s", arg0);
>  
>  	if (cmddir == NULL)
> -		cmddir = find_install_dir(arg0, "libexec/evl");
> +		cmddir = find_install_dir(arg0, LIBEXECDIR "/evl");
>  
>  	ret = asprintf(&searchpath, "%s:%s", getenv("PATH"), cmddir);
>  	if (ret < 0)
> diff --git a/utils/meson.build b/utils/meson.build
> index a34ff19..59d818a 100644
> --- a/utils/meson.build
> +++ b/utils/meson.build
> @@ -2,6 +2,7 @@
>  
>  executable('evl',
>      'evl.c',
> +    c_args: [ '-DLIBEXECDIR="' + get_option('libexecdir') + '"' ],
>      install: true,
>      dependencies: libevl_dep
>  )

Merged, thanks.

-- 
Philippe.
