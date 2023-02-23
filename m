Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE01FB5
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:14:29 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230223070419a96bc15d209c568cbd
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:04:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9nhZxcQmFK02aeGyjmZi/QI4Fw+IcLKE+VLfKHynQdw=;
 b=IpDGhdI1XLGkb0YyNA/++qREIDPNhi/ZErpGO+aWmGB0cHRRX15u6NhTOCloWbjOaViqvP
 /jQFOeKKAgb9gKUkg08yWjrwz2cvva7N2s069sDNDMz+jcvf9/apxChsP+32i5NraRoJiMRy
 fCMyq5Nb0EQTDhkTc33K0Z+k3vcro=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [stable 3.2.x][PATCH 1/7] y2038: posix/mqueue: Fix compat case for mq_timedreceive64
Date: Thu, 23 Feb 2023 08:04:11 +0100
Message-Id: <20230223070417.3969366-2-florian.bezdeka@siemens.com>
In-Reply-To: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
References: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is a pointer to ssize_t part of the ABI. The pointer itself is
autocorrected by the syscall enter machinery, but when reading/writing
we have to care about different sizes between compat and native case.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .../x86/include/asm/xenomai/syscall32-table.h |  1 +
 kernel/cobalt/posix/mqueue.c                  | 26 +++++++++----------
 kernel/cobalt/posix/mqueue.h                  |  2 +-
 kernel/cobalt/posix/syscall32.c               | 17 ++++++++++--
 kernel/cobalt/posix/syscall32.h               |  3 ++-
 5 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
index fb55d8863..3c9c287e1 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
@@ -63,5 +63,6 @@ __COBALT_CALL32emu_THUNK(recvmsg)
 __COBALT_CALL32emu_THUNK(sendmsg)
 __COBALT_CALL32emu_THUNK(mmap)
 __COBALT_CALL32emu_THUNK(backtrace)
+__COBALT_CALL32emu_THUNK(mq_timedreceive64)
 
 #endif /* !_COBALT_X86_ASM_SYSCALL32_TABLE_H */
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index d93c0bdf6..a156af564 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -1048,21 +1048,12 @@ fail:
 }
 
 int __cobalt_mq_timedreceive64(mqd_t uqd, void __user *u_buf,
-			       ssize_t __user *u_len,
+			       ssize_t *len,
 			       unsigned int __user *u_prio,
 			       const void __user *u_ts)
 {
-	ssize_t len;
-	int ret;
-
-	ret = cobalt_copy_from_user(&len, u_len, sizeof(len));
-	if (ret)
-		return ret;
-
-	ret = __cobalt_mq_timedreceive(uqd, u_buf, &len, u_prio, u_ts,
-				       u_ts ? mq_fetch_timeout64 : NULL);
-
-	return ret ?: cobalt_copy_to_user(u_len, &len, sizeof(*u_len));
+	return __cobalt_mq_timedreceive(uqd, u_buf, len, u_prio, u_ts,
+					u_ts ? mq_fetch_timeout64 : NULL);
 }
 
 COBALT_SYSCALL(mq_timedreceive, primary,
@@ -1089,5 +1080,14 @@ COBALT_SYSCALL(mq_timedreceive64, primary,
 		unsigned int __user *u_prio,
 		const struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_mq_timedreceive64(uqd, u_buf, u_len, u_prio, u_ts);
+	ssize_t len;
+	int ret;
+
+	ret = cobalt_copy_from_user(&len, u_len, sizeof(len));
+	if (ret)
+		return ret;
+
+	ret = __cobalt_mq_timedreceive64(uqd, u_buf, &len, u_prio, u_ts);
+
+	return ret ?: cobalt_copy_to_user(u_len, &len, sizeof(*u_len));
 }
diff --git a/kernel/cobalt/posix/mqueue.h b/kernel/cobalt/posix/mqueue.h
index b4b263158..d9223866a 100644
--- a/kernel/cobalt/posix/mqueue.h
+++ b/kernel/cobalt/posix/mqueue.h
@@ -51,7 +51,7 @@ int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
 						  const void __user *u_ts));
 
 int __cobalt_mq_timedreceive64(mqd_t uqd, void __user *u_buf,
-			       ssize_t __user *u_len,
+			       ssize_t *len,
 			       unsigned int __user *u_prio,
 			       const void __user *u_ts);
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index b0b2785e0..9be0971a0 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -356,11 +356,24 @@ COBALT_SYSCALL32emu(mq_timedreceive, primary,
 }
 
 COBALT_SYSCALL32emu(mq_timedreceive64, primary,
-		    (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
+		    (mqd_t uqd, void __user *u_buf,
+		     compat_ssize_t __user *u_len,
 		     unsigned int __user *u_prio,
 		     const struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_mq_timedreceive64(uqd, u_buf, u_len, u_prio, u_ts);
+	compat_ssize_t clen;
+	ssize_t len;
+	int ret;
+
+	ret = cobalt_copy_from_user(&clen, u_len, sizeof(*u_len));
+	if (ret)
+		return ret;
+
+	len = clen;
+	ret = __cobalt_mq_timedreceive64(uqd, u_buf, &len, u_prio, u_ts);
+	clen = len;
+
+	return ret ?: cobalt_copy_to_user(u_len, &clen, sizeof(*u_len));
 }
 
 static inline int mq_fetch_timeout(struct timespec64 *ts,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 72e32f4f8..37f58ef7c 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -133,7 +133,8 @@ COBALT_SYSCALL32emu_DECL(mq_timedreceive,
 			  const struct old_timespec32 __user *u_ts));
 
 COBALT_SYSCALL32emu_DECL(mq_timedreceive64,
-			 (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
+			 (mqd_t uqd, void __user *u_buf,
+			  compat_ssize_t __user *u_len,
 			  unsigned int __user *u_prio,
 			  const struct __kernel_timespec __user *u_ts));
 
-- 
2.39.1

