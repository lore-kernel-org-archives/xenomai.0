Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05274428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnWRog+Rcl8sAWkZCPwVOUwQ/P83FC00V+0K6DkN8dW+vb+PAUVXc35jtQFCRadCh7nbh9WAaXH421q9LusPvtCPIyXzx5fRfGlebyc6idS4D97MKRC/HHt2skyGj0ntjtznKSyQUIDNFiQjzYKyu7bL1/pKqkGmoZAtETGFqrFvqLVBZwmXxOa0exj+KvyvoaNWMfzqfnP80F44h+X851oKsX4IZ/0imF4FFA7c5QL6La7z5ISqSzpFk93YhIVU/j47hV4AqXEtwq8WBB406KOMFbQobfU8D/aH8dEKBVhZBcpZBEVvGdu+LUTCCepGyTIk9eyK8w0VoURvaHp/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeYksPI9xeeP7XBCKaE77V43QOufVd3xAet98Frjqos=;
 b=bj67l//53DsAA3xBWDGpNk77YNgfHxE02UM1N7Quh6lCl/TRyrQ2KMsr7Mcmh8co6J3DcH39lVPtMhZ+1AdXtvrbYvcUX9zBEZJpp0OhFqapQgWxfmXWTTP48SCMHuNp/XStVeG4uc18dUGPdrPYCoS3/qXfH5O7FSw7O4xX8fFSu2+/bLjPduMjdhvTU9vRxev7lKifpkbU5n1f35bv8biwLTbqu1Djv2RQI40sN/7MK+QvXg6lpZZx0F1bYUFi3FLO8tgpW2ya8Dd84KOOSyXVnbQ9EhDbc/YsQ2aCCr4DQ/rmrIJvreLx3WYGEBKEnyuH8pLop0x7dSk5GfT8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeYksPI9xeeP7XBCKaE77V43QOufVd3xAet98Frjqos=;
 b=UdewDjDViogrSEC3+DaDq5ops0BGqjP3Nc+ddmCLljNfUbCO2rX8iL0Yfb91sXIgGLzKqLF+oyJJDRPelRuRGkCTWzI+j+JCNqn8D4+n+OMxr3jVQiB/Xzzd+NIuhqpl8gWl5xhfRsj6vYOoiFeNrvFkbNnYkHx+TSjt14hBTbs2GAfLeP1lCsCMxi4zyQxuP1Vz9WYJkw3+Fl7BUuE1Ebq2Zl3BPvhoAmgjoRL+ryr6Yrd5ss9jSrl7V6szAvTf3tEHXIThle698lh+mX9zOLUE115XOlHC5PBYxAzhYZK01+1UoxOwDEQigjZ4BrZLg5KC6EwEEkJAbOG+18yqbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:43:56 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:43:56 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 08/42] y2038: cobalt: posix/mqueue: Remove compat syscall for mq_timedsend64
Date: Tue,  9 Aug 2022 15:42:52 +0200
Message-Id: <20220809134326.23688-9-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cee53927-d947-4540-344d-08da7a0d34dc
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MCAiWrMKVEoLXAz8tMGU1RxaaoFS8auoAIUiyxslYc/b0Hrh3pj3vom7Aw3ifRwXrNeHumwKAohufJUqGuLnKsHg7Ba5otZ1najgYSLPpYZorda50wdN0BCWGD0yaFej8NeDh7k/yFKHfvfn/Fjp+FZUsFO2gtq4DO7WT3OMK8VJ0bENwoyGYTPEeNRbX6Xvpwa2nuRGJn2dgXaV5bnA6nzK8GVj9dtYmEMj2JLoIIW5E0gku8u6HRb/f6IEr3MWQObTMwtO69wmm0e+w0iSgKDsSGz1E1s2CK6/w6K5b0rgZPWFZso/oALbe/WXp+bVeIPvyM6XrwNkl4pHZgX7Kr+NZijU2ObRhHnq0h05YlSvrzV7985ZNPnG3SFL40KiwMAGXKwRSXdATFO956b6QH3UiGeJ99KT4PX2HpbKx6GeHCWgACu6TMrHKeQMrWL89gt28tYIaUYFG6vf4yJhTzuKLhYTHUIOVF9JIMP7KjSi4W3N/7Owqo878MPpFQnXwwfqJvVDytOiSNVgW2HYQJz4z7H/bima9UMhbXzboqDUqQcTfCs9p+UY9oOKRMBDOGTBbNPK7dyXNKd5eIIkO2v+6iCrCBxG6wpaAlESSrAPtS1o9CyuYSp5KOtdsmSOa8muoSgZ0nMxLrq9IQSjEo+xwqjR4g55KgG35GNo2/oCIrN2v427/J+F5pz8rY+GX6/D3w97JxPSH69lr1PsXx1HEZTTL2LzE5+q9PSTHxk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(55236004)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hQmgLWwtYmSHELreM6HzRTg0+3q0dUTZjpk+AzzEumIdYO9TpEc+iNY2qd9L?=
 =?us-ascii?Q?YWKMzRCuQTbf02vmZpvmVRIL3M+vanfaH4WxFkCXvoGDMNOYYk2ODn7F5ul2?=
 =?us-ascii?Q?g3ckGwX8z9UuKYK+FVUj1ZS3Pc3NjQ0TF4MM+BROn9Upj7oFkPMiIw0S973k?=
 =?us-ascii?Q?Rjs+LiGi+315iS6F8rxBaZLMOZs+mLTSRlyZ7nKgZwLmIKEXvVRjnf/+upAj?=
 =?us-ascii?Q?cGH393Q5a3Qkpd4ofJ3i+eYbzrbx+Y0GkREIrW5jlI5jlSkZh7ApIK13H6hd?=
 =?us-ascii?Q?AdpY502JfDVWZ8XilcyjJz9zLokwmGLxskebENFXumBH9u+Fzd7Iu25MxCk+?=
 =?us-ascii?Q?4y8m86ROLQoFNJnGI3+QxVkj+EbOdnw5MX1T7bbcmVBQMHDpCZcw/lmUge2i?=
 =?us-ascii?Q?e90opR1ts8IIZo+TNrz2MvXMxEErzDqEkzZg4bOcpAJIRHwSVdz7nJoo5fWw?=
 =?us-ascii?Q?Wyyi0qVX2UjGE5dmn24XIvMInkkKcHB17l10Q8tWhISAp428WTx8z75Wsi/v?=
 =?us-ascii?Q?Ryo65F1VKdmEcV8HFGpLwLNGYClXBkuoBk5XqnAjQgF0dprUwKThEAldA4rS?=
 =?us-ascii?Q?nFE896g2/gYgF9XV6FsaXUqRg65d3OLyenrZgYsw3zn2kMnzEREatUlNWTtg?=
 =?us-ascii?Q?b2E2/wisS1hUvBjdERxIE7KpK6NZ+XBk9MyMGxTNRPFFeNc4Qvlwz0FbpKZh?=
 =?us-ascii?Q?T8QU6TWRED8VZ68d7QIO4qWBFNLuxAKCq3Yi7l6Zd7qvne+nP1iKQSUZXh5+?=
 =?us-ascii?Q?2MxOBwPHy3s1PtN789ct45WvKcDjoOO2WfrC7yjVouZW5TbjlK5QiVpR5jcf?=
 =?us-ascii?Q?GKjsAgfmupi1QZaW5tSUP4SwpHKO0meJeGGUEbyFhKmvy8e1LZA0zSYA7PLw?=
 =?us-ascii?Q?7/TgWhww6uRiM5SsYK5aW5Xlvxt7ogO8wGB34gxJ3I3n1p0KGzUs3RDfZZhe?=
 =?us-ascii?Q?uX9JIAo1aKsFrk/1mr//Lga1cjN00yDqCaJrVs6U6Xx7v1DC+rHKj+1ed1ZS?=
 =?us-ascii?Q?4PKvQGrNdIs5PVYbBSVuDpqIpfFPyaieOgW+jdsVP15NtAL0A0bkADdNcwwa?=
 =?us-ascii?Q?4QB2yhnPLwLvnxOy8DhAeg2CxTswoYyld/3l/x0MJNzw9OW8iW4yu2Umvaon?=
 =?us-ascii?Q?LikbosDdFa2Ooc6WSlj/Ha1XTcJkPyYqj/yD2N2a2ZPU3O9B0HI3v98hdeJ5?=
 =?us-ascii?Q?XZUsNQ7iv6F50Zlcx0jVFriU8VbK26BEEJTd6LPwMP0fqFLD98qa3afT1STH?=
 =?us-ascii?Q?a0h4bkJxL/9YxKFvj5stAz06PkgbOo92BwRujUZu/4P4qBH0ODhUc4X/luWs?=
 =?us-ascii?Q?zq5c/RjVqiMoVM4T6Qx2DYlBWDgjbU+Nk61UU9o3mSvha7pi7SkMhYWnSk4D?=
 =?us-ascii?Q?QfGCK+JnyMNdFTgHpfx4PtC+/0+KxqndWHaOiH/dfg4ZQ2hJ4656bsNOdvqT?=
 =?us-ascii?Q?qImE/KxJfB9ABL1vQH9tv0fvtBebpyLPsAvWE6WzB8nqjjFoGYslm7HAkvTJ?=
 =?us-ascii?Q?WE0/3tcd8D71fu5GxYamTyTExWpMatk5t0xVbCWRjU1c6zdKcpBatu28sVB4?=
 =?us-ascii?Q?uDS3pubaLlXWWr2TWGJbiJseXQuLuCnfvOy6qZ36La5YXZjukV0T0svhuo9y?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee53927-d947-4540-344d-08da7a0d34dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:56.7137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXLbXGR/Lm1bhYgYVWdGMY3eZvJZxdmay9ZlOKFcqP951Ypp3Mpn/TnBkCDm96qZ98lRJKnAMuelds1gFC4z/gnnz8zjU71UO6yc5+Rf4zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/mqueue.c    | 10 ++--------
 kernel/cobalt/posix/mqueue.h    |  3 ---
 kernel/cobalt/posix/syscall32.c |  8 --------
 kernel/cobalt/posix/syscall32.h |  5 -----
 4 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 3514ba1b0..4487e23de 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -974,13 +974,6 @@ out:
 	return ret;
 }
 
-int __cobalt_mq_timedsend64(mqd_t uqd, const void __user *u_buf, size_t len,
-			    unsigned int prio, const void __user *u_ts)
-{
-	return __cobalt_mq_timedsend(uqd, u_buf, len, prio, u_ts,
-				     u_ts ? mq_fetch_timeout64 : NULL);
-}
-
 COBALT_SYSCALL(mq_timedsend, primary,
 	       (mqd_t uqd, const void __user *u_buf, size_t len,
 		unsigned int prio, const struct __user_old_timespec __user *u_ts))
@@ -993,7 +986,8 @@ COBALT_SYSCALL(mq_timedsend64, primary,
 	       (mqd_t uqd, const void __user *u_buf, size_t len,
 		unsigned int prio, const struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_mq_timedsend64(uqd, u_buf, len, prio, u_ts);
+	return __cobalt_mq_timedsend(uqd, u_buf, len, prio, u_ts,
+				     u_ts ? mq_fetch_timeout64 : NULL);
 }
 
 int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
diff --git a/kernel/cobalt/posix/mqueue.h b/kernel/cobalt/posix/mqueue.h
index d9223866a..755623f47 100644
--- a/kernel/cobalt/posix/mqueue.h
+++ b/kernel/cobalt/posix/mqueue.h
@@ -40,9 +40,6 @@ int __cobalt_mq_timedsend(mqd_t uqd, const void __user *u_buf, size_t len,
 			  int (*fetch_timeout)(struct timespec64 *ts,
 					       const void __user *u_ts));
 
-int __cobalt_mq_timedsend64(mqd_t uqd, const void __user *u_buf, size_t len,
-			    unsigned int prio, const void __user *u_ts);
-
 int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
 			     ssize_t *lenp,
 			     unsigned int __user *u_prio,
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index d3cc79878..0197c749b 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -285,14 +285,6 @@ COBALT_SYSCALL32emu(mq_timedsend, primary,
 				     u_ts, u_ts ? sys32_fetch_timeout : NULL);
 }
 
-COBALT_SYSCALL32emu(mq_timedsend64, primary,
-		    (mqd_t uqd, const void __user *u_buf, size_t len,
-		     unsigned int prio,
-		     const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_mq_timedsend64(uqd, u_buf, len, prio, u_ts);
-}
-
 COBALT_SYSCALL32emu(mq_timedreceive, primary,
 		    (mqd_t uqd, void __user *u_buf,
 		     compat_ssize_t __user *u_len,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index ab7dbb945..5569af7d8 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -102,11 +102,6 @@ COBALT_SYSCALL32emu_DECL(mq_timedsend,
 			  unsigned int prio,
 			  const struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(mq_timedsend64,
-			 (mqd_t uqd, const void __user *u_buf, size_t len,
-			  unsigned int prio,
-			  const struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(mq_timedreceive,
 			 (mqd_t uqd, void __user *u_buf,
 			  compat_ssize_t __user *u_len,
-- 
2.37.1

