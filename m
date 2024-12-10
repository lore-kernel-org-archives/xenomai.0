Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2D4964F
	for <xenomai@lists.linux.dev>; Tue, 10 Dec 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733817795; cv=none; b=TJhZhV79mLHTD0HYYnc+BdkGYVSi1rOv1P7JLm0orkz7Es4ZdofBdmZ7fP+5FDmgmID1Y7oUDNihApBKvk+gGpzAxxXC4Sh0/DFSClaDjB2GtvvnYXsSh3q/V4fy133WOih1xtc5b25vIfB9DZ5iimv4OfQy1iyW7vrkLNQv2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733817795; c=relaxed/simple;
	bh=nQXQIHCpBi2byaPDlN/DLoa5TqS0kc4rXBoAGdxU6lU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AE5sCGxQ9cRvEryUB22H/hu8KNAUoHfad1DQbZoM3RdSCu9TcM/i7DQHplR4d1DLefm78yMPDyEtLRhK63V2Xe6vUunwJv6i5svuUL/FHWGEGd5boF6NTqUy3szFIyUGZ35EueqVDNqd3TZDJGXp46lMJnupi/HUaF/qKaOjMz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyJxY+0h; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyJxY+0h"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so4339067a12.0
        for <xenomai@lists.linux.dev>; Tue, 10 Dec 2024 00:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733817791; x=1734422591; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tWOfDv9iZP8s3ET32PFnHbe13gBA9MzvKQfZZbRq3ps=;
        b=HyJxY+0hUUtWXqDZwy9Lm1T2pf4N8gE3uIRweX1OU90e+rZDUPtEb1DtHfBWtCvVc8
         XHLAhzZb2nmP2/X0WqaHvYmHFWijlx4v4wfne5MmWi+aoXZN7IBk1v24BdSlsqbCKbw2
         w3StwwGaMYiUDaUpTN8ud0plkA1bn9Cmxu6lFLN2BAR+yQwiNgmgrLQ6RABr14dQ4cJO
         qF5KEKvq3ydPD9j2ImPkW652gncax8017OGEVN5lKZjostB0gQZaPJ/4+m9myURyPdF0
         1Tn9lvq3Fb23H1O3iKiv4n91emaHKbCPqtO6gY+H8afeU/tnNjVewuuibtdHF/GuBkZS
         CwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733817791; x=1734422591;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWOfDv9iZP8s3ET32PFnHbe13gBA9MzvKQfZZbRq3ps=;
        b=Ac1rPz1ANY5Kyyr0E2Ct10Q/9Tj0T7hac9/vrR3aoUjhWd1F5cE/D8zXpANuSK0g8z
         XcCKlwQg2JpruRaUvW/XfV5/uz22MyHDfMyiqUDexY6JJtKUR5mZxri9lLvOerAewUX7
         ZmrRp8Xih1ly/rQb6x1YIbOkufIT4xKe8h1rP3b9TFx53zwK+AEcQqW1jsI1dynS76uM
         8sU4j+cq8YTcDqcX4mdH+0CNrUoCGPLgBBaTVjyKMMSoi4EbHBB0yIToe6aDM3BKBvX9
         s5+MDJkK8zxvh/XkbhmvQzXl4qxRHq4Z6zyjmpDlj+UVN2/j9ESiCc2739GM+Lld5K3D
         jw+w==
X-Gm-Message-State: AOJu0YzRh8EsiRtye3RErhiFhpzLNmniL7Oz5BunOB89LcFbVHR6AIUY
	mZu/010MoGGL66KLVnpdc9Zr9bXRz0OV/Edmm7kyz5BWt0VCJX/7rXeAJPEflVFOeNJowYxazUo
	y8bOlieUwUh+jfSU//MS5dyDtNxMg3QVj
X-Gm-Gg: ASbGncvtV8CbKU7Js/RcywZxyGDBKZeLfQdfTa2IXp4c2fMRfN4X6hXJXGWEmZy4LGj
	x+7aZch52bmB7PIAAmosiE3jJ6UVQnBA3HoA=
X-Google-Smtp-Source: AGHT+IFddQwOITOoEdTt1ZfIYrBY5ys/hD+Tw5twBO6tn9B1GzI0FbJRlAQEqurkRaPEOGnyWyUTYczzz8BwHxkE10g=
X-Received: by 2002:a05:6402:5206:b0:5d4:1ac2:271b with SMTP id
 4fb4d7f45d1cf-5d41ac227c2mr2860825a12.11.1733817791320; Tue, 10 Dec 2024
 00:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 10 Dec 2024 00:03:00 -0800
Message-ID: <CA+K1mPERb-5hy-Ta9QWqbJVV=V7E1_w0bK2kvivxLNYcQB6KZg@mail.gmail.com>
Subject: Intel speed scaling
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

My Xenomai RT application has good timing latency but my processor
seems to be "speed scaling".
I'm using Cobalt kernel Xeno 3.2.5  kernel 5.4.281 on Intel X86-64 CPU.
Speed scaling is turned off in the BIOS, and as far as I can tell
speed scaling is not enabled in the kernel config, yet when I do:
cat /proc/cpuinfo
I see variable speeds.
Are there specific kernel config options I should be using when
building the kernel?

thanks,
- C Smith
