Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D14199FB9
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628700; cv=none; b=uRH6dHI+fIB2MFhE3pmfJeDvD8BzPYTpPNAtIySLLfJoh0j+asieWXViHJRcdsPg94fkmKA4TRmmlAgX7vc1zf+vX1mNeEtH7XwXEP4Y8QUn8gsPJc9YjF7cRz2TZtWOgU5v3bItISoBGwFVxkeu6ijFwC5ZdFXrBQ36h1daae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628700; c=relaxed/simple;
	bh=1gW/7qta2XWGDsTsAfTz9tNaI+J3KaUOTJxw/nIYcqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y4mCde1sy/0giIbAFPqWgDMvF6iHkIuz50JTIJiHdFXh6+l8FWFDhcl9/k8IYptc8/Ajv8L9J5r47Fimt5a+6Viq2cHWs9W2Kb5mYYMjn9Md6TkUBFJeit0dQsItL2gbXxnzD8HPzpwCO4XT+4OOyKrA/oDctwgTKYLhTN4xGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YykUa+WE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YykUa+WE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c7edf2872so14238495ad.1
        for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 23:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728628696; x=1729233496; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KY8d38AeEmakBI0XsHIQXuUogPh9L1IwtKH/ckDDjYw=;
        b=YykUa+WEYZgBnvdCPH758eDOp1LHAk4oya6wUS7mMXkzgFVlDmUzJlhHDFDk7hiJ+8
         +lKOYxSlDWWDRPDGUaPl+nGYZuu6I4ffA7SWyXUc47/ucR/MPDqbEruStsA/h/Pei0Oc
         TcOyLpu6OUqnAfGIiyESLkB9ecEZEF8qJFqoMumKbICde1nEXrboA3C2QJGn9BY5bZI6
         ADLkM5QjdaFCDYaT/L9RCIYqeatpx3+3y2/slqhoFB2BBOb5ISTY3Sz5NKasww9sbQ2G
         4r1/y+dsDyOz3Jy+klx3nTeoLkm/7fioDQJSPeEL7xEOgwo5wXVJvVSt2MRYVJtSrD2j
         QCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728628696; x=1729233496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KY8d38AeEmakBI0XsHIQXuUogPh9L1IwtKH/ckDDjYw=;
        b=YpjkbJShlBLUJ22YPMjyyzWSO+pHpxOcA2BuH9GcQBGCQmAhFGKUaTY71sdSKEDSga
         jADyOV34rmFQTLbGPhNfXbk1xlV/l4EGnV2XO2UXT6vqUB/CcpsArnIqAefzsZIGnZGR
         /CNxCQ81HURgAtWWtwiJEeQBFb8cf70OsKxkrewcffDyVNteKoN/ZwmkpuABvKB76u6a
         1+6pdfgeIal144qyXFCNd6qMpTwbxVGJrR1uQxqz8/EjSWBh4W55uKFbjW0NqluEEvei
         XBaG7vAXUHvb9lF5/d2Y/8n9erGLMn2SPGSGbXtiHa1twDrv9YQoVnWqERNP/S2Qt6IH
         K/2g==
X-Gm-Message-State: AOJu0YwXl3ByIJErNtzARXBu5v+KQa0isSLazc3Blp+qUzA6dpQw/9nw
	SNaXzzY5E+qf6+47+7IwAdOsfLIdBgGbNeVePcNnhtcmwqEBPnzbtpybnPSxHQY=
X-Google-Smtp-Source: AGHT+IFcA+xUoW2NMunOb8d8M8n0mpTzb2ZyswjSILi50vsR/KabQ7edm/qvsrRFxJ15/aUgVRHSaA==
X-Received: by 2002:a17:903:110e:b0:205:5d71:561e with SMTP id d9443c01a7336-20ca0402291mr28529655ad.26.1728628695214;
        Thu, 10 Oct 2024 23:38:15 -0700 (PDT)
Received: from 43c7c7756ed8.. ([117.129.58.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1b9f3sm18241865ad.76.2024.10.10.23.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:38:14 -0700 (PDT)
From: shannmu <shanmu1901@gmail.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	shannmu <shanmu1901@gmail.com>
Subject: [PATCH 0/3] *** Port dovetail into RISCV ***
Date: Fri, 11 Oct 2024 06:37:27 +0000
Message-Id: <20241011063730.310568-1-shanmu1901@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This ports dovetail into RISCV arch. This patches are on
the top of v6.6-dovetail-rebase, and tested in QEMU with
IRQ pipeline torture tests, just without SMP enabled.

I have seen patches in the community related to porting
Dovetail to RISC-V. I was troubled by a clock interrupt bug,
which was resolved until October 7th. These patches may still
be incomplete, but I am sending them now to express that
if the community is considering adding RISC-V architecture
support for evl-6.6-rebase, I would be more than happy to
contribute to that effort.

shannmu (3):
  RISC-V: enable IRQ-PIPELINE
  clocksource: Add irq pipelined clock events
  riscv/evl: Port evl patch to riscv (just compile pass)

 arch/riscv/Kconfig                        |   5 +
 arch/riscv/include/asm/dovetail.h         |  58 ++++++
 arch/riscv/include/asm/evl/calibration.h  |  12 ++
 arch/riscv/include/asm/evl/fptest.h       |  26 +++
 arch/riscv/include/asm/evl/syscall.h      |  31 ++++
 arch/riscv/include/asm/evl/thread.h       |  11 ++
 arch/riscv/include/asm/irq_pipeline.h     | 173 ++++++++++++++++++
 arch/riscv/include/asm/irqflags.h         |  26 ++-
 arch/riscv/include/asm/mmu_context.h      |  21 ++-
 arch/riscv/include/asm/syscall.h          |   6 +
 arch/riscv/include/asm/thread_info.h      |  22 ++-
 arch/riscv/include/dovetail/irq.h         |  11 ++
 arch/riscv/include/dovetail/mm_info.h     |   7 +
 arch/riscv/include/dovetail/netdevice.h   |   7 +
 arch/riscv/include/dovetail/poll.h        |   7 +
 arch/riscv/include/dovetail/thread_info.h |   7 +
 arch/riscv/include/uapi/asm/evl/fptest.h  |  29 +++
 arch/riscv/kernel/Makefile                |   1 +
 arch/riscv/kernel/irq.c                   |  72 +++++---
 arch/riscv/kernel/irq_pipeline.c          |  46 +++++
 arch/riscv/kernel/smp.c                   | 135 +++++++++++---
 arch/riscv/kernel/smpboot.c               |   2 +-
 arch/riscv/kernel/traps.c                 | 212 +++++++++++++---------
 arch/riscv/mm/fault.c                     |  46 +++--
 drivers/clocksource/timer-clint.c         |   9 +-
 drivers/clocksource/timer-riscv.c         |  46 ++---
 drivers/irqchip/irq-riscv-intc.c          |   1 +
 drivers/irqchip/irq-sifive-plic.c         |   7 +-
 28 files changed, 833 insertions(+), 203 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h
 create mode 100644 arch/riscv/include/asm/evl/calibration.h
 create mode 100644 arch/riscv/include/asm/evl/fptest.h
 create mode 100644 arch/riscv/include/asm/evl/syscall.h
 create mode 100644 arch/riscv/include/asm/evl/thread.h
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/include/dovetail/irq.h
 create mode 100644 arch/riscv/include/dovetail/mm_info.h
 create mode 100644 arch/riscv/include/dovetail/netdevice.h
 create mode 100644 arch/riscv/include/dovetail/poll.h
 create mode 100644 arch/riscv/include/dovetail/thread_info.h
 create mode 100644 arch/riscv/include/uapi/asm/evl/fptest.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c

-- 
2.34.1

