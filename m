Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD7823DD
	for <xenomai@lists.linux.dev>; Sat, 28 Mar 2026 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774690469; cv=none; b=a6cRS1j0BmEoFuR1g9pBes5vjplCOpDnoHmpcQKjVeR4ApgxYoxtVt1IiHMWxRIgmkaaDzMsCVvXh/prUO3zERybVgWwC3swQTNMbjOqQeuJTGVcUnKXQ3mzaJjbGBkCaOnAQLAHViEGo1Bx85wd+rCXDjlUABr5FmWkCqKGRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774690469; c=relaxed/simple;
	bh=HDwY82zqMKRQcWbRaRjgsbTztMI7vUnpXx/lfrOjWU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKE1jafVQjVFLBYaCJ8sO95d962MJ6iPjAo8JcjLtZvMNHgsB/4Y4H6anq4QzuLdLEWpjS1F5yXABYTA8+p37lgi9a16Qs/ZCwk1hCRS+pDzMUanz3BLCwrFAQ2zjPoaJyWF4rDdtNTqypj+nPI8PNwwhSCl3Dc3/eaKvsIdtRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=meU6s59f; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="meU6s59f"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D3CE3E970;
	Sat, 28 Mar 2026 09:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1774690459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YsWZjH+JrXZ2urIeAyNn+ldMDTL1EcBDU43/4KAN2AI=;
	b=meU6s59fComozmbZG7nkWYbDUqxAG+aqfrIl8kE139ZfJ9uE/1Qb+xkyuPaJ9MRU4G0QPK
	KkBzo6ezjVywkO8J7C4o6rxR/kRvK9+Lmi/7ISXfnZVYvBgKbcAcIOTiwFBBm5F3AMYqo5
	+/1YLe+Y0nO/EN/JnEWRbI0NQXsrvV2PShltYSfVySGQ8+wMSrNORP5pQ36OAj/7hWHSKo
	gJqPUosUJIafoIwdoNHznWmoPZhDfRmzUySsX6zIPinaaIzBLEwYMB8xgTi7HoCAHrFMTt
	wD0AobHmPD5WwWnt15PcdgLxsbbgIcdXB7PnTNlTWdWbK4liwQIz1Lk8/j0l0w==
From: Philippe Gerum <rpm@xenomai.org>
To: Brandon Ho <brandonho667@gmail.com>
Cc: xenomai@lists.linux.dev,  Brandon Ho <brho@relativityspace.com>
Subject: Re: [PATCH] evl/net: rx filter precedence over loopback
In-Reply-To: <20260327202446.592184-1-brho@relativityspace.com> (Brandon Ho's
	message of "Fri, 27 Mar 2026 13:24:38 -0700")
References: <20260327202446.592184-1-brho@relativityspace.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 28 Mar 2026 10:34:14 +0100
Message-ID: <87a4vsb8mh.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFCEaGNyUwg69+YIOGLjHXNUzdsry3WgNLbWROZDGFMeZzqxLEHl5mwdP/B6+zmwJAO9170Bp0Ore7aImC4W36I3UNzANj4K6NZUom5vo4fFQrmReCXdQXeJ3b/LF/ylq9LnhoTbix9BQlAxPexzUWcgLo5RPPVtzof5vW2x2rpXrbFg/Yz8XoILOAqWnPCssaKRFIPI5IpXbJ+awePZxbvRvXNqHkjKZANSkcbraLsKBjlVYv2XMcCiRz3aJs+jT8YYpumQNwP7LEbgqnC/VXIrzJO+7NL2k06os80CEMwfVYeLQTfvbuCNU/UHet9DpJF9z4aQ8estKjOSFq0FCN/HjOcgVAAhrh+NknmrB3tS1vxB4jh6t5y1W4GtEMnj+q2jXhNS/jYh2sMk233UxHSv4DqcpBSWHRTM2hYNDNKZK3Zq7eMP+hUTgC+VJqLUL8FVDW9EuzZ9PyX2pstwZSXx6JRbzRcuBL2xEi0+RZBCdtdU00ckgCPNyKUav163uAqwJRPKSd+0/Ypa5Os5fBv2gORfLwQg6p54FWdIgXwgqLlLRfrwdc7Im7/dy7QIvv2figYps76lcFS2XvxBYN5QNbxXUIlKwJRf2eAhJDe15Es2YyT9RP9dq1L3UI1tnthCm4gRfpPkzlCvJIjyGb6OaGRFFqAcQUYqdgYnXo+Lg

Brandon Ho <brandonho667@gmail.com> writes:

> Signed-off-by: Brandon Ho <brho@relativityspace.com>
> ---
>  include/evl/net/device.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/include/evl/net/device.h b/include/evl/net/device.h
> index d0085b3c8..b8ed44377 100644
> --- a/include/evl/net/device.h
> +++ b/include/evl/net/device.h
> @@ -53,18 +53,19 @@ evl_net_filter_rx(struct net_device *dev, struct sk_buff *skb)
>  	struct evl_netdev_state *est = dev->oob_state.estate;
>  
>  	/*
> -	 * Unconditionally accept all traffic sent to oob-enabled
> -	 * loopback devices from the oob stage. Those devices are very
> -	 * unlikely to support VLANs, but we could still use a filter
> -	 * to accept in-band traffic, so keep on checking for the
> -	 * latter.
> +	 * RX filter takes precedence over loopback acceptance, because
> +	 * it may be used to route packets to in-band consumers.
> +	*/
> +	if (test_bit(EVL_NETDEV_RX_FILTER_BIT, &est->flags))
> +		return __evl_net_filter_rx(est, skb);
> +
> +	/*
> +	 * Accept all traffic sent to oob-enabled loopback devices 
> +	 * from the oob stage.
>  	 */
>  	if (dev->flags & IFF_LOOPBACK && running_oob())
>  		return EVL_RX_ACCEPT;
>  
> -	if (test_bit(EVL_NETDEV_RX_FILTER_BIT, &est->flags))
> -		return __evl_net_filter_rx(est, skb);
> -
>  	return EVL_RX_VLAN;
>  }

Thanks for contributing, appreciated. The change above is superseded by
the following (recent) commit:

https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/0bf66e53dcf91da8b3a8c3283cb78ff17712c670

-- 
Philippe.
