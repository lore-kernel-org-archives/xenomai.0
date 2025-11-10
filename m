Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9247119F13F
	for <xenomai@lists.linux.dev>; Mon, 10 Nov 2025 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762755936; cv=fail; b=kTfjX+IQGdS8fIkA6j7jYpz8m4GyvOiIsvYA315i1GzHRO1CP+l8dEbmD5fHXs7u9D+TzOOvW9/oQXad6oHJiRSkeOm8RqZ/LU5zqSpNLswDrGi2RlDLcQwX2bl/SS6cQ3s7IfEuie3z/VysCQNDDhvOX1O1E80IME69F5KjPaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762755936; c=relaxed/simple;
	bh=NTnIwjPnWC3H3akT5PJCm9cu2czMYmL4bVSKBLg1+5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oDUhLhDMxV6k/eSB+j8zsbPlkAoc4v/jJeOkmFFMeIKlQqI3AvJAIe2CpK5fjknJTt8O6x7fJjR4KmFNOae8ICgcewoBeN7eu2WJiXixk/T3kAWBDZ+4XQMP6BU3mCGIdXjUK2HJ8nDrrIk+7A9NLvy6bV9eBpshxBxpJXIWIXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jXP2U8bC; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jXP2U8bC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV0/0zIzgzkaF4zek17G+fUFi3VMO9yc7CcIvGa+F4fqoHTbl/DWVde3Adw1ZZU3+RXx3PaoULgitLj7/qZ+KL/AjX6rvA6y3aztTn7zt9I5Egb9BDmgUVU4NB6aiHt6eLydUlhyKMaI36UffBXI59i2DyEp1HEhvQ73mWhfDvGe43lZ+W0dWS3HhNajOwJ1rUwYg3rXanuXpsHaaoCiSianqTz5mJK3sBC5KlD0885yWoaFBeORl90CbLRaLfbA2BvZCD8xd8qe5kFvPwED7f8ssfT2SSr+zcy1Y4bt325Yz7OJiuZGQM8noBsW8DsOpQz3TGHkFtxnlLac1rv7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHubwvPZD5KJQ+9uFJ8h8F7f57seYLy5F0VmlZo/1uQ=;
 b=TlWOu/V6kwPXZReoqIHQlyPNuoSIuaABKNzFkg7Yq6UszKDuorMN7WHq5R4ZUh05I3Np4lZRqMewmDWclRsYh1UMgoXWKJlSuTdrqvMus4Ki0xszkMVKqkbFKKvNgICpOhmX8sG9v2REs1e4crCgQtJ5S9MKZWpJ/UPsPdRBwy3ubBs+mxOZYN+ZOC9m0IgSlRGGYaGaTW1K2VUBbMioxf8B2ZwFDQ6UQUxHoT2K6UK0g99JzCnu45rK2/OmKLRFFoW7+9nOHfW+82fuvj9o5TcA7+4ajxHzBS1lapHwzEPVe58Z6knpk5jam1WZDLULStVqZ3/DpKWMxzX6ayAydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHubwvPZD5KJQ+9uFJ8h8F7f57seYLy5F0VmlZo/1uQ=;
 b=jXP2U8bCcSY8JBxOk+Avz4c3PdPmAUvW5Zf9IaGgjE0GLJ60pIYUQdnx6zieXcPw7hvdc2X5UBryb7I4+f/NkEJ8bEdivg7KPYbZ7AszBnPSe3XDwWxiSuM5uOWrp6z/KJSliTYhyOgEvnHpybIOQOqjGQC33fSvZ6qsgcT13c3s37bYujnkRVGRzLgEkac9J3gwnJuXM5NuOHSqzWqhNO8i4W/55HTZlSLb0wEoGV1bRZ0P8ZuPzLSN4eGqFRza3GKcbLEOYYNld0Kcq9tuyiNpOm+emzUt9XGQ/mQh21+FoY34wkTIQfyZGGQh1JgX5PowO0y6AjSYQBU7VvkR9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 06:25:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 06:25:30 +0000
Message-ID: <1c4413b7-6d87-408e-9854-bd2c6e0daac7@siemens.com>
Date: Mon, 10 Nov 2025 07:25:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v2 1/2] linux-xenomai: Add arch specific
 debug kernel configuration snippets
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20251107080005.1272435-1-tobias.schaffner@siemens.com>
 <20251107080005.1272435-2-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251107080005.1272435-2-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 321a6c1e-2e78-4d99-a5c1-08de2021f256
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blZFSER4UitiVldQcjRqeEszWGY0ZkcxRXg5MjZXWHhPRi9DZ1dQT3NTS3k5?=
 =?utf-8?B?K1Jud1FRSExYallEUG1kQ0JnOC96T0FTaEFhMDZsQWgrc3NYSTJMa2ZMZHpl?=
 =?utf-8?B?Q2x1cURVdndSbDJtYTYrbFJicXl0UTZnS2RBSmtUZ3d6QzVPTGN4YzJzaGcv?=
 =?utf-8?B?S0tKR29zZnppV2JiaHhWSnVvUmg2M1dKbytGMlQrL2xLV2tIa1hjNzVTZ0V4?=
 =?utf-8?B?TDMzd0twTEdJcUltM0t0eEZlUjBqOGoveTYwVUFIdnZubGlPeXAwVDJkRk9u?=
 =?utf-8?B?NklCUjYzeFlVc0ZjbnZ2YlpldjcyR1N2OHI0UUptTXUrL1NOVkNVeEVacUJF?=
 =?utf-8?B?UkpuKzFMUGRCY205VFIybGlGdGFHWmMvVTNaNUdqYWVxWjBoM042WitwSmli?=
 =?utf-8?B?N3Q2c2R5SjA0emFEUUFDb2dWcnV4dXIyYldaRGpDT3gvRmczQjEreXhaY0hh?=
 =?utf-8?B?NUdCQitSQy9ycFJ1bjkzdmp0aURrcXhENnVScGlMS1NvTUFibkFIODZ0dEpu?=
 =?utf-8?B?TUEyY0dxWTZaUEVlMjV2anVpOWRrNXFUWHpCSllEVUY5T3dBMnU2eFRmNkVM?=
 =?utf-8?B?cWdzUHZVai9xNWlwZ2cwUzlEQklMbGlFU0NKRDVDN1pJT3FxdmJyWkVyb1Ew?=
 =?utf-8?B?bG4xeXN6TGs5eUhieXlBZUZVWHhORnRTK1AxOFNJWEVRaFhQWFRnWHRLTEpU?=
 =?utf-8?B?aEw1alFLRjd0aFlPMFRhNzlMSGs1SWtsTkt3V0FmV1duYWw1clpJankvYzAw?=
 =?utf-8?B?SkVsbUlFUHpyRjBlK0xNWGJUL0wzZFZqdjdpZDVNaEhTWEhWd01wME4xeWRa?=
 =?utf-8?B?dFA0S054aW9uTGVsMW9tNmlwdE5XaURQVTljVWJSMHBZODhKbWQ5em55REpO?=
 =?utf-8?B?V2tVUTY2dzRTaHVvRkl3RnhxWVRoUS9EUFJDRVQ0UDdYTWpXN0I0dDVRR1VF?=
 =?utf-8?B?S2txOHNnU0s5cUwyNjR6Z1pOdUszSU1ycDhTeDBoZThleTI1TWVSeGY4QUpa?=
 =?utf-8?B?RjJFQTJvTldFTmpmRzhFNzQ3R1AycFB0OHBHaWQ1dDg2UE81U3UzcnRFTVJp?=
 =?utf-8?B?SjE2S29DNm1MZ21JbVlERGpqMVRlaGgrWGdBeU5tZXp5cXRYdU1kL2ZpNVB3?=
 =?utf-8?B?RGpUTWR6VEVBMG56dUpRQkVqNTlENHFJUGd1SkljOWlKZ1drdFh1MmQ1c003?=
 =?utf-8?B?VHU0UDloaVVZVFAvbi9SM2ZXOTVsanFVRVFrNmYzNUhOa0dybW04aUQ2UWFv?=
 =?utf-8?B?eW1IcVRiMHZTdWNVcXp3eTFNOCtPeXdhbjI4TnlEWGhJYUVRTzFNbDU1NkVk?=
 =?utf-8?B?cXdnWk5hZU1SRVZYV3FxVW1aS1JqR2xxVE9scjZ1WTQ4dk91OVdHL0xkalVi?=
 =?utf-8?B?U1NZVnZ6TElBRlJqTUtYcU5oUnlwRkJ5T2JyOHhZdjRXQStjdjBrRE1zTXpp?=
 =?utf-8?B?VDVTeDZUUG55MzlJWlJoTGE2MHpsalZheXNVZVVPSWhVdFJlVFhaZFM4bnVw?=
 =?utf-8?B?Y0h4MUhqUS9uWHVZQnE5RjdCdjkzT2psS2N3c2xMWWRXMEZkNkhEK0ZrcDVp?=
 =?utf-8?B?MytET296NW5jalB6RTUycytweEtaWm5UNW9MOWd5WXNBaHhNZ3R0RnF6YlBs?=
 =?utf-8?B?emRrRzVxbDdMaExmV3J5VDRLVTk4RmFRd2JpYkFYcFMvcjVnemdKTTE1eHpq?=
 =?utf-8?B?NDREd3A0WDN4V3pKVnZjU3NpSC9paEJ2bGNBMm5wMVhkVTlEZ3o4cmRNcGxu?=
 =?utf-8?B?RzJJMkVxNzNWOHpvQUpwRzBvUklBRUZwZllTS3NaaWhiZ0hxalNXcnBCUC9Z?=
 =?utf-8?B?T0dEMjJ5a3JBTk5HczVuRExmNnE1blB4QlZKTWRYUTVsRVBVanNieXhtcGUw?=
 =?utf-8?B?MGU1SEM0bXFDaDFIWXpUYmRpU1JFcTgrQ0pCaWZoUFdmTUU0MlBIcGVtRnVu?=
 =?utf-8?Q?Gmh8haKmzNVh5Mes6UJwaKykY8yG2o/0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MS9qMkhBWlJuL2pkS3JYSFBsYnUzczJkZW9UVVdBR09TZXo2dlF3cU1NdFo3?=
 =?utf-8?B?SVVmRGxvZGUyZktPR0hOMVhUNVFwRWNZSDk4T25aK0JhbldMQTlRdDRGbkxz?=
 =?utf-8?B?akw1Qk56ZzladnlNMFdraFBMa3M4c3ErOTNUV3VqZy9JdHdPNDEvSjNpNjkr?=
 =?utf-8?B?aUVoRTNMclUramxPa3paUnNVWHRGQU5wRytQa2lQYTBRaGhQTS9kV0t6emE0?=
 =?utf-8?B?enc5angycDdTNlU2NmtGeXJTM1Q5Sy9HVE5zNEJKNkxwdm1wUEJZeTFwdU5P?=
 =?utf-8?B?dUFLd3NzaDcwL1kzK2l4ZzZVeEZPVzltVThRZmpVdzlST2dpMjBvOEdFL2Ro?=
 =?utf-8?B?UmxUT2NqYXY5NTVPRlI1a1NUSkR1T3NrbEhOaVZqZWJtcHpuRzJCVjNhSzZu?=
 =?utf-8?B?TlUzWmVDNUR0RWY3NndieVFmcXI4cW5yYTExWFdTZnJ3bUp6MlJoekRpWGZF?=
 =?utf-8?B?cmgxWkZzTXh6dzR2RXJFMThPQkwzZldvK2sxaHM3Qlp3Q1RGYVhSNVNTODdm?=
 =?utf-8?B?RUxGNk5FT1JoNEx3VFdEdzgyVGtxQ1dBczBDcTNQR3YrNFdNKzdtdjZtL0My?=
 =?utf-8?B?UHBaMmszTWdiS3FjRVR2V2tCNlI5MEpTazM2Ty9kK2RDVWdZMEhVVkVPU3FJ?=
 =?utf-8?B?alBwZkRCYUhFYUFRNHZ0SDJSdjhiYjJnNG8wajF5OWN3bGRuTFJOTHp2bm9J?=
 =?utf-8?B?b0tnQ0lSbFJmdzl4SXpvOWVOSkZ6NnF4RlF4eVl5WWRzaTlTTldBSDA5bE8r?=
 =?utf-8?B?WFlQM1JWTVNxVTNDRUdTUDNHazhQRGk3RWRQdG9lRUthazBaWHRCT085MEVo?=
 =?utf-8?B?NGpwVjVGcG1DampiS0ZhYTVBUDhYak9ySTYvamprNWJkRHUrcDBQM1IycHcv?=
 =?utf-8?B?bWtzMlByYTZTWUI4Tkwva1BUUzV0VUMzNE4zUk1FT2ozVXJqK2FwbktCOFo3?=
 =?utf-8?B?UmlMbUdFdXhTSUpiVm1LcEtxVThnTmZWNWw3YmRRS3VFTllpMnlDWjNoMHBP?=
 =?utf-8?B?MW5TeVBCeHkzUzd1NGpkVG1iRFNFTlNwa1EzY2oxRXFFVjdpTFBGSEg4cW9o?=
 =?utf-8?B?Sm5UUm5pa3JzZzBGSTYrUFk1ZUNRbHJ3SnlMdnJUN0NFRjZSaG5iWGFxZVVh?=
 =?utf-8?B?RlVMYUtoZXZqKzlwdCs4WEthQjczcmpYaXpOOGdsbHI2WkxaZzdEVFV0M2tH?=
 =?utf-8?B?aC80R0JsSFZYN2xKMzBEbjJ2NEFURTdiL1VtY1lXVUcwb2c3RkNadXR4a2Nj?=
 =?utf-8?B?RThzUDNiZFJQVkJtcGdaL0E5ZmRvUXJDajhXWmxZQ2pOK1l0b1pPVjVTeHNl?=
 =?utf-8?B?ejZZU0JmVmJ6aTFjUldOSVNaM2F4SGtrajdHdWNZdWVjTjdRUndYZks1a0M3?=
 =?utf-8?B?TWc4SjFPdDhkZFRIR3lBaFFKajNjNmdNeFQyVXVuNDBWcVhZcnVGeFEzNDds?=
 =?utf-8?B?MnhlR2R6ai9Jc05CTmY2eVdXcG9PVlBzWU95eTdKNm1lTVU0Q1dyZ0s0clM4?=
 =?utf-8?B?d0phK3l3VlExMVdaemIrWnZ1Mkd4R0ppVHpwL0hZcGQxWGhERFN2QkpTcUVU?=
 =?utf-8?B?WEgvcTllVGR3aGVzdGxPdzVoVUQ4Nk5aSjY2aThvQ3pnZEV0NVduelJwWVRn?=
 =?utf-8?B?Slo3WVU1QS9EVlhwRitsa2xFZldYVXlqTDNycEpoS3l0Vng1QXAzZlBaVDZF?=
 =?utf-8?B?Q3IvQSsyaENEdHdrNmN1MnNaMVhWc0M5NXBaU05CVENqS2pkY29pUzBPRzdP?=
 =?utf-8?B?emhQNGlWRW4zZEdKVUpFcFVSVFNMemZWc3IzRFYwZGt0UUpqbUdZcE05bkYx?=
 =?utf-8?B?aTdZblJ4U0djUnJXbndoMkdZTW1IcUhVS3hWYlFTT0FNc1p6akZGTEZCSzNL?=
 =?utf-8?B?SWxFVm5IRFMybTFJTFFjQnJtZlJoNVllSndGQXlPWCsvRkt1MzRlYkdSbnVy?=
 =?utf-8?B?b2JTd0hwVXFnR3MyeEVwTWpVaUthYkpPSDc5a25xQTRjN1ZLQWw0czhWRTV1?=
 =?utf-8?B?WjI1U3RXSW15ZjE3dElGdmxJVXp3STMyZGJoOCthdzFJNzZKVkd5TEV2RkpX?=
 =?utf-8?B?a0UvNVhWM0dSM2VONWROR1NSUmRKdndvMlNkQnZpYWk3MVIzaTBUcDdLTy9v?=
 =?utf-8?Q?pqK9UfmvoaTZF/CJV2gJ3oDUo?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321a6c1e-2e78-4d99-a5c1-08de2021f256
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 06:25:30.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQwxhPuANMLny46HXZUKuHoqNu3oFuVicYuPqQ8tkDH025IHtkKRFCp/XmDPXUwImoIEsuri2MVfcTsX61mURw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8197

On 07.11.25 09:00, Tobias Schaffner wrote:
> Add dedicated debug configuration snippets for each architecture to
> consolidate common kernel debugging features. This replaces the
> previous approach of using an inverted no-debug configuration to
> disable debugging options.
> 
> Separating debug and no-debug configurations improves maintainability
> and simplifies future consolidation of debug settings across
> architectures.
> 
> The change has been verified using the kconfig library. Applying the
> new debug configuration to the updated defconfig and running
> ‘make oldconfig’ produces an identical resulting configuration to the
> previous defconfig for all supported architectures and kernel
> versions.
> 
> Several debug switches that were previously left enabled in the
> no-debug configuration have been moved to the new debug snippet.
> 

Do you have an overview of those? Would it be a lot of effort to factor
those changes out?

The approach looks otherwise good to me.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
