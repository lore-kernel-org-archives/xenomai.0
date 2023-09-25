Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87691CF85
	for <xenomai@lists.linux.dev>; Mon, 25 Sep 2023 15:06:59 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC3AF1BF206;
	Mon, 25 Sep 2023 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695654411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oPp5XuXatRm9Q4OsstHkCgwYPN1fAxQpA+XjFwxpLuc=;
	b=ngWjDTPFExhERvVRzpKiapKrxktMWG/DvcqyaKhfDNm8W2mQuCnJQJ0H5ZRk5MGPBO2Dpm
	szyahiT5gGd4qRnLZksGJc0sYRPe5hPnGw9kdUBRZApYBoLoEeZ9YKJBzpSjq5K3StWPBD
	6FL6kJOIKXdnMHZ2X+5hVeIMRiBo/uWZ3ws67bdCnCFXzQ4AdKojJfwHn77wU7CpswWGXt
	UI5LMJgmwn5PBOrn8YcgbPK/hApFzyEDKfydfys48UfaCG4a9XVTzWxkj42UKBGjewtzPX
	qLNMEY+hORmxd83E7GE0WzCp+vX3BY1qO/qFm/ZTEn7xTo5pTH09QiRMzkl0cQ==
References: <23cc119f-7301-49d8-9a95-03ff9e061ab1@siemens.com>
 <20230925130311.17757-1-aaron@sigma-star.at>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Aaron Marcher <aaron@sigma-star.at>
Cc: xenomai@lists.linux.dev, richard@nod.at, jan.kiszka@siemens.com
Subject: Re: [PATCH] lib: Drop cpu-affinity=0 from skin-tests helper
Date: Mon, 25 Sep 2023 17:04:24 +0200
In-reply-to: <20230925130311.17757-1-aaron@sigma-star.at>
Message-ID: <87edime1h1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Aaron Marcher <aaron@sigma-star.at> writes:

> Alchemy, pSos and VxWorks tests assume zero CPU affinity, but we cannot
> enforce that in general.
>
> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> ---
>  lib/smokey/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
> index dfd63b409..b50d9fbb1 100644
> --- a/lib/smokey/helpers.c
> +++ b/lib/smokey/helpers.c
> @@ -416,7 +416,7 @@ int smokey_run_extprog(const char *dir, const char *name, int argc, char *const
>  	int ret;
>  	char *tst_path;
>  
> -	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", dir, name);
> +	ret = asprintf(&tst_path, "%s/%s", dir, name);
>  	if (ret == -1)
>  		return -ENOMEM;

This is going to break the tests on SMP, because the test logic checks
whether some series of actions happen sequentially, in the right
order. Allowing the threads to run in parallel on multiple CPUs would
prevent that.

CPU0 is by design always available as the boot CPU.

-- 
Philippe.
