Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C24B30F533
	for <xenomai@lists.linux.dev>; Fri, 27 Mar 2026 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643116; cv=none; b=c1pb5kKnt0JD6VMEwPhba3PKYk6FLb3ZG/0vp8mINfiY9a5B6CEnOwXFyzJ1kUTssGzp7kV9zHlO6KziWJmsdqvyOg8xTdDi2HSl/SMVgdhakgbQVdPK6OlcX5LirXnj9cH1kmwM8qh/ZniMN7u1/EqZM1T2JSuaK1ioNiCgMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643116; c=relaxed/simple;
	bh=Wlsec9AoIjQWU3BNgvK2WmCQNTTZzE3S8oQ0vFISQ4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVK+yU32ZFQle3PcQb7ORgt4bb2kBBE5K/1rWgu8jSlraPArgXG9WQRaUho0PI/+8tfD1b3Slx0XuKNIgXkhw1pxC71tZlcTUaVyQD18pbqCYWA1LOumlhOk8eQhGLuS7nP9hoPIwyujC//G1Qf/R4mLQ8UboQbRFJzZoZinZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qHOQlmsD; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHOQlmsD"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-126ea4b77adso3659429c88.1
        for <xenomai@lists.linux.dev>; Fri, 27 Mar 2026 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774643114; x=1775247914; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ui6WLACwGw5SnTdkUE71pr3rfe8MuitgXnqgoEnCEWU=;
        b=qHOQlmsD+prnoGCxOITT6kR/k6490hQh0wUGibOiw9ogodCldMnrq/8UPi2BruEDE2
         Ha/lCWeUVND5yE4VvdrZk9DWBsJRS4Qkl6z46cAvSPHG6hTpdZIEyA4WOTEU9+7U0H4G
         1huI4Sc7x3YvOmSdRVGZFVWwVNXHJYK0pyfZ7g5gXwsCTQa4mBsu8EXzh45pyZWL8ASY
         YskFZ0YBeS0C3bsr2JtTzFijcK1IfCpRdog6VW2+ZrArPk9xn9RxmXgl3+O9L5+nkSk9
         Oa4aeJjFCCt0GMR5gGjvR+UA8Rjceq4THz51h1/nVXhpZmG0NCc9Kj+kNjRj5kwmUr3U
         FGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774643114; x=1775247914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ui6WLACwGw5SnTdkUE71pr3rfe8MuitgXnqgoEnCEWU=;
        b=UR7cNkDFpORi7YveeHLy0fdABSrhEsUmASLlpuQMkYVNVSkYuw4FvfC9eVqVVxWYGm
         6/3VMODd/64azhb4iTnu36C9Fuk4N0MsvMSIM4ANhX9IgQGg3523jIoVFHbsExhUpxxH
         992ZevpKNFyTjRv59IRjjNeOsp2EUd0Uu7j1LlcLtTeMgVFtIaL13A4B6R1rV6fSyfpE
         IKUb4tJSFMa0bDLkE/k1E6XLI7JMjy5NtZP8hEG0tnncGHTDVtFLnTVOqe4gc33UXsNm
         uDSX9bDuz/pXJecj3pLrBcJ2kaVnaMznYiI6N6E5Y7QNcf+nB1+wQA/34F58mrPbzhGm
         NyiQ==
X-Gm-Message-State: AOJu0Yx7SiNwcA/mFDx7JYWdebJpyB/pmNK0cXbh5Z0h93bHweY1uDh5
	CGv3hUaPJLTarVDpEa3kGNarSUN+5nd74TXrxBwck29LrRYmYeTMhEXT7IxlVA==
X-Gm-Gg: ATEYQzxK6vVeGRs33ZqRD95ymGzzqYccN16aPMUpDXm6iexxTVrCVOFnwfLcYJpOSto
	3DSCy+Yb5R3ayHz3FYxdz9LYkLJbRANJVjvl3WM5TBsE64gKZl2zkdDYPlMvuOmM/b8ROCfYG1w
	GutH+hGvhHqWjSgPovwQ0bu19RazSCLTeHOcj2nmfvVSfeyKBBRIuZ+CdC3jgw3YbvouIUdlQV4
	rXZHFUO7pFBQw42tngA/Gl1ciEwEr1w+MTsapwB8lVKQbfE1wntCh/UlX6jevzlC619WoW/GGq4
	UHiQASllTjpgLOnOH+gHfy7fadZ6IKVpi0tAf93XgNBA3zbNlPccKUVpdHdBGQB4VE8XkpdRaS2
	kDT2vqXucT9PeXrBTNWeUuX+MXB6rjP2uWOKRgpJ3UDnwBNBPeuCRlaEnOp2lhpOZsV5FN+zPSJ
	ar23YDi3JPmtG1A4hS02zb9wjmIEzPgZO7o5SJXgugIVKzC1wm11ym
X-Received: by 2002:a05:7022:4398:b0:128:d084:e921 with SMTP id a92af1059eb24-12ab2884db0mr2379263c88.14.1774643113882;
        Fri, 27 Mar 2026 13:25:13 -0700 (PDT)
Received: from brho-desktop.RELATIVITY.company ([136.226.6.69])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12ab983f904sm326842c88.9.2026.03.27.13.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:25:13 -0700 (PDT)
From: Brandon Ho <brandonho667@gmail.com>
X-Google-Original-From: Brandon Ho <brho@relativityspace.com>
To: xenomai@lists.linux.dev
Cc: Brandon Ho <brho@relativityspace.com>
Subject: [PATCH] evl/net: rx filter precedence over loopback
Date: Fri, 27 Mar 2026 13:24:38 -0700
Message-ID: <20260327202446.592184-1-brho@relativityspace.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Brandon Ho <brho@relativityspace.com>
---
 include/evl/net/device.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/evl/net/device.h b/include/evl/net/device.h
index d0085b3c8..b8ed44377 100644
--- a/include/evl/net/device.h
+++ b/include/evl/net/device.h
@@ -53,18 +53,19 @@ evl_net_filter_rx(struct net_device *dev, struct sk_buff *skb)
 	struct evl_netdev_state *est = dev->oob_state.estate;
 
 	/*
-	 * Unconditionally accept all traffic sent to oob-enabled
-	 * loopback devices from the oob stage. Those devices are very
-	 * unlikely to support VLANs, but we could still use a filter
-	 * to accept in-band traffic, so keep on checking for the
-	 * latter.
+	 * RX filter takes precedence over loopback acceptance, because
+	 * it may be used to route packets to in-band consumers.
+	*/
+	if (test_bit(EVL_NETDEV_RX_FILTER_BIT, &est->flags))
+		return __evl_net_filter_rx(est, skb);
+
+	/*
+	 * Accept all traffic sent to oob-enabled loopback devices 
+	 * from the oob stage.
 	 */
 	if (dev->flags & IFF_LOOPBACK && running_oob())
 		return EVL_RX_ACCEPT;
 
-	if (test_bit(EVL_NETDEV_RX_FILTER_BIT, &est->flags))
-		return __evl_net_filter_rx(est, skb);
-
 	return EVL_RX_VLAN;
 }
 
-- 
2.43.0

