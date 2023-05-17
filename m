Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8EB1FDF
	for <xenomai@lists.linux.dev>; Wed, 17 May 2023 07:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4JV06HQ4xCPDACyXEXfBQ1V3XgnxMwT8nBdU5LrXiKDH8XdVV3epuoyoc1r7bhqGTGBa+AF5T5i1zEvS4VOx6xF+2xWfVAAgQNEKud05VrX/JfNWOSWCMN8Xsv9SgPNljhjSbnBdMZvRwvo+iIaYx8OJb3fibOIL2AJ+ATp0zknoYPUkd7YBgo+w5WLhJNpvP556VM1GL4PQNp45D1Xs27mKK+xYin7QbV8PXIXTNOBN8bGp6OS8fzwWiBpZ0Uc6uC/nVr5TqzcrOZJc2Egd8g9+9RwLqxPAOS8g7cLRp8Ni02SR9ivd6zT5zuvrD5VzjDYeS9CbCzv6APWU/zd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFMbpUqr7ub3UByntJ18gzALp/t1sJHsZ+RcPItBQK8=;
 b=HnvcqSWydpGxF4ps90v2RnNJWSByWC1Ec9Y1Hqx5sPHtEZJZChb6APteiY1ds4b1n9DCrsJ6SgUWo7MOsUDsWWRg6IO9nhQhzsN0a8aSFSClG7O1fNMNoED3NNwlC39c5es5N1FNZqXh00BNTut0MjtBDAilVk24DMvD0SW2p7H/onR45NxiZMynzaisV9fudgfg8gAfhHUdJAxUlfAiAy8Tz37JiFe+J/DNfK7maDoe/LJpTTclsAXXix4RIRtEM+Wqo4yMswNnSDR4zkm/A1YxP284WOuam708334h9MXFrQlhMLuRR/HVhF86RTdZ2ZLTKEtcXtLTJv90Hy3Oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFMbpUqr7ub3UByntJ18gzALp/t1sJHsZ+RcPItBQK8=;
 b=gGsREiQVYhYWLyZy9F5Y4ExkGM4deFzWss/sxJwRHPjvmxY67oGRvPCgRcKEFMRhY/DmJXPgfmAZbPK+5l2pZRhVSHiGNmBP5T3o4KX0YA36GONfr4p3ok2sBsQ2hmLRjfyDj+NuFukKKrwVyWML1mDGWTjGN2lYWkddibhZc/nu4iHGqthPpundEP7vzmHhXKUr123pKP0f8vcbnV4rRyu7I0c0q5vIGTHV/TRDREvkx1A8/IHg6+iEnt87/TXLXlIkA2BqtKslcJPs6xyEEgEG1vNcIfGM0tp2sOFTvugXzUdJjHsVSgmU1Ga8DrqBB+rY/YFNYRTMlh45J7oubQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6119.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 07:26:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 07:26:52 +0000
Message-ID: <660ffb7e-8363-90a8-7b08-2534c28a87c3@siemens.com>
Date: Wed, 17 May 2023 09:26:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Meet-up around EOSS (Prague, end of June)
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 Xenomai <xenomai@lists.linux.dev>
References: <de5bac83-77b1-87bf-1a66-c1e712e52a7c@siemens.com>
 <5a62a0fe-d60c-9ded-cf89-2ebfc53a85d0@siemens.com>
 <VE1PR08MB4909EC2EF0C817C923B271CA927E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB4909EC2EF0C817C923B271CA927E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0d09c7-6eb8-467f-2fb8-08db56a815aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nmt3xeQUMXpqNHxHL8/iof09k0ueaCltshsvj1lLyv4dch9MxSJr5Bu1uft9gFQFRoowlYrwBFUAX98vviwhf0FSOPsNqcCxOT4r1fWpwRLvwGKgPItcDc2wshru+AvLqreRR0wKdPfIE+22bbxneWEpX7nuj2/VwloxqItz9YLBRaRv70EwooJowb2pmCVNSsJCkjISxnVLWIarg4ACNC64V4sP3BiNi0elz8kTFVW56wPqFspdhsJxRVxj7GVrz+UGd6wmCNcPuYn2aViS7pOsZI9egoeY7iag/Q1r5JWQd6xkyfBM01cmF/u0mGTtziRk1aMj/pssIsYEuyYG9Hc75SXT34WvppxSDtNVOza2Xc5YBB5keoLmghqM9w8oycJIpeuskrCxwhN7Z0lxUgFKAbb3GOK2C/WneZPMKamT89wXNtzm2lxVZM/kMSSOAyYej4G8SAl5pt00Vucoo7OH2I2XwvTlYGBAU9NTiwTOMDcIft6A+jeQ62ikjs7K8yAbBeMgX52Ylv2sx+ozQPV+7GIUvuRWdjXT6y+jgQz96syfRS7XIzZV5kXNWKVCsFPH4woAQAVxjwVZDbmFFd8mH+gMVhXPlDV1d869+eisGEX9R/Nv8GjKw8SaAtTdwuQeOjztmo9mBmWgpIOKdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(6486002)(966005)(2616005)(36756003)(83380400001)(6512007)(6506007)(53546011)(38100700002)(26005)(82960400001)(86362001)(110136005)(31696002)(44832011)(2906002)(41300700001)(8676002)(31686004)(5660300002)(8936002)(316002)(66476007)(66946007)(186003)(66556008)(478600001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDd0Q0ErcE1MQy9JS0VIVk1FOTl1S0NtdFBQRlZ4a2Q0NXp0dFM4SVhSZnA0?=
 =?utf-8?B?V3ZKclJpbEV6ZkR5anBCR0QxUWUzcDJnd0FkSmdOaERkSjFmUXJOTWliOVMw?=
 =?utf-8?B?NmxycDE5MWErRlRFeWtZcGx4ckxGZlN6Z0laOU8xTFJqTyt4YzlQU2crTnFI?=
 =?utf-8?B?UFJuN3d6RVhMNlJNb2ZMeDM2aTBDeXhPcXVKSVhNUmNIZEhQM1BHNGpDNXdC?=
 =?utf-8?B?TXhXQy9VZ3cvSkpzZHBCRjB6YWF4cHE2eFhjMVBVTzdtWWErN0lPai9EVlMv?=
 =?utf-8?B?WE1CVENZYnB2N1p2QlcwSklaSnFlKzlEc3JZRlhweitJNHpZVjVWd1F0Mng5?=
 =?utf-8?B?R1JQMStTb2ZhSGhSaHJ1N1lKK21TaFVJOU9lT0xiazJQbk5ZVGtmTHZrakg3?=
 =?utf-8?B?TGJKYWNRbHVtL1poMDRYOXJPRXUrdzFpb1Jmd3N0bWJtN2FXTHo4ajNaOFpL?=
 =?utf-8?B?blArYmc1SC93cWliMTIwZEo2bTFDRGRrNnloYjMxTHlweXR0QXhBNlZxbnJN?=
 =?utf-8?B?MG5PaUtOOWhEc3pLdFpwc0NqM0FjTU5wMHZCVnhkSWNWNkd2ZVVvT3krTXlG?=
 =?utf-8?B?NGZXMVk5NFZvZVk4WmtzT0hoNlozZnRnbU5ZN2RnRERQeG1PZHpxVGZZZk00?=
 =?utf-8?B?MUY3bmpFSGU2RmtML2diR1ZWMFJEUWZZSXNBWWZxMFFSVTFSc0Rra1FqZ3RM?=
 =?utf-8?B?UEUwSVAxN1VheVp2WFE4cldNZGZIWUNpN1dZdmFGOFlxemhVZVhQcGFoVXlp?=
 =?utf-8?B?MFZSTjBCdldVNktkdFhyWTcvZGVwWTMwVVRHMHFtZ1k5b1I1MGlqY1BlUlRL?=
 =?utf-8?B?SmgrTUVuSW5wYWpDY2tvVmFCQ3JGMnBJaVV4YXl5L1g0eTFGdzJPK2g0WGVn?=
 =?utf-8?B?TTRFbjJwaFMzVmFEd0lOL1U0MVhzZkIwTjN4Y0R1SmhlWlg1RWQ4VGNSRU10?=
 =?utf-8?B?Ry9iNFlvSUxZQjhBSlIrY0xNeEdJcE1ZTk5pc0hTOWg4dlFKcTNYdWMwZXBr?=
 =?utf-8?B?clZhSlVDWGZrVjloRDRKa3UrSk5JMjhVdytCdEVQRThCRTI2N0p1cUFBV3Q0?=
 =?utf-8?B?NFo4N3JHZysrTkRCMmFrYWdScnVjUFFpbnRmYlRSZmM5dVhWaXNNeWlUTjJp?=
 =?utf-8?B?a2dINEd3M1V5cldZUjRwWWxLNDRwUm5vdWJHSXhjS3JUMDc0endnV1d6U1du?=
 =?utf-8?B?RWxwcG5mc2g3ak1sOHVFaUh4QkdnNVA2ZllsVTd4U2ZtNnZDVWhMdkVkNDdx?=
 =?utf-8?B?US92czB6QWZmeTl0WHhxNnZJR0RGakhMY1FMZ2YwZGc4bDREOHMrZXdXVkVr?=
 =?utf-8?B?VkhvV3VNNnh4THM1blQ3NVo2N2tmaE96ZVFFMzhJeDU2VDg0NVBUVnhtL3dB?=
 =?utf-8?B?WWw1RXlNdVNoZllKU05ncjZtdzB1YVM1cGJwdVZvbU5rUUc3cEZJTXJkcUM0?=
 =?utf-8?B?ZEdpK3VGU2NDMWN6bnRjMS8xczlVV2NQeTliMWlTOWduVFRNdkxKeWR0ODNY?=
 =?utf-8?B?ZUs3WVIyUGE3a0hWNmx5ZmxTZWhiNEVVQjlXQUhBK1N6OVQyL2lOME51Vmcv?=
 =?utf-8?B?UStwL0tQWCsrbUY0NHN6WTdtRzlHeG9jYURVbjY1VDlxSWE1eUdMTVBFMVFN?=
 =?utf-8?B?cFp1QzF6eGtGU3VQei9pc2VKdU94RGNFSjFwNHBhRnk2Y3c4dGFzcmdubDRI?=
 =?utf-8?B?eEdUWm5FYStjc3hxVVJrSDVESzN2R2d6Q0hUWklGUWNBNFdGVnhiV2FvREp6?=
 =?utf-8?B?SG0xb1JROGp5b3RxdTlmbHZlNXlSMFhORWVvT1Y1OWZGQ0VScnZlcTNtQUV1?=
 =?utf-8?B?NEtHK1U0SEJvdnhodzYrWlFiTjllQW9KUisyT3hUeTRScndsZmRZRHFycDFQ?=
 =?utf-8?B?cVFkdWlmOHFIZFBLTEpBY0YxWThvV3JwOGxxZUNOQlQ3Vmo5TFYwZGJ0NmVH?=
 =?utf-8?B?Q1VUUVJ2R095YVhOQXA5NnUrb0Y1ajRsdCtZQ3laWmRGd2NRd2dlVE9QRlpR?=
 =?utf-8?B?dEtTRzZMYU9raEE2S0ZqV2Y4b1hmTlA1VXpRMVJOcXZHT2xvY0lRMVJDN1pk?=
 =?utf-8?B?M3V6dFpOSVB3bDgvTzd4WE1BY3BPdTdNUFVWZFk2M256QVVuUzgyd0hDZUVK?=
 =?utf-8?Q?dc+5/zVAeAHtE8y4HAHWxyMw0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0d09c7-6eb8-467f-2fb8-08db56a815aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:26:52.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjtqY9jCJXhtUO7o+W0HANJgKx1c+er4UAXhDCR8XgpCiJZZts/eTwStTCTVoZxLnYTHhueeZlCpnyoNcalqgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6119

On 17.05.23 09:16, Johannes Kirchmair wrote:
> Hey,
> 
> As I did not write here before, hope I am included in the three other people. :-)
> 

You were :)

> Johannes
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Mittwoch, 17. Mai 2023 09:13
>> To: Xenomai <xenomai@lists.linux.dev>
>> Subject: Re: Meet-up around EOSS (Prague, end of June)
>>
>> CAUTION: External E-Mail !
>>
>> On 22.02.23 08:32, Jan Kiszka wrote:
>>> Hi all,
>>>
>>> as just discussed in the community call, I'd like to propose having a
>>> Xenomai meet-up at or around the Embedded Open Source Summit in Prague
>>> this year [1]. If you plan to go there - I do - and are interested in
>>> chatting about Xenomai topics face-to-face, please let us know.
>>> Depending on the feedback, we would make this more or less formal, from
>>> looking for a real meeting room to defining a time and place to have
>>> dinner and beer together.
>>>
>>> BTW, the CFP for EOSS is still open for a few more days in case you want
>>> to talk about your latest great Xenomai project at this event.
>>>
>>> Jan
>>>
>>> [1] https://events.linuxfoundation.org/embedded-open-source-summit/
>>>
>>
>> Just a reminder that we sitll plan to have an informal meetup there,
>> likely in some nice place for dinner and drinks. Besides Richard, at
>> least 3 more folks signaled to join.
>>
>> Jan
>>
>> --
>> Siemens AG, Technology
>> Competence Center Embedded Linux
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

