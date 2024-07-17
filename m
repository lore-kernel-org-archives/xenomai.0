Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3F12E75
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240795; cv=fail; b=pjmwJs4Ex71qZ/PYljfaVlEknwDWO6cR12Up0WVEg/3uW0g4XbADifauuhEGUJSTe/MhuLrPnQXSKRxHEsEOuf5CAYNkZZxgxNHOu9ZC2IRmpUw6WxBA6Cu/ueVsK8mbNnM9HEgwdgseJreWAZ/vuCifFWZdh49hLApwFUz5V08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240795; c=relaxed/simple;
	bh=Qsp5NbRSRQM9biMrgvk/cXY+CtRomtm1iXbr+tq3yw0=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=OBCNWFknDKbmcnnsrstuEsplJtsQsIt4KAIooR7ijH8J6XoFvdoCv5ZXNjHDeqjt4+990fB37Tv5zCI+EkbSUu0E6uyvdP5UbZjIOf0a6w+SS3x++pk9LfWU5aKP2cHcX8Ic9ZVA8ABfv0WZfp7YHk1CcgbDCu5Zii5dAuXSzBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gzIjevIc; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gzIjevIc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xrdas/Lhk0kG/sRqLCJE2yEOSWv7Opf+isaIGUWVnceUnvrKm4tMwBWiEfuqLX2E6c0/Iw2vTqZbtshDep3teWJwzn8wGyRVtVx9khvJptiyeRLYUHGqYI3IsA72pawyD2mcIrtcJWmmx2FPry7nXW5WgJzt9r2tAvqm+kKQmRXRA9/NSV0GXTJw9+k8VMDcVJXtliLqp8qyxJHj0CcKkl3OYxgJCcPmA70iJpIGHHrSWMBddotzT0S3mRENAdK9ooyBr6/2Db2Y161LydoGwBTIT6/X/7k0cf03+w2N8edjUjkLLutju13rR77vdTUr4+L6sPTx5LErxhMICQyzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmEH6lGnSdxVJvYlLJF9vNfPpoD9Ei40fuqhx8BekJ0=;
 b=fbtAt0u89BaoACczbcI88//knH8e1zLc4yhcw+xK63n1QpG3akIIu8FSFsXOES8ZLVGMiHG7NYCG7Mv32WX1PRPCyGLe/zRPkSZcXECUyi0CQ09yVyCBfrIF3xnM5LJv2s/zdoCW2dDTAFP3El3xpCWBdElg/vwIXdrg5qZAp4ijqNs6h7J2QPdgci1euPcOJEaNhmPABbpQdr/5fl+KN8lzTy/j1Gnn6sVtz/whm8Tel7xnY8RZTg9sfEI/y8rVwCDsSU6eal3rf6CY4HiJc4i9/t8O5hBXbHh/NLLvqzGu2ZAqLtBix1WVPuy/UF2nJHijuGwl3sGXfokSnahL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmEH6lGnSdxVJvYlLJF9vNfPpoD9Ei40fuqhx8BekJ0=;
 b=gzIjevIcMQC/5hd8h23926tcdYnd4gBQfr0yrxNqQarsE8+pdSEOxlW99V14QhoeJIlwUALh/yLiRMDBMxAipNOdVa5F9cSa/WTYNVqbNfqBV0TBvTMploi0JQNlu6xXPt+bej925MfEtfQmiilCkz+oIl0xrJuqAcuUZblkESjwxp8j0sfHvCqCeB2e8hnn79rLepXs/EhedJLilFWqVS0298wxf+yBj6Q+7NzitVo5C6qIo2ENRSlIPn9PjV/2Av91YnPTaK7NOYIHAoO8AAgERvXmO2vUFwakKYCHP+KPWbns7vEZdLMVL2BLKBH/X1XAMOr3VBHM5QOysBhWog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 18:26:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 18:26:27 +0000
Message-ID: <0c22e55e-a28b-45aa-a614-82f4fa938d68@siemens.com>
Date: Wed, 17 Jul 2024 20:26:25 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Update to kas 4.4
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a91695-e594-4041-370d-08dca68df89e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVBnYThlaHpGZktjSmdzYk9zalU0RXRoL01FeTIxL3ZKZVVEY3FFcytOYVZT?=
 =?utf-8?B?UWNaRWs0TnBTdVlCeWM0bE1Ob2w3WXd1eG90bVRFUVFoU3FsakI5M0Zjdnp4?=
 =?utf-8?B?ekNvSVR0TG9mYXlWdndYRW1ZcVpnQ1FuZzZ3YSs2RDRkdzhJMlprbk1pSENR?=
 =?utf-8?B?Y2FORHl0TS9Ea2lOSzdweGpGZHM1WHdEV3ZFaU5sdWRXTEpHYUdqNXRkN0JX?=
 =?utf-8?B?SlcxdUN3bStwaVBKSFlOZXZrWEhTTEtxTVk3UTFVWGdodk81MWhGT2NaZ04y?=
 =?utf-8?B?RG9OQXRUSXRwQ1ovc2lkK2UwYVpKeWJHK1hPSTdHeWdqc0NZUVZrS1F1cXJj?=
 =?utf-8?B?Mk1CZFNyQUt4NWxKZWlFZFhRUmZ0NW1DcnJrYkc5WFRBRUpFaFlucDd6VkhP?=
 =?utf-8?B?dy92TlV0UUlYb0d5c0FDbUIzYXB1VVVPRCsvUmJwVllMbWo4dnlRN24rZlA3?=
 =?utf-8?B?VGUzZGkweGxRbTdta1I1VXl1Mks1VkhPQ1BscDNrYkpIOVpxV1A0QTF4WVBs?=
 =?utf-8?B?U1graVh2bzc0bXlGeEVWWjdsaXpJNGJ3aEU5MndwUWRhQnZmZUtUSnhMSi8y?=
 =?utf-8?B?WFhzV21xK3ozRnBUb0xSNGgwTjRqcXVzTWRJWG9GWVAxbFZ2Q3I1anA4YU4r?=
 =?utf-8?B?cG1ta0hRMDJuTWpucmRnZDFEanJ1UUREUFhocTZadjlCay9PaVFvRTBtRFRQ?=
 =?utf-8?B?ZFlySkxuOXIwVXVNTkg1TjhRcjBVN29wV2ViUnBPNHJ6NitDb01GZXVtZTRr?=
 =?utf-8?B?NE1ETnUvTk4zQ2JQMXFndVFheVVVOCtJeDJyalRpOGlXemZVb2Mwdk0vdXNT?=
 =?utf-8?B?TDVYMU9aaHdSTDN3bUVRSTR5eFZIWkRhejk1MUpGVm8zVFJlN2RST0NUaVg5?=
 =?utf-8?B?UWhXQ1YxbUd5ZGhUOGVyWEE4T21rV3VqL2taR3hxeElwcHl3WXQ0TGtHaWdI?=
 =?utf-8?B?YkNnV2NQN3BxVWhYZ3lnVjRiOU14RmNTaDFLT3F6TjR3cDU4L2dVajR5eEsx?=
 =?utf-8?B?NWlDY1BVK0NkOVFYMklJWjA2LzRQNkV3ZThTMjlRNlQ3VXVRb1lRTDFGWjNC?=
 =?utf-8?B?dnhnMUkxbnZpMVNpdVh4WDlKTW5HclMxNnhUdkpCdXNWaFMvRmJJeEtpTWxX?=
 =?utf-8?B?S2hYb3ZqMUdVV3pHNWhraVJuUE05K0x4cm5jRTFWbk1jUHNtY0QxVTZrZmYv?=
 =?utf-8?B?UlpZcmhBcWdjVHJaVGtoYnpNYXVXNXE4TUxjaFRVU3BlbTJIczNneU9tM0da?=
 =?utf-8?B?T0s3cFc2QUVaZHl6STBFRmZtOHU5YndZL1duRUdOZlRDYkNJdEhFUlNtRnlX?=
 =?utf-8?B?d2ExUVViRitJMTJia2pqZ3Q5NjVtVHNKWWhaOTlQQnRjMW9XOFFzaStrK0Ji?=
 =?utf-8?B?czJRYVpzT2VPQkpiR282cUw2RS8wKy9vaFdGNVFrb1lrVkFPM1hvalVwR0tn?=
 =?utf-8?B?dEZnd1FPNWNyV1B3cE1ycmVndVVxOUxJK2JGdndJRVBvY1Y0MWJhYjlWdjA4?=
 =?utf-8?B?RmRkZjM1NjVGOVBpM3dQQlEvZGJ6SnNjbU93TGVWMFlXckJxSmxmbzhhbTln?=
 =?utf-8?B?bWtja0VQMHRhczJzNHhkMkxIY0U4VjVMb2F1R1hBemxPcXNJM25Dc251anpi?=
 =?utf-8?B?V09zYnJaVGcvcjZFVEZsMHFaSGVCZlJPaldPZk1GZHNRTkFmN0dyV1B0UStR?=
 =?utf-8?B?dm9FMURYVC91eGpIK1hmSXR0RDZVZXdGQmg1ZzJjS0wxRXRxWUhTRStMaGkr?=
 =?utf-8?Q?JBq0Xu+WtlZ6FH5ePA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWJubERpMjU1NnYrZGYyeU5WejZqZVNXQ3p3N1RJZzJpVVRhWVdwN09FVVdh?=
 =?utf-8?B?UThMWjhOZmJJMmFIUkF0WEgxZ1RhTFduZVVlWXhvaXBDVEJqQk1mdnBpTjBH?=
 =?utf-8?B?TitPSTJ3NGJIQlBSYW5zSlVyalRqY3pNQ0FPUkxIWnIyQTdONmpQY2VXSS85?=
 =?utf-8?B?ZjJJQmIyakZZUFA1ZitqUDk2VWROK0ZmNmxtTnlZS3FLRVp1ZHUyMWhtLzh2?=
 =?utf-8?B?T3dUbmZ6bUFPakVQRjJPYzEyZmdlYTd5a3lINVhhdHJTY0VORm9zenF6MUhP?=
 =?utf-8?B?ZjlJUlRhem1IdTFjNzFlaHllY0hxTnlCQ2VpYVh3K0cyUVZ5QU1BZ3dJbzdn?=
 =?utf-8?B?eEg2ODZ1eHJvVktIbjdDVE5RNG5qaDk5M1pQUjVBUXg5SEswaXcwdllZUW04?=
 =?utf-8?B?WmhvaHVYUmFIcUlkeldnUDk2a3ZBWUdWQU1sQ3NXMFBhZFRyVS9PblRvbjhP?=
 =?utf-8?B?OHZpSFJReWVYeE9JeVFyWmZ6aE96VE9CSVFVejZRRDlXQUlLdGd3SmJsbnIw?=
 =?utf-8?B?L0lrbFFoYU11MjNzUFFia2VPeUJaVTJ4NUhYVXhtSDRXcFlLejhHeEl4RmpM?=
 =?utf-8?B?OXJ2NXZDc1FWZFRBL01RM3BGZVpjTlZ5RUxkZE9YeURYWmZ2cEVxSGRRS3lB?=
 =?utf-8?B?bk5JdjlkSjk2MXlCbGlFQWZQdTZaQ0Ztd0JqSXlrM1dTMVYzWGhZUVdxZ0x3?=
 =?utf-8?B?WFRpemFnUklQSkplZkhVSy9MQTJSc3JPYnBvMTBoNTN2aXdRVklJY3lYZWx4?=
 =?utf-8?B?a25KaHdqUFVwZDI0a00yeXQyMFVlMlZSUUpYemxDSWpYLzJKREtOSFJ4Z1Nt?=
 =?utf-8?B?Q2kxOTFWMHE5MVpyckdpelduLzZHN3k1SGxXQm85RjhxazdsclZtQ2hVam94?=
 =?utf-8?B?blNYeGVmc2xjaTJKekdpbG5TOUs5cVE0Y25BM28wNUpvRVhhVzZhMGx3bVdh?=
 =?utf-8?B?WXBGcWpWWDRyM29saUYxQjlhdGR1NEQvdWdXT1I0M2FyWkRFVGlTM2JsaU9N?=
 =?utf-8?B?NTlSNUJVcmxNZUlVbm5kZVpsa2srL0JoK2VUQnp3MnJrdVl0NTdDSDFrSzdi?=
 =?utf-8?B?d1BieVhhY2pFMFErNTZGTERuejFwRUc0cWM1VjJBRGxoQ0pQaDlNMmZNYnhR?=
 =?utf-8?B?MnZ0MStZc0lFTEN2RjBwdy84RndZQ3J3MndyR2hjaDEzbjRxdXNZSlFoY0xQ?=
 =?utf-8?B?b0FQT3ZiK0xqTVZQeWk4b25LVXpkQUtOSDFsZnFXZjlDSVhmNUZIcitwbWhh?=
 =?utf-8?B?Mi9jdmRGK2xGT0M2ZUIwakhUcnhQZGRZWHVEbGxGN09EQ0tKWks3QUt6ZnBh?=
 =?utf-8?B?WUozdUF1UmdyVGVQMlpUMHpveEFyMU5VM1YxeGEyNThNckhaa0MzQmtTelVr?=
 =?utf-8?B?VVNvenhkVVNMNGJYUmZYcXREUThhU1dNdU1XTmdEeGdFdUpCYUFMOWc2OGZ4?=
 =?utf-8?B?bnN3Y1p4RFMyQjVuYStmQk53aU13cFZIV2ZDMmN2TWUwWGl3cWhoRlJEOWhD?=
 =?utf-8?B?RHVMQTJNY3JRK2VYdlcxUlV1WHZiTVlCRkpZbERqaDVKQ3ZReU1zZjRWT0pP?=
 =?utf-8?B?bE5pTjlYU2FpVmoyRTF4UXFUWEpsWUpadDJVL1dUM1pNR3NvempoTFFxaW9j?=
 =?utf-8?B?Qy9vUjJ2QjJqaU9ySFdSTGJzYWJMazVHSUptV0tvU3ZjSWQ1bHZSN3lndlQv?=
 =?utf-8?B?azVzai9vTnpjc00rUGpyeW1ZM1VXOEs4cDB2Q1QwQ2FMOVZlOEY3Mk5kOEll?=
 =?utf-8?B?YWg1OW1WV3FVUGxRVW1vQjFwVmV4Y0drVXpteHVPS1E1R2hkUFhLZHcvZUpF?=
 =?utf-8?B?N0FZaXlvR3A2WWc4NU51c2ZVbGhheUFWandmNUpjZzZkdTJsLzkvUHF2TFdL?=
 =?utf-8?B?QUdEWjBlV2p3dGhCYWVoVjdQVDFuUlpXa3p0ajdsQm1wU3Mwakd0MGpTaEpr?=
 =?utf-8?B?d01zQzdCVmJtRWh5eUZkN1JpbVJwaXF3anBGeC96ZG1YNkQvSFpuNUtwNEly?=
 =?utf-8?B?T05YcmZUT01vYldta0x0T3pQWmNCcU0rc2dUdDZSV0dicCs1SC9NQm5QZ3pk?=
 =?utf-8?B?NVd5N0xHa2h2R2pYRG5LRzF4ZFc4TExKdWJ3aE5jaDgzWjdLaStqRWtJOWNM?=
 =?utf-8?Q?KQewwfHhc8oTQHY6pTXpGHjxE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a91695-e594-4041-370d-08dca68df89e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 18:26:27.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBF4za7U8cc/fCgqF3tf7QJjBKuAqwkE4XMSm+qfEUoB7KKooDDgvDzN6PM4rPMN5bcEbT8mb58gqHDB8E21hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8640

From: Jan Kiszka <jan.kiszka@siemens.com>

Housekeeping, no major impact for us.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml |   2 +-
 kas-container         | 136 ++++++++++++++++++++++++++----------------
 2 files changed, 87 insertions(+), 51 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index bc9d525..1dc05a8 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -26,7 +26,7 @@ variables:
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:4.0
+  image: ghcr.io/siemens/kas/kas-isar:4.4
 
 .common-config:
   before_script:
diff --git a/kas-container b/kas-container
index 8fa2d16..169ea1b 100755
--- a/kas-container
+++ b/kas-container
@@ -2,7 +2,7 @@
 #
 # kas - setup tool for bitbake based projects
 #
-# Copyright (c) Siemens AG, 2018-2022
+# Copyright (c) Siemens AG, 2018-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -27,13 +27,19 @@
 
 set -e
 
+KAS_IMAGE_VERSION_DEFAULT="4.4"
+KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
+KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
+KAS_CONTAINER_SELF_NAME="$(basename "$0")"
+
 usage()
 {
-	printf "%b" "Usage: $0 [OPTIONS] { build | shell } [KASOPTIONS] [KASFILE]\n"
-	printf "%b" "       $0 [OPTIONS] { checkout | dump } [KASOPTIONS] [KASFILE]\n"
-	printf "%b" "       $0 [OPTIONS] for-all-repos [KASOPTIONS] [KASFILE] COMMAND\n"
-	printf "%b" "       $0 [OPTIONS] { clean | cleansstate | cleanall}\n"
-	printf "%b" "       $0 [OPTIONS] menu [KCONFIG]\n"
+	SELF="${KAS_CONTAINER_SELF_NAME}"
+	printf "%b" "Usage: ${SELF} [OPTIONS] { build | shell } [KASOPTIONS] [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] { checkout | dump } [KASOPTIONS] [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] for-all-repos [KASOPTIONS] [KASFILE] COMMAND\n"
+	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall} [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] menu [KCONFIG]\n"
 	printf "%b" "\nPositional arguments:\n"
 	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
 	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
@@ -80,6 +86,15 @@ usage()
 	exit 1
 }
 
+fatal_error(){
+	echo "${KAS_CONTAINER_SELF_NAME}: Error: $*" >&2
+	exit 1
+}
+
+warning(){
+	echo "${KAS_CONTAINER_SELF_NAME}: Warning: $*" >&2
+}
+
 trace()
 {
 	[ -n "${KAS_VERBOSE}" ] && echo "+ $*" >&2
@@ -113,7 +128,6 @@ enable_oe_mode() {
 
 run_clean() {
 	if [ -n "${KAS_ISAR_ARGS}" ]; then
-		set_container_image_var
 		# SC2086: Double quote to prevent globbing and word splitting.
 		# shellcheck disable=2086
 		trace ${KAS_CONTAINER_COMMAND} run -v "${KAS_BUILD_DIR}":/build:rw \
@@ -135,10 +149,6 @@ run_clean() {
 	fi
 }
 
-KAS_IMAGE_VERSION_DEFAULT="4.0"
-KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
-KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
-
 set_container_image_var() {
 	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
@@ -168,14 +178,12 @@ if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
 			;;
 		*)
 			# The docker command is an unknown engine
-			echo "$0: docker command found, but unknown engine detected" >&2
-			exit 1
+			fatal_error "docker command found, but unknown engine detected"
 		esac
 	elif command -v podman >/dev/null; then
 		KAS_CONTAINER_ENGINE=podman
 	else
-		echo "$0: no container engine found, need docker or podman" >&2
-		exit 1
+		fatal_error "no container engine found, need docker or podman"
 	fi
 fi
 
@@ -190,8 +198,7 @@ podman)
 	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt label=disable"
 	;;
 *)
-	echo "$0: unknown container engine '${KAS_CONTAINER_ENGINE}'" >&2
-	exit 1
+	fatal_error "unknown container engine '${KAS_CONTAINER_ENGINE}'"
 	;;
 esac
 
@@ -205,8 +212,7 @@ while [ $# -gt 0 ]; do
 	--with-loop-dev)
 		if ! KAS_LOOP_DEV=$(/sbin/losetup -f 2>/dev/null); then
 			if [ "$(id -u)" -eq 0 ]; then
-				echo "Error: loop device not available!"
-				exit 1
+				fatal_error "loop device not available!"
 			fi
 			sudo_command="/sbin/losetup -f"
 			sudo_message="[sudo] enter password to setup loop"
@@ -216,10 +222,9 @@ while [ $# -gt 0 ]; do
 			# shellcheck disable=2086
 			if ! KAS_LOOP_DEV=$(sudo -p "$sudo_message" $sudo_command \
 				2>/dev/null); then
-				echo "Error: loop device setup unsuccessful!"
-				echo "try calling '$sudo_command' with root" \
-					"permissions manually."
-				exit 1
+				fatal_error "loop device setup unsuccessful!" \
+				            "try calling '$sudo_command' with root" \
+				            "permissions manually."
 			fi
 		fi
 		KAS_WITH_LOOP_DEV="--device ${KAS_LOOP_DEV}"
@@ -236,6 +241,9 @@ while [ $# -gt 0 ]; do
 		shift 2
 		;;
 	--ssh-agent)
+		if [ -z "${SSH_AUTH_SOCK}" ]; then
+			fatal_error "no SSH agent running"
+		fi
 		KAS_SSH_AUTH_SOCK=$(readlink -fv "$SSH_AUTH_SOCK")
 		shift 1
 		;;
@@ -274,16 +282,16 @@ while [ $# -gt 0 ]; do
 		shift 2
 		;;
 	--version)
-		echo "$(basename "$0") $KAS_IMAGE_VERSION_DEFAULT"
+		echo "${KAS_CONTAINER_SELF_NAME} $KAS_IMAGE_VERSION_DEFAULT"
 		exit 0
 		;;
 	--*)
 		usage
 		;;
 	clean|cleansstate|cleanall)
-		[ $# -eq 1 ] || usage
-		run_clean "$1"
-		exit 0
+		KAS_CMD=$1
+		shift 1
+		break
 		;;
 	shell)
 		KAS_REPO_MOUNT_OPT_DEFAULT="rw"
@@ -322,15 +330,21 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 	case "$1" in
 	--skip|--target|--task)
 		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
-		shift 2
+		shift 1
+		shift 1 || KAS_OPTIONS="--help"
 		;;
 	-c|--cmd|--command)
 		KAS_BITBAKE_C_OPTION_ARGS="$2"
-		shift 2
+		shift 1
+		shift 1 || KAS_OPTIONS="--help"
 		;;
 	-E|--preserve-env)
-		echo "$1 is not supported with kas-container"
-		exit 1
+		fatal_error "$1 is not supported with ${KAS_CONTAINER_SELF_NAME}"
+		;;
+	--provenance)
+		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
+		shift 1
+		shift 1 || KAS_OPTIONS="--help"
 		;;
 	--)
 		KAS_EXTRA_BITBAKE_ARGS=$#
@@ -345,8 +359,7 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 		# shellcheck disable=2086
 		for FILE in $(IFS=':'; echo $1); do
 			if ! KAS_REAL_FILE="$(realpath -qe "$FILE")"; then
-				echo "Error: configuration file '${FILE}' not found"
-				exit 1
+				fatal_error "configuration file '${FILE}' not found"
 			fi
 			if [ -z "${KAS_FILES}" ]; then
 				KAS_FIRST_FILE="${KAS_REAL_FILE}"
@@ -395,7 +408,7 @@ if [ "${KAS_CMD}" = "menu" ]; then
 		set -- "$@" -e _KAS_REPO_DIR_HOST="$(readlink -fv "${KAS_REPO_DIR}")"
 	fi
 
-	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < ${KAS_FIRST_FILE} | \
+	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILE}" | \
 		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
 		    -e 's/\f\([[:alpha:]].*\|$\)//' \
 		    -e 's/.*default \"\(.*\)\".*/\1/')
@@ -416,18 +429,24 @@ fi
 
 set_container_image_var
 
+# short circuit for clean* commands. We just need
+# the build-system information, but no repo mounts, etc...
+if echo "${KAS_CMD}" | grep -qe "^clean"; then
+	run_clean "${KAS_CMD}"
+	exit 0
+fi
+
 KAS_REPO_MOUNT_OPT="${KAS_REPO_MOUNT_OPT:-${KAS_REPO_MOUNT_OPT_DEFAULT}}"
 
 KAS_FILES="$(echo "${KAS_FILES}" | sed 's|'"${KAS_REPO_DIR}"'/|/repo/|g')"
 
 if [ "$(id -u)" -eq 0 ] && [ "${KAS_ALLOW_ROOT}" != "yes" ] ; then
-	echo "Error: Running as root - may break certain recipes."
-	echo "Better give a regular user docker access. Set" \
-	     "KAS_ALLOW_ROOT=yes to override."
-	exit 1
+	fatal_error "Running as root - may break certain recipes." \
+	            "Better give a regular user docker access. Set" \
+	            "KAS_ALLOW_ROOT=yes to override."
 fi
 
-set -- "$@" -v "${KAS_REPO_DIR}":/repo:${KAS_REPO_MOUNT_OPT} \
+set -- "$@" -v "${KAS_REPO_DIR}:/repo:${KAS_REPO_MOUNT_OPT}" \
 	-v "${KAS_WORK_DIR}":/work:rw -e KAS_WORK_DIR=/work \
 	-v "${KAS_BUILD_DIR}":/build:rw \
 	--workdir=/repo \
@@ -436,16 +455,14 @@ set -- "$@" -v "${KAS_REPO_DIR}":/repo:${KAS_REPO_MOUNT_OPT} \
 
 if [ -n "${KAS_SSH_DIR}" ] ; then
 	if [ ! -d "${KAS_SSH_DIR}" ]; then
-		echo "Passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
-		exit 1
+		fatal_error "passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
 	fi
 	set -- "$@" -v "$(readlink -fv "${KAS_SSH_DIR}")":/var/kas/userdata/.ssh:ro
 fi
 
 if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
 	if [ ! -S "${KAS_SSH_AUTH_SOCK}" ]; then
-		echo "Passed SSH_AUTH_SOCK '${KAS_SSH_AUTH_SOCK}' is not a socket"
-		exit 1
+		fatal_error "passed SSH_AUTH_SOCK '${KAS_SSH_AUTH_SOCK}' is not a socket"
 	fi
 	set -- "$@" -v "${KAS_SSH_AUTH_SOCK}":/ssh-agent/ssh-auth-sock \
 		-e SSH_AUTH_SOCK=/ssh-agent/ssh-auth-sock
@@ -453,20 +470,27 @@ fi
 
 if [ -n "${KAS_AWS_DIR}" ] ; then
 	if [ ! -d "${KAS_AWS_DIR}" ]; then
-		echo "Passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
-		exit 1
+		fatal_error "passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
 	fi
 	set -- "$@" -v "$(readlink -fv "${KAS_AWS_DIR}")":/var/kas/userdata/.aws:ro \
 		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/config}" \
 		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/var/kas/userdata/.aws/credentials}"
 fi
+if [ -n "${AWS_WEB_IDENTITY_TOKEN_FILE}" ] ; then
+	if [ ! -f "${AWS_WEB_IDENTITY_TOKEN_FILE}" ]; then
+		echo "Passed AWS_WEB_IDENTITY_TOKEN_FILE '${AWS_WEB_IDENTITY_TOKEN_FILE}' is not a directory"
+		exit 1
+	fi
+	set -- "$@" -v "$(readlink -fv "${AWS_WEB_IDENTITY_TOKEN_FILE}")":/var/kas/userdata/.aws/web_identity_token:ro \
+		-e AWS_WEB_IDENTITY_TOKEN_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/web_identity_token}" \
+		-e AWS_ROLE_ARN="${AWS_ROLE_ARN}"
+fi
 
 KAS_GIT_CREDENTIAL_HELPER_DEFAULT=""
 
 if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
 	if [ ! -f "${KAS_GIT_CREDENTIAL_STORE}" ]; then
-		echo "Passed KAS_GIT_CREDENTIAL_STORE '${KAS_GIT_CREDENTIAL_STORE}' is not a file"
-		exit 1
+		fatal_error "passed KAS_GIT_CREDENTIAL_STORE '${KAS_GIT_CREDENTIAL_STORE}' is not a file"
 	fi
 	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/var/kas/userdata/.git-credentials"
 	set -- "$@" -v "$(readlink -fv "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
@@ -483,6 +507,11 @@ if [ -f "${NETRC_FILE}" ]; then
 		-e NETRC_FILE="/var/kas/userdata/.netrc"
 fi
 
+if [ -f "${GITCONFIG_FILE}" ]; then
+	set -- "$@" -v "$(readlink -fv "${GITCONFIG_FILE}")":/var/kas/userdata/.gitconfig:ro \
+		-e GITCONFIG_FILE="/var/kas/userdata/.gitconfig"
+fi
+
 if [ -t 1 ]; then
 	set -- "$@" -t -i
 fi
@@ -500,18 +529,24 @@ if [ -n "${SSTATE_DIR}" ]; then
 		-v "$(readlink -fv "${SSTATE_DIR}")":/sstate:rw \
 		-e SSTATE_DIR=/sstate
 fi
+if [ -n "${SSTATE_MIRRORS}" ]; then
+	if echo "${SSTATE_MIRRORS}" | grep -q "file:///"; then
+		warning "SSTATE_MIRRORS contains a local path." \
+		        "Make sure to make this path available inside the container."
+	fi
+	set -- "$@" -e "SSTATE_MIRRORS=${SSTATE_MIRRORS}"
+fi
 
 if [ -n "${KAS_REPO_REF_DIR}" ]; then
 	if [ ! -d "${KAS_REPO_REF_DIR}" ]; then
-		echo "Passed KAS_REPO_REF_DIR '${KAS_REPO_REF_DIR}' is not a directory"
-		exit 1
+		fatal_error "Passed KAS_REPO_REF_DIR '${KAS_REPO_REF_DIR}' is not a directory"
 	fi
 	set -- "$@" \
 		-v "$(readlink -fv "${KAS_REPO_REF_DIR}")":/repo-ref:rw \
 		-e KAS_REPO_REF_DIR=/repo-ref
 fi
 
-for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK \
+for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \
            KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE \
            GIT_CREDENTIAL_USEHTTPPATH; do
 	if [ -n "$(eval echo \$${var})" ]; then
@@ -559,4 +594,5 @@ while [ $KAS_EXTRA_BITBAKE_ARGS -gt 0 ]; do
 	KAS_EXTRA_BITBAKE_ARGS=$((KAS_EXTRA_BITBAKE_ARGS - 1))
 done
 
+# shellcheck disable=SC2086
 trace ${KAS_CONTAINER_COMMAND} run "$@"
-- 
2.43.0
