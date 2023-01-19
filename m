Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2053.outbound.protection.outlook.com [40.107.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4436FC2
	for <xenomai@lists.linux.dev>; Thu, 19 Jan 2023 12:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKn6H4i03/GC9HKf+A+jGWUknDqI7LF4g1SAyou/ZqlxwHPIjYSY8DZ4GtOGTrWAIBJbwVkoqZ/2t2/co4eSclg+Vrg4iWwAShXL8YjQ46wda04ZWWhT4fDA7nM3tTCCeUcCPbZWhwWZd4vUobz2bkBylHurXUsqv53ltjSUeDzvcPdaOs8I9qGmDzZbT1HjeLzj2n5o2UfO1dqnvqSb/wS2r095WvqQXpQ7l6afdV+rriCSVzrmxcyr9ZGERpz3jcKmIsq1CGqMWHZR3k8rgDSj1Q+dWXGgalKyAb0t2hZFMiae3AgxLl9hX0DzygS9OTPNniJXpJnSUMHubFSqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tZcrDboNzvE8vVO9wx9qd0fd0fr+ZDp+0BqbT07CEM=;
 b=g4E7tJTYrcnXyrppx0GtiKCIdYStOqPFV/73oR8tVWwz/qFm/zZsUWZiIRcPxCi/azn8UiV9eZ1YA7l/Ah/xsD78PO4SNHzps+4oa6H7vsBN0sgw5FrkwZ0uBh5Ybqn5gyi+Tx/85Vf2SbFHuJU3xv5+mGleAnODw9YETppf23Sf2D31l19LHJ1Kn7l7Jf5q/Tx75Us6t0/CoD1/Nsw6M84q0pI3VI1TH7tAF4res64JCmceHg1aY5c1nyc25g64P/27fHDk/sXoy8BAvVghUUcG5AqBmbQguaAnGgnHca8Q/DH/P8eDXi7a/URY2eOhZ8O2gZqwpOwGMw6RwgYuEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tZcrDboNzvE8vVO9wx9qd0fd0fr+ZDp+0BqbT07CEM=;
 b=uEt8dByJGGjK9bCRpMprvC23OxgJoqIl3PrSzQgEZApbH5DqGcW9A8uRjoWP7st6BHXxVxO794GcX3eDl1biDkrx0iWRA9hUfnUyKvvR60G93PA8+7tZLuVOocsikFycrnsLcx7vIKOL6jamHV1j02MNOJoi03a5ANLT7lQeLUyc+An4FvUnS/EBRHwwhDaaYNd6m5h/p4j6txJ05gWmcGkXyfh1zZN+sSe46PBvXQsDg3azQtZkVXM1TcFO9tXqINk60pQMnAeNLpZtgJL9iz9zUYy0IN0Uy5gph2wcBNPD4DBADGChlSAa1VFxuKSSeQLEqHBeMwzPReS4QX4Zig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7219.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:461::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 12:12:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Thu, 19 Jan 2023
 12:12:49 +0000
Message-ID: <35c4d16c-9793-4662-df3d-2d58affd3be2@siemens.com>
Date: Thu, 19 Jan 2023 13:12:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: thread cleanup troubles
Content-Language: en-US
To: Johann Obermayr <johann.obermayr@sigmatek.at>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <DU2PR08MB735839A582125026237762FCF5C49@DU2PR08MB7358.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DU2PR08MB735839A582125026237762FCF5C49@DU2PR08MB7358.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: ebddf425-4cc5-4b0b-e63a-08dafa167b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/iGZab9gq8JSbFtBUdYhvaWtm8pROAsozVL4KqmOkM8PQEid6TFa+F8yHkZNPXdNPccu8rIM+AnK2PxlrvkD58iR8cAG+gdctG3fnLeYV9jdP/aCVHzahKuodPSVwP4lqYUX6uEJIOPMbl5lj4nB68UB7u/5SCx9qCFjHpMKYhSrlRD6wqoe2oci6xzXNeLGbLxEr/Cp+TzShCeqLs1Dd+RKKvUxeETM7BGkyqEkyxcMWNfY6hPTbi184sSXV3vm/iKScaywAhLNwPxzbRfWw0kDnfDeC3nPkVL3KVBEKCp3tcvR0ANQPcI2JegbKmZSthyG6ty0+pTyGdwv+60wV2SVBh45Q2HDb7GVSOTgzZC09nOp1G0msAd2PW3vvB/ahFL8Mx0yeK5BjRlldLCPRqOqIHLkDkmI3h2eXCUi8Fzs2qDvxNI8J8EP9Gfr+MhB8xDZOBHZDRTDeihiTIYYW8jovgXjYWmd44eLHypdxPF/JT0HkctpCDtERzHn2uog/Cagn8h79cStToGM0hgGL9K0pqLZYcfDaO0f9Iu+Bho/JfazTnuyvhDvcQMI5f9XtOd/ydxrpmiar/VqXhhRasS1IOheaH/MdPYw69DyKfaVmVErypQ5zMajU60GEDl4KrPbqW2ADjmfWfsLEaf+g3ir6xoLFB7UiA7RWkoHDDL4t25DxHDuTraBO8j78f7THQBhFJdbdAYJrGrIFzzKFM2jsckZhvNIkzGkDl6p4Ug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(66899015)(41300700001)(31686004)(6666004)(53546011)(8676002)(7116003)(66476007)(66556008)(66946007)(8936002)(2906002)(36756003)(44832011)(5660300002)(316002)(110136005)(2616005)(86362001)(6486002)(31696002)(186003)(478600001)(6512007)(82960400001)(6506007)(26005)(83380400001)(3480700007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW1ZMUlzdXpqcGRYcnI4OUdiNVVaV2dUMmFwek44TXVWUGU4b2s2dmxJby9P?=
 =?utf-8?B?b1d2cDA0YUdxK1lGQy9mR0NldXRFOVZVN3hRQnhRRlc5b2t3ZGRYa0VjTXF3?=
 =?utf-8?B?UGk0RTBmT2p2YndDUER2QWlKL3hldkhBeXd4L09zSk43clNha0phOVB2ZzZE?=
 =?utf-8?B?aWM4eXp2a2pEZE5HWHdBTUJ6a2twOHZJOFhRdjUweG5qNVdWZHVVM2g5N2RD?=
 =?utf-8?B?Wlptclp1L2tjY1MvUWJ4RTBPaHg1TGw3KzhqQWFHUmRqTXNNUmxBK3hHNXpz?=
 =?utf-8?B?Q2Z6dGZPRmh2TVVRamV0VTE2OWZwL1F6STlETHRKZGRXQnJ1YmozNG9DYmhh?=
 =?utf-8?B?a2NuOWxLNkcyTTBucUtiS1c5R2pyL0E3enUyMk9FNE5mbnIvSEdaa1h6V1lV?=
 =?utf-8?B?RDE3RGFNTGZYYndERDlHTzcxVGhpL0JueE1uaklGRXpUTGlONVY1cWl6S3VG?=
 =?utf-8?B?cXZVWWtKSkhXYWdDS1dPeVNneWhtYXFuN3R1TEcrSWZyVDRmV0E2UmZ5RUMx?=
 =?utf-8?B?aFNOSENiRnREV1ppWWYvMFNhSzlMUzZBU1I5NVNuU21ObTNCTjdLYWRIaURp?=
 =?utf-8?B?dk1qQkRkczRTbWx1dWVXQlpqUjNpVjFNenJiVmUwMzZnTFV2NHAxSUdmTVRJ?=
 =?utf-8?B?RzdkYzFqUWgyaEJ5UmM3UHFkQmJKcnBadkxIbTNaSE8rdXgxM053NGpzQzVn?=
 =?utf-8?B?dVpqTnZwenFzUzNDNUFxTUVPak9JUWxha0NxeDI0amdGTFRXMHhRT2lhRENS?=
 =?utf-8?B?S2ErYVBXNDZYTThoSlVCbHlaYllsRzByWHJoa3dHQWdCVDFUQ2locURsKzFh?=
 =?utf-8?B?RC9jTmZpNmdmYXZUUEhoR0phYkVDZDhON1R0YlRScG1lZXl0NVVzYklTUndh?=
 =?utf-8?B?Qm5FaXNlay9qK0ZsQ2pVWkp1cE5qU05RRndCRTNUZmllZFpHQ2xITDhVNTMv?=
 =?utf-8?B?WjgrSDdaL1dkSW9mZHNzMlBaRnE2MTYrbDh1Ri9jNlBobTJmWHhtL3VmakNH?=
 =?utf-8?B?LzNYbW0rOEZ0MmFPd0F0Um9lUVZFR21qUEtYQkhHWjZNQ1hiVml2Sng5Y2VI?=
 =?utf-8?B?UFgwM05uSlc0WGU1S0FWVWc5TlNNUUxHV2x6dHB5VFBwTTFVQk84dEV5T2NJ?=
 =?utf-8?B?TG9LWTRRdlJ6US9VT0l6NzNPT0xEM3J6bHg5eDR2U0NiM2x3dkZBQVpRYXgw?=
 =?utf-8?B?dzNPUUxkSzRHOXB6cGNQbHQ3ekZDV1lPUGpBVXlpWXZaZTBIa0lIZDJOOW0x?=
 =?utf-8?B?LzR5R2dVM0pTVytmMHlMbzR5eXhiZk43K21ULzdReDUzTE9VbzRBUjlzeHJZ?=
 =?utf-8?B?KytWWjNaSDlzYUErZnhSNGpoc1dYY1ZTbHNOWUhyZHo4ZEUxSmpwODgvY0c0?=
 =?utf-8?B?MHBoNkVNQVZUa0JqbkkwOENNS092WTdtb1ZEZmpwNjNWa0lreXM0SXpqRjhN?=
 =?utf-8?B?KzdFOHRYNlRTSFNjVTlBSzBaWkVrZEE5UHpaSWFZNWlwYUlvMEhUSHlDamJZ?=
 =?utf-8?B?Rjl4MER4Q0xWZHNuU0JPVXpkdnVBaWg1Zk9BUWZZYklhL0pJc3Z4VFNiV2ZQ?=
 =?utf-8?B?elk4M0d1S2RZaUxud2c5OE1ZYW1JYkd2VGY3aVFXN3lwaHdrYVRPVmpUVHo0?=
 =?utf-8?B?RDBGRnpNZU92NFNjSVR2TWlhTEszdVhyRmFvTjE0U3hiNUcrVUFHZzNqTzFj?=
 =?utf-8?B?OXZHWlZ3OEdNSk9jeWlENGx5ckxSRDBBV2F0RkNWdDRyUU1uaDc5Nkg4bENV?=
 =?utf-8?B?ZEdqNzF4dm9OblJjVWgvVUp2cVRZZXVNbkViQ3l3eGdZcEJLTUJOWVJPZDRw?=
 =?utf-8?B?OEMxK1ZVT0JXK1djWXk2NjZ1clIyZXRNeFRjek11SVROUmRNQ01UcnkwNUkw?=
 =?utf-8?B?RzZHR3Vhc2RJQ1UzckNYWlljMGEyaXo1RlRtd3ZweHZFM0F0b2Y1ajlBOHMz?=
 =?utf-8?B?NkNRRlRUNEZnekxKd0JJbWtvbGFsVVloa0JqZ2tLNStyazFPbjVWdERFSno3?=
 =?utf-8?B?SDFWL2dNdjlkdFBlRzBxNTBoYzUzZWFILzh4K21TdmFQWE9LNUtUN3NRRXE1?=
 =?utf-8?B?VUFEWm5kQjNxcHRsejBSbGVzU0JjUTJIYzZZbDVVYVh3S3NxSVBoNG1EekhR?=
 =?utf-8?B?c2VhUUJJa3BUS0FmY3AwUjdDbzVOc3hlWDdYajZRUjlZeTA2V2JTWURCaTR5?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebddf425-4cc5-4b0b-e63a-08dafa167b27
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 12:12:49.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzD6rgOzJeutGzpqPu5HrNnmOERS4OANqcB3yHOlwbREPvKPtND2zhdwpoC5hOxtQux6OPmmbI6qnDLspf+oWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7219

On 19.01.23 11:41, Johann Obermayr wrote:
> Hello,
> 
> Like Xenomai, we use pthread_key_create to clean up our threads at the end of their execution. In the cleanup function we also need a mutex to unsubscribe from a thread list, we maintain for certain threads. Xenomai calls finalize_thread on the pthread_key_create callback and finalize_thread deletes the task on the Xenomai side. Because our cleanup function runs after finalize_thread the rt_mutex_lock call fails with EPERM.

"The order of destructor calls is unspecified if more than one
destructor exists for a thread when it exits."
(pthread_key_create(3p))

> What is the best way to solve a problem like this?
> An idea would be to add a new function "rt_thread_register_cleanup_handler(....)" that registers a callback which can be used for user specific thread cleanup.

Without extending the interface, you could create a worker thread that
processes a cleanup queue on behalf of the terminating thread.

If we wanted to go for extending, this would have to happen per skin.
Cobalt itself is not affected, only copperplate-using skins.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

