Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67D3769E1
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783252846; cv=none; b=fQ7dqscjYYZvzojqhwxYsH1pmNyjpxsOxh5xb9aeopCFhJE21+91TLpUyqJ5fOSUCif0niaQUJbyQb1cviZUUpgYLx2c1gHTOC441TjfEeYwrnwG1W6HVRVxOL4YpxfHUvix6P0bRbUAUPx3LQTTA+LmxBwuTefpePaj4WobJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783252846; c=relaxed/simple;
	bh=ZM0Eydln+hv+KYG7ukui+2+VftMr+02mLIV7qPGc+ds=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aQvdUSQ0QIuc3cI1unLPva5serqpqV1cdVoigbZCrdevb2V1Y7bg/IU3X2ivBMzZFRhAUK6UomhgHsk1e9iSD1STEZgrKP/a8Cyq/cRjTv7iVKiiEapNU/cJZIsWvRos63jN5kKvIrCjSWHimUZskpMmbhbUU4eYSUG/N/i0Rdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcWdEMLR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcWdEMLR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so10228255e9.2
        for <xenomai@lists.linux.dev>; Sun, 05 Jul 2026 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783252843; x=1783857643; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LM9ADdGFkfdafFx5WENtIwShKpKTPHVmWGnzogPSbLE=;
        b=OcWdEMLR8MW33NM0ECSeDKgz4D6ETkLckxAQFPdW26Id3/7yWmxRIAYO9VADkDIZ/h
         uxCnmX+QlrzujU8IGwl5MtL+hBipE0kj2FFGYNI9XFGIXKsj1KnCNHB5qjn3KXa+tfZV
         LS7FadZPueR90fSfhClgQJIyvu+iENEgvhnNtVyDq3PSYtn+3X8cGKW1tfRUlRPYttyK
         LbQKjSzXXjuxciqFsgLwrJ0dr7HBSLeX/B95V0fmudcBXnglZmzAry7RJnaI183xaTu8
         0AB2bdvp6X/HnL0iuChNFHGpMOgFep96ulgfxDcpYLpc2xytynm/d3RN0X7b4Dcq7a3k
         NMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783252843; x=1783857643;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LM9ADdGFkfdafFx5WENtIwShKpKTPHVmWGnzogPSbLE=;
        b=r7+kO/kK5GE58Cv5jPjEkMrelDxbnmeg2kzwdd0sP2iKDtHTizy9DG6E1OS+cNg4Em
         Msq73qJEO7cWPIj3OqcTbRbaf7oxYWCqJFzNRgQcbSJLbyRgebT2zCPb0OZZr/3n//sm
         DB/OFph2i39HIKVibiBiGPtQFIzoIgJDKOcEwhv1b2moZrwZEtqdxVBvAqR6kUsZ83fC
         MxU4l3kqgQmgC39wt+/tY83gz+ifmqHlDGdxXLbGQNdIIdo1B79G5yXicc92fjcMHAHK
         YmZQdpzZhTfJK6QZxT62bjFvVCnzpliHq455jUgQEokFp50PvpCh6/F6gDw6K1IOC7+g
         X8CQ==
X-Gm-Message-State: AOJu0YwCH5iMi2Rcf7IgDWYWgS7ot2EzW9r2G6UUItfgAzqed3Bv/6+2
	we4iDSrh06f4pdMLTg4DRsbkeL1DjBdpJB435sJgkHDpFNMu1hCv2/PT
X-Gm-Gg: AfdE7ckV8VFn9WdJWcobjwAbjyNze0frO/kocenFMob0nfBYsIA39m99qKA7D5gmNJ3
	xQ+H89T9tublwH/T9eB0OIBtfzGynrkD9JfE46a3qrr1SHhz3BA6J/0nx7/So8rixhxP4BCvMOP
	cOOUzWo+mK+Nd5yGO+xMHAqbUHwX+qVCf/NNhAX9BpewS3T1m79LpoB9RrXoMOJl24oWvVEF8ha
	ZJaPTSGVpqMb+BnEEH3frQ0sj7RjXEJVhUNER4Zo+p9RuB6YSCaS0dqnpHQhr+VR2VmOxwC50bB
	hKRPAK2K+JgxGflNvo0egiDEgrcGaeCdr6xrn+Q6HjpbyaZbsSc7buWqE1juk4Ej2Jwi0haF0F0
	yq7A7ZzIqtB0rwTS2URLxkRuE+X3YuATIBfPaGQHg3P+RBVVts5k2078HOr44YUaYYzULao3h8W
	uxvobPhYbVu5JeEpfa0yhH
X-Received: by 2002:a05:600c:3f0f:b0:492:3c7e:57aa with SMTP id 5b1f17b1804b1-493d118e7bbmr78798995e9.0.1783252842992;
        Sun, 05 Jul 2026 05:00:42 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae4fsm16135112f8f.18.2026.07.05.05.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 05:00:42 -0700 (PDT)
Message-ID: <b5821b4e-cfd9-4255-ac8f-3de55a788d1c@gmail.com>
Date: Sun, 5 Jul 2026 14:00:41 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EVL: Kernel WARNING
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <c88ccba0-23fd-4f4c-a182-0967e79adefb@gmail.com>
Content-Language: de-CH, en-US
In-Reply-To: <c88ccba0-23fd-4f4c-a182-0967e79adefb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.07.26 um 20:05 schrieb Hannes Diethelm:
> Hi
> 
> After updating to the lastest v6.12.y-cip-evl-rebase, I have a kernel 
> WARNING in the igb driver if I use my oob-net-icmp.c (Patch submitted)
> 
> Exact commits good...bad:
> linux-evl efed612...55591d4
> libevl 3e5577d..f7b7df4
> 
> Regards
> Hannes
> ...

Update:

- It fails after ~240...253 packages. After that, no ping response is received any more
- I use "sudo ./oob-net-ping -i enp7s0 -a 192.168.122.1 -w 1000" so it fails faster
- Also without -w 1000, it fails, you just have to wait longer
- With an I350 card, I get the kernel WARNING
- In a VM with an e1000e, I don't get a warning but still after ~250 packages, no response is
   received any more
- After evl net -di / evl net -ei, it works for another ~250 packages until it fails again
- With the good version, I tested ~1M packages, all fine, max 60 us response time on the real PC
