Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC51FCE
	for <xenomai@lists.linux.dev>; Sat,  9 Dec 2023 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iTaTzUgS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h259pv3C4psvXmhwmdJL5zCypT5M1qRUKHaJfPD6CoUdb8Yx3OJyESweLI/fM11bo4O49CPXYExEmVwUvf5OHJf8uMb7qmb5lICjol0tAfxzI6elD38F9ygJCy4ikSABlahw7TfVyie4OL6bt52XglAzFip/dVXoNVrAMmOr1aG0CvFYiL4cJAKSMilMb0xcyuUgYf6UfglT1v7KQzwbBjnT/G1YehB/IavrQLqp8TpQAAeH6BI28X5SU97rYn6hBd6kFIL1/pCQI/pcf/aQBnSziqXukJpctIXc44huUdR8WiF+KrI3324wZ+lyG9Pzpg+/jSdf7oJFVuZMxpr32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYb68yr34jlJnfBZ90z7qJNs499ICYT3YXh1GMW3eP8=;
 b=eoojNzAlfteJ0cgrfrOOukRcD7DhwIHSo/DuCWc/SWj7U6YgPdiSufOlcinPNIp/R9+MLGWkZRMkvCXelQbrVbmhHvEZUdKcnq+dPZnc3GC78xIHvkp1ARPOYl5dZJajbVhZAFgOEj/dTpZfnuRhqp8j/SDfvLlQ0SfcJMVTLBhhEcMqmvPfBrXktQ6tqfDdzBZqlcohkffkwVrIdVj0r5FX1r/rP4smhsp4lP7AOff/v0UAGjMfo1Zr5PTslC5vDN/aQKWbVmnZui32+MsAG8Cm8MUq2w299JmxCz5EQ6tkS/jBT8qr8KOzsG+VIwO9QTXv6rB8gJ/35PDeCy+tPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYb68yr34jlJnfBZ90z7qJNs499ICYT3YXh1GMW3eP8=;
 b=iTaTzUgSJbXBjiLiEXf1+EtP749cChnHKjzGcqP6Xq28NUeJYx+uDKu4Kw5ycpsqtCRhQkVjZOiFI0MkiesJVYI9NUihliFu3vG67XdfTg2N3fh2y8SefXsfgGbpO1hciuBirB6ZrFPBXH6S1riAHtk6okEeMynHofAN4SSfyiPWzJn4rwEVgl8qFmDo4FOm200Krm2Ts68RFntZdfyDrzaZvm0wuDzR0HPb3+sLDiSes98Nr339/2N9CJAc2xnUCUXa3XetBhQUKRdFVOQiep3NSPsGxrK/V/CSKe62xauXQ/eBkxPSEwiv+P8JKGr8yPnOJRWMgQvMqqta+KxsaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 09:03:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 09:02:59 +0000
Message-ID: <69ae4c12-197f-423e-b19f-b078573b73e6@siemens.com>
Date: Sat, 9 Dec 2023 10:02:57 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail-6.7][PATCH 1/2] genirq: irq_pipeline: Add lock guard
 support for hard spinlocks
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0274.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3860:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2b4dc6-dab8-4224-2fe5-08dbf895a459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e+qEdFd7C+CVy6rwzyrITJyqBWWiSnYZ+Dlw97TuXGqz604rOnKGaV/HNNLu9o7tTQCN5m0FO+gTSZyN7JbJRhGWayN7EFwKqSu3/7B0BRYfhGPihu4NRIbWt8zwO7P1M71ryc2J4dTve/kcosaXjTvpetl/1UyFg17AwiRehXKK36Dq5xHTgpgjbKXQU7CYyuO8l7mornsAzPq6TeGdeFry02ihiqPtLSFKsjTSD2Vd+0i7MrU2N/Y+tol5tpjE2Oq2kpPBdP6eUP1IG98kZHc0WW0D/mNAbr+WP5QIdfUiKyayr4nI292uIlApvwlGGywUbz9cSCBalO7yhLscr0jMeHmAFgaA9TDBH1qBhp9csa8ukeDbc5yrFnQcbBeZKtEyFTme2ov3l9GWBn5OIT2QwM5qIhphj/c5tsNxB8N3CCtmYSRCEtZLhsClI5yHeqEhEAwKzoQHpX26HRfwTB67hOR1tTD241Z+7T5X9gxXJ22WQmkYwoFMXimbwJcSg+byglC2MTjSjiHdSxXPxtcuLxmR+siGMVFTCoeBAvn5SsYFgcsic1/c6sey1/3r+Hg9IB3QvATmGRBlk6Nko61KhSR2axpan9d69AO9NzKsnL2BkrAVBDSyhS3MypUMbr2NyreJHThjBhOxvFfm/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(36756003)(83380400001)(2616005)(6506007)(6486002)(6512007)(44832011)(5660300002)(8676002)(26005)(8936002)(41300700001)(2906002)(478600001)(316002)(110136005)(66476007)(38100700002)(66946007)(86362001)(66556008)(31696002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXhyb20yTzNsTUQ1cU1IT1NyZmdLRWNmakQ1dWRVeTdRRU0yZTBuTmJxQ0hq?=
 =?utf-8?B?V21EN3YvbG5IalBsdjFBWlpsU09DdFZpUENaZG4vc0VzOHhXclBBYjhlYVlj?=
 =?utf-8?B?V0JZSStwMlArN0l5cUVWZGJleUtia1YrWUlDeE9DaVAvNjM3dlBDWW84RXli?=
 =?utf-8?B?YXFpRTlHdGhka2svL0pFQ0dkd2ZIQjgzRWNjUFFMdlJnNVdaV2U2V3pkNCtp?=
 =?utf-8?B?Zkh5Z2ZVbmJ6UUtDMDlFUm1xOE1xSWlURE9iVWRQSjcvdytYeG9ZbitKTEJN?=
 =?utf-8?B?azNCRHZHeHkzWVRON2daZ3JOZnF3MkNtdS9OSndERUdWTVNQU2UvL2sxeXoy?=
 =?utf-8?B?NnMybDZkQkRneEhHU24zWWNkcnliSnpXVmQ2QXg3MHU1dWIvZzFrL1lidFZh?=
 =?utf-8?B?cmN2YTcxN2R6U0VndTlBS0NJSEhablVybHdJM1JHMng2RHVvZGZDWlkyaUlm?=
 =?utf-8?B?ZXc5RThOMVIvSktEdzA1RUxPRmhZeGdtZlRZeGwrem81OHgrcm5LVGtvWE16?=
 =?utf-8?B?UWUraE5DdHBSTzVGcU1OUDdPWHJLMFYxQVF6WXZzci8xc3JwMzBMaVlyZFll?=
 =?utf-8?B?dW1hNzF5MGVWMzM5ZTZ1V0RsU1N1Wm1GRjgxRnZta0Q5ak9HSUs3NkVMQmtI?=
 =?utf-8?B?T2xzbEx0K2NMVzBnbGI1bWJJRFBEbGkvZnhtODRWN1ZoVUhUSTJzZW5YU3BJ?=
 =?utf-8?B?WCtmYkdEWW9JbkdhQy9ldUpPSkhJbDQ5aVRnWEQ0NDI5bGlmc0l2Ri9uazlu?=
 =?utf-8?B?KzcwMGprRmFCZGJ0TU02bXdDZE42WXAyNnFCL3dTVW5na1hLaWhTMFNpMHBC?=
 =?utf-8?B?Q3VSd1FVR1VoSFIrbTZ4UTFKMC9PMlNMQVZ2MFBobURGeC9IdDY4RE1xejk4?=
 =?utf-8?B?dU1pd0FxM3dqSDBkQWJNS2FMVU9nQXZKS2VYeCtVTll6V2U3N0xqRXJ3bDNu?=
 =?utf-8?B?K1pjWVAxcmZ3VTh4RHdqU0VObG9YclhKdUI3K21HQlRjNDF4Y1M5T3AreXRr?=
 =?utf-8?B?SXZTdFNyL3JOa2N6ZTVhSXBWeEI1Rkk5RDVRamJnTmVLUWFueGxxeEwrS2ln?=
 =?utf-8?B?aEEyUUdJbnV0ekpQLzYxZ2Nwa0h1dTVUVFVLOGJZTFdZa0J5L1NtbnFESlg2?=
 =?utf-8?B?ZE9nanF0NzFsWFhWQ0dveUhmNnl0VlhTL0ErUkQ1dlVVQnNDV2YyS3NKWnkv?=
 =?utf-8?B?RkhLeTF0NHFiS29pRWJWT3Vqb2kwTjBtd2NPYWNDcGRJck5oanZkRXFFMWJS?=
 =?utf-8?B?bzNVWGN3T3M2amUxT0xRb0x4bGVqZE8yK2pjSmxxaVJNTldGQWl2bWptN083?=
 =?utf-8?B?cUJFcXpEZExlZm94OCs1blYrdUFRNHljN1RnaGdmUU5XRFZnb3JYbWVrcUFJ?=
 =?utf-8?B?Tm1SalpyQXpBM0hJZGRnZ0ViNjdNSEE3Mi8wNGZ0MXExcEJ1SjZ4YisySFUr?=
 =?utf-8?B?VXpEdk5ZUlBieks4QngrdlZPTzF4ZGdkcWtpTk1TalIydFRaMzhSUER2YUxx?=
 =?utf-8?B?UzgxQnFaMTdGa1JVTVNaZFVtSldibUxzM0NINGN1MFMxSFFZSXJBVk0yVDJ4?=
 =?utf-8?B?Mkp5bXZBUTVVZ1p3T1B2ZGtRMk8rdE1FUWVoNkRsVk5ncFVuVWVRV0N0Njgr?=
 =?utf-8?B?YzRZd2dGMlc5ZXRHRytwNmhCNVVzUXIrT0NTWG1pQVpaUmZsVEpwU2Rwd2cz?=
 =?utf-8?B?dkVSUEpvaXN6cmFtWlRaREE3OEI2SS90WGRtbzdCbDdFZlh4K0k4M1ZSODVJ?=
 =?utf-8?B?eExTOWwvdFdzTEhnYi80S0lQM2VBcU41N2YxUUhMcVFMNTE1U0Npd2g5Mk9l?=
 =?utf-8?B?UlZQVVJtRFlobEVETjlrQXhsN3hHdC92NmgxNTMvSGRvbzJTUEpEMWcrU0FB?=
 =?utf-8?B?Q0FGdlRUVWt3b09rRVFLbDlsNG00WUhaR1l0Wk1tV1dGZ29lTHNHVHEzaGJC?=
 =?utf-8?B?YWNLOTJMd0k3TWZvbGhJUmx0NmRyN24zN2lzWGRDNkpOZ0RKUzQwejRnNDU1?=
 =?utf-8?B?OGUxZmRaV21wRVF4K040dU5BaUZNekc1MTh6bmY2K29mcXBqeFhrRDFUMktF?=
 =?utf-8?B?NnN4dnIrSHJIRUpocGdNVUV6alkzOS9kcm5SU29xRGY5NFR6UEZhbVdJcGFQ?=
 =?utf-8?Q?bRbj4jvYlsUvmOQzTrxnn31N/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2b4dc6-dab8-4224-2fe5-08dbf895a459
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 09:02:59.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2gCOCI2pJ+2gjy8SCNWlLD0RhhT4qxuYEqADL57eL8DQungLSh/Whuq18UHbCBHuaQSyXqZBhUgoLcSY0MOeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3860

From: Jan Kiszka <jan.kiszka@siemens.com>

Will be needed when converting guard users of raw spinlocks to hard
ones.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/spinlock.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d5ab32d64cab..0f01c1cce343 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -554,6 +554,26 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
 		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
 
+DEFINE_LOCK_GUARD_1(hard_spinlock, hard_spinlock_t,
+		    hard_spin_lock((raw_spinlock_t *)_T->lock),
+		    hard_spin_unlock((raw_spinlock_t *)_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_nested, hard_spinlock_t,
+		    hard_spin_lock_nested((raw_spinlock_t *)_T->lock,
+					  SINGLE_DEPTH_NESTING),
+		    hard_spin_unlock((raw_spinlock_t *)_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_irq, hard_spinlock_t,
+		    hard_spin_lock_irq((raw_spinlock_t *)_T->lock),
+		    hard_spin_unlock_irq((raw_spinlock_t *)_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_irqsave, hard_spinlock_t,
+		    hard_spin_lock_irqsave((raw_spinlock_t *)_T->lock,
+					   _T->flags),
+		    hard_spin_unlock_irqrestore((raw_spinlock_t *)_T->lock,
+						_T->flags),
+		    unsigned long flags)
+
 DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),
 		    spin_unlock(_T->lock))
-- 
2.35.3
