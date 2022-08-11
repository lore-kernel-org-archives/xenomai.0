Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1E2CA7
	for <xenomai@lists.linux.dev>; Thu, 11 Aug 2022 08:03:50 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id BB22720007
	for <xenomai@lists.linux.dev>; Thu, 11 Aug 2022 08:03:48 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 6A4F19400E7
	for <xenomai@xenomai.org>; Thu, 11 Aug 2022 08:03:47 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id 73so16489848pgb.9
        for <xenomai@xenomai.org>; Thu, 11 Aug 2022 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=53UVo+AKObRVn4CVeIxxGKGxL1NFGlLFfdRAioKxRzs=;
        b=bN4J1brHfKsOx9FuBNbWz6cpaYAFsfOR0rtgDdZrDx1/AVApSpmiI0Ss0duKrYskNc
         ogB+cBCfhIynwf+2ZRVEKbIpI3p+j7YAcLrFCOpX3Wz+52W1fqnGbApKglv9NDhgK+gZ
         8p5MCPqdADbuI94/aVwkMxtc4q7qtX6Ox5B1hKiA7IBwueSu8urGWLglPvWuvkvUed9q
         tc6tRajMIyvgljZWDGB9YheC9eSLC44I1dfruk1V4WcGnjCJ9eAIGlmw6HLgjChQnopl
         0kia/QEF2T5FIq0cDMV8TximbdiRoElb87gjwLl/E8P19s7IhuWrQCmA+23sdmb5bh2H
         onAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=53UVo+AKObRVn4CVeIxxGKGxL1NFGlLFfdRAioKxRzs=;
        b=sVOF9XqL7pw2P+Lf570fNGDXR3lwgsD/NnwiXtJrLO6IEumishwxN1lZPgf/2Y8XO+
         TTM9AsuLDolhqXT57nK230jHfNuDOQ5Z5VU7q4+dpFlxli6QXJjC53/CreCGh+imszEA
         qawxyjaog8uh0L5lKG/ZMIZwcsroYpmEobzvTEmuNyCft4JmtIdfOOyr7X+ChEpVIMl5
         jiuqTjd1wA3pVGEKwBlGNBXyv3Jvh4jF8+P2K2LQOGmKNgAAOaPPIb9ZFxcSR+4w7ePr
         8iDy7GKXk6TPoY8HmjFvv8n9xITQnDGKhVQmoatSQHggpe6MkdGY2mLzjISfQGLJEJ9l
         n39A==
X-Gm-Message-State: ACgBeo1BmvJGZO1fmRsPDvifU1jJWw5rJU7kOTOZej97czNTMuBAGHSO
	df+fDjhHngJVnXKLN9iz8oI6yJywgYdVBLkwVxTPCedA5Pg=
X-Google-Smtp-Source: AA6agR5K64K2S+0eFp7N1x6GUBNh0ssiYVQs+hzG5aTcOKK4+rqEumRGVRAZR1aT6BYdCYUe0Ehk5MhqDoSo0sKStjs=
X-Received: by 2002:a62:1c81:0:b0:52f:ccb5:9de1 with SMTP id
 c123-20020a621c81000000b0052fccb59de1mr9012838pfc.45.1660205025627; Thu, 11
 Aug 2022 01:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yucong Chen <slaoub@gmail.com>
Date: Thu, 11 Aug 2022 16:03:34 +0800
Message-ID: <CAGjgvr9G4JpZ+krfnX9xWwbTiT6JbtG_2jUWiFJyqVtvFk=MKg@mail.gmail.com>
Subject: Linux-xenomai hangs at "Starting kernel ..." on Jetson TX1
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass (spool1: domain of gmail.com designates 209.85.215.172 as permitted sender) client-ip=209.85.215.172; envelope-from=slaoub@gmail.com; helo=mail-pg1-f172.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20210112 header.b=bN4J1brH;
	spf=pass (spool.mail.gandi.net: domain of slaoub@gmail.com designates 209.85.215.172 as permitted sender) smtp.mailfrom=slaoub@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com

Hi all,
I'm very sorry to bother you, I'm currently working on xenomai
evaluation, mainly to observe the real-time performance of xenomai on
different hardware platforms. Recently, I encountered some problems
when porting Xenomai to Nvidia Jetson TX1. We tried for a while and
couldn't locate the problem, so please help me analyze the root cause
of the following problems. The specific problem is described as
follows:
       1. Kernel version: 5.15-dovetail,
https://source.denx.de/Xenomai/linux-dovetail
       2. Compile the kernel method:
https://elinux.org/Jetson/TX1_Upstream_Kernel
       3. The kernel of 5.15-dovetail can be successfully started, but
xenomai is not enabled, and the dtb file in the 5.15-dovetail
directory is used to replace the official dtb (Corresponding kernel
version is 4.4) file provided by Nvidia
       4. Recompile the 5.15 kernel, but enable xenomai and use the
dtb file in the 5.15-dovetail directory
       5. The 5.15-xenomai kernel compiled in step 4 cannot be
started, and stays in the "Starting kernel ..." stage
(linux-5.15-xenomai+upstream dtb combination cannot be started)
       6. On the basis of step 5, we used the official dtb file
provided by nvidia. The kernel can be started, but it will be stuck in
other places (linux-5.15-xenomai+nvidia dtb). In any case, the kernel
can be loaded and executed. The reason why the system does not start
normally is the mismatch between the linux kernel and the dtb file.

       Question: Why does 5.15-dovetail get stuck in the "Starting
kernel ..." stage after enabling xenomai and matching the
corresponding dtb file? We analyzed the dts files in the upstream and
the dts files officially provided by Nvidia, and mainly focused on
interrupts, memory, CPU and other related content, but still did not
locate the problem. Here we have another question: what is the
relationship between xenomai and the device tree on the arm64
platform?

thx!
      Yucong Chen
