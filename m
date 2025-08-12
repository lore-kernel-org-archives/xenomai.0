Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD72EE5EC
	for <xenomai@lists.linux.dev>; Tue, 12 Aug 2025 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999828; cv=fail; b=ZBxH4OBkD8WavHL86efKoG26snr0giP+Ffrza1xnixixzd+iFYyOQdxo1S9Jjkwh7ghv/5zz9PIsyIB1sgA3wfI8smKL+GKzGRqhHcglReaUrNC8qKFba1Q2ZR5dNnzGj6vtG77PWHMzcoZvgTD84EwciJRpj42s7dJzxqedH8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999828; c=relaxed/simple;
	bh=Tc71U3kwZ4tr7tM2AJAWfe5XBfiuAB/YHaTzhCD9HIs=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=Aw5vl31sriqeeUdVNKlosHaOVprCXo//+kHP5Gkxe2ee7jpKyBBozxK1uVS84ZSCIfESZ1Zu/qJxsX376aj2fwIxHkSVvCT8Mwgx0uHF6CMd4tAqt+VOcLpKJuo8rCMXsJ20E4g1K5dOEg6DHSNdCzzTRfysEIv7OabPG1zpjLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XLktkl8T; arc=fail smtp.client-ip=40.107.130.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XLktkl8T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NToR5r5CRY6Cy0Bz+F75Ld3eeqgxugcKoV/hylzYWNeyZPzu5/afVIDbME1mAD7a2eVy/jz10WTSKTCgkHWQGqsoexeAQdG44cINeirx36rJbZoBUXrgnTu3znbf63h0YzFXYNO4f1Fobn3l9Oo3lsSS1u0F71RNoDJ8tqlSIrgYvczXP5FJugEzjj/aWeiIUVe7YS2x1VHhXFu64ofh6MJolHIFbstXnNwrzGW3XuV2IluSgDVHTc4GuM/uNZRMgN+FJ0iVEDSSP3EJvSk3Uq/umLnMZzqes6FpqfjrhBSStxg/om28vvtFvL579/Uy/KBbPPrcInHPTi8qn+E+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U74Jk+XLj3nAG+fekRUpCc5WdHtzg2hzuQ9p5EdKoDk=;
 b=pOSHmEMvYTBwiEUVnsjQybsmo9a8EtPAM4GVvwVuDGDFcKLEgPrLqQDVOX3D3tYQu+rC9x8yV8AysnPX5RZKIoNR3MdbfCRFqpn4dKtC0RxNolDiLezqGIxNlAU6BwAVqAM7pY1BzQ67NvSyvo4XH901WMN1SlUzwypII0QAEv6U4mBAEVdL6ymIePcbMg57PKwVe0v5ax4r2GFjp6sfkFTGK5ZVv1zEBDctwfHJ3M1OYo8gjLARWhBxc/D45r+E7e4HkrN1twjYQ0Nz2G1IFWCzEdDsUn01PtGnN+HNxol992qkj0q12F6XWxHTZRRE7C7AQKOwqchulC7Rt+Bi1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U74Jk+XLj3nAG+fekRUpCc5WdHtzg2hzuQ9p5EdKoDk=;
 b=XLktkl8TPJ95CdCfX1jZrnVhx03SS87vaDYHK7TR+zvPtpUzyi26QluJfjqDFjE+fa8DWwHZUDRRzxj+gemESxOFC4pcLk6fd/BkpVUvigsnmA+yUFpoTSaZ0otkNZfMYNo+bSBE2FcOR/rDlMx0DQVUcPSKCU+D4KqFq/pBnKN4WiKyVbA2jMNZ3x5SqAQqNMCSqRuJ9rOPVCzJcr+IDV5uPPrjjB1lHdF+1gNdcVuOdmxp2dojZzUzTboo/1yHajWeJQ9Np8L07oH5goGoEx0F/JVJiRjOGW/jc9oc+ZgPfptnGgCPA8Cv7GFEaxvQnc0IBqUlbtXNwCjk6dvmKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 11:57:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 11:57:02 +0000
Message-ID: <aa60da66-ce3a-4b83-a2fb-d00e5306ec5f@siemens.com>
Date: Tue, 12 Aug 2025 13:56:58 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] User clear-test-password flag for root user
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:610:b2::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd2c7f1-0af0-4bce-b557-08ddd997599e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFNVUkwxK2VFOUdoMGxhMDZlNXFZaWJRalg5V1kreXlJZCtMazI3NnZudnhM?=
 =?utf-8?B?TkR5dUlyNzl2OWRudGZ0bFlrVmdxSkUwTWVuZzZCQ3VxcG5rWW9ic2tuL0xw?=
 =?utf-8?B?RzRLU05mVFNoV0VES0tJanZjVkxJUEFnU2tOaGpLUXZRRWh0M0pLQjJ2elVC?=
 =?utf-8?B?NFJ2bkQxUXZYTVRlcnlXVXpXbk82ZHJXdHpaWHFBMHVHMEIvNTJ1N2toanEv?=
 =?utf-8?B?L3RwQXZyUHowNnNBc1h3QmxNT3RNKzZTaUxsOHBsMnNhQms5UHdVa2pUbDhX?=
 =?utf-8?B?bU1PdDZCREY1Vno0SjVtRnRKb0xzUXVzUERlNkhXT3d6aXQwY05nZWlWVC81?=
 =?utf-8?B?eHZtcnQ1Ym9EczNKOFF3bU5PT2dwSG5DY0p2RnNCSDhhT2Z5YXlhSlNHcmJL?=
 =?utf-8?B?WmVhdTFIdXRzM3NWdmVCREtqTlNOZDJ5a3VVVTRteWNNM0tTWVNRL1UwYWZW?=
 =?utf-8?B?czhRWVdlRXlSOENXT1FDRXJoSXZ6V25sdmVkekFucVpDdkRmN3hUaThFTUx2?=
 =?utf-8?B?aHREZFYrWkhmK0dYcVhTeVB4dVdUeFcwOVFpUE4rQWt4clhacVl4MnA2YVpl?=
 =?utf-8?B?YzUwWGZzdVBEK3dUa3Y4STlpc3l0MHhjWTZFTVlWdjRiQ25ZYXNPNERhUXVH?=
 =?utf-8?B?VitUbG8wWnA2bU0xQk1IUmRqU2orSTd0bXcvb3BnckdqbUtBTlhBUUpwRTJw?=
 =?utf-8?B?a3dPcmdTTFNxYzI1MTVpc2NXeC9mMjlTY3BzRkdVdGxjM0t6elFGeHJOVG1i?=
 =?utf-8?B?dHRZWnpQUXN6NzZNT3B0RGJGSFZRRzd6U3NnMkdDdVZRWXRlNzUrU1lMSjJ6?=
 =?utf-8?B?RytPS05FNGV1aE4weWx2YnAyZy94ZmFjYW1ETUhockV5WnlQK09VQUV0S0wx?=
 =?utf-8?B?ZWtFZVJrbEN3a1BGNDBFNk1RWUJSSmJEVmFLbGNHQnhYZjdZUzRhcFdRbllJ?=
 =?utf-8?B?VXVIQnlPR292dnptN2Y5NlgyaUx3RW1FVGV4QTBHSmE5QnRBczY1ZWxBcnVH?=
 =?utf-8?B?MHdQaXlKMUoxUk5NNk95UHNDZnUrVDR4Y2hTZFBxdytZbmZZbUx3ZGl5Rms0?=
 =?utf-8?B?MXA5VWZpU0c1b1g5ZmR5bjNJeW1janpaTGFzajlkK3BjQkJEWmR0L2V4RVNE?=
 =?utf-8?B?UDI2TXoram44QzExeVY3cHcxOE5XUEl0K3RPQ0Q5U3liUDhFRFVXMkkwOCtP?=
 =?utf-8?B?amo4SjlsTlpIMUE3ek51cWU4N2ZESDcxK2RZODNaVXF5SFNwSFF4S2c1dnBn?=
 =?utf-8?B?TEN4RFdNUmo3Z1VtN0c4K3FENFAvVzEzTWxrc0ptRUFiNERwZm1HY3FseVhR?=
 =?utf-8?B?WU11K2IyUXVxSWUzQ05MUm5qOWg2YmhDSVowVTFNYnl4SFlCWi9TYzhFcXM5?=
 =?utf-8?B?ZnJvay8rakF0bmxmRDB2RjZXZzZQUDBYWUF2bkZSMjAyV01scWFvZ2l4Y1Nk?=
 =?utf-8?B?MVQ4MkNNYklVKzdHSXJtYWMvbDhkYSttTWNNeFo0bFE0WUt2WHV1ODRPcHdq?=
 =?utf-8?B?OHBxZlRKWUJSaElSMlRXMlZpOWFWMTNhd1NOU0Q2SnBNcFFWemZld0VhcTQr?=
 =?utf-8?B?YzNRdkt3dm1RbXBxRHhKd09GZXJuNXJuQVRhbE9KdHlVWEc5L2RtYVFwTFVT?=
 =?utf-8?B?YytjWUtUOXRnVE50ZnI1WTliRmd6TzJpd3Y0cFRLdndGUkh5U045S3hsYkNW?=
 =?utf-8?B?Vk1nKzRpdXVlYk50b3BMT2ltQUFwcGlGSVBkdE1kdXhMaDM3ZldXeG5iZGxi?=
 =?utf-8?B?Y0FUYVloRnlXSFpuT3NGK21ibnFLVkpiZlN3NzNIMHJpYW5mUGs0UzJzOG5F?=
 =?utf-8?B?cWZqNENNeW5aZHNaUXpTQ0o0M3c3NVQzc0F6ZVgwRDUySzNtV0pxbG9xVHly?=
 =?utf-8?B?SkgzMlhGWU1yRzhxUThwZk5vZER4QzNPeWVqYzJ1c0c4YVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW00TG1vQVZlcmlTRUtqejdTTkxNWmtvdTdFODAzcFkwY1FqOVRsSmEwYXpC?=
 =?utf-8?B?SEJOcy9kcmh1TzltRDIyVzJSbmc4ZjRJbWtNcmdYSktvemQ1NEYzTGRnamN6?=
 =?utf-8?B?V1k3WVE0QWEwUUIzVFFEUEZ2UitxaTZkbjNrSE9YZ0h3TlBLY0ZaTmNSaUJa?=
 =?utf-8?B?aUE4VDN1L285cnhaOVk0ZGlDWGl2YklNL3AyWjI3cXJhV1RQOEFQd3ZhVHRV?=
 =?utf-8?B?VmFPMUJrL2NETytncG53clFkT1RxYStRM0RjTG1oZU5PZFdUZ0l6b1c2MUQ0?=
 =?utf-8?B?cXluWGRqWWsyT3lzdXpJU1pmL3MvMHNiaWQvSitPTWhWT1VHbjlja0plekJQ?=
 =?utf-8?B?T0w3R1IvUlpuRXh3MkVjY2RCY3Y0VGgvRkFhOEdIUGNhQlh5amdHS2sya0dj?=
 =?utf-8?B?N28yU01KYWJaNy9DSGJiUTczb2ZEUDlzYXpmZStWUFNMYTJ3TEtOZDB3Tk1Q?=
 =?utf-8?B?Zi9DMnY1RHpDcCtqaFRJV2VhdXNnakhUc0hSYjMrTks1bG0zSWRGS1ZnaWg1?=
 =?utf-8?B?R3ZsSlMvZ2h4SGpjMTNFeVM1OEN4aFpWSEk0Ry82cHhOay85K1R4WVVLU3N4?=
 =?utf-8?B?bGNwUUU2azlwdVBqRVliZC9tdHVYa2JoaDhqSnVZY2Vvd29Ed2dNVnBuTXBh?=
 =?utf-8?B?ZTUvRjhaQTZSK3BYYmYvTnJ1bEYzMjNGRVRkT1R3RFdENmFBTzRXQnp6WDJy?=
 =?utf-8?B?NExRRWh3cktsYzB6aFpqVFVhY0s4N1hEODlrV1NjUmRKQWxaQkNzTys4elBJ?=
 =?utf-8?B?eHRXWFRhU1VqR0Y0VkxrL2NXdUhiUXM4SGNldk92KzBaRkdyL2tIYis3WDY5?=
 =?utf-8?B?RDFRRVUxMjNteVpTTk5YYUpQRFJxektMbUFQNkN6aFFVWnVhcVBaMHdXdEpj?=
 =?utf-8?B?MXU5YytzZWtuTjBNblB5U0tIV0Z4bnVVOHNnakM0RjVFRDM0dzJIS3lSSDlS?=
 =?utf-8?B?UWxhZTJaSXZPUUkweGVNeHhDYlppNVRlbkZFSmo0MllsQ0hROFJpV2NNV1hl?=
 =?utf-8?B?L0srazJhRkdRYXBrUDNxU21xWXpodmFVaFpoMnFEbjJXeE51QjkwYW1FUUN0?=
 =?utf-8?B?WDhmbVhWNWVXcGlUaEJrZWFMbVl0YjlibkpXTXB1MEc4aWw3dkdkek03NUJk?=
 =?utf-8?B?M1JRcDFXdHJTN3JXT0pPTzVsOFpkUE9XdC9MajNOOTZhTXhSU3ZLTlhUR2NH?=
 =?utf-8?B?LytPOUFlQWhqbU0rOW5HaHg2bFEvZ0FHallHYUpSeU5wVFdQejkvNU5zLzFH?=
 =?utf-8?B?d3o1WksyQXpnTHFhR2dVTE40YWN6em4yKzNURzU3Ymdrc2g0Tlh5MVIrQ0Zj?=
 =?utf-8?B?MEg2N2FnQUdBV1ZjdzdWRHpKbUpXdi9qbjJmUWM0b1NZeGRTeGoxbnpFbHly?=
 =?utf-8?B?bE1KTWxUTzFURFhpN0xJN0RVNEdBUHBKVWdSeW40UUUwYWU0UUVQa2laQlhz?=
 =?utf-8?B?MUFIM0N0RUtyU1ZBRGlYNkplWFBqbThXcjN2d05QUVZTZUhTc0pIYzJxcFNT?=
 =?utf-8?B?N2F1Y2JqYm04WmIyRWJFRzBBMUdVRU1GczlIeGRsMUQvcjMyQjYwSTQ3T1Y1?=
 =?utf-8?B?S3pHakl6MWx2V2VqMG52ZmdROXRnTksrYTJ1c1ZPWXRYaVI4cndmWU8vTDkx?=
 =?utf-8?B?c0NlU01GcDJoZ0ZlUFdkTDFOSzNSWUZMY3ZZN1RCczBvVkl0aEtIKzdYdTZY?=
 =?utf-8?B?NEE0alp6ckdXZnM0d01EbWlITXJCTE9LSzdVTzM5dnIrRit1d1QzYXRKVUlv?=
 =?utf-8?B?Z2VNVVh3d2p1aXU3TXNycmorVi9rdHFNeTlmRjFkSEZZVS9pQmNISXBtOG9q?=
 =?utf-8?B?SEhRZG5KNlBQNkpxL2Ewend0ZExKM2VqaE5uZEY1SGtXdWdFVXhnaUJNL1Np?=
 =?utf-8?B?SHJiYngxUVpJYXlRcUpwdHY4MXUrQU1HRjNGS1hxNUM1dXI0RUR0QmVUcHpT?=
 =?utf-8?B?dXRVSzlzNXZHTzI5RktWOWFzTjkrc3QzRWV4ViszSjNXSjU3ajhKcUlwQjdt?=
 =?utf-8?B?dkFxT1dNNkFEcjZWZjVlY1I3WVRrYkNXNkwzS2hyVU1tMlQ4SXdibW9USThq?=
 =?utf-8?B?N29oNC92TnYxaCtFQlB6aDMxUlBhcWVqdk5ia0hGd2IweklyK3g2V09YS1pq?=
 =?utf-8?B?a3F0MGFNRU40UnRibHJtWmhsNzh1S21wVzBwQkg4YU50bU5UUHhnUnRxZmEv?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd2c7f1-0af0-4bce-b557-08ddd997599e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 11:57:02.5427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lK/3v9iP15QGBIV2EkXxbZR1H8xW9pzY0je/S0CwDntM8yKwmJUFzdzS27psBm/DrW2hJ4vnw6L5Xjmle+JDMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6828

From: Jan Kiszka <jan.kiszka@siemens.com>

This just makes it clearer.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/xenomai-demo.conf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index a113a54..8377732 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2024
+# Copyright (c) Siemens AG, 2018-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -29,5 +29,5 @@ SDK_INSTALL += "${@'libevl' if d.getVar('XENOMAI_MAJOR_VERSION') == '4' else 'li
 WKS_FILE = "${MACHINE}.wks"
 
 USERS += "root"
-# 'root'
-USER_root[password] = "oC3wEGl799tZU"
+USER_root[flags] = "clear-text-password"
+USER_root[password] = "root"
-- 
2.43.0
