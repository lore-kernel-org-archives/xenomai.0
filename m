Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB218BB89
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103713; cv=none; b=TFwP1fibb0pye+ff01xp3/VkmpwthsEJZkp9vnMt9Phl0VWD1uOQh1GFwVJqRFLN0A6Y5GSK0LN+efMW9kN7q16ankY6Ls8wGAUSMf4U2+P/yiLGf92Fd+4ZMYTrkqNww1s/jYWzEJLOxjYCnjJsAdNmegp7ja73Jgrf2GdO6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103713; c=relaxed/simple;
	bh=ZIhagUOvtQL8dswAIG7Z2W2h1EAynMIK4OygJw2LM4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C68R5rUx0NR/DBjWKDNGpIZsW9cJ013ZjV7i7S3n6Bd8HNV6uNo0IBCncwxIUZqwk3UXeFfqQ5sLAvQvtmVXUJ10F6Rzb2rfPekEfCrV7laq5ywpsD8L9yfYpSvAz5DaalNDe6LQbRUqiGlTBdx2yLeT0sHl4m7l332ycvKOWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evgAD3vo; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evgAD3vo"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71e6d988ecfso77780b3a.0
        for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729103711; x=1729708511; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqwxkvTyizqqHRN0UUWSB7LH8r9SFiNxbsGQj4P23HM=;
        b=evgAD3vogMezYrcuHwgSgbPlV9eUj1XwJ7AXWHXOkvDi745vS2DFzREj/Yc88/CAYH
         phR7dqYy58c8cSD2E+E13TawPj647BPQFmFiNxnBEbVu83238iq24Y89huCKD0xS+EIH
         +Nf47oAz4H1CA8W+GyY/2MRPZ9UOWqCQCXnpLYukq29qMkjdRG2Iut5EXa4502UCHlNE
         nYciYP/vHO/wKfuyIlUDE/gP3P9BzTylO/W015FcXaZyh64WlktrqpEr3UgMkT8e+SR+
         5i9grXHcxwQw3Ojg+E2MzmuJtYK1fMHvXoCw1+o/nD6VgBVVwQH0gYNom5SkJOFw+LOR
         Cg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103711; x=1729708511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqwxkvTyizqqHRN0UUWSB7LH8r9SFiNxbsGQj4P23HM=;
        b=KUkdtfSnghrasV8IdJUSvCpuS4nnNRhIfDEL0gajJzNkgH0AOV1PaXatRzieWVADwz
         cAx9V1579WY/fWq6IVbpJbj6jRe7mIqk7hV1hKrAe1LHZU4SqGzJoxuWf+nWX+6FO+cm
         wZwMQW5qEnfaarfIc9So0JQM8G2XQ3LqUZESrVLSFu8Rn8CcKSMaUmy7V/nkvQY9NOXS
         JpxSE5qMbNOBTf5901N5zmnF+zlzK6qZLn//da06GmYsWLc4kUTgGu3vCnJS2szjDXRa
         LnHGdFYkjU536smjNUR/8kXmx6rmYanRzgSxDvbj1kvl9QjcawN/1Kngj8p8dU+aTbZq
         tjNA==
X-Gm-Message-State: AOJu0YyavG+k7UncEiJgpmTmNI9hBgt0JrEsS8HhNHOE+pnxy5y05wlI
	U+5koWJxsB/M+NOhuWFnpN/DG4FD1p5Xxlkni0t5vM/4GoNG9SCJYj2f1cLZkRs5f0Xk
X-Google-Smtp-Source: AGHT+IHrFfEAMfw1TDrVQ7X0zrzxwaVvvs5dKLLsI9LL09P4aKEVZQz4smsQTPLUmmW/pZG/51SpKw==
X-Received: by 2002:a05:6a00:22d6:b0:71e:795f:92f0 with SMTP id d2e1a72fcca58-71e795f93f8mr7862334b3a.3.1729103711270;
        Wed, 16 Oct 2024 11:35:11 -0700 (PDT)
Received: from localhost ([38.207.154.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm3414085b3a.186.2024.10.16.11.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:35:11 -0700 (PDT)
From: Zheng Zhang <lz5333885@gmail.com>
To: xenomai@lists.linux.dev
Cc: Zheng Zhang <lz5333885@gmail.com>
Subject: [PATCH 0/6] *** Port dovetail 6.6.y to Loongarch***
Date: Thu, 17 Oct 2024 02:34:59 +0800
Message-ID: <20241016183505.738682-1-lz5333885@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

This patches is base on 6.6.y-dovetail-rebase aiming to port
dovetail to Loongarch. Most of architecture related code has
already been ported, except ipi part, which I will add in
the later patches. This patch is tested under qemu-9.1.0 with
irq torture test in single core.

If the community is interested in porting Dovetail to 
LoongArch, I am very willing to continue improving the current
work and maintaining it in the future :^)


Zheng Zhang (6):
  dovetail: Add dovetail and irq_pipeline option to Loongarch's Kconfig
  dovetail: Port Architecture bits related code to Loongarch
  dovetail: Adapt Loongarch's clocksource
  dovetail: Add place holders for smp/ipi related functions
  dovetail: Disable irq in mm and fpu's critical area
  dovetail: Add more irq-chip support

 arch/loongarch/Kconfig                    |   3 +
 arch/loongarch/include/asm/dovetail.h     |  44 +++++++
 arch/loongarch/include/asm/irq.h          |   2 +
 arch/loongarch/include/asm/irq_pipeline.h | 145 ++++++++++++++++++++++
 arch/loongarch/include/asm/irqflags.h     |  28 +++--
 arch/loongarch/include/asm/mmu_context.h  |  31 ++++-
 arch/loongarch/include/asm/ptrace.h       |   3 +-
 arch/loongarch/include/asm/syscall.h      |   6 +
 arch/loongarch/include/asm/thread_info.h  |  17 +++
 arch/loongarch/kernel/Makefile            |   2 +
 arch/loongarch/kernel/alternative.c       |   4 +-
 arch/loongarch/kernel/asm-offsets.c       |   1 +
 arch/loongarch/kernel/idle.c              |   2 +
 arch/loongarch/kernel/irq.c               |  23 ++++
 arch/loongarch/kernel/irq_pipeline.c      |  34 +++++
 arch/loongarch/kernel/perf_event.c        |   8 +-
 arch/loongarch/kernel/smp.c               |  28 ++++-
 arch/loongarch/kernel/time.c              |  10 +-
 arch/loongarch/kernel/traps.c             |  52 ++++++--
 arch/loongarch/mm/fault.c                 |   4 +-
 arch/loongarch/mm/tlb.c                   |  17 +--
 drivers/irqchip/irq-loongarch-cpu.c       |   1 +
 drivers/irqchip/irq-loongson-pch-lpc.c    |   2 +-
 23 files changed, 412 insertions(+), 55 deletions(-)
 create mode 100644 arch/loongarch/include/asm/dovetail.h
 create mode 100644 arch/loongarch/include/asm/irq_pipeline.h
 create mode 100644 arch/loongarch/kernel/irq_pipeline.c

-- 
2.47.0

