Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18630381AF
	for <xenomai@lists.linux.dev>; Sun, 26 Jul 2026 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092527; cv=none; b=a8h7dMfQJHNpN/bvGYi4PwEk4eTw1cxniYNjoIEDBUxl8Cj3joOpDmFFaw5Ty/xhyjWIh0FpfJTOXOoTIPXdk6DLdumxCCZ/Cdl23Qlnm098SXG5JPWyNHRkoepJ7SLbAPGgE8e715m06sWil+0594HqFYajgeJ55AUc+dZZayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092527; c=relaxed/simple;
	bh=er1d6NH8tEU87BTgGLl2YiqO2OTF8C1h5G/JvO9lBhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYISF7JfYH6+hJUNkvLsQLpRtjx/bGNG/Ibd+Ll9Ho1TCMWLwrXJw68M7EBuuP7cc7cS6mefqIJe3yzZwhKdZThk/LCHIR5ODugDPKK4Hsr9lMcoSXc/9Z1MvnSy+v2kNhB1TTxCLobriABF2d77f7yNoCcbVsAErLa8t9z09n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUM9MFbl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUM9MFbl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-496b7622a83so6593585e9.2
        for <xenomai@lists.linux.dev>; Sun, 26 Jul 2026 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785092524; x=1785697324; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZRkWCnhq30FiE3GT6GlRS4IOguX0TupQKjerP89VjBE=;
        b=eUM9MFbl1+SwDMHvr/+TCCZb9az6Ebk/Ciu3WJfFTmo47B7d9FDO/Y1ieVQ0gCkIpx
         LxQAWO5SVPS+6vk582T7KmS5tfKmAtM1OyErJyM3LHpH0+xZM67ktSaWcKBrio8pHlm9
         ymmpA7+Dgr/YRxZINMi8dis0E62QkGkCXJTUcVUEYf2X2OF8swwnKdB05rZmmLO71ulu
         e9K5YV1dpO9BC4ilo2SyMayG0GON3xf62qDWP0VXEdbWZ71zPNjoF1aAFBh0unbHKxJj
         lwgQEv9vFr68KO1HzGbosXCPbjq9pfJx5zseZhYA58Bkyfuuu4zJjpO54aKvGZwY9yHr
         N9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785092524; x=1785697324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZRkWCnhq30FiE3GT6GlRS4IOguX0TupQKjerP89VjBE=;
        b=ZTodzGqp5xKqSaoINuwgiR1apkHQFE/30ETp9hgMON5L9nJbQDk0EdnDPXaFtbF88v
         tYq1ifnnt2AE+3yp8iAh3SR4nUyz4I0T8XZ/aoMZRXcK60xwt4kd+vEtikEgeLEbjw6P
         6EeOJ/uXu58ULBvBOhAKC8PaokbF1QNDYseJ/gt2FuGQ751K5NHaC5yXi5qAM048efe/
         Ug72lFAtejqno2Y9dzulCDtfAnKDLWreXkumXnJjLyJwj3fbhPFS/2h+5cqfh8e5qcdY
         Cr39sYf3xoWHV6VNl4VL5DCtK5YI5VPNkAxyBRCNhMVDtMR1xjqrs21V8MoaxcrwP3o+
         25lw==
X-Gm-Message-State: AOJu0Yy1t/+bQNNf6z7ZNapU5YNMuIR/rJFAx24NPl/h7zv/mQtzI6l9
	sGGFBw69e+VASiIREf4wyCmKtuiaKpudiW5t14Mjlp9bo92ER4JFS3Uga9aeOF4F
X-Gm-Gg: AR+sD12p08oXnKhsunyVzEj8r+lKa4Szjn1Q3MLmTKKsJIOsNM+oDKtU5AD1UovLzbI
	h1h/xKnG3/ueR0JgkYYTN8NA1+tNYAzDu7P2//qQt42ZoGCVCKgOsvBedrGYsIJMfc1h5VLmE/u
	WUEKR/A7lhywCBrRvTiLiuGnd7CQibbvlrcCByefJCHUCY1OG1OXIhWssmEz2ISkZjeyn0D0+aL
	afyLydC5peNgs3AV1DH48/RlF7pKu0xD3Q5WTGamx5Y4PUSCpSxZ/p0jrY3KUuHEwFPw3Vc5PzX
	zq0fLHhiJeTD211uZ6huU7bh6SfK/mQ29k6zqBv7H9ZddTQtJaLMtelW6lTRL/Eou1X14rziV4P
	fhttZd3dGTEHz15j+xAuzRg6s0kvbGCJngrMMw7dLyVkrrm3mRHOMdiOG0k2KXkWMHrlyekeyBj
	fibe38
X-Received: by 2002:a05:600c:4753:b0:493:e46e:157d with SMTP id 5b1f17b1804b1-496b5747d73mr81380375e9.19.1785092524004;
        Sun, 26 Jul 2026 12:02:04 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4957f99fa7asm200466445e9.2.2026.07.26.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 12:02:02 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH v2] tidbits: net-udp: use MSG_STEADY for server mode
Date: Sun, 26 Jul 2026 21:01:56 +0200
Message-ID: <20260726190157.7532-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726183511.5310-1-hannes.diethelm@gmail.com>
References: <20260726183511.5310-1-hannes.diethelm@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSG_STEADY is now supported, so it is used to check if a client is
already in ARP cache and permanent. If not, use evl_net_solicit()
and try again.

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 tidbits/oob-net-udp.c | 71 +++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
index 658b463..475e26a 100644
--- a/tidbits/oob-net-udp.c
+++ b/tidbits/oob-net-udp.c
@@ -238,9 +238,6 @@ static void server(int s, const char *text, int mcount,
 	ssize_t ret;
 	char *tbuf;
 	char rbuf[16384];
-	in_addr_t addr_list[SERVER_ADDR_LIST_SIZE] = {};
-	size_t addr_list_fill = 0;
-	bool solicit_done;
 
 	tlen = (strlen(text) + 1) * mcount;
 	tbuf = malloc(tlen);
@@ -281,39 +278,6 @@ static void server(int s, const char *text, int mcount,
 			evl_printf(" (TRUNCATED)");
 		evl_printf(": %.*s\n", (int)ret, rbuf);
 
-		/*
-		 * We need to call evl_net_solicit for each new client
-		 * once before sending data. This demotes the caller to the
-		 * in-band stage for the first response.
-		 * If this is not done and the ARP address is not
-		 * yet in cache or garbage-collected, oob_sendmsg
-		 * will return EINPROGRESS on start or during runtime.
-		 */
-		solicit_done = false;
-		for (size_t i = 0; i < addr_list_fill && !solicit_done; i++) {
-			if (addr_list[i] == _addr.sin_addr.s_addr) {
-				solicit_done = true;
-			}
-		}
-		if (!solicit_done) {
-			if (verbosity) {
-				char ip_str[INET_ADDRSTRLEN+1];
-				inet_ntop(AF_INET, &(_addr.sin_addr), ip_str, sizeof(ip_str));
-				evl_printf("== client %s first seen: evl_net_solicit\n", ip_str);
-			}
-			ret = evl_net_solicit(s, (const struct sockaddr *)&_addr,
-					EVL_NEIGH_PERMANENT);
-			if (ret)
-				error(1, -ret, "evl_net_solicit()");
-
-			if (addr_list_fill < SERVER_ADDR_LIST_SIZE) {
-				addr_list[addr_list_fill] = _addr.sin_addr.s_addr;
-				addr_list_fill++;
-			} else {
-				error(1, EPERM, "address list full");
-			}
-		}
-
 		iov.iov_base = tbuf;
 		iov.iov_len = tlen;
 		msghdr.msg_iov = &iov;
@@ -323,9 +287,36 @@ static void server(int s, const char *text, int mcount,
 		msghdr.msg_name = &_addr;
 		msghdr.msg_namelen = sizeof(_addr);
 		msghdr.msg_flags = 0;
-		ret = oob_sendmsg(s, &msghdr, NULL, 0);
-		if (ret < 0)
-			error(1, errno, "oob_sendmsg() failed");
+		ret = oob_sendmsg(s, &msghdr, NULL, MSG_STEADY);
+		if (ret < 0) {
+			if (errno == EADDRNOTAVAIL) {
+				/*
+				 * oob_sendmsg with MSG_STEADY returns EADDRNOTAVAIL if
+				 * the MAC address is not yet in ARP cache or not permanent.
+				 * We need to call evl_net_solicit in this case.
+				 * This demotes the caller to the in-band stage for the first response.
+				 * To probe if the MAC address is in the ARP cache without sending
+				 * any data, oob_sendmsg(..., MSG_STEADY|MSG_PROBE) can be used.
+				 */
+				if (verbosity) {
+					char ip_str[INET_ADDRSTRLEN + 1];
+					inet_ntop(AF_INET, &(_addr.sin_addr), ip_str, sizeof(ip_str));
+					evl_printf("== client %s not in ARP cache: evl_net_solicit\n",
+						ip_str);
+				}
+				ret = evl_net_solicit(s, (const struct sockaddr *)&_addr,
+					EVL_NEIGH_PERMANENT);
+				if (ret)
+					error(1, -ret, "evl_net_solicit()");
+
+				/* oob_sendmsg again, now it should succeed */
+				ret = oob_sendmsg(s, &msghdr, NULL, MSG_STEADY);
+				if (ret < 0)
+					error(1, errno, "oob_sendmsg() failed");
+			} else {
+				error(1, errno, "oob_sendmsg() failed");
+			}
+		}
 		if (verbosity > 1)
 			print_addr("sent to", &_addr);
 	}
@@ -350,7 +341,7 @@ int main(int argc, char *argv[])
 	struct sockaddr_in addr;
 	const char *ip = NULL;
 	ssize_t ret;
-	useconds_t delay=1000000;
+	useconds_t delay = 1000000;
 
 	while ((c = getopt(argc, argv, "a:m:n:i:w:I:p:dsTRCSb")) != EOF) {
 		switch (c) {
-- 
2.47.3

