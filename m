Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4CE7E
	for <xenomai@lists.linux.dev>; Fri, 21 Oct 2022 16:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7+qpa/nZZ+E4GY7quwUm4xpUUqAcvs9DozJNJrJHYquZ/KIGHNVllnHtkitM3DgXriYYxF6CuSO+LmD1Poq9zdTRbrkc3teXWELWRUk7U+KynN9ONljMkQQeufLA7+25s5hEVeRPBaruhOzlR2BHRzInndMew/39S8g+ap5d7DHNZH02wZmV2pe/kgNGSDPPocBL4R/5W5/NiD0d2XnJO2i2ROn1x1WQy/M8CqKcw5Qmvu3GPDnukPRiiLcy7sj+v5wZE4LlJUfXQt68xJTldno+0L2sC6Je6zMa7CmrHLp4Q8nspC6SUcC6bo5vuGS172l640vk4kPjEuynmYXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTMjYXdBkJVSHSwVVO2wstZJ+HntX/OVPPg+ir9eSTU=;
 b=Hk/6Dx7jdTwJ5aB2qRYD1xVUbvFA2IZRyOCj/6jBbimBFFqFxy+6tIBKzJnvzZ2JdNZCU/gylA+45aRFvetXOI5qAJx7ZMfUS3Bj3V20JDDBMvj8+d/dQmWRq8qdfFAEI6uIoTcLOjlkjOV0czjffiaTsWqa8wx3QiIo70kRGCVQbsARBQrHttWhuLkgTr+8DyGXGM7v72bnCjYGmu/T1jPPqHxePgeXr1PUaqjbSJS3sug9WizbuyeOdGzAzdkjw6L9Fh5ibW8hUNlWUcG3Ef9hldyjMeLEJD0G5QZZ5z7LBQQJ9uGVegIoszVfkNF6O2mMweUN86dSq9GjCxuS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTMjYXdBkJVSHSwVVO2wstZJ+HntX/OVPPg+ir9eSTU=;
 b=QBUR5RF7cRl4n3LflYhOZAMq3WSm6I7nbhOaYsLh2ghycJny2Hhf8ZbjZANNpkWQwXD8RHa1y7fRJb9+VLkfwesvNhTp0cYZK+rcYLJcRtgQe33dTA9pTg4r96uXzazWvuriqDbXwCb1DWw8wUkWx2rGLA6R3VTWg+km0DjHnbVxhiEXTTjHhXm9MO+YAEuYWcemGMsY79gQEcRGltS/KI9j7fLHw+QQLIjFIgehUZr0VMIQJENAH2BYavuSk5Eobm+6BhxFvLjXmPZkBEieYwi6VCBES/wQnlofqe1SCM6czPd8yqmBg83CbC5T8fm5Ao+6SmNjwCuTc4Qh1x3OKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7326.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:616::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 16:43:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 16:43:32 +0000
Message-ID: <babd3769-0cb0-2c8a-8433-10c95ecfc15e@siemens.com>
Date: Fri, 21 Oct 2022 18:43:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: I need advice on thread scheduling policy.
Content-Language: en-US
To: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>, xenomai@lists.linux.dev
References: <CAH0t8y31sXMGTmmAvLc5Z=wRYNbZoNhiv-KCRj5b941QSJmt=A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAH0t8y31sXMGTmmAvLc5Z=wRYNbZoNhiv-KCRj5b941QSJmt=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8e6dac-e29d-46de-f1a8-08dab38363ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I5zRp7if7urstMzQWMhFAlhDA2GZ/tRLPBk0DmhVWgxjwDSfI5fHGdUtez/EHAikFVVVPsUOzttiqRakLvRNpXBRkeSaLtfwGMqtokhqk9CeG0Xdm5vbQS14hOWw6nyzlwNy1udIOCrzyQQf52dOijfWWvKiAnT3yhQWFhLLxuAZYBxJNijSlYkkAfPgtarStFbPDl16gLmGYZOUegqEZCOMhVue5n6hOdpqLJPuBgxuWeXaTKnf3zUS+Q0K8HOKFttFj/AfyL6qJYVfD7i+ZFfmFC1sH0tlzQtRiKwuT/K0OMvJwovL9H+0uMX4o4o+vUc6NXcthyvRVOfrfvwILfeLgKtCVcdXurBpRcCSe6WRyLlHeKkdQtN0QsBpmgNofRWLfUcNm37Do4U7Qcg/gomyJs9ta5ocwIB1eKrycFeIATrHAwZ+PiU3Yp0o710k8E/mQDZDlfn8tgk34tPwQ7T8rPY8y3VPzac9oty7iyky0zcCYvoVbKOUWzO6e2fAgMNIr690MR1Reu+JIDaB74yWCXjMwz167iJBLmYRzArQ0LtJ6FeW6HHcVI6I4HrlmTfyqF5JemD4UtBjPnETE1rWAVVmSYaegJ+pzQt4ScA6bFzBExOVXdGG73HFitm5D3dTVG/janloVtCwSh9mzqBRPFR20gARuDejk+1DEdBRKNVMr6VJ9Df5nR8R0LWkkLPqQXS682XjDYLY5U3BkA8Ef7bGvdeJEV1BKiPvdPl6teQGfMiDEdPBLGaHr08n4X1TkkxglUSda5DjgX8Y6ceC8m17LpAWioYE8b19Y5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199015)(316002)(31696002)(6512007)(26005)(86362001)(66476007)(66946007)(2616005)(8676002)(44832011)(53546011)(6506007)(186003)(66556008)(38100700002)(6486002)(5660300002)(83380400001)(36756003)(41300700001)(31686004)(82960400001)(8936002)(478600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2NxWjZNdFAyb3J2cWlINkZEakVBNGMxNDNUMnc5cFFCc2FHLzg0QUtZWDVH?=
 =?utf-8?B?enV1U2hONnRNZmpKaGJyWURPdG41Vkw4elh1QnpjS1VSZ1NKZm9hVnAwQUxv?=
 =?utf-8?B?RkZNbzN1KzRuQWV0RnF0TXpXdWpzZFc2a3RyOC8vWk5FSUJNM1QvcXkxd3Fr?=
 =?utf-8?B?Y0JsM0U4QVJvRk1jQ2JRUzQ5Z2dJenV1V1ZQMzArNnVrSnZJTDJqL1pHcjND?=
 =?utf-8?B?TTJzV0YrTVlIRHM4MzZJbWJGMnVCZHpXeUw4cnU0Q0VseG1iSzg1N2l4cGtz?=
 =?utf-8?B?amNqanlWb1BFYy9mYXlvdUREUW1rZlRGcnR0RTF1SzU4eksrVjVMdHJCLzN4?=
 =?utf-8?B?cXgyR1FuSmtXcGdLN0FrQzMvRWdGQVY3ZnpMWHBFa2k3NEs4UTUzQTFyRmRy?=
 =?utf-8?B?UGI0ZVp3NzYzR2IzU3F4VTk3YnpYdU8xQkdsWm9mUXd0dmJEL01jUUxSOWNN?=
 =?utf-8?B?OXdMRFZnaFpMTnRZTU91MUhQV29oTFpUSVFCb2ZhU09uaFFsSUJQdVZBcStV?=
 =?utf-8?B?VE5WSFFiL21zaGtrMWJqNnJHZzB4Unl1UG0vRWROV2xselBvWWNwVmR2eTFM?=
 =?utf-8?B?RVduUFBVRVJ6UEVzSDFoM3ZmRE92ak1FWEcyMG5WNm5nbXNjcWxWRktMQ21Y?=
 =?utf-8?B?RDh0K1h3NHBtc3hMb1lOLzlWWW16cFJJcFFFdGNPQytOQXR0bGFidnZtc3Ew?=
 =?utf-8?B?Qkd6UFcwV2xQa0dPZlZuby9rUjVjdUEzN2FFdHlDWmExNlJjd25vODYxejU0?=
 =?utf-8?B?clRLR3A2RlNldlJhTkJrTTMxQWJFcG41UXBPTjJxYTB1enRtbXVic3lxMi9y?=
 =?utf-8?B?QU9sN1lLTlFaZFhreVRIcVR0WHVRRzZnejRnSmZHbXZiK1VaaHh5K0JyQk1C?=
 =?utf-8?B?OTF0ZzhrSFR1UnRNQUJ5K245ak1jYkV6aXJaRzJMSk1LenpIaEJXSDNvSzZ4?=
 =?utf-8?B?VzlNVG92Mit4TmhUZ3doTmlWWkpFRGwvcC9GNndNb1RHNSsrN1Zqb0RoOGJi?=
 =?utf-8?B?Qlk5VkVYQnVmejlvNktreUhCaStPRnNyeGgvb0ViNTVpU1BTayttU0I5TCsw?=
 =?utf-8?B?NmVhVDNjdWczKzRMN3Buc1paMzlUUVJ4VU1zM0d3VHB2N3VKdTFLanlUcDlL?=
 =?utf-8?B?NEZ2UHZTMExiakdqeERiYmxIUHdrMFY3TVEvcXZjL051WTRnQlZBZS9wUnBX?=
 =?utf-8?B?WHNRMFdiNEplbXpiZU1IZkoyS0FId3JZTHpkRWxJSEUwTFNDMHJGcExZM3Rx?=
 =?utf-8?B?cXp4L3dKUVp4TVUwTjNmZXg3K09yWTJtdlVpMUtXUmZnZUFqdVovQ1M2azRK?=
 =?utf-8?B?RzZMejhONER5dURLK1Y5aWl1TVhvQURRY0Q1a004RTRITEl4UU1LeDNPYStv?=
 =?utf-8?B?ekt3UWxxSWJ6TzArb05OeGEzYnJybnNGVGR0WWRHdDFwK0RxNEt6bkI4TEZt?=
 =?utf-8?B?SEF3WjIyamtzM3RzTWE1cG9sTzZ4RUhSQmtSMUVBUjdjUHpwaGVrQXo3NllE?=
 =?utf-8?B?Y1ExbXZUdC82ZXB0T3BMalhNeCtSVzkzVFl4cUNtVXB0OHo1YW5iV1cxWWk5?=
 =?utf-8?B?b0JhTll3czV6amVmUVAxU2tadm1oaVBNbFlDNndXaVAyd0JPZDVNek5ieGhS?=
 =?utf-8?B?Vk01bmljVklYcFdGYVF5Zm52N3hKMVRJVU1zQXNGUHNJWDY5N29lUHMvM0xp?=
 =?utf-8?B?ZXhNVDMwK2ZkSGJCU2tnOGV4bG1pUzdiek9iNHUyYmZJaXNOWmdkaWVaOVcw?=
 =?utf-8?B?YnNVd1FrMFhETGswN2xaM0svOEMxWnpnc09XOEQzV2tLSS9ZeE4zVmtzYm5a?=
 =?utf-8?B?WmYzZjBOVUtldnEyUXNGcTZ6Y1p6QUNVckVudWR6d05YV0k5SFVaejkxMHN4?=
 =?utf-8?B?L3YwM1JKQmJEbTk2UEo2cnJLUjBub0c0VHVJY3NKTmIzZ1R4OG9Hb2x4cHBP?=
 =?utf-8?B?SS9KSk95cUlOMW1RNE9mdUtNOVU5MnV1dnQzSlJQdDZmdjg4Um9rZ1d6bjFu?=
 =?utf-8?B?a2lFbU5sME1hM0MrTmRXM1JzclhrYnNGN3Z1SnZCekNoREJlTVVCckVTVEli?=
 =?utf-8?B?cnVjQnVKMG1wcGVGRFhYV1BOd0hBM2NxZ3M2bC9JZS9BdGo0dExMQUZJSVM4?=
 =?utf-8?B?aVgyTDlKK2hKeWFMWGpFY29jbkRBajlyVE5Cek5yckw5RExEMjRJVmd1am16?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8e6dac-e29d-46de-f1a8-08dab38363ce
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 16:43:32.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWEknaf94hblYaz7j3QOjp888S9cwC5+GOEF+ocIdPOvqVIO5y8klYN6E8xi+QI9zhxLb8UToulaqYK/s7sa2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7326

On 21.10.22 14:21, Tamás Paál wrote:
> Dear All,
> 
> I am using Xenomai 3.2.1 and a Dovetail patched kernel on an x86 PC.
> 
> My application has about 30 threads. 3 of them are time critical. The
> low priority threads are interact with the time critical ones, using
> semaphores for data synchronization. The scheduling policy of these
> time critical threads are SCHED_RR to be Xenomai threads. The others
> are SCHED_OTHER so (in my understanding) handled by the Linux
> scheduler.
> 
> Is this the right solution, or should I make all threads to be Xenomai threads?
> 
> What is the best practice to get the lowest latency for the time
> critical threads? To get some load off of the Xenomai scheduler (by
> removing the not time critical threads to Linux scheduler) or keep all
> threads as Xenomai threads?

The best latency you generally get via
 - having RT threads on isolated cores, doing as little other stuff
   as possible there
 - using wait-free algorithms for the RT side to exchange data with the
   non-RT side

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

