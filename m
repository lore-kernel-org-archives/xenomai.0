Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B522A4D2
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772563; cv=none; b=spyOA8YIBbAHJh8IdjO5jFH8x7HcK5Zr3bUqx3MujLUWX/8bu41f4lKMC1uSsXi60bOm1WMVAiM1S9ZCrfX66LOYnR3k86izHHSopmBNxauyJlMC7Ww1RGsWF5Cz8FEzdeJxbuwyiJuhxKFsWly9dmuI84HHa6ZDD2mTmNZ//FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772563; c=relaxed/simple;
	bh=Ev/sn1d9YUdle6goKa4dnQFUQB7ck73GN0Q/FCtcOF4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tG3VddS2AHA+pvmM9rrS95woWEsUdQTaXdYF9KVWvg3pBKWurTuvh+NAlgjyDeHFssLe+JoiuxSyYUejyggl5UzJSvHSRzzU3hj2hfixsMBWMN7ZjjtS9O0/1ACwdMj2sSIaHOMPngXpQY/6rmg71F+JnbTeCuObfE7Qa0ZTu2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=fFU6dyI1; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="fFU6dyI1"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250113124911ed4faedb3d49dacc5f
        for <xenomai@lists.linux.dev>;
        Mon, 13 Jan 2025 13:49:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=phCW7wUtbfIz8Oj662I9uPHd8ffF6IryzSKxYkQyyu8=;
 b=fFU6dyI1YdRcMO9c9hwscdDslLE05ILbZZrfUzoZ0YmrRADJ56GEWfaUfFXKPxfMcK1jQE
 KvfN9EUdGzB15P/WCtk5a3xSpwC2QVBJWQL7w6Yi8AqFPbM+eVLjff4pu9bYpDPXFi5IMKDl
 j7PzW301j2OuK37hL0CfIiY5Y+MgD1x0XEevo9g0V78Qb3LwBUjmmNfQYqitNBLBQ/kuVALL
 FnISCpLZud1eFLs+u8LNcJzQ6BYy50JwYizHW0dzLAo56Cp6KnGtl7L0pUbMy0LSxP1GZiae
 7oEkwWCkD+Kr3zBms6h0nkf3lBZTRXe05+zm7jWxEB3ZMk915AH9zO5w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 2/6] Update isar revision
Date: Mon, 13 Jan 2025 13:49:04 +0100
Message-ID: <97cb13e2323c22ca01c6694f618866ef24b2a3ba.1736772548.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1736772548.git.jan.kiszka@siemens.com>
References: <cover.1736772548.git.jan.kiszka@siemens.com>
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

Brings slightly faster mmdebstrap.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas.yml b/kas.yml
index 778165d..2020ed7 100644
--- a/kas.yml
+++ b/kas.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2024
+# Copyright (c) Siemens AG, 2018-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 75488685dd2123417deb70f6d0923b8c2772954e
+    commit: 483093e11cd722f0c88dc2fcbed1e937fc0abb60
     layers:
       meta:
 
-- 
2.43.0

