Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642468;
	b=FVkZiuSHIHA85OyO29DBBM6pYEnaGzHn17x9efveY3uK3u6FuOBWezfamz5Z12kX33A8
	 kkxkStOzd8YXqw29vmOxWaB0miu4gM1IHW6ykNcZRh1o0f9+XPrE78ZaE/ZbqsPYJlCK9
	 SYKRi817gtqhgbYSudn3DUF1rDxNmGM9dxxemcGgUlPsXtTGiKgCes5vJjQrTm12E9/Yq
	 KrN7hBuZqNFVPyLd7wmOKdW77TFA2JNzPe8uoBmXuYUHHu4s9nNqd/v+FwZsR+3yiaoFe
	 nNOhjhA2hoBNMC3dLh7inAiLWKgMfASo0MG5mqGA+LsJtMg7H42rPqpOrHY17IxUH6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642468;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Zrm2/rmJwl7kk76L5w/CSYJJGo4V7K16nnpYNQDbyqE=;
	b=Pyds3MPLydFTLtfSt+66vyjz5kp0DAO863w6K8vvGCL7l9lTDxEp8TlLXoMstvhuUto5
	 f3BvlHv1I+7Q6LfG1g1zWDrQRQRM7ptT2g/iFFLRiHh+KxvZjv0Z9hrziiAHQTnUBU73a
	 +WVR0cLgU0u26GwZeCzWPdiuLhdpavJ+LJ/aJ/U4od4iwY9xQmT3echa0VYzofRiuGss6
	 E9Rj25G2LVtPrncxda1HSZLcz7Fx6Ums23V0+anw1bGxe/yKRnAi119cZcCNtTnzJn+uw
	 FPk6rqmhuhsnTFAQkujwYhsvMR3KmlJ/BdWgF50n6TBIFW/yfmI/XtObRdKGOMNFQxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gHWwwQ/J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A79606A321
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHWwwQ/J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626E61F000CF;
	Wed, 25 Nov 2026 21:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642467;
	bh=Zrm2/rmJwl7kk76L5w/CSYJJGo4V7K16nnpYNQDbyqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gHWwwQ/J9Qyx/t+XrVVMvFPUHaAL8xK2lBN3+5R1ZGmVEgfBu8DhbPgWkt6hrQOuO
	 nuNbZNGa7bmPiFBTLHPucMq7F1RLslwqMaw0RXbscexut48ZW1i+JEQwbFCHUTwtbE
	 loRGIzVr/joN7dXhJiP8sOlpeiLXgpXajNDcwaiTX716bcXatt8DHoK8xhzl9x/fbM
	 fYZyPOUtieRKuLnPOl0FeSu1N6yg39WHEIxKwjdjyo6pIx/L7M0WJDwa1Mx4RutMaL
	 3gHyMnDMv/EJnsMHHEDWNQ6WpkczC7gd+LGZ049yu8Ltt94+kw+YI1fw/E0T1X5ath
	 swsD+ypqp1KKg==
From: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/7] lib/alchemy/mutex: Allow any Xenomai thread to acquire a mutex
Date: Wed, 25 Nov 2026 22:34:13 +0100
Message-ID: <20261125213419.2363742-2-rw@kernel.org>
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

rt_mutex_acquire_timed() returns -EPERM unless the caller is an
Alchemy task, although the lock is a plain POSIX mutex. The Alchemy
TCB is only used to record the owner for rt_mutex_inquire().

Only reject asynchronous contexts and report NO_ALCHEMY_TASK as owner
for non-Alchemy callers.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/alchemy/mutex.h |  3 ++-
 lib/alchemy/mutex.c     | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/alchemy/mutex.h b/include/alchemy/mutex.h
index 2c4212f33..ef391a294 100644
--- a/include/alchemy/mutex.h
+++ b/include/alchemy/mutex.h
@@ -42,7 +42,8 @@ typedef struct RT_MUTEX RT_MUTEX;
  */
 struct RT_MUTEX_INFO {
 	/**
-	 * Current mutex owner, or NO_ALCHEMY_TASK if unlocked. This
+	 * Current mutex owner, or NO_ALCHEMY_TASK if unlocked or
+	 * owned by a thread which is not an Alchemy task. This
 	 * information is in essence transient, and may not be valid
 	 * anymore once used by the caller.
 	 */
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 6bec2d9bb..9609f1fa5 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -285,8 +285,13 @@ out:
  * waiting on it. In such event, @a mutex is no more valid upon return
  * of this service.
  *
- * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * - -EPERM is returned if this service was called from an
+ * asynchronous context, or over Cobalt, from a thread which is not a
+ * Cobalt thread (i.e. a regular POSIX thread which was not shadowed).
+ *
+ * @note Any Xenomai thread may acquire an Alchemy mutex, including a
+ * Cobalt POSIX thread. However, only Alchemy tasks are reported as
+ * the current owner by rt_mutex_inquire().
  *
  * @apitags{xthread-only, switch-primary}
  *
@@ -303,11 +308,12 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
 	struct timespec ts;
 	int ret = 0;
 
-	/* This must be an alchemy task. */
-	current = alchemy_task_current();
-	if (current == NULL)
+	if (threadobj_irq_p())
 		return -EPERM;
 
+	/* May be NULL if the caller is not an Alchemy task. */
+	current = alchemy_task_current();
+
 	/*
 	 * Try the fast path first. Note that we don't need any
 	 * protected section here: the caller should have provided for
@@ -362,7 +368,8 @@ done:
 		ret = -EWOULDBLOCK;
 		break;
 	case 0:
-		mcb->owner.handle = mainheap_ref(current, uintptr_t);
+		mcb->owner.handle = current ?
+			mainheap_ref(current, uintptr_t) : NO_ALCHEMY_TASK.handle;
 	}
 
 	return ret;
-- 
2.55.0

