Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B56137F
	for <xenomai@lists.linux.dev>; Fri,  6 Jan 2023 11:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQVQkXt0kS6jygOfK9CRA4oMJT/7lkTl9OEkIWdiNN9NCMK424FRJa1K31ir037wSFV06MbPpzdyB+xDVMvG7Jwgn8Fw1mIwut1epDGjXYfqi9qRkYqo5gO2Mwc2737AtbGZhOPkbxwBGciPiFkB1oM4W4eJAt0CYpn8sN7++yykf11sQJOfl/RCDv0Kq+5lmiFKYS+sscdzGfXCus5JnWzVS75wYNGc4mKKyjWDrdFQ+vOdFddGUvgpSH5r3eznlvNAvut8FBwsoiq4sfw0mW5yYZK5ST2YFFKJ5S7YdWmc4WFos0nLfZYo0aus+fh3l1o4OLUeIjaFskrlM0uz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx128jEDQtFfnXGqFEsk3pCetCVujNJFN66allEZlJA=;
 b=S4wBV2KmkE52l85MuIkx/B/YT6gIQmHT34UkEWhQtIuDooyXO/5oS+PlHVCjdgE9aOw6l+l+dv50C5sWTtWVDd14m+BNg2biFhbHDWymLPqMWsGR39YW09FZArpd4+PlEbnP5m916OuYrzrXmOiEaBSsmJ8dzlPtTKc7Jsp9vsPMF4sLlona4w6pXUAcfA8B0DvAEqk2PLAp7owpn3MqtYA6m0f7SnDuBb4BVu8FJurOnS/h+o8tT0mTSP0+Yfy5gK7MXOHqY9v92zuTxEpN+oYn0YSPz3opTxMmOpJulZ3heP26/3HC0kbKY5SKU718FjcL1Cpu5SPnuVKQfuAatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx128jEDQtFfnXGqFEsk3pCetCVujNJFN66allEZlJA=;
 b=iQ5a3ycu/r/igt+nhqwVxnHiK5BgH80+Faljj63vEuK1x4nfeFCZGVBMtpLzAmPGHg6QBnTv+MLdhs3H2EFAcgvEcecHKyPKiFzJqaIVgd07OtW+ukwhU3BN9+U3SuHSvlASnICG77iR1nZJPSzQ3qhNl2jU1nz7vacSlPUCdgQPwiogawEbA/GWDtncMPVDUv4J8EvoO88SUdMoxq4/mPda8cVFMK3KeSasW//aGNbsXxyerNKzGGU9APhfNM+Idk78U7+IHOczj2dI1uNWD3AiEyTaaX/139JIy4H/NOLRbEB8GSsJq0x/N3ChkuUu1NxT8FF9qgQPqSoe7A+8wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:545::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 11:47:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 11:47:09 +0000
Message-ID: <c28d17f1-b7b8-24e1-4764-20b05894a702@siemens.com>
Date: Fri, 6 Jan 2023 12:47:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH] Update Isar to latest next version - sbuild
 integration
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230105132733.3056171-1-florian.bezdeka@siemens.com>
 <ee077ae5-b261-18cb-a903-8d268fa29883@siemens.com>
 <ad5c6da9-b10d-7400-d10c-4783eeb2c11c@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ad5c6da9-b10d-7400-d10c-4783eeb2c11c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: a805ee4f-5f9d-4590-f9bd-08daefdbbe47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NGkgB6kS0Ogq51u8TL9BXssAkvqJo8u8KQ/7RL9dO2hZPLWNoe+9P7VY0YgqpmfcX3ZwWKWC0zYdCT0M7r8HaR55A+0lTVWEu0So+WbeBZxRgeGvfVtS3gfjmvUdYwUbUhyGwBX5aRHCli6n5773rcO5S4AGmhyBPbicozMwSySY1yeXQdsBkw2cfOfsfWmTb4uVPnPVvgsSZ4IvcuIqIgS1XnlX0PL1MDHUjJfRrAkh4OFJ/M6amj/4TY09wEeDUcYMeDWYD5VnxxiGK+OZrtS0A8ekBceM7Y3LB5yV6ANnECy4J6nI33rR34G61vmP3T0C91zLeYQtA8Jqiz1gHcfaiUDDqVecD3VfPAefNWVwalOv6ATC7aF3NXwyAcDtHEfFflQDKPFiV5edoDLUIhdNS14FQrn51/x3saAcuok5KLOr/0izP9q63DnIhFT40gtK4PFefGIHUTp/JxuqxRrNSoT0ffA3mYG1pfOlJK89UAtPkOZZU5z+Z8YqUkxLbxkscETCNMQt1DTRZVKVVTLz8hIfBx3jxRyWTsRi+O3EbnbQYa7hzlYVh4zR8a7VmqQE4y+sly7urYw/8rVwLtdpyPeibXxOK5ABXAfdQcEeSTpMV1e8jTeD8rDco2yZwIsTdEtugbZUHS2GkxHa/bsNxC+JtCk5bkgHCniUEh7YdfN7zYvBXmlQFfyxj5KZ7fC2MseydHX9Fw1wuE/knWxHb5SYVN5t3/+jbrfCWO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(26005)(6512007)(6506007)(86362001)(31696002)(36756003)(186003)(53546011)(82960400001)(38100700002)(2616005)(316002)(478600001)(41300700001)(8676002)(4744005)(2906002)(5660300002)(8936002)(44832011)(6486002)(31686004)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0toUWNQTUxMTnlIVU1ZUEtPQ3NjekUzTlZMZm9PY2ZTSlhROTZMM1NlTTJo?=
 =?utf-8?B?SlFlZHNWa0RScUZKZzhDVlJNVGJLbW5pNkVIdVNKS3ZHamRYdHFTYjNCV1B1?=
 =?utf-8?B?TEM1SmZlL3BRUmExZHNsQVFtSkF3Q1lIck9aVEwxN2F4N29SaCtFUUFqT3Nm?=
 =?utf-8?B?cVZPS0pxL05yem8rZitsMGZQa1JEQjlZUkpWa2JxMkxNNmFJYThibjJhYmxt?=
 =?utf-8?B?QnFCTzAwOS9DYUVycEIyVGxVOFdoS0xYUWJJU1NkcjJ4NlBXSTAzUXZQNGJx?=
 =?utf-8?B?Nit6TTFuaW82N1VHQ0swSGJlTVVMS3FpMWVtSzZIZFJXeGdRQ1JsM3EwVVVF?=
 =?utf-8?B?M3d3QnlaaHhPcWN6djA5N093ZU54aW1vZUY5SWRvMVV1Y1R1b3J6QzdidDU3?=
 =?utf-8?B?KzZQN0FWSTdJVXY0Z0h2bHdpMytCTFJOMVBZRGEvUWJFb3VUVGQvNUxmV3Iw?=
 =?utf-8?B?YmNWUGNqTEF5WFBhUXg0N0VDQlRZdFBiQkJSdHNvb1BNNEN4Y2hNbCtaWjRL?=
 =?utf-8?B?OTZmVEdYWVl3VDRaWXYvUHlwYVFKSUNiMUdtVTVkMWdYTEdMUHNnZzdXWk1O?=
 =?utf-8?B?YncvaFltS3c1NHZ4OXZ1RjdRZFp2bW1YM3BpcmdacUxpRlNXOFdXbzl1QzhF?=
 =?utf-8?B?SjFvT0xYR0dBRy9XT3l0ZkVqS213WklvcUxQeU5XOG5tTmZVRFFFZ002LzNL?=
 =?utf-8?B?dmhjUUp5RldkRWM5cVl5RlNsZ3RwdzlwSXNFUEp6UmhzMTBDNkZtV2Q0bWhu?=
 =?utf-8?B?YXJ1YXN3QkthZm51UUluckxDQ05lOFdvY1FzUFhIUVV5anlkRUI0SHQwYjc5?=
 =?utf-8?B?RDRDblBPVEEyRVk1UDFrOGlhVXFuaFNXa0hSRWtFTS80akRQVXpnU1ZuTnRD?=
 =?utf-8?B?YW01MklPRmJQeHhiN0NISzlYT0ptanAxNER1M1NLZlgycEJMejlyUDFCMFRl?=
 =?utf-8?B?UVNlMElvbVoxcDIyVHNNSjJ5a09jaktKNXFIWWhVM1R3c3pPamp0eHpNY0dr?=
 =?utf-8?B?QVlFby84cVRyQ1pUSXQ5Rk82OFZvR05weTB6aExTQlhsNklLQU13QlhrOHk5?=
 =?utf-8?B?dG1qSW5aaXcvNHBQcVdCQW1oUFBIWmFPYmJHRUxIYyt4K0JwakFveVBkdmpp?=
 =?utf-8?B?eW1DODFqRFhBVVhacmFNYTRzYjN5bmlkRDJ1eVo1Z2MzTGdFOWhwbkR5eVN1?=
 =?utf-8?B?NTFnaXB3VitDRWJTT2UrZnIxYWl4bWwrM2kyNEhweW95ZDR6MXkzWHdSZmxr?=
 =?utf-8?B?a2xDWXFBUFY2QVV5cHN5RStIUGE5R0hWZlloaGRtM0tPVnhBTXZMRUtmNTJU?=
 =?utf-8?B?dTR5UG1HN3pLRnNpOU1PVlcvN2hNSE9sUXdmcXd6cUsxK05VamI1V3pJWTRm?=
 =?utf-8?B?Ulp6VDROcHg2bHo4R2Z2cDNmUjlzeXFxSjdQN3U2OG84d2tCY29yS1B6T3Nn?=
 =?utf-8?B?NmdkWkpPb1hleGdxR0pBZGdXc0F4TkxJbE5sZUNZZS8vdXZENG1LdmV3NE05?=
 =?utf-8?B?T0FpVFp3ZzFmcUxQTW9QYUZCR0c5YVA2TS9uY0ZWcm12d2RqSmVOS2VxZ1ZO?=
 =?utf-8?B?N3VRbmtWeVd3MERpT2J4RE51U1NEQ2tXNW5kSnpKU2pKNStvS1JleXRmakNL?=
 =?utf-8?B?WVZNV21RaFQvUDM0Skw5Z2wwU05DUzB5NlArd09DaUVIYjRHK0IxMExlcmdV?=
 =?utf-8?B?Y0crdUVDS2RmZ3lJQ2FHSTVTVmNDYmVEWW9kVkRqei9BeU5sNjBrVnhidTJn?=
 =?utf-8?B?MHBrQm54MjBmMmlzQTNSSkFRSGhhRWZUOWovODd3eDRYZFM5TFA1dC84RkFu?=
 =?utf-8?B?WlJzTmIxbVdacVZsT0EzOWgvWnRjdVVEUlBqRlNOeEx2bWxESVVaZkViK2dz?=
 =?utf-8?B?bWI0eCtEejlWV1JHRWFBT0Ivay9SRW95MWZBYmhPUDBHSFhyMUlWZWozTmRW?=
 =?utf-8?B?Nm50Z2dldmlrU0xvbFdpWFRlWjF5WHA0WE5uc2JkT0NxaXRYdXFJZ0s5Nklw?=
 =?utf-8?B?TDVZUzdzUVRBTU9OcEJJelFyaFRHc0p2YXZwTm81SHRSbHNMUTZxakJWRGQw?=
 =?utf-8?B?eFNhQkpqNDBWY0JTUkk5QTlicVNNMUtiMHB4c2UyRG9aNzN4a1B2bUJvY2hK?=
 =?utf-8?B?aXJoTisxSkl5ZDVScUVLakJyOTZ1Mm96MGpXcHE0dkFaUGdTWlJUYVhJWjZq?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a805ee4f-5f9d-4590-f9bd-08daefdbbe47
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 11:47:09.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4W8V0eipcC29GsYtSrmwawRIBqyVocHP38J8r8ba6ZyJrTKYqks0FHoOG9cePHIf1AmlT4tMyG9XdzFM6aY9fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7602

On 06.01.23 10:03, Florian Bezdeka wrote:
>>> +}
>>> +addtask patch_debian_rules after do_unpack before do_transform_template
>>> \ No newline at end of file
>>> diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
>>> index b874a4a..4994533 100644
>>> --- a/recipes-xenomai/xenomai/xenomai.inc
>>> +++ b/recipes-xenomai/xenomai/xenomai.inc
>>> @@ -34,10 +34,3 @@ do_prepare_build() {
>>>      rm -f ${S}/debian/source/format
>>>  }
>>>  
>>> -dpkg_runbuild_prepend() {
>>> -    bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
>>> -                     ${PV} ${COMMIT})
>>
>> We lost this part now.
> 
> Nope, it only moved to dpkg_runbuild_prepend() above.
> 

xenomai != linux-xenomai.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

