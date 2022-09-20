Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50058.outbound.protection.outlook.com [40.107.5.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AEA1C03
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 12:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC9pOtK1MstTkguSIKQpwGci4tH3KpfcvE23BlXRnwTTV4IF2G8uQytTFlJoSo8uvdFzQ+Q7yMhx5CNnfhc+Gn3RlyS0jzv/bJn2hdkdfmtRFIcOWy3p8DgSuPXXip13HF7x22qXbK3aZVAWx+fJq+AYO9f2H64OJ9tMmjILOBBU8oWijMFv4hyf6jmsLObKiq2eD0pBm8tHcChd4Nq21ZiWpkCrlJ69ts00XpIqSPuDhB2MNL4DF/+l4bdix9R/4UcQ8TY1weuh0bjVdr1nG1J1jDmSZRiMprB0ku/vbuI51XyoTyUOqUE3p7XAXBik4bSktfNZF0+nidXi5cg0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtU+JIdzJAhuUKrvwpnnnPGWMrW+zrvmNLkZF6AXcbw=;
 b=KVzURd3BWtkvebbmw62Jj6yDl8V/Td1SOUfaTYsY/ZhfqE9y4rJs1aPhliYvhQ8IMH0f+gY0xFFo0Z2aJOT6VBnl+CzuxdCaqdO/ktuKUwlCEPfECcR+SiqX53ZRcjSxRLU0cWccnQPS+S2XJ7lgIuM36EAenavWbkfzMZShWYXJBo09x1ey4zaLt17n2JKmBcZ+VFf9hJEyyS19KU7xnFwTEqYPOTKIRXdEDvLCk9ckhDMbU7AD4m+Pk1PFosoJHyApYU+38ePJ1qVFBNQ24wJiCkyeTe+dHNmY3c0N4+RpbpO/j5I1NynqVZqDSF/MgFu9RSPTs5JIhxTnEi+jlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtU+JIdzJAhuUKrvwpnnnPGWMrW+zrvmNLkZF6AXcbw=;
 b=tb+bOvSdzT0imNWA9u+V7pVHSRcpkkP0n2no9Vs80/5GDzyjNVcaLsotD6qxrM+QJXzI6FFKa9FKr1zdACRrMwBcC6NwVcpi84ZWHkIf7uoPfFjYwVdClCB89zf9/Ip16rH6o+OfHbxn8uq3kGe7v6yf1wS/PxSYhwKZ3A78CjRRfdsLGFADaO0ZxS7D+h2DCu850s8s8DGMEdXWU4/TNXsiEEyqojp3DofVVQtYfdjGSzbFyJn1vGyB69UyqgUHZMupvzwDrTZFeaetZriQ4mFJjmOWRVHchaxLn4riBJv6B9xPZNAevT+xYRb0lTSqOq5rwJZR2e8eJNiSw8yVuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 12:25:08 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b%7]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 12:25:08 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 1/4] cobalt/rtdm/fd: Adding helpers for handling compat affected data structures
Date: Tue, 20 Sep 2022 14:25:00 +0200
Message-Id: <20220920122503.115682-2-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920122503.115682-1-florian.bezdeka@siemens.com>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DB8PR10MB3611:EE_
X-MS-Office365-Filtering-Correlation-Id: 1104000b-b2d6-4a75-bcfc-08da9b03282e
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nl+LdTWIBxFmthNu4QNZ19dzuVSY5aHmgEXub1M2K7JOHgxEpgUuCiduB7RAoGUEXDDDe/HLEUG87kBnnh1fKE2ea+S3tg3/vr18OjnwZlhi2NM773KaoBFms4lXqXynNa96sD2U5coatc/mslVxzO5D54fx+Tr+xu2cc25g42Z/mbddnwsKa59oVDIJb6BWaQytn2RzxvMFgx4V1S93a/9Juq3xh6O9f06JfQfTu5lD5kYe8uKkr4Gsur/CMCQagZoufjyh0iOcrHLTYYkD+HEoTlzM7YQ12uXhNOos99OPyXVwZtdUNwGCUQyPhIl8xpMfip4buQTbJz3yUidhkvkrCOggslBKGgnzVHjRVouPmiP0ezi3KavROTzHiAU06nJEYKWjmDTHSRQaasgF3BIoMjEE8v1cmUXn67NRWPEl++f9WrVzyt1z3UIr2IRr6tCrVwNqpgrq3u9wCX6/rdtgdTYpJcj6AA1voPbmv7Ri2ISecW2mXSvhXLxFWl6/aO7jMFvUEtorksfFvmKlNuup7mmHIMjybXLcmOG/apuI8LejvH1Qosnc6MmZ1WY08xqRxt/ZBQNFWBBRuzRSWPQzcYNLu3KXeZX3Uvk6sGLrosSE4vhsjCtsEKVtHWSIIXdJtBEDnw5GS93HiWTnjL9++45sm3vXciAQnv0RFk77ueh9lpAoyTfs4cIEiGqkUurh1Re4zZ1hZ7RtOtM8dg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(2906002)(82960400001)(6486002)(5660300002)(38100700002)(8936002)(478600001)(107886003)(6666004)(6916009)(316002)(86362001)(8676002)(66476007)(66556008)(4326008)(66946007)(41300700001)(6506007)(36756003)(83380400001)(2616005)(44832011)(1076003)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YaF4DX9WMf/1dFUhxcYPVNxh+ndDZxBn6ecFrywaI0R4NExbzJxdpoXf1JFt?=
 =?us-ascii?Q?ZCejkLfokWgZD9oa0MlbEWwRcKh+raKP/QuoV8Xe+TBtX2PHJG2isEOv7N0K?=
 =?us-ascii?Q?9d7dAbBg1kalquCYRAdc84pgc40XWqDBMPVRSu/UdyQzW5tiO1mWMsV4k+5A?=
 =?us-ascii?Q?DqnMTef96hovDFPuDi9sJgd1goEmnfnrOw6ND4RjlCbBcbn33obDPy/ZZxy6?=
 =?us-ascii?Q?vCLUjPT9N/YTbqtu2hQlnnncjxTtwfRMgn8Nh7ofxgAdU5hZ0N7Z8WxDc9Lh?=
 =?us-ascii?Q?hwIyhWnL4l0wgtRxznJwwnU4LaScAWvh51bXwBKVcQMv8YOmT8iPotI151t4?=
 =?us-ascii?Q?c+chTKL1Hjkv1EPDn0P8DuqCZnzqOGEFG1RDeoZAvZ3ZQqXLtL7llvBmijON?=
 =?us-ascii?Q?+LZ9giz/DUahtB+87RCbmhdplqC44FLEySos0OtgJf4Y+gG+Nt8KrBqWJ+rC?=
 =?us-ascii?Q?ZBjkAKX4cNRA0tx3ZLk99IIZwQAhVuZc44dLh5OUfPlotXcv4sjynofs9JrO?=
 =?us-ascii?Q?Rr5UAiwkFZf8bC3RWsrSb9lAvmXfdhfjY12lZU5jE0lWqI/lRQdGNRz93b8d?=
 =?us-ascii?Q?XGcMiDVQkr8rk8DjNJaixciLcd/88OxT9IScMlK3ZeNJAv1eCydwLVNrLy38?=
 =?us-ascii?Q?2ECm6bmooCRpDm5GnTzMpMFFVggHWNc73Y2gM4s7nzjH59rULAckxfhkSWpq?=
 =?us-ascii?Q?NlHky+4r7hk0WXQDMoehDZKOQ88l3KHUE8lrEAt69AsUtuZbKMiz7I8j+K0f?=
 =?us-ascii?Q?2CtaoGboK9j0liKoYNCPnbZnRsKdtXYiTVIZf6Pgwm0Qefn76IKXMTzrikHj?=
 =?us-ascii?Q?vAab/2h8ZuZO6pZig81XJVoALMnjza8oaslNwIMIoEWEMwUoJMLFCUQF0KNc?=
 =?us-ascii?Q?ZcLy7K3NbAsBtvwYJDI5vEkws/vK2he4vR1KmNQMLfKnxU5sAjhBSUF+hQzS?=
 =?us-ascii?Q?bvnK5UwkOmeeN7N26tgf7mIoOd/20r6hJTolsEoxXyPoNBFBwXE+06eF4xkA?=
 =?us-ascii?Q?+jByYzKn6I8rGpzClG6pdcIiWcuXtGbkc6qdAGCc4/gg8I/f0xTh5QJea1xN?=
 =?us-ascii?Q?9sOs/Q7JV6O9+/Lw9/NQDbmsUXyw5kfsa9NnvP77geeQN+Zswb/T7vtAJPsD?=
 =?us-ascii?Q?hl2N4fLByQHVKeOUpfWgEPN0zUf/Iaas0wfhBy0WWNgAzLJS3ibCCcTGobKC?=
 =?us-ascii?Q?0XmcsUW1vQcFsIbFg8iem8vQtS2mTFJHaGQ6Muzbuc4aaypJQrhRKNPH7TQK?=
 =?us-ascii?Q?gD4cmfS/nkpJrvntuSmfo9XqX1GyT85cTk8N9u24KIUk6TDjHD2lB2EVxMcg?=
 =?us-ascii?Q?YZ4LTfQf51O96cqtN94OIhuhv3/IIgIx8nPbjXYZKvhTJIXdSCLq2r+1pUB1?=
 =?us-ascii?Q?7tS4gDDTtbyCE8b6VU5upezKR3WV4g7dRrPyQcTKKVVWWJLqXWu9S6Asmq2t?=
 =?us-ascii?Q?FwNyWU1Z+MkubTiHZeXU9vLFQQAlr0BWMvGwNRE7ENBqHEhHCQIqzDuYeiC2?=
 =?us-ascii?Q?abiOMc6b3jIFFf5bBL0PlJuf1Z9NxQxV5r6fTi6PZCIkWYL6MeOjyRVfWU12?=
 =?us-ascii?Q?razZoPnXuIDFmBj4i0o0xfvhRhKdpE0L0fsBWK6LUX9Sk0GM1qtkfPb5jQho?=
 =?us-ascii?Q?TLUocdPAdKW+V2QDxdnYmJofqh1RudlOmfYpQzl5MF391ZdZlCSWq1G12omL?=
 =?us-ascii?Q?/1CNHQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1104000b-b2d6-4a75-bcfc-08da9b03282e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 12:25:08.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt2KcAcGN5SuSYv9HgaWZLKkQJlK6wzBSuSNCYMi+QUI5qCahwuadXEl2x+s5P+LNiiVMFQBCfmhrXulzRpSS529nn18rO3haRNSfdo860E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3611

Several drivers will have to read and write data structures that have
a different memory layout when handling compat applications. Moving
the decission if the compat path has to be taken into the rtdm layer
helps to keep the drivers simple and clean.

Added helpers
  - for reading and writing struct iovec
    (and its compat representation)
  - for reading and writing struct _rtdm_setsockaddr_args
    (and its compat representation)

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/rtdm/fd.h |  16 +++++
 kernel/cobalt/rtdm/drvlib.c     |  17 +----
 kernel/cobalt/rtdm/fd.c         | 122 ++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 15 deletions(-)

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
-- 
2.37.3

