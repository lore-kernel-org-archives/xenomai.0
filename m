Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3A18C0A
	for <xenomai@lists.linux.dev>; Thu, 19 Oct 2023 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hYfW2Ti/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnA1fpb6W6vXxOgkVaTRqjGwyHPAfVMqhuInpPKSJxqnBx+89L1zW5atj1R/LEE8mMbwrr0LgJfvPKlLHgXshL1VgXxIuNnwdFQPrW19/sp3AohKb5uuJTzOv5P56IptpJN462d8NT8LnBaOWS6jeYQjDU7mpwD85EdXrDT1btOmrxHKTqxXX3tBjBGnyagyICniY3cwbAsYejJ6volBGFvGq6SYwHCovhiVzzA6b/uQxk3C8v21yuPAP14JcfQV7iH5NE+CA+nfSjW83NSD03kDArP16+HsYzzFqN52CYg4GsqiM8n0NG8vQUzs4GIcWhDWKrELh+gY3iOjOmzYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHp4RrhS+L81DHeTYu5cgkyHeiX2Hc+/QsuqMuZpf8w=;
 b=LslHWjWAGh7H5MnUhIW9vrasvlbuzRo2Wy+Y1AaDbxCyydRB97prCj6QQyNdlyVWvBjljaXtNPOP8dB8qAXm6o22dviqel6ir9GrZABxmYvoK2Bay/ZwEgoz1DgQdIeV7fGGivJpfe5Ew9afotL8kOQam/l5ThuICWvsIq2cEXuOkqiNP5OIPJF1go9QYabXc5xJFEjGtPoEAUaPLhko7nDWss3SLlAWJ+JlkimgUngpH1IPtsnb7s9JqhlAjJ2iwvWticprbiqpf/bzKuwwbZ+/pBVHyXtrvDzLMBjvzOc6aqeM6oZUP63lRqve3SA3veUiXxU/aXnrAukCTuA/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHp4RrhS+L81DHeTYu5cgkyHeiX2Hc+/QsuqMuZpf8w=;
 b=hYfW2Ti/J9J9CuKcjw+hU2/oEGzEy+Ezr0bG0JcsnVEGmX6nEU0avCvLPaeykC8vSGmXSpKnWkDS5PZ8L5kACs7/lii6M0sauCl/hOoMUMvWZnlBXUfqPT5Ej6aM5ui7dUD61af6VQOpQ5rb/FD/CBu0qBF/9UegtNnSVX4w5wz1aM3CfAc0m4QXSnX19VIT+JSHiWdExW9mdNa4W5AAz3mcyt05+BlM4TdGVsrIP1NZdbozyhYYGXixCUk+idQQonQSdknQwWCTmnxpupKwM4UwgB5WwM9eAoAZYXybUCtD37biWLuHArjmTGlqRIudz7ZCm7l7MpMOR6VkyOFw8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4099.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 11:13:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 11:13:15 +0000
Message-ID: <fecbc420-0e64-49e9-8560-60a333a53935@siemens.com>
Date: Thu, 19 Oct 2023 13:13:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Cobalt kernel parameters
Content-Language: en-US
To: Prasanna Kannan <prasanna.kannan@ipg-automotive.com>
Cc: xenomai <xenomai@lists.linux.dev>
References: <2047000542.27707045.1697689065162.JavaMail.zimbra@ipg-automotive.com>
 <917e42af-545c-4439-bac4-78d1f9548931@siemens.com>
 <617630177.28605403.1697705869664.JavaMail.zimbra@ipg-automotive.com>
 <cf30fc77-0095-40bc-8fd9-a5c908dfb7ce@siemens.com>
 <1873992245.28780880.1697708309041.JavaMail.zimbra@ipg-automotive.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1873992245.28780880.1697708309041.JavaMail.zimbra@ipg-automotive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:610:4c::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: a44792f5-1cb8-4779-ab13-08dbd094642b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I1n6RF4OzXm9g7DZJGMMlLuhXf8hsc1LNQ6YcFBw5cDcZfav9YIWW72ikg/aYFS20vfSanOKPvq90tUqtMpggrFqrXndOLMP26OsgBC00JukoF6xfhX3eTkmiMZPVBDcmzO70UcHo/EzwEvr3bm4wxcnMjiFx/mSUh6fO9a8aOclHhdPHdrwVqg3apFlPynDjda83YWjj7XjNkL5Ou8/zEhYh/jov/v7U4WtSdEudmT460IJHFGwLcZKFiPOFMIHPOSQiVu3F9UrY3kVNjKmdc6aWHZ3kigJFzyEBdyrlZGrcOFQ2YLuWpaceGyHtAe0i7S4q55cNo3XERrWgciD/vc1gYNpzL4iGCfjfUJ7JDOYivGL5DYfIogR5s8QCDPMeo8M6K9+aKLEaIN6qSMDQoXf7V/WlVFqxZvttnQ80WGxSxFWOvuLls8VsYrt871Iz1uPuOi7EYYjyPKofEV/rmD94jdcG2pTm8Yd3vyhSYuzE6sIKW+H2ef0PL+Xrn+kw1qa/2elBf72k3m2hJ8bTvuhTir1kHiV2Ylt4VJ2z80t3znRILj//8cTIB0wSOsH1C0Z7hj5zPX9MRK2otg+7xiQzMKRr2faaNBurejDahIjA4kuudXBLjqNBcoaDSyDp8MgYUyR8NpGMh1/ZSiBnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(86362001)(3480700007)(38100700002)(6506007)(44832011)(36756003)(41300700001)(5660300002)(4326008)(7116003)(2906002)(31696002)(66574015)(83380400001)(6512007)(82960400001)(26005)(53546011)(2616005)(6666004)(8676002)(6486002)(478600001)(8936002)(66946007)(66476007)(316002)(6916009)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDY3VFNCNkNmWHo4c01pVWp4Q2NrcStmZGZUcFYxQmxpSG5BYldibnMwZXZD?=
 =?utf-8?B?MFR2MXZaVmxlSzREZUFROHRtK2J3aVpKRXg5NUVvR2d1bnJZc3BBN3NLeTJO?=
 =?utf-8?B?MkQrU1VPbzY0VUxEY0dpOXVBeU1ZWVdmZkRRUkR3ZzJ0aEhOdzdIb3lSTmxM?=
 =?utf-8?B?SHdpMFdRSWpLSjRJVkdqOWNPcVF5UmVMOHR4aVl1VHRmK2ViZ2t1WU1Fa1lv?=
 =?utf-8?B?MEVQQ3Aza3BDTVBGa2NwOUl5V0U2OHhlQ3NGY3c3R1FKNFlsajZDa2lyaERF?=
 =?utf-8?B?MlJ3bnMwYW5memx1VG5aUDQ2b1J2NXljb1FOMHNXN1M5SXhSZENTSS9VWk9v?=
 =?utf-8?B?UldPVFprQzI1eTBhc2VWZ2U5Tk53azY5TVFRQlRhaTdCRnAvczdiSXRNeGpT?=
 =?utf-8?B?bitNckVpckVRdzJaSDdoRitmZG1GRmpOaFNpazBHT0pGUzZUTFJKNWt3S0V1?=
 =?utf-8?B?TDBJZUFDT25ha1lKaGVOSVNVWUdldEI0d1FsVEk2a205NVVYYWVwNlNHSkhF?=
 =?utf-8?B?Qzl4TVhzbnQ3eXMwTmF6YjBuNFlkYXNRUTY4ZHY3MXM5TWorYVJGYU8zVzZx?=
 =?utf-8?B?bitPNXFKZW1Vajl1dTM3MExmTHdENTNnT0Q5MXUwaVBMM0VKdUdvSkpNNkE3?=
 =?utf-8?B?cDZqQkJCQWdGbStqbEVuSkdycEFRYThpZHlRYmU3QnhiYnNGVXJYYXlzbXlE?=
 =?utf-8?B?R3Vwc2ZKcngrQXlWWVUvV2EwRFdQZi8zYkszd2VOT21obFVabDgwcjRyLzh0?=
 =?utf-8?B?cXVENURLMUdlN2pzUUlNU3B0bnJkbGRvdkVYVm9hc1M5YnBIalJRQUR5VEk4?=
 =?utf-8?B?Wi8wVmVPNzFUM1g4eDZjVmkyN0x2elF4bUtRY2FHTk44SW5lbkVLd29wdTNG?=
 =?utf-8?B?c053YXBzV2hvL0ROemRFNnFJSW9SeUtHZ1BZV09lU2FOSDJiVzNzOGNtZmpR?=
 =?utf-8?B?NUNKMERoVW12b0FrTkZmdi9pL3dod28ydHJ1SEw4ZXN4bGRkeW9Qd1Q3dWRI?=
 =?utf-8?B?S052czhPUGZuNFZXdWkwQ1BNeUZIMnFJTmdXdHcwTDhrbDBqT01GYmVZaWRR?=
 =?utf-8?B?YWdLNEtKcGhZQ0M3OXpEZFh5UmpSWGhKNm82dlVZYVJmYW9qNTVqVFVLTk1J?=
 =?utf-8?B?WXRrdTlEdk9qZ2ZRYldWZU9tdXB3VFByUXlMNnZERDdWOCtQbDhvK0hJNG0x?=
 =?utf-8?B?THQ0ME5pWlRvTTJUL1Z6WGJ1RHJCRmlnSnFUMEN5VmxDZWtJWnNqQmljcitD?=
 =?utf-8?B?ZHZyVDZXN0NsZkpHK1dDT2VUeFpNbStzL2JUSTJwL0tienM3NVF6SmpYcmJZ?=
 =?utf-8?B?WEcvM3dtTVl6aGtQSHVWQkFYQTUvR09ScUpuazRjRUtycXVZcHdHSjdoVGJp?=
 =?utf-8?B?b215aGVKT2Foek1rWWY4UERETE84M3ViT2M0bmJjSTdDWU9UblVhV2FpV0Yx?=
 =?utf-8?B?VEtpUFJoWUxvdERQY0QyTllYTG5Fei9YTFdoa1pZRGVJUVA0YWx2aWkxck5T?=
 =?utf-8?B?cmJ6ZkcwQU5Td2hlNWgyNUNGejN3d3U2RWFRSTVzVW14SVIxQ1RORkxRTXhL?=
 =?utf-8?B?dWJhSXRkcW40bE1jS3NFaW91R0ZXMkRMYVBOSHVROHpYVWRlL2IwYlJEU3cz?=
 =?utf-8?B?cFJzcHZiU0RWQmZpN3RHT2hpbWxJSHdXZkpCTm9QUHZQSHE0Q2FmbHhoWXZY?=
 =?utf-8?B?eldmcDFRTWR4ejdOMkxOa0F2cEdPWVJpaUEwQVltQ3Y3VkNhVEswUVgxYStm?=
 =?utf-8?B?MlNVWFUrQUttTmo5TmUxL1ZUalp2MXdIeVdkcTcwWXQ2YjNpTGJDbHR0Zk5z?=
 =?utf-8?B?VG83T3NPcUYzcFZwTUh2WVpoZkxJQ0hrR0FtTjh3V0tyNlFoVWVkRUF3VW44?=
 =?utf-8?B?dW9xcWtxSldpL1BmQ3FKS2Iybis0aUsza1hDbFliZjllbzhmTFVDcmFYS0dS?=
 =?utf-8?B?MG9DZzdORnp1OVBKYVE4RXVlSi9XUng1ZEVSY2FESDRXUjNqaDZkUlNKSVNq?=
 =?utf-8?B?WGpaYitwYkFmMCtzajZLQjdZUCtVK1cxVktheS9xZHlXR2xDdUduZHc4cFE4?=
 =?utf-8?B?aXdnbVBBSk5JdmZlYVZaMzlEdGlabEh4RDg5SkNDYmtDQlBLakluS2NTRmg1?=
 =?utf-8?B?QnR6ZWJwdVdJcTdVYVVlNW1DUE10WjFkbjY0Y0tUWkhzN1M5SzVZRkVVMzdI?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44792f5-1cb8-4779-ab13-08dbd094642b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 11:13:15.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53Glotwb7UKHqfZVaH98L1z0BhDU+ADSNR1UydZLr+UNk7QuWRxxKnKial58K0BTBBXmA4dRncGD5lkRVSaeZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4099

On 19.10.23 11:38, Prasanna Kannan wrote:
> Does this mean , if CLOCK_REALTIME is  is synchronized  with  PTP, 
> Xenomai clock is also is also indirectly PTP synchronized?

Yes, in theory. As we have no yet collected practical experiences where
this just works and where there might be still some devil in the
details, I personally would not say at this point "also in practice".
But I would be curious to learn about experiments, potential problems or
possibly even successful field deployment.

Jan

> 
> Best Regards
> Prasanna
> 
> 
> ----- Ursprüngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> An: "Prasanna Kannan" <prasanna.kannan@ipg-automotive.com>, "xenomai" <xenomai@lists.linux.dev>
> Gesendet: Donnerstag, 19. Oktober 2023 11:04:03
> Betreff: Re: Cobalt kernel parameters
> 
> On 19.10.23 10:57, Prasanna Kannan wrote:
>> Thanks for explanation. 
>> Does Xenomai 3.2 sync with the Linux clock only on start or is there a possiblity to also force the sync during run-time?
> 
> Xenomai uses that clock source all the time, no need for sync'ing. Be
> aware, though, that changes to CLOCK_REALTIME will now also affect
> Xenomai tasks & timers.
> 
> Jan
> 
>>
>> Best Regards
>> Prasanna
>> ----- Ursprüngliche Mail -----
>> Von: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;
>> An: Prasanna Kannan &lt;prasanna.kannan@ipg-automotive.com&gt;, xenomai@lists.linux.dev
>> Gesendet: Thu, 19 Oct 2023 06:43:40 +0200 (CEST)
>> Betreff: Re: Cobalt kernel parameters
>>
>> On 19.10.23 06:17, Prasanna Kannan wrote:
>> &gt; Hello,
>> &gt; 
>> &gt; I’m currently using Xenomai 3.2.2, and here passing the kernel parameter “xenomai.clockfreq” doesn’t seem to have any effect.
>> &gt; In Xenomai 3.1 I was able to successfully use this parameters. Is this parameter still valid with Xenomai 3.2.2, 
>> &gt; if not are there any suitable alternatives?
>> &gt; In the past I also used to check the clockfreq registered by Xenomai using /sys/module/xenomai/parameters/clockfreq. 
>> &gt; Somehow this is also missing in 3.2.2. I am thankful for any pointers here.
>> &gt; 
>>
>> This parameter was obsoleted by the switch to dovetail kernel patches:
>> Xenomai is now using Linux and its vdso as clock source. This also means
>> there is no longer a need to calibrate some hardware clock itself in
>> Xenomai, therefore also no clockfreq parameter anymore.
>>
>> Jan
>>
> 

