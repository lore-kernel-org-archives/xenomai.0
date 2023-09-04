Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE67E
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 08:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDxJE9mcRM9k/qSDsGD4Duj8Ao2ah9vA35uKaHWZWp169liZyHV48sdfLmC7rPY3sciL52EQ1HCs3oJkKmBgPgDI4ZaNGcmnl/jNw7E+uvR001KZDSpIjYHCXPZwZ+Q6eAke2nASpfu2mg9RhaXlE4NhzeE1d1H7hFM9Spe/RX9PLzB7Cs7g3Z35MHrINCOEz+2mSHQ4MiPCKNlU9o4A0u7TrB2eoJZzUs2vgh+ukqN7Lhu1F4d58QG+uZrBmC99mm6xbe6t/tZ9G4SWE0xpTToitoc6QfOL/RT0OLJ7VMaHk1b0vOOA6mE03KON4Uv6Hbz4SdTmglBTwcsAl9DU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khYTWWW/6+PgKnwQuNgFupeB9w9KpZlBra9Yv5lGicY=;
 b=kidUUVzFjGO683RZozh6FPHLKW+UbDnzBbD/fxV3ljzR/oHPPpJNBdbJeOplHunB75/sfkpIrsQM/3BWMdxlHw34BUHocLXqyty5Z/Az9JEz4IwpTVHQLV+noUvV7nP54a6t4U/gaQzSaNIEudRiFEHxaIIEcI25uIuQMLZmnor/dciRfxTZd4PsJlcl18AQG3KUoPM4kI3Ij24AvvKJ+txKIG1EDT22UZ6HvKBO3+G5MA2HI+EyqylHuCXTRYR1PT1JG+eEEGey6x7Xajv+KJUv6ACAv7Ur/KxR+zzsLYmhJjY7EHo6v60UjL048CUn4jHFrkUPcq9xByNfHTu/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khYTWWW/6+PgKnwQuNgFupeB9w9KpZlBra9Yv5lGicY=;
 b=KwelDQuKygZVovx/XbtA8/g4hIKnSdH95vbfL9/EaTioZe0nccQ9pg10xViOaIhGD7Tb09Rf/uf+WTulsHP5KtORIupBqzW5y8TxmjeSyJ897wZ+g2RDjkLo8jyVpCrCWxtUuac5aQUbpsA/XslOjxm47k9gn39DLqBK1MKFFd8S3tTo7lA5cMvSM09fV09Ep1AqrvwHHbLJxrhwywJrjE+nuQkhmlqlRlxveFm48iljQGcP/C0B7EytiRHCNWi90GE7QHSMksy5zMIW3y9+r1/tMafQWDtP7Llrr7SQabyoiuWVJaDkKYk073FMA4FQHG5Imfsr7+KXSOReHREvFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6567.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Mon, 4 Sep
 2023 08:56:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 08:56:49 +0000
Message-ID: <46263735-3b88-4426-a378-57eb9bccd1b1@siemens.com>
Date: Mon, 4 Sep 2023 10:56:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <d5505413fbbf778aacaeb40effe8cb0ea61107b9.camel@siemens.com>
 <MN2PR11MB4285D68E3408171C181D9C20F2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <463948a9bd09ddf6062f879fa9746b0c70e6a9ab.camel@siemens.com>
 <MN2PR11MB428547B97385F160CD2E4394F2E5A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <42d72c52569d30b9ecaf8fd30dd777abd422adf1.camel@siemens.com>
 <MN2PR11MB4285133F95080135AD983AC4F2E5A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <874jkffxe0.fsf@xenomai.org>
 <MN2PR11MB42858E54D7324967AE6D1FC2F2E5A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <87zg27egin.fsf@xenomai.org>
 <MN2PR11MB4285669E0D22FE1D5B103E2FF2E4A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <874jkewdwi.fsf@xenomai.org>
 <BY5PR11MB42769E5D589385FDF64A7C7EF2E9A@BY5PR11MB4276.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <BY5PR11MB42769E5D589385FDF64A7C7EF2E9A@BY5PR11MB4276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ae99ee-60b9-46a5-643d-08dbad24e010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lCSU2IPdOzbEKw90j2oHSAlLKmju0uGHRuig4l4LiHDyHr92mB5ERkZeWn0ypLTyTJG6o5IWaYIlGv3FBdJPX2KRHlP8brQewr/mFNf9NhW+CT55ard+ZF0fXxMvNYYoT97GBB4zEc94R3pCckh9HiWY4BAULkNglfaekLQIJJeTSWCOomwHYniFoEAl0djmXDD9tLo3zSARU00FOVyYYykoPQ53lniv5B+OnpgtGCfFE/ZSP/CO6zpJlJHKOEX3+cwyKh9dvayurzmSliFVj7tXGNL1NwNb7qz9HDwR8lqZ8YtJ6PQQBLw8elKNFtnmgw/1KeDSJat0YoZK8Wf6Frez1UY0cVs9VnxcS7X1uk+bR0HvswrDYug37NctYJTeSwk5sGPEroyj/4BcnFiGdsZZrHGqAeSTfZu06t5OKdzsKVeOZF+zWVq/9XmaTD070ZADI6fiL/Sg+zlhvhsj/bFSGaidWhiFiGYqJq4xpX5hmXouimQPasCItZTj9W1tsB495kDjWehEqC6aDbnOD3/uR/Bfd1cZXL3gzG3N2vlNXlFx8Bu6y9jlihEFR3Vjo99rbqaBmovbxmqeoDF45eTdBOvckezlxr6NNVkW3/iFoaj9/2C8DSH03k7oISyF7Zxpaa7xzaF6IFMx8mqfWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(186009)(1800799009)(451199024)(6506007)(6486002)(6512007)(53546011)(83380400001)(26005)(2616005)(478600001)(2906002)(44832011)(41300700001)(66476007)(66556008)(316002)(54906003)(4326008)(5660300002)(110136005)(30864003)(66946007)(8936002)(8676002)(86362001)(36756003)(38100700002)(31696002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWpBWDZsL252RHAxcWFwL3Q0R0krUkNwSTRQZlVkVkRQUnlsTEtidW9TbVdp?=
 =?utf-8?B?MGR4TStGV0tKMjJnNXNBVDlpcXVsNngxZEpHQWxOZ2pEQmt6ZWxvZnkrUGxH?=
 =?utf-8?B?V0RCaHRpTHVrcFVTd3Z3WUJ5eTZLT2kzS0VvVCsvQUZYZFhVOWt0Y0p0c1F4?=
 =?utf-8?B?aEdpYTBxYXduTEVlM3VGYUk1S3VNMVBUanA3R2VNTms0eEZSNnREUXN6L2dl?=
 =?utf-8?B?NTFsSHJKSHRPcGd1Wk5sN2o4L3E0TkVoOVpWMGFEOExZV0hRU2d0bG9aNmtY?=
 =?utf-8?B?ZXJHVit4aWlsck1ZQnMydnhvai9OVFZ1Sjd5ZG85Qzd4SkNVbXltMlRxbDZQ?=
 =?utf-8?B?SFNzYThYSTJETXNKbTNRbTcyaHRuR2h6YjdIeU5hQlBsWDEvWFo0TndmbUlh?=
 =?utf-8?B?UCtIdUxOazVxcmtCQkZQb3JDUUtTWFJhU1hRbEFJSEZjOEY2TTZVNUEvd3c0?=
 =?utf-8?B?ckpwaGt1VU9UTkc2OFdHOFZudGNEWkdDZHo5WmZBWnY3N0hicCtVSStCV0Js?=
 =?utf-8?B?cU50RXh2ODNhMDROeTNVeHlNU1ZTL29mUnB3TEZad041MVA3eU9GU2pHa1NT?=
 =?utf-8?B?YWZVTHMwZ2psN0c3Y0s3cXNnNVllNW1VVk4rQlMyc0dlVXBmQ0NvcWZLc1N5?=
 =?utf-8?B?aXJxclJVTmtNVElKeXg4dDhYczV2Vm9JS3lMdlZUWkNyWUdXak84aWUyK3hC?=
 =?utf-8?B?OVh2QXBlOTA3OTdIWk5OTFFQRytCbnIwOEhnT0JVM2ozU0lldzhFeS9FeGd3?=
 =?utf-8?B?NDJCTGcrOEgrY0hBTVRNMHFaRllPckdMTFRUeUlYRk0xSThRN0QvdGVOKzR2?=
 =?utf-8?B?eUlTMVYrQUZ4NUlLK0U3SXZaMUU2MExaQWM0OUY4WDYwaHYvamZ0elBzU1Vl?=
 =?utf-8?B?aXc4QWc2SlB1WjJVczVaYVZWcUJCMVd5bENIMmF6TFZKOU9ZN1ZUUFQ4Wkp6?=
 =?utf-8?B?eHRhS3lGckh3dm8yMDd6aW4rVnZ1MG1KSHltSGJTaTB6d3BHbU5TdGpNa0c3?=
 =?utf-8?B?cTVGaXVSU0hjUTNSY2FYeko5VGVSVFNGUVMyZzhCd0Y1enBsWGRNZ0hrUU5K?=
 =?utf-8?B?QkIvR2RLWFFYN0kvT0FGa2d3ZlJDZkNNQUFwb0g0dkV5Y0pyWjltZ0FQNlFQ?=
 =?utf-8?B?L05DNXZZZ20ra1cvZ1JnRjJ0eUlZUi91TVJBWUc4eURPeUtGUFYzdUg4RHJN?=
 =?utf-8?B?dGV5TENYSEppbUprTS96dCtQeXhaVzhVcHpVM3lETzByK1Y0VnVkMjl5UjNB?=
 =?utf-8?B?T0F5VFpYdEpIbVJkYVhnQnhTM1NBdTloSW1EdTZvUXBZMGgwUm9XU2dXOEw4?=
 =?utf-8?B?UGo0b1JNZG8zQXhDSWpGb3VQUWpLTnpGYVpML2JRWVEwREJ6TmRxbDhoNWRh?=
 =?utf-8?B?KzF6cUZ6ZkprcElpUlB0cnpIakl1bGVZR0FzbW5lWGc1bUUxNC9udTdjR1c5?=
 =?utf-8?B?YlpSQ1BtbTBCQithK0FnNGJ5VzBLcWZvdkJKYlc1WExyQjdnc3N1bmJUZ0Ey?=
 =?utf-8?B?REdxRUd6WTFKY1FrQ3c1YkFCNzY5eHMxK2ZOVFBXVzJqdGEvU2VOTkdIZFMy?=
 =?utf-8?B?TmMzSkZuWUR2VXprNTRIaXpEMTV5OGhsNWRJNXVpRFgrVkgwc0hianN4NjlZ?=
 =?utf-8?B?ekFjRnpSWko1N3puOWhIdThjNlBWRUxNN0h3bVlFUU1hSFVJWW1qbmxST2JJ?=
 =?utf-8?B?bHJLaWRuczdnUVE0dnlFYkxURTk4aXluRzhmRVFWaE96dE9wOEpzbSsvVnlE?=
 =?utf-8?B?cm4xazc0VUpaeGVYZ2pzalZ0M3RJclJhcFUxdE4raGpSL2t4Q0NiSmFFSkNr?=
 =?utf-8?B?bzZNUVhiSXBvSnVFY1VUT2l4cU1zY2Q2UUFVRWxJajFudEJQSUEzTEF0bWdJ?=
 =?utf-8?B?cFBKRFNtU1FtajlPSVhTM3ZWSGFXN0g1ZzVLeHJKS1VMeTgrdkZMSGdXMnBF?=
 =?utf-8?B?Wi9TQzdFd1d5R0xqS2xlQ0Ftdk9reTFtMFFra0lmdUgyMnhvRmNYdDFDcVJV?=
 =?utf-8?B?aXBKLzQrbksyd2NBaERkN3ZyN2tqbUVrYmhGNDNwVjVjNE1WMGN6eHdkWkJa?=
 =?utf-8?B?Ymc0aUlkS3lROUc1aHF0T0pJT1NaekVWR0x3Q1FYYlNYaDRGWVRpQm9yUVRz?=
 =?utf-8?B?a0NFMDY3SnVjZTFSbS9FaCtEZWlYTkxvWWxSSVQ1aEpURXgyL3Y1UmFtZzJF?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ae99ee-60b9-46a5-643d-08dbad24e010
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 08:56:49.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSFxpwrRnjXFO2yN9HX3rM3E7UvAbojFk3Cc66pFxX8ZvqMtMZZLM+GFuMadVNq1H7ssbVcLolffIWpxlttgkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6567

On 04.09.23 10:20, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Philippe Gerum <rpm@xenomai.org>
>> Sent: Friday, September 1, 2023 2:35 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
>> Cc: Bezdeka, Florian <florian.bezdeka@siemens.com>; Kiszka, Jan
>> <jan.kiszka@siemens.com>; xenomai@lists.linux.dev
>> Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
>> pinctrl device
>>
>>
>> "Chen, Hongzhan" <hongzhan.chen@intel.com> writes:
>>
>>>> -----Original Message-----
>>>> From: Philippe Gerum <rpm@xenomai.org>
>>>> Sent: Thursday, August 31, 2023 4:57 PM
>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>> Cc: Bezdeka, Florian <florian.bezdeka@siemens.com>; Kiszka, Jan
>>>> <jan.kiszka@siemens.com>; xenomai@lists.linux.dev
>>>> Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
>>>> pinctrl device
>>>>
>>>>
>>>> "Chen, Hongzhan" <hongzhan.chen@intel.com> writes:
>>>>
>>>>>> -----Original Message-----
>>>>>> From: Philippe Gerum <rpm@xenomai.org>
>>>>>> Sent: Thursday, August 31, 2023 4:06 PM
>>>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>> Cc: Bezdeka, Florian <florian.bezdeka@siemens.com>; Kiszka, Jan
>>>>>> <jan.kiszka@siemens.com>; xenomai@lists.linux.dev
>>>>>> Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
>>>>>> pinctrl device
>>>>>>
>>>>>>
>>>>>> "Chen, Hongzhan" <hongzhan.chen@intel.com> writes:
>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>>> Sent: Thursday, August 31, 2023 3:10 PM
>>>>>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>>> Cc: Kiszka, Jan <jan.kiszka@siemens.com>; xenomai@lists.linux.dev;
>>>>>> Philippe
>>>>>>>> Gerum <rpm@xenomai.org>
>>>>>>>> Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced
>> from
>>>>>>>> pinctrl device
>>>>>>>>
>>>>>>>> On Thu, 2023-08-31 at 00:45 +0000, Chen, Hongzhan wrote:
>>>>>>>>>
>>>>>>>>>> -----Original Message-----
>>>>>>>>>> From: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>>>>> Sent: Wednesday, August 30, 2023 9:23 PM
>>>>>>>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>>>>> Cc: Kiszka, Jan <jan.kiszka@siemens.com>; xenomai@lists.linux.dev;
>>>>>>>> Philippe
>>>>>>>>>> Gerum <rpm@xenomai.org>
>>>>>>>>>> Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced
>>>>>> from
>>>>>>>>>> pinctrl device
>>>>>>>>>>
>>>>>>>>>> On Wed, 2023-08-30 at 07:54 +0000, Chen, Hongzhan wrote:
>>>>>>>>>>>
>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>> From: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>>>>>>> Sent: Wednesday, August 30, 2023 3:20 PM
>>>>>>>>>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>;
>>>>>>>>>> xenomai@lists.linux.dev
>>>>>>>>>>>> Subject: Re: irq storm on sd/mmc card detect gpio interrupt
>>>> alloced
>>>>>>>> from
>>>>>>>>>>>> pinctrl device
>>>>>>>>>>>>
>>>>>>>>>>>> On Wed, 2023-08-30 at 03:05 +0000, Chen, Hongzhan wrote:
>>>>>>>>>>>>> Hi Philippe/Jan
>>>>>>>>>>>>>
>>>>>>>>>>>>> We found there is irq storm issue like [1] on sd/mmc card
>> detect
>>>>>>>>>> interrupt
>>>>>>>>>>>> alloced from
>>>>>>>>>>>>> pinctrl device with Xenomai 3.2 Dovetail 5.10.*
>>>>>>>>>>>>> According to our test,  the patch [2] works for such issue in
>> our
>>>>>> case.
>>>>>>>> It
>>>>>>>>>>>> seems that handle_edge_irq
>>>>>>>>>>>>> never ack the irq to clear the interrupt status for the Linux
>> gpio
>>>>>>>> interrupt.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I am wondering if there is any side-effect for this patch, Please
>>>>>>>> suggest.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Regards
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hongzhan Chen
>>>>>>>>>>>>>
>>>>>>>>>>>>> [1]:
>>>>>>>>>>>>> cat /proc/interrupts
>>>>>>>>>>>>>   14:    2440190          0          0          0  IR-IO-APIC   14    -fasteoi
>>>>>>>>>> INTC1020:00,
>>>>>>>>>>>> INTC1020:01, INTC1020:03, INTC1020:04, INTC1020:05
>>>>>>>>>>>>> 128:    2440190          0          0          0  INTC1020:01  112
>>>>>> 0000:00:1a.1
>>>>>>>> cd
>>>>>>>>>>>>>
>>>>>>>>>>>>> [2]:
>>>>>>>>>>>>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>>>>>>>>>>>>> index 6aca6c036ada..4d08eaf076e9 100644
>>>>>>>>>>>>> --- a/kernel/irq/chip.c
>>>>>>>>>>>>> +++ b/kernel/irq/chip.c
>>>>>>>>>>>>> @@ -869,7 +869,6 @@ void handle_edge_irq(struct irq_desc
>>>>>> *desc)
>>>>>>>>>>>>>         kstat_incr_irqs_this_cpu(desc);
>>>>>>>>>>>>>
>>>>>>>>>>>>>         /* Start handling the irq */
>>>>>>>>>>>>> -       if (!irqs_pipelined())
>>>>>>>>>>>>>                 chip->irq_ack(&desc->irq_data);
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> That doesn't make much sense. A IRQ storm means that we
>>>>>> unmasked
>>>>>>>> the
>>>>>>>>>>>> IRQ to early or forgot to mask it.
>>>>>>>>>>>>
>>>>>>>>>>>> A forgotten ACK would mean the IRQ stalls, so it would never be
>>>>>> fired
>>>>>>>>>>>> again. No?
>>>>>>>>>>>
>>>>>>>>>>> According to the test, it seems forgotten ACK will keep firing
>>>> interrupt
>>>>>>>> here
>>>>>>>>>> like
>>>>>>>>>>> following comparing:
>>>>>>>>>>
>>>>>>>>>> This doesn't make sense (IMHO).
>>>>>>>>>> Can you provide a callstack from handle_edge_irq() in case
>>>>>>>>>> on_pipeline_entry() returns false?
>>>>>>>>>>
>>>>>>>>>> The IRQ should be ACKed on pipeline entry already, even if
>>>>>>>>>> handle_edge_irq() is called again (from Linux/Inband context) the
>> IRQ
>>>>>>>>>> should already be ACKed.
>>>>>>>>>
>>>>>>>>> Following stack is dumped after patching my patch. Without patching
>>>>>> there
>>>>>>>> is no intel_gpio_irq_ack. It is called in handle_irq_pipelined_finish from
>>>>>> which
>>>>>>>> it already called irq_exit_pipeline before sync_current_irq_stage. That
>> is
>>>>>> why
>>>>>>>> on_pipeline_entry returned false in handle_edge_irq
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> [  291.009330] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U
>>>>>>>> 5.10.179-intel-ese-standard-lts-dovetail+ #1
>>>>>>>>> [  291.009331] Hardware name: Intel Corporation Elkhart Lake
>>>> Embedded
>>>>>>>> Platform/ElkhartLake LPDDR4x T3 CRB, BIOS
>>>>>>>> EHLSFWI1.R00.5204.A01.2305180757 05/18/2023
>>>>>>>>> [  291.009332] IRQ stage: Linux
>>>>>>>>> [  291.009332] Call Trace:
>>>>>>>>> [  291.009332]  <IRQ>
>>>>>>>>> [  291.009333]  dump_stack+0x7b/0x93
>>>>>>>>> [  291.009333]  intel_gpio_irq_ack.cold+0x22/0x27
>>>>>>>>> [  291.009334]  handle_edge_irq+0xe4/0x310
>>>>>>>>> [  291.009334]  generic_handle_irq+0x4b/0x60
>>>>>>>>> [  291.009335]  intel_gpio_irq+0x11f/0x1c0
>>>>>>>>> [  291.009335]  __handle_irq_event_percpu+0x77/0x190
>>>>>>>>> [  291.009336]  ? handle_level_irq+0x200/0x200
>>>>>>>>> [  291.009336]  handle_irq_event+0x6c/0x100
>>>>>>>>> [  291.009337]  handle_fasteoi_irq+0xd8/0x250
>>>>>>>>> [  291.009337]  asm_call_irq_on_stack+0xf/0x20
>>>>>>>>> [  291.009338]  </IRQ>
>>>>>>>>> [  291.009338]  arch_do_IRQ_pipelined+0x11d/0x230
>>>>>>>>> [  291.009339]  sync_current_irq_stage+0x157/0x1f0
>>>>>>>>                   ^^
>>>>>>>> My understanding is that you are not handling an HW IRQ, you are in
>> the
>>>>>>>> stage where the inband IRQ log is being processed. HW IRQs are
>> already
>>>>>>>> ACKed at that stage.
>>>>>>>>
>>>>>>>> Maybe we have to understand your IRQ chip routing. Is there an IO
>> APIC
>>>>>>>> involved? handle_fasteoi_irq() would be the first level IRQ entry point
>>>>>>>> which takes care of masking + ack.
>>>>>>>
>>>>>>> Yes. IOAPIC is the first level for external devices. handle_fasteoi_irq() is
>>>>>> registered in io_apic driver. There is second level pinctrl device acting as
>>>>>> gpiochip which has irq domains where sd/mmc cd interrupt alloced from ,
>>>>>> which need to be acked in handle_edge_irq.
>>>>>>>
>>>>>>> Regards
>>>>>>>
>>>>>>> Hongzhan Chen
>>>>>>>>
>>>>>>>>> [  291.009339]  handle_irq_pipelined_finish+0xa2/0x1a0
>>>>>>>>> [  291.009340]  arch_pipeline_entry+0xdb/0x120
>>>>>>>>> [  291.009340]  asm_common_interrupt+0x1e/0x40
>>>>>>>>> [  291.009341] RIP: 0010:cpu_idle_poll.isra.0+0x3a/0x110
>>>>>>>>> [  291.009342] Code: 00 85 d2 0f 8f 9c 00 00 00 e8 72 33 28 ff 65 48 8b
>> 1c
>>>>>> 25
>>>>>>>> 00 ad 01 00 e8 a4 29 27 ff 48 8b 03 a8 08 74 0b eb 1c f3 90 48 8b 03 <a8>
>>>> 08
>>>>>> 75
>>>>>>>> 13 8b 05 cc 6b 01 01 85 c0 75 ed e8 f3 22 2a ff 85 c0 75
>>>>>>>>> [  291.009342] RSP: 0018:ffffffffa1803ec0 EFLAGS: 00000202
>>>>>>>>>
>>>>>>>>> Regards
>>>>>>>>>
>>>>>>>>> Hongzhan Chen
>>>>>>>>>>
>>>>>>>>>> But: If we use the dovetail sources to build a kernel with pipelining
>>>>>>>>>> disabled we have to ACK the IRQ. I assume pipelining is active on
>> your
>>>>>>>>>> end.
>>>>>>>>>>
>>>>>>>>>> As Jan said, I'm searching for a similar problem for some time now
>>>> that
>>>>>>>>>> I can only reproduce on VirtualBox VMM. In my case I'm seeing a
>> stall,
>>>>>>>>>> not a storm. I will give it a try, let's see.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> After patching:
>>>>>>>>>>> 128:          2          0          0          0  INTC1020:01  112      0000:00:1a.1
>>>> cd
>>>>>>>>>>>
>>>>>>>>>>> Before patching:
>>>>>>>>>>> 128:    2440190          0          0          0  INTC1020:01  112
>>>> 0000:00:1a.1
>>>>>> cd
>>>>>>>>>>>
>>>>>>>>>>> Regards
>>>>>>>>>>>
>>>>>>>>>>> Hongzhan Chen
>>>>>>>>>>>>
>>>>>>>>>>>> Could you please check if we call unmask_irq() with HW IRQs
>>>>>> enabled?
>>>>>>>> If
>>>>>>>>>>>> so, I have an idea what is going on...
>>>>>>>>>>>>
>>>>>>>>>>>> Florian
>>>>>>>>>>>
>>>>>>>>>
>>>>>>
>>>>>> To start with, prior to any further analysis:
>>>>>>
>>>>>> diff --git a/drivers/pinctrl/intel/pinctrl-intel.h
>> b/drivers/pinctrl/intel/pinctrl-
>>>>>> intel.h
>>>>>> index 65628423bf639..b7afa763ee079 100644
>>>>>> --- a/drivers/pinctrl/intel/pinctrl-intel.h
>>>>>> +++ b/drivers/pinctrl/intel/pinctrl-intel.h
>>>>>> @@ -222,7 +222,7 @@ struct intel_pinctrl_context {
>>>>>>  */
>>>>>> struct intel_pinctrl {
>>>>>> 	struct device *dev;
>>>>>> -	raw_spinlock_t lock;
>>>>>> +	hard_spinlock_t lock;
>>>>>
>>>>> I already modified it at first when we found the issue.  But it does not
>> work
>>>> with it.
>>>>>
>>>>> After patching my patch[2] I mentioned, the issue disappear finally.
>>>>>
>>>>
>>>> Ok, but the patch is papering over the real issue I believe.
>>>
>>> What kind of real issue it would be? What checkpoint I need to check to find
>> the real issue out? Please suggest.
>>> Continuous fired irq is obviously caused by forgotten ack behavior for the
>> issue. The ack is supposed to happen elsewhere？
>>>
>>
>> Edge ack is supposed to happen in handle_edge_irq() when a pipeline
>> entry is detected a few lines earlier, your patch would cause a double
> 
> Following patch is OK for you? It should avoid double ACK.  Because on_pipeline_entry after  ack
> it set IRQS_EDGE. so we can ack here when find that  IRQS_EDGE is not set to avoid double ack.
> 
> index 6aca6c036ada..d06cf4a79f2a 10064
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -868,8 +868,10 @@ void handle_edge_irq(struct irq_desc *desc)
>         if (on_pipeline_entry()) {
>                 chip->irq_ack(&desc->irq_data);
>                 desc->istate |= IRQS_EDGE;
>                 handle_oob_irq(desc);
>                 goto out_unlock;
>         }
> 
>         kstat_incr_irqs_this_cpu(desc);
> 
> -       /* Start handling the irq */
> -       if (!irqs_pipelined())
> +       /* Start handling the irq
> +        * Avoid duplicating ack when IRQS_EDGE set
> +        */
> +       if (!(desc->istate & IRQS_EDGE))
>                 chip->irq_ack(&desc->irq_data);
> 

Doesn't answer why we get here without an ack while the pipeline is
enabled, does it?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

