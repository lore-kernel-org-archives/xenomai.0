Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877EC13D50C
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917152; cv=fail; b=p8cVgt6BQ1E3kkM85teQ2Knrw6dmc6oWa5lfq8JnCSr4hRznuJhqifVNtv/lymbptuU+qDt+wy6TAvBg5qNzBIie8jTw0x5oQ2VL/KdlzA1tI4sYZMo6cd70EVqmu5/hSzLQTBGnQWIOgUccNYMql0Q5neEsilEyXfZDLfn4O+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917152; c=relaxed/simple;
	bh=B3la6Zz/SFcxQ/eullztzPTbGZ8bxOcDFMBCdjc+fQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=quwrKI1O4qCZCvO849LkHg7fX1eB7VodS63MwGPfR4TSOST4nLl/xJujjvnDlgvQQxnA97RYEeUO66EnO5VFx8Bcr04IbO5DcIM084g1HR7Z1+oCj8wNQ4y4+9ganW0Z0cqpi+rpqQZJ1CquBflEd64AmOvsgfPsO38vAcAVDJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ooDpZPGC; arc=fail smtp.client-ip=40.107.249.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ooDpZPGC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1Is0YtodIx9xah9EBeq3sbd2xpGa4bbQGNt4eIIfOE6mk9F2VHKg4Tc2cCkAY11LJoKkAqQmeTLesTZMe2qfUlULUPFYoJmNXq2kPEomvwipuWtNA32nKSmR5VikFtJCNMOXIxG+eTchHZPpxNXen2kRJHeJ7kiPgVR5jnhidB0YCpd0BZWfN731PN1Yo3M9YyKJNJIw36paerfnAkd/NWVvAGTIRdIoBNxXDXWN0lpQ9DBdTxg6FP81AJHhrc7BlUjYzUvhQ2o71quohUHnAGjvkML6p9j59JTJppWLXZSl1MHlw6WmLw5TNawR2V5up57HELJjksHW0+xrccKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O8SxsWmmlUr3zs/ahN6VIRrOSRdC2PxpxkX5nMyxoU=;
 b=fCElER7KHnGckDk65G+ue+7FJWMDSFkVcKXKBRAvn6LiObG1Mw3smoFD1k58lN6ZaXS0RGK9CXrI8sdz754xLnBSqLH6WW+TpFA3zeW80iJ5mdUFN6Eq58cFpAtL/HN7N2D1f7/nGUwHoyhJjiSz5GwpzXyDj2rdQE25WWldp9gggPxeAygjZ18jElJpC1k/Z4I7Ir4dNPE0A7Rlo2ABcY7DeZeR8ci0xwNNUR6HEIsaAv66qR01xx6YDQiuGf19sSpd3r4QwFEtW5yjplj/c8xE9Is5wtFNpFEqmZKGtLL3GeVnRixEHkkS3dPhEs2kiPB4O5fExJNyOLuthRcLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O8SxsWmmlUr3zs/ahN6VIRrOSRdC2PxpxkX5nMyxoU=;
 b=ooDpZPGCR/O+/zJD5yWH34pUJNJj0FXkGTM8p/i3zL1lA54guc0WloF34hWnGdMtDCWaxgRYTJndbl759WQfvtOxSnmKqdEI357ylBEah6zhOivyJIUErYoY9PVDznuwwvFJ5n8YrY1h/9XjbQjt3X+U/8Z9VK6ZTMGf2Gk5w/SMLbu1y0ycg8IcZUdUXHmQkxddDdcqkpKT0o0z0Cm+oXIZdICS3N4M6/bMhjikEdZBQeayGes9QC8o0yJkmIE14ExiV8XHI8APwTiMqP+dzyH/UPNM2ZyTF1sI/uyzXE8FNJCdk30FWYdtGIwxLVkSE75BajU1HegAbhJyBa9tqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7564.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.11; Mon, 18 Nov
 2024 08:05:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 08:05:47 +0000
Message-ID: <d7263ac8-ab84-4028-a617-6a8a8cd293ce@siemens.com>
Date: Mon, 18 Nov 2024 09:05:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] add BOSCH M_CAN support
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn
References: <20241118073011.195696-1-liuyang@sinsegye.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241118073011.195696-1-liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:208:136::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8afd2c-fc02-430e-3435-08dd07a7cf29
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGxvN09MRmREVEFJbndGMzVhbFNjakp2NU05b3ZVa25UT0pKN0dtek11WGN0?=
 =?utf-8?B?ODJTK0Rsem1EWU1kWjVnY2ZCRS9LaXFSS1hVdk0vRWZPck11a0RlRlU2UkM2?=
 =?utf-8?B?TzhOeHA0aXFZV1pNWjZubURXRDkxTTg3SGpkdmhxOWR3RjA5bFlJL3dTUzdO?=
 =?utf-8?B?SXVqdCtJUmxyeExkRGFFSnVkNloreC9tUmVlaUtBVlUwRXFwdFdmSHRlbVRi?=
 =?utf-8?B?cEZ0cHlRY0hWUTRSeUpva2Z5TE5uRWpDWkpGcnBBOTg2cXo3aDFFdEhBT2Z5?=
 =?utf-8?B?cmxTZHBleWhNcjBucXptZ0FXblVQTGRGK09zcGhJL25MNTdJTmY0eVRFeGZF?=
 =?utf-8?B?cUI0UEN4WHVqRWJ2Y2ltUGFOLzdMemVIYVFGTVBLQW5raEtER1ZWdGRFMzBC?=
 =?utf-8?B?YmxNMm93SE1mZTI4ODJvd2dXcTBxQ2d5aDFlVkFQV1htRXl1MXlRSTd6eWlt?=
 =?utf-8?B?R1dJM2s1bWpGYmhPNDJ6NWhuWno5WWdxdkFRZTFuSUdwNHhDdXBKYXZWVXFV?=
 =?utf-8?B?ZzY4RUx3YkFkYjVjSGoyaVZndUxBNU90MXRyWE82WkZIVWlMRDdwdmhTR0RO?=
 =?utf-8?B?ZUszZHRHY1RNcGVnZUhqV2JDMTBRRWpic3lzUlNiYnpXbWxNbjNPN3FNWnZD?=
 =?utf-8?B?U2txQmxzUHZacUhoZTU5UnZsdGM3cm51dWdvZ0psQlBXa0E1ZWdGUm1xVTFR?=
 =?utf-8?B?SVdYbjQ0S3FLakxLY0R3NUVVK29CdGpWUFZnL1hrUG83NnNFd1hvU2gwVzFi?=
 =?utf-8?B?Tml6WjRxbENDMGRSRXAzZktxejI3OHBrM1JodGhUaFpUeW1hdyttNkR4ZS9Q?=
 =?utf-8?B?bTB4MnNGdGEyNlBxbm9OaVY1NFVlemFyZTN5SHpYejYvNWpETUFTRzMzVVQw?=
 =?utf-8?B?RVQxS3Fpc0IvazlTVG5ZV0VxM3ZxM3Evb053S3B5RHpuS3ZLbWozUDZoYlpq?=
 =?utf-8?B?UVNRb0lqTmwrVEpwa0wzK0szajFIRGp5RHljZzJzR0JvTm0wVjVIbHRIU2cw?=
 =?utf-8?B?NmNUWlUrQUlRUGNZMWtkZ0lvblJoazh0ckxGVVlaK0VXbURLaFFwZGhsZG5j?=
 =?utf-8?B?RTh2RVhFYjlkeVB6REtnTW9ERjMvVno0MW5oNURGVmljbHVYZmRlMnpFQU4w?=
 =?utf-8?B?N0YwcEc5b0xaS2pieXFqcHhzVEg1WlNaRjFMNGUxaHlod013cENUQ20rWDZx?=
 =?utf-8?B?ekNRM3VuN2JWNnlMMFQ0M09JeGF1RTV1by92cEVrUklJMXE0SWJjZEkwekpR?=
 =?utf-8?B?MDY4UGFjSFVtRklITk9Ya0NaQTAxSXZ1SWx1RDdIOFB6cnNEN0Q3MGlFMEZN?=
 =?utf-8?B?NFhBTU9KaG1HN2dxdUpxV0xrQnVHZ1pxbWFyUkU5eldOYzBRNkNaQUJkMy8w?=
 =?utf-8?B?eFprUzJOcGhFRXVPeTkxcXc5NVNTWFREdjk0LzlQdGtFVC9RVGdUYUMxZ0lQ?=
 =?utf-8?B?Sk5mVENMdSt0Y2lsUkFOY04zVzlkVEkweGxvd0t1NmdBdTREYklDOHJ4UC9P?=
 =?utf-8?B?UmVSUFdLZ3p5SDE2NWlzVS9GVnhHTk5hYjMzVHZNWUZKUTJzMzVQWjF4U2Va?=
 =?utf-8?B?L0dRdkIyYXFXeE1RNXJ4dU5OTW5idU1zUE45SjZNVS9JUG1ROWROZnRWTEFs?=
 =?utf-8?B?VXBMOXpObk9KMXc4czhCL0wyNkI4ZFFCbitaV2J4OEdEa1c3Z2s4TitDcVRB?=
 =?utf-8?B?UGF3RDd2dXFHNWxGcjB0a1NnNWFGdXJrUjZ2NjMxS0xNbElzY2I0OFNLUHF6?=
 =?utf-8?Q?PWDx3JiEpzh1E7yu25OpBWWl7oHTNMxKUKHd82v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGZkbDlaUkhFK3FjRHNlT0x4dFY2ZjhvZjgxSEpJNWlRM0h3RWZ3UEJwTGs1?=
 =?utf-8?B?Smo0eC9qOTFNTDhEOHVEc2RKUVRjUDRSOUFLU25XNURYcGVBRjB6bjVGeGJD?=
 =?utf-8?B?Z1hJRXV0RmZ4QWNWZzh4RHRRQURtRHgrNUtSU0ZlNFp1NGVselRlVHNoN3Ft?=
 =?utf-8?B?YTFYVzdVcVZqMkVtOFNCOU9jRThlcGJmanJIQm5nMWdEODB6TkdzOGdPZCta?=
 =?utf-8?B?OGltY21wbnZUdDFEVFdXQjJiRG0vR0pwU1Q1N1R2azF1OVp4YWpQKzQ2U2Jk?=
 =?utf-8?B?UGpoNmVaQ0wwekpPK1JZS3JGMGFKb1hnUUxiNWNySEQwRkNsU2tyYWhrdHVJ?=
 =?utf-8?B?R3czVkdGeXU1ZWRZK0Z5NTliRms1TEdaVEVDWmRpYVFqVGdUaFQ4c0JmNGRR?=
 =?utf-8?B?cVQ2TkpWWm42ZUpRczN5NXZHWHI3ZVl5VXRkVVRFRGwveUx0ZzVOeDQ5cjhG?=
 =?utf-8?B?cWtCY2ZJcXcyR3YvT1RXZ3hFZU40d2lycFVtTTVoY3ZmN2kwSXQ0OFIxeDBp?=
 =?utf-8?B?V3NrTkZZMFhMb3NhenFsYzhyREViODl3Q2RiNHFzNjlLNGcvYU5adGFScHVa?=
 =?utf-8?B?M1J3bjErSWpQekVNZ2Q1VVVZaUdqU3FMNmVBUVk2RTdKN0hUM1hoeitTQVFS?=
 =?utf-8?B?SDIvaDZqeEI0elpZeXNPSWpEWlpISkIvc09sOVloMmNTMUFrcE9SQWJvYUpM?=
 =?utf-8?B?OC9XekJwTFhiS1B5ZTVRWTdtVXVGV2w5OFZsdFNHd2E1blZPb0VET0NVeHN0?=
 =?utf-8?B?aW5aUlo1dTJLeWJSb0s0ajQxeEVtL2l4VFNORnVuYnFpSmNLNzdFSDR5Nk1z?=
 =?utf-8?B?ZlNLbHdadDhteU83Q1V5Q3dCYndSNFIyODZLczVmUlA3QWE4RzlTV0s5Tlo4?=
 =?utf-8?B?RmRtOSttY3pYbGp0cS9jajVHQnpYSFlWK0d4YUlYY0I2SEQ2N2pTRlBJck9E?=
 =?utf-8?B?MEhMY0g1OWE2QkNQek9PKyt3SUR1NlhwQUdrcTZSUlUvc1ZlWnp6Qmlidncx?=
 =?utf-8?B?WEttT3FBcGxzQURvQUlMS3k2Unk0VXQ2ZE1Fbkx0aDBuSW9OUE10bSsvWmpy?=
 =?utf-8?B?Y280RVBibC9QalBsTXIwYzc2NEw4azF1YTlWcjBmdjVOUWovRjkxbVptTHhE?=
 =?utf-8?B?TmdlRDlaVVpJT1BENzExRHFMQlNwTTlOamgzZ0tFUGw5ZGZGUjg0NVo0YllZ?=
 =?utf-8?B?a29nQVNLOFcram9OQVVoaENGVFJxYzViRlgweWZRMkg3RUVwelZ6NUJ4OFVw?=
 =?utf-8?B?ZWlYdDE2alI2dklpZnR3cjRoWFE3dEIwQ1V6VFVxWCszb1FLaFBnOXY0TXNV?=
 =?utf-8?B?bUNsMGJXeGtKV2UxVVJkRlg4Wms0M0hqL3BTSDFIR1BUTm5hcFNsUCtNelIy?=
 =?utf-8?B?bXRZRS9oVWowbGFBNEVFbytSdEQ1ZmxkWFRaMGtIWS8wMUo0d244LzlCNExn?=
 =?utf-8?B?cDVnUXVnOGRQUVpKeDNXL0hxNGFhaHFRVzdVN25NU05uQzRFeXczLzZnbDF2?=
 =?utf-8?B?RkNaNGpCclE2MHdNREdaQW5DTVRFU3p4RmI5ZFB1ZFNHaXNoUVVCTlVPSUZj?=
 =?utf-8?B?L2VQOEdnV3Q5SGpkbk9MT1oxTVB3VzFlWklhSG9sVU0zWFFMblUvenFEdlZm?=
 =?utf-8?B?RGxFY0d0SVBJUXRSTGwvQXBwWkRYM21sRzBLNmdMbGEyT0VuK1dZNnJXb0dt?=
 =?utf-8?B?cUlCSFBUTTFTZkh2NHlEY1BKVU1ocDhjb2hYVFhFRXdUZTFsdUlhUmhINkhp?=
 =?utf-8?B?WGltWVpZdFB1VUE1S0czQjdKYlhrSXhkekJNdDRwYUpycis3NlJVMk4wc0hQ?=
 =?utf-8?B?OHlJMVpIQUdQR1Z4cnV0RkhFSzI0SlpTYXVIajFaRjlYZndmR1pWTEN1MW5B?=
 =?utf-8?B?ZjJzTFExU3N5N1orc3RpUGtXaVlUbStWbTR1WS80ZjJBWXFLZHo4RzFyeEpO?=
 =?utf-8?B?dVpmUEM3eCt5bGE1VVZlUEVTeHFQQTBvQVMzbWpCNlRrSjN2NVlPWFNSeG1F?=
 =?utf-8?B?Z2ZrM1N3eEUyTTBhMFFNTnEzbXFpOUVCM3F4cThtemZVU1FtNnUxNzVCc25x?=
 =?utf-8?B?bmJSVUFrVU4rVFpGNHlOckpPYi96UEYzZnJDR1Ztb3dyeFRCVkY4bnJtRTE4?=
 =?utf-8?Q?UjoKFixxTYJ28LxXSftL4u7+z?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8afd2c-fc02-430e-3435-08dd07a7cf29
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 08:05:47.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA37hUfsiFlo/ZGMT9u6nCGYGOip3JmcJWZciTZAvSKXSse/455ElGeQumAXrmtUE/7siF6kaNfdx91vRm+lCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7564

On 18.11.24 08:30, liuyang wrote:
> port from linux-5.15.51 driver/net/can/m_can/m_can.c
> rtcan_m_can_pci.c is an example on intel X6425 RE platform
> 

Please read my complete feedback and address it, either by replying to
it or by changing your next patch version.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
