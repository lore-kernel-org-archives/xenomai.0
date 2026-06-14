Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306D258EE9
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465822; cv=fail; b=co44y0AAUm41dMOp87gDXZg6Wr0HKWSUasZdieghvYTovPIv6zWjWAqJe4KjQsq56ErZuGMFnLBQHL3u1Werc3aql7TFSGNuipIqdFe6LZMt3kv03GibSHqt5min0MIxwh5p9iYDX0elQP1V1eJarfoaxK6Xl11/Vd4sCQn1+v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465822; c=relaxed/simple;
	bh=43JftdPwkzqEBftOa4mBo3lDtybkG4DETOLh5Jtx+5Q=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=PefFwNUsX0kRbEyyR3EXcBdSY1aRCkyPcsHvnIqSx0BtVbdVhnFqUnorjo5ByPpi2a0sIEhLFwjp1F58D/HEH7prxrBPKwCFfdtSVzVx9fqmUtzchEcAg6khVsGX5K6Bz7ViSquyQHmIt2hZ6vGXfo3N3NwormIRMPtKESM7CC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SorRg41d; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SorRg41d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrX7n9o2TaVKGt4ISHgtdL/kog+SqvwVMMDp2PcRNoIU0gCFf/qko8nUeTq/ls2DOMdd2ArcQaQ55PLty5+4LqKXMbEVpFezWhcxAdpPyqG0/nIEqEDpWjD6J+OqPtPMo5TGyAVOwfD+04oIo6c1q/xsYChpKamHvmbPPLu+JN6+A2nzLQQuPpYmrA7fdllk0UNl9ulgNaLee8KDj3dy/4/hdCxCU6L9FqnsqXK82QUQcAbO51aabGs6TtECTUpQm9ccz21+8QoSpC0wHFH+1Ziw6edLk3FRlVznC8Dufif5IWOClFJXuACJsNV5crdncz1ny+UhyqoYBYTO8tfNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJC06tdSwulHUksaVx/n5tPNdZa4Z9g9M8VfQRYz0gA=;
 b=aEFkrynYwLNyB/zeBsvIS8zEW8nBbGBqgdn2m1Qv64P1brBSnuy4dLTmDFCtJhdn85n0Gm9r2b/CeXThMc7z2L/UNB/twk+PuEdd1pq8UlpP3E6OsoLFk1BdEvRFPDlBKB712w8uu1IOmNYiNJmJNWVB6ThN3IOMFH2ZU7LYMjTvEXpJAff58MBzVURwaCUuM0jwOOHlOExWUDXOf7zbV8l7RqChsMconNM3bIvJv5bLMyCtXZVlqngeyC1bO3d3j2XD4zuuZspdLGlSlMZVmEhTbiokuvxgOAVfoTa3ysMCDcYFfCgiotY4T0v5BI7LjOjDo1soP9U2tOLL2zrpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJC06tdSwulHUksaVx/n5tPNdZa4Z9g9M8VfQRYz0gA=;
 b=SorRg41d5X2d9YP4DmK9F6jJIBzr4XeNUlEC67oI2JOx30tbqhx6+E68mFaTz7zUrNgCs07qw0eVLlBgPT3vPZn2FvFRt9LQJ25ZJocCm0uHCt6rTrjRVNbynYd+1OiP6/cI9stLSrYyw8J7twGbK4IuyHMmiMbNS/HFCRYvACwTHDNRc0Q+eTSf7v3WWArr9ip1yxcObG8Tadz9gSV8TGQvwCfUXCoX1oPqqS/tvQSLRH6yZ2LN99+cKOD6cfmXsJN2lInn1a00RmnIiFf/MF5vtei1+4pT+nv94vf6spXgjSjSKJqx3vukOtB2Qk9HjdIwkLLOOSNuroAAv6jjSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sun, 14 Jun
 2026 19:36:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 19:36:57 +0000
Message-ID: <83bfeeef-c3b2-473e-b94f-8d270b0a512c@siemens.com>
Date: Sun, 14 Jun 2026 21:36:56 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: [libevl][PATCH 1/2] tests: sched-quota-accuracy: Augment workload
 with busy-spinning
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b462eb7-016c-4f91-f0a4-08deca4c4c0d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|55112099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	FVKaH8dD21LR0b0MGTxeushpArS4uJLw7Dtz6P9C34/cyM5KEUSvBl63L1E8UJejJ83AUYMRcF8cjExuZuDdbtyUJAXS+iyFoC8RILhRjl2DJks58PPRFd0VOhQGw4cqNyjL0Ak5EBU4XXUqNMbu06iQDNXrz6OFTn8QqglAXXjpn9HxazjB26VtKyIcjenlsaj7lFNs95TxvVwpmOvh5k7pg5814i0BBzbL6pgsYRyv0ZTZKzJsuttbyJ+umrfscuY5wU9jMlmlvS4YQxN0UVbIXTCaoTanWfHJ6p2WudLakbQ0fq3TTOHfg++r7cEbDP6sLZODt/5GS1Ycyi65uqutUyENvQnlGNSfVU5ykddYU40HAulfn2lwyS0+UZASSE8ukIXtl6jiB9BofEkj8aUlg92Cs5j0aDPtbLk2SHU5RHS2bq+oHstvwbZkWVsGhAzeNeU4sUYt2XZtFLxhIFk+LLeyLepYE5a6KMfL/Sye5MVAcnkNwUukAoty0BNXd8BkUOlodv4geY6wWlWW9Yd4rTBTUJm5ym/SBLj+TwaQ39CVVkY7sOydj0cpRKhfzriAdbtL25fRC5pxLzGip8raGVLN7emkuFFm8fTnH4BzlnEG+jq6XZtEYtQIpphOIz36p+CRGtyDiE1pLbmqdvJ52StfqOgXfIc0edLn+NcWU6WolfHWhyoZ6FppcycM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(55112099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnFOKzRUcm9OOEFIWExKeS9ETkwzbzVVTklzb3h2TE5STVI5cnFhVTR2NG1j?=
 =?utf-8?B?OWtVT0NhZGY2S3R4Q1JoUndKeWVyNGhQNDZhV3hZbEtSWlY5aGtCcndxY24y?=
 =?utf-8?B?ZHF0NHNvbEpablRWOTJvNU52U2RVSlYrOUlDZHdEQmszc1NyRmdSSnZJc0FZ?=
 =?utf-8?B?ckVJQ0dlTnBVUWJXWncwcjdTZ0FQKzRtL0UwSHZLREZjM3ZPY2hRUFh1ckZr?=
 =?utf-8?B?WUN6QW5NRjdqRDM4YjlRbHphbkZoZEJqRHZiZzZnYlZ4Zncrb1Zuamw4ZHVI?=
 =?utf-8?B?Nm9XM05weDAxRkI2YXd0RkhXYlBpUE0wWVdJR1RneUthaGFXemxvY3hkeCt6?=
 =?utf-8?B?dEFoVzczMEppd09WOWpGR1c5MnlXd01LaDRRQ0FWWHZjSm5QQUJVcC9LMWNL?=
 =?utf-8?B?blB5blBDVGZkMDlwOUhPTmJ4SDdWbkJZdEZzRUcvSVlhRVRWNjJIZFY0a3c5?=
 =?utf-8?B?NWlrVnJ5U3IzNHhoa0t1ZlRzaE11dzZ4OUlIaFFKRldjWHI0aFU0d0FXazk1?=
 =?utf-8?B?Qjh2UnZUSE5HUVBpNVlITHp3Nm5iYURjVlJsMU5CRWhYcnFZZFJVM3hmVUd0?=
 =?utf-8?B?NHhCMzdFOEhHeWM5TXNBUzNXMDQwVFRDOW41NmdHNVZPUzRSb29IRVN4OVRJ?=
 =?utf-8?B?NEJpdS9TKy9jM2oxVXRlOS9XS0lVTWYzUVFJTVc0VFQ0dEE3ZHZ0SlhQNnBB?=
 =?utf-8?B?b2t6RHo1UGowYUlVOWhFTkgzOGNldlQ2cldDcGxRRStVaWtLYlFIdlY2SXJD?=
 =?utf-8?B?Yzh1Z2ZrT0JVK1VUMnpTK1I0ZkRZa1FJZktSTHNwYTVaM2FpK1dpZFZjaTZX?=
 =?utf-8?B?dnlJRkpOcUt1ZDh0dnNXQkpqSmF4Q1VLQXd0dGplSXJOd0RLUlp3T1c2TjR4?=
 =?utf-8?B?c1BqNWlBOW1vaE5NQjk5cXZURnpXSFF1dUFVQUQrZDcyYWR5RWpYZHY0bnV2?=
 =?utf-8?B?bUV4YkRCbjFXa0VCWVU3dHRyaUlFblJRY2NjU3Jhc2xRTWQyc09pdm9MWVB4?=
 =?utf-8?B?emxWUjlraGZHdU5EMytsTUxBaGQwb3R5b0xnTGF6eEdDNFpmSWdUMVZ0U3pm?=
 =?utf-8?B?R1NaU1l6d2t2aUUzNm1aS3lGcENnWk1ReE41VTJ2QWVOdUxPais1eWtNbDhN?=
 =?utf-8?B?cmZLNHdEVTc3cy8veTZSblhiZitNcFM5MGtyYW8xYm42dkhxUWJ0eTZhVDBy?=
 =?utf-8?B?eGY4NGJLd3JOK3FKRjBjZWxTdjhkOWppTnJSL2VXZ285VmRObG9jRm11OHcw?=
 =?utf-8?B?ZGNtaVlkZjcvdDIvME1SMUVtT1BuZTB3aVRjeWhGSzJrKzc5RWJkTS9MN2Jn?=
 =?utf-8?B?WmhvZ25IaUl3ak5lWnpLalhBbkNwYTVvSm5lR29oZFVRUWo3YmZQUGZhVFJV?=
 =?utf-8?B?amlNNU5zNzFLNUQrNTZ0c1ZXVVNZS0FWVnZBbnFyK3BpZGkzK3dOLzVkZ1R4?=
 =?utf-8?B?MlJlYmd5cU5WRzdOSWU1Q2FGdktDTzYrL0VRN3IwY3R4dEVyTGwzcjcvSS8w?=
 =?utf-8?B?QUVLQ3dDajZBWmFtS1VvNmliQ2haMERBZVJuUkJjVnpmaGJma29WN2R3S3BJ?=
 =?utf-8?B?M1A0VTFyZGU0VE5UbHNtbFhBZmVKSzZ3NzcwUXlrOU91aU1IaGNuUzdDOVlO?=
 =?utf-8?B?V3FWUHBGb0txdEtWdDR2RG94LzJ5cW90dmtJa3YwYUh4OWRPL1ZRRTJZTlNF?=
 =?utf-8?B?SDZYRHg0bkpiYnprYjVTQ3o5Z1BNdTVOY1FmUUtuZlp1OHZXY0VoenV6N0Fv?=
 =?utf-8?B?algrdnZnWjRSa05WL3luN01qTzZpdThNTE9TQzladWlSTFIvSGJmYnBsWkRH?=
 =?utf-8?B?dHVKQ0NxTFd2dUx3VVRaZUNxOVNwMkNraTVDQitxQ3dFbDY0OXNqMVF0dmNH?=
 =?utf-8?B?bjZpV1RsL3VQZmkrVkJRTEk3VjBkWnV0WUxYNFF6N3I2MlE5Z2MzZ3l5aGg3?=
 =?utf-8?B?SDNaK01TbVpGdW91dlZUQXY4QmFyS1dhandDbHN3QWtWMHByejVsWEZ1SXMv?=
 =?utf-8?B?TmhYVUh2MWttblVxTnM1SVNXT21FcjJtdEZMSGdpOU1TZlhrOUpCY3R3T1JS?=
 =?utf-8?B?VG83WHlaMHNJNDdWM1h2WFpzRDlSekttRUZJWWtvRXNYVkhSRy9wK1o2eGdi?=
 =?utf-8?B?QnE2c1puZEFFMVI0QTlUN01Ca1pOTE9jWW9kVDkrL3FzQ0l1Nzc5YytEQVJq?=
 =?utf-8?B?SEI1M3ZkVXErNXVjcDY4K1dCRVk1a0VhSm9heDd2OTZ5K01ERXd3a2paN2Jm?=
 =?utf-8?B?REtzMmFPUWV1Mlg5TEs0Y0o1MmJOckxka2E3MzFCaUIvblU5M0hQNGRxQTB0?=
 =?utf-8?B?eDN6WmlUVFVhZmxZM1dHMkVsNEsvb2V1ck9FZnlCTVgrU1pXSGVOUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b462eb7-016c-4f91-f0a4-08deca4c4c0d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 19:36:57.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08Ko8owwl7xUh34A+GhBJFJBgrPnZjicdo/yNJPeHfv3aY8P9MvCpVfIqYfZTb9MTUdRhLYNYh2IKD7mlVW3Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7382

From: Jan Kiszka <jan.kiszka@siemens.com>

This increases calibration accuracy, specifically over virtual
environments.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/sched-quota-accuracy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/sched-quota-accuracy.c b/tests/sched-quota-accuracy.c
index 9ca496d..278ff1b 100644
--- a/tests/sched-quota-accuracy.c
+++ b/tests/sched-quota-accuracy.c
@@ -94,6 +94,13 @@ static const struct option options[] = {
 static unsigned long __attribute__(( noinline ))
 __do_work(unsigned long count)
 {
+	struct timespec now, to;
+	int ret;
+
+	__Tcall_assert(ret, evl_read_clock(EVL_CLOCK_MONOTONIC, &now));
+	timespec_add_ns(&to, &now, 100);
+	while (timespec_sub_ns(&to, &now) > 0)
+		__Tcall_assert(ret, evl_read_clock(EVL_CLOCK_MONOTONIC, &now));
 	return count + 1;
 }
 
-- 
2.47.3
