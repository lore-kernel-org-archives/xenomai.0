Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654693822B3
	for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776086439; cv=none; b=s6/1jCeMehhj5SIqNmGRaqopxs9BWKmfrvj5nNhNXlu2iRuajhr6dsNrgE6gw2/Jfa+nrms6igS4mlU4gGMtb0hF6+LDt7M6JQ9iy99FR8Ez0yv4TPL1sD7xrF5MqIZk4VxSLoCn81i93QBKHJFvfbzsYcsOc7UqBuF6ksCM31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776086439; c=relaxed/simple;
	bh=YXwSIy5KO/wEWUjuJFVAULNe/8tZhHdevZ735tjwIwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EAoL1JUxOur1tGBXUV1zGfHwkGZiXXjbEpC00gH0GFKHT0v5xQ8vCv8t044YiAnF1lEAvDWDOpd/cWGz6jE7fuFs8YGU+X1ZUif9xLVHIJqi2vwgl3vocfkxf93ZV6bP7zftEckTS78VfuJTSgxlQxEINQB/wMVNIKX6DRptzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=dxLPJxt7; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="dxLPJxt7"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 45D9E580CA1
	for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 12:47:35 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DED021FD19;
	Mon, 13 Apr 2026 12:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1776084448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyACpYwaVomWiv/Z1Q37Ax2Mkb1cSfcI8J3INWQXAAM=;
	b=dxLPJxt7WWNpJHjqXK2p4mHmFFpvr61bTK0om7Qe1IMX4SaIhMeyKycleOVOYpIWpan3L8
	csWj7la2/O/gqkitWFzk5gbhjxpOF6ybvWqsrty7oX1S3ZqkcmymcQR0RMmT8a2ffNw9wk
	ewH8whK2ToFAQQ84uXDaXSanqLvQQctxXHITTni9E8YmJBOK47UMm5jVBxWjikfu1qj50u
	Ew5ACFjveBwQyG+NyeY4mgm0WQ+hvo2BfQUXIxaXwaAXMlZwJOsh3ZiiJG7zew+BJlHUH0
	pcrREVhOgX9PQzs7nxz+VknjtPcEv/yvrAbF9YtrTxSfR4bOWVeoirhVWCaSWA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH 7.0, 6.18] net: dovetail: Fix wrongly merged comments
In-Reply-To: <2a30aada-ea67-4cb3-974f-a06e79a72d37@siemens.com> (Jan Kiszka's
	message of "Mon, 13 Apr 2026 13:12:07 +0200")
References: <2a30aada-ea67-4cb3-974f-a06e79a72d37@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 13 Apr 2026 14:47:24 +0200
Message-ID: <87mrz76n8j.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEC8vsyGKn8bHiGYXckw9jYpm8/65H8gY1e7c0EuoC+QfADXlvgWmxWN7+nt7HBx+XwxIwpU+cSfQabdluw8D1yI5qHd8zizx6DAeCeyj2H2t34qezBxnhQh82w6+2Hj7jn/EFXmZl0aUKLcR3qvtzHcGUX2k7HGVs5v1+H1DvkAKuVo8ugTmLqrZsYB/0H/5o6lubKKOv3lToUFVe2zfytZYKI48KXSykMakrwxuPy3PHeViHGfsHQ2noXm1I3KMkmMP6NaEnVltsCL8Jz87tuUEuvybZBxU1kBKR/XgxABQdd7cqxjE5b1R/TILnJd+zDMpDBp6cqvKTHE8ywo3QAQREQcQts5M/LvCu5iF32MtLie8Lqe/ULa2GRoJ8/Ltj6+tucEYV7S2MmgXttXLGELRZ4hwB8ghvoiCeM3PX5Zvet3pCW2EjxNjB9O/nqqTZjAQAzSsmg+zo63CopSXUGXT6Zptdyoo0zUtCQc+UHHtxBJMkXr4kW779MWwNWd+CmYIb89jq7y7CQQfH3UwaKNwCKEJ44YkMtsXUupMb7+vMsn0Cd6o8vWVf/W8A/rRKk8XjkA7GID3/1c324U/FVP4tdOyhe+4f5ZYf5fMMDHd1K0b91tF26Ew3SxQZw6EPBVpa6pXY6zpVncaTup8Ow92VRgmsxfLQ2hQZbC+CPYg

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> No functional changes.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/linux/netdevice.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 2285dec50589b..b59673d4f3fda 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5001,18 +5001,16 @@ static inline bool __netif_tx_trylock(struct netdev_queue *txq)
>  
>  static inline void __netif_tx_unlock(struct netdev_queue *txq)
>  {
> -	/* Pairs with READ_ONCE() in netif_tx_owned() */
>  	netif_tx_unlock_oob(txq);
> -	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
> +	/* Pairs with READ_ONCE() in netif_tx_owned() */
>  	WRITE_ONCE(txq->xmit_lock_owner, -1);
>  	spin_unlock(&txq->_xmit_lock);
>  }
>  
>  static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
>  {
> -	/* Pairs with READ_ONCE() in netif_tx_owned() */
>  	netif_tx_unlock_oob(txq);
> -	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
> +	/* Pairs with READ_ONCE() in netif_tx_owned() */
>  	WRITE_ONCE(txq->xmit_lock_owner, -1);
>  	spin_unlock_bh(&txq->_xmit_lock);
>  }

Merged, thanks.

-- 
Philippe.
