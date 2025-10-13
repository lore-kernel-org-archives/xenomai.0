Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C512701DC
	for <xenomai@lists.linux.dev>; Mon, 13 Oct 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375475; cv=none; b=hUTFdztVuGbVnsHgTi0CmQvWTWf2RMe6FXfBNgOttPUCBCHVX4NuZkFy2togruuekmp2gTDJKMogdTksEo9+7YqI2AMapKaHOrSPswq62uI3I62OgjV1vIv2V0cdbxuay5ARz/ZjUR7ftu31crOm4VNPLgeRnDIKKLLB3ImmsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375475; c=relaxed/simple;
	bh=eDs8stUyJRdwgxiAODKAytJ0ICkkTz7MrfBXafyQbNk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rP98gH5Z3LIJt7TdpRdR99P1zAC2JnzjKF+TrsBpTY6wdlrnxsZ//3MG4B3npeqeF81lEPtnxYWic08yaOxzR/sOKWeeNpciq3aKWdTzH0W0B7328pj1owUwBbJbR3TX7aLq1I1xv/PLogWFjgusiD65hoOUp2san+XJRxT90TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=V5UNpOE2; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="V5UNpOE2"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202510131701007dd72186350002076d
        for <xenomai@lists.linux.dev>;
        Mon, 13 Oct 2025 19:01:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=kXPKpUDKbNiGSILGqOJq/DbgicjHTeq6tygcLng9KzQ=;
 b=V5UNpOE2n8cPGq6yFPP2w+2nSK+S/3qbWgc2XRgKvV/M82pe1BT6u85HosO0PhAqdQzp7m
 jAii5yYbv9XUR0+QMnn8oWsPggyRESanBfnSpOLZuEMxvfIDOmxdedVIkQ0qHEeBvpfz2ZD6
 wbx8qUaQbdMDMhXNFulQrylhCTfbhDBNd+IKu5mInKsKf/Di4q8g+XjP9jHHC9WT8DYPkW9d
 e2AnpYL1byNnSxDcknGHtnhZgCGolvU7JU5r23u4qYh3T/mubWfnTMHwYfCsMicxnuAuFguq
 VIBwCh7K5Lh7+4aT1QS3wQUvsj7PIhyDh2MnVX/bA8elTm3dIy2bjrOg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 0/6] Fixes related to toolchain / libc update
Date: Mon, 13 Oct 2025 19:00:54 +0200
Message-ID: <cover.1760374860.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Fixes that where found via the trixie update in xenomai-images and some
cleanups. Most affect ARM 32-bit, the last one also 32-bit x86.

While the patches do not change the ABI and would therefore be backport
candiates, I will likely only pick patches 3 and 5 for stable.

Which means that current stable versions of Xenomai should remain
careful before updating their toolchains or libc versions for ARM and
32-bit x86.

Jan

Jan Kiszka (6):
  testsuite/switchtest: Avoid including arch-specific syscall header
  lib/cobalt: arm: Avoid thumb mode in syscall-issuing modules
  arm: fptest: Ensure that fp_regs_set/check functions are truly inline
  kernel/cobalt: Optimize xndebug_trace_relax implementation
  lib/cobalt: arm: Skip SIGSHADOW_ACTION_BACKTRACE over asynchronous
    signals
  lib/cobalt: x86: Fix and simplify 32-bit syscall argument setup

 configure.ac                                  |  1 +
 .../arm/include/asm/xenomai/uapi/fptest.h     |  8 ++-
 kernel/cobalt/debug.c                         | 11 ++-
 kernel/cobalt/debug.h                         |  5 +-
 kernel/cobalt/thread.c                        |  2 +-
 .../arch/arm/include/asm/xenomai/Makefile.am  |  1 +
 .../arch/arm/include/asm/xenomai/debug.h      | 27 +++++++
 .../arch/arm/include/asm/xenomai/syscall.h    | 17 +++--
 .../arm64/include/asm/xenomai/Makefile.am     |  1 +
 .../arch/arm64/include/asm/xenomai/debug.h    | 18 +++++
 .../arch/x86/include/asm/xenomai/Makefile.am  |  1 +
 .../arch/x86/include/asm/xenomai/debug.h      | 18 +++++
 .../arch/x86/include/asm/xenomai/syscall.h    | 71 ++-----------------
 lib/cobalt/sigshadow.c                        | 12 ++--
 testsuite/switchtest/switchtest.c             |  2 +-
 15 files changed, 110 insertions(+), 85 deletions(-)
 create mode 100644 lib/cobalt/arch/arm/include/asm/xenomai/debug.h
 create mode 100644 lib/cobalt/arch/arm64/include/asm/xenomai/debug.h
 create mode 100644 lib/cobalt/arch/x86/include/asm/xenomai/debug.h

-- 
2.51.0

