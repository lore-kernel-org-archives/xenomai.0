Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BF17AAD
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 11:32:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMohu4EDBta2QX35/QCOzZ2k+gv/YC4ONiZob0Ucf6EUOWxFmCd7Ak0LVTz3bWiIGdmn9GvnhPDRm6x7rQ6nj9cpT54FsLlyO5kqlCf9FGG2OpyVu9zZmMrQhSD9b7gR1rH29zgEcbzNGb9sypgD6K8axDp5GpkFZCgAB7oFB76VaaFrVQNATiSmjrUawzBp3wsAGRlnJyfbML6pR7TjLWhyoR7ea8O1yR6wn/Saf9WSZ//mR8EWl/6q+iCwi0VmRstp6KwHsqKgt0gHAfOp7r932+50O8Vou2Sv/DoEvPQ6bmntCK8zaFfXupCz/ljJe8uqrSLNEFj0k7vuILoD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8Q1e8ts2dLgzx8TJySPSbkSfwt1aHmRcr9kew61D4g=;
 b=YwmuG4elaWBBqb0hkGEyFujUcSL68QNn9cWn0ZzbMOB5ma/gCcKxAqfkBkuAxRFZVjSDklNRlZgzOGJJcgybu99Zu+5SVJJLxGcKcgP/KqcWYb8wxfXo/ENOQwDVy3IQDKS8kywIUh9ipnTTTAuAJgdudS2anoO3O3n8hNl4uN1UowWGLto+IxLg4atlBB2rjddKW4wzOkYr8Lq0VvICUhuhj6Upk0ZDfQq0zvVIq6DKEG8FMCwmoJacW3N1+acpYkhgf4qy0xCnrDvdgpbm5SSe1F5ZfruaHqisODRySCjqKhphGcGrD463GuXuqgCAEfO7brrVsvEfVIVqTMQ2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8Q1e8ts2dLgzx8TJySPSbkSfwt1aHmRcr9kew61D4g=;
 b=ywV6a6t93wJTVQPzvyOwLsQkjjxv47YCaoZwDCSIjkc12PwtZnGKEr5hwlgWOdOTyDqZn2Y+TNq8ueIM0eiaMGUbkNLser8fW48kg/5lKZYzkO8VutVPhjkCPQo0IQqvrwLourLy+cMm/T3Qpa40lr0VsRbtvmxNTFOOZtVZ63Hr/W4n7yAipa16lnsxIYv0/e+PNh2EmwrpSw9N5kfLNgx34UtHYONXEs59+4FFiwDSq7mF1DKZggg9iJmCEpLM8nUnXdb9y09oUaYUAh372JWHsWtC6wKhULmsLEUXRtYpdWgNDL7Egh9Bm10umfLWCCTgTeled1Sui60Eo9F5Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:581::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 11:32:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 11:32:43 +0000
Message-ID: <a8499bcc-5da8-4da7-8695-d5955d1a680b@siemens.com>
Date: Wed, 9 Aug 2023 13:32:42 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 02/10] testsuite: Fully integrate psostests into smokey
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
 <20230725082959.5144-3-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230725082959.5144-3-aaron@sigma-star.at>
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
X-MS-Office365-Filtering-Correlation-Id: eaa9726f-0dbe-417f-390b-08db98cc5871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cuy7rnba/juPOM4pQj2zX0lRT3ScXb9FkaLyRaxTjDRlTAdNVi3+pS/KKp9WaMiL+WpzhdCyNxWXtf24XP5tvN/1PkFER9K7u3vK8E0teNCpAU3ZwNxxUEf0LYVP6LomfT/zAhAj4WRwDrtRSFe+jPYioBkyWhtt6fI1Hc6gOcl83PM7CRb+SlJxJg4QyOdIbZqG44LLrKZIk3+OCr80SLUo+L58GNV+PKDAw+zTYVliQ7tfmM7gG9HAgXpJJVQhnhjUJox0A1Ro2CtuiY4ot8QaA9d0rJq2nP3/G8I9uTp1WZuaRkljHnZ4Hw1k1ybhyb4y/rXXUbX/rs3pYxfiv8V+U7ep4gAWSLNOirdsa7ZwtYWaz8jrzcbh2jdO2Bt2IvCzebbarxJVjYi0YEsYaW7dYoldAJTqdk03ZDseWU+QjxaS1Gk019XUHRFD2ENUPj5JZKsyv3M2zbuqcCSMLzr7NZArLrzUYM/2dOz2CXkJLWP2bAY8Y/yclKoLDsttPEglji0d7d+f68F9Ww5mGN18/LKjsJ2yZ2Gm8lrTqPnoH5dPl2UdRa6BVe36Q3sarLjd47uzBjCh6fvSy3GBc22yRiVDbkeZ/VVy4XRylHjthbEc5SzynAkUyiupH0x4X7hfijgqJ8i9tjqgviiNEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(1800799006)(451199021)(186006)(44832011)(8936002)(5660300002)(8676002)(4326008)(41300700001)(316002)(83380400001)(86362001)(31696002)(30864003)(2906002)(6512007)(31686004)(6486002)(2616005)(6506007)(26005)(66556008)(66946007)(36756003)(66476007)(82960400001)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzFLZGN6cnlSTGw3MXdVV0cyL2g2eU9zZElCR3EvOUFUcm9ZNVQ1Wkhza0ZO?=
 =?utf-8?B?OXRKSDU2a0U3MUVvc1Q3UmtMMzZ4SHMxMVBSeDFIS1JaVHdGYVcwY3ZON0xs?=
 =?utf-8?B?VXJuNWtsK2plN004UmQ2emlhSVg0ZzBmM2tyNlM4bUdmTmxyZkF4UWdqYlI0?=
 =?utf-8?B?KzVuakorTXI2MENGMEdPSXAxUjlsM0htemhXSVM1d0Z2MXVJZFlYSGwybkt1?=
 =?utf-8?B?OTMveFhiUDBLNlpQeXhsYVltVUUwTzFxZ0F1YXNxNHNBL0h2Nmp2cGVpaEhX?=
 =?utf-8?B?cnZOdEw3QVpyWk9ENTNSOGNzRXRtbEMxeVNFRWs2bmtzbXlGd3RhcStOYXpt?=
 =?utf-8?B?bFRNa0NzM1BNYzlSWVV1VXp6VTN2dDdOUGVXVEtEamdEZVNjY3RtbDh2VXk3?=
 =?utf-8?B?NTVrczNXUzlnSDFoNHh1Z0VZUktrWTVTekhzYjhQVkVRRzlFTzZKdFRSVEta?=
 =?utf-8?B?ZUw5czVSSVovODdNeVFjYU1Ud3JnYlNFL3JCc0ZhREVSZ1I2eW5rQi9hc2xH?=
 =?utf-8?B?bGRqR2cyTUdST0RXSFkxd0N3WVl2ckYxZ0M1STN4VDd0MkF4OUlmMEVCaE0y?=
 =?utf-8?B?cmRtdnBiU0hZQlhLUkU4ZVR5QUZ4NVJPNVliUEVvWDVTUURFMzFNQUhlc28v?=
 =?utf-8?B?bGw3L2NCRzVCdXpReVdJZ0ZITHA2QTR1OWE3UUFQRjFaYXVhOFJKekN0Ymhu?=
 =?utf-8?B?b1NXYzJkV1FyUTBvMEtIS3hoUytVR21EemtQZ1VwWEpKZlExNTRVbFkxb1Nw?=
 =?utf-8?B?bHFPaWxxbmY2NmNjM2YvQTlva0VqOGphcVZ5Q0o2VXZCQXZObFRzWW5wUDR2?=
 =?utf-8?B?ci9CenFVWFo5NXlKaEk0dnZTZlBaaUJrWEQ3eTZxaS95b1NJYjN3U09iV2g2?=
 =?utf-8?B?ejBwQnl4bFhXa1RiRXkzRWN2d1JIcmhVQWJyaHhLRGErNGlqNVlnTVU2TFdO?=
 =?utf-8?B?cW44RURlQk1FS1hjRUN5WDBac3E4M2VrQUZlQVBncmRhWjRxNkR5OXlORG1K?=
 =?utf-8?B?aUtYZjVqU1ZiSVA3ZVVjWk1jWEltNmlZbDV1emZ2c3g0R3NWNlFtVDF4NUw0?=
 =?utf-8?B?Ymx6WVNRYVlGUmphV0R3N2NlU2luMW5nQjFjdXBQZCtZM2tsdHBPUXZJZkRS?=
 =?utf-8?B?RjlOS2tLSE5hZlhnaktMcHhhRk9aU2lsVEh5UGxpeEJUQ1ZwYmQrQm9PQUp0?=
 =?utf-8?B?VUg4UDZpbXZJTStMeUpjUkl0dkZQVXJPWElTc1ZOaXBTOEJVdERxN0UwSjZB?=
 =?utf-8?B?RGJkSGtoSWJSS1pqOHVNWVptMWVhaFNEbFByT3dNUXEzSHArSFBYQWRHQ1o4?=
 =?utf-8?B?KzZmeUZoT3Qya3JEdHZQSXVMbEdkN1QzWXBMb2RzTG9BM25ORElMYW56YURr?=
 =?utf-8?B?KzYzU1QrSjM1VjVEYzc0aHJLUngwM093VmtDejFvTWoyNVZDQ1lqRXNwdWcv?=
 =?utf-8?B?L0JKOEZJYWNhY1YzSWtNSjF6M2VpMkpwUjc4NG5GU1NVZXBGR2trbkkwZWkw?=
 =?utf-8?B?M3JFSWdVWU1GYlo0TExzTWhrdHROcTY1Nng3OGVjcVgvdU5qOWhVdFBPMFVE?=
 =?utf-8?B?R1NMaVQ3QWhwcmFjVEt2SGFiazBOWnlCcmV6MHc0ajlPMXZZMUpWVGd0NVRy?=
 =?utf-8?B?bU8wSzZzYllFVzFxYmZzcStTbjgzbXF4Ymd4ZysvRHBaVVN5dTZwWDhVaThK?=
 =?utf-8?B?Mi9kcEVZTzZTbnlYYWRkNVJJTzlSWlZZL05xOWdYc2gwU0tDVjc4bjBTT3JU?=
 =?utf-8?B?NDFiMlN2U3hUOThTV2ZYZStmY0lDN0RPQmRJUlVvTjF3M0dMdldFRmM3K3pC?=
 =?utf-8?B?cnNIMW5FQk1HVi9RdFFLRWkvSm0rMUhjSjM0ajFDcjRXNHNocjFQWnV4RUlK?=
 =?utf-8?B?K0NMa0lpbkZJVVBqYlBrL2lidzFkbXpvcjRDRm5OQWVGM2JUdVpkL3RoK3ow?=
 =?utf-8?B?bEhRamFQSmdxcm5EcFVsY1ExdnlrTjEwZ2Q3Mmg3NUl6Y0dtb0hkSUMwaGFh?=
 =?utf-8?B?WUNRY2lMU3pYeGMrSlNlZnc2aE9CMHJRRDZlTk9uRWMzVXZHUlY1UFJyeSth?=
 =?utf-8?B?TkFUMWUvdEtrKzNOem10Zk1xWnlxamx2djdlUFBhTkx1NGxoWnoycm05d05C?=
 =?utf-8?B?dUgvWXlMdkd1a1FnZHBqZHhxYnBWVVExTlluZzB0aGx1ckRwa2xYMTNTT0dY?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa9726f-0dbe-417f-390b-08db98cc5871
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 11:32:42.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBsqBcAwAgidgbWN0j/dXWWRVGVuJ/wljl6IDldqfh1hVgXaYrmaYMyD4BfTyHGu4VzHmct5Z7VBYx2kQ8ETjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6062

From: Aaron Marcher <aaron@sigma-star.at>

Just like for alchemytests, integrate them into our testsuite.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
[Jan: fix whitespace issue, clean up makefile, do not hook into automake yet]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac                                  |   2 +-
 lib/psos/testsuite/Makefile                   |  49 ------
 testsuite/smokey/psostests/Makefile.am        | 151 ++++++++++++++++++
 .../smokey/psostests}/mq-1.c                  |   1 +
 .../smokey/psostests}/mq-2.c                  |   1 +
 .../smokey/psostests}/mq-3.c                  |   1 +
 testsuite/smokey/psostests/psostests.c        |  56 +++++++
 testsuite/smokey/psostests/psostests_driver.c |  33 ++++
 .../smokey/psostests}/pt-1.c                  |   1 +
 .../smokey/psostests}/rn-1.c                  |   1 +
 .../smokey/psostests}/sem-1.c                 |   1 +
 .../smokey/psostests}/sem-2.c                 |   1 +
 .../smokey/psostests}/task-1.c                |   1 +
 .../smokey/psostests}/task-2.c                |   1 +
 .../smokey/psostests}/task-3.c                |   1 +
 .../smokey/psostests}/task-4.c                |   1 +
 .../smokey/psostests}/task-5.c                |   1 +
 .../smokey/psostests}/task-6.c                |   1 +
 .../smokey/psostests}/task-7.c                |   1 +
 .../smokey/psostests}/task-8.c                |   1 +
 .../smokey/psostests}/task-9.c                |   1 +
 .../smokey/psostests}/tm-1.c                  |   1 +
 .../smokey/psostests}/tm-2.c                  |   1 +
 .../smokey/psostests}/tm-3.c                  |   1 +
 .../smokey/psostests}/tm-4.c                  |   1 +
 .../smokey/psostests}/tm-5.c                  |   1 +
 .../smokey/psostests}/tm-6.c                  |   1 +
 .../smokey/psostests}/tm-7.c                  |   1 +
 28 files changed, 264 insertions(+), 50 deletions(-)
 delete mode 100644 lib/psos/testsuite/Makefile
 create mode 100644 testsuite/smokey/psostests/Makefile.am
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-1.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-2.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-3.c (98%)
 create mode 100644 testsuite/smokey/psostests/psostests.c
 create mode 100644 testsuite/smokey/psostests/psostests_driver.c
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/pt-1.c (96%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/rn-1.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-1.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-2.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-1.c (95%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-2.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-3.c (96%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-4.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-5.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-6.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-7.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-8.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-9.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-1.c (95%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-2.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-3.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-4.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-5.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-6.c (95%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-7.c (95%)

diff --git a/configure.ac b/configure.ac
index fe59333ed4..9db5438eb6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1044,9 +1044,9 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/can/Makefile \
 	testsuite/smokey/x86io/Makefile \
 	testsuite/smokey/alchemytests/Makefile \
+	testsuite/smokey/psostests/Makefile \
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
-	testsuite/psostests/Makefile \
 	testsuite/vxworkstests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
diff --git a/lib/psos/testsuite/Makefile b/lib/psos/testsuite/Makefile
deleted file mode 100644
index 3330a617ca..0000000000
--- a/lib/psos/testsuite/Makefile
+++ /dev/null
@@ -1,49 +0,0 @@
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
-TESTS := \
-	task-1 task-2 task-3 task-4 task-5 task-6 task-7 task-8 task-9 \
-	tm-1 tm-2 tm-3 tm-4 tm-5 tm-6 tm-7 \
-	mq-1 mq-2 mq-3 \
-	sem-1 sem-2 \
-	pt-1 \
-	rn-1
-
-CFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=psos --cflags) -g
-LDFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=psos --ldflags)
-CC = $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --cc)
-
-all: $(TESTS)
-
-%: %.c
-	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
-
-install: all
-	install -d $(prefix)/testsuite/psos
-	install -t $(prefix)/testsuite/psos $(TESTS)
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
diff --git a/testsuite/smokey/psostests/Makefile.am b/testsuite/smokey/psostests/Makefile.am
new file mode 100644
index 0000000000..ef4a231239
--- /dev/null
+++ b/testsuite/smokey/psostests/Makefile.am
@@ -0,0 +1,151 @@
+testdir = @XENO_TEST_DIR@
+noinst_LIBRARIES = libpsostests.a
+
+libpsostests_a_SOURCES = psostests.c
+libpsostests_a_CPPFLAGS = 	\
+	@XENO_USER_CFLAGS@	\
+	-I$(top_srcdir)		\
+	-I$(top_srcdir)/include \
+	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS =			\
+		psostests       \
+		psostests_mq1	\
+		psostests_mq2	\
+		psostests_mq3	\
+		psostests_pt1	\
+		psostests_rn1	\
+		psostests_sem1	\
+		psostests_sem2	\
+		psostests_tm1	\
+		psostests_tm2	\
+		psostests_tm3	\
+		psostests_tm4	\
+		psostests_tm5	\
+		psostests_tm6	\
+		psostests_tm7	\
+		psostests_task1	\
+		psostests_task2	\
+		psostests_task3	\
+		psostests_task4	\
+		psostests_task5	\
+		psostests_task6	\
+		psostests_task7	\
+		psostests_task8	\
+		psostests_task9
+
+psoscppflags =				\
+	@XENO_USER_CFLAGS@		\
+	-I$(top_srcdir)			\
+	-I$(top_srcdir)/include
+
+psosldadd =							\
+	../../../lib/psos/libpsos@CORE@.la			\
+	../../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 					\
+	@XENO_USER_LDADD@					\
+	-lpthread -lrt -lm
+
+psostests_SOURCES = psostests_driver.c
+psostests_CPPFLAGS = $(psoscppflags)
+psostests_LDADD =						\
+	../../../lib/smokey/libsmokey@CORE@.la			\
+	@XENO_CORE_LDADD@ 					\
+	@XENO_USER_LDADD@					\
+	-lpthread -lrt
+psostests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
+
+psostests_mq1_SOURCES = mq-1.c
+psostests_mq1_CPPFLAGS = $(psoscppflags)
+psostests_mq1_LDADD = $(psosldadd)
+psostests_mq1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_mq2_SOURCES = mq-2.c
+psostests_mq2_CPPFLAGS = $(psoscppflags)
+psostests_mq2_LDADD = $(psosldadd)
+psostests_mq2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_mq3_SOURCES = mq-3.c
+psostests_mq3_CPPFLAGS = $(psoscppflags)
+psostests_mq3_LDADD = $(psosldadd)
+psostests_mq3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_pt1_SOURCES = pt-1.c
+psostests_pt1_CPPFLAGS = $(psoscppflags)
+psostests_pt1_LDADD = $(psosldadd)
+psostests_pt1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_rn1_SOURCES = rn-1.c
+psostests_rn1_CPPFLAGS = $(psoscppflags)
+psostests_rn1_LDADD = $(psosldadd)
+psostests_rn1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_sem1_SOURCES = sem-1.c
+psostests_sem1_CPPFLAGS = $(psoscppflags)
+psostests_sem1_LDADD = $(psosldadd)
+psostests_sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_sem2_SOURCES = sem-2.c
+psostests_sem2_CPPFLAGS = $(psoscppflags)
+psostests_sem2_LDADD = $(psosldadd)
+psostests_sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm1_SOURCES = tm-1.c
+psostests_tm1_CPPFLAGS = $(psoscppflags)
+psostests_tm1_LDADD = $(psosldadd)
+psostests_tm1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm2_SOURCES = tm-2.c
+psostests_tm2_CPPFLAGS = $(psoscppflags)
+psostests_tm2_LDADD = $(psosldadd)
+psostests_tm2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm3_SOURCES = tm-3.c
+psostests_tm3_CPPFLAGS = $(psoscppflags)
+psostests_tm3_LDADD = $(psosldadd)
+psostests_tm3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm4_SOURCES = tm-4.c
+psostests_tm4_CPPFLAGS = $(psoscppflags)
+psostests_tm4_LDADD = $(psosldadd)
+psostests_tm4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm5_SOURCES = tm-5.c
+psostests_tm5_CPPFLAGS = $(psoscppflags)
+psostests_tm5_LDADD = $(psosldadd)
+psostests_tm5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm6_SOURCES = tm-6.c
+psostests_tm6_CPPFLAGS = $(psoscppflags)
+psostests_tm6_LDADD = $(psosldadd)
+psostests_tm6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm7_SOURCES = tm-7.c
+psostests_tm7_CPPFLAGS = $(psoscppflags)
+psostests_tm7_LDADD = $(psosldadd)
+psostests_tm7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task1_SOURCES = task-1.c
+psostests_task1_CPPFLAGS = $(psoscppflags)
+psostests_task1_LDADD = $(psosldadd)
+psostests_task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task2_SOURCES = task-2.c
+psostests_task2_CPPFLAGS = $(psoscppflags)
+psostests_task2_LDADD = $(psosldadd)
+psostests_task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task3_SOURCES = task-3.c
+psostests_task3_CPPFLAGS = $(psoscppflags)
+psostests_task3_LDADD = $(psosldadd)
+psostests_task3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task4_SOURCES = task-4.c
+psostests_task4_CPPFLAGS = $(psoscppflags)
+psostests_task4_LDADD = $(psosldadd)
+psostests_task4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task5_SOURCES = task-5.c
+psostests_task5_CPPFLAGS = $(psoscppflags)
+psostests_task5_LDADD = $(psosldadd)
+psostests_task5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task6_SOURCES = task-6.c
+psostests_task6_CPPFLAGS = $(psoscppflags)
+psostests_task6_LDADD = $(psosldadd)
+psostests_task6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task7_SOURCES = task-7.c
+psostests_task7_CPPFLAGS = $(psoscppflags)
+psostests_task7_LDADD = $(psosldadd)
+psostests_task7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task8_SOURCES = task-8.c
+psostests_task8_CPPFLAGS = $(psoscppflags)
+psostests_task8_LDADD = $(psosldadd)
+psostests_task8_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task9_SOURCES = task-9.c
+psostests_task9_CPPFLAGS = $(psoscppflags)
+psostests_task9_LDADD = $(psosldadd)
+psostests_task9_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
diff --git a/lib/psos/testsuite/mq-1.c b/testsuite/smokey/psostests/mq-1.c
similarity index 97%
rename from lib/psos/testsuite/mq-1.c
rename to testsuite/smokey/psostests/mq-1.c
index 00f4248984..83a24028ec 100644
--- a/lib/psos/testsuite/mq-1.c
+++ b/testsuite/smokey/psostests/mq-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/mq-2.c b/testsuite/smokey/psostests/mq-2.c
similarity index 98%
rename from lib/psos/testsuite/mq-2.c
rename to testsuite/smokey/psostests/mq-2.c
index 48b4e611cd..8af8b42d6e 100644
--- a/lib/psos/testsuite/mq-2.c
+++ b/testsuite/smokey/psostests/mq-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/mq-3.c b/testsuite/smokey/psostests/mq-3.c
similarity index 98%
rename from lib/psos/testsuite/mq-3.c
rename to testsuite/smokey/psostests/mq-3.c
index 942b1a325f..1171a70544 100644
--- a/lib/psos/testsuite/mq-3.c
+++ b/testsuite/smokey/psostests/mq-3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
new file mode 100644
index 0000000000..0221f65afd
--- /dev/null
+++ b/testsuite/smokey/psostests/psostests.c
@@ -0,0 +1,56 @@
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
+TEST(psostests)
+TEST(psostests_mq1)
+TEST(psostests_mq2)
+TEST(psostests_mq3)
+TEST(psostests_pt1)
+TEST(psostests_rn1)
+TEST(psostests_sem1)
+TEST(psostests_sem2)
+TEST(psostests_task1)
+TEST(psostests_task2)
+TEST(psostests_task3)
+TEST(psostests_task4)
+TEST(psostests_task5)
+TEST(psostests_task6)
+TEST(psostests_task7)
+TEST(psostests_task8)
+TEST(psostests_task9)
+TEST(psostests_tm1)
+TEST(psostests_tm2)
+TEST(psostests_tm3)
+TEST(psostests_tm4)
+TEST(psostests_tm5)
+TEST(psostests_tm6)
+TEST(psostests_tm7)
diff --git a/testsuite/smokey/psostests/psostests_driver.c b/testsuite/smokey/psostests/psostests_driver.c
new file mode 100644
index 0000000000..c931d196d5
--- /dev/null
+++ b/testsuite/smokey/psostests/psostests_driver.c
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
+       struct smokey_test *t;
+       int ret, fails = 0;
+
+       if (pvlist_empty(&smokey_test_list))
+               return 0;
+
+       for_each_smokey_test(t) {
+               ret = t->run(t, argc, argv);
+               if (ret) {
+                       fails++;
+                       if (smokey_keep_going)
+                               continue;
+                       if (smokey_verbose_mode)
+                               error(1, -ret, "test %s failed", t->name);
+                       return 1;
+               }
+               smokey_note("%s OK", t->name);
+       }
+
+       return fails != 0;
+}
diff --git a/lib/psos/testsuite/pt-1.c b/testsuite/smokey/psostests/pt-1.c
similarity index 96%
rename from lib/psos/testsuite/pt-1.c
rename to testsuite/smokey/psostests/pt-1.c
index 99f93ca1a1..48f9799f79 100644
--- a/lib/psos/testsuite/pt-1.c
+++ b/testsuite/smokey/psostests/pt-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <memory.h>
diff --git a/lib/psos/testsuite/rn-1.c b/testsuite/smokey/psostests/rn-1.c
similarity index 97%
rename from lib/psos/testsuite/rn-1.c
rename to testsuite/smokey/psostests/rn-1.c
index da136f3815..42f86a7eab 100644
--- a/lib/psos/testsuite/rn-1.c
+++ b/testsuite/smokey/psostests/rn-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <memory.h>
diff --git a/lib/psos/testsuite/sem-1.c b/testsuite/smokey/psostests/sem-1.c
similarity index 98%
rename from lib/psos/testsuite/sem-1.c
rename to testsuite/smokey/psostests/sem-1.c
index 61fa4b6051..d32334c02c 100644
--- a/lib/psos/testsuite/sem-1.c
+++ b/testsuite/smokey/psostests/sem-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/sem-2.c b/testsuite/smokey/psostests/sem-2.c
similarity index 97%
rename from lib/psos/testsuite/sem-2.c
rename to testsuite/smokey/psostests/sem-2.c
index a15bc388f7..8223434f5e 100644
--- a/lib/psos/testsuite/sem-2.c
+++ b/testsuite/smokey/psostests/sem-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/task-1.c b/testsuite/smokey/psostests/task-1.c
similarity index 95%
rename from lib/psos/testsuite/task-1.c
rename to testsuite/smokey/psostests/task-1.c
index f4bb71b7eb..a0e6efa972 100644
--- a/lib/psos/testsuite/task-1.c
+++ b/testsuite/smokey/psostests/task-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/task-2.c b/testsuite/smokey/psostests/task-2.c
similarity index 98%
rename from lib/psos/testsuite/task-2.c
rename to testsuite/smokey/psostests/task-2.c
index d7f9fa06ff..d24c134653 100644
--- a/lib/psos/testsuite/task-2.c
+++ b/testsuite/smokey/psostests/task-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/task-3.c b/testsuite/smokey/psostests/task-3.c
similarity index 96%
rename from lib/psos/testsuite/task-3.c
rename to testsuite/smokey/psostests/task-3.c
index d775f28232..d13e30423b 100644
--- a/lib/psos/testsuite/task-3.c
+++ b/testsuite/smokey/psostests/task-3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/task-4.c b/testsuite/smokey/psostests/task-4.c
similarity index 97%
rename from lib/psos/testsuite/task-4.c
rename to testsuite/smokey/psostests/task-4.c
index 3bca00271e..ec6a99609f 100644
--- a/lib/psos/testsuite/task-4.c
+++ b/testsuite/smokey/psostests/task-4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/task-5.c b/testsuite/smokey/psostests/task-5.c
similarity index 98%
rename from lib/psos/testsuite/task-5.c
rename to testsuite/smokey/psostests/task-5.c
index e0124c12b5..dcb8ec6eaa 100644
--- a/lib/psos/testsuite/task-5.c
+++ b/testsuite/smokey/psostests/task-5.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/task-6.c b/testsuite/smokey/psostests/task-6.c
similarity index 98%
rename from lib/psos/testsuite/task-6.c
rename to testsuite/smokey/psostests/task-6.c
index 13c618c578..9cc46e6339 100644
--- a/lib/psos/testsuite/task-6.c
+++ b/testsuite/smokey/psostests/task-6.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/task-7.c b/testsuite/smokey/psostests/task-7.c
similarity index 97%
rename from lib/psos/testsuite/task-7.c
rename to testsuite/smokey/psostests/task-7.c
index 8f5441afa0..9177dbbf46 100644
--- a/lib/psos/testsuite/task-7.c
+++ b/testsuite/smokey/psostests/task-7.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/task-8.c b/testsuite/smokey/psostests/task-8.c
similarity index 98%
rename from lib/psos/testsuite/task-8.c
rename to testsuite/smokey/psostests/task-8.c
index d7c8fb33dd..4543a04fad 100644
--- a/lib/psos/testsuite/task-8.c
+++ b/testsuite/smokey/psostests/task-8.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <xeno_config.h>
diff --git a/lib/psos/testsuite/task-9.c b/testsuite/smokey/psostests/task-9.c
similarity index 98%
rename from lib/psos/testsuite/task-9.c
rename to testsuite/smokey/psostests/task-9.c
index 1ae9929997..f37d6736ed 100644
--- a/lib/psos/testsuite/task-9.c
+++ b/testsuite/smokey/psostests/task-9.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/tm-1.c b/testsuite/smokey/psostests/tm-1.c
similarity index 95%
rename from lib/psos/testsuite/tm-1.c
rename to testsuite/smokey/psostests/tm-1.c
index b2f38f2986..64605d8b99 100644
--- a/lib/psos/testsuite/tm-1.c
+++ b/testsuite/smokey/psostests/tm-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/tm-2.c b/testsuite/smokey/psostests/tm-2.c
similarity index 97%
rename from lib/psos/testsuite/tm-2.c
rename to testsuite/smokey/psostests/tm-2.c
index 44340f5ddc..18ddff4b6e 100644
--- a/lib/psos/testsuite/tm-2.c
+++ b/testsuite/smokey/psostests/tm-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/tm-3.c b/testsuite/smokey/psostests/tm-3.c
similarity index 97%
rename from lib/psos/testsuite/tm-3.c
rename to testsuite/smokey/psostests/tm-3.c
index 260a1314e8..f5a947f463 100644
--- a/lib/psos/testsuite/tm-3.c
+++ b/testsuite/smokey/psostests/tm-3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/tm-4.c b/testsuite/smokey/psostests/tm-4.c
similarity index 97%
rename from lib/psos/testsuite/tm-4.c
rename to testsuite/smokey/psostests/tm-4.c
index 26697c2fb3..2c8c7a3189 100644
--- a/lib/psos/testsuite/tm-4.c
+++ b/testsuite/smokey/psostests/tm-4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/tm-5.c b/testsuite/smokey/psostests/tm-5.c
similarity index 97%
rename from lib/psos/testsuite/tm-5.c
rename to testsuite/smokey/psostests/tm-5.c
index 0fca7d023a..d136133987 100644
--- a/lib/psos/testsuite/tm-5.c
+++ b/testsuite/smokey/psostests/tm-5.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/tm-6.c b/testsuite/smokey/psostests/tm-6.c
similarity index 95%
rename from lib/psos/testsuite/tm-6.c
rename to testsuite/smokey/psostests/tm-6.c
index 9debc498c7..ba92c3071f 100644
--- a/lib/psos/testsuite/tm-6.c
+++ b/testsuite/smokey/psostests/tm-6.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/psos/testsuite/tm-7.c b/testsuite/smokey/psostests/tm-7.c
similarity index 95%
rename from lib/psos/testsuite/tm-7.c
rename to testsuite/smokey/psostests/tm-7.c
index 202985daa3..3676502784 100644
--- a/lib/psos/testsuite/tm-7.c
+++ b/testsuite/smokey/psostests/tm-7.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
-- 
2.35.3
