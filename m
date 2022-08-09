Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EACB442C
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wqywq4elxovq0LLBf3C8Gef2TGDMM7oHkx5sPldfUQsNUhLML6kiCmVdxAHsmZjTCv3nDcsHCWR2fyF6CokJRdXXd5a+7pd5dHJOBNoecHPwqklQmXeKGc/zq2D30cdgsDQe4qbXI67BMNhxm5r/apUYssCK8v1pqXcifmWLGae9ayesJ73phs7eIpS5EgNxHy3AfDrmmHIgWPbRg5rgsiA/aJt/mUd931PB925Q5mDObJJUfJeqvIqCHE4rlglvvVgl0i7hNK+7mgnqCAIuNfVTouwn3GsUbVi/IzwFLN5UkFPZ602uMkIyzB/U4ZiLRUow+b/Ly56VOkoK6CpkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li0JsYBWOo+374wOOi8w3lbwyBJ3wUnGYuS/drIzF54=;
 b=NZ/fN/GMQ5G1E7w9FZSn8oKEiKjjGmMTbls702oqWCiqpHu7R8rLjKvECiswjIPfBF5Fo0ZBx9aDFlMuxoCofNMWTgAyoiykH3e07WZUi6eGEh1tgjbOGxd+6gk3JJLHgGUDiEyZBBTzQcI/UWqvNhkICpy6h++EirXlo9Cdx8qQeqSp/aizYAT4m5DRN2TwvgVNT9WboZ+40LnCKJpbgAo0YZLYBp5KhB52MHdHD01qc68HvN/Xo7DvcpN3rXQXpm/hqFygEVlNVL05YxTIaUko2/6adXtxOR7r/ChPmJ82lK5D/qsHZaoAFvAZ8HUWJ6ob2gItBu96JVYG50W4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li0JsYBWOo+374wOOi8w3lbwyBJ3wUnGYuS/drIzF54=;
 b=dEmFyzZQtP+Qn35GWnuNqlSkIbk7IScB5oeEdIxxE8HzTmIRNl4riuLtC+jyBrn87MfBz3aRlIU+IF6xSXCGVajmM2IlZghmzVV3SyuRstXZPj1MMuFFJtJeq/7t3aqqkHRAD0Kely5EyogdJAZi7OY7MN/UGPtDe0pHsdNR70ttJ6HRTyWHUX1lS7rBnLFfy3sFIhbMGgjEhuzocsrdeEL+f4CJnk8G4GxM9zZoaG/HNvFD/XIF77Lb5lBb5DI9RyKwSw2vSvYBjsmeHPz9GvoRysKioo80qtvWrMWdF6YMg0jqxC7fyHPg/XTtJS8VNZ5/OJEvDV+uRY/7klqNcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:07 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:07 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 19/42] y2038: Prepare code base for 64bit time_t
Date: Tue,  9 Aug 2022 15:43:03 +0200
Message-Id: <20220809134326.23688-20-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0266.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::15) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d634498-80bd-44bf-5dc1-08da7a0d3b53
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FtmrQL7EhmyTiM5+419BPUAIiap+CAMBteTF+Rj3b3Xg0WIHkFHJlG5H5qDhANAkDAGqXJc2iOUFSxVGDM+vifOSuyX47fmKxljN3rSGRYQs4cXcsJTGvodbZgspdLOAbk14JkHYABHSVBhfAY0N4MpnvxWbmqgQld/rMImr9wU9g3CGlfeM+WWM7OD651ANIycRimv8uf6wmWVgtg1tR1sqPQJyVwJrPIMhMyZ51aeRfZnnr6JHhZer/NowsuHgEjljoe0A0kynQjrLhAXXdwnlhVIgOlBvoV27sVTpllMSpxL/LdOB3PV7ZMnNhefWNu1nebJc1w+uuU1EeQE2I9BOFFMr73OIFceWcgcs3RNS7ZZQN8FvI20FEE2vAJKS1B3D95pLd6C4t4MsV96UKu17Zrl8aPFaRrd1V+gbzpGRzFxJwEm/vO1YbwNHlCRi4/3FU69wqNIC7F7vHjoFlxb3CgCXZDAVJ+zPytnNgKkm3YsfSQyarqg+LUfIxRe7yqh/vPeJ7G+dOCQbBlXh/E1F2QdSU9sOfkuqn8FRm7Mo31Kwwi3XGz/kPZc0NwzvjJUfZ8/P2ppFmLZKUORVsATmp/KkhYQyQ5MVvycnq+I55UcgyvXnClJFtar7MwnBnamhTKbm+yKR/7CP2u/vBkk6FtjE/H5GcI3ZNt+3ZFuXTmN1gupP2iSGHqfmMoYH3+tLh6TZkIk8orkqzS61FTY+1NxNLkttO2rSP0JbyyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XMxvG5+hBvX4KOHCe+JEOoK9AEBM7ZsgY9yQkAgKLDJjaN47t8C+30FnjQJ2?=
 =?us-ascii?Q?xHWFzr0qPhteWULu8L7GVPAJwBj1qJr27qzTcTsbUtjL3WnRAjCC7Fjp0QPF?=
 =?us-ascii?Q?SA1irdZBhKaj1Okc4R3IH4vFqD5W7wnSX/SCUPM/vrj55QNP1Zm3LMwmRWw1?=
 =?us-ascii?Q?IOCrIanlx3N6UvcvnSo0UQHDcnI47yDQBfu+hr9t2ZwFP5920GIfRSdHORtQ?=
 =?us-ascii?Q?EmfzjmNDto6dSOGHqjmogEVKcSs+0/HYEbx8315IEpTAP0gylmLmdOOEjXKa?=
 =?us-ascii?Q?o+WxlEjFN+127+Wf+pteM4ffP4hb65ZATJp8EcCPq1aeIINt0EnA6ww+djDg?=
 =?us-ascii?Q?kRHQGAzMuG9CGErqrDl5ID8wsOxhCXdnQYj+mN5LQsbCjOpWwRMBHnCZgv3p?=
 =?us-ascii?Q?xl4pBwW2c6BynAxJ2H7FwTMrZbM8R9Bw9sRymZnGDTC+5SBmFo+x2pSljBjA?=
 =?us-ascii?Q?HdIfuSPIRI3zTGALm4ulwl6G89WMdJL/es8GGs3vAjFmoJ8cguv2HJk8+OOo?=
 =?us-ascii?Q?lh8nzF5bXRwOaJdclDgRhIPHeJohhF9vbms8cbQmdkO6gTL7VO6lPvg6+uW+?=
 =?us-ascii?Q?uyfoLoIqXex8PUzrcTVJRILYsh4pDoEeK1V7y423jQhhmFdWPydtWoYVhkex?=
 =?us-ascii?Q?tEBSCYP+yB8mTfUD4BJ/JmHDw/C7RsR8mpJ6rFD2MzZlkSFBV7TmBXkti7y1?=
 =?us-ascii?Q?zpfvEOGvP/xuIdbGPOQviP+soVVLe8WlTwjyWx/TWfVJioHsJdLU+Q/Roo2j?=
 =?us-ascii?Q?VdbOroHHtNHDwtoERfEe2VpWRALYlu7iwMWtmKO6YkMCG/OjTtNeF+rxl4Tu?=
 =?us-ascii?Q?yTfi9o1qmzfkHg6XXpaZBfTCREmgjM0g/k9RkRdOniiKTPkzVcsdwT4QcVWn?=
 =?us-ascii?Q?YGUnzPSxWtO/hTvv0zy7PzK7CZ7yK9Ur5w/ZgOqYWKTzoG/TBSfojnzJHBY2?=
 =?us-ascii?Q?hY+YpgcXJgsecleWqA4Ba8OFCBtHDKW7Nr/lles1QuhJhfc8oZiHBzAtxQ8n?=
 =?us-ascii?Q?S16CsV3hXPxWzAse4M2pYh/unBGYUvxTtKIcUKB3jbn6Ih4j7ZyDzTAS6SsK?=
 =?us-ascii?Q?epKv4XGmI47fwr+qsvrwCBwXAkUAskg3/rOf3Q5SxDV8u++CCQQmhiDUJdpC?=
 =?us-ascii?Q?YNo3J2PhknjvWFoU2pkIZDQOxouW7hfiwtNhhTdSXMxqSQlc9tFTAj9THAf2?=
 =?us-ascii?Q?4lznzL2cQgScOe4hFlAY0DctywXLK3CQi0y/Xi9toJ9gYmIF1cpXd5XuDqDh?=
 =?us-ascii?Q?sApLGyPcwcVr4pFVhPFydHC69Ny+UAWhZ8EFGtDLp+A0L0/WqU8vaBX/W080?=
 =?us-ascii?Q?nFWoTaPr3MwbgXczufMCjjighCv80+Q880QmafdWKliLnWdPbE8jNPUAGw30?=
 =?us-ascii?Q?g/PNs10259t8M4HUmpbcXS4kuj3XOSUbVpUhwQOhRwPnaHJAXroUoQqt/Ury?=
 =?us-ascii?Q?5dyKfgGqZHbFQ1g4Q3IvykuYFERUDzgHXC59LXxxpU5DfO8e34ulwHkCJHcM?=
 =?us-ascii?Q?7YzQi6WW+hdcPV8CLlYd10rfCx8vAEAO393q6rZp7RKykhEZX7fmW44pMIUl?=
 =?us-ascii?Q?EQYUs6x9lajKdKeRir+D5ody/s0JZvikjmxfL3ykXsiGVzY5LS7jfMaoUqFp?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d634498-80bd-44bf-5dc1-08da7a0d3b53
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:07.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o301ZM73UfYX7LIojUktwgzkkz7x5HzT5ZWX3zpiSm6xOAQySS1CVzeAgvePOcr5n23IpKnu+sJk+m2/qv8RJsZ1mE01hJ+bETWXAc+6Pkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

Compiling the Xenomai code base with CFLAGS set to
"-D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64" - which is the requirement for
y2038 safety on 32 bit platforms - failed. We had some problems with
printf format specifiers which are now too small when time_t is lifted
to 64 bit.

Casting to (long long) should do it on all platforms we support.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 demo/alchemy/altency.c      | 26 +++++++++++++-------------
 testsuite/latency/latency.c | 34 ++++++++++++++++++----------------
 testsuite/spitest/spitest.c |  6 ++++--
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/demo/alchemy/altency.c b/demo/alchemy/altency.c
index e7c31d7c1..b15930567 100644
--- a/demo/alchemy/altency.c
+++ b/demo/alchemy/altency.c
@@ -258,12 +258,12 @@ static void display(void *cookie)
 				time_t now, dt;
 				time(&now);
 				dt = now - start - WARMUP_TIME;
-				printf
-				    ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
-				     "priority %d)\n", dt / 3600,
-				     (dt / 60) % 60, dt % 60,
-				     test_mode_names[test_mode],
-				     period_ns / 1000, priority);
+				printf("RTT|  %.2lld:%.2lld:%.2lld  (%s, %lld us period, priority %d)\n",
+				       (long long)(dt / 3600),
+				       (long long)((dt / 60) % 60),
+				       (long long)(dt % 60),
+				       test_mode_names[test_mode],
+				       period_ns / 1000, priority);
 				printf("RTH|%11s|%11s|%11s|%8s|%6s|%11s|%11s\n",
 				       "----lat min", "----lat avg",
 				       "----lat max", "-overrun", "---msw",
@@ -413,13 +413,13 @@ static void cleanup(void)
 	if (!test_duration)
 		test_duration = actual_duration;
 
-	printf
-	    ("---|-----------|-----------|-----------|--------|------|-------------------------\n"
-	     "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
-	     (double)gminj / 1000, (double)gavgj / 1000, (double)gmaxj / 1000,
-	     goverrun, max_relaxed, actual_duration / 3600, (actual_duration / 60) % 60,
-	     actual_duration % 60, test_duration / 3600,
-	     (test_duration / 60) % 60, test_duration % 60);
+	printf("---|-----------|-----------|-----------|--------|------|-------------------------\n"
+	       "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2lld:%.2lld:%.2lld/%.2d:%.2d:%.2d\n",
+	       (double)gminj / 1000, (double)gavgj / 1000, (double)gmaxj / 1000,
+	       goverrun, max_relaxed, (long long)(actual_duration / 3600),
+	       (long long)((actual_duration / 60) % 60),
+	       (long long)(actual_duration % 60), test_duration / 3600,
+	       (test_duration / 60) % 60, test_duration % 60);
 	if (max_relaxed > 0)
 		printf(
 "Warning! some latency peaks may have been due to involuntary mode switches.\n"
diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index 6cd3a28b4..7856b48b8 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -322,12 +322,12 @@ static void *display(void *cookie)
 				time_t now, dt;
 				time(&now);
 				dt = now - start - WARMUP_TIME;
-				printf
-				    ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
-				     "priority %d)\n", dt / 3600,
-				     (dt / 60) % 60, dt % 60,
-				     test_mode_names[test_mode],
-				     period_ns / 1000, priority);
+				printf("RTT|  %.2lld:%.2lld:%.2lld  (%s, %lld us period, priority %d)\n",
+				       (long long)(dt / 3600),
+				       (long long)((dt / 60) % 60),
+				       (long long)(dt % 60),
+				       test_mode_names[test_mode],
+				       period_ns / 1000, priority);
 				printf("RTH|%11s|%11s|%11s|%8s|%6s|%11s|%11s\n",
 				       "----lat min", "----lat avg",
 				       "----lat max", "-overrun", "---msw",
@@ -386,9 +386,10 @@ static void dump_histo_gnuplot(int32_t *histogram, time_t duration)
 			return;
 	}
 
-	fprintf(ofp, "# %.2ld:%.2ld:%.2ld (%s, %Ld us period, priority %d)\n",
-		duration / 3600, (duration / 60) % 60, duration % 60,
-		test_mode_names[test_mode],
+	fprintf(ofp,
+		"# %.2lld:%.2lld:%.2lld (%s, %lld us period, priority %d)\n",
+		(long long)duration / 3600, (long long)((duration / 60) % 60),
+		(long long)(duration % 60), test_mode_names[test_mode],
 		period_ns / 1000, priority);
 	fprintf(ofp, "# %11s|%11s|%11s|%8s|%6s|\n",
 		"----lat min", "----lat avg",
@@ -515,13 +516,14 @@ static void cleanup(void)
 	if (need_histo())
 		dump_hist_stats(actual_duration);
 
-	printf
-	    ("---|-----------|-----------|-----------|--------|------|-------------------------\n"
-	     "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
-	     (double)gminjitter / 1000, (double)gavgjitter / 1000, (double)gmaxjitter / 1000,
-	     goverrun, max_relaxed, actual_duration / 3600, (actual_duration / 60) % 60,
-	     actual_duration % 60, test_duration / 3600,
-	     (test_duration / 60) % 60, test_duration % 60);
+	printf("---|-----------|-----------|-----------|--------|------|-------------------------\n"
+	       "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2lld:%.2lld:%.2lld/%.2d:%.2d:%.2d\n",
+	       (double)gminjitter / 1000, (double)gavgjitter / 1000,
+	       (double)gmaxjitter / 1000, goverrun, max_relaxed,
+	       (long long)(actual_duration / 3600),
+	       (long long)((actual_duration / 60) % 60),
+	       (long long)(actual_duration % 60), test_duration / 3600,
+	       (test_duration / 60) % 60, test_duration % 60);
 	if (max_relaxed > 0)
 		printf(
 "Warning! some latency peaks may have been due to involuntary mode switches.\n"
diff --git a/testsuite/spitest/spitest.c b/testsuite/spitest/spitest.c
index 6163e54bf..99d609403 100644
--- a/testsuite/spitest/spitest.c
+++ b/testsuite/spitest/spitest.c
@@ -233,8 +233,10 @@ static void *display_thread(void *arg)
 		if (data_lines && (n++ % data_lines) == 0) {
 			time(&now);
 			dt = now - start;
-			printf("RTT|  %.2ld:%.2ld:%.2ld  (%Ld us period)\n",
-			       dt / 3600, (dt / 60) % 60, dt % 60,
+			printf("RTT|  %.2lld:%.2lld:%.2lld  (%lld us period)\n",
+			       (long long)(dt / 3600),
+			       (long long)((dt / 60) % 60),
+			       (long long)(dt % 60),
 			       (long long)period_ns / 1000);
 			printf("RTH|%11s|%11s|%11s|%8s|%8s|%11s|%11s\n",
 			       "----lat min", "----lat avg",
-- 
2.37.1

