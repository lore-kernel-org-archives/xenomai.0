Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398512D877D
	for <xenomai@lists.linux.dev>; Mon,  4 May 2026 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879997; cv=fail; b=NEyvnDiiw3jcTchckkCOujGfoplMKrjGx8MFoBIvZEjZWHJ+E0M/GLsknzFszUlRe5zDYeRBsmP7QfKEd+5Xa5fdLbDD3yWcrYveQqPYaycxD0kNZyGIPxb6N+vjzo2wpkAheflV6A9v6vRAWWOHw+V3k5Ntb1lYCyOclFKmY6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879997; c=relaxed/simple;
	bh=lngpI25UuGFa3/NLeGnr8CTLTbEETTCmx7qRvMwH0zI=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=CiOmrz3jEySaD+YOuEz4Lrd5GsUxcftxeVnxr49gk64qLCtnLEup+uzhBanMFKlPuf51yPROdpdHB83XwFLIPoNcJQtzf0QeedhP/hqbR+A3TT2mrUlsHDb31ri/W08g32vpoWVTEgdV8qVWgTBtBVNFr1do2NW1qpaKQMA3Vpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fbZyzJpK; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fbZyzJpK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSVslWp/ReXOV6FjkSqkCe8bheQnBgo7bBQ/7hi8W4VOcE9UgU56ELecX48NV5Pt/zStdfbXgVn9V9lryEkJMJAiMzwEY16qUpGgMvibHhXkVFfaS1zsZv0fK2wI/WwJfIgrX5Ij4Tc1QoEmyd6kHvbKpnzVBbSU8sKF3FaoEKZdE6IYYlETuZikpNQfF+JDv6abE6m9S6Ca9UK3MBfmZNm15tvJRE69nGKCF8RjpsrSRN8dd/pg38H23/sofd2VkUZyTgdHSkqlpOxjQWTKuZ5LnILXmkWcxa3veF3Uq9AxJ3pLNJQbNgPogkzily6voLQ7EtpQmSV4CNXmtEOrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNEoZRx8SbCNbHXu1CLX5+cdeb9m8wjyxBO45yxGX/c=;
 b=mES0U/QMyzPt9nfMT6EMiwCI4PhA4zp5aA4HFhvoDy1nyNQIdIO6jw+YNe1YSX6HctSVOSp6W6EAqhyDVpuWk7go0TpDRyqXLiAidC/XKcWYFICtQsAvwSPUf3BUlk0rrfvAc7VvVWSyHSLJ9o7d3K4hIpBHhW/Tql5TCmprhgWzPNn66cyhS/lomS3RMkL272VGX+bjZ9Raody4F4tm4J9IanKnhPev9rfShE7A8TYBDSFpCRHzbM2RhblWsYliTmBN93k8n6DVbRG0Wd73o3XZQE1Y6KTjteV3FUyxTjmoIrG28M5+ohoge0j8lKLa50f5UIsoglacqnnTCbC0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNEoZRx8SbCNbHXu1CLX5+cdeb9m8wjyxBO45yxGX/c=;
 b=fbZyzJpKjYRCEmSYdN5C2QbY+EHb9TgtTH3Zt4IutzH4Wg1KipFAE0GRtmBLWPZSnogVQzfXUY583tFktryIZNFZ6e5NZyNQk4GOVbD79M7OIsmWDcb7qwMbmcvQYIYqSIPDvl2unRzfd1h5IUNj8fh9joRXUzdVvKfinruAFhbtub3G0YEmOs/dzxX2kbXjyVTf9qLNfWpbul+v5CvYwXBg58TPe/sEQ0X3eIkf7CT9u6onxVp2tVmC0RSpwTduAMnMt6x2Aadc4Zo98yPcCDq5DgV8EwYQGe7ZBB4+2/q+8Ywrq2o80GsYhOPPFuqsZaLCqLlOCcKv2eQW1zcU4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6169.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 07:33:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 07:33:11 +0000
Message-ID: <a256fa26-71db-46a8-88bd-c4df74d28363@siemens.com>
Date: Mon, 4 May 2026 09:33:10 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite/smokey/psostests: Avoid timeouts in over virtual
 environments
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 56772560-4ede-4230-a0e3-08dea9af650e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JOIdjAYCgv5pP/E/E8O86S8gOHAxSVOd/9ouODcHiHmNNnpFJTPOmd+662AI9iT1rD3FTvwxNMmV4HmdoRYBJp+VHCJoLSWVwYqeaeFq+xYJ3O7klz+4RdjSaPVFAX/J/p97vem6OrBRytnxdaQJklEMIhoWoXRj0WAKYCoKv/haMkeaSZ6YrCYQ2e3FgJubin684dAZ1oDz41YHarvbmuqYwEsiD38PlxCvJHSfd72E4GuwtHso7xpLCPD7URBndT7j0s453QUrqNy903o7wZ5B69SquT4Wlya1m/CLDKld3JAu2WrsrdIwCM+20B5YB+bX4FsrwZ+YwbbVLO4DhdIWZ89s6I6S8zrHH4hpywCLdhrHaMX0HFxQsVorKma2c4iO6xnfTB5fBhwCNprZ62rsHhVuwIgLEIuX/lK3Aj2k0WLtXDO1pFxg4WtlLqhLDLgouxWgj1A/yQwHwhtqeUwRV7DUzYz5ZbkSr76wbL9wZIIdj2Rgf98xEGfvHR4UBDgYcCtnfHn4UsbXp7Bte8APY6aZ5EbgQBeFbASASn3RGjRz8KrAblpCvMttoC+B6MdMngGa9tiIDG5Uge+HBvH5N9tuQiwhCc2LPPI5ttTuY0RdOcAMWB7DbsrPRpogQNzpLGve9IvyYIcE50AAaHUs51smJb0wDM52JJqSuCKgStrC6kV1IB25PgxfZuBN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDMvOFF4bktUZ1BaNHdiQUp0YzQyY2Zqekg3d2haSy9hbXRIbWovUUgrb3Jk?=
 =?utf-8?B?RWphZE50dTg3UFlwYnMveVBkVFVvekt3RjUxWXB5dVZGYndCZVBlTk1tMldh?=
 =?utf-8?B?ZlJpNzc2R25xalp3aXg2Q3V4ZENrcVVFdU9PZENtQVhUYXpVM3djV1pEUTJR?=
 =?utf-8?B?Snh6UXluSXBlS05hU1VmQno2bXg0eWU1NENHMS91czRoSmJZcVVOa25BYkhC?=
 =?utf-8?B?YnpZV09DSUhxcWJxN0F2c3FmbzhmbU9RTkV6b2N6eEpicnlkejFYU2tTZG9U?=
 =?utf-8?B?eXVZMStPWTJTZ3dQZnN0WURxeFJPOURBR01rSWdvV3llQU40SzM0cU5BYkYv?=
 =?utf-8?B?U1FOWTdPc3dLZnFJbG0xSk9iUnMyVXlKZXF3ME1lT0NCRDM5eDBMYWFvNU9l?=
 =?utf-8?B?eDBqOXh2N0FZZk40Tmcvb3NTMTQ3bVdJSmRJSVhJWVZHU0czSFlLd1o1TWxz?=
 =?utf-8?B?Y095djJXRHB4QWtJZDZpbzEvT0ZtZHQ0TElTT1NQdWgxa0RaL0xvOER2WFQ5?=
 =?utf-8?B?eXlGVEg5SXltRlJxalYvU25xSnl4RUVHZm9oekRQdnA0dDNlS1gwRXJnLzZo?=
 =?utf-8?B?c0RCdUc4U1BzQmo5eVlmazhhQ1FZRTlub1FaUlJSUlVUK0hMTTRtd01SOXpF?=
 =?utf-8?B?S3hWNW9kc2NkR1lvVE9VT25BZnlaa2lvc0piOUcxdmZZOHZGeHYwdXY2USt5?=
 =?utf-8?B?Z1BmYk1aUW8zWEF4NFNjOVlJVnQrbVZ6TktJVVk2S0d0MVZuSmllOHFJZi9o?=
 =?utf-8?B?VHlVM0tiVlIrVWJaL3NuV0x5clY0S2xkY2VWTmorOGtiUE1lSDYrelA1Mkoz?=
 =?utf-8?B?UitpY1EzSVdzUURWdlphcWhiZU9YUDRnRzQrN0JrMlhiTXJmdFh0Vk4rRExV?=
 =?utf-8?B?eTkxRVB0NlVHbHlPSVZab0JWR1UyUDlvbTdkaEZwbGp3SmdlNDRQeWRCdzNr?=
 =?utf-8?B?eG9lVm5ZSEZaYk9FaDlLR0JwUG1xZXJXVlh0eEpteXBVSXdvNHJwMDVTRER1?=
 =?utf-8?B?Smh4bzQ1cTBjdVBsa1lhN3VrYzRxRmJnbjhPcWY1M1BkUG1RdzJuR2wzYU1Y?=
 =?utf-8?B?WlpyTzlBY25zRXcvV0pUYVp1ajJyK0R2cWV0cGljVDU2ZHlJTXVvZVoxSUhY?=
 =?utf-8?B?anNSQytHQTRFY0RRb2hVdHhSbkg4YjdqK1VxdDUxNFJUS3hlVHNudHVoM2xj?=
 =?utf-8?B?RnEzLzRmQmpuOWNEek5LM3VpQ1pNRGw0WjJ2RGJORkY4RHRjcWJtNXFsZGZZ?=
 =?utf-8?B?aDhjeWFKMEo1dUt3QzFRUEVoSU9mZ3RUbUNTalRoN1N6Z2VIWkg2RDQ2WWEz?=
 =?utf-8?B?R0poRmwzazVVcmJxTnRPY2JIQXFvQm92b1BJY204bDdqaFhONEFFN3BSMnpO?=
 =?utf-8?B?bU84L3lpVmNPVmc5aWRWNG45MXNRTkI3NS9PNkVlZFFmemZhS3NaTmJOQ1pW?=
 =?utf-8?B?QnUvUFhBYVR6eUFDbGFWUnp0cDhmZ21OVmN4L1VMOEVROXN0SDJaNVlJb0Fj?=
 =?utf-8?B?d0Z1a3R4dVI5UUlSVlEvTW50YzJyMzJoSmhTNHVGQjNqTTRpOGd1bkdvMVlM?=
 =?utf-8?B?ZTM0QnBuak5HRmtQYmhjTHNkZ0ZpbXZ2emNEOG8wTWRkUmdlWVJ6SXh3Q3do?=
 =?utf-8?B?YlYrcU5OM1RDZ2RqMkZsUVJLZG1VMjBRSWFMKzFraDB0V3cvWHU1WjZIOGFB?=
 =?utf-8?B?TTlGMDIrQ3JTTk5ZTDZUT2tMQjRxOXRuanB3ZnJsWGtVMXVXSUdSRkF2eHdw?=
 =?utf-8?B?UG1VeDg5Z21pT29JcFBjaEttdzJkNlEydVc4b1NUdUtwVnNsaGhkWGQ5ZEwy?=
 =?utf-8?B?U1lRQnlkc2oyamVGaVhIYkVvYlBocTVWYmtRVFZldk5SelZKaCs1OEcrMEpL?=
 =?utf-8?B?dUJBdWN0aXQ2N2xGNllralM0K00wZzRiL2lKYUhqclpuMGZVekRhQzRGczlQ?=
 =?utf-8?B?NzdRN2dTeHBzYllzQTV2TzZFRGRFVUFNUGhYVmNNZ2owdmtOcURJdVk2bVJR?=
 =?utf-8?B?a2phcUFXSVRQbmNQbXRGdWdQM3RIeDJtSHc1SDlkNWIzQUtFQlg4S2JwbTBP?=
 =?utf-8?B?NGJRY1F2d2FrZVBzTTVMMGdCN0J4aTlObVhOTm1QQWhVSDNXQ0lHMzBQN3JN?=
 =?utf-8?B?dTFXOE1IS1NEdHhONWJUSGFUZExCNmx6NEV4UWNCVE9renFQRUU1K0pCcnpI?=
 =?utf-8?B?VUhIK3JNQWxxR2VjSitZSTJ6Si9uY0FYZFlhYlF6eHlqSUhhWU5HVm9COVZa?=
 =?utf-8?B?VXZFYzcyei8ySW1vODZzdERyM3BnamFuaEdXdkYrUTl5L2Rva1RLMk9JWlhZ?=
 =?utf-8?B?cUxudzFyWnZ2a3dFS0pSVnV5dVVvaC9zbUkxcGxZK3BaSUFrM2FaZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56772560-4ede-4230-a0e3-08dea9af650e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:33:11.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpGHvWZVIqih18UrXHc5RvlwW0i0D5f3aOV184m7FuKQZJxtDATOveVxgIENSmMLz+wEDN1pd2f3LckUcjpvFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6169

From: Jan Kiszka <jan.kiszka@siemens.com>

This was seen over QEMU:

2026-05-03T09:42:36 [2] at mq-3.c:31
2026-05-03T09:42:36    0\"071.079| BUG in __traceobj_assert_failed(): [TSKA] trace assertion failed:
2026-05-03T09:42:36               mq-3.c:32 => \"ret == 0\"
2026-05-03T09:42:36 [1] at mq-3.c:27
2026-05-03T09:42:36 test psostests_mq3 failed: 256

It's most likely that we ran into a timeout here due to QEMU not being
able to deliver the messages to all receivers in time. Just wait
infinitely in such cases to avoid spurious testsuite errors.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Was not worth to bother the AI in this case.

 testsuite/smokey/psostests/mq-3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/psostests/mq-3.c b/testsuite/smokey/psostests/mq-3.c
index 1171a70544..4b6f2dcf35 100644
--- a/testsuite/smokey/psostests/mq-3.c
+++ b/testsuite/smokey/psostests/mq-3.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
@@ -12,6 +14,8 @@ static int tseq[] = {
 
 static u_long tidA, tidB, qid;
 
+static bool on_vm;
+
 static void task_A(u_long a0, u_long a1, u_long a2, u_long a3)
 {
 	u_long msgbuf[4];
@@ -27,7 +31,7 @@ static void task_A(u_long a0, u_long a1, u_long a2, u_long a3)
 	traceobj_mark(&trobj, 1);
 
 	for (n = 0; n < 3; n++) {
-		ret = q_receive(qid, Q_WAIT, 10, msgbuf);
+		ret = q_receive(qid, Q_WAIT, on_vm ? 0 : 10, msgbuf);
 		traceobj_mark(&trobj, 2);
 		traceobj_assert(&trobj, ret == SUCCESS);
 		traceobj_assert(&trobj, msgbuf[0] == n + 1);
@@ -56,7 +60,7 @@ static void task_B(u_long a0, u_long a1, u_long a2, u_long a3)
 	traceobj_mark(&trobj, 4);
 
 	for (n = 0; n < 3; n++) {
-		ret = q_receive(qid, Q_WAIT, 10, msgbuf);
+		ret = q_receive(qid, Q_WAIT, on_vm ? 0 : 10, msgbuf);
 		traceobj_mark(&trobj, 5);
 		traceobj_assert(&trobj, ret == SUCCESS);
 		traceobj_assert(&trobj, msgbuf[0] == n + 1);
@@ -75,6 +79,8 @@ int main(int argc, char *const argv[])
 	u_long args[] = { 1, 2, 3, 4 }, msgbuf[4], count;
 	int ret, n;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
 
 	ret = q_create("QUEUE", Q_NOLIMIT, 0, &qid);
-- 
2.47.3
