Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD76488219
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431670; cv=fail; b=Sm15c1OWrPwfvJD6tUnPch19GHhrWESyGquN1j6W0LtQ28t63nA/uuNhYvKf6U1p3Dks/pGguqF6vNb5NwJvyC6rt8mttabs0z16SwbugtcQPIbgbRInCSI8lW2WZ8Dze8Ix4A8FXQ3VKfqFVTwJ76EC0LoxSQTS9t/zsjWwW98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431670; c=relaxed/simple;
	bh=BJo7A/rieF0Y3vhK0bmAe2gM1sjNUJL+IbNOgrQjQh8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eDTI8dbP6csjWO1H2vWWi2h+bAlGN1NjwBMaVi5q2E93O+txLYnmL9QgefBKlqfvjm6v5OYER33T0/oFVW7wrao6SfpO+Goq/s5s3tCiC0GngypCBMMY566oQu4pswU93+JWCgfLf1jFQGKJD5I9aCDb+RMGJM4eyFidrtBt/Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=e105XU6A; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="e105XU6A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFwtI6vg58Y1JG4Ryx2iFtvCPdwzsH6co5TqXRKHPz32nBv7Jl4YTh5wgcnc6kBAgbYkhk+Re4lHRf7Wr+JkEpuE2wOeye4OhuYWV5twG+t9mDoNA+BRIGIELNlpTRHLAV1uruwz0bR0pVNMHpox9Ypmy/lll4Jyu1UH17StYWi93a1tV9F0/m6HHtFj7ivbc6Pg60U9bpMpVEId2o0ZL0DMeWYEmTWoyDL/D5oxC4aNB10hjOgsfD6XjrfOJCNKZD3KXpIa3dSw/oW67mnGVxs444kGdJG5IUQpUQa8xDV4iLGv9LuF0EgXdma8HROnXL9gWfTux8Gf2PrPM0UHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIMkcxO6XR0bsalIKZdZ2irTG/ggv3mHpFGxi7rEFyU=;
 b=VWjloxHmxDud+QeHlPPudHW9IPuQOuZAlg85CnYZzLetVWM+Trq8WCC0joqWuTwLyTMU9j4ryeEO1Jmub1R/dfmWZMeh7f4C0fB4SmiGB4PAnWKzd0rQDvdpo6VMXeIsCedJ8LsuONuaC15lxJV5FNe48GlSEBDf1ew3hrKCoIul+sFeHo2hlQDL+ucpbf9RvXDlLvrV62JFQIV7SUYuVJs+LZcgUV04CUo5csq6FKW1W0ESkDH4O3yf4Leo8NfqwsJWgTTlLNhhZlmzXCN65HgSF7snZJrOC+9f28t5WveKkm1BM3dwysTwSRBryUngyOwIB3o4V8q6S7BshIMZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIMkcxO6XR0bsalIKZdZ2irTG/ggv3mHpFGxi7rEFyU=;
 b=e105XU6Af5+u/VXn7B621BWNT9bPK63FO9wdpMiSbrYo8y2Nip81uWG2rA2BwpLBNls1NyCdyXXHhi9dFmlQjpwL41vHCl1J/Av5HE/t8203XXnbgoPjFzSiqT5mcDtqbw8t/F8cu2Fs/cl7hp1irZFCJQzSfCEFnpxslRstiXjdh+ai7ixZFsZvRUHqO/TZz0zw3dypL8YGnFtRI9XG2OsQer0jjEeNLlfW6Ze2SdcYXAyncPamTNSzVbMdwC957V0ziez1jLhQfLG7M+9v/TClkirTLlZ0NUIwv6786NFSAQbZKNpcXx4NJPwVSdEPSW9RuKnhIvMIFsO4M+55Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by AMBPR10MB286757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:814::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 10:34:15 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 10:34:14 +0000
Message-ID: <541bece4-4a55-4be6-9886-228fb23b9da2@siemens.com>
Date: Thu, 3 Sep 2026 12:34:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] docs(xeno3): Fix doxygen parsing of
 COBALT_IMPL_TIME64 wrappers
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
References: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
 <6af60166194fe03a0058c8cd3429d054125ef948.camel@siemens.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <6af60166194fe03a0058c8cd3429d054125ef948.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::7) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|AMBPR10MB286757:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f75215-5bde-4fbe-ca7e-08df09a6e66d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|4133799003|10067099003|4143699003|11063799006|5023799004|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FHOlDs9Ny3JBs8m5rbcKacyEmZtRIWqJXbr19a+1aLFJhhiZoriWMG0+1hFnEmxf8sfKXKShuKDxjnpHmuhQh14Zdl2Dpg23rwuyeVl1j5nwGJjNfAmRFwvUEwU75olWmn5wQ3KAf0alSieTakrTcdgZdnu+uxTMl/K/vIXV5eeOyHmb7Knhg+1vRYOWjlN5nxCkisASFW+iLd6oG61MUtSTXyh+w7GDNbrV9WBrjttGM0Q4qaZEitM9wiIrUw9FHSN8AvmNOH8Cdul7B8I3vcEeAO3VgEfDX9Si0rmfh0Reu27hzuQoM0XvC2lf+hWygxu2fg24GFFfR/XijzgBhE0jySi22z34OftE12hBgO1y7wFmmnjJkElotHozIlrHLiOCoFqeGyGkPuz+S8FXcgbvm3u4hchFYtHGh0eEbfQ7yUO0VECJMtr9CAyGn0u9tLQ6++VooqmRKSIc/vj0aS9VRmiA9Dm4pMgK+KwzeshVfk5NSQzMVNr1ZCVrWfXZta+HVz5PV29uZK2ZdxxELsgbgT2pnAPtLFc07g2Q7174pDxwDZVpE+/YSFbuxW7sUj32Qopp3DxNW3tgJymOA3cM3/hGyEun/YcCzrOeCpMCFi5/XQi+20w65uG5AcNHH4/kN3jPzbm129gi46aGHYz2UENdiUfZHm4JVt1tidg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(4133799003)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z091R2ZBSjhJR3dLeHFYcDVJWk51Z1VyazN5VFl5RnE0RENQbGRjMlV4a3Js?=
 =?utf-8?B?eGY2ejZpTWErN2t1NStyUWo0OGRoRXczWnlkWlFVMmhOc0x3TkFRK3hDNE1s?=
 =?utf-8?B?MWZWeEVEN1hMYzZPQytWZTBTR2x1ZWFpSUJXa1ZLdVRLTFZPdUZHaUdFZ1Jn?=
 =?utf-8?B?YXB1ck5JYUlBWEt1ZnJBNklUSnFjUjN4RldyQ1VzbkJuVFBFdjFrcThGcjR6?=
 =?utf-8?B?c1N0Y2pwVERLVnFBU3pSZlFEWnRybTVyc1FrZHdoYjRqNFdGQmVwcUxTT1or?=
 =?utf-8?B?RHJHZWVxVTRDeEZpUEo3bGUzYml0cXMrZk92WE5mRkVWMTM3MHllK3BnbHdM?=
 =?utf-8?B?MGFJT0d0ZW5UTlVwZHZvUEx3REEySVZlNUYvbjFsY2IrN0IrUzJWS0dDYXlM?=
 =?utf-8?B?c2dhcm1iazNxcUhCNTFMeFNWSmYwUjdoS1B4TUEyYVVZbnBnbjRmU2lYRFJ4?=
 =?utf-8?B?T1pESnZRY0pxd08vaEhoS3pyRitCZ0JDTzVsTzNHTDFUT1Mxa2JXR096MWQ4?=
 =?utf-8?B?S2VoeXptdGFsUEdESWFkQ0tpb1ZtNUNKZG1HbmdZQmVDUnVLVXRLT1pxZHM3?=
 =?utf-8?B?bUMzOGsvbWJIRHdTdUx3WjRBWnpSdEFoWS9KSU9neW1CbzFZQ1dyZHduQSth?=
 =?utf-8?B?NzBybGNyWFlqL05Kai9lRW5wOHlOTEM4c2Q0MjVVU3NKSHNkN3F5S0ZOdXhv?=
 =?utf-8?B?ODdod0s5bjh1U1NtVStoZTI5TUk1VkZadkxNcW82NVNFdWpyeHRVTlhaSHNL?=
 =?utf-8?B?U2pxZlNTWU5WQlJWUU9LNkxjTWdyblFzbnZLU1cvLzlSQ1AzaFN0Nk55T2ti?=
 =?utf-8?B?OXM2N1JiOW5pWndQNzFjMGpyUkozUEdoeG5FcFdvMEV1UWI1ZzBEUnQwbitS?=
 =?utf-8?B?QWV5ZkxhckRsR2lDNk1Qb1J4VW8rOXpyTnE5eTgwNG5Va0Y1MERkQW1aWHNV?=
 =?utf-8?B?ZmRkT0c5SFErRS9pQnJqUFdUakdJc0kvVC9vYmtiemFrbHMrbnhUQVhjZ2ov?=
 =?utf-8?B?MHc4Qm1SMWhQZXJvT3dkRXlHd29yREsxcW5BSTRTbnNUV0V0RloxSHdTK1Vj?=
 =?utf-8?B?YjNBaUJrNlc1R21nVlVzV3cyTVloNmtKN1ArUTVFd2NtYUFKZENmaUFWbUdt?=
 =?utf-8?B?NElTN1dockNIMGVQT3U5SndReVhwZUZEcklVQ2IzZWxNM09UM3lOYTVOaDFi?=
 =?utf-8?B?VmxJdzNwTlQ3VHJxdzRLZGZNY09Sb0hKSGRxdCswMDI5akl5TXlRUzZwbEVh?=
 =?utf-8?B?aWR1MW1xblp5V1Riem1SWFpvV1lYeWR5dHBmTm54ZXRZSG1ROXlsZDYvMjdk?=
 =?utf-8?B?UDNFMVNkN3JZQVdDVTZmOTdwcnVwRGE4TXNvTi8vdUVsYjFXTEx4emVZeFFm?=
 =?utf-8?B?TE5ESE9QTXJlaU9hSFBGU2M4cFgyTlhwaVEzdTJaZHZGcEZTY01YVjVuVjl6?=
 =?utf-8?B?dUxsQXdyZTJGWnRJd1lSNzhvZkgrbHlJRWx1NGkvTGZPRktGSDV5MUJBTUM4?=
 =?utf-8?B?QkxZTVdscUxoTnMxMFhxWXlXaDNpaWZJb0tqRDlaeTR1aE9MWWZFNzJlY2sv?=
 =?utf-8?B?VnQ0RFZNTmVpSVhNcElZM2JHVXgwd1BCb2I1a1B2M0xaNU95RlFPbUR6S3Bm?=
 =?utf-8?B?UmdWYm5UMGhmTHF2aE02YWNXQjR0TkVNNlYwUWVzenNsTll0VnZhTE5tVE05?=
 =?utf-8?B?RkR0TzBIcm5uMGZIZFk2TzBxQlpESlQxaWRMZnltY2M1VlpDUW15NXczUjhZ?=
 =?utf-8?B?bDdqaGQrdWJ6cmxmY3dtTTJ6NU5wTlp2YXJGWFUzaHRPMGRDN0k1cmd3bU1Y?=
 =?utf-8?B?WmJXK3llelVKZ1FaSy9taWlHakFJY3lhblJSWWFVZVVPRUhtS0FvZTExOUdi?=
 =?utf-8?B?dm5CSEV5Z1pLR0JRQjR2cFVGUDczYXBwaTR0YWd4WGQxOVZZdktTMk5GamRu?=
 =?utf-8?B?RnE3YXBjbUxtNml3KzE5RjAxbzZLYmN3SUE5eElzVXlseVQwZHJORWxJZ1Nm?=
 =?utf-8?B?a0Y5MWtUTmVPL1ZGZnE5alpJM3RpbmM0THJZbjVuUmV4T0ZmSDVWZnN6QXh4?=
 =?utf-8?B?aDNpcG52K29udU96VVU1Q1NxdDRSV3dxSi80MzNyU1poQy9oRGFXeUQ3VHhS?=
 =?utf-8?B?MFF5Q0VhNTEyNTBKUUZGcVRlS1FuRVZLQVgyTE1Jek5PUkFlRmZvbTlHWWZC?=
 =?utf-8?B?ejVraVZsOTVMYkhhTGtDWlJJSDRLd0lJY25KSEZkTXRoTlBJRUpKSGo5SmI3?=
 =?utf-8?B?U0RScStJZ0RNRTlaV3JXQ1l5UHRFRnoyQ0JKVFpVYnIwd1M4NEhKbUF0Wnpj?=
 =?utf-8?B?M2lTd2Ftc1IrdkptT0duaERkalEvMHB1RmVDak40eUdlMWtXcVFjOVdzN2ox?=
 =?utf-8?Q?VVoKolmzs0YAtkAg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f75215-5bde-4fbe-ca7e-08df09a6e66d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:34:14.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyvT23wcR1x382JBtieRfNrAfwlc1RcQOEFEOQViuXe/+AR61qr/kUf3UgOr+v2E9ndFikULhwFzgMwNZe8UywwMxhvJ1eqJPEt0Pt+jqZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB286757



On 9/3/26 11:48, Florian Bezdeka wrote:
> On Thu, 2026-09-03 at 10:34 +0200, Clara Kowalsky wrote:
>> The doxygen configuration lacks a definition for COBALT_IMPL_TIME64().
>> Therefore doxygen does not see the expanded wrapper prototype in
>> wrappers_time64.c and instead tries to match @param entries against the
>> macro call.
>>
>> This raises warnings at doc build such as
>>
>> lib/cobalt/wrappers_time64.c:42: warning: argument 'clock_id' of command @param is not found in the argument list of COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,(clockid_t clock_id, struct timespec *tp))
>>
>> as doxygen is seeing the raw macro form
>>
>> COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,
>>            (clockid_t clock_id, struct timespec *tp))
>>
>> With the fix, doxygen rewrites the macro to
>>
>> int clock_getres(clockid_t clock_id, struct timespec *tp)
> 
> Hm. The generated documentation should be "generic", right?
> 
> Depending on the chosen build configuration clock_getres OR
> __clock_getres64 would be correct, but that is also hidden from the user
> in glibc land, so we should probably do the same "hiding" here.
> 
> That said: LGTM.

The doxygen mapping should describe the stable public API, not whichever 
internal symbol is emitted for a particular time ABI. So the generated 
docs should expose only the generic API name clock_getres, regardless 
which build variant is selected.
> 
>>
>> It uses the first macro argument (return type), the second (function
>> name) and fourth (parameter list), but ignores the third (alternate
>> function name, unneeded).
>> By this, doxygen sees the actual public function prototype.
>> See #18.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>   doc/doxygen/xeno3prm-common.conf.in | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/xeno3prm-common.conf.in
>> index 71db05686..ee4ede10d 100644
>> --- a/doc/doxygen/xeno3prm-common.conf.in
>> +++ b/doc/doxygen/xeno3prm-common.conf.in
>> @@ -647,6 +647,7 @@ PREDEFINED = DOXYGEN_CPP			\
>>           "EXPORT_SYMBOL_GPL(symbol)=//"		\
>>           "DECLARE_BITMAP(symbol, nr)=unsigned long symbol[BITS_TO_LONGS(nr)]" \
>>   	"COBALT_IMPL(T,I,A)=T I A"		\
>> +	"COBALT_IMPL_TIME64(T,I,N,A)=T I A"	\
>>   	"COBALT_DECL(T,P)=T P"			\
> 
> No complains about COBALT_DECL_TIME64? Would have expected something
> similar...

I built the documentation with:
./scripts/bootstrap
./configure --enable-doc-build
make -C doc -B V=1 2>&1 | tee /tmp/xeno-doc-build.log

And checked for warnings:
rg -i warn /tmp/xeno-doc-build.log

I didn't get any warnings for COBALT_DECL_TIME64.

> 
>>   	"COBALT_SYSCALL(N,M,T,A)=T N A"		\
>>   	"COBALT_SYSCALL_DECL(N,T,A)=T N A"
>> -- 
>> 2.55.0
> 
> Question to the complete series: Is
> https://gitlab.com/Xenomai/xenomai3/xenomai/-/work_items/18 completely
> closed with this series applied?

Yes, those 3 commits fix all doxygen warnings.

BR,
Clara

