Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF3741C6A
	for <xenomai@lists.linux.dev>; Fri, 28 Aug 2026 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897207; cv=fail; b=GQJk77ECd98fyaTfNYj9ZFn+aOMiu3j0sh5ge1EKmyF4w/irhmSIeFFlCDHp9ABmPg+aba5uYPuQ9aNCqxv5XAdrCitzty6w856xyRrG76k+Enk88JX+IP264WJ50eWC68lnxfniS7nRw4hwMFT+0uU9Lznq1DKPXQV2CJg9/oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897207; c=relaxed/simple;
	bh=gHvsWCTHwgmGthGfYb+63Na1g+CbNrfD7nkZmyrLHTY=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=MQMCG/zRj/gKt4y+QBDpKfb80co643SZxcLdqTx6ZvNxEOE5ArUKWJF7aRnp0Qhaq4DxtQTEXaVDdEAi2izxav1wJH1vs9gRf3ASUvyw17ZQizzlewFxMcO9BlhObyHvaqjO32eZqmR+/xP1wV1B/ejPj+J/9/n2HEt6mofxdaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sL+Zy+N0; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sL+Zy+N0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiXtVMuK4Rzn7crtakh9XQxvV6aLWM1oFe1YwcRQV66R6WuVRHA65bA7j/o0/LAo+pN/az+PF+EUAy1WJZChYUt/AGwlw7q4+oYu5iDxuHQ0Es6K3yYi49WgqcbFcHjWDEojo8KxuqVJX/duC4B3kfpzAPwfELI1U16RVvJgVtE4211B0Bcnxk9wrhja9Z7zN/odyO2mMl1lh2g/CsrA0OTGWGvc9ogZcfFjTmZNQzpBEmvqZFlsDDgQ5/afjtZE1RSEmHSysoMx7jyBbHcRAmu+xhUK+0Zmod8fuXZC5VpXGOHt45czXEc5dO6Xtr+LdKRZ+muFU5CDvY+Ih8LqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H0vD5OwZvZonpy1TiEAgOpmAUK0JVSrd8Mo5mxyHHk=;
 b=TL7VzIEB1U8jOmCWxnCp/B3HGIm7Xjx36YZMRzgSaebl1XpmA5sQpYV6S0KJsQauwEvR01jnrIKhSUD7wUt+t34bKFkHjSeXs3pki7t9KGcqf+nrLI7njvrY2Re0JOWhNBdGqHg38ZljlAlzD4k/+C+MYNy7YPtlTo8vpctP84jdX0s9yi63oRd7LyGowKr3ifaAVKI3eRuqUPtR5M/Df2rFFI+A1AGrenW/aJ0A0SkzPM1zmOpXcGzZ14TAGyVY9KUvIfkD1aDX/KyAZR6wP38P2wyq4b1lwlc+wFzxIeZvQumdrQ6wYaX88I9qlH8QPnWD5b9x9gtn4TBuTO0gKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H0vD5OwZvZonpy1TiEAgOpmAUK0JVSrd8Mo5mxyHHk=;
 b=sL+Zy+N0/uWFLeovUuvFubLXiruyUOP+XIVvPHCczTloiZH/ML/Dz+R2EmfRDUVfltTII6L8w0DB/+N/UafGd1vmM3HVZnZQWExgEKZ8pVVBBl1JchpeZon/psQ3oEcE8WQd9kMBYz6xn/lmFnfYL7MyezjC3yXKXKn47bmD/hNkxOCZ+keeF1F/mce5jzItQ/y45uMUOx2hlSHjVRpZ3pjQ2ocQeyqwo5bXx2m+ggmz0e4Xp0W20sHXeJ74sVfWfXMNJk+9lgYJLyO1EG2fKGQ8ZaD3tp/875M1w8KZjONzKh6vRWuYB6jQeRs3NwLiZQAb/KkR5jn+eZ7voj1/3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7607.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 06:06:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 06:06:42 +0000
Message-ID: <b425e881-b3e7-44fa-8682-dddb51188a61@siemens.com>
Date: Fri, 28 Aug 2026 08:06:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite: smokey: posix-mutex: Account for slower thread
 deletion on older kernels
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 87abec8a-e034-4961-647b-08df04ca87d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tLpBBz24Hj9Reagq58SoBSNC2qd5W70tOMKaJxKODDlPYbRF/0nBrrIb+rcGWtw0xpJj5f4aXjj5r7OUjvTQaSvesmyTc6LJ/6CoZOZNeavrNauH+kI47kahltQ179Q5F4+Tr6U8M6PBFMO/yvyOeCiMW8jLVCxneNHT5fHCqlvFE7v/NLU5MZA1cTo9gFjSrTIdZrTKlHGY7Q1ANNyCJlC3sfnrUzkbQAFmmmJPzfmBdMe4uc8hAf4phuqjIEWS1PepH0HpElOaMuciSG/Wmm7P5RmgkUYnqrZeFWfLxiaInW2cOUX6LcICsFLx35EjNGyxDOCjUsPtlZwQl/f0VT7v0KN7BfA+D01M37oO1PaHaf+QF4ijmla/oMyo5XPJXy0gXDk/2k9MgitmVY8qVBmK2tRRjQrAFig2V2uquZjUuFnSJQ1wjNdE0aljwI0xUAVxQaYCtsEOQ1u2Jm4qdo3mQFQrQmPqUi/kJNoLJoBx2siJ4C0ph9OCdRwVTotKp/+ByogMGvfnpBgC25IMGboJuKgM9SIEbUuuBe0rSGTDKaNU7gIyLRnvbI+q/QZAsBnMzt0VklSchjlrTnVn9Exm+BBws6dEeDb6PM78LXqwLRt26j1ME1Q42MIOIl/nfwciAd41b5BUcmjnH/Ioc2qS5lZUWhWpcJjps99Kn2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDJlSitjSmpkbmZ3aS83TUNRM3BqbUxMWmdYQWtvUkIxdGZGR0wxTjY1QUVt?=
 =?utf-8?B?U1QwMnJrV1JHSXNIUFlIN0c0b3U4R1pLVnB6SnBLK1lpczF6MzAwdXVyeks4?=
 =?utf-8?B?bnRwdVFjUDl1SnZQYmx0NGdreDdBMUlzcmtjNGorK0VmL3UvM2RmRW9oOTB3?=
 =?utf-8?B?Ykt1RmdPVXhsZE5HcE5YRUhYQ2ZSWDBHVEpLdnJiQ1hBYk93RjJHdFZ4d3lv?=
 =?utf-8?B?Snd5Y3B1aU1acnRZRVFrT09xUllIQzBUeXluWjI0WGJKclpRWGRFalJocHM2?=
 =?utf-8?B?dXFLV3ZzUWJGTmc4VTZKTGJac2hUMzlrMmZ0cmc5aUdKYU5ZZHBpcG5MMUQw?=
 =?utf-8?B?V0hnSUpMS3JjbVRVYk10OGg3OVRzVkd2KzY3TFlRb3ZLMUNQSFBJa1RKd1RU?=
 =?utf-8?B?SVRocGZDTVEyTFI1YUtXUmtQVWNwb3pSQzBTZytyODhtTGl1ZUgreG5XNVd2?=
 =?utf-8?B?dHJxVTQ4YVNOMGdqdnRTZG9tSnp5b2FjL0gyb2RQdnlCbmhYSHhzRWZ1Q24z?=
 =?utf-8?B?V24rQk1yWDVHSXN3OTdwS2VxU080MHZORFVIbnZsUTAxNVJJRXM0bTFvZnl6?=
 =?utf-8?B?YnFJOExkOEU3TmtJK3BqbWxKWERJQitIR1MzSUcxakltSUVOWDNtTDNuT1NG?=
 =?utf-8?B?SWVlUVZjNHN2ZFZTWVY2aEd0NjJUT1JaN25lcUJKREpmdEIrL3dEM0c4REx1?=
 =?utf-8?B?MFVxOXA2Um5mdXhTN2srNHRZeW1OcnU5WS93ajFrNTN0RDZVMDhZM3BVV0NC?=
 =?utf-8?B?a1dhYWllQzIvQ3FqSm0ycmVoNlpZeTVlRzBXSXI0bHZ5UUdCRGd1TFltb0JP?=
 =?utf-8?B?OVdTUnlBMjEzaHdMd21rRUFZY3hKNFdzN3dQUXozYWxCVFB2bnhoWSttbVZV?=
 =?utf-8?B?dCtqVmRzNjR6Y0hDbFBhOFdzaWg1aWw5anplcm0xUTdBZTc3ZitkdXp5cmZ2?=
 =?utf-8?B?SFdpR1BVbml3RWxyZFJTUWZqZWtGRCsrMkJNb2pVUXlKQ2VyelpvSnRFKzN1?=
 =?utf-8?B?L3R1ci9sSEZRenZ2V045OTUzbnUzZ21DN1V5eFpHV3VpOS9TZmJGa0FKaDM5?=
 =?utf-8?B?d2xnYVhHb05vZk8xVkt3TW84SzE0NmkyajR4UTZKc0JqcjMvL1h2bFQ1TjRl?=
 =?utf-8?B?TnMvNjdKbHc5d0lSVDF6Ny9xK05NU2RrM0FySmtnOHY1UzMrSmZ4N2hxcG1u?=
 =?utf-8?B?bEN5eDhaK0lMT0wwV2pWZENZdjkzUXZqcktnc09YWEJJWW56WGlPd09JWitr?=
 =?utf-8?B?YWdyTE1aZ2lPQlp0cHZ5aEZOSk91M2ZENVY2N25IZGM5UHZzMXBzM2I1aXpC?=
 =?utf-8?B?SHFyazNOSFVSQm4yYjhHdUlpTjNUUUZOSDFJd3FzTzNHUlhKenp4VGM1NVdv?=
 =?utf-8?B?MlYzQTNlRjNBdzhPTDBCem1IWk5KZzRGMEpNTnQxVEJxcDVYcllGVGNrNXcr?=
 =?utf-8?B?TkNBMGkrWG9VZHhodGpWY09oL2hPbURvRmhjVDU0NUFNTkdYVmlXb1gvblVW?=
 =?utf-8?B?Z3JOU0Z0NzVtS1ZJbFJaUnhxQ2pMU21wQXI2MEd1b2hQZHdGTHJQTGs1elBN?=
 =?utf-8?B?RTQ5aVBlNXluK0tIVmpPSEFZN09MMHJ6RENPWkNMaEVJT0hYK21Ib3BNNUVu?=
 =?utf-8?B?Vmc3YU5FaWlJU2hFbTBiQ2gyeXhWVTAyWjFMSVRSV0hZOWVmOUFSR0FKSGp3?=
 =?utf-8?B?SC9PWGd6cUNFTGRhdkw2TjRWb2U2d2VWTXZjcTB3aWR2RHdoSDFHRWo1RWM4?=
 =?utf-8?B?QTBsYXlzMWkzbFFZWEJQVTRzTXlZcDcxYWswRU1pbkdNaytJRVhUcHNNTDlk?=
 =?utf-8?B?NzBMbnM1TzJOMGg4S0ZUcEVUdThpcXE4U0NlaVB4S0FhZXVGSmp5Zkt0eFNP?=
 =?utf-8?B?R1ZpeUNKaU1Zc2FPREcvMU5UbUo2S0VRaWRsN1piN1Q3Z3hJQnZXakhud3JI?=
 =?utf-8?B?amI2ZEdHTEs5SE9nZGZnMWpKV1NYLzB1K01Vc200ZGhmajV1dkFyekQ5bHF5?=
 =?utf-8?B?clMwSytFaEx4VkFXTG4rV3RxK21vZlduTGhqUGtua2haMGZQNWludWh6WXdq?=
 =?utf-8?B?dmp4RzMzcXhib3kyNXp0YUlva1hEbDhDVW1Sc2h6S293cC82aEcwSXR5bHRa?=
 =?utf-8?B?Z2FyL25Ed0JybXRQNmNQR3c3SmxYYkNQYWpjN29lRWpabDBRdGZKaVpsSm9C?=
 =?utf-8?B?Zk9GU0xIZ2p5RFNmMkROWFZEd0g3VkRrdGdHcXFJNjBhZHFwenIrR3cyM0VW?=
 =?utf-8?B?dVZ2RWUwZFF4eHFYZXJKRVlxckhKMnd2WVBkcVlJcVhLR0IyWmRkYllRTWZw?=
 =?utf-8?B?K3hpTHNmVmxGamplUWMwL1pFRW54d1JvaGlPaUE4WXYwOWFCLyt1QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87abec8a-e034-4961-647b-08df04ca87d0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 06:06:42.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NA4ck6AozPPx5m088P8SZlPCk4xYCqes1ipEGJJr7GOoWYqpiYQQzfJLdxLDx10ewqIh4oyLunUS/OfxikoCkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7607

From: Jan Kiszka <jan.kiszka@siemens.com>

Due to [1] and missing [2], specifically Xenomai's thread teardown can
take significantly more time. So much that 100 ms timeout for certain
tests are no longer enough.

Rather than porting synchronize_rcu acceleration backward, risking
subtle kernel regressions, we are better off with accepting the slowdown
for now and relaxing our timeouts a bit. At least on ARM.

[1] https://lore.kernel.org/lkml/16fda1b1-2c72-4d05-b1c8-f424ac2848c6@siemens.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78370df5c3574cdc5c6de7844481b4dc0ef4f172

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Upstream promised to look into the inefficiency, but that will take 
time. With this change, we can move forward with updating 6.1 and 6.12.
5.10 and older are not (yet?) affected by the original change.

 testsuite/smokey/posix-mutex/posix-mutex.c | 55 ++++++++++++----------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
index 50f894062a..1e315e106e 100644
--- a/testsuite/smokey/posix-mutex/posix-mutex.c
+++ b/testsuite/smokey/posix-mutex/posix-mutex.c
@@ -56,7 +56,12 @@ static void sigdebug(int sig, siginfo_t *si, void *context)
 #define THREAD_PRIO_HIGH	3
 #define THREAD_PRIO_VERY_HIGH	4
 
-#define MAX_100_MS  100000000ULL
+/* On single-core ARM and kernels < 6.17, some tests can take longer */
+#ifdef __arm__
+#define TEST_TIMEOUT  300000000ULL	/* 300 ms */
+#else
+#define TEST_TIMEOUT  100000000ULL	/* 100 ms */
+#endif
 
 struct locker_context {
 	pthread_mutex_t *mutex;
@@ -1435,30 +1440,30 @@ static int run_posix_mutex(struct smokey_test *t, int argc, char *const argv[])
 					    SCHED_FIFO, &param)))
 		return ret;
 
-	do_test(static_init_normal_destroy, MAX_100_MS);
-	do_test(static_init_normal_contend, MAX_100_MS);
-	do_test(dynamic_init_normal_contend, MAX_100_MS);
-	do_test(static_init_recursive_destroy, MAX_100_MS);
-	do_test(static_init_recursive_contend, MAX_100_MS);
-	do_test(dynamic_init_recursive_contend, MAX_100_MS);
-	do_test(static_init_errorcheck_destroy, MAX_100_MS);
-	do_test(static_init_errorcheck_contend, MAX_100_MS);
-	do_test(dynamic_init_errorcheck_contend, MAX_100_MS);
-	do_test(timed_contend, MAX_100_MS);
-	do_test(weak_mode_switch, MAX_100_MS);
-	do_test(pi_contend, MAX_100_MS);
-	do_test(pi_nesting_contend_multicore, MAX_100_MS);
-	do_test(steal, MAX_100_MS);
-	do_test(no_steal, MAX_100_MS);
-	do_test(protect_raise, MAX_100_MS);
-	do_test(protect_lower, MAX_100_MS);
-	do_test(protect_nesting_protect, MAX_100_MS);
-	do_test(protect_nesting_pi, MAX_100_MS);
-	do_test(protect_weak, MAX_100_MS);
-	do_test(protect_dynamic, MAX_100_MS);
-	do_test(protect_trylock, MAX_100_MS);
-	do_test(protect_handover, MAX_100_MS);
-	do_test(check_timedlock_abstime_validation, MAX_100_MS);
+	do_test(static_init_normal_destroy, TEST_TIMEOUT);
+	do_test(static_init_normal_contend, TEST_TIMEOUT);
+	do_test(dynamic_init_normal_contend, TEST_TIMEOUT);
+	do_test(static_init_recursive_destroy, TEST_TIMEOUT);
+	do_test(static_init_recursive_contend, TEST_TIMEOUT);
+	do_test(dynamic_init_recursive_contend, TEST_TIMEOUT);
+	do_test(static_init_errorcheck_destroy, TEST_TIMEOUT);
+	do_test(static_init_errorcheck_contend, TEST_TIMEOUT);
+	do_test(dynamic_init_errorcheck_contend, TEST_TIMEOUT);
+	do_test(timed_contend, TEST_TIMEOUT);
+	do_test(weak_mode_switch, TEST_TIMEOUT);
+	do_test(pi_contend, TEST_TIMEOUT);
+	do_test(pi_nesting_contend_multicore, TEST_TIMEOUT);
+	do_test(steal, TEST_TIMEOUT);
+	do_test(no_steal, TEST_TIMEOUT);
+	do_test(protect_raise, TEST_TIMEOUT);
+	do_test(protect_lower, TEST_TIMEOUT);
+	do_test(protect_nesting_protect, TEST_TIMEOUT);
+	do_test(protect_nesting_pi, TEST_TIMEOUT);
+	do_test(protect_weak, TEST_TIMEOUT);
+	do_test(protect_dynamic, TEST_TIMEOUT);
+	do_test(protect_trylock, TEST_TIMEOUT);
+	do_test(protect_handover, TEST_TIMEOUT);
+	do_test(check_timedlock_abstime_validation, TEST_TIMEOUT);
 
 	return 0;
 }
-- 
2.47.3
