Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048FC4428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvVIVBRSXdsspuruzrGi3laG37P3icpSxliTrPCSH4F0H98WB8xRT8QnFpLf8MhPbQHVqh6n2jpyUWe01EI+TqAtbP+XyErpt1IzJMGB8g1tqvgTQpqfU/wokeyY0KgkBmsz+9T1nphg2JwWkikqmeESLUIi7o7DIZ1ahnWaNiirIwdh2aKCG+BhXTSTJxmRKutKiOhkF9tfrWHTIOW6fjWlJv7PZ1N00KBfS0VpHoUJgXSSDSbXjUmgy7NAL4Bbn+PhRc5t7H1/o9zVspougMbsUGKCDPXM9p/T4FbPu0V22yknux7SH8f7Kiyn2BylVAQFUUc0weATeWIGI8iaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl/Bo/X5wLv2eeZgmxQNi+1zHs+BSW5sB2eSpleZYzU=;
 b=A6ma6BsAxh+ai4UUz2ootwANHStVCO2uqNQLThSq6SihWkZ7X0sMwk1c+zdJ52rpsrjQnx6vjOYmHtT6TaSyuXmUtpQ5pEdTjjcvDvcci0lLbA9UkLvctcW65xN32W2HDM7MrwVciW0Ff9kv/nE/+HkxNksa1qcVsjB5LMC0bczERXCFDWnLRtdqaixfUBe/QhC/xKPJQ8MY7hy+Jf2zFj6YviM/HBOs7B3ZGjQzMnSRXZn7XZ8Qm5gOYbna8/BpSi13wFe8odnNvAtrkeHcKeXkDCMOOh/GmBs7xum9hGoe2ycTUVonOTsFuIgZVVNUKV1qS6QmujNX3Km5hV8Iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl/Bo/X5wLv2eeZgmxQNi+1zHs+BSW5sB2eSpleZYzU=;
 b=Zlj66R8BbdqXAfkGoefMaI2jJGAQSFee93DGeuuZ9+orlSsWVegFCfKV7/ai89QDeYK64+Xct9B2gyyyI/3ccQKGtylhvyTWZZTUTMKvyGCMmFJbdmKxkqd2S/taX2/gnaLz5FcfrMQRbMKYO14Aykio966hZymTX5Of0y5UY6Ife038Ac1P3C2l7crwsp2hJ20GVe95uRyTnNSWBl1naPBK2AuL0uuYKInj+JvSS5edPab4tlgLiYeFjxiekYw4ltjN6w/+QI/AlidGeDkOdTC9sMJF8MoyzL4A9mxWSa/qpb9nWkuA4yxhTKaCfIfZsZiIoAzUfX6SOa7spo/tNQ==
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
Subject: [PATCH v1 06/42] y2038: cobalt: posix/clock: Remove compat syscall for clock_adjtime64
Date: Tue,  9 Aug 2022 15:42:50 +0200
Message-Id: <20220809134326.23688-7-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17350076-a2df-42c4-3215-08da7a0d33b9
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	atz0dG8h2JCh7faXkGgkhdZSE9Dsx4b8BR3UHDqhU5mzLo4sDyc3eaccffSZkzWZ9iZKiwL6j5XX2iO5EcwNc0WLqem9J/TQ++inELoFjc/+LIaZadKPhJ32dy6R0Ee5p20DY+raaf1pH7tqmVTJFfwcPF6n0x8Kr8X7cznjqiJHW+T5+fjuM9HzhT8VxMqNZ02j+W6MrWkv2DgOB9ScFPAzrMpbnzVSLoP26wJFP/fQo6Uez4Brp7ZB2vcm+lN0IjC/5baTDyKbGQ+EWAH+Rcpt+975zDUsAfEFtj/nG/z1gfVjF44YTBIpqJ5n5rdqqk/AABWmNp+27GsV6ydvW8oRY3PzkL7Uq4FtzWCTdVZJ3ckMHj+Q7P0Vo4/omyUQ8Cv14E9WDbmia3MCWMzirFIDrhUT7Fr7GtHQ3YCvO1uMfP509Uh/ZtxFh/vRekhu/ldfHf4JzWuMgWRtUgNwpG4Z2eUZsqq1vH1mV0kIF2f/jkG++m0l8Qy+CxdOC/03G0ve1Wcj2EbS3tHNJ5bjbPpi6MPdgGm73l4Bufojg290WyI6mcXa7uNvElVQGogFOyaIO5TtqiI+xzWtOtQ0gQR10bNc+L/kMeuX7JDzeMzerxcQPCxDDVM6NWphuOqqyXVXW5KsBkbbyDuMKcSm0N6qVqwZOaUSGVDb9ABAP+8FVUgdaibSJlto7k6STICBaAZg1x6bSMKGNRYNMyK04yL3eVYzT4ANsNzGm1LwcAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RJMCZmy1D9b9kZTaGvFDU/yFQ3wXgk3t4ZVxVuMNFT3gTsnmq2dNf+wHP6CD?=
 =?us-ascii?Q?b7AQGo7blKh4YGZwsPzZEa2es0xck7afH6Kg39LmQRCSf+7d/9MCUF9/Be1s?=
 =?us-ascii?Q?MWmIpwneov6GRvKc8WxZESYcVap87YL6VxwpT8Jw0OJDhQFhJZeSlXJv/l3z?=
 =?us-ascii?Q?satuAz60Aw9q7RAfwAlr16FtxtLIQVplavctgma+AvnlkhMQGAHGCHVYHdjc?=
 =?us-ascii?Q?zsG4fH6L+D8f5Kst5UFhZ4LuVZxJug+nitqO4rVsqRYNgfiLcZbKPpVKqfRL?=
 =?us-ascii?Q?wdkqiHhgLTBnvVKHgn3fvtNs/vc7p1MR5w+1gZ+559D+BkSuZWEmLEh1pyYE?=
 =?us-ascii?Q?hqrrYm131BKgN0xOvPJj4WUsk5tkYeddK+UvZPm1qM9pY723zzpLiXeD02nZ?=
 =?us-ascii?Q?qAy/hRtaNaqB26pXKIegcBAXFkpV+FlQnYVqw9aE+l6+gdzVBa0/P+js9478?=
 =?us-ascii?Q?CBlHvI7a4y1AdVQc4U3qsA0wnU7ksWGsjLa2DSZPRwDLBbCGQrNb1Qg+FwuE?=
 =?us-ascii?Q?BdQ/WJMmSywspKcBz/fpWByo/HQw6O+gBpMtAR8ZA6fVHjwim79YPaZs2CqN?=
 =?us-ascii?Q?/qCfLyUMfbC3MoxVJOsJ1m6brJqbCgJp/gLMwUF61PKbBUp0FsOpYrA5zQMW?=
 =?us-ascii?Q?KuVwIMtuRhMKUpwlJVlFtIYAL0Nt7E+BXrHDCL6vTVUZmvpmQ+OZXJ/T5SyL?=
 =?us-ascii?Q?byauPvMN751P58+VuqXkoZGlH/2RCAw9kcGChrG9DSNap6BCN9OyW7FCbfG/?=
 =?us-ascii?Q?KLtvA1a+7FZrMJssa20L1x1Yqx0TYAIRZNRyDEFcqmfTdM/TeykrDAksz9rv?=
 =?us-ascii?Q?G+hlz1pEnymjeLYwajLxKKjX0vO3vpz3lmbq4g1ByvR2ht/BsKbrJ2uPL2vn?=
 =?us-ascii?Q?LSrbiB0nTy2BtjSkBLzhSedB8ycqcRqya1j+tfIGlWWR/fMQBKfyALlCW6IL?=
 =?us-ascii?Q?QkAkv0zDpnT6WQtUEjQGX2XHhksQr6Jbva7R2z+12etV6yT147fy/Lg0UL2+?=
 =?us-ascii?Q?+jl3d1cml12/qKPeq9DqaKUn0aOyvG19cfoEhFcqvkzOjMKa49Fw6geFn0mM?=
 =?us-ascii?Q?LEW0kQUNQwfG68ewHLa3uvpG7lYpF8DJ0zlf04NUTV3GBn+dH65gNAPVoqap?=
 =?us-ascii?Q?S0TaAkegJs/wwUMUgiPhxqgtD4ql+IIM8waIuiXEbcpW/xY5XsGooFGkx96g?=
 =?us-ascii?Q?hYYQ5He6ibD3GpXRQOlwYg++uf+M0CAL6ivSuydeNXkcxgboaaDUIMvhS+t9?=
 =?us-ascii?Q?9KLUKCc7dgeBzdTyj307hhklq6Gd/sLCjRNXY+rUMk5U7RLvY4o4aQJjMk2H?=
 =?us-ascii?Q?mcHtutuiFUIqTemMSuIGO6r93+A0SOsb2aBMaqFmzAUgrVMSLVCLTdsVMed0?=
 =?us-ascii?Q?4Y9DiXXUKCk8wQBDIVfmKYiAYn7fu51tVbN0Yz6ioqB6VxbRSd8uqqxF5ave?=
 =?us-ascii?Q?o7YbPGsUWqzCW/2m3DsMzzbp+s+vR/motagOPBB220KkJm0JixN/vPSm4dmM?=
 =?us-ascii?Q?MQi/lg1YIEWExlS9D50u795InocFePan5HxdRxu+3yXibvoXJVpslHXW21Ns?=
 =?us-ascii?Q?3JE27DPh3rO2GW/aJiBdkFq0CPKLnb7FjGvJY7focUrB+nd2TGCla/81T9QI?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17350076-a2df-42c4-3215-08da7a0d33b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:54.8066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rW5zhETf7j5E7mkcQp8aM6lOERQiCtan0wnU42DLzJmC4LDGoZIF+HzEzX0BIPDLo+CryVkziujp2AZEZQ3YQkkDbcq0/vo1svCl5oY51iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/clock.c     | 10 ++--------
 kernel/cobalt/posix/clock.h     |  3 ---
 kernel/cobalt/posix/syscall32.c |  7 -------
 kernel/cobalt/posix/syscall32.h |  4 ----
 4 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 9de90c728..266ccef52 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -254,8 +254,8 @@ COBALT_SYSCALL(clock_adjtime, current,
 	return cobalt_copy_to_user(u_tx, &tx, sizeof(tx));
 }
 
-int __cobalt_clock_adjtime64(clockid_t clock_id,
-			struct __kernel_timex __user *u_tx)
+COBALT_SYSCALL(clock_adjtime64, current,
+	       (clockid_t clock_id, struct __kernel_timex __user *u_tx))
 {
 	struct __kernel_timex tx;
 	int ret;
@@ -270,12 +270,6 @@ int __cobalt_clock_adjtime64(clockid_t clock_id,
 	return cobalt_copy_to_user(u_tx, &tx, sizeof(tx));
 }
 
-COBALT_SYSCALL(clock_adjtime64, current,
-	       (clockid_t clock_id, struct __kernel_timex __user *u_tx))
-{
-	return __cobalt_clock_adjtime64(clock_id, u_tx);
-}
-
 int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     const struct timespec64 *rqt,
 			     struct timespec64 *rmt)
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 305400148..dbaabbc5d 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -106,9 +106,6 @@ int __cobalt_clock_settime(clockid_t clock_id,
 int __cobalt_clock_adjtime(clockid_t clock_id,
 			   struct __kernel_timex *tx);
 
-int __cobalt_clock_adjtime64(clockid_t clock_id,
-			struct __kernel_timex __user *u_tx);
-
 int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     const struct timespec64 *rqt,
 			     struct timespec64 *rmt);
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 2e7c2fc93..245ddb2f0 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -196,13 +196,6 @@ COBALT_SYSCALL32emu(clock_adjtime, current,
 	return sys32_put_timex(u_tx, &tx);
 }
 
-COBALT_SYSCALL32emu(clock_adjtime64, current,
-		    (clockid_t clock_id, struct __kernel_timex __user *u_tx))
-{
-	return __cobalt_clock_adjtime64(clock_id, u_tx);
-}
-
-
 COBALT_SYSCALL32emu(clock_nanosleep, primary,
 		    (clockid_t clock_id, int flags,
 		     const struct old_timespec32 __user *u_rqt,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 2711fb2c8..b7baee94d 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -67,10 +67,6 @@ COBALT_SYSCALL32emu_DECL(clock_adjtime,
 			 (clockid_t clock_id,
 			  struct old_timex32 __user *u_tx));
 
-COBALT_SYSCALL32emu_DECL(clock_adjtime64,
-			 (clockid_t clock_id,
-			  struct __kernel_timex __user *u_tx));
-
 COBALT_SYSCALL32emu_DECL(clock_nanosleep,
 			 (clockid_t clock_id, int flags,
 			  const struct old_timespec32 __user *u_rqt,
-- 
2.37.1

