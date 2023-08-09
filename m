Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3093817AAD
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 11:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMnM74ngw5I9nuLE1jqC6j2GfwZ//CF+WMxibtT+q1NUcBiYms6Net7R6P/T5ECcEVBDkNWnIEhexYX8UWFuZ1gdOAWHg5qypwr7znVM7zhgM+JrS26OGmnKs5wfCvvAN02QkUqlgebFLpnesKDIaoF07SV3JwvwjP46yzRTCG3rEnTbnq+n5pMnR/CvRy9lZuLiGxwe6tsYAF43WQd13JcS30Ybm6UMu7lf743F0oiXm86Yd9xukkZITvYmqGKVgUEBzbjVGB0QqBD6qrl3lYkJqDimH/l1p9SKZVF49PVaKh3YAvnMMO7xoK9jMoGyc3nqm3qotuwYoh3DbJg4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRzf5RVd5DEslf4RCXP1K7CKhvgd3i4l3CQBkOHIQlw=;
 b=BINDlHJvmEy859xhEua87zD+QyQBAA7SP/tusDB6ub0ILXo6YLZBMMYnYcFfsZfPjfEdxQQXE4qAis1NzFrLf1SkKkuUXKSEnkKQdw2kQRXbBk0dycIdrqfU9TRh+N4rUmBShB/Oe99z/7FZKrri4ZhhJjjKIfaL9YWuaeOu8sgr63OTn9/kskr5j84Cih54irV8wEdKyQJsfrd0i2SWU4BygR0MASYygZvGffg04Ic5CrFJXXvBgGzLHhlBH0hA4WBqt7raaY3GbBMTAX2neXpk8wJtFoMmbU0EbqxAOabL44T324MZ5wBYQlUaqihdnKGs8CxV3sk3aDkTmviMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRzf5RVd5DEslf4RCXP1K7CKhvgd3i4l3CQBkOHIQlw=;
 b=NXDzIgwu8k2gghQzZiY80mH/+ZqiKavBo90BwIOiywRW/4RA56+okml/U6/wuM0lbURCMeUBRkNemXqb6PmydVUb6Y0XEjjgpG4NvWNFlrmzYslFi2YcD4Trr24hSgE29n16k5+tzSz984NAi/RdVobsnYI9RdkyYbpTmmPgST6CzQ3jQSFeMFremeE37ffod3oedjgNc6ESHf0DvMDlb8/euNZt5i/Tb8Wuq5PG+hTZvMpLx+aQpuplj5uImU698/jc5uEM5H8K6kZ/E6+tyinQxFeRiH55G5+dIdkXwM8hRaCrr81GJ2hZQ2UMhfNsu8/GolxKj1StstWV0zUfrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:581::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 11:32:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 11:32:45 +0000
Message-ID: <d80c7841-d6d7-4014-807c-63afe6db6366@siemens.com>
Date: Wed, 9 Aug 2023 13:32:45 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 03/10] testsuite: Fully integrate vwworkstests into smokey
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
 <20230725082959.5144-4-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230725082959.5144-4-aaron@sigma-star.at>
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
X-MS-Office365-Filtering-Correlation-Id: 3e7bfca4-c7fa-4ef2-38ab-08db98cc5a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IcUBGhuhQpdADntC4eVfTYkon5C2lsm9Fs64Ez7K+5+8P4LowTEm72tqw80rXkBUT7y2lpMlzPFwbFRqxJmCT/7L821eoLjsSqleyVVcJx6UC0SC0Z9Nf4/ZBqgl6aUHoRDjnxy76CmR9Fl7RXsdB1Lu4LvyS3RpjRsiUqJseRNMUucrKgJo3vZFCXSvY3WEFFIm9qKSc9tMW0ZImcLJ13LlssfhY43g0AUG9lEtAj+UM74XwP18Ja4qjomhkUVFOL1Cd03RYvDxPvN0p5p9YqE19X+PBT9Nn7nySgcHmMfoWpt9V+X7s7DrvkqIX3rwEFHXMaKeH1TF2ZtPpb/hRZwoWpCmMl6k12EZGkRr3NwnEbVVLorzpEVc4p1M8LGOSDZ9xzsrS5alUAODp6AzC31PWe4h3dZKqRJwUG0/0k5yWbBUNy/z0C1QPmVldhPXlL+tG0XLl4+g3NaUaRnpBNnAOPhfMBtHyII48P5d+vCSK5bW03s+ZG6hmVs6CCQi+XpMmbMMHeprsAwymAYwjX6n9oOSRorJSG4w/fhSdt9G8BVpaYJlarnNRRyEnqJk5lvJGV4OkUJgBMdnTTTUdJqX6jdtBERO05/Y4cl1XV9CuXjC4jdxaFXgc9RY4m+xJArV6+Mpb+SsHvvwJTr7JA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(1800799006)(451199021)(186006)(44832011)(8936002)(5660300002)(8676002)(4326008)(41300700001)(316002)(83380400001)(86362001)(31696002)(30864003)(2906002)(6512007)(31686004)(6486002)(2616005)(6506007)(26005)(66556008)(66946007)(36756003)(66476007)(82960400001)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXk0eVpNSzBBdFgyVjhjV0dnMzB6Vmd0bjlWMldSZVBFWlFZQTJ5RTRqRjhX?=
 =?utf-8?B?VldKemlmTFBYVlI1b05nUTlxVWxaQkt4NlVaRG9PRFdOUWZ0OUhzaWtROFdm?=
 =?utf-8?B?SGF1dFkyaFpPUDcwZGcrOGh5T1lwUEZ6N2hSL2cxNklmd3FEbmF4WktYT3py?=
 =?utf-8?B?NDRUQU1pWWtndlBOUmNxVS9RQkNTMDRzODJ2T0NpTVFqd2ZzSjRyaFUwdzI1?=
 =?utf-8?B?enVBSjZ1VFgrSEt3anlGZFkva3RwWC9NOEQ0UFZ6eXgvL1JJTmx5NnZsUWl0?=
 =?utf-8?B?d3F5UzFnMlNabGJNWEZOa1Y2emowSUFyWk1rSmVoU2llL3FwYm9RNnNzdFpy?=
 =?utf-8?B?TkZDckExSEFOM0ZsZlUzUy9mZ2VRUk4vRVE2TWxqWnRhWXB3UDJhTHJ2MHJw?=
 =?utf-8?B?ZFY1T2JTNTRlM3ZMTTZKckV6ajFMYTdQdzBLL1JqTmZxUHNEQ2VTdDd2WFJB?=
 =?utf-8?B?VWlicHRFcDU1dzVCZ3ZzME1Fb1Zqd2N5RFpWZmF6UTZEYkRnT2NXbVZKdU9L?=
 =?utf-8?B?SnB4ZHovSWVaM2xNTE5DZTZ1SnhzbFNWUTh0NzdzRENqaDJhcjdZNzZDbnRL?=
 =?utf-8?B?VFM1YlhIMk9VZUczYUVHZkMzWm56cjBLRXB1ekVRVXV6WmJrT3NJeXJ2c1dK?=
 =?utf-8?B?OU92UWx6NlJCZ3ZSYS8wdUFMaHlVRmhwSVdnZGVxWUkwQlJhRzJpZkxOUXgw?=
 =?utf-8?B?VU5QWnlJYjZPeWFJTXAzRE1VdHZHMmtXU09OUFVSdjU5clpJNnEvdVBCdHBJ?=
 =?utf-8?B?eTIvZ2k0QnpwVVR4Mkk4QzBkVFFzcEJjYjJVNEk4S0JlM0Z1WUtxMFNUYkVx?=
 =?utf-8?B?ZkpuQ013Y1BQR0tNbUhPRG44QzZmTnVCZzZDSXZTK1RvaFhYU1ZlRTErc0ds?=
 =?utf-8?B?MTVyZnVhNmhScFV1V096R1YvOGFnb3Q0ZGlLL0NPQTdLRExDSXE4NnNUTzAw?=
 =?utf-8?B?QUFsMm9vSTNhNzdnckc1NXVYS1EyNmcwYTAwa1lMZmxCUHFMOGlDRERibHJi?=
 =?utf-8?B?cmZXb01vNTkvcGpzL0ZLeEYwQ21aOVZLckl1cDYxd1pKeGdWUHlYZU5BL3Br?=
 =?utf-8?B?aDJDakYzaE9kZnEwcXlqcHhOWUNWQ2tOdnNyUUpNU0lKU1hlS1ZFN3JpcXFj?=
 =?utf-8?B?TTRWZXhhVWNEVVJFalhEMG84YkZ3SVI4anU2Mndhc0d4eUhRd0RuK2VSRG53?=
 =?utf-8?B?SWt5RWh0R1NQaU9hRHFGMy9UbDJBa1BpR3BEcG1sSnBtT1YzR3NDbnNvSDBH?=
 =?utf-8?B?TjhwK2FUZHMwOVZmb1BzSWFrWENJbVNlNjV3WHluZW1CaFZYdnZxVTRpdnZG?=
 =?utf-8?B?K2RyUnBNbVlDeDVIalJhN3RjUWgxK0pLRW1PM29aUXhpNkpoWGxkWDRnVktI?=
 =?utf-8?B?ZVljZmFsajlwcFNuTy9RTUphRytRTHB6U2ZacEZTak53Uy90Yk9yV1hzY2hs?=
 =?utf-8?B?bEJJMndudWE2QmZRK083MGlzVDcvZ0oydnYxREl3M3FCZHJzcVRDejBqY0Zx?=
 =?utf-8?B?Q3hUV0tjeEQ0RVM4ekd3UnJHUlp4UHUzbEZTaXpZQit3SWxqSGptZ05pZ3Bz?=
 =?utf-8?B?cjJCWTZsZUNKdXJPM3c1QXpRQzhTb1B3c2dsSUhXSEVhYUhJZFk5NGFYNEh0?=
 =?utf-8?B?QjBLMHFjYUJwYmxqTU5CdHpnWTZBbE9KWEFPYkdMZXZ5MEpCQmhySGhQWEhI?=
 =?utf-8?B?WTFKNHMrdXQwVG52V3lrZDgrRkljUmJUUkc3TXp0SEdXNk1lMkZpNUI3VDZq?=
 =?utf-8?B?R0JWZ1duS3M0UWhkQTBCaVF6ZEFFYWpiWGRZZUxHMDZwMGVGWUprb2E1YTQ4?=
 =?utf-8?B?QmhGd0N5WXRoVDVLcFh1Wms2dFpacWZWcVZmZFVVY2hjcXNtUGkvNkhzSEFK?=
 =?utf-8?B?TjdoNnJnYXZpV1ovMW1jZGJJYll4OHlmZGM0ZE0zSzVKL0REY1RZVSs5L01a?=
 =?utf-8?B?bGRGUE8zR1RYc0VJUG4yTWUwRElUbzFjbnZuNmtWV3RDRld4enFabU1kekdV?=
 =?utf-8?B?Rk1GVnlRSWFTWnloYUF1VkxtbjMwVW9qVWRDOUQ1SW1hUFJrMUVORWxqUzFM?=
 =?utf-8?B?dzdBK2FJZzNISWZXVWZqWS93VHkvQkEzS0JOUkpMK29JMUFpS1ArNXd4OW94?=
 =?utf-8?B?bU9INlRkUXpIVkNMSWRxeEszTWNzMTdLdnZadFpJbHNBdVRMTFYvOWRqSDRD?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7bfca4-c7fa-4ef2-38ab-08db98cc5a2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 11:32:45.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BL/KOa4Dp20nfgoz9rmV3s5Wqia1jgVpMEVda3r7wp24p2xmj6wHtIqNT7WxQt/bIRZNoqS2hY09G9cj0ecRbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6062

From: Aaron Marcher <aaron@sigma-star.at>

Same as for alchemytests and psostests.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
[Jan: fix whitespace issues, clean up makefile, do not hook into automake yet]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac                                  |  2 +-
 lib/vxworks/testsuite/Makefile                | 43 ---------
 testsuite/smokey/vxworkstests/Makefile.am     | 95 +++++++++++++++++++
 .../smokey/vxworkstests}/lst-1.c              |  1 +
 .../smokey/vxworkstests}/msgQ-1.c             |  1 +
 .../smokey/vxworkstests}/msgQ-2.c             |  1 +
 .../smokey/vxworkstests}/msgQ-3.c             |  1 +
 .../smokey/vxworkstests}/rng-1.c              |  1 +
 .../smokey/vxworkstests}/sem-1.c              |  1 +
 .../smokey/vxworkstests}/sem-2.c              |  1 +
 .../smokey/vxworkstests}/sem-3.c              |  1 +
 .../smokey/vxworkstests}/sem-4.c              |  1 +
 .../smokey/vxworkstests}/task-1.c             |  1 +
 .../smokey/vxworkstests}/task-2.c             |  1 +
 testsuite/smokey/vxworkstests/vxworkstests.c  | 45 +++++++++
 .../smokey/vxworkstests/vxworkstests_driver.c | 33 +++++++
 .../smokey/vxworkstests}/wd-1.c               |  1 +
 17 files changed, 186 insertions(+), 44 deletions(-)
 delete mode 100644 lib/vxworks/testsuite/Makefile
 create mode 100644 testsuite/smokey/vxworkstests/Makefile.am
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/lst-1.c (99%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-1.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-2.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-3.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/rng-1.c (99%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-1.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-2.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-3.c (97%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-4.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-1.c (96%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-2.c (98%)
 create mode 100644 testsuite/smokey/vxworkstests/vxworkstests.c
 create mode 100644 testsuite/smokey/vxworkstests/vxworkstests_driver.c
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/wd-1.c (97%)

diff --git a/configure.ac b/configure.ac
index 9db5438eb6..a601f94cd3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1045,9 +1045,9 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/x86io/Makefile \
 	testsuite/smokey/alchemytests/Makefile \
 	testsuite/smokey/psostests/Makefile \
+	testsuite/smokey/vxworkstests/Makefile \
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
-	testsuite/vxworkstests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
 	utils/can/Makefile \
diff --git a/lib/vxworks/testsuite/Makefile b/lib/vxworks/testsuite/Makefile
deleted file mode 100644
index 648c9be90a..0000000000
--- a/lib/vxworks/testsuite/Makefile
+++ /dev/null
@@ -1,43 +0,0 @@
-ifeq ($(DESTDIR),)
-XENO_CONFIG=xeno-config
-else
-XENO_CONFIG=$(DESTDIR)/bin/xeno-config
-endif
-
-prefix := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --prefix)
-solibs := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --libdir)
-
-ifeq ($(prefix),)
-$(error Please add <xenomai-install-path>/bin to your PATH variable or specify DESTDIR)
-endif
-
-TESTS := task-1 task-2 msgQ-1 msgQ-2 msgQ-3 wd-1 sem-1 sem-2 sem-3 sem-4 lst-1 rng-1
-
-CFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=vxworks --cflags) -g
-LDFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=vxworks --ldflags)
-CC = $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --cc)
-
-all: $(TESTS)
-
-%: %.c
-	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
-
-install: all
-	install -d $(prefix)/testsuite/vxworks
-	install -t $(prefix)/testsuite/vxworks $(TESTS)
-
-clean:
-	$(RM) $(TESTS) *~
-
-# Run the test suite. We pin all tests to CPU #0, so that SMP does not
-# alter the execution sequence we expect from them.
-test: all
-	@for t in $(TESTS); do \
-		echo -n $$t...; \
-		sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$$t --cpu-affinity=0 --silent && echo ok || echo BAD; \
-	done
-
-test/%: %
-	sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$(@F) --cpu-affinity=0 --silent && echo ok || echo BAD
-
-.PHONY: clean test
diff --git a/testsuite/smokey/vxworkstests/Makefile.am b/testsuite/smokey/vxworkstests/Makefile.am
new file mode 100644
index 0000000000..a0aa9df764
--- /dev/null
+++ b/testsuite/smokey/vxworkstests/Makefile.am
@@ -0,0 +1,95 @@
+testdir = @XENO_TEST_DIR@
+noinst_LIBRARIES = libvxworkstests.a
+
+libvxworkstests_a_SOURCES = vxworkstests.c
+libvxworkstests_a_CPPFLAGS =	\
+	@XENO_USER_CFLAGS@	\
+	-I$(top_srcdir)		\
+	-I$(top_srcdir)/include \
+	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS =				\
+		vxworkstests		\
+		vxworkstests_lst1	\
+		vxworkstests_msgQ1	\
+		vxworkstests_msgQ2	\
+		vxworkstests_msgQ3	\
+		vxworkstests_rng1	\
+		vxworkstests_sem1	\
+		vxworkstests_sem2	\
+		vxworkstests_sem3	\
+		vxworkstests_sem4	\
+		vxworkstests_wd1	\
+		vxworkstests_task1	\
+		vxworkstests_task2
+
+vxworkscppflags = 			\
+	@XENO_USER_CFLAGS@		\
+	-I$(top_srcdir)/include
+
+vxworksldadd = 							\
+	../../../lib/vxworks/libvxworks@CORE@.la		\
+	../../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 					\
+	@XENO_USER_LDADD@					\
+	-lpthread -lrt -lm
+
+vxworkstests_SOURCES = vxworkstests_driver.c
+vxworkstests_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
+vxworkstests_LDADD =				\
+	../../../lib/smokey/libsmokey@CORE@.la	\
+	@XENO_CORE_LDADD@ 			\
+	@XENO_USER_LDADD@			\
+	-lpthread -lrt
+
+vxworkstests_lst1_SOURCES = lst-1.c
+vxworkstests_lst1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_lst1_LDADD = $(vxworksldadd)
+vxworkstests_lst1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_task1_SOURCES = task-1.c
+vxworkstests_task1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_task1_LDADD = $(vxworksldadd)
+vxworkstests_task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_task2_SOURCES = task-2.c
+vxworkstests_task2_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_task2_LDADD = $(vxworksldadd)
+vxworkstests_task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_msgQ1_SOURCES = msgQ-1.c
+vxworkstests_msgQ1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_msgQ1_LDADD = $(vxworksldadd)
+vxworkstests_msgQ1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_msgQ2_SOURCES = msgQ-2.c
+vxworkstests_msgQ2_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_msgQ2_LDADD = $(vxworksldadd)
+vxworkstests_msgQ2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_msgQ3_SOURCES = msgQ-3.c
+vxworkstests_msgQ3_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_msgQ3_LDADD = $(vxworksldadd)
+vxworkstests_msgQ3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_rng1_SOURCES = rng-1.c
+vxworkstests_rng1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_rng1_LDADD = $(vxworksldadd)
+vxworkstests_rng1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_sem1_SOURCES = sem-1.c
+vxworkstests_sem1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_sem1_LDADD = $(vxworksldadd)
+vxworkstests_sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_sem2_SOURCES = sem-2.c
+vxworkstests_sem2_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_sem2_LDADD = $(vxworksldadd)
+vxworkstests_sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_sem3_SOURCES = sem-3.c
+vxworkstests_sem3_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_sem3_LDADD = $(vxworksldadd)
+vxworkstests_sem3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_sem4_SOURCES = sem-4.c
+vxworkstests_sem4_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_sem4_LDADD = $(vxworksldadd)
+vxworkstests_sem4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstests_wd1_SOURCES = wd-1.c
+vxworkstests_wd1_CPPFLAGS = $(vxworkscppflags)
+vxworkstests_wd1_LDADD = $(vxworksldadd)
+vxworkstests_wd1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
diff --git a/lib/vxworks/testsuite/lst-1.c b/testsuite/smokey/vxworkstests/lst-1.c
similarity index 99%
rename from lib/vxworks/testsuite/lst-1.c
rename to testsuite/smokey/vxworkstests/lst-1.c
index 03dec367d7..878f32c902 100644
--- a/lib/vxworks/testsuite/lst-1.c
+++ b/testsuite/smokey/vxworkstests/lst-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/msgQ-1.c b/testsuite/smokey/vxworkstests/msgQ-1.c
similarity index 98%
rename from lib/vxworks/testsuite/msgQ-1.c
rename to testsuite/smokey/vxworkstests/msgQ-1.c
index fd15e1ddd9..71eedd44f5 100644
--- a/lib/vxworks/testsuite/msgQ-1.c
+++ b/testsuite/smokey/vxworkstests/msgQ-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/msgQ-2.c b/testsuite/smokey/vxworkstests/msgQ-2.c
similarity index 98%
rename from lib/vxworks/testsuite/msgQ-2.c
rename to testsuite/smokey/vxworkstests/msgQ-2.c
index 58f11e3a16..d3ee1397c7 100644
--- a/lib/vxworks/testsuite/msgQ-2.c
+++ b/testsuite/smokey/vxworkstests/msgQ-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/msgQ-3.c b/testsuite/smokey/vxworkstests/msgQ-3.c
similarity index 98%
rename from lib/vxworks/testsuite/msgQ-3.c
rename to testsuite/smokey/vxworkstests/msgQ-3.c
index 1a4e20d26c..a23d5c3d09 100644
--- a/lib/vxworks/testsuite/msgQ-3.c
+++ b/testsuite/smokey/vxworkstests/msgQ-3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/rng-1.c b/testsuite/smokey/vxworkstests/rng-1.c
similarity index 99%
rename from lib/vxworks/testsuite/rng-1.c
rename to testsuite/smokey/vxworkstests/rng-1.c
index dd944a58ac..1e179c6f66 100644
--- a/lib/vxworks/testsuite/rng-1.c
+++ b/testsuite/smokey/vxworkstests/rng-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/lib/vxworks/testsuite/sem-1.c b/testsuite/smokey/vxworkstests/sem-1.c
similarity index 98%
rename from lib/vxworks/testsuite/sem-1.c
rename to testsuite/smokey/vxworkstests/sem-1.c
index 245eb5c484..b64aba3b8f 100644
--- a/lib/vxworks/testsuite/sem-1.c
+++ b/testsuite/smokey/vxworkstests/sem-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/sem-2.c b/testsuite/smokey/vxworkstests/sem-2.c
similarity index 98%
rename from lib/vxworks/testsuite/sem-2.c
rename to testsuite/smokey/vxworkstests/sem-2.c
index c9befc4d9f..67caf2924f 100644
--- a/lib/vxworks/testsuite/sem-2.c
+++ b/testsuite/smokey/vxworkstests/sem-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/sem-3.c b/testsuite/smokey/vxworkstests/sem-3.c
similarity index 97%
rename from lib/vxworks/testsuite/sem-3.c
rename to testsuite/smokey/vxworkstests/sem-3.c
index 1041d25b0d..1f4252e3d9 100644
--- a/lib/vxworks/testsuite/sem-3.c
+++ b/testsuite/smokey/vxworkstests/sem-3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/sem-4.c b/testsuite/smokey/vxworkstests/sem-4.c
similarity index 98%
rename from lib/vxworks/testsuite/sem-4.c
rename to testsuite/smokey/vxworkstests/sem-4.c
index 5c82169e19..0a8daedb1d 100644
--- a/lib/vxworks/testsuite/sem-4.c
+++ b/testsuite/smokey/vxworkstests/sem-4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/task-1.c b/testsuite/smokey/vxworkstests/task-1.c
similarity index 96%
rename from lib/vxworks/testsuite/task-1.c
rename to testsuite/smokey/vxworkstests/task-1.c
index 3cf5f38061..a07d643c39 100644
--- a/lib/vxworks/testsuite/task-1.c
+++ b/testsuite/smokey/vxworkstests/task-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/vxworks/testsuite/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
similarity index 98%
rename from lib/vxworks/testsuite/task-2.c
rename to testsuite/smokey/vxworkstests/task-2.c
index 46d99a266b..7f9f0f0020 100644
--- a/lib/vxworks/testsuite/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
new file mode 100644
index 0000000000..183df35095
--- /dev/null
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -0,0 +1,45 @@
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
+TEST(vxworkstests)
+TEST(vxworkstests_lst1)
+TEST(vxworkstests_msgQ1)
+TEST(vxworkstests_msgQ2)
+TEST(vxworkstests_msgQ3)
+TEST(vxworkstests_rng1)
+TEST(vxworkstests_sem1)
+TEST(vxworkstests_sem2)
+TEST(vxworkstests_sem3)
+TEST(vxworkstests_sem4)
+TEST(vxworkstests_wd1)
+TEST(vxworkstests_task1)
+TEST(vxworkstests_task2)
diff --git a/testsuite/smokey/vxworkstests/vxworkstests_driver.c b/testsuite/smokey/vxworkstests/vxworkstests_driver.c
new file mode 100644
index 0000000000..7cacbb399b
--- /dev/null
+++ b/testsuite/smokey/vxworkstests/vxworkstests_driver.c
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
diff --git a/lib/vxworks/testsuite/wd-1.c b/testsuite/smokey/vxworkstests/wd-1.c
similarity index 97%
rename from lib/vxworks/testsuite/wd-1.c
rename to testsuite/smokey/vxworkstests/wd-1.c
index b557545e8b..7da5d4dcbb 100644
--- a/lib/vxworks/testsuite/wd-1.c
+++ b/testsuite/smokey/vxworkstests/wd-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
-- 
2.35.3
