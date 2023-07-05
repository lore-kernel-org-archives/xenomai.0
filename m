Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2062.outbound.protection.outlook.com [40.107.241.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE8137E
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 07:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgWmNJYKzhIL5pVz5BauA0MaTNqnupkm8EdS1qUbxu/8A+JCCmxF7R2DXm11FiuuCRlOXqr1+hlQHOwMTvNFRZRZaGCD1EUd2hzhl/JuT1AqnIS0Tvh+iNjWyD2PgfObSIf7ajWfr4EizJ7ldre4OrJxm9ZbelHtq83LAQ+iWPamRufWv5r4uA1jP0wfAImerqwcTxOayhOOUt2ANX6Kc5GrAQIU8DF8LqC2IZyXLLsGyuzIBE4Yu0AzvRcRyyMXiTmVAEtZW9MlEBz2GhyUEviBrczpHvDNc35YN0DiR9EFUYgQaXXQn+HvZlDqv+U09ABo9RJI79q5dEdiZnD4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaYkBqbStUw8sSPBy6PBDVqbf1PLqOO86le7rvZON5M=;
 b=ICXB5jTOKXmq1DL2ISqKHE6CqtZkMzaQcs0mIL+XTLua6fBC1c+ApOGnDO1CNcSQJESPN+a+b8xb1AdGBzY0IwZYG4SzGchLYU5aDjxVdJY3ulF+vesJbghfUk1FX4M52sWyEUATHrojxCpdfecYvDzL3N67+LwW3L34+LO3TAHnweKBJnwEe0px712wsorh72WnNhAKi4mcz5F8ClrWxdogZ8fs3QwKCwOzPMNWSW/EVUu2z3WxRktVBAzKCzfSc8oM6TtD0mShWQwOEDOOjd9s/Lpih0eVgpY4MrejY5jXwvd3N328WjEbK8vvKsqy7f9L6cv4F1fgMmfAn+5T0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaYkBqbStUw8sSPBy6PBDVqbf1PLqOO86le7rvZON5M=;
 b=jRO38db82LJ/Du+H8MbDTllpQ1tYR3EA+FbVsZR+KUHKTccF5V+YDIHDV9B5bSshlq7nlYleq/2+WbB5mpoHZ+0HVdJJD0ggQEKkoCwuqbEufnLVA6miyvsUu+Rz3k7Z3OuugiZhCxrmf1t5O38SeVWAWactU/dzGogh6h6gkjQbe1DapWZwq93+HvVXpIZAjX2524KfWxF3xHMdIVgEDiT9zXz4CPO0dAhIn87Q9qJb9y6ERnq6oqBQNmOMciG0amzu6Y4Exx5rzaxgY0F7EqifOx8G3EVSSdiJytOdCQacVnNsLY4cxAhX4u3N1orECnESct3OPvqBM8UIdr9WOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 07:14:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:14:36 +0000
Message-ID: <ee3f32c1-8617-525b-ad4b-489b05f7d9ed@siemens.com>
Date: Wed, 5 Jul 2023 09:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 00/12] y2038: Add time64_t support to scheduler and thread
 APIs
Content-Language: en-US
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
 <bbded65d-a4df-1570-26f3-fab45bc71d1e@siemens.com>
 <d33cf5d4913f71182682bc1fcc8d12ff94237053.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <d33cf5d4913f71182682bc1fcc8d12ff94237053.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0c1d61-01b2-4b75-d54c-08db7d277d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	udNZ+te102O2d5LjjhzOklhEGViyBN/RA+0BmkmeLa26VfWnzfo6sCM7chvFnKd73j7MorgfmWP4KA0+m4+0p08iHDTaBQzsothRwNZY/0meczRoqb45i/r7ZROgBrBbFV+s+HSazD6yjhK3BlRrjyEyaed/wRbllgU/tUreoZBMgLWbfA3Y5WTe5dtybxYUhzuCvuSYHWvK97c+Rt2vrkHGbWSwu+CNIAQ5Jufzq/MFG3fJoMMV6MI14LRuOwmlhXcIPvkZ+KNSV/BNPTK/BNV6MWPcigDM9w0QAm3+EuslRvr7hmtDnepKNdBCg9fkJerV7/mxwZIYgsyavZ8LExKicfoAY5NVtpQSmHLT9FIPgjuSNIvru23Ru0g8CJeJQg5keyJOZmV4zcv2D316ufo+Tj3MsDOY7O0pAG7eNRnr1duQ9v+oJkRRefkxSwYOZ5zWjNENBCO9ox97xrEr1e/EWMCEDr+7I8LB5z9/IDxMOovrpLqm+QmXqo+x8jjnTVjK4RjWTuyeTbA6bn+RpSDRVSnDHfBa0b326JHrt/jAg6K6irbT45fbBLehEtVIip2UdVOCUDK7T8/nqkMpf8IUe94+x7+ksAZnxd4J8PGqzK5ByZZMpZi5Cy6HNlcu2fQ/vm4WjouHU2B/HyImUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(44832011)(5660300002)(8936002)(8676002)(316002)(2906002)(83380400001)(31686004)(41300700001)(2616005)(82960400001)(66476007)(66556008)(66946007)(38100700002)(86362001)(186003)(53546011)(110136005)(6506007)(26005)(478600001)(31696002)(6512007)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2xtVGRJYXkvU3c5dDdPbUJwejdCRkZiM05aOUlrOGtFaXp5L3NBOEN5NHND?=
 =?utf-8?B?azRTOGdvY2ovdW1IbWxVT1NHL0xUcWc4NTkrY3Z2RWY4UVFlWXM4bFN4K1c3?=
 =?utf-8?B?S0JVOUhyQ3pVU1p5OEtsaUxqd1JzT29hWHpQUnRVZkJtK0E0a2NBUzZvNVFI?=
 =?utf-8?B?RmdzV2lZcmw5UzdFMU5vS05PV2JHOGc0bDZTZTdOdDJ5ckRuR2x3Wk9HMXU0?=
 =?utf-8?B?VXRKK1lLWlYySmdUNnBMeG5GaGZ4WTAyaURUdjFNcVdFbUtSNzRndGdhY2tP?=
 =?utf-8?B?VnA3V21RT3RUZjRFdVFWVHBsMDVkSnd6UDEyci9oSENPaVBrS3ViL0xNN3FS?=
 =?utf-8?B?dEZGVDZybWxLZm0rSW1yakJjRkxqakJqYmlOeStjdXBMUEcrb2RjZnBCdXMw?=
 =?utf-8?B?eFZnMm1mdm41c0xhK1p1MUJRYXR0OEdKNml4anVoZFhRcWdDTnJsaVNJeFlh?=
 =?utf-8?B?a05raCtxV01mYXI1dUt5Z0hyZTlSdGczbUlzV2VQTHRQNXpEdlIyRjNFZ1BK?=
 =?utf-8?B?aVVhWUpQSlI1MVRYMHZTdWpHNUVEc3ArdUtlcWhRbGZhbTFCcnBsbjNxN2VJ?=
 =?utf-8?B?QVFYTTN4NlZ2T0k3NkhEOGR5SHFCMWRKNWF4T1BDK092alpMell4ZEJLdlVP?=
 =?utf-8?B?WmlRbUZEa3ZlNTkzaXpZUWp2YmhIdkxnUFhIUUVIaFhrK3pUMzY1dnJWVmQ5?=
 =?utf-8?B?ZVFOQ0xlZkQxMHZjQjdhTjBhM0dUclI4RkxKWXBJM2x2UkNPRm93OEUrQjdv?=
 =?utf-8?B?dmtqY0RGU09YNysrWFBJNzJ5eWNmNVIxKzNSRXVZK09NRTBieXFkNjlNUlJU?=
 =?utf-8?B?ZGtzbm9CK3hSNFE1ekdkLzJnaGhpS0lqTmxXcEdXOUVVcmxhdG5ja1JPVy9F?=
 =?utf-8?B?OG40ZnpNeXlnbzRMUi9hemxpZmRLRklTSkl3dEJLWFJvWS9uZHZ1ck0yWk8y?=
 =?utf-8?B?NTRMRURIZkM4VTVWM2NkYjVSeWFTdHlUa2NnejF6THhDUlN6T3pCVE5QMm0z?=
 =?utf-8?B?WkZzUGhNLytnQ2xESGIxWWtPa2RqcnVjZzdwdjBSUXU2cVd5eUFGVTluYmJI?=
 =?utf-8?B?bmRWWGhMMzMzWE9FRWZ3R1Q2dHJXUTUvc2tIUDhGR0ExNytqZythVzdoNDRz?=
 =?utf-8?B?VmtYOVFwK3RXSU4vNjMrcGR0RGJkSzVocE9paFJaeGtzVytLcDUzT083NllR?=
 =?utf-8?B?NVZTeDhyaEk0Vkt6NnVtYmkySkdoeFlWMVZORTJVT0JZT2Q4WEk5WFJWUnRL?=
 =?utf-8?B?aTVlMG1VcVRnZVdkajFjQ1lGMVVMVWFsVXNJdFNFM1pTaUx6VnB4anYzUDZG?=
 =?utf-8?B?YndDRWFjZUhsRHNxaU84cFBvd3NoblRaRTMrb0pJQk5qeWZ4eC9tSWo3Q3JL?=
 =?utf-8?B?eWVuMHhGdFMwV3ozbkNyQ3lEekFGUkpnZDF0ckZrTU4xSG9qalExSDNBREs2?=
 =?utf-8?B?OFFyZmljUS92eDRZVWFxaUZpMjF4SzAvZUJUQlpkTDdqK29hcEVKT2dMcEpu?=
 =?utf-8?B?Tm5uK0FPNDY3UmhVTTVMN29CM3pzOHo0V3NDUFRyVE8rbitEZG1nc09aU29K?=
 =?utf-8?B?UjFQQWxoSDBZSXd5ekRNWHphZXVpWWpRRHNRRlhrU1hpdnJlNmVoWG42Qi9B?=
 =?utf-8?B?M2xEbXg4a1VmM1FHN1BYcHVJSTlFbm9QYTBRMmQxN2VxVHJmR0Y5YUZhQ2FY?=
 =?utf-8?B?Z0VkSEJYQ2FoZHRGSWtXQitKWkYxanpKNEdrYThsZG5VQ0RSeEhUQWhDc25h?=
 =?utf-8?B?Z1ZiRUdjRmluOG5zNkFvN1R1ZGhnRTBjN1VsajlqWDFnbHZyR2JhRDdtR1Mw?=
 =?utf-8?B?bW5vQVNWcEdJcWlQa3FBYlQ2aHpFZExoNzZHZVYzdmlkcktqSlhuZFRsVStL?=
 =?utf-8?B?aE0zWVJLeWxmR2xmMVV2S2grMGdyQ1VNSTlWT1lyNFlETDQyOGF2YndyT1A1?=
 =?utf-8?B?aU4yM3N3UHkzSnFyWVdRNVBZa21ZakxFd3BVdWRiTkNyT3gvUHIyMTJuV25t?=
 =?utf-8?B?RXg5cnVUUXAxUFZkaG9aQTI3WXJsa1RGUlFYbmkyR2xQakxWY0FjNzNJOWFR?=
 =?utf-8?B?NHdNSFdPL2VpVTJtQnM4ejY1cUhZbU9DOS9PSFFFWTB3RjdJWGdTd1ZpZE1M?=
 =?utf-8?B?R2M5b1lZRS9ScGljTnZRYnVMckdUOHlKV202S3lpSG1jUFR1bWpITlNqRmFU?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0c1d61-01b2-4b75-d54c-08db7d277d98
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:14:36.8872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StdQHmATgqcyNDV+LZJ6rxuaiKHEjt4x8TFtCYFf6cI8/jekmEghkQKJopVJCfa9A42Z1xWVTCUsPBflWdVgyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7321

On 05.07.23 09:05, Bezdeka, Florian (T CED SES-DE) wrote:
> On Wed, 2023-07-05 at 08:54 +0200, Jan Kiszka wrote:
>> On 05.07.23 08:38, Florian Bezdeka wrote:
>>> Hi all,
>>>
>>> this is hopefully the last preparation series necessary to turn on
>>> time64_t support (a.k.a. y2038 support). 
>>>
>>> With this series applied the Xenomai specific APIs around scheduler
>>> and
>>> thread APIs will support time64_t when requested. The final "turn
>>> on by
>>> default" switch will be part of the final y2038 series (which is
>>> hopefully
>>> the next one).
>>>
>>> The remaining stuff can be found in my y2038 queue at [1].
>>> The Xenomai hackerspace wiki is up to date and represents the
>>> current
>>> state of the y2038 work. See [2].
>>
>> Which of the fixes from patch 8 onward should be merged first so that
>> the problems with the in-tree tests are addressed first?
> 
> That would be Patch 10 only. I never saw this problem on internal CI
> test runs, so I'm not 100% sure if that fixes the issue. But I think
> it's worth giving it a try.
> 
> I can try to move it to the front of the series. Should be easy but the
> QA CI run will take some time.
> 

I just did that in next, let's see...

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

