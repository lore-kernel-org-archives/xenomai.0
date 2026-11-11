Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794419738;
	b=K7jumKCHRjdAKnlo3F1h+gYlwzGCXT9vpDjFtDNEo6dK4XeDu9NmkE0PdFYtB7tDk6zz
	 7Df9ZdZksbqdkTivsjutiKfW/hiwhAuWsAaBxVHeTOVk03cTOe3quAEtVfAuI+fDgWuyc
	 W5OsRY9PPP35ltzP1joYnT6AFIyveFzhGXPnIqPvxopDiC7zxGfS5Bxb1RNQlsq+bMTPS
	 MFsSl3ZSamp/XZ2LLnMHLmD879v/nL97s/atJeabD9i48er2SltzN01vbd+H31Ytu3sRF
	 F364K/bRGHq3Rj1uXLCfZPw53cTj08Oa7YmCLrwfvSKKGtUEyBUtCjLeQaMpLTJ+8YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419738;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5jXWpaYFAGAjwhCGEcrcF+3q6O5LB/RLGYYYArsPgRg=;
	b=SvzvuEpzr+TNT0fcK6XzRTHeQOFqrtEAb8T+xouNH6mE0PCaNP5qf5I+dWtlrgf5UVqt
	 u/XpaNAQOUWH0umfcaZjp2S4nbhPxwop+Bng6qirlF7bcqA1OrOM5cLpOvrFv9JHKe767
	 vFoHbegqzRJ2xwHBRNSDdNeep1vRc/7BnMA4aS6dtd28bf3FANkds5t/ho30MDqK3YJhi
	 3IA3BCpxEw/dL174c5lRL5Z60+/fXOnJ+DjRFYwthycfufBrEbVMzWBTbGi16T/0nCZ62
	 sDM/kG+QiqUO5+0G5LxQnO4GMiMDg2Q2lfJiWb9mkSdwDY5GONUXPzwOhezCHWjU80A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=eT8q7gtf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.19
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC55B606A321
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 17:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC55B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=eT8q7gtf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3WQS44OzaCVc6NPCbccXRkHzql5ilxiglOEWwaaXPUhYJuKFDHHZv6DlM/j9Dzx7OZLK4UlFPxVAWxlNFkXN7F3C85HRTEPEMQKLrSPZyHY22ek221b6E3lMEOxpBbOZ4RB9OnaUbJLwqnFV6T2KgBfmW2Fe3odgl45C7UIUcmEzPwv+GMlqGKpv2I6d5wQ7QQiE6FRud7K5s8v3CTc13JHZ+S2cHHdOSZoMn8MygjaPAVHPu9VSkxycdXhJaER6wQmwWd4Y5zJ3H5oqzMY/7/eVwzWsT7kgZBtkRyoCaHZN3pW5QXy++GitcES6iTtfL5aAshEI004yzekGUFPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jXWpaYFAGAjwhCGEcrcF+3q6O5LB/RLGYYYArsPgRg=;
 b=opHuGzYDOcavbtxQLLUdzaCY0hdBc2ppCuLdDsTu6s10M50h8/Esu8ybJ8bZi+cJTw7Aah9gMU+aztroNmcSgObT4hCh6KObWBerMbFQrxEATal1CrJn6iEK9sx86oOlXA2BUNHB0MhUWPH0yzHzoXSZDeEoqeQUf70M6bLX1NxvMDcIyBu64O8GM8+Fmy81jRPbjjfMO1Wx9aGlh628fdVdCYYXLNFYCQ8YpeEcNCxSJyHNdEJvMmYPq2Xw9lJD1opbDdU4adaQo0yZq8/UXlCUjy7pn2iBFqwXQOSMy6XtLZTn8Ao+d+4q7A9uaK3qEnnQf85DbjFPKDY7xNxXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jXWpaYFAGAjwhCGEcrcF+3q6O5LB/RLGYYYArsPgRg=;
 b=eT8q7gtfhMyYbfCTjEHpqGDllkMIBOnXF9agzd3fKLetsouUBtTpkUIOxL6Qgjt5/ao8lrgxvzIfqpKh5z71/dRkhW2tsVOt2yiuc+CXFimNc8CT2GZYdMk6KTvDgfwuyol//7GidQiFUlKZkZSp/0YMU319VNY/MtIyVM5oKtDMGmxl7rGyCW+yR4GtIX3osxQzQ88R+6RQ7dzqM4i/LJIdwEtYqN4kxO9yrynTDafcWYy31ac/xKHNybxX55/LdHwLLRF9kzew3BrFmEYrbmVAalErwkzlERtfADMtmGXSF7FOz029W+SXkDshgW23bIK54C0X0TqMHRaJrdxHVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GVXPR10MB8455.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1e2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Wed, 11 Nov
 2026 17:55:33 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:55:32 +0000
Message-ID: <10791d06-65b9-48b3-800d-383e8f50c99d@siemens.com>
Date: Wed, 11 Nov 2026 18:55:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: O_OOB ABI
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <18f772e8-118f-46f6-963a-58db46724e24@siemens.com>
 <87v76346l0.fsf@xenomai.org>
 <dda83d6a-554f-48bf-8f00-5d1a1deaa82d@siemens.com>
 <875wy345kz.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <875wy345kz.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GVXPR10MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6ae6dc-c59f-4e4c-99e4-08df401cfaed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261021121427099003|56012099006|4143699003|11063799006|6133799003|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	lLtq9P1G92cVpomiNHFgrBVpycBSTDA7XO667N2Y900YnndFoOF1XcMwlqNSd6tzK/EnuSvNw7aaYIRDSwWuDStsVPJVHuqDYIrTG20UnXsCzHglM3ZifjQSGQGmZxUFh+sENP3pdBFZXee82C14z0ov0qf6w5LCXilhd892q7V6bTvDZH+wsrFAAbTb7vPdXjRzFJU9zvULsELnEk/3ZjPMcIRNtSZRm4jrb+bXlu+KMkrBUHVRSTG1rpX+ITt8Unnyd2MVKzPHTRK2KB043c+ctGvEK+72wv7btDnJhJ+ROgqToX9ap3gcL5PpbUwPZNxAd5UVLQmfaL8WCKNip2f3iwHiCiVsxDdQa4T1IhyBB79dzGPSKyAhtYA9aTrz+Kla1FOs+TJe0LIliOKu8yztVuINzpi8qXXztSSNMLeZ6pB0701G1iYN7rLt1auvFyDQlbTfOE1i+9U0Cxk+ugx+quYKXDrRYQZ7s68/poke2W65q3IfqjcKpdx2rg4LC2ziJHYyDIa1i/Do17BY0QnfF9DDIeHhyXCDetgrsYSz2nHOGANo9bhqH8Lcqnf9gp3nI/56wtVfYfjrLg5k9g+Tzoq2RsawBrWH5zjZtBPuWHyNdpHSmCtMqH+C3v1IASR8axHigB75PfnfaWPhkVtd5st+AJloTDe9Y3QlQbo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(56012099006)(4143699003)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0tXSHFuMXlYeGs4ektrQWdPUlVsUCttWWc1L0FYcVo2ZkFhNC8vbHJtTE4y?=
 =?utf-8?B?MTRvZlhISDBHb1NTT282WFVhN2dxNld5M3dac2pvRWF6UVJkVVFiQkROdEZH?=
 =?utf-8?B?ZTF6TDJlaytKL3ltNDIyWW83WWVFQzVZczdybHBKRUdiOUJPWVBIeWRkM2NY?=
 =?utf-8?B?K25nYVhCT1lHMksreFZwbmFsOWVIZ2wxYm4zT1BDL2tBU2xwZUhXVTk0bXh1?=
 =?utf-8?B?ZVpzTVV5ZkwrS3hsSXlBb3FpVSs4YllTUmlQNElaVmpjRkFJY0ZKdm5zSHNX?=
 =?utf-8?B?YWRvVDNnSkRNQmNVdnpUT1ZEODdESWJrODBYKzRWZW53Wm9rdjNsZjkyWFhT?=
 =?utf-8?B?dnN6SEZzR2JEOUN3L3U0MHJCMVlqcTNMVWlhRndLSHVrYmpaSE5TZUV6Z0Rm?=
 =?utf-8?B?d2FrcHJjVVg2UmVqMHJTRUY3MUpoZ2N3elJZUGVaTGI5MGRMMWtOM2FxTU9l?=
 =?utf-8?B?WnNUalVKTi9MQjk4VXVNdGg0NFAwbXdoTElMcS9YdGxFUVBXRDNRWHFtVkI2?=
 =?utf-8?B?SE5CMm9RVndVTEFHR0lqMHczTUk4L1cxYlFCeFN1OEZzTkRWb3VraEY4a3lw?=
 =?utf-8?B?RzVGUlpLYjZybnJtS3B1SWdRZE5qN0M0VkFRSVQ4L3BMWVlUM1BRWnJVZmUz?=
 =?utf-8?B?U3RDZVFkZHd5aTNOa3FQNHNuWk92YldMRmNtSFNNYTRhVlJwNVQvMDZ5WUpO?=
 =?utf-8?B?YVBIRGV6bzhLWWo1WmpSbGdySVRNTU5vT0NGRnJKZS9rd0tWelVJcHE4TGdz?=
 =?utf-8?B?c0o5WkNFMnNERmNkcTg4YS84dXRRVVZwdW8wSE15T3cza001SlJXTlpXS3Rh?=
 =?utf-8?B?djRNbVgzK095OXZtWVdrdU5aVFI1amxWL2JSc2tXQWVja3BzVStPU1dMQXJz?=
 =?utf-8?B?TWFmeWV6OWoyN2Q4THAxbmxqRmgzVkNWMGQ3c3ZjN1FLMVhqQ2NxUUVHbi9S?=
 =?utf-8?B?Z21YSHRsVDFySFJ5b2dtSnJMeG5EL2t6KzVXRnh4OEZkTkc3bDBoU0k3MEw4?=
 =?utf-8?B?ay9sMG9rdldzanUrb0V5S2x5ekVFalpZN1FPcFlWUStZeFU1N24yVTROMkZL?=
 =?utf-8?B?dGJPWWQ3SHZWSWFiUm5yajMxS3V1V01vd2VnWGgxL2ZqZzBtemFSQWZYZ2ZI?=
 =?utf-8?B?QzNPMk43cjgzRzlZVFFqZndwTy9pd2duREFiUG9od3RGK05hQWhWcm5nM1lG?=
 =?utf-8?B?b3BVQUUxZGljMHl4ZlZPcHN2MXNKNXJ4MkJHL1hXOWVwMVV4dG4vT0FNZnpE?=
 =?utf-8?B?K1JkK2dpSzRTVXV3cEFUV1VnV3FiN1RlMlFQTy9iM2lwSlhhNTFFUGFkVWFX?=
 =?utf-8?B?OGtLTTBxRDhoWFZ0Vi9ZOWlSSVcyUXRyUHE4Zm1qSUdNK1FjQm5LZE9SV1Fq?=
 =?utf-8?B?WHNjUzgxMUFSZVBzbW9Jb0RIWkcwbHNZY253cEYxR3BJMVg1ZUpIM1FTTXV4?=
 =?utf-8?B?S09hZk5Jc2Fic3gwT2xhdWdkcjB6aEVpV0NPcW9xdVloK0oyWVhTNXBCcmJw?=
 =?utf-8?B?alZNSi9HaWRMQkFSd29wYk9tVWVXSDJhR0dOeFFTSE5YL0dkK2lwUjVVd0lS?=
 =?utf-8?B?Lys0L0p1bEdTa3pwU3E2YlhxUmVhZmJPRzd2azljR2FmN05ncUxtbUliSzQy?=
 =?utf-8?B?ZDZFUk1lS2o4YUtXam81eUZKb0U4cHhoZi9rbWpIS1JHaUZ3K1ptZ2I0cEZh?=
 =?utf-8?B?bDhCeGw5NG0zRUhyVGxXWkNCV0FwREZDeGVBYU56OHpIQWJzSFNYTS9kQmZL?=
 =?utf-8?B?bHpUdlNRUlljTUx6anVBWjNLS1l0ZTAzaEZYNzdIN2w2bFdZZEhyMzQ2d212?=
 =?utf-8?B?YU9GcnFlV2ticUlJWm8xUGRJeXlXOHRpOFppTGVSTVZyTXI5VjQxT29iNXFj?=
 =?utf-8?B?T3M0WFhnVFBiVFJ2MlQ1MnZINlhxS2NVR3lRS2R1ZWRESXY2Z0pxUXhXaW1r?=
 =?utf-8?B?UGw5OUZQekJZVVRvNFVuTU1pUW5oZ3I1VE9FaEZwMGV4aXY1VWg1L2UxM0ZW?=
 =?utf-8?B?SFFzYXArQkZkbWxGMG5NUDdPWEpqZXYrQVptTUM5c3IyT0hzWXdEbG9UakpI?=
 =?utf-8?B?WkF5a2ppNGpycUFtaFVZc2FhUU1ubm1KS0ErSVY1bDlSQ1NIRDhROXowV3dO?=
 =?utf-8?B?U1haQ3RaRkpweGthdFRoZ04rVW13SVBiLzd4c3hZMjUwcVNBZ0FCU2hzeG9r?=
 =?utf-8?B?TnArVFY3eWFBYmRQZm14SUVVd3plQmJHdHNjM0R6cEdSWVVkWSthVE5XTTJB?=
 =?utf-8?B?OFZoeVFOVU93Slg3aFB4U2F0KzFoRmUySFhTU3pIYmdmRmVpQmhEZUphdlgz?=
 =?utf-8?B?cTZGYVZMSjRmeW1JV3Q4VERPLzAxMXZxY0VoalViNjZlZVhEWXJxdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6ae6dc-c59f-4e4c-99e4-08df401cfaed
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:55:32.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inuslbXuUIgHgrQcp3KcnMk7X1dhp4oYeR3Upar9M5Kf91VlNJxY5A2tKqUTTnwmk1Au2gbqt22FQcoSP0qmlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8455

On 11.11.26 18:54, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 11.11.26 18:32, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> Hi Philippe,
>>>>
>>>> FYI. I assume this is an evl-only topic - if at all:
>>>>
>>>> "O_OOB changed from 010000000000 (1<<30) to (1 << 29) starting with the
>>>> v7.2 port. That changes the userspace ABI compared with 6.18 and ≤7.1."
>>>> (opus-5.5, while reviewing my 6.18 rebase)
>>>>
>>>
>>> Correct. Only the evl core enables the oob capability for regular
>>> drivers, which userland may request by setting O_OOB in the open
>>> flags. This is out of scope for cobalt.
>>>
>>
>> OK, but shifting the bit was no problem for existing evl applications?
> 
> It was 'only' an issue for applications built against ABI <= 46 which
> could not run on a 7.2+ kernel as a consequence of this upstream change.
> 
>> Handled by the ABI matching between kernel and library?
>>
> 
> Yes, this has triggered ABI 47.
> 

Thanks for clarifying - maybe the AI will find this thread and avoid to
flag this again. ;)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
