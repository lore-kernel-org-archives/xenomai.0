Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E86A361640
	for <xenomai@lists.linux.dev>; Sun, 26 Jul 2026 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785090928; cv=none; b=qnerf6DH1Upwrxj1vlRA1Yj5B31DN/6xQg4UiFkAho2lIBlGtFE0V/V38xBG2o5TX/8zWVsuB9Kj7Qc2nOF09D30O5fTLdCsNCExM+Qo/fNyhpelWph23r7IDe+9SmayvBzC7WkAOYGJrI2VNj+jg/nnINd2RaE3Jxcrhd4UR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785090928; c=relaxed/simple;
	bh=knuDnbP3n5xLPlYqLb8Wfy0fAI4Hr8t0h44tU3ZT1Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2Y7MCRGFjwvJe/r61fN4xBbtqv2I1aEgvN6ZPxxPVs80u3PqhDgKC3/wcxlLKn49HfwNXFw5ccArHh4m60svj7D9NUZL6fu3voEq1PgSLRJr91h2UIgAoioOzB6uQSn8EW4WtBMqER3I+D8zxFXjwAe+nHfeu9WTxEFFUiDHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK1xc3dD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK1xc3dD"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495590dde14so21461745e9.0
        for <xenomai@lists.linux.dev>; Sun, 26 Jul 2026 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785090925; x=1785695725; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOo6NUkTH+1zmwNvai0+4JtBg8h4ZvGB3+dAKpWEYhw=;
        b=gK1xc3dD38jUBgFcxI1gXOre5OSEmT99ReypvS/me9ORUCeL008kRWlHAsJnUUajBw
         SBiI7JFkTdzeE/KsSVYwLxVCiH4+FQo1Wa8v3KQoNkSbmzuis3eGSeCmavt1sKsxyIJs
         pqJq2z4dCe9m/SlWiE5X5z+PLx8CK4up+mmnrvAMOubj2SWHICoY1DUDxYYh+5xQNXjR
         g3GlrPKmQarxU7eOxJbi3R1JTl7G2JkZQddViK52IxlI0ohzxgvIYbQRXiSInPEcsH8d
         HipJ6zhhrTq1C2MxJvc84bKGaU1eZ7Bm0W5Ldv4hqnJtu9bJImJHEyv0knARenCjrSNs
         EKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785090925; x=1785695725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DOo6NUkTH+1zmwNvai0+4JtBg8h4ZvGB3+dAKpWEYhw=;
        b=M2jTNc6RlDV2l/JzUKi+cbMH3hgj1IwW17jn2wIoJHO7HOZn0rRnJHCb4toCEWzSGK
         ROogkLMRBrcSpoAp8aCOrmDEx8uS/0hjZyt/BHM8jZZo70E5o0biYgl6SWRxkyBSivdZ
         mlPa7MApnjXhGNUQpq0hQUl316Q28NmBpTcBnByzGiV/qM5S265WL0LIvCo+/GzGSkpc
         cVnvu7F9Msk36MBlsw8uDXDoIbYIQC4IDsSDKuBOaTnFjI0pqRq9LkvTILw3peZCCDjL
         0XcN3t3TJ2ZS8oUfhQcedtjTfcjXCRXW21oiiRkSOAYlIyIHohziWWAhpaMM2dbQqYny
         6IGQ==
X-Gm-Message-State: AOJu0YxspvoyN/goHe0tUxWoLY4r9KUaJAjmcVNM1TomxkgwfJt1trwt
	Zw01ZIqANC+dxoGR9RE/uZRh7zKVh4JT0a2Uvk0y2aC02q3+pBGmopjT+5Cwxzu9
X-Gm-Gg: AR+sD127Px7F7WUQv1D97lSWAuYobHwudnRCpLD7y6yF7qJ1Ja1QzrcIsbxV1BDmQ+C
	Ktnha3vR0QRjhkFBypJOH/nt41iJY9yWDY8Q9kC7dKZf0oLbAn0ImypjwxN9d+Bdh6LzFR8o2sD
	80xL/RSAmQxegUZqwXzy8o3QVxltreqzKIPIdfpUAKDXGHNRTehZnd/7esnMGt81WbHaS39G3vi
	eTmxQYprFkhvjxYpN8/4BAhymukrEhTnmtHwfarqhG3y31XFT1zYQ1igCvyrimEDCCxxsSWk7gY
	D31AbROVFiTKpI8uv+8a2Al7SqsDX1Pcjyexi+GqEUgc7A6k4wUIUgqLop71yvvQx/qNT5+86BP
	IR84BsFbtM6pk814qpDc+KWN1p5B82YoKfhCPcmo7Sm5EeyWL83tTXC3G72e8GcZqFidNV5XO4j
	oapxk3xmLz8RwoYEM=
X-Received: by 2002:a05:600c:6986:b0:495:3e08:ad24 with SMTP id 5b1f17b1804b1-496b5726c49mr86373815e9.33.1785090924498;
        Sun, 26 Jul 2026 11:35:24 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-496b4858cfdsm171105805e9.3.2026.07.26.11.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:35:22 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH] tidbits: net-udp: use MSG_STABLE for server mode
Date: Sun, 26 Jul 2026 20:35:11 +0200
Message-ID: <20260726183511.5310-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <eda638e0-cabb-4b3c-9dc3-bd5ee4d167f4@gmail.com>
References: <eda638e0-cabb-4b3c-9dc3-bd5ee4d167f4@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSG_STABLE is now supported, so it is used to check if a client is
already in ARP cache and permanent. If not, use evl_net_solicit()
and try again.

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 tidbits/oob-net-udp.c | 72 +++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
index 658b463..931c4dc 100644
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
@@ -323,9 +287,37 @@ static void server(int s, const char *text, int mcount,
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
+				 * any data, oob_sendmsg() with msghdr.msg_iov = NULL
+				 * and msghdr.msg_iovlen = 0 can be used.
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
@@ -350,7 +342,7 @@ int main(int argc, char *argv[])
 	struct sockaddr_in addr;
 	const char *ip = NULL;
 	ssize_t ret;
-	useconds_t delay=1000000;
+	useconds_t delay = 1000000;
 
 	while ((c = getopt(argc, argv, "a:m:n:i:w:I:p:dsTRCSb")) != EOF) {
 		switch (c) {
-- 
2.47.3

