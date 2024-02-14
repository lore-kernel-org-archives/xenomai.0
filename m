Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6F60245
	for <xenomai@lists.linux.dev>; Wed, 14 Feb 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927677; cv=none; b=VV3HcKTFgSNeC2lFAt69skz7TkJAJHvlCCZkqmZz8sn299ueDqiOcqh2p7Ue5j9stpIF35oOyg9aQJRqOwEruZohEtJL7IYXQmv2u0CUUXCF/cOoGW6M65NRbK62J18B6dS6YC5Ak17VUyJ1dT+REgsfN66CFwVgh2HG062Pe4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927677; c=relaxed/simple;
	bh=bJVUWfA3kY/e1KkUaMun8SNL47i8TFgNICCnIOQTYZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSjUrd/LIH1km7G9vSk2vYr8PqU48jhVIXL/hRSUdb+Fj7uOVNg43DT86draE6mjHJS+aEGm1iIf1aDCBPMd3MtHkasCp0oLrh21J5Ju9RyGmxyuPxxwdesVSQz2uJ3OQ8Gu/wGNLswjXPDnICZJe8l5sRnaXnMT5SR2DfYcDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=FjqtNMxR; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="FjqtNMxR"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240214162101e6898378752c71667b
        for <xenomai@lists.linux.dev>;
        Wed, 14 Feb 2024 17:21:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=XxltEXi3x+8/7uT1p/3cmgqFgNILZ0VmjQlS73geYLw=;
 b=FjqtNMxRQpTIgwxqb0MELgs4hI6salDyUCQAqJNX/Bf+gOePbLcYmn7wFvHiy8Cp6Ansky
 k9jN+qJbfVU9OdSjnbB/3NoPX4s2I/H5E3rTgM/h1Fn5CiW9EF+qyFWww3YnjCmeCrPrHCe9
 ZPOSyo9VXv6TB8hxlqOxnwjhKoak4=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v3 0/6] Add 32-bit compat support for arm64 to xenomai
Date: Wed, 14 Feb 2024 17:20:39 +0100
Message-Id: <20240214162045.2017832-1-clara.kowalsky@siemens.com>
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

this is the third version of the series for adding the 32-bit compat
support for arm64 to xenomai 3. 

Thank you Jan and Florian for your comments.
Changes in v3:
- Squashed patch 2 with old patch 5 "Use syscall_get_arguments()".
- Cleaned up pipeline_get_syscall_args() and added reasoning.

Best regards,
Clara Kowalsky


Clara Kowalsky (6):
  compat support: cobalt: Move 32-bit compat files to generic
  compat support: cobalt/arm: Refactor registers for arm alignment
  compat support: cobalt/arm64: Add compat support and clean-up
  compat support: cobalt: Bump ABI revision
  compat support: lib/cobalt: Fix VFP detection for arm on arm64
  compat support: cobalt/arm64: Enable compat support for arm64

 .../kernel/dovetail/pipeline/pipeline.h       |   9 --
 .../arch/arm/include/asm/xenomai/syscall.h    |  26 ++---
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
 19 files changed, 166 insertions(+), 205 deletions(-)
 create mode 120000 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/abirevision.h
 delete mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h
 create mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/abirevision.h
 delete mode 100644 kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
 rename kernel/cobalt/{arch/x86/include/asm => include/asm-generic}/xenomai/syscall32-table.h (94%)

-- 
2.39.2

