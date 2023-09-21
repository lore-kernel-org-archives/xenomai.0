Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CD15A7
	for <xenomai@lists.linux.dev>; Thu, 21 Sep 2023 17:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfSf0ztgUqtkB82LYx6HT24Feym9WkU4WXoDsWYq8wffMMQq0134SjVijvKaVi8KczUIMdPXsofGon531rs8fny7mrZtr/eJSBPVtVHlsMF6KrQ9q9tPehNHg4RMt4hKHwfs5R8dsGt34WAym6kZ1o/ZGxpvAb6lBPx9m4SGUwCcfv4+RLINtIBq/nanz2vgIttYCPoNkHOnUBcSfbFqrn3bR9PAh7WIOwctW2LZblWee0emYamGYzjOLgW0vk3Xl46u1CvisAvFTPxPu1F1bIKAVmNSk1kwKxDGTbc6wMnEBjXNmyAZfN8w4lRFT6InUlyDBVUG+6RuElI25CqXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMCD7IbRKmVJ6XhQb2PjjuWQi9aduRaQvdvMcYsfqC8=;
 b=d5nA8pLZXXnrSzij6p8vKtRn/1+6UnG9qgWjIV5Kfy1urOspDFwvlQiSJAvYnQz9l9nmhF7e19WkeQJPMcBP5VkZv/hBjqsjT7tMwXLXu0kjsFQgDVm8hvIgPeA4P3i5v4bV5b7Wb8SaPsg9xSQFNB+BIZ1A4kBbKVSBp/Ii7CsN3C+fUgpQ8uUu9I8JkycffMeavilKhvEX/0igvyn0xn4WmvsKa979nizUmCucheFgK6lYEtLIE+ccbrcKzWu7kTtjB04LlJeN1Ai/DMFMOACvbqPE1914MM8PL7xok2MhucZyyqDkJ3Ok8LPFuUKIgF8E0CM4xe6gtXqRxmrXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMCD7IbRKmVJ6XhQb2PjjuWQi9aduRaQvdvMcYsfqC8=;
 b=WFycpq1uX7qa+vtRAi3jalJ3CwN0GSVsD5b+cOoc8x9C9NxWhcThpm7FUYj72Jjv0EVM+11D04W3We81fuOILcthQ2P2nP8PY27hP9ZbdhFq7sGkUCaViACtvUGRBwQJx+p6JFQTc5/SkZQ/+vpQlXwGFwl8reQb0As07u66dEOnRlHVHsc4zDpyto0unplE71hxjfmZUd3zYCOsPxw3AENBdXNt3L0iNsLO4HE3RMras4iXkxfi6gZQ+Q37hTyC83K9T58P5Tb4FcIznMOdVbGsdauaCId5xgg8Kajc/OXNbqhrXBDxAbbywXq5vfb+Kqi6KU7Pvg/2FVnWNPUlrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 17:38:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Thu, 21 Sep 2023
 17:38:27 +0000
Message-ID: <1eb4952e-f76f-4831-87e1-5effe76700ca@siemens.com>
Date: Thu, 21 Sep 2023 19:38:14 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail-5.10] Re: tracing: irq_pipeline: add pipeline awareness
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:610:cc::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3869:EE_
X-MS-Office365-Filtering-Correlation-Id: 274c2aea-d42f-4644-3bf5-08dbbac98ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y4MoVGaGmY7gu4+6Slj1neMe/D6771m7NALSxjz0eyzMFl7IDY00wETXSNKQF33muKJvyNnfWT+t3W/d7NJXSz1Uu/4umXeauuqV/UC8KowClKVEUA9bWRTJZja+E5YhtHUcQZbKikJlh2Va4iEo8TcRIGi+YeK0Hr8wykVRyZE8bME/VYXohbVXlVxg3ryzycc3bIPUrwgcmJcLdt1EsUpDn5Vcrav3FvOQgM46TTlTnmakSlx0Q0y4910H4/vIU3ThPOh+UCBw4XLbNk8nTUN0AIebMqnXLM1yAs9SdsiwY0pT+2C1MV6R4nMQYPQworB8i5nMZbMldeDBPkDmQPGfJZy4YfswJ/1pO4npy/1DeRgLOpbFscrk7VgUhWICJkJ7HNlzQDBgufnF5DoM8/IBgJkjJCPovT8FiJ/665eqoOUsl0TdPN3MBwOQiOzygeqkxy86+kcOo2Y1Gc/xtt9tqVGIy5F+jA/tyYuvBHS04LBVxmEjfbR51kYkAL2AXjHrinpsPN/qELTuuEKjv8yCPVfjFssbNc+suQMZ/8EptN5FvIJ7WMfJIDCB1fURDmmxmmAWrf8ZnIzI8t+clqJwBQaCL5VVZUfhfiiphCRYcX+INQYJrCThhvd5UHMzzu6oplhnyWnsW+eawB+1Wg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(186009)(1800799009)(451199024)(478600001)(6486002)(6666004)(6506007)(6512007)(6916009)(5660300002)(2906002)(4744005)(83380400001)(316002)(26005)(66476007)(44832011)(66946007)(66556008)(2616005)(8936002)(4326008)(41300700001)(8676002)(31696002)(82960400001)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clFkZE9oamxNWlNhRUduYjNLdVhjbDVRN0JxR2N0cjVjandybVBWN2ZKMWRZ?=
 =?utf-8?B?UnJjb2xyWmpqVXdjNjJVUzU1OUpDVEl4U2Mzc1NSYTE3ZDdFY215Y3Vhcnh5?=
 =?utf-8?B?MkhGdU1RWWViZzNScDhoNFdpaGw0MTRDL2NjdWl1QTFUU1Nxd3pkVnVZbG83?=
 =?utf-8?B?WWZHMk9GekNoSXBJVUh1TDVqOG9scTZOdzR2ZDBpZVlhWk9mVVpPR0crVDd3?=
 =?utf-8?B?cW1rZHBSeEh6ZUJOUndFcGRENFIwTS9wbHI0NllheGJTckRYNVB5d3R5VFJP?=
 =?utf-8?B?WWcvNkRaOG9oR2NPc0M3d3g4VDloZDVBWFpWOWFvYlNHT2I0akRjRU94bWVX?=
 =?utf-8?B?MHVJRWlaZlFaMjZqZnZLSis1UEkrOXZodHBHSTlaYkExenlnbVVCektwNTgv?=
 =?utf-8?B?T0JJSnF4NXNtN2U1empvYkVnWDZqVkR6bDFCMzd5VC85bzd1UVZrRnZEc0E1?=
 =?utf-8?B?clNUeE54clQzOFdDTWJtMDBOZFltTHloMHhpT3Z6WFdwMWh4ditrQmRlNFRa?=
 =?utf-8?B?Z21RNHBsYzlQVVdyWkFVbWxqVGRic2x4Q3pqZkx2ZTJGaURybkZtTndCbHV5?=
 =?utf-8?B?SWZYbEFyUzFLMDBSQXA4cDMvZXF6OEVyNjI0cVRwZDgraTZKN2RDRHBiaGR6?=
 =?utf-8?B?VXlDdk5Pb01uY3hCMEphd3V3YVlpN2w3SVJOd25OT0dvbzFlREdxdVhPQU1p?=
 =?utf-8?B?ZHJFbEJyczIxdG43Rno4dDVjcS9Qb2lLdk56bGFEdFM0RzRKbC9vVDF0aG15?=
 =?utf-8?B?TmJUSFp3THhZR1JJMTgvUUtZeFNiK1FOTll3TlplbDJlWHV2cDF5NzJIR3dl?=
 =?utf-8?B?VGo1bnFBV0hGMWpvb1NMTVlmSDYySjVDODZZVUVoM3BJM2lJZ1FKdUtIZjE5?=
 =?utf-8?B?UXlLakJBdDJRdmhCL2NrR2tWa0VXaTMwRG03SEFGbzBHYmtPWUFvUXVOWnZs?=
 =?utf-8?B?d0U0NXFhalZMUVZ4QmF6VVN2TzVlaDNma0tUa2Z3QmRaS2h2UXQxYUlqVWZy?=
 =?utf-8?B?NTlQSm9WODdHVTV4SCtsM0dtK091YzhyMVd3U2FRZmtCSXFIclVWakNXbUhX?=
 =?utf-8?B?MzI4OEJKRHlHdXdsa2VmQ0tPaEp2a2ZSaytRWGE1Sm0vWGdCWWxEVzRYMEJZ?=
 =?utf-8?B?bVJWT3BvTkZBOGd3MnNKV2NYSjZ3NE50bXRwN01GTGpPQVhUUGpOSXlpUW1B?=
 =?utf-8?B?NTZWZ0dCR3U2c1FJZFhRaFFhZ1loalRWS2YrQlhlSHRZSDdLRDJzYlJXU0xl?=
 =?utf-8?B?YW9mWGhwU2w3cmUzaWowUkJGTE1JNkQrZmQrTFBPbEZqOU1jclVXcjJQMGJ2?=
 =?utf-8?B?Wk41MDhFbHBqM3VEMGpweWMrNnAxamVMY0g3Nk5CR2JRZjhTZ21lTG14NDdm?=
 =?utf-8?B?TGlwRTI5TWF2emhzNkQxV1ZQR3Y5S1lxeCs2YmxKdW9mMGtJZ3BXeUNUYUdN?=
 =?utf-8?B?OFVBbXBtNDBYYlFOUTlOVzB4VUxyTVNPV254TFlocHFhalJKY0l3R2dacGlk?=
 =?utf-8?B?cUFvTjNWcmM1a0pkalliNXpMK2dkdVR1YXk3L282TkU5MXF2VGdYVnVrMGMw?=
 =?utf-8?B?U1ZoUENMSWF0SVN6MENkVU5hbjVqVHNzK2VpQk1acWFBMHI2dEQrclpPMFc4?=
 =?utf-8?B?ZDRiNmVBTTZSalgxSGFwNXJXQTdZZjZYZzhFa0UxMTlZMHZiZXZUai9GUldM?=
 =?utf-8?B?NVAwdmxXUjRURnBnaE95L3VMaXdkWEt0Sk16d1d3NE5UNmpCbytXYmNHbEVv?=
 =?utf-8?B?bnBUSVNpb0ZwU2RjTTVGZXpNQ1ErczFBcGtWMm10RnUydW14VGJDcjljWHFu?=
 =?utf-8?B?Q0c0aVRuaDBrbjVyMjZHeUtTSEdFdHlEbTlSUlVrTytjS3ZPOGdxTmticnhx?=
 =?utf-8?B?M1RIYmRIZU9ING1QZ05HTml5UEZiVERicFR2V2ZTb3Q4YkUvTFFaK1hHQkw2?=
 =?utf-8?B?ZW13WmowV2NyNkE4eldSWlZ0OFd6NkZxQmt3S0ppek02ZFUrc3NDcXVLZElt?=
 =?utf-8?B?ZmhaMnlPVjRUeUsvNEUzS0VjM2ZIRzdnM2FTSTc4bXZXMVB6NUw4WHVhK1k0?=
 =?utf-8?B?S0JYTTFaUEZxakcrMW1rOEkzbVVjR0tOcytkNzZHVEV1VG5BVlZFVlZBWGNM?=
 =?utf-8?B?NEM5S0xzc1dFSE1XSkY0ZE1UeTBmeWoxU0RtMHJUeTE2R2hoNndVWHUzSVU4?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274c2aea-d42f-4644-3bf5-08dbbac98ffe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 17:38:27.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0emxPrzdHvxa+FR/WUzyt+vSJ0zsAQqWXXOhFLBWwJ40DtHfL1RAsPTGakBnB1a9go/fq2SvEQcpP/VG2gIclQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3869

Hi Philippe,

what is this fixme in 5.10.y-dovetail-rebase (and only there) about?

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3e0ae1168069..8d10bdfd8ccf4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c

...

@@ -7229,10 +7231,10 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			break;
 		/* Now, we're going to swap */
 		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
-			local_irq_disable();
+			hard_local_irq_disable();
 			update_max_tr(tr, current, smp_processor_id(), NULL);
-			local_irq_enable();
-		} else {
+			hard_local_irq_enable();
+		} else {	/* FIXME: irq_pipeline */
 			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
 						 (void *)tr, 1);
 		}

To my understanding, tracing_snapshot_write() will only be called in-
band, no?

Jan

-- 
Siemens AG, Technology
Linux Expert Center
