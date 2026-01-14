Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C134FF5C
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296705; cv=none; b=Iq21pbJgIv07CeaqQi+12Hunhf/3VpCwrr6ciRMglHtiMEGAd1/JdRsOEEk0BiZp1OPkZ6aVhhZpWav3QJo/0AgfwgvMrU9tE5fprcUWwwWZQxdfoGBFHCLZTxuPqjYZPk/OyYRVVLDJKivGAqx1SKzn5nPizdAGQbZ4EWYeyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296705; c=relaxed/simple;
	bh=9gsIySUjsNozYLIWI+GM0KlXfyO29INngfTw9PghwUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8nwW4koG7/D0GBrPn7n/umJVdPQOpCOitxNbt5mqj9HYfXGo36ZC/vQPOa4PEtxPqtyPcsA7FAfa1iInRE6kljl43nz94GTF0Dhu6QxW1HI9kQ9K3d04ARieI7zg2ShMUuFl7NwBN+9Okc19p5sXb+6NqJH9nB56VwzFRKIWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfhOAZBB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfhOAZBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768296704; x=1799832704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9gsIySUjsNozYLIWI+GM0KlXfyO29INngfTw9PghwUI=;
  b=OfhOAZBBtHAKD8wtXIDqSxyQsFWeBoB37VJ0YvAg1YsyZYzrbRifFnLl
   kTbSRgYJLOuIpg3libUXaBTT9nqkpUDpJrYCFTLp7xT8dI1Jdn8BHCR8c
   mwU49zyLrZ/JGGPYwGw0URLwW4diRqtbW549cFOg0aCjGG7tDwBbCcFMN
   gJRTMJB0xOV1VbcuLlKLqOXPvhD1nrCfV9V8JBaBUGZ0xTlYLYFaAJkcQ
   VRaYZURmoVczdshs8698o7MWZDEzWBLcx+EWavSDGCb6oMudKA+zo7Kvy
   jr7OID5x/gXJUNaMmd7Pw+1n40Azg7hwm0fBY0vjj+nB1+CStwM9Fb3Ir
   A==;
X-CSE-ConnectionGUID: Ju6jEmOCSWiNkxRKqgYD9A==
X-CSE-MsgGUID: Pf33avrSSAeI058lXCRrlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69630578"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69630578"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 01:31:43 -0800
X-CSE-ConnectionGUID: 2FwIT9h4RtuRuy4l0MuCZw==
X-CSE-MsgGUID: ptaxBbe4Tq+Nrl8s48yoyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204618494"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 01:31:42 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: xenomai@lists.linux.dev,
	yuan1.wang@intel.com
Cc: junxiao.chang@intel.com
Subject: [PATCH] evl/net: export sock_oob_bind symbol
Date: Wed, 14 Jan 2026 17:27:11 +0800
Message-ID: <20260114092711.3204218-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113094852.2806192-2-junxiao.chang@intel.com>
References: <20260113094852.2806192-2-junxiao.chang@intel.com>
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
index 4c61a1c1f6d0..69593470d62b 100644
--- a/kernel/evl/net/socket.c
+++ b/kernel/evl/net/socket.c
@@ -449,6 +449,7 @@ int sock_oob_bind(struct sock *sk, struct sockaddr *addr, int len)
 
 	return esk->proto->bind(esk, addr, len);
 }
+EXPORT_SYMBOL_GPL(sock_oob_bind);
 
 /*
  * In-band call from the common network stack to shutdown the
-- 
2.43.0

