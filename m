Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1DA388E68
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079339; cv=fail; b=fUxBMicjG7lb0CHW0LdKwr57NUs+OTrOtyL+xxNf33OJKfB6vPtPfRLd/oMCu8Fo8uQfN6M4NPQdRZP8vzv4n11n7PZ81HrXZjer2+129+1F9obY7Cctm/nF/0+EDfI5h2HPjVjIU6PqOHU0fEIeSXx51tSaNwcC6Pe6NC+rJ+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079339; c=relaxed/simple;
	bh=Jxp4N6LRTkHtXRAy33ApkS5GD3opANMjk3jmC3xnY6g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V2IfV5/liFqD9oarZxCnzPYfz9zB0D39aUwG5Eax6eLITXqMLZXDssT28UlPQ0HFlnUbIqwagk6/oLAhpN7tvawA20UznyI4HewGNoy9Y+aOU0B0V7f8cYOvBM4u6+BxQ0KSk6VRkPt1KlPIB/tXKjSdJTLqo19c2xJT+m3lUow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Mh1gX3/y; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Mh1gX3/y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEUP6ivYM4cmmX6uJGiRQ1eznlj3j4TZjc1afO/Wr6fGBCCuFYkpRxjwcuhKeMf8CR62r2b8BVMIhe2cjsrs4NAHNWAGup2QVIcAKtmoH8ItDZlX2QOWEVJCgPQJRrW88m43asOnxCodstUuRFgQqlZ8dyparefvYK57tONtGJHkgSKRhA1UUeQDXtPFPp48DdJ1N9ucEMiuODi+TTUTvAcWre/64mfTv4IRg0IpSWWE8wo8a9S7AlQTNFUxBW+xBwyDACAV9plclbwJa70d6ueNPUQFcn2LQVA1vyXSoTod8ZQOBwB+YtFG4aXr43VsGkFWtZp8Ql7Vz5+ASaNFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biqJejKutnMiV1t/YzjFF5jUFsPEELiUatsfp/hnoMU=;
 b=FDne+vXeF8Q/qpRrANF5k80jWXIf6z+JeM7ofrXT/4dMKyUtWuV5HRSGLBGivZIz8PsQ7fJUaGxqZoNZ7JAMulphmgQPNpKaOdbmbt6QqlXNwTbsYRlzfQKYd0WEC3/zG85YPE3EzZJtCG903kUVK/jrlaN1evwAOXtOwUEV6vs7hgSXkZofpqMH0dav+z6mkFjuYVO2CGQGhdPQ/qeJjiITgTNCx8FPzyX+Gg/JK7+xDhBxngkUYD/U8HuU4P9I0PPXqRwdv98cjQ5SdkG+pLI0F2v6fOCZceqh6+4OXXWNl4nlzCi6V0HFTUB2jcboEggOQTgPhH6UHnCOJMxzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biqJejKutnMiV1t/YzjFF5jUFsPEELiUatsfp/hnoMU=;
 b=Mh1gX3/yGr2XdXZ8UOFJgvXwiExFfvEwir9TaOOCLHFFhznrgaR5H5OzDIwdBzPTBUEccuEc+EvLKFJOOeFkE/mk+8k1pA01sQKIulafAPOHyqG6K6lKDDuxpbeeOWSkhqJ8RRxta9ff8MSaJOb016C0KalHUDKJIcNQ/BcEqSVrAehuGXWG0D6acG46ALZLKgrl3ccRVNya1BD/RLqOXs/jtwW0G242GwIBRmobbPziNKz9uIhl747Up8i3laxDjT+7xnihd+DrHI3GGi0HpkOmKonvBbZm/XZUZwzXXJ1VOqOKmNCPq4BCx1pCc8uYSrQMKmFKZ/fnCkXP/7pdHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU4PR10MB8559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 11:48:55 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 11:48:55 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] ci: do not skip tests on vm that have been relaxed
Date: Fri,  3 Jul 2026 13:48:46 +0200
Message-ID: <20260703114846.24710-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU4PR10MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 81153a1c-c9fd-4727-b94c-08ded8f90f42
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|23010399003|18002099003|56012099006|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info:
	uX/h2o4Z41iIcl6Cq9y0a0PoZ96dxDmdKtaMG1Gf+tdF6acrLFzrrycxsAb+xTsC02Ccy+PClbcEKZcD2k2t1YoaUrv22kIfIXtBDItTzGHh7gLuLczqj4UDUh3Nq6CcnkH7/dJUWJGHO5IMDaGe1fbWKbo+5SOTp3ULMStgliUj8IvyGYFweAkR/b96+MbQtQS8INjQxShXNrt3UIniqPZmCHK+lBtBaRLG0iycGWLllvHTTF2sJxsXGkpHg8CeaLUdZXzzhxID46W0Y/sDFyoiJPtlaOKvIQ3NjD1AfT0tIWJr2eKShZfNRws06fU8FV63Y0j5LuHMcawaexOeizlQjCLY03v3yaE2356WGMrO3bOtxnYTBfQC+JOTiIDIFkEJPJ9FlFISFa9azi1AhqZT6YA/jyy6Ck9AA9jBur6MXMic4AkswJOe8Q/9kuOHhbLpKnN9jFyr7IZ+zybh2JoYkpP/4CjKrkLpcHdICb0FZJf04slQSWir8Uuuuf3cI5juhlAuIM97U1guHSvFqexDhhjA7jA10lglz6NlbAks+KTTVv9gxoWKXKnQSzbEEi1JnVZJ72624Qqu/+2Ppmc5PcA5GBHLtN7a6p/mT77IkV3eHF+dbm9MqeXgcFiAzrrjmAqjaRkHWYcdsCQP1y5wz8iAMZL7hfHtkQoyXYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(23010399003)(18002099003)(56012099006)(11063799006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gl2qYjchzgi9nwJD3/hdMwZmbzPf82gZb+NrVhKrMXHMH16X2hXtBivKg4ES?=
 =?us-ascii?Q?7sgVY1v0w/tmJHWv90FF22d5wZ42ciIBabzaw17EvHHlLupthdrhWgtUje66?=
 =?us-ascii?Q?JZ/e83cz58AMOlDWZx7ISFYZwAIBhjnQ7ioFI8zhDHuZQtn5BANDG3I3FYS2?=
 =?us-ascii?Q?lMf0NJJDETSb5RjGRqhSb0wqGpCaRM8DEQCVZ875NCYIqXflKtiRsB72k/Wa?=
 =?us-ascii?Q?nPI3X6lWZOwmspFbfaSUg34+835izppLTvmClAThIOgfOGwYpfuOTRIutzxC?=
 =?us-ascii?Q?MozBrRj8R/QE+CDen/sGjfSUUotaTpa27LvSWtsb/RFc4vQMz973/nwKSqaw?=
 =?us-ascii?Q?DU947JUgsT4g06I3VGQGo4wJZRGfTpDBeZp6xcCf7I6b5aNWj3I3Nx6+PLaC?=
 =?us-ascii?Q?q4RkFQH2LaK2bfyWiy72aZgS3n+9AYdyMk8Bx72gR2b1Ys7AcHtGs+hCy5+N?=
 =?us-ascii?Q?a31jmITEVyQ1Mq6EftJsIZuX011Wyrm1LQeo1oRuKBVPCVPTOdJDMVHXgFLy?=
 =?us-ascii?Q?8v0qoOibxgrF8V4ATRwi39IZwynlFlVZqj3VS7Wxamuol8BXo+lqPi4/JIyr?=
 =?us-ascii?Q?XCN/zUiugYYR8L+erlkXCEsSwEYfz76Q7tQ2XVf8KfUje//N3ClunyAd3dE1?=
 =?us-ascii?Q?1zYjekRztTdoH+muOAfSEkrBNen1EmfN3aVZgzAwNT7qMprAwvzHEgOxQYw8?=
 =?us-ascii?Q?nOyWDvbdyGYTIX0le/MeSCRYXkXh1PqPpf8Nwpo29kgmpqEnqJhFeW+J1SUE?=
 =?us-ascii?Q?QZge+H+M6qZTJuICnfhmxPioTbk/shbhR/IX3+djHOdPa91DkJkKhHDheSVB?=
 =?us-ascii?Q?QN/Okap+CvVxezTo0q51/2J8cvtARATkFRe1+yRwAVQpGf9KF50RE0zPRQhz?=
 =?us-ascii?Q?bFDUEbmANBXS2801/05/MO/7nh5YNA/9CPLfz/w9HYOurOMnau+PH/wF+2jd?=
 =?us-ascii?Q?bk9OeTsryxauzfrVKDVSiARxAaHt9OWf3nYuwBPBNv3jvE/l4GkoK9j6f/2m?=
 =?us-ascii?Q?jxC0PrqBTRZ0l7HtfwTKZVmMT4BJBsVr1KCsEp5mN14+pIyMavc1sKunZp7s?=
 =?us-ascii?Q?EnP1FMD+6kYTIwGsHKjGIcutS2gQNQGFMPsxCvdk3jvFS7RgakpDeNy0ZaFm?=
 =?us-ascii?Q?yDPSUbg/vTKkezuNgzORCwTxEZLU9098PpRVVrKcSYzEnA0OblvPSnNHk0ww?=
 =?us-ascii?Q?zcEG1uB23Wkt9Fg7GD0GFGiA2VtqDwYLM8KLf+qc/NOMfIcjqEH9+Xh8s7JI?=
 =?us-ascii?Q?wrMsI5nvFWrQ4KSQ2ITfU4liAIw44iOR91ZyUU/I5L5aWwrRJRzawhkQxXHf?=
 =?us-ascii?Q?ny5ynLwuArY+sGRw4qsdJ9UI+uS1AvFvyCiVL0OEnoaNqWNNr84WyCJimATU?=
 =?us-ascii?Q?VdPxppBgljksJY5bkLX5OWEfr4FXXAufccBouJ3oP0PHks2cJV/WQ7DUAai1?=
 =?us-ascii?Q?LvBArC/10lpvCH8k9HeHiNfFjke7GcJB+kZdBvrAddNb2LSkJNSghOn0YXTC?=
 =?us-ascii?Q?REPv+1efrcbj6O1aUoJWzZpP4MK9u0TKtgMt+eICk0laQCP9ASLGjBL5qDjb?=
 =?us-ascii?Q?iFdznsuG4G6BUjSx9VfgmDHnA1h9OMW7aCO/QNjAK/gRWjXJxUu/MHG4SWGW?=
 =?us-ascii?Q?0TrAX6IolJl5GUr/5uabL/9bJ/fuiv0kDWQrF6zz2kMJ54kK+TUzZuk8Tb8R?=
 =?us-ascii?Q?Ub6tltD+GZzI1o6N011ErvFVcuC9NW8rp2kAy8mTx9vcfVe6sD8hKCb/gp86?=
 =?us-ascii?Q?RJE1DtI9cLTI2cRALzfTRkD0yCeZmJLWPB8gXSg2d+uPWRFhTfmB1jKgQ5VQ?=
X-MS-Exchange-AntiSpam-MessageData-1: vSp0GMcqVzRLbIARYv7RQS7An0eJ2cAvIS4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81153a1c-c9fd-4727-b94c-08ded8f90f42
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:48:55.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gY0L2RQnf5gstSbQOfvz+8BqjCRReSOSNz3lDFIdxcYeWeKuS9wsIGf8srEpMWv3pMe/VthsOBf5dJa72q1TymmNqS4KL4Awk9rMI5O52m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8559

Remove the broad skip list previously used for tests that fail on QEMU
targets. The list is not needed anymore as the evl test suite autodetects
if it is running in a VM and relaxes the tests as needed.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/lib/gitlab-ci-base.yml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
index dfb33ad..0540628 100644
--- a/ci/lib/gitlab-ci-base.yml
+++ b/ci/lib/gitlab-ci-base.yml
@@ -123,7 +123,6 @@ default:
   variables:
     ADDITIONAL_XENO_TEST_ARGS: "--vm"
     ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
-    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun|monitor-event-untrack"
   rules:
     - *test-qemu-rules
 
@@ -174,7 +173,7 @@ default:
   extends: .test-qemu
   variables:
     TARGET: qemu-riscv64
-    EVL_TESTS_SKIP_PATTERN: "ptrace-sync|sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun|monitor-event-untrack"
+    EVL_TESTS_SKIP_PATTERN: "ptrace-sync"
   rules:
     - if: '$XENOMAI_VERSION != "4-next"'
       when: never
-- 
2.43.0

