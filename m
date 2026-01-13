Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AD2765C5
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211609; cv=none; b=MW+NjPHUEJ8gjhpjGubP8gUbmnz2sWSgy+LLXZ+y56gZfAe6QimksdA2BRZK2jAKFfFy7xmutbNTaO7ZejbNnQH6jIaGDlrVawsrcg19EOlgOfGThAyWMEog+pmM0zk43N92j+9ca65CXyCTDgVpQCFallANxOSxWQZ8OALWq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211609; c=relaxed/simple;
	bh=d5ep2DdQblpxEiZuDLc5YvdXpU3xuoVP6vEWVMDbrvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j//zD4uTO8F5jniX3/P9yBopsKhpd33EQBvSmHYUSJrycxwtRgkkDgEJ3gfHvpx0SNxKQVxjoBOv/SEpmbMe1uFszZmzg0D7P9mxjmEXOx/PvJ+DBMLPfpjE6oARvcKHA3rMlG819DwRWxaHaGT9Tj54sNtc++Ft1xYWNBpyd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESOljjfz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESOljjfz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768211608; x=1799747608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d5ep2DdQblpxEiZuDLc5YvdXpU3xuoVP6vEWVMDbrvA=;
  b=ESOljjfzzBKvDbN2mRlSdmN4CZliUCNrCfk9f+QbkMPrSCgQPd8LpMic
   dnYHEpgDM1oWnuVrza1OJJcKuBDNYpLo5Wfj07B+cQ3u8wLZlP18YPtdz
   NKtIx/yS8u9tEV9Q486tajxZcrs/MzbJk+uD0GOv05ycedciNf/rpmESH
   QXM7PmePjkDWIH0/Ai34UFNrpF2nnjfeLgSnV0wir21SN9BEKEL9lcJFH
   rDFqNTgs2bJRvkTPtTidVmgahb8FTd/JQ3AUwv/2HflONc92YdaR/JlkU
   41n++y7/DgZCDSZBfLds80CODjjH9UX1dHF9Hbds/6+EjikdLKd8vFyZi
   w==;
X-CSE-ConnectionGUID: X6adqh4WQ0C2tuI7ssT/FQ==
X-CSE-MsgGUID: eLwrMWIFRwChNlETT6WqbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69218274"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69218274"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 01:53:27 -0800
X-CSE-ConnectionGUID: C0nTkr7sTLCvDmEIwo2avA==
X-CSE-MsgGUID: LvPcykt9SsiLT+nA12UUow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="234742399"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 01:53:26 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: xenomai@lists.linux.dev,
	yuan1.wang@intel.com
Cc: junxiao.chang@intel.com
Subject: [PATCH evl 6.18 2/2] evl/net: export sock_oob_bind symbol
Date: Tue, 13 Jan 2026 17:48:52 +0800
Message-ID: <20260113094852.2806192-2-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113094852.2806192-1-junxiao.chang@intel.com>
References: <20260113094852.2806192-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

API sock_oob_bind symbol should be exported because it might be
used in other kernel modules.

Fixes: 9afaf877fa08 ("evl: add net core (EXPERIMENTAL)")
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
---
 kernel/evl/net/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/evl/net/socket.c b/kernel/evl/net/socket.c
index 4c61a1c1f6d0..b87f3fa9863d 100644
--- a/kernel/evl/net/socket.c
+++ b/kernel/evl/net/socket.c
@@ -449,6 +449,7 @@ int sock_oob_bind(struct sock *sk, struct sockaddr *addr, int len)
 
 	return esk->proto->bind(esk, addr, len);
 }
+EXPORT_SYMBOL(sock_oob_bind);
 
 /*
  * In-band call from the common network stack to shutdown the
-- 
2.43.0

