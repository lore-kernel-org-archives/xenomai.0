Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB54239562
	for <xenomai@lists.linux.dev>; Mon,  4 May 2026 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879379; cv=fail; b=feOFhy/Pt9LAozyve27q5YVs71QvTTL7YRtFkxkItpD3e+PUREkVV7aaT2O6dhLcfsE683vepuIZoGy0gecBXBwA8XLGnOPUOKRE8RnyZ+PeZaFN7bRIFmQ0dNaw/mTqNz/gHNEkXEF1pGpHaCimcW/1BZmfdqZhjP+RTWBzFSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879379; c=relaxed/simple;
	bh=RbHgakIVBVr4vVUelnrEwBCTLTeKA9EDlAE1wa8Paak=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=XU2BA4VvZrqFfJi5kO5npybxXhWwARHag9VeWe+5EImg657OULngVUG9fQcSyiiM/1HPRz3tOA7sXcoW3V8zg4n2rUBQRZpCACAezr7HZaD6UM2tPcIYpnEar6qp7q6pQZb9dF5h7nBASC4m4JUKXih5TfQX+nJv/IqZEZB7jOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=C7whnTbw; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="C7whnTbw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDeCopA76aIjY7/UqEtepT24o9g8BTQhjJPi6nWmaeg+ZgtKudt42MWpLQB+KrR52Htvms9HVFtdWMwNuz61zL2ch0Ho6Z14Yh4xLrulFiKHSyb6fpV5GWRUg9TsQFw+PTPc7llTHy48WlKW9rMXHpeELxz1OfrEL8SctyBvDFkaSHPQltLXVUArT40x7xxpmNZCRGw4oCtfBrznbhCnog7h+StfMGST9jAOtPoYYB+vuw5J/PkCT8AVYonn33TVsbMF3fumq0lobJNVnpfd6xdJn/D7uRWTSh0HfAR13mbczQNQFC7nFSd6AQvQkFpnFsQ3DWVj57P+iRE7EEyfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EF2EWWHulpUextoZ9pEGNc73EWU7x/fpKnDOJGvVdU=;
 b=ov1R9ldEN4zfGpcH0068Vm+jxsB+YaGCIONjso8c/EAFNgkO1glY1MGD773q3Ac+TlKnF3sTvmRu39aYewuH5hdF9NP9cdNDN31lVW8SVwOmt3M5em8TLWOs5LVANhCVS0FNwKx7dgXAD5q2SGNIfLmjxcP4zBfKANny7m0eM4eicdRpbGUfM8g75RgSF9cu2kFAL/z58uHeTE/MraCypUdtGb/y8D7S/qSq8LryKeHY2Mk3gK1nX87xsVHq0sNAmmJrH9Y4lQIyteDd1kQPiF6tmbGsXgWu7AL9rUUZQnM058PuOPmxyYEXNRc3zSPW2t0ZZSpmS5FHrp0wuDKd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EF2EWWHulpUextoZ9pEGNc73EWU7x/fpKnDOJGvVdU=;
 b=C7whnTbwBh1g6AGHRdO3J/GqYaJat4YSA7v8evSVC5j05UzjSVELv+KTGaNJDo26fqURXyG+IaPqowR/xTOErV4+DkGWDoKmdNIXefUY1JNrNAA2lgzleXN0ig6WTz0Qs+Cyn4ooZmnTausiSDnd45VCkbEbIkqx9p867W6WaFye011Vuxe0lU4af5DZff4Mjhw35W5vfWjzAeBcMf6bfGAwyrGYpJvy9B0QxkPCnjHPzzOltzX2/liJ5NoOL6wvsem+IMOmOSPwGXEmPaAnS/9l9YEzU9BX9FVzl6Zl1mxBZ++Erkw3LWI4d/cEMXyrOd9G0MJZbAEtFL53mrOmlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3203.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:184::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 07:22:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 07:22:54 +0000
Message-ID: <6263dc31-37b1-4c5a-9714-7db1c38e83f9@siemens.com>
Date: Mon, 4 May 2026 09:22:52 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite/smokey/alchemytests: Account for race condition
 inside QEMU
Content-Language: en-US
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
 "Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0359.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3203:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d7d43d-b2a4-43fa-c7bc-08dea9adf50c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	q51/TCtcEysLjBReTn1bqm4HFvL0/W9c9oz1oQ/neLsANxzQaNg5CQbFNzG+1ZM7DTUSJQtay/FNulr8sPOlMrejVy7RmCNibRUyUeZ+kIiIKmWNHPuzndDiLvrcuLxPXjWnP4NhLvsTbwW46gMN+HWDoPk9k8Xs7u2ZWkSy76sYZ8fU4DFuEtbMcwLU1qUTaTyMFUlshDRGpNPbWn19BdQBQDVNfiEiDm3r0JBU1QVA+o0TOuXQp/h4x7g/eRaEOWp8xOZG5JOIcGB6Sxo+pCVe7ZmRUpBZxN8Mvw60ypLMM8UVN+ay7rnxAB9S43Q2nuY0q369daZtMhQURHNsaD20EAgS0mheKzDQotLhBLARYca3jAF4QmtSVH+AkTWRvAbD10utTTdDzGL9Oa48flnddmHwVrVTZIfEIuaKER7kKxoRYIFHuUtr5Ac17DNs2LUwukWXi3WDyZI1GLJ9Zs6l1bvatCi6xrmqENp/rU31fcrxTNXIe2gqXJEJYVEBMp+dwU+r60ssUt+wW1errZ5TOiAMDcddCF+V7ez7T+NKlCjgCSYQCKhHV9mWGwWY7RclzCW62W1IlYALPDpGF7G577awA4ZX9gxY0/HkYpDhhD2DO1+Q2gT7xlsMqKUH+MyQXGU8rIuK0Br0qJqXGdZ1cDd7jr0NQIwEQethsqzIy1JRggHf34CupFEiOOfqnS8pYott1st2FyQjvWF56w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFtUENMYkJEcHFTV3NodE5vRUZ6UmJBb2JpZ29FZ0VFSzljaG1VNGZoM3hz?=
 =?utf-8?B?NmRIb2thWFZBZzM4dTY3M3JCY2xlY2JuYituVEtWV2ZSbWc0K2JjQ0tEZkth?=
 =?utf-8?B?OTluQXVRT0QvMUhDRTlFcXVhbVBJNFB4bVZVeUpHeVZQQTQzeG1KRDB0eDhv?=
 =?utf-8?B?eG9HcVRnb2VSSGRhRXRhL0dTeTVtTTUvZXdoY2pFUUNvUWtUclpkeWZrQ2VN?=
 =?utf-8?B?anB5V3oyTXQvR2pqWEFlZ29zczNoSlZ6MWdMSjJyTnZXR0dmM2dDZjgxOU9K?=
 =?utf-8?B?eUMzQmVuZVZuWm0rTTlWcWFyRG5vV2VFcnhna2FCRDhvN0VYeEJzaWN4cEJQ?=
 =?utf-8?B?bEkvaGtCcEVWeEFqdHMzakM2ZGdGU25MQ3hKNlBtaHJ1SjEzWnRsU3RTejcr?=
 =?utf-8?B?OHRNUk8yb1ZSdDJjVUZaUGZqQzF4ZjNwQmQra1d1Y3JKT2R4cnd4alJMQ0gr?=
 =?utf-8?B?dmc2WkdaeS9zcWtWZURORFBSTE5IU3FJanBEMWhWVjVOSlpCZUo0bVRPenhQ?=
 =?utf-8?B?OHlPNUFwSFcxQUFkYzFIc3lyUTlQVGFKNzNVMXRsSGRTWk5XWVhvbDJUeUZB?=
 =?utf-8?B?dFlkN0N5NnBKT2VSTFg0dzkxUXYzbzZ0Tk9KeWRJdURpdzdyVDhIM2xyeXRq?=
 =?utf-8?B?eDR0RmIzcnlsOXJwYlp0T05mVG9iWm9NdjZmZytNWElXaURQVGZ4UlovWWZo?=
 =?utf-8?B?WGVYVEsxaVphSUhVMVk5bFlPWElqdzhvUTZiellzWVFBQmhMVWVmY28zbjNt?=
 =?utf-8?B?ZmhzRDdwSWZoYTRaWTdURlNVS0oxUnkwS3Ixb2xxMWdLSWdkODBvditlYlNO?=
 =?utf-8?B?c2JzVkoxZENibUNZdENCZTNjSVdSelZVclBUbGFEMDNVQkNQWWNML0pORjYw?=
 =?utf-8?B?Rmo4TDVFUVBUSHFjSVNYU2JCUXp2Mi8xTytrcTJIVnpwbjNVUlM1dWRkZ3VX?=
 =?utf-8?B?cGRiS0NuSW0zRWt6NW8rckNIbTFpbkVWU3dNbkkrZ0JrRVBoRW5TSUFhaVpk?=
 =?utf-8?B?WWZUUjJLU0VPQjJwMXFPMVAzNk5UZnFpbEpSdEtTbks2U3VTZE1SRWc1UmFw?=
 =?utf-8?B?ZnNVWUtzRnFPYXg2aXY1KzluMmtjd25uOVNRdWl4ZkJITmhzYXhPa3VZREs0?=
 =?utf-8?B?L0MweFhsNC9MbnI1YzJNQzh6NjRoL0pEVlZCSmNiRlpjVXhmK3VpdHpIMVlt?=
 =?utf-8?B?T0dNWjc3YURsakFTZnE0bzNLY2xJRVB5QzdvNzZLN0g1V1VVY2NGeWVub05Q?=
 =?utf-8?B?Q3k1NEtKMWtoL1Z4czJMeUFvMXRKMWFuUDJKSkg2K25ObFNXZ1U5RjQyT1Mz?=
 =?utf-8?B?S1h0MDR4V2l5Mk5BOWV3aFV6QnZSbVVaV0IzOFVRUnFOeTFMdmdUdkd5WG1D?=
 =?utf-8?B?ODZ2UlhlaUxqd25KQlVxRGM5Q09rOU10RTU3bG1IT1luVEFQRkg5Y1dmOTBt?=
 =?utf-8?B?VmJNVHdyYUxaVXZMTUkrc1lQamJteFlRREFnR1NsclluQ3ZkV2l5a24wTzJZ?=
 =?utf-8?B?czg4VVpBYUFYcXh5WFlpNkIya2ZYL1NtNmcwUk9OL3JaZVFjUEpqTVdMK1A2?=
 =?utf-8?B?bE9BQU85V2d0SE1veHJBOW1pNDh4cUcvdjg4cFp3S0drbFlvcVd0ZS9IOHV5?=
 =?utf-8?B?bWhmdS9sTXNVRXdPMG16WkhZbTlFV3BJck5vVG5Eb2lWZk9pdjBITUVxK0wx?=
 =?utf-8?B?cEpDc2JzaUZveFRMdFcrRWhRaGF2VXZlMDNIcDNMV1pFMERNaDZqdE9kdGpF?=
 =?utf-8?B?dHZ5S1hWVitwRG05RzZrUlNOSmNOMnNiS2FxRi9zS0tpQ3QvSjV4K0FFUTE0?=
 =?utf-8?B?QmlYQnVQeXhRb1pSeGxTdGExOGdENGVUdkdYaDU1TDJnQXRsb083b3BuaG9X?=
 =?utf-8?B?c09YYmp0bU15S1g2QlBCakt3eEFaQTduRHNGblJPUkVLWkU2QXpJcExwMnRD?=
 =?utf-8?B?WDRiK3RLZXBDZGxjY05lR0hwa1huRTR6cHVUSjFja3ltVEdYWkE4akM1aXc0?=
 =?utf-8?B?K3l3SHI5V0JhQjI5Qm1HQVNGVDF1UkxDNjBhWmM0cG5Sb25SUGt1T244WW44?=
 =?utf-8?B?QXBDYVZWblJWS3ljSnFBYmdlelBhS2N3Zkx1SFFrOWp5LzJjTEtDemlsQTFy?=
 =?utf-8?B?dk56OE1XaDNtSko1eUdSYmpWVUlFZjNjTllleVA4bUhSSHlTYjdpcThacmY3?=
 =?utf-8?B?dmxOOU16M1RGOFJVM2FUTmM0WUVFY000dzdFZ1o2Si9yS1JMMndEbThXTmVG?=
 =?utf-8?B?K3ZoN0JQNTIxSWdhTENLbkVqemE4SzVEQktEV3pBd2pDbE5zYUN0b24rSkFx?=
 =?utf-8?B?NjB3ZFdyRUxHQUIxRXJhUWZheUF6SFl6WWJsdnBHaEx0Z2NkZ1IwZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d7d43d-b2a4-43fa-c7bc-08dea9adf50c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:22:54.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drrS87GbzgDj2J/a95dZH+5FqrWQjAexY2f9aatgLOYscokDHXXnw+OrLHuoSQ8qAYpJPWAMEVvMW1bSAhuNgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3203

From: Jan Kiszka <jan.kiszka@siemens.com>

Let's cite claude on this which I used here to check its quality for
explaining such issues:

  Looking at the end of each task:

  - BGND (prio 20, line 28-32): signals 2<<18, loops back, exits loop,
    calls rt_event_wait at line 32.
  - FGND (prio 21, line 56-59): exits loop, calls
    rt_task_sleep(1000000ULL) (1 ms), then rt_event_delete.

  The intended ordering relies on two assumptions:

  1. After BGND signals at iteration 9, FGND preempts and runs its tail,
     then sleeps 1 ms.
  2. Within that 1 ms, BGND returns from the signal syscall, exits the
     loop, and re-enters the kernel via rt_event_wait — i.e., gets onto
     the wait queue.

  Both assumptions are usually true on real hardware but fragile in
  QEMU: virtualization adds large, jittery scheduling latency. Anything
  that delays BGND between line 28 (return from signal) and line 32
  (entry to wait) by more than ~1 ms — e.g., host scheduler preemption,
  timer-tick-driven simulated timekeeping, demand paging the
  libc/alchemy code — pushes the delete ahead of the wait, producing
  exactly EINVAL.

  Most likely explanations (in order)

  1. Scheduling race amplified by QEMU. The 1 ms guard in FGND is too
     tight under virtualized timing. BGND doesn't reach rt_event_wait
     before rt_event_delete runs, so find_alchemy_event fails and
     returns -EINVAL instead of the post-block -EIDRM. The error code
     itself is the smoking gun — EINVAL from the wait path can
     essentially only come from the pre-block lookup.
  ...

Claude was only given the Xenomai code in next and the extract of the
error log:

2026-04-27T17:06:37 alchemytests_buffer1 OK
2026-04-27T17:06:37    0"078.764| BUG in __traceobj_check_abort(): [BGND] wrong return status:
2026-04-27T17:06:37               event-1.c:33 => EINVAL (want EIDRM)
2026-04-27T17:06:37 test alchemytests_event1 failed: 256

Not bad. Mitigation was not vibe-coded to avoid arguing over copyright.

It's hard to ensure that BGND is actually blocked on the event before
deleting it, so do not bother raising the delay, just address the effect
and avoid a test failure.

See also #52, https://gitlab.com/Xenomai/xenomai-images/-/jobs/11416004714.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

"Baked for 1m 53s" with opus-4.7.

If someone wants to try out different models or play with giving models 
more context, this could be a reference. Or the other issues we have 
open around #52. Still low-hanging fruits for AI - but maybe a chance to 
validate less frontier'ish options.

 testsuite/smokey/alchemytests/event-1.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/alchemytests/event-1.c b/testsuite/smokey/alchemytests/event-1.c
index 9ce679c717..d691192ec9 100644
--- a/testsuite/smokey/alchemytests/event-1.c
+++ b/testsuite/smokey/alchemytests/event-1.c
@@ -11,6 +11,8 @@ static RT_TASK t_bgnd, t_fgnd;
 
 static RT_EVENT event;
 
+static bool on_vm;
+
 static void background_task(void *arg)
 {
 	unsigned int flags;
@@ -30,7 +32,7 @@ static void background_task(void *arg)
 	}
 
 	ret = rt_event_wait(&event, 0x55555, &flags, EV_ANY, TM_INFINITE);
-	traceobj_check(&trobj, ret, -EIDRM);
+	traceobj_assert(&trobj, ret == -EIDRM || (on_vm && ret == -EINVAL));
 
 	traceobj_exit(&trobj);
 }
@@ -67,6 +69,8 @@ int main(int argc, char *const argv[])
 	unsigned int flags;
 	int ret;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], 0);
 
 	ret = rt_event_create(&event, "EVENT", 0, EV_FIFO);
-- 
2.47.3
