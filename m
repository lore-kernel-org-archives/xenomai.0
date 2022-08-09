Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BD14429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFB3uQhj0t9JwbzvcBSrduFqqJ7Zq/72E94qDdq0oLiMaUk1WsExcjjiaR9wHER3vEzNRn7Azwav3ZLka82e3dR7fA1V1fOjvDb3IOrqr3+2guGp+4yoYVrcDtbOsipEWVhQFYHNGCGzHWuYy9zkdiwHxffPeFLYytHgm9cCJW3HXL/9QCXPRRreaqV3qHll4h+sY4LVnV1m/83c9aMhLEGfa5+1HSU6sUrbz1mSIaGIhK4jg7HbgGdSON5DO4R0qwZphVilRJsgSEbeEZ7r+nKnSpraSuXyhLlGRnFAKW9hvIeh0ARCWwS27ix6UBkRFfJ1KBajRT0RjK/hTpEUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DQpXX4mNhxcftVBeBpzvbR/JoUiB+Tf2+X2e+X3enM=;
 b=YlRfjodcfdW1MWtiqDX1PfY1w6tw563NQR1qkZ8CEHlVUe9WlgiMia50PZ2uJCYi7GxRmQMoZ/Um6on73gOzToD+JtDBYQc75fEB362R+tajZm6R37LB7PaP5ejWwFkmJkcM5m0O3j+TEPf3UuEfbb/hYpgsoP9mZWiLbVI7TIqHyKcvem/9uS08bc5xPO0QpHAfD4PU8GoQkBMuvNobKlRyGeYq1+3jwikUgYnhN9J7TaJpcOCnARmZDs5hfiDEmIzvxr6M8bDomUZHgbqXI1UIh3xShiFFPoei/MWdwreMLq++jjt4HLxq3kU0f2AZgGrDXjq8kewNZB7MBIaSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DQpXX4mNhxcftVBeBpzvbR/JoUiB+Tf2+X2e+X3enM=;
 b=TKz5FhBDXSVP0P9qoqe0EYUacNfC/jOYwgUy6JKQvEhe98vdUlB1FzU3LSbRQ7P9mJ7MYOD+sXirhYijynJFm7fYM/3cEoD3CiIKlbajDUysrzsEM4s7WgzcmWdvYsKOvdALeVYC9qtibRIHzkfyQ1+rHfKkGuOwXqFe3PqnbwtPWsHgFD7EzFSM9XGu4jghn47lv+nMvEinFUaJL6owd/apBkW96WNmUD3BJk/KchelOzTsuy6ezp0kk2M8oTznyCSHaqRf+IgR5fOxOMTAoI+FPCpug3vg+qkxylcQFiORLvlq3rm7a+39lEG15M9mbE7OYODMhZuiGPGtq5WseQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:51 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:51 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 34/42] y2038: cobalt/posix/select: Refactor __cobalt_select()
Date: Tue,  9 Aug 2022 15:43:18 +0200
Message-Id: <20220809134326.23688-35-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::8) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ece99a0b-7544-429c-6469-08da7a0d448a
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QL8H4m6neKEyD7/bghFGktNAOQvx8oKAaTf7TQ/f2+cFOdpbYRYOF1O7mKKxiI0ZlsyivE+F5g5dGbwxZcsqSA316BHUlwrdQYffkyDH9jfCvSUa325lhS4iygvFOHZPMp9yns7pN99PHwKUeDOlLMvuXxVSA05AhKkenLwCWUwG4LmYS8Oa6CjF0LkSFx7oqKOwj0t6KUMdmg6RhirbELkiUAQ4U5/+o/hm9AYnIoz4qYMDivWusaL+XKk7vAJa30DSKCREvzf3BoMZ9iIhYfN5I5Id6PHMYwx7MLWJKFpKh+zXrZyc/8Ir7rQXGImMr01oA4FeTiMlIMdV7sQCl2Paj0H3HCYlPZ62EiQdHyOSCt186aaQOGsTYGjqwsnfUdWr8MDO04XQc/iyg+osguQbbO4mfJOz9C2aoiIVraR3Pu/Ow5KZxvyha1Y0rIiYDvTolGbqr51AnrBrziBEVejFDByydcozX6+jjNWTq+CrzbwsfebEsidf80+wLo2/f9WXQ+y5O3QqjmAHEJYzgxatIOpwz4BI69ca4BCwJ+5TZ79jzE1kCWnDR6m/02Sqcep8U4vQ+IJrncO+qZ1MR81DaW3KsWFFZzk2zsXZ7uVbPhP2WG1C5dJsfetiuTqawRfGIGNeF+yy4O5X2SUdL6zsy4HX0gOe/urI8aZycQYQD1sVj/UUBFoocBp5hLLozg/LMlH5ex6YDR0eDCEO6SR++b6qRFXbGjgHbj538+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(8936002)(82960400001)(1076003)(2616005)(186003)(107886003)(36756003)(38100700002)(44832011)(6666004)(86362001)(6916009)(4326008)(66476007)(8676002)(66946007)(6486002)(66556008)(478600001)(6512007)(26005)(41300700001)(2906002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qUKcWUqPc1hJFn2x+D1tnkkhJo59t9GULjHgj06FQcfkSySxDmBqTUkXCLaa?=
 =?us-ascii?Q?FJvrRV1/fRUiIuK7ov/ZLEh72JkhW//nRZkPkmYYKhsbLydEbqzxFevHCNo9?=
 =?us-ascii?Q?ZCbK3WYAIZTHc2063hBUghz0pGkGcjE5M4M9zdbUoN4Ud3bAkPHgcrSU+sx4?=
 =?us-ascii?Q?0QVloNy4AWZDgCz75pcfxsndkYUYyJXtEC365ndXh7LxXC1p0uYNXI4y+DRa?=
 =?us-ascii?Q?JR5Ge4McSPjUpKeVgNnuJ2SnpO8y9seFdAfrcwZW7Nspvo9Ax5JeEEtvYBvb?=
 =?us-ascii?Q?4WAy/A/7F8bLXJz78VZg8Di9dggT9AgpwElk8UxZuKlKtYA6VJTOvKVanBln?=
 =?us-ascii?Q?fznEbxeK+a94OZV7by7oGHSki5+ASMTh8MC5leQDkxj6gRJP5SAbNeWJfFsN?=
 =?us-ascii?Q?KbsmWNJnOdtCw48iJLAPI1TxLzBMpwBLLMQ365tefoh3fYT+BUDEXCx6am7q?=
 =?us-ascii?Q?s2NSbruH+/ovNX0E9tF/5jteH0pZVkUxsZ0R0Ee7Ry9wrb2N0enWb447x2Ks?=
 =?us-ascii?Q?HUyoI0g78hZiauFJ06/R6tijh9RG3eSP0PaiUm8XKl8/nbx6WGuYdht/Wk2y?=
 =?us-ascii?Q?oYcBDhlLnnwJrOYEgJojbCqyP/KXKOvliacdRhK3HLR/hqThWsWYGiVFGwQI?=
 =?us-ascii?Q?3NxxRr519PIQDq+DOgikxa4iOJxR1zTAlPBvd5ZP0ujOEcTrR265IMw9+Tma?=
 =?us-ascii?Q?nSrxMRoUotbFnQjTKYOQDfk9N25CBbmt0bjBS5wQ4aH8io/CUSEXhTG+yDss?=
 =?us-ascii?Q?Bt1OjjS9ScnnV+oB79CbdQNpRf7WZvPSYGK20L3jEiJgbslGh7qUaWBEp+eJ?=
 =?us-ascii?Q?SwM0A8GaP0ZwChOPQBJUJ5lKI/TBBlSA3RIYl8CCjEiSyUJ09+IfpQkeqqLx?=
 =?us-ascii?Q?K2T6GMzv87L4nkbqy7LTNpxVbxOW7CJiqQHXcmeVRl11g4KLLa8T/5LQx96c?=
 =?us-ascii?Q?9yHJnvQlMuQfWpWtUJBR2K8aNtDtXbHhUFXwWVctWXyxQRcYPGRD1oAOS0wF?=
 =?us-ascii?Q?CeFrlSH1T1f6ZQRBZdzziOIAsb+kJAc0+Y8bfWydCrTJIAA4m9vVkumN4EAw?=
 =?us-ascii?Q?8h+KSsLGtOVybtBeHnvQVwiNX7xh8yZ8xLe6sx+IcqbY+0KWFO+PkfHQScfW?=
 =?us-ascii?Q?FugFP0ffqVdTtw4bVhvrPmajcRXUVj91JTleCW92Vc08TkABbxJLnDcnmwf5?=
 =?us-ascii?Q?mv3N4d/o+neVFBj8NZLNuaMcIhiGKSqp//3Znnim4HEtv+jtbnr/IELei2R/?=
 =?us-ascii?Q?cO9ZW6Tyf5wkC+rewDNqrQ7ADW7HVTLVRX5v7KZgBAKO0mbXqSstt9yGYrc8?=
 =?us-ascii?Q?sxxoyPfon0jt513oFLyl4FuaYXerALSEEVjcjFOJcCAm32FGNzAWVyx9V3tV?=
 =?us-ascii?Q?j0rS8n5c8DSZD1p6zrdE1r4UesBd297Rglm12rqVQrJN1G5E85hw5RWvqVlL?=
 =?us-ascii?Q?DX0SmEfWti0UVZSzyGuoZaEJUoWjriwVu+6B6W3nrSXgEzupOJ0sR9nKy2jx?=
 =?us-ascii?Q?PrpNV/9ae0MF9GjbWoa22PXwOMTbLMwWDCbUs6tw7Zn0Pep1JUqaSpNiMXtY?=
 =?us-ascii?Q?+uNQP/3Mef7OMWTKTEcDwq4nu/MGgzun0/BJDOssmO1buEtmsCfVS/sMd7xb?=
 =?us-ascii?Q?QnNcMEePEZG///RR4EqAHIc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece99a0b-7544-429c-6469-08da7a0d448a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:23.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/XWcB3YSTlT3HQqY+nYnxtIrubSJRSnkZsg5RMvDy11b5Dv3X/GjcdrVTx14VLlmcYbiz6xpQuXY4Vx5keornab5t0Yev/iMqIZo5Rz6Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116

There is no y2038 safe select() syscall provided by the kernel. If
y2038 safety is required the application should not use select() and
move on to something like pselect().

As we still want to support select() for keeping backward compatibility
- even if y2038 safety is requested - an additional pselect() based
entry will be introduced soon which will re-use __cobalt_select().

This patch moves all the timeout related userspace copy operations out
of __cobalt_select() and migrates __cobalt_select() to
struct timespec64. That will allow pselect64() to be based on
__cobalt_select() as well.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .../include/asm-generic/xenomai/syscall.h     | 22 +++++++
 kernel/cobalt/posix/clock.h                   |  6 +-
 kernel/cobalt/posix/io.c                      | 62 +++++++++----------
 kernel/cobalt/posix/syscall32.c               | 24 ++++++-
 4 files changed, 78 insertions(+), 36 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index 70b3e68f9..d61b985fb 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -138,6 +138,28 @@ static inline int cobalt_put_u_itimerspec(
 	return cobalt_copy_to_user(dst, &u_its, sizeof(*dst));
 }
 
+static inline struct timespec64
+cobalt_timeval_to_timespec64(const struct __kernel_old_timeval *src)
+{
+	struct timespec64 ts;
+
+	ts.tv_sec = src->tv_sec + (src->tv_usec / USEC_PER_SEC);
+	ts.tv_nsec = (src->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
+
+	return ts;
+}
+
+static inline struct __kernel_old_timeval
+cobalt_timespec64_to_timeval(const struct timespec64 *src)
+{
+	struct __kernel_old_timeval tv;
+
+	tv.tv_sec = src->tv_sec + (src->tv_nsec / NSEC_PER_SEC);
+	tv.tv_usec = (src->tv_nsec % NSEC_PER_SEC) / NSEC_PER_USEC;
+
+	return tv;
+}
+
 /* 32bit syscall emulation */
 #define __COBALT_COMPAT_BIT	0x1
 /* 32bit syscall emulation - extended form */
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index dbaabbc5d..38b59e24f 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -68,12 +68,12 @@ static inline xnticks_t tv2ns(const struct __kernel_old_timeval *tv)
 	return nsecs;
 }
 
-static inline void ticks2tv(struct __kernel_old_timeval *tv, xnticks_t ticks)
+static inline void ticks2ts64(struct timespec64 *ts, xnticks_t ticks)
 {
 	unsigned long nsecs;
 
-	tv->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
-	tv->tv_usec = nsecs / 1000;
+	ts->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
+	ts->tv_nsec = nsecs;
 }
 
 static inline xnticks_t clock_get_ticks(clockid_t clock_id)
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 45ec09fae..6709ef639 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -221,7 +221,7 @@ static int __cobalt_select_bind_all(struct xnselector *selector,
 }
 
 int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
-		    void __user *u_xfds, void __user *u_tv, bool compat)
+		    void __user *u_xfds, struct timespec64 *to, bool compat)
 {
 	void __user *ufd_sets[XNSELECT_MAX_TYPES] = {
 		[XNSELECT_READ] = u_rfds,
@@ -237,13 +237,12 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 	xntmode_t mode = XN_RELATIVE;
 	struct xnselector *selector;
 	struct xnthread *curr;
-	struct __kernel_old_timeval tv;
 	size_t fds_size;
 	int i, err;
 
 	curr = xnthread_current();
 
-	if (u_tv) {
+	if (to) {
 		if (xnthread_test_localinfo(curr, XNSYSRST)) {
 			xnthread_clear_localinfo(curr, XNSYSRST);
 
@@ -255,23 +254,11 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 				goto out;
 			}
 		} else {
-#ifdef CONFIG_XENO_ARCH_SYS3264
-			if (compat) {
-				if (sys32_get_timeval(&tv, u_tv))
-					return -EFAULT;
-			} else
-#endif
-			{
-				if (!access_ok(u_tv, sizeof(tv))
-				    || cobalt_copy_from_user(&tv, u_tv,
-							     sizeof(tv)))
-					return -EFAULT;
-			}
 
-			if (tv.tv_usec >= 1000000)
+			if (!timespec64_valid(to))
 				return -EINVAL;
 
-			timeout = clock_get_ticks(CLOCK_MONOTONIC) + tv2ns(&tv);
+			timeout = clock_get_ticks(CLOCK_MONOTONIC) + ts2ns(to);
 		}
 
 		mode = XN_ABSOLUTE;
@@ -343,23 +330,12 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 	}
 
 out:
-	if (u_tv && (err > 0 || err == -EINTR)) {
+	if (to && (err > 0 || err == -EINTR)) {
 		xnsticks_t diff = timeout - clock_get_ticks(CLOCK_MONOTONIC);
 		if (diff > 0)
-			ticks2tv(&tv, diff);
+			ticks2ts64(to, diff);
 		else
-			tv.tv_sec = tv.tv_usec = 0;
-
-#ifdef CONFIG_XENO_ARCH_SYS3264
-		if (compat) {
-			if (sys32_put_timeval(u_tv, &tv))
-				return -EFAULT;
-		} else
-#endif
-		{
-			if (cobalt_copy_to_user(u_tv, &tv, sizeof(tv)))
-				return -EFAULT;
-		}
+			to->tv_sec = to->tv_nsec = 0;
 	}
 
 	if (err >= 0)
@@ -390,5 +366,27 @@ COBALT_SYSCALL(select, primary,
 		fd_set __user *u_xfds,
 		struct __kernel_old_timeval __user *u_tv))
 {
-	return __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, u_tv, false);
+	struct __kernel_old_timeval tv;
+	struct timespec64 ts64, *to = NULL;
+	int ret;
+
+	if (u_tv && (!access_ok(u_tv, sizeof(tv)) ||
+		     cobalt_copy_from_user(&tv, u_tv, sizeof(tv))))
+		return -EFAULT;
+
+	if (u_tv) {
+		ts64 = cobalt_timeval_to_timespec64(&tv);
+		to = &ts64;
+	}
+
+	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, false);
+	if (ret)
+		return ret;
+
+	if (u_tv) {
+		tv = cobalt_timespec64_to_timeval(to);
+		ret = cobalt_copy_to_user(u_tv, &tv, sizeof(tv));
+	}
+
+	return ret;
 }
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 10b080dfd..af2365e78 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -749,7 +749,29 @@ COBALT_SYSCALL32emu(select, primary,
 		     compat_fd_set __user *u_xfds,
 		     struct old_timeval32 __user *u_tv))
 {
-	return __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, u_tv, true);
+	struct __kernel_old_timeval tv;
+	struct timespec64 ts64, *to = NULL;
+	int ret;
+
+	if (u_tv &&
+	    (!access_ok(u_tv, sizeof(tv)) || sys32_get_timeval(&tv, u_tv)))
+		return -EFAULT;
+
+	if (u_tv) {
+		ts64 = cobalt_timeval_to_timespec64(&tv);
+		to = &ts64;
+	}
+
+	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, true);
+	if (ret)
+		return ret;
+
+	if (u_tv) {
+		tv = cobalt_timespec64_to_timeval(to);
+		ret = sys32_put_timeval(u_tv, &tv);
+	}
+
+	return ret;
 }
 
 COBALT_SYSCALL32emu(recvmsg, handover,
-- 
2.37.1

