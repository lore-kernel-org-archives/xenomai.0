Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642476;
	b=gWziIpvTy3Em9eg6lz6zEir1f4iVMXaafMexjes+sis2FVo5evivIrCs8wx17CSJSJWG
	 wjSk1Cl1dpuxs+l4ueAN6tEyLZvCfI4eKqUGP0e/haKCix3gYfkFcF84/mJG/yfZLIyUP
	 tqxB+3m8bxWzgW7PZl9ADwS2QLOdue8OxcSxcPEHINDEUUJbNeCG3gH9wyjCT+ZeBrzuQ
	 7L2fRn7dL7HhAmmOD/B4EkJVxzAxNaW/lfW8j/nHPVCeGYjS6Nh7A7CkPhkPimmWW6Nk9
	 6S+l1H2R5ckVgX0391E6UjY12QwqT39w+SI+ZSEsAPutLgkCOMkIAZsJrS2v4K/Wu0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642476;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lByh1otLEtdYMnk5j6ky3ViUYZE/edglwzyJ6UQ2sAM=;
	b=aB/Qeonq/sWGgvP58RJDp32kH+09oW76AsT4V/3JLTjyfsLx5x5mXI4Mt3XPJ8vtojCD
	 OSns62pH2MYqufcEOpdz49MFN6n0nqZuCFg4+sVebuKqNwGRlHY4CwKKNVPxVPe4J1Nnf
	 QCh/uhTa2kQloOFIqi1agLq+5R487tVXdmy3l+Ocg0yf6av3cfpQxPAPukA/hJlFEHesR
	 cMbuqNtbQ7W+kdtJSRpcrQtJ9ZGUmF6oUIEDz4WmN4AONAv9BzKFPwEr1Pjqs63fXm2e5
	 v+VeNQoo22OnlFMk7VOMBtb9neigKsWUC7oFbAevUIQ29wLCFqWEnOcKELPPsjLj6Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l091JT/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B59F606A32C
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l091JT/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A061F000C4;
	Wed, 25 Nov 2026 21:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642475;
	bh=lByh1otLEtdYMnk5j6ky3ViUYZE/edglwzyJ6UQ2sAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l091JT/G4htSkfNOmoufQZvyPH1deEB3KaIQSd2nXxRMQ2x0L68O/aQpPl1GDPTZi
	 +KZU9gpdUDPvfq/ch3/T4D/ldMyFkUc29jiCh8rWGIvEwHMfiE/wA8uHc0UO9P4Qch
	 a3yd2D82480zuGD0LPIubYCq8CBrN5QWgkXoNbEjqVJi2hmeZg/dlxmSV13yQN+Odk
	 r3BKCsf7OaBiZ36APMBi1wj3XkOjWKlDVwhqtFZONyFWWApX2V7sAB5MT+E1qVFPhp
	 pCv11D0dk5LaWBVJgiqRGdTuXi7zrQhKrV0DRrr8g3MvakwRb80eiyrcgtWuaUr36x
	 usM2QGLsURHUw==
From: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/7] lib/alchemy/event: Require a Xenomai task only for waiting over Mercury
Date: Wed, 25 Nov 2026 22:34:17 +0100
Message-ID: <20261125213419.2363742-6-rw@kernel.org>
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

Over Cobalt, rt_event_wait*() is based on a Cobalt event which any
Cobalt thread may wait for. Only the Mercury implementation needs a
Copperplate TCB, and only when actually waiting. Move the check there
and keep rejecting blocking calls from asynchronous contexts.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 lib/alchemy/event.c        | 10 +++++-----
 lib/copperplate/eventobj.c |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/alchemy/event.c b/lib/alchemy/event.c
index 8428db539..c08b224c7 100644
--- a/lib/alchemy/event.c
+++ b/lib/alchemy/event.c
@@ -378,10 +378,10 @@ out:
  * sleeping on it. In such a case, @a event is no more valid upon
  * return of this service.
  *
- * - -EPERM is returned if this service was not called from a Xenomai
- * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }. Over
- * Cobalt, this error is also returned if the caller is not a Xenomai
- * thread.
+ * - -EPERM is returned if this service should block, but was called
+ * from an asynchronous context, or over Mercury not from a Xenomai
+ * task. Over Cobalt, this error is also returned if the caller is not
+ * a Xenomai thread.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -393,7 +393,7 @@ int rt_event_wait_timed(RT_EVENT *event,
 	struct alchemy_event *evcb;
 	struct service svc;
 
-	if (!threadobj_current_p() && !alchemy_poll_mode(abs_timeout))
+	if (threadobj_irq_p() && !alchemy_poll_mode(abs_timeout))
 		return -EPERM;
 
 	if (mode & ~EVOBJ_ANY)
diff --git a/lib/copperplate/eventobj.c b/lib/copperplate/eventobj.c
index 28b7c167f..c5a726a89 100644
--- a/lib/copperplate/eventobj.c
+++ b/lib/copperplate/eventobj.c
@@ -229,6 +229,11 @@ int eventobj_wait(struct eventobj *evobj,
 		goto done;
 	}
 
+	if (!threadobj_current_p()) {
+		ret = -EPERM;
+		goto done;
+	}
+
 	wait = threadobj_prepare_wait(struct eventobj_wait_struct);
 	wait->value = bits;
 	wait->mode = mode;
-- 
2.55.0

