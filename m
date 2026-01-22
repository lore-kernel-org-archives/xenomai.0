Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F813E9F83
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078382; cv=fail; b=INQ0Y1bow6QYBv8sLaQ6KIQFzN/ArzbWMj7ILcTrV2t9Aod4wHQqJ09bpU52WgV2dqhOFFKoKTmmt6mVcuxriTZuL6hZGaZvRwun2Vnc8JiRSYIbKHapqQ/w6viS9ONy3WvSDZ5i6JrnIVfr4O25OEbSb+mM1geHJAKG49RfnAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078382; c=relaxed/simple;
	bh=PIilD9QOg1AvIERSpUC0/5PauompRqtAef7Me5yWpFE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Pr1q5nzbSxtsAy9R7w017pDl40WpNS1eWl5ZzNy5ZEBOPpBkhw5P5z859pAH18iU3g9/Vyram+S3fIy/07AMez0BgZscRBdjpzCqIJahKlbmOMwOU/SaDmH8k5SS8YW1KDaV3+50GW7rGeP20C2iv0Lds/u34WZp7idvSdzATf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QQGzgpHm; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QQGzgpHm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsGROWbfaQEfcDkrGHPm6lex7nENLeIET36Mv4+BHKGuzjGxadCba5uE8M1ZlG1oR0AuPBESSedi6HOAI0G7zeW4K0iQb7/lUclBwOXJAZXWWsK4pb/R6X40YuDYMovU+hjtlmOsky7VTqK6oCKn3l5dwqCzMvvLn6MI1DmqGTC+4VHfg3fS1/m6JocGiClEwdVdmq0ZtGq0sIQL6DFbvNpPEdenNiJLI14UmNVqZgtIp56GOM38y5oJhns1R9B2PT/twQYPzpkHdDKRcTC69Du1pAqnSsXm54uE0rTnT7RINTSOcsE7mM74J/DPtX1XVBZH2Cm1kcu0dY1vwqLDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLzRRYB8OZ0e++hatXXhJZGkik0xCPaTvqZwy1LrziE=;
 b=nTqwDT4bDNIF5QJDC3kRg1EMzuRIVZsG6SnsAhcYcEMU0N3aHFZR0kAbyYWeBhhpSSmthO5POeMmb1YcHisbH8uXPqYY74WvXjUE3IQnOkHGV28dwI3PEmRH0sZcSoJdXyOd6MjRpt0csMr6QVH1wYAcT/G0WhFoobJTTHVyTBId3Qse71Klve/3WFxX/ZobSQuowp26dC+I4n89dLJxFwHLVaW2PMbQDZ+MzHtTekVFxi/CqsFSx1bHkj11Pm28pISOx7CVk4aunJPrXOVNxmrz/p3sm+RQY7toGXgYKmy58vh79qoPbBfqiIhdvtV9J0kBDOUz01gWHFcnV5Oswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLzRRYB8OZ0e++hatXXhJZGkik0xCPaTvqZwy1LrziE=;
 b=QQGzgpHmqDYm6wAUvzygt7RNAKsuALKsljjAKkb26Lp3u/HZgXszuuns//UF0ArStBNxpLTdZCSx8+O476Utu2mxhPwVF0uBYkAzQ0jLRg+G/KD1qTmds0xvQiiw1MjiAI19qDfGURckxynQedOAkXVyoDNT/sTfIhzmi5nE1Hp+RsaMnD7LvBy+vwoRPZz7HnVSvQCtY5aMXiYJff2NWGog3CfRFk0Fc5YPgTrpcM2v1Cr/q7iOI029CW6Q8GIv2OtTkVAh/qtlSQwfe3uFYYlRKosgS3DIoL3Dup9NUwoyQ+j7iZ2vBBl0bMXHY8r+qbT3rImSBTZtGUKupfrzpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU2PR10MB7744.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:491::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Thu, 22 Jan
 2026 10:39:36 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:39:36 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] ci: run the EVL testsuite for basic testing
Date: Thu, 22 Jan 2026 11:39:28 +0100
Message-ID: <20260122103928.424945-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU2PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 760afa2e-694d-4cbb-fed4-08de59a289b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1NY/6zrZsYGSn4YzgMsiEgNNogO1lx3Uq6CnF56scBazXaiqHzjaj5xBpJ/d?=
 =?us-ascii?Q?vliYivAdpBfXtMP555mUvf3IbOgAg8k9eRh4Vz+++TCw1TtdOZk34LoTvsJf?=
 =?us-ascii?Q?9W1lZeWjqnK32w1qwJ49ybVlV8mlT7X2IPDLfLw4LOki6VAdc9VEdu3glPxB?=
 =?us-ascii?Q?nUvCOXiDkChK2stzJNBHQzkHFcp1hbpES2h7i1YT63mpbaV9dhMl60/naVsa?=
 =?us-ascii?Q?EiSn7dKBC5JF5DPMb9HNKr43JtfroBf89hzOU9gHMQ5nvSCEn+NnQm6eDsx/?=
 =?us-ascii?Q?1CAEPBoH107NM5AdXQ6s1IdiHrZK0BKkJ2pZBNv+VIQCRXZptXIuSEnFUnZk?=
 =?us-ascii?Q?lV5Dx4nOU0AZ6NOSxMnp/7HtEYEeDx7cIXjmadpWzFwl+EG0J4cjaR0uDgZ6?=
 =?us-ascii?Q?/fRX5qXnQteuJLJ4OwRLrf/jj4x9PP2DIpc3DZUQBLVZuOTQpbkPsfgYVQPY?=
 =?us-ascii?Q?oNlNuByssZOFw/fQXNUmH6AJVAbm29Bm/mAPqAgMxXv188o8FBPKZ4yUSJ+f?=
 =?us-ascii?Q?1jMDzMO6gA4wIoY5IajvWqu6IJkoST0vuEV2xjZVRgEjvesrwdBmF2BA1S7e?=
 =?us-ascii?Q?fHCwynmGswGe69z6vrzBuRyRv7NizNG8dI9gBTzbrCXKBswUJlMVAT49aTa/?=
 =?us-ascii?Q?AdvJ1fTlSv/azeB5yL5mZe+ZHeVmdVgi07wWQ9ieF3o//mKLLgpEwxD42Xca?=
 =?us-ascii?Q?zaAEoiJqPnr+uQAW1qyJuzOTaymOtyQu2Ld3yY/rHV9eqK3OVDa/6mrzShUF?=
 =?us-ascii?Q?/JDaEFm1ctEee+v/kBn5UqfEx6XuM18/QUSzH8qXOsh59swR9abmbGO5S0Nc?=
 =?us-ascii?Q?mYFT3dozIFj2KvsvcnA65nEaKFqkDgPYtOFlGeFq6BBWwyOkSermrYuCfbfs?=
 =?us-ascii?Q?j+dB/d4OnwC+bf7BNESUNrWNNt3gEYtnRp3fxjpWi5wGpUDn83HnVfawlvGI?=
 =?us-ascii?Q?/ZL4c/DJKp/j5+at11J13FlA9W7FTREX163T/r3JCpVlnOQL/0UlGedznrUj?=
 =?us-ascii?Q?OD85n83S37nVHnrVYvUZnWY5gZUj5YcAVyNNhn5VUd0arAJ5MREvpiLbXNR0?=
 =?us-ascii?Q?Acz3QpyhQU1Rz8Cb/x0cfZIuGzrMBB6a1QqabbtDskzprbQo//JbR9JJLcwQ?=
 =?us-ascii?Q?Yi4z0S+6T1QEcLvqcNIJyoSTOXqB9D1q53e7Efs0rU6iXhxX4Gg/LqLmfpRt?=
 =?us-ascii?Q?UyjaHZQWHu37+UyK5Evo+mb714Gm5Y3lnbBznRD5K72yLlcLyaeuT9BzBv98?=
 =?us-ascii?Q?KWQJia3MfHk9LWGjrwe6x8H77r9+ZgJ9Pj8wCBArlV9+H4Yg7YSwtX/9o+3B?=
 =?us-ascii?Q?CIPe7Ws94JaqHFuN8sc0iGhUqiXEMGmF3bGphFTOGWC3ptlkP13WKXFtYzqR?=
 =?us-ascii?Q?Sftd1WLrXSyGmhx78o2NiE26PSAOYqIa+AT6upA+ZoAM8GIgl8u44U/WvBVN?=
 =?us-ascii?Q?Q2lXFhjcwCC/NyTI5dtKIKtngogNVDrfiz2MF3Zbb2w795fBYZvc8ZG60r+K?=
 =?us-ascii?Q?V/xIiTYrfZhuQr0NmVgCzs0Yn9K+Yq5QLNdImvTt2rdQP+WwZNb2PVY0NdZL?=
 =?us-ascii?Q?vFYpnoAGcDL/AyPL7js=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJbGK975JzB6uo39nhVSpccfpMbruNosWzVuSqT7VkJ8+rd2GK4BCGFykShd?=
 =?us-ascii?Q?c3n1IRawjU4UKGlpl1dvICibw1HeQzXhZngBNsy2VOM0kdmQxv9he26n3ERO?=
 =?us-ascii?Q?9KnTm+XtJSfllSjQomkyk4xUFI/7j0uroNF3moIZjORwPsrYRLyo4c0AlDxk?=
 =?us-ascii?Q?RRNvP2ve7gUbSnMqf1/t+wRrHf6H+hVayyrZV9BaeLon2bQekVDQ8vqZZRQ7?=
 =?us-ascii?Q?9yiFo+SIwiPINg1psbqW2o+hKd7jWgJ1liPHsBkrxizkgVCtWrMOJL/P79Ff?=
 =?us-ascii?Q?0szK1hKoGf4OZpP0mT5Cls1N/hRwrQqt0OihUxAgvEX9uz1ID9yJtVnPuNK5?=
 =?us-ascii?Q?kgByfnYLFwzmrxxh0kmTWGe9ex1EaPdG26TBnDVaAcgh7dKFpNgjzmmhGRR2?=
 =?us-ascii?Q?zKDedmjA6Frp8NiALGlENHLmIEDg8eNo1pTbVl1N/xuqNEc0R6HoPDRTB1RF?=
 =?us-ascii?Q?FYrpW/2QaGspkZQqpti8YUgd3Y4OfCZuqUc3nAIFuWs4MNH6MuayLHQATeZN?=
 =?us-ascii?Q?OhYBIoZUqZSS840LizUgHTwpZsxwmmGXWPFPyRD0waDpVXso2VQoaljtoX3F?=
 =?us-ascii?Q?7gxzus5HcEPXz6qk5xGRwDfkxgaLEUJ2nbpSYNDzYr1aoOeWwMyHvTm06ppI?=
 =?us-ascii?Q?2xaZfABlx2Pbp4enf8V3UR1iu5A7iTlHwodXIukLYg0vffC8WusNfZgG1Cqu?=
 =?us-ascii?Q?5B2XtLrAUycqArpl+Wn8bVsU0z/qzDYCooUoFI+SUMfuRIOAT8CS/xgbycSl?=
 =?us-ascii?Q?uaHzllT+mhJjaPiIghHzVkObgcnpkhB74SrEaebTbeGc17ePaFUH7yBNA5Zg?=
 =?us-ascii?Q?GmcgF8IQTa7MngS752tec4ouy/Ef0r+sHSfWX3ykM4LP3V9VzL7PmBZUEAp2?=
 =?us-ascii?Q?bpyhjaoNzpcXQQsQKKnNWMmoxJn2G2FA8xZKm/S3CaR6TeXN4QgzG6smG1a4?=
 =?us-ascii?Q?VivWLHfou+lC+jyJPuR+Fm5OVHLrt9R7YYrOfsupcokoCdq47E8qgXUcn3GY?=
 =?us-ascii?Q?MyAklR2uI5ns2Mqo3fIKsa1MPR0HmGgH6+yeqwmaOEj17GoUoJhM2VTSNFIm?=
 =?us-ascii?Q?4TLiUAC3bZo/PqJ/lZ23ull5uqS9N8YbtZJmCdSbtlhwOAXQoyF+z7h43tY0?=
 =?us-ascii?Q?nWr5sV1YF5r4o4z27Mwaq5LxAhOHEsfQbPWFqNAAq9Ym2JgPJ2gAThARNp2N?=
 =?us-ascii?Q?WbUSjKIs5CdqCtHs8aivN1Beuz3XqNJr62L0TytLBDweJ4QC7NgwQVKP8Cof?=
 =?us-ascii?Q?AGg8Ytzn/ITwDrFN4SU96L9uMJxZnKNLvHvC6Oc2XjqLeiBjH3Hwmv6AGvUg?=
 =?us-ascii?Q?NJmDC6pta1CA+RY1q5AqruX9tTVRo7Lg+8E30o3U7JQglQEeBoMoG+exjfcU?=
 =?us-ascii?Q?Ou7PAoQ4gzJ0XGFDhZq1tBCkdCIH/XqSTvACWlOBY/ROfRWWNVLDHZJD8hR3?=
 =?us-ascii?Q?9y21gB4cB+fE2wR6RRA8idLeb4NWsoSJIEIMwYlLuVFpNDQMH9BkOEQmzPSL?=
 =?us-ascii?Q?7ufooViAsm+gEucOq3aX96ZwgTuFqWGnfERcqNsQdpdGPT0NUy78atwnJkuM?=
 =?us-ascii?Q?tCcMvKNzA/IekbxuSxHaW6j3xFiI/+aZ1y8m/kh8TeBQu+g4TLBmTxf/Yav9?=
 =?us-ascii?Q?hactbc3PwRwnAVhzwJEjF9RzaUePWxwHQx2khqgeHfd8+P6klJSePImdTFGU?=
 =?us-ascii?Q?9byrW4mwxtHo8Autrf5Gg7vswl736w5xcRHM1IoCBpJj1+ON7iJQQ9eVG660?=
 =?us-ascii?Q?615E3TqDviqddWjBuF+4W4KQDkcwj3M=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760afa2e-694d-4cbb-fed4-08de59a289b1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:39:36.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fwbNXdr7qvZU54kre/xhSxMscu4gk5NXKgRRl2yDKvCVwA6L8aiMnzQ1TZfIFOZEIwf9qDrzEeOi4MEf8WS1LbokmufemElqQTFWrGNbNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7744

Run the EVL test suite for some first smoke tests.

EVL_TESTS_SKIP_PATTERN allows to exclude tests in the test suite. At
the moment this is used to disable scheduling quota tests that fail on
virtual targets.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/gitlab-ci-base.yml | 5 +----
 ci/xenomai_4_next.yml | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 186d1cb..76e38e6 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -107,8 +107,6 @@ default:
         - report.xml
     expire_in: 1 week
   rules:
-    - if: '$XENOMAI_VERSION == "4-next"'
-      when: never
     - if: '$LAVA_TESTS_ENABLED == "true"'
 
 .test-qemu:
@@ -116,9 +114,8 @@ default:
   variables:
     ADDITIONAL_XENO_TEST_ARGS: "--vm"
     ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
+    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun"
   rules:
-    - if: '$XENOMAI_VERSION == "4-next"'
-      when: never
     - if: '$LAVA_TESTS_ENABLED != "true"'
       when: never
     - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 30ca9b1..03dc233 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -20,3 +20,4 @@ variables:
   KERNEL_VERSION_WITH_QEMU: "6.12"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   CACHE_KERNEL: evl
+  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
-- 
2.43.0

