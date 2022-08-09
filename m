Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4C442E
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3sdkBEqz9iV/dmwYmIrX/9Ob2HiEtWbZY8wsrd4DED2Ky/5qPg6flvKAzjGdF1P1p/y6mMDi1NYBc9mwIms+xQpUUBGXUP13clp+mJq3MdcfOT2Ys3vrWcPp63j82GBMyDUNqf+HYKpGLqntkuDSDdxH4gtgiW9BMqrILpqQGcWN7RISqenJgus0CpIAvrbVJ4D77T6WXTcMK4E//Fla6SHb3ePMhXShWE3frHiJW1GX6kIG+YlQvYt9lme2ouQEqIuwQ+uabYdt0/JHuVoqmqiGEUMzA4SLp1kg0bri7Yo5iGNNwc6h+XA3bB6DT7erc4SFWWe+xITu4Q/ztoXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtvzEC8GJvCjys/bBTA9FKlng8eovLrnhYv7CZPZEKU=;
 b=fK/WG8EKlt4SBoFdTaserbKmSopQw2I9YoEmNlKT5LYmF1mQQ9TxgZuypg5nyjYUJMKgWuCDxEJao7IkL9oQx5ffr4OsuUYuynUPUQAmF/tc3R3Dq7Qr+6PL88HRAdlrR/Kr2uBflIf7qcFM36W8IoLcB2SavTdNNBWKoZJLkC78YmoZTBWhz7Qy3fvMV91PnKmoOMM+/ET9lBrOe/1ZP6dGQr0U++dm6br3lKI/QsOVD9kvUylIpo2of7szUxmfQIagJVzJ+hvO7amRHADPgh3aF7X9UVE7S9arOnBvu3dazikG7sUuQx3MNtcB+ReRsACqP7T/LKysOgYRK+hFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtvzEC8GJvCjys/bBTA9FKlng8eovLrnhYv7CZPZEKU=;
 b=SvkSuYXaVeKO+lg7uDw+NO6M4oTetgj18RwLEUYfpavWTHyWh3mv7MyrzJy1QLEwyFPxJBHXcVtYg6TLMbsG+Lh8cAt41L8PLep80B7Y/dlltTK1CeXKhXkiUJeM3q49ZkMFBqSdIQfkZw1m7onetevz2SSmy5rnC22vfQRhreTmEdsmWVYuYoIqXd0+wPhu2BxfHIlC8hc4gSaz1RhEhTUCbwmAzVrN84jHWGQq+jjjH4TOKmzym/DE/oOfZIKWjiEhNvmR3/M/W2N1UlyCZjEoXIbBD78/QTj3N1s9rfAmrfwgwU47g8q0XIgYmCtw7Peyvd5M2cau4fZXalUrlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:15 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:15 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 27/42] y2038: testsuite/smokey/y2038: Adding tests for timer_gettime
Date: Tue,  9 Aug 2022 15:43:11 +0200
Message-Id: <20220809134326.23688-28-florian.bezdeka@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb67bc43-eeae-4c56-29ca-08da7a0d4035
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KWdQuqHXYRe84vP1JKmyLm8kpfyvDUgbmtF0PWGrDbswFrJNKd5p3IihP7HhAC4Rz2VweIcgQPB2ukBF9VW4Lo3Bm/MNMuH6xUL9fyRl36tSjEbvwYMhdp9I/k51xs188VQzlfJZATuZy3aZ6YRDNQSlP4dPdPan6jfC24MVdZiCusAJGV5uVhrKNj2lHup7sJ3gmmPyjCD/IBlyTtbTWJ2CNIAImRajq+Nuk8l7wGmFGpRMa8Lgxym8H2DwSCXBBdc8Lqm5FPwe6yDurpAc5AN4Cl1tEcPEcDWYlRuKldqR6BAdXPlAteeKJbEIng0BxGiwbO6vqBfAsazMKVgiadGkVD1MMCP5RSAX/VlmA7Zy2l4sb8upvyLcFokKcVy628Pa8sExuIrlkqeY32KR8FZTWniKMyBl2gK2s3qjGH+IP2wbL8sEWcPG+VHj4VSBoDkxvR66IvYQwnJxlbPOgrtKY8owSS389RgmqjGbT7fgcFnWJyuGvRgkuvooHSrYUHOXdHDMyq/4T4xUzY5lYjVhHJH1a9sAxcSFjI08FAcTpSqQWxHEw6FJePnXurDkGCz/r6a9OmOA4G203NUajHIFChR9yqufDmBJRa39fEQ+0ZKt7XZ8AKdjIh60yGZQDfnIB+UAfuU21MKOTDt9i7UO1R09oZvt3Yfhk7UK15UrV43e6ZIcMywbXhj9A7nNHfD41WNOYEd6gxpsi0ylwSkTs0mnPWaad79hYfKYaaU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MZ6N08fJg9D/1UZdUOtA933JvfldJ5bAt80ZpGIcEo5AX8Umr2eNTEuB9qWm?=
 =?us-ascii?Q?RS6Ne/Tme2lNZYjbcP47GhQpE6y0SHDX1dTfYmvyNrNXkGG1U+aylCVWudWC?=
 =?us-ascii?Q?GQbVVvmrIDg2G3SL0eFOvGNAPe8WsgcySDD4/gqwvEm4Ae2X+0yZ1d6RZoZQ?=
 =?us-ascii?Q?CtOiI3ad0Oram7jJGkxT0Di/Jx8q06HPueluHPiEr1Adr51MjnkiZjdJKdLV?=
 =?us-ascii?Q?JbpEhNm9JSqv55tf8k9xYghfERsAo1VHJbjvmdfoURqbSfN/mzgeygtGVpYH?=
 =?us-ascii?Q?yf4wm27wWe7W/dT+6UO2nGnJitiyshTwyncv0KMDmIsL7MAhv9GTy8+SpXT2?=
 =?us-ascii?Q?ZVhDUjOYSbfzLHo+nXVssCoV5OOGHM2pf5CwGm9TOpcmFMOeXZr2lrkI+Uvd?=
 =?us-ascii?Q?9vtWheDNkT2fP9roTl8rb5OkOmsXduoraSbjHdtVFJYZifPLt14Hk1VeA4Jo?=
 =?us-ascii?Q?K8mykzO7zzMfIjc6bB/AZ0oVi1LC92jSufML0/RNUpSHhvsuynZoJ+oY7+sX?=
 =?us-ascii?Q?NvHDFk+TGNtEyU1epHoSRTji6yFAv0inFYPdSLsIruna/yW520FUv2VnCW/O?=
 =?us-ascii?Q?Us+YDFCQhOL7OIoxMDZeC0l5sds4Kw119yPVmFuD88Cx2Q9FlIN5RVLvP0K9?=
 =?us-ascii?Q?YUwtUW+5onI7vJ3s6J+xaYfTpdVAs/jwvtaQUqsH+meVNTuI2RQVp6C1UQxc?=
 =?us-ascii?Q?Ms7cVjzUP8xxhqVjYUmgJbsBGLhfiD7T3Fyf3xfg7oq7o95vJqWLwXHm//mA?=
 =?us-ascii?Q?MT+HbxEcNE0nKigYKx05fu5ZKsazanApMgeltovBNchEf2bFPAZm6bcx0DyR?=
 =?us-ascii?Q?1Aw93tPDVPSg9tixu4lAqGbSjfcMF6ejzw1StZg0ygTC9aTcJL3XZ0v1mbvc?=
 =?us-ascii?Q?2xBk7AP2VgSimYKXYe6VpMiMxrlFUJzL+loXRwKneYWO0PRhyiYqhRc9AjWL?=
 =?us-ascii?Q?gx/PuYPrwKd5SpKtL8JV+FoDOje6hyT4aXuc4AdRVEXH4gxTXy8/2aQ6XdWy?=
 =?us-ascii?Q?rmmcBQ7UUa8uJaob0FrScJNBcKnegKb6PA5c87zBdhT0SzZ8dfkhV5+T0V85?=
 =?us-ascii?Q?z+5yFUN+tTu9fb+vuaYYTasbDEQzh4lSKYqpZWmdRdOWhgFVNTU8koOQZQEC?=
 =?us-ascii?Q?LL0pr6mtr+R6JcuwIwJW+oN5ao/C9rKoxuBqpohwtUGGZtC8vStLnU4go0qS?=
 =?us-ascii?Q?7/fVckWmVjkJL78U32R4okgVLoaU11GoNN6XRRTJfhkBH+RRh0M2ffOwt2iK?=
 =?us-ascii?Q?oaB6j00Nbg5l4KVoHWCW0+Q91HtMq5fOnvcwRyVD/yn1VzigcYCWxPyCKIyB?=
 =?us-ascii?Q?OqKEp+tDKy02xGKY9Ks93kI47sYyqYK0djVExziZ0/FHnGP5zWz9DYmfWXeo?=
 =?us-ascii?Q?FxOn+078ijvnZC8ri7oBf47amz9kjJiZ2qa4nfz7JjZy0Q/HoGazZ3iJnWaG?=
 =?us-ascii?Q?g6EfeXeUqqwhrGzAIAemx9VtPKHenYr1RAQUhk/FqgNB7ITNNZeAMITXj4m1?=
 =?us-ascii?Q?SIrFtBFyV+VjRzFruji2zTr3XeIJzabJazt5gNdyFXGomL+w3x4J1d1PxqNq?=
 =?us-ascii?Q?CuQ0zZonore/2X9D3ApFeTGTE2y+diCbOIN4iI9VCyAtJevh++2DJqcsEVm5?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb67bc43-eeae-4c56-29ca-08da7a0d4035
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:15.7985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPVDAUyvm51BkCZ/qDgcHpIq+spiiAQy0E0l281rtwR/idXXK2b7XTaoThPiaKsmwNG1nne7FG1duonjrS85lQyghxqQ49P1f4apYy++Wtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

Extending the smokey testsuite to do some tests for the recently added
timer_gettime syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 63 ++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 8cf533f7a..b2cb9da61 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1280,6 +1280,65 @@ out:
 	return ret;
 }
 
+static int test_sc_cobalt_timer_gettime64(void)
+{
+	long sc_nr = sc_cobalt_timer_gettime64;
+	struct xn_itimerspec64 its;
+	struct sigevent sev;
+	sigset_t sigset;
+	timer_t t;
+	int sig;
+	int ret;
+
+	sig = SIGUSR1;
+	sigemptyset(&sigset);
+	sigaddset(&sigset, sig);
+
+	memset(&sev, 0, sizeof(sev));
+	memset(&its, 0, sizeof(its));
+
+	sev.sigev_signo = sig;
+	sev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
+	sev.sigev_notify_thread_id = gettid();
+
+	ret = smokey_check_errno(timer_create(CLOCK_REALTIME, &sev, &t));
+	if (ret)
+		return ret;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL2(sc_nr, t, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_timer_gettime64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Init some random values, allows us to identify that the kernel has
+	 * written the time
+	 */
+	its.value.tv_sec = 123;
+	its.value.tv_nsec = 456;
+
+	/* Fetch the time from the timer, should succeed */
+	ret = XENOMAI_SYSCALL2(sc_nr, t, &its);
+	if (!smokey_assert(!ret))
+		goto out;
+
+	smokey_assert(its.value.tv_sec == 0);
+	smokey_assert(its.value.tv_nsec == 0);
+
+out:
+	timer_delete(t);
+
+	return ret;
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1370,5 +1429,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_timer_gettime64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.37.1

