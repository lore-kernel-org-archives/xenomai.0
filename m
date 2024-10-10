Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711F1BDA84
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599452; cv=none; b=efEWc/Ck6IJQhzUCqkEY5YxUrIDGJ7XZyaVOGX0jaSCfGw+rXvWdIi6F6/CqsN5I0qLIyVwTCvL9bsokz6eIcTEW5i3jdJ0NIK0uRHV5T1uah4uc0OdKdc9iApVwQgb7BbrirXbBzqhlXtmoXO4UmcJ41TiJv2y7ylRWR7ifC3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599452; c=relaxed/simple;
	bh=IZ6kXXN7ete1lIVDV4grJNbETK+j7IBIwI/87Zkak/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNBUGs+8M1etQxazWCrKJ7e5eGBmNpBMtykqmkiNDwhDEXys4/sLRuQbrUaCXBMJKHkp9jqelb5b+6f6M0Stwev02PPzhuGm61TK2Gk7sjBdrvc8kPKFWuXa04aQNe3XsUhyT26u7L0rrRH/zj8G2tOHSkouUYP19Q3ZoEHneD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IU7uxOIC; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IU7uxOIC"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241010223045e1e558c9b6df76868e
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 00:30:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=11NlSVTFlRIqt1mmuykTTufxvi2npXV9q4h739z5elQ=;
 b=IU7uxOICPEFdRVFfdl0ANASmx5UDuEt9GZPB/bKBOiUzqpINuKUxwHNprG1FNQPLvqivoS
 lv0QqEu4Z04cbkSEod9yJsNAL5vVilSp4IuEC9cYSh4AeTIwf42zJHn1euojWZ1/y17sB+fJ
 mYU4L8dlXa2vvBgT4EsGCWwMCRd+q8MeTGACKWmBb/L6fD1vn6q4GOvoC5O+iXGOpECRnal2
 kIGfBLa3jjrHFzeI15tbDru901Jxa/MJS/4Fu2fHGWavRDDvXPs/WAcKW8pNfPlpWNzLq4RD
 2PCW1MW6nBWbAcfcvRlbv5xxMBnoWLHsobVIUGJviK0TuvQb9LfkzhIg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 00:30:45 +0200
Subject: [PATCH v2 1/4] y2038: lib/cobalt: select: Fix compile failure
 observed on Debian 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-flo-cleanup-y2038-v2-1-0ef0d52cf9c1@siemens.com>
References: <20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kisza <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The following build failure was detected on Debian sid/trixie:

select.c: In function ‘do_select’:
select.c:55:23: error: implicit declaration of function ‘__real___select64’; did you mean ‘__real_select’? [-Wimplicit-function-declaration]
   55 |                 err = __STD(__select64(__nfds, __readfds, __writefds,
      |                       ^~~~~

The problem here is now the changed behavior of the __USE_TIME_BITS64
macro. Up to glibc 2.39 this was only set/defined when building a
compat application. So when time_t was "upgraded" from 4 to 8 bytes.

From glibc 2.40 onwards this macro will always be defined when time_t
is 8 bytes. So we basically run into the different code paths when
building 64 bit applications.

__select64() is only provided by glibc for 32 bit targets. 64 bit
variants don't have this function/symbol. We need to check upfront
if the symbol exists. If so use it, otherwise fall back to select().
This is the fix for the time64_t world.

For the compat case we were missing the proper prototype produced
by COBALT_DECL_TIME64. The macro has been updated to address this
issue.

Nice side effect: Should increase the support of libc implementations
where time_t is always 8 bytes, like musl.

The glibc commit that changed the behavior can be found at [1].

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a4ed0471d71739928a0d0fa3258b3ff3b158e9b9;hp=a0698a5e92ceeed3409d28623b1d599da6bc887d

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 configure.ac              | 3 ++-
 include/cobalt/wrappers.h | 1 +
 lib/cobalt/select.c       | 7 ++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index aa3794a5f..2a9d49973 100644
--- a/configure.ac
+++ b/configure.ac
@@ -570,7 +570,8 @@ AC_CHECK_FUNCS([pthread_mutexattr_setprotocol	\
 		clock_nanosleep			\
 		shm_open			\
 		shm_unlink			\
-		backtrace])
+		backtrace			\
+		__select64])
 LIBS="$save_LIBS"
 
 save_CPPFLAGS="$CPPFLAGS"
diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index 4fcb1c3b9..b6416ce63 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -38,6 +38,7 @@
 		__attribute__((alias("__cobalt_" __stringify(FN)), weak));     \
 	COBALT_IMPL(T, FN, I)
 #define COBALT_DECL_TIME64(T, FN, A, I)                                        \
+	__typeof__(T) __STD(A) I;                                              \
 	extern T __REDIRECT_NTH(__STD(FN), I, __real_##A);                     \
 	COBALT_DECL(T, FN, I)
 #else
diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
index 9577fa256..ca81bd36f 100644
--- a/lib/cobalt/select.c
+++ b/lib/cobalt/select.c
@@ -27,6 +27,7 @@
  * There is no y2038 safe syscall for select() itself, but we have pselect()
  * without signal support.
  */
+
 static inline int do_select(int __nfds, fd_set *__restrict __readfds,
 			      fd_set *__restrict __writefds,
 			      fd_set *__restrict __exceptfds,
@@ -52,9 +53,13 @@ static inline int do_select(int __nfds, fd_set *__restrict __readfds,
 	pthread_setcanceltype(oldtype, NULL);
 
 	if (err == -EADV || err == -EPERM || err == -ENOSYS)
+#ifdef HAVE___SELECT64
 		err = __STD(__select64(__nfds, __readfds, __writefds,
 				       __exceptfds, __timeout));
-
+#else
+		err = __STD(select(__nfds, __readfds, __writefds, __exceptfds,
+				   __timeout));
+#endif
 	if (err >= 0)
 		return err;
 

-- 
2.39.5

