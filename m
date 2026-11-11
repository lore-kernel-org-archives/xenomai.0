Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390264;
	b=V/mztvK7oDHbRTeOUitmnloRHxT60pWHnZH4Ep5YjZJRniLNDMiwGWI17oUen/ESH0uN
	 S0Yo6xpzxxWaK3cbomnTrdHzH+byoxYf7OLrLvAx33GIWBcKMD/EZrksQd+oTq28Eiumm
	 brTGk+X6KELjoCYpdV59m6QZmByu/ONQeF6Ka180AKUYi0UFdSqHZIcf8UN0sbCEnS8aY
	 jS/otgFsdHOplFEp1O1tDkoqE9NinQbE5yWPPA//LvDJLP2TevYh0DnWtmvRZmixvbMWw
	 6F2urjIDnZghK1IlyugtpKeT4sEuB+1h8jxH+HOCXhJA3++yBXfHT8YOYI3pRNp9gnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390264;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=en4CUy4S1sW0c2qBtrFEinl6guZj/SPH/VHsAtGncNM=;
	b=diJmggHqhk1qZF1mM9RUvrUj3FKd97EQz5wK7Ib7JGv3+Ffus8PXXQYY82jPKEEiLl3l
	 pyhRcpmdfR6j18FPmnJSnfQSvuGnIzcFn6F6LDyDRrEI3qjlubjzDxn6csURvGECXU8pN
	 BvdP/XXU35C6R232FmUnUkssfV0Ip6L63CgrWFSHJdesmld5TQzS3FBpdTO31qojpZwam
	 wZMeypNws5eFswgRhfDqffsFfm+uG+kueKK/gC7ZLMPyGc7KRBv2sC4ABNcx+LpPUH0wC
	 llo/MB+EnKENaOhRddUULf1YSwMsDd9Gx5B2cvpZ0Ad8DBHwZsYCN9Tyz57lX1HJb7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=fgRK5c6j;
	arc=none smtp.remote-ip=217.70.183.193
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E4606A321
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 09:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C6E4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=fgRK5c6j
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E3973EBA1;
	Wed, 11 Nov 2026 09:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794390261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=en4CUy4S1sW0c2qBtrFEinl6guZj/SPH/VHsAtGncNM=;
	b=fgRK5c6jjJS9zreHJ/ywvs/zxJUYGQKkvfFkwNwGUveOyPv8yVswx5Q6jLTljpmm9KojQr
	ZGWfYusD2IZqOeeK85v//9Tp354CAIuS5twXIqlcZcYWzSJbvboengu1i8pbf8d99OYN65
	tHHRXCriiKMI4rf3qdjD5try8oES1yXZWQdF5kXvc6+/Jzuj6pBcWtcr+/r6EN9b2/sQgD
	FVToF5rBnwox90acxN5E1ein6J3Tmk2K2XAKZK2uJnjH8fCzrrubUaYYfhCZEYW30T5AZ8
	aGbL2CVH3wnUEiEcVpYIgqPxO5HgHfy9xLa4zYflZ+esxwgGMpy3x1nAU+0Wmw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [dovetail 7.3][PATCH] net: dovetail: Pick up lost return code
 of packet_do_bind_unlocked
In-Reply-To: <3a6f9b1e-dbab-4aad-be69-3fdb30be8545@siemens.com> (Jan Kiszka's
	message of "Wed, 11 Nov 2026 10:15:05 +0100")
References: <3a6f9b1e-dbab-4aad-be69-3fdb30be8545@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 11 Nov 2026 10:44:20 +0100
Message-ID: <874idn66tn.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGDXAuDYjtZacsUSG/nuXkyxVs1eEFkCz7MuLQlFyTwQ93kkV1womu0SKd16zbNzClVeTfuqbAXNcRrOUA3v4Lb2k33CfBJtlvpCusbrVaKLtP1LHCpE1LQs+DFzEgDWZCsKt/sNPETLt+aDHHAq1vh9DZnXg1ArvWzfSsGdkcwn98oGaGziW3qR0lB0RSSf9loZKidJtO8wxZ3Ulzji91EStnFX+k65ZFQrP8neUnaTxV3Fkhqqi7QxdiQZGmCP/zGZ6VJ7P6H2JdjVvrSmF9KVTHvjPh9HSn7+D7HxgGqmGGQ9SGEpdydTgyHj+fUb8IM2IC59SUGmp59lpMBMrd3jhb/Qvi8fnJ2VM0N7om6epUcrJIRPds3ttTdJaR1QK6MNIdF6ul3R50SCW08jdveFrl745H4aygwjrcaXUSfFJ3Bs+0h1hoC9kaSyu5wCPRJZFjFc1ixfGi0tMWlrheLzpmVG+d0CrED0QJZLe9+U/hEUk3ds2OgI4LTHz+hQLsXCgUvAey3BSVWa3sJh4Mz2Zrcu5A8E2Q0lLU3N+h878HBqQvnsD9cqgH9NHIASJ8eFs/7VavS1DU+pP86/wtrNtWNyHA8ukw4yjSjZQHnho+cVtJ4+gYBiVL6Ct12Q6vGEuIXY3PU8vAVcLkIydngGQk4qnclz+rHGoJANNG1sA
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Results in missed errors and uninitialized usage of ret, thus random
> behavior.
>
> Reported-by: opencode:Opus-5.5
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Apparently a regression of the 6.19 forward port.
>
>  net/packet/af_packet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 6ebeb3f1f5811..53b1c35423699 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -3371,7 +3371,7 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr_unsized *uaddr,
>  	name[sizeof(sa->sa_data)] = 0;
>  
>  	lock_sock(sk);
> -	packet_do_bind_unlocked(sk, name, 0, 0);
> +	ret = packet_do_bind_unlocked(sk, name, 0, 0);
>  	if (!ret && sock_oob_capable(sk->sk_socket))
>  		ret = sock_oob_bind(sk, uaddr, addr_len);
>  	release_sock(sk);

Merged, thanks.

-- 
Philippe.
