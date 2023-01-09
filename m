Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D1733D6
	for <xenomai@lists.linux.dev>; Mon,  9 Jan 2023 16:26:17 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id hw16so9598845ejc.10
        for <xenomai@lists.linux.dev>; Mon, 09 Jan 2023 08:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXvJqRCrR/kmiH1/zkeHCiRftUPBafjE0SpebDHfX6A=;
        b=SRjuh9A89It+tr51+e9bHBv1Vzn+xssbe7NIGPKSgS2An81ATcZsibKKAOqws+fz13
         x3n12ntR9qi7dT24yL4ZH8jTJZd3ZbAIYI0xgyEBGqEt/eqtMJ+Ka66ebd4J+Laar47+
         zxkTsDFunDqVgsHRu/5LWBKEej6sbw2Iulrmyiv40TvnHyuYncdKpld6dkdcjpDSij+2
         MLIzIax/aSm1OdOR6gumis6c9z0V6NP6H9VhMXgCMezfKKeii88XmeMjybG5FY+23PxN
         sMwIMzbUbP//N16XhzIc7b+atFP+F2bazPqFH5bWu8ez6bYIC8AuZYepcmZgJHtek1Xe
         aNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXvJqRCrR/kmiH1/zkeHCiRftUPBafjE0SpebDHfX6A=;
        b=xwOhaHmzMdsIhiZP4YPDfIGoxghYOQbBQWi/wD3hfiubQgBSw6NqScdQ5MGsxJDzb9
         fxkYrjF9ZVmFeWKbcxyJ8Rg5zgtC0OWEG1BK0IPeb1J/tDvDBGshxs0FldsF9GkJFxBN
         S8QiqOKonNhnKJnymtIBAWBH4kF6MzweEbiDaoMFX/WIa4HmrN6tEzSjwNPibIA5kD/f
         HutK3Jc7tGGpZ61ZshYpWq+gOUtu0vd6+CG4ttZoHNquQDnJ2O640YLILNrWadxUr0SR
         o+c2c7XtqDh/6/qfqF+juIlgIcXjbBh6MXoM8xVS1OFnXCDt7NUHIv49zErl00BerZ0U
         2LNw==
X-Gm-Message-State: AFqh2krGNT0tlLIPo4BfAVARxDAw+LAhhS1Py+QQNBhwNQAg8/1yKQoL
	n6qvxcZ6UuasH39YkE+GjHdmGK0gy3ssAJ/AU1Q=
X-Google-Smtp-Source: AMrXdXtBzZFyv4c7ich6bVfrV7paPo/WNW/+aFPGwYV1B7LFmLFjW5C60jU/Qm3EeT3ILQynvtmb5g==
X-Received: by 2002:a17:907:4d6:b0:84d:3a95:cdf5 with SMTP id vz22-20020a17090704d600b0084d3a95cdf5mr4931233ejb.10.1673281575750;
        Mon, 09 Jan 2023 08:26:15 -0800 (PST)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id gn19-20020a1709070d1300b00816edcb4e59sm3922435ejc.146.2023.01.09.08.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 08:26:15 -0800 (PST)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH v2] Alchemy: Fix rt_task_unblock() for RT_MUTEX
Date: Mon,  9 Jan 2023 17:25:29 +0100
Message-Id: <20230109162528.26749-1-aaron@sigma-star.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220330201614.31083-1-richard@nod.at>
References: <20220330201614.31083-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

Starting with Xenomai 3, RT_MUTEX is based on libcobalt's pthread mutex
implementation.
POSIX requires that pthread_mutex_lock() shall not return EINTR,
this requirement breaks rt_task_unblock() if a RT_TASK blocks on
a RT_MUTEX.

To restore the functionality provide a new flag to __pthread_mutex_lock().
It can get interrupted and will return EINTR to the caller.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 include/cobalt/pthread.h |  2 ++
 lib/alchemy/mutex.c      |  4 ++++
 lib/cobalt/mutex.c       | 14 ++++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
index 0451f6704..2d645c5d9 100644
--- a/include/cobalt/pthread.h
+++ b/include/cobalt/pthread.h
@@ -174,6 +174,8 @@ int pthread_attr_getpersonality_ex(const pthread_attr_ex_t *attr_ex,
 int pthread_attr_setpersonality_ex(pthread_attr_ex_t *attr_ex,
 				   int personality);
 
+int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex);
+
 int pthread_mutex_gc_np(void);
 #ifdef __cplusplus
 }
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 3b27a04b5..45db692a7 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -399,7 +399,11 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
 
 	/* Slow path. */
 	if (abs_timeout == NULL) {
+#ifdef CONFIG_XENO_MERCURY
 		ret = -__RT(pthread_mutex_lock(&mcb->lock));
+#else
+		ret = -pthread_mutex_lock_eintr_np(&mcb->lock);
+#endif
 		goto done;
 	}
 
diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index 634be35d3..28d2557eb 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -411,7 +411,7 @@ COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex))
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
+static int __pthread_mutex_lock(pthread_mutex_t *mutex, bool want_eintr)
 {
 	struct cobalt_mutex_shadow *_mutex =
 		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
@@ -470,7 +470,7 @@ slow_path:
 
 	do
 		ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
-	while (ret == -EINTR);
+	while (ret == -EINTR && !want_eintr);
 
 	if (ret == 0)
 		_mutex->lockcnt = 1;
@@ -489,6 +489,16 @@ protect:
 	goto fast_path;
 }
 
+COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
+{
+	return __pthread_mutex_lock(mutex, false);
+}
+
+int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex)
+{
+	return __pthread_mutex_lock(mutex, true);
+}
+
 /**
  * Attempt, during a bounded time, to lock a mutex.
  *
-- 
2.26.2

