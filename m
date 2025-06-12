Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04B2F4317
	for <xenomai@lists.linux.dev>; Thu, 12 Jun 2025 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737750; cv=none; b=q3tkQdOAEVwYRmVIjwMz1IEUtfyuy3NrfX6i3wjCx0kuK9xVsfH5SiwPxu0tsy1Mqa6wPXoOYFh1/pAq3yjCMxRxWecUrb6dwR3561kecI+xJOutEXojeqVhzR6ZjtAsqI3mWdGj/IusJbBdKI+vu2T5Ibb2+/T+qbBLTEYUJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737750; c=relaxed/simple;
	bh=oBriBAnK3RBCIWUCIm31hKRrV51C8r1Rrtki6r+oRCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i1Z3vwEOBJd30d7WUYE0iz0z9vLmaXg3U5Euwit/bQNU7PqzJ4A26+W6YDePkjGfy4Rmq/r72rqnGT62DUDY4dO1FUn0RjcuufrIoAuWgE1g5vo6AEW32APwj1vh12+SMagKQSxdlxuzFSvWwgqVWXUGZDQzFeFUZ+CUBCdyTes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=izeJtbM4; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="izeJtbM4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA03944270;
	Thu, 12 Jun 2025 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1749737746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0MAYPqf/xTcHiGLZ1rHuLU8V2h/4me5BVWTQ7w1zH0=;
	b=izeJtbM4xuYnDyQEpaIn5Ud2fuUolIExP/7SCKvBNHg2a9CWBTcGo+fiiTGeB63yAle2QO
	cE1MN2u4qHfIA99HqE1kZURGVYzv0cRTpFWguIqv4ZCGA1KaGzK9/LXD7CV7KvWud7uZbA
	JczTHtaFEbij+a7bERH8Uj5lOnasQsyFhzHnmpYDVs+Gy1mE4xpcDXSo2ymc0JcIWZt3ww
	2PI8Yb1nRq3VRxm5SkDzXdk0/HZkNpFIWQiSIsspuAZ9PxKaEsZY48ZO7SXSEI1PFKr9S4
	CM+ybEaz5Chv2grnakPUP1RrsEubxxGdzlhrzcw3GB9nnu4LfThhBdeGvVaMwA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH dovetail 6.1-cip] igb: add missing header for oob
 extensions
In-Reply-To: <847f6d81-cf28-4155-b969-aeebb76e03c8@siemens.com> (Jan Kiszka's
	message of "Thu, 12 Jun 2025 15:58:28 +0200")
References: <c564966e-2ca6-48f3-ae28-dd7707856f7c@siemens.com>
	<847f6d81-cf28-4155-b969-aeebb76e03c8@siemens.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Thu, 12 Jun 2025 16:15:41 +0200
Message-ID: <87wm9hujua.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduhedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepgfevgfefhefhhfefhefghfeikeffkeeliefgjeefheetieduveegfffgtdelveeunecuffhomhgrihhnpeguvghngidruggvnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 11.06.25 18:20, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> 
>> Not yet tested, but this should make our pipeline green again:
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1166309
>> 
>>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>> index c0932a3cb220f..26be743f2a6cf 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/pagemap.h>
>>  #include <linux/netdevice.h>
>>  #include <linux/ipv6.h>
>> +#include <linux/skbuff.h>
>>  #include <linux/slab.h>
>>  #include <net/checksum.h>
>>  #include <net/ip6_checksum.h>
>
> Sorry, this was wrong, at least insufficient:
>
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1167536
>
> Seems there is no way around reproducing locally. Will keep you informed.
>

Meanwhile, I noticed that threaded IRQs were allowed to switch to oob
mode, which is quite wrong. This causes the oob-capable IGB driver to
run into a serious issue when forced IRQ threading is active. I'm
working on this problem, which is a Dovetail one.

-- 
Philippe.
