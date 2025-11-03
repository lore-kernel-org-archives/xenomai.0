Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445772FE04A
	for <xenomai@lists.linux.dev>; Mon,  3 Nov 2025 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175013; cv=fail; b=bq1x9ns6lj9iWEZDNO16n6ehjFCC3r4nZOFLfEt7yXscJr2Usb2EqSN4Zn1W19S0YqTTIBkMBtBBnLcHjUnc64HUpajVEf231wnKllefVm2iS3BKQ8zYoZTeOabN1gK1o1jebmGG/TQcz6m1oHgPGho2/2jL0Sn7oGxJc/7vRVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175013; c=relaxed/simple;
	bh=ZikhCwOSo2ONPvmvZi+0yVfMnKwwSfUa+8mTnXGqgIY=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=Y3YGH1awE1R1OTUspH60XjmZ9obF24dTPPJQihv5TpOtEnEJLkXA4tISA6tYXiNliUfjqg1GnvXflMtsfHM5IEjveBJoXgMg008F/OSCfXkZEsDJWu7ibCv8jgYTQ6pyafdKeOgFYoOyM5MXF93ms4ikQEzLTFXoPRjf5yA2SOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TAe/Rl3O; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TAe/Rl3O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvH7HYplH+gZ00tEgi+Van6y+3AqtZmhPHH0ZgKGAm3vqNmhwgxqfMYWtilJLXjTFRxkHCoZcX2pr03BH51Ow4KdwAOEW4Ht/N/2ifE/DU4bhA3v0beQtbPmcdCxhdm6Ec7YnrZjZW8Ii5ITmvx5wOfyfaImXTZExoRQqcR48pepZaTxJKNikDJpmI5/vdNyiVJevIA4WXpSLTsuBiM5oX1QE4u0PkWjgw0RGV3YALXm1FXfELCGJaajTcHlEN2CgrIuww4FB/jN9vzs8Vfk/ZSUV57MCYnFupHWp4+D6OuFL3Hy4w34cMXuyZ9CcM3wlWVyw92nmW4Yc4zms3VUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNkDI8JnyLwtW2KzfLaoMrzhAGn88MedO0SUjL9oe9s=;
 b=TXx79ZgEHf5WDGzH5Yo1MT0uQGL8J0bpxLAe3YqgvnyjP4ArmmHGX6fIMvZtyBu+IUAZDSfdCSQImzsss+rCjOjbmUkpe+bVS8VHECp0V/wGqWB9VWKWSwbthLIEekbV0siQBg1SR3Rr8cQzX5ENKEbQKrMxw/FVOYlCIk43DLFa9vlRghPD8COMREXp/keHNQxnyLZS3tVu6IHErP8S5JCeRHycxAz1NCv909gZzFLkXhUbReiC200eZxgLA0DkeZHAoIhN+sPbIS3T/SwSAYtqQLnS1Piwt/FNc7PZ1w3hmuMK6KAmCPDX0iR//vKdMF3kbcc39vWyjFxS8D4dWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNkDI8JnyLwtW2KzfLaoMrzhAGn88MedO0SUjL9oe9s=;
 b=TAe/Rl3O81dkB2R9BEm17UX8ittDKlGPbHlaeXOsnR1vcIiuJA6d4yNn/ewKQHrf36TgDGFNTVpn4mFqtxT2tcnMiKZ18gqp8H50r6g0xwabBXkYNycG67TL44XSxEmVD+pvTnwZr2hov/h0DDhOd9cpsTNjS2vNt+q1Wp5Xl+coS5SaaKd7wUuVNsHQ9uqp54NgiTdmrlnSQ6NeFQjyYsagMcg0IuB/S+iW2sLQxb/Z9a+bcYpVB6DEAjgA/yGkhHsIZcEHlHzAqHMQzGd27yOyHID/MxYj2XrjHjbkL06iVwAckrfzQzmfZm4ZX1hahkm/I4RrdfmK0k7RUOWgpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:478::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:03:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 13:03:27 +0000
Message-ID: <169860c2-4e9b-4d97-89cd-97100b30f814@siemens.com>
Date: Mon, 3 Nov 2025 14:03:26 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Update kernel releases
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c41928-2007-4955-e00f-08de1ad9614f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjRLSkpPY3YwekxzNjlYdmFXbDhlQnAzN0t4Z2dIZFdhem9QZXpIMkZUdkVQ?=
 =?utf-8?B?ckJiNXZwSzU0OE9CM3AwK3kvMG9YSFREQ1VOYU9pWXNVZHNLNmFqLzRWTFN1?=
 =?utf-8?B?dWFyajF4cyszQU5aTjNCaWM0alNoaCsxeTRNZW96L01pREw5L0FVOEFKVHIr?=
 =?utf-8?B?eHRxVXorTjBmTGw5Rld6eld0aFhuQ0JTVHMycDFSdXozUWQ0d0tPK3F3YzZ1?=
 =?utf-8?B?bWVVMWYxZTk0dzE5Y2hWV1hhalRWT0gxeEp5bThiVlF5L1lIeTFTYWl5WUlP?=
 =?utf-8?B?QVBsZ1JxUXJOQjlxTllHYjlMeDdYVm9DUFU5K3BqQ2ZXVFcwalB2WmlGTzZt?=
 =?utf-8?B?WU5UZHJDZFFsRnFDSlRFck9lcnJDOGxQOGQ1YTdUNXRjeGppUGF0NU5ZdGg0?=
 =?utf-8?B?VEVSNnU2Y2NFOXNxU01QbDhTamhpTVZldDBER3ZyZzZ0Z3dDRUpHQnhaUnhk?=
 =?utf-8?B?ODcyc3Q2d1F2OGRjTEJFamN1aUc3S0ZFZWZsWHJ6dWZ2amhrN1AzT0Z0dTQv?=
 =?utf-8?B?YWI1ZjQwdzdVcVBHTndhVnlEb2IvTlkwSEpUSWg4V3gzWWN6ejEvM1Fqa3I0?=
 =?utf-8?B?VjJMU1R4S2IzdmI3TDlSbHZtekxHOVk2UVE1V2prSUtpSUovbktsU1M1WU1X?=
 =?utf-8?B?a2c3dXNhc2lmMmtjSmJVOHEwanN3Y0c0SjBpRGVSWGUrRm5VcStkeEdOdEZu?=
 =?utf-8?B?bzNxNTVmSUp1UWRwZXcvSUhZK2FZZGtFWk5vWEsxYjdicXYydTc2b2wvcTVa?=
 =?utf-8?B?UFZBaU5mZFNqcWNxMW9NcjFjdkRLUzRUWDQ3U3I3N0p3bkZIUjNMeUIvWlNC?=
 =?utf-8?B?d0Y3V2JLNmFnK0RvRzBWYlhGaURrK1FjbkJrNDJzbGV4STlYNnZ3SVJQZkhG?=
 =?utf-8?B?V2pQMndzc1FKTGpWSlF0d0lvNXVLbFMzQldoUWtpbXVqWWZzUzVRSnZVMWQv?=
 =?utf-8?B?MTRMc2FESjZPbnlBWmxDM1B3c1Iyc0YwWWFLWW12TXQ3S1p2L0JWTHFEb2FH?=
 =?utf-8?B?THFrNlpibTNvQ0ZzT0VKQmUreGdFclAxcG5PeGJNVFBpY0J6TFJuU1BXOVNV?=
 =?utf-8?B?WWgrTzNaQXlMaHdmd1BrbzdiNHJldlJPaU4xTGxzbVZyYlJZWm1Tb0VZWFpT?=
 =?utf-8?B?Rlo5UG43OTdrVjNMeEZkUnl2K3cvcnFwVVRsby81b3JJZ3FuUkpqMlVka2ds?=
 =?utf-8?B?elIzSzlpVlYrWk16U2FyeFJycWhONFZ1YlhRZ3B3eWNJdksrRkhvL0d4a1dI?=
 =?utf-8?B?d1VKYUdhZTkrdE9CRGw1cU0wN2xObGV2cFBtOE5KUTd4aGkybFA3NE5YeXJx?=
 =?utf-8?B?WVM2QURjSlhVVGttUjIzMzlmZUpaVW42dm1aNVBmUjByVWFPUUpQREdjR1pu?=
 =?utf-8?B?N2gvWnRyaGUxbEh3cXBEOHdCN3lCenlBb051aFgwM05FeUZKT0Z6THBoUkJz?=
 =?utf-8?B?dTVlTkVEbTlpYStJVWR2ZjlRdEplOUZlWHFNdHZGNStkV0VIdHJGdlJDRkpD?=
 =?utf-8?B?dXRCWkkrc012Z2hJdy9TMG5ZN1czL2VqZ3dhVm5JWmJlOHdTalNDRGpVM1A0?=
 =?utf-8?B?cmJsb3FjTW9JbW5OaVVKTHFSU2taZDhuRmgyeW0wT3ZYcWZoQTk5SlJtTFdH?=
 =?utf-8?B?UEg4R2FWVXBqQ3VLcnFIZWVvS2pLakJhcU80SDN4MkRFaG1jdmJDRHROQ1U2?=
 =?utf-8?B?a1lkdXlDT0dnSUwxSFN0UnpHVkJQa1Z1S0pSajljOXo1MkVpTjhDNFhLNXQy?=
 =?utf-8?B?ejRBck96c0d2eWpYK1dxemM3ZWh3Q3hCckRFbTA5SEo3YXVheXJYT05nODRR?=
 =?utf-8?B?SEpiVFhkSWsvSEZDVnNjRkpLSmVqNHNPTDBWTXJDU2NWUTRoM1MwZ0hvQTJU?=
 =?utf-8?B?RUFUVWQ0N05iUzMxaVdORjhBSk9xVi9QeUp1bDgwaE5qMjJoUktDU0RYL25l?=
 =?utf-8?Q?B8iQ2cbQQ/oTgVf0LGcGGKF5NUmUmqXa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkRNUXlpeURmR1hScjErTjVPb3ZMaGFoWC9YanFvWk50NmR3S2lYNW4rRTVk?=
 =?utf-8?B?d29YSS9ONW9UREEyemdnR3RqbW5laXEzM3Q0VnI4Q3lCN0dlZkpRR3RRd0Vz?=
 =?utf-8?B?U0FSUXRKVDZXR0FOK2hjMHQvSjJ0cXFMQjU5Nzc5dUR0S2xsbFJrM0I0QXZE?=
 =?utf-8?B?MDl6TXNTR2pJTFVLa0RMQ2I5aWlBa2g3UVAzRXZGVlZMaXJtNE5XRXo1dStE?=
 =?utf-8?B?WGxEYUZieUhUY2h5b09hZDc2em1RQkFtWGtZT2ZSbFN3c3ZCQWxUWWhTQjE5?=
 =?utf-8?B?clR4MW5RbWkrandOb3JhTjdwenUrOTVncGkrNS9xYmczNHoxZnhFeEg3NUhD?=
 =?utf-8?B?ZjhTNkgwalFXdVFvTEdDRmlROWIzakh2NXpvWWpLVHlmRk5yejZ6UUxDT2Vt?=
 =?utf-8?B?K1E4bEc3MDBORzBCdzlPeGh0aVpUWGliV3V0MlFmNDlaMVlsVWdubjlJemlM?=
 =?utf-8?B?SHJiaUlGcnR5Y25wWmxaRVZGZDd5aTRqOVJWdit2OUYvaVJGbityREh3bmMw?=
 =?utf-8?B?V3hiKzUwTWdTMmZhTitIT0VDNkM4S29LTzRZajE0MGNoOVh5bUpnSngvSWRh?=
 =?utf-8?B?bzFwVmxjbVRiaVdHSXVkTGcranl1UDVCOFdWNkNjZThzajQ4S1lKUmVvTXgv?=
 =?utf-8?B?cmNUNGZtMnB6Y08wQ2FZZGM5azkwSVNFd1VMMFRuWEs0SjAwc3d3Z1F3TkJS?=
 =?utf-8?B?MGQxRWNxNE5BNDBKRlh2dzdqQnBnRWk3eVViNFFZYnkzU3AxSjdnZDBtR0ps?=
 =?utf-8?B?T0g5dTd5SEtzZEg3QmZtLy9lMkJVb3ZZcTllRmE2dW1XU2tWRnRUMExqRjhk?=
 =?utf-8?B?blJSVWdIUTVjbHJuQ0w1Qk9jZVdLcFk1STZJbE9LZGJGZGN5WFdSZWZZQTVn?=
 =?utf-8?B?Mkx0clZ5YzE4NDUzVXBFYk9NSDFGQmVFampDUnBpY0xTeTdsUDloc2E1K2ho?=
 =?utf-8?B?UFErRGJrR1phZUpSMmFWV2FOd1ZLcC8yMzNVMnZpWWxtaXAwQ2I4am1ZcG1N?=
 =?utf-8?B?b0lVOHdqVUptUFhYZUdiNjZBMk1tUnBkZXB0ZjJDVCs1R1RWRnpuQlJFQnM3?=
 =?utf-8?B?Q3JLRTVmV0lFTnlDYXlIMlIyNWJXT1plT0t0U0xaVmVCNzRvaTgvUGdJb0Vk?=
 =?utf-8?B?Z3ZwUU1lTjRER0IwSi9UWkpTcmgrL3BGUnUwNGVzakIyZjd6amxBamM1NjNH?=
 =?utf-8?B?NCtnNXM0YUoySUtSM05paXg2NmVoN1lmUXA3TU1sVHVjUlMxM1FrWTZiNXRo?=
 =?utf-8?B?clNXNHM4Vi91V0RBTnZKQzVvdDl4UXR2QTZFVlVBY0dWUUQydDVHK1gzc1pR?=
 =?utf-8?B?RnRuTElaMENwTEhEQ3NZeU1wRUl5K0g3cGFYWWJrUFRVdEROQzZSZmFybHNU?=
 =?utf-8?B?Qk02UG55V0lNdUJBQkpmSEZVcExabXNiRmpxZEdYR2YyNHVKMzBlTEN1d3Ax?=
 =?utf-8?B?eFRoY2diamliMlZib3Nkd0tNT2JrOVd0ZmFxWEZ0TTVCZXJsNm4wNFoxZ2ZR?=
 =?utf-8?B?SXBBOUpNYkYrQmp2Tko3MWRTWkJKRXlRakt6N3dTbW11WkE0OXZ2VVpzOUk1?=
 =?utf-8?B?YkJWUDRjVEpLb2JudFl0aXZLREcvaVpONnNlSnZkRi9iMjFJTWtjdHorVjhO?=
 =?utf-8?B?L1plM2dZcjc4Vnh4NXdkbjZKTytJOU1wcmVCMzdnSC9WbnVkYnhHanhNU0Ra?=
 =?utf-8?B?Y0RJVnlvY0NiQmtNa25TRGJsaGltV2h3ZXRsd2gvKzRPdHdBOE1OZzRiVkh4?=
 =?utf-8?B?TXEzbVE5Q2VCbjExZEl1Q28rM3VHaUMxMVMxa2IrSksxbkpDcGhBUUU5T0dU?=
 =?utf-8?B?TExtYXU0WFhvaXhoTS9adHBWc1R1eWxtZ1hIRldTbDBiMVJMNTRpU1VyakJZ?=
 =?utf-8?B?dHBMRjJGVzdBR01yOHA2RUduN0RKZXpGdGhrZVJGZ25uQjVLYkV6YU02Nzdy?=
 =?utf-8?B?Q0JMNFludm9INjA5UUs5bW4wV3pWM2RaVUF6cFJBVFVwazRieTNBY01EalZQ?=
 =?utf-8?B?QVFkeDhxSGFUOUlVc1F3UVBKVHlhSGVYR3hDZkJuQ1I1MlhwM1A0cUlvWkhn?=
 =?utf-8?B?TlRQT0dKYU0vQzMwNGJvaVpRRXZrWWxaWHgxVTlvOGY1UHdXdkJWNjZFTTZq?=
 =?utf-8?Q?lcxEU30XyI6FKZ1rAqexpvO8Y?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c41928-2007-4955-e00f-08de1ad9614f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 13:03:27.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXkssnXymub+X3jYiGpmzHk8pgbe8YAttVJnwT/5W66+dXpaGXJBJXtaTB50wQYv9hFBw9A1FocKpnT8bXpUjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5625

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3_4.19.bb | 2 +-
 recipes-kernel/linux/linux-xenomai-3_5.10.bb | 2 +-
 recipes-kernel/linux/linux-xenomai-3_5.15.bb | 2 +-
 recipes-kernel/linux/linux-xenomai-3_5.4.bb  | 2 +-
 recipes-kernel/linux/linux-xenomai-3_6.1.bb  | 2 +-
 recipes-kernel/linux/linux-xenomai-3_6.12.bb | 2 +-
 recipes-kernel/linux/linux-xenomai-4_6.1.bb  | 2 +-
 recipes-kernel/linux/linux-xenomai-4_6.12.bb | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3_4.19.bb b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
index d906dd0..693b51b 100644
--- a/recipes-kernel/linux/linux-xenomai-3_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
@@ -12,7 +12,7 @@
 require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI:append:amd64 = " git://gitlab.com/Xenomai/legacy/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV:amd64 ?= "ipipe-core-4.19.322-cip113-x86-30"
+SRCREV:amd64 ?= "ipipe-core-4.19.325-cip123-x86-31"
 
 SRC_URI:append:arm64 = " git://gitlab.com/Xenomai/legacy/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV:arm64 ?= "ipipe-core-4.19.229-cip67-arm64-13"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.10.bb b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
index 644f001..04d0129 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.10.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v5.10.234-cip57-dovetail1"
+SRCREV ?= "v5.10.245-cip65-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.15.bb b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
index 14dca06..87e7a26 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v5.15.179-dovetail1"
+SRCREV ?= "v5.15.196-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.4.bb b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
index b2acad6..7a4738d 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.4.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
@@ -12,7 +12,7 @@
 require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI:append:amd64 = " git://gitlab.com/Xenomai/legacy/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV:amd64 ?= "ipipe-core-5.4.284-x86-17"
+SRCREV:amd64 ?= "ipipe-core-5.4.299-x86-18"
 
 SRC_URI:append:arm64 = " git://gitlab.com/Xenomai/legacy/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV:arm64 ?= "ipipe-core-5.4.180-arm64-5"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.1.bb b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
index 03b3800..49e584e 100644
--- a/recipes-kernel/linux/linux-xenomai-3_6.1.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v6.1.128-cip37-dovetail1"
+SRCREV ?= "v6.1.155-cip47-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.12.bb b/recipes-kernel/linux/linux-xenomai-3_6.12.bb
index 505aac4..c066037 100644
--- a/recipes-kernel/linux/linux-xenomai-3_6.12.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.12.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v6.12.19-dovetail1"
+SRCREV ?= "v6.12.55-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.1.bb b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
index 1571ab6..c0ae308 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.1.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.1.128-cip37-evl1-rebase"
+SRCREV ?= "v6.1.155-cip47-evl1-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.12.bb b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
index 3e042a5..380c2a4 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.12.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.12.19-evl1-rebase"
+SRCREV ?= "v6.12.55-evl1-rebase"
-- 
2.51.0
