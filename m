Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3DE27A462
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771232234; cv=none; b=T8pKFYKKNqd1OZzGZihQLb3AqTJ95MwzirMTtkGm0hy2VKDntWrJvAmzu/stGIb4Ju90x4SpbXb1oYLnciY3biNiNTv2nUZXRJMMvivRBrGWPayx3W5DzMMdVg79q/DduPj8H52VxKpx/ShnE2FV0DCg6deuo1M5+mCrzzaeFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771232234; c=relaxed/simple;
	bh=62GKLq4R64MxbPQkTrAehCUDof6w28CmBUhnoE7H5oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6Qe46CEGwwEvZGEA/XRZDV9AezfVx0PmfvbE7GAxFb7MmhMyqJoRGftFO1Rao1yQ8nk2ktNNxpy7KH49fo3PjqCfJ9QO/ZysIc3E4jEtDhctnvQuKyhrjPStYt6h7PoGKf+EKxz+uA6Vwcxb9SO4HwT38W8Bvoqb6b0QClL52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=fIpvh72I; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="fIpvh72I"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260216081645cdd7fadd2100020759
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 09:16:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AuZUn/iz0gAWMAiFl1OCqAJJM5CQySO/06n2h252eio=;
 b=fIpvh72I1DpTsi3Acu4XDXbUqzAgIVkS09TReXUa3HIGi7Sh7273wCtFAuSZbY22q8t1FK
 GLARTKLXUteCYN+IAdCrNpGkQH7GkzKkINJ53f9bFhaifCq7GzIeK4d9SfsV2HJ3Zt+QKvTe
 FETpYBW7epKNL0gf3vsyaVV6XNqVRoFWcYULphrwa2JkiDzOCFhvXm9LWw4tIDgLsEi4amyM
 i8E4ImLYN9t3TKozrW7NQ5f6rEAiZ9KUXfPgO4Sq8XgMJTo0wBSsjZvF7wMqp9Tl5nZrDSR/
 ngS4EHuZtmFVwmvpvRGAAJxgDl8+q9QOlm9/Gj2+iSC2QpsY+gZDV5kA==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v3 2/2] ci(libevl): Trigger more kernel combinations
Date: Mon, 16 Feb 2026 09:16:29 +0100
Message-ID: <20260216081629.3163713-2-clara.kowalsky@siemens.com>
In-Reply-To: <20260216081629.3163713-1-clara.kowalsky@siemens.com>
References: <20260216081629.3163713-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

The libevl next branch triggers a pipeline in xenomai-images in
combination with all available kernels (6.1, 6.12 and head). The
physical targets are built for all kernels, the QEMU targets just for
the head.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/trigger/libevl.yml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
index bbd4e13..ece5f06 100644
--- a/ci/trigger/libevl.yml
+++ b/ci/trigger/libevl.yml
@@ -18,9 +18,7 @@ stages:
 trigger-xenomai-images:
   stage: trigger_xenomai_images
   variables:
-    ONLY_RUN: xenomai-4/evl
-    KERNEL_VERSION: head
-    KERNEL_VERSION_WITH_QEMU: head
+    ONLY_RUN: xenomai-4/${CI_COMMIT_BRANCH}
   trigger:
     project: xenomai/xenomai-images
     branch: next
-- 
2.52.0

