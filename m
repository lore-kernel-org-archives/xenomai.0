Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E8442B
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRWhGE0lTY6YiLfW6b6LHsqFeiy8b8Ltydw9fMjJlt3WlzBfiY9j0m0mIInLo7CFfhi3QGNMYQ2YVhSDc0vVKwlDt8GQI5vR0LiKYwPX+Bju+ZyWatELAeifYweCrqLs22+DL1bB8nq0B8uo+xaTu4Tuk9bVC4m4kb6UEGDg9OjOw/OR+zAt5gLlyjeC85E1GuBDvl09mBH6Z5DV5mBY46vfOyUG7i6xGjOhIhKTCpVq2W0KeBUQeB3HvDYl21dSGiORTOxqUz8ags8v6LK0aAvDsjzH36dPvC4zf1aZsSEi/xgOmK4ugNay2kfSw5NmqRT7z8CQ7iCaGLvC0SkMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhRIA5K66AkWRSad9Gu5N+NL0j2Gc/wH1ShHsP5YYZ4=;
 b=SrICcaCgYv0sLYnHtt2Nf4W9DI3nqdNJgQlZDC57FuDv5JmkRA0CPQQDq1ZkYbT2PysuYe+LBQeWtrkAUhrpbOzAACSwMivnFRRB7lLqZCMPPg6eXprTPlU7jbHq5kkMLMTtbHUo6vwuYFvMcZa7A/Ggn8h25TlpzPzGmaR3PtSKKr5Y+ZwgxZ4l2/7xblNLQi/WbK2hf8c+HrSqfJuCYwlLOwQZMLgK24UGWl8eaEsCbvV6Fp28eyoyklr2ksTgJdQUEvnM6xaDgdXQbkWzw39wOp2YY66zCdn9ACdeBHS72NOTuJwt0Th7E7l9Jj3+o+b9aQAeHVe0ScsPc3oiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhRIA5K66AkWRSad9Gu5N+NL0j2Gc/wH1ShHsP5YYZ4=;
 b=OwwB+BxycM2KyAoBTM+JT7JN7IWd8jszGxSd9Eo/KXGicSaKEEHglOw6UY5pz0T3gjHiC1oK5T3o3qxiwYq8nvFZ2nC8I6jswQ5Bz7wkQqBwc66nej3wMWaIlBAJVJypIiWnUcESEFl7aRIEYAcEZmyXfiAJKOO1yrqKr5TE95/GhVjdpLOU+RmFttbrSe0lLRiz6HfgR5UVQfioDNLLnf16QLt66C/RF5Po6NmZSbtmTC/7MAJJiecPSpDoyWwTPDq48k6E9wDm65Q/8rTDKzKG89mG/SZJAXwAvOYhYGA2vHbVv6O3JSLlaJnRdKueQzrPcLsStQHXJ5tcR4DFNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:09 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:09 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 21/42] y2038: cobalt: Introduce some itimerspec64 related helpers
Date: Tue,  9 Aug 2022 15:43:05 +0200
Message-Id: <20220809134326.23688-22-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bafbc57d-c9c3-4fdb-3473-08da7a0d3c9c
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fVGzQS+G+ZHhjCDe026kxr7R/oAjYM9SPpfcKltmJAM5x5xqax2p2lT0dPYiMxiaHhTGWRdMnyOXGdY4T1PofKCmeI/9jjJme5nfZZ9g7tHY7UgutQckjBrow8THaQWUQJvD6K3Bx/AoHoaHpCv9dKlSMJLbBigyUvnsvYdY4DtNTCxfob51+Jr1h4QFLxLdcbPOnBpC9gYOPcxogKwo2dYtsYljOqb0+JP+MU7oJ3y8BzmL7ua9BK/EZEoXD6d2ewyj7mrXM8Jd4uJurs+sb120hCbCYEirFYaHCwFuH9yAPxUKdlr4/9NihKmW5nT21/JGSJUCwKXjYeQrLads6calWybHGXfqf/qsuUd5Ug+BYdieeoolHpJgOLvCWZwi8VrwrddFwIZHdjKwk0AQwINUqprxcLo+EFDyztyAc6KOxMb3fRluo4F/JUlt143AczW+rHhYjTn9JWTV/7zDgTG+PUwN2yjpjw+whnSVMIF5LovV4yaNyE5UywUZQLfeKOpXwLk/1q2d+YER7p/nw7LR0H4vR8VP7cm10r2SLMpyMvzTAEnYsG35HvyzeDf1wT1cdyiRsHNAZSIsD/H/rKl33E0EPig9cDUUJDoRt2s87JNU/gwenHG5hqYUUk1E7QezSB6wq6kH8rpJUjYDpHnzXwj/0N49EKZkQK6OAqhlJNv6M+kpkFa4m9NKISmp/sPSzIm8XNBOY/XyaGJU5oLyt7Y7RG9exmMMw4RxUjk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(55236004)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ur7t6QRRpUNEdmM0RTl1mXgYkVmJgIkbylb38hzmSymCnsbENd+vExLTrsI+?=
 =?us-ascii?Q?bb2FtR3Bg5L7R5jG/bZx7r9Eb/RsNmuoWXEVRRGt6huPEn6dmI/iOj3jLqwi?=
 =?us-ascii?Q?Tek47d8BVEp6eJWmuEbDBEHp8JwkrmoLrNPhj7lCm84EPS+nAIC6gLlZ/vqm?=
 =?us-ascii?Q?RyeMmjIf68/DeawDcHGPVi9vbiIP2oNRRQnUxH5+NUzZQ87iZzSkVAbzsTq0?=
 =?us-ascii?Q?eHGsqh18ogd0VT776qZ06u0Hp+JtrvrNXSLBQOolPk3d8b9Rnp2c0vZ/la6k?=
 =?us-ascii?Q?VH3dejsT8fpO1gs3zc2fBQ3PdHmw3+q2ykU8qLHF3hndpjrGme4QpLjnNILw?=
 =?us-ascii?Q?oLuBfMggEJ30DI9t2RD0x2Xf6hNSWDlJKF+QJ+IefSR7L8B8gcLPNkQWawy9?=
 =?us-ascii?Q?zHnx34VEqhSFj0XHDz6osu78QGvTaayd92DvftKYYbDs1F3O9Zba9HfRJxWu?=
 =?us-ascii?Q?zNfjd/V448DEU4WBtC8Zj5a50Gri55wlfcdhs8XVHvptMUzykqrzghX4MW14?=
 =?us-ascii?Q?B985TzfNgvgC6YxJ/gkkSCb9B7NdIEjTRMwImDYzRfoahUZ3i0bUUal3cHFo?=
 =?us-ascii?Q?a5ZjsLN/jbFoc96eHdv4gW88gRuVvED/+ytR/IyQuDkosrafZ7k8gDdoGzOc?=
 =?us-ascii?Q?JxRFLG3QZbMhyfs6vFgbzeNnjjM3PBo8o7nNBDm8M7ldkpA1hzi8x8ROYdaU?=
 =?us-ascii?Q?y0PLgccP9OasJWoh+CFHSS8ZMb/ufUaj54Vveg+CntahfetsDTFM5cO2RiwL?=
 =?us-ascii?Q?hvF4SnEipvtCmWnjGWshBiCGyQFQnYn/p2fY2iIdAXl/ckJ/9xcpqoXROeak?=
 =?us-ascii?Q?P9pO9JVVH8YYPLuJm65OK3okBAsLf3f1MNXt1H97UGbndvX64f72rmlacZNn?=
 =?us-ascii?Q?0k2ixUKdLandCWeBoOeLxgYLuYpPXW5JVKdhYvKpCaWfkb5VoVjL4lyonUcq?=
 =?us-ascii?Q?8GXL2gKh2MODfo/ep14+opkB+x1WooioX54MIWRhwmMFVaUd87++j8DunN4C?=
 =?us-ascii?Q?i8dHXVPhFXaY7EZ7h1rWa37aEwtte0LE9XQBuyUAit2jfs2jzwCr4HTJYiXs?=
 =?us-ascii?Q?K1BdpVc3BQOO68Upk1X7FgOpBTfE15S+rZYqy4fv9FCGjSg1mjOCdAYEfACa?=
 =?us-ascii?Q?hCpZ+TPx2xgJ3dlEjdt/vbgKO29vhOu+3W4XH8DRDOBrvqvfrKzcU8gQxhIr?=
 =?us-ascii?Q?9SKkbI+nkyGbKSQ5YOqdurSJ6Pq6P1vdxIYAg/x5Q1vzoQbL0pFW8Jpf7NZW?=
 =?us-ascii?Q?z9hzyPz9wHH4fYQfgs6k+uKj6X0dfsSNRNJbuJ1lfl1SJzHMqAMBRAtEEeMw?=
 =?us-ascii?Q?28Gy2Wb3DOKcn/LltIifxCUz3jjoor9QVqgNr3svu83AtbpqnrMwC8i6nHi+?=
 =?us-ascii?Q?pm0gBTnWwNCBFdOxRkPPWsIlEh5X34utqf3DEYfBYzci2fA6SO/SIrT3Lydm?=
 =?us-ascii?Q?Py8AxXuBWFJJ9TI2dakT/kXdfhUFGraO6KG9q7zNXZNFB4+Z3x+mNdNTjsig?=
 =?us-ascii?Q?nFF59SdARrsLxx96uLa2JopZ7WRT1zAmEqk47NtrVk33r6nnsWNaL57VRcyX?=
 =?us-ascii?Q?6gq2CG71KiCLupF2kBHEaxXx/eze5eOHkeEycHRPn0ZtvHJp1TtlxmO2npR6?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafbc57d-c9c3-4fdb-3473-08da7a0d3c9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:09.7161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 378kHkLm53T7tzAmHzt5GtqXmRfGYpmzIN2eL87gB9aEZYxxiJ/SLTeibVs0Rzhkyr5n7RD3qDIrjuoYhxyvr4FB5bLJQdmDfUFr2JpGDv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

The introduced helpers will be used by the timer and timerfd y2038
related services for reading/writing itimerspec from/to userspace.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/time.h | 21 ++++++++++++++++++++
 kernel/cobalt/time.c         | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/cobalt/kernel/time.h b/include/cobalt/kernel/time.h
index a55398068..e348cf9b8 100644
--- a/include/cobalt/kernel/time.h
+++ b/include/cobalt/kernel/time.h
@@ -28,4 +28,25 @@ int cobalt_get_timespec64(struct timespec64 *ts,
 int cobalt_put_timespec64(const struct timespec64 *ts,
 			  struct __kernel_timespec __user *uts);
 
+/**
+ * Read struct __kernel_itimerspec from userspace and convert to
+ * struct itimerspec64
+ *
+ * @param dst The destination, will be filled
+ * @param src The source, provided by an application
+ * @return 0 on success, -EFAULT otherwise
+ */
+int cobalt_get_itimerspec64(struct itimerspec64 *dst,
+			    const struct __kernel_itimerspec __user *src);
+
+/**
+ * Convert struct itimerspec64 to struct __kernel_itimerspec and copy to user
+ * space
+ * @param dst The destination, will be filled, provided by an application
+ * @param src The source, provided by the kernel
+ * @return 0 un success, -EFAULT otherwise
+ */
+int cobalt_put_itimerspec64(struct __kernel_itimerspec __user *dst,
+			    const struct itimerspec64 *src);
+
 #endif //_COBALT_KERNEL_TIME_H
diff --git a/kernel/cobalt/time.c b/kernel/cobalt/time.c
index 27dbf8290..716223dc5 100644
--- a/kernel/cobalt/time.c
+++ b/kernel/cobalt/time.c
@@ -36,3 +36,41 @@ int cobalt_put_timespec64(const struct timespec64 *ts,
 
 	return cobalt_copy_to_user(uts, &kts, sizeof(kts)) ? -EFAULT : 0;
 }
+
+int cobalt_get_itimerspec64(struct itimerspec64 *dst,
+			    const struct __kernel_itimerspec __user *src)
+{
+	struct timespec64 interval, value;
+	int ret;
+
+	if (!src)
+		return -EFAULT;
+
+	ret = cobalt_get_timespec64(&interval, &src->it_interval);
+	if (ret)
+		return ret;
+
+	ret = cobalt_get_timespec64(&value, &src->it_value);
+	if (ret)
+		return ret;
+
+	dst->it_interval.tv_sec = interval.tv_sec;
+	dst->it_interval.tv_nsec = interval.tv_nsec;
+	dst->it_value.tv_sec = value.tv_sec;
+	dst->it_value.tv_nsec = value.tv_nsec;
+
+	return 0;
+}
+
+int cobalt_put_itimerspec64(struct __kernel_itimerspec __user *dst,
+			    const struct itimerspec64 *src)
+{
+	struct __kernel_itimerspec kits = {
+		.it_interval.tv_sec = src->it_interval.tv_sec,
+		.it_interval.tv_nsec = src->it_interval.tv_nsec,
+		.it_value.tv_sec = src->it_value.tv_sec,
+		.it_value.tv_nsec = src->it_value.tv_nsec
+	};
+
+	return cobalt_copy_to_user(dst, &kits, sizeof(kits));
+}
-- 
2.37.1

