Received: from butterfly.birch.relay.mailchannels.net (butterfly.birch.relay.mailchannels.net [23.83.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6FB4A00
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604953; cv=pass; b=K7cugKuUXJchHlUP4AuzGTZ1CyQYLNUPJfUNQp6Tb7EQisdlviwcVQYw5EXTtQJaIACaFj10HtPhqTCMIYkJCYYl63CwlzBUQQZ//0kqUFP/NfN+P5qoHWRblJXYApGhQMOOxY6ixUSrktJXOoAWfiiZR12J5sh7G3RZQGU/IcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604953; c=relaxed/simple;
	bh=LJTgjoiK8iSHdV8FohdhAo+BijxoHZn1RAHIE0A/cLM=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EaJNx2mTITUOMZ9Ho0rL5IkYeBDqS0ULsItDq3ELzvHcTr12aMXaN1Mt6pnh94v1HGLguKuB0GsjIOITBxxOv5CCx/dB1Ott4ijSM0+GMLXG8RDC+L3R6C4JsctTC51Tv4IFbqZudwwd+cf2ulsx7WhOQZ4feNQ7EopiANHbTgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=yaZS6ZwC; arc=pass smtp.client-ip=23.83.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="yaZS6ZwC"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 44A957C1630;
	Mon, 27 Oct 2025 22:42:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.120.42.56])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B35CF7C2A0B;
	Mon, 27 Oct 2025 22:42:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761604943; a=rsa-sha256;
	cv=none;
	b=HRGllTMhrzaj8Z1B+Jx0t2VPLlYPjMl4qk0XxUEfeCNGgnh6Jnakl5sDO+vdR8416KpPgP
	qGApSzv6YaOd2JGbdAan+0sA94Yk4plxfMjzkvm1GjO/VVphzfh9Of0O/eMdjaSsLrS3ed
	+CgWne4s/U8tHLuMpdWNPaFlFQQX9e5vaSPXqHP3dGIQ7CJAqAnZslIGryUs7v3X9AM3Ed
	vRF5yAEEeBVjebuedT2JZ+dU5AtPZLlyAxuKtUA8E4f7HLRPrvXhpH7O8pPs2gyMaKlt0U
	T4COOxL8GQQ7Y4iyn3LqSJaEYZZK8jnc61VuM6H0K951ROGvJo+axH8y2GlXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761604943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2g1/HPz8937JjQLc9B+OI0W0SlNTE3kFi/dIW7MaQoM=;
	b=MrA+Xm9Rtq17TOj/dDVVe3yhJblX4rYmh7h3RyFfwcVH06G9mcx5HhACOls7ajNDazVY1F
	1RE0VIClY7DGJvPFRehASKNtgZicJKkh7obPI4lwifa6PrXIFbkVCE0X3hquj/LCjjCavf
	AbcXFszDInjt3j2AvQnxjezUdCN3J+foSkWO3Q1xDD+HMMinb8IGS18enXcu7WWYqd2oHo
	WYmUKGCDENiRDq9yh5qtkfzq3nJizUc5WeXvAR2jHp9paBe9iEidwjCSSTBgab8m8lbGLk
	sg7jTakixI1QI+dGmIH7NfzYkjOp06430SRrOIGuFJb6ghV3Y8rIHhgxpOlhAg==
ARC-Authentication-Results: i=1;
	rspamd-9799b5d46-4hjb8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Whistle-Left: 165271d427bc0a76_1761604944031_317931092
X-MC-Loop-Signature: 1761604944031:120029289
X-MC-Ingress-Time: 1761604944031
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.42.56 (trex/7.1.3);
	Mon, 27 Oct 2025 22:42:24 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.170.47.63])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4cwT670vkhzQ9;
	Mon, 27 Oct 2025 15:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1761604943;
	bh=2g1/HPz8937JjQLc9B+OI0W0SlNTE3kFi/dIW7MaQoM=;
	h=Subject:From:To:Cc:Date:Content-Type:Content-Transfer-Encoding;
	b=yaZS6ZwCk9BVC/TvSNsjHUBb0zaAi3sZDG+h6ECyALG23eOC8XZY+1L9of7baT1XB
	 obIqnc7qB1UDmOMnTgDXi+tMivVBXH9aVWYUo7uY2UAIWHBmDHQTHlZDrWeQ8BqmKI
	 5DaWKQj2k70FnWxhJOgAKyksUdgX7PV+HP6QFc7o6c35cd3sldRxePUWVJ9g97P9QI
	 WkUtIMLgG+ipm/5ajqxUn/BMoGc6NvlWI4Ns866ufdmcZkPg7lq3EU/piRFlfYEuZa
	 meKbGE6zrdNRXYBjmIuRI68xXWixfPjAAFs3Itdz4govkbG4KAC6QTl/2y08mXCgck
	 DxD3suM7OVJBw==
Subject: Re: Unexpected switches to in-band
From: Giulio Moro <giulio@bela.io>
To: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@nabladev.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
 <20251009151737.0d03b211@wsk> <20676160-4572-d92d-4b33-ff4255946345@bela.io>
 <87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
 <f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io> <20251020094705.2ac256f2@wsk>
 <9d2bacac-8d70-f083-e926-21beee2207c2@bela.io> <87o6q1ad07.fsf@xenomai.org>
 <20251023155439.0170f987@wsk> <87a51djuor.fsf@xenomai.org>
 <20251027120535.7933c720@wsk> <20251027172505.29eecfb2@wsk>
 <70047565-fb8c-e402-eb04-0aed403b3b12@bela.io>
Message-ID: <a5aee9cf-b0e5-aed9-f81d-83ec011612ff@bela.io>
Date: Mon, 27 Oct 2025 17:42:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <70047565-fb8c-e402-eb04-0aed403b3b12@bela.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Sorry for my late response, here are my logs:
> 
> files.bela.io/Xenomai4-ISW-trace-6.12-logs-2.txt
> 
> this is the kernel in use (with committed .config): https://github.com/giuliomoro/linux/tree/v6.12.y-evl-rebase

I managed to collect a few more traces.

files.bela.io/traces/traces-1.zip
files.bela.io/traces/full-test.sh << file used to generate them, it uses the `alloc` program I provided here https://lore.kernel.org/xenomai/87wm51sb3l.fsf@xenomai.org/T/#mef94253db4bf13198b1ca7ac30d268fbc1acde94

Interestingly:
- latmus tends to fail towards the beginning, or it won't fail at all, so full-test.sh kills it after 10 seconds if it hasn't failed yet
- sometimes I boot the system and latmus doesn't fail after 20 or more  10-second long attempts
- sometimes I boot the system and I can get a failure about 50% of the time
- sometimes (30% of the times) trace file is empty (it only contains evl trace's comments)

I hope these help, let me know if I need to change anything.

Best,
Giulio

Giulio Moro wrote on 27/10/2025 13:16:
> Sorry for my late response, here are my logs:
> 
> files.bela.io/Xenomai4-ISW-trace-6.12-logs-2.txt
> 
> this is the kernel in use (with committed .config): https://github.com/giuliomoro/linux/tree/v6.12.y-evl-rebase
> 
> Best,
> Giulio
> 
> Łukasz Majewski wrote on 27/10/2025 11:25:
>> Hi Philippe,
>>
>>>> so either some
>>>> traces are missing,
>>>
>>> I will check if I can add more tracing.
>>
>> On one console:
>> ---------------
>> evl trace -eirq -f; sleep 1; latmus -c 2 -p 1000 -P 99
>>
>>
>> On the second one:
>> ------------------
>> test_prog/stress_prog_NO_IO &
>> sleep 5
>> test_prog/stress_prog_NO_IO &
>>
>> echo 0 > /sys/kernel/tracing/tracing_on
>> evl trace -p > Xenomai4-ISW-trace-6.6-logs.txt
>>
>> First trace:
>> ############
>>
>> The relevant dmesg output:
>>
>> [   75.214527] EVL: timer-responder:743 switching in-band [pid=745,
>> excpt=14, user_pc=0x77d08492a5fe]
>>
>> When I do look into logs - there is also a "hole" when the ISW is
>> reported by dmesg.
>>
>>
>> However, there are some hints when we look around evl_latmus:
>>
>> timer-responder-745     [002] d.~2.    75.868139: evl_latspot: **
>> latency peak: 18843.649 us **
>>
>> On CPU 20:
>> stress_prog_NO_-752     [020] ...2.    75.868139: folio_add_lru_vma
>> <-__handle_mm_fault
>>
>> Which ends with folio_add_lru()...
>> And after that we do have the ~18ms latency peak.
>>
>> And the "folio_*" is a relatively new feature added to Linux kernel [1].
>>
>> The logs can be fetched from:
>> https://nextcloud.swupdate.org/index.php/s/EjHo5EAwMTeY5ya
>>
>>
>> Second trace [*]:
>> #################
>>
>>
>> [ 1610.086961] EVL: timer-responder:768 switching in-band [pid=770,
>> excpt=14, user_pc=0x72e9d35af5fe]
>>
>> <idle>-0 [008] *..1.  1610.076068: rcu_dyntick: Start 1 0 0x2ec
>> <idle>-0 [003] *.~1.  1610.102242: rcu_dyntick: Endirq 0 1 0x404
>> <idle>-0 [003] *.~2.  1610.102242: arch_handle_irq <-arch_pipeline_entry
>> <idle>-0 [003] *.~2.  1610.102242: irq_to_desc <-arch_handle_irq
>> <idle>-0 [003] *.~1.  1610.102242: ma_read: mtree_load
>>     Node: 00000000c4071949 (0 18446744073709551615) range: 4355-4355
>> <idle>-0 [003] *.~2.  1610.102242: rcu_oob_prepare_lock <-mtree_load
>> <idle>-0 [003] *.~2.  1610.102242: __rcu_read_lock <-mtree_load
>> <idle>-0 [003] *.~2.  1610.102242: __rcu_read_unlock <-mtree_load
>>
>>
>> Now some questions:
>> 1. Why '~' (i.e. oob stage) is on CPU=3 as we pinpointed execution
>>     of the 'latmus' to CPU=2 (and the command line has isolcpu=2) ?
>>
>> 2. The mtree_load() is called in the OOB context... IMHO, this shall be
>> done before we do start the latmus?
>>
>> 3. In this case - there is also a "hole" between the ISW time
>> (1610.086961) and the ones between rcu_dyntick: Start / Endirq
>>
>>
>> Link to the full log:
>> https://nextcloud.swupdate.org/index.php/s/nPRAnqCLFDibX6r
>>
>>
>> Note:
>> [*] - All ftrace options enabled in the kernel
>>
>>
>> Links:
>> [1] -
>> https://github.com/torvalds/linux/commit/49f8275c7d92?spm=a2c65.11461447.0.0.68003853Pbec3R
>>
