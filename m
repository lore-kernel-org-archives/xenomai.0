Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3D4428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYDyaKctTY8tyg8vF4Se80aCGMon8VqjxroVauI3dnyDyt6Rtn5CHSyPRbG/DiJW7KamT3KAI6CLiWDLYtpkzlLcURd2sv6QaZoH33PdSSB4HucycPJZHWUoo75w7aDxFx2ah2+diCEebyAByu8NWM1otMa8OPxhkuFElBSOJMVCBbv2Yy5atSlXkH5xWzzLQlrSvwsbIaQrb3r8VtNlzPrJwvqrUnkh1Ezn+sASOUFici6lKEKdv0CUd0jwM1F9BYC1sqoGztau6b2ZeDZjZHe5N/R1WNWFyM0Xa7WYLetdpdTcwQDNiy/QRrkYOEStyKlJJRuewWVlz+q5BnW1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wFPeolGP+nuYT5sUtJVGt0UjnpF1Phlk6RHlp7YPwY=;
 b=atZMHe+LFVTBlIwmgJHyf12Q2UYY4R9yQ3L9nl6QhnVQQ0akq8+bAIwRGhHp0moS9Z8R2MlLS1tfXug/XtWjI/CGnYJ3b4UkdkiVUbwGVyXnlZ/Tf0e1x94d9/zs98CNrJ/8UN7HXupkYlBcu+MM2hTOXpUjA2cvB99VL7cGI6GUEnuDtgpNkIhjFUnVCTUgc2Ygd1wqAC0ksmTVKxv5u5EEd/buI80xtv98t1K6Tmsrndj5C+dvVB8cIhBSeP9kPoFus5XiDXEKeL3G7s5jPnDBSypwGIfZELCHrf2pJVINRd8RijEakx8wTZZtCKZqFCUL+vQorJ4+blAxoBjK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wFPeolGP+nuYT5sUtJVGt0UjnpF1Phlk6RHlp7YPwY=;
 b=V2pzv7mSs3Om7iS+nA2GpoKlHnuaccvk3MSigv35LGEe9qdw/U9c7b6i2XbEegVqObQzc9Otl7cbb7gA2lb/WkybiqUHmjYdbJppUuJKeeBdhGtIW1RSXPx5eSJ2tY9OiG4cDWOPvG84w/Nj1+t9LxyedwnZn96OGO49+oFIi4WIfbkrJVKSyPKPqlx41BgwvEGky4SKfqqagYVD+A2gdMZQ8k/z7qFUw2XrlETRSr3iZ+EXSVXPNXXeV6D45xEQOAWklSSd/59LW0VgRdHJwcyHulKjxCzjU2Inc482GtZK/VQ/EuGHV0fMgTrJ4k8/rEM7VnCPM7J2VpSXCxh8sA==
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
Subject: [PATCH v1 05/42] y2038: cobalt: posix/clock: Remove compat syscall for clock_getres64
Date: Tue,  9 Aug 2022 15:42:49 +0200
Message-Id: <20220809134326.23688-6-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::23) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47faa003-118c-450d-cff8-08da7a0d3341
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ihiy9pOGdY4AzemGcsjO5xazaOSN9Inl30I0gtdL9nmq9zJfS3q/TXtt8dV/r6i5vHe0hZFG0LnhapVj/HfbLc9mn6hESx9hRBwK7pbRRuM8dL45j6TbJY/t3RqQs0PNKU9b6nFqLmzd1wN571ieftzikruVKeQD8Us3kQgOqhLtA/AZJ6WTLGcQ0Zh3Ux82h6yXTbRM8SBQeccC3/uJAjJVWrH5160gnfX0iDj6GXHDd2DWzRlDGyetDc1ChG1HMFOTQLBTS0G2Ym69u3OPDkvNcwIee+EdGGXPf1Zu8DbNBbkUFijId/D3jpYYH9A5r6dgvK0TbAGkz3UqsC+d/TOfCLJuyFjvDIO49XaEjhSQOp+AqPpecV+VsLEqUqYRAkSCPBKhEXAW1l4q8svfqK3xSJGJZpESxxkp3wVOL8hZklHiKkRLxSxlb1GtAIqY+8KwkQbv/J9uYiv6AnMD286+WLBgUFejD/GpVV/oHLP2I3Pxv4aRrXW/E618Sao/xyw0Oi5sz3uewOw01Edsx9106Su9XBga/PJKEhQJAfmrnJyu0rsuAKMx5s0yRfZwrr7Uamtq64eKczocNz1BraQ3KLX0HAFa+3MiTA5CcQLW+MR/ymTb+XUjE7Z29RPSg1bR8nGgBb1xaVykKtce4paZgaxpoFI7DDZRR74ltxsVlP3iHsrEOqb8TkT5CkeYtbzYZrbkKoGL3puLjM92RLvH4NRoYOhM89PFIYHa8Os=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dMy40aMZstR3Y7CTmLn97DPnZRjiM0UckBLxxsiD2cpVgfY1dKJJn068Swie?=
 =?us-ascii?Q?hSDshwuM5Tzzy0zazTfJZyp3L/OxkM43kVh2QFSQ/FOWK9rGuJuKuig16L/T?=
 =?us-ascii?Q?GALDTjJ+iYoyRIHG6m2DACd9wm02a7n11HBiO44I5HoAEpNMaTkcd1ZYcr/N?=
 =?us-ascii?Q?5NfWH7cattSYkU3Ot93mL7ZnbbLq6F9+3k4eWx7jpvlbJhZeuFc6eB/WMgEL?=
 =?us-ascii?Q?yMwbwbqOw3fb8HCV2oGwW4r7RaqYhtZCFg1LrIuuFaRKpJ4iHb7U1so3Y0e/?=
 =?us-ascii?Q?WhAgZohW/3ez0o3Shhyzi1Zv+myvRp/xvznUGdbS96N2xGvXxo5fqgduUWMp?=
 =?us-ascii?Q?KPFiwdPKyuvv+Gwmv8X1bZcz7IaDTqVPcTu7rGJOLTPMpR5Ksw1wKBWE1WwX?=
 =?us-ascii?Q?41S4D76MLcMQkdW2WGkg28SVXhTaBb5S/DYdN+Gl8F0T4NiLdZB/LB2nafrq?=
 =?us-ascii?Q?CTE0dyiRCIHQHx84IT7MV39J+TxBrNhjqp0h03is8EY9gJOk5gTXozveHiQ0?=
 =?us-ascii?Q?QaEe6C81pqZ9Q0iEHsEYOWUqv8ngxl+d4x3xzarBWdrix8TZpA/H0l6U3OZL?=
 =?us-ascii?Q?CJfFSFCR5Ln1LLz8F7zlzW+nXrPOrTGrn+ad48bjD85USTcFNk/Dw4wxMRV0?=
 =?us-ascii?Q?ZIUGLVU6orVTQK8Rit5oOYpwT2+Yv91EJFOieJZYx5alQu50NJAEGY/5dXiW?=
 =?us-ascii?Q?FPtIfBjEApNE16J4JfXSc9ZRSUVQqg7SKIXQGapcTeLdaiV2d7hfZ6btf29Z?=
 =?us-ascii?Q?2eMUSaBtXPsdrSOtxD+2mMFC6g+R04tlltikD+pZMiMpnt5m2gqER6su0GAk?=
 =?us-ascii?Q?hk/QQbpliPwKCkewBd6n+4ufKxlTQPtpVH2kJYn9/VhfCsv6vytMQIOl2CcQ?=
 =?us-ascii?Q?cwrx+iiTwAVSIBw630SqxQ52zNXX9KgU7sSBgsKnU7Sk0Ncq42xsAp9jSsx1?=
 =?us-ascii?Q?n6QrDVbvpRD/SLBVrWYvH29UxaQX7BmTT0/1PQQJOTUWg7xVr4bbDuDBhjL9?=
 =?us-ascii?Q?4lFbNZ1/wkQMMD6XB2YJeWGZkhUBSBQPraBz1/4yg8grAQ+8AK+MeZqlYOf8?=
 =?us-ascii?Q?Rh2jTFuErKgYSe5dLGUwcx+3e7HSTjJ3TEJ2dnOb2gX66TRJ1vaoWXckPRMn?=
 =?us-ascii?Q?7Fz+uOWeZWnMzlv5R1I9lvO+5fGGP7I+et9GoRJRfTcdBqX8X0ioieyh8OA0?=
 =?us-ascii?Q?aNxS1jfysSf+79R5rPaXjo8KyoD7JpCuTHww5y6r+n/+EPiiuHn/XFo8yOia?=
 =?us-ascii?Q?b+ZIYB1a0ipp1n41s+9Wsf/ZkcOLNPVBUGPbLYZuzbteJ5RAz4Wwo1WwdafM?=
 =?us-ascii?Q?Z91BJOpRVXomMIGCSGY3zEpwLDmu93jjdIQfQoyCv45vWOCm744JqVAnoD+1?=
 =?us-ascii?Q?dExtPL+1PfJa0bzpOUZFIhF0fd1mA6VoUAM13K+ljGWKfEOIqGBfU/LGICOH?=
 =?us-ascii?Q?C5kDHSI7FqNLqZeNPJOBRjGrBduRMEureEwVCHyIL5yw3BFopQXBYD8GAm4Q?=
 =?us-ascii?Q?qCeg7rlhHEO/Efmu9PBP8TC6kpTNuNI2sh4t3Y04IzVOcNGOUWOTpcN3VL1F?=
 =?us-ascii?Q?KLNmUgQnDbkfYPEfx8L/MNqdMou+d8v9EbrV3cvtlRYqYnhbOTpjgHdrxl8e?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47faa003-118c-450d-cff8-08da7a0d3341
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:54.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGDBGZtW8hjfW2J7RNtcVEa/vQ6n+hOfqMw8cUccX+d+3T+y+R4/qDNaoijz/H4EFoaA+lrN021NIwpv/rF+pNFso+ddrJki0LGCk3F90Jw=
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
index 7b1693612..9de90c728 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -93,8 +93,8 @@ COBALT_SYSCALL(clock_getres, current,
 	return 0;
 }
 
-int __cobalt_clock_getres64(clockid_t clock_id,
-			struct __kernel_timespec __user *u_ts)
+COBALT_SYSCALL(clock_getres64, current,
+	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
 {
 	struct timespec64 ts;
 	int ret;
@@ -111,12 +111,6 @@ int __cobalt_clock_getres64(clockid_t clock_id,
 	return 0;
 }
 
-COBALT_SYSCALL(clock_getres64, current,
-	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_getres64(clock_id, u_ts);
-}
-
 int __cobalt_clock_gettime(clockid_t clock_id, struct timespec64 *ts)
 {
 	xnticks_t ns;
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index b5ab39b44..305400148 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -97,9 +97,6 @@ static inline int clock_flag(int flag, clockid_t clock_id)
 int __cobalt_clock_getres(clockid_t clock_id,
 			  struct timespec64 *ts);
 
-int __cobalt_clock_getres64(clockid_t clock_id,
-			struct __kernel_timespec __user *u_ts);
-
 int __cobalt_clock_gettime(clockid_t clock_id,
 			   struct timespec64 *ts);
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index a245e91af..2e7c2fc93 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -151,13 +151,6 @@ COBALT_SYSCALL32emu(clock_getres, current,
 	return u_ts ? sys32_put_timespec(u_ts, &ts) : 0;
 }
 
-COBALT_SYSCALL32emu(clock_getres64, current,
-		    (clockid_t clock_id,
-		     struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_clock_getres64(clock_id, u_ts);
-}
-
 COBALT_SYSCALL32emu(clock_gettime, current,
 		    (clockid_t clock_id,
 		     struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 0e06e12c1..2711fb2c8 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -55,10 +55,6 @@ COBALT_SYSCALL32emu_DECL(clock_getres,
 			 (clockid_t clock_id,
 			  struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(clock_getres64,
-			 (clockid_t clock_id,
-			  struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(clock_gettime,
 			 (clockid_t clock_id,
 			  struct old_timespec32 __user *u_ts));
-- 
2.37.1

