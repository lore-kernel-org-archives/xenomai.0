Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5723C8
	for <xenomai@lists.linux.dev>; Thu, 18 Aug 2022 07:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJFubRPqBTAkr8DtYVTPF6mES83e+asxwdk/8CbEycZdrqEYJ8SHTn3kzz5+kx8HYUqM6qc5S3l8uxJtS1OaWbATe40G/j/3qog3SVP+nVe1qaPpdvXf4LZTJeri14SgbSguATAXK7883PEAk4naOs1Y73j1i+zQwC3v/G6suExLphd176KkyDq0wvuPRGfdqd0wMMF63SVE0DQFlFBYiEnHH/IYpq/K0cZjE3Gy1Fgd9mu4IT9x5j6zL+4dI8t8odQln5/yB/5v6HCT8ZlLMS/FMv1Pbw+o3KfYD1C1/ck72ZOrwh+Uhs1N2X7h38Obkfbuj4ysgS8p0aJQOJqozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6FdK3ri3pUQ1tw0PXuVtU59fHrlhx6eYwwXrp5tZnc=;
 b=dHEt9v/F+mdW+pvo9qpTn4ODsYNCznKaOdXa+OwK3uIGyu2mlA70qhVtNEwzgI7z9d2Iq+UeNyI+Di94E6Vk9xOJQ+48m/L82EkUur4Ze/egfe12S3m66v95FO9c1nc+QEM5wXIXlTZA5jIw8u7ggj6jFjhWFdHJ7IC0XbKxyClWgtgk8hvEuFSnfZu/MhRxZvBIrHMPYAbhn5ctQDQk7Q1PDgUaMZnjwvt/tzQHT+cS4Uma7/c+L+l9d13vNK9ray5sQn9a0PVMPJb3mYPG18IVjk/nDNbygtq9nMrq/GUbA56jYi+ukfbrDof27Aeq2Ea4ThIChte3o6q93B4RsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6FdK3ri3pUQ1tw0PXuVtU59fHrlhx6eYwwXrp5tZnc=;
 b=po2AqMo+5ZeZLnkX/XPLkJWFNiKwKuAKwS6Z5R0LLaM6jwkamvPk3OV/CrO5NzI7v0ohvwyftw+aHJ4+SejYwqILi2A0rNosps3gwThSZbrVUGNC3YIg2fKb3QNJL39wGAQ25Zk3GuJ9/DhLLsNceugpf5IDlPxdgWv8bhywVFMuRGcRoO9vNijWIFDLiktI8bicL0Gi669qaQMcniZEYxuAXA59MEzJkeMKawcSgu65esf43/fDNmC9YE8MIH4OA8yaw5vsgU1vFHG1RMtU39lMHzse7ogLeErYidElXYA9yqpkB3pQcJoP2rmXc53OG39FMPvxD5Uq4lL7tBvVzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DU2PR10MB5126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 07:14:57 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.027; Thu, 18 Aug 2022
 07:14:57 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 2/3] drivers/rtcan: Implement compat support for the rtcan driver
Date: Thu, 18 Aug 2022 09:14:41 +0200
Message-Id: <20220818071442.16567-3-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818071442.16567-1-florian.bezdeka@siemens.com>
References: <20220818071442.16567-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cda60f2d-a72c-4042-f82a-08da80e95b19
X-MS-TrafficTypeDiagnostic: DU2PR10MB5126:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UYO5f+/Zp4hr8e3Q4rTZEe4uFl3+payX9kTDYgEq0kcc/oFsfiBr5A5luiVo+9eQXAQv6LlWG/kOWDlAjP3vIC+rEKEIYE5IG8oW/pQHK/liKBipBdjFKj4T0MB/r6AW7k0OIM2AHOiWLcZNPfrwU2v8eeZ5FQEsT4fbRdD5mjVQ1SsgmIQsr3rLVmTE1cvOAjsYjWlW3hQ3b79BjAIIfXjITRE3KWYMXyIagjILTb7Swm5PSdcX1WasdMX723Dt4kZboZ4yqCIkZzi9JicTlXzemPkrycxQthVyBUEMuVQxx4YEejaDBtV2v3uJYGbzxq2h5ljRVsjzSjubwiu7UOB7bJIIgxsiKjLcg7E5mx/8iu02QpJQVWoKphUGARjFb9TmyfOaeNIWQ7nBlk2qsiMgUgrhb+3qT900Pk3wuPmc2v3+QOJvsKxdi3lNF3ODzbJjWcZW2nTXwEk1Q0JKnH0gX+gy6KuTyMZ44BduhsZ6+SSnIOoCWDAL5J+ruTZ56uUuSvMJWKIzFi1rD9KCI5JjfcipZF5ZY3dWI3hHPUSB60v3T0aWvbinjDBHbpauks2f7qmOquJG3Q80MQLVfUecV/OIijTp9g9Nf5hTU7kyanybxJZcyLGZtAu+wpdlN6ZrMfUT5kZkZ8y0sXz3E9vODlrBSeep/CJMJIXzmi4HyzKb5vQOrXaOuAfkf+RayREIx53kWCRiF9iF/YL+jw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(6916009)(41300700001)(316002)(478600001)(4326008)(38100700002)(6486002)(5660300002)(8676002)(66946007)(66476007)(8936002)(66556008)(44832011)(2906002)(107886003)(36756003)(186003)(86362001)(6506007)(1076003)(82960400001)(6666004)(2616005)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XJj78HQMBl5vulP9Lb3iRM4TXy8w/u4W0JgpUtZnCc1iBoPA3I+ATWjU32bE?=
 =?us-ascii?Q?qJCDa3aeo5SQbDDVBwLoBgX4nE+KdRv5YeYSHgHRGdPaCeNnC+BISOIJ9T3C?=
 =?us-ascii?Q?hIEO8YYndEniXruZfpZwMPVeChn9Fb+ekEn6RcR1IcfSiBDcRBLxvFkr63Rf?=
 =?us-ascii?Q?HyIzT4vdp1MYGNBMyV318Uiq6DjwsH4GD2uBJWY87Uli6bX/HMzEpE2/tghE?=
 =?us-ascii?Q?bGaaQIXrGJJ7mS0tH0vwKZH1Jnij6XC3Rw1K/G+4AhMCpGdsdhaPe5BAEDB5?=
 =?us-ascii?Q?yx3TeFZ5LAoTp79LRWXHPcpoj5ElySAmpkyRXw4oG7IKnYCn/mAcUcnI3LcI?=
 =?us-ascii?Q?QQIUOOdHBivnFIk/LegeE2+hUHmeXeDuxyB9tMYq/LaMcC0ZRQcmzOGfoVgi?=
 =?us-ascii?Q?qN0bkgx3XmAPxDzKIrLuDOEY7Yf+iW6YEFGEdKLmOLv1kU5vqSZD3Vu4QVcf?=
 =?us-ascii?Q?IybsDK5LVUcQ5CXfJcjSQrJYDYtPT5IynFtNb174Hr2j6XSyc04ZL8tAHC4S?=
 =?us-ascii?Q?JAwB74jIjOzCA/gqcFrSxw4LRZD5YDn3uZd5+/BLPo8grOm3/ZH9KSeETZnq?=
 =?us-ascii?Q?GnMTn13BFQGABEL81aZYkh7WE3sdohmaAMeUZP4omlv7lwMFXQZWfzFdHZFe?=
 =?us-ascii?Q?lTbTFYzzIDUWypjl925kxLf7hfDVnvvdUQrc3mbh07yid7+KgxWRLrT95NvL?=
 =?us-ascii?Q?EAa6qlLX51dP4U/1Vz9Y7MD8KORhXE3FZM6CM7BvfxSwOySSsBrMuSf20eSq?=
 =?us-ascii?Q?oMlUYECiAyWOKXmopn8S/owKgNn2MyVlrxOzNloAl5/INs/xkLCHUB8uFQPx?=
 =?us-ascii?Q?T18ssXQZJOAnv5TWwU4ZWkHCDLmO45GeDEcs2Ne6fuRHIGZfhkf2AXqyJwAW?=
 =?us-ascii?Q?V1HhDYVB3j/9uRXHrh5CcqBpchzN1jHPYPN9Z8dtoFgO8U0LiTH0tMdh+G0+?=
 =?us-ascii?Q?LCrhRLYlzEZ+rwWqoikxfwvpywZnW+0L+D9N7KfY1F5tQFL+Un/qBSEkzGxg?=
 =?us-ascii?Q?XNOLLRjN53TFHToR8vpKe30elwfk6w9dfW0qe2ON6KzaiCNkiLsslNMRzFdg?=
 =?us-ascii?Q?qx7XIn1QmNfBJk1BsvT40knwboel/1s5jTJnLAPXd340buNUlV1MOgk5dspb?=
 =?us-ascii?Q?8gIGmOexluZyXms+L2lOuQf2Wz4ctJvy/NAVj2CY06WcHn6zszy1fDiyYim+?=
 =?us-ascii?Q?STKROv/g0GMzG0Ck23mx+9Gu8pRL+LwQVHYTGPbxbhPTejora8ZOTAeBr2hW?=
 =?us-ascii?Q?JUS2NVtIKMYsLABHn5KZPXHHzG/YUzV96sPtrapzkxoN+UkrM7O99z26CLQB?=
 =?us-ascii?Q?Z0WkdhovSZ5SjQgpKblcsvfBeQDBMB21yH7vecegztW7vQROkr/KmMqoB/mT?=
 =?us-ascii?Q?IRSLXLfvTCy+laThtPuoHJxOaoyhdi0NmhjNJ30L48j8gy/fYrD9yIU1uIjr?=
 =?us-ascii?Q?LK+6KRP1zHHCHr9h94OAC6RaSQSjWIjaQOtN+pVZLKMdwHs/bhvCOKvtPPPS?=
 =?us-ascii?Q?v+INDCLbdFQ5B360MP6l/4WPN3mVfNQGW4p5qOcUWxVnSFtXTd6R8W+lniXg?=
 =?us-ascii?Q?M5Ost+CPQrwLbejyBkwg2qsbFNbfY8hISy3gr4sXDkCZZ9I7FYnrkzkN9Wx9?=
 =?us-ascii?Q?OecPTQsWCzUQTHAW8WN8F92gC+3Zb8ujo3ytgg22BpY+XPvth0FYJt4vdaA9?=
 =?us-ascii?Q?CTha4A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda60f2d-a72c-4042-f82a-08da80e95b19
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 07:14:57.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3aN1pjib8ZO1ExYxIWbnMybhi5xEvnYKIktRf4T9V9wg2SxVaLsBWJOP1DcyWvhb51f7/RSXu5fh1Rl4J5i2s6GrNyfCRBWbiod5Bay/2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB5126

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
 include/cobalt/kernel/rtdm/fd.h |  16 +++++
 kernel/cobalt/rtdm/drvlib.c     |  17 +----
 kernel/cobalt/rtdm/fd.c         | 122 ++++++++++++++++++++++++++++++++
 kernel/drivers/can/rtcan_raw.c  |  42 +++++------
 4 files changed, 157 insertions(+), 40 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
index 058a9c638..176c67e22 100644
--- a/include/cobalt/kernel/rtdm/fd.h
+++ b/include/cobalt/kernel/rtdm/fd.h
@@ -29,6 +29,8 @@
 struct vm_area_struct;
 struct rtdm_fd;
 struct _rtdm_mmap_request;
+struct _rtdm_setsockaddr_args;
+struct _rtdm_setsockopt_args;
 struct xnselector;
 struct cobalt_ppd;
 struct rtdm_device;
@@ -403,6 +405,20 @@ int rtdm_fd_valid_p(int ufd);
 int rtdm_fd_select(int ufd, struct xnselector *selector,
 		   unsigned int type);
 
+int rtdm_fd_get_setsockaddr_args(struct rtdm_fd *fd,
+				 struct _rtdm_setsockaddr_args *dst,
+				 const void *src);
+
+int rtdm_fd_get_setsockopt_args(struct rtdm_fd *fd,
+				struct _rtdm_setsockopt_args *dst,
+				const void *src);
+
+int rtdm_fd_get_iovec(struct rtdm_fd *fd, struct iovec *iov,
+		      const struct user_msghdr *msg, bool rw);
+
+int rtdm_fd_put_iovec(struct rtdm_fd *fd, const struct iovec *iov,
+		      const struct user_msghdr *msg);
+
 int rtdm_device_new_fd(struct rtdm_fd *fd, int ufd,
 		struct rtdm_device *dev);
 
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 4eaf3a57c..30455c3d7 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -2211,14 +2211,7 @@ int rtdm_get_iovec(struct rtdm_fd *fd, struct iovec **iovp,
 		return 0;
 	}
 
-#ifdef CONFIG_XENO_ARCH_SYS3264
-	if (rtdm_fd_is_compat(fd))
-		return sys32_get_iovec(iov,
-			       (struct compat_iovec __user *)msg->msg_iov,
-			       msg->msg_iovlen);
-#endif
-
-	return rtdm_copy_from_user(fd, iov, msg->msg_iov, len);
+	return rtdm_fd_get_iovec(fd, iov, msg, false);
 }
 EXPORT_SYMBOL_GPL(rtdm_get_iovec);
 
@@ -2233,13 +2226,7 @@ int rtdm_put_iovec(struct rtdm_fd *fd, struct iovec *iov,
 		memcpy(msg->msg_iov, iov, len);
 		ret = 0;
 	} else
-#ifdef CONFIG_XENO_ARCH_SYS3264
-		if (rtdm_fd_is_compat(fd))
-			ret = sys32_put_iovec((struct compat_iovec __user *)msg->msg_iov,
-					      iov, msg->msg_iovlen);
-		else
-#endif
-			ret = rtdm_copy_to_user(fd, msg->msg_iov, iov, len);
+		ret = rtdm_fd_put_iovec(fd, iov, msg);
 
 	if (iov != iov_fast)
 		xnfree(iov);
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index ed2e13578..29555cb21 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -31,6 +31,7 @@
 #include <cobalt/kernel/time.h>
 #include <pipeline/inband_work.h>
 #include <trace/events/cobalt-rtdm.h>
+#include <rtdm/compat.h>
 #include <rtdm/fd.h>
 #include "internal.h"
 #include "posix/process.h"
@@ -998,6 +999,127 @@ int rtdm_fd_select(int ufd, struct xnselector *selector,
 	return ret;
 }
 
+int rtdm_fd_get_setsockaddr_args(struct rtdm_fd *fd,
+				 struct _rtdm_setsockaddr_args *dst,
+				 const void *src)
+{
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	if (rtdm_fd_is_compat(fd)) {
+		struct compat_rtdm_setsockaddr_args cargs;
+		int ret;
+
+		if (!rtdm_read_user_ok(fd, src, sizeof(cargs)))
+			return -EFAULT;
+
+		ret = rtdm_copy_from_user(fd, &cargs, src, sizeof(cargs));
+		if (ret)
+			return ret;
+
+		dst->addr = compat_ptr(cargs.addr);
+		dst->addrlen = cargs.addrlen;
+
+		return 0;
+	}
+#endif
+
+	if (!rtdm_read_user_ok(fd, src, sizeof(*dst)))
+		return -EFAULT;
+
+	return rtdm_copy_from_user(fd, dst, src, sizeof(*dst));
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_get_setsockaddr_args);
+
+int rtdm_fd_get_setsockopt_args(struct rtdm_fd *fd,
+				struct _rtdm_setsockopt_args *dst,
+				const void *src)
+{
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	if (rtdm_fd_is_compat(fd)) {
+		struct compat_rtdm_setsockopt_args cargs;
+		int ret;
+
+		if (!rtdm_read_user_ok(fd, src, sizeof(cargs)))
+			return -EFAULT;
+
+		ret = rtdm_copy_from_user(fd, &cargs, src, sizeof(cargs));
+		if (ret)
+			return ret;
+
+		dst->optlen = cargs.optlen;
+		dst->optval = compat_ptr(cargs.optval);
+		dst->optname = cargs.optname;
+		dst->level = cargs.level;
+
+		return 0;
+	}
+#endif
+
+	if (!rtdm_read_user_ok(fd, src, sizeof(*dst)))
+		return -EFAULT;
+
+	return rtdm_copy_from_user(fd, dst, src, sizeof(*dst));
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_get_setsockopt_args);
+
+int rtdm_fd_get_iovec(struct rtdm_fd *fd, struct iovec *iov,
+		      const struct user_msghdr *msg, bool rw)
+{
+	size_t sz;
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	sz = rtdm_fd_is_compat(fd) ? sizeof(struct compat_iovec) : sizeof(*iov);
+#else
+	sz = sizeof(*iov);
+#endif
+
+	sz *= msg->msg_iovlen;
+
+	if (!rw && !rtdm_read_user_ok(fd, msg->msg_iov, sz))
+		return -EFAULT;
+
+	if (rw && !rtdm_rw_user_ok(fd, msg->msg_iov, sz))
+		return -EFAULT;
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	if (rtdm_fd_is_compat(fd))
+		return sys32_get_iovec(
+			iov, (struct compat_iovec __user *)msg->msg_iov,
+			(int)msg->msg_iovlen);
+#endif
+
+	return rtdm_copy_from_user(fd, iov, msg->msg_iov, sz);
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_get_iovec);
+
+int rtdm_fd_put_iovec(struct rtdm_fd *fd, const struct iovec *iov,
+		      const struct user_msghdr *msg)
+{
+	size_t sz;
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	sz = rtdm_fd_is_compat(fd) ? sizeof(struct compat_iovec) : sizeof(*iov);
+#else
+	sz = sizeof(*iov);
+#endif
+
+	sz *= msg->msg_iovlen;
+
+	if (!rtdm_rw_user_ok(fd, msg->msg_iov, sz))
+		return -EFAULT;
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	if (rtdm_fd_is_compat(fd))
+		return sys32_put_iovec(
+			(struct compat_iovec __user *)msg->msg_iov, iov,
+			(int)msg->msg_iovlen);
+#endif
+
+	return rtdm_copy_to_user(fd, msg->msg_iov, iov, sz);
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_put_iovec);
+
 static void destroy_fd(void *cookie, struct xnid *id)
 {
 	struct cobalt_ppd *p = cookie;
diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
index dffc6e837..92b7617fb 100644
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
@@ -922,10 +917,7 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
     if (rtdm_fd_is_user(fd)) {
 
 	/* Copy IO vector from userspace */
-	if (!rtdm_rw_user_ok(fd, msg->msg_iov,
-			     sizeof(struct iovec)) ||
-	    rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
-				sizeof(struct iovec))) {
+	if (rtdm_fd_get_iovec(fd, &iov_buf, msg, false)) {
 	    ret = -EFAULT;
 	    goto finally;
 	}
-- 
2.37.2

