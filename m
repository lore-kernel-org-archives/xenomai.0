Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7201EB5FE
	for <xenomai@lists.linux.dev>; Tue, 22 Apr 2025 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307827; cv=fail; b=gODn9WX1KVAzNJDP8xrZF+NCp+BHs3mIe80iO76Lhb9x1uJ31pcOX1RPTOqO6Ql5ZQNYcFsHUftRCJTbUmJcLP3j/fSZ9ZU97v0QND6SXPFgriqsOvE0mtaG70tBS645ntcZGm8TAfGKAAJawbM7b2HGEZ6n2zwu642N6NQ4lRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307827; c=relaxed/simple;
	bh=e/8vg5+MYjzIr3g24wmKYqMmL1Z6oaO4MCzF5IYQ2v0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ovwl8jXxoQd0j+BJUVEeJigrh8YyfS9NGiuZlGAM+QoK0oV3v4cEQO/W4iOosy36TinEUPU66eSl10GWOf2BSPoAxuDxUMSlUCq5xHwBDewA7t9l5t/RVqwVXm1zlpuxaMeOt7hGuXZZXS2MsfvP+mg2gzqyBzkhjGx0/kvGHn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=d+GC5Ov3; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="d+GC5Ov3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjAWeAFlGRvmnlH54hiRKDkpO0jFujpVHgdsq/55I+YNqEVtdpRa+Mx1mxESyHfZgwR749FNr2Pv1nCUZEd5aKlQHJBtNVy4Mz1SRvuvvhxLDd+jDeipRBi8Mr219B/D/zd0H7uB6WGFalO1K1pdp0ciFk1UBkKaRMZTjFdA1Z8TRAw2Bv7uI/VPuIyj42NqRL6UwBu7sR1h+BYMgngOsNiXQoimb7l9Qm0DiunwOt/4ogF+FKBg5BdqsUXWG4HXpd1gxHNzSWI4MRJIVGSuM1Ua6tkbxq9fFf7aa+kqt8Wjw8G//xPVbqCjJzhuXZHPv1viOP6JkeyfjJ83LAxWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KInFhVRCNs5+dy12El8FtNo3EW1OI5JUmeGkXeYN/YM=;
 b=r0pdinRQJkf3Ellf6tEYhY7LIEUTLSsvmNFn+Lz78c+cZklpw+UzKo7h/fpTSRRoibvcUwyfbq0ZOfCOsysbXxd1HsOLOo3HZ3EJ71tp6L0a8IDnVa9TmzcrJAm/muZ5dokEd+MoPTksZxofzQI+tmTztSEzoFmDtk1X0Q7D1CSKCUttTUY8GbVdhjtQo2YyCXymnTjQt1mOpUMXiMc1sIFhl9Byc9k7TU2pL85WtdUo2gTUSJ4iCRam8jfHLpyIJ/0yq0xUiClJTBS3tB5spRWoFBM3R1oi0gSTW5UK0lBBJGm/AB7rXddsWZGiM6Fjt1vIzJ9YLWc+MscxovqYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KInFhVRCNs5+dy12El8FtNo3EW1OI5JUmeGkXeYN/YM=;
 b=d+GC5Ov3Qu90lpELe/KfNoF4sKRZd1KJhrYybh47eKwW4iVMRVktr6nVR9mrpEx+WLjkVOtYjNy6bAxU9lvaPoWjF4GBu/WZA4bfWOjVYWINhinq3Xpt0kMzjpPrmtKGhbelBV1DMnNAQsyNP8NokJHxOEDv88exF/OHpHS+vu+hzc+bcVlap1VPnp7j+EuJrhpTU5gK2hy9+iTI3hvOj3CgDtHTGsmVQUbqEJko4nMizt2u0I26XixU9Jg3dCIOTeT5zYtwFztBn2yD2Hfrt4svKuOo3XBP2wp9LYgevrgWfRlaZAKIzHDXl5EnR99BcUJPd1jiMXN9R3me2At9vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAVPR10MB6885.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 07:43:41 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 07:43:41 +0000
Message-ID: <9d66437e-e385-4356-9056-acb74306cb4f@siemens.com>
Date: Tue, 22 Apr 2025 09:43:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] demo/posix/cyclictest: Fix building with glibc >= 2.41
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20250422070033.648810-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250422070033.648810-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAVPR10MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7156a3-4756-4c55-d681-08dd817166b9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0dvVnR6aFF2L242LzIydFhrNnZGbEFxOHcrQllESnNqekhva2JrekxzVElv?=
 =?utf-8?B?TDh4QUtOT3NWZTArbDRJSkVEQUxmKy9SNkJER3FsZnF0S1hKdXEzeUZQdUV6?=
 =?utf-8?B?aExxZ1dmWmYwSHYrNStIek1qYWtybVYzcnFjaXgreUJIZmJpOUQxZFBNMXJ6?=
 =?utf-8?B?eFMxaW1ObWNaQ0pFN0tkSjE0MUJReGZVcmxOMDd1dU13ODJGRStFNlEybXdn?=
 =?utf-8?B?SmtjM2ozNHUzajRSelB0eWxCVXFubHdRK24rVDNMaHNlL05IdC9hRUdIMHhH?=
 =?utf-8?B?MlhrRDgwVDBYb3YyZnFZdExUSUdqOXFBUzdrVVpvamhJRytLdVVFcWVOZHl0?=
 =?utf-8?B?cy9HNW5SUGZLSHIwVjN0M2o3aWhwbFExQml3Tjh0a2hMWmZqM1lmWDlGMllL?=
 =?utf-8?B?QmJNc29ZVVJ4M2xVVW5LYmxwS280WUpuQUdwTTY1MkxnU1gySmJNVGpJdDFj?=
 =?utf-8?B?Zy81N3lmNTh0N2lXMy9Xd05FSVJHb1dZL0VUZzExYmRMQ29iVFFLNGdRekp2?=
 =?utf-8?B?cXRQTVZyNUo0eWMwWUQxcEFKUHo0bFgyUGMvNGJWRjFrVVZvTm1Dc2N2WXRu?=
 =?utf-8?B?aTZlWHg0bnJ4cjB3RGpRREd6ZHg0bE1hTE1LaU1CaTlLTHZpS05rc2pFVHJV?=
 =?utf-8?B?ajBCdDRuSCs4VlQvZitRRHI0VTVlTVprczFPSXladEs1QWFJZ3hJVnlFOHhL?=
 =?utf-8?B?RWF5Q0dpK2F0aHJsV0pWWDl0VXduVTg5VUxxSThHL0NiYitNN2RqRmdtSC9Y?=
 =?utf-8?B?R0M3NWUwd0FsaDdBWUxtbmhEQlBDNW5oRE04YlQ2dEVPR1FvY0pGZUxMaTZF?=
 =?utf-8?B?RGtYVUZ6QWk5dmtVRzk2bDlqMHkyMisySy9yVDFnTlc1V2p4ZzZjVlZhUUph?=
 =?utf-8?B?aW5aaFE0UDk1b3ZwMkJIZWQwYXhkL01uSzVKRlZ4dGlOVTlmTndiNjVlSXBu?=
 =?utf-8?B?OFR4NGQyMmZkUi96RVl2M0xXN2Q0MVRNZVlTOGMyUTE5MkZJcmVOdG9seGdM?=
 =?utf-8?B?allvN0JkOFFyZGFwSzcyRVNIaU1wNjRrd1pwSEtUUkY2NzQ4dnVmb2JkNlQ3?=
 =?utf-8?B?YTFmOENpbHVQeVpYQU5UVFJmTXg0bDV4bDFrRnJyRVp3TkZJa2V1bkFMelBH?=
 =?utf-8?B?TVNISFZ0WCt5Sy9INThlNm05ekNGYmFsVDl6QitpZlNjMlRCQkMzQzBjbTg5?=
 =?utf-8?B?TEl3cmVXR3duUW8rYjNWQ0RwakRoSmpCd1gySE9wdng1V0x1M3h0TEUvclU3?=
 =?utf-8?B?QnpYMzc1ekoxRXo1SDliamo3N2ovVXF4cEJQUXY3bFZrTkdhcitzVnNpbkt5?=
 =?utf-8?B?MUNibDRwRm91UGtvVng2d3BvWm52MVpiRHJ6R09UMzZuTWxwdkZFMXhJZTBW?=
 =?utf-8?B?ZWVFVXE1aXJvZkRHMnpGQ0ZLbXRTczFxM2lWZ25iZ1BaZzRaQ3F3UFpxWTQ0?=
 =?utf-8?B?M1dpRG5jUGVwUHVKWE5zQ3BHOUI0K1hWdmFuVmd5SzBKTFdBOUpZaXdWNytW?=
 =?utf-8?B?WWtHb09DalZGUVp0UzNTRENUdS9jbHZ0dmpubS92dWhFUkZwek40ZDZTN1hR?=
 =?utf-8?B?anZSc2kyZVA1WXpuMFBwZytEd0QzOEljVE9VYWlocHE3bXY5dkRNbVdPVHpC?=
 =?utf-8?B?ak9KSVVWYmVsVlZNM2pPM0pVN1AvYVVOei9NTStjMHBBRHNiUGdidjJveVg4?=
 =?utf-8?B?TlpQR2VRWERVVG90eU1iRzFWeHAvbjFLNDN0bnkwaForK2syNDNCMFAyVERC?=
 =?utf-8?B?OTJWZkRwdFZ6UGd0RkZSYU42czdpSGI4cmNiRER0VXpOU01aeHhxbUxsMy9h?=
 =?utf-8?B?cG9nejc2OS9IZVQ0NTcvVHpFOTRIWEIxYm0zVDVtUEU2YUhTMXlERmNyZ3BI?=
 =?utf-8?B?SmM3cjk5TUVqZXdzblhUWncxeUlIcUNyeHJZNzcxMHp6Q2lxUHZNdUQ3MXJw?=
 =?utf-8?Q?F5Cg9VOqlLM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MERDRnFaQy9QRzYwc00rQVlhVnRwd1FrbGI3NTBsUzZIUEt6UFl2VEJUa2JV?=
 =?utf-8?B?MTV0akl6T2lqSHFPQzlYMUJJb3VHRExaSDZUS2NGeFlTaGVYczFPZlJRVm5I?=
 =?utf-8?B?MjExc2YvNFh1NzNXUjZaeU9NOVdodndGQ1FVL05yeXZIbzJYdHlYVC8ydUFO?=
 =?utf-8?B?N2ozbVBOaFZneW12UGZDNVNIQjFzVW14SWlDQ0RJQmZ3V3IxcFAvY2NOa29F?=
 =?utf-8?B?TVFpVWFrQXA3RU1ISDY0RVhVZDd1cDR5c3FDMHZ2bm80MFBTZ2YzdTc0Zmw3?=
 =?utf-8?B?NVltTlBQR2JVUmtLeU1jYmQxV0s3N0VwT0ZuWGlqLzBrKzcrRFdVSitQRk4w?=
 =?utf-8?B?dkgxZ0FnV0Y4d1dUbitZN3hsUHVtVWlxVDlIeW9GckhLc3c3ZnU4U2xvTXlk?=
 =?utf-8?B?cWpDMkFhQi83Nk8xWlRGSmNsTmQ1MjNuYitLYjlOV0tnOFB2Y0RPZUxzTGZL?=
 =?utf-8?B?T3NtTE9LUnRqcVkzc1hxS2ZVenlKK0VaQllHYmJYVDdXMVdnZkU4dElwT0M5?=
 =?utf-8?B?Y0Z0d2VPb0xNdnp0bFcxcnN6UVJORDlzK2NLa1JYS205L3hkclNsL21jdlow?=
 =?utf-8?B?RTl2TDgxTUdrRDZHNlpoc25YWDZ2ZHVmQ3pUcGM3RXVzeGdLUWxwZUl1ZkQ5?=
 =?utf-8?B?b1NtREdhVXB3NkQ3YmpVMkUwaG11YlJkWWxtLzlzMVpJT2dHTU9UMlRoUG1D?=
 =?utf-8?B?UVNtV2YwMUpYSmNPcGg3OGJkUUdPY3k4NHZ0TjltcDVGOHFkQnFEZVMzTlZ3?=
 =?utf-8?B?QURwdXFWY1hXMmVtaDZPd003OGhsc1laU0tlRjhYaS9HOS9jUlN4WlpBNFpE?=
 =?utf-8?B?ZWcwNjh2WFRzR2k3REE4eFNsL3FQRDRxU255WWtxQUVaaktuZHB1T0dkR0hn?=
 =?utf-8?B?VTU0aGdQNE16eEc5Tnhia2dJWWgvU2RGVmF1NzVrbnZXcGNDQXd6VW9JNkM1?=
 =?utf-8?B?dTJ4b1p6TXExb2dVSWFlcTJxS2VpM01aY2x5cUtpdHdpUytNQzBGeDAzSWRZ?=
 =?utf-8?B?NVpidkJQLzZ5L0Fzb2gzd3BZdnptUjA0OWhPVkJYaS9QN1ZuVmozQmFoZlhD?=
 =?utf-8?B?NlR1a0d6WEdRQXRJMlU0R3pRdlZIS0NJYjlqSE96QWs4TkdIQXVIYUN6UGlG?=
 =?utf-8?B?TWgzdm9pVzBVci9uQVNadGdxY2cwRTZsa0ZwVmFETlRVcS9mZUx6WGw0M0hF?=
 =?utf-8?B?Zm91T1JnZ2ltcWdIM1NXbkEwK3VhQS96TTBJcnZKV3NBS1R5ZmN2dlo2RW92?=
 =?utf-8?B?VkdWeE9qeGVQNkNtQW9TcGtubG9QbmYyd1hLR2pCYUIrT2hqRnVoSDFlODYv?=
 =?utf-8?B?YVJRTUtrVllNMDc2RkFlMlVmcG1rTDZrcWgwbUNuRElkb1dtcEFiZk4zT1pp?=
 =?utf-8?B?Z3JYTHQyd01mY0VUcjc2V0JGMnMzdks3czNxRzFIemRJK0J3WVVEMEpEQUhO?=
 =?utf-8?B?NVJPNGFiZkZUQW9XNGs3U1duRlUrRG1qZ2tyRnA1UW1KcHRsaldERlhveStB?=
 =?utf-8?B?V2VIdTFuVHJBS3VQSHlGclZZMXpjTmp0cWxhQng3QVN1UTgxRU1yWithdTk1?=
 =?utf-8?B?ci8xMlZ0bFV2cldlSVRhS0l6WWJGT2cvc0picndlUFRMTUlvTzl5MWFFYStT?=
 =?utf-8?B?dHhwMkZmaUYrQTU4Vks1WERvd1hwYTZaU1FxTjZTSTBORWFoOWZTYXp4azhB?=
 =?utf-8?B?YjJtQWhZeDFuQjJIalpkMkFmU1krNkVvYlFtemxUVXE3QUx6NmFVeEdqMXBQ?=
 =?utf-8?B?TDA4QjZsTDFyNVc5UDViRnRSY2V6eUQ5SHhISHZUREVsVUw3TXpXekZ1Zkdl?=
 =?utf-8?B?MjkwZWYzc3FKODMzM1k4bFA5OWxMcDlONE5YajhYME41NDJweEU1Vmx3Nk1w?=
 =?utf-8?B?Z0doUksrZlR2bXlrelgzRVBOcnRVNnhrWEphdTNRU1MrdW5hbXdzV1M5RXd0?=
 =?utf-8?B?aThzZi8zYS9ESTVjWG40dHlHUzZ3UGROQWdNYWxOb3FjQkovM0dCOWJMWGRH?=
 =?utf-8?B?RzFubFZXdGU3ak5Iazh3cS85OTE0amFDdndFK3IrRUw4UVpKRTJGUm4xMks3?=
 =?utf-8?B?RjV1VEZPeFRRWTB4WHlEcVVVS1cwNjR0K0NISHIzWFZWTEFwVTFEa0p0SG9J?=
 =?utf-8?B?SFIzK1pJQS9IRjIrM1dDMzRLMmg3dTY5QURLalFVTndqSjZPcHZWMnlZNXJo?=
 =?utf-8?Q?Qolrq81qSBiWuC4koURkuSMdODnH7ftsFxMQ6anWSWKe?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7156a3-4756-4c55-d681-08dd817166b9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:43:41.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xjz1S9KEXertHUdhc94/D8ZSn4WjzHSF8XHYV6XqdxNEbXL7Wbx5D4Ies21y6+d5GCDwH/kqwXo2264i1OUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6885

On 22.04.25 09:00, Florian Bezdeka wrote:
> glibc 2.41 introduces wrappers for sched_setattr() and sched_getattr()
> with slightly different signatures, so gcc (v15) complained about
> redefinitions.
> 
> We can remove the prototypes from Xenomai as we never use them.
> struct sched_attr was only used by the prototypes, so it can be 
> removed as well.
> 
> The only remaining piece in rt-sched.h would be the definition of
> SCHED_DEADLINE, which is part of glibc since 2.26. For the Debian
> world this predates Debian buster, which is currently the oldest
> supported version.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  demo/posix/cyclictest/Makefile.am |  1 -
>  demo/posix/cyclictest/rt-sched.h  | 61 -------------------------------
>  demo/posix/cyclictest/rt-utils.c  |  1 -
>  3 files changed, 63 deletions(-)
>  delete mode 100644 demo/posix/cyclictest/rt-sched.h
> 
> diff --git a/demo/posix/cyclictest/Makefile.am b/demo/posix/cyclictest/Makefile.am
> index 248e40690..15f157ab4 100644
> --- a/demo/posix/cyclictest/Makefile.am
> +++ b/demo/posix/cyclictest/Makefile.am
> @@ -21,7 +21,6 @@ cyclictest_SOURCES =	\
>  	error.c		\
>  	error.h		\
>  	rt_numa.h	\
> -	rt-sched.h	\
>  	rt-utils.c	\
>  	rt-utils.h
>  
> diff --git a/demo/posix/cyclictest/rt-sched.h b/demo/posix/cyclictest/rt-sched.h
> deleted file mode 100644
> index 064e51c4f..000000000
> --- a/demo/posix/cyclictest/rt-sched.h
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -/*
> -   rt-sched.h - sched_setattr() and sched_getattr() API
> -
> -   (C) Dario Faggioli <raistlin@linux.it>, 2009, 2010
> -   Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner <daniel.wagner@bmw-carit.de
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License as published by
> -   the Free Software Foundation; either version 2 of the License, or
> -   (at your option) any later version.
> -
> -   This program is distributed in the hope that it will be useful,
> -   but WITHOUT ANY WARRANTY; without even the implied warranty of
> -   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -   GNU General Public License for more details.
> -
> -   You should have received a copy of the GNU General Public License
> -   along with this program; if not, write to the Free Software
> -   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
> -   USA */
> -
> -/* This file is based on Dario Faggioli's libdl. Eventually it will be
> -   replaced by a proper implemenation of this API. */
> -
> -#ifndef __RT_SCHED_H__
> -#define __RT_SCHED_H__
> -
> -#include <stdint.h>
> -#include <sys/types.h>
> -
> -#ifndef SCHED_DEADLINE
> -#define SCHED_DEADLINE 6
> -#endif
> -
> -struct sched_attr {
> -	uint32_t size;
> -	uint32_t sched_policy;
> -	uint64_t sched_flags;
> -
> -	/* SCHED_NORMAL, SCHED_BATCH */
> -	int32_t sched_nice;
> -
> -	/* SCHED_FIFO, SCHED_RR */
> -	uint32_t sched_priority;
> -
> -	/* SCHED_DEADLINE */
> -	uint64_t sched_runtime;
> -	uint64_t sched_deadline;
> -	uint64_t sched_period;
> -};
> -
> -int sched_setattr(pid_t pid,
> -		  const struct sched_attr *attr,
> -		  unsigned int flags);
> -
> -int sched_getattr(pid_t pid,
> -		  struct sched_attr *attr,
> -		  unsigned int size,
> -		  unsigned int flags);
> -
> -#endif /* __RT_SCHED_H__ */
> diff --git a/demo/posix/cyclictest/rt-utils.c b/demo/posix/cyclictest/rt-utils.c
> index 3882d2375..cf3367b3a 100644
> --- a/demo/posix/cyclictest/rt-utils.c
> +++ b/demo/posix/cyclictest/rt-utils.c
> @@ -18,7 +18,6 @@
>  #include <unistd.h>
>  #include <sys/syscall.h> /* For SYS_gettid definitions */
>  #include "rt-utils.h"
> -#include "rt-sched.h"
>  #include "error.h"
>  
>  static char debugfileprefix[MAX_PATH];

Thanks, applied to next, considering this for stable/v3.3.x as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
