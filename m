Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1E31D375
	for <xenomai@lists.linux.dev>; Mon, 24 Aug 2026 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571297; cv=fail; b=vEV87NfbgrY3h22tIWLpPU7tMPwU7T8GuYcvSz1/tB/xBFP+pBIH+bBY1IN93LXcjkuOEd9lfujuqOA+oTafSILMRGwXLfk0Z4GnLMpjWDseQVpb4vMXDsUYyXKl6CYSD2VsYdyK2Xvu271OVHplBW5wa5L6WwfvLSVRBYoh3ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571297; c=relaxed/simple;
	bh=zfuseDdSDceAtIhtrMfvEHN47rAS0mlgfqe22iVFnJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NCwTX9w2DSIBl6FF5LR+toRQRGo1BtGtUQ3K/v42Tgxh5bcO70uNtGnYZ7N4RsHX545C1tKoLO91Yo+DUuYbsCrY9asfgSEz1e1L5+GraYzlUbHY9dWU17+ID8VSxW3b2A0KWj+/9AP8YRJ7g6v+krru7zANuDQ+C0TIMt6n5Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tJxTYx8N; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tJxTYx8N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlWyt362uiMWdBCDFuwGoqbgVU4lSfRxqPJRmiEhUDQKxNiGhIun1sGXFPeAh3Ku6lPFnc6+FLCuCyZcMwbh3AWu0kr/+XsGoDInif03woCQZakJA+6A+xFRrqYeD22QYKNp2Tj4O2/L2OI1cGEShPuG+itMgyOgAIROmOaCdiqoGMbuzX47+o2e5RnY/ZRU0bYsphLIXh++5oIlIKwXR3oloj/H9YgjdN3R0cYwWWUo7iUCoesGbAAHqy7JYTlW53Y0N4uWCRU2zLUPPPErGfk1VrkuP8PGPmVGrXWfrhGPyYVvz19AHBX8lC6L6jvogjbNpuqzSSmDz7WUC3OOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxMBQ0gNEoj6/IwfC22MU6pfBYE5fZaOYrbDhQSYHEU=;
 b=axrqOU4PnHhVFt5IFuz5+SPIzT//tb88SgBbqI3O1CrLtGchPYOrF5GOIALDq5n6QFYpx0xr7bDYq5y2xN/tHPiNmQcQOOthTV1qLy3RpAm6CxfdfBIwsf3MlfB19wBE/+H1icQK/K/R+bLHWD0t2euHTCiqZdfPrfFT4aS+9ZHLPzmyaD9xJFXXZKeiJ2O7BsSpX2Lhq1t8y0IP4QK/UG8GUZw4NDGQcVBPAhSg13S0ouzSp2B+ulJ1fny80kEcQfeKlDvy9TobstmOkit7D3zX2vp44VVQIXy8vGsf7/RWVaKWZKewLxymCvEoLs8PkI7zukMBwoectCNDQOlhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxMBQ0gNEoj6/IwfC22MU6pfBYE5fZaOYrbDhQSYHEU=;
 b=tJxTYx8NewZ7FWURXtmvtgjFFwXb4hBgaBBH+p6R82mm1K9UQW1mpJSyqbFoE9tQ39Ex0C11klKpKZtmslgsbgI+kCouswfMpgkDzVkiiVez/oJnwa8xbuS6XLWuxBeOXVszdwznXjb6iBGpW7TptJ4Qjbhz5vzmYb3bDGriZJ5UrajuJs9I5XfpPz5DBY6vmhRmZ+8qQ6UErIEk4YsKW3y3cBuAMGjL2xUeSrauqgaPQEWlo7I/4FZKb/ysVTrrvsu/BOskAGKFIu6j7/P4Rfi1i3a8Csmjty2uanZ6Y3uI0Wt0iPCMtabZIHa5EvLqCv65ELlKvTKFoPni7MEYfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6574.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 11:34:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 11:34:51 +0000
Message-ID: <f8f380f5-49c2-4a3d-9095-06d985d005a5@siemens.com>
Date: Mon, 24 Aug 2026 13:34:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Richard Weinberger <richard@nod.at>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com>
 <87bjefs6cw.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
 <a006030cc98da209b4764b5117c41d93fa3d9399.camel@siemens.com>
 <535f40eb-3af9-427e-85db-2afaf69b847e@siemens.com>
 <87h5nvl5ct.fsf@xenomai.org>
 <2894b9cf-09c9-44ab-945d-cb3edbe5fd60@siemens.com>
 <CAFLxGvwSE28X_PG2NsyhnFxq5SGjrS3WH9bhJcX4gyrroV2z1A@mail.gmail.com>
 <d8c7650d-d0cb-4fda-8664-177adec000d8@siemens.com>
 <CAFLxGvxXvMq5THr1i7u5AFUu2SB=HgBA7rikBMM=Fa0nskz8UQ@mail.gmail.com>
 <796829a8-f7f4-443b-8995-930ca11c7e6e@siemens.com>
 <CAFLxGvxLFfBwwxxxzQsWb-+jksttFHk4iX=hgnhpYRWWTr9nqQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvxLFfBwwxxxzQsWb-+jksttFHk4iX=hgnhpYRWWTr9nqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d827fc-234b-44e0-0459-08df01d3b61d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	AXkq2ZFI3N9eDeQ5GehjnCqRqC3Jy3wiXiDPVv9TEzV9iTqW0Om5sHr0OCGLXMENIfn2wbB20bSq02BFNjuTYGZIfwxUHOpvp3qS3ZyQU+lr89qB3r/y+sZz+sk8+0RvSTEEfntQAiJnOuWhHah0KYOhQ12lpaCZAeDCgNUZlItI3bLmzZ1vCBiJKSAfVLNh+PibW+KaWXoFP94CHJOM2oVELo6WHowpizC87wDh/eXBGxFKqWmJ1izl1kDF/LgmsEkh6zddFV5vqOq039JQzH9X0Zw7OC5YEvK8UCrDO4HZ5Yg9BwzGbMqur0J4SiEEidDV1MvYOTxnLnM6VWCsiEO5zeGKWSDgnmoaYn2A7sZuWnjpKc6Wyp6CplIqBoVsrbNhhZTyq8TmxrOaQ3lRIK+VJN4a/yJlzeu1PTzkr9iGLjMslanuGDMVfNlWsdY/c+AKfLkwjpXF4N0StOsfk/JCpS30gNFZPbQEAHGdVmktwVNzWtuezrIgiJMqYd0e3TxXaDF+GDNXBK8+FHxBNOrUQOo7pdTAPEYP0TBRcX+UKZ/dMLJf6JbsLHortgw5vZayDT9+EBMFZ3yCaWCr2j2E+9UKJD9R4AFSMQJApIk2E3+AdGKC66CPIPRNJ4zTxU5cqgLXqElEAZmBLLzW2rwINs26RdOStroZm0gSF/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGpyQUtRSFNxY0Y1VXhqRElIWDdQc0hEUDFXaHg1bXZpUHhSQWg1UFFuV0Yr?=
 =?utf-8?B?WHI4R2dQL0VHdTdaQTZHM3NNbmw4UWYzdlUyeXVubzZySEtGTTBEeWtBSXVJ?=
 =?utf-8?B?dDhHVTJrd1ZKdXFjb0Q1VklYN09ja0hPTlV3K2VzWVk0SjA2QzFRWFRpeGFF?=
 =?utf-8?B?Y3BOOHV0TlppMEcwK1pOcXdPbUNKRzlFV3hiUURGUXZ4dnhQRnhWR0wrRUxU?=
 =?utf-8?B?OFR3MVFMYTZldldmaW1oZ29yTStCWGdmdEdMZW9YNjhKQ0VtSU1uY0VRK0Q2?=
 =?utf-8?B?Z29zajZEdk8rTjgzWGNHNTlhZUJDNUhSRk0vNVFSQ3R1Si92dkswS3pJallR?=
 =?utf-8?B?cmhJOENEQ3pIcFpHQWYzTE5Bc2xxNVBzdTJkUlQ1SjZYcXo5QmIzb2NteHNN?=
 =?utf-8?B?QUZzOHJUYk5jeG1wY0xnQTM1UElNOGZtSnphMkdIdFFveENFaHlKaXZuczF2?=
 =?utf-8?B?VmNCNzA3ZXlTaTBpMnVsemVvL1gxemVnVHpETFdnc3plc0JZMG01NzliVDRD?=
 =?utf-8?B?Vm9HOXUyaXBGZWE5SEJYdEgvMVZINHV1WnJydyt0WVFpUE8xRWJrb2ZVeCtE?=
 =?utf-8?B?OTZXRnIzM0tob1NqWmdZVTB4WXRFYU94R254R2poV2J4MTB4eDQ4RzZRQUtT?=
 =?utf-8?B?d3RYUTdKWDZIKyt4YzYwNG03dkt1WXUyaEQxdU13dVZkOHNSYW5kYUw4cGNQ?=
 =?utf-8?B?MzU5dlRNNmY5TmNBV0hteUZMTXNxMExGdnl5NGtlQUlZNlExY09xUlRpWnFJ?=
 =?utf-8?B?TjFVWjNzNGZ4U3BpbjQzOGVpVXM0SEhvQTg5N2RxQS96MXowY24zSkJCT3BG?=
 =?utf-8?B?QkE4Ykw0SVZra1QvYjh2UmE1LzZ0UTJTazFnaHI4TDBSQjI4VTJJRlZjQUFX?=
 =?utf-8?B?aFMxZ0tjblM1cXg4cXV4cGRRV3g3Y2RmNGhhWGxVOUQ5a011cmNocXJMRE9j?=
 =?utf-8?B?dVluVWRtNWxSdzVmeGRWanNyQjVrQml0NU5wTVlybWt5YVJ2TDg3REgvLzRE?=
 =?utf-8?B?WVZ3VW1FNmZ3NzBvRG1yc3dMc0xNRUlOYklST1pTVmRaRUhFOUEzNzUrRE9K?=
 =?utf-8?B?SHMrWFFURmVBOXVNSHFjZnJuRlRVKzZjY1BEdThwVklvRzZIdmdkZFQ0cGFU?=
 =?utf-8?B?OUtnc3VMQkk4Z0Zob1RGK25xMHRESUNOOHVZQUxMTmNGVlVVREMrUjBMakV2?=
 =?utf-8?B?bWV0L09DTUM0Z09XdThKNDE4SWRxb0FUbUJOem9OcGp5TC9rMkxma0FvS3c1?=
 =?utf-8?B?V1FSU3dDQ29wL05VdDNUMkRNRG5IWlh4c2lXVzVucGRWWWY2Y0tUcFpRclRw?=
 =?utf-8?B?MnhRREtRKzIzUi9lUklRVFVxd0tiaHp6L2JuUllHN3hiSWlYOXMrQllETkZK?=
 =?utf-8?B?SmtPM25KWW9rWElXSlJIV2JLVHJOZDhTbjQ0N1ZCcWVpTVY2V2ZLOEc0djN2?=
 =?utf-8?B?UlNZbFJ2UktxRXdLL2J1c3NQZ0NSNkc0NnlZMlF0NGlhNVFRRGtMWFhYSE0x?=
 =?utf-8?B?MEwyYk9udXBkZjA1bUlUZDd2UkN2bW9tbVVnMTVid1c2enFrSU9DemtlMnFY?=
 =?utf-8?B?S1N4dUpkOURWQVZEZHRISVBlZGFHczFHVVovWW5jOGNuVlNiTlVrWThYY0tQ?=
 =?utf-8?B?bnJHeU9hUWJRM0ZYSDM2bTMrWnAybUNqK3ZtOEszT3RFS1NRdlVSb1FCRkRh?=
 =?utf-8?B?VDZxalFYRmdFL2pDWmg2ZHZqM25CNzRmNFdiTkdIcnpYcURVam5UWGJHZktj?=
 =?utf-8?B?bm9EY1p6VXB4eUh0SnZJbGtNTThOUGtWL2ZJRGpnZFlzV29zbzV1YUt5NnJM?=
 =?utf-8?B?UXNIVEJQRTFDSVI1WWJldnpiR3IyMFFoNVlLN3hwTm9ENzhiRE9XblJ0MVBH?=
 =?utf-8?B?bmE4S29QQW9CMVVSNFhab3QwbEk0OVpnVkxNOWx3azVwbjBCLzM5K3VEdmlz?=
 =?utf-8?B?VGNwbURsS0wyNDVBMEx5VEcvRGVWQ0FFSjVXdGV6cE0vbzAzNWFYcm5IS1pu?=
 =?utf-8?B?UXc0TUNPMkNEV1dtNDZHVG1VNTFiVU9WanRYeXFlbGFiTnJWS3k0d2JHR0tk?=
 =?utf-8?B?T1J6VjJXSmhVY2hwRzV3UUcrNTErT01rTGRXaEkvZnh0VGtaRk1mamg5VVRR?=
 =?utf-8?B?Zk9ldDc0RldUQ1lreXA2aUJkZGNpaEF2WU5mS2l2UzFRaDRxNEV5bjZPMHEx?=
 =?utf-8?B?MHMxc2xNdUxNWStYemVsRjlaY0h4QTBCbXJJSTV0c3ZkQ0hvTzJjLy9Fai9i?=
 =?utf-8?B?UHZQTXgzWnE2OGlFWC9MWG9DVW02bUYyOG03NURXK1pJTzZiY1hTRVZBNFlJ?=
 =?utf-8?B?YzUyR2FYNlBPRlk2cnZTc3BiYUVhT0dzdmpSYm9zdkVXcDk2cTZvZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d827fc-234b-44e0-0459-08df01d3b61d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 11:34:51.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/NznGPl0WRNjyEPX2gYHLc7YTRXXNfoxe5Glfnnmsbup8sPSk0dSrOgay3FIuTfkiMxW9Vnex70Vx3MYA9HPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6574

On 24.08.26 12:54, Richard Weinberger wrote:
> On Mon, Aug 24, 2026 at 12:43 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> Just to be sure, Xenomai offers no way to wait until a thread is
>>> finally suspended?
>>>
>>
>> Nope, it's fire-and-forget when you are targeting remote threads.
> 
> But the order of events is preserved?
> E.g. when doing suspend, resume, suspend, resume, I can assume the final
> resume will make it and the thread will not remain suspended?
> 

Given the race we currently have (in Xenomai 3), I would not subscribe
to that. But it is the goal for the fixes solution you can already
inspect in the EVL core.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
