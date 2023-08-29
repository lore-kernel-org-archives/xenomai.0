Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEAD156E2
	for <xenomai@lists.linux.dev>; Tue, 29 Aug 2023 13:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UafAQC67ef7jtXudFLxS3XRvFZxnrIT9AuV3rKjNBj3Q2XaPZreLEbzaTQOdHRLuZ/+2diy58tf5uGiJt8RY+JG9IbmG/+x90erPaO2MZKpbFQRqpLEVMBf6lt2ZrFy/2HxwuP4tHsPif7ZknYARHWG5z2gNG1fFCsh85wy2IWcZt94S8lsBDnb3cgoh6tgJ5nP0w5wxv97VAW0jn7BaYi1kCrRdiSTborNSWGFoMUM1vkNZyRNcvyvUFUwcHd3JC5qCNvYJYAh+MC1fhmCZuIYt+ZfudxrOQxPbANxwVu/F4h6NRijlT/yllndgggll6xkGd5S/HiJu8GncjeeVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+Gup9VvJeHshsi6irLisk9csEzSc5uRXkjxIIIzwW0=;
 b=lpuzBsB4gCzBXPaEjtYHswXkbzNT5TwMRP3Y1YH/Kq9fVB8jDU5Efa/Ar1pjKFAFfQLA7Nj5JcPOUjZkvE51C5Q7LRfz10fQjp8pli9eNv7tsG21SOL8TZ2DoJtZ8ZMalZCJ3SxVeogNLSzo+Kcd/3/TUUaNEfzxY1UkTJINQHmqmDBJ1uf8AKRrY+VciaIwAeIbCsGmF2thKrUQUkkaUw3UeVkmJsoQS/+os25OFCne7APnR5O98E5WA/8vgJA0YEiwtL4/iBrKzpBOjZk79Le7tSQxfli17yV0ArQ+T2xJ/Nf42pHzyY/jbSnzRuDChw1HxeSXi0zneKbZ4AUltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+Gup9VvJeHshsi6irLisk9csEzSc5uRXkjxIIIzwW0=;
 b=V3tGF99zPox0Lc4nj1P66STL1YfgDLsMfTtLBUgcDs93I+IadDv7EB29v2lMsxGWSfNoc2UlmhM3HN168u+vkzXEgViC7jaww7aOVCDpCP7nCJupyBWgp+/sRzccXFXC+S5sxPbwrnO0sHuutPdi4yjjl96iGimCE/DLGc7EfRsShgcWgdiTYD5Z4gYT9vGCV7Y0tRqM+/efGFmyefAIDYHetDBQV0n2dijWX9HGI4GSiXlynZCihw+z+4SM6PMyIuN4H1efC+EVYQ0uIuKZIYNDIV0ItM3osC/msHjRcpcjHOZg1YMzNd0mUZIVF4tWSiZNs9Z+MdvjZ6O1oheJPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5389.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 13:48:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 13:48:29 +0000
Message-ID: <cadddc63-1063-456b-9bbe-3d7054d5b61d@siemens.com>
Date: Tue, 29 Aug 2023 15:48:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cobalt: Adjust dev_addr_set wrapper to 5.10, 5.1 and
 4.19 backports
Content-Language: en-US
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <f4a0e665-394e-46b6-ac61-cb3d3f76ea21@siemens.com>
 <d0819b6742607b5763ff643e9b7a540e5de7d544.camel@siemens.com>
 <f1d803d0f7b59818cd29fd3e80a37787e3e7ea6d.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <f1d803d0f7b59818cd29fd3e80a37787e3e7ea6d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b18aa5-92bc-4443-a7dd-08dba896a029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zhlUEjbbDlwO7JUq1KQWjEyw7/2wCXNvnGrB+q/bR0aTPyg+fW1jWZjXWeBtMigp3kRqkBS56LTOR1UIhMDcwi8A9vJv849E6T9Hkffdp2GWmzgpuKfUcvYPwyfrM+PWhejYf7qQvX40li574G3ec89xCcTdKK2K/VGvtMhN03guTEW8X3lY6pe5pdkpY+VS8eA28jE3hNBja/Goh+dcKedPQmyMAHGGGG6OkTrmtTwE+WfEo5cZqy0Y57Wv/IaToRZCAMKJwq6PbMW4gYlq6Nr93Kmsp7U7WT+9XKaJnpqbQKhb8yRP3H+HcY0C7Ut8lj8nbsFFQr72CNQOouJBMc4ieTcIcK58xqNu68sVueAG8oU9rmILV+QSKjrvs9k3wwc9p5+j6L6vm84QvLeh0AaGyqVsf+00oHJM1VhvI09foYh2xHRpfGyVOS/XGzqYxrKEJo0cX2H+ta73dU2kjIXczwt25wNnda4p9j/ImXPqTk/HNkMCtjai7a/8l4B5UJhwMvLxUfXEW8BIi33nF0j1heXt1RaSe2+VmI7avXjaOr5/FJL0HCbJcVE4g5D2LGbDVqJi2dw4rCGVNsp+cj94tlTjYWjnWN2H/X6D6cYg4EEcW2BBFGKZYWcPu0Ag5vchOG3MxAgUBns7olkhuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199024)(186009)(1800799009)(31686004)(6506007)(6666004)(6486002)(6512007)(86362001)(36756003)(82960400001)(38100700002)(31696002)(2616005)(478600001)(2906002)(26005)(53546011)(83380400001)(110136005)(66556008)(8936002)(66946007)(66476007)(8676002)(5660300002)(44832011)(41300700001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWwwV2dTU2FhbXdWOTJZbnNZZTNPeFowc3NtZ1pyMDgrbTlxU0l2RUtJNFFv?=
 =?utf-8?B?RlRoeWNjUFBSQ1pFblpQMHU0ckhIT0dXU2dJZTJUU1VDM0UzcVR1TEgwZ0pk?=
 =?utf-8?B?RkgydzhNV3crYVQyME1CMHZrWUdUL1h6eVFacHp0b3hpQ3Nsd3R5SnZqcHdo?=
 =?utf-8?B?Nk9mQllHTk1PRlh4dmowNGoxcGY5L2w1bnp1UHNoVGVTa3dERUdSZlY3UkVH?=
 =?utf-8?B?UmVROFYwZzAxSHFKdFkySzBHRWhub3hmL3NlUFh6VDM3TUYrYWpTbXZZQmli?=
 =?utf-8?B?bnpybnJaNHFvNDBKekM3aEFTanV0SDhRaGdGTGUzV0pBWW1mcVVsRVV0ODNl?=
 =?utf-8?B?TnZPMUhDcUdNWHBiUVBqQlYvQW0xSzBWVVRldCsxMWVuOEhFQ0xEY0R1Vito?=
 =?utf-8?B?a1UrUnBVcWd0MWRRb090L1RJNnhmUUxiRlFPK1dZb0FsZFpDZWtmQVQ4UGNP?=
 =?utf-8?B?L2syaWhET3pPbHZmYVdPUWpvenZ0RlFJYy9CT0VMdXBvNm0wQUpCYVZvL0tj?=
 =?utf-8?B?azQ5WEc2WjRGd2swc0o1SVBlc21GdEE0WGFTN3ZESXhUSXhMN3RCTkw4NG0z?=
 =?utf-8?B?Q3dieTk5U2NIY1lKY01KV0xuTGFEUlZVdFBVMjFMS0g4Qm1iVmVBQXROdjZN?=
 =?utf-8?B?K2N5Qkc4dCtpZjRlcXZ4MzJPQWcwcHVJbU81dHFPWTkreHl0c0RIQnNCZDh1?=
 =?utf-8?B?Y3Zvd2Y3VVg0NVkxNit2dkwxVWM0eGRFL1Nld2UzVUJBM2hpTmVVYlk0S3M5?=
 =?utf-8?B?U3ZnS1RVUVd3ekNib05tc25XRE91eGRRTjhON1BnckdxNU50U2ZLY2hLc1Nn?=
 =?utf-8?B?M3FnNjFRTnpxTDNJalV1OHBBVGorNzZKRWZLaU5RVzZmUFA4ZTJoOUZQTFhJ?=
 =?utf-8?B?Slg4R0x4a3duNzQrZ0o3VXVYc2lYNWZlK2FxOFJGanFRYjNxckVta2Fya29n?=
 =?utf-8?B?K2g0TnZNUWZlalFQZjFHOStJamRkbUoxWDJtTDZnTnl0VnVuRGZkbnJMV1Vi?=
 =?utf-8?B?NFFlV2hGbEpDME8xSC9WNmlXWkFZdUU1SHhLRzdGTC9UNUpKL1kza0xqM3pF?=
 =?utf-8?B?WnVRby80Zng4c09QSFpQWldSb0N3OTh1QVVvRXFFR2FFeVc2NWROUzBPQnAw?=
 =?utf-8?B?Y2dUOE51Mk9JYWFteTZEYkZKTGdqajR6aE13aVhLcTZNOW51VTdzRzh5VVZ6?=
 =?utf-8?B?cVNBNGw5NXZiWFRRT1kxbDVQY0FHQ0orQi9ncFJmZDdsZXpLa29kUFBXTE1a?=
 =?utf-8?B?TTNvdGkycjFRcEFLSTY1UmNrdWVNdFhidFdPUzhKWlJnbFJhVXBvUWhPMGVr?=
 =?utf-8?B?bjdoUWlNVHpUWGhPTk8zTGlpbkx4ZW5vNDlGd3B4Q05PbWxmNEdoeW0zNk5N?=
 =?utf-8?B?MFNnUE5PZ1RPcnA3UVVhL1BrMWFFb0xjOCtpajlBc2pERUVWU29neXVrcjc4?=
 =?utf-8?B?UUZ1MnNpZlhxem5KT0VFcUxCMlBKcmp3bkJoUGUrOWpKSWR2eDBKWDlEbCsr?=
 =?utf-8?B?NjZ5TWxUQkFFK1ovR3pYYTFFWXFNc1dEeG5uVE50SnJmTEM2NWVubkJPN29Q?=
 =?utf-8?B?RjJJSVQ3Y2tKWVNoWlM5WTRza09aUS85VUNaWmRiWkFDTFEvNHZDa2JuRlAr?=
 =?utf-8?B?enUwQ0d3aWR5eWJOdzFVNTAzaUw0Y1cxVG9JVEpKak0yWVhzWThKMDlUVFo4?=
 =?utf-8?B?Tk1LSkRvVGdSL2c3bGtxTjh2b2EyTkNQQW04Q1FUUWI0L0lJTk0reEl1L0xL?=
 =?utf-8?B?ZUNCWVFjZXNaMXROemVJUHcvWm9LQlY3YWRSU2NaK3NsR1ZHOXFVRmRKK1lH?=
 =?utf-8?B?WjRiRTJUeVlTMGNneEwzNEIvT0RKa2xaaHdCZnRYR1R1dmtiWHJsREEzN0Ja?=
 =?utf-8?B?TUovamRXa1U3akFHSWluWjFpMWtIY240MkszQUVhOUxjQ3pTVTNRS3dvTFlH?=
 =?utf-8?B?NElJQjlzYjk5VWphanRKSkVlRE5TSlpaN3FyL1lnWDN3cG5BblNlSUV2Nk83?=
 =?utf-8?B?NVEwYWZ0bTJLQ0FCc3RHbkZzeXExRExTMVd6QU9vTHVjaVJyOWFxRTNKRUdI?=
 =?utf-8?B?cmZEZS9CeEZobThodnlIcGVLbkx5SlhWYUE4OW0wSTRybTB2UE1sdmU0YlJV?=
 =?utf-8?B?V1FUT3VmWlZhSVROZ041WHEwMkdxTFBrUkVHQUJISE11cVRmN3dZN0dObFhp?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b18aa5-92bc-4443-a7dd-08dba896a029
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 13:48:29.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UA0nF/tU71CsUcbBKKqn+xjh66tRUnzFWqQxuJhq5GjqhnC4YKec0wd01AVlwRG94Jy0HKQdTRHxmynLWkshTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5389

On 29.08.23 13:39, Bezdeka, Florian (T CED SES-DE) wrote:
> On Tue, 2023-08-29 at 13:04 +0200, Florian Bezdeka wrote:
>> On Tue, 2023-08-29 at 11:40 +0200, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Some stable kernels gained this helper meanwhile as well.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>> index ea7ed3ad56..a533d46690 100644
>>> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>> @@ -54,7 +54,13 @@
>>>  #define close_fd(__ufd)	__close_fd(current->files, __ufd)
>>>  #endif
>>>  
>>> -#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
>>> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
>>> +     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) && \
>>> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0) || \
>>> +     LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) && \
>>> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(4,19,0) || \
>>> +     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))
>>
>> This is still broken. I have a 5.4.253 kernel here which already
>> provides eth_hw_addr_set. 
>>
>> LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0) is true for that kernel.
> 
> I'm testing with
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
>     ( \
>     LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
>     (LINUX_VERSION_CODE >= KERNEL_VERSION(5,10,0) && LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) || \
>     (LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0) && LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) || \
>     (LINUX_VERSION_CODE >= KERNEL_VERSION(4,19,0) && LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291)) \
>     )
> 
> right now. Would need proper formatting of course.
> 

Wouldn't that work as well?

#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) && \
    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0) || \
     LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) && \
    (LINUX_VERSION_CODE >= KERNEL_VERSION(4,20,0) || \
     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))
...

Jan

-- 
Siemens AG, Technology
Linux Expert Center

