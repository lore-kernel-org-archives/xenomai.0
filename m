Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014E4428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIeCGOBSjgpf/9tFu55l8/cGcDIgnmVUTcN4XS4fNMtejMDVrQA/NtVGxn9B5xYl4Q6/OAXuenkwwc/X9fcaq0g43RF2JhgRCtJFWgwVVFK4ccHdNYPmI2b6yyp4tLVSwOkY+zD+Ht+SURVUVntc5uMSSY3+FGeuLWYHNcd8h8r1hok0FPLEwNrXcN2TS9wYJRZr5v+suX+jl3H9g7gRafrZ6MrwGlO9UTgQ8jnpEy0QDPiNXsxqYbvkBSYgcQNWKh11dg/eb5Rj1oXAUbX3W27GLpOZDwWSKfktZPBE9tiz91R1lFCUvhbRurI6S6Rks3YVkODRlWtYQBjxIrHG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/fwXDuamMr+EDHpby9CBchlciwDU/E/71p2qfA/RLI=;
 b=SjjeLKb3KVZSjxB6NVe96J74SBWdygsdMtej5Wmb+pNuHIUbx4L9k1A2oQn4fz33EvVxnJFdfUU+fMsjk8DdlZ25pfxAP2yoVoObp33wo3qKpge8Oo9VKiRWZzkRQr/CpLkrLu5BRsrK/WhKpELyE6tv+aeabmNVW7aDoITOEchXJS/GKG8Da+xfDfKo1Kgv7Af0Sr07ahsloxQjxLnW3hAcUj787sNmOqcljOrKpxg8SXFCvRptorILyMh9pihK8n5Y89o93E5hZX1n+NZvePvhoBfbASAL5AYive/xL1xkM4AZDKuKXSXSSc+eTeFsETiJbg7fkT8GMursTF25nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/fwXDuamMr+EDHpby9CBchlciwDU/E/71p2qfA/RLI=;
 b=SUplb8nzp63LjmEi6QRji6d+AbHhrZLTtsuyd71rC4pdyGb6TH9b3ATwJCsOrTwQ2D6+ia1bfJ42F1OAe+EilyeGFalmDv7Q4z4XwAE3anWfAgqTxrxyCAZ2gUVEo7Po9uOn+wNae0OZoU5RAmYlWqkuEJKUkcSlhgu+GdOd2fAcXZc1rxuGoQD5MKrUYMvn9FJV4VJtnKzFzjqWVYThEg/7q2JuZv0RZwvNZNnQiQqEfOCf9kOWG9xb/4gDqQTrMDMZEWHc7KjS8h4600fSzrpb4nmpztscWEfjmT3Tq9ePRCZAMoDDrconbCo9ugp3GAL9/92yuyVkUnHI/4SGLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:43:50 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:43:50 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 01/42] y2038: cobalt: posix/sem: Remove compat syscall for sem_timedwait64
Date: Tue,  9 Aug 2022 15:42:45 +0200
Message-Id: <20220809134326.23688-2-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:206:1::18) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86896a52-a2ed-4345-3883-08da7a0d30f2
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zwsE1VToj1jHYY8Z85F4lRJRpMRkDkmM/skPpnYFfetBHHxJZl/asx+ICpTlj3N96dU3/WPMPUoppfl49F3X4YiN75CZi+SVTdmNQ0qrAXqRFyVVm0sKgOrff4QVzftLr6IJ30s/RU17FcEUJNdVQKXu6wOwRtFuFtKjTEskckFLrwtbojTR6wXSZc6VgVQvI1mwBMQjp0CWzVQaOQAe+3KfLNLWcvBBiQQdsCcEdjUHAY8U6Joef6CspSc+3yBnLwT+rZQCCFzTVC7P07hZxv5OtGvcBUwdS+qBaCY/VooVqrqrDTk5tLuPJ0NN1Bv7mB48wrDmQbhZgpqdsI1zrvXGuabKyiWrl6lK/uJJO231UW0T1WePVMELuKPy0duOKYtv371MUpJL6Y/oz2SEj2Ok61VhZE9U7MLsIse68fuY1+7E9+s6mg3hqPp3nkR8g6NdzU/90+LPSZMURdvK0yesceWNYrPGPDXT3GSdhjD1sBODw7QEFe68r8vdrrmIpp0ZAWvApW5hW+k0rKfI1ItLEPeojOBAVNZo18o7gTWDqR5VfDYzaTvMMv9hWNr6pfnPvHENvBQvDdKLLM3psLakacOJ5gDbX/7QGdW4HTWCqZHdHhRvUq3aKWyVK5EqMcvyj+IVMbVwYcJzM7zNBJpRusyPBSKQNPKB4pT8l4HAMunVjhjK9ZYY9QBb2g89Fc762If+dg+RIA52fbPKdJ2hYcTbfe+Zu8dUQeHcfRw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(55236004)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fV8+/geYvCGeowfl0NRk15F9xZ4s1rXpm83zCqcptaZcuO0Yz9He7MqVm2BK?=
 =?us-ascii?Q?zS6SzG3N9VHfsBryJ8mqZ+YzOz/ceibhfD83fFkmMvNpKJaavkz+EL5l738u?=
 =?us-ascii?Q?Fr8Zxjmezwmv5r23owSyrA74XNY1x0ZQKBupjbRGab2Q6YBdz62LnzuJOOLQ?=
 =?us-ascii?Q?aNnOIInFbr+PAKomaGSXbjNjm/wv1oWfmnWTAxDKGPTMwNptNCJyGh2CjWTx?=
 =?us-ascii?Q?W9Hx9CwTvaitgfTmD2ehPw+6NAjGOIMFv2Vyx5Xf3LAgbQFEGeUr8O07cQZa?=
 =?us-ascii?Q?Eiws3siJvdMh531l6M74hhdpXY0sMG13QwZ+J0KH0f/OKiYsUc2eeFC9CWwk?=
 =?us-ascii?Q?DTgLfcezfkVEueTK0kp8EvsSkTFdXWzwu+0WTyUZTjf947Tmm7bBbk0iH3Qc?=
 =?us-ascii?Q?xQkmjv445aDrUzRyl4lN2gvGavksgyaNAU4+be8KN5rw8AoU/Km/uARXSnGy?=
 =?us-ascii?Q?ZXPLx77Plgpgza7nQak6XPZmcJ2VUQ4ldUIb7GIcBz2g8XNKpRq5XQ5hdsDg?=
 =?us-ascii?Q?x09I95lYkj19QuhfI/4OlOW+kO2yMBZH8IO/5XESkgR+R5zaXHpAyBrpBZ7t?=
 =?us-ascii?Q?2M5ER0XIiR7sKMQRscQby8ZB4l7sypwcrnhs0+c7MbZfkgPPrYUlm26NujfW?=
 =?us-ascii?Q?bydaAE8vsMkduztp2Mhx/1eZc/qh8NaBHC0wEYcIn9UfejK6mSPWwFbT6sHh?=
 =?us-ascii?Q?KN+iMW+dE5XYeDfY8z093lmJykRWXQsTTAW+Lr+jtkwLMJhV2bMkLK3xDMfD?=
 =?us-ascii?Q?DE4OVqD0iRp6fH/VX/JVjuLx6gpBFv3otXf2iIwmEcg6u/7huGYD/LYUk1z4?=
 =?us-ascii?Q?VftguzV3YpeSm4hliacId2Lnd4OTLs8coEsXap99O4Dc551ThyqB+Rb03hDw?=
 =?us-ascii?Q?w+W7Y5t6eYouhUNkK+ffFX9q0h3xhRIyLuRRRF3d3QJ93O/UjQoX24LYaAoI?=
 =?us-ascii?Q?BKrAcr4PU0SJiKf3uoP0ngtVk5ZHufmVIVHsWqE/azLWybedKm4BHQhffPm8?=
 =?us-ascii?Q?iXchhgfchB6/Xmbg1fmwBfjp/9lYwfz8Ugy2XSJDKdiqO0Fn/JijaTTGC+6p?=
 =?us-ascii?Q?3/KprFtHI79ivwIvT7Zq2molWv6GvgXQxdoF4MGfg23el++rGN4xWXRZ3NnV?=
 =?us-ascii?Q?PMcDcsGDxL9uXOpHSEEhPQAvax2GztXPNhuvqwkqpX+KcCNGLDv3wi6RfwvS?=
 =?us-ascii?Q?4vkBUThj0v/IoL74aC0F4yxmKDHXYjaFvvLBucRLP0uHi4m2vk5ewagWoP3y?=
 =?us-ascii?Q?ghyPlUNFFmVANwR7IruOkQKS9wZx2cqrlAhfkk5FG6T5Bx6gqFlpjQp1D2hy?=
 =?us-ascii?Q?/MXKdq1ZrJc3EDxSajy6/MJzT+Lvnn7QoZb/yJST8dRV4RKH5wDlkM5IeFyI?=
 =?us-ascii?Q?+5O2+FBOTJ3TeHPrGKvniynUViLWzsUpI/DxzCHl3rg25BmtTA1TfUR06/0O?=
 =?us-ascii?Q?4eMNR1fRkTDYL4wbUpmjv4n9KUQI/2ohw6q3/JRgRnzCoOS0I1bJzJ+8Ie8j?=
 =?us-ascii?Q?iXMjWRvoRqp0LAxl2nCVJzVjV9nAnH85jXaiMsMFZoKugpptFJMcP/lYkCNT?=
 =?us-ascii?Q?fvnbxS4i0Nwko6JNxrggUqFuWqxCYmVAxHV1rv3jLHK4Zd/RtJ8lO6BOEZ+p?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86896a52-a2ed-4345-3883-08da7a0d30f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:50.1627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41weySftzw42DZu73on9jGIfEPal3f54pqQvFB01HisIx6DlletkBxmTpAW6rzwOOWz2qprJqA5RPyNvCSODDjp/Van6wUwNp9DFgTLsFXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/sem.c       | 20 +++++++-------------
 kernel/cobalt/posix/sem.h       |  3 ---
 kernel/cobalt/posix/syscall32.c |  7 -------
 kernel/cobalt/posix/syscall32.h |  4 ----
 4 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index 71b8c52f5..869260924 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -360,18 +360,6 @@ int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
 	return ret;
 }
 
-int __cobalt_sem_timedwait64(struct cobalt_sem_shadow __user *u_sem,
-			     const struct __kernel_timespec __user *u_ts)
-{
-	int ret = 1;
-	struct timespec64 ts64;
-
-	if (u_ts)
-		ret = cobalt_get_timespec64(&ts64, u_ts);
-
-	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
-}
-
 static int sem_post(xnhandle_t handle)
 {
 	struct cobalt_sem *sem;
@@ -485,7 +473,13 @@ COBALT_SYSCALL(sem_timedwait64, primary,
 	       (struct cobalt_sem_shadow __user *u_sem,
 		const struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_sem_timedwait64(u_sem, u_ts);
+	int ret = 1;
+	struct timespec64 ts64;
+
+	if (u_ts)
+		ret = cobalt_get_timespec64(&ts64, u_ts);
+
+	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
 }
 
 COBALT_SYSCALL(sem_trywait, primary,
diff --git a/kernel/cobalt/posix/sem.h b/kernel/cobalt/posix/sem.h
index d7dbb9098..e1e4d68f0 100644
--- a/kernel/cobalt/posix/sem.h
+++ b/kernel/cobalt/posix/sem.h
@@ -66,9 +66,6 @@ __cobalt_sem_open(struct cobalt_sem_shadow __user *usm,
 int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
 			   const struct timespec64 *ts);
 
-int __cobalt_sem_timedwait64(struct cobalt_sem_shadow __user *u_sem,
-			     const struct __kernel_timespec __user *u_ts);
-
 int __cobalt_sem_destroy(xnhandle_t handle);
 
 void cobalt_nsem_reclaim(struct cobalt_process *process);
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index b65a0a760..2b4911c59 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -137,13 +137,6 @@ COBALT_SYSCALL32emu(sem_timedwait, primary,
 	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
 }
 
-COBALT_SYSCALL32emu(sem_timedwait64, primary,
-		    (struct cobalt_sem_shadow __user *u_sem,
-		     const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_sem_timedwait64(u_sem, u_ts);
-}
-
 COBALT_SYSCALL32emu(clock_getres, current,
 		    (clockid_t clock_id,
 		     struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 55f08121c..f36fff272 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -293,8 +293,4 @@ COBALT_SYSCALL32emu_DECL(sem_timedwait,
 			 (struct cobalt_sem_shadow __user *u_sem,
 			  const struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(sem_timedwait64,
-			 (struct cobalt_sem_shadow __user *u_sem,
-			  const struct __kernel_timespec __user *u_ts));
-
 #endif /* !_COBALT_POSIX_SYSCALL32_H */
-- 
2.37.1

