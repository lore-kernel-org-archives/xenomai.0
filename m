Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92021442A
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVG+89hVtlpUuWJKLhrTz37ulVbCLeVnr6GN/TzVMt6gp4JgTBUen7vyvlTBLt70TX20IHqtUzfIEInyt6SqOgwyXZwVGQcThAfA+ncH8dTr/Y8AkenzCvA6cdv3/vIWJSL9SzsH6z4co33hd67+4LaTb+PTBSrKawEIyrgDfzaJwrPTBCpHK3rWpmUeUACkclx628+TVCPvQEvjKB9NOxOAAagrNOFVdC3/ndHnsXbiZJMHL7Wa8NxWA4bw6YeRh4yBOZ/OsVScnpirtw2Xf4mQuLYPgkOC+cLDK2FSU96EeN/R0jNoiBW2rsDiAUxZzm8FnrPegDPL9xJf3MMBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSGDsh/RLrXPbnRE9iuZG/VstByjgtRBUVwqZ4RB/fo=;
 b=WYnrqea8pV4mf5UNjnKiBU3qOWSDH5KfJXACy30dtzUfwBM7P9JoPHvCM3dBWXTqBK6v2qF1W06+l76dybvxOewvS6OpQ04qKid0LGdL2zDy0w2SrguSvOZujVlPsNq8BuTb+1WXWmzQE2YrMTQXkABe46MdXsycbAotdtyNtpA2ga7HWeFhB+cPLyDhH0UYGSMGuG1jbOVA2nMznhqAOXpIofg7GSlbdnpPiUeTFzaltB4lnSk9kUeRl8UpklPqU0WlFpkO/68eHJiVrNCWGWksOP1haECvPm+0eYz0BJlNzH/lSILAsh9vcXiPwN5vfrPd09lrxeM9KVQhtk/MNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSGDsh/RLrXPbnRE9iuZG/VstByjgtRBUVwqZ4RB/fo=;
 b=DVOE76qeW+7sA0SRiunQa2oP8LFinUqHZm3W0wNSoaA2praLyiYj6OYmEjFltN9UunCzLsLGzdoGAz5OTKiHgMeRp7HPBQmbe51AtbsWlZOEF6aweSaSmIEymV25L7mqZbcxA6ZbgxOkkFBeUgDH9BcmAEXeGdJKEL3sfrJuvpgwHOqDp9y/cczLG49mTXX1962tKqBwWK6sYN+3Oma2n8vbW2LRYHWSEmO0PIkd+nqRnC1ddCdm0Bg8C4KrWnWMHdYp7uK5YMes4lj11f89fptJ/bHfMCeAOAQ+PIYgRVsFPUkwoCavxX84b2hnpCTle+YXkOYB0M0t32VP+RQjMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:52 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:52 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 36/42] y2038: testsuite/smokey/y2038: Adding tests for pselect64
Date: Tue,  9 Aug 2022 15:43:20 +0200
Message-Id: <20220809134326.23688-37-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::31) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7038a40-2986-4835-934b-08da7a0d45a3
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c0uFwLzTw7NUAXE0liYEHsIk5xsujYrlMg6M+j9fzHaJaZ5kspxY6WZx+MZzJL3mp7dhOBLz7JxLrtOOhk5nbbodsWLagbXuvl3UQTG4xHFa3N38rt/KdtRqYfPG05s1n7pU4knPyTLnawnrOBwG26Ot9aC/o+cM0qFnbSiTvL09VVcCLiUj7fyCkDW12H991TrGmrQXuQYClluYCNITsD1xgalA4z5mo0YEnqUV0gori2Z3ykhW8FIYT/tbpGeIoj0crhw/den5cQ8VAzrgFEp0YLH9dySJ06/l7TlmlckG/xghOJs1m+Pay/xC4XuMCzqb1itXZ1LocjTrf75iKQdy2zFR2plE4AlsHP1mkk+//0ql1uvyu/lJACA3HCDPtsr1FJWoNFil4ZUKAgAZiqhOafC5OW3kYE4YUXsjf1a6J4Z3Pb3Ieaq7jRZGt8c1jhy0Fd2rWLRr0LZdPJDY3hdg9T1LKvsYqw+PsPqaAYp53MLjblzTCYaGPeox7qrLFcTqFqhlZGgebpQCqS5FlE929ISQQja2a2/+JHMHvNNuOaDVqm6sK9dFA87s8C7ymLys0lJ+CLr+0ok14RXgD2x+sYBW8K9eRGVjt5KHk9tqGIR1IgLYKTrztIVaB7OAFPznm/sD0IZj3ab+yPWaN/LCy/OyslYD1MVpQAH3va35whn7chLzBEpUjsifESl9tyQhm10CdLhUDugHHiew1YhFN59SCBBOBdhGBR2Zt58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(8936002)(82960400001)(1076003)(2616005)(186003)(107886003)(36756003)(38100700002)(44832011)(6666004)(86362001)(6916009)(4326008)(66476007)(8676002)(66946007)(6486002)(66556008)(478600001)(6512007)(26005)(41300700001)(2906002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9xswEGpvvaM9S/FtxTAy0K5t70a49UiK+iRiGiHwJL5nLPstN3C8ayWc4Ht3?=
 =?us-ascii?Q?3TTjETCTlpGNMJNeUPKo3O1LIoCJSG67DxP4m+8KM2aZ/XtEOQol+wpQXpmN?=
 =?us-ascii?Q?d/HJb4FIG4zuXLOPm3pYnM3DrGlRXJJc8nMada1Ya7fIlfDotcJsTnafPABN?=
 =?us-ascii?Q?50OkxVG5xFA+8g6z6TcFdJGRpKm395+f0OZu+XVyFAeRBfLa7H5855lEuGf2?=
 =?us-ascii?Q?Z0qebqBJNssmyM1q7wZBnEnahhNYFhsNeESMsylUzSqx0uxmzf+vzX6f9q1e?=
 =?us-ascii?Q?yOUMVSauVgPZShQxp1gZA96jLTeB2xuqx86cfpWg+ln5IeNjuoB6XtIpLUrf?=
 =?us-ascii?Q?j8002zJ4Re3jb7RidVhaQSCwpE+AuMsSHk1eaDKHYzfohcPN2KjSGPoHF3/m?=
 =?us-ascii?Q?kFBk0QgjmMEVHtg3Ba3O0Jcd7IpR4PSSRoULrVbj2shyA6VOjSnCk5YguYO7?=
 =?us-ascii?Q?Qbz9IIH7DEU+/GD2MpzFWkDoZRajV0sHvaHnKtk+3HmYe37nkG8Wj3IzpUdK?=
 =?us-ascii?Q?NW0Nx7LDh08DXs6oGbgiJ1wQ5gWBMMH8t1fij7EPM2PHDVTXFOrmBSHghboO?=
 =?us-ascii?Q?nJK9nxaYcyB4GaklbwPSznAMGy0GdgJuV//jME+iXctiLSIPko4G3Jh9uNjH?=
 =?us-ascii?Q?fPMWAx3jc9PO8efRIGCDOxQtvgB6LnA0TnRIyGB3jgPzeGXWJKhWrAivZZqH?=
 =?us-ascii?Q?KA4ujc+lWjBsxtrPlV5Rvgh1WOeyH2O/PnndsxAOQQwRdA5c2zo38OXQawQU?=
 =?us-ascii?Q?d98yDxONKQuceEhcWf/WucTcRADlEEPdqAFtPQJbrX2mWWDXSPMLRPtNcWlf?=
 =?us-ascii?Q?n+YotdF8Ozytsr5FldZk8IoUoMYxQV3cimDEAG0BaaFGqxqKJcJ8de3JLpCQ?=
 =?us-ascii?Q?XoqftYZ/myP+UPDOKhjWmLO58h2HOrELc1krqZN3k6CyaP31G9ndp7iviI/P?=
 =?us-ascii?Q?HnugwArNbesfMmWBAueow796e7D1E90/natc9kzREAigVnuSpTkBn94cQLpv?=
 =?us-ascii?Q?yFMWI4CUgKjdxlgGf1aGsYIr4MVzshipDII2E6SjcKngEHkxn7KvAOrposUS?=
 =?us-ascii?Q?PrMG4C4J1DnQguI+l3i/tgsYydQt31OtbPoqca7OL1cFrFT1oElS7/M2Od73?=
 =?us-ascii?Q?AGREVaHt5+TM3d3k0NBil+2j7kZDBG6UJ+MGbrrZ7O4WfWqT00iSVV1Ye4rV?=
 =?us-ascii?Q?v8ykmbQ/JzaEMyP/wTQD8PMyPeo2p4k1MkKE0PWnCEkExIuekzsln0HEBEfe?=
 =?us-ascii?Q?nhI63OPTGt6W64xXAN1Llj/GBthD3JzJhR7qG2TBNx4opfhn6jWX5RpFVNMu?=
 =?us-ascii?Q?LTFQYxUyNQuX0xFDti3bGhk6qNA3ahGBlby2uloI4L182R82KmtE2iqCwGQs?=
 =?us-ascii?Q?yvWWvErJacO8fvTdQe6qf3aBYk6L0SFeKN23mXVAr0it6Dow5I5grYA8sv8u?=
 =?us-ascii?Q?8+LbOCVKpBo2i+a93B8F7c28iXEc3wwbrUVQGBKDm4U4nnRoL7k9SIquIJEs?=
 =?us-ascii?Q?FJ3o1NZZx6M97Cayqqu1ix5gqU0C6I9pNmbJjWxuws4FpRkInuRAD0XKwntk?=
 =?us-ascii?Q?2fghHMNufF94o+fbi684p3Hw6I5ekGnqfSLl6sHYTO84DexcuroHFhfn/kAz?=
 =?us-ascii?Q?2TbA8U/5nwIB5KwApweLFrQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7038a40-2986-4835-934b-08da7a0d45a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:24.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWGnB6TdHDbVVgwA+VHswYxMgWZPFo9GQPlYQfV996ZWzHSJNycL56Cqpr0URnwMXqswinLsVnr4qixXc+y9pd8Pots/++e6IiCsGahfEfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116

Extending the smokey testsuite to do some tests for the recently added
pselect64 syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index e3fa3eb9c..4fd051932 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1443,6 +1443,72 @@ out:
 	return ret;
 }
 
+static int test_sc_cobalt_pelect64(void)
+{
+	long sc_nr = sc_cobalt_pselect64;
+	struct xn_timespec64 t1, t2;
+	struct timespec ts_nat;
+	int ret;
+
+	/* Supplying an invalid timeout should deliver -EINVAL */
+	t1.tv_sec = -1;
+	t1.tv_nsec = 0;
+	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL, &t1);
+	if (ret == -ENOSYS) {
+		smokey_note("cobalt_pselect64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EINVAL)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/* Supplying an invalid address should deliver -EFAULT */
+	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL,
+			       (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Providing a valid timeout, waiting for it to time out and check
+	 * that we didn't come back to early.
+	 */
+	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
+	if (ret)
+		goto out;
+
+	t1.tv_sec = 0;
+	t1.tv_nsec = 500000;
+
+	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL, &t1);
+	if (!smokey_assert(!ret)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	t1.tv_sec = ts_nat.tv_sec;
+	t1.tv_nsec = ts_nat.tv_nsec;
+
+	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
+	if (ret)
+		goto out;
+
+	t2.tv_sec = ts_nat.tv_sec;
+	t2.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&t2, &t1))
+		smokey_warning("pselect64 returned to early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
+
+out:
+	return ret;
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1545,5 +1611,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_pelect64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.37.1

