Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF0154B4
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 11:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKygIrWSbpGwkBxb+78o4rY6/1UFkUeSQuJHDJDHIsdvas6EalVyufMfphm+G6goVfU1JNATq6wCQFbtdmWMWLRRUoo5W6vMqPBSdaYBbyEpAr28lwvmrXFWPipSGteFv350EDsm0AB8R7qQ8PXhXtCudueON8kwZ9nyZpJRmXmDI0vne4+DRd9I1w7pElBBEvwzQd0vM7LCPAKVBzmq6DbRq2TSBa0RalDJ+1jE3vuGvAhYa7Djyr7kMmeyvTJHDfkNIiwJr85crM/bhkuRLVdZthXcEGqAn9GNNuS8ieqpVBfHywrfq3cWm15o90p6GdWVDRtX+0Zzz0e6KSBxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEBYKvO6PPIu3FSHUNPK9sNPGpIxlnyrqHd4BX97wXg=;
 b=epKxec2TFrbSBBM/7FcrqhfF9aKhIbPyCsKeFjJthHw7y5YLEo9zraOxZONLRK7hZfoMZgKPW47sx5Y1psTvZ2S2Hmo107foErv3nnA7GIK28m4bXk8Q6LADwluGo4C+zZVU0SHv9zbFDnP+1VC0Wrn2B1YHjDRy8rSnOvXv7f2Tnpv2DI7cHcEypMIh6nxyPCDRALB4Y8biidMODUr6fZs7Cl5DBIvcG0JUZ2ewOuNmHdlmyYpjMQ2oCxW9XpVqYjxCNJnVFRRs0hP36t7qpi9U84xqRbH/UskrjFluvWpXWqL/E4tmSjDzkrLxUWG+v7iJ/THfVL+n+9w23Bh7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEBYKvO6PPIu3FSHUNPK9sNPGpIxlnyrqHd4BX97wXg=;
 b=xOBt2M8pWXth3PnP/Lf+pMsFYY5B01r4OCced83x0UGmkoVvyLtVMx+aAad/FoG67EnmN8cYVLBFEvOvPc6PNjcCuafj0uq6SzMDZ4V5Ak40oeC8webHMoqH6ascBwMbOd0AfaeY7pqH9UmDQ9Mio9zE9AAMqRxFXad7gPNEEa51wYGu0WRVPZPAM04sWJeAzoqXhfR21ChUL3QlIh4+dF7KJDmkjMa4jMRXkIrnLZR5jBKmqYPC2qJD8MKoJioKdOWavM9EogEkiduO9h2PlAN59lp+/Pepyc7uHqOaB3nfXwGZrnqNFqhiQAo48E/viX3/O9ldHpB972j+zoEg2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 11:44:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 11:44:54 +0000
Message-ID: <a1d3d859-5230-4b13-b54f-93e41a1a3476@siemens.com>
Date: Wed, 9 Aug 2023 13:44:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: v6.1.y-dovetail-rebase
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <a022bab1-7fbb-3b71-3eb3-e16791f3c2be@siemens.com>
 <87edlkeu1b.fsf@xenomai.org>
 <a35a96771c0f059370357b9a37c9ab1871e621b0.camel@siemens.com>
 <beff2aa61a6b00af08baa7374feff1a0ddf6dd93.camel@siemens.com>
 <87tttiswuf.fsf@xenomai.org>
 <163ed99e-bb3f-afe0-27d6-eda78c65e6c5@siemens.com>
In-Reply-To: <163ed99e-bb3f-afe0-27d6-eda78c65e6c5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3931:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e67146a-516f-4906-2ef3-08db98ce0c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+DNPGum6sO0ho0Qxs3QULNE8sl5orcyV0yTw0NHUBR+cK4zDYy9NXLLu11cNo+kPm9vW3Tut+4NHLL5lBc4kZKgtSVdU3+mvcNtb1A5O3ZcDqj+rr1wa1NiouFjuZCo3mSrdvZOpp/NIFVvdyNhEsonvMIUxxfhmvxzd8geNIpi7Xq5JehgiUCSkBWbmMaiocYqaTmjv6jdK+/9LueptG8rnqnELPw/2sWkX4dT0vlcJYPwBcBbbd6pkfZI5vRI2mD0YC1E8qALl6/DOLAgR1ofAdSaaqpchPUfWxfiQQ3I+lvdzJIk/NCh5JfL2md+oJOR3mg8xF+eQZLV9c9K4YuSNpi9Zro+cqdJXEHeqWMjNTKWdW2yxuf9Wnb/FT2mVcISdTUlDHIoMX9eEAUTpqpuwg+GvYMUPQMQTafwrBHlK4eQEi5E02esskcFC6V0kMId6j+uPXQ2qNdrZ5fgodREi8Gx/iR19j4K3t4zRVH/obg0k1k9LcCyngo+7u2Qd2Keh9xGe8rMigKGQMAlwM5Dh2ARYFmRPxvCpbVk6gDYHI+icPkfCR40u51IMg6KtQ6Jxz7dNGVXM/WhuxbpW3shM/SZQORBTRJjg9891QyC2fpPiBSenBfhujneZucUINanewXqn4s9j3HA/MuYOcg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(1800799006)(186006)(31686004)(38100700002)(82960400001)(86362001)(31696002)(36756003)(6636002)(66946007)(66556008)(66476007)(4326008)(2616005)(83380400001)(26005)(53546011)(6506007)(6512007)(41300700001)(966005)(6486002)(110136005)(478600001)(316002)(8676002)(44832011)(5660300002)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME9wc2x1UUcrUndqc1QzODhKOW43T0hDUHlkMWRGNkIxdjF5dWl4eWY3QmQy?=
 =?utf-8?B?Sk0zbHBDTlo1QkRBVWR4WDVhUmVhUVlGMTlrRm9NbWlUQnRCQW5xMnFOQkpJ?=
 =?utf-8?B?MVBLbVUzNzFRNWJvc3JhUDVRVHNKQ3hJRUFSczZvdzk2dzZFc2p5M0hoUUVR?=
 =?utf-8?B?WGRSLytFQ1FLS2lid1hjNXJNN1pwdkpYSzhRMUJDcitUcDdZQXBOVnorQ3Ax?=
 =?utf-8?B?QWMvUjYwNk5TOGdjcnlXcU4waXJOTG1HejFrbWdDckZUNnJYc0ExbHNOeEdR?=
 =?utf-8?B?ZEtlM3RnWGthRFdmczBMMWxPUDZudWs1MitST1lpVEM1N1ZqYUNZdjlnZ1lH?=
 =?utf-8?B?MUV1blV6UndES1BXYmp0NVE2aWdiRjQwNUthMUlmM0RBeko5WFBTZ2piUmtI?=
 =?utf-8?B?YVlTWncxOGdBNnpncFZKUjU4ckRUR3Fka0dMa2czRzlzQWhrcXhVMDd4bUFW?=
 =?utf-8?B?OUhXaG5VNGdSVTZLZ3F1QWc0Uy9QMUFqMjB6a0lCb2R2VjdJL0FaeVFEcnNM?=
 =?utf-8?B?MjR6dDg1Tk1zYm5XaXpyZnp6aXAvejB3L3NyeXVjMFRBZk0wUXFueXZvQ3BV?=
 =?utf-8?B?N0ZUcDVhZFozVUxaczB2cTJZL0hCbEdiU1RVZGtYNE1uWVg5VEJSN0F6ZmUz?=
 =?utf-8?B?NEhXc1hrdE9ucTBzanRRRUJPbjUzeHJJQVdmVTgwMUZTd1pxWFBOTzMwZ2lS?=
 =?utf-8?B?KzlISHRzcTFIUXZkM2NHcEQ1OFFDTXRHdGlOY2dpamNVcDArOGNPbG11ZjJm?=
 =?utf-8?B?MlBOb2VPaFhERmlLdXExcjY2ZmJ2MlpOblFpQXRpYmVrKys5dGhLcnZMdnBR?=
 =?utf-8?B?L0dQMHQzaTUzNkUybFVncnVYUFB1ajhmWTJDWitCUFdMc20vRVVzNHFvR1Bo?=
 =?utf-8?B?U1BKelE3eW5NdVcyeEV1SGNCcklJV1JjL1JMdGYxYlpPeTJLVS9tUFl2ZjZn?=
 =?utf-8?B?V3o2SjJXeXowNjVXb3V5dnNVcUVZTkhvVVRlRUd2QUZWTXlva3FpR0dUZ3VQ?=
 =?utf-8?B?c0NpVTg2VVBtRFNXbEZCRlpDSHJUY1VvWjVtWEFyMm55VXNlZkp6UUhVcGtJ?=
 =?utf-8?B?QjU1emJrUWdCM2hEL2VXaDkrbEV0M1JwYkdkcEZUWTRBY0E0MGp3THpwaFhl?=
 =?utf-8?B?TENwa3JtNktzeit0TjZXRTBjaGZsNlRGSGZ1NnljSzFrTys3YXVZT2ZEYjhC?=
 =?utf-8?B?ZGxYODg0S1FFZ0cxY0tNMEJ4YjRjNlgyd2NFcWRQRXNnK1J2R2YwVHd5UUVU?=
 =?utf-8?B?dkg5UEVVNWF2cFc3blF3RURPbUNwODl1UCs2SWFvc1pZU3U0blpWYXBSV0xK?=
 =?utf-8?B?SmFBQ0pOS3ZBYm5iUjFVZEVrSnVmWkUzdHo2ckhISE5TTDJydW15aWtOTEJC?=
 =?utf-8?B?OGxoMitOYm9oSlM4dm1pT3lvc2VYbkR4YmtsOFVnMjUwSi9aUHlRMUVPRHZI?=
 =?utf-8?B?d2srcjV3SG56ZmxIazN1dHFJV0dtYWs1N05tS0V3ZUtZaFdWM280ODNnRG9h?=
 =?utf-8?B?RUp2L0VMOVJzS1lKQXVvR1k4ZDN0TDN1MFJtZ1Z0citOSFhlL2lDdk11RUo3?=
 =?utf-8?B?WHlEc0ZQb1VlSWZKams1bVdiT05vbEhISTMrSW9YMmpVL1k0U2F6OUxUajBX?=
 =?utf-8?B?MXUrYUhWWFN5Vmdpd2ZGT1NGRDlEMThITXFxMDJJdFN4TFVxVVpUTWY0RUo5?=
 =?utf-8?B?Rm83R3lLb0ExZ0c0d2JzS1V5SXJ3NkVoVmlOWUZMRmdEVzQ3QjRFRGJlOTlp?=
 =?utf-8?B?a2ZOby9iUjFseHVPU0NXeDlXMkNNN3Nxa1gxWWttdU54WStvWHIwekI0bDBR?=
 =?utf-8?B?VHNYU0xLZXhOQVR0S3RJWFNJRlJyR0VCNldtT1VpaStsWlRaUGU0c2tReWQ1?=
 =?utf-8?B?WENHZ2lmL0E3TlI5YXQvNVVjQURtSFRETFVBQTIzQXNuYjZUTjlSTzNUU0Zi?=
 =?utf-8?B?bCtpc2pKOERBcVRGYU1qTkhGQldFWFJDWEpBNTBlYUxYSEl6VHlqMzBNNTFC?=
 =?utf-8?B?MVBnWkY5b3dVU0FZSWRNdGk0bWY1cmFydGJPalBqay81VmdIOG9zY1NnMVds?=
 =?utf-8?B?cndMK2VQWHBUZE5kUjNiZ1VPWGpudzFhb2Yrc212U1B5bkRFWU56dVBod1M4?=
 =?utf-8?B?Snl5UVo1MTRjRElEMVdNVVl1QmVrZHFrK2lPR0JLOER3Q2poMEJtSk5mRk5v?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e67146a-516f-4906-2ef3-08db98ce0c5b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 11:44:54.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vk+NaCN++8PGD8B0bsU9KYO0w/9Du5OOByy6RcOkHCHWyiWS1gAczYDofvT2cEoOxz4tdz/K4i4qSD4XAwmBcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3931

On 09.08.23 07:52, Jan Kiszka wrote:
> On 01.08.23 15:26, Philippe Gerum wrote:
>>
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>
>>> On Mon, 2023-07-10 at 08:59 +0200, Florian Bezdeka wrote:
>>>> On Thu, 2023-07-06 at 21:00 +0200, Philippe Gerum wrote:
>>>>> Hi,
>>>>>
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> Hi Philippe,
>>>>>>
>>>>>> quick feedback on latest rebasing:
>>>>>>
>>>>>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/8f155631c8b51731dfc2ae5145d4dcc68f2ed7ed
>>>>>>
>>>>>> This was likely accidentally folded, right?
>>>>>>
>>>>>
>>>>> It looks so. This conditional statement appeared upstream during the
>>>>> v6.0 cycle it seems, and was unfortunately left unfixed in the dovetail
>>>>> patch for this entire series.
>>>>>
>>>>>> Furthermore, I will factor this change out into a separate commit in 
>>>>>> merging v6.1.y-dovetail, for better traceability:
>>>>>>
>>>>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>>>>> index ce8bdd804bc7..c843bf352999 100644
>>>>>> --- a/arch/x86/mm/fault.c
>>>>>> +++ b/arch/x86/mm/fault.c
>>>>>> @@ -1466,7 +1466,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>>>>  
>>>>>>  	/* The fault is fully completed (including releasing mmap lock) */
>>>>>>  	if (fault & VM_FAULT_COMPLETED)
>>>>>> -		return;
>>>>>> +		goto out;
>>>>>>  
>>>>>>  	/*
>>>>>>  	 * If we need to retry the mmap_lock has already been released,
>>>>>>
>>>>>> To my understanding, this was a dovetail fix that applied to previous 
>>>>>> versions as well.
>>>>>
>>>>> Only to v6.0, however this series is not maintained dovetail-wise
>>>>> anymore, so this stayed under the radar.
>>>>
>>>> FYI: This change fixes a real issue here. The 6.1-rebase branch made it
>>>> through a 24h stress test while the "merge" branch failed. Happily
>>>> waiting for the next release...
>>>
>>> Do we have a idea / plan when the next 6.1 dovetail release will
>>> happen? My internal customer is waiting for that and I want to avoid
>>> backporting to 6.1.34.
>>>
>>
>> There is a brewing rebase to v6.1.42 pending tests here, no challenging
>> source conflict. I pushed the tree untagged to the v6.1.y-rebase branch
>> if you want to give it a try before Jan updates the stable branch.
>>
> 
> We are testing against -rebase anyway (but that needs a trigger which I
> just provided). The merging branch is only updated once there is a
> release tagged.
> 

Passed with the Xenomai 3 tests:

https://source.denx.de/Xenomai/xenomai-images/-/pipelines/17252

But can we update to 6.1.44 directly? Florian mentioned that there are
Downfall-related fixes in that release.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

