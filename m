Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1E5D8F0
	for <xenomai@lists.linux.dev>; Wed, 11 Jun 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661367; cv=none; b=qPfpBVlntNfJJhRheYnk/SW1QImdSUFYM4Vs9/Ht+o8mKLhlJm/bCSSoPADyDJ6xg5XntDR1AW2oRffb44GwrCk20sXx7nOE/gpC2izKdgfYuGx4H/KwUqO70HJ1Q+x5xO4Hw4fzs+gLk6Vz+ZBjPsb2ktZeRYL5yM1fGvNImNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661367; c=relaxed/simple;
	bh=uhmG7DiCPFj7a5Jr0V3sZmS2u2kuVbMmGFii6PpSO9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WuJWzZcXE+VppliA1+6KyUrHek4F7aSJAGvCR3Ck+T0Go9NARZK6eMEDQh21e1EfSxi3+DBYj5FDylG43ibuNfT4qVqVid2dbCmJiXthbtBUyWugZAd9xscUB4nbs2izDRYdRNl0luszOQcpaH9EvO6rB+cKxMF7nGUOcMyFZak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=c8R4gpMJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="c8R4gpMJ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8903C4442E;
	Wed, 11 Jun 2025 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1749661362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bs6q/kKPoXwaIA8DdFo5QsQCkYFguuT6yr1zqoCk0m8=;
	b=c8R4gpMJvvJZDcGTk3Gu4yvIFhlbKp9UYuNYXwri71vGvzKj92nzi1g5CFnGrHdHdq4mpH
	WQuYcmUMr664JQT9M3ZWmG8vLfjHUoD4RGBiVxurNVSkHmHbk00ze+q6s7hUkfoVCoIgpu
	33+IZgiW32hBzne5yEyrQkxDTpBcKX50iAqGINxEhVi3QNTbXTwsOyWsG1oebDqYLxeIgM
	xBV/kr2HN3ORR126l3LDmehwk3iNM1Wi3vV/5ElLnejllgBms3dZh3ZVDf1fBNXf+PD5mc
	VtNB2tpZzEI0dSoxK4+EtSeo8hgpfN6qg+OmgqItAe9kTVJIcCbXk1TSwZMD5A==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH dovetail 6.1-cip] igb: add missing header for oob
 extensions
In-Reply-To: <c2874537-14c2-4e1a-b8da-20ed0e50661a@siemens.com> (Jan Kiszka's
	message of "Wed, 11 Jun 2025 18:50:03 +0200")
References: <c564966e-2ca6-48f3-ae28-dd7707856f7c@siemens.com>
	<87wm9i2q1s.fsf@xenomai.org>
	<c2874537-14c2-4e1a-b8da-20ed0e50661a@siemens.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 11 Jun 2025 19:02:42 +0200
Message-ID: <87qzzq2oul.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepgfevgfefhefhhfefhefghfeikeffkeeliefgjeefheetieduveegfffgtdelveeunecuffhomhgrihhnpeguvghngidruggvnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 11.06.25 18:36, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Not yet tested, but this should make our pipeline green again:
>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1166309
>>>
>>>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>>> index c0932a3cb220f..26be743f2a6cf 100644
>>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>>> @@ -12,6 +12,7 @@
>>>  #include <linux/pagemap.h>
>>>  #include <linux/netdevice.h>
>>>  #include <linux/ipv6.h>
>>> +#include <linux/skbuff.h>
>>>  #include <linux/slab.h>
>>>  #include <net/checksum.h>
>>>  #include <net/ip6_checksum.h>
>> 
>> Interestingly, the original code never directly included that
>> header. The x4 includes it indirectly, x3 does not since it does not
>> use the oob netstack. Applying this patch, and forwarding it to v6.12.y
>> which is going to have the same issue.
>
> Interestingly, the current 6.12.y builds did not fail.
>

Maybe the pipeline ran on the fixed tree already (or some indirect
inclusion was at work with v6.12..).

-- 
Philippe.
