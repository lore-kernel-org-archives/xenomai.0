Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297DF1876
	for <xenomai@lists.linux.dev>; Sun, 30 Mar 2025 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743322575; cv=none; b=Jj+LXGDmgZG5SVUeVkEXNtYkWyfWSFVb59JhyLB0Nv9nHxYr/wrO9fgLy7JLU0WUvLAnicLe/FfImKyDGQ/Fhu5TJ9oIhPp7dAyt3a/+9FpA6ulCphkYgiGXzv+RbAW/4t5FlXH40aigXlS7FOatJFoffFRiqwHwhBW3VqSJmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743322575; c=relaxed/simple;
	bh=nItvgEHO4yqAvYcAS0LtJnoA7Zx542xEmqFiEiYiGfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQdn8MElkFXNUt4WPcUbWj8xYOnwZDSzDCYRezv6ALNy9dIWZ+uwwTekKLRUkIG6uMBIoHq9s9j8ZlZq3rb4w3y1tF7tJ2ZdOj7+lzNyXx/wnUUje/L2aO4m9I4EBRrWIbJlweo14Au4TVZ3YAAtwY0UrUu/9byTXrg2IbxqQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=O+hEWa9V; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="O+hEWa9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743322559; x=1743927359; i=jan.kiszka@web.de;
	bh=xhMi45nb5Hu6KZkmT0j0TAUfAXqkTF2CM4FxoXdWX+4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O+hEWa9Vd/q1JAep8AUwTFWjRQUPdpFbqmGGODG3G0Sarp5xZJ7TmILvSIR+1iTH
	 ojQGtOl0vM5WV1gyBkmL4b0sOTGfC4mjdXrhg1EYZAI7nuPv+YIqzlzfrpwxFfycj
	 X/EWXDrjanvrkkkLkAZfo/FprdfARq+H390P3g4BRqMZZm6vtlLFKoT7YFQaYayCY
	 uxxca5mTNoj2nZlAgSCjXE9yxL19IYkT7CrpLgM0LHEwAMVjZKvFpVvEN2uHcpY3V
	 cQnUGujMXG/nbwGlWOYKbL0X5KDStzusndWmXTfm9SPtO6Sn3YLlxtFNT9JidaYm2
	 8GOuNafk6KLePtKxBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.170.15]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGQC7-1ttVpK2SvF-00GVGR; Sun, 30
 Mar 2025 10:15:59 +0200
Message-ID: <bb6ba058-2c41-43b8-ad8d-a4b1a32a89e9@web.de>
Date: Sun, 30 Mar 2025 10:15:57 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/cobalt: Fix a deadlock when release_buffer() attempts
 to re-acquire buffer_lock
To: aspirestro <aspirestro@163.com>
Cc: florian.bezdeka@siemens.com, rpm@xenomai.org, xenomai@lists.linux.dev
References: <20250329160646.527363-1-aspirestro@163.com>
 <b2f68c9c-c677-4e31-9d4e-47a647f0a46d@web.de>
 <e435d7ee-fbde-4e7d-993d-f91c0eac4ecf@web.de>
 <47d51681.1282.195e5d959e0.Coremail.aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <47d51681.1282.195e5d959e0.Coremail.aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gbvq2A57ydBUdfc/i2TLeKfpTcSt42t4IHHHNamrHcm5R9a2QBn
 t1vBJsBUvEpqQJSRoyTF0sazvvOxfSU5GVAmdOa7o/Wtv4Vu88W0EnH8FyY+jj607Q32YJK
 vYBnRrTLYo8hUt/HzxtIvkRiQSGfHZdV513/tUSaSGn0fnGs8PjiZYDE96/ztQ4PtA+JxXK
 kUc9txXQKgIZ7QrL/ZgQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lIRl5Bd0zAo=;fnP5U55Y+6SOk5sbm1cMz+SQd4o
 g5BEWwlQvd6L5l4pRUbtkhP8fQ+O7Vf/Y4yTg6DcyfO15DVd9CZ/h5hTwzMqO9vR9T3FtAVlH
 yAfgHceh8lNELAu2aGjT6mXpzvo32Yad97OnZmZ2UWosnXzESgBBfgtLJzJTNjfZSNxjpcB89
 LTNtwvvbuK8ed+60BePx8KRZw9dzxFU28egHzS/YwadMFs1IKopc+otokkQPY72LOdbwUd2Jg
 eIUgLIEXhIaKSmL2Ii9sYEAsRdQoPxZ1i5kRgyyUgafmqKEym5S/gOYoY4Zn1/wEc/xS3+1Rb
 yAsWEK6ytmmAaKcjWyGM3IB0sNXfk6SK22Ml6iArWTNi1lJeViDoifsH9AhqR1WwnuCViS9jW
 3GyHhtJ3TrGkmMoOBQj4udZy/mrVEnB5wN+unJjM2ms7Zqtb9DF9/fPuSx0vYeymfGe8WMM3I
 NT7OzYAFDs56dNNZYCj1dNDrE/wm1STQ9RdqJ8Qk7z2g2VGkpjNYnQEEZoyX0Oy//NrdiZodW
 jIOx+zyP3ZANAN6kuozKZnafE33JDvF1U888IzrJa7vBkEER6H+EeOmbUmuJ20dBGiLie9Lmg
 /qy69W8cfJ/sU0PI0j6jxeZSDzudTWVd9tPND46WJ6X7hkFl0D1QSb/rDhqZjwpDqu0rRv2u7
 yIoQkZTOCon23LIQIT51e0xjB925bwyeD5pAwTojZ3uawwq9CfhMPxcMSiqMuuS3xFhuTB/zO
 iZNPYhDH20cDbzH50QHfVaePkQ/T0fupyV6L5YM4D1D+KEBvwwIxx1jhZ4UfoI4Vc5CgqABCx
 EpPW+5H+IftzL9tdLhpRmjGgBDVckA6uNijtKv2VY4c1TzMo9UCINbHY2dUW9OaZmiliwdpxH
 cwETTVMWh7bNzfkEmGyJTeEgfJ/Ntk6B3BVDlAiDfn9AY5hnoTlMk5MOfgu6laV34M48b/n/A
 7MVmgEZaUzMT8CJ5ZVvtYv1A0GRsQVUlHmlCwe6WX2A1MePsQlvkLsW4nuYaIZGzlIy9zrIZf
 KMeyrM7rhp+xxslnD08KBIwoWQAYpKyxKEBL8q2CB5GUYPcd2rkCGyfp9twiBnVdCPhupOi3C
 tJ3pTGNjMiorfAOOye/m2xsbQ3laKcLNLrDuUbaqGIsY66cMprFtH/n6rsKTvwm4sWFofUnVW
 x3LLqNwWz8n40ha9sUwaPBIe4rJlqVBYiuvRCfWuM87qccc53ya6iZqU1VPPrD/1VE9CMl5YH
 BoefzN7ARtSHMdFdeBfiTDJy6Yh117K/ZenuPueFvhzd8Hm0c+bJt7WvDGbDcXbFpKhPqRJaJ
 ErdTnlobUVFajhqdI15YH+tnCDCoMxslDaFQQQ5dO90JVLqYZEeQKYzm4iIGbh0kpWZLnPNyi
 A5pFegEpod3blk7gvzml/5jB0PrrmN+g28KG6J5V95Dchgl1QOn1TobioO548dQpfXzc/IEo6
 LfaukNg==

On 30.03.25 08:59, aspirestro wrote:
>
> At 2025-03-30 06:48:46, "Jan Kiszka" <jan.kiszka@web.de> wrote:
>> On 29.03.25 23:25, Jan Kiszka wrote:
>>> On 29.03.25 17:06, Ethan wrote:
>>>> The release_buffer() function is the destructor function for the thre=
ad-specific
>>>> data (TSD) associated with buffer_key. If the current thread is execu=
ting
>>>> rt_print_flush_buffers() and has already acquired buffer_lock, and is=
 then
>>>> requested to exit via pthread_cancel(), the release_buffer() function=
 will be
>>>> invoked. A deadlock can occur when release_buffer() attempts to re-ac=
quire
>>>> buffer_lock.
>>>>
>>>> This patch changes the buffer_lock from PTHREAD_MUTEX_DEFAULT to
>>>> PTHREAD_MUTEX_ERRORCHECK type, as it supports deadlock detection. If =
the lock is
>>>> successfully acquired, it will return 0. If the same thread attempts =
to re-lock
>>>> a mutex that it has already locked, it will return EDEADLK. This appr=
oach
>>>> prevents the deadlock issue.
>>>>
>>>> The deadlock can be observed as gdb shown. The thread "slave" will bl=
ock when
>>>> calling pthread_mutex_lock() in release_buffer() while attempting to =
re-acquire
>>>> buffer_lock again. This also causes cobalt_print to remain waiting in=
definitely
>>>> for buffer_lock.
>>>>
>>>> (gdb) info thread
>>>>   Id   Target Id                                        Frame
>>>> * 1    Thread 0x7ff7ff4010 (LWP 1654) "hello"           0x0000007ff7b=
b6398 in sched_yield () at ../sysdeps/unix/syscall-template.S:78
>>>>   2    Thread 0x7ff7a7a1c0 (LWP 1657) "cobalt_printf"   __lll_lock_wa=
it (futex=3Dfutex@entry=3D0x7ff7fcaed8 <buffer_lock>, private=3D0)
>>>>     at lowlevellock.c:52
>>>>   3    Thread 0x7ff72791c0 (LWP 1658) "master"          0x0000007ff7b=
6d314 in __GI__IO_default_xsputn (n=3D<optimized out>, data=3D<optimized o=
ut>,
>>>>     f=3D<optimized out>) at genops.c:393
>>>>   4    Thread 0x7ff72581c0 (LWP 1659) "slave" (Exiting) __lll_lock_wa=
it (futex=3Dfutex@entry=3D0x7ff7fcaed8 <buffer_lock>, private=3D0)
>>>>     at lowlevellock.c:52
>>>> (gdb) thread 4
>>>> [Switching to thread 4 (Thread 0x7ff72581c0 (LWP 1659))]
>>>> 52      lowlevellock.c: No such file or directory.
>>>> (gdb) bt
>>>> (gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__owner
>>>> $4 =3D 1659
>>>> (gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__lock
>>>> $5 =3D 2
>>>>
>>>> Signed-off-by: Ethan <aspirestro@163.com>
>>>> ---
>>>>  lib/cobalt/printf.c | 13 +++++++++++--
>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
>>>> index 0aa5940c6..87ed989f4 100644
>>>> --- a/lib/cobalt/printf.c
>>>> +++ b/lib/cobalt/printf.c
>>>> @@ -82,6 +82,7 @@ static struct timespec syncdelay;
>>>>  static pthread_mutex_t buffer_lock;
>>>>  static pthread_cond_t printer_wakeup;
>>>>  static pthread_key_t buffer_key;
>>>> +static pthread_mutexattr_t attr;
>>>>  static pthread_key_t cleanup_key;
>>>>  static pthread_t printer_thread;
>>>>  static atomic_long_t *pool_bitmap;
>>>> @@ -498,6 +499,12 @@ static void release_buffer(struct print_buffer *=
buffer)
>>>>
>>>>  	pthread_setspecific(buffer_key, NULL);
>>>>
>>>> +	/* The type of buffer_lock is PTHREAD_MUTEX_ERRORCHECK, which suppo=
rts
>>>> +	 * deadlock detection. If the lock is successfully acquired, it wil=
l return
>>>> +	 * 0; If the same thread attempts to re-lock a mutex that it has al=
ready
>>>> +	 * locked, it will return EDEADLK. This approach prevents the deadl=
ock
>>>> +	 * issue.
>>>> +	 */
>>>>  	pthread_mutex_lock(&buffer_lock);
>>>>
>>>>  	print_buffers();
>>>> @@ -666,7 +673,7 @@ void cobalt_print_init_atfork(void)
>>>>  	}
>>>>
>>>>  	/* re-init to avoid finding it locked by some parent thread */
>>>> -	pthread_mutex_init(&buffer_lock, NULL);
>>>> +	pthread_mutex_init(&buffer_lock, &attr);
>>>>
>>>>  	while (*pbuffer) {
>>>>  		if (*pbuffer =3D=3D my_buffer)
>>>> @@ -723,7 +730,9 @@ void cobalt_print_init(void)
>>>>  		rt_print_init_inner(buffer, __cobalt_print_bufsz);
>>>>  	}
>>>>  done:
>>>> -	pthread_mutex_init(&buffer_lock, NULL);
>>>> +	pthread_mutexattr_init(&attr);
>>>> +	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK);
>>>
>>> Good catch! But why not using PTHREAD_MUTEX_RECURSIVE, rather then
>>> triggering an error that is not handled and therefore happens to let t=
he
>>> caller continue?
>>>
>>
>> In fact, this would need more work because we would also have to ensure
>> that we can actually re-enter the locked sections. It is therefore
>> better to disable cancellation while running release_buffer.
>>
>> Jan
>
> 1. PTHREAD_MUTEX_RECURSIVE
> It is difficult to detect how many times a PTHREAD_MUTEX_RECURSIVE lock =
has
> been locked. Thus, it is impossible to determine how many times to call
> pthread_mutex_unlock to release it.

Indeed.

>
> 2. PTHREAD_MUTEX_ERRORCHECK
> I was thinking that PTHREAD_MUTEX_ERRORCHECK can inherently detect wheth=
er
> the lock has already been acquired by the same thread. This is an existi=
ng
> feature that, to some extent, is very suitable for preventing deadlocks =
caused
> by a thread attempting to acquire the same mutex multiple times.

Detection would work, but we may also leave the state that the lock is
suppose to protect half-backed behind when we re-run logic under the lock.

>
> 3. To disable cancellation=EF=BC=8Chow about this way:
>
> diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
> index 87ed989f4..403829a2f 100644
> --- a/lib/cobalt/printf.c
> +++ b/lib/cobalt/printf.c
> @@ -484,9 +484,11 @@ const char *rt_print_buffer_name(void)
>  void rt_print_flush_buffers(void)
>  {
>         cobalt_thread_relax();
> +       pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL)=EF=BC=9B
>         pthread_mutex_lock(&buffer_lock);
>         print_buffers();
>         pthread_mutex_unlock(&buffer_lock);
> +       pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);

We likely want to save/restore the cancellation state here.

Jan

>  }
>
>  static void release_buffer(struct print_buffer *buffer)
>
> I havn't verified if PTHREAD_CANCEL_DISABLE could fix this issue.
> I need more time.
>
> Ethan

