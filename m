Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675673;
	b=r1JZmBzaHkhUqj7jKruqWRbfNWBLa1mdJ7oVfST76nUMYA64uWg3rBV7mlOPShvby6q4
	 QngBES9JvzuzMazCmFr4V1WmOM7Y3Bxz4sFAYXhL6CCMNtPFheFOytbQT69m9dI9Ed0Ks
	 WZfVXcnLGlthzzn5RfyxVCJ4H55Hk1RqZsnl0j3TmhQbrk++4eCTzGjkleNInKKg/YTCW
	 F2ljLzv9mTYEQfFPFNhW9ZAWPbj1B94LVLEs8/d4of9unAbnDw3iikjKWS1qeynY2zTrj
	 fDqE8e6v2Wrrtx0BNHohIkPPxBJvA5Nyj1+oQdmJUOg7ErouH1UTPrLMrAIorp9qT0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675673;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:To:Subject:Content-Language:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BehUFFPk7mUcqgpKvCxNwvcz+FAXE3o6loFi1lrkrLQ=;
	b=RmLUtD7rBRjYFRxtto4exgusfj2HdxBYtA4wuiKVqh5vaU7MsqDBn70iY1nFVU5WIs61
	 nefrjBldNhh3r86vgZEwr9QNwXvp2QV3Db6HOx/AFzyjXh++itI0RrenesjrSfWHSup1J
	 bgGfso4SI5DvJB/wjbGNQ5LpCKB+XJa8e/WmHECUHUQ+CeTjkhZ8KlSCwAVYOp9bbKJKF
	 THJ3GEreZqckxLVB6dD4BGa+mkJPhAHaCON0DAqTv+KAu0VNFbG7rJDzerZqicDfZZip1
	 10nMqpi3j43exHbPBvMUvceKmSnDmrtsbSc7mMbuy+Xu755ilmncgAdzYfoQCDKoASQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=NEEjtIye;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.11
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE92606A323
	for <xenomai@lists.linux.dev>; Thu, 26 Nov 2026 06:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BE92606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=NEEjtIye
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAToN9r0bg95n9p6Nc3pgZdBrYoA+9T/jntlmbhbScr4ABaXocD6RC9/hRqI4c5PLELH13e5Brgzghfuhaq/J1zTa/7Xsacc3Cx8A8oK9o4m1uBXWR9mFHR4v6sgkURdIkLp/L79Bo4slwRvUPrTPijhrd0Xt0axiEIzaID09p4i+o9CcRqxfrVCrvPsUAdf8/i2OKYHoMxBV8jiGDJvhhg/itvphqCYOycVc/nIz/gvy9GUdwYXiBJGKQx24bcsF3tt39UG8HNI8tFN1VrTjIS9i7eu3cRQrh2uF3CDyzgmqo2jgUpzY1mFn++4TZPHm06m5Av4fbPbkyJ3YtEk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BehUFFPk7mUcqgpKvCxNwvcz+FAXE3o6loFi1lrkrLQ=;
 b=WyRqnf3w9eqJA/2dVwcMExy0JMqVk8qQ+1oP6sla1wjK/ZZ8PqyKQKF9UyAHYCZB1dJeE01xKmcv8OPKVK5Hn8meQabAir0DbIBOlNdNxonTXxIIHx/LnGHQ7B5oGeJ+BlDFFo0OS0JbiKb/c4QyLAjrwzTT6YtMRKWKDpiR6je5sWfSRTVDMUR+ffXyLCicI2wp6JjCz5sXcW2XHW3TYfwBb5kIuZbRF9E2Pdh4qGCtl53vpzCf0Uba3HpEDDMR5j9FMzLrOLy6Of0avsuTIiMSVZV0JgkdBf6vpfvsa4S/MeYiSMJZZQpBovn14shlfFSRiYzIZkuY6pHtMqCPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BehUFFPk7mUcqgpKvCxNwvcz+FAXE3o6loFi1lrkrLQ=;
 b=NEEjtIyeEU8K8lSWdxKDb7jAvhbOaiZ+ymc4xXLmPmryG8GvisdGeyfMoko0fsRWv9sNRC7nYhADd0UXdRdXfxvvAiqliNq/UcecYhviiskhrO9IAHhxPZF/AVTCmToOQmgSnZledaXE6xtkrpsLTNlhOdQruFZz3OcyMtwsvresB64Ae83gI2p89onlG9Gn6+C7WNJdwB+r635BPFx19RYH50xW0794+EEm0LF5QnOgSOTfhDXaBy3z/DUnF4RxqqOg9B1Hr7u+ZiWEJ0QCUgnyT9ILoB8bA5uUR9e5s61kRWkHr22UTcFz2EjzU4gpJd/vQvVrgpDuP8iapqwvGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM4PR10MB9424.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6cc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 06:47:50 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 06:47:49 +0000
Message-ID: <9c06fd01-c76d-4dda-88e2-8ce7895103b7@siemens.com>
Date: Thu, 26 Nov 2026 07:47:49 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite: smokey: vxworkstests: Raise another timeout in VM
 environments
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM4PR10MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ffd275-6b07-482d-2aa5-08df4b892fc3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261009223027099003|55112099003|261021123027099003|18002099003|261021121427099003|261028144727099003|261022105027099003|261102123227099003|261026140227099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	drEZ7nJa6fVPYRB0GiDgWHvZ98HvGELMsrqs/Y0l6BQZ724RKpYr1JiegibUlGEYL0Wy7GplwjmMgg38KcWgC/0grhw/x+CjObp8w5//lBpLGsX0L6t1Znl5EhmBbi4ktSzgugBb46US0dlqdeYD2TmEFUXPq307Ss4CuYSnnM/s9uQBSAsoxj0/ELzk2GCtBLR8hn/0eNGtrnYGoZxr440CiwXsFHpOdJV1/CVuHjAq+/+gooK6rBBPkztfKohwotpTlpadc/aygzTcncoP7IUsUDELiXe3V6cbANZrvo9XWlGH2m3JxEwDEiMpRisKPVpoSb0qn6L/AVnC36GliMgyZwau+AA2+qa8JtdxNKqvczVKaZP355aPTnh6bNDC8TsCeNazQOCemWrxiiDEptL4JUb5nN7IQytXMdv10RRyjqDb+LnjRJNwlmD783udp0jXWswmvvvawUub9bXa1pwJLDr1bax6nCf4PbzQSqyy6tlFujIJUikzbJS7uc+yeYIiyOQKWKpzeC6lePx0NAF68wNE2EdEQmwSY77iGPdBsUqTlRrXA5AK1hKDqWiZrl8WTwtpV7hL5v8/k9lvuxvJM/sRvNn++mP3mfFssuR4T+UUpPuDr2yjGZKFuaOYDD2u6Tyw/BOIQt7ZjMenWobIirOxn2xoOBCwEP8efYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261009223027099003)(55112099003)(261021123027099003)(18002099003)(261021121427099003)(261028144727099003)(261022105027099003)(261102123227099003)(261026140227099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFV5Yjh6VDVxb3ZMYm81Mkp3Z3BtMm9BcUNXcnZYNkV2NitKcm1saE9oeFJ3?=
 =?utf-8?B?dUNaWkJscHhyMUVMMXBwY3JxSStQcVhTZlByc2tDMmZNTVNpaytxSDVBdk1i?=
 =?utf-8?B?UUY5TFRoNy9yaVA1eVlJME1HVmxPL3hpeGdsaURLMlhNRlFFMzFrTXU1WXNu?=
 =?utf-8?B?Ym5XV2IwOGhmZUVlbU5rcVdPV2VWcGpQd2pYSC8wcWVNUml2TXM2RTZLd3Jn?=
 =?utf-8?B?WkR4UWlSVmMweUdpNmNOZUFxQnhlRlFZQytKbXFhSE45Y25KWlpaZ3Q0b0V4?=
 =?utf-8?B?em5PdzZhZVlRNTFLWW9uQklLMjd0ZUtKMlQvdURDeWpiaVgzR0dMN2c2VXk3?=
 =?utf-8?B?Z3dlOFVCNSt2Zkw5QUFJcmkyMm1ueGd1Y0RDak1SZDk3UTRCUkEyNy81UXJu?=
 =?utf-8?B?NHJXOEdBQ3pBNHZKQ3hXZnA5QWgxUlVxSXhNVnJtbkNYd042QjNIeTRRMldw?=
 =?utf-8?B?aXNXdkk2UXVNeStkWnovZWtLQ2huTlIwOGZUcWhwU09hTTBBVjVUTFBpVUpX?=
 =?utf-8?B?WWdhWFZzRURldy9vNjJXK1lGY0ZyV3B4NnpGT05OREd3anJrM3NScmp5dE5N?=
 =?utf-8?B?aDh6cERoY1lXMVlVT2l0dFNXQ0U3Z0JsTkZOUkxEWndPU04vT1NpY1hkZWpR?=
 =?utf-8?B?MXo3eG0wbTdWZTN2QXRtUnprdFAvTnNFZldjdmlYRjdZblI1U2hYVklJcmxJ?=
 =?utf-8?B?MmljT2NJTTgxZk1yWEtkSWkyUTJ1TFpLZkJiclVZbktGelVteTUrekRPTm1V?=
 =?utf-8?B?NU9JWVVKTXVmNk1kZ3o1Q0lUVHg2Q3JhWHFBenRsQ1hKMHJxY0Ywa1g1NjE4?=
 =?utf-8?B?Y0xudWhkR3VCRzMrVG9qWE54U21kNThHVHhhR1lXV1NONTZaMFZud3NxQ1dm?=
 =?utf-8?B?bzZSdzRobENsTXJuT0dob3lRWE9tdENsWHRXWUVGOW1WaGd1OWhzQVM4RnlM?=
 =?utf-8?B?U21YWnBEbmtLRWthRXRNdGdrd1dIcHMwRkoyb2p1a0MyRVlRWHlLN1dLYmZW?=
 =?utf-8?B?YTBWSFZ5SEE5K252a3JmR0dFQzYzcW9scGlkVnBtc3JLd2JMSXMzb3Z6cHJp?=
 =?utf-8?B?bS83TzQ0RkJsSkJycFFNd1h6MnVLWnNKY0tRRUI3KzBHYVFxMlFmbnJaQnRC?=
 =?utf-8?B?MmRZeVVlYkVaZkg1UzY4MFRrNFJOSktsTzBjN3d1VUQ3ZkFHMk1pU2s0WWti?=
 =?utf-8?B?bFhsbW5VRDVxbjc0R0hsRU1kN29FWDJtSDlCdkFlSTY0VCttK3RUTEJmcnZU?=
 =?utf-8?B?ZmVYbXcxbmJFSFk0bDFvUmg2UnF4ZTZyVVZ0ZGxUR25ZTzVJcDNQYSt3VTZn?=
 =?utf-8?B?UDNmbGhYSUtXbm1nSk9hM1l6MGxJZDF2OUlwZG95alBOMHMwd0kyQU9nN2x5?=
 =?utf-8?B?dHk3YkFiQWdZR3FTNDZOb3JveGJPVWtSeHNQUEF4cDluTENGUEdUb0c1R2RR?=
 =?utf-8?B?QXRleHpVY1NveGhpaXJOTXcrR1hFUDcxMHFsRklTbG5IeU53ZXlQT1Foeis4?=
 =?utf-8?B?MmdDemJGOGE0U0I4Skk3RUZObVlXVFBDa3BzTVpmN0Rpd2FRcnRZWHJyQm01?=
 =?utf-8?B?REFyS0RwZGtBZ3JleVNWUyt3dlVXZ3VIUldRTm4wSkdrZDJsWlJQbjU5VzJi?=
 =?utf-8?B?VlhvdlNLMTl6RSsrSjgydzc5UzZpL3RMNGo0cU1jZituVnkvWk9vWTlPQVp3?=
 =?utf-8?B?TjVrd0UxRkJ6U3lqOVJ0SFVkNFlLeWRyQ3pCbUsyNWw5VXRNb2tnVGNtOTFq?=
 =?utf-8?B?WTNZN0tKSjdsSTVaZkpUZ1NPU0YxaHZwYW5wdFM2SUhRMEhDdkJiRFpWWWZm?=
 =?utf-8?B?OTR6Smd5aUFBU0dDZW5PaDl3dHZDNmZRTWhjaTA1akN4UFlhL1lIa0FibTh6?=
 =?utf-8?B?cytFbE5pc0NPS241VkxJOXh2cE5vcy9IN1JWeVhEMCsrTVhrdGxhaWNpSitn?=
 =?utf-8?B?bWZ6ZVFHNGc1VDJieHYwdGVSNTZMWCtSQ0VnR3QxR2QxL1VBVHFaYUhoNU5y?=
 =?utf-8?B?TjFCblk3SXQ5KzluWHN2UThSdFdXblpBOEpCT2hWZ2ZBM1JFcktuRjZqNWc3?=
 =?utf-8?B?Z0h0a2tCcDNROHhlQktjRXREdzRyQlh4Mm5xWUZPc0dGUmhwTVpLMTZBeGtp?=
 =?utf-8?B?eVZWR0QzaFJxdDQ4YTVXTXd0dm5PcnFtb2svZXdZM2RWS1lORy9RYVZ4RU1T?=
 =?utf-8?B?MXM3SHJqQUlncmcvOUdNYTB5b0c1Vjd4aGNQRm1lRnRHUU9zZC8rU0tRcktF?=
 =?utf-8?B?dS9GZ05CaEhCTTB5RTlyYURvT2VLY29XVGpoRmZPQUY1Si9rcUgyWE5HRWth?=
 =?utf-8?B?NU1ieUR2dWR5bkdYWTVndUQveHpMMmtxN3ZsQ2NPNkdwSisyTnlhQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ffd275-6b07-482d-2aa5-08df4b892fc3
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:47:49.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2h0HDQfZDqV1UPAsEqDkZxpAtUG36XhDbAvpBNDJMo5Ru+cUu4bHVp6rxDjwJ9ha0Bn5g5fXRV6GMIk0aWCZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9424

From: Jan Kiszka <jan.kiszka@siemens.com>

Similar to 79df634b5b23. And this was already observed failing in CI.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/vxworkstests/msgQ-2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/vxworkstests/msgQ-2.c b/testsuite/smokey/vxworkstests/msgQ-2.c
index 669c064e23..a6945976e1 100644
--- a/testsuite/smokey/vxworkstests/msgQ-2.c
+++ b/testsuite/smokey/vxworkstests/msgQ-2.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <boilerplate/ancillaries.h>
@@ -8,6 +9,8 @@
 
 static struct traceobj trobj;
 
+static bool on_vm;
+
 static int tseq[] = {
 	3, 4, 5, 6,
 	1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2,
@@ -82,7 +85,7 @@ static void rootTask(long arg, ...)
 
 	traceobj_mark(&trobj, 6);
 
-	ret = taskDelay(10);
+	ret = taskDelay(on_vm ? 300 : 10);
 	traceobj_assert(&trobj, ret == OK);
 
 	traceobj_mark(&trobj, 7);
@@ -99,6 +102,8 @@ int main(int argc, char *const argv[])
 {
 	TASK_ID tid;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
 
 	tid = taskSpawn("rootTask", 50,	0, 0, rootTask,
-- 
2.47.3
