Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A08F66
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434679; cv=none; b=ezZItREIftF2kNkdnYmozTBrz4PhrkQI3jqSJjZbtAVGP6PbCrSOaPLJ67YOZMPL5AAr52NNMrOs4DOSwsr50nuqMNV/RjSpaUV+abNEb9ZxL+eEmRkawBD+7vwcMHyy6L/y3dGBJFgPpn5fmKaIRAU4/+WmVUsOpkhtNEhgT80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434679; c=relaxed/simple;
	bh=Vzqlf0staRfL2MC3KZqvREclv7UMWyYBNPvIo4JHFyA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zf2L3EspYSBwefsYZIM+7DnKIt+6ZN75VTFzwuArvk07Eu+oaOUCr9G9CnsxsrB7o3sho+gRA4GsmMvpDdUOXZ8zgjrP3zvlC4GitIpNn2RPR7vf3HVlRN1lT5bll5/aeC9veFN4fp5VAphqV3nnj3PKfXQ8RGeoEhh9NBNc3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=oqmhIvdO; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="oqmhIvdO"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202403260631063ac9ad911785e869db
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=TlMGkpU5qlkmwnZkvk6vwT7g7aa7WNCKe2L9qpTqWZk=;
 b=oqmhIvdOYOzEh8A+p+8t3PlaX2tceYY61sDFIZoWqQDMw7wRofqbCZbAMNMcAZh6tXfgNf
 GuC2YMt5rtK1r1ugx6lk5Rqft3N4WThC05zO+BL/kjhI2vrv21LACjjjtp4K5xZTijTdvR6z
 rMQmDb2q/j5ERYnxwzRi3wMCgFsbE=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 02/25] cobalt/synch: add [__cobalt_mutex_]lookup_lazy_pp prototype to header
Date: Tue, 26 Mar 2024 07:30:41 +0100
Message-Id: <5da61e1dabfdb123c40acd75d424972d4585d8ae.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
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

There is kind of a layering violation here between synch and
cobalt/mutex by the latter providing a helper to the former for priority
protection/ceiling. With kernel 6.8 getting picky about missing
prototypes for non-static functions, we need to resolve at least that
aspect. Therefore, establish a prototype in synch.h as it is not easily
possibly to include posix/mutex.h.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/synch.h | 2 ++
 kernel/cobalt/posix/mutex.c   | 2 +-
 kernel/cobalt/synch.c         | 4 +---
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/kernel/synch.h b/include/cobalt/kernel/synch.h
index a2bf80d175..8d6bd1d201 100644
--- a/include/cobalt/kernel/synch.h
+++ b/include/cobalt/kernel/synch.h
@@ -174,6 +174,8 @@ void xnsynch_requeue_sleeper(struct xnthread *thread);
 
 void xnsynch_forget_sleeper(struct xnthread *thread);
 
+struct xnsynch *__cobalt_mutex_lookup_lazy_pp(xnhandle_t handle);
+
 /** @} */
 
 #endif /* !_COBALT_KERNEL_SYNCH_H_ */
diff --git a/kernel/cobalt/posix/mutex.c b/kernel/cobalt/posix/mutex.c
index 65882081e7..c755b442f6 100644
--- a/kernel/cobalt/posix/mutex.c
+++ b/kernel/cobalt/posix/mutex.c
@@ -424,7 +424,7 @@ void cobalt_mutex_reclaim(struct cobalt_resnode *node, spl_t s)
 	xnfree(mutex);
 }
 
-struct xnsynch *lookup_lazy_pp(xnhandle_t handle)
+struct xnsynch *__cobalt_mutex_lookup_lazy_pp(xnhandle_t handle)
 {				/* nklock held, irqs off */
 	struct cobalt_mutex *mutex;
 
diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
index 6e50e537fa..70c05c1f49 100644
--- a/kernel/cobalt/synch.c
+++ b/kernel/cobalt/synch.c
@@ -37,8 +37,6 @@ static inline int get_ceiling_value(struct xnsynch *synch)
 	return *synch->ceiling_ref & PP_CEILING_MASK ?: 1;
 }
 
-struct xnsynch *lookup_lazy_pp(xnhandle_t handle);
-
 /**
  * @ingroup cobalt_core
  * @defgroup cobalt_core_synch Thread synchronization services
@@ -514,7 +512,7 @@ void xnsynch_commit_ceiling(struct xnthread *curr)  /* nklock held, irqs off */
 	atomic_t *lockp;
 
 	/* curr->u_window has to be valid, curr bears XNUSER. */
-	synch = lookup_lazy_pp(curr->u_window->pp_pending);
+	synch = __cobalt_mutex_lookup_lazy_pp(curr->u_window->pp_pending);
 	if (synch == NULL) {
 		/*
 		 * If pp_pending is a bad handle, don't panic but
-- 
2.35.3

