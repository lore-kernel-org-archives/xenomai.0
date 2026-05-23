Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030836F90A
	for <xenomai@lists.linux.dev>; Sat, 23 May 2026 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532948; cv=none; b=l2QpAm8SWozroIwgNrG70ltXFeMstHF7Ck8qYaFt7f0idbCcJtFJ89OIY2+olQRLZDVY2dLq3R4eaX29zpmp4by7hwIc0qruLMES21FSokG+KgtGV/tF+oX/QbQCKnLu2Sd5Ko7SXWs8dein9plrrFtX+OgpS2JnNHCs0aHGHm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532948; c=relaxed/simple;
	bh=9dCyoVMAvg4+4NLc6OMLmGzJjt+oCqBlclajAPQZ/Nk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=SUwHb+UxIIO1Pz+x0FdM6nOtcp7rebRpHZx9Z6kG/wYS9Y+mAzCsrK4rp6xcBV8drnHrta44pJWC0O47Ze2Y9sYXNXsRnHgwDTRE7M0+jmdzFZ80aG77Em4xuo36kxWn/s/Lwr7KTqFtP/byrSysTRJOZrd+DC6yhZtuF+Zto7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1uZWmEK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1uZWmEK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-452169ae568so5317064f8f.3
        for <xenomai@lists.linux.dev>; Sat, 23 May 2026 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779532945; x=1780137745; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dCyoVMAvg4+4NLc6OMLmGzJjt+oCqBlclajAPQZ/Nk=;
        b=O1uZWmEK/Hx6o9296rW/WPset+xt8OOxoOG0yzzXJniUW2lxRKhrHn2gsjq20agy8/
         x8eLQBo6jr4juJWRZbEwe7DbX1E1kD+K6ElyHFDUnoZRLYUlVYMnlzttTKDqddC/UQUY
         6pXs0KfLD92RL74A8PhW+WR/LJKWJAvdpw+wk9s5qoNKUnsPlPHgZqe9vZd6WuKLIME1
         n/6go/i4J9MDaY8EOYP9rqzQEcdDTT15lCutt9Br0M8YFsvlHvEGgKgelqK+7OGxMMGW
         uEmvXSj2GmMY8OnQnDPser4xLVH6feC+Wt1zNUjL6VKFHUwp+alryQMlcQk+/m4L3PNK
         BF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779532945; x=1780137745;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9dCyoVMAvg4+4NLc6OMLmGzJjt+oCqBlclajAPQZ/Nk=;
        b=lz1sgVNkkkCFpZTohszc/fa7mNbomPM5KdZP3bFgWoRImySUAHp7KzCpAqw4zRdwXo
         M64aIQUjrbB0iGfqCPrTeJ0181sIz3VJsmMVGL5hugyPNownp5xtRqdY9e5NPG6QxfSx
         EcTZUDSNL8oHQfipF9rXifj3BdCnwmMzLUdbpeQbROPKNBCemIC5B/ZgXDNHtASb56tT
         rYsflhXMsDVAVawqCAGI6oXjGm+WaIQ/eAawi6Q6+G90w66WJcP3vKieBvQ2WZl2S2aQ
         QOeMmyQpUDKFBtEdJqMr1zgHEULoNq/W0Lgkj9uCh2zz7lEvMLXT8YTMTSIIiVbb6/DD
         JklA==
X-Forwarded-Encrypted: i=1; AFNElJ+uA4HT2QlE5jyV+6TOsEgkJ4/qxuPUQENdqjfcCmnhAODy1Rfe+JDdAxztkfyXY9DM4mfIG8vC@lists.linux.dev
X-Gm-Message-State: AOJu0YxpldExPQ6H+AXxv79Sp+gHr+NONsRzYivxRkwXTdmSapSfwBDv
	cW2oemkuIp93vvrk+CwVRiDD3fVear63yfso4pZELh+2Oref4u823vEQVrpapA==
X-Gm-Gg: Acq92OGlAiicVjsPPFVP8QNQBciwpp9qzin0PhouVIkcYUUF96Ssndu96DKOL9fTJ8D
	GBKGxvrBr4cCL6/GgTZgBsKGluXbOw4KFoaWc57KmteHxOG6537rr9t8yLr/5FQPvG8evpOhUIf
	kM8FMxWjz/dgHYwlXIuGakmz3tEzzQncXPxmRokzrIu/7z1nAXkWvci3rIvqjhUCd3AwTz0Xz+t
	UlsWijkj6XUaeSa5f0VG9ScMeKS7TsNzdHKE92NWqIGtTM6hwPzXf5yDpnKYR0ppG8R9FSR6oET
	ohd7W66Aj77uz37eD3i4VUMN/CNlo36wQM4s7NUVfk0GDd1WM6sD8jKXp7pvH1757mPANuZtax/
	0pcPX6c+HHM4ChcZIskhnJhHfyTj2XiNtO5xyOq1hx+lRkF26G62Vp0Qr4Al/OfzDHgotLp6RFD
	WGHAnk0K9Hx4vwwvPWbic3R4ztXecpUrU=
X-Received: by 2002:a05:6000:1ac7:b0:437:711c:8754 with SMTP id ffacd0b85a97d-45eb3689169mr11124615f8f.7.1779532945431;
        Sat, 23 May 2026 03:42:25 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4741bsm11619475f8f.22.2026.05.23.03.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 03:42:24 -0700 (PDT)
Message-ID: <2de2080d-4d32-40ab-8c6f-652260c04e5e@gmail.com>
Date: Sat, 23 May 2026 12:42:24 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev
Subject: [EVL] Unstable with kernel command line nohz=on nohz_full=2-3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello

Due to I am switching back and forwards between PREEMT_RT and Xenomai4, I just left
the kernel command line with the best PREEMT_RT performance in for Xenomai4. This is:

isolcpus=managed_irq,domain,2-3 irqaffinity=0-1 rcu_nocbs=2-3 rcu_nocb_poll nohz=on nohz_full=2-3 intel_idle.max_cstate=1 cpufreq.off=1 nosoftlockup nowatchdog mce=off

I had strange behavior when running an EVL task on CPU 2 or 3. Without network, it was fine. But as soon as I run my application with network enabled,
it just freeze the threads from time to time. It looks like evl_sleep_until() just never wakes up sometimes. The reason might be the active network but also
somewhere else in the code. Without network, there are also no 10'000 ns sleeps.

The code is:
evl_read_clock(EVL_CLOCK_MONOTONIC, &ts); -> ts: 1682 s 249982420 ns
rtapi_timespec_advance(ts, ts, ns); -> ts: 1682 s 249992420 ns
evl_sleep_until(EVL_CLOCK_MONOTONIC, &ts); -> Never returns

As soon as I remove "nohz=on nohz_full=2-3", everything works fine. Might be evl relies on scheduling-clock ticks?

After that resolved, I changed the command line to:
isolcpus=managed_irq,domain,2-3 irqaffinity=0-1 rcu_nocbs=2-3 rcu_nocb_poll intel_idle.max_cstate=1 cpufreq.off=1 nosoftlockup nowatchdog mce=off evl.oobcpus=3
so the Ethernet and also the main task run all on CPU3.

After setting also the IRQ affinity for the Ethernet card to CPU3, the max latency is now quite good, max jitter 4us for the task entry, 15us at the end.

I just report this anyway just in case it is a bug or others have the same issue.

Regards
Hannes
