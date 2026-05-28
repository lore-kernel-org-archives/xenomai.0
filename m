Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F8248886
	for <xenomai@lists.linux.dev>; Thu, 28 May 2026 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953902; cv=fail; b=jRHOcKpfzuEYrqHtsZMW7ZxMqglvpoHfRqMBEuvp8pMqyKVplj8vjH0zs675m42E2Tc3hEufbLDYRbCipXaIyWtnqOEQnlk+iG4ToQa/eq5e0CYQPSsPCu70MRWYZohSkyCe5b/fTt/2SyTokCuwZn5GRYS3z9ak/41ATzruyJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953902; c=relaxed/simple;
	bh=x4nBmP5HfYdhxMFkbQPGwvz3CLjKfIN+JLwHPYbAW14=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=Pn3k1apUtyLqTKQNv3tg8TCDCDP6DcVauVjd2EpUyTycoj35aR1qmWli8PqiIoWoUXWBfLBEdATG7udRSAn3mLVtENhTTtX4tN2f02/6THtZvQk+KRA3OQxQz3dPZsDA4FERTmWg47eyqcLD3xnY/y8Q+00EwLgELGNqVbcuHac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IzT3FH7t; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IzT3FH7t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/ENEBYKK2+VbqQOU3FhaDkxmfLjDmxrYm8hR/m6px98epCL5nENznQrgmOuGqE6Gpz/6muqSWfiVJGLbXXKD+IQpSuwZNx2eiaUVCJf0KG0WYklODSyf3oWNi+Lbusfo3bGcb3W9reB2i4eqIqme8rETYx5cIFf2A94rkRM7GjIKwM3OWH/Esn82AkpMlGdlEkgOCoraZ5BU/Q6/S/rpMyC7VSg9rx1997+dVVz+IQzMc3uhhDD+fMjfU0YObA46vM9LAQN9m/1IlDFWGkRXBHxNuYzUHX3D38pj1O7ydf0x+wvrl8HIm8ylUbD9KpcleqqZMq02w/BvNf1sWYF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeMhdKtr6xSpgPCEHXm9ZlJph9b59lqQXyPIuXk2m0o=;
 b=Swo6JP+fu86zoGTaSQgEXSCrmTNOE6HXgDwHWtfT6ZrC8W37VaxmeYQclpBr5NBPRx/X48XpAvZ3ExL9E/yJgH9QsfoJJqM+aGjjSOa3VlCJlCK4dJBftvN0ojmoZJMrLcaSqyxwHweWzeOEzuzNMe5dN6f8lM73RcAVu8FqwjkEjUYy4rvZwg+tvP/fX4T+noba9YgKpTvZiTAaTxyVgfk1ahiWD+5VU9AK+lk2+2ndPsOYOynSwxGIZKWNPKc5NQI6TL2YrqPmmU2nrIuTl8/3FaA5HiilMxr8PRS/iHUNLepjp4Le6WunLFCZVSRNU1CEJg/2Hc+TJe780QD75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeMhdKtr6xSpgPCEHXm9ZlJph9b59lqQXyPIuXk2m0o=;
 b=IzT3FH7ttn7MQwbfg1flg+6tVYAs+gqEE6XCPb9YnN05mlwwxcb+Pkb8l3n2KSbo8f//FaztQPWwBlDgNmFoddt4BtWdCHhUIHf+jpEutjlROiEuj0jSDVzD4Cqj0vht3F7cYeULj6kaS1ENLAC1wVB/W4yNUAEbJ7Zh1DzUcFtaza5UzJOmZCFQ0xDmwVq+IH8n3B6ugFeDrz28XITlPNa5KNZLMwEaC+zbO1Wn0L3TaSt5RVu7yWce83lhJSomXT4uKcxEQHwIh3+Ak1B/NIh6lwNiVJoS3bp5TlRWxd6ez2J5dt83KpcsKMmoMMo2biDd0PxDiORisWFE1eLNfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:142::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 07:38:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 07:38:17 +0000
Message-ID: <8be12604-226e-4703-af51-ab4bc8e75a8f@siemens.com>
Date: Thu, 28 May 2026 09:38:15 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH v2] kernel/cobalt/thread: Confine condition for sending
 SIGSHADOW on xnthread_suspend
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3559:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ff5bf8-55ab-4c36-1577-08debc8c153b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	tZBujzT7hvTNnOdpPzg8FrJrWpyXBkRGqV8zQMaFwroMXiwUm/2mPl+Hhm1pf4f4Oox8bPxep5+Dr7JQf5Ia8H2QG5mBjMOejZou+i5DPv2K8pdxZ6ILceCSsyT0vtaAf7CZBzfYM65E+5CvdBcargR993stgAKZMHxUurDYEdX3WSTZNTi5wFNGFGOhWJXJc0EgjSwqFkAs2zDUT0hpuXByEUyAZDr263a2+fUflEtCcdH0A2K5tMsCr2FpciUvi0ixHafa4yTm/14Z02y7DNGhb1YaePfuHOcvQn/VquiYMJju3AM5Kl1O6xt/ev1qZ2bu/AUcC7arW876QWqNMpqj9owIvK8g00zPbiyyyLFjwHfyJl7Aue7D/BdgGxNp8Va21TRF8ZV5m7KlG+RsGir8kj+l9sdbVWZsUJKyC1IrvdweFekJ+XsOakOlNM1YKoevhpe2obliL+ck69fGuKfPOIykotCAeYdhzx9K81Hr05DwlA5PFn+S6ejHE39ShpLPgZdC9GeiXEw280eHDs27rGz/0GAiNbyvhXO7ENWmTQFDs+Vuyzhj27qkC+SQrflgaWOLCmtz7j+sNZ5f8Zs0UpmI6xcp1QJltqzDCr2+PHEPkvFco7Q+7No4HpCMZMYPWccAFcNv2iTuBe/jC+AT2afCdo8sAXdwqYV9hF8OXc11gTTtsv+98UumhZVLEb1cnRCTZGeTKQLUN+Vt2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0dXV3Q4SjlMK3lNU1ZrbXhObkNEMWhsUjVra1lsNzgzRXJ0S21WSS9CVWxw?=
 =?utf-8?B?b2paV0U4YXlYR0VvZmdTSnRXbUtSaHFObnNjMlhRZFI5Qi9YUjZRUHF0cUs4?=
 =?utf-8?B?OXZsem1MODRWeXZHYlNiSHp2TjVOeVBwUkJWYXNQN254VGE2eldLVGRybmxM?=
 =?utf-8?B?SDRrcXNxUzNDOTFub0VIU0RFQnFRL3lqS1NRRnM0TzROcnhRSWh0ekpaVzky?=
 =?utf-8?B?WVFXZ2pkYjJEM0NKWTRjcStsMG9idE83WTFDQmFmeXFIL3RvN0R3VXBLM0M4?=
 =?utf-8?B?MDRqWVB1WVBYbDRrdDZlQXNqT3hGcmZOd29aeDUzK0xrT0d4M2NiU1JyQTc2?=
 =?utf-8?B?dFF5TTYvWHl0dno4Rm1ZSDFtdTVaZWg3NlJ1RXNzWThKNVp6M0Q3V3N3c1VE?=
 =?utf-8?B?RDZmZVkyTUhxMWR2SkcycHlvMS9aeVJ6VVNUNjZkdlp5VDd0TnhTVWJHSHB3?=
 =?utf-8?B?M09JMWNZZWhRdG00QXFHL3JGOTlydzVSM2tPQmxBOUlBNi9zSFYvR1N0YkRm?=
 =?utf-8?B?N3ZjZGkwMHJ5WlhFNExUbzVINFJGMFdtSEtiVlpHMmZ6M3ZFbEZpQkV6amN5?=
 =?utf-8?B?Wi83dXo0cDFYaDhKd3dTMGJCOWNaOWlBbFFMQW1INVdXL3JDVXFyKzd2cU55?=
 =?utf-8?B?b0JabVhmcUFSWTNMcHgyTUk1aEpPSFAzdVFGL0djdlpqbDhkb3FQc0ZvRHFU?=
 =?utf-8?B?SmpwTjFSOE53WWhOM2lpdzN2WGdaNnBqN0h5Nkx4bEpyUDlUOFc5UU0rV2Vy?=
 =?utf-8?B?aWJvQ0tabmswN2FqZGhzQkVTc1ByK1pDMklHVUQ5NTdyaGhQbjczbmRQR1lM?=
 =?utf-8?B?YnVmOUVnL21lMDFZTXRhZE80VjFJUmxScjRreE1sWEkxNUwvTzM0Ym90OWFU?=
 =?utf-8?B?Yko3NlhseDk5NytZU0xxRWZzMm93MEhqdmtrVGhKa0loVEpGYUFkV1hDbGlN?=
 =?utf-8?B?TWhVbFlYMFIvZytXZ0tHeGJBK2o3LzNHc1FiSW5hRHpZMFpqZVJ4Z05YM3RV?=
 =?utf-8?B?V010bGJKU0tLYWxzOWdCZ0piN1Zvc3dRbzZHMnhSWDkwRHdjM2taUmJYUlND?=
 =?utf-8?B?dEpGTnMyMUtqcUhPOUFXc3drVWFvc2ZkRmRkbVNhV29DMDIycUgzVi9FWXYx?=
 =?utf-8?B?c0FkOFBKNm5FN0F1YjV0R2gzVFMxTE1idnl2ckNINDU1M2I5VklqN2w3alNS?=
 =?utf-8?B?dmdJYUxHRkJORER6b1RMSm91SGZRbWJoTjFuTUQ5amFyYVB3NjN3L0N4SHhz?=
 =?utf-8?B?cVZUMHBmYXBtTGZOOGVkVFN2aHRHUlN5RDFZaThvK21KbExPdUszZldEN2tk?=
 =?utf-8?B?S2hEYk1TZW04TkhKNVUyT3poVHVPUVpaVjRjdzZOWW95UFVaYmtGSDI3cFZX?=
 =?utf-8?B?ZDVzTGxwSmJmSE1Vc05odGtaU1BUMFlFdnNKUHdZYkZxbjMxVkxqd0tpdVNj?=
 =?utf-8?B?dUxQSlUxWDFYZGFQRjRNZnNIMU0yaERqOEJKK01tVEErOENDb0tiUDRTNXc3?=
 =?utf-8?B?ZDlUZGdqU0tTQnpMWmFyOEpaNXhGakFVbVJlMU9Hd1ZMaS95dEdOK24wUFhr?=
 =?utf-8?B?TFBxMk1qbWlzNmdBQmdWbjVBRGlaa2JDM3B2VThoN2ozMlo0SjVDRU52Rm5D?=
 =?utf-8?B?amVIbkZCOStSY3VkdHRiWkh4ZVFxMDFoUzF3bkUyUUYvdnFWbzJQQXRiclR4?=
 =?utf-8?B?VytRQ2ZLQ0RjY1BmQ0tSalRIZ1VpN1Z3ODdGbkMwNHI4NEJPeHhTcmROYXl3?=
 =?utf-8?B?amhESHVrMENvdFgvM3ZzUW9oWjcwaWVGY0JyMXpPaFJwY1IycW9HTXpNNlZU?=
 =?utf-8?B?bWNNaDkxLzE5ay82cjFPcXVlMkxVSlc5R281QWZmRDB4RHl3WnBNT2JmNVFv?=
 =?utf-8?B?V25yRUVEeGM5blk2OUdGS0xzU29wUzVNL3A3VGVUNTZXUmxaY2xCRjJucGdy?=
 =?utf-8?B?SVRiMnBzUlhlT1RjbituNzArckJrdEtvOWM1a0JrSkltSFYzM081dVd1YmZU?=
 =?utf-8?B?WXR1dDh1L2hrdTM1bEFSSThYRXpWdFRqeDdNK0N4R3MzVDBITWdjRWIwdWs5?=
 =?utf-8?B?YzZoNnZLaGhKYnZiUTJ2VWsxQ2kxQTNvWnVVblpma0VCeUVIUUMxeXJjMGlr?=
 =?utf-8?B?Rm9lNVh1czVJdld5SGtNSFJlMU1Ha1hYbGJjRjJlNWxJM2U1U01GV2tvaUQ1?=
 =?utf-8?B?VjQyOWN2V0Z1NXRUS2w1TVNENkVKTjBMalhEbnZzV1ZJM04xbzV3ZTJiVnUz?=
 =?utf-8?B?TTlnbjB5a25CMVp3S2JoK1BaQ1Rtd3d6bEdWeFI4ODAwdHBkZVhKaCszM29J?=
 =?utf-8?B?TVVPSytvYWtndDhOeWtWODh2RHo3OEx1TXJIZjlvRWhnWTNsTVY3UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ff5bf8-55ab-4c36-1577-08debc8c153b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 07:38:17.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbCOVWaGP9ZasUM3PxuQ4wG3+4jMzMAvrOWwJlTj4tyP8AWe+I2I+PguVtQpoueE6wHs8LLDg6kQDTH92Xj8IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3559

From: Jan Kiszka <jan.kiszka@siemens.com>

In fact, XNDELAY is only self-applied. Drop it from the condition set
and also fix the comment explaining this as well as some other bits.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - rebased over next, without [1] as dependency (which will need a 
   broader approach)

[1] https://lore.kernel.org/xenomai/48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com/

 kernel/cobalt/thread.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 60a7112844..a51d9eca8d 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -996,7 +996,7 @@ void xnthread_suspend(struct xnthread *thread, int mask,
 	 * assumptions regarding suspended threads.
 	 *
 	 * We only care for threads that are not current, and for
-	 * XNSUSP, XNDELAY, XNDORMANT and XNHELD conditions, because:
+	 * XNSUSP and XNHELD conditions, because:
 	 *
 	 * - There is no point in dealing with a relaxed thread which
 	 * is current, since personalities have to ask for primary
@@ -1005,15 +1005,16 @@ void xnthread_suspend(struct xnthread *thread, int mask,
 	 *
 	 * - among all blocking bits (XNTHREAD_BLOCK_BITS), only
 	 * XNSUSP, XNDELAY, XNHELD and XNDBGSTOP may be applied by the
-	 * current thread to a non-current thread. XNPEND is always
-	 * added by the caller to its own state, XNMIGRATE, XNRELAX
-	 * and XNDBGSTOP have special semantics escaping this issue.
+	 * current thread to a non-current thread. XNPEND, XNDELAY and
+	 * XNDORMANT are always added by the caller to its own state,
+	 * XNMIGRATE, XNRELAX and XNDBGSTOP have special semantics
+	 * escaping this issue.
 	 *
 	 * We don't signal threads which are already in a dormant
 	 * state, since they are suspended by definition.
 	 */
 	if (((oldstate & (XNTHREAD_BLOCK_BITS|XNUSER)) == (XNRELAX|XNUSER)) &&
-	    (mask & (XNDELAY | XNSUSP | XNHELD)) != 0)
+	    (mask & (XNSUSP | XNHELD)) != 0)
 		__xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN);
 out:
 	xnlock_put_irqrestore(&nklock, s);
-- 
2.47.3
