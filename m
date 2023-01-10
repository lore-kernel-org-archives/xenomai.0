Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611718E
	for <xenomai@lists.linux.dev>; Tue, 10 Jan 2023 06:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nITPIhIVWjJnW4Jwv41RAwko3Jgkw9NMg7rMwzNF036NxjdV8XmJ08dY0/dfXK7OwY09tQudKoOLysst7L4GC08Mq6IDZqG7airFRnlFCckaUeMtgJZscxpTlCqJMmaby2oA/rnZhxWaJlxcsPbR1mSUT433bMrMmYjASBZqEvByfCnVcli8vyc7DI2M7vfuO9L/xw/SIUJwo/yy77x31pJ2unqTPdyP9MJJorGJO5d46vusfcY0E700DXIScoDJnt3yVcIsbi6nJW9rc8fHB00ShVxC9WuUPN4y7agiL69mgSufBE4mu3aEktKcc84dASzdgrAmXaQ/bF6Vweu06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04fyK2nooCCIQgDBtRYeVOqim3UuuO6j9rnVCRmVvAI=;
 b=AbxjAOtySSl7fSctMUfeUmG4SaQGe8masUNG4ojSwu5iNdwZNkL5Ao7S4WeKL6THKOEwRRzMGVYV8hnvoImZD3alFheBzmWa0j6zW03BzvzptsaKU850BNuQzUqQA65VwZHJDhkli2tRT/ijhnGdakLHy1SgKi/4gqqRGu5FpF0H1D+MRlcZPphYF+ImjbQsiTDiNuvgL2DCZZIbYLVXYWtwDzTUS53QU+zsd6yJcZdKWRhCr9kJj6t0YYft7rJ9wxr0RO28Za2pqKVW6VTSLRXs0NySPCfwttpPM4jB/IQIG6/XY/rfB3q4cWnb9jDhwc8kTI8o2SIMJj8U+4UMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04fyK2nooCCIQgDBtRYeVOqim3UuuO6j9rnVCRmVvAI=;
 b=haDJr9QoHCcsjf3GgoHQL6wg/wGj+TC4sZrhdMBSPnil6G30siF+Ypm09KZFmgvjCWrUIhB54t6f2Bc4hOPD3pzzPI3/A9AEgLeA45LFhNmqkdRvU9BpfCkkS0dnXBc8QadLvSAF4IaRd54q78Chda5gfp4dl7qeHmT8wuf/6SZoHhJgFVRrjXIoNdnyIX43E2LDGm/UhaYY/nwQ28SKu1s5RTY4W2HZ0fs8cnEOIznyqFagMaUHKonrLmceEfPGbmjjW4DMc7yXlmSv1FqJNGT91B6a0K5GD1NX62B2nSW1BEkLND7FpArzfdH+oV8PLW+2g8nLNEyB2UygNh250Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7900.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 06:37:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 06:37:22 +0000
Message-ID: <b99be622-aed7-d6df-b832-fbdff4a44072@siemens.com>
Date: Tue, 10 Jan 2023 07:37:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/copperplate: Release main threadobj on exit
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: "Mauro S." <mau.salvi@tin.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: ea86da26-0d02-4b2f-9b66-08daf2d5210a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DJ0dHvIzYjj9ZkBxDpmVxH0+LMa2Xn3JROP1teqGRTW9DXsXw4v2YybPFMhNyC4G8axTd2akeTDFLtynfUPJ5aFgmLunS8xJofiTllU/ZbwMBrLJOy9M6nZaecuQtX2MwPUvbVr1H6YGpPH7yrJDC+7p1g0mRBQI74RnUUjGZ/TdlDh8h92PgXBzj14SqI5ukqg1qC2KX1iuq67xo6MAq+PggRjMCq7I8FS5kUnWBoEzlDkFwBYIopzHU2aSCI22azJ/RH4+E5UANvlay/EEdCPMz32VTgzU2Zm+u2tPRY5aVcDvPW8V7loxt7Vskgir2Oy4pf1LdhxYdCGGWnnXKqHy/zZubMu6zyqUfEwpoV1KkLUVYKCOt3KfDcCJmjsVz3Ft2Gl+2eV9b7iHap0slVMRAFmL+j3sCvgaPywWWH4EdAbjUW0/Mp6FsLMz/mBG3z66B411Hw6AquCp/mYDDM7Ka3P64cCU/LrUhg2fkJAlYfHLORQuMTF1EHeC2/Xyrn8FqAZHJ5QZ+YnHdXsaLu8qVBb4j/Y4zHugN3JQ63wLP5U1qYrSPTOoVzRoAD5JzTqk9fM0rJmVD31JZQHtrSlR5QB2Upzb1VJNoWVO8m+BjHGm8UDSyix2U1idLH3vYdKpJNls0bc7B0hmYMv8k2aHulHq+UkadgFrnOHzqsjIF2S5UZWIMZQDjePJyVHijdfMVVD2nSSNDx9m9dCFRHBfPwExahg1K3YJxA34kVU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199015)(44832011)(2906002)(83380400001)(2616005)(66476007)(66556008)(5660300002)(66946007)(26005)(8936002)(186003)(36756003)(6506007)(6512007)(478600001)(82960400001)(38100700002)(6486002)(31686004)(8676002)(41300700001)(86362001)(4326008)(6916009)(316002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2d3OEZNOXBvbWlITEtTc3J1WFFQUTQwUFZkbUVDYmJGMDFpYUVOblcvK2Nn?=
 =?utf-8?B?Ty9tTmpGeWNRNGhGVCtjWWJiWGVrNUJZeTZTWjJXdmMzMUlZdEJIT0ZOYXg3?=
 =?utf-8?B?Vzh3djBReDMzamhhNEUrZVRiYWpHTFJNd2dxeUpzZTdCalVoVmxtVDJUeEdZ?=
 =?utf-8?B?MCtaS3pVckdXVUlCZHRjTEc1TDRyMGd6UzBiQ3dMZWpJak1PeElVQUFCUy9Q?=
 =?utf-8?B?OWpMcVQvWEZqN0QzTGFXZTNOUW1QTDRIdnJWaDZraFB4czBNV2dVSkF3MEcw?=
 =?utf-8?B?WCs5MFlwckdmR09pM29YSUs3WXRxK0t0dzJhZlY5R2lwL2U5U1d1ak5acnJU?=
 =?utf-8?B?UTliSTZGeXo2a2w1b1pHUzdJWnV1NzlUWnRYOWdyR2YxZDF2bGp3RzZVaG1Z?=
 =?utf-8?B?YXdtblBUVGpLSXp4RDkrOWwyMDVHMmNKdk43Y01kNEJGRTRXVE4yWXNiRHBX?=
 =?utf-8?B?YjN3M2Vkem1DQ3c4cGtMdmJxRGxTVVlpQ2VHL09RMC9hcTVuMk1zRkwvYTI0?=
 =?utf-8?B?aTNNaHdBazRBUkZtYzdXcDcvTFdzNFZMaWs5aGVEZjRRN3FCQlNYSFdqVnRl?=
 =?utf-8?B?MTBFZmZkaU5FT09uTWRPNVlwUm00UkdqT2l1dWZ2cTRUR1B2UUN5YXpYUEV0?=
 =?utf-8?B?Q0Y2QzhrZFpocU4xSEIwV2VQOG9oaHZTRFF4VzZ1WEhwM3BZUW5tcEk5Mjlm?=
 =?utf-8?B?WGR1NSsxTUQ0NHpNUUhDR3BrWXpVa0JaNUQwbVBONGozTjMrMk81bkVxTVRh?=
 =?utf-8?B?LzZZUnVxcFNMelVuNExVdi84Ujl1Sm1yWUJBMzY4azRKY0NmU01aR01BakFq?=
 =?utf-8?B?TjJLRC9XT2VzVk9hRlRKT3g2eGwrcmpvK003Uk9NY0RYc21wc25VQ1J6ZlZ0?=
 =?utf-8?B?eHJ6RnRhMmNOdG1UUkdxR1BUZFhpVG5CRldLWDNaNWdaOVVkNWNrMUhGKzBG?=
 =?utf-8?B?MTlqbGdRZ1pnQ3pZNjhFVXFRaTE4c2ZvcWE0VE5tMlpzRmVLVGFJN0NPVDdy?=
 =?utf-8?B?TEJZaG11Y05SV0RhdFJEWG5FSUxsbTlFUWkzTlMvMUJXcUNQbk15b0U3Mytw?=
 =?utf-8?B?bFhVMVh1YmRtTjV0WUhSOXA2UFF6WEVhU0lFUHMycUQ0VDVqYjZMbVJoMk5M?=
 =?utf-8?B?V0ZHWEFxMlg0NDhiOUdWYUk5V2hnNDZHUUk5YXR0OVlhQm5GdGhtRnA3dEdO?=
 =?utf-8?B?cXBFRktTdXZIdTVwTHZQZzk1QmovbmlLRnIxMFc4cTZSYzd1L3FUMVdKb0xj?=
 =?utf-8?B?ejBmZGtGUzJaSGhyY3R4ZTVWMThLK3doQ2VidVZVOC9RbzkrU0N2MFZ6RU9m?=
 =?utf-8?B?bG9aKzliSm81bEhnSC84ekNlcFo5QS95bW5XM0EzNEUydTJvcHkwNVdaVFpo?=
 =?utf-8?B?amlzQTFaUjZxUTBEWjRUbGgxL1RQMzUwYkdXMXkyRlFmKzA1SVpnbGdoUy9K?=
 =?utf-8?B?ZjVBWTcyUXEzS3BtQ0piOTZPNDJGNS9WUGtkRUV4RTY2cm5ZckJTYVRPR0Jo?=
 =?utf-8?B?MWpwdUYyOEdxMDRXTE8yL05CR3kzSEVZN2hkL29WYjVueTY5U21jcTBQQjBl?=
 =?utf-8?B?V3d0aHdoTlZJYllpdzk3N3FDVXNGWHU1TVo1emNEMm9UUXRoUU5jR0M5K1Iw?=
 =?utf-8?B?K05NQzJSMzduYk9rVUlPQVNoeHhxVERhTk1oTWo5M0FDV1U3dHpUaHR4ODZ0?=
 =?utf-8?B?L3FyUUQ2aHZnV09sa3pxS1dzcEcvK3ZKUnVPVnRIbWdXSk1ZWG9QTlZsY1V4?=
 =?utf-8?B?b2pCWmRpVmdHTEtwRlRMd3BFT044VTI4cU52VnBBWHdBQS9BQnU4Smwwbkty?=
 =?utf-8?B?RExRUS9ub0g1UklCNjRvOUVNTmVqQmJna0g4Y2kzSnE3eEhhaERLWW9RVzk1?=
 =?utf-8?B?U09ncFZZdzFPWWsvWnBzMXFKL1FFZDF1c0pIQk9zRTBjcEF6QnQwMmhTSE1U?=
 =?utf-8?B?V3NBbGdzQldvYUVudzh3a3dVUkovTmFiYmNPdkZWRGJaaWdhNWtxMWFQb2Jy?=
 =?utf-8?B?d0ZPeGhqNGxNeTc4QUJ3dVBXdjREa1dyd1VYazVWQnkxZFBCclUrOVN0aDVJ?=
 =?utf-8?B?Y2NEb3ZzLzVxVk9yd3Z2T3FGRVNJdHg0Sk9XWEUyUXlUYXhRcFAyWmxYeDdm?=
 =?utf-8?B?bnVWd0JuUDBFOElrVVVEUEdNWGJPdUM4SVFqS2VuTkhKOHMvanU2eThuOHRY?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea86da26-0d02-4b2f-9b66-08daf2d5210a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 06:37:22.3895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Y6U1EbeWIGX27vqAQ3/RcKw1t6fEaIrKAcZdsN4ly9Li1xRDj9QmOUgtZagRweqDY66iu+OwYl5pt/Pt+TQ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7900

From: Jan Kiszka <jan.kiszka@siemens.com>

In case of CONFIG_XENO_PSHARED, the main thread's tcb is allocated on
the shared heap. Normally, threadobjs are released via the destructor
of threadobj_tskey. But this is not called when the main thread
terminates so that we leak the object. Fix that by installing an atexit
handler that only needs to perform the release now.

Reported-by: Mauro S. <mau.salvi@tin.it>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/copperplate/threadobj.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index f4588a17a8..6808bcf164 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1770,6 +1770,13 @@ int threadobj_set_schedprio(struct threadobj *thobj, int priority)
 	return threadobj_set_schedparam(thobj, policy, &param_ex);
 }
 
+#ifdef CONFIG_XENO_PSHARED
+static void main_exit(void)
+{
+	threadobj_free(threadobj_current());
+}
+#endif
+
 static inline int main_overlay(void)
 {
 	struct threadobj_init_data idata;
@@ -1806,6 +1813,10 @@ static inline int main_overlay(void)
 	threadobj_prologue(tcb, NULL);
 	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
 
+#ifdef CONFIG_XENO_PSHARED
+	atexit(main_exit);
+#endif
+
 	return 0;
 }
 
-- 
2.35.3
