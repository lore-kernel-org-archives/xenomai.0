Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48F34320C
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072588; cv=none; b=VOjVmB84BVttRimhlw08DugK5vHJLnUdZBlmgFnaVZP92b0rXbkVHqzmtNcRGAz0uI8BI4wUI2cIgU5bcnGhjaeHaNPXFS3AdI8Z9TfpCXwkhgurnn++kauRaNwjzAEWEa1GV3qmnVQAcTeG8k6jP0TnPJHWh6/aJG/kCMQfIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072588; c=relaxed/simple;
	bh=wDmtn0az/ZGTsV5fo9OoouZA3Qw0sqHwOUyNpr/gRzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oj2bDB4tNbOW43x2ZWT3TmKWD0oTuFFJ4eRphYz5tbArHDltIsYon6qiKtEh59yyGF2by+UzYSAQXTxWW7iUBDqSunmhq8FmXdBfr1gZ31NHCCgJfdgBNZigROmlrxKs9AilM88Kxauccy6XxdAbyIEUIvFRLnTDpZYxuqxg6uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=eJ3wdcUq; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="eJ3wdcUq"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250905114300438d15be41000207bc
        for <xenomai@lists.linux.dev>;
        Fri, 05 Sep 2025 13:43:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NINyf3AtA70wsJPLGEvR3aMo0MEPVHqRLK2/EYh35/U=;
 b=eJ3wdcUq6vsJQgpc7WtVsn5xGnykjmBwByO6Lq7XJ78HJ89fhGn8jefSxXQgKk+egzcSrt
 h8g1Bh1Y4RPp1NZhpJ3jgVoEE1Yyb6o7a6WlWUofflVfAHDq2H4Kca7Q6Zm3V8tSYStFE3Uf
 fGcBwAOhQUKbv2uzvoDqQZb43FDQEBcRSqf3oZZn9sVG+omHz5TjBJtTckU/qv+8B6boCTbi
 IGjupTOXbK9xcrisOkQQyEefCG4DBPbombdr06CCVim98JRIQ3oU2nFkWat0oRugXq7E3jev
 PHbtG0mTzPybel+q4hfCgLXpAMqzi4BTBsbTggn1DGBgXMMlfKHFzBew==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 5/5] drivers/net/rtcfg: Resolve FORTIFY_SOURCE warnings
Date: Fri,  5 Sep 2025 13:42:58 +0200
Message-ID: <ddd74ce015e818f402e130da8ac5dfc86be24605.1757072578.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1757072578.git.jan.kiszka@siemens.com>
References: <cover.1757072578.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The rtcfg frame structures are of variable size, depending on the chosen
address type. Avoid memcpy to avoid trigging warnings while writing to
zero-length fields - which are actually backed by sufficiently sized
rtskbs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/stack/rtcfg/rtcfg_frame.c | 21 ++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c b/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
index 0c8eb7a878..ca6c130b5f 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
@@ -167,15 +167,19 @@ int rtcfg_send_stage_1(struct rtcfg_connection *conn)
 
 #if IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4)
 	if (stage_1_frm->addr_type == RTCFG_ADDR_IP) {
+		__u32 *ip_addr;
+
 		rtskb_put(rtskb, 2 * RTCFG_ADDRSIZE_IP);
 
-		memcpy(stage_1_frm->client_addr, &(conn->addr.ip_addr), 4);
+		ip_addr = (__u32 *)stage_1_frm->client_addr;
+		*ip_addr = conn->addr.ip_addr;
 
 		stage_1_frm =
 			(struct rtcfg_frm_stage_1_cfg *)(((u8 *)stage_1_frm) +
 							 RTCFG_ADDRSIZE_IP);
 
-		memcpy(stage_1_frm->server_addr, &(rtdev->local_ip), 4);
+		ip_addr = (__u32 *)stage_1_frm->server_addr;
+		*ip_addr = rtdev->local_ip;
 
 		stage_1_frm =
 			(struct rtcfg_frm_stage_1_cfg *)(((u8 *)stage_1_frm) +
@@ -326,9 +330,11 @@ int rtcfg_send_announce_new(int ifindex)
 
 #if IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4)
 	if (announce_new->addr_type == RTCFG_ADDR_IP) {
+		__u32 *ip_addr = (__u32 *)announce_new->addr;
+
 		rtskb_put(rtskb, RTCFG_ADDRSIZE_IP);
 
-		memcpy(announce_new->addr, &(rtdev->local_ip), 4);
+		*ip_addr = rtdev->local_ip;
 
 		announce_new =
 			(struct rtcfg_frm_announce *)(((u8 *)announce_new) +
@@ -381,9 +387,11 @@ int rtcfg_send_announce_reply(int ifindex, u8 *dest_mac_addr)
 
 #if IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4)
 	if (announce_rpl->addr_type == RTCFG_ADDR_IP) {
+		__u32 *ip_addr = (__u32 *)announce_rpl->addr;
+
 		rtskb_put(rtskb, RTCFG_ADDRSIZE_IP);
 
-		memcpy(announce_rpl->addr, &(rtdev->local_ip), 4);
+		*ip_addr = rtdev->local_ip;
 
 		announce_rpl =
 			(struct rtcfg_frm_announce *)(((u8 *)announce_rpl) +
@@ -498,10 +506,11 @@ int rtcfg_send_dead_station(struct rtcfg_connection *conn)
 
 #if IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4)
 	if (dead_station_frm->addr_type == RTCFG_ADDR_IP) {
+		__u32 *ip_addr = (__u32 *)dead_station_frm->logical_addr;
+
 		rtskb_put(rtskb, RTCFG_ADDRSIZE_IP);
 
-		memcpy(dead_station_frm->logical_addr, &(conn->addr.ip_addr),
-		       4);
+		*ip_addr = conn->addr.ip_addr;
 
 		dead_station_frm = (struct rtcfg_frm_dead_station
 					    *)(((u8 *)dead_station_frm) +
-- 
2.43.0

