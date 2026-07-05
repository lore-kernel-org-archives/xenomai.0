Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9B366051
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783295880; cv=none; b=EFA0JS12L33MDKrF/TeWBWHSCtUhrNP4PDI0UPYU0o0p4v+LyepMMIS5xbKH+OUotXZXz1drIWYOShwE/J1+oTKIzMcj8/vBUMcw+VX4RxleO2tF7Xv3OoQXjDqCr6GhjdEeoRgfwc+cnBdsdDqwfc0o02LlyVKbVj3y9J6XH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783295880; c=relaxed/simple;
	bh=7FDmF2KV8e8G5GD8TTwCrI8N/C5OKb5uX1M/x6R87ik=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cLlqJz5/fll3h4mN6kLvVtzYFXKvZZauaHC2PXwF645d8O964/baRfxkAhiOnrjE39TcemcQYTNLRZN17Fta7NhxD6n+WZr07Jaj+viF1GOSrEhqcjETkPivDmXo2WclJdmav9VyqcHnC4TrffRzsjbak+sY3W1o27Sm8N/+I+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hpf+wHjO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpf+wHjO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so17586435e9.1
        for <xenomai@lists.linux.dev>; Sun, 05 Jul 2026 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783295877; x=1783900677; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=stCWYzig2eG/TCE3lFoRTx3Udn9CJFKu1CeLCkSjLlM=;
        b=Hpf+wHjO0VqNV69DIRFqopsuG5x7CSMkTKYSxBN9UIfj/1V9caYuDpZlWIML0fA56L
         YPRUpvZ9WmYuPJbSkqxjRrCR+tKSnRj827P0myWtBr75rYUz2XuH+01pGbu8i/Te0lqa
         AxRulQOdnsiBEZ939nVChANavtg9U9OYQQCScLFd/CMoCRGwpz/v068O3OX3TinAOyNa
         VmUFFW4KihKF2j8uLbmOGNPh+DFZHgNr6Kxgk7ZPXeJAhP/Ehj5CAElXb9gGQ7V/zKOV
         IJT/688Ju/AakgX+LVh03zaMpEx+NXgV+ZZR+/NPxHbd0DIu5ZO6zgbfCK5aCxbQDM8Z
         iuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783295877; x=1783900677;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stCWYzig2eG/TCE3lFoRTx3Udn9CJFKu1CeLCkSjLlM=;
        b=bLh+PJ7+MAldmWtX4qb00GPKuySYDS5pNG+Q14+30b38zMIidkryZCPDsStkg/cWLD
         bCYN2JFjRMcyUSXiO3vFBDHOojLoBvYqBAfQR/ShyKcvKu2tAKMaKuFhRdlgrcF8NInI
         g1E1LTTKSCi9wnk8CuZq6c01SUFyUkMec7zeblp+kfLvCW66/2TqWa57MZartG1GpiOj
         Mh/Oj9pXG9OYLM6TlyH+9DO/xxM75eAZkERiSVTBUOLztvEnta8GH4S4ex0ECa8b10hN
         m0fkvmlLQQsEj27f6tLt4mo40W4sb20klvSO1cD31UlLjId3Nj9CJHJuoIDL5crqW57c
         pO8g==
X-Gm-Message-State: AOJu0YwSWY6tiklWVwiApOzTEdk8iXgCgNp2ufBvcL4D9rhm6h2j3rNR
	gjoRJ9BQpfPFBc7r3FDWlOTevav3u6qZXJETAsdFoUXqXQGxnMGYLPg/
X-Gm-Gg: AfdE7cl298dX+5blACN9RwkiIqzI9sqQ5iVVgWAwld3ZKEh55TpawLPktDxFU6soQ0t
	29BP00NuLdLQ3mys298p5W1r0IalGY7p9FfpQD1ihIbuP4uXkZx0u7VyZdawvGZB1QC9vLRKrql
	1zBYCpFCrNFOdsk8sxgaysV6oaBHJrEivz6s1Q5qOtB/D1KDnQ+G5FoaMCnIOoMhNGarhKh0wzQ
	B+m3n0aZNemXrSY6VCHeOdrBkh00061s1GOhiwQ+XT7RH4DBbbxU/2SRvp2U6yyPfvl16i+sZR1
	cD0bc38gA4wU/sCcs7nL+m/oel6X9iYRE93JElNNRTDBmu0P82SjhCof72ksJGzS/c0ID5JHw/J
	Ym/lKU+/Y8UPib8qAvnZtDcefyuDiFNWlRMx2T8yP8yLTUldtWpY4cv82vpOsyZRXXN/IIrlz7L
	W/xyU279NWDBHZ9z8JdfkV
X-Received: by 2002:a05:600c:154d:b0:493:bcba:46a4 with SMTP id 5b1f17b1804b1-493d11f32f9mr100540645e9.20.1783295877113;
        Sun, 05 Jul 2026 16:57:57 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm554057435e9.0.2026.07.05.16.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 16:57:55 -0700 (PDT)
Message-ID: <0945f3ae-d4be-44aa-b882-ef87c329e709@gmail.com>
Date: Mon, 6 Jul 2026 01:57:53 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] tidbits: net-ping: add ping tidbit using raw socket
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20260628153956.1435330-1-hannes.diethelm@gmail.com>
 <87se5xmqf6.fsf@xenomai.org> <c67924a5-603f-4c8e-b958-f055dd9b1bfc@gmail.com>
 <87v7atqt3s.fsf@xenomai.org> <8cd341fe-9aee-4600-91a8-3947e948db4c@gmail.com>
Content-Language: de-CH
In-Reply-To: <8cd341fe-9aee-4600-91a8-3947e948db4c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.07.26 um 00:17 schrieb Hannes Diethelm:
> Am 05.07.26 um 18:49 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>
>>> Am 05.07.26 um 17:01 schrieb Philippe Gerum:
>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>
>>>>> This patch is the result from experimenting with evl networking. I 
>>>>> use it to do basic
>>>>> connection tests from the out of band network and check the timing.
>>>>>
>>>>> It is a bit complex due to evl doesn't support IPPROTO_ICMP sockets.
>>>>>
>>>>> Using the in-band network stack, you can use: sockfd = 
>>>>> socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
>>>>> and then only send the icmp part of the message. However, such a 
>>>>> support is not really needed,
>>>>> it works fine without.
>>>>>
>>>> This said, we have an ICMP protocol module in the evl stack since
>>>> recently, which only responds to ICMP_ECHO requests ATM, directly from
>>>> kernel space. Extending IPPROTO_ICMP by implementing the oob_sendmsg()
>>>> handler for it there has become an option.
>>>>
>>>
>>> That would make the ping tool way simpler. I can also wait until this 
>>> is available and
>>> create a new patch. It's mostly done just to figure out that 
>>> IPPROTO_ICMP is not available.
>>
>> Ok, I believe having IPPROTO_ICMP would be the best approach. I'll
>> let you know when this is available.
>>
> 
> Meanwhile, I changed to ms and corrected the "%zu". Attached 4 variants:
> oob-net-ping.c - The variant from the patch, improved
> oob-net-ping-nonraw.c - OOB with IPPROTO_ICMP (Not tested due to obvious 
> reasons)
> ping-raw.c - POSIX raw
> ping-nonraw.c - POSIX with IPPROTO_ICMP
> 
> This might help you debug the IPPROTO_ICMP implementation.
> 
> While sometimes having issues with EVL, I created also POSIX variants
> so see if it is my issue.
> 
> I can create also a patch if you prefer for one of the two OOB variants.
> 
> There where issues with -O3 in ip_checksum(). With -O0, it works.
> 
> The only difference I see between working and faulty is that with 16bit- 
> aligned (raw)
> it fails and with 32bit-aligned (nonraw) it works. -O3 debugging doesn't 
> really work, in assembly
> its nearly unreadable with -O3 and as soon as I add a printf() in the 
> while loop,
> the checksum is good. I have no clue might be UB or a compiler bug. Took 
> me some time to debug.
> I have gcc (Debian 14.2.0-19) 14.2.0
> 
> Of course, as soon as I create a test program with only ip_checksum() 
> and exactly the
> same data, it works also, just combined with the code, it breaks down.
> 
> This version creates faulty check-sums:
> static uint16_t ip_checksum(void *buf, int len)
> {
>      uint16_t *p = buf;    /* buf is assumed to be 16bit-aligned. */
>      uint32_t sum = 0;
>      int count = len;
> 
>      while (count > 1) {
>          sum += *p++;
>          count -= sizeof(*p);
>      }
> 
>      if (count > 0)
>          sum += *(uint8_t *)p;
> 
>      while (sum >> 16)
>          sum = (sum & 0xffff) + (sum >> 16);
> 
>      return ~sum & 0xffff;
> }
> 
> While this works:
> static uint16_t ip_checksum(void *buf, int len)
> {
>      void *p = buf;
>      uint32_t sum = 0;
>      int count = len;
> 
>      while (count > 1) {
>          sum += (uint16_t)(*(uint8_t *)p) + ((uint16_t)(*(uint8_t *)(p + 
> 1)) << 8);
>          p += 2;
>          count -= 2;
>      }
> 
>      if (count > 0)
>          sum += *(uint8_t *)p;
> 
>      while (sum >> 16)
>          sum = (sum & 0xffff) + (sum >> 16);
> 
>      return ~sum & 0xffff;
> }

Disregard the issue with ip_checksum(). -fsanitize=undefined gave the clue. It was indeed UB, just not where I expected it. Fixing it right now:

ping-raw.c:206:16: runtime error: member access within misaligned address 0x7f4bbbd00a3e for type 'struct ip', which requires 4 byte alignment
0x7f4bbbd00a3e: note: pointer points here
  6f 6a 08 00 45 00  00 54 c3 84 40 00 40 01  00 00 c0 a8 7a f6 c0 a8  7a 01 00 00 00 00 00 00  00 00
              ^
