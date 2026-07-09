Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498739657D
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615011; cv=fail; b=mT8emVEaZJory2BVBemnq4xt3qZc3toBmx+zhZfIxRm3j6iD9M+DuujU4a7kmjyEvgS21Zx6LgLUgODSrZYIwMe4yWzKEuum015nL+zUrlkZ9xIcpzO2XhxkvEVT4exIqmDWhcwzqA07zOgipZlGclYN7nFKXmL20pAIpMbIQKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615011; c=relaxed/simple;
	bh=yHCRwrX8YUcwCN18WeQxIgGxqlFwM8j1XsTodpqUb/I=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S7zQ9CKq1EqFUj4E0d+nfyNcby/F8r0yVORe0bafifdWg3c+f0uSsLWZj3+LbS2U26ymLcV07H/vRjs1SMWUUTBf8okC/7OhTzqAku2YM5MBQI5cb9VKzRR9j2kMqKFFGxEF24Qb101m4k8XO+6r69WjltJi7oPUFQwoTvZ5vEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CjnJRXW8; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CjnJRXW8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9MxQuW76MW6MB26TYTVVFiOqc3Oc/vQy/V0EgFoKmDqomgjeEBkh372SyxZj8DlABJdg0jrKCUFJEX2eW8I13x7UbZs9FwR7WKqgqQbHiLMjQfkesEJD+TS7rxAxWqKvG6W8TB81wuJiGJOCkuVcxsZsVBZ5SxC/FQyPy5MbURWOsYlKKlw24FHY8BLmlFvN/1vxR08kWQmKJndRqxm/lgQOnRBwffInCu4IXPE8IbrGWTj2W3OGpZhdzEz5PKA5nIgEdRwgRljY/byKLX6+sojGQup4qf8lqxBzVfQ3cZchGJi7Y35lINSXDlCImQ5cDllJW64Iy9c7k6dBPqaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkfhRPk1tjX9OXvMzPjULA3XtjeDCOMeeuDtBZ2WtHU=;
 b=OsA/5h3ZRrW82CgBTpnmA3Ufn7lDfOvn9aX/SVRjcn297ZQ0JM4jQD+rPvj8aGOk0fKsiQamxkLq1yJ9/69tU63UpoCKgVFUOH0VqdLpHjVBhqt+R605nGHdr271t+zDuMBH/hIdiL6YFEFWl7UCtgwyV1APnbrIWncR3QWNQt+RVBmnmmw3zfhK9cT/N+kJMhumRp6gePWdNGa9huDa54ESSjT3F4720GAbtWQzjtE9a+Vk0WiOp6JsTiU79mngsFjbvL7fI4T/cPa2YLKef2ds8SKZn202ggWdSc4DiThzmlVblFJvgOrqLBLSvUiDlAJbtZenOD8qUBsR9iZKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkfhRPk1tjX9OXvMzPjULA3XtjeDCOMeeuDtBZ2WtHU=;
 b=CjnJRXW8I5R5VQbz2ZzvZwUJ0N74eIPaGayum2IfwDvSexDwC15NCVVQSJtOJ3enABGdgd9DNQCQsP3DWbyFfICqTJRpM2W1NzXKla+wv8WxaMhY8YYjFfRJ9LPEAjMpwA2T9L29ob5NQsxvLP0B++Ew4bX8OJy9ba5zJhvGNregvMeyDl6th/gK+PaPFnR5CELI/09vvSZwF8lybkf8V+f1oXKb45k+s7eb3k/fqfE10sCZ97CDyXjQvEPbnr4aJTdkIHskMsznPePSeOo7NjqCK7uM7iZe2LEYMybwBSoxszGZZnceOsfFjq9Ob31H/sgc+JM0d68g/nUEN40HpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:204::20)
 by DU4PR10MB8544.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:567::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 16:36:47 +0000
Received: from PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cb59:4914:5780:9cbe]) by PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cb59:4914:5780:9cbe%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 16:36:47 +0000
Message-ID: <c208544f-f9c5-4f54-972a-cc7256fd2095@siemens.com>
Date: Thu, 9 Jul 2026 18:36:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH libevl v2] build: add initial RISC-V support
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260709134451.325524-1-tobias.schaffner@siemens.com>
 <2dcc2289d120ec592539490954f262732f4966b7.camel@siemens.com>
 <bd53dc18-eef7-41ca-bea8-a5e97fb91207@siemens.com>
Content-Language: en-US
In-Reply-To: <bd53dc18-eef7-41ca-bea8-a5e97fb91207@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::11) To PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:204::20)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4977:EE_|DU4PR10MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 18832b4b-027c-44f9-2d23-08deddd844bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|18002099003|4143699003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IEJSOK4WFVy508s89oEmYpWSL/DWUEkA/3heTLTke3OF6Uq5zwAshIWidZ7Qzct78mw95ltXnstvUTSggOxRub+2F4g9w/CnciHYT3OPqa0asYWRmeNN0D2/s1jLX780WtE5xbXSWYWOh2prF66ksqP5MZB/3ouWoOrM+X1WEffbaS/nidNdfZ3PeeiMMA/craio4ExPIEvldDVXXrM3FlOQHSjnHueZYmuK4XxBE788+09k7S3sR5Mg15qZ6OZoMivpPt629YgsVlvFBVTeW+54+o+XdcWT+cZ5xrDGIuNtpXF5OXdHfGodCEVLY1u/QX+ttuUxzur8qkYqvXsyehza+uMoaici222wV3j47RByZytP04T/EuFR7ovMkmaseWzWHKGdRIhPszNPIogAkgRzE5KAdcFY4etpw0WyiEPBOEQe0JoJBDLCm6VnkyXFBgUnJOrjT1nszMQ5mzXHveVSE8WDYkO0z/cepq/aY1jaE9g79blYruUnholEJ3epT1rCfGhWD66TEl5CBG75YxmxYBvCn9pbOb8A0cWuJWk/ntbl5Q9oohkwT5eFdm6EFQmIxyP2OiqUdHtpLnYSQJXVPGq0YnhdyQZbFt/BS7EDQO8/h/R+zTi/3dtDxOMu+fOjiyFr7Xl9Y4C+2I2nP+mRSomTb+VzgaWEQZhne7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(4143699003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGgxTnVJam9ycmc1dm9IWXhHMDRyVktobDhTZndTYjlNdjVMclFNOHVpaU5G?=
 =?utf-8?B?b0pscmJYbGw1T1hvYWVTb2xZc1FTZVpaN2QzQStwVVdrMGtyTnFVeTgycEZj?=
 =?utf-8?B?T3ZkTUNlVHNRcGVwbDJwanNrSWdtTVVRMGRCbkNVbHFUczA3aHBTeDhXTHEy?=
 =?utf-8?B?VUlkSVhuRUhLSmdQK3AxNytEem9MMldlRXRjMFlMV2pZM05JVllTaEUwUm1W?=
 =?utf-8?B?S2dDVXBWTkt2SlhGZllyZ3Q4TGV5NDVaQTZRcThQUVVoZTZobnFTSEExRGVz?=
 =?utf-8?B?VGVTZHNxR3VrZXBEUHVzWHJST003MWR0MDc0SnlxVHBKMmdlTE53dG9EVzha?=
 =?utf-8?B?RmJTci9Cc05MUHMvNU5TTDJ6MFVTRFlMT0ZMYm1xblY5KzRrRjRpM0RhWFBH?=
 =?utf-8?B?dEIrNHpDeDEzRmt3SDJhKzVubVZLT3dVZzVrTG9hd3JGMnpkMm96OVdHYWpa?=
 =?utf-8?B?bFhYUlVrK1pUQUlVSmQvbFBzRDh3VGtncXAyRkxGeElYTnk4czcySWxKVmtj?=
 =?utf-8?B?Qk43NVBldXg1SzMydm4rbWRjYUhWZU5HTFlBYjJGWUdRVGY4T0VNVnRHNFNm?=
 =?utf-8?B?Z05zUmR1TUJRemYrUndaYnduRnZwaCtKS2JOenJ5am03Q0lTc3pKY2N5aG9w?=
 =?utf-8?B?QmVGRmZmZDhLdWtVQWN4am5qb20zTWtXYmQwY0cwcDlHRmNSdnI5dnN5RjAw?=
 =?utf-8?B?S1lTRE9jMERZZEcyT09ON2FxZ0lJM2M3bkdYdm5uL2hmNkhuTHJMbmhUOVRF?=
 =?utf-8?B?cWY4cXc5YTBTbTVBRzA2VndMZDlDdVBpN1h1MERvQVpmQnZkNE1PKzI0Ymg1?=
 =?utf-8?B?RllwRGFJcnhoajdjK05VQTQzYlhCS1kxeUE0aXJ6dTA0dDFoTm5mc0ptTCtQ?=
 =?utf-8?B?VUZKeEtXRTRZK2d0clJ4UWkyMTdBdVZ5Wko3a1dUNUxYbkpHbUpuaE9aQW1w?=
 =?utf-8?B?Z2hOKzFUcXZKK0o1dEtRMCtVdWN3Sy9LVHRXRG4ybTh2MlFUeTNYQzdrR1p5?=
 =?utf-8?B?WGFRMzBaYS90RUtSRlFwZGd3UW41V0YvMGo5RDVGekVIUjFhRWdNcjFsOTVK?=
 =?utf-8?B?eHI3MjZUeWNkeE9LTGdZaXFnS1VUNVJEMDZsOGFSOW10QkJ3bnhxeFFuRnE2?=
 =?utf-8?B?a29zeWJnNFR4ZVRnbFU0ZHRtUEd6VFUrMDErcVlVd25KdXBOdWY0L2h4Y3dl?=
 =?utf-8?B?MVY2TUUvQ3FPdU9UemxOK084WkF6UG1NRHNLSnZzZTJDa3FJeVNVQVlRaytG?=
 =?utf-8?B?bWM1RDhaaUdiWkdPT04wdTFKQnh2V05vVk82VVdxSHllM0NCa0hYTmRoa1hE?=
 =?utf-8?B?QjY4OE5lNGtjUU9rRUVreTFGVG80aEgyVHhDOHU3ek5QdFBYZ1YzazF0WDkv?=
 =?utf-8?B?T2VhcWZiRS81MUdEb3Z0OUhvaE9UczBuQTFmVWRhVlVYeEpxTkhoUi83ZTBV?=
 =?utf-8?B?Tmh6bGRkdHFabm14MHBBL3A4ZkZBU0w0R0JKOUU4K0M1VW14cVRoa1RzTnYr?=
 =?utf-8?B?WEVIZTF6ZGlTL2hRbjYxeFlHRDB6S2ZndHpsYVE5czhLd080eThUdHp6Z0Na?=
 =?utf-8?B?b1h2bXdQWEtHOGNCR3V0TGR0NDlvN0g4cXd3UStma3puTXI2YzZSZld5SHQ3?=
 =?utf-8?B?NjZTWTNTVU9zRnF1Z3FzMWhGRkFTOXB6Nzd2Q0ttaWo0QWp0RHFTQklOVzdj?=
 =?utf-8?B?VklVcFRrbjVPRVZzenhXQmdsZGtWaVJvRzFOOFBWRDFXWjYwclNvVjlDVlZw?=
 =?utf-8?B?S1RUNVMzbmVsUGxFL0Q5UEhLYlZZU3ExNEhsUXcvSUNRd01MVUg1eExrTjdj?=
 =?utf-8?B?UjV5QTBEemNKa2JIcHlTTjkxTWI4VXprQThJNGhnTDlZWnNEMHZHNE1NbmF6?=
 =?utf-8?B?QzhYSkp6VldBSHdhVXQxQWd5ZHRIMGlVZDJER0IwMG1NaDNUejl3WnJiN0U2?=
 =?utf-8?B?U2t4eU85SklBaU9nbUo2M2RTcDhmVytvRmt5SUE1QXdoOU55OHRxZWpXTjVR?=
 =?utf-8?B?N1pNeERJSUF2UzdlRTAwaEk3R3NTQVpaSzZBSzZVQ2l2VDJpUHpqVzRIN3pX?=
 =?utf-8?B?S0UvZVBjQzFYZEkyMTFwZmlySmhoVERwTHRaUng1RXh6MnBlY1BWTFNmYWx1?=
 =?utf-8?B?QmlET28xNG8rTHU1aXAzSjhIUXpZR2wzemc1OGFvM0FCL0ZOUUw1alBLMXhl?=
 =?utf-8?B?NnFDVFBZbmFjeWlYMy9aUExiTDhSM0Vlb2l1TWR6TWh0WnlkTDlpM3c3YXdJ?=
 =?utf-8?B?TzdSSnlHWU9kdVdMLzY3TnROWEdNOEl3RXRTaGlxZVA0aUU2Y0VseWxDZDMz?=
 =?utf-8?B?VXNBZjA1WUNOZ0tMYjRXeVQ5T21aV0lrOEpyZGkrSVV4cmhGYnV5RWE5anVN?=
 =?utf-8?Q?2fnpsKB4vWLlZUsM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18832b4b-027c-44f9-2d23-08deddd844bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 16:36:46.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSJhPp04TpoEhV6l6LSjKYexwbewtTfA+zpG5V10f9KBaQVNM/eWH7TB5pMFJ44BiqawgcWimi69DF8u0Tofu1gtOuuST8RkNfqzofKvNyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8544

Click on a legend element to toggle display of that core, ctrl-click inverts display, shift-click enables all.

Data to construct the above plot have been generated using the RT test utility cyclictest.
Unexpectedly long latencies may be caused by SMIs
Total number of samples: 100 million
Resolution of latency scale: normal
Duration: 5 hours, 33 minutes, lowest P state: performance

On 7/9/26 17:32, Tobias Schaffner wrote:
> 
> 
> On 7/9/26 17:17, Florian Bezdeka wrote:
>> On Thu, 2026-07-09 at 15:44 +0200, Tobias Schaffner wrote:
>>> Provide the basic build infrastructure and VDSO definitions
>>> required to build libevl on RISC-V.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>   lib/arch/riscv/include/asm/evl/vdso.h | 14 ++++++++++++++
>>>   meson.build                           |  4 ++++
>>>   meson/riscv64-linux-gnu               | 17 +++++++++++++++++
>>>   3 files changed, 35 insertions(+)
>>>   create mode 100644 lib/arch/riscv/include/asm/evl/vdso.h
>>>   create mode 100644 meson/riscv64-linux-gnu
>>>
>>> diff --git a/lib/arch/riscv/include/asm/evl/vdso.h b/lib/arch/riscv/ 
>>> include/asm/evl/vdso.h
>>> new file mode 100644
>>> index 0000000..5e331fb
>>> --- /dev/null
>>> +++ b/lib/arch/riscv/include/asm/evl/vdso.h
>>> @@ -0,0 +1,14 @@
>>> +/*
>>> + * SPDX-License-Identifier: MIT
>>> + *
>>> + * Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
>>> + */
>>
>> ^^ Copy paste mistake? At least wrong year...

Click on a legend element to toggle display of that core, ctrl-click inverts display, shift-click enables all.

Data to construct the above plot have been generated using the RT test utility cyclictest.
Unexpectedly long latencies may be caused by SMIs
Total number of samples: 100 million
Resolution of latency scale: normal
Duration: 5 hours, 33 minutes, lowest P state: performance

> Shanmu directly copied this from one of the other vdso header files 
> without modifications to the copyright header and I did not touch it 
> further.
> 
> Would leaf it as is if it is ok for you even if the ifdef was slightly 
> changed.
> 
> Best,
> Tobias
> 
>>
> 
> 

