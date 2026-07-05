Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56523FC41
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783270345; cv=none; b=hTc+4E2Afzbvd5nOZvbqJ/4sLCuYMOQ9FVyFLvr7BY2GbMl9eyYd6HvHmrBbn6OymMMuW6i+/Qy7rrnbDB4Qmr7mCgpk5unouDDE3av1Froo4ewIZl7qg5h7KeiVcEKvumuGKzGEpt2cvc1pZ25edscNJTOk5oXHyVnXDzDoo1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783270345; c=relaxed/simple;
	bh=wV6Cr5ofCosInGxcPiKG87ongRlMZ7ONcfr2wzMHNXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lxV822/KtETMmHn8wCgf10hIv6YjjMTf419ItZ4HW8rJh1smIsrZau+zMc2WHavXYRcjWNFy2TSheMcM1vaQF+9x0/ixrJZQgKaRZ3KrtY4sntiuNdqlWbdTLQzdpZxqS3HkmigWwUH5JCqKPA9BZkYyybKJY9KP5IwF6hnQ9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=STAEbpuL; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="STAEbpuL"
Received: by mail.gandi.net (Postfix) with ESMTPSA id BBB893ECD8;
	Sun,  5 Jul 2026 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783270335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bBrjEcVmy2wj8uXUnrKakA4tGJX3kFHvbqonjjUiTdc=;
	b=STAEbpuLTCLzAvHkDhMKSQ8LZkTPZR5wsG+L0Uam8pBq9G+CoG+DZiFXI3ivZZnbhgSiEy
	pA4HnB5YYgDZsQwwmpiIEjaXTCkIO2hAQ3MsGEkueUZG1MLFKS5hL7fMmIbY6Fn96lG/UZ
	131ODRVAwsUNezqbASV+ZOPLlpcrsEgocwhkz2uLCIpici852e1/H/pTbwPO9EH5TFr3fQ
	r0o1IFst+Zq3u8Yw9aIVUDbaEvQ9O8M3wLKVOszo7gwpHsj9r60nNBbEafTM+PhtwGoLCo
	zqQgq0dP/EKpfeERuxlkSmUo09ZB0/g5UMGc+paX3zcvCGytImRe3AqkTtr8RQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-ping: add ping tidbit using raw socket
In-Reply-To: <7f0d1a81-adce-4d15-9707-87b8469cf8ae@gmail.com> (Hannes
	Diethelm's message of "Sun, 5 Jul 2026 17:27:55 +0200")
References: <20260628153956.1435330-1-hannes.diethelm@gmail.com>
	<20260628153956.1435330-2-hannes.diethelm@gmail.com>
	<87y0fpmqky.fsf@xenomai.org>
	<7f0d1a81-adce-4d15-9707-87b8469cf8ae@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 05 Jul 2026 18:52:15 +0200
Message-ID: <87pl11qszk.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTFVj20DHq2Ff3kZp36DTTgrugTeB11lQYiiDCRBePkefJmRE1auxkIXcLLDz1Qax8XP/W+hIJ8gpCkLyUcg6mWbhyFzX6IKXRYbvRqAeRj9tyx01vte/rqWg0Faybyb73TaUkb3/mcRPEU1WBVR3/gaeawilawftTzanIap0dfvC/fSlG/K4DRZgjItxK8mIrqkfl8WkVRdVdLr+L6BEJ8fyCg2OWZ1c00304S07eaMDC9pWRYg0CHpfHf/KnrgI/Cdl1NtNVjVHXsY99agyZMjGgyXTnH4yhT6jgu9M1xKlROZ1B7s/HCSU2N/bK4TbCrQQeBXMqw8f+tP+voUF2MFD+ZHJZ1beV17PI3K4IlXhoPQTwbd//qGisOPnb2dGic/62TzXs8ZBYMtvhyuV2gP6JrqShJ+F6M+keUV92Ly+vaElfu2IHkVRhQ3cIWKJo7w1WblCMkYIpEVAs/Bz51v/H1v9WhY3UMPJF+MMls3Kic5CaMtQC5QDjuu6+OhQXypDp6zs5n0RIUZhRlmgj6AltBTIt0751f6qRuniERkKbOBvCrLzkNWSzzimU5B+d++UuasRLDiLA3MVvtakVWHqN61T24yIkSxJyGGBEZkprJ05MvHxdD/PDwnussRWv2V2Cx7JJY219di2kdaly94cKmYnrMEB7WnPCygDBHqpw
X-GND-State: clean
X-GND-Score: -100

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 05.07.26 um 16:57 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>> 
>>> This tidbit allows to ping any host and measure the response time.
>>>
>>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>>> ---
>>>   tidbits/meson.build    |   6 +
>>>   tidbits/oob-net-ping.c | 480 +++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 486 insertions(+)
>>>   create mode 100644 tidbits/oob-net-ping.c
>>>
>> Thanks. We need this to build on 32bit systems:
>> --- a/tidbits/oob-net-ping.c
>> +++ b/tidbits/oob-net-ping.c
>> @@ -215,7 +215,7 @@ static size_t build_icmp_request(uint8_t *o_frame, size_t icmplen,
>>   	icmphdr->checksum = cksum;
>>     	if (verbosity > 1) {
>> -		evl_printf("ip_len=%zd, icmp_len=%zd, ip_len=%d, datalen=%ld\n",
>> +		evl_printf("ip_len=%zd, icmp_len=%zd, ip_len=%d, datalen=%zu\n",
>>   			   sizeof(*iphdr), sizeof(struct icmphdr),
>>   			   ntohs(iphdr->ip_len), datalen);
>>   		print_ip_header(iphdr);
>> What about turning this code into the (currently missing) 'evl-ping'
>> utility? I believe it is of general interest to any user.
>> 
>
> Thanks, I will fix this.
>
> Why not. So I would move the code in the tools place and rename it? Meanwhile,
> I was continuing work, so statistics are available, ping style.
>
> oob-ping:
> 2 packets transmitted, 2 received, 0% packet loss, time 1633ms
> rtt min/avg/max/mdev = 226.8/248.3/269.9/21.6 us
>

Yep, that's nice. We would make good use of this program as a standard
evl utility.

> ping:
> 3 packets transmitted, 3 received, 0% packet loss, time 2030ms
> rtt min/avg/max/mdev = 0.118/0.142/0.159/0.017 ms
>
> The only difference is, that I use us instead of ms. That could confuse some users.
> What do you think, stay at us or use ms?
>

I would stick with the standard ping convention (ms), maybe adding an
option to display delays in microseconds.

> BTW: This is in a VM, that's the reason for the bad timing.

Noted.

-- 
Philippe.
