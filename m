Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB322B8C6
	for <xenomai@lists.linux.dev>; Thu, 12 Dec 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021528; cv=none; b=Nc93y/Ub8X4BT+dt/PNMzqAlK1w4Tw6U0GUq7PTMU9zlOazTO4KP2R8wH1qYGjc2u2QYxhu5IGDN5RgEGa5mFhQaMQs7fpfj6MWvSgMePFJdWFI5My2JVc1cYf1koB2rxXyrLf8Sg1sSlLkmkV9IXx00GQ5J7MuLZl9z/wfHgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021528; c=relaxed/simple;
	bh=yGbeYWlLCt/rP4yAM/4HUq014HT6U4tCVs7CYegksuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jfTh/NQQE6/5z6bZ/B0TGVgeDe7tQ4fq0Z7dMV11AKtdKq7uNc9zLuQ11kc4n1Mh2Jm+QqJkNzAg8SYvZR7bm/P1HA0/9N7zMIIeHGHvi0IOER6JIK3IqcLHTlcfJtg60l8N3XW9X9ayInbjKIcx8y8SjLxmpJxmX2XqoKAzipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DM19Mjcz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM19Mjcz"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-728d1a2f180so668048b3a.1
        for <xenomai@lists.linux.dev>; Thu, 12 Dec 2024 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734021526; x=1734626326; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TsB17zD4hddsJALy3CMvjXUqx0M463/u3nhYNHp7svg=;
        b=DM19Mjczy9pWghatEHJYAmjUFjboKLKMPQD1UsQ8X74OW/+la3rqFdvss2OkSjtnLi
         IPvU2G6xKbj7JPS833fWBKKlvP4RBy5RJ5KUWaImHfKsEy5nr2cQkZQqCJRS9B0/y1v9
         hRBrFQnF7wGKb+fov7fFLu4VwqUhMLzJ5iTSMEnf9/kiLQUly9k+gq+8o4iS+Zc5oMYv
         MvN7CAx/y7Id3Q4zFt6Kf1vRlO8yr16i+WJBIYWQxuM5Vpy6OPFnuUWQf9V9OaiMLQ8g
         6R1qL7qIO8qlmIhEcWw18S1fAzauPku7cZN2ygZfUeD51itzs9OYKK+tMsXJJFThTogj
         tXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734021526; x=1734626326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsB17zD4hddsJALy3CMvjXUqx0M463/u3nhYNHp7svg=;
        b=nd4hyVZKfwTjX9LJkv9YGcIe7kg9IBDQNDFzKvkr12Un5qTbr1DEf8seaoMhfwV/Np
         pLQEsS7DPdWWHKWKqfS3bP4UFotQA6zvSsSbUyqSZqthxxLGeKaDgoh9CYjaVLs565nd
         sUYCcxwXEd6+T79a1FPpHc8A7rM1q2v7WoethBBVoOMpvidMu0wjRTKbdr2VkyErbOtm
         luyymhzKNXIfXVk4TWtsmT7/XxrzyyOvhKm9LixvB7JxC792jPiOhy/qtHbuJtPFx/Ki
         WfQoBo64z9LWMAYK2SlSmWjOiEp3oIkUd34J+hSa86b70ky+q2W7bZdzJV8ILb7X8ki1
         nRqA==
X-Gm-Message-State: AOJu0YzNTTNX1kghqXpQAHc394VtSRtUeIOZyvtCD2xmppyvElzOZvGS
	hEB+dBl7vNIALJIO6oX0gsMCdQv0KlMVnsnhHHlvwQmFyVGGuG+bhhterQOj
X-Gm-Gg: ASbGncuwYkV2khOUZppykEWIQcW3Zd+M5wTfZUWlRRlSgzwbkD4h9rYlftZm4Dp+1bS
	LyBSQa6rTX1BNU0rfiAwphwqX2Y3Vsh5CY0asWjxvFwpLmpTWgbZ3+5wZxMG2c8KbB3rEj4ztkx
	QZjeaZk04O2fSTAS6OPgb+OyKfIpzJXrCMeM225BjIRkxqZYd/c6rIPHxVfQGwtB5HkXUio25j9
	DpLxth1QAKNgLtFFnsW9z77YAOwTju514Z4sz1in4O8IG4qOc87cAFnDId69pMEDUZdfdqOrp69
	2WIRUJc=
X-Google-Smtp-Source: AGHT+IGQegSvfdiWvPbQZBNZVoEpDOrS7XNZI9RQ6DAMfzwxu3VzxolWywXKa4oRXCNVQ//S1YEEBA==
X-Received: by 2002:a05:6a00:4f92:b0:724:db17:f975 with SMTP id d2e1a72fcca58-72907e6c1fcmr1192503b3a.12.1734021525688;
        Thu, 12 Dec 2024 08:38:45 -0800 (PST)
Received: from 43c7c7756ed8.tail12dc50.ts.net ([223.72.120.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e7c98efbsm8294896b3a.186.2024.12.12.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:38:45 -0800 (PST)
From: shannmu <shanmu1901@gmail.com>
To: xenomai@lists.linux.dev
Cc: shannmu <shanmu1901@gmail.com>
Subject: [PATCH 0/1] *** Simplify RISC-V IPI code ***
Date: Thu, 12 Dec 2024 16:38:36 +0000
Message-Id: <20241212163837.326938-1-shanmu1901@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V is different from aarch64. AArch64 has SGI0-15 and use
SGI0-7 to send IPIs, so we introduced a feature that we handle
inband ipis multiplexed over SGI0. But RISC-V only has one register
to inform IPI and the ipi_types are recorded in the PER_CPU variables,
which can store `sizeof(atomic_t)` bits. So we don't need to use
the same way to send IPIs. We can simplify the code by unifying the
IPI handling code and sending code for oob and inband ipis.

shannmu (1):
  riscv: irq_pipeline: simplify the send and handle operation for ipis

 arch/riscv/include/asm/irq_pipeline.h |  18 +++--
 arch/riscv/kernel/sbi-ipi.c           |  10 ++-
 arch/riscv/kernel/smp.c               | 102 ++++++++------------------
 drivers/clocksource/timer-clint.c     |   8 ++
 4 files changed, 59 insertions(+), 79 deletions(-)

-- 
2.34.1

