Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDF39B49D
	for <xenomai@lists.linux.dev>; Fri,  3 Apr 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220835; cv=none; b=XwmND7tohDF61m30Pqs273Dy4W0B9zw2+h+jj1LR0ftAemTssQi58pYFn4Il//gOssIPb5f1mW+tZQnMm0vrC3wK4d9QqLJ4XrkO/nirZ7rOWZDpPOK1POuttZR0CCOOaW+vtnrYMeD4OrxyV9WQ6JL9y/2VwsNAGnzLmdfxENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220835; c=relaxed/simple;
	bh=HbnqNZeD5bfAiQdHBA5zr6tzsZbwaO32FQsNJu1Gs+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uwsj4CjXUpxCOr9xwPHiZulVFk5QeomRJ8NDPw4D9/CB6ifCcWfaeMKVWtqdjmI5yhnNyFxZsfiEEZbAUZvdiOUQP/6iTnoeuZFMFvspKR4jxd2LVUK707pyLyBWW+TWd3sHRvRvQNjcooKeZaPkUAtQ/Gx6ucLfln4zMeXQB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=XjF4AJGg; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="XjF4AJGg"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C95F3EE1D;
	Fri,  3 Apr 2026 12:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1775220821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N9rblPHzjWU++1jUKyynewumtDVVfqqb5zJaFYqgJg4=;
	b=XjF4AJGg4e+BdUJIFFLPpLP2M2DypV7M3p/2R+6CNwHlyPudM8NcUXDxl6ew0AGg0QLlmX
	/+BzaaOJVAEL08VArMgiFV1ZmfUJYBfug0OdPbfedYbeHYlveqrbOdne3jOWZgWh7oX7Af
	G46ymr77Ixq0x5DP7/Hg821+C7AzW8+3CiOSQxc8nmygz38gy9VUpXlrNoDhj1Mk0nYBba
	WmSA1Wxsft7auemhKu+4uv8F8KyvHKcZGz6DuwzpT/fhBobpxta0snaUGkHZaea7oP9JRg
	tlHjmEMRt83SVs5P+Nh9/JOUol9vMHxrXWE6fPVMxN0D3usBAL0BNWePXCN42Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Brandon Ho <brandonho667@gmail.com>
Cc: xenomai@lists.linux.dev,  Brandon Ho <brho@relativityspace.com>
Subject: Re: [PATCH] release oob skb in __consume_stateless_skb
In-Reply-To: <20260331223817.136912-1-brho@relativityspace.com> (Brandon Ho's
	message of "Tue, 31 Mar 2026 15:37:39 -0700")
References: <20260331223817.136912-1-brho@relativityspace.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 03 Apr 2026 14:53:36 +0200
Message-ID: <871pgw19yn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTF3U3Dwgl9iFQAaeDaVDpQpB46RMWu4jT88epufy8sxz7iW3J/Sm3VlPf6OYJvXMR+amm7kwTAkf+QcrsjR2Llc3SX90M53hMj26YbDEkK80pl2ii2kvYvIWe2LOqvRUmgbnkhXG/kLNC3n84UVj5h0mfOgmgmUyx0eyeiq8c/qlNzX1cl7YaE5sBa9bu7sX3SIJPM9M4Zgl4L3HFMkKk/LqBG1UGHEUcD7Se9S3jzTNkX9J88XEBYexaTHs8czBEMK5i1ouZza8VUqWxHdHqLYKXTkrx3zDa9ha0zaFymbieCRsS9ZsesIqh3TwNg/I7UlLP52pV90pB72jAuBZKTSqcMVw+WeD3CnPRB0l0kgWfK1gzjDAI07n9ZuPu/Qba22XEoraBJpxc7Y+8ztiBcsdd/oMrmKYcnvuwu5S+GJSrnBQ4gcMDCe0+VviwWEsqEV8kFccihCi7UQCLKMOsNetvgprEJBogrgxLJKwNA7fNXDYFH7270Tav8FnygNfrzZVXYucBEmuwVsXN4lGW5qVoMdqRz5ZkwfZ01HFXIYSg3SKYUw75vOVmW/hEVnNSu6Q+FJSsynJkYGEpF3sCz0Ys3BbHXexR08Qk0/Ytk8MCNEv+te7Um6eOQz0zNleYyPjp8wO3TLikNSjEZRu7RK/soIEGiKo0qpvbFYig4+8g

Brandon Ho <brandonho667@gmail.com> writes:

> When an oob-enabled driver receives packets, those skbs are allocated
> from oob pools. The evl core may leave some of these packets to the
> regular network stack for handling based on eBPF filter criteria.
> When the regular netstack eventually consumes these skbs via
> __consume_stateless_skb, the current implementation does not release
> them back to their oob pools, causing a resource leak.
>
> This patch adds a call to skb_release_oob() in __consume_stateless_skb
> to properly return oob skbs to their pools before the standard skb
> cleanup occurs.
>
> Target kernel series v6.12.y-cip-evl-rebase.
>
> Signed-off-by: Brandon Ho <brho@relativityspace.com>
> ---
>  kernel/evl/net/skb.c | 3 +++
>  net/core/skbuff.c    | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/kernel/evl/net/skb.c b/kernel/evl/net/skb.c
> index 8efdca1da..302f79dfd 100644
> --- a/kernel/evl/net/skb.c
> +++ b/kernel/evl/net/skb.c
> @@ -55,6 +55,9 @@
>   *                                                -> free_skb_oob(skb)
>   *                        -> dev_kfree_skb(skb)
>   *                                -> consume_skb(skb) [1]
> + * 			  |
> + * 			    __consume_stateless_skb(skb)
> + * 						  -> free_skb_oob(skb)
>   */
>  
>  #define SKB_RECYCLING_THRESHOLD 32
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index e297781da..e08d0bc54 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1645,6 +1645,8 @@ EXPORT_SYMBOL(consume_skb);
>  void __consume_stateless_skb(struct sk_buff *skb)
>  {
>  	trace_consume_skb(skb, __builtin_return_address(0));
> +	if (skb_release_oob(skb))
> +		return;
>  	skb_release_data(skb, SKB_CONSUMED);
>  	kfree_skbmem(skb);
>  }

Merged, thanks (split between dovetail and evl trees).

-- 
Philippe.
