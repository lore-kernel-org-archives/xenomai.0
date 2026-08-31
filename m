Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4142CAF6
	for <xenomai@lists.linux.dev>; Mon, 31 Aug 2026 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183021; cv=fail; b=c6ugQ+TEEw4+TiqKgDAfWvdro0sjKOITUprh6HsLg63uoMZENA1JkMPdSpS1CHB2zOArqTW708LAsejkxbYpWe39aHNv6gKQ8L+i1kEw1dj+8xtGX5N+Y0GU5XyqGlMe96bmrxbTJoimYOwAdkYxhbawXdjMpH/P5pm2ai8LKpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183021; c=relaxed/simple;
	bh=+YV351aWCJQotNVRC15MDTb4ODTS5I198wZMY3/w3q4=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=EjyQJUn5aEYyVZVADRsiLYnelo7Pb9gtZ5QJXxK3h83OVLUIbciJ0f4glI2vZ+Rp/eaxRo3XsHGEWokx3QkVsmsSRLRQsDmozvKTB7vIMdbfvYBBuKR1SUTOmCsoLw3+UdJm3W22NCFEoY2oxVMPcMLRmW5R1akUVSbGzj5UGCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XNqP0FbU; arc=fail smtp.client-ip=52.101.72.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XNqP0FbU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/ysgzTxmdfmERI3oh2u7E7qr0hlig0WuuPvj5a/7nlt7WTClFUT0lZd4QwhyOKPKDLNy5F7NNrICTXVxjov3KiYSvCeerb60moeJHruWgnlOxpWx4vEpKe2n9e3Eigd6juL1fFtmoMfuepYdI8nrwPag7vNcX4eF27fn+NfkL6Bgy+RnfCZ4pXHzEPm56hz9fgFkXl8T28MKbculEsSuqXe8OZvk5Jmawgk2aetzskUAT4dHqzWV2VuxWXlt/n3aQMJi9X1pQK8kWhA4Gifr+TiRNZha3fMa2xnaRH9GcuOHQWhLiRR5r9QjGkV0frz1PfcCzWQENswM6C/Zqeu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2+spCQWH/OSQfdUTU9vo3i67j32uMRcfGIEB+nvt5U=;
 b=Cpg9RQTjbmQe4TisqqTofVy2veejXLyM8JqKa/VGXruXKh0Fsy2nT1MzR3JXHbQNizUOqMW7WT8JxBsw3r270Py9f1RIMBxN0No7KwpyyrGSRWlrnsLTDqkaRbJ+WiAjgNkN6duHimjEdMPq3YgfKecqKB5hYCJDaBUjvzqVTQ1M24O6JoLHW5frTpH34AZcIyd22QVEB/rnAOn3H9okXIPx0COr7z+OhIKCeqBqZFmxGqcQn4FjFqxZC6qWbO4TbRxx8bW7b/75W+xREGt7hMkzPoa1yX9TOPFPGTTTR4Y/FtKOQ4YdHQP8DJu0g+YvnpbCsnHbqr8ECA3xQdsL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2+spCQWH/OSQfdUTU9vo3i67j32uMRcfGIEB+nvt5U=;
 b=XNqP0FbUG1+bojryQrTFJSSXSdEb4ggUaB0FRNFsgDLEl50/82A3Rln38dW+FH0JFVT8xQUWWO30dCN92+47zJkIm9zZ717xGMcGasfN2lfYflyuG5JSsi/VJOXtKVbiHhzU15dkQ5inOUDjMBRaoaqUTXs22XNBC8n/5DxhEFy0JJhk0UviM5v+Ln4o6+uPQhKKzEHDCBpB9FpQXWY7Hk6Byu4fp9Po52IqT8KqQ95gQkYe+/Hr8LxVKuinMspsd3owm+5taPZEXAS1O44IHyruJYXyE7+zaLngJ5tkeoPkJAN1QTn6dDIZvm3qYmrKSsjHWkF0rE0Caf38UxeHLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:30:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:30:15 +0000
Message-ID: <2776b343-0622-4f57-b806-094f0120b220@siemens.com>
Date: Mon, 31 Aug 2026 15:30:14 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: [libevl][PATCH] tests: sched-quota: Synchronize all threads before
 readings stats
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0635.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca1b7d6-bb78-485d-f82f-08df0763fd9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|55112099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	/1/Jwx6eDloMrnrKQTExtgfcxcvJWlPeJfnqbUPo94slr1NCvmdZpqAZtFQNyxp7SNg/kY43u0Zzm0ohIxcsoVEonIvRisBo47LLryuIXaJ7mCYjWoysdttdrwJ7vPBJr+w1iOKEoSOnMz2zwfskkrWKk6LmmGLXe2lsVe1W6X1tgpAziz2KPDW9qWmrnSGzAHezb/ZjdyJ+LBagPMC/eB6A5ZlET5rmWdHQysBzmGeGqrSI2beM+cmw+CGQU76sRhEf+ymHJyI9nvabMtZd6Fy5G0nGW0v3/a+AUZc5H6RNXW1O9gQhXt7b5ePCD1OMNrDuIMXQzFxr4FT9D0aIAMJkLjiX1a8ujo8WwMoY724rRDweavZmfMCwF2cupvU6eM+GUDSOgx6DGUB/pOEbv51BEgCxY9LF1AF3ZN9rqvRVQmI24CpkzWdZEf5fiPiulHDheaJuJ0TIJcSg9mxftjVhHJjByuXZ97/j/qix95K5rT3+sj9tMXULvbUrehjWTQ5DZO4ELFxtSjqA4//5RRS42PrynSAn/Awuwy+wZRQ9S6JzoPEdM0KR4nLe9ZTXfk4jBuaSaMQj/79CET8/OzK0kuNl7sYAJM2whevuBO3ddmpsU5THYAJigDwrllcwNi/sEzWgob2VzxO5BIRdIIHI8bE2r4pMjektZ2+w2T0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(55112099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnNwQXFSREVSREcxTVgwdFNlY0x6N1I2MFhQYWdVdEJzMXVXaXAvZlR6Wm9i?=
 =?utf-8?B?dEVrWlkwZEJnKzdjRnhHdmZpdGVaVFQ4NlMzUGkyaHR6QkkyQ0NSWUY2MUdN?=
 =?utf-8?B?SDZOMUthdVBpWCtHWERsWDVPVUdzOFllMXRXQzcvSCtMSUtiUVdFSUZFa1M2?=
 =?utf-8?B?ZFR0Ti9tTG1IeHVMa29NbzVmRU1DU2FNZzZXMVk4dUE5OVVDdVM2bU5waGhj?=
 =?utf-8?B?UzVnam5UNGtZMW5oSlI5V3MzL3BmRGV1R3BDMEsvQ1lESFFZNmp0QWhlcEdu?=
 =?utf-8?B?SEVrV3lYbyszT1pJb1RDR29xUzViVG5qUSsxM2lhcUM2UVQ3T0J5dUwxQzkv?=
 =?utf-8?B?WXlNUGJVNFFVLzg5ckVVT3Q3clVSdDBxcUtvVTFRajF5blFkTjg4YWliWWw5?=
 =?utf-8?B?NG0wK0JXbDZEK290RHpDcWsyd0ozZHpLUzlXd0ZiRDRpUWxlL2hGc25qcnFr?=
 =?utf-8?B?MUZ4MlZmVk1Wa2NHL3A3UlY5ZWxsUDE5ZTU3Y0FYUC80N2d0TlM1RnQ2blcw?=
 =?utf-8?B?b1g3ZTR3L3F5WDB1TzRYOWNKVUtSbFBjYjdHWUJJSXNLelpiMk9vRDIxaXNT?=
 =?utf-8?B?UXVFVit4U25icUhFSEFsNEF4eGFycFpDQUk4OGxSQXhUTjB1dTc3UDhMUFNw?=
 =?utf-8?B?NEl2V1FVYmVvNjNRR2dkNUlCRGd5a0UyczVwN3l4a05jb3Arb3NyVGpnUjVp?=
 =?utf-8?B?Z21NWkZ6ZWNSdlAvcEEwdm5hUnY0UWZiSU5YVERDVWYwaEJpMVNvMTVOcmVM?=
 =?utf-8?B?WlRYaUU3QVNyaWxVaUEvRDVPclJScnc0VXEreHRKM3dYQzZFa3JSYjhIemhP?=
 =?utf-8?B?Y3dzNmFuVzlYR2c4b01QVXZmSVVFQU96NlVQT1IyMmpuZk54cVhVcys0dVc0?=
 =?utf-8?B?cXBGREI1WU11RW5teFhXZW5wcEI0amVTdVY0WFA1Q1FyTUQ0Yko4Z3ladmFp?=
 =?utf-8?B?dEtjMTRRSGtuTTkreUZPVzFsd1Vjc2krR1c1V2VoUHA1YUc0blhMUzBxVXZM?=
 =?utf-8?B?OGhUMkJodVFWMnhNbE1NM2pqQW9SMU9nUi83djBLMDhiUDV2NUFJbEQyZWVn?=
 =?utf-8?B?Q0NHdjVacGF3REtRZnhRbnlMVXVnb0R4Um5hVTgwaWZTY0FYQm9ucHlRUlFk?=
 =?utf-8?B?NElNRXducWJsM21VQUlaNzdGcjNlWjk3NmNCdXZBSXNBcitSci9aWEdiZll5?=
 =?utf-8?B?b1lzQnFuWVNIaTJwVlYvYytic1lZbnpzU2lIKzdDY1ovNXlabFpTY2tuQ1pj?=
 =?utf-8?B?UU5DbGp2WHByQ2dRWnJka2pLcUoxcnBUS01TV0lIQjg1d044U2dMcURQU0hC?=
 =?utf-8?B?UE5hazZNdGVpNkl2NVo0SThoQ3lXRXl5c0JiUzFEL2p6OElZUS8zV3lCSFo2?=
 =?utf-8?B?MW5hWmVGQWpUR1dFbkNvTVNVbTdwS3JRSFBEUS9XdlloTlhLc1plOWlpN0sw?=
 =?utf-8?B?SWszYnJXSk16SXVSMWQxSDZZOGRtMFU2OUEraTFpbFNuQldhOUhIdnZNWW5S?=
 =?utf-8?B?TWlxU25lMUYwSkJOQ1Z0bEZnbE9XWlNCQ1E1dGUxeDN1S0c3bFRpMmNxQWxs?=
 =?utf-8?B?enZJQmR0SW0yc0VsK1hGQ3M1TUd3TWlFUDVpN2s5R3I2dFltV0ptaUY2Nmgv?=
 =?utf-8?B?YnlncXJDWiticWE3RDU3NEIyTGtWL240WXFENjFCZkV6eVVhOWNyRE1TLzdn?=
 =?utf-8?B?M29hamU4aTBXWkNqazlxREorUnFCR2p4aTdWUXpZaHFQTGhjdXd3bzM3SFNz?=
 =?utf-8?B?NC9PZmU2SmFXNDBwRWZRTXdpTjNxKzlZSEI2c1ZCL3p2TUJwcGNEK09aSWVV?=
 =?utf-8?B?bDJsSnB4dVFzYVBaYnZHKzNnRzhMK0pOajhZWENsL2FwVURoVTUzS0VwYmNC?=
 =?utf-8?B?V2xLK2tMYnZMR1JrdDR3NGQ1ZnBHNnVKVkQ3c3dVWVFLTERWMmVyOWdIVExs?=
 =?utf-8?B?Y0xhYmJGSWU1NnZiRmQ4NEZCdVhEenQweHBkb1NDYnVJTUVTdVltSHlnZ2VI?=
 =?utf-8?B?TUwrMFR0TnlHejVkZUlaa2Nhd3VoUGlMUS9naHhRaEpXcTF0aU9FcVNCZG1V?=
 =?utf-8?B?T0laV21qSFI4aXZHaExBT3Nzajg5UFZiaGI5dys5eVVHaTlHWHNYQWdmSUZo?=
 =?utf-8?B?KzJkQUl5d29hMXhEQlJwekw2LzBBUE9MZkRrNkNPVEhVakNXTm5xdko5T2lY?=
 =?utf-8?B?OUR2aUlSdnRZS1M4QXJoTDNodHRVVWhLQ3BPSTJ4b2RUSXJVcW4xUk50Wmth?=
 =?utf-8?B?aVVSK2ZtY0IxNS9lUDhzZ2tnYzgvVEU0cTNlS0llc0JYMVpFUWlHSjJScjZV?=
 =?utf-8?B?dDFrSDNqSUZYYzQxMWVIVU10a0R2Z2U2YlpnSE5NZkx4ZU1TRjh3dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca1b7d6-bb78-485d-f82f-08df0763fd9e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:30:15.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkmPOP2F3g+/TyZ4ZdAXya8xTBFefV27eIEhmstNSgrmNNti6tSekb7EjDNbdBK5BatDuTBX16Ou7jJANURYsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8230

From: Jan Kiszka <jan.kiszka@siemens.com>

The quota threads may complete their work in a random order. Wait for
them all first before starting to read out their stats. This avoids
inconsistencies.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/sched-quota-accuracy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/sched-quota-accuracy.c b/tests/sched-quota-accuracy.c
index 2a2dc38..1bf5eb9 100644
--- a/tests/sched-quota-accuracy.c
+++ b/tests/sched-quota-accuracy.c
@@ -275,8 +275,9 @@ static struct accuracy_results run_quota(void)
 	 * number of loops we should be able to run during the
 	 * allotted quota, even in case of runtime disruption.
 	 */
-	for (n = 0, loops_at_calibration = 0; n < nrthreads; n++) {
+	for (n = 0; n < nrthreads; n++)
 		__Tcall_assert(ret, evl_get_sem(&ready));
+	for (n = 0, loops_at_calibration = 0; n < nrthreads; n++) {
 		do_trace("CPU%d: calibration: quota_thread[%d]: %llu loops",
 			test_cpu, n, threads[n].loops);
 		loops_at_calibration += threads[n].loops;
@@ -292,8 +293,9 @@ static struct accuracy_results run_quota(void)
 	 * Wait for the accuracy measurement to end, then collect the
 	 * numbers.
 	 */
-	for (n = 0, loops_at_accuracy = 0; n < nrthreads; n++) {
+	for (n = 0; n < nrthreads; n++)
 		__Tcall_assert(ret, evl_get_sem(&ready));
+	for (n = 0, loops_at_accuracy = 0; n < nrthreads; n++) {
 		do_trace("CPU%d: accuracy: quota_thread[%d]: %llu loops",
 			test_cpu, n, threads[n].loops);
 		loops_at_accuracy += threads[n].loops;
-- 
2.47.3
