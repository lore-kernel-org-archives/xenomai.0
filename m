Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147AB4429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAImVJrLx0o2aPcHye+FQzWnKKvJVZkoGGe0ZNEuneBBV5SQ5Ih4cTjDGMIjGf+UdnrLGKuV5CVpFWkmT3SqprZEqht0KH8fqyOPrT99InVQKnr0gQm65UhwfI5FNLUAlVami6Z3Xqd+r8P/aYFfUZwik+NCc3DuIo4NVnD3kAh//pJtNNBUevfnrsVGP1O767b5B8wwjUBBRZYRGWyPSwqxLgzmc6lI931aqBgd7g2HSj5CZCoUqyTXsmKdo8YOXbaum7nIVDlLYtDzSuKrqLY+OzwbgOxWS+LGPk4kQjh/BMis5PVj+5Hy9WlofTZv+ikz2cqlznBJmrayMm6WgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq8L2P8enrPPjFgCWf1NuWVZ66FKD5q/WfhkJDyiBSk=;
 b=AzGdzJei053Ce0SuOWP/mKw+ebRTJxjzlN8FW7zrjcc199ngvcDA2zlDEwZzSOU+kyrHcDYM8Mpxp/nS825IqBJP6OdGUchyj5SW0uaaFeV+zUuRZxkAy5hEjg4shwXoOYMQqGgs4SWaSfYaI2jf/a15EAjwj2f5FP1kkcPGCfjcg4aaMhvPLrhz6YAO6I4MaDS03F5tU5Gol6aTzSZG7XxA7EKmZH5MUaiUbqQpwpCC0M7ElGNZ9u+bfzv+npZNWEEyhTEzwo6NdOe/YT06Hb4ChFZII2wzDGCzN6Lep/CLc4yDbpDvtbR7WfY6ykgFFuBbOh8I//ccvDObAI51Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq8L2P8enrPPjFgCWf1NuWVZ66FKD5q/WfhkJDyiBSk=;
 b=LCETR2sfFu4MPDx6u1a1Z+AFSJJ8TyVjLOev6y4SxOKs9VYWUY5AY8gg4yTj0Afk3ry+V6Ri8fRNxLqYn2EqJr3Pzz5K2rWHW1nMsqSpoJ0lbG9hD4XWZGZm2KcFNgeNPSbjk7wBXKUfThSI2tmwsj3bZMlXEkIT4xSghp2HzHrJ2uAuh4lbM7ECDi9CPBKpPBCoK2gQG4dsPn1N8/HpjlFIEPO66s9lmdhByDhrn+/CSQz43CljaPjX8qA1fJ8Lgoe3w6/XP4Zs0dXiRgysqlHzdgSBHU6K7WNhQNbhUuyQ3CdSoyU6OvSIdFr6yKJ1X2iBcYi/nnTBmYAeoDQPVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:43:55 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:43:55 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 07/42] y2038: cobalt: posix/mutex: Remove compat syscall for mutex_timedlock64
Date: Tue,  9 Aug 2022 15:42:51 +0200
Message-Id: <20220809134326.23688-8-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4da6ecf4-4412-46b8-4ce6-08da7a0d343c
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bWD9qmHqUcxHYTkF0fxnqxRvNM28yW0B9rHegM2hUT7HmgcH2u0w+SW8U8BnogAVSOWHdC0Iy9LdEXJ+rF8HsYQgi02WTT/y4NKUpMFRICwiGW4cITyem1rAuVJ1YU9BbgyARiUUEtnE1zgTpUm9X4itElf4PybS9vb874FmbBZ14u1HV+XBIdpVbMTuKTur9GLlym14o2DoryFPf1xNyHblwin3jEygQmUv4eWx0cw89LWVt2bnu0oU9KF0PbSmdbQRQ265te/ccAeewO+G6pHJ4lC+1mNVLzTI4dGwrB1IrtK8tIdqaG/cc152fyFjEIammqDvS+nZiMHHYIhhYA0X7A1OBZVuCTQVSDYFEfIYrKO3nnvoQdQh+LelaxGF3baoIwF3OyPfZXoOkO5Lf7F2bbz870qeJaU5+n9DFaj+cJd7CMzK0mQILTJbxrfpWhWFNTINi0of6TRkWiJuJdsOd19TI76JB4Ki3WbZwneQpteIKKlDlRCqMTHB9l92VGg9Zmh+gBSaFX9Sx2ykzvIZXm62zO0mkstEf3ilmDjJ1kf61u7YFl7VA+Uh/Hytbfo0D8aT7gl7R7MT3OIzPM335F/h+oPV4OqCnyIgYlh7UkFBGfyWPUKLoF3FCDAxTXEJka3Lc10LefrPW2czwTIv+V7kcVcNwmCLT522UKqVwtc/D8SspM4EmL+mYUd3icCE2GribfZQtlRE+z/nGFlSZrWJmPUDDWiawMfIxfM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fUkpSv6W4FfxIXSTdjYwRS8p2r40rQW1OT6zextrDxHJtx0riUYXG1AVDbHY?=
 =?us-ascii?Q?RdZgu9Ea0VdYdGUWi+wdfbIOnL8B3vIvw+8qXkkNPqZ/tIX2dtpIx4APxG6F?=
 =?us-ascii?Q?eogRRm/c4tphjExeXfDbw5eVGb91IZdFqB0uWc+Q4O9NHdpSAdfh/RYmRviz?=
 =?us-ascii?Q?LRc2OfDRipu0o6gnnJTiJqWHEJCaiNz8vK0N4bfpgH/4t9I8ULV0zVt52AsW?=
 =?us-ascii?Q?vPkcQS+Qx22oxWNL6mVMU7iejdgvBjInPBgdEVj6ZjttVpnRCZ78TdSwfkmt?=
 =?us-ascii?Q?mySqmJeo9/Fvj/oa0NO33MD5ZqT1dWsU95YtL+8FErDyxTcvzIPvpabFwsIk?=
 =?us-ascii?Q?d1HWGof2ZWXIiMiaL88vKxWR+zq2Xet4JTBC8SSRmeXvGtOQxXgbJnQDxZLr?=
 =?us-ascii?Q?dQyPyObsYi/or+vNTezlEe9dS1qVpiT0NCjqmARu3dGMFyArSUkGArYSXAIe?=
 =?us-ascii?Q?/udb2/YDQRksT+SID2+qZNYaoWJ99Z1j8NvXKVwnLqeXsMlwuZAq06F25QmQ?=
 =?us-ascii?Q?decGL7yqKgXiDnN/Oc5thMGNq7HHClkbkP3vRm5gCvGjJnf5aqzx0UtLM1Op?=
 =?us-ascii?Q?qxMmi+A6+fZFdbSc5og/zOilBeWjoQawvRTQqzcti/fhyKj4KmYonrE+1ubh?=
 =?us-ascii?Q?qMmW9LWp73wGwMp8Ev53DcrklBZvyidzmoFUlksAxN9vmrlXE9NuIkn47pXz?=
 =?us-ascii?Q?A8YLB69cBgzIK1W9gYqim69mNLePRaxDdxletnP5KDjvLuo+huVroZhM+y7p?=
 =?us-ascii?Q?bxin0U8l5avMtw6XE0chpBYp5LPVeOulXWigswZinEXbJ5xxnBJDogmlPqpu?=
 =?us-ascii?Q?KwXOWFqEMtHSNoHTczc9ygcjClczbcLYbGVSeijjPkD7v/xb4W8fjTUjg5bg?=
 =?us-ascii?Q?AF1HvDYIechbfXHcjsH/4UZzMAK7JiIKCWAZQFX1W+OU4IZ/itkLuwv6cARD?=
 =?us-ascii?Q?x5AA4FwM4TUeqmjqvosJCf8pL3iedwanktu2mBPwsMx/KOSkrhhoN3pbtEPl?=
 =?us-ascii?Q?3QZqrRD/HdgdMhVpcV12a7TuN2HLvb9VtvFZiJUirG+fWDFM0X0kzxVdz6tf?=
 =?us-ascii?Q?exVlkYMDo8hpzDfwKKyXWhOSNNNhPAGuRWVYoypcwqqO71JaidwKkdIL8+FC?=
 =?us-ascii?Q?Q8o18j7ro2G9bemLuC5ib4EtasMsDyhSTHSUmvrNa90Cb+fyS0PzwF61x5rY?=
 =?us-ascii?Q?OJHiH4gJMqxoLfigCTDnVCM1XWMI7wluFuAGyAU8NFSGD6iUQM3sw9UMGUqf?=
 =?us-ascii?Q?abKXMfCjRf4Bjg/9aYl30CYhZSl5svUZafAvZ/dUoY7yhqj5mlEZ17ZPVaZx?=
 =?us-ascii?Q?u8rFpnh1uA0GGR/oO5cI2izJH2IQ4NypbO18FmuygA+iNwm4PD0a8BAjjPg6?=
 =?us-ascii?Q?eTp6NPhrPuj5VrdtLu+yaCNOkJYbsePnlGLVacYXjsFxDaBfnz9OPajbWHJ4?=
 =?us-ascii?Q?5ilg6p1WRatYX9oklakThwG0BRj5PUtOIk+3lzcNZg3siqUjdZmvOlvzTHIP?=
 =?us-ascii?Q?SkzIwcdRus9S9KHs4Cb+CZ2KUnHfQia9u/S18u3yAOw8szbcW9oeJLRD27Yp?=
 =?us-ascii?Q?boryfFUgYn/45FZ3BfZMx+VSIyHWAiFkA1IxBPXf7ojHhCH+Lu1Ur1zKgMyW?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da6ecf4-4412-46b8-4ce6-08da7a0d343c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:55.6814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgcTxP7T0hmuOhqoe/7iLmUVl7ok+HKm493lPamusMVTu9iwHhrCyq9W2jmJgWUePX7D1/LRYkD3vneC/xcfoHQMquM8R3mCfuL+z+Rv2lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/mutex.c     | 10 ++--------
 kernel/cobalt/posix/mutex.h     |  3 ---
 kernel/cobalt/posix/syscall32.c |  7 -------
 kernel/cobalt/posix/syscall32.h |  4 ----
 4 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/kernel/cobalt/posix/mutex.c b/kernel/cobalt/posix/mutex.c
index 0f1c01851..2bdb66d17 100644
--- a/kernel/cobalt/posix/mutex.c
+++ b/kernel/cobalt/posix/mutex.c
@@ -364,13 +364,6 @@ static inline int mutex_fetch_timeout64(struct timespec64 *ts,
 	return u_ts == NULL ? -EFAULT : cobalt_get_timespec64(ts, u_ts);
 }
 
-int __cobalt_mutex_timedlock64(struct cobalt_mutex_shadow __user *u_mx,
-			       const void __user *u_ts)
-{
-	return __cobalt_mutex_timedlock_break(u_mx, u_ts,
-					      mutex_fetch_timeout64);
-}
-
 COBALT_SYSCALL(mutex_timedlock, primary,
 	       (struct cobalt_mutex_shadow __user *u_mx,
 		const struct __user_old_timespec __user *u_ts))
@@ -382,7 +375,8 @@ COBALT_SYSCALL(mutex_timedlock64, primary,
 	       (struct cobalt_mutex_shadow __user *u_mx,
 		const struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_mutex_timedlock64(u_mx, u_ts);
+	return __cobalt_mutex_timedlock_break(u_mx, u_ts,
+					      mutex_fetch_timeout64);
 }
 
 COBALT_SYSCALL(mutex_unlock, nonrestartable,
diff --git a/kernel/cobalt/posix/mutex.h b/kernel/cobalt/posix/mutex.h
index d7fede27d..800515a69 100644
--- a/kernel/cobalt/posix/mutex.h
+++ b/kernel/cobalt/posix/mutex.h
@@ -40,9 +40,6 @@ int __cobalt_mutex_timedlock_break(struct cobalt_mutex_shadow __user *u_mx,
 				   int (*fetch_timeout)(struct timespec64 *ts,
 							const void __user *u_ts));
 
-int __cobalt_mutex_timedlock64(struct cobalt_mutex_shadow __user *u_mx,
-				   const void __user *u_ts);
-
 int __cobalt_mutex_acquire_unchecked(struct xnthread *cur,
 				     struct cobalt_mutex *mutex,
 				     const struct timespec64 *ts);
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 245ddb2f0..d3cc79878 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -225,13 +225,6 @@ COBALT_SYSCALL32emu(mutex_timedlock, primary,
 	return __cobalt_mutex_timedlock_break(u_mx, u_ts, sys32_fetch_timeout);
 }
 
-COBALT_SYSCALL32emu(mutex_timedlock64, primary,
-		    (struct cobalt_mutex_shadow __user *u_mx,
-		     const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_mutex_timedlock64(u_mx, u_ts);
-}
-
 COBALT_SYSCALL32emu(cond_wait_prologue, nonrestartable,
 		    (struct cobalt_cond_shadow __user *u_cnd,
 		     struct cobalt_mutex_shadow __user *u_mx,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index b7baee94d..ab7dbb945 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -76,10 +76,6 @@ COBALT_SYSCALL32emu_DECL(mutex_timedlock,
 			 (struct cobalt_mutex_shadow __user *u_mx,
 			  const struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(mutex_timedlock64,
-			 (struct cobalt_mutex_shadow __user *u_mx,
-			  const struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(cond_wait_prologue,
 			 (struct cobalt_cond_shadow __user *u_cnd,
 			  struct cobalt_mutex_shadow __user *u_mx,
-- 
2.37.1

