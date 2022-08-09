Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697B442C
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1/HRO54BEZ7aGQrw5TaK1RB6CYTAjFIl3B+lirG+Pv74Ux5PqlPIUx+fjXXyg7IUj//OlPQHcW95ZMeLBrEMHw4Nit70ifRZcywYG6M3qt6FCN4Ol3NCRkEAHw+qRSJIzkXDh3hHgYytorGGLeoCk3KJGSy1uFWG6GtInTHbEYfVlxXQvBX29I7YH+MWR6hguuFqDJZ2JYxCZqkW003s1wILIw2NodQPHazPqKxdK9IvNpGMO1j3i1W7XTay1Ya9bVXIQYnCZ8qqNkQGVXHn0fvwJ9KHUaIc4i98oYAl01LvEII/x2nF0UOG7tuX8l/bub3goL73zPj69SVXcOeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58KYjkxscawBQc4yOpztzlzh0QJXAibfzST0l99f7kw=;
 b=Wn75bhAPuC2n4HftC1CyqeGjKE0lN0OzGwKAyh92TdetZVcbs4Rx7N9S9Fnlpj4e1HH1M0lEr7JKe/XsPkfw5PUSvH7zZndtCBfnlSbmVYyT7EVcB5MixJ2Jpl6RroVhBXcHgYtlRiEhqU83Ez0S4rPkwT03OSEEsQBe9XxCzDnRHLuAQRJuGdU2UsOWKFHumdZg4Ve1Y0hoV0MzNfwiblg4QESJHR9MZv2NzNdoB1bcBeUiyz4HyVBGXPhHXptBmCtSiTpS2bageen8z4BW/p/f4vV2efORUthSdaYWsEMLKzHvKL15duMcS0zU1NH/0VReOsEPj09duNMfQBCD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58KYjkxscawBQc4yOpztzlzh0QJXAibfzST0l99f7kw=;
 b=gC8d8zRzwd1d+OatmTzsCABEqfcuml38tr8r35H9dxlj57njLxgv5uUHaLGEdEMmo1cP8LAZCM4liZ0T8LUXMCprMRw4YvgLB67yM6k5JgAvo47xiJKP0qqrpiqyo/GSS2yBhE/k1luPszq7KmBqC4D2Fdc/Zev6YMs53SyhF2nPLDMiJ1sK27sBKPIBt28lhnSHI3RdvwEvscGhZJduT5bxOb1pe2zDJugGz6f/1mte6DKdjfJk0Bi//3BzOEH2k9a6fvqaGSjF/H3CGu+2sXTNTYrWPWnVlMVD6us4CE2Gksdhfn8E5D/1hMSMcvcIdiA10Ndo95sFukpjdMT13w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:55 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:55 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 40/42] drivers/rtcan: Implement compat support for the rtcan driver
Date: Tue,  9 Aug 2022 15:43:24 +0200
Message-Id: <20220809134326.23688-41-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0002.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::7) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5a4d4e4-6414-4adb-4ddd-08da7a0d4833
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CcGxeIuyTKKXz711NpUDwrou+09F53et31SXHXd4+FPo+BE40oGh9E3NUG+WtUnTU+PtQb/a4T2U5tcdJzxBDgUtn3zaUtTUtZ7rzLINiq/bfSTfrdMYQ0Ttsw6VvqqEpczp4CrBUgE/HO1bl1kgipCO0NoP3SZSawU76SFRPd7SeWccZF3KJn7yDq+INBbfvAtAIiEMTdbThvs2Tqs6H+tDatEwm8IIBcgfOEkIk6m6+azQb/5Vr5Q2+ayqfDwf7e5kbLAUJmx6xMxhZOTunQFYAZ/Vk3z2PYHRs3JQYv4pGV9tKSglCGXkXa4WS0rdetssYclUrOHam8hvXtxboq8c4aX0/m0PqGluEFckaJHGfjU5egVzEPqG+0ikkPEb4pobhFDcw8i0FRKnXVVRYtjAFxdrCQ8RbeAed9iVGJcU3+eghsUr1Q+dSAAp7Zxp1Do2q9M/3bcHlXj5Pyl0Qz8ZZPPucisOZ2/i8qf0lh50TpnoVYJSgjCr6Tb/oWALHVW0RGq1ciD7LD344u1Xc+G/hbLOJHCrlwpnS/Z6fDCtFqI1yiMfFBZQtQQbhm37O1Jv78A+3CYpth+qT7ofeke2iQQ82AV6KwHOahF6nk0mRCsiraOh6W2XhGEsqIhZUMnwC3tnvowOTsww6U+Hsxi09aEy6BIPs90UWdpszLDLIfeTVPVk4feKKctpkbEJme1TWrpFiiy5rJA8SA61HuOxVBhFoiLfIMQcAPpoNLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(8936002)(82960400001)(1076003)(2616005)(186003)(107886003)(36756003)(38100700002)(44832011)(6666004)(86362001)(6916009)(4326008)(66476007)(8676002)(66946007)(6486002)(66556008)(478600001)(6512007)(26005)(41300700001)(2906002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjwPqp9h/w5DtfOSzOcdbiibHmcUBluLaoGN+KuCq557mETARHT6OA5gW5ZW?=
 =?us-ascii?Q?h+PeQDz7nYx/PFepJhefQXO5E36v7r4XT5o8SVOLdUu8m8EmaeAPioPjKOzC?=
 =?us-ascii?Q?iQS9iAmRFUB12eHTbJppGRlplLPZ+edkIWiZqBC3lBMgALGeoSM+2HWi9RY6?=
 =?us-ascii?Q?V5ptOG8TDL1tWqRfv24EY5V/YkpxoLjaEa1biFibJt8nk6grgQRxRUlbV32q?=
 =?us-ascii?Q?NsLrOQl2SNFYVkNdC5s1r84O/cH7Lz/FVM2maTUVCJnYpTTtgN+xXyowvnjh?=
 =?us-ascii?Q?n+Q4Mp3mOzLxPcvR+e1g7ZdDY/EEnhZhAZY6qPoOhZ+N9iq3mNIIHm+NGU+e?=
 =?us-ascii?Q?izbV2ls3lQX5cyg0h5b9noHBeNnXBWU2eTV40uiB4Q6lv5Uoi3xdxJI43D2L?=
 =?us-ascii?Q?R2AZD2ehuEMvwLCW66WuacP3Z861NUYa2PcgugNm9UpLkOyUk4+4VawcgNSg?=
 =?us-ascii?Q?D14cQPgHKIZ7SLjUsBnOrgoKaeAUPW7233FJLi3jh/JoxASfoVLQON5TFCXY?=
 =?us-ascii?Q?q4FmTgW6hL/oRNtUl9zlvOyM7nL+VDh56PVC6ihg8Fni5N3kFJyA+V5yaOiS?=
 =?us-ascii?Q?gixKajScynmzP6D7qv1fxM4GwNSG5uyz4k24RnXqRY/Ju8wdvtlEGaHSZAio?=
 =?us-ascii?Q?u2vAhyQxNqoU+i3EOy9Vd4hCWak0NCqjI2lUlh0hVujc1Gr8LWl4WyhLek7i?=
 =?us-ascii?Q?FluM7UKoXgekm6Wsg1eduKMtXdCmUvJcLI+LUClWMD5/A6mnXWF/Acb9SkyR?=
 =?us-ascii?Q?bYLDOD8bHU91pKKXgqzMkpRLdPnjPu0oAp6Mb8I6vvit90hGnKNMAmTxwPO6?=
 =?us-ascii?Q?cFRK3ZEIQmjGNbWM974evNw/m8MCbVOsFLbT8yN8tPevOKbbS0PUeY8MY/dK?=
 =?us-ascii?Q?uT5SEp7+K2w8lmXpXxTguU53gfi35QhrB8uiJbFPfb0DbNqf0t7W22sfVxgY?=
 =?us-ascii?Q?KcSoHw40+YQ7aFserCAtANf9/ohdatkAA6773ZMO51D8WZA5K2J3K/8LYusc?=
 =?us-ascii?Q?ee30AU1q1Peaj32ogzRwoA9HIIYX0X2VRQ1MVUOS1CRrVZbZaLnUe5rdBVrg?=
 =?us-ascii?Q?uYgGU5v7CI2xKLUhVUCklrRCDKT3SbIl6MgpDwYJvmptfCs9uhGWGCre+eEc?=
 =?us-ascii?Q?7kQ+AdgQNiM82UYV6lQaNRiYSoVDKy///8NHpk43+1lhBJV6Bj7/9zy5W7+4?=
 =?us-ascii?Q?bA++biLdUnj/0Q42tE7p1DzUTs/c8i2rssmvuXxmLkDwfePrieOLdbo4uDn7?=
 =?us-ascii?Q?bcPNLm4jetKy/0v0bcUvvvtq7SrtHj3tyvDZ3YVI1RAzTuhFj52RPExrTVGw?=
 =?us-ascii?Q?D4lTH+qP9xOBs7305cKO/gCWFrqDS9QS6F/alvZQr3rV9z+zKI4l3U1UaCdI?=
 =?us-ascii?Q?Rie6P8LlHr5YXkoDM9jrzw7cp1+CDhBh0+WBq/y4YWEdGj13VgrScwMsd8cQ?=
 =?us-ascii?Q?Rkkjha1rzsf15kDznSp9v+NEsP6w/3kkdNSMOsSvFKLMBq0GoIiuFhsrh1t4?=
 =?us-ascii?Q?ZHtki/S5u0lurLIfvSrs6cMxUx98/l5j4tNLJV2peeN6ct232r6XVIA82Mo/?=
 =?us-ascii?Q?nlyUm/ergbylpMLxcg4/I8MCRsv6K4pt9i/No8Ci15m9dprnEdx6FtXkS2fe?=
 =?us-ascii?Q?vifRsXkDMBAHolaUUL9qU1Q=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a4d4e4-6414-4adb-4ddd-08da7a0d4833
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:29.1612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5W0kCy9hHvEgRose07AN9Dg151+oFNvixL0kT0im41jIUSVuozN17qiDgwaVWArNPCPmQCJH0zw6fmNK5QWPk2zhTayYOEvZ3Nsm0/9DKCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116

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
2.37.1

