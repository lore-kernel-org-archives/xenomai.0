Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011048.outbound.protection.outlook.com [40.107.130.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2325A631
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792019; cv=fail; b=a4+jHjnTBdE72YULBdBztMrX34p6xw5hbJ8Kv+SkALYnkUeYc0jWFZWBcVeh30MPP3ck0vYwqASWM8FUNYOqR9c6AdyPO9LcxEXB5X7YlmCiDnCfelQfipz2GgMW/OR+MTgvCX+/LqWEBHh9/d2oEKs0J1Bv9kM3rbBD/I3m0Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792019; c=relaxed/simple;
	bh=dUJaL1foyl7uE51+GabqiJwDKCjH+SOIf4ceZzwvTX4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d4kLPfPNIlfqntiqoJNezdWb95j8/1k/Bt+hzQWVTkpXpNHMZY2ttEOnTPPTsANk0UbWnVZjA2XVx53R2G6YggxepfKHlxO9N40xSnKnbulrClmZ1EAVYiAwmLxoOS/+ZWn92W0pFH6VZd/W3KMmXW5sbLYk9XsCVfNGdqOaOr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rxWzN/vK; arc=fail smtp.client-ip=40.107.130.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rxWzN/vK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWlJLgbewqepekqqlU/0C8cGkVA5z07Wearxne/2tlvXMqVqyU3M6VlkHsTYF1L0d2qNwqIhGRMC2inJaN3A9oCDwNnRoDFLp/EN96aDoDZCMZ0nMCeIH/VHa3Zm0DqTvxGsAVwHD66PvTcK50p5Q+IWyVAcAMt+BMbRe4KK+qMgv+tP4T/gUh54o7EXwmVIwa0tjsaXD2yXHm39jNAsfm1+MLprlnRLDpTg4YlLHOhaJ8YbA0nErcWh8l1ZHY1oHsw+p4MPcYIogi1msaL0cqIrQmTsFpRZtNAoVtLwd+KO3MP0E7Bjsg5Uh6gvbWe+9EwvYw0DDVhpTB2fTkMw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnKuB6rGqtydYrBnBNDeUSzx5uqThcfD/S8ak3IVQgI=;
 b=PyjkuY0vQlXQj78qxM9EvBfFQM4lLp6ksO70C3MUcIAp1eV1krNxnR7DVCPV47o1m55Vnp/jqnBeGz0rrmSckOwDXpK4mKnTfl7DT6k2zBe2KTJXLwQxrIZIzCW2SWt+tw7JoUX/1FFkNPzp/v94LICPXLjPjkYqq0NstoPw1t3jQFOsc+ESMADT7mf4b6PY6yyrgwky/JkWeMGmstdMyRPofEAITEdu7XJFaX59T+gq/SNeSD28/MTVhETNUrLn2uXqvsvvz6vb7cPSYFYo5JmytHaxIUM7v3Fkuw4gbgy6tWL+YdMmZq4A/RWQOI6/Q7Tp/vUIKDuslx5OMlP8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnKuB6rGqtydYrBnBNDeUSzx5uqThcfD/S8ak3IVQgI=;
 b=rxWzN/vKynwp/HnQOeFrrvDE2+j3/oYNsrX6mnconjW7N08q9HgRtBb6c1LPo+AD2que/gZzSWjPZhA34i0DWYl5J+y0+EK9eo2BeCH7aZfF74PjFSRZqFm5ShfBFfxjH/cR2kBuxhy+EoUlqAbs8pch/NYdC1h8dQuI1O5fFX03liXDBdbSqK4KWSX18MbtFI3+uhL4U8kpxwsFV7LIdztDYf5mM5hF9d25peniSvVznDChdHlf3mSe8wTeLw5XuOyrp+7xXBMrFwb68rQUS4F75gjp0DDk3OtwPqEoj5oTFfiUu/LQVx5jhQLVN/LkujalTbCOHG4xz3wZ+XI9Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7401.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 09:20:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 09:20:12 +0000
Message-ID: <4f31a416-b22f-41d4-abd5-c035d2e064a5@siemens.com>
Date: Thu, 25 Sep 2025 11:20:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: Propagate debug build settings also to plain
 applications
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <0d628811-9955-4fd9-90a2-27be551dda14@siemens.com>
 <587ea11186ed7eeb39adc4959b7f0ec7b299d08f.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <587ea11186ed7eeb39adc4959b7f0ec7b299d08f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f128eb-c55b-434d-7750-08ddfc14bb16
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVVMUy9qQlA0eWJyUVJWRHhqMW0vRE1RRGNiVVZmTVUzQVM4dDRVeHk0THNZ?=
 =?utf-8?B?MUVMUHBUTEpUNlJ0K3piR3g0MmIyb05nb3BoVHViTGowWEN1T0NIdjVPZExo?=
 =?utf-8?B?TExFSnVVUXhLRGNmVDdaMSthc2VKdUF3eFpsM1lueTcyN2lnT0FaMUgrK0V5?=
 =?utf-8?B?amhXUU9PcTkreUorM0hxckJ1Mmt2ZXBHM3lxdmdWN3AvSmJvNGpON3BZdkwx?=
 =?utf-8?B?K2p6UVJWM2lMRUo4R0RxcmFzZUlLQXZsdEw0cHBMaGpRdGl3VUd2R1luZnVr?=
 =?utf-8?B?QzdkM1V5RkZFY21KeGttaXF4dXZwQVdmOUFGQzhLVk4zdG5Ta0NicFI3UkJV?=
 =?utf-8?B?aXU3aG1FdVA5WmxBcHEyVmQvRk5lRzU0ZXA1ZUZ4azVmZ0x6TEhabDBOV20z?=
 =?utf-8?B?Yll6WUtqWVFGcWxzRkJXYUwraGJnQUFDcFBKeUtPZno3OHhUT0lwTnFURjFm?=
 =?utf-8?B?dW9lejBYUzR2aWl0dmRBNFpsMGpENmZ2SW9LRDQzSDd3SlRzVlJyR0UvUTlv?=
 =?utf-8?B?RjEzNFdiNkppSVdMTVM2UE5ZUXhrc1ZUT3RMeEZVSkJOTTlNazdMaXRueWVJ?=
 =?utf-8?B?SnRDS3l6ZTNnRGZ0Qm83L1hOOUU4MHdkd1BER0htTlZEMUxDTnBUMnAwOXNH?=
 =?utf-8?B?WkJZanpsc1JESit4M3dHcHR3ejVEZUh6TkdCNUJhSHJIS203czZsVzcwUjAx?=
 =?utf-8?B?ZDRnTEhOOXN2VURSRVNvckVZcUQ2QVJ3ZGRGcmZoNUhPcGFtUE9CRU9oRU0w?=
 =?utf-8?B?Zndva0dwT2szMTl6WURHTkJXVmFtblcrcFhOL1pJRnhualJWYkJuc0RuU1Vw?=
 =?utf-8?B?K3p0T1lxTUdNZEZjR0k3UzNLa1BlVTdvUFJKVUR5dDNDa1J3Mi9jckJSK1Fn?=
 =?utf-8?B?VnVjdjZrNy9Ka2tYN3ZXeXNiUUNnZXZFWTdDNEQ3U0c4dmRROURwWHVZSDd6?=
 =?utf-8?B?QjZuL3pvMVdjZjloL1FkbFJONElxWSt0b2t0UEo1K1oxMTFrbTZaTHhIWTE3?=
 =?utf-8?B?YzdLZG5Ub0pLdUtDRmttNGVhbWU2ZGlXNytKaGx3N3YvWTB4cVlSeTUrc1Ft?=
 =?utf-8?B?VndUOFlkaGNURGJKbFVYT3AvWFFNczlES0lKYjhCdzN4c1Q3aTRKRjUvSDZX?=
 =?utf-8?B?NThud2lsRmw4eW9LaWZ2T2FYaWVQVVRWZGxYNE5IMSsrbEY2UVp1NzAyU09R?=
 =?utf-8?B?eWZJbzVINEtvV01QUVVNeUV6c2Y1TjRuSDBlMlJkblVsNFBRQURxRXpXdDhV?=
 =?utf-8?B?cllQbk9JdXNWZ01pSGZ6VnFvbDhrd1RZNmp6amcySjRFWi83ZzlWZWZlZXdQ?=
 =?utf-8?B?N1ZpM2Y3Sm5pRzg5K2JuZVRUNUtqZTRFMzdFc1IvWExCZ2h2d1lDUDhUOE9N?=
 =?utf-8?B?Ykh3d2dYSkZhemJLRHlNMGlkTytNajFPZzhnRkhnUXJtbWJJbWJTNlJqMlpR?=
 =?utf-8?B?amkwS2IvUGFlZVB1ZjhyYWZ1RjB5cG5Wb2NQSGNhWEpJUlpVVDVoUW1qUEgr?=
 =?utf-8?B?Q0FMM01ZMVRKd1ZUNllSRW5ES1FRSXR0eGFiTVdOOVllcDdOekRHR1hoTWU1?=
 =?utf-8?B?VE5iWjRRdEVZV2FLMXFvLy9hK0puYWJkSkllTDZpLytZMUJpc0F1bDNWL2Q4?=
 =?utf-8?B?ZklaOVdrZ1dKYkVKUk10SVpVaS9vMDdrc21LVUdVREtZVDlYQ1JBWEwwQldn?=
 =?utf-8?B?MWdZZkpwM3FLWG9wT28yQW9QaGQrYmQ0ZUlOWWdvL1BtcVBOT3d1RkJ2azg5?=
 =?utf-8?B?TVh3d2ltRFpySW94SzhXZ0xLOGtzdjBrT29VenorejZOYlBmTjFzU0tPMXNW?=
 =?utf-8?B?SU93TjRsRlg3UjlRY3N3b0Z3TUcwcUZhQkgxc3hHL09IM3FhR09vRFdwOFRr?=
 =?utf-8?B?YW5tNVJRR0prTUdTVVdMV0VrRE15bFlZVXIvRDVwVlhJOWZHRjh1OUo5YlA3?=
 =?utf-8?Q?qCo3TBYn8wE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFgxV3FoY2F4aXNCUlZCalVvYXBHWGs5TXFKNDhDLy9xZGZpTU9IVk50Z3dU?=
 =?utf-8?B?eUIzalhOMGZtZW00OUcxSjIxK0p0ajY1bndpQ1FFZ0I0akpMN1F5R3MvRXJw?=
 =?utf-8?B?T3R2VkwxQkhqSnhPa2xVVHdsWGF6Y0VwVjlYK25Hc0pVeWhYMmtwVm1qMmky?=
 =?utf-8?B?ajZUdS9HYUdQc2lHcEdYdmtFQVY2RG4yR3JjVy9HMXBqSGZSZ0lnS0hIT2ZN?=
 =?utf-8?B?bHNpdldxN0JvbytmQTA4ZHZ6VHVudXZsNzJRQWl4Z0xsT3FmZFJ2RWJabHIx?=
 =?utf-8?B?aldtQ0lDL1ZzM09XTWthdmtFTjJTMzNLV3MzRWJVLzdScC81MURGQlp0bHF0?=
 =?utf-8?B?MXNPOEl1NmVucFBCc2NCdHAzSGRBYXUyL2xDaE1nUFJROVdzY0QxanN2UkJk?=
 =?utf-8?B?ZVcvMGowalZoZEplbjgrTENDdUNmU3lkRDcrSjhNTUNDaWJIK0xBWTQxM2di?=
 =?utf-8?B?N1k4dDc5RER4S0ZwbGlWbXlvQnduTW5wUVRXMVZ2NEw2TkNtV05wT0hVb0dy?=
 =?utf-8?B?WENVclliWEdFQVRBZUNHNG5HVXMvQytKK1ppendMRTFyMlI5KzVCb1pHTVoy?=
 =?utf-8?B?cmJVTnNSeS9KQnUveDl2TUtqamVLa29VMW0wTXBIamlFK290TGNHM2FrdG1r?=
 =?utf-8?B?a3JsaHpCWDRNa3NVcHc1ZGljeU1veXFYam5yTnNSUktuOVJ5N2YzTjBnNWE0?=
 =?utf-8?B?RDZERkl1bmZVZmpoWkdibGNSRElaNXV0Q2FuQjdxYlN5Zk1venA3SDJ0WTFV?=
 =?utf-8?B?RGUvUHAyUVhIeTFBSDI0eERZZGNUUjJsRXVTaWNmd0dGRll1YXk5RHRXRkFI?=
 =?utf-8?B?eVBFWXFvN2hkU2RRQkhIbFFXOVQxMllBMXdzNGhBU1ByRTRmT1hnOG9VN2Zy?=
 =?utf-8?B?UUdHSDdOMHN5NkpXemhhb3NFSm5FejJWWm9RbFlKMGlQblZRMGNGYzAwbDJU?=
 =?utf-8?B?WW13M1E2bnNDczZzemVrZVBNQW5Dam8zK1dLN3FocWpMcTZqc1dOUklteFdS?=
 =?utf-8?B?NThwZE1rWVhEcUN0Z2N4QkZvWVVhdm5sWDhOeU1pRHJEdzkrdy94RjF1TlBU?=
 =?utf-8?B?UEVpS3ZNMnErVll6Tjc4SHUxVVhkZlhPTCsrOHV2a21ZcThuaXVRaTRETERD?=
 =?utf-8?B?clN4bCs2VHhTSWo2VmpkRFZpbWJqRmsyNDUvd3Z1dCs1WUZ5ZXNNZDZGODdR?=
 =?utf-8?B?YzlNeWM4Z2hnSjM0OFhnYk8vdjVXVzBzNjdvTnVHRkRGcEZnTnpEdWNKSHBs?=
 =?utf-8?B?Rjd6V1pwS2lKZlMxNmptNEFPcDZ0WnE2YjFMTHFOcnhsOElDNysrbHIrRUR6?=
 =?utf-8?B?NG1jTW85aDdmTjAxQTF1UEZqcmhkR05FVnh5UG5DWEtlUDdKek12ekdtK3d5?=
 =?utf-8?B?Zis3dTcwVC9DMmtoUzc2RDlNU3QwK2RtcWx3ZXd0QUlxZjFscURCWEkvaWJU?=
 =?utf-8?B?cG5MUzY4TnZZbXFYaEVzRzVrTVJxUVd4ZFp2ZzhpYUJHYnRjaC9pMzdsK2dC?=
 =?utf-8?B?R2xOWGFUM1RLYm1EYWh5aUFyMUo5Mkd6a2ZmRExuN01OMXdndkdFQ1NQQzlU?=
 =?utf-8?B?bjhGRCtiYjhJMTRaQ1ZTYW01a3FrM1hOYU83UUdTbUtGK2lpdElLeDM1b1p1?=
 =?utf-8?B?ajg5Rm1malE5TTFqNHhRU3hSMGI1UkdzTjhqYlh3SHExUkIzYlQ0UHlFbmY2?=
 =?utf-8?B?eVdMR2JncjRTbEJlR2dITDdHWVc2T2ZtQ0EyenVWU1o3YUEvcHZncFVLOElj?=
 =?utf-8?B?VE1nNHVnTmJKVG1zcC9rVkV0dlBSS3A1Q0JRSkR5aHg1by9QOGIweTdNdWN0?=
 =?utf-8?B?cHpyTStoc0piQ2s4ZHUzUHc2U3ZyZzBBNC9oV2x1alZ5bElWYjZhNlprQ3kx?=
 =?utf-8?B?TjhvWDFrSjFLa2VtN3AvcUJPT0NSb0VUZlhZYTJ2MEEwN0s2RmFja2tyWG1p?=
 =?utf-8?B?bmZtWHhBSksybGJVeVU4dU1JZzVRaExaR0EvUm43YnZSQXF2QXdGamc4N2Jw?=
 =?utf-8?B?YkxVTzBrNWxSQzJnbS9EK3BvWjVHdEc4cy92Y1J5YVcxaS9icjFvR1NBQjBl?=
 =?utf-8?B?V0g4OUlzMTdTSitHd3BRQXlxUDFqb1h0VDcrdTJ3d1dLUE9BczEwUmZKMGh2?=
 =?utf-8?Q?y0VHsY2FP9lH9HLhN+leu6u7O?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f128eb-c55b-434d-7750-08ddfc14bb16
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:20:12.6444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAYjLGMEwSJbpgHBuwxc6MLW6hFb77OKY94wmBQr/kMCa1+Jgj/iiZbu+9AazjFgvQzc+gYEsCNnK9FQKaPXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7401

On 25.09.25 11:14, Florian Bezdeka wrote:
> On Tue, 2025-09-23 at 07:43 +0200, Jan Kiszka wrote:
>>  
>>  if test x$use_assert = x; then
>> -   XENO_USER_CFLAGS="-DNDEBUG $XENO_USER_CFLAGS"
>> +   XENO_USER_CFLAGS_DEBUG="-DNDEBUG $XENO_USER_CFLAGS_DEBUG"
> 
> We add NDEBUG to the debug flags? That looks odd.
> 

...only if assertions are disabled. Naming is tricky here as we also
carry optimization switches in that variable.

Meanwhile, I wondered if we should bring the FORITY_SOURCE setting to
those apps as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
