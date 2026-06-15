Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F9194A6C
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500678; cv=fail; b=qBX9WFb/3apu5S6d1tUK3/SNSu29rN9CA5q96jwOAbZAgef/hGYQYkMUSa6Dj0KAxB9MQ+sLKp3gnTqlYIw73u+88RBOUk9JJFAAZyT5jAX9mla9jDUB5DST39BseTpxwyxHNynt8Dvu8RZEpaeUMoxY3xTHivhDQ3QKiG3y9zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500678; c=relaxed/simple;
	bh=Ybt+iVFsK4LKCITij5kvJIL/544BpQnhJYQdq2Hf0fQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ICXJSRo8cCFi4BL0wHnpzfR3PrCRiOd1gWgMnWfcKi5nIamtplSV1eh+uVZz1ECxgl6pXrm1qkLeO64kn0X+9EOz0Jl9RuP/0ggI0MvhEBRTQqLSJUQ2myhTHAwO8jXGSNT22gNxvN9SkB5DD5cFC97uPKJ01BKh9hSWbVspwqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KiKntfVt; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KiKntfVt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WV4hMWdfsV9TQP+hjmaZIIky3Mgpmhd69VrdiWrBN6YBm5Rfj22Q+BKOnHrgltH2o5aRsvboT32TbT20WX9JS0E6trYGZVJTa/PU9dYGuOrBA43L0WCFCDHbiuFrtUoX0zQbJQv67BUvk2HNeNg6zdxcUtI9SmqPzUmqWkyhykLWyVHcu86bhhAt4MJ3Jw11D1fkY/xJqPC/MP01Yn53hMXM8ew2qQGUwwlcebcj/fbvmX9QbNemFdhO63gn3/sX7AJlmr+1OQlUz/IimBf1J+TP6vPAhk1u2njDZqnVZbG5AS+kX+gniZ9y3idhx3k2zxh2ryHpyNXvg6yPJygUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+PRQ5cT4zQdZUaS91UuSqLRQJGKTXpk6LGtUU8W6Zs=;
 b=tJBBMcYfl5BhSNABlAy289Q9NAcB7oEqR+NnGcQ5Wfnve6xntS/jLaSPx7HdVd3/X2VIztDdftEm+MhLkodfau6FAEEkFW55T0ErfcSmMG6D6XGZWwCGyWtY/OJh9eq5JpQ2d6ESfCNeT3UoMgMZTEKdqcrWeNuHP0my10MWPCE000GkhCFEIgk/YL/nXaFXbWHcdmarvVC2Nzx70nJFbigx97mdjlCh4M51r1a2qeW2EKf1QsGGQsv7GA/+ZuZJw9mbtDE5VqwGQQ4M58WfHQ9E1S9RfYt2tZDngsR1e87opnikoAO5mr0UFcaA9ACSxJH4OXVrCp/3LfUV+KjpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+PRQ5cT4zQdZUaS91UuSqLRQJGKTXpk6LGtUU8W6Zs=;
 b=KiKntfVtER/4lifAW/ceA8RdRMI14FZ8BF/0IhvfwtYopVPsZEB5yXrzh2Imsb46CHtdtvyQadErba3KdkI7dPGgu731Qqyp/jVMXx18tCBSbGVg/1GjyR7UQPb6zLrzoD021q5HDhLqb8swh0WcwZfy8kDKHe+Ig6oNekgCGrZj0ZPq0y1V9BTazKL5CA8EFd38LW/w1PUXsWbMpk2tsf//lQWbjANJ0BvwfIufIVF/530bBXbdrxLze50PPr7gsLV0MmvcC8RrP1mEBsaSUfaHCM+ZITWiw1CHspcnAFkD8VbS31quSA3zhZ2znNFO54GDJ79ITLmLn8AqLVqT5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7191.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 05:17:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 05:17:53 +0000
Message-ID: <b3d5c062-36af-490b-87d0-347242fc6ecf@siemens.com>
Date: Mon, 15 Jun 2026 07:17:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 1/6] Kconfig: Permit to enable debug mode
 for Xenomai 4
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <cover.1781428654.git.jan.kiszka@siemens.com>
 <f4ff8f75dd3ae44a85beb8f38391720e8760108f.1781428654.git.jan.kiszka@siemens.com>
 <e4e17554-9101-413e-877c-fd4917212509@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e4e17554-9101-413e-877c-fd4917212509@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0343.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5577e6a1-5edd-467b-68b3-08deca9d73e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|55112099003|56012099006|4143699003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	VQXHpc5IqaWiABEm29j3GQ9voMgxHDznTtM/JwXO9WNv022GOMV4ZhBuiw1K7hKMma0WwxM/pQuvn7A+iYodm/TkrYK2um5G3mD3TPaGLvPFafIOrfP+wZ8RcDl11DJeHRUWEVQ3ZIdTMdfW87TGMZZpbTers0o1Rr/g86bIHbbfb993yGVCqFv+ntO/BAm9qw7ARS6wAJKTisWL90Nua3CZHXLk7npVKOu5THluigEp7STU8YHo28KbFLPra2Z0rMXXrK7getVzUuG4pYrNcKfuQXnik8lyZcBpJTvsbTuQCyNrHSGnA2F8xEeNkEZ7CSZ4n3++LS9zjqHHPLC5SNGMZG7ryF2mVS3wbOeNB2iWksYfnMofrF0QFGIeFwAWtwbgxXWOlymd2Yq1odR3LtYCyc78HIq7t1N1X4Buw111RzlV7N70scD9t3c+X7OvAdGR3d3HjBnQneW3Y+f6q0rdfYtptyjzt7LlUgGku8pieMyjFDMXV+2EhG63tH8hdoUaCaa2qxTSoFKtlu9JJqPT9bE2oWoe6LP1CIOe9oBXhXqs73Tpe7o+BfmTefPcDxZzSDvK1Zb1xO7bGWnR+UlTer8ZYWpdHKaOj1QaimH8GmFEC0CTZ0fc1cWo+Z2T3Avf/E/yRLLkG0IInZLcubDR+Mky3Mi+Psp65zvyu+1eVzooM2zzcRbo+weSAnc9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(55112099003)(56012099006)(4143699003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWxSK2h3NTR5ejhRb2dwbUhVYkNCZ0pGNmduaHFPQWlXV21GQmdtRDVFNG5E?=
 =?utf-8?B?VVJkSlM2T01sMysrOS9PK1QrTjhjcVVFeXcxSTBwSW9qZkNSUTJ5bi9qdjl0?=
 =?utf-8?B?ZFFodXZnQ0VUMTEwa2ZFL1hTdUxHcEoraEJ1a2ttZnpNZi85Mi9yQ2UrRDJJ?=
 =?utf-8?B?K0k4N2trQnkrMGhleTAzRXVReS9oTEdXQ2pTd1owaUVDWTBDVjFLSXpBaGFs?=
 =?utf-8?B?Q3lSRDU3Mzl5TFYvd1NNUWIrcWQydG0zLzZDM1NVMU94bFA5aXRjbjVlK01a?=
 =?utf-8?B?dnRPOWxHd1FxV3ZVVC9xUFVCT2ZRZmFKTzN3clJQaERNR3Joc3pqemZVaWVL?=
 =?utf-8?B?L2trN0pkS0lCUWVBK3FKaW91TWlnZ05tMWJVeTBzUUxkWFlKaElMQTM2K29D?=
 =?utf-8?B?Zk5BMENhaXBTb1IxcC9rTi9sMk1HQ3lQdzNQa3dWVXpTS3NZMzFZaFdFODcy?=
 =?utf-8?B?TXhaOHRJSzFEYURsV2lUbm8ycjlZdEZORWtoeFpLUTA0SVZ0dTlBdDRoalJP?=
 =?utf-8?B?VWNJSkx6RjZZRWRyRTc1MmZ3RWxocXBibGxTZXBpdE5uNlNnZHRENTBNOU92?=
 =?utf-8?B?dTlCSmRnMnJ1V0hWdWFpeDkrWnFsZnhGcG53bnE1TmkxTURScUpCNndQQjdR?=
 =?utf-8?B?OW1oaEFPR1EzY3FrblozNG40c3RHV3BQQlJCS2ZEQXp3ejd3NHFUT1MvcEx0?=
 =?utf-8?B?NU5nV2xET3l6NWpBVzZXV1B0Y2V1Uk1nVWkrTTFQMWRWWEQycUEzMHJvYUpD?=
 =?utf-8?B?TUhNdEJic3M4dEozZU10Y3BkanBNWXY5czRYcnZHZ2hNSkVDcFVzbUZXZEpX?=
 =?utf-8?B?SWE0UzlGczJkTUtkdHNyOExVK1pnT1dGWnZWazIxUWVzT3BoL1RSYlBnbHhO?=
 =?utf-8?B?ZjBPK3owaWJuTC8ycklCN2RKYUFZYk42d2tnNitPdUROZDAvcWFHTTE5cFdw?=
 =?utf-8?B?SFpuekMxUGp3QmhpSDBEdW95MVdwS0VRdmRobDBUU3NzeWxXYmZxdjd5ODFr?=
 =?utf-8?B?ZGNmaXkxRlpWdjA4d2haVll4THhUWE54bVludlo4OUFDRGRKQVV2R1BpTkdL?=
 =?utf-8?B?ZXQ2c0tvVWhFbm15LzdNWVRtdnJwWGVqaFNjSzduN1QrNFFTclBYdjc4dmxE?=
 =?utf-8?B?T3IwTGF0TUc1ZDdiVnpuSHM5WFlqcDd5ZEdVV0RuWnJjb1pqN3VmSlBRZGF3?=
 =?utf-8?B?THVuQzV0N0dYNEZFekQ3MzExellhVmxWT2ZOVFpCTHgzT3pLWlRYUllDWXAz?=
 =?utf-8?B?OU0vUmNzWVBSSlA4NlZEbEZQNEdnb1VyakNvaytNbTdUaU1wVWVLTzdqYVMw?=
 =?utf-8?B?ZXgxb2VTaDR3UjlvaDE1TVhaQ2wrRzJJNkcraXFTWXk0UDRTTEJwVWFqNzNG?=
 =?utf-8?B?d3MzS3dBSmVLcWw5bFFxc2hSMkJzRlRKYklLM0RQc2poS21zbUlIU3d3Wm5i?=
 =?utf-8?B?cVVhNStPQUpobzBQNzZTQnhCVW1nTGZqTWpycFRoTkhFRmRXZHY0MHJWSTM3?=
 =?utf-8?B?Uk04bTgyWWNqQk1GSVliUnQ5VGdrbnVSMjJrUzlBOVBrRkZlL0tjZUZWUVdn?=
 =?utf-8?B?U0lxczJhMjAvTjNUQnU5ODk3aFhuMitZTCtIOW1JSFRZZXBkVkRlOExGMXBP?=
 =?utf-8?B?L2EveXA3SXdOMHRBMUtHb3krQnZSSHNGWHJJZzIwL295bE1DUi9kc0lqTUJl?=
 =?utf-8?B?eFdDdjVUOHFqUzE4V3RlM1RGbk1rcFNMM3p3WTVrZ3ptZ01sT3U0b1dtV21X?=
 =?utf-8?B?VTJVOVZRalU4eXptSWVqeG9VRjJENFdFQnJOdnZxQnFKUk5UZGJsVzVpUUlR?=
 =?utf-8?B?QmZLVVRUTDB0TVljSjNKSzlGZFhMU3VhUGlCSjVBelE2aE0rQ09jWWZIaXhu?=
 =?utf-8?B?dFBFeE9EOWpZSnZ1VTV3UGlzV0RYaWdxRjNIVUUzS1V2ZnFkOTRnWDlRanZD?=
 =?utf-8?B?dXlZbWpsSFNMYkE5Szd2anlVWkordktpdzBjYWQxaG9zeElFVU9DT3dGOVdh?=
 =?utf-8?B?TnB2a3o2TjBPTjRaZUNjakJsemZMZG01WTR5aUMreWZuZkVobDJFbURIbDB3?=
 =?utf-8?B?SkhKRW5YYjZ2dUw0U29wVUVkSjBPTnRiSlovVm45K21ySEFGZmNVUllReEg0?=
 =?utf-8?B?R0pYU3ZhMjBxb2FVQ2dDUGRIZWFKSExUZkpjbUFTRWJOcTMzSjRkR3FyM3Nz?=
 =?utf-8?B?TmRsdmdZWTBYUVY1TjB4SG5Ma3FIZEtmWjI2R1AvQ0J2aVhrdTJZcWJuMGEw?=
 =?utf-8?B?eFdMTWZYUWxiNXp4T24zc3hidVpyd24xYXNwU3BSMzQ4TGljbm5ETFJZV1JX?=
 =?utf-8?B?UzZDSzRGMzNpSGpWRGRyaHROVWdQTkozWGxRaDA0bHdBaVRIQTRrdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5577e6a1-5edd-467b-68b3-08deca9d73e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 05:17:53.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3ZhVAwRL3tSdFZ1NaiLTlqVvzambqPr6CVkxBzyenGAs5d+CxXCXJqFl5mR5NFROeSUzEXtWRU6+rf+0s1kbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7191

On 15.06.26 07:08, Tobias Schaffner wrote:
> Hi Jan,
> 
> On 6/14/26 11:17, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> No reason to limit this feature to Xenomai 3 configs. The compat mode,
>> though, will remain 3-only.
> 
> Care, that nobody enables the EVL_DEBUG_ switches at the moment. So this
> might be a bit misleading now.

Happy to take patches (against evl.cfg). But this patch is already
required to get the kernel's own debug features such as lockdep or even
ftrace.

Jan

> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   Kconfig | 51 ++++++++++++++++++++++++++-------------------------
>>   1 file changed, 26 insertions(+), 25 deletions(-)
>>
>> diff --git a/Kconfig b/Kconfig
>> index 98cbfeb..dc79700 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -201,31 +201,6 @@ config KAS_INCLUDE_KERNEL
>>       default "kas/opt/linux-4.19-head.yaml" if KERNEL_4_19_HEAD
>>       default "kas/opt/linux-4.19.yaml" if KERNEL_4_19
>>   -comment "Features"
>> -
>> -config DEBUG
>> -    bool "Build debug version"
>> -    help
>> -      This enables various debug options in the kernel that can help to
>> -      validate the correctness of a particular Xenomai version and
>> kernel
>> -      patch.
>> -
>> -      However, these options also significantly degrade the
>> performance and
>> -      maximum latencies, so don't use such a configuration for
>> -      benchmarking!
>> -
>> -config KAS_INCLUDE_DEBUG
>> -    string
>> -    default "kas/opt/debug.yaml" if DEBUG
>> -
>> -config COMPAT
>> -    bool "Build 32 bit Xenomai userspace"
>> -    depends on (XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3) &&
>> (ARCH_X86 || ARCH_ARM64)
>> -
>> -config KAS_INCLUDE_COMPAT
>> -    string
>> -    default "kas/opt/compat.yaml" if COMPAT
>> -
>>   endif    # if XENOMAI3
>>     if XENOMAI4
>> @@ -292,3 +267,29 @@ config KAS_INCLUDE_LIBEVL
>>       default "kas/opt/libevl-latest-release.yaml" if LIBEVL_RELEASE
>>     endif    # if XENOMAI4
>> +
>> +comment "Features"
>> +
>> +config DEBUG
>> +    bool "Build debug version"
>> +    help
>> +      This enables various debug options in the kernel that can help to
>> +      validate the correctness of a particular Xenomai version and
>> kernel
>> +      patch.
>> +
>> +      However, these options also significantly degrade the
>> performance and
>> +      maximum latencies, so don't use such a configuration for
>> +      benchmarking!
>> +
>> +config KAS_INCLUDE_DEBUG
>> +    string
>> +    default "kas/opt/debug.yaml" if DEBUG
>> +
>> +config COMPAT
>> +    bool "Build 32 bit Xenomai userspace"
>> +    depends on XENOMAI3
>> +    depends on (XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3) &&
>> (ARCH_X86 || ARCH_ARM64)
>> +
>> +config KAS_INCLUDE_COMPAT
>> +    string
>> +    default "kas/opt/compat.yaml" if COMPAT
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
