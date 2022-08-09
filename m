Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081734428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCCAhWfKUFEOCoZpPyPUlVB+1/4gkl2BlHm4Ekc45/uuxMbUt8MuNeEjMqY4QUsmeAxM50ozySMqXYSDBqXFl0NspImv0aJkXstZ/KRLF0gNyFXZ7Flw9wNtaB3mCcV+aryaSoZ5jYSJGEb3wU/qV1rBGxQaZLBoxp1NXOkwYZqlzRSbIwMLse9p/P/Q+0OHPVtpjDKqgmj2VKQfASVijU/n1m1wpN5JtJlqfJvQXYTzWMeKG/6kHRq4hBNq3YajjkOQIev5L3FD2P4asBiRFQZvChT+79tahFvNCaNYlcTMRONSJ6j05tU55zHyXo8RLJVYVvL1Eo7CjooF1Un87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRChNkQKRqbiIzZO6p6jBgdjA2jCGA7ZwMWLmWxBCe8=;
 b=PDidGxTVGzSKm7mtZeS3Evo5dfHlvYKnzzVXYjgu6H4Q5aBKfywH0bgWnxLcoj9fsg9Uy8BXRTFRNQSiUa9nSDZ+uiqApkvLDocHLiir2OWM93SMbCWn1rXeE/Dg0bQXsMTFIu8o9+CwADGhf8gDqOPMZrx/uTuE10Gwpux8lGnwH3/Z0IRtcWFDxdBtfZD8auThxwasJDnGVNVPCIfe5DPMkP6Ta+UxoEIyEhQU1pDPMqpirF14hAGY0/OA1PGa7LYCccqx5CQ8kILxooNLIc8Tz/0wNl5tnDeui1gy5Ltwjbkypjrw3/jpqY6HtfaCEw+exC/G2AKn+NH32CNbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRChNkQKRqbiIzZO6p6jBgdjA2jCGA7ZwMWLmWxBCe8=;
 b=z+eVOjlqvE+tkSada562Nfc+I9G4i2/4aHusCd1P5UFMDT9vUvbYjAt8KAwXiQsSDCtMnfToNigVNqjpy8gXWKhGOMFOvKTUXLQwKCATiXEvKvFa8vKBPs8KrrgGYzdxXwv3MMgjkjM5zoe4ruOngvpWGAKLF12cO77RZbwwDTUxcTHvj9GGGbchRf+KbkJoayZshQVTS+uTJsa96ER2Z1SjvzxVxTJf7Xq4Kovv5d68skmFDhzi89HVrpDi9SXSC9GDp8eOlnA7TTI5IExJyGOTUc2ESUxUfqbncg3IfKb4QfYOT56oyFvLekRMwk4UFVQfxi+KfJTj90sNELw+aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:43:51 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:43:51 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 02/42] y2038: cobalt: posix/clock: Remove compat syscall for clock_gettime64
Date: Tue,  9 Aug 2022 15:42:46 +0200
Message-Id: <20220809134326.23688-3-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0233.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::14) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ad453e6-7523-4c54-bda0-08da7a0d3170
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mtGxxjcLR6zrbpg4vm6UOThBUnZBfWgYYbF/c3MGiEwoEf6oZm37+Is6PxoMTVvRk6pkRwFvLQq29qbx022lsDLt0I/IHGFDyKh3ON3SofIU6ZQSPNGYkCvE3HO+Rrl4KfS+inauhtpAYsrDfjzRvNIXpo5ONBYnoLSaUtE9CTpg9KyZ27YcHKSmJrt+iWTCY6PuiwRl71bn3IMCJCztx7mSsJL/gaU/WSYHZgAKf/QaopDVHsufaZT+IBYXKV9VUfq0GL/Z5TwJDhRFqx6fggwPutDvwe+eHzkMklerRuYKjV4N27n8qBE4+Brdo3F384N2wbD2osiGj387FFb/3FdQlOYWzeEJs9Aaoo2ovkj3CBpLMVdVD3Sk6VUgA9VWwbjUS3z9QhZO0HxVbZBZIDACEsHXD5MMTkT+iB01Dx8AuNNwz1C8KKn1X76zzAZrNwG5WxJew1DqxS3/iWbrRU6rn6VPoPK6fnCUiPpgvsIQ7jzEOXqjUX8EEgUdmCStK7GRD348w0q3GcRS+zQ6CWZ0pUGMGfEyi2IXPZG0k3cSKQXrbtkFsp1IGJzGNMZc2KYGPJAJdsJngZZ+KJ761uVapXfy22w/nKSwOLCv6ZCWCTfNYAgF4tvkIsiu+aeB6SSYE+FGLVUQAnfI6GCBazW1gb7pi/AzDwnnhDrXNGythdd13vdvmcj3oEH0QX0+8VPDzOO6HrExsZIUf1b8ONBqgpyfgfEbsb3O481YXeo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tgOyY8JNicQPoHgVQueJhsg+MPYtOwCTlyNL6ewUw9wGq3lMYMgRMvD6nEmx?=
 =?us-ascii?Q?d8fap2o2PVKX9+9Qk6FqXNZmZovGFRpZFQwcKPmMX6w4xvT2qSmfMdu1Yq79?=
 =?us-ascii?Q?+G9+WVGHYoUzgr86mgXt1NKXICjHd4YSE+SJZPi40wbJS4IzzdyKFmYA0fra?=
 =?us-ascii?Q?+Cf3nvoaLHQwARhIczMoDOpUogEGxTjH7ZmL0I/rPx+2qjKt93cRh9MclHpl?=
 =?us-ascii?Q?TE3Bcjgz6z2VEOfLbWiGL9jXHd+w+C417S+grByAd8QnliEwEoQDkGK//wQP?=
 =?us-ascii?Q?Z9aHSySCnVVpC4bbbzcA0RsJqWiKMIKvmweGnpwtdgPz8d6d8ALueBbDTJrd?=
 =?us-ascii?Q?j0+EK2yLAimYVR9uVESY6sxX358LuXhF2ShnB70EHp69XywRviCtHqA72AxM?=
 =?us-ascii?Q?Pu7wkI3/v5eKk4FdkexiBuc8S4LPrC12FdxqLYC6Xk9WGipwCl9Z22Uj+cae?=
 =?us-ascii?Q?qHMOSg8KYmt06i2YjYt8Eo3BcDdQRZm7794HyUy0LWdRyceeNGiVR60boyW0?=
 =?us-ascii?Q?9lOp8V82Fr14zg0FyjObuoItnC7q6f5h12xuSlj9ZADvPT4pozbtenLjo2r5?=
 =?us-ascii?Q?g8z0HbosWocTToMqps9ahoX5OnF/fz96b0RnXM7pYMN7Xn23EHWr/qJ2FVgK?=
 =?us-ascii?Q?Tb8tB23FMd+ZBzkBxEnWjp4BTRFzJqosDsI6cnnbSoqgjLGSRvySkuQheanO?=
 =?us-ascii?Q?2YXTRYey6C7Qkr4Y+XmgpTi+jWugB1GTRN07LbETlAaBS24qVEAfj+sH5B4j?=
 =?us-ascii?Q?Ovl+8E3INmvYhZ1hE21777JEnrXGNIpxg/s2iolFMSOIiDuvl9tUjUr33jxn?=
 =?us-ascii?Q?+WlzMchI8nEUsh+9Y8FTmZgKKIYOvcbZRUSMg+juqIVxnRMaejbJbLIJjWyZ?=
 =?us-ascii?Q?mGkI30hiCsattydwl0uRn/Kt0WDsOqOoCY6ADvhomvY6fuN9XCsaLheds7f2?=
 =?us-ascii?Q?rhP+P2WBl964hqv1w2JBkUNaBSJXD5xrKFf0QcXf+u9FOga0l0J+VOqFLkTF?=
 =?us-ascii?Q?iICQXIvaq1D0VlAZU6ENiHt1fqs19dJeBvKU9Wdz+SUDd7z6Tz1mUCYgrfya?=
 =?us-ascii?Q?Ui5FtJA9dmVMD9L3COn6FlJc/7wMHL3s0o6roEfroZCmQQWWugBxG3lS0RcL?=
 =?us-ascii?Q?2NsL0Y/uh6LeUecLeimLGCrEC7J0C3nVVR0P4pD1mcON6itnulcRDoh2pOa3?=
 =?us-ascii?Q?GrNakYoqUUGgAa3YK0/3MDWhDfB4BLKGTzvPAsjsYaDxLhf6hX+ZKJRoSBb2?=
 =?us-ascii?Q?YOkPBViQHYXT+ondixSvJfmavd/txb+Ka/fq4vng1obVAVYcEhavYD/YPmSg?=
 =?us-ascii?Q?J/MvPlSQxtsBkzfGm7mG/rPtyGWZxwCMUoaojacTEldcqfvjmSyG6rvy2dCZ?=
 =?us-ascii?Q?+DgCa+FYWy0VtEjuSq9ENvGqXQsZUSO1Xo0nGmxmemrKBhBR32e+RAij6ISr?=
 =?us-ascii?Q?/uDArdWXzekpERioUkeYOFIkGAkrtaTMoF1gTxck9vv3NTg67sHcG+vaQ9n0?=
 =?us-ascii?Q?PWxum/0gObVVeYjl0Kd3sXCBLkiobWInstoVDy1ltjHm9Liyvo+EUx4rLqnj?=
 =?us-ascii?Q?2udpnteYDzkkpLsW6HbH2yLyWg1B6shJ/ikL1vMaMXepimfT2yGyQqhAseCH?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad453e6-7523-4c54-bda0-08da7a0d3170
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:50.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MxfidGY8NX3R7qIj+L2lHAFFXRPrcj0faTK0ahnwaTYPLfogeSWf2vDqeJ1kWLEVmT2siUO2u+2mBblPWkZnO9OiH/pkUT/TZQ5kvM+cRw=
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
index 16cc8b20a..bd393bb11 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -162,8 +162,8 @@ COBALT_SYSCALL(clock_gettime, current,
 	return 0;
 }
 
-int __cobalt_clock_gettime64(clockid_t clock_id,
-			struct __kernel_timespec __user *u_ts)
+COBALT_SYSCALL(clock_gettime64, current,
+	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
 {
 	struct timespec64 ts;
 	int ret;
@@ -178,12 +178,6 @@ int __cobalt_clock_gettime64(clockid_t clock_id,
 	return 0;
 }
 
-COBALT_SYSCALL(clock_gettime64, current,
-	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_gettime64(clock_id, u_ts);
-}
-
 int __cobalt_clock_settime(clockid_t clock_id, const struct timespec64 *ts)
 {
 	int _ret, ret = 0;
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index e18373979..169d51e62 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -103,9 +103,6 @@ int __cobalt_clock_getres64(clockid_t clock_id,
 int __cobalt_clock_gettime(clockid_t clock_id,
 			   struct timespec64 *ts);
 
-int __cobalt_clock_gettime64(clockid_t clock_id,
-			struct __kernel_timespec __user *u_ts);
-
 int __cobalt_clock_settime(clockid_t clock_id,
 			   const struct timespec64 *ts);
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 2b4911c59..917a67625 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -172,13 +172,6 @@ COBALT_SYSCALL32emu(clock_gettime, current,
 	return sys32_put_timespec(u_ts, &ts);
 }
 
-COBALT_SYSCALL32emu(clock_gettime64, current,
-		    (clockid_t clock_id,
-		     struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_gettime64(clock_id, u_ts);
-}
-
 COBALT_SYSCALL32emu(clock_settime, current,
 		    (clockid_t clock_id,
 		     const struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index f36fff272..7d448d0ef 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -63,10 +63,6 @@ COBALT_SYSCALL32emu_DECL(clock_gettime,
 			 (clockid_t clock_id,
 			  struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(clock_gettime64,
-			 (clockid_t clock_id,
-			  struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(clock_settime,
 			 (clockid_t clock_id,
 			  const struct old_timespec32 __user *u_ts));
-- 
2.37.1

