Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362F6130
	for <xenomai@lists.linux.dev>; Mon, 24 Oct 2022 20:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzbm9CISqreAik0BbcHov32i4Ef76zmotFUzi2aECc3K8yjCyNHRINg5svRRBw6rP58Pafv82+2/I+XXv9ixiAfDpO8qiPtO4P5ORwR6HTLfh4Hvrn3m8lks8mMDexS3HmMKU3ARjJLaQiy2UJzzZocnRWEASe8fZ7VAT8Oir8FvLf5ivv1JloIztqIzjT4SxytBLE597/4ZkMqQUeZ16jPq62tl4UXtgGs2POhXHRC34knwyOQX9MTdeFyT7NRNVkPsAYm5Vc1Icpfy2Uu2DzAuG1uEeGCD9iYDnR71pDcGdIgKVxyhgyYSKW3QeGWjIEpD7RAqW8+sCknNQX2/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZDmu36mpGt1+VzMAqbP+PTmLWA/CiSZKUYaoCeZOSM=;
 b=FLxgLQWh6p51cpCRYZpZPtUAMr3YEybbmavILDq2tyb61nwFCK8p5BU4T1J4FofYPAk9OyY53iUfr3FbpZcBZ61HO6quMcBHemmSXfHW/gJ18hW2dcQ7PzpyDq6pWzb2+n8U96LIdv5z6+KTkuo8eGq6VzMTbT2SoffIvDRydsVau0+t4gbTkVIZCv63pjZd787dkTw8Wi395v4c3SGCuCUhUZnCDpXVYRz8ojIb9tdag8O/EYd2+ay3tVLJFohZ2sHoSBJafedMNHb9c2iG/khnnt10u/+MkesOqbMexV96XBTW04Ob3lrulEhkaCZn4WF+YvHMbrdL/SRzliZwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZDmu36mpGt1+VzMAqbP+PTmLWA/CiSZKUYaoCeZOSM=;
 b=WgfTQCLVkMb0wKWQLWG6v6dGrevzLJYlRzWyIvlW0UXz8fYSUSdXb2pU9ev9twfh+VCjo12W1axebMovQPVGQfH88kx2C2XD5AferKeHIpD5QQbfeN8Cs5JG+yD+X+4KsxGNNmkc5QPmcLsDgBqsu+ki45U7UGRq2DZderc1mHbkLb4UZN3uDOec6cGFBy7MX6Qyeo2cgLuLVjJrnb0sgXPZWkIg/Cp5PSwB6P1eSIcp1MO6TgBiHjIzUbl2hMmOyR/P40CIo/MFCFE9UK5Qp9KNph6CQeie/2hf79WfNV+xrxvo0uVEJVpsfadq+vtCM8UHM1ay5FSYc1/h2uWvGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4107.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Mon, 24 Oct
 2022 20:13:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5%7]) with mapi id 15.20.5723.034; Mon, 24 Oct 2022
 20:13:12 +0000
Message-ID: <ca3f971c-87e1-b7b4-262c-bf80483ef9fd@siemens.com>
Date: Mon, 24 Oct 2022 22:13:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Content-Language: en-US
To: "Heber, Stefan" <Stefan.Heber@zwickroell.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>,
 "Chen, Hongzhan" <hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:610:38::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 6021d553-c62f-48b7-e96a-08dab5fc2d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YbaEu7AgIyZ+2vsoVdRH618ZKr8SJ16xYTVTZvg9ivJW9EX5BV3ZQMYlshtB11qvuQLqZuT4xbLE6JGU32prBf3+wcwkKmZJ2UMhWsFYHNNLBbUUrL31GH+Lu4lcWqo+hsXvACRtHsp5dV0FbwlbM7YclZ/1wbZcNcPiy3G4n1dA8z4eYQZifJRBZ94B3VWUUs3uVaA43y4ZGN5+T9mz16t8/qPKyQXFzuNSv43Ya/o4Cr3P/BNS3B7hxBbAuhLKJOewcoaV87fhj7TEXsNei7l+BbuctyYcyjWCt/Y7tnhg2tHyZkc4Fxle856I0Q0MUCWhw92zWnG8pI/dCzZFaCpcU+zc5WdX5XvB146l4sLbBKPMoQhoQIzZbqkWVQmWolbN5Hx8+JNMFc1L3YSNuev2TOr12k0uRgMP0V6CRdVjYOCq3FaFbQjthbx8YRO3rUlcDPU9POzwHIzV1LiYZlmqSvlmfH3wL66wneB3jTJr2yiycW4lCN2fWgrZ9h4mLkELBJjw3WcxrI5SenT3PrS6qcWqJ0KguvY50e3ajHUUybYP3ee4zxeKJUnmp5C0uMAKBDUuZz7RBsvAXdMYxFTjUEc8C8HzCNzRHKAlnvslgStq+vACgdfSEu6xvK9SKEA5+FYCUxFGQ4vaInA+DY9Jw6F7k0tPLqpTggTZlmblGB6pBzNvjIODLR47SIVZI3QR6M5VbsAOlStWKw8VDeIrYx9I2RJPdtSkAaoGmkiKPnH3JNW0mdnguODqOapelGAVonLLdi+mmtFLXJ5mlBbK679UZe380euSS6ua6wI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(31686004)(82960400001)(478600001)(2906002)(186003)(38100700002)(6486002)(316002)(110136005)(66476007)(41300700001)(8676002)(66946007)(4326008)(54906003)(66556008)(53546011)(6506007)(6666004)(36756003)(6512007)(26005)(5660300002)(44832011)(86362001)(8936002)(2616005)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXpmRHk4YXEwOUNUM2lXdUMxVTRCbng0ZEg4VitvYkNxWnRNUEkzMGgweG8v?=
 =?utf-8?B?Y0tzZFZoaXlZNGtiZW11VFJlVkFRaWZpQUpzeVhiaUp5UHJNQlFqRHZFUXY0?=
 =?utf-8?B?Znc1SGExVUl2ZTgzLzRKNlJ1UE02RHBrbmMzSk5ORzcya1YvckN2UGJXTCtE?=
 =?utf-8?B?TW00SDQ2YTVJUHNLN21xbytkbmwvRHBEMmlpbVRVajFSdk1tM1RUQS95d0xX?=
 =?utf-8?B?NjRTRmc2WnhFb09NZTcyb3FOYTkxaTdKRHJ0Zzg4VndrbG1CcU1VWXN2aGcr?=
 =?utf-8?B?WThRaDltZWpKTExvVStGdEJFQTJyQ2FvQTFiWmhLWjRncFpQdGNRdkozdlkw?=
 =?utf-8?B?aGxEZ2sxWGhRVVIwb1JWQ3cwZHRib1E3L3k1MnVyVjlrelc1RlEyd2RnRjQy?=
 =?utf-8?B?VHhYMFNmQnptY1NKWExaUEpiWEFzeVN0MGFNQ0RhUnlwbWQ0RGd2SlNnaS9a?=
 =?utf-8?B?YjBpbG52MCttYjdMNzBkRW0zNlNEL1pya2F4c2h3Q3RhRkZ3WmFJQkV5clVi?=
 =?utf-8?B?MWpFTXlGMWd1QUh0MDloWkQyaXlCblgvS3drcEg5YnFMYmNmMGFSZkVyK1c2?=
 =?utf-8?B?d0lVQ2hUWG52T2o0dWNOcll4U2hxakJ1LzFYem81ZEplZ2d3NjBIaEtFYmRM?=
 =?utf-8?B?UTQ0WEM5eTlBOWgxSmlWa2oycU9LOHc0VHkxNytmUmg4MXJvak5yeWRaQ1Nv?=
 =?utf-8?B?aDNKbHFiT3VMTktZR0hSMS9UdmxUZFBVazVBVS9jc3p3TlVpWHJlWFltMHRy?=
 =?utf-8?B?elFGWlREcW8yeE1NRTdDZG1hRDVuR2RrTmhvbHJwaGRRZVBYaXlmWlVpdUR2?=
 =?utf-8?B?WHdrbmlaR3BpakNCM2VielFMMWNzT2tkWFZ1YSs2U1RJMzNicm5YelNzR0hs?=
 =?utf-8?B?ZERMMUI2UXgxczl6djlZeFhLc24xVlZVcGFWYStocmNKV0xIU3NmSVdjT1Fo?=
 =?utf-8?B?bFVZRU5YOEFYYUI0SWFGemx5ZHpTMVUxSW5qVUt3NS9xZEp4bzRYTmI4RjB3?=
 =?utf-8?B?ZVJuR0dHN1Jrbjc3dUl1VXkxWmo1WEFiSXkzU3AyMndvK003N2xiOThERVpu?=
 =?utf-8?B?bFlyejFtK2xKdDdWaVhIMkljazNwbVdSY0xHNXB2dmpSNENnMWsvM0w5aGMr?=
 =?utf-8?B?OUFDZ0JSV1I3MTQ0cTlrNy9Lbmg0VnNDR09xdTIwdWpuWFFoUjhyaVZHTk42?=
 =?utf-8?B?YW9hTUJzUmx3Q1ZRc0tPNFV5M2VxMlgzWFlUeFlNcnZjSFhxNnU0L0hVRmF6?=
 =?utf-8?B?eFV2czVWTEp6eGZJR3JPZkNjNG5LbWMyVWphV215NGNkLzZwNWhQRXN2V0hp?=
 =?utf-8?B?dXZ3UEhjeSt5VWFlR0h1Y2svUFJrSTYzeG9MRUtSOUJPQWM2c2E3cDQyTzln?=
 =?utf-8?B?eDZpVU5aT0grTXFmSzZhbnlYckR3TmtPZEs0cjVnT0c2MmRPRi9CNEthZzk1?=
 =?utf-8?B?QVdPb0pYb251SS81TFdYMDJ4eDJxMDZpTk9STitwNENsSDR6NFBuNjg2S0FV?=
 =?utf-8?B?R2VFbiszOW5LTkYwUjVuRTJZMkpRS1lIREl1aGFuRWlueTBtS0MvYUVOM3Nu?=
 =?utf-8?B?U1Rod2w3ZUFaVGtvdHE3TVZOSmxGSXVyay9pUDRUM29XMzdJeFhtUHZ0WnlL?=
 =?utf-8?B?SUVoZlY2NThCZk44R0JoTGNMTlg2MStWS2VHc2NoVE1YWmY4MGlRZ2JUdGh1?=
 =?utf-8?B?VUJPMm94OVNXMHBXRFY3Y3BVQnRITmFHRk1LRzRYK0xKSlR6Y2ViSVI3d0pu?=
 =?utf-8?B?Wk05OE1MQkt3RUg4MnlBNkw0K0VuV2tTMXI1TDduMXpGVytmZEFrc0xrL1lK?=
 =?utf-8?B?R2NKMFM3cks3a1NybWpqR2lYcGcvSlJyeEdEeWZZWUR1TFhlWkpkWERtOG5r?=
 =?utf-8?B?ZGNQM3RHWjdpc3FVN0JvMW5rZGlUZWxyb0MzWHZTckNKdk56bnpxbG9WVEo5?=
 =?utf-8?B?dlhadTBTdWNqUSt3WHd3a2lraHVCOW44czdrc0JNSWFQNmdzY0VoUGFOeWRu?=
 =?utf-8?B?UkJrU295R2trUzA4azJ6VHZJVFM2dkZFcksrZzFlN3pXMEVkbkpFN1YwSmM0?=
 =?utf-8?B?eDQvbTR2L0RFYVpzSzh1VUE0WjA5QlBQTDNscXYza2RaSFZ1bVZ5UE8zdHRh?=
 =?utf-8?B?bnNsV2tXa040V1R3NC9NSDJTNjF6U283emRBUWhCMkZXaXR3ekM5MktNS1Vh?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6021d553-c62f-48b7-e96a-08dab5fc2d82
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 20:13:12.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDzeVfvNgneSAiVO5/hoPLBO49ouqBvYsFTnRDdEpoVjTbpeBnK/XuQf3Pua6u2URzLdH4DxDqzCBpdxCvSYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4107

On 30.09.22 13:47, Heber, Stefan wrote:
> Dear list,
> 
> we, as long time Xenomai users now have a severe problem. We are currently
> in the process of migrating our huge application from xenomai 2.6.4 32bit 
> to 3.2.2 64bit (linux 5.4.105). In general we are almost done, but one 
> problem remains: Obviously we have memory corruptions resulting from 
> strcpy functions (transferring large configurations) being interrupted by 
> high prio tasks.
> 
> We now nailed this problem down in two minimal test applications in order 
> to rule out any programming errors in our own sources. These two 
> applications are:
> a) a simple test that swaps two very large strings forth and back via 
> strcpy (and alternatively other copy implementations) and then check the 
> string contents. This simply happens on the main thread.
> b) a "sleepproc" app that simply contains a while/nanosleep loop that 
> wakes up every 500ms just in order to interrupt app a).
> 
> When running the test app while sleepproc is running we see sporadically 
> errors (typically less than 20 runs of test until we see that error). 
> Without the sleepproc app, test runs without errors. And don't worry 
> about this magic txr19391 prefix, it is just an issue number ;-)
> 
> So, could you please help us and have a look into this problem?
> 
> Some remarks:
> - The test seems to be highly sensitive concerning timing. So we had to 
> fine-tune a lot to see the error in this minimal test. Also it seems that 
> even the CPU may influence performance enough to make the error 
> disappear. Another weird thing is, that if we let the sleepproc sleep 
> 100ms rather than 500ms the error disappears.
> - In the test we can either work with individual mallocs for the needed 
> 3 string buffers or with one large malloc and specific "pool allocations" 
> from that large pool buffer. We can see the error only, if we use the 
> pool approach (see the two options in the code switchable by commenting/
> discommenting).
> - We tested 5 different copy methods: strcpy, memcpy, two types of while 
> loops, one for-loop. We can only see the error with strcpy, memcpy and 
> for-loop. (also here: see the options in the code). Maybe that depends on 
> timing, maybe it depends on the implementation ... we don't know.
> 
> CPUs we tested on (all with more or less the same kernel config): 
> - Intel(R) Core(TM) i5-8400H CPU @ 2.50GHz, 4 cores
> - Intel(R) Core(TM) i7-7820EQ CPU @ 3.00GHz, 4 cores
> - Intel(R) Core(TM) i7-4700EQ CPU @ 2.40GHz, 4 cores
> - Intel(R) Atom(TM) CPU D525 @ 1.80GHz, 2 cores ... here we couldn't tune 
>   it such that the error appears
> 
> So, thanks in advance and, btw, thanks a lot for your excellent work 
> during the last >15 years!
> 
> Best regards
> Stefan

Ok, confirmed under xenomai-images, qemu-amd64, 3.2-head, 5.4-head. But
it does not seem to trigger with 4.19-head (all the rest was the same).
So we may "only" have to look into what makes 5.4 special. Didn't debug
anything yet, though.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

