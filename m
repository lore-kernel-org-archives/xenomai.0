Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A46F2512E6
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969133; cv=fail; b=CGBSmcdO7Thf5carzXDc6z/Sajxd+kOQDlWK8D3/vOHz1/+q/9A+F+9xLMoh1t1JO+n2ROqVNXdDorvaHEEhHAZAUD8oSx1iUazL620jUXoJ6Akld6hkUPBU+ILLb/Oxo7Zj57Y5Lo+ROj867wE0i4iKQyQyFV9jMgPx+NFTuQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969133; c=relaxed/simple;
	bh=XoWfltBO9Sk5jYQT2nheKZjuyjqcytDn/N617Mmf874=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iHnmD92vdVqnZong+znR0q7jl5h+QZPLfaFg6oiiNSoWqADs1JaRxXLhc73Ng0nYXHMdUw+BVZSzEimIhTW4YEUATp30PLLKGKXWlqMOgCrLdC3MnWznpm3piwhKg0kvsE49neUqucEYuFrLSOhD2twO6irgNVMUtfJ41kqWTg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nv75+VH0; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nv75+VH0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMdIIibm47JNGspIgiMbGgU3H+VEUJpImwFsU3YcMoxdeSFwFQNNvlj6mtP5uuj5+2OPMnPY62UHjUqLUIWyiuua9e6hlsK1aMbk3793KJB0TOFpLE+ZjHvmKRZXTb4GBVksLC/JKVGBY0qn0LF2u+I6pO51KOqdGkUlctr7uE7bWkMoIgTqKAWjJr7boZVOPywvgfCx0Hr4KsO0ctizt16/gCZLwqjZf36blo4FTbP28xWvePP1oG6ppwD6DzW2wYFerl70hIFJVRN0zYdYLrkNKhyPPsfmO999i8bmf5gx0OF+h8sRoYxB0RclqhgD7he3k7WqEZP1dJHpYHXglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN4Uh6yyaz6kBPJQlGAMAbG2+eQjO4Vow3oY6XcOzo0=;
 b=Du7XkW+qU3tUHgFbFkwZNrRdrr673lRS2q4K2HCqeq+jr5Y1Ww6rTndVmJk2CLjA5w78niy69j57fla1pfmNJ/NQGrn56agvt77UsYNobOxRnL4vKQMlyUB6YxDtuNJf1LtRYatjBF+9y8isSt932ctKVYb9P4fiuIAsluMJEXH8yr/euqe+4HZaCIcOoacg7S/r18Cw5YyvH4f+4v1MoCVxMG2TbGHg0IjEQN4vLbGVAMb0glVVDiQIMHWdk2uu8cyf5qvkVGS9quRELubIYe1nwBdqQJgwLqmOZ4rVnPbpZM41C1GlH7qE4hTRdVgRxaP14ynVJsdtfFAw1SotwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN4Uh6yyaz6kBPJQlGAMAbG2+eQjO4Vow3oY6XcOzo0=;
 b=nv75+VH0UcoqUBVMT/r6S25F+6d/oXzHzipqQQT6YpvlLa5ggkHltH4SiT0wxKMr2tqltRZgWtLweuuZcDIQ3Q6eOE66aCZhTcZRTcD2MTmUbV21HYM6e2HRMVWKWOk0bYkNTWuH87PurY359ThqRlvNkgGKnplGvTjvLv+9CeNJefstW+gC+nOE41YeKFVZ371+t4ARJ7ro/YwhgdzRjarRp8kHwa77GKmD7T674j/xSsViNZlfn10KDJXz+/xBMFj49i3VCFnen+vNdXR8YrQhVOcX12/Nkzao2BWKce3mU4CEiocvrpMFlWPdDJYaPD1x6y6LLzxqssnPIGuEpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA1PR10MB9149.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 14:32:07 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 14:32:06 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl] evl-test: return non-zero status when tests fail with -k
Date: Fri,  9 Jan 2026 15:31:57 +0100
Message-ID: <20260109143157.1102568-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA1PR10MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: 45293938-7faa-4c2f-7823-08de4f8bdd26
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gD3PKdfspUq4fsHgsZg9BLGAdmCZPSRoMcsDjyZQqRzwtZwuiz/I5BGOdCBo?=
 =?us-ascii?Q?ZjmpuZf/weGtoyIrKJuDH0fHOlHwTAUCmzZr9nOzmfz8xWVUuKquD9W04vLY?=
 =?us-ascii?Q?5Zsfx2lBqsgDo0FL5u/XDrhusWDqaouIY6DSk5O3hes7qNiqoPQ5+46+n/pm?=
 =?us-ascii?Q?0jqSlkxN3LSqtIaGtdUDupH0o1G7PYHhKhO60Kn/W3ok1VpVlot6yE4Ew6W+?=
 =?us-ascii?Q?Ls3Le8fzI/WxD2D/FIz7rpaQXgcz4YvjJNRGpmWjz5i6VP+Iqkpd2RVhZK+a?=
 =?us-ascii?Q?HQ8HI1qfFbDpAGnLeyMBM95tidCJ0dLvi+1UZsp80dOtX2R1ibB6V0EYrh6y?=
 =?us-ascii?Q?RIzpydmb/6YmZ8snMYHTZFBU0m4gF47fDkLHaLV8Uz+kWTZspu6tUFiaK9YG?=
 =?us-ascii?Q?F/q+bCc37z+3Fh12WnrKvyRG+nX1asvWtP0oHruCqLCNsb0pE5SkaFmQy0AL?=
 =?us-ascii?Q?y664fZWC8JPTOprT6L/FA+Yf9f+EXxUqMSN2xEiDBi/KJ5iY9QpriBEHIMiH?=
 =?us-ascii?Q?ZFaAod9N27Z8UobKg9OTvq23vL5uDoWmNDoG0jjNqJYIn1PJbl6G+gjXtX/u?=
 =?us-ascii?Q?6PU3EW472K7N3mGYSDp+MiZdmWwTOHJ/UJYaUYsx9iATCP8skRVHi6xzn6Xs?=
 =?us-ascii?Q?67iF8AWegENV59JGWt1IcLp68WKrS4DzfmTHT6l0LQwY3ROl8i40a4AOKfmi?=
 =?us-ascii?Q?aBNjao/9liYXfGc5vLYV7W0LqgK6aMtYPCAiqSjmZJxe/LvK59HFjbQPeRSC?=
 =?us-ascii?Q?EjdEFfTICoegg2Akvw2uwZlUqFssOGfz01NE3308RC7GD4AWGEu6ELbuPEzx?=
 =?us-ascii?Q?rSc9cchW0VgMamF0q09Oi67zdgXrq23Q/sMRv/bTzomVK0zcYr+sn0OAGANc?=
 =?us-ascii?Q?qlefrsBUhLTM5drnXeTdlFlo7VbXkom6uhWyJRTZi4FyaTv0+57AjOtbLwZF?=
 =?us-ascii?Q?mCfKQOSVKYFyDikx3WpvYnW/0ifSw7UvZbolPKGt5H+uZRnQpbgAE+T+sof5?=
 =?us-ascii?Q?AYgpqi2RNMipX0YfBEiyARsPK+HFhp4uYGNB56MGl9yV/+y11pA4XldWQ0Ce?=
 =?us-ascii?Q?l2Gf0A9pSfjxZrc15MC6s2mV3wrPcMoCTvewl6shPFXq+hkqkwVljh2C75AY?=
 =?us-ascii?Q?X8T8sEgBXfz6uIneMosLE0Hejxkg6w17UJX+iC+FWNCXkEDP9866EoGkpdIB?=
 =?us-ascii?Q?Hk2p4aI6D7QfJqg960c1d7RPkqHoCD4kBdU0gNP+qs0dj9xNcmQ+3H0Qb81/?=
 =?us-ascii?Q?oK9q+4lsut4NycNLwW79dtPuQimnre2QShjNxvEF61xqa2WK/uWkOsStzLtG?=
 =?us-ascii?Q?yzrkXvdxEawVQTZaZqdi2OIQyjeTWYXXp1urzlEVhSvpxWOHPpX2ruGK/5Ns?=
 =?us-ascii?Q?Hi8hwY1R6stjFa1sOF2bh0Mj6Ce11b0+NBcMvLyhebQJmqr8DkfCQ2q6oZhe?=
 =?us-ascii?Q?7zPI4sG2GOHnTF7mc0hJJ/iGknVQ4vcu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZqwNg3q1SSEr5tm2eR3wEge2AYSEyDweuySrn/76/T43KtQn68slfI7sNQsc?=
 =?us-ascii?Q?58t2nnhlN885YIvupUtjnmp+On1nMTjItpveLYN1hJ67Hc4DazsQ3qRKGFXU?=
 =?us-ascii?Q?+jU9MzickllvERZruY6cFHbNxtzVmyTgpBwkNgV8Gt1WQ7bVxclyz2S3Np0H?=
 =?us-ascii?Q?R0sQHOlZvFUBp13BrYTEht4EptnOTkoirnKT9FtbcwgDeyDaz1Nk52C5DLY/?=
 =?us-ascii?Q?p+P3k+fiaxjlEvgpJD7P6tN+WoqtKjzpEHLbFxIgzJN1eDVES7666Uz6BUW3?=
 =?us-ascii?Q?WUJ6+Ui5EtA2Q8gCvaJGEM+qzHJAK1/zv8CcdgXUFfxMT9L3WHqiJXeky0Sl?=
 =?us-ascii?Q?NyimEI7vqx5pDmqzpjYnYW4LUdR/mjZ2L/QD2o8RTrMG1BKEjT/9YIkI4FML?=
 =?us-ascii?Q?c3eqwocXo9DJQWNC+SqmR2zJDr2dVwmFAXrcixulNtSx5pqw+TqiPf87Bl+z?=
 =?us-ascii?Q?+5fsB/WqpyTkBjvLZxheH2VQgT1fnNyRtQ2wPLUHkgh8k2upHH3sKEA4oFdB?=
 =?us-ascii?Q?F/eUMDYjJonA8aXqV1cf7JiKoPVmtWOsJkKARMfHqPaW4daJOfdhI0neTAM0?=
 =?us-ascii?Q?1517h62u/M80z4Vf3s5wodPdDe4AQTCqty9C+I1xZ7Pwyl1hvdKC2qXdOiGl?=
 =?us-ascii?Q?Jk7YTXdiTl6WQH3B5HdiTaAfj+FHDfUelPd9AOQFdR/VF7jdQtXgMQ75nlf9?=
 =?us-ascii?Q?PEQBoi3ztENKsoknxrvTAmi8JLd1pZvSmU/4S5lK5k/OKjp3YIsR84j1jZ8a?=
 =?us-ascii?Q?lJxvni47Nhvu0J2GjpN6iigaLOxIzMm9/SxUWXfWpdT0xz2EjVgoXn+DHrDr?=
 =?us-ascii?Q?WWx9TG4TO6h3GlwrCqHjimG3oypuTVTL+JQV8VLap8D6FUi0JkT+XRO1Zqn1?=
 =?us-ascii?Q?5NI3sD2KrTEsO0Tjyf4ugiZbqiD5YHL9TKSzfLbsjKSusuU6Beb04sH9Zh4c?=
 =?us-ascii?Q?2sDKBL8ogbCf+LdxsFEc1LBXmBeUTgpj7GJfeMgZHt4wLct+DNMCFN+Fo55e?=
 =?us-ascii?Q?XUSbRU78XwHjG7BWJ6lqpJvh+tgtQKa4WVHdFx4klG3NGLcF8DhXr+jAsdCZ?=
 =?us-ascii?Q?pDqmkCt6wDMNURaaZGImZp10mnEv/GrEntuXQCAgosd3dravOR7NGRhk3q1A?=
 =?us-ascii?Q?bxfAXssXaQHUpyfg9OwYVMCzp6LSXcI9+JGV9z52hpRfULLVDVorJF5riq3Q?=
 =?us-ascii?Q?hAGNZ0lpUbAw/J44VM0aS/nnODV9KikwyihQbNvaNAapgoAGE/9xdQ3s86J0?=
 =?us-ascii?Q?fGq5BdHUhZHTM3njxU9woUfdzCXQsA/aTXQJz05DdHnLy6CINtYUdlbBOmdU?=
 =?us-ascii?Q?uxUP6epOYdYIi/4Hr8HTfp4jyzsjAa8G7MeI7tufsTYastFFKBvc+NQr4YkJ?=
 =?us-ascii?Q?7/P1OvafE+XSnXNXa5yQZekSTs3A7Of2yexi/1NDIetOSxL9gAoz8X87C8fo?=
 =?us-ascii?Q?ZHzGOULGesmqJXHFRCbJDrblwgXrrOtDPAwDcZcuvUaKAyIBZqhdOWdcKGdI?=
 =?us-ascii?Q?5/5P4LBbidpyfxFDvTu+9OqqepgRUy4n9bivZGADMfHfD0gEoZbYA4CFzlM7?=
 =?us-ascii?Q?RoNIGnDD/8NuyNf1LS8oC1aHPkElJMdN25mi2wzil+YLMyt4ueVTvYZ6GRou?=
 =?us-ascii?Q?5jPqdLcYIyVB6Hy27u2trPrq+SJtOXNV55XaYNPSQfbr29b74XoRFUSMWWcQ?=
 =?us-ascii?Q?lj//MjNwR/TR1PZXX8JFqIY+8YyckfsIKvpT7IfNW+PzTFbW/VbU69QUC5Ee?=
 =?us-ascii?Q?7gfzPwWe/94mDMoyXmMinvq5Sg0AjAY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45293938-7faa-4c2f-7823-08de4f8bdd26
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:32:06.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiV8LXPbc78MndlmAmvDCKaVONKKSbalJdpqI8iR48BwNqTLOzaDzFuEUEScpTEm6gKsAErq8rPZHwrA0ZaiTWmxKnIUUpJGfNCaKKE7EYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9149

The -k option of evl-test allows the test suite to continue running
after a test failure. However, evl-test currently exits with status 0
even if one or more tests have failed.

Track the failure status and return a non-zero exit code when any test
failed.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/evl-test | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/utils/evl-test b/utils/evl-test
index b2d3a7f..0d0ca81 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -68,6 +68,8 @@ if test x$do_list = xtrue; then
    exit 0
 fi
 
+result=0
+
 for t in $test_list; do
     test \! -x $t && echo "$(basename $0): $(basename $t): no such test" && exit 2
     # Swap stdout<->stderr for the test, capturing stderr into $log.
@@ -83,9 +85,10 @@ for t in $test_list; do
 	    echo "$(basename $t): no kernel support"
 	else
 	    echo "** $(basename $t): BROKEN"
-	    test x$keep_going = xfalse && exit $status
+	    result=$status
+	    test x$keep_going = xfalse && break
 	fi
     fi
 done
 
-exit 0
+exit $result
-- 
2.43.0

