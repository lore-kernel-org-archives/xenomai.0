Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8C1A0706
	for <xenomai@lists.linux.dev>; Wed, 18 Dec 2024 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524859; cv=none; b=rOjhbNGgCU70/zxN7ClWXYZ/vfGHhur0by6q5mmr0Gi+hC4ruUkjHTUMY1RMSdrBcpZ0SSmYtcWk/fPME/yM2P9rQEGWeGRFHcKeTTK4pSQeZSAs9lgggVQFkB5BeffWu/CTnM4k5vlr7uIBK0Bf+QrgkQ5JrF2S0coyYXKWT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524859; c=relaxed/simple;
	bh=5YRDXxiHHLa1ac/dnBDvenT24COF2VRgJm7XmiyouBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jVkoNqs8iQmxpMRadnRyb5VV0IBlln4WqI6w4mvKJ5ewMdFNCBGwIffGWjtSKuCm6iuP9TgaglmOfNvpwuAzCI/lhlVgMfuO5YD8kK0CfeaRdCiIDlzPi4wSWSn8oQc+AMCOd0bujfsrcTThPSIz1CnJacSgg4orX5G/JeyvxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+nR2spj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+nR2spj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21680814d42so53247435ad.2
        for <xenomai@lists.linux.dev>; Wed, 18 Dec 2024 04:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734524857; x=1735129657; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIaKA+wVMNsPOyWWb6nt5hAidcg4l+J/7uYIrUyhxpY=;
        b=h+nR2spjbwKarIPu4vkPSf7DLvsr36SlbyniWkTzoUIdOyQzmDUD+24vyPnjHZmnkd
         IzgZ0oIUJAawjyLPWagfvga7ygB0bgfsNZJq4SgWMtUyzGKvg2Y9Y0OJf5YvZnN+XUYJ
         u1OFyhUZYPL43qLZTjZ1QHY6Hyj3+rHbfcb2nnSJkBcGSrX7KNyyJbluyjd3Ax+2q8Ej
         +OAM81DsD8coOyJmiUne5KfYTExTohM2qa7RiKAvlL0qmWVpuEJQfMfwFnxLDY+4BzEX
         pKTGoJDBiRkkn1dL/NSgFrtOGveG0Y7dbyP9CNozKrp9ZaG00WCarPR6Ua5Hi+ipOiXg
         HKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524857; x=1735129657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIaKA+wVMNsPOyWWb6nt5hAidcg4l+J/7uYIrUyhxpY=;
        b=eAxZMS5ebOoI5be1Ali59lDxjxzOtfmWJLF67xcKqGeLD0xs/jQqtDrpgxcexp1VGt
         2yrcCFLIvUmno1KNy677BTUiX8ZWFSzjNHHiDGBEO2PEGCUc4/LGhkvjsqEYThuTB1JB
         FTWPeivui8aovtuFlL9o+09DmfZrDf0osJMywIeVfm4aiN2uQflh/4VHcGnHxPtB2SA/
         ghzjIcG/1wiM3iyOoTBEa9oFmDD5Bjs+rMHzctgWAfygxyxoHRmCYPlJHevIHKpoLkKI
         rAOcG649H3GVwMSQSRX1/mrBN2U5t1q0v4rtI3KlWM5Mj9MEiMhtMglHLZB0j51Xeusf
         Xe9w==
X-Gm-Message-State: AOJu0Yw5DE3mopcdT2pJFBAdWSnYMot8iw3XsoYLdXHLs7PPwbozAkhz
	H/aAiMpGAYhyz87DdLpDUtyJo1oWK7BLU/HlBfAs8UrCHLLaZN1I/w78CeRXdjM=
X-Gm-Gg: ASbGncus643UOmZRaRiy4pwIkUj4Ukv1qSCg/6AvQh2LRhd++tRF0wAqu2gc8p3W3WN
	DqPrxC0cctRuKNnyQSFUK3GNpibcFECDNjmSUw7a3QuTwkeGHWcVXwI8QTAhP56p8nvKCufmdmV
	PkkID+oE/YWn/Gz3RyWOB3SwYzhtXd5gb2Aoc/4f2pHnMGHix7TY9XDszlKk40oeStgsf06PWdD
	XV1tXJtiIB8H/4FdjmDzJH8FvUzvtrtiCM31uwOw6Bkb29dlUw=
X-Google-Smtp-Source: AGHT+IH9jrSdTakLhmRmgckOM+6K10PRgFKB7bFWIyrZ1NDDfIfOBxBTW5o37swdGAiXY8LGjoyOoQ==
X-Received: by 2002:a17:902:f546:b0:216:34e5:6e49 with SMTP id d9443c01a7336-218d7273e7amr30583015ad.57.1734524856728;
        Wed, 18 Dec 2024 04:27:36 -0800 (PST)
Received: from localhost ([223.72.121.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e655cesm75026485ad.244.2024.12.18.04.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:27:36 -0800 (PST)
From: Qichen Qiu <ruiqurm@gmail.com>
To: xenomai@lists.linux.dev
Cc: ruiqurm@gmail.com
Subject: [Draft RFC] Bring POSIX signal to evl 
Date: Wed, 18 Dec 2024 12:26:15 +0000
Message-Id: <20241218122615.1974864-1-ruiqurm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all, 

Currently, EVL does not support POSIX signals. To better align with 
Xenomai and Cobalt (see the CXP [1]), we need to add POSIX signal 
support to EVL. As far as I can tell, there may be two potential 
approaches: 

# Approach 1: Adapt the current flags mechanism to POSIX signals 

EVL offers an alternative to signals called flags [1], which allows 
sending a 32-bit word to another thread. The flags mainly offers the
service:
* use `evl_create_flags` or `evl_open_flags` to open a flag element. 
* use `evl_wait_flags` to wait a specific bit and evl_post_flags to 
post one or some bits. 

The mechanism is like a POSIX real-time signal without queueing. 
However, there are notable differences between flags and POSIX signals 
that would need to be addressed:
* Signal Capacity: Cobalt supports 63 signals (excluding pseudo 
signals), while flags are limited to 32 due to the monitor's design. 

* Initialization: POSIX signals are pre-configured and require no 
explicit initialization by the sender or receiver. In contrast, EVL's 
flags require users to initialize and open them manually. 

* Target: In POSIX, signals can target either processes or threads, 
whereas in EVL, the target mechanism is more limited. 

* Sigqueue: POSIX signals can carry additional data (sigqueue), while 
EVL flags are restricted to 4 bytes of payload. 

* Queueing: POSIX real-time signals are queued, whereas EVL flags only 
store the most recent signal, making them more similar to standard 
signals. 

While it is possible to adapt the current flags implementation to 
address these differences, I believe doing so would overcomplicate the 
existing mechanism. For this reason, I prefer an alternative approach: 
migrating the Xenomai POSIX signal subsystem to EVL. 

# Approach 2: Migrate the Xenomai POSIX Signal Subsystem to EVL 

Xenomai implements a signal subsystem. For each Cobalt thread, it 
maintains:
* A wait channel (sigwait) to sleep and wake up while waiting for a 
signal. 
* A sigqueue structure to store pending signals. 
* A sigwait_context to hold the user-space waiting context. 
* A field sigpending to track the current pending signal for the thread.

Philippe once suggested that the new POSIX-like API "would be 
implemented as a separate driver using the EVL kernel API" [3], meaning
the POSIX signal support would be loaded as an EVL driver. However, 
since signal sending and receiving are per-thread or per-process 
operations, the signal module would need to attach data to each EVL 
thread. This integration seems challenging for a standalone driver. 
Instead, I propose integrating the implementation directly into the 
current kernel. 

Before starting work on this, I would like to gather feedback and 
suggestions from the community. Thank you for your input. 

Best regards,
Sam 


[1] https://lore.kernel.org/xenomai/87mtyr1abi.fsf@xenomai.org/
[2] https://evlproject.org/core/user-api/flags
[3] https://riot.im/app/#/room/#evlproject:matrix.org/$kFRgs7y48Qr0033GNh-sDnI7GUrrp_mo-OEhDI0GAWk
