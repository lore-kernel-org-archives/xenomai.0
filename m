Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25253A0
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 07:37:59 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230811073752339cf5c3fc20015a11
        for <xenomai@lists.linux.dev>;
        Fri, 11 Aug 2023 09:37:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=961a7yxG7IPmBkoES2xxVKW5Eo4JTV1N5F1zsBhqM1s=;
 b=MAWBgjchy8nWcwf8T15G31uy1z66RV0zmjnrgXevslXXrEHfXtjv2F2WwfMqKQzgClP1lZ
 qm46q2e9mCk4ZQOyOf+FAl8BcE3HKAErjNj76BE/FlK2SxiMhTqVMEOt3PFzVV7XL8iPowg7
 HZoRoWBXs7T00eTXPc6+YXeOG5ERQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Aug 2023 09:37:42 +0200
Subject: [PATCH 7/7] y2038: lib/cobalt/select: Fix __RT(select()) routing
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v1-7-d1cfe2f394a3@siemens.com>
References: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some parts of the testsuite use the __RT() macro to make clear that the
Xenomai implementation is called instead of the Linux service.

Code:
  __RT(select(...)

Result after preprocessor:
  __cobalt_select(...)

In case y2038 support has been requested (default) by 32 bit
applications the Xenomai select() implementation will be called instead
of the __select64(). Catch that case and wire it up to our limited
pselect64() implementation.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/select.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
index 7727012c7..d2897066b 100644
--- a/lib/cobalt/select.c
+++ b/lib/cobalt/select.c
@@ -27,6 +27,20 @@ COBALT_IMPL(int, select, (int __nfds, fd_set *__restrict __readfds,
 			  fd_set *__restrict __exceptfds,
 			  struct timeval *__restrict __timeout))
 {
+#if __USE_TIME_BITS64
+	/* Might be called by __RT(select()) only. select() - without __RT() -
+	 * will be redirected to __select64(). Catch that special case here and
+	 * forward it to our __select64() wrapper - which might be overwritten
+	 * by application code.
+	 */
+	int __wrap___select64(int __nfds, fd_set *__restrict __readfds,
+			      fd_set *__restrict __writefds,
+			      fd_set *__restrict __exceptfds,
+			      struct timeval *__restrict __timeout);
+
+	return __wrap___select64(__nfds, __readfds, __writefds, __exceptfds,
+				 __timeout);
+#else
 	int err, oldtype;
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
@@ -45,4 +59,5 @@ COBALT_IMPL(int, select, (int __nfds, fd_set *__restrict __readfds,
 
 	errno = -err;
 	return -1;
+#endif
 }

-- 
2.39.2

