Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51E157A5A
	for <xenomai@lists.linux.dev>; Mon, 31 Mar 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743409058; cv=none; b=VswN8Ra6DpvsdYP3z6pRkqfO/ArcMyY20hy9fZbgsdfGsHm4PzbWns6dcY5FrVTWxOv1YB5KOHPAu+uxafietMyvYTTuTLI789sflayYQNEiyKGma/K+EXg8mItsHVKhMudgyWPKckK7KFO0Gcq8VqAUTyIdUnLj0zSJjYmEzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743409058; c=relaxed/simple;
	bh=A41dym6hRlJWa7wmUjCtC+FIWJjO5YPjXKWicm/3r+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZLDsvgF7C2ErsR1ziCRSwRIqtl1XtBvaqFpt3XAy22WruWnrw9UeLMQV3pbrWA6ybGrWvS5LnjIIbWLhH4I2p/LevBYE4WwnfIlpiWRrPe2iAm+KtR1SmoAj98PfAphWqgzFTBr6aN7SRo19yuV2F3QyfomaRQr4rcbqds7bVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=UqtSSfxb; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="UqtSSfxb"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202503310817251f6885f046ecc82293
        for <xenomai@lists.linux.dev>;
        Mon, 31 Mar 2025 10:17:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tR/22CcXkeMFVopnVBKp+qAQ9gYGE+AYzJtbkDR93uA=;
 b=UqtSSfxbPkq3/YhqF2ShYAeycXO5PqNl5eKvjWE365XqMn6GXQW3cgJ2sV65EJvyj5po1i
 8K9RxQyRaD2h1aD8mQBIh0Z/s+/kbs6lb3jghnp6bxuFHg++TvNwXEhtQmTxP2QR0th4bnr4
 aJ+DnBU3K9x5NRolUlM8mC6TjePSjAC71+BvjirPT9ER6c5gUO2wgQRNftioFJOPZ28NoIjo
 Sh9nZrg+LgAff82PxNT7bl9TJD7Dm6tK0as9pQxQIC2pS3Q0T1e7vUvSD6YGOJMVYj4zvFpC
 ac3goPd8e9hFdNc1Nc0dFf1BbZ263Y6MKiiZ+bmq5c189iUFnxRJeFMQ==;
Message-ID: <3c057a963dc1abbd5efbed2049e366252f4916ec.camel@siemens.com>
Subject: Re: [PATCH v2] lib/cobalt: Fix a deadlock when release_buffer()
 attempts to re-acquire buffer_lock
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Ethan <aspirestro@163.com>, rpm@xenomai.org, jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev
Date: Mon, 31 Mar 2025 10:17:25 +0200
In-Reply-To: <20250330162941.598668-1-aspirestro@163.com>
References: <20250330162941.598668-1-aspirestro@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Sun, 2025-03-30 at 16:29 +0000, Ethan wrote:
> The release_buffer() function is the destructor function for the thread-s=
pecific
> data (TSD) associated with buffer_key. If the current thread is executing
> rt_print_flush_buffers() and has already acquired buffer_lock, and is the=
n
> requested to exit via pthread_cancel(), the release_buffer() function wil=
l be
> invoked. A deadlock can occur when release_buffer() attempts to re-acquir=
e
> buffer_lock.
>=20
> This patch uses the pthread_setcancelstate() function to set the thread s=
tate
> to PTHREAD_CANCEL_DISABLE, ensuring that the thread does not respond to
> cancellation requests while holding the buffer_lock.
>=20
> The deadlock can be observed as gdb shown. The thread "slave" will block =
when
> calling pthread_mutex_lock() in release_buffer() while attempting to re-a=
cquire
> buffer_lock again. This also causes cobalt_print to remain waiting indefi=
nitely
> for buffer_lock.
>=20
> (gdb) info thread
>   Id   Target Id                                        Frame
> * 1    Thread 0x7ff7ff4010 (LWP 1654) "hello"           0x0000007ff7bb639=
8 in sched_yield () at ../sysdeps/unix/syscall-template.S:78
>   2    Thread 0x7ff7a7a1c0 (LWP 1657) "cobalt_printf"   __lll_lock_wait (=
futex=3Dfutex@entry=3D0x7ff7fcaed8 <buffer_lock>, private=3D0)
>     at lowlevellock.c:52
>   3    Thread 0x7ff72791c0 (LWP 1658) "master"          0x0000007ff7b6d31=
4 in __GI__IO_default_xsputn (n=3D<optimized out>, data=3D<optimized out>,
>     f=3D<optimized out>) at genops.c:393
>   4    Thread 0x7ff72581c0 (LWP 1659) "slave" (Exiting) __lll_lock_wait (=
futex=3Dfutex@entry=3D0x7ff7fcaed8 <buffer_lock>, private=3D0)
>     at lowlevellock.c:52
> (gdb) thread 4
> [Switching to thread 4 (Thread 0x7ff72581c0 (LWP 1659))]
> 52      lowlevellock.c: No such file or directory.
> (gdb) bt
> (gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__owner
> $4 =3D 1659
> (gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__lock
> $5 =3D 2
>=20
> Signed-off-by: Ethan <aspirestro@163.com>

I think we would prefer a full name here, as well as inside the author
information (sender display name as we don't have a From line at the
top).


> ---
>  lib/cobalt/printf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
> index 0aa5940c6..bd2d7de56 100644
> --- a/lib/cobalt/printf.c
> +++ b/lib/cobalt/printf.c
> @@ -482,10 +482,17 @@ const char *rt_print_buffer_name(void)
>  /* *** Deferred Output Management *** */
>  void rt_print_flush_buffers(void)
>  {
> +	int old_state;
> +
>  	cobalt_thread_relax();
> +
> +	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &old_state);
> +
>  	pthread_mutex_lock(&buffer_lock);
>  	print_buffers();
>  	pthread_mutex_unlock(&buffer_lock);
> +
> +	pthread_setcancelstate(old_state, NULL);
>  }

The problem is specific to the buffer_lock because we use it in the
tear-down / destructor part for a task as well, right?

We disable cancellation before really owning the lock. Is that a
problem if it takes some time for really getting the ownership?

> =20
>  static void release_buffer(struct print_buffer *buffer)
> --=20
> 2.17.1
>=20

