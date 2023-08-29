Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFB14AA7
	for <xenomai@lists.linux.dev>; Tue, 29 Aug 2023 13:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anR+FsK3q2HANtV40sRdAmO/qsTQb/d8k1qQRL0dEmobtE54SnGgp/MAfeu4ASf9DBVTSfJSy93MHF2iIXH1N6l9Z0SA+0CJlkHxCFmddhNkN4djV5rWe3kiSXxeIIPq3T/LAmqmWfWQgiMWUrJMwJY7Av2ft05GdCiGsrsD2vuoQwk3H/dmG0oCtJw9UXAqBO+06YE7nygJxNH+PhCszieLNi2R2oPn9Gk68tF+HGm/1vAPA1seXCFiPVpmhM2EFoy2thrTRYSW0FPGtA1IME6eRYAsV+DIncaAcNFRSiAelwQeIGf9JhvAXp5V5SSC0tIV8tqkKv1tyV3akxOosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMCNswslF8BCsGjez9/GjnamOTmUOCGHXppQcZDUyzw=;
 b=SfR+e0GF6VTRTPLsaxIfOvuFHCOcso7tRaTm5PXhReVDZaUZE3cSd2qkGjiGj02Iw0+pyMJX89sbxEjOXQDrKxTZGDNpNKYk2R/MTlHmVkikZtr+ZF2rfaeJ0UFaAgFiMGfE9Q0DkuowbbQ8EEkScWvMLIOUFdvx3zNwmWVvd/oqFAAkg3JicrhDYHdmUzCvTPLbuCucBYYbJ70Ls/lhhdCQoPUEG1T7dz8Mk56o4WOv0Eg1B1XWbkXKqZSmxa3sXpVozivuw2CYKF3NMXomBnmSItKo5uawuuQ1EvoGFXX5gplSsog6zYTHZGXFYblZ3Da4ytQ6iTIs/6J0vkejag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMCNswslF8BCsGjez9/GjnamOTmUOCGHXppQcZDUyzw=;
 b=qy43YXDDVbrwP8meQ2G13aT8lz8JABCm2CBQNl+mEV662jIXwjxbNAwecuLtwso4tD45BPjRpdBqzx2osJtYJ+heO25pR/EsJPjwqCOvCmZucixo7+JoFcUSknVw7rDvqliwMOKXw06nVJGdRISAt6RMtth5LHjuNh1mbMMg5VI+MCuQMvptpa1mcHdkVwMHgOXKNz1SF5O5lugJ/8NwCTRJvfbc677+oWZCFCv2tMO1chGFTx05ABB9etxcrqUs2YJaE5LlrJKOdlJ1QoOcZUci+mFLljOodaQtwrTwlnJcgu9liD+hLfdwbK8j+aYVKQu8ICZVWKWcEEUOeqCT1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7369.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 13:56:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 13:56:26 +0000
Message-ID: <33d8ed69-98a6-46e0-972a-f9ef419bbeac@siemens.com>
Date: Tue, 29 Aug 2023 15:56:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cobalt: Adjust dev_addr_set wrapper to 5.10, 5.1 and
 4.19 backports
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <f4a0e665-394e-46b6-ac61-cb3d3f76ea21@siemens.com>
 <d0819b6742607b5763ff643e9b7a540e5de7d544.camel@siemens.com>
 <f1d803d0f7b59818cd29fd3e80a37787e3e7ea6d.camel@siemens.com>
 <cadddc63-1063-456b-9bbe-3d7054d5b61d@siemens.com>
In-Reply-To: <cadddc63-1063-456b-9bbe-3d7054d5b61d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aec645c-4cbc-4cd5-504d-08dba897bc70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f5s8MPwb6kYFiZ/R+QGcM/v5Z72LSIojfrf3KJKQA5zrj9iOIbuZGAUys+2+GtyscaegoKMa9hXRwT84RUsejH5AxxKJ0yclWVclq81ZBNcVqpq4k4GLQtl4Of0XtuNNNmHgp7DpHH1Jok6U5l4FUM6wbxkWHszXvIlEgEsdHWKa46C9wf31jX85pbbafi77jRL5YGQrJv7tsNARy5N8ChuXQeLu9b4esESWMOzDkysHKAErAhncLj8JS3Zps9bqC93bjxbgLsT7LcdDsGdkKZQQ2VWNW6/NBS0yThbKVi0rxq6ZFTAc0Motr5FXpPgPCH1NUhDumilHoaBTs9JRqIMSH505XbKZbPTMUzHR7175K2jYYxVz2V7Tay5xXa880ctKy40FNbE1e8jPDSbFUp0wjlZXVhPe3MOY7xlyIkZHsruGqHkL7tZF3OAC7t8uCBGfEnmBzJBrsCpFbMlML7fqjnrYegArTb4dMyPXKEqCXu6X4vdHhf9mdz5U25emnNqiqr3wCHHrg+u2kqYM15OK+LhnlB0ANF+ChnCAPi9ojl/RAHQNhm1hBX3U8mpuQP6dj2JN0VscvLM1+Bs76O+48rIAnC8GNL/jnauxQw3hEk+9GqAh2lDdPm5P2mkGMOWK8sQjHJGyst32gGJiRA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(1800799009)(186009)(451199024)(31686004)(6512007)(6506007)(6486002)(36756003)(86362001)(82960400001)(38100700002)(31696002)(478600001)(83380400001)(2906002)(26005)(53546011)(110136005)(8936002)(41300700001)(66556008)(66476007)(66946007)(44832011)(8676002)(5660300002)(2616005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0JUaDFxTmp2SkIybG9hdFNXQUx0VHNEYzFYTXJXcE9UWWwyVkxBNEVMQ3ds?=
 =?utf-8?B?TTg1aDZYR3padnZ3bWtEZlhnQ2U2SGJhOW5VcUd3M1JKUEduOERISGJCUmhx?=
 =?utf-8?B?YVFEV0pnZ05xVjhDYVU2UWx1cG1VSlVlTnpGbmpQNGxxMXUvaDI5Mm5HNVBh?=
 =?utf-8?B?MitudStWSVZGc0tidkhzM0tyK2RQYlRrcHpUandCWEdGWGVBc1R1VHlhbWN6?=
 =?utf-8?B?WG15Q1dIOUN6NmVlcXpzQVhVTEpDc01YZ1RmaVVuNTN6eGpyWGRuTVlEcFBz?=
 =?utf-8?B?ZlpXZEdFRTljeHkra3poY3JYUSt4U1FiOVdkaXNCT2RIdVd5clFSR0ttNkVU?=
 =?utf-8?B?ZG91dkdkZXJOWmFEczRJdmN6cmppZFdGSmdYanBESk1WOEFGeXp1aERBYU1x?=
 =?utf-8?B?dVQvYSt1K2lqeEtxblVHaEJ4WkVBOFJoNU1pYzdlWGlWRkZRZnFmcTJFbk5J?=
 =?utf-8?B?MitPVS9MUFArNFJ6ZHdvbkdGNEtvV3NDS2dvK1lhTVN6dDFjTlAyVDkzei8v?=
 =?utf-8?B?YURtMkY1MCtIaWxFMUR2NkZwQ3czcW1IMmN3K2M2UDUyYW91Q1VFZW5RTXdE?=
 =?utf-8?B?d0xJSXU0V1ViR1pya1lVOWJiVHFvVUtGWmFpWGRrcW1McjNGVzNoV0xzV000?=
 =?utf-8?B?N01rSUE2YXd6SGR2SU5HdThrVjFHN0h0UUFMWDhxbG1KczduWFNYVEVWbEdJ?=
 =?utf-8?B?VmZidWY2elp4T3cyWElpRzdrZUtxMmtIbHBEOXdISnkxUkNCNUM2a2RpRjRB?=
 =?utf-8?B?RmV6RndsWmw5K0NWLzNQNWtIaDFBbTIwWGRzTTY3YmVTcmVBb0dvRGExSnVM?=
 =?utf-8?B?TkRFbzJzdFRsZldGdXBLamowY0d1dGU2cmVxb0FFM3lBaGFnaGViWW1zSTc1?=
 =?utf-8?B?WHlRUDZSNldHRlRVNmlLemJpQTVkOHNzMFpkMlBzRG1ab1lnQnRkNWEyRldY?=
 =?utf-8?B?OVpKOCtoNUt0WjlITGRUWTdDaGd2dUF3VUZrRUJVdTRyRkZSNUhHTlQwcW9B?=
 =?utf-8?B?RGdUckJyVDVBc1FPMDVmaTJ1N0k2ZlA1T3Y3V2ZESXdPZUZuME9IQWIyKzlZ?=
 =?utf-8?B?R0pMNytCMEJBZ29MSEU4aG9henRKLzlBZFNDTStoZW1oZUdXUjZqVVZ5aWpm?=
 =?utf-8?B?d3ptcVpCWTJRRzYxeXhnK0JJVWt1eUdDL1BmcWNibDU3Z3dkazhnRnZ4UHNz?=
 =?utf-8?B?akJQekdTa0dWdUtSbEl1RCtwUjFaTDhpWndwV3FSSXFsZFc0aEl5Q0VMejdw?=
 =?utf-8?B?TXZGWFdZVllqM2Q0QzZCUlhuN1lsSTFsVFZ6bnZIYzNxQXJ1WHBQLzlHSUlC?=
 =?utf-8?B?eVU0MmZGY3Q1d0Q1MTRtWEU2b1prTFpudHJTZkluWjJ2R2ZyRFZmc2J2ZFRk?=
 =?utf-8?B?a0FaVjBrLzdWdVNPOFR2Nzl5cHplWEg3T1daUXozcFN4ZWRVMDNOZ2FUWmxa?=
 =?utf-8?B?RzdHTW1Ycmxia2JKZXAzN0YwWGZzSHppR0hzbThJS1FhN0dEZklyL2JoWVVw?=
 =?utf-8?B?ekUwWVRvV1hkM3FXK05BTE1IRW5JdzdSeWxqcXRxMHUxZFZWN21GRElkZUpL?=
 =?utf-8?B?Vk9sTDdWS1lxZjh0S0lUcGVHbm0zUy9yQ1Q0eWRPZzFuRXAzeVRsRTFKVHln?=
 =?utf-8?B?U2lDOUNDOWNUN01kWlBob21WUEZla1BHSEtJU0pPRG5qUnpWSW5Jamo3V2w4?=
 =?utf-8?B?Rkg0SllabnRKak50SkVZTFJka3V1bmFCMGRCOHF0WG82UkY5QXF6WThQNGE2?=
 =?utf-8?B?SnpOMDNiZjdvV0hZS2w2RFVnZ2xyUHhnaFltOWRJY3lTTmZucGZ0dkJJc1hF?=
 =?utf-8?B?enR6MFIyOTBMdkNVaWV0eVVsc2lLOGpNNW0va2taTCswbHB4RzZnV29VSTNr?=
 =?utf-8?B?SkFzOEsxYlhDWHZ0L1lzb0lYdWZKN2hJcDN6c0htSFF4cGhhWmJLVUg5KzNM?=
 =?utf-8?B?MnhwMEwyVkJYY1V2UytWL2JUTUlpY3VVb2x1amZnTk04WSt3TUt5K3dYRUE4?=
 =?utf-8?B?dnpQYTNRZTNPMlloVkFnNUhtZkZjZk03SzdjMVhYSjFaUmV3U3IxK01jODIz?=
 =?utf-8?B?ZWVaYTVDQmM3QzY5Y3loZ01MbnB2Q3RnOVBqeWJSMFJVZXQyMzhXU1Z1OCty?=
 =?utf-8?B?enhnV1J4WmxvcnhrQmRBaUVhZ0lSdkl3VEdoZmF5eVo4OGVLVHdDN2ZrQm1L?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aec645c-4cbc-4cd5-504d-08dba897bc70
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 13:56:25.9561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwkIv3M28r4c2KwYJ3FMDXgPcdyVdn5JZYbusxiopPwt49n3xOGzhZP2okkFaKAeP9jgz8+WZeRZ1YqHkVH1vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7369

On 29.08.23 15:48, Jan Kiszka wrote:
> On 29.08.23 13:39, Bezdeka, Florian (T CED SES-DE) wrote:
>> On Tue, 2023-08-29 at 13:04 +0200, Florian Bezdeka wrote:
>>> On Tue, 2023-08-29 at 11:40 +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Some stable kernels gained this helper meanwhile as well.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 8 +++++++-
>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>>> index ea7ed3ad56..a533d46690 100644
>>>> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>>> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>>> @@ -54,7 +54,13 @@
>>>>  #define close_fd(__ufd)	__close_fd(current->files, __ufd)
>>>>  #endif
>>>>  
>>>> -#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
>>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
>>>> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
>>>> +     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) && \
>>>> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0) || \
>>>> +     LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) && \
>>>> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(4,19,0) || \
>>>> +     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))
>>>
>>> This is still broken. I have a 5.4.253 kernel here which already
>>> provides eth_hw_addr_set. 
>>>
>>> LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0) is true for that kernel.
>>
>> I'm testing with
>>
>> #if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
>>     ( \
>>     LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
>>     (LINUX_VERSION_CODE >= KERNEL_VERSION(5,10,0) && LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) || \
>>     (LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0) && LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) || \
>>     (LINUX_VERSION_CODE >= KERNEL_VERSION(4,19,0) && LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291)) \
>>     )
>>
>> right now. Would need proper formatting of course.
>>
> 
> Wouldn't that work as well?
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
>     (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
>      LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) && \
>     (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0) || \
>      LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) && \
>     (LINUX_VERSION_CODE >= KERNEL_VERSION(4,20,0) || \
>      LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))
> ...
> 
> Jan
> 

BTW, both v2 and v3 make no sense for master because master does not
support kernels < 5.10. But stable/v3.2.x would need it.

And I noticed that I apparently never sent v1 which was only addressing
5.10. Will do that soon (and restore next to it).

Sorry for the mess.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

