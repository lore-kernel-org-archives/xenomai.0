Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7B1DD537
	for <xenomai@lists.linux.dev>; Mon, 28 Oct 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123091; cv=none; b=jzCcU5WSrdZSEvWwkZp1yGkAKyOdYRi/6LRG0XHSBvkw5S/AX6L27ICmvuRcYvO8fdPWSiBpo+t3KHNxI6bOe87Kl2fhymm94SDKIUlrPVKI0aH9g/rJXNgnxzD3TmYZl92IsRECgc2/DT94PxKp3bJgOd276om809ubQcwpc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123091; c=relaxed/simple;
	bh=5OqpoTkUlsIZHqwqsciBedZrX0rnqMtm/+J/uE+R6yY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2semfCqw1HobmbYJ9/nVTAkG7vLW3d3Ra/h6EFlaKpMiWECVsmy/ASNWxbA76N3WXyvdmDcz3qtWRqAX5tOSyNBH211yOew5IQF2c5CFjGO/zlGNJSmNELsyylCFjsAjCU8LUx4eP4tgImD/4B0f5LieDGWpQFvrkXwfmNf2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=fd50nR6q; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="fd50nR6q"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202410281344454ab3076144a9528588
        for <xenomai@lists.linux.dev>;
        Mon, 28 Oct 2024 14:44:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6h+IoU+fLGavmrp1MH7xqjJU+i+iESvSSAkvqBeoFHM=;
 b=fd50nR6qqfZYw1fg35eWc1g33+WzxuaHd4X2vAn17ccxThDYRGJvFm9lmJR1ptydynBC4c
 zFRIoUTSqqH0zMc8F+8mwaSWzK1VJjuO48o8M3CLx68oB+qnmG47jb7wgwCwcLRBjrDYmLyv
 GGD/3i6VF5ma7zpEPT2v9ll86BaLNBb8cfOVTF3bcS/bNb3rjHbGfi4gc5X+PiXe3dRgiZ2+
 T5CtKvGogi9crNWW+FW19ARaLh4PhJu+tjvzAADdiDhCn+OUlEqGfdFKBqAJkqKkXPjgt+AQ
 nE2N32sUlTVPDZCade1bisiD0RLG35APBubP96k0A6rFMapMgzXwaoxw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 1/6] layer.conf: Fix sstate cachability issue
Date: Mon, 28 Oct 2024 14:44:39 +0100
Message-ID: <68fa3ee1401c8bf4e3dc1b5adc20ede98398df34.1730123084.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730123084.git.jan.kiszka@siemens.com>
References: <cover.1730123084.git.jan.kiszka@siemens.com>
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

LAYERDIR_xenomai is consumed by ISAR_RELEASE_CMD, and that introduces
the build path to the sstate cache. "isar-sstate lint" warns about that:

==== issues found in armhf:demo-image:rootfs_postprocess (04880b1a) ====
-> path in build-dir:   LAYERDIR_xenomai = "/builds/Xenomai/xenomai-images/build/.."

Resolve the issue by setting a vardepvalue for it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/layer.conf | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index f665993..c96b6fd 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018
+# Copyright (c) Siemens AG, 2018-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -21,3 +21,4 @@ BBFILE_PRIORITY_xenomai = "6"
 LAYERSERIES_COMPAT_xenomai = "next"
 
 LAYERDIR_xenomai = "${LAYERDIR}"
+LAYERDIR_xenomai[vardepvalue] = "xenomai"
-- 
2.43.0

