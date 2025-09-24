Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A8128725A
	for <xenomai@lists.linux.dev>; Wed, 24 Sep 2025 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749036; cv=none; b=LacL0AcaqKz11mEOGPkVZGGA94KXbzghMRkYZLe3Elutq0krB5LovP1f/ESr1W00g3j9T96BqpLIaXtElS/nj0Sd3Ynxk5GUPqS4PkhAAjRl8AV2u5PLXKVecxgOXLQBEWYHMSx1astG7wVILd6gcS0oaKYq5LeNH48by3Eoy/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749036; c=relaxed/simple;
	bh=Jc7dKs/x7NBocPemDk1rXuLF4URIXgJdj7lGIIhW8vI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UP6Y1uME6+EtCPt4Gq/ZO+GDiwVVvHfsY03RTS3VqNRfInhvtvavE2CRZk95MwKt5hI45JNvU1/1SFeyq2E+lzv7eGyjZwWntP2ZlS9kIZhkphC4zYdnZUysxuVjsCgRbVOvmyr+aQ5/z6E9Y2uhPWitkkLPiSTZU1bh3g5idLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LhTTJsbN; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LhTTJsbN"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250924212344a2bbad84710002076d
        for <xenomai@lists.linux.dev>;
        Wed, 24 Sep 2025 23:23:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0HNJKsxvvoZP6z8GRxC2YnW8V7bww3dbG1EiYiDZgVU=;
 b=LhTTJsbNf3UK6XLAjewGgwr4/M3Fc1o2Md2PhkWmQM2oNyP1GVW3KS1I1ONJhtlIiI0Nu3
 0rVQgwml0zTXFDsiqMh1FTf8kQj68G+gSja5x3oKTDFxdFE4c+aweiTyEWEIJ3wt8bR8Vgxy
 cO6tfEZWWNrYq/bpUOfMsJxVSab67VrM0DGdtTlofXk2RjuSKUwVUk1DV23m8/KWTV9z9Cov
 qgXRa+rpq3hkuYQhhHL/NDrLG1GxfRigOtiE7epTw5Wbt6RQwp+wTmjBd/OV4plgZhF5jy5J
 0ztiwjQNQxHuUDFIu4MKu9HZgBCDCCGoYnB8xQE7Im7QNOrnOKjVwEwg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 24 Sep 2025 23:23:14 +0200
Subject: [PATCH RFC Dovetail 6.16 1/2] locking: irq_pipeline: Rename
 MUTABLE_SPINLOCK to HYBRID_SPINLOCK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-wip-flo-fix-lockdep-warning-for-6-16-v1-1-8a8475e2cdc0@siemens.com>
References: <20250924-wip-flo-fix-lockdep-warning-for-6-16-v1-0-8a8475e2cdc0@siemens.com>
In-Reply-To: <20250924-wip-flo-fix-lockdep-warning-for-6-16-v1-0-8a8475e2cdc0@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Preparation for the upcoming user in kernel/irq/manage.c
No other users yet.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/linux/spinlock_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 8c77fd34491fb..fa79cc084ec57 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -172,11 +172,11 @@ typedef struct hard_spinlock {
 	struct phony_lockdep_map dep_map;
 } hard_spinlock_t;
 
-#define DEFINE_MUTABLE_SPINLOCK(x)	hybrid_spinlock_t x = {	\
+#define DEFINE_HYBRID_SPINLOCK(x)	hybrid_spinlock_t x = {	\
 		.rlock = __RAW_SPIN_LOCK_UNLOCKED(x),			\
 	}
 
-#define DECLARE_MUTABLE_SPINLOCK(x)	hybrid_spinlock_t x
+#define DECLARE_HYBRID_SPINLOCK(x)	hybrid_spinlock_t x
 
 typedef struct hybrid_spinlock {
 	/* XXX: offset_of(struct hybrid_spinlock, rlock) == 0 */
@@ -207,9 +207,9 @@ typedef raw_spinlock_t hybrid_spinlock_t;
 
 #define DECLARE_HARD_SPINLOCK(x)	raw_spinlock_t x
 
-#define DEFINE_MUTABLE_SPINLOCK(x)	DEFINE_RAW_SPINLOCK(x)
+#define DEFINE_HYBRID_SPINLOCK(x)	DEFINE_RAW_SPINLOCK(x)
 
-#define DECLARE_MUTABLE_SPINLOCK(x)	raw_spinlock_t x
+#define DECLARE_HYBRID_SPINLOCK(x)	raw_spinlock_t x
 
 #define __RAWLOCK(x) (x)
 

-- 
2.39.5

