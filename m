Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F34428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQYFH/F1ZsEhbVEesZyfgpeHwZZdu19HFguAYXbzRV5u/+ncKTgwDPGcGY8QjScQWxT9SGG6eav8eFG8ZNzmJF3rlZ8kwq6Tdz7WvIHxkD5Mqi8fyvYm0C/0gOOrsaApKO7oVaJ8e4iedAMhJfFf+73ulGpFMz9YlatYuYTjVvkYG8XBMMP9MvowAfAIIUQ1z8VYy3NGM81L9bwGCZy7UzdIQRNmr+0oz4TIrHOzpjPNxC28FRaAGFojFlYZANRhSCR6JvVwTTVbvKXdnp4Z+LpIPYtZ6tKZaqOaEx443oc53P07rKtaXsnPFKbdhwt2IjJwAX7YiLbQatP/8axAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgHXjguYkCame7s/HG7ZQifJr3Iqh4BhAFfSOfrDevo=;
 b=c/rhrGsv5b9PCUPg7iU2zfGmCv/5JahAGQmCmMz9nWvmZE1z9pNHI84A26x2cVJIRmCpXB0jjGXu02L9YkigMnlSrUy2UbkUJTXAxJ+oGXxnBkvj5yqJ+JmWqbM6jXh/M5iAnK58xRip/KQCwRk+vOS3i+Ta+li0GBuXdGbbKnVIWcB9l56uUwKepg/i58KTBYB7NVD85dRGHAMQnmBridYvRG1c7ntnMNqKEJwX0DUcYUofL1qDl7tjhPSOYVoYCLdRHEguVl8DpszrnlEcI1nr92uOIejt+i6QyTMPCWcw5iEr4gGtuUCbyMOBWHcalsjF9db1uGrRMOhZ+Igl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgHXjguYkCame7s/HG7ZQifJr3Iqh4BhAFfSOfrDevo=;
 b=gqiFNUUvH+hBoTCSOI0d5pHsyCHNVyeEvDpMkZarQYn/oAqcP2KpiqYPJcWgkahAtNFza6X+5Z1p7d9gZbYuLINf3X9/qNIeBHcEdjQmKnliHu17eCNE7i7Cdh3TlcK6AmyINVHe+d8uXHQVHRZQSNEjIq36mH61BoAIKZ3J1HOZScEduQrPpFEFql4lwgR/Oi03bb2DpLFyg+46CbjtoR37dWmKNDt2JBp6gfJKC9h0aJXyigBEHL2F8+TyHuZOSld3R9uYFiAbJY3dEL+ygojT4l72IufTcSTHp+FMctKEUiyPBFLqITLQroPyygDI6oChNAFxLBi5uZ2hPtBquw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:43:53 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:43:52 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 03/42] y2038: cobalt: posix/clock: Remove compat syscall for clock_settime64
Date: Tue,  9 Aug 2022 15:42:47 +0200
Message-Id: <20220809134326.23688-4-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0601CA0026.eurprd06.prod.outlook.com
 (2603:10a6:203:68::12) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cdbf611-3adf-4e5f-aeca-08da7a0d320b
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zPa1dbEoZsSaWmpZ9e+jzR62Zh12hRkWPKD4HH0ne3prO8QWC8eFMbS4kiQIru2te7EiF5PS62nUTKg91KqftHcbzxIBiBfVFJiqQvsKdavTLKWJmZpSkz6gFyqwShwLTmjMxvkqj0ReAA0cis0xpO50UU07rp1deEK12UrTGUSVztoEE/d1+USJuGSAcdRriz5u6iw0vhXhdkwsnNQQIeDPrJGOt1ol6NIovrGytAbufjci8nG/3Qm3efg5vwhTmqTFMNXj6HXoMVjefK4VYoGDrmWGdJZxMXzy22VvVpWjDSP1PEIjyZv13vOtR8LnM3noCyYhBvIFWD3nFpGMuLk26iZTYBb7LLGg0I98gmhg6GSyUuxOi8R0FMXq87pYdsIwo/kLji7SaivEsByA5Id3u/rjvz1EGbkqdSpHltvSFlHjpUT1aT9sNGxvkPNseQNISKwiMPxWh3D4cEdiX5Z8FgE4/S8pGzWmccQs7qD7yWeUqiYvPCWprIcJwQjZChs6qgwd2Ljm2UniDqCPmJ3ncu7bCyEHrAXnhONbndPR8xANflIzzmwx0DHYKQwA7FJBqN5m4lqfO8X4OlCHhCJZSx/nKPBPnAQ70q5/4qPh9Tt/Qp39cO9rJFQaxfazaSeOjnnK/kx/oAeBE6MLNqd5CAxbAYkiTjBz+OWofyTTLJR9/zBsJmZ9VtbSIxSmM+0SQ4X4Zr5r3eir39y3YxbQS72LrkqaS1vxeWVlEIY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(55236004)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wGEcjuzjoDha+3ywLJpofyC2Tet8FqODUeLzJgo8fniHmDEfe5yD6YUpYLv8?=
 =?us-ascii?Q?NF7aVQbL+OOdbv+KWrhWS26f4zFtkWN/6KfqC+bjrhEpmMmmIGC6zv3MSMBJ?=
 =?us-ascii?Q?60uzYrxtEM63Q9+bHwZs6pDGFPiSwDd06DNPvWmj+W/Fxe2/epgckET8ycK/?=
 =?us-ascii?Q?kgWJo9uQHBglT1SaJtCo3b/azWE3Sw4KTqBVaEoJEcK8uu3myqShcQwYSASx?=
 =?us-ascii?Q?UYAfUVPZJMXG+c94xwM3bxJZhvgt8nHBIGmHI4wHuCkZnrJO24sMA5yTxkt4?=
 =?us-ascii?Q?lTKMJcm9Y1rD+y8Usb+7RAIiNkvmjkRAWkaHJXKEnjTJ+bdqYveThw/9jzVD?=
 =?us-ascii?Q?FIHwZqIMmkOxuvb0RcMgvGGm7OZ/QbToHy1ePR7fUOYBcrkkcPv7D+nou4B2?=
 =?us-ascii?Q?wo0x5vzcouLVL8B+jGcCe8+jVltibWIuZ092G7a0pcVnY0CVnFZciisMoAeK?=
 =?us-ascii?Q?UJaTClzBUVzvnlD+RvyLucRYI1rSIdHAFutYJKOyiNJM4eRScw7LoBBlnzKZ?=
 =?us-ascii?Q?ADtMmnAvy2mJDVCH8QcZ1Z6CEWOatWlvRYvekR0WlSdlN90WoAF8PW26XC1d?=
 =?us-ascii?Q?3C3wJHJJUwpTReyQX95Ij0SEldSCU4WS0/REPl+Gdy2fyPVq5XRKp4rjRfgv?=
 =?us-ascii?Q?mC7cTRsS0rguW5ImYq3fc4tgXv3Bg3mIjbtWs1vecvhuFXRz7bZBRZNByFGc?=
 =?us-ascii?Q?JX6aP8yP28jWdrBlbKV4nWI9HbmkaYc2vtdSNkIIlUWjBcyUqThMzAXPiVAh?=
 =?us-ascii?Q?y1XBqo3SwbMIYTQ5omOhIpdJOtlKAt/Meyuko2e8Bn4XAKg8P83uYXU3TvWn?=
 =?us-ascii?Q?UrTHc7PC9kJ2cXOxepleqteAG8Bl5DUAWcRouGq1XipHw47ID8hEJWzbioLt?=
 =?us-ascii?Q?Bg3eW6Z0eZfZ/76y6NYC0EkM/DtuisaJhI5PIi4whb2LVhAXuXjL2C7HUuVU?=
 =?us-ascii?Q?vW1JwdIzRwPIf38vPJhQj5d8Op2S6ppodgcZh9XS1t3qYU7in97kuTEOOGnA?=
 =?us-ascii?Q?nBEqQvKT9qG7DuHI8mAiBzaoBZ97/0k55JQFecnwMO48UjWT5YKlVvKJJE3g?=
 =?us-ascii?Q?xorKCL67du0ObnHsprOdb+W2wJ6E58OXzGZFuxfKp7XeGD4gRa4jrwF+ZQaQ?=
 =?us-ascii?Q?Ur8ecRURCYWExKwqbwqAAGwingrfawrcsG7j1CEtRVIeTvNDpPcluejEP4lW?=
 =?us-ascii?Q?7zrpnEIy3UN/Cg2EFpCBHCCRkEqFkE7ZYvqG8lOp17/TAmkBxxO1J2CM/iFX?=
 =?us-ascii?Q?ayVSIWLBByCrQAgnnWoSw+y1bsQqshUB4JxAESZAjZ/T1HeydZgD+itnaPEe?=
 =?us-ascii?Q?EESCBkGrup/yroeGYtgc29X+iFGDP4fjQjfOQJDLYr+el+07TX8PqmBqRZNr?=
 =?us-ascii?Q?fYaWPbrh6cVVinonII98PEWt4hHxN6x9g32NJxf+YkeSXO+rMCr2wIwnkBI5?=
 =?us-ascii?Q?Ft13XewExTTgov1fhRUNiII/bFIE+ioM1swsaOvCK7P7Gr9uIE2oAHw5mx9v?=
 =?us-ascii?Q?wEy0sAbXyJ46HMuklnsapdoF+GJnYEsKw+1Dt4MXnQX/XSqkgcSrnakN72Sg?=
 =?us-ascii?Q?XwGBukzVbh78Q6KcfKgJJnNCY0fnSNzpk7awt1iINSBsH7eu+r9w+A10rMxd?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdbf611-3adf-4e5f-aeca-08da7a0d320b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:52.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iCCqJdDRTJft97571bfw8PWtWjHSl+oAMyoZIKG1QBpcxWw3Fzh9xxL2DKXpboyEOeHtVwJiBkDba4Nvhv6riEU3laHdHIUoxZlBS3rRw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/clock.c     | 11 +++--------
 kernel/cobalt/posix/clock.h     |  3 ---
 kernel/cobalt/posix/syscall32.c |  7 -------
 kernel/cobalt/posix/syscall32.h |  4 ----
 4 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index bd393bb11..c4457b6c9 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -232,8 +232,9 @@ COBALT_SYSCALL(clock_settime, current,
 	return __cobalt_clock_settime(clock_id, &ts);
 }
 
-int __cobalt_clock_settime64(clockid_t clock_id,
-			const struct __kernel_timespec __user *u_ts)
+COBALT_SYSCALL(clock_settime64, current,
+	       (clockid_t clock_id,
+		const struct __kernel_timespec __user *u_ts))
 {
 	struct timespec64 ts64;
 
@@ -243,12 +244,6 @@ int __cobalt_clock_settime64(clockid_t clock_id,
 	return __cobalt_clock_settime(clock_id, &ts64);
 }
 
-COBALT_SYSCALL(clock_settime64, current,
-	       (clockid_t clock_id, const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_settime64(clock_id, u_ts);
-}
-
 COBALT_SYSCALL(clock_adjtime, current,
 	       (clockid_t clock_id, struct __user_old_timex __user *u_tx))
 {
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 169d51e62..2607522e8 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -106,9 +106,6 @@ int __cobalt_clock_gettime(clockid_t clock_id,
 int __cobalt_clock_settime(clockid_t clock_id,
 			   const struct timespec64 *ts);
 
-int __cobalt_clock_settime64(clockid_t clock_id,
-			const struct __kernel_timespec __user *u_ts);
-
 int __cobalt_clock_adjtime(clockid_t clock_id,
 			   struct __kernel_timex *tx);
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 917a67625..30d7e1bcd 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -186,13 +186,6 @@ COBALT_SYSCALL32emu(clock_settime, current,
 	return __cobalt_clock_settime(clock_id, &ts);
 }
 
-COBALT_SYSCALL32emu(clock_settime64, current,
-		    (clockid_t clock_id,
-		     const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_settime64(clock_id, u_ts);
-}
-
 COBALT_SYSCALL32emu(clock_adjtime, current,
 		    (clockid_t clock_id, struct old_timex32 __user *u_tx))
 {
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 7d448d0ef..c016c904c 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -67,10 +67,6 @@ COBALT_SYSCALL32emu_DECL(clock_settime,
 			 (clockid_t clock_id,
 			  const struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(clock_settime64,
-			 (clockid_t clock_id,
-			  const struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(clock_adjtime,
 			 (clockid_t clock_id,
 			  struct old_timex32 __user *u_tx));
-- 
2.37.1

