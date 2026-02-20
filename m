Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C831B101
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578540; cv=none; b=ZqQOosBg6HsyVbsNkIlseQVrHux6uRQEaZFvkticv+1UC6/4LJQXx6farx6tFV5cKhifIInJXJ9bImeIPDhGc91BiEdbQzBqr7mAH0jX8yPUJwCFmYYRZlnxFLlvoXonYd4xOVZZWDbZVnY+zMVS8pmyrSoWx13j9RRX7pIFG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578540; c=relaxed/simple;
	bh=TgnN5LSjzuG5Eozk3zyGmtt4q8F6+yuFMXrS585ISWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SeXFKZEtF+X6mDgY2TZ+3/jArpywhQECzeOWq54Sk3Y2KzeYGaNV2N/Jri7f/ogFjidAQ426yDGV6XbY6rs5qq6mcyzxtwSzIrcEjew6WLLsDblKhfCwcKrjidzVVC35lccXaslunBhVyzLbhdAyq+5HkIZwOeSe0T+C83oM8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=MmBuNlEo; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="MmBuNlEo"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202602200908475de91be778000207bc
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ta1594oCMjMLb/ma88Cz8U60TlBnVJ0sVG8+G6B2HZg=;
 b=MmBuNlEoU1VMI5ZHnVjYL7VEKJIPTXrS1Z58/93d52AbP9WnQkaTGi6IDo//+Utn05M2wV
 p6vAVlcXAv//KpyEgpmObROJBC+tZ7+DJA99+WBUcDjEoW5Vedn9c3d79KSIaqd6CUtJfIgT
 FhWgOuLv6ihdq/1jvdk4vqG5DWqm75Fh8ZM0DQL2VAFGbnBhsGbUEUWclGyzeZ3JCZGicYJK
 1HYNW18+SjMVXHQLxusku/oDqy/dR81lsxMPNocoD93z95iusjMon2clW0ksKRbKv5I8DVFV
 UjtsnJqAZL2VyFMosMA0WxkcLzmxwuvpg6qanokPnElQBKbcJyiNbZCQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:53 +0100
Subject: [PATCH 10/20] lib/cobalt: mutex: Provide time64 variant of
 pthread_timedmutex_lock_interruptible_np
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-10-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

That service / function was forgotten when introducing the time64_t
services. This is a non-posix / non portable (np) mutex function, so
not marked with COBALT_{IMPL,DECL}_TIME64() as no wrapping is taking
place.

Provide a time64_t variant in case time64_t support has been requested.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/pthread.h     | 16 +++++++++++++++-
 lib/cobalt/wrappers_time64.c |  8 ++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
index fed7dd2d8ecee155cd58d2d07cbd6077b6c7612a..b6a6d7a58b0fb44abcdb11e9666b78a9e6b48667 100644
--- a/include/cobalt/pthread.h
+++ b/include/cobalt/pthread.h
@@ -173,7 +173,21 @@ int pthread_attr_setpersonality_ex(pthread_attr_ex_t *attr_ex,
 
 int pthread_mutex_lock_interruptible_np(pthread_mutex_t *mutex);
 
-int pthread_timedmutex_lock_interruptible_np(pthread_mutex_t *mutex, const struct timespec *to);
+int pthread_timedmutex_lock_interruptible_np(pthread_mutex_t *mutex,
+					     const struct timespec *to);
+
+#if __USE_TIME_BITS64 && __TIMESIZE == 32
+int pthread_timedmutex_lock_interruptible_np_time64(pthread_mutex_t *mutex,
+						    const struct timespec *to);
+#ifdef __REDIRECT
+int __REDIRECT(pthread_timedmutex_lock_interruptible_np,
+	       (pthread_mutex_t * mutex, const struct timespec *to),
+	       pthread_timedmutex_lock_interruptible_np_time64);
+#else
+#define pthread_timedmutex_lock_interruptible_np                               \
+	pthread_timedmutex_lock_interruptible_np_time64
+#endif
+#endif
 
 #ifdef __cplusplus
 }
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index 8f37e310eb19f783199681fc167883b72ebdfa1f..fbd644bef485b4ec9d319373ffa702bc1927a75d 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -667,8 +667,16 @@ COBALT_IMPL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlock64,
 	return ret;
 }
 
+#if __USE_TIME_BITS64 && __TIMESIZE == 32
+int pthread_timedmutex_lock_interruptible_np_time64(pthread_mutex_t *mutex,
+						    const struct timespec *to)
+{
+	return __pthread_mutex_timedlock(mutex, to);
+}
+#else
 int pthread_timedmutex_lock_interruptible_np(pthread_mutex_t *mutex,
 					     const struct timespec *to)
 {
 	return __pthread_mutex_timedlock(mutex, to);
 }
+#endif

-- 
2.53.0

