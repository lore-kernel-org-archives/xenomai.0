Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85738DE9
	for <xenomai@lists.linux.dev>; Wed, 31 Jul 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456271; cv=none; b=A8r9KT8M6IlH5gg8WR5AREbVfHYo7eJpNF1Wnd2iCXLP+i0ubJhtcEFeKwpfs87kLBGO9ibQLaadszZ8FcIuHgddK40V0ttW3CdJACkbbWJ9N4EERKJgElzu9CeLQeM3oluqfYyIey0i7vYidbCs/79K4v5wHlxn4mRDsNtMWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456271; c=relaxed/simple;
	bh=NwRQnKVjH0tNXnpeAbi+jNHv2ozdSKx30iTDzAR/LNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Us3qU/AitJ7pvuZntCfGF8YetMbvLlWvOfFNOAFn3antYGfhywn+82xSt2NQCJZvK274mWv0MuiyA/h5VKrczM0GdqaNQQPsFJ5+szbao6ruoVwLGEc75P/LkULJXQfrWCprK6kAOvCOdbC0cp2UxvC7AcvmLe4ff/txdyCa20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=nTt+1/2G; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="nTt+1/2G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722456260; x=1723061060; i=jan.kiszka@web.de;
	bh=gIqMbN/Ia/xek9Xf+XrkKWvucQwHor/37gBtKQbQD4E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nTt+1/2GgkFn61b93R8YZraZJwrVP8qyACO3IDdOO08TQLpq4A63KSyDy5Zocr6k
	 v4BjHhx3XTCuo7T1pjUxTkQb0pvfuZa60DygTxzZ7uyCFBQjG29Op+GiC7L8pZ75T
	 xmaOR7iG8szodoAZJzuZHkLBz1TTVTI/cSsttQP6QTzy/+LfBx0b/BcTIrnkXZSMU
	 5aVQOO7b30xXgm5IuVoXkm2qffMPLQrhUolJ1REyU2Jp/8Hm0YbRuXyMNDSwyfJzU
	 fedS/s+e+MR3i4nbGXhXlYGQLCHjVKEoiFb/JUO9Yp9/bisdw5HM/UjdS/se/YpJy
	 26Yhxguq3NPJoapkfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.168.54]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqZQS-1rvX2C0K5g-00iVdu; Wed, 31
 Jul 2024 22:04:20 +0200
Message-ID: <c7f22a5d-73da-4b8a-a3eb-50fb579f5c57@web.de>
Date: Wed, 31 Jul 2024 22:04:19 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux system got freezing when "Xenomai App" started (or
 terminated).
To: =?UTF-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?UTF-8?B?7Iqk?= <junesoo.im@doosan.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: =?UTF-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?UTF-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>,
 =?UTF-8?B?6rmA6rec7ZiEKEt5dWh5ZW9uIEtpbSkgLSDshoztg4DthY3svZTrpqzslYQ=?=
 <kyuhyeon.kim@doosan.com>,
 =?UTF-8?B?Tmd1eWVuIFRoYW5oIFR1bmcoVHVuZyBOZ3V5ZW50aGFuaCkg7IaM7YOA7YWN7L2U?=
 =?UTF-8?B?66as7JWE?= <tung3.nguyenthanh@doosan.com>
References: <SL2P216MB22740891EAD5CFE21E4A39E3E0092@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
 <SE2P216MB22790C817B4227CF808B2121E0092@SE2P216MB2279.KORP216.PROD.OUTLOOK.COM>
 <7ccc013e-5c32-4f18-8a7d-45ddcfc96650@siemens.com>
 <SL2P216MB2274A6A3B523862FDBA9F341E0B12@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <SL2P216MB2274A6A3B523862FDBA9F341E0B12@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dKQPWt9N4LC9Uc2u7HnfoSRPm4TpJIssiiBfOGpXE8DiaF1WwhE
 AIvg2wdK/Rzj2VyY64+13xywwio0V+WXfK5ohbFbqL4Ykw3NbpWfEOah2yRW7TlcgommVdv
 I9w4+J5+zva8bwmUqmSOw3UVhd5g2r107qBAvTrTbA7qDadmDZqpWxDMtIEoj/xpT1vUY98
 AfTcLRqztKS3lAgT1Xlvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LLO0VBP5d1o=;EXoskiHqCGX847JVHngqRGkiHci
 lmjrNm6Cqbqtf+Uz722Ealw7EWqmRYwLCasufhCo2W53Rf2NLOko2iCsXK/Q7+XO5XW/PClcu
 YOzyULTyA1eXAKu236VxdIML+ceSUL3DML1PEAQODXjZ5FSy9M5nf78sy1D0pR7TpFEl+pMCk
 4xIHQYU0upJN80EN02AVy3/coszIsDNBAEPJ1/0Rlr/9BV/V/jTKrlvCKO7IzHzKzxfK8hiBO
 CHGE1GE8fi6FR/nvi/9aUr7LbMvFPyNVhp8cWmCnfyGnDavMplx2aV8SmliLxnqUEMpcbYs/G
 S0nZwoJPzK2r0VlxlXepxwGZExBp2KYiVF7yYz3dOXiv23VgA7s+rA2AJoYz9x5CQ0oJmqC/y
 WyAfNJcv8q3mlHZtJNMPJr7MXZTaT08K7Ar3aq1DjlTIKawkbg1ZDWYd0nrtTuH26vN/ekKwh
 J/23RACNapF46PEOHhCsx/3xJSfjIha7Err0si9aq5cv/8wj5wOQvpn0i4rlwXd3o9FYhN4ao
 nkAJ1Fx6C0JfXDheA8+MCIBxc9VIB1iOyddSArOeQDHUmNtdj+jPh7HlEe6RLz1QX3OHIBR+E
 1l/AHld0VwY6ZcT2hwXkaqG5W2k8fpPNPucXIXGHC90gX8cmItgkqDD4oz+7HOzV8Qodx9pcL
 Hz9cKEHAdq26P7f4G1MKJZvnX2+ZDKcQ1f/aQx2XnO3t9CfPEEPXcqxBAk9tE2Z/uMakOB4dW
 gXroahpS8DI3pnFHWK3d1hi0YAVvmRU/O1EVk6HjzlJsfsMUaR9lNSlq7mhLj8SwQiqkbh+RO
 T2m/kLHTsVWqz/rzgAyQPZrw==

On 31.07.24 11:35, =EC=9E=84=EC=A4=80=EC=88=98(Junesoo Im) =EC=88=98=EC=84=
=9D =EB=91=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=8A=A4 wrote:
> Dear Jan,
>
>
> I am validating our Xenomai Application with following setup:
>
>    - Xenomai version: https://source.denx.de/Xenomai/xenomai/-/tree/v3.1=
.4
>    - Ipipe: https://source.denx.de/Xenomai/ipipe-x86/-/tree/ipipe-core-5=
.4.255-x86-15
>
>
>
> During Reliability Test in which we do the loop:
>     {
>         1. Boot up machine, start Xenomai application
>         2. Wait for 1 min
>         3. Reboot Machine
>     }
>
> Sometime we face the double-unlock issue right after starting Xenomai Ap=
plication as below:
>     1. [   14.046242] [Xenomai] lock 00000000733490c8 already unlocked o=
n CPU #1
>         [   14.046242]           last owner =3D kernel/xenomai/posix/pro=
cess.c:1243 (handle_schedule_event(), CPU #-1)
>     2. [   13.787715] [Xenomai] lock 0000000054aa4b33 already unlocked o=
n CPU #3
>         [   13.787715]           last owner =3D kernel/xenomai/posix/thr=
ead.c:91 (thread_hash(), CPU #0)
> In consequence, System hung up (with Soft lock/Hard lock printed) and ca=
nnot recover.
>
>
>
> I have done some searching and found this commit:
> https://lore.kernel.org/all/9de20ac1-f92f-693e-f205-c965a2c6b434@xenomai=
.org/
>
> As my understanding, this issue is caused by "xnlock_get()" which does n=
ot dissable the interrupt.
> So I have some questions:
>
>     1. Do you think our issue is related to "xnlock_get()"?
>         As I checked the kernel code, there are some places still using =
that API, while mostly "xnlock_get_irqsave()" is used.

We may have a corner case around the reboot code - or can you also
reproduce without rebooting?

Furthermore, please test with recent versions as well. I-pipe kernels
are in maintenance mode, receiving less attention and minimal updates
these days now.

>     2. Is "nklock" could also be accessed by POSIX kernel?
>     3. Is migrating back and forth between Primary and Secondary mode sa=
fe? As we previously experienced live-lock when calling Linux VDSO gettime=
ofday(),

This is architectural with legacy I-pipe. Another reason to move to >
5.4, thus dovetail.

Jan

