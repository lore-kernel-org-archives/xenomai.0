Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351017;
	b=dzOjYKoxXL8rHSYIZYzIfag2nc7EpHSw+x2nu7yaTfvPYBbjzKJl+h022G3Ax+lR/H7v
	 AV2GGLz898x+KrraRDHuITE8ZqImxIjV/Bj4kBuTMmGZND1muhAKsWXzJZ1rjsemnHpnV
	 RvqIyKJgMF6xqCC3hmUs9be1HfReo2DPXh2wShztsIaNf1ly9dq7HQ0HHIr3nx1XMqH/b
	 lY9fMUMO7AiZvS62XOWgav2Vr0Uclh8xQQWXS0Qq9aBkj+O/eCFxL+QnaeDo1aNXb+axw
	 tzckmmh0OOh0R/VQTj+YUXUKHMKrlzusnlZ3nkGh16AJN91kHdUDquYah9kNU5Yp3HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351017;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=8mPkHnU/ON7NYA+zvXpe2MBWxIddy0zg643dJ7rz7eI=;
	b=yyQKfE6FtchYw5lS6zibrmuT8/SQ1I7zy07K0vQe7equwOTdAkhAvO8jGL6YMNqz69zg
	 e9EnoghnesPdnPYjMPADZOTPY+d6KiRIgtooTFhii1TbhLwycJRfkbxZo3CdfRh4NWcgb
	 aKLGwWuK+vpd+mBnmePRnrHR69kXaGrQPRsELWfZ8aMwszMyVJ9WGguLypZ+i53y4asux
	 Fx/0bIebzN2ZwnITXmcUxZDuPc14qMacPZ0cL/NS6I52DkoJ7MmtTLvsRmY4+b3Tn5to7
	 0Nn+3btlK4G5myxrHAhZdF/zBomnsk/GI6CD12E9Npum+MCvSg+wIvlhNCXH38gM4Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=dvLhMCqZ;
	arc=none smtp.remote-ip=217.70.183.193
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F077606A31F
	for <xenomai@lists.linux.dev>; Fri, 30 Oct 2026 09:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F077606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=dvLhMCqZ
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EE3B41D3D;
	Fri, 30 Oct 2026 09:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1793351012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8mPkHnU/ON7NYA+zvXpe2MBWxIddy0zg643dJ7rz7eI=;
	b=dvLhMCqZGad7EFoBB+3HW6Id5f/DXOx2EzfRuQItOcBKyCctXabPtAKvHi0ttkzpcrsByn
	ebMrzpXMzWw6xCX2FPF7yiAs5DQt61n9zYUdmkJkKCZc4yGxDP5MXtrKmrrbiXdPQpW0Rc
	/bkkrKbkBiASziFh4ngKxZtHiiTGz57+xDaUO8zi+vuC7xr367yap6DtIHWfvY5UZF+S8O
	zReSI7Vf5GIJzDBQMg7KZ1uy1+3YdUQ65V349d1eGBaY7xy5Ecpv2Bz58bSqUkEXsEeAc5
	jZXkzw2DTrgnjDHYHGQoMGsgndGu0yb1NaZog4emIMSU5p7htoSJh8+Y/uasug==
From: Philippe Gerum <rpm@xenomai.org>
To: Luc Montier <luc.montier@etu.unistra.fr>
Cc: xenomai@lists.linux.dev
Subject: Re: [libevl][PATCH] lib/mutex: init recursion count after trylock
 via the core
In-Reply-To: <20261029082848.22006-1-luc.montier@etu.unistra.fr> (Luc
	Montier's message of "Thu, 29 Oct 2026 09:28:48 +0100")
References: <20261029082848.22006-1-luc.montier@etu.unistra.fr>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 30 Oct 2026 10:03:31 +0100
Message-ID: <87cxsrwof0.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTF9Qk422eA6Na3/jrpfQK90L3iVno3QxYE7U2n02uA0PbC9lKDbR+jH8a9lgUEi+nRMOUee5FFUa4ZgbpP4peA64tMlSA06G7Vsg+vpmKE8YvZ1OMielUtu6gFqwf9fZO9Y6/Ae5upcSwu8rNKTvGToCb5bfM8wrcb0XYZzaKSHKlR9EtDG9Dsn+Om2AMDqqShNBsrz5vDBZE6lKBG30aPtnRo+BQ8f32R0mWP/QSLabdR2biEu8ThbzcsqV6uBN1b+sjwvNoOOIcFK3LAhTC7oSZV7r558QBjkvGEXR+IaCT6VCY2XnmGFDs4dX69Cz44GNg/Euf+PAdSzs9ARWdi9HNIz44Yrd/kXRXP5CybxzA9kc8J+LFFDcTTjw7BGfKxcaXwVTuEE80ywYWnJQPj5yoWrUnTbGhXSdf9sPLq59Mqxw7u2vlkkqxKs4IGWt2byG+h2q0l6ER3ZL7VJeIlC5/75M0sDTPFlwdWFklvCxuEUyyApLR6PHWkWtgCi+YO5wfZopiSprCC43apOFkyPC/cmU35kGZw5LGUDkGOaYrcjT+aaul///40DjQqw+uBIwWco3EXUMp6QuFEeNAaTkQOhPeIbDmTup5uk+i4iUqOXiWU2SuRILsm9ahzZttUw19QodEgnSv/wHzwAmYKut3oModAcjUPFId6PC+pqUA
X-GND-State: clean

Luc Montier <luc.montier@etu.unistra.fr> writes:

> evl_trylock_mutex() takes the slow path to the core when try_lock()
> returns -ENODATA, e.g. for a thread running in-band. Unlike
> evl_timedlock_mutex(), it does not initialize gate.nesting once
> EVL_MONIOC_TRYENTER succeeds.
>
> For a recursive mutex, nesting then stays at 0 after the first lock
> instead of 1. After N successful lock calls by the owner, nesting is
> N - 1, so the (N - 1)th unlock releases the mutex and the last one
> fails with -EPERM.
>
> Set nesting to 1 after a successful TRYENTER, as evl_timedlock_mutex()
> does after EVL_MONIOC_ENTER.
>
> Signed-off-by: Luc Montier <luc.montier@etu.unistra.fr>
> ---
> Hello,
>
> This patch is against libevl r50-5 (e7dc1af, Jan 2025), the version
> that matches my kernel (6.6.74, EVL ABI level 37, Raspberry Pi 5).
> I could not test it on master, which requires ABI 47.
>
> Reproducer: a recursive mutex, a thread running in-band when it calls
> evl_trylock_mutex() three times, then three evl_unlock_mutex() calls.
> The last unlock fails with -EPERM, and gate.nesting reads 0, 1, 2 after
> the locks. With the patch it reads 1, 2, 3 and all unlocks succeed.
>
> On master, this code now seems to live in lib/intrinsics/gate.c. Is
> this already fixed there, and where would the fix belong?
>
> I just want to if it is an issue from libevl or a misuse on my part.
>
> Best regards,
> Luc Montier
>
>
>  lib/mutex.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/lib/mutex.c b/lib/mutex.c
> index 276e77f..832268f 100644
> --- a/lib/mutex.c
> +++ b/lib/mutex.c
> @@ -332,6 +332,7 @@ int evl_lock_mutex(struct evl_mutex *mutex)
>  
>  int evl_trylock_mutex(struct evl_mutex *mutex)
>  {
> +	struct evl_monitor_state *gst;
>  	int ret;
>  
>  	ret = try_lock(mutex);
> @@ -341,7 +342,12 @@ int evl_trylock_mutex(struct evl_mutex *mutex)
>  	do
>  		ret = oob_ioctl(mutex->u.active.efd, EVL_MONIOC_TRYENTER);
>  	while (ret && errno == EINTR);
>
> +	if (ret == 0) {
> +		gst = mutex->u.active.state;
> +		gst->u.gate.nesting = 1;
> +	}
> +
>  	return ret ? -errno : 0;
>  }

Thanks for looking into this. I don't know about libevl r50{-5}, since
we are not adding any patch sequence to libevl releases. This said, this
issue was already fixed by commit 189e496e (ABI 44).

Please note that ABI 37 is quite old and obsolete on many aspects. You
may want to resync to the current code.

-- 
Philippe.
