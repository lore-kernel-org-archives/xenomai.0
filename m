Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2105.outbound.protection.outlook.com [40.107.22.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98181154BED
	for <xenomai@lists.linux.dev>; Wed, 10 Apr 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738347; cv=fail; b=pCoCdZuEsh3CEg+3j75jdlsblWmHvG6stziGZR9rBtxDRvtSUSV610Z/OpxoF4tcDA0mT9pgRzLcSqrkpa5GQk0HpFsMs7pe7Zp12ViDLGs/rjMO42iNFOwrYXtUR/pX5O5OtX0uw9mTDyLYG3L3lExm4octukiL+CsBGk2e9F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738347; c=relaxed/simple;
	bh=6psAQW8sSe/ouG9FPXNesbzC0ObX1ilrtvszZ8H1Qj0=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fhuFV2YRApxbrjpq/JF/WavrQ52yBQRxinnZlsleUy+o5MaPeVwxM4eOUuYb9Z26NkxCrk3/2b2mbVbeF76pwwkYLfzz12E+rWLVTWi8zl/7JyvPaBDngFpyMkDNK/jj9O+D73jIqfCxJX7KdVAXq8tFh26XcHR4R6RPPj0pE/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WBDqRIZq; arc=fail smtp.client-ip=40.107.22.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WBDqRIZq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju4MTFgdSklZL2cr8EeXvacMW0URTOnrTVOHFgbfI/b8pFW/0kr/Blim8nf/SMpe+BDE6OrFQhO4GFpO+N2IUgpT5waSGD7j3ODQ2pnA5qJ3Cpm0ekGRHGP0fV30py6M3YNBo4du54hgr2peUGMhaFn0Z3YZq6s8M12+039sudCm8GMZvjcM9Two+sYFmlbCD9QRh51WShvHkL8j0YsTNiWAWsMyo/MsGb7tyxNQpMMv9/oySvRIAqtMEpUuzSkmDffOM4ohias09b7DuJyHjM+q3wf5Nx+/uibvs1nvFER/iyi37GMqntLwm6k29ItWGKKsX1Q1eyQhUB7Hu/7vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptNJhNjX4SMJNDa2si0fuUVVD7tAspCpuuza0eDAegk=;
 b=MJ5CazLWssZC27mr6xM0w6y69io1mk4sKcuaZyuKtcQASrd7hl0FG8ycg+iIbo0NV49qYMvTeGY5Mvnh2wQtUpcw4rYAu9ephLazHfCpxH2rYPEBHAv4fSxC4q3TztBdU3Pu/iHnMb36MSuS1NincyE3N9Kn0u/OvLd19tgYp38iwDVKo+OT/7umDEwNezs7Anp4N77+q9I7VjOuHGHbSzpIE/7U7+UaTSRI5evc8KEoIly1gF36yYAZS0L+zVIByKzM7EOI4MYbUlMRBSmu9cMTgHx1aKzNrCBTF7FeZ+r3GMcgDq49NEqUzd2lGrlh6nuIwBUFGu1jE0NcFDzQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptNJhNjX4SMJNDa2si0fuUVVD7tAspCpuuza0eDAegk=;
 b=WBDqRIZq25d/KV/8o/1+ogpFc3mstXcdUt3SbNWoKD9QspUaVBz7Ivmz7HvDGRagu0CKeIk5VW1XnefPNZZSft0TLbIVpXiFriaxQMNzUJjoaHyFJt7BuTWWu6gxYJvt7+hgl0qeq5vohFWh0LU/iA50ZdQY1M56qrq058RpefGD8Hkx84XLEqtQvCO4bZaRjhdEwV5mo8PNW8qtxJQUROUR1wC5bPEYJEN4AvfDVEuQER1qKJJV8JItN0ITnld5LOoJGXn27FQK1FqtWKtmKkRveW7iVurtHqfsdnJvYv0DRjFGkurdsYPAc/VdthJ/bO6Sm3AGvCIBAynu9aq3TA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 08:39:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 08:39:02 +0000
Message-ID: <4eb36f9f-472a-4dbf-92d6-4e31d43a517c@siemens.com>
Date: Wed, 10 Apr 2024 10:39:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] prepare-kernel.sh: Fix typo in variable name
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240404093040.15605-1-richard@nod.at>
 <20240404093040.15605-2-richard@nod.at>
 <383dc8e2-ab48-4422-9ed5-41858aad88e5@siemens.com>
Content-Language: en-US
In-Reply-To: <383dc8e2-ab48-4422-9ed5-41858aad88e5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9001:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b/Y+QQLXiRk7JwxpYMqdapiwXwNO+2iSLxIJDUqU4D/yfo4cJePbhsJLr+nMGsjJ4xNzjG8Bk9JXUrH3oYCuR3PSIP0Vbo+XQ28DaEP1nIdWjQ1R+X5JMfVluEGs/3BpKmXUo3F3yLzemUFde85CfiDiAiR2eaxhQj/biK+XARp9UIiNDpfRW3Yw2FjvVMvO20wceMaQEqa6ICPjANX0GpH7wfpfVsegFSn2Jq6q1oQSZqyOt6pT3035mcnGnlTTdoJhvrOnEM3jv/whb5AfdU0sFOLNQsfYOXA+mrVmKaltxI05wR3E1by2fpctYRRH/sJ+84UGh+b7UsmJRoYfLyu3IZTiPDNHLlnUubt/VHztdlv4C62wCDIktG171EIatpl7u8rbqtNEn5hN5TanzDNoO51WykcyWezsRT7jUznbSzFNNXpf7WnuJwKK3NdmbdEsCNa0pICfVZs9UO3t9keXSXLAxXgsC8cupXFhFGly0xILWTwrAoAslvorDL9YN5Vx9e5B4O7vsEeFDLhf7CMje4zRNmow5YxHi4QzlW0Fm+gbR5j5f17BB3XctBxk1xnHHrZjy1NEStbBvDpU3Fj8N+va9Q57zh/ytR8uDb3HxwUEMJVW+eGWr2Mn7EPRvBVYUJaa5/H185etkbyEsNZQAKyctyLrhFleTnoUhkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkdOTEM3K2NxQnMxZlBpZ3BFRmcrcTVraksxTW1CdHBpZzYxdHBVdDB0dmhR?=
 =?utf-8?B?dW91MlBPa1ZVb1dqeU5qUzB0a3d4Wml2emJqUEdocGtab0V5cjBhdnVVZG9Y?=
 =?utf-8?B?MWxGUi9xbWZQRXJxaVdEeG85dDdHT3FsLzdHajJZMTJPL2pMU3dIQ203b0h5?=
 =?utf-8?B?OUNkOHpINGRMeDBoQWF3eGQraDhpNUtJMmluUk05V3Y3VzNKUGR6MFoyNFJo?=
 =?utf-8?B?bFppeUhDckRvcFBOangySFVDdVJKSlhqOElpT2VDc1FNVzZuZURwdktJYzVD?=
 =?utf-8?B?Vm9vNjlwdVR4ZlFRMXU4Z2JMTWxWLy9Nc0RwRlJKbXlJdkNyMjUxUE9tQm90?=
 =?utf-8?B?VWZUZndWNlJLVzJsVXdsZkdpRjFBNEM3YVNWeVREaStJSCs4UEtJdmV2RUhm?=
 =?utf-8?B?S2pCOWhwYzFyMVJ2U1hLbDNOMTRRYUR6NUtBcTVFVk9xMTV2SGc4Sy9KbkxI?=
 =?utf-8?B?bFYwR2szcHllRHNHeTlQc3VQNUtobG5CeU5tY3h1bSsvRWtCUUxGb2l0Q0NM?=
 =?utf-8?B?N1A2T1NKanVNNVFvTnhZS29GWVJNS0x2N3BXc25CTTQ2R29PanpzMEFTS25D?=
 =?utf-8?B?OSsrVkdtQTlaQ1VHL0VudDByTkdUVk1hWDZzQkFuaUx5dXhkZFV4d2NaUHpt?=
 =?utf-8?B?RkxJNU90bWdoSGp4UWczWjk5a01GQTRwWkxoQzRMci83WVB6VXQ3RmFZOUE2?=
 =?utf-8?B?d2ViQjRleC9STDFpVXo1aFYwSGpyVzl4UGxYTHZqRksvUkcrL2pZT3BUM0I5?=
 =?utf-8?B?cXZLNlFFTHpsalphL0dxb0pzU2g0dTZqOEFMZ25uR2xrUHppOWxUbjY4VG02?=
 =?utf-8?B?RTAzNHN5UmUwa1E5MEZWTTlUa3FQTWszbVVqTmtKSm9paERTNEJLTDBJV3k0?=
 =?utf-8?B?UHE1bkJiYnBLd0FkaFFkSDFJcFh0QVhRZEV2WmF4SnVScWcrYytveWRpQTBo?=
 =?utf-8?B?U0xXd2kxcjNDaW1Id3JORWhOU2x4K3R6dGJGUjNBK1JoTlVYUVBma0ZCRFAy?=
 =?utf-8?B?MzJxU0FpTFdtQzlhOUxLRS9Xb1ErZDBtQWdvZjZaUXdwbHFzWTRkM09NWVVx?=
 =?utf-8?B?S1F1RW9nSTBoSmZSMW5kbmRXbzhnTHBTamIxUzRWdmFmK241NTY1RjhxRFEy?=
 =?utf-8?B?T0djT0tzY3dMNGVKYk1hYTRab0lpOTMyRnV1dHFkVTR5dzJLVm1OMU1oSlJN?=
 =?utf-8?B?aUh2NVE4UFBRMmM1Ujd2aEM2QmU1YVVmRHVFV3grNEJabXVFZVRRYnJYU1lr?=
 =?utf-8?B?L0Y1QjZoQ3hvQk41Y25aSlJWa1RWV1NQZzd3Z0lQWTVXRHA4K002Uk00MGlh?=
 =?utf-8?B?MWZRYkNHZHp5dTdBYUJwaVBYaStMR2QvSUdjRU1EZVhQZVgvR0szRm03WFky?=
 =?utf-8?B?S0hIdVlDUEJSdWNNSXdBL2RmTGdPOXQzTGtvMXpzV3NzOU5yQjdNaHJMdGhC?=
 =?utf-8?B?aHJmUSt2amRrWDErekdLanpGa0lyZkRoN3BES0JlRXRCT0ovd05CZ3F4N3U1?=
 =?utf-8?B?QkxoV05udlh2Y1ZYUWh6VWxBdGxVZlR4YnNST0hvN3c4OW81SnVCdTkxeXQv?=
 =?utf-8?B?Z2RNdXBIREtERmVtZENnSkVWVURsS0xjZm41a1gxVzlkLzB2ZnZKdEd0QWtC?=
 =?utf-8?B?enZhaFVpbmdRSXlZQ0RLZDZZMEZsU3VQQ0gwcDU1Q21kVXA0N3Zqd2s1am5V?=
 =?utf-8?B?R08zc1Q0b1hlMHRlcnV3ckRPMWFuanI3M1RocjV0MkVDa04xV0YrYnZhMzZo?=
 =?utf-8?B?UGRBSTZDMGhyb3VPZ1VQaUg4WmF5M2c0ZHJIcWhVaUk2M3N6eUsvVEkyWHd5?=
 =?utf-8?B?czJoYnEyZzdyS3JCcUVMckluK2p5K2NIdnZrSW1hcjJ6WHU0ZCtFU3RQU2pn?=
 =?utf-8?B?NllHSzY1blhmdjBtajFoZXVoR0l0YU1wQ2ZuSDAyNkIzcWo0MDJYdlIzTmh4?=
 =?utf-8?B?RGlleUFOckE4Uk1OUGQvb1NHRnViWUxkTXpsNUJlN0xXZmRDMG9zUDlEN0tp?=
 =?utf-8?B?UkNmV0M5ZEt3UHB0VGYxS0l5aG1UT3ZCVzM2cEVuRFRzczl3SnhpaTJFM0J4?=
 =?utf-8?B?am1uOGhyN0tTMFlXMk5QVFJTVlJnNkE5MEZldllOc2l3ditFQldTYVRoSVNO?=
 =?utf-8?B?ZldicmVNdE1NSitVMENuNUhTWEpoTjJNdnBSY2R5MVpaNGtkbVg2ZVlWQ1Fs?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3349677a-aa87-4cfd-cebb-08dc5939ac5d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:39:02.0526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1XM1r77SlHBprlBOQxx8+feH0KVb/Kz53Ixt2mBSu8kc5JXfhHMW1TPx4jjq9TK6QSiThfFdn+xrF7d+nIFag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9001

On 08.04.24 18:17, Jan Kiszka wrote:
> On 04.04.24 11:30, Richard Weinberger wrote:
>> recursive_opts was added via
>> 3f4c56c74 ("fix prepare-kernel for 2.4 and mindepth argument")
>> but never worked as expected, it's recursive_opt, without "s".
>>
> 
> And what was the impact?
> 
> Looking at where recursive_opt is used, both cases specify additional
> constraint on file names that likely happen to exclude source and target
> directory names. Right?
> 

OK, applied with clarified impact (none).

Thanks,
Jan

>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>  scripts/prepare-kernel.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
>> index d50680dba..0b11eca66 100755
>> --- a/scripts/prepare-kernel.sh
>> +++ b/scripts/prepare-kernel.sh
>> @@ -94,7 +94,7 @@ patch_link() {
>>                link_makefiles_opt="-name Makefile -o"
>>             fi
>>             if test x$recursive = xr; then
>> -	       recursive_opts="-mindepth 1"
>> +	       recursive_opt="-mindepth 1"
>>  	       dir_opt="-type d -o"
>>             else
>>  	       recursive_opt="-maxdepth 1"
> 
> Jan
> 

-- 
Siemens AG, Technology
Linux Expert Center

