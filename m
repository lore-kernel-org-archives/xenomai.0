Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7111DFC7
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815449; cv=none; b=Dw8AxPkUlLNhn5QnnqGL5IUJqdx542Uv7Ub+pWjXhK7FCvte+rLjzG49+Mi2Ooxg6ugmP6ir7x02mHQwdjEU4VSW5Tu+vo1Cnrd9Fi3OA2U7Denebl5tImas6fc8WEyclepB+5LxZrCrSIrbVzh8E4PY5ib8dOrnB5wYCZJAFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815449; c=relaxed/simple;
	bh=J+gjxInlvQtcpG4WbWYyrnvVtf+BU+tQDp6T1wreQkI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FXwbSirZets54ZOmaJfjAJxbe7xYQjj7G9sSzYGOhYKO2b+n9BE6y/6mHaMBpbUVBqQ65mR4JWJG0lPlM5wT7B22n81ZJ/nPmDILnsHXc7ycyJkgE8rS+jQknO9A9a9sc5TgDU1Zgyzf5E38cYte3BTgMYJDDmLrc7Hc8+HjMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEcw+z2Q; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEcw+z2Q"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-65894e58b8aso4096048a12.0
        for <xenomai@lists.linux.dev>; Mon, 27 May 2024 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716815447; x=1717420247; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8bihhVhDfU91j4pWIUN2XCeVmSAk7JuMacgRCOIP6i0=;
        b=NEcw+z2QT3KnDM9WQV9swUO2mAYRuDZUBbsxNAWuvizNGoboWfRcErfvMcY7QKZEDv
         lpYxqcihN+4xrAF8V6MO54i25PgsBCDEYsVOyytbU/p/EJyXpu21LIONEqd7Vz6FpLbg
         vh8iRC+CvwDxOsu1Rk1xDwLqmmFb4oiamQBFUVGh+2kbbc8M1MlqucWbXZKgXEyV3lEI
         1AUQhdjPqkgTT8SG2fuvrSzdMKGnEY9kGJMtqy6ROJP492m13rDltQ7gjdtTHL6Hx4U/
         EJDL00T35ogo7kHJelAq1hN6LIffIhglNydMuqq4eexaTkCFKBbtf0S0rza3PfVlecGg
         gJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815447; x=1717420247;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bihhVhDfU91j4pWIUN2XCeVmSAk7JuMacgRCOIP6i0=;
        b=e3+zwDvwsdYgE3nFkwGMqqnFKT3XAMIes9sdVi0AMjKpyR3R+e8evn1LR09+gC/pEn
         uwsaL4aJua/8QMzqLprzUvY0qmnZSQv7zFdRbRqXziYpKLfocuZa+ImDyzcsrVzB6RLw
         L2hqy3QUoetPq1ipW/oD+jl4mpoveYgPVYd/M4YgEOZuUf2IqtTZuryJ2d8eENuc72Mm
         0HUMMkbLZux3qJ38jAyB1GQ33w2pZypb//sWscATbxrvh5ZRC4Zjb7damWFMby7IeNX4
         0wpnQuSCTwNZR3TC5mMrcZ9uvHXb4D9jK3z6xA5Mi0VPIvZvZiaLXSOhpEhYWCLkfN+H
         EAEw==
X-Gm-Message-State: AOJu0Yx1Xrdn9yBJi/B8oIO84Ff3jK5wXhKeQhIf9uaOpKo1xrNRtJAO
	gvCHu0VEvkpZ/BCOqeo5bWHSKbivkmbWrR+5LrbhJgZ/3N7wQKtI134qNWoujw00DpGqhEhjcgF
	Xq+OmRcGRmsqF1Xy++w7p49FbbumYEXjj
X-Google-Smtp-Source: AGHT+IHuqbqg7/ftJUo2aAiwKHclMB4/j+wiLOLcvHYRAX5Zr12ppt6AKxCNTDJsDR9TTzntPASbIa4p6adcjVuusmg=
X-Received: by 2002:a17:90a:bc92:b0:2bd:f1d5:8e3f with SMTP id
 98e67ed59e1d1-2bf5f4073bcmr7434535a91.41.1716815446936; Mon, 27 May 2024
 06:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Mon, 27 May 2024 15:09:18 +0200
Message-ID: <CAH0t8y01h5W8Hsa=xvUJCyQM5VeA8CSTftBvLYrzbzQHenv7zw@mail.gmail.com>
Subject: rt_igc fails to bing an i225-V Ethernet device
To: xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Dear All,

I am experimenting an Intel NUC 12 Pro small PC (NUC12WSHi3). It has
an Intel i225-V Ethernet controller, that works fine under Linux, but
I cannot make it work via Xenomai (Cobalt core).

I downloaded the latest Xenomai-master tree, and the
v6.8-dovetail-rebase kernel tree. The building procedure went well.
Xenomai also working as expected.

This is the i225-V device in the system (the result of lspci -v command):

72:00.0 Ethernet controller: Intel Corporation Ethernet Controller
I225-V (rev 03)
Subsystem: Intel Corporation Ethernet Controller I225-V
Flags: fast devsel, IRQ 16, IOMMU group 16
Memory at 84200000 (32-bit, non-prefetchable) [size=1M]
Memory at 84300000 (32-bit, non-prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
Capabilities: [70] MSI-X: Enable- Count=5 Masked-
Capabilities: [a0] Express Endpoint, MSI 00
Capabilities: [100] Advanced Error Reporting
Capabilities: [140] Device Serial Number 48-21-0b-ff-ff-5f-cf-d2
Capabilities: [1c0] Latency Tolerance Reporting
Capabilities: [1f0] Precision Time Measurement
Capabilities: [1e0] L1 PM Substates
Kernel modules: igc, rt_igc

This is my init script:

#!/bin/bash
ifconfig enp114s0 down
#remove the device first
echo "0000:72:00.0" > /sys/bus/pci/drivers/igc/unbind
rmmod igc
modprobe rtnet
modprobe rtpacket
modprobe rt_igc
echo "0000:72:00.0" > /sys/bus/pci/drivers/rt_igc/bind
sleep 1
/usr/xenomai/sbin/rtifconfig rteth0 up
/usr/xenomai/sbin/rtifconfig -a

This is what I see on the console (line 9 is the echo command for rt_igc) :

./start_rtnet_intel: line 9: echo: write error: No such file or directory
ioctl: No such device


These two lines appear in dmesg:

[   25.325872] igc 0000:72:00.0 enp114s0: PHC removed
[   25.389790] rt_igc: probe of 0000:72:00.0 failed with error -2


It is very interesting, because rt_igc driver handles i225-v devices
in other (not Intel NUC) computers without any issues. The only
difference I see is the INT number they occupy and the PCI slot number
(0x72) is very high in this case. (In other computers "IOMMU group"
does not appear either in the lspci display.)

Please help me. What am I doing wrong?

Thank you,
Tamas
