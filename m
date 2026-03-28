Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E13913B5AE
	for <xenomai@lists.linux.dev>; Sat, 28 Mar 2026 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693852; cv=none; b=hsWUqn9Z7TwwUW6vHdR1hi2iNqHac/xDrcydrI3cIdYhv9HzRsIOEzW5O9IyACmcQh/sYwn7n7QGo4x8Uu/z6sZd1g+5QVqfyp4MnhUW1M39Q+3PCfOiUIqeHLoANpcb0s1XsLdWQDO3Vv6LWnKbJWMZZkpfn/thDvHEQwFq1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693852; c=relaxed/simple;
	bh=ivZ6WyAGQXe/i32TeirJAIxrQMy8C6c2QfytdC3LTt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rSJjGI0maJXOdJC+WHUNWn0zV6AVoSqc80VyJYsYQJJ5zH5j6tnRcv4MnRkys0sI0MZl+FcnaATqJwyBAXpUvHX7nkDkDPsSxLyLvpo0YEZ9E36KUT5o2wxYqfU0JBjocFCIu6HRqldFvff8MTNYaBL7mzFcvPld81KxDQg8K/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=E+CXM7H8; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="E+CXM7H8"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 9E0B5580CC2
	for <xenomai@lists.linux.dev>; Sat, 28 Mar 2026 09:50:15 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 412DD3EC03;
	Sat, 28 Mar 2026 09:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1774691408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=krRW6nZfUH+9of74nZCYvRpBsEQgCOrbSUqilpdtIJg=;
	b=E+CXM7H8Myg727kDSupXa+GZaAi4GtwB2gcMQgnW2Xi4uMbYf7ApwJ1/WhNyp6f12FSsQZ
	QQ+U8jlP2VGCMHu2eqXhVLpzl47aT3PbNC9awEd62PUSXE4YKyxGFWkruh3JKxpGZmkhQp
	ZGsiprz/0/bk2QMimtihOsodgxIdiCc04eX8UR+ZQ9iVOZ+WAEoaJe21BWGjBKg/nnUFIs
	cBibU7TUacp+Bgyh9ybwZ1NsKE86x3mhbD0GYYMKWoZ9urK+jN5P63b60Y4nuI4UsiWgMi
	TL3Lk0KbdEvaNbjZR3Wh3dm9xnONxibzUe+ffQZnPsO6CwvvnlKwmQ2JVuF5IA==
From: Philippe Gerum <rpm@xenomai.org>
To: Brandon Ho <brandonho667@gmail.com>
Cc: xenomai@lists.linux.dev,  Brandon Ho <brho@relativityspace.com>
Subject: Re: [PATCH] release oob skb when received in-band and fix
 setsockopt ret
In-Reply-To: <20260327184718.580694-1-brho@relativityspace.com> (Brandon Ho's
	message of "Fri, 27 Mar 2026 11:47:10 -0700")
References: <20260327184718.580694-1-brho@relativityspace.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 28 Mar 2026 10:50:07 +0100
Message-ID: <874im0b7w0.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEvjpq+PlYmRN/eaR0LfjOxBwaV1Da+rnqCYy7r+3A+eN8nXmpJJL3Ut1HJI8Km1HHkf3s19Bc2WsgS7kPvaNjJqMA1LGZoe6ZeesRFHFWr3hLD4/mxrjQGVQ9p8N2InJInkY2A9hFfmS6N3y0SDMRBnMQflKQ3wBby45T1heocfypG2qHaoC7U3OYT1TD2Y+Su4o0L82+O9SBDHQnva48EL5Xnin8U1puZImANbz/SQQ/K4lR+HbgdjsCLtyw73phygas3uvGBW62jKuhdmoZS7mKpb6BlZLw7sQ8tTu0/OyZB3n/8dEdgu4mICg0NsL9Q4c0ysecGeyfupxcHjP7+jqVdaRv38no77qeNodh+7KH5sgNJLKnDXIsAsM8zPKDYh5gpvQxRrMm0b/GGh9EX+3yIDcfE1l/fcTYpykmaQ8Yzya8iGBLvAEMNgFHmqHgAvQrJZDQUrDlUbd0/QSrtYwGX24Jw0KDJ/D3WGYdSMo05F/AVWYmeLFhB0TgHm9It4nmeQhy6aT0u7d0NMM3DHQZl4HjFWNUBNKVcSH2YD24eth+Zj30zk+dW9nVSJKJIakCip65HrFzYy7JRevaNn9f815XoGY3rIptqhG5+04XYexWw8HYrcSyepJzCcrIqLma/RtnZQ8sIG0Js32isbrbLEmY5R3i9qlUK6Ro28A

Brandon Ho <brandonho667@gmail.com> writes:

> Signed-off-by: Brandon Ho <brho@relativityspace.com>
> ---
>  kernel/evl/net/skb.c | 3 +++
>  net/core/skbuff.c    | 2 ++
>  net/core/sock.c      | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/kernel/evl/net/skb.c b/kernel/evl/net/skb.c
> index 50090c181..9cd52e3e7 100644
> --- a/kernel/evl/net/skb.c
> +++ b/kernel/evl/net/skb.c
> @@ -55,6 +55,9 @@
>   *                                                -> free_skb_oob(skb)
>   *                        -> dev_kfree_skb(skb)
>   *                                -> consume_skb(skb) [1]
> + * 			   |
> + * 			     __consume_stateless_skb(skb)
> + * 						  -> free_skb_oob(skb)
>   */
>  
>  #define SKB_RECYCLING_THRESHOLD 32
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index e532fd636..b4dc5e1c9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1621,6 +1621,8 @@ EXPORT_SYMBOL(consume_skb);
>  void __consume_stateless_skb(struct sk_buff *skb)
>  {
>  	trace_consume_skb(skb, __builtin_return_address(0));
> +	if (skb_release_oob(skb))
> +		return;
>  	skb_release_data(skb, SKB_CONSUMED);
>  	kfree_skbmem(skb);
>  }

__consume_stateless_skb() should never be called from the oob stage, or
receive any oob-managed skb, which makes the redirection via
skb_release_oob() pointless. Did you identify any code path which would
hand over oob skbs to skb_consume_udp() for release?

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 3321ff386..70a313c1f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1721,6 +1721,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>  			goto lenout;
>  		if (ret != -ENOIOCTLCMD)
>  			return ret;
> +		ret = 0;
>  	}
>  
>  	memset(&v, 0, sizeof(v));

We don't need this, all following code paths either assign this variable
prior to using it, or simply return an immediate value. The original
code does not initialize this variable on entry, which confirms the
latter.

PS: on a general note, please split patches addressing unrelated topics.

-- 
Philippe.
