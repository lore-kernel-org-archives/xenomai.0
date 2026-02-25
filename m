Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452F3D524A
	for <xenomai@lists.linux.dev>; Wed, 25 Feb 2026 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032473; cv=none; b=PS60eVAXI3BzLJOT8EA4BhviwLbPiNkTVlDw+9Dn8LP9TGlKyb07a4Ay6mg7Jre1BHbg+bvnsxnKmi7JmWd0XpOJ1qpMlxDndcdJ3KX30ZSwNJ66Ab66sKR/nR0QTyvBqdsDxbI3KOX2ZQVe5Igh65n3kCoUgQy5MrklvIg9Bgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032473; c=relaxed/simple;
	bh=larp8TBP0Q+SXq6hESPGCNqwQ/d+KMk6pIa+dT754vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0eeP1OgwCk+ndZ/YdPURkWzt5pSBswFtFgLawC92t5uxcFhH7xwqA/xoxSlwDdpSkxVzDvJzHQBtZNK8Qy+thLRO1ag/ZV3dM0xcuOcxoc4EdLRh/eP+xJSJs/E2jhm1nDG5/FPrRCDgPOhO8eZMA9RGufrUiBQknbOa5ZdtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=i4eLfA8r; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="i4eLfA8r"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260225151420f54a06a3c500020744
        for <xenomai@lists.linux.dev>;
        Wed, 25 Feb 2026 16:14:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=PX9EHUEWYnIS9YJ/hVFqU9hrbvtYIL2+bnj0U4keBMw=;
 b=i4eLfA8r4gkoZB7P0F1XcFS27Cmtp8JlinIo/AwdtIqh47ILQwFFjepoI2hWMYN5cfjNmp
 ve5wGBxvGhBlXm2UH4tpNLITYeO09o3myK9T49FoUnrgaQUJCFupxvsbhMg5iTzEyiKOd7lJ
 tUj8G2rDeP/oHWNveceufU/2AemdzUoSHpDrbQOm/GToLDyc9nweZ4lwlERyo7YlijCeMiKm
 CO7hRo86rXuVfPGTfwNVoCCf/f6L64aIAmgknKLR1LJFSzAeYAe56vOKGPBh3DWbgl64CnYz
 Rmwn3dwAHKD0x57E7TjONORbfCz9OztuUvz3Wt0e1oHJr8jMk1SKuZxw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.19] e1000e: Fix merge mistake, reintroduce FLAG2_IN_NETPOLL
Date: Wed, 25 Feb 2026 16:14:13 +0100
Message-ID: <20260225151413.1929834-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Seems I miss-interpreted the change while forward porting as a rename.
But: It's two flags using the same bit().

Reintroducing FLAG2_IN_NETPOLL to make the e1000e driver buildable
again.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 200ab51b07c8e..7e08444efd932 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -501,6 +501,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
 #define FLAG2_CHECK_SYSTIM_OVERFLOW       BIT(14)
 #define FLAG2_ENABLE_S0IX_FLOWS           BIT(15)
 #define FLAG2_DISABLE_K1		   BIT(16)
+#define FLAG2_IN_NETPOLL                  BIT(17)
 
 #define E1000_RX_DESC_PS(R, i)	    \
 	(&(((union e1000_rx_desc_packet_split *)((R).desc))[i]))
-- 
2.53.0

