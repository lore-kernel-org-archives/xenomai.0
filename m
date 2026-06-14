Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D659C29D275
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465851; cv=fail; b=Ya+CNgWFPV/Ewg4MCuoGvfwIkC3qnUBHim2+McFCMvbFWPm7W+Th6/LVPFNn6MNbsWaEYrNHXcQq+PelnWnPq5YMrlDdEc6RUdxayI5hrA4X8tOKBkMv2ku0hBG7zT6lGvAYrxkD6b1NHx6Z5Io1ywbZKh6X0BrbPmWl0hMSHmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465851; c=relaxed/simple;
	bh=tG++eJm/uzd1jfCKuW5SDHUb3GToLJsgcdJi4GHfYOQ=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DiXSbD9/y93NAJU1xG+IH83Tp21PEMSpkhbQT50KG6G5BrMZ/hgmQG/IImVC+2ih1sOnbjoJqU+oi5B2iHuW5D5oLbHf6pTtA2LeJ3JrMY+RjFB7wCIKXGHfBmoLDsITEtjpWUgAMov/d/v9x8kDdYVEjRD+1x2Ox23jq/tAt9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wDPglrRc; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wDPglrRc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRr1oi+mumy2aitireBwo2ICO7WClV2OikYxVD/hzel1BsLwSoD9gUGoPRaBqhXBNey7YKh2YOzkHnDBaTLFNXqPhYetYMRwYjYVVzw0UvCnKBeXMfUfUQEvdFjfj2AKEb8rbmk2TVweZT7EuQn5mq7v0k/hhyovCGFlv2UbPIXbliiJeoAWtDuCGCgUfUk+QBhNqio7iahzKPbpbxijLeh8e7YZ5XiV2GupcTtVe6IUSqs93670lM3KuCLDISqjgxwQRFSWRfqDCMUU/GSztsrVqwI7rv7woCIQSb1cuogxhbrJh1itxRFoqsEZ0m3JR3vc58m/yNviSMNPJQAdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enQXnNFAI4ksQL3aHAGU13txEa6pBURbylPw17VnDho=;
 b=iz5g49md0jV3zNovozq0ea6dqdCoFV/CQep51COOzITa+0DOFUq5EDCWfQoY2gIhbatSHSBn8353A+EhWgQdleOtaYIatwrehenHmBHsfHHdXL2dmXsi6A9dsktZkxbN7ubuWA5phuo6v6Fe+6yGvcv1XelQ66GrJw0xQaPwuWcN04ySw7qwOU6TNwn1/+lFuyeeGj51ro/0bVLrMH/JoR2xlLDaEyBIra2PsZCRdJ8zwlWP8spjpxrKTme6EX3qMzfVVT50NFuZ0GLrc53zzabtatE6JZgt7TwAFkMbZx9w5oTLmqsPBj+gaus7V6LYRF9bxu+2RfXIUaxXAdtGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enQXnNFAI4ksQL3aHAGU13txEa6pBURbylPw17VnDho=;
 b=wDPglrRcrJTDLSCON9AoZxQSQTNvZaE2FPVxJ88PBvw0YgUb0KtcsMbpzGMukLNn/lHuWFEo6ZLityJ1AZS73VRv4rFcLAr6ws8+RT/FK5q/XJDzfiqxClOlw9GTZolsoXzulJrIeLRKBmoQIzIQieuYnx8WEBuT/z1MWhvDjm/0HnFMOR3dEdkWEpBbCJYmBLy93b+yp91nu0OtFzzYVZ54/uj9D5MTXuzzyyfq/UgEyku35YKbjAr94THfeGQX7SgpmyNUuxmwRAtop05w9oEWvw2Y/mZnzHQxT2Hw2OIaTLpNuR9WBzkXattAvQ+jDI0Dw6cC0JxtYm/36U7Uug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sun, 14 Jun
 2026 19:37:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 19:37:27 +0000
Message-ID: <38c143a3-5021-4617-ab2f-ff3c9f3adc74@siemens.com>
Date: Sun, 14 Jun 2026 21:37:26 +0200
User-Agent: Mozilla Thunderbird
Subject: [libevl][PATCH 2/2] tests: sched-quota-accuracy: Add preempting FIFO
 thread
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
References: <83bfeeef-c3b2-473e-b94f-8d270b0a512c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <83bfeeef-c3b2-473e-b94f-8d270b0a512c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: a64ff75e-6bc4-4ad0-96a9-08deca4c5dbe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|55112099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	MT6RXntMdSwUXJCftz1a5+dZjUBngNqMW4Q3Ith6h6oVaSbQxYen38ljDssu+++90hyNTQj41QYCRmMTMd4YBnTRyoRRwI/Q+70YZsRkWzwygM/1N9qggOR9y5ex6HwA9piMh1WhNxEAiQ6dB3Jw3W7ecxgYrUdVYCvkIwhrgVPk+R5NcUr60d2M9cd1ajLK9yS5Ytl9N9xJZeMkXYu68vUc9o6RizmhzwVhP38uKOhsHH+8vg+xXmgPm+Mz86acjtfUZZcld1j/203fVcR2SZaqX5+ToA5hILvFRR0M1qed5xU1r/p3exvdbFEu1q3tS9pJKWr2765E3FFpXFwTrs8WCLbf5b9o0T/hMPgNq9agAu3RXUibi3kFcWd1iI+1U5wHEn9f3RkPDNpZw+WHCgtO56Vrzd7ztwm4tEN7GiFH1ND8+N/mLeS7BFldlf9/rrpux/S240Xl5rZjXBgPAuhDE1Jxi1JtjYbJZx59KtMZDnLPkkupLyzG+wX0DxDfqujuvhtbnHwA+1LUrXFhzPGuTjZsfv47eaxRRhzF2IEwgYP6njrxqilGPxBsI5m0tx6he/dkS6Rw5K+ypGOcdZDMSc/fnMaGAbcQ759ctGSkLijAgDPY6WkWqSW3zfAmSY9efx1KivMsPL4tx9kp/o8z/svMe2ioHpXTzRuhLzJOHcZdPlLWIxtKw6C8NwRf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(55112099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yng2WkgrYnlBbW15QWcxVVpYaG9tSnkwbzBOb0tmN0lSYXZoVFprSVJUdGxW?=
 =?utf-8?B?WlZGb25GQVZoTnV2MTRKRmtCcXdKakVhcmRIMDJDOUFkU3pJQ20rcWcxVGti?=
 =?utf-8?B?TEpma1JpRjBGWG9tc0Q5dldGOCtFRWxsZ052NEdJaXgwK2NPd3MyRjBMaUph?=
 =?utf-8?B?Q0c5MGxtb0tUc0o3Qi9PZ3dxTTVLSUcvVmd4VE5jai9ITDFhTjI4dTQxWDdn?=
 =?utf-8?B?RGwwT05UM0RsRTRFclVkaG9aVkZjVkFIVW5vTHJrUXJIYW9qNVpBMDlZMHo3?=
 =?utf-8?B?NkUzNHJtV2krWFVKWklMK2hPaEVIb0tIQWxTemRITklOZ25zUElDc0Z1OUVj?=
 =?utf-8?B?aUpJK1JmYkZmT0svNS9PYlFkWmVLM3FOQ1RYMHhCY3JRRUphc2xvQ2oxdzA0?=
 =?utf-8?B?MzJRWUdLUXhQQ0l4YTlaQ1g2cHJZdzk3VmpnNTNza01hWFJKSEJ5eVM1RnpP?=
 =?utf-8?B?L1FjN2NzNVpOS1ZVcVNZQ1p4cG55d2xad3ArMkt3UTFMM2dGZklqOVduWEZn?=
 =?utf-8?B?ZmpFdG0wNWtTZkdiUFF3L3Y4d2dGc0ExbnJNTndVODlvajgxbld2cVBmaHhR?=
 =?utf-8?B?cUlyTmRJMm1zTk0ycWZyakZMalY3RFBZSTI4a1VnVUxPQWU2RmJrY1phdEtE?=
 =?utf-8?B?TmhpQVF6VjBGdnk5WGpoNUo1Q3Y2c2dGUlI4NmxJR1JSSlJtNGtOVFpnNmNw?=
 =?utf-8?B?aFlCS09xWm9oUXBrNGZ0TVVyU3JJaUx2aHZHWmRHdFNJY0xCeCsrYXNRRFJJ?=
 =?utf-8?B?amlYYm85SVk4ZjNsaXZobk5kdE9sSU9ydjRyb2d1VkIvMFRhaUhwSU43NS9v?=
 =?utf-8?B?U2tZbEwxRXpLQTJoNjBpcXhVdmJ0aGtPL3BxTU81Njd4YmMzWTNQS0dLRHVt?=
 =?utf-8?B?TklQSjdLSW0zSlJyK0UrSHlMZ0JlSUNGT1o5TGhlYk5PbW93Mm4rQjZ5a21E?=
 =?utf-8?B?MGpocVNTL0Zud3IrVTg0Q05TVll2RHFuSUJiVVdldlNhVXRoZUxTZ0x2eHYr?=
 =?utf-8?B?bGQ5NlB2Nnl0Wk9td0xsYmZhaDNHUFdSUS93Tkx3T04rYjQvQ09MVnAxZzNM?=
 =?utf-8?B?Zy9JMDlCc2RWL1Rsb3JTR3NCb3FTeDExY21SRHRVVk8ydkEwd3hjcmZGRFlS?=
 =?utf-8?B?UHBvMWZQc0JML0xsT2xabjdvemltMGtuWGozNGVVeE1WQmlrKzcyVEhmRW43?=
 =?utf-8?B?SWlKZDlySjk2TEk1RUovVGJJRzhCdWRVNFlTeDBJU3RVNDhBQ3l1NG1Za2VV?=
 =?utf-8?B?U2s5cjhidzl1WmxSbGFsb0tER0d5TVNCNkd6c1lVbEVpMXBDRG5JRysybTNJ?=
 =?utf-8?B?S1E4K2V3N1hOWTFZdHRFRWk2TzFrQWljYWQwVDh1d3pIeVRiemU5UjV4dU1m?=
 =?utf-8?B?aUlEbm5zeStOQjl0N3dCTnM1czNWR2wvZ3VnalhuQURqazNUS2hXOEFNNlBn?=
 =?utf-8?B?QnhPbnJreExYR0NieFdKQ0UwSlNSUUUrZlVrYnJjdS9Pa292dnRmcnhDUFlU?=
 =?utf-8?B?Z2Z2WVlJMFpJTmI2dDZoWTNSZHhieWgzSjBDelJHd1JBNmZFRFhGL0JEbk0x?=
 =?utf-8?B?RUE3a2sxUFpZZDA0RTJNS3FCWjR3SU95Ty9vVzFPTGMxT2FycWUvYUJpZTM0?=
 =?utf-8?B?bVJjR2U3NHplTHZ0SmpnT1QrazhPUW1ZajlyZy9ISC9RWkFvQzRnTCtqWGo1?=
 =?utf-8?B?NmF0MDVkRmNiRkRlU2ZuMWZFZG9mRmNwMGdiTTNZSms4a04zcTRmM01MUkM2?=
 =?utf-8?B?TDVVRC9JUnh2dGlyMWx1Z2Y1VUdhTFVwdWJEaThwRXJSQjhQc09UNTQyaDlh?=
 =?utf-8?B?NUlvUjFvNHpsK28wakNQZTcvV0dKc09sNDl5KzEwdS9pUy9LbnlocmRQdFN0?=
 =?utf-8?B?RHY2bDBhUmN1eVBrNXliWHM4d1c4b3BuSWQ4MjkwUVpZQms3cjVBYmc0d05v?=
 =?utf-8?B?QlVXSXpzTzd6WUxYdU1Cc0UrSUthdXZFNEs3Y1o1dkZvYWJhWVpkOGNLZ3Fr?=
 =?utf-8?B?VHVvVUJqQkFxVzk2S0o0V1lMVVhocWwxSmpnOFZsd0RRMkVweUw2YUNHUk1i?=
 =?utf-8?B?YVNsbTh5eVUwNlNhWEZKVUZmaWhWVjVOWi8xZUZFV3k5cmlOSS9iWHQzT1E0?=
 =?utf-8?B?ejl5aUp2T0FJcGJLNGhhZVMrOWJDYUc5N3JiT0xKRnN6NURWbW0xWFNhWFlB?=
 =?utf-8?B?eE5xeUhzVTc5N0JFbnNRdEJINUV6MUdqY2xLOVdqWUtKRmVuWkFqWjF1YmNO?=
 =?utf-8?B?SVJsRTVMR25LUDQ1TW1BZEpTQkFFTXBESDJlQ1RqSmFMbkdLOTUwK0gxbDNx?=
 =?utf-8?B?bHF3NWNmak9oakJlVkxKTXdtaEorUzJJdXJORFRFSVBWL3ZQek5FZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64ff75e-6bc4-4ad0-96a9-08deca4c5dbe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 19:37:27.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rm59P/NSv30N7qV8oLU1I0wmG+ox3a4ZRc5wRjGP0d8azD92MKfTLRBSzyghYYrwxzVDlHg0fiHJcoJmVJ8efg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7382

From: Jan Kiszka <jan.kiszka@siemens.com>

Test that higher-prio SCHED_FIFO threads do not run on the bill of
SCHED_QUOTA threads and that their accounting is not otherwise
disturbed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/sched-quota-accuracy.c | 55 +++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/tests/sched-quota-accuracy.c b/tests/sched-quota-accuracy.c
index 278ff1b..f48f034 100644
--- a/tests/sched-quota-accuracy.c
+++ b/tests/sched-quota-accuracy.c
@@ -34,7 +34,7 @@ static struct quota_thread_desc {
 	pthread_t tid;
 	struct evl_sched_attrs attrs;
 	unsigned long count;
-} threads[MAX_THREADS];
+} threads[MAX_THREADS + 1];
 
 static int nrthreads = 3;
 
@@ -165,6 +165,41 @@ static void *quota_thread(void *arg)
 	return NULL;
 }
 
+static void *disruption_thread(void *arg)
+{
+	int serial = (int)(long)arg;
+	struct quota_thread_desc *t = threads + serial;
+	struct timespec now, to;
+	unsigned long loops;
+	int ret;
+
+	set_thread_affinity();
+
+	loops = crunch_per_sec / 1000; /* yield every 1 ms */
+
+	__Tcall_assert(t->efd, evl_attach_self("disrupt"));
+
+	evl_put_sem(&ready);
+
+	__Tcall_assert(ret, evl_lock_mutex(&lock));
+	for (;;) {
+		if (started)
+			break;
+		__Tcall_assert(ret, evl_wait_event(&barrier, &lock));
+	}
+	__Tcall_assert(ret, evl_unlock_mutex(&lock));
+
+	while (!done) {
+		do_work(loops, &t->count);
+
+		__Tcall_assert(ret, evl_read_clock(EVL_CLOCK_MONOTONIC, &now));
+		timespec_add_ns(&to, &now, 1000000);
+		__Tcall_assert(ret, evl_sleep_until(EVL_CLOCK_MONOTONIC, &to));
+	}
+
+	return NULL;
+}
+
 static void create_quota_thread(int tgid, int serial)
 {
 	struct quota_thread_desc *t = threads + serial;
@@ -175,13 +210,13 @@ static void create_quota_thread(int tgid, int serial)
 	new_thread(&t->tid, SCHED_FIFO, 1, quota_thread, (void *)(long)serial);
 }
 
-static void create_fifo_thread(int serial)
+static void create_fifo_thread(void *(*thread_func)(void *), int serial)
 {
 	struct quota_thread_desc *t = threads + serial;
 
 	t->attrs.sched_policy = SCHED_FIFO;
-	t->attrs.sched_priority = 1;
-	new_thread(&t->tid, SCHED_FIFO, 1, quota_thread, (void *)(long)serial);
+	t->attrs.sched_priority = 2;
+	new_thread(&t->tid, SCHED_FIFO, 2, thread_func, (void *)(long)serial);
 }
 
 static int cleanup_group(void)
@@ -235,6 +270,9 @@ static double run_quota(int quota)
 		__Tcall_assert(ret, evl_get_sem(&ready));
 	}
 
+	create_fifo_thread(disruption_thread, n);
+	__Tcall_assert(ret, evl_get_sem(&ready));
+
 	__Tcall_assert(ret, evl_lock_mutex(&lock));
 	started = true;
 	__Tcall_assert(ret, evl_broadcast_event(&barrier));
@@ -256,6 +294,8 @@ static double run_quota(int quota)
 	for (n = 0; n < nrthreads; n++)
 		pthread_join(threads[n].tid, NULL);
 
+	pthread_join(threads[nrthreads].tid, NULL);
+
 	/*
 	 * Percentage of completion of the SCHED_QUOTA run for the
 	 * given quota value, compared to the calibration run which
@@ -301,7 +341,7 @@ static unsigned long long calibrate(void)
 	crunch_per_sec = (((unsigned long long)count) * ONE_BILLION) / ns;
 
 	for (n = 0; n < nrthreads; n++) {
-		create_fifo_thread(n);
+		create_fifo_thread(quota_thread, n);
 		__Tcall_assert(ret, evl_get_sem(&ready));
 	}
 
@@ -400,12 +440,13 @@ int main(int argc, char *argv[])
 	effective = run_quota(quota);
 
 	if (verbose)	  /* Percentage of quota actually obtained. */
-		do_trace("CPU%d: %d thread%s: cap=%d%%, effective=%.1f%%",
+		do_trace("CPU%d: %d thread%s: cap=%d%%, effective=%.1f%%, disruption=%.1f%%",
 			test_cpu,
 			nrthreads,
 			nrthreads > 1 ?	"s": "",
 			quota,
-			effective);
+			effective,
+			threads[nrthreads].count * 100.0 / loops_per_sec);
 
 	/*
 	 * The accuracy value is the alignment of the observed runtime
-- 
2.47.3

