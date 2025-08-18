Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D33203A6
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520017; cv=none; b=e5y9QHrc3v4sijIkR1lDHjgI3vXMovEUnS/HDUNeEgVR27Ughg7WCfxRsL1UVzJvAELeV3J++W1EvNeMmsFddPJ79EivgXNanafNPCV6LC1k15lu3xuegGgB/efgwXBOI9jUADMopd6jDJkiVGvWGXnyIHM816S3R6Hqyhm9SYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520017; c=relaxed/simple;
	bh=nkbojAbzkVUmi8RVqCgwQVg6UKTamT/mA15cafESSCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q3r/OlWb+iO96UKVt7bLhC4x2xfK/eNerBSy/rOd2td4sCNpGtjt02fTBPUku7JjYmrlQ2IuVhdP13ek4qbO3mKuXSXx9XMrmDTCTw4O8YdIu1QsMZn99IQSctbh5Z7qbdiYZXkQkxnKfOWfOLT/GVsC6ZeewXWRm1VMHmpI4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=eURXH/sF; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="eURXH/sF"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202508181226460e94e30222fb5b2315
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4r4iVgcZ9ddlSZf+bBXEdIvCvwOMiucUaxwouR2zpiM=;
 b=eURXH/sF6PBM6BoR/914ymPngR9N80/bzRKFdVYiSOVP7hw+utHVbCZEjq9utIFAJSyzQm
 osXR+KkN5Rm/Oszzt4f5jZNWj20xNl8oa8l86Hq4Lv+XZVVdPBUhHB/S5khUbkOGQ64cq0Mg
 yAJDiUu7/2NX8Tdjea0idIzM+KS/5GfPno+t/8qcD5WZFbS911aR5ahSy6n+WZj50V0Jn0rk
 oO5oT+QbSWnItQRinLCZjhymFri+D/O+/WZCehAT8/OUlePrqgFMmzbjHTaqkQ2grcNj7nH/
 47rMrl7Swh7VgC7CKNhjRMhdIgSVBN0XgmuyJg9G+YRz9xugutmNxT/A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:49 +0200
Subject: [PATCH 07/13] drivers/stack/ipv4: Add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-7-c57f195e3f93@siemens.com>
References: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
In-Reply-To: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is a build warning triggered when MODULE_DESCRIPTION() is
missing. Seen on builds with Dovetail 6.16, but likely older versions
are also already triggering the warning.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/af_inet.c | 1 +
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 1 +
 kernel/drivers/net/stack/ipv4/udp/udp.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/kernel/drivers/net/stack/ipv4/af_inet.c b/kernel/drivers/net/stack/ipv4/af_inet.c
index 8bc87d90b..cebc20a69 100644
--- a/kernel/drivers/net/stack/ipv4/af_inet.c
+++ b/kernel/drivers/net/stack/ipv4/af_inet.c
@@ -36,6 +36,7 @@
 #include <ipv4/route.h>
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Real-time capable AF_INET implementation");
 
 struct route_solicit_params {
 	struct rtnet_device *rtdev;
diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 12896f646..cb574c948 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -187,6 +187,7 @@ struct rt_tcp_dispatched_packet_send_cmd {
  */
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Real-time capable TCP implementation");
 
 static struct {
 	struct rtdm_dev_context dummy;
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 5018ba807..736ba1921 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -86,6 +86,7 @@ static struct hlist_head port_hash[RT_UDP_SOCKETS * 2];
 #define port_hash_mask (RT_UDP_SOCKETS * 2 - 1)
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Real-time capable UDP implementation");
 
 module_param(auto_port_start, uint, 0444);
 module_param(auto_port_mask, uint, 0444);

-- 
2.39.5

