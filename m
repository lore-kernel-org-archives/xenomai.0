Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5F349483B
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436594; cv=fail; b=MF0YiZXDNkAr3M4K5j3gBt9KEMzOEsRxQKunqz9V+J084xdV3jGTKxqUOZ70Zf1bhYh881/hgyJp8grLSX/TWHdO/sTxoSEpBmcBuoNbBZ0LIkL1glOmTGLevY9cQqC2EyA14PcYNfB40XpCEGyhYdTxB1Pv91+jHebZvQ1PsJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436594; c=relaxed/simple;
	bh=k2sPMifk0/lbZ4hQh5sgDaTMaQFdYHfDkq9qHvVP24M=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=qsaxQ3+MOqlfHa72Bbs9c1HmSCzI+sxit4Zaucwy3Ku53bOLMqCG2OlULiErHX/uAxUkQ57ueC40oJU8Mv5bv9KNyEjB21I+RXVScRe1gjth1SkBhYCebWYoWjBmwNJep39zF/MnmhjGhvw4E2fBZdtNmaUKz3TtOkGlwat5gfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CD4xjyPL; arc=fail smtp.client-ip=52.101.72.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CD4xjyPL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Copns0QaBsSeTgJrNxHRZPdDlJR73XvWewdbIbqFFdGQGlzTpfpyTn7Y9bq0f1Y+0xtvc3/usgXic+ItZfV/VVr+1AVnczACFnmsuLt4kWUYGNQ4/8pwU2Wi93Ur54ds7sMRrUEA0tfkRnZ8MaGDUMZZmt0BvfHhwoCSCmhAPyEt2pQSuwcR5A0ApqtEEkgOF1g8b2nTubVEewfxqZLi4ZuMdI+kkD1P/oDNnk8vaPanLseAR/gulYaobKkJ3fzdX/MRbjeYG1quvO2KNcu/nTEBYHkG8Jx/K/qpoEgsA2WBhbxgADtXo6b7gzwGXrlQxFqGbbXkcZHdRJHRu860ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxKOyZAaFFjSqdh1SfnaLFeYkXz8fHBKICtfXBwZ5CM=;
 b=c8xd2oPp6r8OHY8Hm2T8OkaZzZX0lU8EU3qw86M8AlCybLJ+MkzE96bgNxuqwuDb2+AAD+fcoEnNRzExMnLUAhHUGU1vv3f4bXEn7nbK9fDks4ei62Ftie/jUgo4lCtdYWH9+wKds6SQS/9WpcSjHsl+pccz7zFKou/TJuLm09oeFUAUSwatZrKi5v8Iqx/ExDITPPAKWc9D0rcaKjnO6yN6t2/WZZcOTtpfvvNJ9e9TF7khjWUiIMRxh8iHkXrlYse+Y6yZ7svGAdwR/jaUGm0Y3dQOijbAbB9G+ZgrySJVbwjanAOmbpiYPS3kwEXVwyq+KXEF2qF+3wA9kb1ToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxKOyZAaFFjSqdh1SfnaLFeYkXz8fHBKICtfXBwZ5CM=;
 b=CD4xjyPLc9jba0Q8COVCKbxOVfihQzOGgJ9uy4jE6dYgJTz8a80UerLAgk8gnBYr1ShFl4Q67YTKAaAoE7bJHRYB1Y74GedJal42yKQOWUHOvoOpvGViMFPBP5sQjEflAOrGL6le7oNOuGtQ5CkwTEILjdhxGiQr0NjCopm0lWrWfFz9/MLEFv7Hn/sGT8gUeKU3FzRMlMVDa8xs5/5lptV6MCc7K0de5ApJAJtVy6aA7OG9UlNGz/qA2owKFs6UWvNA9J9VAXZtUdMEX5vdwsRGmlg0W3D5x6WyUafCgARwCTV/gBNJVnWtJbRlfwovfHBPgRnPIP5wBLLLSx/7GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7206.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:56:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 11:56:25 +0000
Message-ID: <5e8b973f-b12f-4638-aaa5-43819e7e3a3b@siemens.com>
Date: Thu, 3 Sep 2026 13:56:24 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite: smokey: Add timeout slack to alchemy over VMs
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: a650805b-0cd1-4dd2-cf40-08df09b2617a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|55112099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	l25hR7GPs8gmeRuRgNc04Ev2nj7Nruas6Za1PZyZyo02xbP0n5JXqd25HZdV6+MTOHQPiAWJuxl3nPKLC4wDrVU+6zFZaVvN3Tjr5EA70hUAssaMfGniXJRMxVynDs0fr3AW2LP6EEDd8JAisa4ccbOpsmpcrxVc3GxURRF0An4caO8zKDlNLtlNuLmYoKSZ5yBHvdtG6ouy0MFcQVtK0y+UsHXbJswDxQBV4AzSOiP1nHovGSxtNvdzz7Rf3dqEvTKXuPuYoP5wtx4OexGRKABNhCS6tF0KweOwMYqyKoQj8K9+p0NyZG40FbDqW8PinfTBenxMAtClQFeM6L7KhIEy2ALYlwkUAhg7bYaySse+eEYcS0vS5b8Ep6rjE6CwSh/jA1Rf40CiKAFfMcO4YUcukPviXBqv9ePC0NcxHV1O3StyZ8Lb2qAlvB7JjbuTpqoQ1TwP5v/YYR5qKt6FSS1bxQpl4YwO4Hz3exz+9MWhKm+xuvGQQQDUzFpJizEqsSAeAWcrdJZ5U6qlqyL+tJioiStvDvsi5bDOnA0OGOtN8JmO9YsR+zbrFnYW8yKjGqjggx1ZbVPTtZ3QPhYEw5g3UXq8bRz+UAGfjOru57SpfIHuqFtbJH+FnimDt1xt6fDp5XNvtwUK1ALzuEltoQvQgnFXQGSUQmhezpRwz40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnVmWldROTRUU1I2STZWRVloSWVpc01MZXJQSXpQUWlGd21WTlVHR2ZPYnRF?=
 =?utf-8?B?bW8wMW1ZT2pSY0crVlNuRVNRVGxNZkduc0w4K08wUWFrbk1GZVg5NTIyMFlw?=
 =?utf-8?B?aTZyWVB6Nk9lZHFrejBnYnprUWJRMGpkUVF6R2pTcGZvTFh2dzIyNkZYTDQz?=
 =?utf-8?B?SGF6YUNYSEt0UmtabDZzQldWSXZ4MFNtV1Vjc09Ga1Ivc08zVFl3ejZkZzNF?=
 =?utf-8?B?MkdjdmZMaW10TWMwekhIL0VkaDdJUmQwMXhkQXd6SFNhWEFpTDM0NDhCejhj?=
 =?utf-8?B?Zy9uN1BkeVJwdkNRR0VBaU9xUXo5Unk4Y3pyMSswbGtWNGNGS01PWndvWER0?=
 =?utf-8?B?Wkg0NCtJR0JrVWxqUHhxTU5KbEIzQ0kxbHY2Vmt5TFVFazB4MDN3NFFnUUlL?=
 =?utf-8?B?Y0RBdGhqbmdxK0VlUUJEN0xNTFBIV2ZWcXV2RlJOejZid3lCandZRzlsWm1L?=
 =?utf-8?B?bTJkYXpieGNIWUkveHd6VGVvTkhhR3Rrb1pxcVZDQmxRMGxDN2pUNUxMNkI4?=
 =?utf-8?B?RVNuVzN5UVFBRm16Y0ZDSERFSUIxeXNnWVArZ3pCazdmV2J5d0FPbWVkUWs4?=
 =?utf-8?B?WEw5YmQvRWlLMUlocG0zWXM2Z1JoRzRhNjY0VWtlRC83SW9KVFBIQzRiamhU?=
 =?utf-8?B?cU5xWndqOXB1d1gvUFVoRHl1M25yTXMvN1VmNVM4N3BlOWY0MWtTbGFQVzBx?=
 =?utf-8?B?RjkrSW8xZTN5RnVvTkM4bTlqWjN2S3M3ZW1IRjFMUklOdkxVcHd0SnFpbktF?=
 =?utf-8?B?TzNvRlp4Uy9McmRaR3VFM1l5cS9LYzhKR0ZFQkFDRzN6c2ttczZZMzhpbXNp?=
 =?utf-8?B?QnFMNXIyUVlINEdtR25xR3duNCs4SXRwQVpaNGlLOTh4dTBRVEdBbHpmSXRL?=
 =?utf-8?B?L1UvTkZHZ0wxWUc1ditrQVNoM2dqNk0xRkFtTzZhT01xK2FKOTUxTytQdlZo?=
 =?utf-8?B?WExWSE16SDhwZkYwWGl4MGxWaVBKUTBnYUdKdjJlNEluNEQwbnhGcmdqMXo0?=
 =?utf-8?B?S3h3T0pIbXUxbUhrL1h4d1M0M1orakkxK3JiaHJndTh3M2dsa3RydGZQOXhP?=
 =?utf-8?B?ZFVFYjR5eGpwUVdvMk0raHZubmdXU3k4MU8xUVErbUVodGJLVkhnMUNQWXVz?=
 =?utf-8?B?WUZiRVptTkpwWE5KSm9lNis3VUlnbnVqNlRtdW9pRTVzQmx4MVY4ZUpGOTdV?=
 =?utf-8?B?bjI5cGJQMk1RNStsTlloZS9HR2MybmpQbmljbkkzWmF0SjA4ZEgrWktEdGkr?=
 =?utf-8?B?TlhuQjl3Wm42eDdFUyttNWYvQ1dFc2NaemhwcTFHSkVYMFFQTXZNVlRNOU4z?=
 =?utf-8?B?OFdzT0VlRFZFVngyMEFhR3NoTTZFaVlOVHI1emJvZ3VwUWFmblFOajJuT0JO?=
 =?utf-8?B?ZGVNU2FZT1ZweHhFSzZFOFZ3MlVySW5iUlB6Zk1kK0NvMElWcVhreWNpN3p5?=
 =?utf-8?B?YStqSWhmSXRBT1RzMFA3aExDbXpPdVVwVURTdDRleXZGY09neEEvNis3N0hj?=
 =?utf-8?B?dGRKaGl2emtmTnhaUDkxM0o1NW5GaGhRbjVtWnR2d3prM1FodHlsVEpmRGZ2?=
 =?utf-8?B?T1Y0UWJ3WXZOaHRQS3NDWVNrMFpkUU9LMEFMSG1KdHdnZXVzRWtZU3ZlSUY1?=
 =?utf-8?B?cmxDdFF0WW9wOTRFMVVhY21SSWt1ZzNFM2RXT1ozOEtqZkJSaUVNOWo3WnZ2?=
 =?utf-8?B?RVhMaG5KcjJaNzJaZHRtU0lrampIMGdFeWhKdDk3bWRweXplZWcvZ2E5elBv?=
 =?utf-8?B?UlA4S1BRdHRibU01TWF6eXFzRThtS0x0czJwbk9TOFZRNmM0Y29MV0hxVWFx?=
 =?utf-8?B?M2VEQUprclBvUllXQnZDQWhXNXZzUjRMMmQwMTRwZ1ZQdDg3QnNBdkZrVURV?=
 =?utf-8?B?RytqWVZGNGwxdUFRd2Q0aXRRS2dRMm5YVWIyU1lwcUZad2pEdnpFQ1ptSHZt?=
 =?utf-8?B?ajFjQloyV05YdUZ2MEl0SnVBYUU5M0FVS241NjNjU0xoM25EUUVoS3QxNHAv?=
 =?utf-8?B?RDI4MHdlY0p3cmlNUkNMQzhLS0xiMFZ1ZzMrRE8zR1VUOVNuQ2QyVWFKMFN0?=
 =?utf-8?B?NkZPbmRobmVwbStsa3diUmxCNTlqd1VyT3RNRWlUVnRXSDdzNTBRREgrMkd4?=
 =?utf-8?B?Q0lXcFRxbjRZZTlCSEhpVm4xUWsvLzVUSVREYld0b1ZTbHQwQzRHbEg0YkIw?=
 =?utf-8?B?b2tyUWdlYmc2OXZCc3dPT3VxTXY5Z1JZZnNDSXEyTFhZbzM0L3JkdmhRNHQ2?=
 =?utf-8?B?R2dEaHRZRHQvd1UrUG9IMmZudDhvMlV6RVNqQnZuV0hzK1U4aEFBM3ZyTWVM?=
 =?utf-8?B?emwyUzVjbTV2TENid3NWMW5VQUM1ZWk0Zm1VU3dzRjBhZWJyNUp0QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a650805b-0cd1-4dd2-cf40-08df09b2617a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:56:25.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV3zZer0YShg9zqen3Drdd8vAvA9njJymk9pUy0X5s6RdVVZcVY5jjn18p9ROlSwNZ4gfncfAjzMjMrDHnNTaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7206

From: Jan Kiszka <jan.kiszka@siemens.com>

Account for sporadic slowness when running in a VM.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/alchemytests/pipe-1.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testsuite/smokey/alchemytests/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
index 8989f3a46a..299e1d8dbd 100644
--- a/testsuite/smokey/alchemytests/pipe-1.c
+++ b/testsuite/smokey/alchemytests/pipe-1.c
@@ -8,8 +8,13 @@
 #include <alchemy/pipe.h>
 #include <smokey/smokey.h>
 
+#define TIMEOUT_SLACK	(on_vm ? 10000000 : 5000000)
+
+
 static struct traceobj trobj;
 
+static bool on_vm;
+
 static RT_TASK t_real;
 
 static RT_PIPE mpipe;
@@ -83,6 +88,8 @@ int main(int argc, char *const argv[])
 	SRTIME timeout;
 	int ret;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], 0);
 
 	ret = rt_pipe_create(&mpipe, "pipe", P_MINOR_AUTO, 0);
@@ -120,14 +127,14 @@ int main(int argc, char *const argv[])
 	ret = rt_pipe_read(&mpipe, &m, sizeof(m), timeout);
 	end = rt_timer_read();
 	traceobj_assert(&trobj, end - start >= timeout);
-	traceobj_assert(&trobj, end - start < timeout + rt_timer_ns2ticks(5000000));
+	traceobj_assert(&trobj, end - start < timeout + rt_timer_ns2ticks(TIMEOUT_SLACK));
 
 	start = rt_timer_read();
 	timeout = start + rt_timer_ns2ticks(100000000);
 	ret = rt_pipe_read_until(&mpipe, &m, sizeof(m), timeout);
 	end = rt_timer_read();
 	traceobj_assert(&trobj, end >= timeout);
-	traceobj_assert(&trobj, end < timeout + rt_timer_ns2ticks(5000000));
+	traceobj_assert(&trobj, end < timeout + rt_timer_ns2ticks(TIMEOUT_SLACK));
 
 	clock_gettime(CLOCK_COPPERPLATE, &ts_start);
 	timespec_adds(&ts_timeout, &ts_start, 100000000);
@@ -135,7 +142,7 @@ int main(int argc, char *const argv[])
 	clock_gettime(CLOCK_COPPERPLATE, &ts_end);
 	timespec_sub(&ts_delta, &ts_end, &ts_timeout);
 	traceobj_assert(&trobj, ts_delta.tv_sec >= 0);
-	traceobj_assert(&trobj, ts_delta.tv_nsec < 5000000);
+	traceobj_assert(&trobj, ts_delta.tv_nsec < TIMEOUT_SLACK);
 
 	ret = pthread_create(&t_reg, NULL, regular_thread, NULL);
 	traceobj_check(&trobj, ret, 0);
-- 
2.47.3
