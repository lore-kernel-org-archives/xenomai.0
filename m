Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365322;
	b=I1wAcaYhT6VZVX5FfR+cXua9wfXhSYrOTQWBqdXK9pDaBrXe0TjYPDMznFZqLmbCe71r
	 w2MHeyVGOwkPkXA1ycIQPlefMjan41LVK+/g7jNrYECnZOZ3TyjskIFrzFRiYiSIgoRH/
	 H90MIgy5yCe+Nu5Iz3Dm7yQ+lCLdE2hwVugsq/Hfzo/05faLubyiY1JnhFvN2lIawdJW3
	 oGs27tJ+wRv25zHLd17Bq8LCsbKpRtqMg3Fa1Q0jLKkAd5FV+2Lbla86EYEZ1kdohYBHq
	 ej+lUVZ8KugS6WSUTFB4w1Vwhygg4QAdBjY+qV16ttWErKja+TuGy8CwPfokZCm2eww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365322;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Flowmailer-Platform:Feedback-ID;
	bh=IZDl30D8tzh51RBTtjWLft1w8gcK+8+E66Zd/IkKyAk=;
	b=OCgmGh+FgeoPZIgZVEckZBKXBoacPKUP/MS4l5JD2CEAAxxOZcJNSmVOlenaG4st0BVL
	 dMFCdMIDdFlxtI2UjAcVigKX5LZA9eQUaMQeXzQHjdVI7167/oNiGzanvjV7zYIUsYYkL
	 F9kaS8ZBWDqZaW+Jc97ReoxyI3fiSNuaRCg5BdaSJ4gizVe2JI/K4KBqk829CJ1AUh4eS
	 gKzOUZhYcCHMQq97VvneUd+uYCT708ZW1vJRU0qaiczxt9HVN48H76EewI4IuvH/3y07F
	 jxCg+iRJ1KtC8mJfhEt9lQOQlTCPKNIMSlHHHLJzHKt7YsbaT+KA6Jr77lYGJTwnvuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=pHpJEzYD;
	arc=none smtp.remote-ip=185.136.65.225
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478A606A324
	for <xenomai@lists.linux.dev>; Fri, 30 Oct 2026 13:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9478A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=pHpJEzYD
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20261030130157ed4b1e44ec0002079d
        for <xenomai@lists.linux.dev>;
        Fri, 30 Oct 2026 14:01:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=IZDl30D8tzh51RBTtjWLft1w8gcK+8+E66Zd/IkKyAk=;
 b=pHpJEzYDdgtIWm06VcfsXn5Q3rkGXZY8rmP7bA3v7V28oOVkD31o/Uol3jtQVwd6nXPktZ
 73q7VezhxWnRrKrnH/pPTfjo/TThfVSYnvCxZWvh1yXTn1hOmTS26dH2wVNQdRgNmJ12dao4
 AiKapTIbum58j0HMWHEn3wPX6kCwjapw1cyb2H2UZQKRIrPUc24pgMo5OSLmcx08fqfcTVzJ
 Q9+CNBp/Ri0vgDrLcxg+O9D80GStSMod2TQKjuY9PugvNysyO9UWBSTAsk3xwPM7PJNCoivO
 G8Q2cmJWUxiFF3ZRftD+e/XxT3jaIz9dfOYUC+Zj912cJX6WtFttXlaQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 30 Oct 2026 14:01:56 +0100
Subject: [PATCH] general: Add a b4 configuration file
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-wip-flo-add-b4-config-v1-1-4d4edf0d1b50@siemens.com>
X-B4-Tracking: v=1; b=H4sIAEOV5GoC/x3MQQqAIBBA0avErBvQyoquEi1KRxsIDYUKwrsnL
 d/i/xcSRaYEU/VCpIsTB18g6wr0vnpHyKYYGtH0UrQCbz7RHgFXY3DrUAdv2eHWKhr02EnVD1D
 aM5Ll5//OS84fmyilS2cAAAA=
X-Change-ID: 20261030-wip-flo-add-b4-config-b35e7c841567
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

b4 is a well known tool in the area of Linux kernel development. It
helps you to manage and send out your contributions / patches.
Docs are here: https://b4.docs.kernel.org/en/latest/

As the Xenomai mailing list (reachable via xenomai@lists.linux.dev) is
hosted on lore.kernel.org, we can re-use that tool for submitting
patches and managing.

One important step that needed manual configuration was related to
the destination mail addresses. We can't use the --auto-to-cc feature
as-is, because Xenomai itself does not have something like a Maintainers
file - which b4 is normally parsing.

Adding a simple configuration file that provides this information solves
that problem. No manual dealing with mail addresses anymore.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .b4-config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000000000000000000000000000000000..6e6bd54084d0ac1b6c7bfea9f64430f1e282e6ce
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,3 @@
+[b4]
+	send-series-to = Xenomai <xenomai@lists.linux.dev>
+	send-series-cc = Jan Kiszka <jan.kiszka@siemens.com>

---
base-commit: 966862a41d31d28a4e81bb3850541758e7f8896a
change-id: 20261030-wip-flo-add-b4-config-b35e7c841567

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

