Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A931E7C34
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760201264; cv=pass; b=XLO9DZh46KPB19HxRj3Q+hKpXWPeQNwtPOshj26xEfdCDOvx6eKufPbT/O7/2AaTu60iv1ZTR6MNWD1B5pNp54y0l5uMHpDa1xuar6NOFf5Nf3sRjjSYt6PzpehthpFWwS+Ee2ycqHeYoikieEEh6rQxo5dgbbikJcuAi68FUU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760201264; c=relaxed/simple;
	bh=Xtu5mOxliegnDSVBbiTV+XFqDAVFEignMSS7FLxguC0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=un/WLjIZ8oyg4eVAxm7vF1fe+9s4Hy6YrGg5XyZ/+zKKwMa4mTGFhOyuDWfY1y9hnc2uhEdfEuUx1uLjKxZQkU+owZWps1nM5IM5Kky2zn2X88Kn6XctnhTiiVkiihmnL/qHV1rmqFFQIjFNHsFIRJ6xBL+p2JEImz5LXO1xOWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=e64eIekZ; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="e64eIekZ"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 92E7D6A103B;
	Sat, 11 Oct 2025 16:47:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (100-114-189-244.trex-nlb.outbound.svc.cluster.local [100.114.189.244])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 433586A0DB4;
	Sat, 11 Oct 2025 16:47:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1760201252; a=rsa-sha256;
	cv=none;
	b=z4nhA23fmCcctZnnAWVPLKVaeIlN12i+57qLM8ETIgKzxmgxdKDZii1z6rkE9ObE/u+LQs
	U9K2LphzN6Ns2eeAB+z1m/p2OBsa1YqdgALs1m3SdUWqyfPggCP3S9pZmS2ev8o5l1lQs5
	AVlXGbfrzASsxxQ1gO5k7m63/8IyosLqnTM8HFBN12JkQYtsic+hhPjtqUa+ENhb4srYGG
	jJupOLV7LPjGtQgI3sfzBYATrAAfy23vMvqKJnGM/eRtI3dGrHDlGxYt3cAsIIDXIlnZgz
	AX6bRMzG8l/Os5u558Rk6Gf83DiWtCKe+gLmT9aEdhO5gX0K8ivA59+2sDCwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1760201252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lXeuKO+PjPzsgII8SL4dUcpFS/uC/IDsNJuL0SzwHQ0=;
	b=tPx4/ZPB3Lmwp2ilSr38n5jNV9oap9P30P+YCmDQOQ0LhvH9HhqjfbXSJbtU7rFW1aNH6C
	YeIOzyZnNHFbVYv9Fd7JJrTk4eTIOOYePcronZWQlssr0bpyUA6DXNuhS/panZ4Gkj1qFn
	Zrg1TO/ljE/MkBbjXxTvlD+P50gv0tvsBtRwF9rH2KYhkVhIf9MFixn2hIDtKh366oMLAb
	sKwne1nKJO38w/ilbP4uyvPbYRKgoI1ZJntSy/tNBvfvYKtvBy8JixzKaF+fZo2Fl9UzQK
	XQsUVr3m97gtUmriUQ6iC7rkR9On4Hej6N8rSiB3R5FAc6rLLEgUq9aoliFqGQ==
ARC-Authentication-Results: i=1;
	rspamd-777888ddf6-fjjmg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Macabre: 412a9e087d14b421_1760201256427_1288278468
X-MC-Loop-Signature: 1760201256427:3248591322
X-MC-Ingress-Time: 1760201256427
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.189.244 (trex/7.1.3);
	Sat, 11 Oct 2025 16:47:36 +0000
Received: from giulios-MacBook-Pro.local (unknown [191.98.11.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4ckV0325zPzK4;
	Sat, 11 Oct 2025 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1760201251;
	bh=lXeuKO+PjPzsgII8SL4dUcpFS/uC/IDsNJuL0SzwHQ0=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=e64eIekZFJTL00zZw1uZrFn7NSYLcD4GquEI+6unZ8P7jUxYuMnbYsqyp2lUrwK4h
	 c9kYnt8UI/dgfqPOcYUGki+dG9/lfrv0yOOQCVVm+9NNNsxcCKFgie8wkTK/EsDDoR
	 Hm9/lc6WlkfouCCOIIsZ472B6jrbY8NYmldbMvZBNAxsK8PAey1it1/HJ0D/V83RUv
	 u+h8ZY9+bYCayyUyQ5r8iCKDcTgWM+X9C1Xfx4mdFWLlEJA39MlAi3mL76WrkXCMIp
	 lzKgc2f1Rl1tmDAG2J9Sp23NXEViWMGzIPVbEYU7xdiKbkQSFv5ga/cvIXYY5srEfr
	 by8ONqhUzWiQQ==
Subject: Re: Unexpected switches to in-band
To: Philippe Gerum <rpm@xenomai.org>
Cc: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@nabladev.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
 <20251009151737.0d03b211@wsk> <20676160-4572-d92d-4b33-ff4255946345@bela.io>
 <87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Message-ID: <f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
Date: Sat, 11 Oct 2025 11:47:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87ikgls9kh.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I realised that gitlab's v6.12.y-evl-rebase and v6.1.y-cip-evl-rebase can boot as-is on the PocketBeagle 2 and so I'll keep using those for tests going forward, without any third-party patches.

>> Ok, so it looks like both of you observe the same issue, which seems to
>> be arch-independent. Checking the code which takes care of preventing
>> COW for oob-enabled processes (a behavior which may cause unwanted minor
>> faults in a tricky way), I stumbled upon a really bad bug. Could you
>> check whether the patch below helps?
>>
>> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
>> index 73de18353e79..c6b1efcbd833 100644
>> --- a/include/linux/sched/coredump.h
>> +++ b/include/linux/sched/coredump.h
>> @@ -91,7 +91,7 @@ static inline int get_dumpable(struct mm_struct *mm)
>>   
>>   #define MMF_VM_MERGE_ANY	30
>>   #define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
>> -#define MMF_DOVETAILED		31	/* mm belongs to a dovetailed process */
>> +#define MMF_DOVETAILED		18	/* mm belongs to a dovetailed process */
>>   
>>   #define MMF_TOPDOWN		31	/* mm searches top down by default */
>>   #define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)

Tried that on top of  v6.12.y-evl-rebase , it doesn't seem to fix the problem, neither for latmus nor for our application.

> Note: this issue only affects kernels from v6.10 and on

I can confirm that on v6.1.y-cip-evl-rebase I don't see that issue, even though MMF_DOVETAILED is 31 also there.
