Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F9822759C
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227991; cv=fail; b=NxiSn7935wKcQUVM2vDZMeGnnJqbGa79H2NSN+CPYAaoFI+ilCQpq4fCLtX4MOcJh7UTvRBPTKMzq+6YAmmDB0dF3xFeAtbYroroGHTQQzGYCmpj81A+B3btcBXCEXMHUEY0o4lgt7rhZ+yrjk6DFTwCwv5ERnlzy85703hM5qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227991; c=relaxed/simple;
	bh=VFWf56aHt1y94E+hmTEGqkXqVRB/1WgnesF8OWbRjdg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GNuJZXPmqSVWKZeJ6LELse/nlGD9WP4owr9hAQF0mRpUvFdWxHPR/2bYmlXZ0BXkVhOism5XbKSfkjJH+iM2Uvu0Z409FwaH8hQjG7AbyJL8vG5PZk1o09gU6zztATFNHi0ahIK4jjJa/pQmu9d633gBjecN3ezmiN/4Nf0VwG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=De+QGopH; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="De+QGopH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snMyJncIOQc4ABmgCcQul+rLe3JKENWaXv6D/cWT2/mdOCSVrc+wdcYdy7b2SdU0nNkANUr3Qlq7rSzPyu3qZQeouToG7qGSFOijlhDUFoGeT+natAIiETbmgOPka3kFpYX9XfFfZVskD61PBMS5RxvFbSukclq+AL9L8pdRdm0sR3C9hhGAupgUf1bkJJ5TMbICJqIwyCeTntSKwQ8RAWVLiqUJ1FJ5lJcNy4dSWoje04B+voN/95tNNyg9WvNiQvYqp3uD0ePLN5Sm/ukECAqiaRZxLUdrUhgAvSSKv4CjuZCaQ+8cdDv1A6XCZccyioYAknuwnWD9EfFBnLyUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ+wp7v6f13KCdEUo96gzQWtFJzoXXbrhFnSx/W50NY=;
 b=ZE4XHrLaH4WtBrd+a1bZ0qRcTkAgX2xCkcgLR6tjnds1y55CPZohPQF+bbGaN6o7jJoJ5S1O2uwT7tzNdQck/P30b/xoFd77WxPg0k3wSnGwCw8vEH8N1YxCYTHheQDYO7xSt8ZNjYlvq6RkEX0ZHi3pikCT5QRIGJpaBcOVxMDgCFwK8MWaxP6yBXIN+8BEoPGEOSLFPOVR1lD74quYkQAgJ/4JxfmSTsP5GvFR08ubfrmkPZhZtDHtg3AFBc4ZhwzJDSU2r8Brs0zFIZ5BA7NcL+VYt1hX7ulOaTwTsmGnfI8C7Espt4AQbFEIGwOuB+PFeCsSuXdfYfeymCn8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ+wp7v6f13KCdEUo96gzQWtFJzoXXbrhFnSx/W50NY=;
 b=De+QGopHhtk3oDoHTbrv1AplduKA5jljUDDKYSatvR0nnpSnxZG7WZg0lH6SmeSOaEFHej+cc6L3Tfwq47hKfpi7ojqDda3UmHPC2RpEWKX7ZQdOxN7oSJFdUd5sptomN9q+a0TyM0INPbmtO25s+gAgi5p2UZHzwf9GX3zEROKlIBXDv9e3wWAViRzSS3whE+J+y6PdcIVT9nsTlyTumi5k8TwLxIFYufLl3W6hCb1k5kYtYkDXmslYHy6r1cxt/xLXBHXJDWt4TtPAplf5nd4zDhQmbOJp1cREq7x8KrrCLtDPolTS/gp3b2+FvI0B9D6dEiaDdU1UKAB2y5tiFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7249.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 08:13:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 08:13:06 +0000
Message-ID: <4dce015d-8e73-4401-8c83-f48f5240292b@siemens.com>
Date: Fri, 8 May 2026 10:12:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite/smokey/alchemytests: Relax mq-2 test over VM
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <f5c42b11-56c8-4a87-be41-e1b73172425e@siemens.com>
 <dc069eaf339d470fecc3bae1d1f6e2d299c0cafb.camel@siemens.com>
 <50dd943e-4c75-456b-b540-5d8d2781d901@siemens.com>
 <313fd59a45d7860b8772040e1b74d6a42bea2770.camel@siemens.com>
 <665e76d5-22fc-42e3-a65a-4b55c74bd008@siemens.com>
 <cfde3caa812e6ab9fb96eccc915e8bb38ed394a3.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cfde3caa812e6ab9fb96eccc915e8bb38ed394a3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: c82ca9bf-0c24-4cc8-daf8-08deacd9a20b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	UCnOMtN3YNxSm4g3zaO9kHjCzclRmVdqjwg6EQQKOxaaRACrwh1L6JF7LY1NUqSmZ/MBoBIk5q2S2bww7osGg+OKMukjUIq7z93HhkSVVrB+emdC+5HUvH+8iljR+bzNwZqCgQ6U/bdf7qzdUEJ/xgqgdGeFRT8nISTOKk++PP5TNu2/lYtgc6vcZWB5Gw8vFvu/enRBqPdAXbI422fioh/elExq8Ix+/JjQn5c7qtU7p5w2RTZJLcQIkx/K2Tlw2VnJZEOy/xev83FcZ+K790fZxoYuYSau3yi4KWOGKfdOApdrOZiu7wz/mkfw69hkx/5cbTTg/pJXQoq0vZUiE+TXXDna2ecFaoqp6zOy/OnNAO91xdAMHN2dZGRwmKZ8sFeCL8GhnIzXmy7S9JLA7I7JTDWhDOnbR7V92u0Fac3qR0CIz0T8ZkdOVW8EKEwy9Ey1QL4IbxCfLz/ct+FPo3Sm6KXgKmkq4AaOyyiPyDQS7DAzDWUQyjZuzvfHbF7hZIXkYARl8WhxW8CvtgQBOxYlt+E95jC24VAa5ZpEXDtnUtCeQrfDC6mDsdfuHluQm0ypmOdHYw8Fpip8mCweS6vtbgDhtCXS0DdJY5+Gwyr60JTN/8szfIf/6mLHyB50nlnReMS1ArRjgWLR/caklTodMH6+XXGdqqgmTh33t7bORdvhtP3n4fA4eDUG8izq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZElFUmpXdUpSQlIreGFSVnIvS242Zm1Ic0J6QW1HaXp5R1JDUzcxbWpFK0N1?=
 =?utf-8?B?REZzSHg5S0U2Wk94N1B6RVFrZVdubWJWTE81TVZCL2NmYmZOU2k0NVFwRkNN?=
 =?utf-8?B?ZU9kMDJuKzJkY0E5bmNDT240dGpFZHIzWm1NUTFzZGJGRDMyZEFhTUdKVERu?=
 =?utf-8?B?bG8xYmFEd2JIaFQzbm80MFRNQ1g3RFlqZXVGSjdNZXBybENNTUUxN0ljVzZT?=
 =?utf-8?B?RVh0RzdaSHN2MkJFcnNtSCtkeHpBTUQyVjVwVURValdyc0lyNDNtY3dlUWt5?=
 =?utf-8?B?ei9CZjhEbTY3MENTeWlUQ0U2WjRsY1lKUU1uYmNtMGJmdm41QVBEemFNRWc4?=
 =?utf-8?B?R01GQURRRzBxWXV1b2tya2VwR1FlVXREVTRiNjkwYWpMaUZ5MFhKVW1VNnNR?=
 =?utf-8?B?aGpHMDJrN1FDRENmK2RBQ0NNTkMxOXE1dnJlZ1JsekpwNXpCZ2FzTUZPWHJO?=
 =?utf-8?B?cVllSCtUU1NUVnVpRHpVcVBrV2ZtMUpTcDFoUVdLTVBYZmRHZnV5MXFhOG1h?=
 =?utf-8?B?enVnSDhST3YyME13ZU5qaUdyVGIrZjEydW9VVlRrVzgyNlNrZDNxaVFMbjhq?=
 =?utf-8?B?NUp3M1FBQnlLakpsNlQxdm9HU1F0c1pJTG9LWjBoWld3WnIzSmRzUlIrbnpW?=
 =?utf-8?B?TjFWWkM1VWMyZzZHNGZ1Q3AwTEsraVh3ODhacFo4QS9TdTY2SWk4cUE0RDIx?=
 =?utf-8?B?dEMxTzR6ZjlCN3lSMmxrL0g5UkVURm1pUTdzREtsTVE3Sk1KRS91QUN6by9K?=
 =?utf-8?B?bUk3WXhqUTNOcHNJMUFvT21SSUMyejhLQ05yTUxvbk8vdlJXODNRUVU3NEdU?=
 =?utf-8?B?WXRmNXdYcjFkeEw4VklaaXNEOGliRDVPOFhDVGM1UWFEclBZV1ptSGhSZ2Uv?=
 =?utf-8?B?OGhhbUZxR0FVblhkVFUzZnlqRHBxazhGdThmblJHRHc0dExlZXRPQXIxWk1x?=
 =?utf-8?B?a3d5ZzNJYThmQ0VsNWNnbVE1MitLOXJuajEwRnJpazdwSzVQRmJmVWU4TXdV?=
 =?utf-8?B?U0JISG9ndkVsNUczTHpySDlGQlJHYmhRRHhDc2tFK2NVRDhtL241Q2NNamdW?=
 =?utf-8?B?UDN3aUlCRlh6SmpvdXhIMy9JVkc0SERqQTkyNGtLK0g1Z2NKcSt1ODRwa2hx?=
 =?utf-8?B?OGNoWU8wMjZiMExGT1c0b2o0MGxFblg0M2ZxYmR5a3ZJNUI1Qjh4QTFyMGZp?=
 =?utf-8?B?TEFhaFIyY0Uva0NyY3pYNDhqRGpJZDlYanRqbEpDeXd6enRsUlRsN0dONW9N?=
 =?utf-8?B?Y0pveEhlYTJPeENIeHBWOEZEWDB1Um5rWjFFRHpXalZRWU5RWkhkRG9EV0Iy?=
 =?utf-8?B?YnNNUVR3M1huaTJnQmFmSzd4QWhsYVltNnY0VDFTcTVuS0lvUmdGTExVV3lj?=
 =?utf-8?B?V0lLcGR6QTFIQkhoWWZ0c0NIQU95emxVb05Bb2M2L2ZSTFJzeUdoMUpKSkpF?=
 =?utf-8?B?K0YyRVVVbFhNNnhlTk8vd0kyWFpiL05WbXFac2FuSmkvSm5vSzF6VUdybHpp?=
 =?utf-8?B?UFRKeExrSlh5RFU1bU1Pc0U4RThCMEorcnVxNjZNVExrR3NKdnF2K1UzZVox?=
 =?utf-8?B?T1g1bXpSemZuWXY2cDROUXJEalpuVXBPMDZkSlNjYnNqdERTSDJYTUNnTmZq?=
 =?utf-8?B?ajlJQmJJeVhMZ3pNb3VNTXNodlQ2Y1lUYzAwUVl5eSswNnZlcWxGVWNIRXdV?=
 =?utf-8?B?VlEySTd0ZW0yem90alRWSnRMRVdVQ1FKOVdhY1Mvck5IcVdjenNMZERiWVNt?=
 =?utf-8?B?ai8yNFNvMjNoQXo4ak5oZDZPbXN5MGhaYUJsUHJqUTFqRGpqUWdpaWdhSm11?=
 =?utf-8?B?bDd4Q3JmeGtlYm5FYzRWellRaXgzcUFpTVM1eGhEalpNeTVQcXlWTkNpWmFH?=
 =?utf-8?B?WW5ubXg0anNPRHVxSkhjaFVWdjhzdm1qNkZwNXZBWHJycU5SK1JhUDhvR2tF?=
 =?utf-8?B?azEyem5SMDE5SVRxcWxiV1dWUkNWdkNmZ2w2RUllSTNobUhBNUxaUmJGSk0y?=
 =?utf-8?B?UnNVQjFjWnV1Q2MxNThzUWphcXhDalJjZFB0ZDl3LzlPbllwRVljVzVpc0Jk?=
 =?utf-8?B?QThDL3Fxc0Y3VC8wbmtCSjg1dTdqNERsdUNBZjlVL1cxY1FkRDNmaS9RWUJn?=
 =?utf-8?B?aWhUWkV6eENENTBlanFmakU5N0FiVkZIVjdXZGMzNzhjalVuOTZtYTU4REJV?=
 =?utf-8?B?akZnaHRsRFE2enU2TnBheHB6Nm8yYm1KamN6VU5nMFFYVGJWaFZvQlU3NXZk?=
 =?utf-8?B?aXNQZFpkaWhiRDZsQU4zUzVtaitzYkJzcWFuekFjQ2tVWGV3cGdlcE1TR2J2?=
 =?utf-8?B?K1c1T2dFZFpUaFVOQVpZTmVkUDJFR2pVKy9mMVk4YklCYkErQnFucU45aU5z?=
 =?utf-8?Q?QwlxS/70VgBTcL2E=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82ca9bf-0c24-4cc8-daf8-08deacd9a20b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 08:13:06.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkQP2j66/K6wp1XbjPK99vhgc3e0/XhHDDv+6MGs2EqMqM4ZTM6onQnvyrDNDjWkMG2b3JO5Vfmc9hWQASD0kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7249

On 08.05.26 09:43, Florian Bezdeka wrote:
> On Thu, 2026-05-07 at 14:53 +0200, Jan Kiszka wrote:
>> On 07.05.26 14:35, Florian Bezdeka wrote:
>>> On Thu, 2026-05-07 at 14:23 +0200, Jan Kiszka wrote:
>>>> On 07.05.26 13:03, Florian Bezdeka wrote:
>>>>> On Wed, 2026-05-06 at 12:26 +0200, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> VM environment may delay or reorder the execution of tasks, so relax the
>>>>>> checks.
>>>>>>
>>>>>> Part of #52.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> ---
>>>>>>  testsuite/smokey/alchemytests/mq-2.c | 8 ++++++--
>>>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/testsuite/smokey/alchemytests/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
>>>>>> index a389e46db0..09b26b2135 100644
>>>>>> --- a/testsuite/smokey/alchemytests/mq-2.c
>>>>>> +++ b/testsuite/smokey/alchemytests/mq-2.c
>>>>>> @@ -7,6 +7,7 @@
>>>>>>  #include <alchemy/queue.h>
>>>>>>  
>>>>>>  static struct traceobj trobj;
>>>>>> +static bool on_vm;
>>>>>>  
>>>>>>  static int tseq[] = {
>>>>>>  	3, 4, 5, 6,
>>>>>> @@ -87,9 +88,10 @@ static void main_task(void *arg)
>>>>>>  
>>>>>>  	ret = rt_queue_inquire(&q, &info);
>>>>>>  	traceobj_check(&trobj, ret, 0);
>>>>>> -	traceobj_assert(&trobj, info.nmessages == 0);
>>>>>> +	traceobj_assert(&trobj, info.nmessages == 0 || on_vm);
>>>>>>  
>>>>>> -	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
>>>>>> +	if (info.nmessages == 0)
>>>>>> +		traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
>>>>>>  
>>>>>>  	traceobj_exit(&trobj);
>>>>>>  }
>>>>>> @@ -99,6 +101,8 @@ int main(int argc, char *const argv[])
>>>>>>  	RT_TASK t_main;
>>>>>>  	int ret;
>>>>>>  
>>>>>> +	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
>>>>>> +
>>>>>
>>>>> Seems a bit risky to expect --vm as first argument only.
>>>>>
>>>>
>>>> It's not a new pattern, and I thought (please prove me wrong) that this
>>>> is already a filtered argv, freed from generic switches.
>>>
>>> Yes, that seems to be the case, but the filtering seems questionable:
>>>
>>> Taken from run_alchemytests():
>>>
>>> 	tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
>>> 				 smokey_on_vm ? args : args + 5,
>>> 				 &test_ret);
>>>
>>> Where args is
>>>
>>> 	const char *args = "--vm";
>>>
>>> args + 5 is pointing to garbage in case smokey_on_vm is false. Right?
>>
>> Yeah, went unnoticed in via 61fc9ff4b7214fb1d9802aa7d177a555f0ad47e3.
>> Please fix and also check the other tests at that chance.
>>
> 
> testsuite/smokey/psostests/mq-3.c has also a check for --vm in argv[1]
> but never got this cmdline parameter...
> 
> Should I remove the check or fix the cmdline arg invocation? Were there
> any issues seen with this specific test (in CI) in the past?

That's a fail of my recent patch, you already commented on it. Still in
next, let me bake a v2.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
