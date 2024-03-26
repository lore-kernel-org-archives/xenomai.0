Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9CC84D04
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434682; cv=none; b=H9El14gC58gyiHlg3OcvYtlxioK2oAOnyag1natRH4j9NNzNS4U+uNco1kkzcWPhQX85ztf0kvhmAxJOFKboW+TOu3WzpuVA8aUSovWzUW5Vp61rZKzGbyij2c9kTMWupnoss/GjiY+x05jAgpCSGFedndjvhFZPYr7aw2pxzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434682; c=relaxed/simple;
	bh=aeY18za470d3ip3Q7yJMWFuska97AjzyHRweN+a2iso=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQ/c9PPl10NY/IC3fhXmih4fXZEDmz1qrHfapx9+tQnFtkvU/oDDnjLIWexoiyPpL4flDCSmgbl3CPRthWHDYu03VOwQTxDfckLrRV69HblXn8Ww9/HlDb0xuCNmwnEryZTCk7qCrwekXYGLvfk0fgou4M6xAd0A6XOlPnm1mB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=P0HAOt3U; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="P0HAOt3U"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202403260631107c76de8bfe3087273b
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=sEmJj1M0Llg3k4kRIVMCpUTjwml0wmFKZRPP1I8k5Gc=;
 b=P0HAOt3UYyjnv+lO5T2iAnNekhR6jhc2wjUZgS+yEt1i3hh4Cvmi+fPc0bBku90rGvdXj2
 Dd6YcIv30RbADjh49Ofjeu0Ucxsvry+GMNWfo4XwmcVAXp2idvl34XeDM7cjnQSFJDIucne3
 o92zHy6OYjwIDhr/GS6mxhn2tb2us=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 17/25] drivers/net/ipv4: Align signatures of rt_ip_build_xmit
Date: Tue, 26 Mar 2024 07:30:56 +0100
Message-Id: <0dc7250869db63065a8a14378d7c9250858241e9.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
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

Prototype and actual handlers all use 'unsigned char' for the second
parameter of getfrag.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/ip_output.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/ip_output.c b/kernel/drivers/net/stack/ipv4/ip_output.c
index 664d0c790f..47da3ca75c 100644
--- a/kernel/drivers/net/stack/ipv4/ip_output.c
+++ b/kernel/drivers/net/stack/ipv4/ip_output.c
@@ -38,8 +38,8 @@ static u16 rt_ip_id_count = 0;
  *  Slow path for fragmented packets
  */
 int rt_ip_build_xmit_slow(struct rtsocket *sk,
-			  int getfrag(const void *, char *, unsigned int,
-				      unsigned int),
+			  int getfrag(const void *, unsigned char *,
+				      unsigned int, unsigned int),
 			  const void *frag, unsigned length,
 			  struct dest_route *rt, int msg_flags,
 			  unsigned int mtu, unsigned int prio)
@@ -155,7 +155,7 @@ error:
  *  Fast path for unfragmented packets.
  */
 int rt_ip_build_xmit(struct rtsocket *sk,
-		     int getfrag(const void *, char *, unsigned int,
+		     int getfrag(const void *, unsigned char *, unsigned int,
 				 unsigned int),
 		     const void *frag, unsigned length, struct dest_route *rt,
 		     int msg_flags)
-- 
2.35.3

