Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3838F63C
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444307; cv=none; b=TwFb68LwEqjN4O0hwbn8MqOAbRkHWQlDS8rj0a7frfQxAyzYn/8+zSphYdXi1pJAn5KLvxnd5k3cDvs+kdoD1n0eX/t9Bt5vgX53ozm/RpG4C1UKBwe0X9K7N4L6wlFjVfP5VSnfqWchiVKqAUaUne+MrfRoGSBWY6CMYbJrEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444307; c=relaxed/simple;
	bh=OAxcj33NXwxHxGi/YswAFcDoQR00e4WCxr1cL7ctPd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cuuan0RqJFKk00aQVP4jEA14hP6ktmdWXFUygDAplMhJCJNp5Dfwj05vUfXgdkylTMV0NZcePkFMEB8n+hNtQhjDJNqWneNbpS7K4U2vfvJ3ZbtidyuYkAHrGwyrNnvnSGXVsVa5GVorx8AoqczStl3TJUVNTJpfbVOjtWTNsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=evnS+1we; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="evnS+1we"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260302093809cb87cae8e4000207ca
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+m8amyuZNIa+Usx75hz+uZZ9fmDwgh7kLVo4qqyrDD4=;
 b=evnS+1weqM1D/NajlHD4KuDlOuiAe4Sn+iYu4RWpMuuc5Fm3ticRJR1/EhKpyFMS/mWn69
 C4ZN1KZRSp1jBZDRl8hF0GhuHocq0o1WCTzT1TXSckASt/1m1l5tGAYOc2GKJAZY9hzAuBvy
 /5pMWlqXEEecRkWTx4KgDD6rWJAWPX02FR+bLoMg+Xuy2+sXtHJVZiYsYvlraJER27HtEhGA
 EYjvPmz30Dt0hkp1TsTOhh6DngIk8gl9RAXVOmrRiyE/sk2/xXlWqHU9AU4Gcq7JoVjPAdQR
 MBeDXz2+Ej01UEmHjW8tAUoOO9uacQg/+dWk7vb7qRmyLt5wYmRATxjA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:09 +0100
Subject: [PATCH v2 10/20] lib/cobalt: mutex: Provide time64 variant of
 pthread_timedmutex_lock_interruptible_np
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-10-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
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
index 25581fd6f0b2b0405d575435a0ba81c397244aad..404e0c63f8a1241b5a34ad663e5ac020dcf0b44a 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -674,8 +674,16 @@ COBALT_IMPL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlock64,
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

