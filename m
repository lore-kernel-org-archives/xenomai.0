Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A182576E
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760988; cv=pass; b=i3dzxNtc4lVANsL/WMmbZJjyMWmbMv+LjYYb1/TUZCG8/2YfDdMtpBz/kb3duJw8agPi9TLVIdnkmvKk4/BETy3i3WxhX2G2/req/xTeP7/MBUDZAMYX/+t4dBnhh3olL2Y1L+CPqJXlDZ/vhV3zELGmfmKh6uq0JBZko01Lyek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760988; c=relaxed/simple;
	bh=G4Mstngb4b9PrYr6sBLuKy+WU/VT0oG24x6V0Iba3ak=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QGhze2eZnlUpClAFxx5ibO3HSFlUFGDTwCnJ23wK4qGRnQ3I/YDDcuf88gI74GGNg7qA6Ba4qAWNG0EUOMeIFVVEZTSZU45mxluLbnTc8YBz89yY4MonlO6oxKSPMFPqOO4juJkfM1Kbfkcv6BTuCbDkb7z2EO+nXnS777yq1oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com; spf=pass smtp.mailfrom=lmitechnologies.com; dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b=ic3KNkwM; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lmitechnologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b="ic3KNkwM"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a682579c72so3872120a12.1
        for <xenomai@lists.linux.dev>; Sun, 06 Sep 2026 23:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788760985; cv=none;
        d=google.com; s=arc-20260327;
        b=eDTmz8iHGeJ4HlrssEa3Q49bngLKRf/iQoPCT15z7kO7A1tAgJCzfhmfsjLy7micLi
         A7w2PbYamy6+MObbwY5vgUOLE7/6nvMzZs3auKGfY1sCDNYt9H/7B6HxZSzwt7pRJNsb
         WDx3ITiBBWdMlKq9PDfytOmmP+ZH+D2yrR0OWpRpyTlRIUdrYUUFvKvLbmVumJon0Pv2
         1MOHtpI1pNbhX9nZMTdTq7eI+TY9rGnR5LwTN1ITu/VMu11tI9QF6E9tGKefR8hIErCa
         Um9qT/RsZK/h6nPt6Oqh1qRI5RFlmAyDhGNDS62+Oul0O9MeeiXoS4CyBFOiwi1wqe1Y
         wpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vw5srFVdCEP7MJHDl7UiquJMXm7XSVx4QfUnyURlVFM=;
        fh=YB3B87WifQ96wNOuamgxI2TmGE/J/7vmGnp4rylPnkg=;
        b=jCgvCU+UjTcYDThcL4zx6nYLsD4ggCzJNzRXVgY8FozY2WWkNFtG6qEfseuvweo/eg
         Fhm3wrbKC3L/DYitRJpiCrF7zNyWjxEbF6yswBuQV7rUAcJ6qODziKu3/A1WoOAqCnG7
         yUHwocVjhbh7HbLMFBbr3r7x6U3qCYpG4Qjogr/1O5ZLhPUpbIRf2RDiHQ54yP/vi0Sv
         yHjmUe9exUdk18jBJMvswsZb5hoxFxhILObz+HhtOVjARxwZEBYOysYW1bfnfJRwuEeo
         xV6A75OEMUTuK/6apwhxbWREqpLciX3EB4GJ0d0oNv1uNKg30OJ3WUJe0/xXhiErmVY9
         DECw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lmi3d.com; s=google; t=1788760985; x=1789365785; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vw5srFVdCEP7MJHDl7UiquJMXm7XSVx4QfUnyURlVFM=;
        b=ic3KNkwMzVvsiJAZoVsDKpQW0tNUNpVr0GhfgEzgTyfFsAVz6jo7Kg4OSqzsbfNAgo
         9Yg9cFn4sRoWLDN5OoVvsDGAu3NclbdrvUBrTa+BWGLxmC72R/5F+Amsu9LdLmOrAqeZ
         Ra2Z4hfDzi8+jgc3aJHAoaOVRsAdB2dJ4SAIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788760985; x=1789365785;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vw5srFVdCEP7MJHDl7UiquJMXm7XSVx4QfUnyURlVFM=;
        b=W+U5PeYOuCfLHxrVF/aXQI7xs67hgXOYuDGvevpCkACNETT+b6mCqyR2ODOlnmUofv
         PSfm8YtFgPQ3lP/qAqGyjzyg3o8/c4FxiPIxvppLwcPrHDg9a2rxynegtybDVrjk7yHx
         PWsMkDHkY8l43GCusNrbjMG+RBUYRXeTWZglu+5IlTGwUQJ8LJZ92qz7FndNHCM9i8Td
         0RKdYbRVqSHjmZj33bwBzRVIBHdTri7rhP4xXHbokP1lbaK0pWroCD9AKnFY16Vj80wI
         MlCifTlFS0fwxqJ8OVlQ4qcO3ArdW8ox//Yrty6SI+q0yKf0TzExVzMyonNWJQ16EVr2
         EvTw==
X-Gm-Message-State: AFuF++kWd37Hnz8ZeRGpNtydc2OBfvWuRVerq+4a3zZKHc80efOiOeJf
	BmOzm2A5JpZGqag+8qn/Rdth4A9EbwXxZV682oq2Z1JKZarDegvi1yrhRR/VmNO1NXotUkgvRqz
	boZnnyZijYo9nQOwCFBcDTt35ZdDb66IhrCjsEz88O0ZB7NZk8w1Cg5tnIxb1OfasutGjnwwDz5
	nEJAsDXP5i6aUmmdiR4XvqW/CB0evfPObz72DESBi3Fs/qQuCYcLr51YFvlARDRCLPn7Aj6YzV1
	P0GszVYIpQkKHaeO6qjPExWP1BEa13mAam7omMgn6X4XARxKA==
X-Gm-Gg: AYBFou3ffJTpNH3jFss22W3IKvbDJy9EhvXhEZP3KA8o+IFR0o2sQ789gdM4mWkR3Yx
	gr+8oasWdxHPYvG1KauGweUSja7EDEA8M0tbx6pKs7nG0kNnyFWejv9Krl8aYB5liLfQwqL8eq7
	5EzNyef6KOAQQG1WlbdruvjyU8g5vsvbpCVz2ctpzhsnKTpfzRKxUowo7A0V2gfsHwVv7dxWvPA
	R2XjZee5p83jJTjGvPSy66LrfwDGKD4hBnabyOLlZrRtMZc8YuHCHbBhOxgQJJeE3ExzC6VkvcF
	hQjUgl2u+9y43x+HB386GpLhafBlxwyKFJNzcu5hedmLSDCn6ZZSKRcViI3u0L5uzN2dN27uIkQ
	4dccn/qnzvLlZHH1OcpV1UFYr66mOEB/+RrvBXyr3/ebsL5umo3lKqsuHNw+dQ1s=
X-Received: by 2002:a05:6402:27cd:b0:6a4:21c6:1d14 with SMTP id
 4fb4d7f45d1cf-6a7e85e4d77mr11933219a12.0.1788760985014; Sun, 06 Sep 2026
 23:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Mon, 7 Sep 2026 08:08:07 +0200
X-Gm-Features: AcwNN1W-A_Iuii7jZ6W1FkSJ-9resFybkbNLK7SKVHHhmVZCnvcw_FZ9xZmPMSY
Message-ID: <CAKndYJGoGdwKkFV8Kd2O+VkAJuqeqxsmL6OLSxhyca5k5R++ZA@mail.gmail.com>
Subject: Idle measurement problem on arm_arch_timer (ARM64)
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Xenomai team,

Using "v6.18.29-dovetail3-rebase", I recently tested Zynq-7000 and
Zynq UltraScale+, and I found an issue on the latter.

My config on this system is as follows:
CONFIG_IRQ_PIPELINE=y
CONFIG_ARM64=y
CONFIG_ARM_ARCH_TIMER=y
CONFIG_HZ_PERIODIC=y
CONFIG_NO_HZ_IDLE=n

Crucially, when NO_HZ_IDLE is off, the system shows 0.0% idle, even
though the system is doing nothing. The quickest "reproducer" is
"/bin/top", which shows 100% CPU load (usr). I can provide sample code
if needed. Flagging the PPI as a timer IRQ resolves the issue. Four
similar call sites in arch_timer_register() from
drivers/clocksource/arm_arch_timer.c need to undergo the following
edit:

- err = request_percpu_irq(ppi, arch_timer_handler_virt, "arch_timer",
arch_timer_evt);
+ err = __request_percpu_irq(ppi, arch_timer_handler_virt, IRQF_TIMER,
"arch_timer", arch_timer_evt);

I'm not sure this is the best fix, but I wanted to share this with
you. If desired, I'm happy to test alternative approaches too.

Thoughts?
Thanks,
Gerte Hoogewerf -- LMI3d

-- 


This
email and any attachment(s) it may contain is confidential and is 
intended
solely for the use of the individual(s) to whom it is addressed. 
If you are not
the intended recipient of this email, you must not take 
action based on the
contents, nor distribute, nor expose any part of the 
content(s) to entities or
person(s) beyond the original distribution list. 
Please contact the sender and
delete the email if you have received it in 
error. Thank you.
