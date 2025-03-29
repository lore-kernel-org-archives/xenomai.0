Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C011ACECB
	for <xenomai@lists.linux.dev>; Sat, 29 Mar 2025 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743288541; cv=none; b=XphpernEg16tHysE7Gv272yC0z4TTNllVeJCAF5YzUvuXO7X4+twq0Oohrcwx1qmHG1Rys66b7G5PhMmP2ue4pcYZPUT/7WuKtif1zny7Jbao1ckFUJJ6gNzGdEQ425QA6+UKfFiyJ+d+5EfqlVilWgLasfH0BCMu4st82CuAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743288541; c=relaxed/simple;
	bh=H9mdcVAk+nVLAESk0SUEaBCaVWG2/iQQ7z9CKPGX17U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eUkbbCFuMNXzx23uAjmBgRWMfIsd27sm/tkHBzzlL1BHzl/JNJm0MYV1kHVn5KFO7fGeNQOnWp9MeuDUxAwp6zmpVqM+RxDgeiV4cFIQkzThM/ZpFsC/7J58MeNVDJaN7GaxQhFNGsrFX190mxkjaIFruDWXZJAl21W8PkqK5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=tcXWQBBJ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="tcXWQBBJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743288527; x=1743893327; i=jan.kiszka@web.de;
	bh=Ki2nRZ2CbC2DCIHF8Nvwq3CTWcDu5nsfBvjNjsH5A3I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tcXWQBBJWnVIUaf9MVR5UnEKcCHtwUXmMKMW6aUqetXtoAumme/Gv7JMdUveSZRm
	 HvN/0+aB4sLjprNEaJR44NTVqmcock/Nzp++VzouGRyXf4kJVMPtFcBuinj9FuTbu
	 nGyXemgSNDw8qwbiqmSYvjhhpczyB7sIh3BUZ/puGLnkpYdWo+JdzlsBXlvWbushB
	 LU/KlYULv/GRyveMCzKtWmdSe/e1BzOl04L111kOslo+9wI1roW/iHi2fwE+zmEQF
	 17m7Mxmzt101427jVaN7DUaE8sI80iB0EB/LB+Pn6VegE/F3CRfAp3ySo40B+S6PC
	 k4RdUoTB1Qasnk+3kw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.170.15]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCuv-1tYzEK0OjT-00R3B6; Sat, 29
 Mar 2025 23:48:47 +0100
Message-ID: <e435d7ee-fbde-4e7d-993d-f91c0eac4ecf@web.de>
Date: Sat, 29 Mar 2025 23:48:46 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/cobalt: Fix a deadlock when release_buffer() attempts
 to re-acquire buffer_lock
From: Jan Kiszka <jan.kiszka@web.de>
To: Ethan <aspirestro@163.com>, florian.bezdeka@siemens.com, rpm@xenomai.org
Cc: xenomai@lists.linux.dev
References: <20250329160646.527363-1-aspirestro@163.com>
 <b2f68c9c-c677-4e31-9d4e-47a647f0a46d@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <b2f68c9c-c677-4e31-9d4e-47a647f0a46d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DEsKonocK0oi5Lhnyh1BS4BfbWpqEa+7uFXJYaUad6pp+vNriLc
 AKEJmjZZpvRmjQ57LGE8pG9Y7Mow+5hPhpQX8wHLS374b7/5B/ymZGH4dxk6+U45WppEcp5
 ifcQ3vLVrQqX9t8FKdvtULqslSsQXlmRrj6zB0r3pYzIPZWintfyusrmyfcia88kFCapHPw
 ll5HTmoq6xRRjLU1e+JnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0vTnDonjTz4=;ODAfKhnC/eL76iaGn78x93G3U6g
 copmS66djEviOnYhKaUj2ecwTEf1oTZZm4au2YjgdUynn6jN3tF5iKyPg6djfH1EV8x/5aocR
 WVqiiyRr71K3AZOHAYbwS0FbP4VF6V5etGb9+6kHeRKvCf7x5CyV5NJz6qOEpTh71P3fnRvXc
 MzdstCgq3r0M/N55Rv5fheKjaag5Fr+TEsFkSc2Mj1+mZoZCsOEwIX+Jpc1KL/h3l3OSzwF/E
 6o2dYje8afBaBuSmJdiJfE/hoXPJhhb6R8t1pEksUnGdG9JVaFQ1AFh2F1V4mdJBCMCnEp36G
 DvkhXTGnz1P/5lAwG1BsGiQrMVGnzntO6SfSowVeXvGAicNt4K25wqT1Nr1pxr45Bz98+e1ZS
 ncyN6u7e6FhSYLB4Vt4esNBc9kxHSfowcy+USpG45gA5gL+alspaKW5GR/0LvYRhd//2Atp28
 /DL8LrRTtsvF3dpLH5JWpF/1upolj/YrwA0flcOsvJj5J58zOTbh4/byfg02rtL/RSDqHY4Lp
 NCAJ98rwQ1dge8j5OH/cz/Bi1rgO9x8zXsXmosaCrBuB2rCcQDBnKJbvdXE6336jt6+11vG4c
 U0y3D27qiPUCSjY5R26YnomKDRVpyiT5app5QHBRe0C+Rt+Diz7DuhPDc3ZBTCbm047pF9moq
 JgUUcIu1ofWef1A/vBtoSSsANBiLoW6MOlOl1los2SiL7LWbUAdti8xcBXn1wixbO06FJbbaq
 QlVfpmP9K7DpwGMo22+9jqHkHnXWgGZzK+lp1aALMOghjOFhznkmarVV6A3hqqk2q+t8nCkSW
 qc6okOBBRGo37pBcZQDxLbx/1wPPoSlS0EJGajgerEhfJGRGPLDaotIpdMm57cm2M1yEB3u9S
 7iMF652DWSHZFuunnuXL540MAj764FBVk1ix/VOQt2GLcQ/aAuXNxreNpLcTJSoCEghCdsgYF
 djkhWWZHWFl7D+VIuD5xHRPTldXQOKv2CYOp8VNhPvyP6bxsVCLPUUS5GiZJYUr726XiAtT/A
 ieJ5vcA8Z7PDAPKjLUtJ14ibqBZ349VaROc6cbNpa/EVt1Ef05boyQN9QkKrJ3IMGxqNjdz98
 3JoRREY800YPiYXG1+qESCH8Typ9nUN8UmZR4YQ6c0mOAuSCEaDWFEMlHx3qoLB3laJ/Pk1bi
 3GAK9fah9e/YsG8Whg7Bo7n9+1ZYCYWjtOp78XhJ4dIBtX3FXThcEp7RYIz36s4kjjm8Rkf3r
 2jZVSP/HWxx2GF91wO1RycS7dnYr4FV/g9GeIOMgOHv2g93TVdG8FndhT8L1sUreA6jWtuU4u
 cgV31Djp7Se3xDgBnivLDNYXWrbi4Ot3lmuQSW3y6E8d9gC0XFokJhEuWR6M3l/WM6TSPXpAb
 wzMAEIe5x3WYv0kKfZhF7brKbT/inO/xKE9VtFKvHu45jNjcxy6UBD96A5Gh+h1cwpo6XNFbx
 rtlUrrCuok87VuFqWuZxWS3sJp3U=

On 29.03.25 23:25, Jan Kiszka wrote:
> On 29.03.25 17:06, Ethan wrote:
>> The release_buffer() function is the destructor function for the thread=
-specific
>> data (TSD) associated with buffer_key. If the current thread is executi=
ng
>> rt_print_flush_buffers() and has already acquired buffer_lock, and is t=
hen
>> requested to exit via pthread_cancel(), the release_buffer() function w=
ill be
>> invoked. A deadlock can occur when release_buffer() attempts to re-acqu=
ire
>> buffer_lock.
>>
>> This patch changes the buffer_lock from PTHREAD_MUTEX_DEFAULT to
>> PTHREAD_MUTEX_ERRORCHECK type, as it supports deadlock detection. If th=
e lock is
>> successfully acquired, it will return 0. If the same thread attempts to=
 re-lock
>> a mutex that it has already locked, it will return EDEADLK. This approa=
ch
>> prevents the deadlock issue.
>>
>> The deadlock can be observed as gdb shown. The thread "slave" will bloc=
k when
>> calling pthread_mutex_lock() in release_buffer() while attempting to re=
-acquire
>> buffer_lock again. This also causes cobalt_print to remain waiting inde=
finitely
>> for buffer_lock.
>>
>> (gdb) info thread
>>   Id   Target Id                                        Frame
>> * 1    Thread 0x7ff7ff4010 (LWP 1654) "hello"           0x0000007ff7bb6=
398 in sched_yield () at ../sysdeps/unix/syscall-template.S:78
>>   2    Thread 0x7ff7a7a1c0 (LWP 1657) "cobalt_printf"   __lll_lock_wait=
 (futex=3Dfutex@entry=3D0x7ff7fcaed8 <buffer_lock>, private=3D0)
>>     at lowlevellock.c:52
>>   3    Thread 0x7ff72791c0 (LWP 1658) "master"          0x0000007ff7b6d=
314 in __GI__IO_default_xsputn (n=3D<optimized out>, data=3D<optimized out=
>,
>>     f=3D<optimized out>) at genops.c:393
>>   4    Thread 0x7ff72581c0 (LWP 1659) "slave" (Exiting) __lll_lock_wait=
 (futex=3Dfutex@entry=3D0x7ff7fcaed8 <buffer_lock>, private=3D0)
>>     at lowlevellock.c:52
>> (gdb) thread 4
>> [Switching to thread 4 (Thread 0x7ff72581c0 (LWP 1659))]
>> 52      lowlevellock.c: No such file or directory.
>> (gdb) bt
>> (gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__owner
>> $4 =3D 1659
>> (gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__lock
>> $5 =3D 2
>>
>> Signed-off-by: Ethan <aspirestro@163.com>
>> ---
>>  lib/cobalt/printf.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
>> index 0aa5940c6..87ed989f4 100644
>> --- a/lib/cobalt/printf.c
>> +++ b/lib/cobalt/printf.c
>> @@ -82,6 +82,7 @@ static struct timespec syncdelay;
>>  static pthread_mutex_t buffer_lock;
>>  static pthread_cond_t printer_wakeup;
>>  static pthread_key_t buffer_key;
>> +static pthread_mutexattr_t attr;
>>  static pthread_key_t cleanup_key;
>>  static pthread_t printer_thread;
>>  static atomic_long_t *pool_bitmap;
>> @@ -498,6 +499,12 @@ static void release_buffer(struct print_buffer *bu=
ffer)
>>
>>  	pthread_setspecific(buffer_key, NULL);
>>
>> +	/* The type of buffer_lock is PTHREAD_MUTEX_ERRORCHECK, which support=
s
>> +	 * deadlock detection. If the lock is successfully acquired, it will =
return
>> +	 * 0; If the same thread attempts to re-lock a mutex that it has alre=
ady
>> +	 * locked, it will return EDEADLK. This approach prevents the deadloc=
k
>> +	 * issue.
>> +	 */
>>  	pthread_mutex_lock(&buffer_lock);
>>
>>  	print_buffers();
>> @@ -666,7 +673,7 @@ void cobalt_print_init_atfork(void)
>>  	}
>>
>>  	/* re-init to avoid finding it locked by some parent thread */
>> -	pthread_mutex_init(&buffer_lock, NULL);
>> +	pthread_mutex_init(&buffer_lock, &attr);
>>
>>  	while (*pbuffer) {
>>  		if (*pbuffer =3D=3D my_buffer)
>> @@ -723,7 +730,9 @@ void cobalt_print_init(void)
>>  		rt_print_init_inner(buffer, __cobalt_print_bufsz);
>>  	}
>>  done:
>> -	pthread_mutex_init(&buffer_lock, NULL);
>> +	pthread_mutexattr_init(&attr);
>> +	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK);
>
> Good catch! But why not using PTHREAD_MUTEX_RECURSIVE, rather then
> triggering an error that is not handled and therefore happens to let the
> caller continue?
>

In fact, this would need more work because we would also have to ensure
that we can actually re-enter the locked sections. It is therefore
better to disable cancellation while running release_buffer.

Jan

