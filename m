Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013026.outbound.protection.outlook.com [52.101.83.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0FC29CE9
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465736; cv=fail; b=f2sR3gVJi894O+xUO6s5DCl6+lL9UiWahuWTEVQJxt+iNPkEdgw5agVYF4G4EWHqzM4UJeTFl3fI93niRCE2PqGhzJpLa7SFDnVUy5RvEkL0BC8rJgE5DNyuq2kcceL26YA8Cu3F1vb3AarX0S+/5igbgkpTK4meajEU5BBd6Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465736; c=relaxed/simple;
	bh=NKuSYZGpZF0bihmMccuJCNWaQzi95ve0FcGogACAy9A=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=fEaANXnFMORMWfUfwq50RMIqnymFGnLoeb5//6OOKyGDYqT40iPZuBjPdG+90BPbwstPVrSl669j65kszcDcZeSQUhqkWhmAnbWp6iZn3mB4xR0mzEIkjZevDxDZ7a5cgp+RPVck/jfYhRJt9K8dCnYUf5hoaqqVJvkjlma2+i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cLIpe60b; arc=fail smtp.client-ip=52.101.83.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cLIpe60b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psSyO6fxoJu5sfhLEXkWpea6ovsLcykVVrqE/zsWEvDl3xbA0PkN3eaEP0IpCLZ27jnoSIu2NbeRYYP1GiQiIcoH15nI/LKXSlDBy6zZoTp5eiz6X25tRv7R1J0KjUVJYLXpaaws59A6t/oLIqrNpx+DL0wGREODDdppXBpX6VSpAY0GWXpJD4Mw34k3arvS4FIGTbJrRL4xcu9TSd9pP+koozTh+hPk4uhcFLdQFvbc/huYizyy/R2mMvpg5+dgJW6Cd3D4/KhDf6sbs917DtE89lNSsXpQE2vzBalWCAbpGbMPEB5GqTCC8xTrfxaTp+W70+QnPBipARAllE7YTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dttahDkQLBaPozqKWZ5sGY5yUmZqP/HvPmunbu4e0s=;
 b=XKB96GqIqt27OSKEuy8y5Ca7V8COnmgY9YF/3mPa/guQCwGEaBy8eqxYAhiubWEE+0uqTMPkavKMACCFW7CORZYtA3JRovbMDvj4HYV7W72m4RFVN6vGyPTumUcxF9tgcqdoNiT8J6V+V++UHOAZXZ1U2Psbqwz1ADDVSMuOhkS8ncMW3VphpUWEuLbD46+ewTsNwrK9/q6RwgQgG0RQV1CTDsq/5reEwRAvSRTrhmQFdc1TuhXmsFNJuIoUyETMR69eEmiDZLStJU8jw8txnUJ+B4Zl9KZqbDDKlQQZJCs1F0TJxtNIK+vPk4wJ6vP8qWL7JrPUDRl0xkSlImaE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dttahDkQLBaPozqKWZ5sGY5yUmZqP/HvPmunbu4e0s=;
 b=cLIpe60beqOGsnfcoQz1OU+CSspONS+urkCzjNDE76okxNkfY93Cpm98joOinsTWB4n8GQFYvnZSAiPSftjCC7S5m3vML4tkNQP47wq6uuhj6KQUXsiZqThlOkwCqSLrOXC3QitxqRfYhFdAcNCcCRiFvDVKAWyJDHvmPgon5NQLXvFpYmUPGYDDnMnQnDDm9d474YwL2Vyi8QJTHkPOCMopZTphdroovQJ9rZXL/ez3BYeBhGZM+ZCQy4CCjZpAL1W5pVvXh+Y+XOK5LGn6h07DDl25gSWvn3W5Rn3JmRBfqzTx7vQUCs9hnFCecqWm/872U8e2RN0cHhfD7CLKSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sun, 14 Jun
 2026 19:35:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 19:35:29 +0000
Message-ID: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
Date: Sun, 14 Jun 2026 21:35:28 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d330143-3832-4b02-8dd0-08deca4c1789
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|55112099003|6133799003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	6F3fY0ewwyeNP313qDFMa30wT+idwdiisqKgiD7jJ2bUQYHcOdOZcWSuOuVotEEyGL9yLd7jogU8ObQ3u3irTQqSFUS5cy/GZAwhI8OhIcov/Mkxeq2Ji6bJyCXnwaSGsLRtgvpJiBwtYi89pNOsE3Dxx3GvIvh2cM7gq9DmbV9DAuUz5/wXXEV5nV8K9TmOl1lPReF9aLby+zQmmRQlKaA1x6SBMrh+haInBkdniPIPF0ZprtuIN094yvAnvrzPp7nSohZ0vCAYnd0DzIfTFggWH/jty4y0dBXfeLRpihzk983hsdMgxaZNTmyXfCWz6QAsFQeqyGuANSsPE4JaNj3usqxvILJLWUQA3/xH1Y+uUgQb6WjLTrx5hYFlyL95gX7ghE5FqE4UjbV+53QVq0g91XkDy0H+6PHbDlNFRXMWJ9SluFgxkBG1WqIRYg3UrqXfc4JmoJFsCfcOyVk+x56+c4oWIgXxIpuDzNGaJTfjvJjEYm2gtqt+3k+XCgEHAw4uZ0mT6teObB1qC6O7T1J0k0QfaxwhZaVzzOa3ViLXJ4Nnj+NNSuEkdbqzMhGWggOY072XaaYEGWHt7rvPpV209TmqzwUgZqZ6iWUn2u28+lHUvMbQ+ViNOxRCvbhDcTDO8rDnMU5Z3vj+Ldcf0Pr+d8uio3Hqun6BmtWgrSl1x7HWu8CKUSWmEpA75uAQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(55112099003)(6133799003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUluamtRaDg0VUNNT1ZSdXB6YUVnVE4yVDBPNnpwMDMrT0FDSEYzeDdYWkhw?=
 =?utf-8?B?TGRycDg3UCtId1BXOFUyOTlNNDhBY0w3VVNORUJTYTk5VXpwUzl3SEt5QmxB?=
 =?utf-8?B?TDZPSWpWQWlhMm1aaTVzYkw5QVF0bW9URXFXVTdNM3lrZHlJcU1NVVdUbHg4?=
 =?utf-8?B?SUZNL1ZpdXJyQlE0elNGVXprdllGTmkzQlMyd2VzNkhlYSsvSHRCaFYxaXJn?=
 =?utf-8?B?dS9CaHY2OWdtazd6emJBOEkrS1NIakdiK2xZR3NseisrNmc2RWtFbGJWQVNz?=
 =?utf-8?B?UkQ1cUhMb2tkUTdxdGkzUWtHYnVPV2Z0RnkzcjJZN1h6cXFhVEViYy8vekhM?=
 =?utf-8?B?TTVmRWFrdjBxSUJiZWR0MDFkM2hPUWNBVlN6Y01XZGNxODZMb0FZVjZyMnRL?=
 =?utf-8?B?WS90OXZEZEphS1NGbithMmo5ZHJSNEdJMmhFQ1RuTnBOaGVLNW5Wemd0Q1Av?=
 =?utf-8?B?MW9DRHNzTUdUNDNsbkI5czRYS281Mmtyd01LNjhhNDVwSjZqUTJiUkY1QWtJ?=
 =?utf-8?B?V3MzSW81Mi93djBhN1pMSVhXZGk3UXRxeldPVjNFRjRYNXVpYjUxWnFJWEth?=
 =?utf-8?B?TmVNeGdna21MZ1ZxWWhSM0RPSmo5cmlRamtmVXc1bGNMOHp2dStoQTRSWEV3?=
 =?utf-8?B?NmtBNTdwLzZER2h5RWs2cVpXSDV6V05qZ0pIeVRQcGFBS2JqMWFDY0toZG9t?=
 =?utf-8?B?bkg4dS9kZHd3cW41UVdFSTRSb21iSk1PL2JrajlEU2N3RXg1eWd6R0FXWGx0?=
 =?utf-8?B?K1NaS2VMRmxKSHRGeGVyU1B0S1o4WWRnMERYWk16ZVRnZEluQ2VtWkZyRW5B?=
 =?utf-8?B?bnJkZ3JjcDBodUNaczJYOWZBTG1CSjV3MVlYU1haZlhmK0RjS3gyVFNhVDlj?=
 =?utf-8?B?SVFNeU1OTFhjNE10MERwZmUxcDRUNXVONWpJRDYzTzI1QTlSaE1FUEJQdFFs?=
 =?utf-8?B?NTVCZVo4TnQ0Tnl6SEk2Wk0wenNLTGlDMnJkWU5KT1BrUGVPcklzYUpmejhh?=
 =?utf-8?B?cHRCUGc1Nyt5U2VCMFdDWVdkbVJINUJnSUdZRERnMjZMem5Gdm5lVnllMFBz?=
 =?utf-8?B?M0lYUFhFTFp0c2ozTHBIVVV2OFhDazNKd1NWVlhCc1VFRXcrRkR5K2U3TEEx?=
 =?utf-8?B?eDZkcklHZVdCWndLNUZobVNpYjlNeUFicVZBRW41N2NHNlRmOXZSL2dBemhZ?=
 =?utf-8?B?YzBhcWZpbHM0MllGQ1JlcEZKeDdYMWZNcTFTZHg1TkR0OHpUZmNnRzlBVFVj?=
 =?utf-8?B?SDNjMEdBVXRNc1R5TExiRDhMc2FMak95c3pMQWtSOC9HWWp0azJnZituQUZu?=
 =?utf-8?B?SEJnWHYvN2pMd0FDeTVnMHhoY0FJQ3krelBWdjBWbU1Qc3NJVmE2bm9Gbmw0?=
 =?utf-8?B?ckdBQnUwZkRyNzVPeTROS1B2RG9sUEp2MSt4alg5c0xvQm02NkpaaGxpTHl5?=
 =?utf-8?B?Z050KzNwVkdUK3NsZ3dLUDFRRW9Hb1dKWXdQbXoxbFc2Tk5uUkdjQ2haLzdY?=
 =?utf-8?B?WWJXc014MGRVdW9kajZrSS94UUV5QUFPUXpBaVNGeHVLN1B1dFZVNlRwNEdm?=
 =?utf-8?B?VVJsRGltVnBPUWNjQVp3dFpiWVZQU2RQbHdwc0ptaTJTN1RPTERpR1hhWTlN?=
 =?utf-8?B?bmZVaDFDOStZc1ZZM1FlRWdZS0ZMQ0tkM0tSZ1lvU1BvOFNBYXBaU00wODA0?=
 =?utf-8?B?b2U4SSttSjlKZE9HTGpQeUF1RG1laHJlNE00S2tzMHRLV2pUcFpqUzRhVDVt?=
 =?utf-8?B?alBWZ2V0S3JFbG1aNzNIRlVkWE43VHBMZk9meWNabmQ3K3FxaXlhOC96Y285?=
 =?utf-8?B?bXV0Tnc1cXMxYjQ1d3pHUmgybmQ3Y0NCV3Q0alJsYzJqSlNmOTB6ZXhkVGRt?=
 =?utf-8?B?cTIxVEVCZUgrd1ZCM1cvZ3BNYU9udkdrczNCRzM2LzJUZENLaFFQcHJLbWZ0?=
 =?utf-8?B?aytNL1F6cFltMVdQWmJvL0lEa2ZRVGRHSmpVMUcrTkJUb3JtQVJBSHhzblNQ?=
 =?utf-8?B?aW9ZNlJ2MVpVUmRjVVRBSlZWdG5PNUJtMVVQY21YVi9IalhNZ2wybUl0OHE0?=
 =?utf-8?B?MCtmR0N4UlQ0N0xBZzlWZWxBcFd4TWExVWhhUmlmOW5SNjJmMkM3aXRHUG5S?=
 =?utf-8?B?d1liNGRieU5QNkVNSHFsS3JtaDZkcndKU0M4SVlWcndNQ0RoZ2lGcU5WNy9P?=
 =?utf-8?B?MDF2Y1pOdlBOU0ZLVU1PaGREY1ZpZnd4QUVvQmFQTHhnQ0tucWFLT3pTTGI1?=
 =?utf-8?B?aW90YXJsRnU0UmRGcmFpUXJwSTgrUGhuMGwvbVpER3RNemxXSWZXRlZ1eTBE?=
 =?utf-8?B?NUZpUU9nTUd1Wlp5dThQOEt2MTkxMGplWHVUb2ZGUmRLdGNMcnk5dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d330143-3832-4b02-8dd0-08deca4c1789
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 19:35:29.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+wt9NsJkEXrtVOuDGY/GimzFMqi0Is3oZg3B0/XkwfVmjgQOweyEkOIzJrbrIeX4zox7wqsmcmM4igagqiaFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7382

From: Jan Kiszka <jan.kiszka@siemens.com>

This shall be invoked before a thread switch, providing both the current
and the next thread as arguments. Some scheduling classes may need it to
correctly handle their state as the sched_pick may not be invoked when a
higher-weighted class is providing the next thread.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/evl/sched.h     | 2 ++
 kernel/evl/sched/core.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/evl/sched.h b/include/evl/sched.h
index ae9690860146c..0b16f1b1cf626 100644
--- a/include/evl/sched.h
+++ b/include/evl/sched.h
@@ -120,6 +120,8 @@ struct evl_sched_class {
 	void (*sched_dequeue)(struct evl_thread *thread);
 	void (*sched_requeue)(struct evl_thread *thread);
 	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
+	void (*sched_out)(struct evl_thread *thread,
+			  struct evl_thread *next);
 	void (*sched_yield)(struct evl_thread *thread);
 	void (*sched_migrate)(struct evl_thread *thread,
 			      struct evl_rq *rq);
diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
index eb133e334d30f..0d49fc16bd67e 100644
--- a/kernel/evl/sched/core.c
+++ b/kernel/evl/sched/core.c
@@ -910,6 +910,7 @@ static __always_inline bool test_resched(struct evl_rq *this_rq)
  */
 void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
 {
+	struct evl_sched_class *prev_schedclass;
 	struct evl_rq *this_rq = this_evl_rq();
 	struct evl_thread *prev, *next, *curr;
 	bool leaving_inband, inband_tail;
@@ -990,6 +991,10 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
 	this_rq->curr = next;
 	leaving_inband = false;
 
+	prev_schedclass = prev->sched_class;
+	if (prev_schedclass->sched_out)
+		prev_schedclass->sched_out(prev, next);
+
 	/*
 	 * Careful: we _must_ have updated this_rq->curr before
 	 * performing the rest of the context switch code
-- 
2.47.3
