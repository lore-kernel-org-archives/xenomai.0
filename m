Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE71DF254
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180949; cv=fail; b=hI61E5+oKNTNx2lF1ahE7kumTZHNsaGUqAHC0YPrGy1wML7E3gPSq1VLTOaVPcRaJiTozEkDLRPfUH+aJkiE9HtwW1Gl63RMyckt56rKBtLF57t3HmNGJaBzucn3E4NvjQ09k+m6z0+6T5au59NceqvE1vbL5wA2DTLYRyUkwOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180949; c=relaxed/simple;
	bh=K8li+6WKDUdFExOuau+FbmBXHDi/ttL87TC0ZSoRTP8=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=JlWh6/lvq9QE7ZB/+szBbW73VrZzdAIc5JdAfo1y++nuin3btUJ2RQ/R0rMNxYPYHRPTIe0ZhwM8fRfXEGouszWaYEcuaGFe53+3tE6rzE0J68O8B8EOpojWIvlvf7tx8PwBSycwmhu8oeizTxT8qqjegsAtyB39dysHlvrEnFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Cw4zgmpI; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Cw4zgmpI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=minVqvLq95GepAdqElf4zFcRgBFJqGwZNErJOgM1ur0mDwfaBUzZEba86skVipZQ3JYaKDq49Dqsr+W5lIQ1YXgnMeUtIHr99XDwgohLmgW3y0Y03mi/hUUp6kimSm1+wcGb6vJj1E5D5Yc5qyf3P4ZWqYA8FqS8gt8UtbQRgg7iS0qQklxHRpynQDhWdkNLKJ66Y9rXvr1dq/b0hf17hW2GhSmEtnJemhhpGBA1eatVtuTjaSlhC0vDpMsyfeztRPFGvw+4+ZVyFYLXMK/cUasWGybgP/VooH45H9ILZdYL0R/VymSFidouhrQT4WDQM6aerG44KlvBpP9EB4cTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKqRBefVn8+qm6A3wJDb26BKwNTVndMVJdUqPF36UAE=;
 b=Ls5TCoe1eUDMWZI41djMYOo25/cLLPf4uzVqog47DCWbZAJtl+j16DOOHBKmkfQSi/d0yuAIYNaVwjBiwUg/1e1o2RC8cMekIFAXpntnlurMI8bq4fvQlsErLGoF33XhmBLygQksCHrmG9wUqEuhuK1H66iAGh0nHsxhh+HwP9DF+inoykYi3usHiRM7ez6/tBf4TXLeW3bWVoVVDgBAM3n6sUhuDnMFS64Ccpt0EV9kY8bxoE2LZQUqkf4W2Wyk/iv67PHZ4+RRU/tstDqaX4kx30GMyQOEbGKDH143sQmjVCX2nbq0BHqu4jiKufyfTTy7IMgLHfJn5/lTJiMg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKqRBefVn8+qm6A3wJDb26BKwNTVndMVJdUqPF36UAE=;
 b=Cw4zgmpIBIwTeeNDrsYiFA6xxCZ9giccWlDV6akgaRU8EutSxr9h9R7UsQVsCcDUENGbNKx5iDwHUGpJ18GWPAOW8fUoJRH+B+Pj58iXrWArJGfMcEdbk+kNftCjeQ1W4Jwi8Zb7Y3mdXI3MsO3FpCg4JeCzWa6YIuA+XsC8J8B5R5tN6yc1dtP2W2onTEEP4s5tbUmAxkXi+drNUyk1635wdIKOcjcXiygiIIzRrBcpaYp9dkTbmlVq38FI7j8CSVR06L374kkWFKXQdEplNCcuXK9x6sNBLuaP9IYZVRbEFUgIf8f4jNYWeMC2QddkhclX9bGG54Sb9CEyxcvYEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB9584.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:35:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 15:35:43 +0000
Message-ID: <ed1ca8c0-93ec-457f-8615-aad03b06f6ef@siemens.com>
Date: Tue, 14 Apr 2026 17:35:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] cobalt/posix/syscall: Account for changes in kernel 7.0
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: 91414c5f-1f16-4824-6a15-08de9a3b7d3b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|55112099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zauUR/tNk6NmkcpJtAVsCXFImHBI4QDYfPQmXsc9XZGkbKeXUNPgtkubSxcnAbbRRklRGSCpX9Hx8PO2DE1YkA3Yeho/8ej9KC7gw+bNoKVRMBqEbrelPOaV3QR2211UtkbTXBq01oGBrsmPzQRHdDPXZ3oMmP4nZ+mYqNj71p7iEHd1n7WmAZxAhvbtPjqGOP8Axt+CUFn2JxrXUDUx7iE+qlz+o+kdUNBcU+RToN5UyD+gb2UjOiyqxBZH1Y2dVxMVleiO371/XxvZ/cT991ef9ib8QiA7UhKMyUIk4575Mi82un/k0Udp8Li9YhxcIRKLmnBIuA8Z26AGj82TBzoLCARcYPahAxRnbspkbmunLEqwvB+vGfKWPTGwSpTdKxEITaI5P5qkLxtpVOymyF9UUW3QySgpw2ESaiZNNAf5htoFAXVeI0qAs7Y0/LzkzmiZb1Oohkm4BSvoPu4ERaYOXnGRHjeSP60UTjEeHKdAGLAuHJITtyXuM/o5wZBHI3eZpu9BVd93GbHDFsUgYcBhS+X4tGcrQ6tmM4H0IqwOSELZ1Fw+Ijr2MIlDyaXz/zWcirMcDG210N/sAp3g9H1Lg6gw47bf3MLOTwvN4bItorEUVQN6my099UOQH5WtrW8okIlox/p54D5rrVDWt1X3Sj6V6UL3bLjWutnnM8z0DDLq/48e4XKDLM6yPu6anf8z4tIvzvCvMQ614tZftyQO1ozt9UkcOdX9T17q210=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(55112099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blF4djRVdDU1TXg0NXY5ZU5NZjVHNE53VGtTdCtycjl0ZUJDU1lTY1NReFEx?=
 =?utf-8?B?cmhEV05hcUIvbWtSbmRUanh2cCtscDBnRzY5bk5QMjM1andHRnI1NHdVZEtu?=
 =?utf-8?B?RmZuak84cUV1bzkwNHVWU0tKTUI1M0R6MW1PbkRvUkF3aWo2VWNPRnp3VlRm?=
 =?utf-8?B?aldoR3k5RnJBeUJBcjlXR2tQS2U1NmJET0VFZFdBMnB1SGh1UUlhdnVSSUpM?=
 =?utf-8?B?ZlYxYWZqZXh0WFJaaFpWcHh6SzlKNlVWT2o3Y2RUaVRyOElYYzU0VDZMNUE1?=
 =?utf-8?B?RVpsbGphd2VvbHVINlVhd2hxck8vNXFSYk5vTUd0RHdjclhJV1RKQ21LbnQz?=
 =?utf-8?B?TFlqZk5VYUJUTnVIdzBKTEZWZEZWTVdhdVBKeGJYWlllNXIzdFBubWUxRThu?=
 =?utf-8?B?M1lTYmNjUkczazFrOFk5ZVNnb3JVR2hlMFZlMHBHbjhEOUtKdGVBTlpqVitm?=
 =?utf-8?B?bEJqaWJmVVlmRkZQejlCNTRkZ2Y2cEdYTFBuS2QwMXZzTmo3TXkrMktWZVpp?=
 =?utf-8?B?akhzc1ZIZmtGRnAraVh6Q2x6cWlMOVRaWHZ5RGlTMkRJaVZsVmY4MGdwRUxl?=
 =?utf-8?B?QkhHTlB0SGh2VlgwdE5hQTRuVTF2RUJhYVRzS1lGUjNjQ3k1SFF2L29OM1cv?=
 =?utf-8?B?MGtscUVzZ0dpM2NLdnZJSnhkUkp5WjIrQ3BwdFgvWisrMGVXb3g4aXRnNEhr?=
 =?utf-8?B?c1o2dnVZdmQva1NXV3drNG5EWVI1MDlJUUx1TVF1VHVONXVPbE4xSFNxb01N?=
 =?utf-8?B?b3VGVHdibWFxWGI4U3gyelo2cUdsZk80YmN4MnIyRGVKREdEeVdWbHBRWkJO?=
 =?utf-8?B?QkN5QjA3RGgybmJscGFTYm9TMGp4bGJnTHpzVDlJUTN4WDJxOHp1TFJUbDEw?=
 =?utf-8?B?Tkh6UHA2blhlRUpjMzZkanZlR2lBRTA1OE1hK0gxRWs0UTZBcTNkYzQyRVVJ?=
 =?utf-8?B?NXJ4ZWpoY3E4N3ZEcjZxcDZpRHZjVy9xM2RkbWxHWk0vZjNwcG5KWi9jczFD?=
 =?utf-8?B?T1ZKYlVBM3UyTnZtNmMzVzRRVC81aW1rZVVUWVRWU1BLdWUxTmpvUXpIUUxm?=
 =?utf-8?B?bitMUGRwbFlQeXJnWUY4YUdPS29FWmlsL2NGckxOam9XTWZzVkd0L0tCOG90?=
 =?utf-8?B?Sit2M05xdHNhZTBCTmx3c2dURnM1YkNlWWpDQWF0aWdwK3I1QXBZT3h3VXM5?=
 =?utf-8?B?WjJwK2hvcWpkL01Cbk01ZWdwQlp6WXpCdkxsS2JnMTBwcjhIeFE5bjNNWGx6?=
 =?utf-8?B?aEtrdEtlbkVCN3BsRVRiYkErU051Z3hMbnc2cTRzT002bzljVkN5YXcxNndO?=
 =?utf-8?B?andKK2p4QU5qNGlFRzgrZGdqQVBFMGZ5UkxNOGF1T2l0a0d5c0VMZFZ2Qk00?=
 =?utf-8?B?dTc5bXFMeVhPRDlMWnE1MzI2L1QybUx4NVRpSlFsY3lQempIT1lVVDhjZDBI?=
 =?utf-8?B?WWtMd1dyRFBwNUFLMzB0YXNzNm80NllXME4rRGk4L1ZDTTl3aHozeHlvUXQz?=
 =?utf-8?B?clI2eXBGanRBMnhBVit3OVU2MFhvVFlqRVdhbEgyNG9HRzJvQzExQmNmQUJ5?=
 =?utf-8?B?VnBOcmRXR3RjcG12V21ZRDhXNW1vOUQvMk5zY3RtOXR0ZDRXQnZ4YnlpSXdn?=
 =?utf-8?B?QzdyZDlXR3lPWjQwb2VoKzZabGpZNnphaHBVRlRDMkRHNERES2NHYnh4S055?=
 =?utf-8?B?NzJ3WUwyN1poL2pQbkhKeTRIT0JiUlJ4cHhMaFFEQkEvTnRYZ2VHdjg5eVFV?=
 =?utf-8?B?UGNJenBlVGp6L2YySDEyWXhxcFBhUmlwdnhQNjZpUy8vVU14cGpqNWFRcFQ1?=
 =?utf-8?B?dFBwRmhheDZEcCtEQ2hLY0NLVjlDNmU3b1VlU0pRUm04WFNHbjBZMXFXd0xF?=
 =?utf-8?B?VCtObStacjR0M3FKSFlWTFlkanRXK0tnRlRpTjBPdTdEYldhZG95OFJxYUxB?=
 =?utf-8?B?bHprQzJkekdGYktpUFhsKzQvQUJzblVEZnpmaXo0Z2psSURVS0JmMEx3WnFw?=
 =?utf-8?B?Wkh0NEs5UlN3WEM4WjgxREFGczdHSFdnWE5zWkhpTnhpODV5dExhSWsxbGN5?=
 =?utf-8?B?UXZDeitTUUZmeG9IVWh3VE1pOTNSMDRBUlNBa0MxK2ZXbkdxT2Q2M0JnZ1lk?=
 =?utf-8?B?SXFjazRFUmJjRStzTnYwd1JTTmNDOENhRVpNd0dJSTRMdktEc2RPN1lmQUFF?=
 =?utf-8?B?SnE3WkdVRnhsd0V2OGhUV1UvQ3B4VWVwSDRyMzdiRGJGQ29kdmNCV1NFRE5i?=
 =?utf-8?B?UnFsalFybkZOMFI5RHVvQTVQTlkySSs0Yll0MHRBTWNLM2pPVW5CRDlJZDVS?=
 =?utf-8?B?QTFONUQxNnE4MDBmbXQxQUk5aTZETnNVdjVLUUo5RUJoYkRnbk02M3lsSFpv?=
 =?utf-8?Q?a6omxXCeCHancY0c=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91414c5f-1f16-4824-6a15-08de9a3b7d3b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:35:43.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6sXE4a8GrZQSM+awIaF+gKXtJHwcLjEdtWQQSPQgW9QpIzm1CYzW+3mIPyNgHqcg1Bz7R1fywkDp9EsaIMygA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB9584

From: Jan Kiszka <jan.kiszka@siemens.com>

With 7.0, we no longer have a access to trace print function that takes
the string size directly. [__]trace_puts will now always invoke strlen
on the passed string. We therefore need to terminate our string
properly, even if a larger one was passed.

We could keep the micro-optimized variant for older kernels, but as that
is phasing out and the gain is likely minimal (the string is still in L1
cache after copy_from_user), simply switch all versions to the same
pattern.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/syscall.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index a26da154c4..bc1825676f 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -46,6 +46,12 @@
 #include "../debug.h"
 #include <trace/events/cobalt-posix.h>
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(7,0,0)
+#include <linux/trace_printk.h>
+#else
+#include <linux/kernel.h>
+#endif
+
 /* Syscall must run into the Linux domain. */
 #define __xn_exec_lostage    0x1
 /* Syscall must run into the Xenomai domain. */
@@ -194,12 +200,13 @@ static COBALT_SYSCALL(ftrace_puts, current,
 	char buf[256];
 	unsigned len;
 
-	len = cobalt_strncpy_from_user(buf, str, sizeof(buf));
+	len = cobalt_strncpy_from_user(buf, str, sizeof(buf) - 1);
 	if (len < 0)
 		return -EFAULT;
 
 #ifdef CONFIG_TRACING
-	__trace_puts(_THIS_IP_, buf, len);
+	buf[sizeof(buf) - 1] = 0;
+	trace_puts(buf);
 #endif
 
 	return 0;
-- 
2.47.3
