Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3C4429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnmikYbgpA0gp0LulXHdNFJ/DSCwMarveBTbqrNtqRRBzuqX89WwymbF2ZE3TlB4eypMsUlSutiZWqEX3u3IYlrcU0V68Wy54UK3E5hW9YCBK50NJ+wb2dQEcSGlc261AlJ9qJ3UQhEafvJKPi6IdjagcqZUDKAtWjLHoU2VoWozVtRYKWLO4a7cs5tlydL7los1n9seBU5Hn45bglUjB6vOyse23j7nN0Be0iiDDeAbev0Vz5wfdI1r1SqVGQqqy9W0HLZvUP8hNmqroE1T5pbkeQV5OVnJvjCRiRbZKkeyK7ht29BElt9YmaqY6zj908sNvYPWGY+QJQGQAXlLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEqxwtJjOoZYOWQahu68FgSyprJ7cDd808lzhH2C91g=;
 b=iH0dZIJw7bcEYqtbM0hQMkNCEPRuoFZ7/Fa9xrYCBesqbIJCwB2tKEfFYyvXLGVGO8THcJ9ED4pciiDT+HyPo3i+MxXO6FtjWhwYV7lOcgGh8hC85N1aROB/Lq++hng7p0WjMZkhFOGcblmZ4fCofcAnGPp0AfexdvrpF6QLSKeTpyhXMNFqurKJGn8EPkGtU1S38Y+khvf644B7e3m90uehfQ8KXbXG4Yn8wMxMn5JRR46elRxhy7Z0iYFJsvn/Nw+XCGpKL55IlB/PIphbMlnehfLLDMr3QF9mLo0pKF1gqVV8mighmGI6GhpxnE5ULfuoTTGI9DhqDbbF7Gu7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEqxwtJjOoZYOWQahu68FgSyprJ7cDd808lzhH2C91g=;
 b=LEjbxW4Tg0/xlkB3yTqs64Bq4jsBZwVIGfZv8+WtjMFh6O5ahTtRMilG+kiYXmLhgFK6aHxufqqpAbihthF8s3lypgqIel/qPB8uKyMrB5ZFh7pfHDgRyzHqiaUe8Np28eoD3+DWCC9L+v9nOSGBgtQrnHHeCGYjF2eblfzmy7GG4SZQgaqFjFWvz7KtKCp6OJ2+sN+mGlVp8tc407DPaY1EZdkQh0IyKCtNH6m3caWCmxLz9ALkkw0aXCIGCr+keQD+1y7fM69wlKTu3WWuVjI0wlG3X1JGSmDVaatgT92Nl9sZ6qYGOpr6Dmm0OcxjkLlBJ+r8+3/FHhH4qCcq3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:43:54 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:43:54 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 04/42] y2038: cobalt: posix/clock: Remove compat syscall for clock_nanosleep64
Date: Tue,  9 Aug 2022 15:42:48 +0200
Message-Id: <20220809134326.23688-5-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::10) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f6a9ff9-1125-4565-baa2-08da7a0d3298
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2tHV7NZ4l+8bgZp4/ZI6/oyjzm7cCcnJUdDkNylV1za5rAD80sx47zo8PEqMAcHFo332svU9jzd1glp1cSGCRKjNcQAUoF2Iur/acYTXXR/M9jOfwoSZb8c4LcpCzPpcYux1DQMtaOVnZfc8pShzJ6ofqMwbkWfWwJzRe9Q1r+wYyHluFK3r6ZiFU46KdwGRAyz40Edza1+VeE9cdp9MOIDD0v/Qqcw+IFvcFpQ3d1a4hBBGBQYBS5qLUkFlzkSxLc2RlcLArOgYRqDbfkCNSjY6kadz6A8VZGk6Hjg6ERRPVMEO8nRRBslp9fvTZgsUcSgxBU3e4U9eIQPL1URmE5pzD3z+MsDBBkhDr17uwkR7KPzTvN+lcPDbkgwr1d564cVBTxxAB2NsdlKJcax00fFyjSGi6M1UUMTdzvaaQkORz9/Z1RE7fSaqyp+lDceb9Qve0n/05A5S5IyrND8ERIt/EDWNfysGd9d7/951104/Jwiy95bBagrOu33RqCXO0TkvD50SM0E6r13syCcVSsto8xbbS21JpyLVr91RzB/rC39VZ+49515QiUFwoGOqCAZX6ZpzMI7+BsjN+lqajT0e5hMYypCz/FhfYVA5X0+ndEAHlIovOhkB68jZ4NZvJOp7QUJ/VWYBGzPh7EW9vW9IUzlNVLAu/f5/l4PQ45wNmDPgI12quEVAJk+/EusA7N2KCutjUtBr5I9aS7Uh5LuWhIeN3v+DmbGKjjfU+LA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h8nrJAOYP2gJp58rTuD47IAIFCdCPIyv4yicOuH/QeZGXc76wpm94+vSNwM0?=
 =?us-ascii?Q?NeczxhYW8MrC0SY70nkBY5C7xIwuPFJ3hqDdY875VltC+Vuf3uc+drvh7p/G?=
 =?us-ascii?Q?yuTbQFY9FtPTjLuqY8dbLklxmfhhuGMe+Ddnjqg133U+3WMX5rcN63BkrsR2?=
 =?us-ascii?Q?KQHCaaicdLeVIRdi4LqFsR7PAf2+jjX2N3XhckPt0TnUWoeogaW2jF8rToaB?=
 =?us-ascii?Q?H7+u6xZHWAhxsXGljtR9SfIn+BzJ7SmiILAH3V4jTXxA6zyQTnxOOr3OwA9Y?=
 =?us-ascii?Q?82pVwS/C64OGrkg0kff4r2kn03KQG36AsWmbnzeZgDWIAGxGmNB4WaYbPSuH?=
 =?us-ascii?Q?Jr3aE+JaoRuasPmlTLtynJUSaA/3dc+K2adpjegnGpnSdGVf5hZQ4ng4zo1N?=
 =?us-ascii?Q?iP1PULK/3qxBvBqx05L7Fv631VuugBUnBbSDSckLqqZMqtNwQEEjqfGvWY31?=
 =?us-ascii?Q?xGFsp9SlxiTT5kdDPeW6g7CVzg7Qv7zGlmGNa4V2L4wHM02AS83xI3MK5LGr?=
 =?us-ascii?Q?kiVMJXSb+N6FmEVGJI6FOQKEGyAadrXoWD4p8eVTSUHVaHhj+MV8POVCAwvo?=
 =?us-ascii?Q?7GFmrjZ6LEfUJD6evsycWr987fAO6G0V2QzoQZL9CE1TmamEkjq2nr14c6JD?=
 =?us-ascii?Q?C7xgulZ3M9//WEiazU4A6EQAyA3t2udXtIuUZ2MRRYPBmI+BrjwaniZbHHcY?=
 =?us-ascii?Q?agVbUyujdtiNR+mQ4gmV8ELurASlKP8zHn5NpPC9hEuiBtWHC+9xEiDwi4bK?=
 =?us-ascii?Q?7WfvJCGWPqqsKJjjFowP/VJNYepSFgo9jRDSx2qGHD3MGhTS4s+iAJwYwu1B?=
 =?us-ascii?Q?PZ7NkLdVi7h4Sh7rHuBJBJSwiCADgRbCctmtvumdHdKoXZApzsHQcT0VfriS?=
 =?us-ascii?Q?veL5/ENI+BHFFmKcaFZU5n3xfHCJ3UiORqHm8wC4b+Ff1UKS8NWVKGRdWTPv?=
 =?us-ascii?Q?CFY2opBdzWuRnXY2VgfmJsaaGqCF59MgPwhO2VNjnWiDkdRkwVdpShiMGXmX?=
 =?us-ascii?Q?3knuIy1lfLFjGK/duKW0wfVAWD4OQ01tWzXKHFAFnaFrs0JcqNHAId8ljcuI?=
 =?us-ascii?Q?+bskJPyLVkCSoGL+A8lT7q4O3xvsnjDg+CMZXwUHDrlw9HWrVvqWENuB6RRq?=
 =?us-ascii?Q?mQkAqU7xG+0p0j3xsxfr2tUV1jBoguBePdtNrlrxBDZGLHdG/T+Jr57SxzjZ?=
 =?us-ascii?Q?l1urwS7KYfe03r2uhKUCMUnVlMSb1tTcMe8/JU3iLrLSvUeoOnqQPnKcmMXN?=
 =?us-ascii?Q?Zw2CrOtUKedEO3wt9kXuHrt5OZGUXUHMddaf5m5zkjZQI1sThh3JKZE/mZ+A?=
 =?us-ascii?Q?ZwQB/nkRQmWxe0xfy9/ILyOB0Kc4bUuP/kdvoAK5gXnYX9baEXxxfVRMIQKo?=
 =?us-ascii?Q?o1D0L1y3CTdt9MXzPWvBPMrFjUlmeMk0tkCSh15IhX3W+OKsMBrNATFZxVoh?=
 =?us-ascii?Q?Z8mRDdn6jdAJWmFfUSy4Jyrjw651d7b4zCuAqONwga6oycxELp+D6N7gmyC/?=
 =?us-ascii?Q?BJrUGQ8gYAED8MyL2XXVfD2kwvzBSpIGgj1jHkHcQnv1nXHXTqVHCGUlLhuK?=
 =?us-ascii?Q?RgyYKzgcX0/MrTq4Lzil3Dcj6CV/yGEqx9S9hTItABN3WzeQB2+ccyEtrp0y?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6a9ff9-1125-4565-baa2-08da7a0d3298
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:52.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYhMnxonMmDfUGhpSU3D0SMYpEMynu+ONdKEA5wtWCqZAhAqnLsmH6oX3qFSzJiQ89g8v+PAnkVbtzX7T3MSMzZyQ/647oadAJsT6BIu4yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/clock.c     | 13 +++----------
 kernel/cobalt/posix/clock.h     |  4 ----
 kernel/cobalt/posix/syscall32.c |  9 ---------
 kernel/cobalt/posix/syscall32.h |  6 ------
 4 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index c4457b6c9..7b1693612 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -385,9 +385,10 @@ COBALT_SYSCALL(clock_nanosleep, primary,
 	return ret;
 }
 
-int __cobalt_clock_nanosleep64(clockid_t clock_id, int flags,
+COBALT_SYSCALL(clock_nanosleep64, primary,
+	       (clockid_t clock_id, int flags,
 		const struct __kernel_timespec __user *u_rqt,
-		struct __kernel_timespec __user *u_rmt)
+		struct __kernel_timespec __user *u_rmt))
 {
 	struct timespec64 rqt, rmt, *rmtp = NULL;
 	int ret;
@@ -407,14 +408,6 @@ int __cobalt_clock_nanosleep64(clockid_t clock_id, int flags,
 	return ret;
 }
 
-COBALT_SYSCALL(clock_nanosleep64, primary,
-	       (clockid_t clock_id, int flags,
-		const struct __kernel_timespec __user *u_rqt,
-		struct __kernel_timespec __user *u_rmt))
-{
-	return __cobalt_clock_nanosleep64(clock_id, flags, u_rqt, u_rmt);
-}
-
 int cobalt_clock_register(struct xnclock *clock, const cpumask_t *affinity,
 			  clockid_t *clk_id)
 {
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 2607522e8..b5ab39b44 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -116,10 +116,6 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     const struct timespec64 *rqt,
 			     struct timespec64 *rmt);
 
-int __cobalt_clock_nanosleep64(clockid_t clock_id, int flags,
-		const struct __kernel_timespec __user *u_rqt,
-		struct __kernel_timespec __user *u_rmt);
-
 COBALT_SYSCALL_DECL(clock_getres,
 		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 30d7e1bcd..a245e91af 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -232,15 +232,6 @@ COBALT_SYSCALL32emu(clock_nanosleep, primary,
 	return ret;
 }
 
-COBALT_SYSCALL32emu(clock_nanosleep64, nonrestartable,
-		    (clockid_t clock_id, int flags,
-		     const struct __kernel_timespec __user *u_rqt,
-		     struct __kernel_timespec __user *u_rmt))
-{
-	return __cobalt_clock_nanosleep64(clock_id, flags, u_rqt, u_rmt);
-}
-
-
 COBALT_SYSCALL32emu(mutex_timedlock, primary,
 		    (struct cobalt_mutex_shadow __user *u_mx,
 		     const struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index c016c904c..0e06e12c1 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -80,12 +80,6 @@ COBALT_SYSCALL32emu_DECL(clock_nanosleep,
 			  const struct old_timespec32 __user *u_rqt,
 			  struct old_timespec32 __user *u_rmt));
 
-COBALT_SYSCALL32emu_DECL(clock_nanosleep64,
-			 (clockid_t clock_id, int flags,
-			  const struct __kernel_timespec __user *u_rqt,
-			  struct __kernel_timespec __user *u_rmt));
-
-
 COBALT_SYSCALL32emu_DECL(mutex_timedlock,
 			 (struct cobalt_mutex_shadow __user *u_mx,
 			  const struct old_timespec32 __user *u_ts));
-- 
2.37.1

