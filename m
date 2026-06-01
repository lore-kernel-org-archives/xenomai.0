Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C036494B
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342508; cv=none; b=athUZ1T53wrvhVWaQHIKFqUpvNIjJ5mzdMk9daHVHks2K5TKyf4C4XzxKR0j0+9THXp3EnGONZe8HXbQ7IXDYURsLPl4EE6kb9oXh8+fUIrJsoxKDyXxGGXyD0FIsW/5jw/F4MxD8WxxN2aA14FZkMTdxRMYZ6VmuWI1OHjsqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342508; c=relaxed/simple;
	bh=7aBzfEWoxw9iOEOqkjH1GuX0maqZkLABM/DJ2zq97us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HY7scGBjxvdGUlHALMxCbQIpjT25WQ6ZbhLIJYb1spiaUduBrvsi9OikBSsdcJu9wuBC1X2jPPwXM32v4NzUho02DM2KbNYmGKh6OgGvp9gskodWsUML+PVhf3Q/e4ARICpD/lp5fE1p8tSTDLmyFQHIcEAU6ahPVXDzBfpEHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWJLqh1u; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWJLqh1u"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490afc47455so2901155e9.2
        for <xenomai@lists.linux.dev>; Mon, 01 Jun 2026 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780342506; x=1780947306; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VKuJjt0rEFA4AZC0NWroC0MLw6LOAzY3pkd4PVBtb4=;
        b=OWJLqh1uoMWph45Ym9j+apffiUn+jnjoCW4ISSH5wJSy9lERn6vQazDXPeBld1oWWz
         vGPGzuS2UmEka4suwM6p5loro7Em4iX8lWfuDiwiiWeMt3KuUn4+gDpwLb2yE9mjGDUf
         sT95WkA7XpfDJYk3pmqeJeWeWtZvW+kCliHdlIJ4MvRgbamlWru3AqdA4cXMWaaw18Ce
         r9h8KFS2Zq1Hl/SktXH+mY4xHBSDRlMJayEVvGtoeycDHdYMMgPIr69YkOC0X9OdU2oy
         Cjuw6gcqHEXxwoZWk5PRDqApU7vUhFFYDYWmtbptz5zsj1OPYHoF8bq7u4ZBmQN5KERv
         XS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780342506; x=1780947306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1VKuJjt0rEFA4AZC0NWroC0MLw6LOAzY3pkd4PVBtb4=;
        b=aoUTeiSPcr55axZuhOmnfLhq0HKAlNDNe5O36WBcQPuF7U/hkcFCXd3N2cvGqGbBii
         5hjqBAp/NgYJCx23JZbep7iR8bPWEkMTw0XXGDAvXzcvtBqmVSIcFvzUge159L90hvwR
         PQN02XNHYIVyHWhutRXlLR6lK+tqwEYVXHVG2dqVcPSXjqiblNgYBXaCha/c5BKr7jLw
         UYtFV2v9Xab6wEvQTOwSh0Jn/wD0fkAZpx6QCmkdwNsBB0BXd5MAxfok9T8j3IhWZ8Nd
         230P0AvlYFXHMiCKH9Yl0+Va/jEK3LbqNgC7msz7rjIyh8gmeqIyL9kIWtXVZc5gwy81
         qBVA==
X-Forwarded-Encrypted: i=1; AFNElJ+HI8t2RT/DK9d+k3VsUxslBVWdyHwv7P9XwVWjyvbQQlvgVImybCuniqyl7UPqmnTOda4GmPub@lists.linux.dev
X-Gm-Message-State: AOJu0YwZOtkRr/+PXqczZRvozMnbme27ZHE+ubG5b1zMrIFQcJmVGWFT
	iSqArATFnQ0vJLTYrpM+/g3ts39KrLYJtwUGp8aHZs85VM5PNH6Ua2B+
X-Gm-Gg: Acq92OHMWReRWSqBC8P2Fzi1iExqIahHZV1b47A6jj/5VEMKcFfZJfqRXKfygvObxbO
	7Gu1xU70nwwCKb8Qqyun/H5ErSo3ibONr/nNKo2f+WVpVPlzUN7csW38LWWSDX0jGNVpbWpzUpp
	I1F0N+B2CmZW1wYqocRyarXk+5LckGEo0/2BHTCj1f8v1J1Yx/x13t+RGYqma6KjRQoJhTAEHSH
	akmQQwqvhvOVAoMN+u2ULStDjqg3TyDJYCLyJeQm4KUta25iTuapPz4KHty2EI2JPuF78ZERG5w
	PsblPAMaiJmyG1rPhE5qtqkeBFpkIEoUvktAk+7ZyUxxO6UFGJ0rU/wSgtuy4WYnenRbX9Vby1D
	U+c2fY6vNi/ZAJ3tQyZ5RcUUA+svMGyaWeAY2YzZtBQfOSPJ8K/COjgB+ky55C6ia7eUsJSEWxb
	59yc/eN/F26yPGKE57SRlj1+WPmLn7YxlnfLr+
X-Received: by 2002:a05:600d:486:10b0:490:b025:f324 with SMTP id 5b1f17b1804b1-490b025f485mr25418375e9.32.1780342505613;
        Mon, 01 Jun 2026 12:35:05 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909c0ac831sm82295545e9.10.2026.06.01.12.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:35:05 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: rpm@xenomai.org
Cc: hannes.diethelm@gmail.com,
	xenomai@lists.linux.dev
Subject: [PATCH v2] tidbits: net-udp: solicit new client for server mode
Date: Mon,  1 Jun 2026 21:33:27 +0200
Message-ID: <20260601193327.367361-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87a4te64vn.fsf@xenomai.org>
References: <87a4te64vn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes random EINPROGRESS at init or during runtime.

Also correct whitespaces and make stdout more consistent.

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 tidbits/oob-net-udp.c | 58 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
index 11b8459..658b463 100644
--- a/tidbits/oob-net-udp.c
+++ b/tidbits/oob-net-udp.c
@@ -50,12 +50,12 @@ static void usage(void)
 }
 
 static void print_addr(char* text, struct sockaddr_in *addr){
-    char ip_str[INET_ADDRSTRLEN+1];
-    inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
-    evl_printf("%s--------\n", text);
-    evl_printf("IP-Address: %s\n", ip_str);
-    evl_printf("Port:       %d\n", ntohs(addr->sin_port));
-    evl_printf("Family:     %d\n", addr->sin_family);
+	char ip_str[INET_ADDRSTRLEN+1];
+	inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
+	evl_printf("== %s\n", text);
+	evl_printf("   ip-address: %s\n", ip_str);
+	evl_printf("   port:       %d\n", ntohs(addr->sin_port));
+	evl_printf("   family:     %d\n", addr->sin_family);
 }
 
 static void sender(int s, const char *text, int mcount,
@@ -226,6 +226,8 @@ static void client(int s, const char *text, int mcount,
 	free(tbuf);
 }
 
+#define SERVER_ADDR_LIST_SIZE 64
+
 static void server(int s, const char *text, int mcount,
 		struct sockaddr_in *addr, int iter)
 {
@@ -236,6 +238,9 @@ static void server(int s, const char *text, int mcount,
 	ssize_t ret;
 	char *tbuf;
 	char rbuf[16384];
+	in_addr_t addr_list[SERVER_ADDR_LIST_SIZE] = {};
+	size_t addr_list_fill = 0;
+	bool solicit_done;
 
 	tlen = (strlen(text) + 1) * mcount;
 	tbuf = malloc(tlen);
@@ -276,6 +281,39 @@ static void server(int s, const char *text, int mcount,
 			evl_printf(" (TRUNCATED)");
 		evl_printf(": %.*s\n", (int)ret, rbuf);
 
+		/*
+		 * We need to call evl_net_solicit for each new client
+		 * once before sending data. This demotes the caller to the
+		 * in-band stage for the first response.
+		 * If this is not done and the ARP address is not
+		 * yet in cache or garbage-collected, oob_sendmsg
+		 * will return EINPROGRESS on start or during runtime.
+		 */
+		solicit_done = false;
+		for (size_t i = 0; i < addr_list_fill && !solicit_done; i++) {
+			if (addr_list[i] == _addr.sin_addr.s_addr) {
+				solicit_done = true;
+			}
+		}
+		if (!solicit_done) {
+			if (verbosity) {
+				char ip_str[INET_ADDRSTRLEN+1];
+				inet_ntop(AF_INET, &(_addr.sin_addr), ip_str, sizeof(ip_str));
+				evl_printf("== client %s first seen: evl_net_solicit\n", ip_str);
+			}
+			ret = evl_net_solicit(s, (const struct sockaddr *)&_addr,
+					EVL_NEIGH_PERMANENT);
+			if (ret)
+				error(1, -ret, "evl_net_solicit()");
+
+			if (addr_list_fill < SERVER_ADDR_LIST_SIZE) {
+				addr_list[addr_list_fill] = _addr.sin_addr.s_addr;
+				addr_list_fill++;
+			} else {
+				error(1, EPERM, "address list full");
+			}
+		}
+
 		iov.iov_base = tbuf;
 		iov.iov_len = tlen;
 		msghdr.msg_iov = &iov;
@@ -433,7 +471,7 @@ int main(int argc, char *argv[])
 		receiver(s, &addr, iter);
 	} else if (mode == CLIENT) {
 		if (verbosity)
-			printf("== client mode (<= %s:%d)\n", ip, port);
+			printf("== client mode (<=> %s:%d)\n", ip, port);
 
 		/*
 		 * Guarantee a mere oob path from the first packet
@@ -449,8 +487,12 @@ int main(int argc, char *argv[])
 		client(s, text, mcount, &addr, iter, delay);
 	} else if (mode == SERVER) {
 		if (verbosity)
-			printf("== server mode (<= %s:%d)\n", ip, port);
+			printf("== server mode (<=> %s:%d)\n", ip, port);
 
+		/*
+		 * The server calls evl_net_solicit() internally
+		 * for each new ip address.
+		 */
 		server(s, text, mcount, &addr, iter);
 	} else {
 		error(1, 0, "Mode not implemented");
-- 
2.47.3

