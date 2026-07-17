Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E34378D71
	for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316362; cv=none; b=uFbARP6ZuZwPThzgRfBz0V+dwtr5iE1/c46XAFpPkHKGdGIxTN5HE8I9LC4+JLXzeSyPkjMcZdoWoJT8sQWUDakYh46/dYQ1uCNRPnsrsJszMyzy1+Ns1XEThrCshFNRMIk4jqb8W+hZ6pdclo4P5Z8GVZ9Ue8b8wZKGD6dmAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316362; c=relaxed/simple;
	bh=KwoMt76KbiYD0ziy5hbBqlxI1EY2HOFeaDmySYZe+y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BicPHcKDWGz/yckdNXKdZVzWjYiAgnjpo6SVMRw8kpiqctuTsnxKG08CTm/GWqLCEXXNL3/Vv1K7cKpuukRwBBxclKQYxrQ4eRDlkg1I+gSsCrYhYQ/enH7fu7hTzayxrEGsNw8IE93GHP+ZOkBuxxk3Q0xtV0BbM5/Yn5Bf4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZwm0hwl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZwm0hwl"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso4516499f8f.1
        for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784316359; x=1784921159; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NOK/3U8NxjqyCw89iAnatgrO68fymP5aPlKeN1Aw51c=;
        b=jZwm0hwl7TbxvPFeIJ3W29ajKU3Mi/3PKt8Gz72pcDoZr5MRtc7cIRX4GGWrP6+fGO
         DDBeUc/u7LLZnDwiag2zXJKwbgU/56u2plW/ynHOvlCqXWPvAQjmGEcaXVuGMsK3MIbG
         4UaDkcP5VBD2B/5GeIwut0yL6eHoeXWaaVOxJ1R2UDRGryogGSo/2WwatNuQQXGLU+ny
         Jy66mHUaMSIg+pYrxamcx6MBUVVG9uzJLSkXzGYFDmPuuz8hai5BGCnDEIZVULh6eLxV
         1KIJqsE0FwZ4GHflVzDK8Crs1LjZndaIzOKZ3+eeh+tWJDPqtAx8TIBqDRc68IDSVR68
         6SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784316359; x=1784921159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOK/3U8NxjqyCw89iAnatgrO68fymP5aPlKeN1Aw51c=;
        b=DjB97K/n4cd5AaxpNiKTqysGR0gHoJ5/oHDnM3QkAEgI5cQ8ki0TbizCCCoOqdT73i
         9GHaMBjgKM/EKSNjjvs6JwTIUbpmaXuL6vQDTnxbjhyCvFa/OkizntnXAUxw9JL9JpRj
         CN/eLz0LnQVYeGCHguFVOr4k605eNp6OHGK+d6VbrYRMoQtj1M7Rasp4QZXr+KYo2DNi
         7pTWH7mK5gdaDPDiX4whRX6cVcnt2a6o3Zg01Z++fmDQWhi9O+AaBAKVo+1jcRNo3Lb0
         QTxVDrTL0++444W208UTVpjO7/UWiEu+dEqzZCerC2DqF6dLNQvDwUnYUsam5FCTbKYg
         BG3Q==
X-Gm-Message-State: AOJu0YyTUS5ZY9ZD1UNTvVRRRzrFbsPOzBvXKl3j20PFBF9oNssU7NMi
	T+VsO+xyv9m10lGtAN2vsDPLA7rtaslWHa/ATG2uO8yMy/OnuL99EknhKh5fJYu5
X-Gm-Gg: AfdE7cl1QaRbJVNKdyzEd9McXI8QRngKlg+GLRNA0LDpvnDhdHWuqA2nKUuH+vPPt7J
	cA3njSjZDAaTvaOpiCfktIExKdZThN6dCg6fAkpe94Dck9WXmqU2mRdFhULJ/MtZBurJrEyojMV
	DXRp0mHfQQJrX0T1kuGcSdEe2PwidMEu7huEAII7BxQUWMfmcNmh+p9JXzUhOX50RPpnor4Nyf9
	is11Uc7gDlCWWbW66lqjpAdk+2V0gS/JRoo8YTUlExECpbdlXCOj5IB2mu4ZSc7AfgldOGd4qsq
	4B1ZxFvBa3wkVo1SDy9fIiPkpszYrerrQx5V8VW6ygAMv882Hf1N/svHvX7CX4r6QN4txkq0EiO
	LJsZ/l77Oa9nWGGsbkYbaIN04BD0+qjYa2KL44VIiC14KHR8L3GM5pienDCf2Uo+n2QXfyfdTqG
	hC/ETL
X-Received: by 2002:a05:600c:b96:b0:495:4b00:1bab with SMTP id 5b1f17b1804b1-4954b001c39mr42189385e9.21.1784316358768;
        Fri, 17 Jul 2026 12:25:58 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63e65644sm5650325f8f.16.2026.07.17.12.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:25:57 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH] tidbits: net-udp: use MSG_DONTWAIT for server mode
Date: Fri, 17 Jul 2026 21:25:41 +0200
Message-ID: <20260717192541.15829-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSG_DONTWAIT is now supported, so it is used to check if a client is
already in ARP cache. If not, use evl_net_solicit() and try again.

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 tidbits/oob-net-udp.c | 72 +++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
index 658b463..f727f6f 100644
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
+		ret = oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT);
+		if (ret < 0) {
+			if (errno == EWOULDBLOCK) {
+				/*
+				 * oob_sendmsg with MSG_DONTWAIT returns EWOULDBLOCK if
+				 * the MAC address is not yet in ARP cache or garbage-collected.
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
+				ret = oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT);
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

