Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C50A4689
	for <xenomai@lists.linux.dev>; Fri,  9 Feb 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479474; cv=none; b=qScTJEKUXjeZjFIr/OWNgZ7sDENmdk3CjZkEPphUKT5f+V/4oC/xvL1BraoC2Xfp+fGZsKvCIldzddpSCaUVyTzYiQeuDhOiA10au6I1zcJySBU5T3HTRG9V0KbdSjROT747Xnk2vRe1tl5Dt6sYrJZB3cvhZoebyc/7P3xml4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479474; c=relaxed/simple;
	bh=Ek2Xhgwbe5L0mRqKb0gQ1dU0juspkXwvO3Oz45iQloo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N+SjM/xy5K+J4vE/wT190lN9dALEN5392usvwJZWXaVG4Le0THQmfez9Te/PycKJNJhxr1Ik3WbTAQQlfLTJ7JEWKFkvmLRW2YhAHKy9fVEAXhd1Qu5UmLdE9NpLigchQF32nt7gwH1fViAfEtbdMd/hJB2hN37i3b+5M3cWXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=KEWK/HqQ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="KEWK/HqQ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240209115105afa9a702326893b184
        for <xenomai@lists.linux.dev>;
        Fri, 09 Feb 2024 12:51:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=6ZhK8MztiYF7hPNF+ZA+DBpKEGIkfrwGCPP2ivzYtB4=;
 b=KEWK/HqQQKdC6MGupHMBMpyBvlLCl5PFaZxeziKiI84KGrj1HKQkBL4RQ2VVrlsGyANFpZ
 psuIkPqGktqx1ZnB7mYtWt+ieTwwWmwFTuRtgyBzsWFK2YZruqGgA7V/0hBpa9m2U9RWRL/3
 DHQP7fiLiFzBgFA5PFPRM3hmEZwXw=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 0/7] Add 32-bit compat support for arm64 to xenomai
Date: Fri,  9 Feb 2024 12:50:18 +0100
Message-Id: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
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

this is the second version of the series for adding the 32-bit compat
support for arm64 to xenomai 3. 

Thank you Richard for your comments on v1.
Changements compared to v1:
- P2/7: Removed unused XENO_ARM_SYSCALL
- P4/7: Synchronized ABI revision for armhf and arm64
- P7/7: Added COMPAT_VDSO dependency

Best regards,
Clara Kowalsky


Clara Kowalsky (7):
  compat support: cobalt: Move 32-bit compat files to generic
  compat support: cobalt/arm: Refactor registers for arm alignment
  compat support: cobalt/arm64: Add compat support and clean-up
  compat support: cobalt: Bump ABI revision
  compat support: cobalt/posix/syscall: Use syscall_get_arguments()
  compat support: lib/cobalt: Fix VFP detection for arm on arm64
  compat support: cobalt/arm64: Enable compat support for arm64

 .../arch/arm/include/asm/xenomai/syscall.h    |  14 ++-
 .../arch/arm/include/asm/xenomai/syscall32.h  |   8 +-
 .../include/asm/xenomai/uapi/abirevision.h    |   1 +
 .../arm/include/asm/xenomai/uapi/features.h   |   3 +-
 .../arm/include/asm/xenomai/uapi/syscall.h    |   2 -
 kernel/cobalt/arch/arm64/Kconfig              |   3 +-
 .../arch/arm64/include/asm/xenomai/syscall.h  |  10 +-
 .../arm64/include/asm/xenomai/syscall32.h     |  12 ---
 .../include/asm/xenomai/uapi/abirevision.h    |  16 +++
 .../arm64/include/asm/xenomai/uapi/features.h |   3 +-
 .../arch/x86/include/asm/xenomai/syscall32.h  | 102 ------------------
 .../asm-generic}/xenomai/syscall32-table.h    |   6 +-
 .../include/asm-generic/xenomai/syscall32.h   |  78 +++++++++++++-
 kernel/cobalt/posix/syscall.c                 |  16 +--
 kernel/cobalt/posix/syscall.h                 |   2 +-
 kernel/cobalt/trace/cobalt-posix.h            |   4 +-
 lib/cobalt/arch/arm/features.c                |   5 +
 .../arch/arm/include/asm/xenomai/syscall.h    |  65 ++++++-----
 18 files changed, 166 insertions(+), 184 deletions(-)
 create mode 120000 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/abirevision.h
 delete mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h
 create mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/abirevision.h
 delete mode 100644 kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
 rename kernel/cobalt/{arch/x86/include/asm => include/asm-generic}/xenomai/syscall32-table.h (94%)

-- 
2.39.2

