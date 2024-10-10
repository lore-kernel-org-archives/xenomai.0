Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226E41E2839
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598495; cv=none; b=RNeKFxzRZD0UHnX0BLbIHsHA09N1AUMYfH7V4sxVjpJcvUtOLdBjdEOsiguoetvmWB2jJHX4ykTWTXRzzSFL8P6PQzJISqri71IJuT65YhsvtnMfvGGI+W5zQN+lBRw75Ed3V7YWQ0ljPOQAKxa23hkqFRbibSV5W17eRexUPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598495; c=relaxed/simple;
	bh=IZ6kXXN7ete1lIVDV4grJNbETK+j7IBIwI/87Zkak/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HWqhl8o7EphWv8amp5nWB+EKo4QcosiPXfQPT6l9UBt0z4WqUMklW3eegabuhCgz1WavtCkt2Ejbb+JmQwyA0DCmt4pPlvdlQBasJOM5YJ3HfDDA75UOeb9T23gWTLH5gzH1qDTilh6cqkJoFSbsijNonPF9fTj/NnuagFkncKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FUI3eR4A; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FUI3eR4A"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202410102214499e83e756319e1870ab
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 00:14:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=11NlSVTFlRIqt1mmuykTTufxvi2npXV9q4h739z5elQ=;
 b=FUI3eR4A6wcrizVSFI9ee1nGjgP2xM4Qip35pqJkYnk66hheVAxwEdhT2JyMXLijt54UKu
 GDF1SLSVymJZfutUstheaXNnXX8JcX06fxjmFJToBbQUVHMNh2mkIgoeSZ8HGEd8mVb9y5PF
 0kEiqrJxpf49FZ4D/eNXY/nUz3xwK8HNm+OPsM55sWVP++KUwPmnihATQVSMpnH/DsqFe1v7
 kjPGW8MC3CX90UVKOe1V5UIgR+RjX60LQW6zJrc9JOJobRcPI+/IV/wnJ9VK45ToBBjtT3jE
 0KH0fn0GSwZHIjsYirsBRIBUT9bxGLQ4a9nQzsymv9Lc66bV6x/4T0Gw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 00:14:48 +0200
Subject: [PATCH 1/3] y2038: lib/cobalt: select: Fix compile failure
 observed on Debian 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-flo-cleanup-y2038-v1-1-4b5b0078fa60@siemens.com>
References: <20241011-flo-cleanup-y2038-v1-0-4b5b0078fa60@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v1-0-4b5b0078fa60@siemens.com>
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

