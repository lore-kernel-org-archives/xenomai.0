Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C91F5EA
	for <xenomai@lists.linux.dev>; Mon, 30 Sep 2024 06:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727676419; cv=fail; b=agkIh2EJPPnASPd1qNV9Gp4ObgZQ5J9bjZMgJ/Kag46wwcMEVsRtYKKFc+QEsGUpQtvWEzXRJ4UOsJudRohJjpc5Zfdeb8SIsCQE2v0kIJlaS1cypjPp/znREIo8E6h6QvJCxoRRMhI4Dwl9dJoNQJXu10p37we8kSICHjZyEOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727676419; c=relaxed/simple;
	bh=yV42URxiPqHaYPyqSCKkgvK75dDvlzgf/JGUrI1TAbk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UhS+UeIFcsro5+OwQa9hZFMnVw3DjDnS0Uk1UX9zTxea4D4m38xbLPaGBQFq21QMezba38y+RFtmAuGR8yENgWF4ESVpZDBDhYWgWLku2ZSAXJ3iNKe/bMBGzpXtm1PbGosiExrHS/Mg+KYChB/+rjJt1jtWFWA41YmKLww4sI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vrZDd1p5; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vrZDd1p5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeuWDC/gGCXqdZJffJOOz2S2gkzP9bvprGnKoKRtn4k7SMLe1zdjr7/ZGeQSmtkdMAoYc8BzUgyhk+IW1dZWRxv6ler3DJz+nzTKKRLNw4VAxhj0Qd7zBtR/eqiOmRvWu7MnTxONeO6VR5kX4dNu/5KxlpNLhVrmPPINQUAOh0NZ6WQO8LqnnspPDXDa6ApdtQkSwb5TgiP7gv0iGNOCjGs7soeD+TXDbEqcMbHcIs71vh7q4VcbgQhfONHVKYeaaCcMU7Vf3DWdQAkCgEzi0xOrpyWIc1dNMU5fJdKKYRVv0Asi3agquAx8hiwwisw5WhwEhnRPBsQVgEcfy8fsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+1G45QyLt+Sw2FBA+HV2wIkCYsdq3DLU/y6wtwFu7c=;
 b=gOR7md+BzRRETwNn8ZqXd5LktidPIVqEK9R8F0gsIq/UmTd4HANYSSWcUx4r56Fe/C9gkBbSpDKBo4o1t1BuBigXVndoTQQHdjgNJNG5KlMMhup6g92w1A4brqIhFmcct4CzmEp+FIqXBWxcNxXfUx6udt4tw9RvTdgd0j39qFDlkIWOgh1YFf2xHVe82EGs3F4d2r2av5UA2XThg/JfY+MDUiMCkjmCIRmPNPlvJIsRmbJGIhJaLmYd78Om6IKVphki4Y+OXWgayNWn4sZS/o2I8MpbGvwJrSmgtwdFvzCSD4hV0jcXfkoKakH1uxLKrIT3rcSGrgGBCgfygdE1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+1G45QyLt+Sw2FBA+HV2wIkCYsdq3DLU/y6wtwFu7c=;
 b=vrZDd1p5hKnOAYx9vH3XSonChVLf4vnraMKGcOnJml4Reo8nrncmNUcUW1yACcRFp3LmsbKwFUjGwQ9K90yNRLolOhuRyBzI1garszNF/joVp7hKjCLJ6DbrmetYYsaQZZAv2wXZOuc+F37WvFTXYxaG4hHb3edq/LVRvds7SEQ3EYHPo9fpULgRQDNFgrs4j7zp5/RRJQHxCxHsROmik9PAj7+QHqZ2WXgQAjBJZtjrFt5Sa8y8yPrORPGaSbaj+Yg2NrW3OcRHxy3pXpp6eUsB9zdeJd3aKRD/ToktHwI/E2nVegja43vGL5Zl7fCj74sEXShXidbdSV4NTl3WLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 06:06:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:06:53 +0000
Message-ID: <11a37985-fa89-408f-9454-85afcdb34515@siemens.com>
Date: Mon, 30 Sep 2024 08:06:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: M_CAN support
To: "liuyang@sinsegye.com.cn" <liuyang@sinsegye.com.cn>,
 xenomai <xenomai@lists.linux.dev>
References: <202409291034463951884@sinsegye.com.cn>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <202409291034463951884@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ce0195-ee8f-46fd-bfba-08dce11614c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUpHMk9xeElsaXJBWkRTRUlwYmNacExRZHd1bmlVWUg4ZXJVYUFGK0pZaXhI?=
 =?utf-8?B?Z3R6UWRDaGk2K3ZGZWIzNHFRNnRYQmgzQ2NhMTdNYlZLWkYvcWIzblJZeWlI?=
 =?utf-8?B?N1ExT3UxdFlIZTB3cmNyR0l3SVBPN01sZGRtemVpWUlEWWE0aStyQitXTGh2?=
 =?utf-8?B?YzNDRkVkMzUxVHV6dks3NWc3NkpQQ3B6Kys0Sk9pQU12U2F4SHlTRTFsM0Ja?=
 =?utf-8?B?U2Q2Vm1taVNCVTNVcVZOdW8rVC9YdkN0cjFjaHZNMWlzNWFtOXczMXU3TVZE?=
 =?utf-8?B?SWRrVjdEbE5tbHlBRnI2UE9laXk1b3QyNmFlWnVJK1RjcDU1VXBhN2FpSjl0?=
 =?utf-8?B?VURpdWhBMmZBT1JMczVDZ2UydEdKU0hDSTZMUXJrdURwa2kydSsyT09xYitP?=
 =?utf-8?B?TG0yNXcxNkRPR0pJNFY3Zjd0UXV0d0hrdi82T095cUNMdFRhZDlDUm5hTnZl?=
 =?utf-8?B?RUkxeDdUTFNoV1RTVzFIa1FLd2hJL2tXNkZaMUMvLzdhTnpodVVTcVhIclA5?=
 =?utf-8?B?QmpPaXJKNjNveFRpSW9MTkpRQTFJTjBKZ2hVRHQwMWpsTHBqRjljcVBOSkV3?=
 =?utf-8?B?c2JjdkU0VnJVVjZ5STNGYlBlNmNJVWEvWXhmTG5PVUFLNUZVMGhoMW9hRVQ4?=
 =?utf-8?B?bENnMGpSRzM1Z0NmbU1FakxoSGVrR2IvOVU0QWVSeFdOM2VEVXk1NW9BaFox?=
 =?utf-8?B?V3JFa01sUW5JRHlTVEpXdnRERkZWZnp3S1YxUXdqZkxLR2QyV1NoM3BTaHNr?=
 =?utf-8?B?NWQ1TURWeXJoTnZhZ2hzMC81OUtTenpnVzVGbWhSUDJvMzE4dFZ2TlRXSDRK?=
 =?utf-8?B?NFp2cVBuakdqQ3NLdzdCd05QT2dwblYzYTBsNGhDZCtqSXVXNEFRY3dycDBw?=
 =?utf-8?B?NDZiT1ZRUDZyMUFoQUhaWGVSaWZXL3cyY3Y2SE5zSDNSWkt3L1FxRXZnQUxL?=
 =?utf-8?B?NzNPSWlHVDk4b3J1RnhpQlJRWWNmM2NEaW1nN2poV3NPTlZ1ZVNFQkFZVmY2?=
 =?utf-8?B?TFRPdWJWV2k1elVvODhKbU52dU1EYTlUTmdYRVZEK0tZQTBkdUF2S1l4bTJF?=
 =?utf-8?B?Q05nSjV3YjVIZWU4NnR5Rk8xYVZXdXVYcVJucWlocjYza0syRnFGV3hEUzdJ?=
 =?utf-8?B?Yy8rTXVjMGNGMUlFMVNWWXYyYkoxeUR4SWt6ZWlITmZCdmpnakllRVdrL1hH?=
 =?utf-8?B?UXEza0ZoZUdxRmZtRFBWUUgwc0dzMGlBaHhJODFieVRVYWJJMi9hek9LVHFK?=
 =?utf-8?B?S0pIaW8rTVIrWUl1bVlBR0JkWkxlWDRjYldnQVRVZjhUeXFycmw3OGtDVHVP?=
 =?utf-8?B?cURodENka3d0RUtXTmN5L0RhU01jNnBpdkQ0NS9tRlpSWEVDaWE0UC9xMVAw?=
 =?utf-8?B?Rk5kL1lGVmVOd05BbmIrelQ1YXFEQ0tGMlR0RFdSTTUvYTdwWkp5S3E5SHFG?=
 =?utf-8?B?VStpUEloU2VMRktaTnY5b0FlQkpzZ1dHQWlXUTVrdVk2eDVxZ3c4emtSOGN5?=
 =?utf-8?B?TmJBUEpla3NBTktUeHdYSHlON2VHMS9FYmpPNjBiRk1YZmQ3OUFoNXVSQXhI?=
 =?utf-8?B?azJQaHBXY29VMFAwbEpSa2lNM09xZElGMy95NXJzZE5lQzUzbEtxc2loYkVK?=
 =?utf-8?B?ZkRqN2NtTW5BQTdwTmkwdzA1ZTVWZ3NEQ3dZUFh4Q2hsUzl1NWJzYU5xOUlt?=
 =?utf-8?B?NlJkelVKTzZwWFc5M3VFMEtqbldCdUxpUXYveWJQWWFTZ0tsRUMxZ21leFEw?=
 =?utf-8?B?dENKZHEreUZ0UG5YU3J4V1o4VGVCYXVEdFcwcEFqajhOQjBib3pzUjl1Z2hD?=
 =?utf-8?B?VGJKZDNhcVFCZmI4Y25adz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHVMRFNkS01WbjFnZUk2cjZSZzlSTkIwZDFleVRiTXlCZzR6cVQvTnFscEVH?=
 =?utf-8?B?MGpla1ovRGhDZ0F5NzN4NVlyS3ZLbjZrUm40ZnB2NGtXRVNGOEpLZjdhTVc0?=
 =?utf-8?B?c0hPS05zZFlaejdvRU9vVzFRc3BKMGx5c3l1Y0hDZEliOFphd3pjcm9ydlUv?=
 =?utf-8?B?Mm9HMVBiOG9PQzdmV2dpUEJkd2d0QkJ0Zm1zVTdzQ2ZWRUhuUllTMmpEcTZZ?=
 =?utf-8?B?cnQ2Y2s0enBTN0JJajR4WkVKM2lqVmszWFpJU1lsVzR5cW0zRHpyaVF1c3J1?=
 =?utf-8?B?NzdCWUlsWkYzRXRleVRTYlZLUkNzdklmM3pBMDRiekNLSTRtbGNxQW94RWF1?=
 =?utf-8?B?OXo2a1lJaDIwalBQSHh6QnVYK2RrTGtCbXE5VFVmZ3hQK1RCRnNZc1g2Y0x6?=
 =?utf-8?B?VWFyWWNyUTJENEdiS3plQVdWZU1yM1d0eUpxdzhiVjR4clBPWTJzQTNRSXNo?=
 =?utf-8?B?elY0V2VlMk9IUXY3bWl4aWluTEVJbnRHOG02R0FjV2VjWUpxSHE1aDAxOWJp?=
 =?utf-8?B?aUM5TFczR2tKOTFqV0NJU0FrclVqdk1hUHZNeGRKR3JGeHRBTy9iZDBqS2hI?=
 =?utf-8?B?dWJoVW5wM1VyUjc1eWROK2FIL1l0T3c3dUEvTERNYVhyMmJ1ejVrTGhoMzRy?=
 =?utf-8?B?dDQzVlBGWThHQzRaeklYeFp6ZWkrUDA5akk0dTd4b2ZkTmJjN1ZrdHRHMVVG?=
 =?utf-8?B?c1IvUGVWTURHTStCeXNZZXRoUjQ5TVhnMUphVzljVXFPUUlOWDI2NE9CbVFK?=
 =?utf-8?B?eUc2N0VobitYNVBPcXpzemRxZVJtTTZHQUttNzdrVnh4YnZUbzRLUXpnL0hK?=
 =?utf-8?B?WmlrVDIzWUgwS3NBWmt3aEkvUHJTb1dXd2x2bFhMSnhhM0JWa01kd0lldEtn?=
 =?utf-8?B?NUFZVGVyOHFkbVZZaGZEMVhIWi9RYzFaSHd0NmkrVkk4V3NWQzRnUTdJaHM1?=
 =?utf-8?B?eFUxbUNaZ1dPalZwdWJndWJMUWs0d21hMktkZzloWlFKRzE1SWo0QjR3T3ZU?=
 =?utf-8?B?N2oxNXMraDFwb201ajF2cTdKc09EeUxteGNZTXY2MDlXYlJwZ2thMWZOcHh2?=
 =?utf-8?B?ZHE2a2hOWU8vZTlSY3VRcCtTNnl2aEF5ZUxhNHdjc3FYWi9SWFRLMXJGOEhi?=
 =?utf-8?B?UE5yNmZvNERpZXFuY3ZHZC9XOGU2aDJTeWhhaC9wZC9PbmJZeDA3L3Z2VDhq?=
 =?utf-8?B?YmxndlVlclpCZVE2S1J4MnZZZmZXdmJBY21VVjZxMUxXdStHZDV5MTc3akhv?=
 =?utf-8?B?ZllhKzR4NUkrNGw4Q25iYU9wMnJzU0hGeVo0YnlmeW9Gc2VpWHh1a1pYZDNX?=
 =?utf-8?B?UWUzaU81cmJyMkltbkFodk9zTUcvRUFrVkhkVFRPcTBmbEdRWnZSSHZETlkv?=
 =?utf-8?B?aVVVUW9TM3VGNTJOL2wyQ1hFOWtYVzA2bUJ1TE5SWkZsNXNKSGR6aG5MTW1k?=
 =?utf-8?B?Tk5NQXBOalFVcG8xcm9jU2N3bGs1aXRjTDFDQVdnOHhJNDRSTlozUkFzNGFG?=
 =?utf-8?B?dmdtZHVKZWFPaEEzYjMwdDBRT3NVZE9aUUtrZDgzM2tJczhhTWY0Wno2S3Ft?=
 =?utf-8?B?NGIzM0wvOGRYdmN5R3MxblVodkZ5NVJGejVMQUxleGt1aDUyQzFkdmNidlRN?=
 =?utf-8?B?SzczRGFqS3NhbWt6eTdiUUkxWDJ2VWF5UGtzb2Q2LzA3UHlPZFF5eFV1OENr?=
 =?utf-8?B?Tk9ZZ2JIeCtIaW1qVndXajBjRG5Mcjc1NUVpYldqdkppOUl2L2lZcG9MOVAv?=
 =?utf-8?B?aU4vRUxGOVRGTnYyeXpWenVncFNva1VqTGpUcWpYQTllRTJCOHRzSjBud3Fx?=
 =?utf-8?B?d0ludWg1Q1JKQU1hUHVJSUc4OUM1dmhodkErVXFLd0dkbVkwYTNTQXVlcWxj?=
 =?utf-8?B?TFFxbUpDWG5sbWZXU3V4aTR0Rmt5VmNodWZ1V291ekVMdmF5VSthRGt1Qnd3?=
 =?utf-8?B?dHQ5ZzJEbXY0Wnl5S3hzV3RPdjhxZ0FWYXNpY3dSNjU2aGJKZ2RtaDNCSDNx?=
 =?utf-8?B?WTlQVW1KN2NzU2VuWFhqY21aYUhXL3JSdmZraDdvbUhhZEgvRG5Zdzlma1R1?=
 =?utf-8?B?MjNGMmY1MFhONTRUc0RqYzVxUTY0ZTY2MTlUOURzOWhsOXE1YUVRNWJkT3p1?=
 =?utf-8?Q?ZKflybRjtK3bj0uUU50AjlK7o?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ce0195-ee8f-46fd-bfba-08dce11614c6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:06:53.4827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdseGlb6ca+WYT+b53XTREMPG5eFdrUxOtvfAluFclZvrtueqggZiYQ6UgwjkfI3cyVa3DGbip2LNDsmvPIQBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4137

On 29.09.24 04:34, liuyang@sinsegye.com.cn wrote:
> HI xenomai:
>     why does not xenomai support M_CAN? xenomai will support M_CAN in the future or not?
>     Thanks
> 

It will - when you send the required patches. This project depends on
contributions, specifically around driver support.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

