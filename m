Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31F331A78
	for <xenomai@lists.linux.dev>; Thu, 28 May 2026 19:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997645; cv=none; b=O3n/JYyCp0k4yPE7iZmSYg6T7QmheczfxJ8EqLrx77diV62RdJy+KYBSoADTa0G8cd+UCyFAFfkh2bll+vHus4mW8HAT7rCobfcmLzd8kjEDVfPyjmjtsKEovFmn82jZym9+NqnuEIqnHW5xhQK8yVrLPOXR6yNZdt+z6iwi88c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997645; c=relaxed/simple;
	bh=sCUuRSFCBdnzyUDQEiQr39sc6Q7WC/TwClUx8bxIFvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0z5W/0hryI+sm3A8J9PeLRsu4PRNf4niAQAJoI3NR1AebR9lFrPVHyt3oGBJZFH0q5uKg66RIBZFWgzoNm6RG+gupMbKQKsk2cC1zmYvP0SBl1Rk8mDGOwFcfD9ToBWY59oGB8XKB6+esF3RZ5rEXpn70WpP6kbOmmS/2s1NGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNoulg7T; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNoulg7T"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso75208225e9.0
        for <xenomai@lists.linux.dev>; Thu, 28 May 2026 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779997642; x=1780602442; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idW8MRPNMah3FYWekOFnbKgmoilboXB4etlAmR4Afbg=;
        b=KNoulg7TefUB0dj63qaNbmyLPP35X7NMMQZ7vjxMRxceCaCENMkCrVMP1/J3Aa9ROd
         YDdByXhFRA0L+W3aSyl72XEU8Yl8xEthGmhp52FFQUt3UDxBYDx0DYZTEsQP3o4MFXym
         bYmUionY8YSG8mXiaDdZL0LtHdrH9AYMY49EqzZaUw2iRtT8T2N6sMOT8JkNLjd6z2ot
         RbrRTsaA21ZsWiuhMSjN1UQoHkVolY7JpVLBlfzn9VbToE/M+btSbcBj2egN9NNllFRv
         CQhXM3jLikIcdd3n4vRaAcwaUIDh7Rk6zQ1TetsFbYSCJSOETdelQNXt//MxfHVmjuNJ
         1mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779997642; x=1780602442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=idW8MRPNMah3FYWekOFnbKgmoilboXB4etlAmR4Afbg=;
        b=DF5ItnaErof1lNkJgi5qD8zk3SHCS7ONod7VYuhMzDP98q7eM8JVVT89hGMV/nvLEs
         zIloFql2iH5AsDiKOmH/ZhgcGjDoo0GYgWnyXc5rOelUMRT+q3EUh3UWEB4wmu4pRXEw
         4Nf24HF+aMRksPFoaU/xaFwoqtf/jABWL/385R5mhRTHKwSYlSFvt7evI5f1a53Fn6k4
         t3+BdaLwUHXlXMn0d3VzOZ3XOMcaYzDCKHHyFI1kTHyK+f2BU9QdoEhSrwQJmWJpAzSX
         FVk+HKuga4cHXUm78Foq27z4bEGLGT4qv8gwGrqy7mgn6WOaYsLlaVHohZEDWuWqn60b
         tcXg==
X-Gm-Message-State: AOJu0YwbcZFgFbb9J29BI4hU8KNDSQCdUzrJfZXkenq8HX3fHleakr7G
	r8SzywasoDj9CekjL33kvazRGaQ7m5KjqoqVHH6XKUGb3eKjbM1q6qp66/Agug==
X-Gm-Gg: Acq92OEFGna/MU9tsUD3LTBCt97tVIzsJwKEuVDj6PrI4SmVbtfgKR2ceTf4OOeLFH3
	LFE2UCVc/j9gJG91kk/gOPjrG1YSk+fGF2MwAdRBJj84DTrXpteNKZXQgfNBzvOU1OEayilmwQG
	MCWB7z0C0TS6D8foQ0RZJtKQASxRSKsaSn1umJAehqPRgIaN9B9uln18dg+sJZ8akL1+Axnt925
	Yaw6JpLVAn1vb81S9V1rycJ6tgWVDmJsxE7teE5kw7LOKUn8IipgfkiQl3MJSiq1pEhfmDnsCkO
	HS9nAfnK4n9NVt/H7ak98ZYddZ0ckKA/FJcNmJV+s3A23ZSwFeqB5Ud3dlTpKVtERsHEBL1Omol
	7gkScyhIJ8f90/o58EsurniQDF3b+nwuVkS3LNf2X87LRGudj5QUFgZYeqYH9Uz5oSzK9Xs6Ep5
	6qgYijtN9eqxRSlRMrEma4Zi+09teN+ChZRNAu
X-Received: by 2002:a05:600c:a203:b0:490:31e:d6fd with SMTP id 5b1f17b1804b1-4909bfe57a6mr239455e9.25.1779997642311;
        Thu, 28 May 2026 12:47:22 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45edb5b1a28sm15457669f8f.26.2026.05.28.12.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:47:21 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
Date: Thu, 28 May 2026 21:44:59 +0200
Message-ID: <20260528194459.6117-2-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528194459.6117-1-hannes.diethelm@gmail.com>
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
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
index 11b8459..7af834f 100644
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
+	in_addr_t addr_list[SERVER_ADDR_LIST_SIZE]={};
+	size_t addr_list_fill=0;
+	bool solicit_done;
 
 	tlen = (strlen(text) + 1) * mcount;
 	tbuf = malloc(tlen);
@@ -276,6 +281,39 @@ static void server(int s, const char *text, int mcount,
 			evl_printf(" (TRUNCATED)");
 		evl_printf(": %.*s\n", (int)ret, rbuf);
 
+		/*
+		 * We need to call evl_net_solicit for each new
+		 * client once before sending data. This will break
+		 * realtime for the first response.
+		 * If this is not done and the ARP address is not
+		 * yet in cache or garbage-collected, oob_sendmsg
+		 * will return EINPROGRESS on start or during runtime.
+		 */
+		solicit_done = false;
+		for(size_t i = 0; i < addr_list_fill && !solicit_done; i++){
+			if(addr_list[i] == _addr.sin_addr.s_addr){
+				solicit_done = true;
+			}
+		}
+		if(!solicit_done){
+			if(verbosity){
+				char ip_str[INET_ADDRSTRLEN+1];
+				inet_ntop(AF_INET, &(_addr.sin_addr), ip_str, sizeof(ip_str));
+				evl_printf("== client %s first seen: evl_net_solicit\n", ip_str);
+			}
+			ret = evl_net_solicit(s, (const struct sockaddr *)&_addr,
+					EVL_NEIGH_PERMANENT);
+			if (ret)
+				error(1, -ret, "evl_net_solicit()");
+
+			if(addr_list_fill < SERVER_ADDR_LIST_SIZE){
+				addr_list[addr_list_fill] = _addr.sin_addr.s_addr;
+				addr_list_fill ++;
+			}else{
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

