Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57F30BB96
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489915; cv=fail; b=uexXrswd90g0lCOgyBZ7FK4qnBtA1JRceXJUSkCvZmjgCsu84hPQfpscaEl1Y5G7gU2nDB1h80oqvnVVnz+6UATQAfqocLK9YuLejPwxFA57yUlNjPEK80PjSbr1mQgIsj8gFrP7QQIQbRpNSnKb0IGX95bicQd0odzJ0JA1PVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489915; c=relaxed/simple;
	bh=WrVNZExSTlvxpyFrCdfqj625uGQNdsQtsd8YFfDcooI=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=FKFszmyQL57ozfrO3bpNLfWimMMO9xfaIWOSw4XlhdKBY7j+yGOP1foqN897mc6K+JOqeU/oXMQwHXC6zT5dbp6h9gXqEb8Cvo/qxUZQjvrFU7qELFLPZveVKKoZCpFoAY4nVvEEPxL71bQoYCR+fQjvkLMmrfU3yldt3CgwTHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=H6fbPmzW; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="H6fbPmzW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATKDiY0DY15VcY008PShUepieMpGrsDnjGNYXhgjOYcnJaBN7Ij113Ha9+riJvq6XcT0oWdNbsdf8NGs6+7Vfedrx8tINwMXQF3ydoVndDSD3lKQAVG6pUe/HFW0W08rgAVOZnp06GJ2P2KWfBQo1kOMHDjqjFpDkG0JM7CGT6ehXby3CAqPuh+WI/8jzCHLlekHjDHuRyy1idBH1ycWGcgpXaP/BJZD42NFW/0e2+9+7wMxXUuOUGlEcX6HnvnsaS75IprgXZ4ZQ6npGvsSzI4/Mf2dgruWhWKFOQUzLA1f+4vXRr34o84gEfCi1rhDjt4w2TnaOI3o9yppADOU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YRLV51z2tBwW5SIhMgJ0A1ZF5OmchMpwZ4hAYjdOBc=;
 b=YZegdg4wvUt5Ii2g8+1RKPS8/fAIE/8z+JAQh2cgW6KNNCz3evSBDd9Za43kZ5oJTOcmcSF5lDGXH6P9qDES5RKhiA/oCKqgt91gy0/oeVwJO2z4zSNQrQe/zTBI8DoT8uplNjRahAaY9JSdTBzMPjuSNBvVOKbexzErEV0W8CdFKaW5vkS+vfSzLZgCR4QG8aEqqaXEigg267xGEorLKnVfZl6bLbYPjZ72fNj+cgAYn4R8dQc8fCr4a2YduGe9A9Hxm0fcynAEkj2o6kFgMIzDU4tLsZbup8i5tBVTKjOf5jUL0+1jojDIDItXkfMrxG8FcdmF8j+xhK1CpZ0hbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YRLV51z2tBwW5SIhMgJ0A1ZF5OmchMpwZ4hAYjdOBc=;
 b=H6fbPmzWT5EFI1t+QmanTnBK0EsaOxr4vzjMfk13GNUyuDXRdR/BzxM5cA08uoUD7cws4YStAJdZ4TR6KAr+H6g6KEZGjby0vRmnPUgqLeHoI5t86kqrhcPUvuI66zRYhzW4Xc2dykVOSoab28495xYqA5lH0hvnsVcKvVCC3c+ilpRZ8RVw+TVR5uzkaWxy+sunysubFED+0Rqdv35dk8c5hnVWi0SxJd0mS2pSTXjzrx5drfdYizTcuGh1wQ+78R7kMVlzJwoPi1gjdsl9v5zSD7supJ2yONWJqyxXYHmEscqz5w5Eh6n4PWR2sK7v0lL9iIe7fO1DZywf3m/QDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 07:38:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 07:38:30 +0000
Message-ID: <16e43274-e568-4350-aac9-66f5f31d3f57@siemens.com>
Date: Wed, 10 Sep 2025 09:38:29 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.2.8 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3662:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ee8190-df36-48e0-21ff-08ddf03d09bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDF0VWxmbkRxUWxVVzhyb2g0R3pWYUxuMFdjUzZMSW0rUk5TUldSQmlDakZk?=
 =?utf-8?B?MEpWMW1hLzdkeVN1Ukx3VHJVc01kcTAwUjAvTkVQRldZbjk5RWxVNVZvL0lM?=
 =?utf-8?B?enJzZnVLQ296dDEvNjExeXRPZUhoNlNWUlJYMmJsL3NKOGY1ak13YVNWQ0ow?=
 =?utf-8?B?WFBJV1cyNmlKcEp5TnVqWGh5RERoY1gzYWpWeFVDbEgweTZHakNxckhLaXRC?=
 =?utf-8?B?czdSUFJ5NHFTYmlUQzlTeHVVMXQ2NzBmczQxYWRkV3lBT25sNTFuVkY2UGZp?=
 =?utf-8?B?UTRHS3JrL3JUNExoMFlreVp6Z093enIvcUdPWmJSY0RxVVBWQ2tZUkV6aE1L?=
 =?utf-8?B?bzF3cmFFK1phN2Q2d0JoYVBHeFNCM2tFUzZaNVZwVFAwS2YvWThKZ1l6WHRF?=
 =?utf-8?B?NmNtRmRJWit6V2psbGx5ZFlsOW1rV284a0I5YUdRM3QzUGFBYXJEazFMTmZ6?=
 =?utf-8?B?aGgwZlFRcFRRanppYUoxd2Vzb2pjc05SaDVYSi9HT2g2NkYxUlVsZFd2Tk1t?=
 =?utf-8?B?VzhDcmVpNzF3Y1Q3bzJnbmNhUnZtVGxiTmxoNXZ5d1NxbSswVHQvV2lQNjAx?=
 =?utf-8?B?SU5vTmFTcWsrbHVJZ2JEM0RYNG83QmdQNS9ET0VzTHhFdTBucjRNZFY2M09W?=
 =?utf-8?B?eTZyQ1BXRnkxRm1Wc1FBc0pGU1pITmRORGFMSTlObi9tcjNqalJBQjhuTlZp?=
 =?utf-8?B?bW00ejluNElFRmxOM3VwNmpGSlNuZHcxTWF2d3B0L3FLNGl4blVHMzRTM1NF?=
 =?utf-8?B?dW1wbmw1SWQyMXcrYzFLVllzL2o5NkZCVzFjQjNMUnozUVhXMWVIcXJ4eURB?=
 =?utf-8?B?eUZuWU9MK04vUzBNNmJYWjY4YndzSmtid0N5QnlyTTRDaDZpeUEyTHVyWjh1?=
 =?utf-8?B?N3RHRjh2QmpRVjhhUmU5WTNVM3d3UkhvNDF0UmZtUzhNN1lZeVN6bFBKaEN3?=
 =?utf-8?B?NTUzV001YlE1aUZxVjZqZzZNYXIrSnZFSjRDVks4RUh4dFhGRlQ2US9wVUd6?=
 =?utf-8?B?RHBkSkJ6TmtvRUtNWFg0aGtRaS8raHNUNU8zbDczWkRLaFBLb0xQTXBhaWVP?=
 =?utf-8?B?QXdFUVh0cTAvY1FuQjBtaEhTcWpCaUFWd2NpZTFTVVBLQkxudWthWElXejBC?=
 =?utf-8?B?VUc3OFZUUE5YclFtcDQ1UUxHZ29wVGtNbkVtUlJmdWYvUkRXNmo5S2Q1UWhN?=
 =?utf-8?B?NTQ5Z2JlbTdNYnZ6WThsc0hseHY2aVZxWHdKYmw1N01oZHdXS0ZRWDdJbTVt?=
 =?utf-8?B?OVFJcWo2QmJRNmQ5VWJqME9LTGJsYUpwUUxRMUF6RkMvMm1sT25QL256ck5Z?=
 =?utf-8?B?TU1KNHQvQnoyU0hxQ0dQMVJBMGpwNUQwLzVCMEE1OFNxc3B1bmc2UElqRENJ?=
 =?utf-8?B?SXQ5QUxhTGxOK05yQS82ZGV0TnRYUk1UQnBVMWZ2UlBvWkF4UW1wK2c5VFVE?=
 =?utf-8?B?eHR0M21TTTFsckRKeTFkTDQ0SkNLTFl6RFFzemVEek5YUDl5YVVWVWJranpi?=
 =?utf-8?B?M2lScm1RaSsrVGtaUEt1dkFJaEF4UmljOFNJZHdubzl1YUR4SmtnaS91ckFC?=
 =?utf-8?B?RFlaWmcvRk1pWFJOS2lvREg2VVVIbVZNNW5La2p4SGJReFlLSG9iK29ZYVFL?=
 =?utf-8?B?SitsNGtKRFlZWDB4VFMvdzFkSjQ4UEhZNzhscHB1QzVSYkxrbDNEcEhoUU9x?=
 =?utf-8?B?QW1iTFdZWHdCR2xMeXBuaXc2Z1VLd1VxU1pZdlZ6dkc1MWJCcGt1UXN3OXBY?=
 =?utf-8?B?ZmMySUJmZXNNN1dKMGxpa2hWb2hWQWE1Um4wMEcxeEMxZXp5MGhZZ1FKcjd1?=
 =?utf-8?B?UWxDWWlmdGxJRnRHa1RTbkJ2QU5TNThZTDFzVVNMOGFpaU1UWjJMTWtuSk1G?=
 =?utf-8?Q?0yE5q6wPeUrUS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm1SUHJtaGwrYi9WdUZNaVJybllZYi9mOXdDaUloWkpyZk1KeC9Kdk4raUd0?=
 =?utf-8?B?MVcvRzdCUkxmWFZFZ3dmUDdvVGJGK2J0RnhQeFJWWlYwbkFxUFZNKzE1MlUy?=
 =?utf-8?B?eW9BcmRpeituN1lCdmNoSXM5LzQ0L2FDMVNLNTdkampQeFFEcVMrTzFOUWI0?=
 =?utf-8?B?aWJCYjBSN1pQV1pHbkhaWXNrdGdvNHA2cllYc1BPYlNrVHhDQTN4SzV0UWV3?=
 =?utf-8?B?WW1hOE1FdWlqNE8xb29lRzArcy9VY2NqbTRqRSsrSm1wcTN0cXdyTUlpQW9F?=
 =?utf-8?B?YkNlWVdVckdtTG1tSFlXbGFhcVdubWNEQjJwZFlyNnd6N2haWksxd2srbm1S?=
 =?utf-8?B?MDR1NjdpSlZDUmJ6MTBEdVNJbE0zY21yQVg4RFVWU3QyTVluOGlvNERXdmVW?=
 =?utf-8?B?NTZTMFhnWERBa082ZWsveG43WnpLb1NtWkFuWE5Xb281YXZaaW9acmRmOS8x?=
 =?utf-8?B?b0pXeVYzYnB3LzkwVGhIR3lxcjZSLzhSWjZtUGVLVlFtSnlvN3A0dG9SU3pT?=
 =?utf-8?B?dkplallBZkIvbXhZays4WTg5VDBjWUZaSmRWL284ZE1uVnducEt0dkZlU1Bl?=
 =?utf-8?B?WnhuZXF1d092ZFhCTnFWQkx2d0o3RGdhRWpRNmpzYTRzRElMRXMzc2FGMEFX?=
 =?utf-8?B?RG10UTM0djQ5Ymk0STNmelVRdXJnV3BpVWVSeHZtOGpDenZIditvZ1pCTzcw?=
 =?utf-8?B?QnhGZDcxYUt5Sm05cGNSLzVlaHplU0FlMnN3Vll5VjNkbU42WllZTUhwWUNl?=
 =?utf-8?B?ckVTMXREbFJ2WlZSZDhwQzc2ZUFVcVZRd2VBL1h0MHZGTFM3UnBMTmRxSDgv?=
 =?utf-8?B?YTkxbGwvWC9KeWIxYlVmcmp6WThmNElFK3FRQ3ozQUczY3lrWkYrUkczQkVs?=
 =?utf-8?B?TTlzVWlMNEpyREZucHN6TlB1elVLRmlYaDMzcWFwWEJnTThHMlZFaUxzNzVW?=
 =?utf-8?B?SXlLU3ZzRnZCNUFBU3ZPMTlvMEQ5amxJd1RpOUtEVmR1YkU3VFIvL1hsTEJN?=
 =?utf-8?B?QWpRVmVnZDZHVHh2dDJvUW8zMXJaRStsV0ZtN2VRMFBQQlpnSlE3VU1kT0pE?=
 =?utf-8?B?dGhuTG81YjEvT1cyQXNKdVpoTXRGSHI0WHJsQWY2VStpVDRPTWI1MnhFN201?=
 =?utf-8?B?WnRsNWpTSTl4eCtnMExrZFdHOUNhbFhacGVHUWhSR3UvaHkxZ3hqKzgyckI4?=
 =?utf-8?B?SjVlK0VsVUZvSVVoRk56R1VoTmtVbldQUWZGUUVNZVA5Y25hM3dJdUd6dS83?=
 =?utf-8?B?anA0OEZEbW5SZHlHR2xsUU4yeWZMcVl2eGN1aldZTjdXb3EvQkpwMThuTXVL?=
 =?utf-8?B?QTBObmJMWXNVUEhBeHVrZFVzTG84WHRnSDJiNitQaEF1a2pnNzRYV05TVERC?=
 =?utf-8?B?T0QxU0h1bGJXcFZObWVCeXMyMVFhckRoSjMrZE02aTR0SnZYME15V1l1TEY2?=
 =?utf-8?B?eC9pL3VUbzBtUGdzWVB6S3QveGFvWm1BcWdtUVNmKzRGeS9KeEdSek9ub3hU?=
 =?utf-8?B?TFhBMWVPdnpwUlJEZkNSTWZPUzByNUJ1cnBmZmFBeWxDN3l4eXBJOWIvRjds?=
 =?utf-8?B?TXJ4WjNIQkFsd3FTWG0zaVhwN25sUHJZdGV3MHB5Q0QyVHFCQW9CME1jOVo4?=
 =?utf-8?B?M2E1RVN2UEpsSzAxT1p2Z2RJTmtyQWxHOEJhRWVpM1lXbFFQNWRaR3A0NVF6?=
 =?utf-8?B?bUJqbmVtdGRROFhPSzQ2T3l1SmdNT0dLV2NxU2pNNU1JZm9paFdpZFVVamw3?=
 =?utf-8?B?cmNuZ0xhMmlXNlBpb1VoZ0F4cDlBTVVyUFVLa1UxdVVQWERmYXplNk9ZeW9F?=
 =?utf-8?B?WUt0RW04QTRyTXc3YzhYRjRwY0ZFdkZNU25YSjhHcmJzVk42dm1vL29VZml5?=
 =?utf-8?B?bjZ0cHlCWFVSc0dNNVRkdDBrRGtZR2IrVndURlhKYk9CVXZzUHZhUmxscnUx?=
 =?utf-8?B?NEZybjJhMEEwZ2NhWnZvV282dU1GVmVlUG1iV2hEMFFqelIrN1J5VzBoTHpJ?=
 =?utf-8?B?N0JEenQ0Skt5N0VhRitnUlljaXBxbkNVY2xiQnpWaERCSFc1VW1XTm15T294?=
 =?utf-8?B?Z1A1bnhMelRVWVBKYkJqMnFURkpkUHVqb2dBK25VRGhEZ0NlTWVsR2xTWWNo?=
 =?utf-8?Q?0bS7TcSFhvEfS+574jUt0/Ld1?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ee8190-df36-48e0-21ff-08ddf03d09bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 07:38:30.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11ZU+pJQnTTxBdT/s5RZQTb0Gfxde5B8+okKDclRFuCOJWXTRwVHvE8xrQp2vpaoroXz4EErd9SKMuPkUZRyOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3662

Here comes an update for the 3.2.x series as well, also receiving the 
fixes for cleanup dead-lock in libcobalt and some smaller fixes. A small 
cleanup patch will even allow to build this version against Debian 13 
which will help us moving our test infrastructure for all stable 
versions to this release (and toolchain).

Download: https://gitlab.com/Xenomai/xenomai3/xenomai/-/archive/v3.2.8/xenomai-v3.2.8.tar.bz2

Changes since 3.2.7:

Florian Bezdeka (1):
      demo/posix/cyclictest: Fix building with glibc >= 2.41

Haiyang He (6):
      Doc: Add supported_cpus param for Cobalt kernel
      Doc: Add watchdog_timeout param for Cobalt kernel
      Doc: Remove xenomai.cpufreq param from MIGRATION.adoc
      Doc: Add fallback path for asciidoc-icons to fix install error
      scripts/wrap-link.sh: Add support for -h|--help option
      lib/cobalt: arm64: Fix syscall macro argument casting

Jan Kiszka (11):
      testsuite/xeno-test: Raise watchdog timeout while running in VM
      ci: Lift kernel builds to cip-based branches
      lib/copperplate: Handle allocation failures of pvstrdup/xnstrdup
      lib/cobalt: Unbreak sigshadow installation for statically linked applications
      lib/cobalt: Fix cancellation issues over pthread_cond_[timed]wait
      lib/cobalt: Avoid deadlock during cancellation of pthread_cond_[timed]wait
      Switch hosting URLs to gitlab.com
      debian: Enable parallel build
      README: Update project URLs once more
      ci: Pull buster from archive.d.o
      config: Bump version number

liuyang (1):
      drivers/net: fix compilation error caused by RTCFG_DEBUG

Jan

-- 
Siemens AG, Technology
Linux Expert Center
