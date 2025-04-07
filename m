Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50372063E3
	for <xenomai@lists.linux.dev>; Mon,  7 Apr 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041107; cv=fail; b=NfQancB43DENa6dzCwdqL4vRtElcQm2yS29JSQO8jJ76eibjdR1vHUlxD5asV3+Gnx9UbBTgG2hkEKBL1NU+eM1SCJOAhRx8yow77+5SQY+5AIWmbilQgG32+sQPqMAdPi8FdH1PDcPuOVfpiX+kaa1bIRjPw3h7VZdWwMgGXEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041107; c=relaxed/simple;
	bh=2H8xV7I9a+WSjFQfXA+AtuhZlF6CEaH97CPescy7CZQ=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=sptf16ooLTO17tNG+OyKDoZ01fVjiW6P5jiMK2SMH+Ci+TPXyDdl9q6iiO+Rbfgj1bAXDhKfmGl31d+iIplaiwjp5TfnzDW4lgAEmlD9J95Y1R8Avkxylw7UYOYUfvealOeBWM+nptYKJepPLaHK+UMGKdQAklqpkRI6Xm5/wZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QJFA3IW6; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QJFA3IW6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FC3r5i7nrameen5oEKJ87fKmWQbgRissY9BCvsjrNs1BSfQHNTLO+h4nXg9V2uoAmXhkr9+vUVvFwt2YJfG2NJGB8u2ysAH3ReuBLixWdVMRR7wIZZEaiqLv7knZ4+zSFbXz30KfQv98EpS3M4YeuM63iDm/iN3zaQeeAAfC5NJwFdSJPHZqF4RLG0Js/rMKPsg2G1ceZQJQ8gU7LSD9UCDyfYjhidUHw7mtrAKAsqxRHuSWOzmD4D+IY+zlKks/n58Y82F9i4V4/bdcwWEVN3FZZBRcI8qJNMbIuVLlyZCPqx0gJQvr4xqVLZPDI9roE4qhaG5ZfSC55Go0D6p5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSXHIBt4nZ1hX86rSYHzSJRKN/19OtHxXxlHR576/RQ=;
 b=ZkmS1SEvEracScqGDHk7ig2A4zjmZrvmnJNDfIofgezkZ6FrLhTlbK7Bz57bU9KzZhrBRscxLwCbZgxt04cJBC1Ly65axQyYpa7wFcRvZ7j4uXL1GdyFyaqCfLrIzOEBY2qpOpqR0Sj0CfHrlssvJ4qawpmiZSr5UoNyn/v0qiFBATSgYr3JgT0J1lgKvRRXlQ8vMCY802xK2TTwmu9P1A8UqCFZcoA2WELE3BiRtDhiyVs7Z+io7YUChwEqYTnbjOC3m8awLx3xEUO47GuB+MWoDBTj9SGwyAFhlvrmpJitkXJin1XmdWHvBtL3jAr6VB2zZ2hY8W6bMNnu3GRSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSXHIBt4nZ1hX86rSYHzSJRKN/19OtHxXxlHR576/RQ=;
 b=QJFA3IW6Rt8eVo1Zh1LY6B52uzfkgSprljyKvXH4j/+Q+i4LkiMBtLtArlLf+8ip4O+q2mFF9Er8UJqeQ1kLfuUA7aUbPTKmW+4WU74mo5KlLrNaLpwKvJZOX4tb7KjNMf6xA2wieWue3W6cnJXsywX3CCz+MUwUWVMWct+u1dqqz11h1EHJP7TphJ8Oz/UAqf4QAYrO47WWxcCr84Sqb8G9OwmPZKCvgDN85aO5j2jClnJACecKMv8SPgOIFUMFXQUP1/HieJlUa8VW/Md9LvU8Fyo1RZo+TmZRB8ZmWf+rM9mi7rHIhOroi1cczxd0iueUW/aKv8n2nI1S1ZkxAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 15:51:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 15:51:39 +0000
Message-ID: <8e0ce080-1167-486e-8887-9fd8a3d250dd@siemens.com>
Date: Mon, 7 Apr 2025 17:51:36 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH v2 stable/v3.3.x] kernel/cobalt/posix: Stop supporting timeout
 parameter in recvmmsg by default
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:208:234::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3782:EE_
X-MS-Office365-Filtering-Correlation-Id: 701db7b0-a0e0-47c3-aba8-08dd75ec15d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWp3OXBFSE5US3A1bDJwblBNbnlOVDlDcWxYOEpKMDNOTDJ0L3UxRUNzUHpv?=
 =?utf-8?B?R2ViNmtPSUJzWTY5U25mR0JLeVV0andxL0tHZWNvS1FlT2NKQ1J3b3Y3QkNJ?=
 =?utf-8?B?dCtlSU5scVV3TkRhd09WbEphRGI1SEVicUIwUE9KeHkrdDljVFRNUDdod2tM?=
 =?utf-8?B?VGh6cVBjdGJHemV5NDJ3dVBtbHJ5cXdzSzNsamN5R3huZHV2eFY3c0tLS0NK?=
 =?utf-8?B?OHNjWWk1ZlQvelIwRG5tdmtwU2R5R1RMS0t0UGNGZm5XNHhVbG1RU3BFMUpz?=
 =?utf-8?B?MEJldFBIM2xzZTdnenV6eTdLTnhzcytRbXBMc1dPNWRxSTV6Y1M1SHY2TmFP?=
 =?utf-8?B?ZmxtNC9oUXU4OUJ2c0YrVnMyVHpZMk42L2F2UUhidFhwZnVNUEduZWpmRmJj?=
 =?utf-8?B?UDMxMThSZ3ZUZ3JEaGRBMWlpNVl0TTZFQ2xSTXA5NnF1TkhlUGdtSTA0U3dP?=
 =?utf-8?B?eGpDZ05DQTgzbXBON2RJRmFJaGtmWkJBRnVBNTFKWWxnNm5ZNU5zQlhGVGR2?=
 =?utf-8?B?cTNIWS9IYXJpT0NzQWRZb3REVDVGZjFWYndlUGFIRi9BVU5uTG50Q2o4MGxC?=
 =?utf-8?B?Q05KUW5qWmJ1SVJZSlVrMnpzdDBpOUtSRkE2ZzRrSmYyZ003RXhnU1B0TkFO?=
 =?utf-8?B?STYwWVB1MlhXR1RvenhjbXdPUHVsNjFlT1Yvc0lWdEY0RmVxRnlFeGRXRGxw?=
 =?utf-8?B?K0ZObU16NFpXaXU0cnZRbHcyVzhZOVhQT04xdUtGWms4azNwQm1wQi9tbnFF?=
 =?utf-8?B?dFV5cDJlcjFSQzlNVlU0dVlJV3BsRlBVNW8yd2xsZU8wK24xQVpXc1ZNYU9R?=
 =?utf-8?B?eTVzNTdtYU1LVlZ6V2psTnplMUlVWFZyUUg4Q1ZQcFMwa0h0Q2hXT0FYcFlp?=
 =?utf-8?B?WENEbStubU5pUFJTekFsL3NNMXZ6UDNTN0pFdXV6WmR1bEcwbDFScUUvZUlQ?=
 =?utf-8?B?V3B5bnpsOGs2Wkdublg0cTBqcExUZHdZQlNkQTR0Mkxjb2t1RlBmdnQ0eTZw?=
 =?utf-8?B?QkVNK1ppSG95aEZzbHBMYWhXUnNXeURNbUJaUWhXeHhNQmtySm5mNHVFV29K?=
 =?utf-8?B?TjdKSGFCSCs2S1JuNm9NWU9HQ0tzdnFteXZFUmxMV0VnU0VRaytKOGx0TDVn?=
 =?utf-8?B?MWFWaU11MVhvYVhjT0EwUldCbUVKYVdCT3lSRW5DNkM4dG00QTZVSm1US0pF?=
 =?utf-8?B?UDJBUXdvZXo3RVR1MXNxMmZYTklXc2xHaDQ0d3NlT3VZOEk0bThJSXJzaXpm?=
 =?utf-8?B?Unk3eElUQjNDOTZMMGxicmlnaXRBWlZsWm5mY2s2OUpRd3EweExlUzdWd2o2?=
 =?utf-8?B?TFhFajBGZnlsUlpHakhKaFNhR05TYXRsK3loSTVTaFNJdDdIZjcvUHBNNER4?=
 =?utf-8?B?WGlIc3hTcWNJaktlZTVaNE96Vmd2eHFlbWRxVzR4U1lWQ2pEVVgvZE02V1pR?=
 =?utf-8?B?eW9SaWRtMjVPWUpnM2sybFhWRG15TTFEMy90RlFqUEZnZVVnWTFJOUEwTzN1?=
 =?utf-8?B?Z1gyT0VXcERuUW9nN0s4ZGpXL1lYVjZaSVdEb0w0Z2RDWEVrOGZUa2p2dzhi?=
 =?utf-8?B?eGFqYUYzVytlTEdqNDgwK3JLV0RSTjRWb1hrd1orZWFueDlxWlVDaThnZXY2?=
 =?utf-8?B?NHJDYlZ1d1BjODljb1FFNU1HYmRWV0FmNmQzQ1d6SmlhVk1XQlA1OEFoeitk?=
 =?utf-8?B?aDk2c3Jna3lRQnNRWnNIMGJCMzBvelpjV0pGM3hXbEhyWDZ1Njk3TVN0WW5l?=
 =?utf-8?B?VHc0RmVJckw5YzlUMnBPVm5OMms2Uy9acDRQVFNHMnczSDdmRVVkeGhnWC8y?=
 =?utf-8?B?d1VjdkpKa0FSLzVLS096UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFg0emVEbGVsSUEreVdVMHZuSmVMRDZPeUpuNWc1VFQ0c2tIdk5iS045dWlh?=
 =?utf-8?B?eG1aM0tOeWpjMnIwZmxzNktZR1gveWFZa1BjQlkvSUk1ajcwR2xidEkybHpt?=
 =?utf-8?B?UWdhZEZ1Y0xwN2tXd1RJUDNUb0hiZHk0V2dvV3FuaFRoaGRVT0RVV3RQeHhU?=
 =?utf-8?B?Tys0NHBnekdQYU8zM3g4MGFmb3YxUTlzNU1rNEQ4TUw3TFRQWFFzL1JBUnFs?=
 =?utf-8?B?R0tzTngyaW0xR3FjOUxmYndPMEFETFZVblpTWUdtaDFkdU9LMXdzY2IraGV5?=
 =?utf-8?B?VTl5MXk1dEsyVXJnajIwK1dBUlVxYWI1dkpOVlR3VUg0MnB2eEpubVpMaXBV?=
 =?utf-8?B?MVZkdU51b2pOWXNMQ2RUMWR1RERGVjNiZ05mTU1ab2kvV1F2dmxKbDNYRmFP?=
 =?utf-8?B?d0VOS0lQYmF2MXFuN1g1UzdwMFd0Q0tBdU5waWkzbUlqU1RFakxTL0ZsOXAw?=
 =?utf-8?B?SXZHZnVFSnVGUEplV2RRdVZ6aU1PcEdJZ3lkcFJuQjBBU3dxdWJpU1Rrazg4?=
 =?utf-8?B?UEh5bXkvZXNLaS9hT09lRFhuaWUvN1VDY1p2WUUzNUdvUDVKY1pHM3NEWHh5?=
 =?utf-8?B?NVhmWlhISzdQb2kyeElOcEExMGpxZGhrNHlhYVVCYzhzQU9yWVlUWjYyVGZ6?=
 =?utf-8?B?ajd2WGJCeUJTVWdjNkVvaWhHVlo1dC9iSVJ0SDd5V2ExYWV4SHlSMmJBWGVt?=
 =?utf-8?B?aThDdnVEL29QYnNvZlhCcEJKZzdYbnBXMUJ1ZEI4RENzaFV1VG82eDRiQjMx?=
 =?utf-8?B?TFhHMWMyUGdabjA1ZkhDV3dJbDdVQTlHYnBmMENvdGFtdll2ZUEzc2xaREgw?=
 =?utf-8?B?bXVYVUNRLy9RdkhBdzNZcU9VUmhJaGFRMDhLYjd4Qk9rYVJZVGpBRW10MzFL?=
 =?utf-8?B?RFdjeUoxMklVdzIyUkhreEQvakRaeHdZN285TzBnOW03M1ByTE9jSks5Mnlj?=
 =?utf-8?B?N2FFakJJb2E5akpJRE9PM3BPcHJnb2VxOWFDUDF2cHMxV0V5WWs1MXNQQlhk?=
 =?utf-8?B?S2lyKytzZEVCTk5RRU9QZVU2YUdkelZTbUpqUENTajRoYlowc0hNYjRVaUhs?=
 =?utf-8?B?RWw3MzhVcURPTjQ2d2hPUExrQlVJeDIrcnNJMmJKYXExTDVUa09IclcyV1E2?=
 =?utf-8?B?ZnpUbmMzenU0MkNrck53ZjBpK1A3ZDNPMEFJZnVmQXRqbGg0VTZSWm13b2ht?=
 =?utf-8?B?M1hkZVJGT3hRaFYyM09iRko1aU9kS0xWMnpKdTlFcVNuaVdpRjJhRjNFdHhn?=
 =?utf-8?B?eTNURWE4Q094L0F1SzZSM0VibFhxbU9kQjliU3RCT2tUQmNpMll5Mm1CVWh5?=
 =?utf-8?B?eEM3NFkyQUZpWDlvTmtTN3lqdzhnOWxxdVRtUmY1MmV2RHg5a2t5S0svWWhh?=
 =?utf-8?B?eUFNSnc5Q2lSbk9HNnplaGlwbEdlVEFvb0pNYmQveTNzRlhLUnlRQ1ZxMnRD?=
 =?utf-8?B?YmM1dG01MUpRYTZQS1dWWmtZeGEybUVjVUhxWGxGOFFFMm14eGlSK3JnRFJs?=
 =?utf-8?B?MHU5K0lKVGNuSHJsSUZ5YWZGWGh3U3p4c0lROHNzTkgxZi9RWllBeTBmZ3FD?=
 =?utf-8?B?ajgyL2tQVENBaVJsODRSNzU4UnVtRjBZemhGTEhXL014dVd2Yy9hb0JSajdu?=
 =?utf-8?B?cXh5MkJWY1BmK2lZMkIwbW9qRWNJdm8yT3V5TkExNHQrUjQzYTdQbG1vWmsx?=
 =?utf-8?B?aHEwczdNQ2FYd3I4YXd3ajIzdGQ4cE5tcXBFRzkvL0VkeUtHemUyOXpWaVl2?=
 =?utf-8?B?SkttUXMxYTgyL2RtK2ZEeDlZeFd6aGZhYjNHT3pPbkRyTjAxUStCR1ZWbi9o?=
 =?utf-8?B?UmkzaXRBZGZmdXN0Y0VIdGFxL1N6cEl4TnA1K0k2OEphUUplZDNEZXBDcEky?=
 =?utf-8?B?cEVlODllUUNsU1FKZGorME1ZYWsxWWNtODl1NzJEVmJjOGt2azlobEI0V1pn?=
 =?utf-8?B?bWt2MjAzODUxVzAwNzM3bGZMWGhVOTFDZHoyeThtUDUwM3FBYzlkdmJTWFdu?=
 =?utf-8?B?MTFRaTlwRU80YU9lVTZUYUhlMEVERG5YVmEzYStzZ0gzTnhXY3RKeEZEUlFT?=
 =?utf-8?B?ZWFZTmRndlk1ZUVROWhNVWZ2aE1NUkVIaitvMmUvWDgwSDhGeXFaaXNYQWdJ?=
 =?utf-8?B?cE1UYkRKbDdrOXpab0lDQUl3RVptZTVUMXFhNWwybjVNZmhyNndRTkphOW1r?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701db7b0-a0e0-47c3-aba8-08dd75ec15d1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 15:51:39.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZmWravXIAAcJrV7b6Hp1Jtzxqbun8E4L/zygDbv5fLVqrRy1Ka9+ZscvCL+FFOeke2VVy7DXq+rT6Sofy3/5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3782

From: Jan Kiszka <jan.kiszka@siemens.com>

This is a conditional backport of 3d6121a5f5dc to stable, allowing users
to keep the pre-existing support enabled during build-time if they
believe they are safe and need it. Default is off.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - fold in https://lore.kernel.org/xenomai/78dbe3b5-55d5-440e-9b62-45db1f2add5c@siemens.com/T/#u

 kernel/cobalt/Kconfig                  | 11 +++++++
 kernel/cobalt/rtdm/fd.c                |  8 ++++++
 testsuite/smokey/y2038/syscall-tests.c | 40 +++-----------------------
 3 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index 6ba4cdc5db..b7bce8914a 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -217,6 +217,17 @@ config XENO_OPT_VFILE
        depends on PROC_FS
        default y
 
+config XENO_OPT_BROKEN_RECVMMSG_TIMEOUT
+	bool "Provide support for broken recvmmsg timeout parameter"
+	help
+	  The implementation of the timeout parameter for recvmmsg may
+	  cause infinit blocking even if not requested. If your workload
+	  is relying on this parameter AND can rule out being affecting
+	  by the race, you may keep this feature enabled. Note, though,
+	  that later major releases will likely remove it completely.
+
+	  See also https://source.denx.de/Xenomai/xenomai/-/commit/3d6121a5f5dc5eee80945856fccadc6dd9e2e104
+
 endmenu
 
 menu "Sizes and static limits"
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index d5813a16c2..eac577f73a 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -697,6 +697,14 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		if (timeout == 0)
 			flags |= MSG_DONTWAIT;
 		else {
+			if (!IS_ENABLED(CONFIG_XENO_OPT_BROKEN_RECVMMSG_TIMEOUT)) {
+				/*
+				 * The timeout parameter is not supported.
+				 * Use recvmsg timeouts instead.
+				 */
+				ret = -EINVAL;
+				goto fail;
+			}
 			timeout += xnclock_read_monotonic(&nkclock);
 			rq.waiter = xnthread_current();
 			xntimer_init(&rq.timer, &nkclock,
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 135f230dca..9a1060ef08 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -974,9 +974,8 @@ static int test_sc_cobalt_recvmmsg64(void)
 {
 	int sc_nr = sc_cobalt_recvmmsg64;
 	struct rtipc_port_label plabel;
-	struct xn_timespec64 t1, t2;
+	struct xn_timespec64 t1;
 	struct sockaddr_ipc saddr;
-	struct timespec ts_nat;
 	int ret = 0;
 	long data;
 	int sock;
@@ -1036,9 +1035,9 @@ static int test_sc_cobalt_recvmmsg64(void)
 	}
 
 	/*
-	 * providing an invalid timeout has to deliver EINVAL
+	 * providing a non-zero timeout has to deliver EINVAL
 	 */
-	t1.tv_sec = -1;
+	t1.tv_nsec = 1;
 	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
 	if (!smokey_assert(ret == -EINVAL)) {
 		ret = ret ? ret : -EINVAL;
@@ -1057,38 +1056,7 @@ static int test_sc_cobalt_recvmmsg64(void)
 		goto out;
 	}
 
-	/*
-	 * Providing a valid timeout, waiting for it to time out and check
-	 * that we didn't come back to early.
-	 */
-	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
-	if (ret)
-		goto out;
-
-	t1.tv_sec = 0;
-	t1.tv_nsec = 500000;
-
-	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
-	if (!smokey_assert(ret == -ETIMEDOUT)) {
-		ret = ret ? ret : -EINVAL;
-		goto out;
-	}
-
-	t1.tv_sec = ts_nat.tv_sec;
-	t1.tv_nsec = ts_nat.tv_nsec;
-
-	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
-	if (ret)
-		goto out;
-
-	t2.tv_sec = ts_nat.tv_sec;
-	t2.tv_nsec = ts_nat.tv_nsec;
-
-	if (ts_less(&t2, &t1))
-		smokey_warning("recvmmsg64 returned to early!\n"
-			       "Expected wakeup at: %lld sec %lld nsec\n"
-			       "Back at           : %lld sec %lld nsec\n",
-			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
+	ret = 0;
 
 out:
 	close(sock);
-- 
2.43.0
