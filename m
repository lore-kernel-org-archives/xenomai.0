Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8092168AD
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 08:13:37 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023050808132912f2c82dd6a1b751a8
        for <xenomai@lists.linux.dev>;
        Mon, 08 May 2023 10:13:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8TQvUU3kgphQoI7TqZi4ZOl+JxVAqcCFutrejbPMRdI=;
 b=EM/MDxB5+tmNfimfoZfFnbbJQBZatqVlrZ2QY/DJa6uhfigyvuwW43pPZqOQiuBK61aQ4a
 5EjGR3ui6PQx8PKTY7nKKu51K4hghD82JMNDZv8S08MbVVO6kEuMV8aJEAItcXqjUEzsz4Fd
 MpOYG+tokDQ0Hdsz9MceRQ/5HC0+w=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 08 May 2023 10:13:31 +0200
Subject: [PATCH 09/13] y2038: lib/cobalt: Dispatch timerfd_settime
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v1-9-a417812fba85@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

If libc reports time64_t support, timerfd_settime is now dispatched to
the time64_t based syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/timerfd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/cobalt/timerfd.c b/lib/cobalt/timerfd.c
index 417e3aad1..a564d5076 100644
--- a/lib/cobalt/timerfd.c
+++ b/lib/cobalt/timerfd.c
@@ -35,14 +35,19 @@ COBALT_IMPL(int, timerfd_create, (int clockid, int flags))
 	return fd;
 }
 
-COBALT_IMPL(int, timerfd_settime, (int fd, int flags,
-		const struct itimerspec *new_value,
-		struct itimerspec *old_value))
+COBALT_IMPL(int, timerfd_settime,
+	    (int fd, int flags, const struct itimerspec *new_value,
+	     struct itimerspec *old_value))
 {
 	int ret;
-	
-	ret = -XENOMAI_SYSCALL4(sc_cobalt_timerfd_settime,
-				fd, flags, new_value, old_value);
+
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_timerfd_settime64;
+#else
+	long sc_nr = sc_cobalt_timerfd_settime;
+#endif
+
+	ret = -XENOMAI_SYSCALL4(sc_nr, fd, flags, new_value, old_value);
 	if (ret == 0)
 		return ret;
 	

-- 
2.39.2

