Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A44429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnEB2S8Tdax1rPsREsfg6+OVrnP+nE7plPre9iI2KQwBjQNQvSjEZkX2Y5w0egyhsnoNAaPoH5J6OQ0bdqsljl31p4Mra7dLyUXZZjRr+WGnl2lZGz8LXjiL8qmN3TRnzWtM7hpc5JML0m52r69Ok+FHd3hIwsQbpOeqsGUrKXw2nsgHNhBElWauLIBQ593mdUa3L2+z4MzX6fqB7T6nkpfoYCPw9kCQBErsdxhIZp8ZqddCJq5ftB0VvXjQgQPtaZV0joYxCLm9w2dNNanOsKUgxU4It30pOt9GVe2ts/9/kkpilY5GADm9SdsIoZ04QgWptaxmgYXdZVUn07h3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0F5ijj4WrbDskQnCi02Rtd+61gF1uw2zD2SIO/D4ttw=;
 b=CQaKMxe+uYkAtSrckhwE4k78+X5IHN2yBexf/JAnAmmKv4RFHYUtfr/AlEffL3zl56oYWenTYfNM+ZL9xq9smcfLZru4AUDCYFFnZPZPPYRbvoYWO7iLz3odm5hdLsCIDUs2czBiw0ta+wEYwWDp3pndmXcgVz/Q1hao+X1ADXt/TlgRGE2BKlCs0UR5Da6PU16BYjc3SQC0M+kGYkvRPpyKjXS/zCgI9Oay+Bguf2JqP/hO1I0xccCvVK3Ytsm0j/Xm3KXIP6wQ2i9HNeYqqqmZXn+F4qYVk8kfwqNsPjaoyQFQbdQLpS/JBaQXGNrIUDfy7wr4XijUook8XreP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0F5ijj4WrbDskQnCi02Rtd+61gF1uw2zD2SIO/D4ttw=;
 b=E760PRnjFjAF115VAnDtyfXiGzc8Q3bFcQrHaxvtYFDjjzv0xByHBEsHO1okNpNQkUfqT6wpfbNTAm4g7crP1ziN8U3PpR0iBC/Mv9rb1d7i5+kMrkhQMH8haY8TxlWY+FHD536RDdYFgblLo9AseaNaW8kFGiv+D+lzuGU2AYF2LrVeJFaM0oGEQFwhDH50nn9KxPjT7O6wAbDCCVHnb+7WOtrC0ZXRXG0gijcutJ8kubrReX0hp6+1CfshPx4fs2cRh7DWwJxFETUpA9GXJk6z3zZUihXVf8cTAxzJnLE9Hz3UxHEBemSQH/1cPsG2vtagDt1tOq7QzW6oz0zfQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:50 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:50 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 33/42] y2038: testsuite/smokey/y2038: Adding tests for timerfd_gettime
Date: Tue,  9 Aug 2022 15:43:17 +0200
Message-Id: <20220809134326.23688-34-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::12) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1f821e3-7116-4161-4829-08da7a0d43ea
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RKo70XVTe7eBik02MdilQeRzeOMG2YyJG9F7f27yJ4SqN7hQh/7i7/CWFeHUDgSFC205s5C012dSmVrpHRPSC9g9iNm7Kh152x4DCcKM3uiP0I/DXVsyrvDIdcb0IoxaWGheeWg6Oifd8B+QCw4bVmHP2NSre/7Jn2hl6rs/xmQtLt7HjR5zdZBa2T5ZdkE3cuEOMeBm0V6JVE+qN3yy1NaFq+HW0sjOyY2o9hpUc0kvnS5u7SqaGDrKhH4icBRNAxI+ztaEBb3rSAWM82UCxA0qNQ6C/SaXkxCEcUxKOdZHDIeCIOIxtiIiOo7lTmim1rcvadHp6M8ohKIT6xRChcZ67CB/CTt4g/GPYlvRrKcxLROzrLkw+BvgpM/cLwzDLkaTpm+k4mIhdsQEZFv2XXURVlh+ZqMf9n+zx0jWbptQpKrm3BTWkauDw27/oHhkLWfPOWPWqrMlZHOLw7dQ5tc6/+cM0WSUqd3I0bF9aCZrFyPAzRu3d36zj2mUzdIjAb8aVa5M2lulVynUd+i/8oDGbR3zJf7BZRvZi/bSH9rBwOok54LsEa/AH1KPYW9MshFKZzdeZf3iI67FqT2H/XxdKXC+x+ybRd0L3F0tVmpQ5tt2r3TJb7tKIb2p6B7ydSd8TVC7Swmo1KOPQdNnU9hp0ZTuJSJDjfZQzYzTWvX5u+O2ObbRPjCkVhuCgI0mwjDEOPQwu8n2swpyygAEXbiCqUuaC6JRrp41onArEps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(8936002)(82960400001)(1076003)(55236004)(2616005)(186003)(107886003)(36756003)(38100700002)(44832011)(6666004)(86362001)(6916009)(4326008)(66476007)(8676002)(66946007)(6486002)(66556008)(478600001)(6512007)(26005)(41300700001)(2906002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rvxDCrDY2lS7U4QBoy7MGXsTdZYdsXW5PkXiRpfZLmwSgDseQHvNe4z9fj1i?=
 =?us-ascii?Q?37xBUoI8hB+sVZAR+PJKP2AD/QQul9EZgfxArVgpOqWLr5RpOLwkIjmyuf4F?=
 =?us-ascii?Q?sy79nZxYKeeJ1BpcdfEe2qYUy+98td1ddIulHneE7aaWCMqAHQdf0Z7FW3aa?=
 =?us-ascii?Q?qdhhmQ2NGZ2tT0bR7ka15n796GRm3t0Mp7vrX8zH2TtTgi8VHa7YT84uiaEN?=
 =?us-ascii?Q?50U9pGoo4sw9+NL4Np3aaONbip2va+Po5tJFfJ/rJE0X4i5ftfG3bci3lDEB?=
 =?us-ascii?Q?h2GSgTjYqKHj2XIH3QChxQTqY4qGQklElFv1mOi0295cxEbAjokmVXT5EWBt?=
 =?us-ascii?Q?9hRKOKiIXYMBAMwToNEGLRrnqCzadGuVv/vMwFC/BZyG3sS2yvfqhkXa3qAm?=
 =?us-ascii?Q?jIJpBNyeMCAP7JdCRzKhbWn0fDBIHlzey9SUTTRcoRXa0FmdlFEm34SPvWHW?=
 =?us-ascii?Q?ACxGdtz/LVb3erXmm1HZllRaJM1j9PFu796VG55XaR2096CFoulVJElmcRME?=
 =?us-ascii?Q?MohKwqho36prN278OE68Sa9SHj9JabrMuK8B9JS6y+b8isweu9AsleMctzJ6?=
 =?us-ascii?Q?zaSDuj5Q/XGoi1FDSQ6vOnakB+BysSvS0I6sKJ2YNxlbRaELUZYDDj8c3auy?=
 =?us-ascii?Q?daIBmWwTRRC+7yKnmN/uAFIxsKaSjSZUxR6p2TpSyGOuydMC5NuBUB2V69Zh?=
 =?us-ascii?Q?IYfqBy3++kHFHWJLayWr5UZ3VmOf20yrjeDU7LDdEFoGI8t1IrDCpUG4DCl1?=
 =?us-ascii?Q?wAI8X6AHEzKgoaRc8f+8bYU3y5qrbL2FYHujyOegunnHCcUY+UbG0WANd1kc?=
 =?us-ascii?Q?e6uzm91mAzXR2gE2P5jsWzhTqkV5AnXWczN3FVnsAFLTptpYJ8UePs6iFCVL?=
 =?us-ascii?Q?EG+tJXDO3pYsVD2M0shqMVGQxCYJRlaJrDPzW1Nh2D8vpUwUHanMOWv2DJNk?=
 =?us-ascii?Q?txEGPCR6r6zRhjhkxlvW8WTYJk1yXow6w5QCTXR+PCgqG7gbdfJJKvtA7pg4?=
 =?us-ascii?Q?g/cHaMXgJSsIocB4MLqtu4mi2OoXwir+gZlL9cvY6sA5TOu3aAXRBSrRzXZ5?=
 =?us-ascii?Q?KJLNzQ8MkzOaOod0fJhgQTA0qJYUMrRoveQTyykO8s5PbxhEcjjjLIflaGOR?=
 =?us-ascii?Q?7I1csjxjC4Z6IdBnvHCOleRRjXTquPeLTowxDjl9Fx6cyK/A+xKBL6sKjt3V?=
 =?us-ascii?Q?j8xV0r4DPTyipVwPzIrUBl9ZbTznIqGi2rPnx9ozPHo9D/kZwoXo3elLoycb?=
 =?us-ascii?Q?oqwXN+22vl30SNfR7d1hvVjswWtFkvPN73vMDGcvFelkHUJOeSoB7iZ62Tqf?=
 =?us-ascii?Q?EHfOEGthO2qLtye7ywdWH14qvRThuTp8E3kFFMZJCMgzHO8rHevY/dy5Daxa?=
 =?us-ascii?Q?QLWmfyXeU/00GEIvrPxTsWvyVIPi+lObggT7McAhZ/ofwGGzsE3WqGmR98R/?=
 =?us-ascii?Q?4BA9H9E96dY0RQvxmgiIMJJ7qoL1hUwxx9apwxh9ql5fkRAFqikN1YGsfBnP?=
 =?us-ascii?Q?EhHQGfKLSeIEaE2muFUFXSfkNF5HytIQSNBwKCxp2peAj99WopexBYmQeq9j?=
 =?us-ascii?Q?nguqbCx/qQcXae3fxKcP+ib5HVB3nblO0atNTMhYD8wnqQfjkgNPcF6cRiKa?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f821e3-7116-4161-4829-08da7a0d43ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:21.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cR+FcqYzDJnQZJCjXSt1haBToWEC2VW2CQABVEKZ2gLY3yAOPZ2IOsvHmZ7dG4r8/rSbSKEIQL5FO3kh6u+YsIb6voCaStdl7NYXgVPBJWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116

Extending the smokey testsuite to do some tests for the recently added
timerfd_gettime syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 371c3a79a..e3fa3eb9c 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1397,6 +1397,52 @@ out:
 	return ret;
 }
 
+static int test_sc_cobalt_timerfd_gettime64(void)
+{
+	long sc_nr = sc_cobalt_timerfd_gettime64;
+	struct xn_itimerspec64 its = { 0 };
+	uint64_t buf = 0;
+	int ret;
+	int fd;
+
+	fd = timerfd_create(CLOCK_REALTIME, 0);
+	if (fd == -1)
+		return -errno;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL2(sc_nr, fd, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_timerfd_gettime64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Set some random values, allows us to detect that the kernel has
+	 * written the time
+	 */
+	its.value.tv_sec = 123;
+	its.value.tv_nsec = 456;
+
+	/* Fetch the time from the timer, should succeed */
+	ret = XENOMAI_SYSCALL2(sc_nr, fd, &its);
+	if (!smokey_assert(!ret))
+		goto out;
+
+	smokey_assert(buf == 0);
+	smokey_assert(its.value.tv_sec == 0);
+	smokey_assert(its.value.tv_nsec == 0);
+out:
+	smokey_check_errno(close(fd));
+
+	return ret;
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1495,5 +1541,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_timerfd_gettime64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.37.1

