Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADDE621
	for <xenomai@lists.linux.dev>; Mon, 22 Aug 2022 01:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661132386; x=1692668386;
  h=from:to:subject:date:message-id;
  bh=/+9iL95NmAwu4BpWxkMBRjA02qMocWNPfMW6KQbHJrc=;
  b=n/idamWCrjbMu1JEaCOgimJrSMqsprsWFF5UmudXYxdnFtEQBOKNQJhD
   IeEVsx+DRl38EdCLo6xmN2qFV4JplJ3h113UymUmQdeIQDf4o7zw1ijJO
   5xxNJi/VIlvXD1H8kNSg5YcT95ROqRtYTX2H1zU5l1Lmm9OxNVu23Fdw1
   +mCSJrlrO4bD/R/Zy7cRs72pjJKRsYMH+X8puHP6V9rDGfoGbCUlkOn3i
   EtkbR3KC1Z9m9ivjn3U/f1pTmWvGMrvgaBnZ8hheRs884dVsGNog0wVvp
   IMsJPNHU37SET476fle2IbETmTBgkFcZAkCcyWrNzMft5rECCkRxyYtIn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="290854705"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="290854705"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 18:39:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="936839365"
Received: from intel-z97x-ud5h.sh.intel.com ([10.67.103.201])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 18:39:44 -0700
From: Hongzhan Chen <hongzhan.chen@intel.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 0/1] net/drivers: igc: introduce rt_igc driver
Date: Sun, 21 Aug 2022 21:18:20 -0400
Message-Id: <20220822011821.21283-1-hongzhan.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

ported basic network functions not including TSN.

1. passed three network related smokey test: UDP, raw, dgram, But
   I do not know if these three test is enough to validate the
   driver, please let me know if there is other tests need to
   cover.
2. In addtion, another thing I want to discuss here is TSN functions of
   i225 has the very similiar effect with TDMA not only from clock sync,
   master and slave arch, timing mangement but the difference for TSN is
   that most of fucntions is implemented by hardware. We are considering
   if it is feasible to implement TSN-enabled TDMA-TSN driver to make
   use of i225 hardware feature because TDMA itself is really heavy. 

Hongzhan Chen (1):
  net/drivers: igc: introduce rt_igc driver

 kernel/drivers/net/drivers/Kconfig           |    3 +
 kernel/drivers/net/drivers/Makefile          |    2 +
 kernel/drivers/net/drivers/igc/Makefile      |   19 +
 kernel/drivers/net/drivers/igc/igc.h         |  557 +++
 kernel/drivers/net/drivers/igc/igc_base.c    |  432 ++
 kernel/drivers/net/drivers/igc/igc_base.h    |   90 +
 kernel/drivers/net/drivers/igc/igc_defines.h |  537 +++
 kernel/drivers/net/drivers/igc/igc_dump.c    |  294 ++
 kernel/drivers/net/drivers/igc/igc_hw.h      |  299 ++
 kernel/drivers/net/drivers/igc/igc_i225.c    |  645 +++
 kernel/drivers/net/drivers/igc/igc_i225.h    |   16 +
 kernel/drivers/net/drivers/igc/igc_mac.c     |  881 ++++
 kernel/drivers/net/drivers/igc/igc_mac.h     |   39 +
 kernel/drivers/net/drivers/igc/igc_main.c    | 4276 ++++++++++++++++++
 kernel/drivers/net/drivers/igc/igc_nvm.c     |  215 +
 kernel/drivers/net/drivers/igc/igc_nvm.h     |   14 +
 kernel/drivers/net/drivers/igc/igc_phy.c     |  793 ++++
 kernel/drivers/net/drivers/igc/igc_phy.h     |   21 +
 kernel/drivers/net/drivers/igc/igc_regs.h    |  267 ++
 19 files changed, 9400 insertions(+)
 create mode 100644 kernel/drivers/net/drivers/igc/Makefile
 create mode 100644 kernel/drivers/net/drivers/igc/igc.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_base.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_base.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_defines.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_dump.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_hw.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_i225.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_i225.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_mac.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_mac.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_main.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_nvm.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_nvm.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_phy.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_phy.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_regs.h

-- 
2.17.1

