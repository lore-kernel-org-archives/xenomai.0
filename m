Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244B1DF261
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680932; cv=fail; b=lXDGvrMxv9xN63Z7xNGXgo0VpSNGfuyPNkEmqT/JT8UiGr7TwndohesAk6mdfdKWZLcvaus3qJxgKLTrHJk4D0+0qXx9IUJR81uB9IeIKMuhPhYf6TbC6FI/m6yq9xsI35/RMvhGp25v2NOST7Eo7jm0PbGihd11E0BIRRyEvmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680932; c=relaxed/simple;
	bh=UVz/qrRtbPReH+Beiz4P/lxd9aErNpVDUE/Acgbart8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQ1CJKPQJyB0+HJdaatzVE+js9+OyW1+94gdn9UFmI4pO77xy1JWI2NAebc+nZhuDQw7d5qkc0ZF+H59+5636YLuuMvoKVaGh2eg8A8DbY79V9O+88a8TTWaQNC1pX4QSVNuR5rGA5Kc43yyp7PNFfl61ub8zmZVysHl9uSsFNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KPVk7QCT; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KPVk7QCT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wK4EmNp7qD8nVrpyZW0ZIH5p3i9rFRchx2g0q4gp3Flo18wnOhMHtNdiT4gJ7nw1HP2EleNpUJTcQS2qqRgrDHwuqNAV0Mh0O85lIbK7N1IA9ecLsphPW1KgySl2FwF2oatEP8TwTFq2/q1Fy5icdUGN1nXR2IhyufHKonr9gRHS9EAYwqOG1nhXzCkOeGDl5Ox37uikw0RQKpxgCy94jKRLMd/YfcgzGWCMspcP9cRkfkqNc8lOGbsz7Rb52b8h9iWIMKJaNPPDMWN6JayGNmv6ynqAPWQZkqr25d3QrK7uNzgbLdZWhxhMrZ828nXQ6trZSy9aMgogBAjRTG/MzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj9Od20tJqXHyjPI2zSKQGOj+0ROemjx4wjDpuqe3c0=;
 b=Q4r46rLtdW+Gd9a8uBbHUlaEkVRQ9embC63/5E3KEkqo5VN1i2uCal58phTnxAEaaSkIKI79QjkNhy1+C2ZgetQp9Y/OlNv+htRb9boWbi7myIIp4IbLtE68tNpvs0fiAfqka5QhBnmhepVzLzcLgrgd/EJdNTDdpiom95YzX/ASDAdznZBQUl/qY4L1lTLow8XkiRTVxuvg0QuskLtEoLcR9/Y1zT7zE7gQSMQOybNwb4YA/aRxiESXb0raciIGrgqLKCV4cgruV8/yFjQm5tyQ9+5Fby1o4eaSeeEOJtZEvrEMsiEGI1Lx+3aafA51AHnXlqX6kGVH31Lg6+I+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj9Od20tJqXHyjPI2zSKQGOj+0ROemjx4wjDpuqe3c0=;
 b=KPVk7QCTho4FmBhzJL9louxT80cH36dm7yUMyK3Q6QaCCssg68LCF1PTX4zEr/goWRVs5ULCdOX5Hgs9qiv1VktYMTq8YP/RP59jW8Bg1vBOvWPVJZpVz+nA0fcIqlGWet1LiJmU8PeguKXNvqnfYoRVIdpc1mQXY4t8jKRFOGfK5K4HG6YU/setney1EJ3QiQR/JwPt5PZchqRMG0xrOy/f65vHAb9n21sldVjkskdI/PYdAXaZaRPqBwx+kDiC9pEwbwfmGdg9HWFTj1/wZwk6ysz4GSEzhKc/bmSRi0nRlcXPRx8R0D9Q4kJxwYtdg11mD76HM3zOuVQEAa9VdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9482.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 14:02:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 14:02:04 +0000
Message-ID: <a8612493-f49f-419e-a952-0b9a0199f553@siemens.com>
Date: Wed, 13 May 2026 16:02:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] testsuite/smokey/vxworktests: Fix compile error seen
 with gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
 <20260513-wip-flo-gcc-16-v1-3-120ae1287401@siemens.com>
 <0a460b08-ec31-48c8-9255-98c562f3ca50@siemens.com>
 <a1529505a5131d8b324d97d3191997998357d25b.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a1529505a5131d8b324d97d3191997998357d25b.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: 5434ec74-d14c-481d-be81-08deb0f8360f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|55112099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Qeq4dekMAr7GYzRYTEbJFHUInDMWg+PG4axBVZ3GHDAFtLxnJUeev/a8uLYK4j9C6hGMNkkIdC7u4ugBoMBtIgigAQISwKA7joLB8TSoEQKN74IQ2GvEE5XzdG5SDXLhILL3JbzPJ1Kuw1Xsa6mwwreNnP30KZE2gFSoihMkkWQXMy7XJMaonGD8cYAuuFveLO/E7jlANkqZjs8hqN7xI0/OYLzvehsMMgPZNEBNjy+c3QlHuATLaQm8R1yzK+4aUrtwpcAhNFj7vcjTwLBYKDxY6J1mI51mcf62K2khaFv44/1b93g+/RpgIaBUB2jr1kND8nS8rr0JM6Dqtv5PW7SPsInFy6nJrRQXymi2TnaANoVNO6AaSm/VrNowjk4GYKKieCz7ZZoCOSBuvLP6xY2ZZgsWLcgVL34+8CeJT+v15gfaNXGMsja5UtmvPj7sesTP/h547rgPJfnlLNhtWZdEkL41W0GVxhxHTSRwJBR/avfdJEQi0+L16rVe8d8ckeyBfWIYGPxhkFFr5UD7/SUqSnomECI3wgmjzhhgVc2soHKuMgYr7/jArJ+4yBKTEeED6qLC0Xo3Tu9N6atn+PZ9TMpqp1xsKwO8JSgBO4pdJNFCYKTyLDgA/gK6gf/yyMEcSn/ZTdezHtMcGKaWlQGKLBzYXaI+KEapey2zbX2sk29FZ/OGb/sh1jRVu6tM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(55112099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3FSSGJsYXJSQVFjc3YwZmNocWhLMlVldy9ySDVnUW9xb0w3ZUIzb0lTM01V?=
 =?utf-8?B?YmxFeHU0VUFiRStqeWJJZnVIZ1BZbW1UcENRWFV2OG8rNXVwaGNFOW5ZRUFB?=
 =?utf-8?B?cGkveXJ3RmtNd3grR3JrOHUwZU9OUWE0eXpRTlFXbDFTRDZKamlPaWhxL01Q?=
 =?utf-8?B?ZWxyZEk3YVU2Rjh1bDA3dUN4YnF3bDgvVk5TcnYwdyt3NG12RDIrU3JvNzNZ?=
 =?utf-8?B?N0QwWDhZRzZISlJBVHFEZ2dTNlpjYlRQeGt1N05FeVpQc0tmdmwrSkd6MTZT?=
 =?utf-8?B?dk1oOXo2RDhSb1Z4SWszMGRTemVRYnVkbi9lN291RThsbis5V0lDNDE4ekNF?=
 =?utf-8?B?UDVMa1crVy9LWTh6WEQ3L0g4NGVGek1LNFBhQUNHSGJFWHdzeHc2WDh2V0dU?=
 =?utf-8?B?d2hqV2pPU2ZiT0hZbEhseit4ak1YSlpBbHJJRlAydlpPZkhhNVF6T0JpSkVn?=
 =?utf-8?B?YjRWakRSRUpJSW8wU1lxUmpzK3hzSlRhMFlPZ2xOSkVYRWt6MTZnVDZiZE1h?=
 =?utf-8?B?MG1VNUJ5TGRETDVCYUZKbThlMGpnUHl6QmZBNUdOUUlWT0lhQVQvK3lqVlRP?=
 =?utf-8?B?MWNzbnNiazZoTWI2QnhiS2RJMGliUTUxK3dlVzBZY3I4WVlPVXpmU3FibHBk?=
 =?utf-8?B?cWZkOXhEdkw3RkkzaGRSeEs3RnEyT2VzOHUybEpxOVB6MDhRNnFWWXJrSGJ3?=
 =?utf-8?B?amd4QVRwRzVFb3lKUTBFVnRvSW42c1NRRWk4YWRmNWl2RWZuT3pPektYcVpk?=
 =?utf-8?B?Zld5dmpmeno2VDVndFpQbDZyMGN1bGZTaElxcGFyY0Zzb3dPRHZIaUEveXFV?=
 =?utf-8?B?VmcvNERKdUxNNlVvZ05jeU1PWlpweWpSOVpCRkJNZC9yYlA2bElhME5aNytn?=
 =?utf-8?B?NVlmNXJ2Sm5LRXVUcnlZYS9DbkhYODkxRHNqTnk3bTBYMnZETWpSZWIwcmpS?=
 =?utf-8?B?Q3k0akpDWXFmUWplby9lR3FpbEJCRmhLTy9rcHBpNHM2WDFKRGpvVVNSTkRX?=
 =?utf-8?B?TXErbGcxdHhtcFoxSnl5YXl6LzEyNDNOTHdhajhMSGx0YmhZeTExZmNRRmlx?=
 =?utf-8?B?cEo4QzFGVFljUjc5TkxwRytibDJ2M0xHMGVyWlI5TTZHMi9yWTBsSzJjUmRJ?=
 =?utf-8?B?UTJsM2VEbmNQR2paZy8vMjNaYnQ2VVhBaFJnRCtQQThtVFpra3JYMjB1WWM1?=
 =?utf-8?B?aUVpM2Y4QiszL2pjWUw4MWI2b3dUeVFrYm9uQnFvTE1VUVR3bFhvYUhZVDh6?=
 =?utf-8?B?SEM4UlYyYTJvWU1xOWxaakF0VG1jeTRHWE1nY3o5RWQ1SkNnR3lWTHNORFQv?=
 =?utf-8?B?RFJBNDhpQzB3M1ZFQXhjUTRxQW5EQ29KSjl1bkdOVmd4TWk5T1lXQTlRdWVO?=
 =?utf-8?B?cjZwU2ltd3lMWk4rTzJTdjEzYUY5VjVpTXo0QmMwZDVOTkx5cW9hTkVtc1VM?=
 =?utf-8?B?R1JwSkZSNzVGd0crVlNJaE5TOW4vMXowaTdXOURnMU94b21KNUdkVjV1YVpC?=
 =?utf-8?B?aWxSWWxxaGVLSndkaWZqdWYvTUpLUHg1Zkx5c2c4MGVOV3hpSXl0MWpKZjcy?=
 =?utf-8?B?UHVseVpISXdLditrVm9zalB1TVZaK0c4RithcG8rT2VmVDdKMWZxZWE1ZENQ?=
 =?utf-8?B?dUEzSkYzeWlrL29oQktiUjd4eEtrWWhnMGJwbmF3M1dvb2F0c2c0UGhudW5R?=
 =?utf-8?B?MmQ3Q3RkRWZRRDFzK1c5Z1k0NXoyY2RnNi83MDRIN0NjOVlQTnNCMmtJU0ls?=
 =?utf-8?B?cmU0SmpTeTNXK0tjK2tDMVpISVpTcS9KbEdKQk5oc2pFbzBJaVJRY0R2S3V0?=
 =?utf-8?B?RXB4MUErVDhIa1FNT0ZLdStuZGFuQlRiMENhLzU1M0VwSnRabmp0QmFYenlk?=
 =?utf-8?B?QTZ6UUR2SDBPMXZFZVF5YjVlbjdzaVQwQzJmVlhrZEZMSHhlQVhjZGxtNnhl?=
 =?utf-8?B?WjdEWWVLR0dETzFhQjdJaUxXT25BL1hnS0J0WnphbTRkdWZJOEhWejZuQklC?=
 =?utf-8?B?bUUwckZ6MHlZUWRsR0QyWHJMLzdhUEFGMTdQNUNIQTB3SEZwZGJ1cDBXSDFU?=
 =?utf-8?B?dUNGaXJjekdtcXNKbWkyTDh3SmV6YVBqak1YRzJEcmU1WG5qcVlXcTgwTG9w?=
 =?utf-8?B?b2l0RlluYXdKQnFpcVFQZUxwNUQrQkdKNmp6YkxaekJOd0E0QzlNRnl6azFC?=
 =?utf-8?B?MHJrQVVPWjRpU2VzdmQ3bW9xdHZkNW84cW44QzJMd1NSVm4vSnc2NEU4SDhN?=
 =?utf-8?B?b2JncUEzRTkvRUx6aWh5ZVhOcWJDQVpxVS9jQVFxeW9OV3prcStmYjdINVJ2?=
 =?utf-8?B?elNwMnhjTzV6cGdMZXA2N2ZOVmJ3SE1yYllTeHczeG5aTjB2YzV2ZlplTmts?=
 =?utf-8?Q?faXH1rQifxSzmh9c=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5434ec74-d14c-481d-be81-08deb0f8360f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:02:03.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hz/JKYsf0KLSXP3tr2wHTYgc5EobdQJBPvmMAK7vmHbJd1XNRJAJ7f/paC8hpwkCA8cIBHfID0MpoMLOLR7kSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9482

On 13.05.26 15:55, Florian Bezdeka wrote:
> On Wed, 2026-05-13 at 15:52 +0200, Jan Kiszka wrote:
>> On 13.05.26 14:50, Florian Bezdeka wrote:
>>> Fixes the following error:
>>>
>>> task-2.c: In function ‘backgroundTask’:
>>> task-2.c:26:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
>>>    26 |         unsigned int safety = 100000000, count = 0;
>>>       |                                          ^~~~~
>>> cc1: all warnings being treated as errors
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  testsuite/smokey/vxworkstests/task-2.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
>>> index 0cbb9e18a13383418c4360241ef244b8a24da975..ed3e31806baad930bb30edc53d2dc6b6e51d6277 100644
>>> --- a/testsuite/smokey/vxworkstests/task-2.c
>>> +++ b/testsuite/smokey/vxworkstests/task-2.c
>>> @@ -23,7 +23,7 @@ static SEM_ID sem_id, fdone_sem_id;
>>>  
>>>  static void backgroundTask(long arg, ...)
>>>  {
>>> -	unsigned int safety = 100000000, count = 0;
>>> +	unsigned int safety = 100000000;
>>>  	int ret;
>>>  
>>>  	traceobj_enter(&trobj);
>>> @@ -35,8 +35,7 @@ static void backgroundTask(long arg, ...)
>>>  
>>>  	traceobj_mark(&trobj, 2);
>>>  
>>> -	while (--safety > 0)
>>> -		count++;
>>> +	while (--safety > 0) {}
>>
>> This first of all increases the risk of getting optimized out. I suspect
>> this is intended to generate some load, and that needs to be preserved.
>> We should likely do that via a busy loop which spins for a number of
>> microseconds.
>>
> 
> I compared the generated code, where only the increment was missing. Let
> me double check that the optimization level was > 0.

Neither the new nor the current versions are safe here, specifically
regarding timing.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
