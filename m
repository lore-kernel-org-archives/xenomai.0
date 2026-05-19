Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE1A26C385
	for <xenomai@lists.linux.dev>; Tue, 19 May 2026 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233198; cv=none; b=PUogl4fJclcQ3UAtQGfbmRWk/i8xLFKebQEY5g6bNJ/KVdp4NL9+YANTWi54sNRX/ev5qsUtZ7i11V+p6xQ57bCxvAbvEPQNhD5zgE7pdDz0CfmCGq/sppLJEY1+pdlQNZ96tqlyaFrfKCzJSDdlxR4EZxPh1yJKbFf1zKsNZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233198; c=relaxed/simple;
	bh=Ab7kIlKDdiCUyXoYnyf/xxWRaOI8XA15LBB9HSg6VQE=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=JEqXifGXAx30l9D6aaac0+pGT+lqGNHzGR7AFqKbKZYS0uHSegUPL2jTqT1+KB5lzzQoSrL601lZPD+YC6xP2Weg6ZISU1a1/RvormiZKkguaxenWEYuH5seny/jza3Asvrc/gYnmGf1vqIThiJ/lsRSgcyM/cKHQhpowuVEmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERrB/iBF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERrB/iBF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso44072345e9.3
        for <xenomai@lists.linux.dev>; Tue, 19 May 2026 16:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779233195; x=1779837995; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TUu94u9sX36KsxBn1zHTDAFXOOzyomU4rU7b6unEUE=;
        b=ERrB/iBF/f0Y6GdCJnYktC3iZNRjQosTGzfuja6dy0Xzwm5W7I1WMmc79g6N0Pdp1e
         bJ83o3mI/8OXR4GFEcx5ZCgeXYbOt++yP22+eQe5HQdd3jT3ua93w5CHuy66u13DFjC6
         hWqhfm1ECBpWiJzh1UE6kwRa0NBQTFFcc/GanqHkpmbUyCfyA00Kn7PgYBrehVdI4Xam
         p1zTjgfOhm79T74JuuO7oS0hA7W7V4MfWYpO+X6NEYAWOWz+J4AW1SjN3HxgYAUYIc1V
         pptB+ay5IGOa5fkGjtH/5HPhWdYtbHDk9EoB2IVUpL0RusYmasrhOy4wRY3tYZ8DNA8o
         3BKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779233195; x=1779837995;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TUu94u9sX36KsxBn1zHTDAFXOOzyomU4rU7b6unEUE=;
        b=M0Kne9kl/E20H+Rcnl7DrTa8YqKtrss8HPIJHrBpl270GxkMKJiuspnQC9QZmzlFs7
         ghvgP4uIhgT2bGsJjrDZiUxlYJw74muJO7k+8gMpA5TPXC0MP1RKlcs8bCjnRY1fpYpF
         mZaUgPkGWbp9gScd1uQQIdBGSeeTWPlH1H6PiWix9hZhtIY198bPDxEtYSeQZA0kal7s
         ZhUDIrQ7Vn4LIYVi3fux2ssRXSAP7yhRsSutZtvbfpfiRIWB1KpnTS4OloT3FgOLrsoU
         5Jqe0L0BSuv1q8AyuhorBn971sjiq/kraisq1Q22yeo509TC13oGBzoFRflMZpUzsKzd
         yFIQ==
X-Gm-Message-State: AOJu0Yz3B4RzhUO1ctPzhtsYUZL31LtL1+lZAtfwrVHofVqo7gSS3ygL
	60hZLRF5Uze1Gjn2PFOVjLjoT6j5p7ODLs1jnsdBY2HoPZ4RJcCjFdXdbJfqrg==
X-Gm-Gg: Acq92OEkJi73SBrimr3YTAEZjEKqM+EKyApcVfR5dZXDMRQutOw1kdrMuQTdyDvf46y
	72D3mGO8OG2p9IggHSZy8Py1n6R4zme8M93WcdNTNN4LjBo+Kam7i7rgUazmy7Y78dHZmP0GpF5
	fCjpNOW6DRbj100TyhiWBX6eZrauJlefhaabEB5Y391MRz73tOFABz0qgm6ht8MKqSN1C3pFlum
	E0lqRmO5CyJCBs41w3HeZELNPnh3pbG23SOOzyWgDMXz0TX/8xjKUWOAv+DHBOigN0cZ7S1uUTw
	kYBhoPYhePWGjqHm3ePluecYoZPXhGRzxZkhEISXWHBtGBtsZRyXvPJW92ULexXBhnHdpARRB1G
	eRrfhC4EafLRTEAw3wBo2qYn2K83KEZtHZZEb9HGrEY1KwUkqo988VCX+PEbF7jGeUaVyITEN6H
	bT8m/pGsOpRBKSgu5MPngFklSUcB/XlUHe1WPPb60Y/A==
X-Received: by 2002:a05:600c:a309:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-48fe61f20a7mr273238035e9.15.1779233195022;
        Tue, 19 May 2026 16:26:35 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ff43f213esm173941515e9.1.2026.05.19.16.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 16:26:34 -0700 (PDT)
Message-ID: <c0c13f34-8645-4269-9bb5-70c8b6fb658e@gmail.com>
Date: Wed, 20 May 2026 01:26:33 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai3 network issues
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello

I don't know if I do something wrong or if there is a bug. However, I
can not get any network connectivity from user space over rt_e1000e.

Config:
Debian Trixie
Xenomai3 master d4929cf
linux-dovetail v6.12.y-cip-dovetail-rebase e2fc451

Setup:
modprobe rt_e1000e
modprobe rt_loopback
with/without modprobe rtpacket
modprobe rtudp
modprobe rtipv4
rtifconfig rtlo up 127.0.0.1
rtifconfig rteth0 up 192.168.122.45

I don't need the full RTnet stack, I only need a point to point UDP connection. This
is why I manually load the kernel modules and set up the interface. rtnet start
blocks while trying to reach a TDMA slave but my device doesn't has this functionality.

rtping to any network address works fine, but looking at the rtping code, an ioctl is
used, so the data is sent and received in kernel space.

I had an issue with my code, so I tried the demo:

Without module rtpacket:
./demo/posix/cobalt/eth_p_all
There are no packages from the real time driver only from the other
network cards

./demo/posix/cobalt/eth_p_all rteth0
cannot get interface index: No such device

With module rtpacket:
./demo/posix/cobalt/eth_p_all
socket cannot be created: Invalid argument

./demo/posix/cobalt/eth_p_all rteth0
socket cannot be created: Invalid argument

rtifconfig
rteth0    Medium: Ethernet  Hardware address: 52:54:00:5A:79:C5
           IP address: 192.168.122.45  Broadcast address: 192.168.122.255
           UP BROADCAST RUNNING  MTU: 1500

rtlo      Medium: Local Loopback
           IP address: 127.0.0.1
           UP LOOPBACK RUNNING  MTU: 1500

Regards
Hannes
