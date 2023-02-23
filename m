Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650811FB5
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:44:41 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230223070423a7ba55ba51f16194da
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:04:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AtCA0dkvpZM2/PoIQEglaui1L3P7/hJNqSITkJ6B5e8=;
 b=LL0Iu2rArayAtzsMvH7djc8UGn3KrxbdbqAGZiVjaMevftzwKexTHIdlqrq+Nc8AVjnLOO
 M7ggoCxEm6wdR1/BteZglgKODMY09LDoF7Pm0v6mifVsAIHkITTd/IOb8/HqDv23JHCF0xpS
 f9KE5PlEj4R1EZ4tFdwG39fpvptJg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [stable 3.2.x][PATCH 6/7] drivers/rtcan: Implement compat support for the rtcan driver
Date: Thu, 23 Feb 2023 08:04:16 +0100
Message-Id: <20230223070417.3969366-7-florian.bezdeka@siemens.com>
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

[ This is a backport of 74478a4063ae5c3df7bfeb489eaefd0802179a5d ]

Once Xenomai was running as compat application (=32bit applicaiton over
64bit kernel) the can smokey test failed. This patch fixes the test by
implementing the necessary compat bits.

Affected ioctls:
  - _RTIOC_BIND
  - _RTIOC_SETSOCKOPT

Affected syscalls:
  - recvmsg
  - sendmsg

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/can/rtcan_raw.c | 42 ++++++++++++++--------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
index b6b456939..441bfbc6d 100644
--- a/kernel/drivers/can/rtcan_raw.c
+++ b/kernel/drivers/can/rtcan_raw.c
@@ -41,6 +41,7 @@
 #include <rtdm/driver.h>
 
 #include <rtdm/can.h>
+#include <rtdm/compat.h>
 #include "rtcan_version.h"
 #include "rtcan_socket.h"
 #include "rtcan_list.h"
@@ -411,17 +412,15 @@ int rtcan_raw_ioctl(struct rtdm_fd *fd,
     int ret = 0;
 
     switch (request) {
-    case _RTIOC_BIND: {
+    COMPAT_CASE(_RTIOC_BIND): {
+
 	struct _rtdm_setsockaddr_args *setaddr, setaddr_buf;
 	struct sockaddr_can *sockaddr, sockaddr_buf;
 
 	if (rtdm_fd_is_user(fd)) {
-	    /* Copy argument structure from userspace */
-	    if (!rtdm_read_user_ok(fd, arg,
-				   sizeof(struct _rtdm_setsockaddr_args)) ||
-		rtdm_copy_from_user(fd, &setaddr_buf, arg,
-				    sizeof(struct _rtdm_setsockaddr_args)))
-		return -EFAULT;
+	    ret = rtdm_fd_get_setsockaddr_args(fd, &setaddr_buf, arg);
+	    if (ret)
+		return ret;
 
 	    setaddr = &setaddr_buf;
 
@@ -447,16 +446,14 @@ int rtcan_raw_ioctl(struct rtdm_fd *fd,
 	break;
     }
 
-    case _RTIOC_SETSOCKOPT: {
+    COMPAT_CASE(_RTIOC_SETSOCKOPT): {
 	struct _rtdm_setsockopt_args *setopt;
 	struct _rtdm_setsockopt_args setopt_buf;
 
 	if (rtdm_fd_is_user(fd)) {
-	    if (!rtdm_read_user_ok(fd, arg,
-				   sizeof(struct _rtdm_setsockopt_args)) ||
-		rtdm_copy_from_user(fd, &setopt_buf, arg,
-				    sizeof(struct _rtdm_setsockopt_args)))
-		return -EFAULT;
+	    ret = rtdm_fd_get_setsockopt_args(fd, &setopt_buf, arg);
+	    if (ret)
+		    return ret;
 
 	    setopt = &setopt_buf;
 	} else
@@ -575,11 +572,9 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
 
     if (rtdm_fd_is_user(fd)) {
 	/* Copy IO vector from userspace */
-	if (!rtdm_rw_user_ok(fd, msg->msg_iov,
-			     sizeof(struct iovec)) ||
-	    rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
-				sizeof(struct iovec)))
-	    return -EFAULT;
+	ret = rtdm_fd_get_iovec(fd, &iov_buf, msg, true);
+	if (ret)
+		return -EFAULT;
 
 	iov = &iov_buf;
     }
@@ -716,9 +711,9 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
 	iov->iov_base += sizeof(can_frame_t);
 	iov->iov_len -= sizeof(can_frame_t);
 	/* ... and copy it, too. */
-	if (rtdm_copy_to_user(fd, msg->msg_iov, iov,
-			      sizeof(struct iovec)))
-	    return -EFAULT;
+	ret = rtdm_fd_put_iovec(fd, iov, msg);
+	if (ret)
+		return -EFAULT;
 
 	/* Copy timestamp if existent and wanted */
 	if (msg->msg_controllen) {
@@ -832,10 +827,7 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
 
     if (rtdm_fd_is_user(fd)) {
 	/* Copy IO vector from userspace */
-	if (!rtdm_rw_user_ok(fd, msg->msg_iov,
-			     sizeof(struct iovec)) ||
-	    rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
-				sizeof(struct iovec)))
+	if (rtdm_fd_get_iovec(fd, &iov_buf, msg, false))
 	    return -EFAULT;
 
 	iov = &iov_buf;
-- 
2.39.1

