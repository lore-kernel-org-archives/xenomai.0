Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F83A269
	for <xenomai@lists.linux.dev>; Mon, 12 Feb 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744833; cv=fail; b=L1Kp3uAFuJIcTl0KVL+4oGTEL1MRQZffkOUq/dKDn5M/Mz0ox3j5ojwOUHgVgwjXUjf6E46CbUXXGzJu4PPjR/lnV2eRdV1WXhvv8qubmvq020YuXJHrWkWN7jCDWnjn3FMri6hVfyIDC4eOAdRp5mDyH48ILGxxwOM9jRMSsV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744833; c=relaxed/simple;
	bh=gNtYV5PTT4lJHmEBLcL1OEqLUVw8UuzUekf8VdMiYCo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pibP89pdvFMbqgHDIbzxw0H3VW8sz66kMAlTVVuf6LCUBQtzQdl6JcnCwf5eDt7+VOu5w23MWZ6QNoWe9FkSrQurANNCtpzs+KUDpti3KXOHCPOODCvVTlp5muA3/47JlIT+XZqDY53NUZ6MOKAdR3hR1ZxHYrtfZ/+SjAYfzio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gcrZPXoy; arc=fail smtp.client-ip=40.107.105.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gcrZPXoy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdApDJ3VM0BFaZB0FHv/Kj7BwztGj3Bxzntl/A6TRwsX80LKF4GMXrCeRCmm3gig/uvrAyTmvoQOpROa1eZ5lYdkptjQvuLkIlm776LPCBJZoEm9PTwPPwxTd0jaEtaRVt6AfmfcM+CYqlM8nr7rVV6d0GcOEKtVbi8IHZIKvCTLhCQiY/mI4obVYKbDLmS6g5c7zduTwUIz2VsuTwEdx2hfv82K5ULwS0MP3mXtgTbAuARBT9fRT9q6KW497yjj1kurk365nS7WeG5ngMtEHPzYwfrX1wEQr8u5tYfQCkzBI77utddAgJr52OgZ83dUPhQWyjAYkUJsl1JVAm02PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luEOqT6ynlNhu92tAkUOvX5gcpzAZRLPshlCw1Fd3VU=;
 b=T1kZ5jvG0fl/I6JSsUHRwrvygO0zzbLKKVCTrzc1agDhkOd7HhzZEqNXyKGVDnbQef/29NeRvU6yxAESNdAHsKZoxgb8zhlFNR3pYU9a5Gh5kmzVVdpohzeJ6/LYgp1HhN7C6bmeZipfT2FVui1l9J5XXTO/NfllA3XwVJ3Q4OOZKtS9rvqj6HB2DZTu7D403KZOJopQ2A0B4kYQ16UkqqSzcwDjyfoF/H7ramR8iC90y7bwFjH1dSfrymKTaGiJsFuFh9Uh2VfTF6hjyCLEhp12BBaMLASQII7/hWqrr2R4yJKehmtB/alALwOfNSmzJbsxtssPqr7YDW3ZKuyk4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luEOqT6ynlNhu92tAkUOvX5gcpzAZRLPshlCw1Fd3VU=;
 b=gcrZPXoyPhggTKnQ0JRQR61aTFRmcdq0wAp56jU7ZmaV8/v3/lvtnu79+aYBH4RCJlau+MGJeTwQX9z/TxByTlZSpDHNlD81iQ/TlRibP8C28JLlwcVa9iuoXqeHhy1cPHyM1Mss6k84d/AWV4BqJVQY9KKDmNc3EqWWPotG4HQtORYVLp4tCwD035YhdAnXtVL912aJEuZ2UQL54mJPJ4x7wWGW0M+WC4ZjZYLGjcFseIZ8Rm+DfigNy/A24rqNsWM94FjdSaybPTaFXgXuffJuPphD59VqJy19WHn9SyJrisBrATjIgFv9C/P+VNYyob27EWw97c65dJGD2EwmnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 13:33:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Mon, 12 Feb 2024
 13:33:47 +0000
Message-ID: <0741388e-f109-42af-83e2-074323069aec@siemens.com>
Date: Mon, 12 Feb 2024 14:33:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] compat support: cobalt/posix/syscall: Use
 syscall_get_arguments()
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
 <20240209115025.1884451-6-clara.kowalsky@siemens.com>
 <054cf7c365f17128d71e68191b03c9ea1f3e62ec.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <054cf7c365f17128d71e68191b03c9ea1f3e62ec.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f31f36-8bb9-45ca-cda9-08dc2bcf3df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VydVjMmQ9UjNM/XhBB3XmFEnIADpQ0QR+vAvXMXu8UnOy1Mxq8NkV5IrTXov/lGVjTU0PlKIWstWiX5S8gmVIrAaTnk1qxdeRpC+7qnwsE8Xz0mGww8XpkNfRA/loiCnsibDPIQAjE8jnE2XTvsGrTQqhDRPYOiz22xCAc24wl47j1iJyYPuDoSbpl7aSk9bhKKYbaAHqNOD1zuezlUYAEM4ST6AETjh98o7X30EaLWlZ/mdMCAkLZVIFHewWY6Mz3Q/b+H0yFR1WRAnH4+9N7mc2uQGjyPnpAgqbKNrrf5vqJeUm+qk31BccJqVBorBWAcK9NESnKReuSJbpqINcQ4Fr6YwwlyML3tUShXb/nayXkr+Cewi4MNeFFp8brDHJDBbIr0xtkRd4ONR/ERWpL13PeGxWJZCeJNwfCuWRJumaq9/8RsJMdfKEo9RW85T1V0p/q9UOBQbh3ontJR31RrPiWxDKMMjFQU306xGqDqIiSSE98AZ6A8pelfJfx5odLdxiszklMAcxW/PzpWfvs3/49aaTtCufP8fJ4+l/mSh4FrvU47wQOWWNsJ9Wj9Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(31686004)(41300700001)(6486002)(316002)(66946007)(110136005)(66476007)(66556008)(31696002)(86362001)(5660300002)(8676002)(8936002)(6506007)(478600001)(2906002)(82960400001)(2616005)(44832011)(38100700002)(26005)(53546011)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0RsakkzcTZPb1pUVytUcUhhT083TDh3SXMwUDgwb2gyZjJnZmZvdmI0WWYx?=
 =?utf-8?B?bU1IMXZNdVc0eVR1THJVMzkxNzY2TDByQVc3YUJjMVlaK1FuN2ZvYXMwK05M?=
 =?utf-8?B?eVN3b3ZDSkhCVXFVMDR2bzFkL0hIWXdORmY2SVZoVzcxdUs0ZnFuWXVDbzJP?=
 =?utf-8?B?cjFKNzYwcXd2bjZLaWxhTW9kK09WVUQrY1UrWnZiNDJDZWFFcVYvNnVwdXNP?=
 =?utf-8?B?ZEN0V00yb2hBT1BxS3JvUGR6bDcxZUtNc0F5cHRLVjNuSGhFVUM5UkI0OXoz?=
 =?utf-8?B?Zmxndzl0TjlZWEpRUWh2ZXBKM1V5YWJodDA0VTJ5eG9ZdkFpaGxsbFRaNENF?=
 =?utf-8?B?VnhYZ21yS0xQYk9UajhkcWIxWXdla2VkT0VHeno5Vk1SdWNLUkg5aHpqNklZ?=
 =?utf-8?B?aDhSY0NOYWlHR0lsb3JqNVYvWkdDNVhuaXNjWVRXTmRyMi91bU5PK0ppMUx1?=
 =?utf-8?B?eUk0RDVybWxtOWdOelkxeVczUkNZTGlsWmFFV1pwM2dhaCt6azNDYWhOQkxO?=
 =?utf-8?B?L240VndOOE1meC9qRjdLVUZCODhsSFczdDVBWnQ4WFBqZ21sV1FlVkhtTWRh?=
 =?utf-8?B?dGRYc1V5Q2lvYS93ZVU4blBsbWtXOERJN1JqYy8zUlArT0RSaWU5ck9VZ3lz?=
 =?utf-8?B?cHFoQm1uL243Szk4aktVbm9xYzJ4UGhZWDR6TW9idWZqYWFCYTB4bGFDd3Nx?=
 =?utf-8?B?Y1UwU0hBZGdEenorY0Fyemxoc21qbjNacG9RenV0Tkg4RzZzQWJWcEhFOHgr?=
 =?utf-8?B?UUcrbTllZW9xSTArTnZyYjdkS0dlTjk2cCtNL2ZZMG5Ta0ozeGhaSFRBZHNQ?=
 =?utf-8?B?WnppSGloeG0yRlN0VnJtOTNoY1g1Nzd2dXVQQllXQnZZQ2Z2VUlNNnduQ00v?=
 =?utf-8?B?S3BldGpPQ3FXTHRMTEoyM2JtLzd6M0xXaFJWY3N0L0hKUk1zdmhLRHlZQTA0?=
 =?utf-8?B?RXdJWitGVjJHRTg3UVcyYnhFM080MmVkdXRxaWZaVzFmNmNMWitlQWdaK2RE?=
 =?utf-8?B?U1ZXcjkwZStHTHp3RVpQV0gzNy85QVU1ZmMvUkF1MlZYcDRGdjRIYzhjemVV?=
 =?utf-8?B?U3FmelYxUDYxeXE5Sk9wNWpCUVN5ZWJGRVFLL1ZxL2pJTGJjZ1dQR1gzWmNQ?=
 =?utf-8?B?S05aNDY4azg2VlBtUHI1LzVCY3ZMTi9TbVpBMENyN3h4bE5KN1RiOE9nMjZQ?=
 =?utf-8?B?MG1oQTlvQW5oS1JRUGRaci9DbWp1ZnFsdy9BTXVNaCtzZkVaTW9tT3R4MkZ6?=
 =?utf-8?B?NFJZVEplTUFYa2FuN1FZSGsyYW85TUNqQ1ZlcWVYWGRZTWM2cU1FMnlmYkNV?=
 =?utf-8?B?dnhUdU40RVFsWjl1SnNmcGxRSkJMTFhzRjJrNU9ad3FJbUl0ZlRRcm95WXFQ?=
 =?utf-8?B?UHNPRTVXSzdycG4wbnhGMzBiMkJub1hoTjBBNWczK1FGMzlFREZQeTRhQ3kx?=
 =?utf-8?B?Zmt4NHl6YVdKdWt0Y0ZnZmpHbDkyc2ZIN0xzYjdqTW9OTk8xdzB6K1QzWE1i?=
 =?utf-8?B?Y2gvbXJuNnduQ29SalArRW0rYTB4TU5LNzBCR3BTcG8rVFJjNnY2UWFUUGRk?=
 =?utf-8?B?bzBVNjlqeDlrNWZyYkphN2NPUC85Znp2SWtNODJjM3ROREV1ZWJsMzNpZDgx?=
 =?utf-8?B?dkQrZnp2S2wxL2dNTmVrN3VOMTVUU2szOWdtY2dPMFRnUU4wVEF2WFFLWDVk?=
 =?utf-8?B?Nk5EWUpXalV4eU55MExZM2dkdFRZR29XK3UvTWVFdzVISXZ5d2E4U0FPcG1m?=
 =?utf-8?B?ZUN4TmZtU0xXMW5IR0FoY0gwV0cxekY5N2pDMC9JR0JmaUFReWZJSFkzaVRa?=
 =?utf-8?B?NTlzbEY5YXZ6RGlaWHdlY1RrRFdGVjVhOHNSTnNzYUErNWdFZlBIcldYd2FK?=
 =?utf-8?B?OVJRa3psTFdXd1pxa2wyWDJyTmxqd0V0LzJmTEdTUnFIaU9vOHJIQzg1SGFV?=
 =?utf-8?B?Y2podm5DM2k3QWpKeW42R3R1eEkyMVRFYTd6dnVGQnBNNlFxYUI5d01WSjZp?=
 =?utf-8?B?aWxtb1UwdTZVellkanF3MTc2dXZ4L09TRCtqVlRkMzJITlRlWFlXNk9wS2ww?=
 =?utf-8?B?Z05UWlRVRFJrSUE0TnE5UW9XWUh6Q1hOSEJtRXJFYXg5U3JIZ3BrVEo1MDZx?=
 =?utf-8?B?dDBMWGxId3JPNXEyMmRCSnFKaTBZT3E5b0dSbVZmWGJxM1FVT2Vmb1N0eXR6?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f31f36-8bb9-45ca-cda9-08dc2bcf3df8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 13:33:47.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKsGJMsFtXhPABGm2wURkhBOgduKY4KQ8/eeP3gFaXBvevS+Meo3Lp57Y8L0XfUnMqER2glmWsJnHPi5q/TcvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6869

On 12.02.24 00:21, Florian Bezdeka wrote:
> [Removed Philippe from CC]
> 
> On Fri, 2024-02-09 at 12:50 +0100, Clara Kowalsky wrote:
>> Use the generic implementation for fetching the syscall arguments.
>>

Reasoning is missing. And shouldn't this switch rather be part of the
patch 2?

Jan

>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>  kernel/cobalt/posix/syscall.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
>> index 6e1f15ea5..1d37cb279 100644
>> --- a/kernel/cobalt/posix/syscall.c
>> +++ b/kernel/cobalt/posix/syscall.c
>> @@ -584,7 +584,7 @@ restart:
>>  	 */
>>  
>>  	p = current;
>> -	pipeline_get_syscall_args(p, regs, args);
>> +	syscall_get_arguments(p, regs, args);
>>  
>>  	ret = handler(args[0], args[1], args[2], args[3], args[4]);
>>  	if (ret == -ENOSYS && (sysflags & __xn_exec_adaptive)) {
>> @@ -733,7 +733,7 @@ restart:
>>  	}
>>  
>>  	p = current;
>> -	pipeline_get_syscall_args(p, regs, args);
>> +	syscall_get_arguments(p, regs, args);
> 
> The cleanup of pipeline_get_syscall_args() is missing. We don't need it
> anymore (was an "alias" for syscall_get_arguments() on all archs but
> ARM. The ARM implementation is now aligned, so we can remove it
> completely.
> 
>>  
>>  	ret = handler(args[0], args[1], args[2], args[3], args[4]);
>>  	if (ret == -ENOSYS && (sysflags & __xn_exec_adaptive)) {
>> -- 
>> 2.39.2
> 

-- 
Siemens AG, Technology
Linux Expert Center

