Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7D3BE62A
	for <xenomai@lists.linux.dev>; Sun, 26 Jul 2026 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091788; cv=none; b=siXmqZca9iq6RF07UPkYdKoMBVXVFx1PYDVKgCTAX9T5s+fov/thOFBdeCtvWS+Eahc7IS7kDLC0jVm7lVebtOu5azY/g59gb1DFxuY0zaPSDl6IRFJvyjTIWmbSW3pZvmbY3L2m+uoXx9glP93uFThx2iQKfO5bWsR/oZeqXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091788; c=relaxed/simple;
	bh=BDJM+imO3s04E8V9zZRbJg0ssJTsBb1SSJEXycuHQ1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZzvpetIeJuztys4opX08zr06azaZSLrN4R+617SgQgci8ZiZ3JPuSOSEKGhJbxynUZwnmiV8AHnn5FTNtpQUd5OwlB1zgUcf53g2IBtwgm8ta2C7ZHW4S1is9tnryo+AgPTEpRWT2jKZbuz1quHZ0OdZJ3P2kHOacwPIkejB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qD1GupDl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qD1GupDl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so21148735e9.0
        for <xenomai@lists.linux.dev>; Sun, 26 Jul 2026 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785091785; x=1785696585; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4HKJv2m0KJt+OBzh4dfGgpxcEDF84lGhDP+0Gsypj6Y=;
        b=qD1GupDl0qNSJvgdfcbaEh6iHxv6aubcE6Qr+dKLm5nhC5AxIbwIB3CnT5/QATJr3a
         4uP2e0Rw/u7yQzp4pVnSqpJcMGnDkTKtB1rRx634P/XzyEwql/Qr/RSJUimbt8vd7Dpj
         KIlE6AkhTcq8UyuFowKIzBms5wX/BAE3/2BS1pava+Eyq9pUWbzWoJs6NCG7qdyHVQ4L
         vFtqH3iTZDYgBxtzzt5ok7vKqk8VfNqu6NijR8uWhr4GfmRizvpy8LsWCGGquL1Z1Obf
         Jo9gQkOFD2x0D9rfiNIKW8pGyCEh5Db0Vm0hfusDfT2Xi2n13/CErIJ/avmXvr684LA5
         8GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785091785; x=1785696585;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4HKJv2m0KJt+OBzh4dfGgpxcEDF84lGhDP+0Gsypj6Y=;
        b=fVCtGBU5xWG7jEbh4kw1g8b4CGINMB0pLqCZ+biDeRJAzk2PHDaoP5f4zcF99fYPg8
         rP+1IHQTUNUlaTsBbc4gbQsIwPDmBZXqAXzeVqBWMhJv6dlt9x43ortqwDRk7Oj2BoIc
         J4vAqbmXRfshdqtbPfE3Op5a9juquCtow7Ss1vKswbdrG0SJ1nm8N51nSBjWGmNXgjLQ
         dD9OMeIsuhpP/3m3XGgTIU5uUIIRvgrRW5i5Sg+9Hk9CZE2wNeO9uPUspC+lMzOb0ORu
         G21bE1Dw+VVRiCt62y0WEROQwcVRp9nYJLv1zTrxLkjtUQy6GGvTpAM6o8G5CZ7OAeAy
         0YEQ==
X-Gm-Message-State: AOJu0YwlA841AOs5wiBJNHiNYMEsHPofv4r5xuJbvU6klMANn/el7q2n
	9auPcOBevjVdT51OTEp66XRI5JU6MmiPKWy1hoIYF1Qe0n2eyAFk26z8
X-Gm-Gg: AR+sD10tS8YnYZnYGhfF87QbXRjxTSFAqJFFRUtP7PcHM3nWfrk5J93owfY/OFN/nQU
	a2lWU48j+LgXrllPNHXPgiY3qdr683BNG/9kANL+OsuHy+LTrOUHRrBQ2NRtprCHLMhCv7d3ZLr
	3jUDZdTTuN4mI1OcEsml5KURQw7M2wPrk7vnpvqBOmJ+Sjr7KjqlSuroTOF6Xc+LbjCqkeBAulh
	ItR80ofvS/WMCyHgt5aXMADoMJAJod2EthfHOL+9c2Jzfo4lYC6CdWqKZV4QwhedMAW+BLD+9id
	bMeDIn2sIwGT/7NpU1s607L8TthuzHsJ9sf5COM9EfKx6XnktldT/lTlfT+uESku1NWBTKS0E33
	BI3dcYj+dDtmyWskXpGB8XsowTlnVgj8Wuwpi92Z8SR4zoGc4YMw0/ZaT9yggGFsudbxOvouc/r
	f+AYhu8aaeJw==
X-Received: by 2002:a05:600c:3154:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-496b56c5393mr79890395e9.10.1785091784818;
        Sun, 26 Jul 2026 11:49:44 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b49a8547sm157732455e9.14.2026.07.26.11.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 11:49:43 -0700 (PDT)
Message-ID: <c81a0805-284f-407f-878a-787c0b571af5@gmail.com>
Date: Sun, 26 Jul 2026 20:49:41 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
 <20260528194459.6117-2-hannes.diethelm@gmail.com>
 <87a4te64vn.fsf@xenomai.org> <874ijm62yu.fsf@xenomai.org>
 <3216fbd8-3ee4-46f7-851b-0f3b48c38572@gmail.com> <87ik7d86kn.fsf@xenomai.org>
 <6c0d9a13-732b-49c5-886b-3dda8b1f5cab@gmail.com> <87o6gmzlpn.fsf@xenomai.org>
 <13bb8457-8148-4758-84d5-1ab324e978bd@gmail.com> <8733xd20u3.fsf@xenomai.org>
 <11409ae1-be7b-4003-8d40-f5e1cb34d2ec@gmail.com> <87jyqodrq0.fsf@xenomai.org>
 <3105aa6e-ba08-4e5a-b228-233473aa5675@gmail.com>
 <dc6c2532-08e4-417d-85dd-8d2e89b34ae7@gmail.com> <87h5lrh503.fsf@xenomai.org>
 <87tspqg9bu.fsf@xenomai.org> <fc1b080c-54ed-4449-8958-fd8be91e1d8f@gmail.com>
 <87cxwe170w.fsf@xenomai.org>
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Content-Language: en-US
In-Reply-To: <87cxwe170w.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 23.07.26 um 09:47 schrieb Philippe Gerum:
>> I have to test it and will send an update to the oob_net_udp patch
>> soon.
> 
> Thanks.
> 
So, I sent the patch:
[PATCH] tidbits: net-udp: use MSG_STABLE for server mode

However, something is not working as I would expect:
The second oob_sendmsg() line 314 also returns
EADDRNOTAVAIL after evl_net_solicit().

If I leave MSG_STEADY away for the second oob_sendmsg(),
it works. However, I see 2x:
== client 192.168.122.1 not in ARP cache: evl_net_solicit
 From then on, it works forever, also if I restart oob-net-udp.

Looks like the NUD_PERMANENT is not synchronized immediately
but only after the second evl_net_solicit(), shown by this test:

arp -i enp7s0 -d 192.168.122.1

oob-net-udp -d -i enp7s0 -a 0.0.0.0 -S -p 5201 -m "Server"
   ...
   == client 192.168.122.1 not in ARP cache: evl_net_solicit
   ./oob-net-udp: oob_sendmsg() failed: Cannot assign requested address

oob-net-udp -d -i enp7s0 -a 0.0.0.0 -S -p 5201 -m "Server"
   ...
   == client 192.168.122.1 not in ARP cache: evl_net_solicit
   ... now it works

oob-net-udp -d -i enp7s0 -a 0.0.0.0 -S -p 5201 -m "Server"
   ...no evl_net_solicit() any more, still works

linux-evl: 9ad9bf1c
libevl:    115d45af
