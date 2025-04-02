Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04669238D53
	for <xenomai@lists.linux.dev>; Wed,  2 Apr 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596682; cv=none; b=l4D9ZotZrUQgwJ3hS/QRo+4PHZLR4lv4sSqAv1OfkoDMLgSM54OkrL0sBBdQ3ZxXCf8XpykzLhqOSRmcgk5/QyiIfUjd/HJJcQGrGjCWSzg3U/SH018VSIbw5MfXGR11x5FipgiFVDa/cqCEY+2tzC9ZL7gsMPcXWMsrntBfeLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596682; c=relaxed/simple;
	bh=i1zaa8AvMwhi27MchKx0MKqgpOZuTZ4r5XTpHAz/tcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnBhuR5e/S8CNJX97uZE6uZTkWc3v/V7n5y5X9CONCIsLef3IxnX5GsLe8dPEn1a0rI6bS9kvF9VSnIiP+E/nqnhksdaxEgkPpnbx5aBpbqvAQ43UlEu9NhVzDY8jDXvwglmoPdUWeuHMzqZRh/aXVVdFX0zmIqvOpsU0uqZng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=N90oHWX2; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="N90oHWX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743596671; x=1744201471; i=jan.kiszka@web.de;
	bh=MWiK2hmrON8nTiMvEyrAegOB3dAoCWcSEkztGVMVSAw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N90oHWX20NoI9Z+6sZHsstEmA87KFD4Hzw3Mtb7+ME506J8FxnihXXfDa2UKob+Y
	 D6NtFEa5MN+imDDzIDLK1wcDnTEstHA5wsH6ZpDNWRvjdDOa8h5D3I77JnS0I3v2z
	 KhEDOrN7zV1L4oNYH51m8c7BPJFuuJ7My+QirpROuIql5CbWi9WRdDDAlUqncaqUE
	 qyDOIH0OQNn9EfDrlglM99U4kyVOV+deJQ3m8YjtiDcke6ogT+9fNfL1SrpTT4B4z
	 OzIBeJnYAnVvr23PGSQ+ik96YruvOMJZaoKw9+ahV01/mmOD8z6Q4aMY67q5uX1EZ
	 jZHa3G4ZnbbUib/vzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.11.10] ([95.157.49.24]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEbq-1tvXHa3UeW-004itg; Wed, 02
 Apr 2025 14:24:30 +0200
Message-ID: <aef405ce-59d0-4613-9273-dd81254f0ec0@web.de>
Date: Wed, 2 Apr 2025 14:24:29 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib/cobalt: Fix a deadlock when release_buffer()
 attempts to re-acquire buffer_lock
To: Haiyang He <aspirestro@163.com>, florian.bezdeka@siemens.com,
 rpm@xenomai.org
Cc: xenomai@lists.linux.dev
References: <20250331124253.598842-1-aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <20250331124253.598842-1-aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VCoQ0MjzAmfoZE5gxCG88+AviXlXxeagcordEN0IMUqwQJyAqPk
 e1wFxCVvDsqQ5jPP6sbOMjr6OowYXC3VCONZTKAqsd4Y0b+eUr3HkoAKB+1goRKofbDOoMA
 fhk/rHd2xKKMuI/9tohPPEkJV4vMxZAgWsO0NRytNJhvlJDVl9bTzUpjXlZallMAVgzL+jJ
 Acj4Eo0HIumDIdTI86DMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OT6iq6AW34I=;TatWwrZK3qGU1HjpvHs67eksqku
 SRUUhmlSNP2os/f+A5kYZ5481GfeNObJxx8RCccGx0F38z2gQKa0eos566sjfhseSxgQur2Q3
 3Z2knfNqkulv/ziJPyPhnv36XRRwahbAm1rBOO0CrXV4iMxKcjH26PEjftZTF4omEJ1c6SC81
 +AIZb+r3kLEz5wsGKXnkr51ASIsxVTw2DnxrreN5JbuWfFly4LfAD6SxEFe86+aPlSxv8vZf2
 0Qz+QTENTBZ8AgeAZxwrSESuQvPI99yXzFzDO98UBN0PWjy2zo+AQgoRlFOl7H/8EjGUH6tut
 vJIL0Vbq7QT7cuJzcnjzE2otaqILUEEKQFKwIF4jze0PSpSWQ9d50LwG0DVkegQ5mkD3g+GnY
 YRdIMUKX/STZTYj1aYi4KcwQ5d+86xZ9Bu6cIANE5Mj9ka82VeT9c/THd8GY1nE+M8AdJDzz0
 qADpo++Rut39PDC5g9X9uF44KKm86WPTA2QMuO1VIP4Mt8akyymELgrzvtnCruG3oV24fFBiD
 jsQXcMPbHc481KP3m10A5ayRd4fz6ntAyWwNtMEqJqu9ZonLzIobgCxmR79FA51AkcSTmvNiu
 6nop0Xg8jFQKz8anRk8+WuuJG2TI8tzsjV0dvxM1riXYXzXf6IkKjzLT2LNgUMnOfINfKYkKC
 DR6LMVdZdlk+QTCV58VYsFc7mRjquJ3UMOGMOftK/dhu0qANrQMQQTzQlL2joB149OMBVJeFv
 onIjxBxnwH5+np4p62+jDRRyL4NIHAK0ULD0hnTcspkIQrirbgfQV8ksVmXGo+cOUWeh4Vqih
 rvCrm/mkqGLnpOtRanYcPJ5vpOVfZdyWeYKEb19+JNkCnBwKOMfuoOLqnWw/RtiWiRYUdgJRR
 EYewDdN4LTr8rAwNEHu6VIvhSaYBEDb45D/x6LXy5bCBLGiQyct88lJOytj6gGGIldEfuQkLy
 6l25woP+3oXL0zXnDztuAZoHXBXCAma1t1nuhy0JaAFqZHGdmxdhZ0V0x/H9WIPlCQc5e5W4+
 GpEWjCtAzDx16LVRhvis4w69v1k9wOFdYi+bG9yq316jGZce0qdYGcrzy5CeBasK8pFIRjL9T
 PgEhOAqZx6H7BMshqkG9g51BJPujD3qqHVEKrD97DEwGt+6jZYWq2UbFshalFglKhsHGml1+E
 J8b9AuliNygzxYGNuwK8Exz7FgVrmYUABGTVc9/NKJJRnK71NVChgjQZAe5dqERWPDusPA2gj
 hglA5Ndbvz01FcZgqo/0stOSqBffLYRGmRRww5fbyRFuxePpkvmd8DY8aNN+npMG6ZB45E4zX
 LydAAZTPP8RQrNEgePns1tZ+hW/5ciTICV5PIKJdxl25jFQ+Kkk/k89UhJwlHJ716GbpsZafe
 TH2klH7OAsUfCi0pny2qXPC51nvdPh38VRsnhBhiAlqmayglEDPwLCEI2XyepFD5JXO35mYl/
 ZG25Wfw==

On 31.03.25 14:42, Haiyang He wrote:
> The release_buffer() function is the destructor function for the thread-=
specific
> data (TSD) associated with buffer_key. If the current thread is executin=
g
> rt_print_flush_buffers() and has already acquired buffer_lock, and is th=
en
> requested to exit via pthread_cancel(), the release_buffer() function wi=
ll be
> invoked. A deadlock can occur when release_buffer() attempts to re-acqui=
re
> buffer_lock.
>
> This patch uses the pthread_setcancelstate() function to set the thread =
state
> to PTHREAD_CANCEL_DISABLE, ensuring that the thread does not respond to
> cancellation requests while holding the buffer_lock.
>
> The deadlock can be observed as gdb shown. The thread "slave" will block=
 when
> calling pthread_mutex_lock() in release_buffer() while attempting to re-=
acquire
> buffer_lock again. This also causes cobalt_print to remain waiting indef=
initely
> for buffer_lock.
>
> (gdb) info thread
>   Id   Target Id                                        Frame
> * 1    Thread 0x7ff7ff4010 (LWP 1654) "hello"           0x0000007ff7bb63=
98 in sched_yield () at ../sysdeps/unix/syscall-template.S:78
>   2    Thread 0x7ff7a7a1c0 (LWP 1657) "cobalt_printf"   __lll_lock_wait =
(futex=3Dfutex@entry=3D0x7ff7fcaed8 <buffer_lock>, private=3D0)
>     at lowlevellock.c:52
>   3    Thread 0x7ff72791c0 (LWP 1658) "master"          0x0000007ff7b6d3=
14 in __GI__IO_default_xsputn (n=3D<optimized out>, data=3D<optimized out>=
,
>     f=3D<optimized out>) at genops.c:393
>   4    Thread 0x7ff72581c0 (LWP 1659) "slave" (Exiting) __lll_lock_wait =
(futex=3Dfutex@entry=3D0x7ff7fcaed8 <buffer_lock>, private=3D0)
>     at lowlevellock.c:52
> (gdb) thread 4
> [Switching to thread 4 (Thread 0x7ff72581c0 (LWP 1659))]
> 52      lowlevellock.c: No such file or directory.
> (gdb) bt
> #0  __lll_lock_wait (futex=3Dfutex@entry=3D0x7ff7fcaed8 <buffer_lock>, p=
rivate=3D0) at lowlevellock.c:52
> #1  0x0000007ff7f43cd8 in __GI___pthread_mutex_lock (mutex=3D0x7ff7fcaed=
8 <buffer_lock>) at pthread_mutex_lock.c:80
> #2  0x0000007ff7fa3038 in release_buffer () from /usr/xenomai/lib/libcob=
alt.so.2
> #3  0x0000007ff7f413c0 in __nptl_deallocate_tsd () at pthread_create.c:3=
01
> #4  0x0000007ff7f4156c in start_thread (arg=3D0x7ff7fa7430 <cobalt_threa=
d_trampoline>) at pthread_create.c:488
> #5  0x0000007ff7bcc49c in thread_start () at ../sysdeps/unix/sysv/linux/=
aarch64/clone.S:78
> (gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__owner
> $4 =3D 1659
> (gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__lock
> $5 =3D 2
> (gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__count
> $6 =3D 0
>
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>
> Patch v2:
>  - Use the pthread_setcancelstate() function to set the thread state
> to PTHREAD_CANCEL_DISABLE.
>
> Patch v3:
>  - Add backtrace output in gdb.
>
>  lib/cobalt/printf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
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
>
>  static void release_buffer(struct print_buffer *buffer)

Thanks, applied.

Jan
