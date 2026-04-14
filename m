Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCFE8F49
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182896; cv=fail; b=lJAJfGWh69Dc+Lw7UGQLNh9SFI62EcXePKj2h0MuBe1rbS8Z9Ab8jpHsreEbFsy19Gv96PcSNt8E1qWpGAhydkFYm1s1UnmOmLklCSShblCisa3Zf27NGzBqHkmBIsBm7NWoLj4N5Z8cvXUS8ra4fuv/pERXVHM9Ir8ytmLlgMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182896; c=relaxed/simple;
	bh=onzzAo5Tp3lJs3jqMeBUZhnuOlkpiMz24/Y9ErWaLRM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UEjMuiBTHXl/SQMn/AySnc5Ekt7z/SL9h7Q6/Lst3RHr1ioxTKPgL1eWm9xd57O0R60Jz5IkZet56HWq3WzutIz2B1ZVPWR5ZE6MPFvhnqsy21W4luWqpm8xHnd1OyTpLrFq9YY5rzD2fbkaTARJdnAPpOwd/F2eMZYXbi280Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OK0CCXYl; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OK0CCXYl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwQfCUVLLkCHcZcMgpB8D3NAuBWcfL44PW5BS94lEtAjxHtMQw6D90FtbPxbRis249O+umi4bJaNGxMiAkNdJY/pg5/Dx+zNOxA6/th1KJVkcSpmc42Pi9318SzLUSjUjdTcOMx4P492RDGg0JcqrNNCGm4+K14dj5CYGZkXRst3FDCKMUH+ZkhuyMzk4egLf0EUuEVO3caatu2A8gQIRFagsAakX2urTJa0wRvGWmV/l1BP7UhxcXhG6ugMaHTQeRo3hNnQBKnCNmkWvFqtwm320YybVGsogiNYT5dpAiNFFx3/sp8Gnt/LkCTwdmTlV4G/aFvpikw+3kBJefE78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCYZkDsKOoS5RChynWuvA9+eVxtr2RyzOZF2DgP75no=;
 b=q7Siy+Y2cEJEZWqQEpuZ6jmWSlgXOousLvGlgiZp/XVGqqyRwCsXCOse3lo0DCmZ0u37jfzH/pcgMA6VvQJiPgSrb1fEdMGseCcMvMQBTlhHL383bzFnqR/yvzOoFzHNwg7/quboo9GoE7PvdlfMM/NDzEF0Gp9Pn/jdPlNxaO/wqal8MWE9q41hy8a9ZzRECmoI0k1UBrfCpP6IraHYtivoo/CYlS6qn3ssJMai0wKXIYxb0TODX+536lsYbQgVU1UZadBUx5LaXUE75Ij2gT9QIIYp/tI/i3AINRKJQk77MP7OYYWYuthrTknsS6Rb18ck1mC1rVj+9u83enuQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCYZkDsKOoS5RChynWuvA9+eVxtr2RyzOZF2DgP75no=;
 b=OK0CCXYlqmUbAyDg+7IOu/kKEeqnPtKaoiyCRZIEgazPREdc5X8sTyUFRjMi/OIFxXimuV7Niq5c3WDUFT2VwoDXBAJuzAQAM3/zRgji250cRC+2mQum2bWyMEIpao4VAPTLGMFb5CrowBRyiOZrZl8OYQzstBszHvc65T9q5idoYlDwiONtmAwq6+yxfqswddZD0TItJEVy4NfCok6m952P7K7Zp1lw/Ow1c65w5C8qmPWw/i1yHn5i3R4iAw/yr5W8OsNe7iUhdw9mOWditBEgSZrRM9I7fWhrhQ9L5wufOc+V65qFAsEb0xJJ8XPZmIzGWE3qeq9ZeXZeyBOq7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 16:08:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 16:08:12 +0000
Message-ID: <7ff13fe2-1fc0-402e-bb5f-d9274eb9642d@siemens.com>
Date: Tue, 14 Apr 2026 18:08:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt/posix/syscall: Account for changes in kernel 7.0
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <ed1ca8c0-93ec-457f-8615-aad03b06f6ef@siemens.com>
 <5a8c53d0507a1f8e0816ea6a1f6a02ab2fea1c58.camel@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5a8c53d0507a1f8e0816ea6a1f6a02ab2fea1c58.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: e047a3e3-9abb-4876-0887-08de9a4006f8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZJTVJTDxC0Vuoz8gyOEEohPBw6vHBVrou+V6nnicYeztwh3AR+2edUAJRhMgEkHNfa7PTNQr+X7Ftpec/hKjdPNADu3jN2Q0Omb8ThVkmyjrv5jGC9wPVf4wRKFChfe3iSDa+v411QJ/hJYxJGbFNxhDkHfYNG+XId3ty9ZhYzUfzRJ+Q+geDKy33uMSB9B1WAQ0NV9mXvD9yCaOubtOEGmOuhPQH4YHDxVqy6/p8xwL/c6P23Q1R1hAxANWVbHBJqxhtpgEpuXEqJI33PsUtXeiOiRJSSU/N1m+0nDSf8ToieI27MKZMfIibQQ3UFJjS+AlNuUXZQG/4R9fSGKRSpmxvV3lsJZsZgH2fXzz53w9yK9Dh4hyg2Wnt4cy/hYzaCORihIWgQoOKFPLOkefL4BXQYab8ejZqd+O7bZT6FEGNjkqUATEFS/SeBSnlJkSzA7fD08qYhMh+fK3Ii/MfqBkY/xN3idkVY21fJ8XfEV/POs4s8bjiEwy2RG0EDyr5CyLiaFpLsZPykssRHBPXmA7lqlBYKbvu1/wtL9vePSm7Ux9jghvxYO0ETZPZRxhgoPM55wiKnY/dYakfS+ti7Kha0xQJvG0qUHQtdhs43A1qoc2POW5tKL5Bx+06QBG8PXs6ikcchpOk5Gh1HWCZ3My4i9ZEg/pTA+4+AG8sG909fvvJ1fd6NVqoll6D3Givk8IYTdCe+uOaZYcGkm20MIxqGhOURt1tXCekRpz81k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czg3cE1RYm4zNDlOS2dwY085NkhHRUZSclQ4QSt6Zm1ZM0dLZVBnYnN3cHJa?=
 =?utf-8?B?YWQxSTh6MXVqbm9VdFkweWY2UnppeEVIQ1BpTXJRRWJqRCs1c2liM1BKZFYz?=
 =?utf-8?B?T0Z4R0pEeGt3enhaVlgwRHBGZHhYMTlDUmR2amFMczduMFExSHVIOU5hc2dB?=
 =?utf-8?B?S1RYRElhTUZjMDArT01rT3ZhNkk3WURXUG00UTYyZU11Ni9YZytjei8vVjY4?=
 =?utf-8?B?c2FRZHlOWnBENVc2SHo4V3BscHJaVzJEczVRS05pSDlzaDhrejJzaURqUFNl?=
 =?utf-8?B?T0tsK2ExRUFBbnFscjVjTUduUGVpeWltWGNrWDRpaGNpRFJWMVA4Yk5CdkVG?=
 =?utf-8?B?b0dycDJCa2dSalFERllnTy9LYnF0RlA3MGJ1OTRVS3d6bDdUQ0xKWDd3K0gr?=
 =?utf-8?B?MFNIUjdWNmRFUFI2SzBOUEpoNVFVZUtPOS9aZ1JlYUJjQVB3ZjVqenAzOE9j?=
 =?utf-8?B?TEFyMDBvaGpVQ24yNWIvK0NSdlRRc3E2RkltdHZGeFVUVXVPVFUvb3lQSnFv?=
 =?utf-8?B?cTFvQUVBL25lQk1JWUtzV3NNMVdLamQ0cWJsZ3VTQ0tTZStqY0w2VXVXb1dh?=
 =?utf-8?B?cHBxcUZPRUk3akRlMUxHN241eTVrOGRlZjAvd3JKQlhwTGZnWlVHU1E0ZXQz?=
 =?utf-8?B?MUZraHdpdlJ3SXJHaUFaY3VwSGJBd1ZFemtBZmk4Szg4RlM2TG0zdjlGTXdz?=
 =?utf-8?B?WllwQ2h6YmxONnd4TTE1TmtHUjZtSDhZOGduNzQ0dFAxYVZIUlk3MDNuYTZK?=
 =?utf-8?B?MU5KUUxVZHMxYnNiQS9oUFExNWVlTlh4UEpSWFdVMEFEZFhIN1U3MVYxR05x?=
 =?utf-8?B?T3RFemlBb3ZzNVU2b0FqbGlQMmxGcmlpNENBOUpJc1VFbHZYQ3hNaTlVMGVx?=
 =?utf-8?B?S3RPekhjazF2ZlZxc0lFV0E1UUxoZjQ4U2pGc1ZMTWdQLytSSy84MFBYa0Ux?=
 =?utf-8?B?UkxsQWp5MTA4UnlRdndYYmhOZVNFUys3QW1mT1JFWm5QWlFMR1doTEtUVUgz?=
 =?utf-8?B?RjJDcUFaaVRqanp5VHFkZUk2Zm4rUTkwLzZkWlc5SytZK1RKeHB2dVVNdG1Y?=
 =?utf-8?B?WVhvUXpBYzJQZ25KS2h4QTg3SmRTYWU5MlR4R2RnSzRKRmRtQnFoWVpoZUNC?=
 =?utf-8?B?V1h6N09TWENNZXEyQXhXSnYwZ2FmMjZiZEZtc3QzNFBCUnRMdWRvMzNualVj?=
 =?utf-8?B?L2xRZ0ZPZlpvdDVSNjlDajBTWEYxbG9yTmVpam1zKzh6dkJXZjZOYW1pSGkz?=
 =?utf-8?B?ZEYzbE1yY1RMMkFmUFZCQThZMHFVakdqMFFVd1hnVmFkcHU4K0RaWlVsYUZk?=
 =?utf-8?B?NUtxbVFXemNuQ2NKZ1RwUEREQlMwYnNaays4OWVGdWJhUEJpd0x4S096RWRa?=
 =?utf-8?B?enpvSmFGVDVGWjJ0cFRpYTk4NHFNRW5NQXhSQjRudXJKYjlDbnZwaVhBaitL?=
 =?utf-8?B?cnlGNFpvVnBNWnBEelN1dmdKRDcwTkp6V2FUVi9BamY2MFJFbFg4QmdlU2xn?=
 =?utf-8?B?aHR2ZGFDSmpVQS9vWmxycy9kQmlFSGxhVStGNUZsZUtrMlNObko0eWxxUTlQ?=
 =?utf-8?B?UXpKOTA2NFZueTNnekZ4bUxqbWEyMjRobWtobWl3dStZUVhTOUozNHF0bzQx?=
 =?utf-8?B?ZWhicHNYSnN6cTF5d0x0d2FPU0R5U2pBeTJhaEdpVzE4elhacS9udERKM1VQ?=
 =?utf-8?B?dkNFekNxU0VOa3UvV1ZOdWNrVkdycFUySVhMK01pcDAwckNvSE1palcrajJr?=
 =?utf-8?B?OFBCTmJPekduSHUxM0FFREJoaUl6NENrYWhjcXZGZjExMWVXVm1tZ0lSbnFt?=
 =?utf-8?B?UC9RSFVxRUtESW9UQUdSOVN5NUU0bkt1eVFsME1XOUVybTVNMnNkWUV5dVJW?=
 =?utf-8?B?RTJob3FsdmpEajZPRnVaOVo3VVhYZ1FuVVdodm4yN2t4clVjYXFGYUxvaUti?=
 =?utf-8?B?R211QlhQN1hHWmRXR2NBalBsMFlHZkU2cG9tN1dIU1p0NjNTZCszR1BITVd2?=
 =?utf-8?B?SkRXRUZ5eXo1ZlJoUXVNTis1dmdmUW5HeUVId1JPSy9VZEpXam56VnNZWkJB?=
 =?utf-8?B?aldQY0Z1OWtaMTdNdlkzZjNYMGRIOFBqZm51SjJna2dPZ0l5WmE5UG9PZ0Ju?=
 =?utf-8?B?SlNLK3dzelBVWTNqL2lRZmRWTzhDakhNTDhxR05pbnBHajRqZU5wMVVIWWln?=
 =?utf-8?B?NVNaLzNQZlNNNWRyVHhPTTJkN0NhT2l5OE9BeXRlc0VWVys2UjcxYTYvUUcw?=
 =?utf-8?B?L1RBeXVpYVlYNXkrQmJjZWdRY0VsSURZaDZOWW9hYjF1MHA3bXRJcGNXaWVq?=
 =?utf-8?B?M2JUTUFTNTZiRUtzUi8yUVNnY2E1ZFZ6WWNLK3hJZ3FmVDJrVkZyZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e047a3e3-9abb-4876-0887-08de9a4006f8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 16:08:11.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwWtFXbtniyOIJiDaNS4n4nI5ALsMHSwVOvuU6QsTUK2Ra/LtnlRVzIxkUAhNW4emk5zhHNT5g+5bMRMZYMJfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9269

On 14.04.26 18:03, Florian Bezdeka wrote:
> On Tue, 2026-04-14 at 17:35 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> With 7.0, we no longer have a access to trace print function that takes
>> the string size directly. [__]trace_puts will now always invoke strlen
>> on the passed string. We therefore need to terminate our string
>> properly, even if a larger one was passed.
>>
>> We could keep the micro-optimized variant for older kernels, but as that
>> is phasing out and the gain is likely minimal (the string is still in L1
>> cache after copy_from_user), simply switch all versions to the same
>> pattern.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  kernel/cobalt/posix/syscall.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
>> index a26da154c4..bc1825676f 100644
>> --- a/kernel/cobalt/posix/syscall.c
>> +++ b/kernel/cobalt/posix/syscall.c
>> @@ -46,6 +46,12 @@
>>  #include "../debug.h"
>>  #include <trace/events/cobalt-posix.h>
>>  
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(7,0,0)
>> +#include <linux/trace_printk.h>
>> +#else
>> +#include <linux/kernel.h>
>> +#endif
>> +
>>  /* Syscall must run into the Linux domain. */
>>  #define __xn_exec_lostage    0x1
>>  /* Syscall must run into the Xenomai domain. */
>> @@ -194,12 +200,13 @@ static COBALT_SYSCALL(ftrace_puts, current,
>>  	char buf[256];
>>  	unsigned len;
>>  
>> -	len = cobalt_strncpy_from_user(buf, str, sizeof(buf));
>> +	len = cobalt_strncpy_from_user(buf, str, sizeof(buf) - 1);
>>  	if (len < 0)
>>  		return -EFAULT;
>>  
>>  #ifdef CONFIG_TRACING
>> -	__trace_puts(_THIS_IP_, buf, len);
>> +	buf[sizeof(buf) - 1] = 0;
> 
> Shouldn't we terminate at buf[len]?
> 
> buf[len+1] to buf[sizeof(buf)-1] might be garbage, no?
> 

This is a protective termination in case len == sizeof(buf) -1. We could
also terminate at len, correct, but so is this version.

Jan

>> +	trace_puts(buf);
>>  #endif
>>  
>>  	return 0;
>> -- 
>> 2.47.3

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
