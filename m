Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923D58F59
	for <xenomai@lists.linux.dev>; Mon,  8 Jan 2024 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="H9wypZKt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlixf1M8d83Y3Ww5G9nzBFV5kvgSy63T8Mmis9vnVEZ7HZmSfOxsFZduC218jJxEWXQiHDbHl0E9jDpRgqPhDdeQ+ycDCRPTUVdwfE/08e5ONvbTdpdsUiaiKzctohYHC4tb6sF2hKa6veoul2h0rrURKE4+Yll3FoFx5+x76cTt1NWUv6G9JwXSrAn9cHxUaHXTtswdWAuL1Hk4BbFXhK1lxd0Dhk7FiHkGAxUyuUrMqH8Ph8jDloAAHf3UvGvnibM3W4QmAUdXsh9+1kwM8+0LgXIUUmnGVIXhqkRdhmRu2I72nqNLYRUNPV/1iggxnN66asviYqXDf2tcdsVCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxp48/wyO8LixSeLtILA7PcxVjgZe8yX6gAroAFjnYc=;
 b=ZCenoHJZhp3jpHg1sjQjVfTNftceL6n9jaShTqiHE/vft70ugZb0wpn0iZrFqErMIlzxFKOTYYVKp/CSFkJyUCkRkC+XUeH2T299F4usddkRvGyNacdamOG7c9RTK4NG087DCIWWk0U7l7yasqpLjqXmMGi4DgZhLNOdRMDoMFVJXQYVSAQHsox2EFKvca7C0ls8KjYcAvZmNBZ/Mhn+YGov5R/346VzA+mzNHuxyOmXdZ6lCmO9YS5HQXDua3JxnAl2eUcaAFcFkQHoqFI1Sqo1QPbMkkk7/KdnmnH0Vehco6IzWwmi0WkpxSYO0n/F8Qcx2vV4xr2JMMeNAS4rtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxp48/wyO8LixSeLtILA7PcxVjgZe8yX6gAroAFjnYc=;
 b=H9wypZKtpsUL9O08optis5AnKAN6BAvxKP81woElGQG85O89nmX8OpZn8cMrGLWP4p+SFn5EX1rkG32WwMH8rRUMoAqwn5bLgkqDQd86PuuEOLranOgiWgRbhSaIsMDfkhKyjREeuyGuV5FJI8Vmm+rgxf7u5nyOIyrAXEFFDVfZZt4FQA1wH88JW+AfGbhHVYLLORXDJO+tWI9CJUxDMSyTydQTtyMHuhonbMF0NfyjdpVKpKncuqMnUcI4NmOl4907K43SAv3ijA4Kv1PxEESq9hrxDlOcuWpQZTFm5zfWyi4M52vh45Ns7QamgcEnR0uu+hMH+ASbyPMkkgBD+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 05:45:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 05:45:07 +0000
Message-ID: <7d54cdc0-c6e2-49f3-920b-2ef1ad87e404@siemens.com>
Date: Mon, 8 Jan 2024 06:45:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: The linux-evl and libevl stable version
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Yao Yongxian <yxianyao@126.com>
Cc: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>
References: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
 <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
 <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
 <5def1e14-e11f-4966-9f26-18ce62378592@siemens.com>
In-Reply-To: <5def1e14-e11f-4966-9f26-18ce62378592@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0310.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4003:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee053ef-8a22-4a2f-4c80-08dc100cf871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JKfuxfsLk3INaUuOD8OHw7vZR4gEbNqSn9TUyota7AfxvljeR4WW44ZftAEKbLhw5pQeGJT4yfGsI7j/5EDiMcYrw92Q6KxaUqOQYcfLwse5LdAcb0RgV3gKLkMscgrbr+V2pvRtvjZniZHj1Smp203ksakIhV3i1zGErSaAmw7GjL5FYqnC+7ETWnz8bgbf31hYNIBL+MM/Ua4+W5m61vaVSzqAq5ot1lRbMoXFq7aEu1pOYmDGO/tI6pF5Dud8LyNkGyPkqLdW5G8bsV92naRsKHsq3w0HKqvDAA/Bt3tLtZAHxP315Pva/7OsQz83YSdEQv8UgHaI/CfEk9IAQYEpu/0u9dRQl2aloGUDU+nd66IJHHKciiaK0hN5+xziGKFQnfFIJnPLPSqTzmjew/0BReA5ynMcYHL16iO6eXqEE4YzJaSodFYmhYBxFPJtcroYvFrhzWv0bLM8ayKI+PNpnsCOcs/sj9fgUCjxPJMAFOMEpnp0oyPNXCriNK+OCLaZEiS1o8SE3te0OMBdDFJLS99Hl4p40EiSLvY+x+pPtR8SGlNKnbcprzRLLIbkB04YmZqL2zilBcd7Nglc92EQNuCInd0K27vyrc+WePkVon9p/8WKJXb0EBpDYJNtk6uzrR6Y2/LY9dtbQDP/kA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31696002)(38100700002)(44832011)(4326008)(4744005)(5660300002)(2906002)(6512007)(478600001)(6666004)(6506007)(53546011)(26005)(2616005)(316002)(66946007)(66476007)(6916009)(36756003)(66556008)(8936002)(8676002)(6486002)(86362001)(41300700001)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDdUVmI1K0RSWXp5bmhvcUdmM2dDU0ljSndMek5iai9VYi9hNFJwQmtLb0Np?=
 =?utf-8?B?akRkS2szQzhQdFdtR3dmZkNSMU9xWXM1dU9VaDN0ejNKNnFMSEJQYUcxOFA4?=
 =?utf-8?B?V3BpdTRlMnFoV2FhYjVWeWdNNklTYkpjU3JuaGttRVBOcytpakw1SGhnTlFM?=
 =?utf-8?B?REdMLy9JT3ZUcDhVWDNZTVJaYWNzS3Zwa3grUkRkRmlqeGFTNnJwbldvaXBV?=
 =?utf-8?B?azhDZWtVZWl0VVYyOG1peWlOWVJEMmVsL0o5WHk3cU81d1VDZE5sVE1YK21a?=
 =?utf-8?B?SWNyMlVXUzlkTklFalVhMXlyWXV2TzUzLzBvQVpQZHJNem1yeUpBOWZmODlQ?=
 =?utf-8?B?L0p4WTFIKzRXUW1xNGlwL3VUUGdqNmtFNDlTTElNQThmeitGVjhWblFqQmh1?=
 =?utf-8?B?eVY1dlJlMFBTRjB1WkQvRzVEUWxXbEhuNTlKZi9yQWlEdHZrSDhUdDJuRlRk?=
 =?utf-8?B?YVBPY1g0NWpqY1paTldNRnVmZGRYS0dOb2VjeE1Ob1dvd1N4Z0hyY09BcWgy?=
 =?utf-8?B?WTdBMHpvUVBKeVFwR3NtOW8zb1dRZDhoMkRzams4SytGK0ZKdFpEZExtZHl4?=
 =?utf-8?B?ZCtFZHVVTFJ6RlRTOE9MNEVablpoYWJIOU9VUmM4b0p4VHl4bzdrV1lSOUdM?=
 =?utf-8?B?YjhWcytpdmo4TVYwUlZudE9Hd0luUkRRaVg4SGxiYlo4TlNBWk5mR1hzRDdK?=
 =?utf-8?B?akovRXdlRGRCNUZPMmk3S3k1SXlzVWo5c1FBWUE5TkQwZnZ3bnV3OXdHVXRX?=
 =?utf-8?B?MUVKajU1ZnM3azA2RkQ3TEN4K01qb2YrOGwvZmFvOTlvV0NvaHVPcUhrWDlB?=
 =?utf-8?B?ZzRhbGVDZ0NRb2FiaHhRUHZ2Sm1FTVF2WXFaVnRtMU1KTmV5TGhNL0E1ZVhR?=
 =?utf-8?B?ODlFRVF6c1JCT0VwZXBiTUhkRE9WMW1RWmFZeXIxU1FRUUdUTzVXb0lDMG8w?=
 =?utf-8?B?dEUxaUQxemM5RkhHU3ZiSFdOOG9vbGpRallnOHNqY3Y4YnNIQXhxOFZqSXY2?=
 =?utf-8?B?eFdIcCttbThQNjVMTkJ4OHJTblpiVGI5RklvcGVHS1VhNktJYm5QcVQreW9K?=
 =?utf-8?B?UTB1ajJnM3hiTlA1WjI5aG8wTzM3ejA5bWhHQkhDU3VBM051cjJRdEhDMFhu?=
 =?utf-8?B?eVV0Rmxjb3NLR2dkdDlWM1FVWGtBek5pWUpkUzN2bmdheExNd1BYcUNFdk1x?=
 =?utf-8?B?aFVFaGZOMUsza3ByUjdhZlZ5WFJpa2ZmS2picW50aHZ6YW11bDVkZEpKYTJz?=
 =?utf-8?B?VElKQ2sxNWgxVVRYQURZTzJLUVhNTm1jUWZRVlh4Q3ROeHNickpoVVErd2ZQ?=
 =?utf-8?B?OWlBVGFuMlhDbEp2blRIYW5uS3grTlFubFNpWWlqUXo0Q0hlR2pKRUUyU2Iw?=
 =?utf-8?B?b3FVTXNRclNtNVNjbitGTy9oMjlubnBjTTQvZ0lqQzg0bUZiTm5jcDFIQjc0?=
 =?utf-8?B?OW5ReUlQTmQ0U2JtYmVVR0VhZWxHTUdUOWhjWmhXbnZpbDlBaWZSbDhkRHY0?=
 =?utf-8?B?SzFtb0U4bDJERkp4NUZtZStnZlhuNGE3UGFsMWx3NHRjdWhZMzhueE1iTUhR?=
 =?utf-8?B?aXk0OHpST3I4L3NUbHpSTHNlSXRMYSs5N3M4VmZEMCtMSHpMWVh5OWpYeEZj?=
 =?utf-8?B?OVk2OHdzemM2RURudnZ6azJSRDY3aDkyNnBLMUlVQjZTbXhTWndXc0ZpY3U3?=
 =?utf-8?B?a3pNR0xCSVBFazZ6U3laL1QxMEdoOEdTRU1NUk1zazJRNHVjVWIwUzNVRFpS?=
 =?utf-8?B?L0RhS2ZkL3ZJaktwTmYxTHlpcElpV202L3Q5ck9XcDNiRzhrZEFYczFsNW8z?=
 =?utf-8?B?WHkxK095ZXdFRVNlVzh3TGF5MlNIVEp1TERmZ3lKVFJiT2c3OXBLQjRzSVdV?=
 =?utf-8?B?YzdUNjlmTUdZZHJEKzdmREh6NTYzSzU4Z3pSZFJHVG50VlZ1YVo4QWNNaFNw?=
 =?utf-8?B?U1owV2hXd1F4NTFXVlRndERaNmtZYUpwaCtOdE01bU9WQ0dxdW93MXdVRjJZ?=
 =?utf-8?B?YW9sVU5mSDBoSFZZYWJESkFGUWxheVZvWW4vNVN6dTliQ0g3bnhOQ3BsRTRp?=
 =?utf-8?B?MjlweWxQdXhraGdPQys3NlNNakVONERkdXRzRXBWUm0vUzV0YW1tWUVhRU1I?=
 =?utf-8?B?akFHYW5RYjFTak51QThxUUtGanZsei9VUlZXS2cxTHZiMWIzSDNseUhPVm5V?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee053ef-8a22-4a2f-4c80-08dc100cf871
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 05:45:07.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmC0iAuhDDiZRvjOtX6m5i+/3jCnv5GbLaOA6+XepHyD2w/tVhAIuSbWGEIIlxi0punDxkTP72d6A25raAH/3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4003

On 08.01.24 06:41, Jan Kiszka wrote:
> On 08.01.24 06:30, Yao Yongxian wrote:
>>
>> Hi Jan,
>>
>>
>> Thank you for your reply.
>>
>> We plan to use Debian11.x(the Debian kernel is based linux-5.10.x LTS) on our product.
>>
>> Is there compatibility issues between debian11's glibc library and linux-evl-6.6. x LTS?
>>
> 
> I don't expect any, just we won't test on that anymore.
> > Why are you starting a new development with a 3-years-old baseline?
> 

And v5.10.y-evl-rebase is end-of life!

Jan

-- 
Siemens AG, Technology
Linux Expert Center

