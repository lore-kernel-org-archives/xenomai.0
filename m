Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1D2E06EF
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783270188; cv=none; b=A1U3MO/wqb1l/iLLZqi1bRld07jDNbo/rrGTI254Nh2mMB+CKy7LWK1vmcWBIdfRin9SXQ2wxmeQulzrgvQq7OGk3w3RHPu8YZ0cn7Zyhx71lgdI/OQCrNj4yc7qbMf5r4C0qGCsSZVI0qL5XgU6Um6P9AKC+1Q3LdSPWuojbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783270188; c=relaxed/simple;
	bh=lGGspXM2SFC6SFmQjWrrPLFIeF0Z5laSsiDn5jbhpQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i3hbFMKul+nHEf3suLF7oA8h9ZaJSpaUwgxA6K70HxoIbQWEScjBWgqcH7iCXcYk/GG8xEuBiu6KEPdR46yk5ZlwQw4Nrtrj/D2C6y4+xOLBvy/JDXVxQUW4UDovl//YAsX9TYaIdO0sNuPjyZKSqAH6j7dLL2o7Y30toM41oyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=CsorX9XZ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="CsorX9XZ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF8E91F416;
	Sun,  5 Jul 2026 16:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783270184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+jc5ISK0IfFHYPASA06Oe9hzNKRBwQWPnMhIz7DDRs=;
	b=CsorX9XZQwejCfoIEc69BSo1vz3lj2aXLizylWFQw6x+npXpN5Tt34kfPQtdAkp3rHymLz
	Ym78hVpm+eHNrhscn/OIw0EjjvMIxQOaJWI4oSoYfiCwrwYH8uUlgJi5UH8sVljS90Hk6c
	QrncPcIawe+fAemqxyeMq/wkfM/wOTX1AbqSSFZIw50qUBU1+EasUgOCF5EgAyTrdAneHY
	lcGMLYZoo/o3oQGF3yFDOChN0vzib0VlcPesO7BECfhJTaxP2NMqxDWWEjkMu3MrYUFlA0
	QqHvKFsxnVlda9nTltYG+ef7lmAJphrSIlUOF+iaqpamRu2BTYuMqCWF0mnngw==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 0/1] tidbits: net-ping: add ping tidbit using raw socket
In-Reply-To: <c67924a5-603f-4c8e-b958-f055dd9b1bfc@gmail.com> (Hannes
	Diethelm's message of "Sun, 5 Jul 2026 17:21:01 +0200")
References: <20260628153956.1435330-1-hannes.diethelm@gmail.com>
	<87se5xmqf6.fsf@xenomai.org>
	<c67924a5-603f-4c8e-b958-f055dd9b1bfc@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 05 Jul 2026 18:49:43 +0200
Message-ID: <87v7atqt3s.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFVj20DHq2Ff3kZp36DTTgrugTeB11lQYiiDCRBePkefJmRE1auxkIXcLLDz1Qax8XP/W+hIJ8gpCkLyUcg6mWbhyFzX6IKXRYbvRqAeRj9tyx01vte/rqWg0Faybyb73TaUkb3/mcRPEU1WBVR3/gaeawilawftTzanIap0dfvC/fSlG/K4DRZgjItxK8mIrqkfl8WkVRdVdLr+L6BEJ8fyCg2OWZ1c00304S07eaMDC9pWRYg0CHpfHf/KnrgI/Cdl1NtNVjVHXsY99agyZMjGgyXTnH4yhT6jgu9M1xKlROZ1B7s/HCSU2N/bK4TbCrQQeBXMqw8f+tP+voUF2MFOlTzjNRKB+6rFpRis+1NGhZot2DAN2AAF+jGZQOOSyapUQWRu0MprZKtZ7YpXecPSdHPS7OTKSvgcrg/gJN3CSfxvR8Prf+WOZUpOCDIPUNoZXdyz4JjXfVLnWnvwbBGjNQURCKYoUJIbKSrz6rDlHxPQlx8sP0tlDAilpOm73U1JoJ+cX6/Vb3C47SFjfPdOVx+1kzAQoRDbtSRUvJD2OwImlJuID38OTrw+cacMKvqd8eJr6DBdGIN+JkF/3gTH2BybxJTwsfWYgfqnhznnTUC9PY+E8mksSsAyFltLBn1c30JzuUZQEH08eoS/U023oC9QF/lnY1WZanvi4/+OQ

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 05.07.26 um 17:01 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>> 
>>> This patch is the result from experimenting with evl networking. I use it to do basic
>>> connection tests from the out of band network and check the timing.
>>>
>>> It is a bit complex due to evl doesn't support IPPROTO_ICMP sockets.
>>>
>>> Using the in-band network stack, you can use: sockfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
>>> and then only send the icmp part of the message. However, such a support is not really needed,
>>> it works fine without.
>>>
>> This said, we have an ICMP protocol module in the evl stack since
>> recently, which only responds to ICMP_ECHO requests ATM, directly from
>> kernel space. Extending IPPROTO_ICMP by implementing the oob_sendmsg()
>> handler for it there has become an option.
>> 
>
> That would make the ping tool way simpler. I can also wait until this is available and
> create a new patch. It's mostly done just to figure out that IPPROTO_ICMP is not available.

Ok, I believe having IPPROTO_ICMP would be the best approach. I'll
let you know when this is available.

-- 
Philippe.
