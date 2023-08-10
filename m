Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0704729A2
	for <xenomai@lists.linux.dev>; Thu, 10 Aug 2023 08:07:16 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3DADE0006;
	Thu, 10 Aug 2023 08:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1691654829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Uhjo8x/gG1PGJZrxiyRrC36bhtOsn63wKxmTf6wFeU=;
	b=Cj4Z05F2U5HDNoj93heZdZM+t0NG0cdpPogvdjcO26vsGP3BnlL4vkc1eWOZ8jmRrxmb9P
	iG5g/MXyg0WH7Eov6Xri7zBTGpQZIaYKAT4ZC3cdAOIyQfcfcXxRse/X4YUVUu0sNV3a2Q
	VxwVXkJSfoR9T23UQwgmdoOEmGIUpRnetzDRB9dWADTwvnupG0QVXKXeDxtNAPnr/dJ0Z6
	fhgOiFwcTyt/nI3Zb3Jcz3Un80sZP+174V/8gpZxHtTaIqpFnfp130TGgSdHzJPVLHPYlc
	kZOGcSxk4kNLKZFGg/Nb6ZcqQkVNvnIsZd82Vk1wc7GIbrL6Z6qPdTdi0x9T/g==
References: <20230809170529.3243299-1-jorge.ramirez.ortiz@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] evl: increase default number of xbuffers
Date: Thu, 10 Aug 2023 10:06:54 +0200
In-reply-to: <20230809170529.3243299-1-jorge.ramirez.ortiz@gmail.com>
Message-ID: <87il9nqq1l.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com> writes:

> The default case is too limiting. Increasing it to 128 allows clients
> such as the Pipewire Multimedia server to operate without additional
> tweaks.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> ---
>  kernel/evl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/evl/Kconfig b/kernel/evl/Kconfig
> index a5ce944e9d29..e41aa74be84d 100644
> --- a/kernel/evl/Kconfig
> +++ b/kernel/evl/Kconfig
> @@ -144,7 +144,7 @@ config EVL_NR_CLOCKS
>  config EVL_NR_XBUFS
>  	int "Maximum number of x-buffers"
>  	range 1 16384
> -	default 16
> +	default 128
>  	help
>  
>  	This value gives the maximum number of x-buffers which can be

Merged, thanks.

-- 
Philippe.
