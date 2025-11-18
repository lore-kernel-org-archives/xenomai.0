Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848221E7C19
	for <xenomai@lists.linux.dev>; Tue, 18 Nov 2025 01:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429528; cv=none; b=lheMJVaVonxgtaC7dTXmJ5qxmcMm1wtQc53hFXS9xk4/nEbVhWcUkSQM191tfGg0tb5r98cmAQEsqNZHy+egLdiIsA7TyJCxgSrX2pR2TG0NipXzz2j5p/oZ4XuH+A2M4sJSccvoB47zt1s1kJr6PKiW7+wK6axr40FeBXQniuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429528; c=relaxed/simple;
	bh=0N0rdrALAFhBEMVBM5IJhgrzUNp872e0ilob/nA7lQU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Qj+RK75WWSrWP/BFYWyNPhl/Agl5MJnczPwoAdBoVklriKuEeyDNrAybc06rA22zTZREz4FkfsH0otXwN+DD1aELocoaK4bSYEqPt7U6299iy7QJtt6ajoJfAmX/V+cF1X9cQUC+laedZeNHmggDGH7dF5nd66JGeYOjnpxWZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+AU8phw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+AU8phw"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so7928796a12.0
        for <xenomai@lists.linux.dev>; Mon, 17 Nov 2025 17:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763429522; x=1764034322; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9sqCiCyQ/XcpKxF6Y9pjuzO5zlp5fZ2fX2Pn0xtUZ+o=;
        b=Z+AU8phw3QNYxaA4/BaNVQUnlxTDA4cyc9Un0C7P1AyDVSPFi6JQrn+M+S7c3JOwB3
         qsmDPZCDFL69nswnIlhTBV8fjo+4fjC73x5ZIp9AYNii4BLjL+x/mx0AUCn05HYNFoC4
         LU7sYwc43rJ1yrMmXRX906vf7nTtU8jSYXKRWmJRQLqv6CXX0h+2Z24eCDjQ8PKOKALK
         BxxAjO30VOT6ZP/3IbXmnO4xxwCPl4Vy9El9UorOdfAUv2q4jGnKErkAhd+il4RMrf6z
         h32W4UvXW8cuFWhcewi2YVxq2c1XW0Z92wBUyWw9uz/Su9nE40PBI4c/Pu8u+9TVPft6
         K8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763429523; x=1764034323;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sqCiCyQ/XcpKxF6Y9pjuzO5zlp5fZ2fX2Pn0xtUZ+o=;
        b=r0KBuHgMQCWdfruOlkRSFksHETvZq6t1pE7Vi9T0u181NpBtdjmE64L1pA/Wijswkt
         4woH27wYOzyk6xroAcQln+wh88NwyhOdJhmHwMnh6z3lSQT/QVim0Mmj6ddrfKRp51Im
         wuVTBFbUlGsORixv4ZQdogQxHGhoBJtuj8dtZQF35gct8safF2sZ568VhyPc//iib7JH
         7YSTUpVtmXJP59IQQMle2FgITFSBIWi9+cpvIqvGRqzIibbhzOjx2FzohVSHggbG1NS8
         VUN88e7DeAJ+F7GrdQ+/0lSKsKHH9ld6EaQXtx8/yMASpxTfuNphgk5305mLLYf/VLrr
         NJHg==
X-Gm-Message-State: AOJu0YxWz5u/mKsoguQP8tRuBvUcuMQNGzOmaUjM3r8NeB7qr2rpbVPC
	UNJaKxA55M+2e/4oNcUJvWquSQR1F9lbe3/792c749uK+BebjkuqeEmg7jQKHPNjX8s11Frkkhb
	rq1rCbcm62+2GaMg0/SG1YbU0Xt8w4LBO7esO
X-Gm-Gg: ASbGncsdATYmGdKrBQ5Y+BBziacLuxRosyBZqjQsaU3hxBDB4XUPZHLXztTomi0xB+g
	4GYTQXCqoU66iCyWZWee2enAWAu/rDvSTnpfxwRASEZQ5oSsy1Y1EXO7jpjlCDqtHHpLjvoIS+U
	3yaQdyYSkaljlbxav/sTvTzkZWZ/zUQdGx5q66HR1tnCpon8Cn343+GJoyx0YSXa7ztyT+hAlzO
	YMU0O/P0ZTLxA5hJ3QeTAGVDDAcnfo4nxKluHLPCPe8PMXqQwH1UILneDAPKjQA33FkWKj/YQ==
X-Google-Smtp-Source: AGHT+IHcPYXqulibeXMSR/9srJ46bjkRwiamS2THrGTJ+C4J3Ge9320YxNId80WvfRaDisSyrD4i63IdMTa0odavCtc=
X-Received: by 2002:a05:6402:458b:b0:63c:1066:8bec with SMTP id
 4fb4d7f45d1cf-64350ec7934mr12594211a12.35.1763429522461; Mon, 17 Nov 2025
 17:32:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Mon, 17 Nov 2025 17:31:51 -0800
X-Gm-Features: AWmQ_bmoNzsRdxoyfPbbTCbnsb52KC56dHqC6pqnVSyyi9DvrWrAx6JL-JS0rvI
Message-ID: <CA+K1mPEs3K7ymrnTMa2vmM4NWrdL-n-G41zxEYTJYBxq4F233w@mail.gmail.com>
Subject: multicast fails with rt_igb driver
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

I am having a problem using multicast with rtnet, specifically the
rt_igb driver.

xeno-config info:
Cobalt Core Version:  3.1.2
Kernel Version: 4.19.229 x86_64
I-pipe release: #21 detected

My NIC is an Intel I210AT using rt_igb. The rt_igb driver works well in
general, it can receive Unicast UDP packets sent into the real-time port OK.

When trying to set up a real-time UDP socket capable of receiving Multicast
data, things fail. Here is how I am configuring:

   modprobe rtnet rtipv4
   echo "0000:03:00.0" > /sys/bus/pci/devices/0000\:03\:00.0/driver/unbind
   echo "0000:03:00.0" > /sys/bus/pci/drivers/rt_igb/bind
   modprobe rtudp rtpacket rtcap rtcfg rtmac tdma
   rtifconfig rteth0 up 192.168.0.240 netmask 255.255.255.0 promisc
   ifconfig rteth0 up
   rtifconfig:
   rteth0    Medium: Ethernet  Hardware address: 6C:B3:11:52:A8:5A
          IP address: 192.168.0.240  Broadcast address: 192.168.0.255
    ...

My code:
  struct ifreq ifr;
  struct sockaddr_in addr;
  struct ip_mreq mreq;

   ret = socket(AF_INET, SOCK_DGRAM, 0);
   if (ret == -1)
      return -1;
   else
      udp_multicast_socket = ret;

   strcpy(ifr.ifr_name, "rteth0");
   ret = ioctl(udp_multicast_socket, SIOCGIFINDEX, &ifr);
   if (ret < 0) {
      write_log("IOCTL SIOCGIFINDEX returned: %s", strerror(errno));
      return -1;  //Failure
   }

   memset(&addr, 0, sizeof(addr));
   addr.sin_family = AF_INET;
   addr.sin_port = htons(port);
   addr.sin_addr.s_addr = INADDR_ANY;

   ret = bind(udp_multicast_socket, (struct
sockaddr*)&addr, sizeof(struct sockaddr));
   if(ret < 0) {
    return ERROR;  // Failure
   }

   // Join the multicast group
   mreq.imr_multiaddr.s_addr = inet_addr("239.249.5.5");
   mreq.imr_interface.s_addr = INADDR_ANY;
   ret = setsockopt(udp_multicast_socket, IPPROTO_IP,
IP_ADD_MEMBERSHIP, &mreq, sizeof(struct ip_mreq));
   if (ret == -1 {
      return ERROR;  // Failure
   }
```

Its the setsockopt() above which returns -1, with errno equal to ENODEV.

Am I doing something wrong in this code? I do see multicast mentioned
in the rt_igb sources - is it known to work?

thanks,
C Smith
