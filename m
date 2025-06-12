Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9002F4328
	for <xenomai@lists.linux.dev>; Thu, 12 Jun 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746228; cv=none; b=ukT3DuVjZCoQhRH2RUFBD7ntFCtW6/ClIrRa57FVaMLDf33opEwFAwsoCfaCafDGHqU2e99th6dUz9z7gP/IpKRjlQBVauoCvBxcfsJB7mFOKAGp+IRji6OIybjBsZ3eej4zQyTHNHi10ZfRswmbYZyOxY2DnHHM2NMeXA7TjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746228; c=relaxed/simple;
	bh=xtgGzXJzKzzhpJVh8E6HrV55OaUDbjky4ExEvlzvWfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eSPv7PunZNvoNdh5mgBJ74h1HSsspwLGokHeZ17VYUxcKh99uOrH95RDhREvftSEBDWV8DK1SieT2Doeb5l/yCSnuREvJUtzvor5BOB4glx7MVT2BtFH3ExsFL4cxutMHg0bRNOCEdpyNteorOM0tu28rAEdJaAb8hdPMoVuw3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=kL/HTGRs; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="kL/HTGRs"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A613C44339;
	Thu, 12 Jun 2025 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1749746223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzEbTlJeKGBC4hWEJCj6Y0rUgAT9T3SVE40QinM9PoE=;
	b=kL/HTGRsDxOiIX1Rr5YynSVvIwgTvEFPWnnaO3ll+W8f/IEMr5yUcS0fvod/iyS9iPUDpx
	33+ePSLXbnIksSy22x2XSU58DJl4hflfIQBRrnbC+J9Z0XcD8k8HL3EVAddNBKaCepaUSt
	Bz2Vk932STcrDBmskUlqEbmofYFFbRT+q40q+4Dv3AO4OdoO6RpmcE1Zv+2yZws4SyWnHm
	uZ8Soz2Ibtc//+fZTCuPipSXKgQ2kCFkKNnyhrxJb+LF/DLUZbZDrTOVtfc0Dj7BOxccsb
	16JmW79txFaUxpNtnb3No3MhAtBnEpOCL20ZKtx6wKXiMDMv5pNYbE8V6cXnSA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH dovetail 6.1-cip] igb: add missing header for oob
 extensions
In-Reply-To: <edede9ec-0b4a-40b1-8a7e-0784db1d9a43@siemens.com> (Jan Kiszka's
	message of "Thu, 12 Jun 2025 18:15:09 +0200")
References: <c564966e-2ca6-48f3-ae28-dd7707856f7c@siemens.com>
	<847f6d81-cf28-4155-b969-aeebb76e03c8@siemens.com>
	<87qzzpuh8p.fsf@xenomai.org>
	<edede9ec-0b4a-40b1-8a7e-0784db1d9a43@siemens.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Thu, 12 Jun 2025 18:37:03 +0200
Message-ID: <87frg4vrv4.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepgfevgfefhefhhfefhefghfeikeffkeeliefgjeefheetieduveegfffgtdelveeunecuffhomhgrihhnpeguvghngidruggvnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 12.06.25 17:11, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 11.06.25 18:20, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>
>>>> Not yet tested, but this should make our pipeline green again:
>>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1166309
>>>>
>>>>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>>>> index c0932a3cb220f..26be743f2a6cf 100644
>>>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>>>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>>>> @@ -12,6 +12,7 @@
>>>>  #include <linux/pagemap.h>
>>>>  #include <linux/netdevice.h>
>>>>  #include <linux/ipv6.h>
>>>> +#include <linux/skbuff.h>
>>>>  #include <linux/slab.h>
>>>>  #include <net/checksum.h>
>>>>  #include <net/ip6_checksum.h>
>>>
>>> Sorry, this was wrong, at least insufficient:
>>>
>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1167536
>>>
>>> Seems there is no way around reproducing locally. Will keep you informed.
>>>
>>> Jan
>> 
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>> index 26be743f2a6cf..67920a8a66733 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -8910,8 +8910,10 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
>>  	if (unlikely(!skb))
>>  		return NULL;
>>  
>> +#ifdef CONFIG_IGB_OOB
>>  	if (igb_is_oob_page(rx_ring, rx_buffer->page))
>>  		skb_mark_for_recycle(skb);
>> +#endif
>>  
>>  	/* update pointers within the skb to store the data */
>>  	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>
> Yeah, that looks better - we are not enabling OOB networking in Xenomai 3.
>
> Jan

This is related to the page pool support, not used by the upstream IGB
driver which manages packet memory somewhat manually. That support has
gained an oob extension NET_OOB wants, so that we can keep most of the
original memory management unchanged in drivers which already depend on
it. IOW, IGB_OOB -> NET_OOB -> PAGE_POOL_OOB -> PAGE_POOL.

-- 
Philippe.
