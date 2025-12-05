Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4ED3254A8
	for <xenomai@lists.linux.dev>; Fri,  5 Dec 2025 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764931426; cv=none; b=SFDeN2c/VO7nQLCLNG7g+8wgGZnusPHOPc+jNOQ5E8UjzMuf2/yNhuolhqpJNAswtye/TuvhZ+HazNI3/erOSdPLnDAs/iO75G6wKhrtqh8aVfFLVWhnzh8JC4uDrOANkMLt7XkiCuEqnVR1AwYF2iWHiSemDzewhmnTm3TfSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764931426; c=relaxed/simple;
	bh=jvu2dFgTZIqr79SG5WjQoK6VwOc5NhQuOBRgO16GcMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ToHFGiJOmM/v0YE4D519JJZ6tvfaCJjx4Namd7FB4yAc6X0cplLlEjo4l57qOoXdMQhczVg+t5laXHwty0B5JAPWsxCAViSeyxNf4Ui1psm0XeFipOC76boj95u+y4j2gQhlKW6Bb+K+GCIUiO1rMiKde0TQPRlNp56NGjuOTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Ekehqmoo; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Ekehqmoo"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251205090313211cb8de7500020756
        for <xenomai@lists.linux.dev>;
        Fri, 05 Dec 2025 10:03:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F6ZmGNMfPtxPMogjXTXijt4Za6u/3BcdZM93DZRzW8U=;
 b=EkehqmooEQ6Ti5v3mbYSmkLehMMAiCxneEevgUjhKiLmhkM6vEu6n6QXoeBaY9h05XSooE
 j3L0lPidx3UC441gCyylnNtXICcIUVNhO7NJa3c6hLKs83lMcQSrE4TGvRKxfUvqOCIK2i3q
 eS3KXjomOmgJosm1bxgNoynwy4apyg5sfRsHj9kgUkOmiKG0iI/Zadnj0UK99EHByh0WU3p7
 9QG15ciSmZNB0MIwSkLhQJNW/xb26HHCh6dgbIYyuOnKols6R8fUjNe8stHado3iAexkc/7x
 OA2qE/HmBJnUKM4MX8kJY3DnJ3CGiSZrV7rbS/1twOnB1elwg85bUfyQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 Dec 2025 10:03:11 +0100
Subject: [PATCH 1/6] y2038: lib/cobalt: select: Normalize timeout value in
 the y2038 case
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-flo-fix-select-syscall-v1-1-7f9c545a63ce@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
In-Reply-To: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Andreas Ziegler <ziegler.andreas@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Andreas discovered a difference in the timeout value handling between
the native and compat + time64_t (= y2038 support) cases.

The time64_t based select() service is internally routed to the
pselect() service. Linux does a normalization step for the timeout
values of select() and so does cobalt. Both, Linux and cobalt skip this
step for the pselect() syscall. That means that we were missing one
normalization step for select() in the y2038 case.

Reported-by: Andreas Ziegler <ziegler.andreas@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/select.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
index be8cf34b2..611994d17 100644
--- a/lib/cobalt/select.c
+++ b/lib/cobalt/select.c
@@ -22,6 +22,10 @@
 #include <asm/xenomai/syscall.h>
 
 #if __USE_TIME_BITS64 && __TIMESIZE == 32
+
+#define USEC_PER_SEC	1000000L
+#define NSEC_PER_USEC	1000L
+
 /*
  * The time64 wrapper for select() is a little different:
  * There is no y2038 safe syscall for select() itself, but we have pselect()
@@ -36,8 +40,10 @@ static inline int do_select(int __nfds, fd_set *__restrict __readfds,
 	int err, oldtype;
 
 	if (__timeout) {
-		to.tv_sec = __timeout->tv_sec;
-		to.tv_nsec = __timeout->tv_usec * 1000;
+		to.tv_sec =
+			__timeout->tv_sec + (__timeout->tv_usec / USEC_PER_SEC);
+		to.tv_nsec =
+			(__timeout->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
 	}
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);

-- 
2.39.5

