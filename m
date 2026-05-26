Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1B314A98
	for <xenomai@lists.linux.dev>; Tue, 26 May 2026 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820228; cv=none; b=Q29HKmg26WpDzU0hnMpTJo2UC7zeB2szSdVBXdqNi044MftLwUajszp8CufHpQXTjhtw1eQKYMtSDt5G/+Wf21wwYFNdHGzjxdC5Msxgu8WiYG9R4ZIL19m8P6r+PGe+LSVZlapBhKjC16CK5o3Kd9y64PEYWLlChlPNuAKCYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820228; c=relaxed/simple;
	bh=DY51fApW96oNoJcNIJtwhoeMV/9O48Drqk0F2vb1eOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNsUAxWGxhNkzsBow3RC5WxIi3YD4l2IVZUhYktMrQ7wItfHgmsRZucK/Y6RuyoW2fJWdn99RA32PMSEb/N4g51ITp1dtdvsh62MddOVpzPh/tkVQzKWWupucwb3ISAMSGWIhOVpMmlgD4rrlFW/u/TKNFUhlivNbPy63H4rbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdDBqV0R; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdDBqV0R"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49068493267so17462285e9.1
        for <xenomai@lists.linux.dev>; Tue, 26 May 2026 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779820226; x=1780425026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IF4PMRPk59Xbd57xSMy5PE91UT89NK+lRKUekADIx44=;
        b=qdDBqV0RAIzoDV6xIpYtIy1fg8KK+6lHQJ6zBdNvyeCZcrE6jJdcXuDjoSMCgvOeWV
         vC+N30fL6CrQFgb9kGUzCYnMP9Hub2GE3zGTJbuhfN8QSn6i4NvcBnHjdNYTToOEkgaW
         vXe+3yH6RtcOx22BRhRqOgvxL9V5m2F1GPKOmG5NyF41/8Y1NgwvWhhjEC99Yr5cslEX
         zTvpMhYg1AFoXnGdZnXJTajmwx/KdmGy4RWJ9xGV/1evKdmUX56DfLhxCgUGWbrwF2gy
         U+pBgnY0NxJCx8F24D5tBBRuiQXDa9UXJi/EeoXk2kC1rfvJbdhaQVdM+1f/Lsec8Iio
         QIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820226; x=1780425026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IF4PMRPk59Xbd57xSMy5PE91UT89NK+lRKUekADIx44=;
        b=KXTKOAknKIzmSaIXdFKAa8piC+wo5ydKW/nIFGBLNK0GJjjs0sNAVr3OVsWpDEvkIJ
         0cjQQg0OidwrpedSKKbSJz3q4gHg+AJzNarNSQNdVZzFTV0cUnC0BbODvOrYIT+Xt+4d
         PxwpGZ0vw5c1BnkKzFW2pxkgjqqeDsF2S0jOoj438qAc9Qqqd91j/KMI/jdv8BKddzi8
         S1nS4ppb31sKDAhOMXQztL9PnyllnQRc05/yPcS5LBaf5IhlL26G/p3u2tUpWGnbKCsD
         EO54fuPE94PQkgs9G3SfO4urQaVjpftDnJIY33epHNjPWjdiEJivLFr4NCCg3jd/5loT
         TG2g==
X-Gm-Message-State: AOJu0YzPUJKEA8cwQ4a9Ev4x6jo7K4bCVeSL7QForzZPOdLO2QKi0XAQ
	IIsNK7tqG1VnGBrDQyWvvxgU2wg25ZskjGG4hWiHWPcCAZLwApBmb33bPObJCQ==
X-Gm-Gg: Acq92OHBuw79l+ukTs3Ef+CwNdYxz3SPiIZnHiWuA3E75MfADHB9WTBSqh706wc35mP
	eClVnRPCsEJ+M24Qz7dY2cx6NZJdXhUrqcnVAzBkIhdl7Th+HjDHU5L6rabUdSUiJlxnKZUgvGF
	5LsQt6ssD5G6h9vAzBKuzuGJpAGT8XVq8yjPcm8ccgxWoHlGqK7DuOoEHq8aM3AjEci4LF8PARl
	CNLyAzKFWCP86q5XCBo5dN/NhHcsElNuKzMssnmpZfISrN3jKZHzpNkREl7AByTvZ79pAD1YAh0
	AzhCDfRcrZl30/Iy7nMaP2zniYWKn//tM5Ws8m/f3TjajU5KxcHSkyn4e2HLnAFdVlhTEAY1Fuf
	xfBGorRfDs47QNJKDOz0NpXDibMYnSNUzwvuYj2rOfhYdug0fEkXSzvAMSO0O7hEbvEP1nvX0YQ
	mj+fZW7UiYit9S1w5HhEX8BDv0t0/GplqACzB6
X-Received: by 2002:a05:600c:8484:b0:490:3b87:be0e with SMTP id 5b1f17b1804b1-490428e3362mr340694775e9.29.1779820225465;
        Tue, 26 May 2026 11:30:25 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45edb5c44e4sm19051f8f.36.2026.05.26.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:30:25 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH 1/1] tidbits: net-udp: fix error handling in client
Date: Tue, 26 May 2026 20:29:23 +0200
Message-ID: <20260526182923.4576-2-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526182923.4576-1-hannes.diethelm@gmail.com>
References: <20260526182923.4576-1-hannes.diethelm@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also fix mistake in comment

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 tidbits/oob-net-udp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
index 3cd7cb2..11b8459 100644
--- a/tidbits/oob-net-udp.c
+++ b/tidbits/oob-net-udp.c
@@ -8,7 +8,7 @@
  * The server mode [-S] receives a packet from on a given
  * port and sends a response to the sender's ip/port.
  *
- * The client mode [-S] sends a packet to a port/ip
+ * The client mode [-C] sends a packet to a port/ip
  * and receives the response from a server. The round
  * trip time is measured.
  *
@@ -443,6 +443,8 @@ int main(int argc, char *argv[])
 		 */
 		ret = evl_net_solicit(s, (const struct sockaddr *)&addr,
 				EVL_NEIGH_PERMANENT);
+		if (ret)
+			error(1, -ret, "evl_net_solicit()");
 
 		client(s, text, mcount, &addr, iter, delay);
 	} else if (mode == SERVER) {
-- 
2.47.3

