Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642470;
	b=OJeKE9iL/DvIWW3huBK7S9u5ooY1NyMvp7Y7oX/s0JHKOYrgfCxZZG1BqXByQYEvHkQp
	 r0qPrW4NGTVlh9AWD445LLNiWAplcClQ324QfLEId6guJxOjJkP/l1j6lNSCx7a11beKk
	 jYMxTza3FoBSV3DOqQ5yLbb7FiVcleSsfy5YeT9j+CeCU4Xxv4KguFRvi+nkZCwU+00k9
	 LJIZ41zfqanUYCmF4d0fl4RJdVUJ5rIGO7UuXT42fhBw30sr8Qq0aKjZF9hmufGs+Hjpn
	 6u7XoayRe/HU/9nX2LPLlyzEU2GpqGflnQJJMESHcSQ4Rz68devK5QzG7TQwbZmzBJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VGvoElqVVsjOj3DlVCTBZOD/bitN87Xf+m8WG19i9Io=;
	b=5Wo5Fpcn8Yw7AP8jFpSg+0ElL/+GyvjCjesr7Y9+4NBxzSSc/qJOSzia7OpLTBLg9/gP
	 o+absCtCQRAhmemL1H8MTgHsZ73eYRTUKAV4F4Gv7ETsmWI0vE2M194FZns0xaHmy/wko
	 qbo/Y3yVFZS4q53EsH7Q2AWb8Mxaj5arcnHXNpkc8Pe4h1IqhyR7QnYFFTz21LbqPbWjH
	 elU9SAYJMcSnZFzFrUv50onGygrohqXWXlMTXC8nb1ovE+EuMhnnqNmRnc/dMF2DiDI+e
	 IavLWb+vVM2z4TrzeakFE8TAzyRT0fdtptAW/cWQzHsTtY7uKOQxIVPPs73qFsC4DjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvqw8xSv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B14606A31E
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvqw8xSv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8746A1F000CF;
	Wed, 25 Nov 2026 21:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642469;
	bh=VGvoElqVVsjOj3DlVCTBZOD/bitN87Xf+m8WG19i9Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fvqw8xSvQ7KDzkaktmCRw1dXmGUlvKGSb5/l/XHM+cE644KNlhY2fCwq4282YLaXc
	 ow/6mvDwx6G8bIaEs2B0vHXYg0u/BfQAKmmdHeJQKE4ryx9G/PBu4NmxhCXUGOBDhZ
	 FhaER59/kpH4uh/nQ+8hRzfinmrKS2auy24qoC4oDvxy0jYPnMyshAgAGwu6RjFImF
	 G2HuaYom1MVogaoqVfoZskIm7ht517p3KG0Gjf2UWCVPgvxx86J1YsDhgQXAFAeH+z
	 my7m+41t2MrWVgXimpOE3DH29qllGmOoRAuD1ojmtsdVWCG3R0YloWR8/Ep/hOowFB
	 M1oO/zLbGoEyA==
From: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/7] lib/alchemy/task: Allow rt_task_yield() from any thread
Date: Wed, 25 Nov 2026 22:34:14 +0100
Message-ID: <20261125213419.2363742-3-rw@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125213419.2363742-1-rw@kernel.org>
References: <20261125213419.2363742-1-rw@kernel.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

threadobj_yield() is a plain sched_yield(), there is no need to
require a Copperplate thread. Only reject asynchronous contexts.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 lib/alchemy/task.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index 73844d34a..dcb3de42c 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -1309,14 +1309,14 @@ out:
  *
  * @return Zero is returned upon success. Otherwise:
  *
- * - -EPERM is returned if this service was called from an invalid
- * context.
+ * - -EPERM is returned if this service was called from an
+ * asynchronous context.
  *
- * @apitags{xthread-only, switch-primary}
+ * @apitags{thread-unrestricted, switch-primary}
  */
 int rt_task_yield(void)
 {
-	if (!threadobj_current_p())
+	if (threadobj_irq_p())
 		return -EPERM;
 
 	threadobj_yield();
-- 
2.55.0

