Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC34CB5D
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939306; cv=none; b=E/uh4UzNiSt1LTskmYsLTzNdHVL6eycxDXpvx30k8dNTdkqPFRO1QN7Ga6cW8O1uXHKGbNPkJHdmxXfLJe1obG89JDnOh3d1kIG/vEokhXOxQJQumTvUTObbF6i4fpXNA+uWDTd3EC9N9Gzo37zl2kBTB/aY+g+B/XGRQkONHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939306; c=relaxed/simple;
	bh=wWGMgQnUH1ifWC9uhQ8a9DpGjQpjM/byZQVUpuoM8Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rqcUCRA2nd5a2r9nJLsxOO9Ulls8tSGfqWYkzN3ZdYszJZ6FJxz9dqlflgr0QFesOdb4bqBPY3q/grOr0Kgfc6Zeh/uGgofcougIQy8ED+PsTkFWCZZq2jzkNavO6P+/zEW/bGt3b6IutG4Jj+N9ftE15lq/CqMtLDpNt6i/w90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=dd3sRWpG; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="dd3sRWpG"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202401221601313fc00c00376b2284a7
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jan 2024 17:01:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=PQ4fS0H/Ipb+IMNCkd0jmGtWR+ExLfaw/DdGLuRBbs0=;
 b=dd3sRWpGPac125K+DofCN+Ta7DNHrCdud56fsOSelRZCBL/y7TmHipptLDJitJ/DJhVD9/
 rGe9ih/v0Qei62LyGLDOuwXsGgJMUzLk6WV9u5xb0m8XLEEMAK4/8/xyxzZAmRa4F0+m0E5W
 HOT8tt7a5Or3LUeLKfScM3DY8VY5E=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v1 0/7] Add 32-bit compat support for arm64 to xenomai
Date: Mon, 22 Jan 2024 17:00:58 +0100
Message-Id: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Hi all,

this series adds the 32-bit compat support for arm64 to xenomai 3. 
It allows us to run arm(hf) applications on arm64 kernels.

Best regards,
Clara Kowalsky

Clara Kowalsky (7):
  compat support: cobalt: Move 32-bit compat files to generic
  compat support: cobalt/arm: Refactor registers
  compat support: cobalt/arm64: Add compat support and clean-up
  compat support: cobalt/arm64: Update ABI revision level
  compat support: cobalt/posix/syscall: Use syscall_get_arguments()
  compat support: lib/cobalt: Fix VFP detection for arm on arm64
  compat support: cobalt/arm64: Enable compat support for arm64

 .../arch/arm/include/asm/xenomai/syscall.h    |   4 +-
 .../arch/arm/include/asm/xenomai/syscall32.h  |   8 +-
 kernel/cobalt/arch/arm64/Kconfig              |   2 +-
 .../arch/arm64/include/asm/xenomai/syscall.h  |  10 +-
 .../arm64/include/asm/xenomai/syscall32.h     |  12 ---
 .../arm64/include/asm/xenomai/uapi/features.h |   2 +-
 .../arch/x86/include/asm/xenomai/syscall32.h  | 102 ------------------
 .../asm-generic}/xenomai/syscall32-table.h    |   6 +-
 .../include/asm-generic/xenomai/syscall32.h   |  78 +++++++++++++-
 kernel/cobalt/posix/syscall.c                 |  16 +--
 kernel/cobalt/posix/syscall.h                 |   2 +-
 kernel/cobalt/trace/cobalt-posix.h            |   4 +-
 lib/cobalt/arch/arm/features.c                |   5 +
 .../arch/arm/include/asm/xenomai/syscall.h    |  65 ++++++-----
 14 files changed, 143 insertions(+), 173 deletions(-)
 delete mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h
 delete mode 100644 kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
 rename kernel/cobalt/{arch/x86/include/asm => include/asm-generic}/xenomai/syscall32-table.h (94%)

-- 
2.39.2

