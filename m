Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79BA38F230
	for <xenomai@lists.linux.dev>; Wed, 14 Jan 2026 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387849; cv=none; b=pKsmVL879hB2MMt3JAsBpg/zhTIHHns18JIRmAmy1z1h3hHsUpOBXLKR6vupTBuAUDbjq+DMYMDrd0E3P+ZLJO/NxRT3zusxE/ZYtNdoygdVzU8F46e4XRreh1qrp58DNhtNujIkfnHu1b38PJoYV3q5Onx2UP+VwplhXhF4m6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387849; c=relaxed/simple;
	bh=ziV6lJfiAuPdLpHV3nrrnyGb6jZV5r73muIKejC/IgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSV1Ar/W3slDiV8ReGtWeJ7OMxAMjU4oL8Ig8C5t0gY5IC0ktlvKeX63OD3FX//u+REaqJKlDLXOF3qOz8GS0Ve9aoNZH893ZqqpC6/IZlPk2rv+E7LFm4Z3zLLDeA3n1PpTUAa7YAAK0Nay2O1OXJFkjCmEzyHttZ4EG5xvEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSbsacrD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSbsacrD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768387775; x=1799923775;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ziV6lJfiAuPdLpHV3nrrnyGb6jZV5r73muIKejC/IgI=;
  b=iSbsacrDC5IaBJKl2SBBcs5SlJIm9cmXA3stHMHoL0BDZFMMwVAsSQaB
   m3T/GkFiom2HSaElv08EEZXQK7qZ2PLm5ahLvnRSSz3AvxPqEC9R0vLot
   0DH10AI8nmeJtS618oU2tazyTe4Pipxbst0QHP5yI6iZvH8GGhB6Ar702
   TdL+Df7ZSLuJI/xcAAeB6exjcabwBqymQ2dSo+0fqh/J1EHRFs+a5qGnZ
   6LniWTiICcPzwDVr2caPvU63VeDwN2OkOMa57ST5rYhEKXOrKUIO2nIeo
   3BcgmUsf/cCsl2SZKxUDrFB4JbuFlBxXgM1lMk6pygb5Popdc0w7kXh4u
   A==;
X-CSE-ConnectionGUID: /al5p6aNQT+RG9YyVKmOCQ==
X-CSE-MsgGUID: 9ErrmfiITxaobS8xerOx4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73538545"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="73538545"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:49:34 -0800
X-CSE-ConnectionGUID: JCJFkAFcSt2LKK5qFVcunQ==
X-CSE-MsgGUID: kqUsXGOLSnaCTjGCBR3PnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209695658"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:49:33 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: xenomai@lists.linux.dev
Cc: yuan1.wang@intel.com,
	junxiao.chang@intel.com
Subject: [PATCH Dovetail 6.18] net: dovetail: export sock_oob_bind symbol
Date: Thu, 15 Jan 2026 18:44:59 +0800
Message-ID: <20260115104459.3444792-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

API sock_oob_bind symbol should be exported because it might be
used in other kernel modules.

Suggested-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
---
 net/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/socket.c b/net/socket.c
index 1ecf67b656c5..ba00e99b042c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -167,6 +167,7 @@ int __weak sock_oob_bind(struct sock *sk, struct sockaddr *addr, int len)
 {
 	return 0;
 }
+EXPORT_SYMBOL_GPL(sock_oob_bind);
 
 int __weak sock_oob_shutdown(struct sock *sk, int how)
 {
-- 
2.43.0

