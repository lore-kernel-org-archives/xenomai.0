Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28241864
	for <xenomai@lists.linux.dev>; Fri, 29 Sep 2023 11:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI83VbXpTOJ+VpicHoeYaYWkcGhvbGtzpw3mfZTU+PCsGMCmMJrDA/AK+7ldekeKI/dwcfXVCujNSI60OI4hhyQRkvcaxqMk9UoNV1Zr51XagnFKJWDWnyym68OPQha3nDs25hh31cfXZACJ50fQE+15JfXM6s2N5NN89uk/meBbUhEWhsIHlK19APwnwQieNyMPJ3UEEdxr34MlhK7SpLxqEmNlavLXX33mbYZgn6QpEvsK6OfCeeGF3lath/z833XiqkoL+Lj1bODr4VYHkxiayJJBdRuL/bVxYGryXHRW6AOhii7jPUYxP0lT/S3IKbBjRPZFwFvQg0M/7692WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ITDtNLv5c+vz+PtD2ShLyLbE7nDiHL1Ghno1X+FOlM=;
 b=gAJGuORo+lSOdSpk9FAvNQAZkwrySuiIMcQlg7mZdmLKaUJFV9tM8B5Jb5gligwa3NtbzOC+EilVLq8FhREYcgJu71rQXDSQ5p30mZRf7Y2FDZsjFPFZjJi55oeLrUvzLOVHFMIRa+ZLJK13aOSxtLTyJNStqIJSqqwqlJHbdZUgwzd+ofSH1EYW1okty850A9P9EqOWjSqaw1btU/wapb2lp7WQ9S5j6699VKwVzIlhdBrNPaPnmma9vM8+2meDJ/xjHXXXIuWiFLuIWa0/rD+hWa6rriBpb5mhfrXwkWVA6n+vPDRi7NRgFmh/45kjh8JAX76TKB0SGdDASvwN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ITDtNLv5c+vz+PtD2ShLyLbE7nDiHL1Ghno1X+FOlM=;
 b=syGTHCNoi/ZT+/2x+EZ7G57Q89DWLypfat6FSv7CaQqPkA6lXCq4VTkVbVt5pu5G0Pg+DuoO05b/Rv3wfg3iJ52Rp2pW7BkCfjk9DS1CJVd9vZAVKyXHsX/C2TVc/t4vTY6QBqG17yRVPG7NyBK5jSxjfM1dKg/Lx8dc0d4/3PqbG89qw3XITYK/NheX2YkncJTI9FZsGdv7nL9vI+cFbU68FpfcLXHwRxIAZgAeIPocinE4Y7j3seOY94B+sFuxPt46KUxBaSrDPq1ZAtw8dbuF+5mNr5e02rh+0Y5TPQQgTdiYGEbJWb4CU9DZfOyW4nbGntQb514AumheFoIbug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7295.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 11:59:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Fri, 29 Sep 2023
 11:59:38 +0000
Message-ID: <79a07f6c-17e2-4d41-b3a4-766513022a02@siemens.com>
Date: Fri, 29 Sep 2023 13:59:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] y2038: Finalize and enable y2038 support
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
 <e21e5064-061b-422c-be02-74aa08d26719@siemens.com>
 <6dccc04e926ae6a658c297cd7f45566e55fbeb7d.camel@siemens.com>
 <d0dc4947-3124-4781-a09a-fc1eeff23578@siemens.com>
 <75b00486e78fd4b2199b8c1ca1bc00fe133a009f.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <75b00486e78fd4b2199b8c1ca1bc00fe133a009f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:610:58::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: bb219a1f-6f57-44a7-9afe-08dbc0e38e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V0x6ju7P2woGMgP9UL+LSj1ls1r2K7c+el91QP47DqXkMkzndjdzk5lVUfAXtsc9k2tm5WhMkmZjczaoLNitySW7a+jSWUfWchCa00Irfy+HX7z3tzMHZDHRsVTCm7Jq6aEyA0mjc9iEPrYobchGLdrwryJA2Ib9iEzxBITI2jBeDAp0p/au/o3+2h9DukUaHYO4mcZmBehp2F5NxVtnJXOstna6dJXyDaZRjvH3SOjXZY7rkhWf9JB9KYDGRJ94fuuQmq4vLla1BDSfkYK57orun3UvnBDDeZ46/9WxvHmHXm5k4EkxfH9aupsd8oYPO+6JEkyaFtWTX/9WAJmGVDMn9pncj5OHHaEM5hOEkpWOxerxKzyEeGhLIjbjKCsxelEIwXOtrFae/KeQ65srKG63BuYJQzom+HcWD9YmquWMDDLJ9ULtIpa583tS9iORAAdznkIF8PEcMLf3eBTYUb4mXnAJtuNQ5If+K3KXqNDzk9c05u8htbYgVOJVIGxgYFiYcC4rXQJdp2SKI6WCEwdmGsQUAjOWwfrRSr5TDu2SaM7FRjmPO3zwjL0yn9NSTYmqlNk6jL27ou03uWPQScv4fwH/EGQfeaa6S4a5MCRQw2AvjtNiVQ5hfR29wdCY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66476007)(316002)(41300700001)(8936002)(83380400001)(966005)(26005)(6486002)(6666004)(53546011)(6506007)(6512007)(478600001)(66556008)(8676002)(2616005)(66946007)(2906002)(86362001)(38100700002)(5660300002)(31696002)(36756003)(82960400001)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1cwSmYwTi8vNjN2YTVYKzNvazdsRVU0SndjcThFVE45L01DQytscVU2QWpm?=
 =?utf-8?B?dWpkV3lCZXR1aTVvL1VlSWZmaWFya2taM2J6emM3aXpmUDlOSnZJTGdBeEFY?=
 =?utf-8?B?Qm5KbEtMYTZoamQ1WUlLZG9ka05SSE5ZeGZ4dlpYbGVLNTdVY2gwKzdTVGVk?=
 =?utf-8?B?MkdzTHM1K2lObm91THIzV3cxeDNjRFkvK3FNZGxjRWUzemNrdjRPMzVyc25E?=
 =?utf-8?B?L0N5bUNDdnFSUFkwWmZGQ0RLamI4cWxsSHNLZ2hYWHhNSENmSzhLUE4vYUNz?=
 =?utf-8?B?MXYvU1ZTWUNxYll4UVl1ZHhUb29SN1gxOUpkOU9wMEFGT3NndS9MZTZKTUpu?=
 =?utf-8?B?YW1xWGpIVUorbFhybk12TW5ISDExWFZveVVIdFFQY05HTG44OS9uM2VvZ1Bo?=
 =?utf-8?B?LzJQT21XSWZsdHc0Y0VGWnBjQkxlNkgzeWtsRWlNbGFBR043aXEzUFgvZ0ky?=
 =?utf-8?B?T0RWeEZsV2lDbk9BYm42TGpyUGQ5eUlDRXQ3UUJDLzgyVkVIRkNvZ2F4K3gy?=
 =?utf-8?B?ZW82MDNQcFFYbXlTTEg3TlA5c0hCLzVDSDgvcTQzSENteW1wQTM3SXMvRW50?=
 =?utf-8?B?ajNVNGxYbGhxZmtIa1NtZVYwbW1KZmhiK2xqVG9UdVd2SEpXSks2UzFyMDV1?=
 =?utf-8?B?dm5YSk0wMTVXQVUwcTljbFNDTU03NjhhQjJXdWtxbCs3QVBWSHJJYzY4Q29P?=
 =?utf-8?B?NEpPdzV5KzE3YjRNNi9FbitGR1ZDN3kya3R1RGw2ZVJLYlR2WmVNOWlKVnlI?=
 =?utf-8?B?WDZvN1RMaGRiRVZ1MW42NkpLbk1wKzhtdnZhS3NUSDJuRmhLNThZaTFKNlI3?=
 =?utf-8?B?Z1dRcVpPRHJJZEVVUnIvR1l0bm0rZFhUYlo0UlRhaTlaNzgxZ2dDMlV3TzZI?=
 =?utf-8?B?V0pzWFkzNmJsODRzTys3YXFydGFueFBVbzEvcG1SVjg1NXordTN4SThyd2FS?=
 =?utf-8?B?MTZwbjh3eWdpZGU5OHV0L0t4SHRJZ1QzR3N1VGRlSk1GOTRtSk9PVXJvSG5P?=
 =?utf-8?B?RnYzeWlZcGQ2dFBxL2s1VlAyMXNqSEUwenFseXpOOW1VWFFTUTRvMk9BOVFj?=
 =?utf-8?B?OUh1bnJDMFc4dVVuS0ticmpEaklISzdnUTBXL0EvNzdWWE1JRlhjY2d0ZEhG?=
 =?utf-8?B?ZnM2b2lMR3VpazVQbUx0bVVIQzY2KzVyYVNTbjEzL2F3RTNUUjVYL1p1UnBJ?=
 =?utf-8?B?d0YwUEZ3ZUk0UHd5ZVJwSmJ2VEl4OE9zcjFxNWZTemVUKzYyK1FIZUlnSUlK?=
 =?utf-8?B?aDlwcUZ0ekJPNVVOUTFzbFc4aDJFczh6cnYwc0wzeVJsK29vWUh0bEdNckI2?=
 =?utf-8?B?UWxaTnlVb0ZtVmFJcnpiRVU0cFVKQ0FrTk5NQVVHUkMza003TERNa3o2dDd0?=
 =?utf-8?B?Yy9EOERhbVJSYk1HWEVlU1p6czMxN1dodGlySWVaUGJDUFZ4UmxBcXhMbVJp?=
 =?utf-8?B?aGlxckV2SDZ4UmVWUDQrTzVmQStXcjdZcFZtZXdmazVwL2JzYU1ZYnVEc0Jt?=
 =?utf-8?B?Nkg0V3VoYUZpVkhPcmtBZFp6UGcrNGFWblNBVDFHOGwzRWx1aHVuWHg5ZzBQ?=
 =?utf-8?B?U2lDTXBOTDVnMmlIR2Q2dWFXS0QrTGxPWW54bzBncktyZ0ZXOHVXRDhlUkF3?=
 =?utf-8?B?dlFNRTU2U1FreXRvWk9XWC9FVUZiTFJ0QWptbjhDRGs3VCtMbUd2OGEzYks2?=
 =?utf-8?B?YndZTlBMWWJRcURzN3ZmU1BPSmJmdGZFSXR3MGRWaUpNNHdYbjZxV0h1UGVJ?=
 =?utf-8?B?NDZsdi9oT3BVRlFYR1B0QUJWOTVLcHlkMEpuaVVXOUxFdjFpU0c0QU9FSFFE?=
 =?utf-8?B?MXNhRjRJSVhYK0ZPTDcrem9nTEFueG9YSEF6bkpObDQvbmlIMXpLeGV3d0d6?=
 =?utf-8?B?NGFiNnFUdUFFaUROeWJqQ2JZRHBrMjArdHBkeUZGWEtyQmdFd3pudW5GMU1z?=
 =?utf-8?B?eVR4NjVuaFhqZmF3ay9BbVliV29MRVZOZm4vWjZLRXdvbFVia2pmZ0x5K0tP?=
 =?utf-8?B?cFdzNVF6QU1RUlNXa1V0TlRKd3J3L2dTQU5KWGZhV1RQVjFGNTZQQTdqYUF5?=
 =?utf-8?B?RFc3Q2NaL1hmK3Z1V0tuSWZTQkNxZVlZektwa0VlUXZPbmdWdk1ZZjlFUEg3?=
 =?utf-8?B?NktCUU15WFoyY095ak1PZjdjRVNacVppcGVycVpoaWd5a1o4RExIVEpUNkx4?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb219a1f-6f57-44a7-9afe-08dbc0e38e23
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 11:59:37.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aq7qnFxwiMZk9A/3HDLdjXfVrNvmRB3u5X4QDIZHvytRvoIw1r4IvgkNlDsHr9akLD73unSvok6Kbi1zEAZzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7295

On 29.09.23 13:15, Florian Bezdeka wrote:
> On Fri, 2023-09-29 at 10:14 +0200, Jan Kiszka wrote:
>> On 29.09.23 09:45, Florian Bezdeka wrote:
>>> On Thu, 2023-09-28 at 18:25 +0200, Jan Kiszka wrote:
>>>> Thanks, this is sure a major step forward!
>>>>
>>>> How confident are your that all these now possible combinations are
>>>> still tested? Our CI will run with y2038 enabled, right? How is the
>>>> disabled case tested, at least build-wise? Or the case "unsupported by OS"?
>>>
>>> Per default, y2038 support is enabled if
>>>   - the architecture we build for is affected
>>>   - glibc provides y2038 support as well
>>>
>>> All 32 bit targets that we have (bbb, x86-compat) are now built with
>>> y2038 support enabled.
>>>
>>> All 64 bit targets are not affected, so y2038 support is disabled (not
>>> required).
>>>
>>> The only thing that we do not test right now is the building against
>>> older glibc versions. I'm not sure if it's worth to add more CI jobs to
>>> cover that case.
>>
>> I think adding one disabled or y2038-incompatible build test with 32-bit
>> to Xenomai CI (not -images) would be good, at least for now.
> 
> The build jobs of Xenomai (not -images) are still based on Debian
> bullseye [1]. So we already test that for now, more or less by accident
> [2].

Hehe, good point.

> 
> I think we should migrate to Debian bookworm and than add one more job
> building on bullseye. Does that make sense?

Yep, sounds good.

Jan

> 
> Florian
> 
> [1] https://source.denx.de/Xenomai/xenomai/-/blob/master/.gitlab-ci.yml#L16
> [2] https://source.denx.de/Xenomai/xenomai/-/jobs/701101#L1298
> 
>>
>> Jan
>>
>> -- 
>> Siemens AG, Technology
>> Linux Expert Center
> 

-- 
Siemens AG, Technology
Linux Expert Center

