Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33A221DB6
	for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763011920; cv=fail; b=THONbUUgUzntytthzKStGwwvekJlrz90bC1LnWmbcLvYoZRlMOkri9H0gih6inN0yBwCRH3vs+71gephGd0WKing5k2D3Cp2BhdVK/oWcK++9Af9xJL6vV0+oPZHEILCO4+s7Y6+UoEsEq3ZpM+h1nUSfIJjWp9PhzkYQz0HsMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763011920; c=relaxed/simple;
	bh=wtVzKF+dACG6A3+5T57IVE6B2t2TcFYsoW3OwZhvkcA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nWEUE4XN/O6MUmyGm8F68eme61UHt8GxyEjkCYXckioNvktQFJvTDh6+0ZOxsyYZTtBhQBZU2t3G2LeGPCJGepQH97/rZGd+t7J/pSPvpRZiq9UkEzPUNR6tqIQnDDwaU988vUHRKZqT2++uXRKzJUTsfxJEEw2zZeBEOvxsaEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kC6Qna/f; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kC6Qna/f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BG/V6UdZJceRoQUQEjU5d6YRG19pXtaalOSmwcnZJYjtVkB44ZABkGysYZJSpcZY56EfmfDrULIf/6yvTRlGZ/WL9pjB4Z2PVjuqO2rX/GJci6DpL/90g28gjBaeZO+V0dgMSP5Yp4r4DzqOfd+M2iLJBETx0u3AD1Gg3l6gYqrevcOk4lXIqgRAlAmibR6bSCjNLxEOPf8+wJkOR2RyeOwmc/6FBMaaOvJzp7s23aE0G8MA+FyEqizZVBonGfMl53GOf9BdMmdLkYQbKdnmgVI41qFLaKK0NXoXvsrsLZW+MrdBnyNmJnDQczXLtWB8KJtPJoqB/rn8gkY/SFY/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaS+WtdRd2jd2iima8ADWLy4BbgoETPi9E9Du+Esm/o=;
 b=Fxmv+77Kn3eXB5/dw5z6mpt1q3fQcbVeLHM+7aItmHaGA6ozYx9vADekvHkJybu+G4JYqnMKEThUCC4WtkPeSDUc8aK1BvcNoVUCwQydcr9NTELTTIldaMkKR4skORMObaE5L56tdHcA/SyKSC34Ul7+3XHqFzQAGAAzzIsPZAp0bw4nKR9QOrYkXT37I8b1pcyXJi9BXv10jPlwoK6kxqsbM/ftJ47D93pAXO5Lae6QomOI7q/Tq2KXqelOLeixLRF8FaBYDA1TrlGbAxUk4k1BvWJNl8bIE0Z7xVxsnZVXS6BeX8Q7U8wL9shK71Ihe7SE6j2GW2susYjGLxuwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaS+WtdRd2jd2iima8ADWLy4BbgoETPi9E9Du+Esm/o=;
 b=kC6Qna/fsP1w2HpaldU3EUup8bNjPzHGTx/2VHEsZ/z6LgDBAzEe5iZn1MNw3qLnQOmKpwVpiotonHGdzQNTFkCPD+v+A5/vJijdzmfyFujNfNEK3/xEtiOfILRaXq4JVLlZ2PiC2s7ITqHy25gfq0GshE8byFsgivQwLnazbSvMkQzBJhK21coR98zs/EdHQ/ejmJ7KCThfqBZWAzkwTgIUun1PMZ9DtmNT5XQX3RppXQ1JEXrivy0kBCk2cDyXfrSl8fqzGLdSG2HmmI3PFuph48hiWlH5Z/zxTO96G6Go/ssIpEidIMQ7Oxaii9/LfKaNZgpC5xl4UwvNPu1hYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6132.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 05:31:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 05:31:55 +0000
Message-ID: <077351d6-f855-4034-ba1c-3c9f2b713743@siemens.com>
Date: Thu, 13 Nov 2025 06:31:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: schedule delay 15ms
To: JerryJun <jerryjun123@163.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <4c6fa8a7.4dce.19a76af1422.Coremail.jerryjun123@163.com>
 <d14c720e-021e-4fc8-8aba-340903db0fdf@siemens.com>
 <25a5a707.3daf.19a7b5f1c16.Coremail.jerryjun123@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <25a5a707.3daf.19a7b5f1c16.Coremail.jerryjun123@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c4a708-cfb3-4752-24ef-08de2275f50b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnFQNDRxNFJIVkJtQWRMTm9RU3BWdngvWXNiTTMvdTE1cm50RUhXem5rUkt3?=
 =?utf-8?B?bHo4RVo5MDY4aWhKV2tzdlRiY0tLa3VVYmZwamtzWFJ1RFRTYlM3emxlMmZU?=
 =?utf-8?B?RlZiOVB3b0M4ZE1FYi9MWkxYTTg1UGw0RS9kWlpRMXorUFVPL0ZIM0hHTEpL?=
 =?utf-8?B?Ym5mWkl1ZmVpczJsNytVdzFtcHNSQmVHSStXcEhlempML0RuS1JOSWZWVkdN?=
 =?utf-8?B?bCs5QXFjc05ZcUpuRUtQN0NJMitPQ05nV0tsdUJyems4RjVmRVNlcUdjanNK?=
 =?utf-8?B?VmtHV0VGMHNzMEVGeUdBREVNMk9BSnpnRitNSmN1SHNKMHhDUENLRTZiZmdw?=
 =?utf-8?B?Wk1jSENoNnFUTmt0M3F3bUh6SHF4TTlDbTBTQ2tvVUUvTVRKZGFNVXpMQm16?=
 =?utf-8?B?RkppcW1jT2ZWVmVkUHpuOVo5RmZLMmdlUEdsVHhOK0xVRUJRRE5GUndBdWl0?=
 =?utf-8?B?YTNWci9YMG1OTkovRkNYd3VhT0UvRFlDelVwTHFwSmZRVVdwbUtGL00yajA1?=
 =?utf-8?B?eVk1MHdScW1QUUx5NXd6eGdNUWE3U2dmb3dEVitUUnE0YTdRbElQTVgxd0Fa?=
 =?utf-8?B?aDYzZVcvcE9wekV0SXNPbjlxZk5qam5lUDVBOXZCcWFaWjJzcURzYllrcWlN?=
 =?utf-8?B?WTREaStEQklmK3FnUk5yM3RoVGFJd1lxLzRGWU82M1ZsL2pHZStUaitGMGR4?=
 =?utf-8?B?VHAvRW5yTzNZMlhKSXlMRWpoR1paYjRocjdmZXloaEd3QUpTVUhsT05CQ0ZF?=
 =?utf-8?B?b2RyYmlZeHNMVXdWcDNpWVpYeHJWRkF1cHNEeHF4T0NSeEFJNnJBelBvcTNY?=
 =?utf-8?B?M1FLTDdHUFJqSnlHeVFydGtUZS8vRnk2L3d1ckcvRERqanNuMmFRWmo1ZkZj?=
 =?utf-8?B?UThVbWF0WTl6WC9LVTBUblJqWDFvNTEwOUtLeW90NUx5alh1bGpBYTY1b1ky?=
 =?utf-8?B?cGVhbllOdE5na0lKaThxVHBMUldVbnNwTk5qRlFhNkhKL2tWcVR4MWJDemJW?=
 =?utf-8?B?dCtzeVRsYVZ1NzNFYVUya3RYb3JvNXdaYnVZVk9ya05tcnJib052MjZ1R2Ir?=
 =?utf-8?B?NTVKaDlqNlo1RXJTNkNqYzYxRk8zeE16RGExRFVjRnlwRmxnc21uRWh0VDZ1?=
 =?utf-8?B?Ty8zbFdkU0hCWjd2NkZaanFYZFhRTU9WNVVEQ1NUci9VT1pmTTZTRUt1cmc4?=
 =?utf-8?B?NnlvTE8rWmNpaGYzSmE3Smg4Z1ByZmowWitjcGJPZmpSQjdrbERSN0tDRm5q?=
 =?utf-8?B?K3J4YndKVTU1eTErZzlUSWp0dG8xUE1aNHJrNnVQQTFDTjJrcUg2N3pNaHNO?=
 =?utf-8?B?WElONzVaR2VHL244YlVwcks1OHduZjFROFErN0RCNVZHZFdFajJwQnB1a09K?=
 =?utf-8?B?NytIRUQ2WDhXU200dlB0N0F3QkhrNHU2YmVsTy9pSlNlNE9yaTFweUJmNVVh?=
 =?utf-8?B?SG5VOEpvOWQzbXV4Y1VQdkQrWHZhMVZFM2FoakxvQ0N4cUxsMnJ1V3lDazU2?=
 =?utf-8?B?elJwbUdlbnArKzJjbXZabk1lZVhvbWdJZVByaTdGYnZkSWZZTXBKTUl2Z0xU?=
 =?utf-8?B?NWZqUCtjRGcrcTBHS1lxM1FJcG1teUFKbVkrcFB1YWZsM202eUkvcFVXUW1m?=
 =?utf-8?B?Z3NoZkRpMVdlUlZCcERETXBNR2dsZ2tJT2RQaXBvd25nclFXeDFSdXJyb1hi?=
 =?utf-8?B?Q3hrUmxYenFHcFQ4TzZmRGQwalV4MkUreTczWVNHbGRCSkZITXE3VXIra2Uv?=
 =?utf-8?B?WmVtRzMwUVM4TlQrdlk0S3Z0SzJBc2FnZFJ3RnhJS2xzNnhkY0ljVTZYZzVj?=
 =?utf-8?B?cTZ4a3pielhSY2JVTjg3UmpEN3o2dFJKb3Eya2VQcHRENGpRVGxnSWNPK0xU?=
 =?utf-8?B?aG5FTUcwWDVncC9OWkRCUkZtczBHU3U2R2RkeFdoRUtOZU9tekNicGFReUJR?=
 =?utf-8?B?aVU1eDRQSzlJbktyUGpvSm14dDNOKzQxVk45NGRYYmowcmxETWxSWHFmVGt2?=
 =?utf-8?B?Rm02Z0UrTGN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clVFb2F5RDdLZmtySjk4Zitrc2VwSUFsTEJ1dDJMTFdLbHlaYkdDcXllNDZu?=
 =?utf-8?B?TElndVpGazI4WExSRitQTjlQWTVFMXJIT1F3U1d6YzhsNS9hMTRPWlk1M3NH?=
 =?utf-8?B?S2dDWldENWZzQThWMlgzUThaMnNVRXpkL200SFZBZWpsNytuTU9wdnp4UWZk?=
 =?utf-8?B?UC9CT3pxaTdGVHMrU0w3Mk5TU0h0U1lnTHJjS3EwWGNpMEUvWWhCN2pVQzVI?=
 =?utf-8?B?TnorbVNnUWJyL2s0R1hVQ2NEZVYrUmhrY0Z1K2FwRkdNejlYL1RGZ1pXbmdR?=
 =?utf-8?B?RFkzVlBkRFExQUpWVm9XZiticHpPZTd5KzJzSlJhcTRYUmM2ajBUdmNjQkpa?=
 =?utf-8?B?RlMwS2JmaDN2V1BBQ3paNkJFa09aMmhJOFBMdndqTmNQN1QrcDFmUlMxQlVU?=
 =?utf-8?B?dUZ6TlJ0b0JPc1haM0c1SUNScG1xREZSdklQbUttY0NQcEdyNkZVQVZ5bTZG?=
 =?utf-8?B?d3pkUmVtaVkxbGp0NjVDOGhDMFBPZjg3Q2JtelB3SFhub1VSMWkrSHhVU0FR?=
 =?utf-8?B?dFkwM0c5TjZnNEdxWGkzaEdNOHVqNGdnLzFnOGR2ZElaOElxVWQrUG5YVEV3?=
 =?utf-8?B?di81MldYWTdncUVFc2hPS203a1hVcE9EaVBvbVpKd2Y5Tm1tVGM5SG5FV0hS?=
 =?utf-8?B?UFpXclVOY0FtMlhjQUt1NitvSWJXSXFNN2sxNzRJN2lxMmlUeXhLMHZtN2hq?=
 =?utf-8?B?NHdCTWxWdEEyRkE4UDFlRWtMeDlIYVVtNUduMGhiK29CMGZQSEI2Wnlwalpi?=
 =?utf-8?B?T2c4NDdEWXpRVnM2dnRLOW1NRGRrWldFRmhVTWZRdEJKTkZCUjB4MDZDS3Ft?=
 =?utf-8?B?dktrT0F1WVBob0lEZm9mMUdqU2pCTlVsRFJpRUhabXNiZGV3RXlITENKZ05G?=
 =?utf-8?B?UHg0S0d0aE1HcCtSUDdHQzEyWFNVbUdvRXhkeC9tNnhkWUI1bHZuL1F3am5U?=
 =?utf-8?B?Sk1rUG1mN0VJdTdUL0pZWU9iWUwyOVJ6ek1FNVlaUUc2MmNBb0htRnpJNDY4?=
 =?utf-8?B?OTdmeFhwTm1tdjhPeDF0ODJ5citLMmJGekJ5QjY5cWZBcGdVVzVnT2d0WnBh?=
 =?utf-8?B?MW5zbjQxTVBnWGJTRzVGUHc5MDFOcFFhd0ZzQ0FZRHAzZnRBZS9yWW9Vd056?=
 =?utf-8?B?QXkwR2tJQkFGc0lBbndpUk1FUExjRnNQVzA1dEtZbXcrdFJheG9nQTFwSE45?=
 =?utf-8?B?MitlSTRmMitXa29FWlZDQVBnYUxmRnN1d2daQ1lWREZrdE9RaFlOdllERzFX?=
 =?utf-8?B?b3NPV2JxZkYwdnBFMmNocEpOQXJSL291TkwwNi9CbXFqbHQ1b3l1NHFicDNC?=
 =?utf-8?B?ZnVDUTlRNGx4anFiV0FxYnJkSnR1Z0ZQYVVPY3docHVZSitDaUFoc0ZWeWFt?=
 =?utf-8?B?blVrbE1CR0p6M3FMSTdYeDBJVTN5TFNRZkVPc3MvUit2WWpoUmtxaE1wTHo2?=
 =?utf-8?B?dDJ3bFZwc3RkamNLek4vMEkwMWFYWmRObzRid2NTWWhXTlNsTUYwNlR2blBs?=
 =?utf-8?B?WUFvY3U2Zi9GZXk5VWFLZmQ4a2tLUVlhUDR0ckhjRlFxbXlwWGxXZ25NRWZ3?=
 =?utf-8?B?R05wYy9zM295YTc3SlEzcVp2YkF0RFdvT1UwSlQyZjR4SkZib2RlK2EyUzBw?=
 =?utf-8?B?SHNFa3hxbmx2Y3hlL2owOWRWMFgwd0FLZ0ZrVU5sY2hpSEY1cUFoNXhqTy9l?=
 =?utf-8?B?MWxBdCs2VGI1WG1XNXRMcmNJMkN2Z1N4Rlkwalc0SG5pWXp1Y2t6SjZ1MU5l?=
 =?utf-8?B?WUY0ckk0Wi9Pclc2a1E4WWZHdXlxcjNvQWdBc3NFYTF3RUZFYmVzWHUvVWlY?=
 =?utf-8?B?UDlkMnhVWEt2R0haU2g0L2ppOHNVSU5nSHpXNWcySzFTSFoyUmZUaUxZLzhF?=
 =?utf-8?B?K0FZYjZLL1VFWlQ1Sjl5SkxXZUp1WEVIcm1aU2hXYUdIMkhGQzNDZFc0RjM4?=
 =?utf-8?B?NlFKcWZ4SEJvUjRaYWtGNjlyN0hPWHdpTHY0YW9GdTJQNTlCYjJsL3dON05n?=
 =?utf-8?B?MlNTQTdTa052RGFMdmhma0tKbGMzSmNoOGpiSjJEY2hOU2pLOEl0clRueUJF?=
 =?utf-8?B?NzZabmJKbEs4OGlJcjB4RWlNVEJvK2Z5YUxCek9FaUFxN25GcnRjT2M2TG9W?=
 =?utf-8?B?eC9JZ1NKeC9xQ1czYjdFa2hseE9JRHRibXVxdUtKTkd3NWM1OUZSYWk1ZkIz?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c4a708-cfb3-4752-24ef-08de2275f50b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:31:55.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR/TCbOe8E5tJBqB6Ut/kskf1Arcc7e+zIb1bX15HTqdMNh9/AA7xJ43Bg48aV/tb4fyLg99nRXe6zwlVW3nGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6132

On 13.11.25 05:00, JerryJun wrote:
> 
> We conducted tests on the kernel version v5.10.245-cip65-dovetail1. The test results are attached. During this period, we also performed latency tests, which showed a 10ms delay at 7174.313414 -> 7174.323086.  irq 114 is net driver interrupt 。
> 

         swapper     0 [003]  7174.313414:                     irq:irq_pipeline_entry: irq=114
         swapper     0 [003]  7174.323086:                     irq:irq_pipeline_entry: irq=33027

So, that is the gap. Did you also turn on irq_pipeline_exit? I'm not 
seeing that event in the trace. Furthermore, I always for get about 
that, it is useful to have irq_vectors events because those include 
timer irqs. But it is unlikely that we missed any in that gap because 
they tend to trigger activities like cobalt_core:cobalt_timer_expire.

What is more likely here is that your hardware or firmware is not 
letting IRQs through. We could confirm that if the issue is reproducible 
while have function tracing enabled. That comes with high overhead, but 
the detailed result can tell us what the kernel did while there were no 
interrupts.

There is also native tooling by the kernel to detect "hardware noise",
see https://docs.kernel.org/tools/rtla/rtla-hwnoise.html. Due to its 
nature, this noise would affect Xenomai equally.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
