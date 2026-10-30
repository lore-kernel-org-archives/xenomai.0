Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351950;
	b=VFCbqGTsU5mEtMiuebqSVceD/t1xEo7+huLl8KSPKVU6gXFhA0nRHMGovobBR1UvzxFe
	 6XU92Q1vi4Ncy6p/RXCdnxPT85rPR/dcSksazFOUf+hb55YUOribd0NPRS3x95T/p0kuu
	 cwCcAh0/n5AhelfvD6IIawuK7fpoMPbdt5xmD7Ct/9HQpGgUQP7LHuFhcOAjhmfJliMjL
	 wQsifkhB1z7FsAWZ72H9WPcKB4hQutnD1QXOYJC4FsoBLdu8NiFjyb0VNJ/V4RvKiXC9u
	 mzgWSktLfnUXytkoRYMtAZ7MsCDq24gWv8y3FFbELKGSLa6b2nPbsDYECSOwI0E5mcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351950;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=Na+DP2jK7lcFcVfRG0Sx/OuzceBljn74QvIq/Aetvis=;
	b=WURhmCMBkSar00IPnzP4Gic7fVbTYfB5fCzbvWO47vHIUCE8BWCjDIYtjXS+KkV8HTtA
	 xp2T7GajymlnaN1HNYpaF7lsqjlS8KwFm7HBFdu0KIhzC8yRFlhkzGYE1E/MqNvL2S6Jc
	 Nyxj4uTqAnsr1hoB4lVnx8RDcRDuUECf2OvYPYV95xrBNASbmiYzz9VwOLPr9kX3r2h/w
	 9wAnZhBWVJI1FQPXIfdxBiJjBQIR7OQ9Q15JP4/ks4XxFAKilu3wpCDR6RXKZcNprNPKJ
	 I0Qja+OxtXLjlbuW19xQDRe1VuRF6WmNVRegE17JGF888doRcsLWZcQ6/EMQyx+A2+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=ET02YffW;
	arc=none smtp.remote-ip=217.70.183.201
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970EE606A31C
	for <xenomai@lists.linux.dev>; Fri, 30 Oct 2026 09:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 970EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=ET02YffW
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD7823E992;
	Fri, 30 Oct 2026 09:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1793351942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Na+DP2jK7lcFcVfRG0Sx/OuzceBljn74QvIq/Aetvis=;
	b=ET02YffW6FYSsV7QHbiEv7rSzFZiM/8ilF4clarFYUasEWXNQY+IgXGqor/OjmoLHmNtxW
	0sXtcIYW/pIfhaP/uPkRUsEoJr+eryjkUSYsunS7ZQzDStPgdfZYkYvbGKAtueLHnlDjIJ
	fZkHEYOpMDYCTNCHE3zM7cAxrS4qc2hND1kGdz+S4lHLYfBQnQPmB1j79y8tsRLKt//WLk
	/Y4tPmsRM2Ubgp+6WKZpaINcrx1SadN795Vrbbhchvx3qw7HrB2HGFU9PqJ2G5parb4nxX
	0m/XZmS6DzQIiTOTjjjhp4WweE19V4wl8D3FFjUtD/MMP0Xcqi2+zZ/FSy8V1Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Luc Montier <luc.montier@etu.unistra.fr>
Cc: xenomai@lists.linux.dev
Subject: Re: [libevl][PATCH] lib/mutex: init recursion count after trylock
 via the core
In-Reply-To: <87cxsrwof0.fsf@xenomai.org> (Philippe Gerum's message of "Fri,
	30 Oct 2026 10:03:31 +0100")
References: <20261029082848.22006-1-luc.montier@etu.unistra.fr>
	<87cxsrwof0.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 30 Oct 2026 10:19:01 +0100
Message-ID: <877bizwnp6.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGElYcr5PUXy6dkXWGZxDhv0QevsIO0qRaJWvhUhQ57cJwT7zMHy8BkM7fm0BeQOawIzEN1NJjkswQx5soHxZY5wubvphNqh4M1gniSQek/j7j6JoDj8l8T9LvPs4glPl+FJQoUcIfOkGUBjTBTnIIbV4a46i7iBkwEZ1WD/ATL4M11VzOaD9xR5hJI2t37GzN+CXXsXd3289DuBXfcgQtzk8Hv96aDxCTgucj9eP2COs4W+4+99ODzYvXhPmC5TE2mYn8ewk0ZiWcq+frMZtcfLQIOiUQdusKU68/0bz/lg/E27Hbos4jCWSvL6Tccp7fJ119zMshqb8ZHSkaj9FjPeW1LuFiGVz8aG7ssK6FZfLo6/J7OFGTgX4OLAzPi+iwvnET15dviILxMo7NT6tHVcImHsUUs0FD/x8XriD60iEGYnZ6jJdIphW9cvN5h5bMfKsNyzAwsOIoQSu+3+0dmKVOKwbUuvorzCETqwn5JzQStHv0cfgzIF6hxMR9BUCvcC4fKRMT3Tm4xxoIjgblosFq4mzw7c6QpKDY8n8Qwg2xU/Uc8ZWTf1eoG4tu1cDQpVCq/sndfwCUblRrvowZGjeqObVRlILJlPChM19h7WYfVvywWJUwJoVgSnggG1wVWlz7cU8evM463xOltow397thAICFvWbni1OdAYMsULQ
X-GND-State: clean

Philippe Gerum <rpm@xenomai.org> writes:

> Luc Montier <luc.montier@etu.unistra.fr> writes:
>
>> evl_trylock_mutex() takes the slow path to the core when try_lock()
>> returns -ENODATA, e.g. for a thread running in-band. Unlike
>> evl_timedlock_mutex(), it does not initialize gate.nesting once
>> EVL_MONIOC_TRYENTER succeeds.
>>
>> For a recursive mutex, nesting then stays at 0 after the first lock
>> instead of 1. After N successful lock calls by the owner, nesting is
>> N - 1, so the (N - 1)th unlock releases the mutex and the last one
>> fails with -EPERM.
>>
>> Set nesting to 1 after a successful TRYENTER, as evl_timedlock_mutex()
>> does after EVL_MONIOC_ENTER.
>>
>> Signed-off-by: Luc Montier <luc.montier@etu.unistra.fr>
>> ---
>> Hello,
>>
>> This patch is against libevl r50-5 (e7dc1af, Jan 2025), the version
>> that matches my kernel (6.6.74, EVL ABI level 37, Raspberry Pi 5).
>> I could not test it on master, which requires ABI 47.
>>
>> Reproducer: a recursive mutex, a thread running in-band when it calls
>> evl_trylock_mutex() three times, then three evl_unlock_mutex() calls.
>> The last unlock fails with -EPERM, and gate.nesting reads 0, 1, 2 after
>> the locks. With the patch it reads 1, 2, 3 and all unlocks succeed.
>>
>> On master, this code now seems to live in lib/intrinsics/gate.c. Is
>> this already fixed there, and where would the fix belong?
>>
>> I just want to if it is an issue from libevl or a misuse on my part.
>>
>> Best regards,
>> Luc Montier
>>
>>
>>  lib/mutex.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/mutex.c b/lib/mutex.c
>> index 276e77f..832268f 100644
>> --- a/lib/mutex.c
>> +++ b/lib/mutex.c
>> @@ -332,6 +332,7 @@ int evl_lock_mutex(struct evl_mutex *mutex)
>>  
>>  int evl_trylock_mutex(struct evl_mutex *mutex)
>>  {
>> +	struct evl_monitor_state *gst;
>>  	int ret;
>>  
>>  	ret = try_lock(mutex);
>> @@ -341,7 +342,12 @@ int evl_trylock_mutex(struct evl_mutex *mutex)
>>  	do
>>  		ret = oob_ioctl(mutex->u.active.efd, EVL_MONIOC_TRYENTER);
>>  	while (ret && errno == EINTR);
>>
>> +	if (ret == 0) {
>> +		gst = mutex->u.active.state;
>> +		gst->u.gate.nesting = 1;
>> +	}
>> +
>>  	return ret ? -errno : 0;
>>  }
>
> Thanks for looking into this. I don't know about libevl r50{-5}, since
> we are not adding any patch sequence to libevl releases. This said, this
> issue was already fixed by commit 189e496e (ABI 44).
>

Note: this is a kernel-side commit in branch rebase/v6.12.y-cip-evl
available from all kernel releases we maintain as well.

-- 
Philippe.
