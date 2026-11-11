Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385958;
	b=CEORAuom94pwWI5pBAsFc0OKf/LEDY+IeQiTPvfS3cOhBWptq7gKrdf15Y7zPYwEZcs1
	 DdRP2q2gBsWj2u41GH9vKkMYy3pqv4oMHVQ1tCq26SxicQJSivXvMCkmBZDT4Yju2Jipr
	 5kl7yCxzUNCc3Pwoqqema2f/KQDl2VCBiDK+vASZRcW6pQqQIocaN9WzDCOTTIZXUBfe5
	 LAWSJRK9PEmJLHH71SjwfOXeO2ZQjZPOA94OKiUkbxIvpZII5W+1KwQEthXO2QhBcArCy
	 4I5GYUYAU7Vw/aRmfqK5TTLosjehgEqxzbCzdvITQqiQv8W1n8fSKrmGpdnHGG8I/gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385958;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=Nh1wEcY5B4OkbGYbKbbmGnhtrIQZaXqz0r4JJzhABWU=;
	b=NSHMe1xyQhEH0HAqYaJgPocyM3hdZ6wzMm6CeXLF+VFdUBYCdULspKEGijWplJxgXAc0
	 gE61gYwNJep1N+jz/6FKV0EmZBXXnXuooawWvUfec6G+vyKx4r1gmWRIDPcOszvjv6U4T
	 ecoo+0XQnHwLBMvRzIlmIwfWHAK1xd5kOo37qWKTe7ydqm7x+IFJxvcXoWGQIYJm5rFIn
	 DoUYHug+/XlYyzdTNtBc0AYetZWX4nvZstABs/xlhPwoWuaMnWy6GoXS5k7LdEpJdBkog
	 4czzIMV1N0IuagVsLLhkGfCN5w6cPL1lHboVUuZZMKrHLpuwkHJmErypz3PaA9uqOmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=o4HB6tOM;
	arc=none smtp.remote-ip=217.70.183.198
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6174606A31C
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 08:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6174606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=o4HB6tOM
Received: by mail.gandi.net (Postfix) with ESMTPSA id 810D63F48D;
	Wed, 11 Nov 2026 08:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794385949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nh1wEcY5B4OkbGYbKbbmGnhtrIQZaXqz0r4JJzhABWU=;
	b=o4HB6tOMz9CxeVMTJ14SxhanZiqBC/B71m4LfIbMa2eJmbvUCf+8X02n/giaK9gE+MuK5u
	L3MHILW45iScYhsMIBZ+ojSaMDu+oNq2gRlzTN/QvAytjvZTe0TniWnqfO1HnqK9anVCmS
	R1wwvrAsInXMZOs5dH1L1WGEkxh1VTYrPsWUODyyO6SClorO00MHMZIGCpUlIE6Qj5/qAB
	DvDHqJege/7PTi1XJvW92gtQt7Y7RY4OTSyC8GYvEsWV2gHgGXeqSLRdnJTEIqDLBpeZ49
	oM8/HvrcG6eTjqn01vouoZUC32EkLZEKe2rp2HKahyHc5stuqogFFucXo/42dw==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH evl] evl/thread: fix lost kick of a thread running on a
 remote CPU
In-Reply-To: <20261110181130.633632-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Tue, 10 Nov 2026 19:11:30 +0100")
References: <20261110181130.633632-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 11 Nov 2026 09:32:29 +0100
Message-ID: <87fqx76a5e.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGQPhqTsoEgDEumFCLSf6GCTbGpOW2WiVhQ9rHfM8OajBYxEt73FkWIaqK1D3zKd+PEDPGSUtxqacltkaFJa9XiXoqSmxj/n3vK1VtzQo8t9GZx7HX0Dn7+0+C1s3bkZBNd0TW7GAhhsUnm5Dbe70nXnUzFAWgUPWmp6aiLzl8YcWnrHO4CwfIrGCsHlwa5nuxNt8vmnqGARMB+wexJ8DkvwQOLVe5t+fe8OUIl+lJv5X3j4pJujSK5M10su1KhtvwUFCTSbOdzpuExEJRse+6wPGiBNUDXaUi1OvVvo6s4L2j6MNg2sEYO/qfavYzLo7i5W5DO8V8ztnizGfW96GLICc8BhwBLkLu94lACJq9sVMhR5jZ1s0dDwG0a8iKVleDlI3bRekdyThHCUX7azyhSvxwObRHPcOztUMh/1TmirNN30C322qcX7MFJ1aEr7bNw6g7mS25kQMLuz404JsPdPlJbWDyU9igdJFUswhA0Bx1piz/JzB5VOq5kGvxlIKeVtBlzcM9/UB9ZYERA9DSzXoxGSDUe9+UPMNh64YmGoax4mIJx5N3+ri2xCHKZmEfE5H9AqX9YbyEHQeOy+QSVfa3jrKe2Gr7D+WOucMVBC4Jt4bGPT/bMx4SO9uGaQpLjP1wTnv9OlmcG9fIevzs2Ccvyr2HbUkgMDorPpOikpQ
X-GND-State: clean

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> evl_kick_thread() skips the mayday if the kicked thread is current on
> its own runqueue instead of the local one. A thread running out-of-band
> on another CPU is therefore never kicked and keeps running with a
> pending signal.
>
> Check against the local runqueue again.
>
> Fixes: fecf5883ecd3 ("evl/sched: get rid of this_evl_rq_thread()")
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  kernel/evl/thread.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/evl/thread.c b/kernel/evl/thread.c
> index 2aa07b494d40..94d073a1b7e7 100644
> --- a/kernel/evl/thread.c
> +++ b/kernel/evl/thread.c
> @@ -1323,7 +1323,7 @@ void evl_kick_thread(struct evl_thread *thread)
>  	 * stage demotion took place.
>  	 */
>  	if (thread->state & EVL_T_USER) {
> -		if (rq->curr != thread)
> +		if (this_evl_rq()->curr != thread)
>  			dovetail_send_mayday(p);
>  
>  		if (thread->state & EVL_THREAD_LAZY_MASK)
>
> base-commit: a3ad77d7ba3eac8a73f64026272747c01dd84fc6

Merged, thanks (upstreaming soon).

-- 
Philippe.
