Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56202253958
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289827; cv=none; b=hTBrj1oZAfk15XI+AlP0C4oTvDhi5Yo901hREZWT3r+l17OCc6SS8787VVudXSNvX7kn4SgjfWCM5opi4q+XmeOn7S45EbB2z68g+LF6F/LMAlCKIdJzgNdWukL/+zM/NDXq2Os4ARts9wTsfROCic+KKVXE2wJSxMLCwEcw3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289827; c=relaxed/simple;
	bh=FnzAC8zONKdvA2GKNWPLF4dF400dpAVTLcHTA6khHV4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Ln3PSblit2Khouym9T5sQg+jyBoD6unJlPdQ9Fg5LNywYvtTimSaL0/X4Rg2xJssuOAtfAVGaqYJbmSI5dgEbDrGPRkWMfiqbanPDuKRrXFagfqpfGYO3gDLlohHzJRMl4bUu+dzRo3YAWIJ2VRgz1h4i+KAd6NGtvXfwml48uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoWUcBxq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoWUcBxq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso14600435e9.2
        for <xenomai@lists.linux.dev>; Sun, 05 Jul 2026 15:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783289825; x=1783894625; darn=lists.linux.dev;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA0wVlzXwU+9/xcpC8qTUDnfAyudPj/h586VYEqFw2E=;
        b=WoWUcBxqBXTHWQ/c4Jb92Arjj1qnMp6bPx/n6G9XgpdaXc1+pHuEFme8YVWyx3bc/9
         ICQHRebp3n6P9JRtDXz4J5kh2UxGzCZyJSfvUZagcUporGK4to4ZYP5qVvv6Pw+odNHH
         SR5VXKtozxeTnkPA8vSg3mtBwJLIwIoQYpo6KtbuFAMDlnETF4x2Va81ikiqu2GCwVOJ
         xImwoECsaMdBj7cj5+3Y03wflAOnpdD4JuKuX3xi14Y/s1mJKKFIufT8w5AsyjtsEi/r
         cpP/9++/E3sZMVxjT2lApFuUxz43e/PDKwo2XzHz00PynwWd2xcJfmEZ2jDufXO35+SW
         sxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783289825; x=1783894625;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hA0wVlzXwU+9/xcpC8qTUDnfAyudPj/h586VYEqFw2E=;
        b=RZ65W5WSl3xklwqolLANbAUwEaLwwhSZMLBe9xeZBu58XvJQUN3NJlBF1/1hP39KVT
         XCEc1ayflvthvd+NvBtwSQeBpameh5TazCR65dXIYSKEt9dFiCg7bj6RbcbLErHGVyJz
         4PocDBrOBbH1ZHtZ7KGAcf7hxCR56kStbtB+y6F1MNNPei929bKH3NNHtpKKJQwriF37
         gQdWUqsu9qT4bictPLY7KMDT91nzRBwV9ORUeRiqnMY40Gl13eK9hztmxSClRcZWRZYv
         jFpocQgzrn5NrIXR/LwU4/u/zvJbr/H4F7YqGo7tIZWLNFvND44KhoyXCeRe7NbOjFK8
         ma7Q==
X-Gm-Message-State: AOJu0YxxKUSzwFlJCKqWiT+5PIsz9FIYirBB++6nZ0KgY6gYPyLDxept
	WTuHECadhm/2JOXB3OEUu1r9Wv/5uHExx0PcH/GqHKGlYsfiCJef5tzCEWcXsA==
X-Gm-Gg: AfdE7ck1etxdf5OlKuwrCrd8DGC5NowRb5F5tLL2uzP91PeMeQtPG4JYFATIAwUc3Tr
	iZK0VNzr/U3BjyALt9zGbBhGNxylFfCFxAEohwfoulwPSUaDngZw7vKFxGZ96HV4l4cr6tFGe/+
	O+Oe3OQo0EFqFvGEfA+SbTvDVUZuXluDNZqTKeuMKknphl5bJmBvPJ7Hopbjb265p88W8205U1h
	FkCG059yUzwPWsOIjiOWGgmGO/J/IPyZ5kntbxII3BzPIAFdwwyHZkDN72z1ummMgB84XJaVkAQ
	OwTmLLRuCbrWLMH3148E2Am6BclcaxVgg3Lt307k2qcVaD9z4yj15l0kOo/qG61EqRgcvC3XLNJ
	63oh/igO7PljjBMYd3E4cHVI+vnkLTf6gnmtCqdLhiwwrICqdKw+x3rFop1uR4n0CWFA+uKqimy
	3zvxRAGOzT/13AbKLz12Wn
X-Received: by 2002:a05:600c:3f16:b0:493:be36:94b3 with SMTP id 5b1f17b1804b1-493d11d9d5emr91066905e9.13.1783289824476;
        Sun, 05 Jul 2026 15:17:04 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e3e2702sm19571663f8f.9.2026.07.05.15.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 15:17:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------tB6k3NTQVgZD3P9v4Wm1I68z"
Message-ID: <8cd341fe-9aee-4600-91a8-3947e948db4c@gmail.com>
Date: Mon, 6 Jul 2026 00:17:02 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] tidbits: net-ping: add ping tidbit using raw socket
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20260628153956.1435330-1-hannes.diethelm@gmail.com>
 <87se5xmqf6.fsf@xenomai.org> <c67924a5-603f-4c8e-b958-f055dd9b1bfc@gmail.com>
 <87v7atqt3s.fsf@xenomai.org>
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <87v7atqt3s.fsf@xenomai.org>

This is a multi-part message in MIME format.
--------------tB6k3NTQVgZD3P9v4Wm1I68z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 05.07.26 um 18:49 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Am 05.07.26 um 17:01 schrieb Philippe Gerum:
>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>
>>>> This patch is the result from experimenting with evl networking. I use it to do basic
>>>> connection tests from the out of band network and check the timing.
>>>>
>>>> It is a bit complex due to evl doesn't support IPPROTO_ICMP sockets.
>>>>
>>>> Using the in-band network stack, you can use: sockfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
>>>> and then only send the icmp part of the message. However, such a support is not really needed,
>>>> it works fine without.
>>>>
>>> This said, we have an ICMP protocol module in the evl stack since
>>> recently, which only responds to ICMP_ECHO requests ATM, directly from
>>> kernel space. Extending IPPROTO_ICMP by implementing the oob_sendmsg()
>>> handler for it there has become an option.
>>>
>>
>> That would make the ping tool way simpler. I can also wait until this is available and
>> create a new patch. It's mostly done just to figure out that IPPROTO_ICMP is not available.
> 
> Ok, I believe having IPPROTO_ICMP would be the best approach. I'll
> let you know when this is available.
> 

Meanwhile, I changed to ms and corrected the "%zu". Attached 4 variants:
oob-net-ping.c - The variant from the patch, improved
oob-net-ping-nonraw.c - OOB with IPPROTO_ICMP (Not tested due to obvious reasons)
ping-raw.c - POSIX raw
ping-nonraw.c - POSIX with IPPROTO_ICMP

This might help you debug the IPPROTO_ICMP implementation.

While sometimes having issues with EVL, I created also POSIX variants
so see if it is my issue.

I can create also a patch if you prefer for one of the two OOB variants.

There where issues with -O3 in ip_checksum(). With -O0, it works.

The only difference I see between working and faulty is that with 16bit-aligned (raw)
it fails and with 32bit-aligned (nonraw) it works. -O3 debugging doesn't really work, in assembly
its nearly unreadable with -O3 and as soon as I add a printf() in the while loop,
the checksum is good. I have no clue might be UB or a compiler bug. Took me some time to debug.
I have gcc (Debian 14.2.0-19) 14.2.0

Of course, as soon as I create a test program with only ip_checksum() and exactly the
same data, it works also, just combined with the code, it breaks down.

This version creates faulty check-sums:
static uint16_t ip_checksum(void *buf, int len)
{
	uint16_t *p = buf;	/* buf is assumed to be 16bit-aligned. */
	uint32_t sum = 0;
	int count = len;

	while (count > 1) {
		sum += *p++;
		count -= sizeof(*p);
	}

	if (count > 0)
		sum += *(uint8_t *)p;

	while (sum >> 16)
		sum = (sum & 0xffff) + (sum >> 16);

	return ~sum & 0xffff;
}

While this works:
static uint16_t ip_checksum(void *buf, int len)
{
	void *p = buf;
	uint32_t sum = 0;
	int count = len;

	while (count > 1) {
		sum += (uint16_t)(*(uint8_t *)p) + ((uint16_t)(*(uint8_t *)(p + 1)) << 8);
		p += 2;
		count -= 2;
	}

	if (count > 0)
		sum += *(uint8_t *)p;

	while (sum >> 16)
		sum = (sum & 0xffff) + (sum >> 16);

	return ~sum & 0xffff;
}
--------------tB6k3NTQVgZD3P9v4Wm1I68z
Content-Type: application/x-xz; name="ping-variants.tar.xz"
Content-Disposition: attachment; filename="ping-variants.tar.xz"
Content-Transfer-Encoding: base64

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
AARZWg==

--------------tB6k3NTQVgZD3P9v4Wm1I68z--
