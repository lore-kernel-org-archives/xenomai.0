Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209161B81D3
	for <xenomai@lists.linux.dev>; Fri, 27 Mar 2026 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637248; cv=none; b=ek6c07Bu0Oh45MPG4W1omm9XOWOuv5Cy9fO6rnnlsgYbphzR9mOwEHHRXrNKhZojqtdHW3Nmke8CNS430vMPqGKPCitdjlwNcbVJVYc4SDbUUdCJpCgufD9oebDvTcKe4PsEFOpIEw1JFUEbWVwO3IQO9gjYqd2Jvrnel7B7SNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637248; c=relaxed/simple;
	bh=UfXNBm95wgg3agtDy7rvvkFlk0bjHakEslJaG4HqNug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmHpX5G9Eln3CMH+u9tFDyT8C2VIoY6SCaOIL/tkCZZrCYl+KWFpMHNMoVIFrnX4kutFZHphnD+79PF9yZpArO8ccNdpjgm+rnx9LnefhgdwKL6DpXMmjw9wvNATH+S/mbwTqqEd+CDFwXOsZW5/9isOUoqjv5yhwNF+53egJ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTMoOqx8; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTMoOqx8"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4b77adso3519761c88.1
        for <xenomai@lists.linux.dev>; Fri, 27 Mar 2026 11:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774637246; x=1775242046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=brihVS608uMtJF1tFAoXDZgtYbkujjydlUHCHgKVY7o=;
        b=VTMoOqx8fm4MpKYBmLl5fAmMoa9RS/wFvyRuhta3SEIAsUgBVVwzntV0BuloYoj+dU
         uflbw06YIwhEongZ/BxlGbmEbV9JlIv1lpKZx/NodWo+cnue7f+oE3LudwmXzrPRG21C
         matazoiILFFMo5Oc8lx0S7uLAPKcOKqMRV9VdgDBkmwK9s6TyTKFXAtIFcckOHTOkGOE
         R2eHxY3hdZcASP55NAmm6l1Oaqh+JtbXwugdW/4BLNOOa7TnUyUkAYlucaf9/lCbwasJ
         EV1pnjVtzvYfBQhfgDrr4y4SaZejVJshwHcp8RDmVJsvhqwUJytIVK8GswaKYUdfqtgk
         TL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774637246; x=1775242046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brihVS608uMtJF1tFAoXDZgtYbkujjydlUHCHgKVY7o=;
        b=iIVJLYrrnzpYV1cABmPEWmngfrgERFAjkscWFDXSvO84Bz6myl9IpNPQVJkxV1CvDZ
         QVJTZ8ntMqlPQ9+Y9xo7C941Z/VRBYhnO7NJo0p4IPPEyfaX4t0IVnOE3parzuDpwduN
         L8cdhnQ03eSWyqgpz6CetAXvW0R9jptwDNiqo+LfnRwcEGYm5pMSQqvNsl+Mge4UtLQe
         dnr6aUHfg5aq78z66Y1FdE7g/eBTRSbzn4xOz4lDJZHebNZNKshIPuo91z2vGIhRhNDk
         lHVF3dHaUT1M6rIHLZjmkbUzdbMWKMkRImgsDgC0C7iWRQq96DOzrlDKuDa+r9IFl7e9
         GRqA==
X-Gm-Message-State: AOJu0Yy3GFvJmDINWw9kBVJN9++2pGrK+LVaUYDdtg1/+aHu93c815Hp
	DWE5ip4gvq6n4SEuQEUy24zE8fSXtWeL4eSmnRfm3yYXFQihTf8VTJHQRKf+Wg==
X-Gm-Gg: ATEYQzzHp5FRl+eWaJ7XFZr3e3ahFBPsQVk3Sd0hxcQZ2mhWsTsmbw0lwfzpXxSgSK0
	2mx+YR2nV7ab9Eb6C+8/DDptshyfGRORbdvfA7yydsMGf78m2FSiYlTYhHeCN42ugGw36KhtpW+
	4co7V90NdktCcnaXSOqIONO41ZKM/+/Rs3FW/QGigxojy/dOe0Mn9ROt3r3LsPzV+PZsMLv28Ac
	9VTw3eSgxjBpYthKpXXgSvr0sloY5bpM4BbkGOHnyJcpgmmey1rkgCULD/Kg1XAqWD0+48PyGZY
	v+ZVOwBP9MmtSB9zU1Zv9YYchqI4NKSMRJeTp7ABLXWWnaaceVzb0ZZtgWa61ce1BlUeBnM8fF1
	/aDqEzIw+l1nPJo6VoXFG+dc316c/ikKEHsfFy+MduYo9s5w1a8hee7S9SofJHVgdkc3rUSU1lx
	UlJ1OzGpG6SUpU7rbcM6nGbiHiINyhMjhmT4nOqoa7OrZ978BdWuyT
X-Received: by 2002:a05:7022:f8a:b0:128:d786:8ac8 with SMTP id a92af1059eb24-12ab27609ccmr2120191c88.0.1774637245727;
        Fri, 27 Mar 2026 11:47:25 -0700 (PDT)
Received: from brho-desktop.RELATIVITY.company ([136.226.6.69])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12ab970da7fsm80943c88.0.2026.03.27.11.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:47:25 -0700 (PDT)
From: Brandon Ho <brandonho667@gmail.com>
X-Google-Original-From: Brandon Ho <brho@relativityspace.com>
To: xenomai@lists.linux.dev
Cc: Brandon Ho <brho@relativityspace.com>
Subject: [PATCH] release oob skb when received in-band and fix setsockopt ret
Date: Fri, 27 Mar 2026 11:47:10 -0700
Message-ID: <20260327184718.580694-1-brho@relativityspace.com>
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
 kernel/evl/net/skb.c | 3 +++
 net/core/skbuff.c    | 2 ++
 net/core/sock.c      | 1 +
 3 files changed, 6 insertions(+)

diff --git a/kernel/evl/net/skb.c b/kernel/evl/net/skb.c
index 50090c181..9cd52e3e7 100644
--- a/kernel/evl/net/skb.c
+++ b/kernel/evl/net/skb.c
@@ -55,6 +55,9 @@
  *                                                -> free_skb_oob(skb)
  *                        -> dev_kfree_skb(skb)
  *                                -> consume_skb(skb) [1]
+ * 			   |
+ * 			     __consume_stateless_skb(skb)
+ * 						  -> free_skb_oob(skb)
  */
 
 #define SKB_RECYCLING_THRESHOLD 32
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e532fd636..b4dc5e1c9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1621,6 +1621,8 @@ EXPORT_SYMBOL(consume_skb);
 void __consume_stateless_skb(struct sk_buff *skb)
 {
 	trace_consume_skb(skb, __builtin_return_address(0));
+	if (skb_release_oob(skb))
+		return;
 	skb_release_data(skb, SKB_CONSUMED);
 	kfree_skbmem(skb);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 3321ff386..70a313c1f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1721,6 +1721,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 			goto lenout;
 		if (ret != -ENOIOCTLCMD)
 			return ret;
+		ret = 0;
 	}
 
 	memset(&v, 0, sizeof(v));
-- 
2.43.0

