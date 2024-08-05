Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07EF18026
	for <xenomai@lists.linux.dev>; Mon,  5 Aug 2024 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861211; cv=fail; b=QuhM3wH2MooEO37n5KLJcBqk5hu7WwlVb6egnFOds7PKjbZq1gq19NnnOX3FrH8LyUCqpxQx4faEVJ1PMnQrHH/GmciOp1C1Vg58ncF8TH3jMwMy3HuMq26UBxPm76h5zmTCGBwZocJLWS9zGb1fhRvLwxr5IPqaS5Opn/s79bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861211; c=relaxed/simple;
	bh=3dq+zMcGKYXxaapDhk9+Tp74qRTm/M7KmqzBZk0EFhs=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=mE4FCiGoVRNT3vtMYgc4m6CLVow8xDAIDVPN2xyZhSqfE5Q6B/zIiwTRWS7UdJ6Dx44404V41JJLJNEncHlPULfdDtvoo3i0uQLWSSUHtxtJJhsEbd39j6CYvNpbjvFsokX+9nMZvxmjtOn57utZ7B0vfLyLtd5XEEOE8RlEkOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=z1qGoSSc; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="z1qGoSSc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cy86HdT8sWZqRNvKw92Bh2yRmqU5RF5+JDzmyv07ZM3GbdpySJOwsVoR9jsrQC8ngJBGYuaVyuXhJIWtMVdtwHbOpUbtwRKRkueYHCuEDDGd/IXAzfUDJOHz4H4QKwoRDnnlz/+udHfAlH2hGk1c+Nru6CQqA+36rARCckzzR6eGFvuEgbERLvrWY3pJIVmZRuvg0VI/HJ/KaRq8cJC3onrbSn9AJxB7esulV1cbHb04tZXLTVh6XKtO4TJGoCGkfLVrF1+89RYOE0AdqdrWa4zI1iY3HNRegaSw8H51IfuyL4Tp+n6siKlt/21hLczWdZoS7FhqPOwt0FzpKGeMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abXtAkDhn6CfTQfEJfxFfZhfUSxSlNw7GWw2hpFEzuY=;
 b=trgbyugnbIKWbtPYcQNyY+m2AyowvVdT8Xb+mjYfYFgqJs+JAtKmYoAxxPI+9FJz6XCnqYEeqXGJoXUWa7cmCHGgYq6dCiaxcYkdiI8dKvjcUHVt1ThVPKAZ2FRLheDJaNWiBdUq1/vGOrFuzsGTWoJXCczVnzwndIhoXaaPDyQg21nIqyLMf81uSTjv82ZRm1YX5+OTarhfOF8qiUSMynx49yLRJRxVIrhwQbOLe4aSg6byA00t8L91GVjvlipgQE+t/I9Qb38M2il+lYW7oP7/66LFl418phOwiFReVJxz778+zIm1bENCjh8vjSo0aUvDE3Lz7J3FmrQehs+l9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abXtAkDhn6CfTQfEJfxFfZhfUSxSlNw7GWw2hpFEzuY=;
 b=z1qGoSScaD8wHp2xBoVoTaJsjMqgT3s5nofaX6t27cQz+zWgr4XHGSrs9mFMqpkEcEFx8rX7eZtdlQ2qoanTReZkdncm6VfpnEYHpocvVClcJD+2/DGz9MHeixmCYoI9f6K+OyAzqRtTLWQX25w5iguTsIgcLVgUduXZBPBThh8yozmEHjnvgCTh65XrtfdMXj+W08XF2TTmc3qvC0AvOegjsbIR858yJ9j0gFGmG1zji+a8B+x5ENhGjIgjfurbmp8iW3MSKfi+XCtGli9aiJxag3EXjhvPwMkegArbcF4dTmQc5upaDjV6VwQ1Jrn7LukcxnjjQtmHQzyS50CbJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:33:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:33:20 +0000
Message-ID: <c36cc523-5163-4e33-9aa4-97765e9f470e@siemens.com>
Date: Mon, 5 Aug 2024 14:33:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] copperplate: Address compiler warning in pvheapobj_validate
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: ac63ed33-ad89-4322-e5aa-08dcb54ac9fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDdaS3hmSDRMWWt5VWo5aWpUUVlySG8wNUFjc2JzcFp2a0xkNkI3c0RkNkpO?=
 =?utf-8?B?RDhvb3JPbG9JeVRHNFB1ZU1UM2Y3dGtTdTQyZVdTMW1sOHZKdkw5aUlvUi9X?=
 =?utf-8?B?aWZEQnNzMy81b0wxSVJHWkVxRmJRbWU2QWh5bEFPWGRSKzFEU1RuT01yRERy?=
 =?utf-8?B?TXI5SmZHNGx0SUtiYWxMVlBUc3lYV2FsUTdQTkUyNXN1K05LTTBPZUhuL2t2?=
 =?utf-8?B?enhZRVZUU1J0Tkk1cmM1czEwS1Q4U0tDQk9MOHhPRERTci9IYTgzSGZrc1Zu?=
 =?utf-8?B?dXh1SEhLQWpNQm01eUpWTkZoRitlaE12ZlFoYVREUTg2UmRlS3hNK25PNWcy?=
 =?utf-8?B?TkhNeEJiRSsyWSs2NHZyRmIzU1I2R2ZxNU04VjJ2VHdxWitpblpuK25Cd01x?=
 =?utf-8?B?R25weWtxR2EzRXdBTXdpc0JPY1lCaW9MWEZqL0N3ejBaTjh2WnRaR3ppWWMy?=
 =?utf-8?B?YnAxR2prVnJNekRMS2IwRUZ1VitJNU5iSWwzK3JURkt6RTBpM3h5aFJBampF?=
 =?utf-8?B?Q09GUHRFaVZBVzlzWUJjMUplVWJhdnQzSlN2bVF3aHArUTlSbGhzeTMzTnR0?=
 =?utf-8?B?MXNHTUNyU2RLUE5xUzFHbGgxcDFQUm40RXQvcmFxSnF4aVFFUmFuNmxmaFZP?=
 =?utf-8?B?TFdXVnh1cnFyUk52ejBTUm5FSXhLV0NlblVBdmlTWUxHR0NLWjRRS0d4akc5?=
 =?utf-8?B?MVZrdG1LcVYvbEZHRzdmUUZUU2R2YzZYNlg4enlTdjdzc0Urd2RTT2JST0tG?=
 =?utf-8?B?S0grY2FzY3pYU0VQQmZhQmNmOW8zNzBUb0JuR09CdlJ6Z2U1bzdNVFFYWXlF?=
 =?utf-8?B?ZFFIS1h6aXNZblBiZVVpU2pVdk9kS2tvM2lYUk1PMGVqL2FSUytyYnF2dFBD?=
 =?utf-8?B?MXd6ZmhqdnVxWmtld0N2VEVqNEhjdnJ6VGhkQUNyb29uMzhGRHNhU0xjeWN4?=
 =?utf-8?B?d3pIRTVFRmZlOUt6aXdpUG1zbmpITXplcC9hSTJkdG53SWlUVWNyRG1KWnFF?=
 =?utf-8?B?WDZibUpkWEVEZ2VSUXdlWFBQeHh1eTIyVXpYa296Zit6ZmhmZGU0enVKWEJr?=
 =?utf-8?B?QVdYTk9tdHBhaVV4ckJLeFRvNHl6aFkvNzMrMmdsSFkrOC96R1BBaU9XYmVJ?=
 =?utf-8?B?YzFiVk5tMTMzOE1vR3hYUDBTNmhlamlrdmpIV2VCZnlWWWhBZUE4NkNaRzRU?=
 =?utf-8?B?dVdtRUxVditjV1JwWkJQR1hRNENuU2xtK0N2QmtCaFNEYWc3aHBHbVJ5R29q?=
 =?utf-8?B?TmRKaktQWms3Sk1EdCtUbDB0aXpyTUoyYkFrb0NZWmlhTFBhZXBGYjBOWWI1?=
 =?utf-8?B?ZlI3ckNORkh1SmpwZ3JoRm9iZTJ6QXY0K0NWRS9XUjkrWHl5bm5vSEJDbXF3?=
 =?utf-8?B?MUZWN2ZvZWRLcXg0VTFRVEFnSWF1Rkt5VVdQZTNTY0loOEV6b1dpSGRQK2Vy?=
 =?utf-8?B?clZrbzNLcW40Tng4Z0lRNVppWGRHMFVEekw2czZMK0U5S1JoZ0p0dWpSQ0s1?=
 =?utf-8?B?a2t6WWExZ2FJZy9vMEZVN0hQSnBEemtUaE5JN3FOM2xTNndHZGRFN3R0VnRO?=
 =?utf-8?B?TFRQU2ZqMHRuVERLdk9nb2dEaHNvcWxOTjBWS29DNGFrRXFGS0p3aktIci84?=
 =?utf-8?B?c0pHQ2RPRzc4SXl0cXBoakw4ZFE4d3pLZEN3SEpGdTQwQlkxdWpQS2ZPbkZp?=
 =?utf-8?B?Y0c3YUpkR0J2cmNPWW15VTJRZy9aNEdKUmJyRXRzOXN1VzVJTkFTeWc2Y2ZN?=
 =?utf-8?B?NmJiamZCeHVrT1B4V0h1MlpZVitHK04yZC9nL1NjZ1ByZEVucnJGL1NDdlhS?=
 =?utf-8?B?YVBaN1Y2bUZoYitQQUNXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHBta3NYYkhKcUZrb2l1OXhqQTlITDdSTzB5RnlGVVQ2d1pXYmtQdG9vT1FS?=
 =?utf-8?B?czlCRzNqd3lzUUh3OWNWdlhTL1UxdldpcXdySkY4dVFjNS9XSHhydVZscGEw?=
 =?utf-8?B?bGhoREFuMG81L2szZkRiK1NFV1dPYUFmWVVnbkI2L2w0N29iRFlROTIzTVc4?=
 =?utf-8?B?ZEI1VkdTcTZPK2hVOGRIbmx3WVFRMHI0cDRKN2k4dURFR2NzSGxPWm8xQ2FI?=
 =?utf-8?B?SURDcWZSNWR3OHkwSTJNT3JET3VLSWR4VjZhMkRxb1I3M3V6dSswSTg0QVFz?=
 =?utf-8?B?YzM1VUlmb1lEU3Y2QVlNaTBGckdraUZkZ01HUVRUQXFSaWxNam42MjA1bzgr?=
 =?utf-8?B?ajgzcDlEaU41ZlVlZ1Z0NGRqU0NCdEVvVXhpTkM0bkE2bGc5Q0g2MW9VNktG?=
 =?utf-8?B?OVFBcnp3TmgybDUxS3BXQnpkZ0tDQ05INk9DTzlqY3pLVTNqbVdkQ3NiSzd3?=
 =?utf-8?B?Z0FzanVLZjREcCsrQ0FUeHZYdlN1aG10dWYva0djd2gzRVJ4Si9uMTlDYVBl?=
 =?utf-8?B?QUJGdFpjZm9xZG8xVjBKQ3ZjaVVPSytVc2EyTXAzWlNmUnhIQ093MC9tZXg0?=
 =?utf-8?B?eGhsZE9SL2tkYnlMN1FSOHRURVo3SlkvNVlOaVB1bUxsaEJlcTJ0WkloZTRs?=
 =?utf-8?B?ZW8rOFZHbHBDOGZnYXFDdlMzbUZKeVU3c3BjWHVqZ3diR3FWcDBja1AwZ0hp?=
 =?utf-8?B?MGJzanJNUElIbHdVcEZFVmxyY2RlWi9lZC9mdThocjBEUmtBNS9oVGE1V01n?=
 =?utf-8?B?bmFZMjFRd0NCSUxvelU1MTR0KzJIOElSYm1FSmU4SVA5SmFQQVlIOWR3N2Js?=
 =?utf-8?B?QUhWQ21EUnNNOHdBTzdCcnN0MUpXaGlGK0dDQzBxZWVrSGczTzE3OWh6TUdv?=
 =?utf-8?B?elE0dENKU2Q4S1BnQ2g2M1lKY2ZwSmw1SE1HSFdjZVlpUkFBWWdETlNlajZ6?=
 =?utf-8?B?bUREN3ZBRTR4ZXpGNTVPYlk2WGpjYytieWZNQm9RejN5NnNROWpOdS8vNDBm?=
 =?utf-8?B?aVczcW11U01MOFVBY29MOGp0eSt6RVgrMzR2TWt3Wkx5THFXVXZFY3RpVTBt?=
 =?utf-8?B?UEN3WU5QSW1FZnVJKzVpK0JJOCtGZ29ud0syT3M5dWtqd1NBUHF2UmNta1RQ?=
 =?utf-8?B?UFEreDhDMWxRM2I5ZFBBaUtPOVVaY1E4bFdDVEhsUk83OTJqRVIwb0JVQzRt?=
 =?utf-8?B?dWpQM04rMWl0VWhYN20xcnplKy9WMG5Lc242ZVUrYW8wcWpPRU51Z1cxdENa?=
 =?utf-8?B?Y3htVUl5M0FLaGdqRU44MWZtSzVMSVpmRWhpM0JDckFHdlpMUnVMeFp1VHpn?=
 =?utf-8?B?TTV3bkkrYXNaWStHSUI2M0ZmMnhWUnRUS1pOb25Fbk5Ub09YcERMNGQ1bTZD?=
 =?utf-8?B?ZXRVdVVXMDhNK1AvN0ZhZEdLRHc5eEFnbTZ5SDQzdHVMZDJYL3FQbitobDRC?=
 =?utf-8?B?VmVuTi9ycGJhQWsxMXczUmlCWEZld0M5NmM4NU5NM3ZOMWRxOVBHNTBKSTNr?=
 =?utf-8?B?Z1hHN09UZU9vMzJOSW5abkwrVldaOWN5RHpHOVoveTF0VnlMZmNRUXhDeHFt?=
 =?utf-8?B?bjcrTGIxVUFuVFhsMmM1TWxKaG9UbVFOL3U0bzZKN3FtWTgzYlE2MUFxaGx4?=
 =?utf-8?B?WE80LzV6MkNkZG1WYUM4dnNGZjM2NUJIUFVUakhTckRoMDZDRmV6VHlOeHNi?=
 =?utf-8?B?MGY3eStDYlpwZWZ6VFdvSHRta2EydFhPWFUvN0E4WkVMWFlUYkluWi9saDNN?=
 =?utf-8?B?bE5Ia3lWdlU4RUpTYUhYQmlZV1RaMWI1TWhGamVXa3U1dnVxRXZxNWtKc3pS?=
 =?utf-8?B?WU5yOCtjWFREaHlyanpCa0YzWk1QenlzU1dQekkzOEtvczRpcGNSbDE2L3pP?=
 =?utf-8?B?a3Z5SVZqMXZvQWM5K2ZQWEEvK0lZSVZ3WWpNY3RYS0FNdmdES2tsMDRRMHg1?=
 =?utf-8?B?VmRwaVRDTVVzcXVHVkh5ajdjYmVyb21ZRGZNSGdvT3NqUXdubGdVZ2FzNkZk?=
 =?utf-8?B?bTlXMlorMXJ6UVcxOFZqV0p5Y05DbVF0RFJGUGRNK3dTQzFMUnNTSXdSWEp3?=
 =?utf-8?B?ODM0S3d5NHhxa1d0TlJjbGZSM1JUMlYwS2hmMDFyZ3lFZFV3MndHMWRacjNq?=
 =?utf-8?B?UE04K0Njamt3MkxKc25qemRpRmJwam1MTmRBcEI1NHBsY0NwQUxDY3pTMXZv?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac63ed33-ad89-4322-e5aa-08dcb54ac9fe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:33:20.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMZQP98clx0bd+DNzc8akkEvMch0M5I6VkQXLODolePN9KqPP1mJaaSxrcT/tRzA3R4kWyyvauTikffl6BLwFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

From: Jan Kiszka <jan.kiszka@siemens.com>

Resolves

include/copperplate/heapobj.h:180:22: warning: conversion to ‘size_t {aka long unsigned int}’ from ‘ssize_t {aka long int}’ may change the sign of the result [-Wsign-conversion]

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/copperplate/heapobj.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/copperplate/heapobj.h b/include/copperplate/heapobj.h
index f8d14a3aa2..51a95cb968 100644
--- a/include/copperplate/heapobj.h
+++ b/include/copperplate/heapobj.h
@@ -177,7 +177,7 @@ static inline
 size_t pvheapobj_validate(struct heapobj *hobj, void *ptr)
 {
 	ssize_t size = heapmem_check((struct heap_memory *)hobj->pool, ptr);
-	return size < 0 ? 0 : size;
+	return size < 0 ? 0 : (size_t)size;
 }
 
 static inline
-- 
2.43.0
