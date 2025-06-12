Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95C2750E2
	for <xenomai@lists.linux.dev>; Thu, 12 Jun 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741121; cv=none; b=YAv1QJU5lf8G6UcIajFk+xx74m4EGpVeK5mzRoIQZF34eeWzQ2wiZHcOB96KTsLlRMRbci7JzlxpIV7fFyMKU1cTydi37kwWXlbbS8gt+IpzuOxSxgpwnqbl4xuJ/rxTu3yS44lE29K9nUxdiCjtQYO9W5/A3YkkODvnX88u72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741121; c=relaxed/simple;
	bh=6qLaa5n3b4LZgbb+9IhxLbR8OLQrZ7/WNxhq2ZPoaSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SYFNrI/qYrOAZj5FxfKnacQsGQ9/Axwkg2wXXZHlk4/4kamQrU6Cw2x4RDvrDPlwROfwsPJhTWIXsfCEWs5IWypFunD8v6ml/sA8MMXbIpgSi0WB9gJM7TmDMf2hI2r92GAzqFSpn22+sHzJU5BdyTLDjPEGsfazHFNMGqlesTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=YIz+OYna; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="YIz+OYna"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C40AE43A23;
	Thu, 12 Jun 2025 15:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1749741111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPivb8FKLhGLksb+u61+5i/Rd3uxKGDyHJLJ81w50EM=;
	b=YIz+OYna/+nnObVo4shb8tvB51PUD4tHoSvY8jJrhfWafPBKFSuNdNlKmc9OnkRatAjkWe
	wAMh29i3nqxxP1W8GDrfjX/4Gd3NbanPcSkyGWUYlezRkRWXJxFe12KyuY/K6U8X08H2Gp
	Oi8FBcqr57HgVqo3MPr6qnhsGXsCHADj0qzZl6aGGnSfFuwMHx2j9Ldx7Tl1yfpwSVZ56y
	ZH87U6oZJpcoRCxjXmK1XPsN0pZAXjnp8yFQIwvBmM3IvpC0HQ40B4iDZIMjeeb1VTdzFs
	PR2wcX2ytyo1pQ3TdTmNO/rsu3dGOdKrlcXD4wJExRMU8UHBhZLJE39qWo4SLA==
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
Date: Thu, 12 Jun 2025 17:11:50 +0200
Message-ID: <87qzzpuh8p.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepgfevgfefhefhhfefhefghfeikeffkeeliefgjeefheetieduveegfffgtdelveeunecuffhomhgrihhnpeguvghngidruggvnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

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
> Jan

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 26be743f2a6cf..67920a8a66733 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8910,8 +8910,10 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
 	if (unlikely(!skb))
 		return NULL;
 
+#ifdef CONFIG_IGB_OOB
 	if (igb_is_oob_page(rx_ring, rx_buffer->page))
 		skb_mark_for_recycle(skb);
+#endif
 
 	/* update pointers within the skb to store the data */
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-- 

Philippe.
