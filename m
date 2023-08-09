Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C836131
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 11:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQTbmYy76tCPeGvWT6Z6mbO62R1e2nfNlw0J5qflH02JC3ofCDcQaV4luNUWts7EHV2UeLVxUx1Ma5F4B1JNrXPcFOJxKZbZyesqj/L/vZUNiwmHRh6SRU2YI9ttPTi8bh+W3Omsgvq7kkHvOUGBuPg1zhGe03oMtvVIeoWBLmTtN+PJR2aUbLeXI8lpxUHcdjzVs5SjZqixUC/aQXz3ehwzFkcZmQgH5gqlcsCP2dLm4i09OB6e33902OUNa20ixn2cxbviMj3iGQuo6YvAe0f1hwF7wy69DwmYkdzkMvlgcehluda7wYd+/UQunFShNeF/OrXN04Lp3uACccvKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxJjodyOc0Muy1aYJaoZfy+FNa32PVfAHLBwGvipc1c=;
 b=dy8yLklWnBxHYHteKxq9S9M61JHxzwkMV0ghu6Mp5pKCe8qT4DwFR1eJgUzYTa/dnrDUff74o3kpZpprjtXkenfiUPN5JBVUaIPiUI0pLHLU5CdAAC4l33bZUKkrc75hOlvZoxw+7wb9Xg2GRtZriRcih37wMjGn1hg9Co0TtbmIzFm/LxvLLfXPgdA/sZ52ZywxLrji2lAghmYmAatVn6nEaWCzf1r6ypxNCGC9R095mRRotd3Ml+qtgFUTkMteBXAZYWUOJVlmPrCKOTZe0l0eTkjjcxcSOMN8YJeZA1tYUs0ndMVlVqof77k2jcOIHJ2rlsoGElaJsvJTyrXQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxJjodyOc0Muy1aYJaoZfy+FNa32PVfAHLBwGvipc1c=;
 b=zWNwjvHvtx7ipWoRmXpxG14+BtX6VnStWK94f5tCeXwCNtihIFbSwaJbbWWg/4Z4koxCDLFiEYfkRCKaXbrmte96Z+dNUC6KM2JyYRHIb6/Rj+7TKUlN+0amTBHJwpLEK4JckU0ArBrGeCogoKJdZy5V9DzSHcm1BgVXBv/Jleq1ksxQUx0sBcAo0D2FjRJ4XODqfNZaLVRe1Se3o7PfStcXR9wjoE+Qo/gMyNv+PIaCx50j243VbcXJKW8zDq2p3Lb55KSdIxioWK+hxK4Er14eTbc2+oj6bLgM7YD9jJbBUTJxKY0LY5yXZJW2Yh7MgQekNumc0ghFNYziCCvvNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:581::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 11:32:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 11:32:38 +0000
Message-ID: <cf0beccf-50b2-408d-8a48-23f13b22c6b6@siemens.com>
Date: Wed, 9 Aug 2023 13:32:36 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 01/10] testsuite: Fully integrate alchemytests into smokey
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
 <20230725082959.5144-2-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230725082959.5144-2-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b914c2-dee0-4632-8de5-08db98cc559c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sxM4uhVJP4jUOEUG6zh7PMDhBTfjx27XOmQmbFo6KecezKihcIjagDFI1lUAm1MoLahcxiYrBgrrbmny4q4/CvN6lE6w4rjhpwbRcyBvS58vVX0b+9dPB0dgy2T3sT6ReV11FDzPtb+V9Vh3YRcvY8heBB7iPDScylnyqKa/D6BGF7anzpML+RGtEMnNFsIFlvG8nYSWOkOAXrASItMjG5wQPSdIM22GQ1gggzb0NC626v5P3+G0arRLWGkyHkMt5HDWIOMdla+5/Dr0T5tAqxJwD+CYirVAb/C0roPquq+vvgarN0mcgoXt5YRHv7STos+bV3w5ltwJnIkuH7cJEAFCcgdSTh3hd0wJD/G/OnVBSBmrCeHQ9tUFkek9WQQXuGs6Lz/icK+rdB/9/+FdFrGfxDq98YKAhJJ2ETyeTlq9cvleLHUadAOw9LLP0OswnQOcCZjYmw4ogiuhAuLcuPWeoXw+eXiJYBCsxKpxWnWJol4HpwsC8c4C1Z5R/F7HLfTWBMPClOM3CrPSPsh/jKBgcomAHmwgOFVOC5Vwc1+aQubdRO6yF1akarzGsYs63XFMIYj3dDkhey/ioQNHzPm/5y/6dUj3SD+HOe8T+u1ribbU+6Rti+hHhXAe1vsmugAFDnUzuh2Wr2dAHqsKRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(1800799006)(451199021)(186006)(44832011)(8936002)(5660300002)(8676002)(4326008)(41300700001)(316002)(83380400001)(86362001)(31696002)(30864003)(2906002)(6512007)(31686004)(6486002)(2616005)(6506007)(26005)(66556008)(66946007)(36756003)(66476007)(82960400001)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVZxWDkwZTdiWGhxUDc4RGR3cXFhN2s0Wjc1U2lwMTJnSnJjbU5VSVZFb3Nm?=
 =?utf-8?B?cmYxLzZXckZubXp1bmhSUFFOVmRLdzhqbk1MaVN4N3lZWFZGSjV3aUtrTDhz?=
 =?utf-8?B?NmJjVmdPU0JxVE9LSEYzR1hhTkhtRk4yWUk4empSN3ZaaWRpZ0Z2TnZOOGZv?=
 =?utf-8?B?MGRib3hUZ0hrN1QzRHlEMk9DNHNBYkZHM1h2eDR5cjNqTFFzTEgvamZ2c29R?=
 =?utf-8?B?R3FORWtyRWpDcjdKV25WS2lUVGdGT2QzbDFkVzREQU52emllRHczam80cDFw?=
 =?utf-8?B?dXhnTVJrbTc0YXJmeFBvT01yVUJZZDlrSU44WnFQcFBHNGliTHNnYlVlUlhT?=
 =?utf-8?B?NHhObDBEQ0dRVm1CS2lSa09DS29rSnd1N1kwYVJ3VUEyeC84SHhsamNuYks5?=
 =?utf-8?B?QWxBeWI3TFcwYU5ZR1VzRTg0ankva1h3Y0hqdDhYRGpYRE5uWDQ2UmJPYkFk?=
 =?utf-8?B?d3dzdGlnTlBnKy9DL3dmVDhSYjhHV3dpelpQNU9KOGpzZ1JlZFFWZDBKTDBp?=
 =?utf-8?B?eHFlOVd4ekNiWDlPdmNnNXFGTHYvWDh4SnNRbmpKZ0tOOUQ5bm9nb2JaR3Fa?=
 =?utf-8?B?WjkxV1Z0UHAxaTF5ZTFSL0ZITXhBQitIUy9ES0U1b2FvbVp5eTFla0xXQjdG?=
 =?utf-8?B?L3kxT3l1dTFQVEtHZFpmaXBBYy9VSTVwcWxxek04Y2luMTNuSmlTWGx3VHNl?=
 =?utf-8?B?QTNLczJzd1B0R0x3c3prVHFMMEk0Q2V5RTkxVm5XdGlrUWVyTko5cE0yS2xZ?=
 =?utf-8?B?OVl5TTZnQzlqeXJ2VjRiU3ZnUFZzbkJxS0ZHQTNPOXR6anUwQUEyNnNtOHow?=
 =?utf-8?B?YlhUMW9oOFZWVXlaYlNNMys2Mm9MeGZHdllhUXpwVEx3RFpRTmY2bDlkTmh6?=
 =?utf-8?B?MXVIdXpuNVB4ZVdYWFdwMnBadWEvejhKeEpETDl5ZGNMeHZCTWJON2NWdWpB?=
 =?utf-8?B?MmdQeXFDeThLdzJKUWNZOXFROEp0Vkx5R01mdkQwTDlBbERWSFQzUDdpZEV5?=
 =?utf-8?B?V2w2S2FOOGpNbUN5SDhhS1lHTlU3eUpFZXY1RlJiWmEzTTkzd1JrQmVYcFBu?=
 =?utf-8?B?aG1hWVR0TFp6eDF2OWl4aUtBblpvZStRUnJwNFBMREwvZ1l5QXlnK3RjNEJ2?=
 =?utf-8?B?Zk84S2lKYXRaMmc3NnVjK3BvVFBoSkx3VnloM2J0NDNJczJ2ck13TmhvZ2w5?=
 =?utf-8?B?czBnR29qSFg3eU4zR3BiRzVuRm1RSjV5NTcvRUh5WWt0NUdiVk9RZ0pFYmpw?=
 =?utf-8?B?ZWppQXhRN2tNT0RxQ0ZpaVhncXkxSUtUUlQ2TFYyK2IxNVkyUDhPOHVjRzgw?=
 =?utf-8?B?OFlldERlVytlNlpORnAweXp2U1Z0U29rQTkxOUdiQU5DTk45blBvWG85SEsx?=
 =?utf-8?B?Y1ZVWDJhL0gxZlFicFdmaXNPT09MblQvajhndUV4TGUxcnJ0a211ZTdCZ1Rp?=
 =?utf-8?B?eVlLd0VrU0VwLzVJV2xVU3lNR3ROeUdjdEQwV05kTU1aNEFuWlMvWmtmZmgz?=
 =?utf-8?B?bTB0b09yR2Foc0hZeTBPdHB0cTRnOVVyRldOSWdoRFFscTNEcFkxcFBWeHBt?=
 =?utf-8?B?dWlwVk1JZFhOR2k0ZjFEUzI0V1F3UVhlTm1TOENoOVc4UCtKc0hmMzllakVm?=
 =?utf-8?B?aW5kYng1eUtMMi9adEd3eGhuRll1akpwZmhzVEd0VkQ1M00zcm5YRVg5VGV3?=
 =?utf-8?B?dWZocExPWkkvNmlWNnk3ZmJPUWdTYllFOEx4ekFUR0g4YmdjelQzT3ZZWFR0?=
 =?utf-8?B?WFdCVDdYclBvc01qZERUZWdaV095NFNMQXFCZEo3d2FPN0tMSHRmZnRzVDUy?=
 =?utf-8?B?Mis1ZGk1UnVlOXJqRTRPZTV2YlVmamw2VWtpR1VYVDREeHVMNS9zK2JIV0JX?=
 =?utf-8?B?VW5QVWg2cFdmc2pPV0lyZjdINDNpTHV4M25FNkpaOTFQTlplaXkycVBadS96?=
 =?utf-8?B?dExRN0ZvYXhtbDE0RnNhaEwxd0NDMmNMNTU4dDUybzJSL0ltNjcxNjJ1c0Ra?=
 =?utf-8?B?OWpKZzJSdmgxazg2NTFQZEJLckhTTHYrdDZRWGREN3Z6Szk3eCt5REFlOTdq?=
 =?utf-8?B?Vmx5aE16dFFRcHhCMEZhT1hkNVl2RUdtQlRVMmlnODViQlI5SEtZZzRKcGxD?=
 =?utf-8?B?SkhxekxFdFlxQUFhNVArWml2My9QU0RCYlE2dkx3VDAvWFNtY0FtUjJ4azdC?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b914c2-dee0-4632-8de5-08db98cc559c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 11:32:38.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++xB7ULAfocGWAmWcHL0iIlMWxi7jsegmzK7fJ5ccZdUgJosLNhlmxvF80Wz9qVvrN7IMTXb6sBPTLZZs1CoLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6062

From: Aaron Marcher <aaron@sigma-star.at>

This is the very first step to have the alchemy tests embedded
into our testsuite.

Build them using Xenomai's build system and hook them up using
Smokey. Every test binary has it's own respective testcase in the
testsuite.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
[Jan: fix whitespace issues, clean up makefile, do not hook into automake yet]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac                                  |   7 +-
 testsuite/smokey/alchemytests/Makefile.am     | 147 ++++++++++++++++++
 .../smokey/alchemytests}/alarm-1.c            |   1 +
 testsuite/smokey/alchemytests/alchemytests.c  |  55 +++++++
 .../smokey/alchemytests/alchemytests_driver.c |  33 ++++
 .../smokey/alchemytests}/buffer-1.c           |   1 +
 .../smokey/alchemytests}/event-1.c            |   1 +
 .../smokey/alchemytests}/heap-1.c             |   1 +
 .../smokey/alchemytests}/heap-2.c             |   1 +
 .../smokey/alchemytests}/mq-1.c               |   1 +
 .../smokey/alchemytests}/mq-2.c               |   1 +
 .../smokey/alchemytests}/mq-3.c               |   1 +
 .../smokey/alchemytests}/mutex-1.c            |   1 +
 .../smokey/alchemytests}/pipe-1.c             |   1 +
 .../smokey/alchemytests}/sem-1.c              |   1 +
 .../smokey/alchemytests}/sem-2.c              |   1 +
 .../smokey/alchemytests}/task-1.c             |   1 +
 .../smokey/alchemytests}/task-10.c            |   1 +
 .../smokey/alchemytests}/task-2.c             |   1 +
 .../smokey/alchemytests}/task-3.c             |   1 +
 .../smokey/alchemytests}/task-4.c             |   1 +
 .../smokey/alchemytests}/task-5.c             |   1 +
 .../smokey/alchemytests}/task-6.c             |   1 +
 .../smokey/alchemytests}/task-7.c             |   1 +
 .../smokey/alchemytests}/task-8.c             |   1 +
 .../smokey/alchemytests}/task-9.c             |   1 +
 26 files changed, 262 insertions(+), 2 deletions(-)
 create mode 100644 testsuite/smokey/alchemytests/Makefile.am
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/alarm-1.c (97%)
 create mode 100644 testsuite/smokey/alchemytests/alchemytests.c
 create mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/buffer-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/event-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-2.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-2.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-3.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mutex-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/pipe-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-2.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-1.c (94%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-10.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-2.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-3.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-4.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-5.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-6.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-7.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-8.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-9.c (97%)

diff --git a/configure.ac b/configure.ac
index 3ce34048e6..fe59333ed4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1041,10 +1041,13 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/cpu-affinity/Makefile \
 	testsuite/smokey/gdb/Makefile \
 	testsuite/smokey/y2038/Makefile \
-	testsuite/smokey/can/Makefile
-	testsuite/smokey/x86io/Makefile
+	testsuite/smokey/can/Makefile \
+	testsuite/smokey/x86io/Makefile \
+	testsuite/smokey/alchemytests/Makefile \
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
+	testsuite/psostests/Makefile \
+	testsuite/vxworkstests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
 	utils/can/Makefile \
diff --git a/testsuite/smokey/alchemytests/Makefile.am b/testsuite/smokey/alchemytests/Makefile.am
new file mode 100644
index 0000000000..68255b1112
--- /dev/null
+++ b/testsuite/smokey/alchemytests/Makefile.am
@@ -0,0 +1,147 @@
+testdir = @XENO_TEST_DIR@
+noinst_LIBRARIES = libalchemytests.a
+
+libalchemytests_a_SOURCES = alchemytests.c
+libalchemytests_a_CPPFLAGS =	\
+	@XENO_USER_CFLAGS@	\
+	-I$(top_srcdir)		\
+	-I$(top_srcdir)/include \
+	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS =				\
+		alchemytests		\
+		alchemytests_alarm1	\
+		alchemytests_buffer1	\
+		alchemytests_event1	\
+		alchemytests_heap1	\
+		alchemytests_heap2	\
+		alchemytests_mq1	\
+		alchemytests_mq2	\
+		alchemytests_mq3	\
+		alchemytests_mutex1	\
+		alchemytests_pipe1	\
+		alchemytests_sem1	\
+		alchemytests_sem2	\
+		alchemytests_task1	\
+		alchemytests_task2	\
+		alchemytests_task3	\
+		alchemytests_task4	\
+		alchemytests_task5	\
+		alchemytests_task6	\
+		alchemytests_task7	\
+		alchemytests_task8	\
+		alchemytests_task9	\
+		alchemytests_task10
+
+alchemycppflags =			\
+	$(XENO_USER_CFLAGS)		\
+	-I$(top_srcdir)/include
+
+alchemyldadd = 							\
+	../../../lib/alchemy/libalchemy@CORE@.la		\
+	../../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 					\
+	@XENO_USER_LDADD@					\
+	-lpthread -lrt -lm
+
+alchemytests_SOURCES = alchemytests_driver.c
+alchemytests_CPPFLAGS =				\
+	$(XENO_USER_CFLAGS)			\
+	-I$(top_srcdir)/include
+alchemytests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_LDADD =				\
+	../../../lib/smokey/libsmokey@CORE@.la	\
+	@XENO_CORE_LDADD@			\
+	@XENO_USER_LDADD@			\
+	-lpthread -lrt
+
+alchemytests_alarm1_SOURCES = alarm-1.c
+alchemytests_alarm1_CPPFLAGS = $(alchemycppflags)
+alchemytests_alarm1_LDADD = $(alchemyldadd)
+alchemytests_alarm1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_event1_SOURCES = event-1.c
+alchemytests_event1_CPPFLAGS = $(alchemycppflags)
+alchemytests_event1_LDADD = $(alchemyldadd)
+alchemytests_event1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_heap1_SOURCES = heap-1.c
+alchemytests_heap1_CPPFLAGS = $(alchemycppflags)
+alchemytests_heap1_LDADD = $(alchemyldadd)
+alchemytests_heap1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_heap2_SOURCES = heap-2.c
+alchemytests_heap2_CPPFLAGS = $(alchemycppflags)
+alchemytests_heap2_LDADD = $(alchemyldadd)
+alchemytests_heap2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_buffer1_SOURCES = buffer-1.c
+alchemytests_buffer1_CPPFLAGS = $(alchemycppflags)
+alchemytests_buffer1_LDADD = $(alchemyldadd)
+alchemytests_buffer1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_mutex1_SOURCES = mutex-1.c
+alchemytests_mutex1_CPPFLAGS = $(alchemycppflags)
+alchemytests_mutex1_LDADD = $(alchemyldadd)
+alchemytests_mutex1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_pipe1_SOURCES = pipe-1.c
+alchemytests_pipe1_CPPFLAGS = $(alchemycppflags)
+alchemytests_pipe1_LDADD = $(alchemyldadd)
+alchemytests_pipe1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_mq1_SOURCES = mq-1.c
+alchemytests_mq1_CPPFLAGS = $(alchemycppflags)
+alchemytests_mq1_LDADD = $(alchemyldadd)
+alchemytests_mq1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_mq2_SOURCES = mq-2.c
+alchemytests_mq2_CPPFLAGS = $(alchemycppflags)
+alchemytests_mq2_LDADD = $(alchemyldadd)
+alchemytests_mq2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_mq3_SOURCES = mq-3.c
+alchemytests_mq3_CPPFLAGS = $(alchemycppflags)
+alchemytests_mq3_LDADD = $(alchemyldadd)
+alchemytests_mq3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_sem1_SOURCES = sem-1.c
+alchemytests_sem1_CPPFLAGS = $(alchemycppflags)
+alchemytests_sem1_LDADD = $(alchemyldadd)
+alchemytests_sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_sem2_SOURCES = sem-2.c
+alchemytests_sem2_CPPFLAGS = $(alchemycppflags)
+alchemytests_sem2_LDADD = $(alchemyldadd)
+alchemytests_sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task1_SOURCES = task-1.c
+alchemytests_task1_CPPFLAGS = $(alchemycppflags)
+alchemytests_task1_LDADD = $(alchemyldadd)
+alchemytests_task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task2_SOURCES = task-2.c
+alchemytests_task2_CPPFLAGS = $(alchemycppflags)
+alchemytests_task2_LDADD = $(alchemyldadd)
+alchemytests_task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task3_SOURCES = task-3.c
+alchemytests_task3_CPPFLAGS = $(alchemycppflags)
+alchemytests_task3_LDADD = $(alchemyldadd)
+alchemytests_task3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task4_SOURCES = task-4.c
+alchemytests_task4_CPPFLAGS = $(alchemycppflags)
+alchemytests_task4_LDADD = $(alchemyldadd)
+alchemytests_task4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task5_SOURCES = task-5.c
+alchemytests_task5_CPPFLAGS = $(alchemycppflags)
+alchemytests_task5_LDADD = $(alchemyldadd)
+alchemytests_task5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task6_SOURCES = task-6.c
+alchemytests_task6_CPPFLAGS = $(alchemycppflags)
+alchemytests_task6_LDADD = $(alchemyldadd)
+alchemytests_task6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task7_SOURCES = task-7.c
+alchemytests_task7_CPPFLAGS = $(alchemycppflags)
+alchemytests_task7_LDADD = $(alchemyldadd)
+alchemytests_task7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task8_SOURCES = task-8.c
+alchemytests_task8_CPPFLAGS = $(alchemycppflags)
+alchemytests_task8_LDADD = $(alchemyldadd)
+alchemytests_task8_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task9_SOURCES = task-9.c
+alchemytests_task9_CPPFLAGS = $(alchemycppflags)
+alchemytests_task9_LDADD = $(alchemyldadd)
+alchemytests_task9_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task10_SOURCES = task-10.c
+alchemytests_task10_CPPFLAGS = $(alchemycppflags)
+alchemytests_task10_LDADD = $(alchemyldadd)
+alchemytests_task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
diff --git a/lib/alchemy/testsuite/alarm-1.c b/testsuite/smokey/alchemytests/alarm-1.c
similarity index 97%
rename from lib/alchemy/testsuite/alarm-1.c
rename to testsuite/smokey/alchemytests/alarm-1.c
index 29b3bbe740..eb6c5310aa 100644
--- a/lib/alchemy/testsuite/alarm-1.c
+++ b/testsuite/smokey/alchemytests/alarm-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
new file mode 100644
index 0000000000..19989cc09d
--- /dev/null
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <error.h>
+#include <libgen.h>
+#include <smokey/smokey.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#define TEST(name)								   \
+	smokey_test_plugin(name, SMOKEY_NOARGS, "Run external test");		   \
+	static int run_##name(struct smokey_test *t, int argc, char *const argv[]) \
+	{									   \
+		return __run_extprog(t, argc, argv);				   \
+	}
+
+static int __run_extprog(struct smokey_test *t, int argc, char *const argv[])
+{
+	int ret;
+	char *tst_path;
+
+	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", XENO_TEST_DIR, t->name);
+	if (ret == -1)
+		return -ENOMEM;
+
+	ret = system(tst_path);
+	free(tst_path);
+
+	return ret;
+}
+
+TEST(alchemytests)
+TEST(alchemytests_alarm1)
+TEST(alchemytests_buffer1)
+TEST(alchemytests_event1)
+TEST(alchemytests_heap1)
+TEST(alchemytests_heap2)
+TEST(alchemytests_mq1)
+TEST(alchemytests_mq2)
+TEST(alchemytests_mq3)
+TEST(alchemytests_mutex1)
+TEST(alchemytests_pipe1)
+TEST(alchemytests_sem1)
+TEST(alchemytests_sem2)
+TEST(alchemytests_task1)
+TEST(alchemytests_task2)
+TEST(alchemytests_task3)
+TEST(alchemytests_task4)
+TEST(alchemytests_task5)
+TEST(alchemytests_task6)
+TEST(alchemytests_task7)
+TEST(alchemytests_task8)
+TEST(alchemytests_task9)
+TEST(alchemytests_task10)
diff --git a/testsuite/smokey/alchemytests/alchemytests_driver.c b/testsuite/smokey/alchemytests/alchemytests_driver.c
new file mode 100644
index 0000000000..7cacbb399b
--- /dev/null
+++ b/testsuite/smokey/alchemytests/alchemytests_driver.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <error.h>
+#include <libgen.h>
+#include <smokey/smokey.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+int main(int argc, char *const argv[])
+{
+	struct smokey_test *t;
+	int ret, fails = 0;
+
+	if (pvlist_empty(&smokey_test_list))
+		return 0;
+
+	for_each_smokey_test(t) {
+		ret = t->run(t, argc, argv);
+		if (ret) {
+			fails++;
+			if (smokey_keep_going)
+				continue;
+			if (smokey_verbose_mode)
+				error(1, -ret, "test %s failed", t->name);
+			return 1;
+		}
+		smokey_note("%s OK", t->name);
+	}
+
+	return fails != 0;
+}
diff --git a/lib/alchemy/testsuite/buffer-1.c b/testsuite/smokey/alchemytests/buffer-1.c
similarity index 98%
rename from lib/alchemy/testsuite/buffer-1.c
rename to testsuite/smokey/alchemytests/buffer-1.c
index d6d1d9ad72..fdcb5e8d75 100644
--- a/lib/alchemy/testsuite/buffer-1.c
+++ b/testsuite/smokey/alchemytests/buffer-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <memory.h>
diff --git a/lib/alchemy/testsuite/event-1.c b/testsuite/smokey/alchemytests/event-1.c
similarity index 98%
rename from lib/alchemy/testsuite/event-1.c
rename to testsuite/smokey/alchemytests/event-1.c
index 0893df36de..9ce679c717 100644
--- a/lib/alchemy/testsuite/event-1.c
+++ b/testsuite/smokey/alchemytests/event-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/heap-1.c b/testsuite/smokey/alchemytests/heap-1.c
similarity index 98%
rename from lib/alchemy/testsuite/heap-1.c
rename to testsuite/smokey/alchemytests/heap-1.c
index 48bc4a56e4..f0904439f7 100644
--- a/lib/alchemy/testsuite/heap-1.c
+++ b/testsuite/smokey/alchemytests/heap-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/heap-2.c b/testsuite/smokey/alchemytests/heap-2.c
similarity index 98%
rename from lib/alchemy/testsuite/heap-2.c
rename to testsuite/smokey/alchemytests/heap-2.c
index ad67afb2fd..1f80db80cc 100644
--- a/lib/alchemy/testsuite/heap-2.c
+++ b/testsuite/smokey/alchemytests/heap-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/mq-1.c b/testsuite/smokey/alchemytests/mq-1.c
similarity index 98%
rename from lib/alchemy/testsuite/mq-1.c
rename to testsuite/smokey/alchemytests/mq-1.c
index ac9801e726..952ff6448a 100644
--- a/lib/alchemy/testsuite/mq-1.c
+++ b/testsuite/smokey/alchemytests/mq-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
similarity index 98%
rename from lib/alchemy/testsuite/mq-2.c
rename to testsuite/smokey/alchemytests/mq-2.c
index 9fea471b78..acc6ec0519 100644
--- a/lib/alchemy/testsuite/mq-2.c
+++ b/testsuite/smokey/alchemytests/mq-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/mq-3.c b/testsuite/smokey/alchemytests/mq-3.c
similarity index 98%
rename from lib/alchemy/testsuite/mq-3.c
rename to testsuite/smokey/alchemytests/mq-3.c
index 7fcae020af..cb4c77d430 100644
--- a/lib/alchemy/testsuite/mq-3.c
+++ b/testsuite/smokey/alchemytests/mq-3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/mutex-1.c b/testsuite/smokey/alchemytests/mutex-1.c
similarity index 98%
rename from lib/alchemy/testsuite/mutex-1.c
rename to testsuite/smokey/alchemytests/mutex-1.c
index ef58a2c866..f08665254e 100644
--- a/lib/alchemy/testsuite/mutex-1.c
+++ b/testsuite/smokey/alchemytests/mutex-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
similarity index 98%
rename from lib/alchemy/testsuite/pipe-1.c
rename to testsuite/smokey/alchemytests/pipe-1.c
index 4202be2bac..4011f9c8a7 100644
--- a/lib/alchemy/testsuite/pipe-1.c
+++ b/testsuite/smokey/alchemytests/pipe-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <fcntl.h>
diff --git a/lib/alchemy/testsuite/sem-1.c b/testsuite/smokey/alchemytests/sem-1.c
similarity index 98%
rename from lib/alchemy/testsuite/sem-1.c
rename to testsuite/smokey/alchemytests/sem-1.c
index 3e526eddf5..080bcea9ae 100644
--- a/lib/alchemy/testsuite/sem-1.c
+++ b/testsuite/smokey/alchemytests/sem-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/sem-2.c b/testsuite/smokey/alchemytests/sem-2.c
similarity index 97%
rename from lib/alchemy/testsuite/sem-2.c
rename to testsuite/smokey/alchemytests/sem-2.c
index c01f6a431d..74cce2b7d9 100644
--- a/lib/alchemy/testsuite/sem-2.c
+++ b/testsuite/smokey/alchemytests/sem-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-1.c b/testsuite/smokey/alchemytests/task-1.c
similarity index 94%
rename from lib/alchemy/testsuite/task-1.c
rename to testsuite/smokey/alchemytests/task-1.c
index 34a6c22fdd..d3d9a6f7f8 100644
--- a/lib/alchemy/testsuite/task-1.c
+++ b/testsuite/smokey/alchemytests/task-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-10.c b/testsuite/smokey/alchemytests/task-10.c
similarity index 97%
rename from lib/alchemy/testsuite/task-10.c
rename to testsuite/smokey/alchemytests/task-10.c
index 58f4cb0357..c4a29ae760 100644
--- a/lib/alchemy/testsuite/task-10.c
+++ b/testsuite/smokey/alchemytests/task-10.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-2.c b/testsuite/smokey/alchemytests/task-2.c
similarity index 98%
rename from lib/alchemy/testsuite/task-2.c
rename to testsuite/smokey/alchemytests/task-2.c
index e751ddd347..592f2ed20c 100644
--- a/lib/alchemy/testsuite/task-2.c
+++ b/testsuite/smokey/alchemytests/task-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-3.c b/testsuite/smokey/alchemytests/task-3.c
similarity index 97%
rename from lib/alchemy/testsuite/task-3.c
rename to testsuite/smokey/alchemytests/task-3.c
index 06f235af9b..eb24935a4f 100644
--- a/lib/alchemy/testsuite/task-3.c
+++ b/testsuite/smokey/alchemytests/task-3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-4.c b/testsuite/smokey/alchemytests/task-4.c
similarity index 98%
rename from lib/alchemy/testsuite/task-4.c
rename to testsuite/smokey/alchemytests/task-4.c
index eba7fbb86d..90e0236bed 100644
--- a/lib/alchemy/testsuite/task-4.c
+++ b/testsuite/smokey/alchemytests/task-4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-5.c b/testsuite/smokey/alchemytests/task-5.c
similarity index 98%
rename from lib/alchemy/testsuite/task-5.c
rename to testsuite/smokey/alchemytests/task-5.c
index 3c0fa427c3..b9075945d1 100644
--- a/lib/alchemy/testsuite/task-5.c
+++ b/testsuite/smokey/alchemytests/task-5.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-6.c b/testsuite/smokey/alchemytests/task-6.c
similarity index 97%
rename from lib/alchemy/testsuite/task-6.c
rename to testsuite/smokey/alchemytests/task-6.c
index 7c88fde9c5..fa58d0fdca 100644
--- a/lib/alchemy/testsuite/task-6.c
+++ b/testsuite/smokey/alchemytests/task-6.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-7.c b/testsuite/smokey/alchemytests/task-7.c
similarity index 98%
rename from lib/alchemy/testsuite/task-7.c
rename to testsuite/smokey/alchemytests/task-7.c
index 1350bb39cf..d118abf423 100644
--- a/lib/alchemy/testsuite/task-7.c
+++ b/testsuite/smokey/alchemytests/task-7.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-8.c b/testsuite/smokey/alchemytests/task-8.c
similarity index 97%
rename from lib/alchemy/testsuite/task-8.c
rename to testsuite/smokey/alchemytests/task-8.c
index bb6dfff062..959b3d3c4c 100644
--- a/lib/alchemy/testsuite/task-8.c
+++ b/testsuite/smokey/alchemytests/task-8.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-9.c b/testsuite/smokey/alchemytests/task-9.c
similarity index 97%
rename from lib/alchemy/testsuite/task-9.c
rename to testsuite/smokey/alchemytests/task-9.c
index e358154c59..56cc7bfebc 100644
--- a/lib/alchemy/testsuite/task-9.c
+++ b/testsuite/smokey/alchemytests/task-9.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
-- 
2.35.3
