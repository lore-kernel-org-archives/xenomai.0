Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725511586F6
	for <xenomai@lists.linux.dev>; Fri, 28 Jun 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578001; cv=fail; b=n/+L+GKVbu0+uzUMACRQ8O/wPFaf9DHjkFEprXQIgTi0ohTdubRaVUYnc/mMp097moQ+a9V4Q1sJWAZDc5zrMNoUJytnyTqqF4b1IL09lO7dd68FoNk3CQdr5G55bSOGoCZbnSmO6rd2skVQJNAjCc0ZLpSqKjSuW4RTmIlppXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578001; c=relaxed/simple;
	bh=0T7RIVv1UPfSVjs5p/GhPTa1yKuBxziYFGGOdm/m4eI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dqw0w111bwEGB9BVS3tOp6RKiBx2yyyHsPL1P+XLcRvor2wbJorwI3lJYW07CRE+ZaGc1fpYbuaLMzE6XK34adG4q+HBo5BRp3MSXh9ophcyxv3jRjymN/6kqI+DILQ5PB91EZ6DaQHGqYAGfM48KJAgrRBxmJ9+5OrbcPlOGzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=h2L+/NjT; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="h2L+/NjT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhOL9bWz/0IJC1RHEyq/EPEtdAQRBmcPtptQ/pJqcuyfk6+LbUHHtidy0G6/y1X36Rt+2dnQrr1DmbO+cujZSKkcxB1qMgoWt5vaujfPAhJR6rGtUC3bK1t1i9vZt3e1ep61HyK9vGjjQqqsvZxxQub/J1JrwswVhBQVSTNqEdTi9a4jLWbTktKTNeSytsmjZDnB0WUbNkrbkPg2PClwS3udsU6brbvAOTycz4nJTLmMTP08gWq1g3T/aJDaPuXAZqsnHzmgi6qLzpqeV4NBo7aCG4WWzBSfi7/7qFUXkd+oJ3UgNExd6pqumsDDR4t8ykV9Wyu3qnvQnxQQkVO8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLHZ5inoOnXBPGTgsIa9ibLhR/uLZjgCKMwa8F+aUOY=;
 b=SxQ6Tln+Q84HPcXjsSRLGHw71wODkkRwST41xXUZvrrcvWbe8QkPKeJCaKseWdo86Eo4fS5k5/wugLH50iAlBoi1MVFaKwabnbh23SlrghcWslmpOKeRsTOy7CZKJOhyUqmslIPN8zB8FuyWtpgDlt96mobAc3LXr7fubVVDDYw3tdjOlSMEhkx7qEACnHd37los1O5lJZYH2elWDxuRfHClwrMqPNiYN7ggbq21RZU3L8QeXX5PptuopAh+v+N6bijAvWILfHQNeigOPeDAjt7K7Vhk8Megg/OgXPfEQSQs0vwxNtqr6jpfDySPchR6f2Xtcwqbc33YfB5ehqP/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLHZ5inoOnXBPGTgsIa9ibLhR/uLZjgCKMwa8F+aUOY=;
 b=h2L+/NjTGz1B1kbygrBJ39q/+mtq+iCq54LnTmDQXM7Twsz72YwEt2Bemx3YOMDRasOFEiW9CTucDo2KfxFr+MHAM1OPx7bIwxgbvO2qdWdeRMF1yfzVDjwngJHz5RvBCTI4/WqJlnLWG6RMotvnKPV7YQaNYSM/eeMENyELeiB2XNVyrqhF3Bs4+aw497LYVVwYErswKIwJo1T6xpOBfqMUN7CuTVIncbsEUSwVoqolJSpwuFXIaMWXXaiqJeSpp+6lX4GQrx/OVJ5DUf/2tx0b2hv8fA7xy3oedXVa20HD9NPZQOrjyMr9RUKSVrHtzWPASyFy16CYEnm7Y8wfIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3486.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 12:33:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 12:33:15 +0000
Message-ID: <3565bbae-66df-40d5-b3e6-f70fa692378b@siemens.com>
Date: Fri, 28 Jun 2024 14:33:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ci: add kernel support for rpi4
To: Yi Jiang <yi.jiang@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, quirin.gylstorff@siemens.com
References: <20240628122117.19059-1-yi.jiang@siemens.com>
 <20240628122117.19059-4-yi.jiang@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240628122117.19059-4-yi.jiang@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3486:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ef6acc-7e21-46d6-14e2-08dc976e7b47
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlZpRTBrV0gwK2hOdHZDc0Y4ZUtNTXZrTzNHTlNwT1RxU0s3YlBiVTV1YWtr?=
 =?utf-8?B?akdNN2huYWpjU29IWHMweGtZcnI1NGtvTE9keHNFeEppajkzS2VIbitMeFBX?=
 =?utf-8?B?eStZTVdEdGMrdDFiSG5ReXVWMDI1YTlSZm14bzdDL1lzZWFVM3N4bmVkQytG?=
 =?utf-8?B?dmJvQ08yZ0NwVEVTMGoxcEVJUzYrSStSOENVZFhxc1llT3pod3BYZmF3aStT?=
 =?utf-8?B?d2NscEJhNGczeWlyZnR0WE9xUFNGYUY3b3pvQy9XTFNyb0lTL1NwQ2U1Tnpu?=
 =?utf-8?B?NWJqU3JtU29jQzVWVDdJclhKN2t0SkdSWHNoUjN4T2xNem5Pb3YvdXRtNzd3?=
 =?utf-8?B?RDJPSUJ3a2h4cGttZXlMYWtJaVJTVnVOK2RabHA3SEYwMHFPaUxXL0dhT1lB?=
 =?utf-8?B?bmdQY2ZjcU5DcUQ0UlV6aHNubk9nT1JGZytwODJmN29hdVpDUjJqWU9Ea1JQ?=
 =?utf-8?B?alMrTHRKVW9PL2QyM04xTy9BbGJOM3NnS2dXNHpuRmJBVmZ4dmRZejlYQmFH?=
 =?utf-8?B?dE1aeC9JMFdwQ2IzZzE5Y2ZpbVdhYnNrdjhMYnFWekpOblYwYy96eWJZbGZh?=
 =?utf-8?B?UzJ2WFB5MGVSWE8xNXh2aXV0eEVvc1NIZ3EySERqVVBReXpObExhNjBGRCtm?=
 =?utf-8?B?dXZoejE3REJEYlJvdmxQejUzY2FmK1FjMEZmdmhVcTRwRzRDY2lqZHcyK1ZN?=
 =?utf-8?B?bmptcUtaU21jNUc3WURia0NaQ2xFUm5vTnlHbVBrOU1zNzFFa0lNTUVDakYx?=
 =?utf-8?B?UWtHeDcybElsTnlMY1RtcjJYVFFMYkQrcHVaVC83eXdnUjd2UWZUajJ6dFhk?=
 =?utf-8?B?T3RSL0tNOERYUGFmdmx0ZU40QmFxcDBVNVBBdE0vWmVjMTc1UHlXRm5EYlNF?=
 =?utf-8?B?VHYvdzdDYUN4VENtQXNOeXJqemk5eUUxN1ZxYXFHcCtEVWZpR3dhTU5UZlds?=
 =?utf-8?B?Nyt0blk5VWtkS1hGQVdmMEhQN1Rwbkx1c3h2WlZSZ1pYNi9HZkorRDMxaUlD?=
 =?utf-8?B?T2ZNeXRndEI1YnRiTDJHYmFxTlorMjNLelBYNU9NbTg4ZzhUT3FqY2NzcFJw?=
 =?utf-8?B?WUx2ZGJCRFF3WGVWZmJLWC90WElFU1pyU2FKeFRSbEFLMHR2dXFIR2xPM0xU?=
 =?utf-8?B?OS9BaFUzNy9PYXBRY3hncElIMTIvSGVwOEdUaFFCb0N0cGNXSFRwanFuZzBl?=
 =?utf-8?B?T1pLazl3UGNlMmJSdmx2eUFFNnhrNW40N2dWWmNmQU9PRjN4cCtWM2hMYzRv?=
 =?utf-8?B?WXZLUDAyMytwNExPdFFqMXpJelhuaW92V1VybzV6REw5MFZzNWRKVW9lQW1P?=
 =?utf-8?B?NmNROGduOHBqV0xQRTJJbzZWakRTdGVERXFnN0xpenRwS0VNTHJNbWoyNGFU?=
 =?utf-8?B?UFJOc1I5SzMvYUJYWTBWbU4xMlVFeVUzTm1uNVB0TmRkV0R1cm5hNlhSdWJS?=
 =?utf-8?B?clByd29acFVjWi9CRHNPRmhFZ3p5eVBjODVBcENrc2NGV2JDQmU2RlpQcmFB?=
 =?utf-8?B?VTA0TEZkS1NlbkRFU1grUzR1UDA5M2tCcFI4SWh5eFlNQjVSWTRyUXZOQi9M?=
 =?utf-8?B?aTcvc1d5c2hLZ2hHZHhwTUx5VUxvUzR3aFpCWWZKamhlVDBYTkxTenQvYnFx?=
 =?utf-8?B?ejdRMDRhdXVOKzBXQWJpMTZVWXhvSjRRNEZMQmZ5enBlWFdiODdIRWdkdmVB?=
 =?utf-8?B?ZWd1c1hURWo2aDFUMGk3T0kvVmdHeWpmZGtiZU8yZm8zSUF6a2s3ZUt4enJ6?=
 =?utf-8?B?UFFIMko4NW1ZVncxbVVXRFJMNFh0WnhKOG9BRWprVHR4MTlqdlhiZmZvZ3Fl?=
 =?utf-8?B?WnZvdUhLMG9BVjBISjdHZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzZuWlAvVEloamQyK3ZnOGZRSk9ERFp5TXk2aXA5SWJNS05rN2J4NVQwRkdV?=
 =?utf-8?B?YitFZDV0aEp0UFFuaDZJUXVXVTNuRXY1Z29SOUJzUlBVaU1sSnFRV3BlSElv?=
 =?utf-8?B?eklQaFhmd2NVZmF1eFRGZWxFY2cyNmxNU0RHODZObk5QSVhUTzdaVmxrNy9i?=
 =?utf-8?B?dmY1cUlnVk9CdndDTnVtK0szdmlXbHROYWNWTEVYOXpRMHVEN1pJVFlzcnVK?=
 =?utf-8?B?RmFmSC9Dd1BFRlJqRlJJdndNNTlaYTFyVEJnV1FFUFNweGs3M3E4NXdKa0k0?=
 =?utf-8?B?QVhPNGxkTzkrcGU5YTFhL3IvMG5yeDFCVGlXM3dyS01YWjFsMklxOHB3VXg3?=
 =?utf-8?B?L1AyZ0JTK0dBSUtpVS9JVllhbExqTnNHSzNTYm5YTzlReUpzVjBMUkdnT21r?=
 =?utf-8?B?OHYvWEdyT3I3R2J1eU13Qkx6cGJwWE5ncmNXdU16bmFLbFlXODdQdExDUmhR?=
 =?utf-8?B?WTFZMkNjdWc4VHlKWk9PQmRSbFQ2dlRycFN5U0lBaTYxSC9sYW1DclF0cklp?=
 =?utf-8?B?dHpnemNWeGN6VklBbnFTdnpxb2YyU0ljZXJ6a0w3Sm1XOUFGRFFML0dUZGJB?=
 =?utf-8?B?QnE1emFLQ1MyUEhTM0ptKzJVV05USW9IYmpJcXlYRE96UDl1VzJVcGdJWnhx?=
 =?utf-8?B?L1lVbW5OMGJYWTA0cnQ1bU81YXV2TTJSS2w5ODVxTVBTR242MDBLVXBPQUk1?=
 =?utf-8?B?ZDBpbktqU21MQzlBUnVTN2FEQzRqRnAvWXl0ODI0TFA4a0FsSDBqWFZoQUdo?=
 =?utf-8?B?ZEVQdGZzeWdDSDZiSFpDYUpuYjRhNExUVHZLNldVR0tPYzRGcFdkcmxiR1JK?=
 =?utf-8?B?UThVNzBlVFFKL2VwMHFCTTd1am5jL0xBRWkzTlk1UXNLcEpKRlkzazBYTlV4?=
 =?utf-8?B?WTFhVVM0eTBOeGlwRWdBMFkxdVFnTWNlMlFmSng3QlVCSTBzRnQwS3F0b0pO?=
 =?utf-8?B?MkNtaUNrRGRpdXZoN3NFdTk2TkhEb3VCVklpWTJqdGFMU0cwN0NqR1crdEVu?=
 =?utf-8?B?SUhhNVpHd0VIcSs2SjhEeHhTODBHMnhkQzM1WlZMVy9RNzdLcUVRR1dJOU1L?=
 =?utf-8?B?OTlYcjFXSkgxWmlBS1k0MXdhZUZ5TmRrRGNlQWVDOG5UMkZ5Z1BoRHd3ZHFs?=
 =?utf-8?B?NTZFcXZSeC90N1dqNktTRE5VOXBWWS8yanY4ZlN1SW00VGN6bUpPTTZYYXFx?=
 =?utf-8?B?ZmdVNTRlem1LSVZUU1FrOWJPMlBYQUhEMzVNckZQaVhsaU9uNUV4SEdWSlhQ?=
 =?utf-8?B?K2pKK0ZzSkpXTGtRUHBIMk5kb1kzSHl5UG8zVERqR3g1ZTJnKzNHL2NGZElh?=
 =?utf-8?B?SUZ3SkFFWnl2R3MxOVBuL3lLWkc5KzdWT2cxU3VRdW5keitoT0NhdHJXeEpj?=
 =?utf-8?B?dnJlTnFLdTE1NHFSbC81dXZrZkh0ckd2WWp6REIwYjJnUnNnMDllc0VOZ2Ex?=
 =?utf-8?B?SjlWSHRaRGJ6d25oUmNtQTFoQ2FsQjBGMnhxT0pRWW9DZWQrdlkyTiszaEVw?=
 =?utf-8?B?LzBMc1M4SG5RcGptSFNnL3MyM0xNalJRYkkxaWlqMmM4WkdhZVlSbjVyS0w0?=
 =?utf-8?B?UFNvMzRBTkl4QklFdHlORnB3UUFqRmFFaHhmb0xpRVk1eWdVTVZtQzZsbGVl?=
 =?utf-8?B?U3VDYWJhb01wVlBtN3dqbytsZm9Hajc4a0pYY0hWajlnREswNjVoaWtiYS9r?=
 =?utf-8?B?dWJzdWt3bERvOHl5WUJSRDNuRWNhNWpFamFhMHFsYlNnSTIyd2FYblR0Tnc1?=
 =?utf-8?B?UW5TUkZrTU5aNms0ckpTQTJCb2h1c3FFYWtXamh5dnNrUXBKSDRjT0FUN0RY?=
 =?utf-8?B?NjFkUFlkRFF0cHZRYVkrQ3lYeDJqaWRyZktJYnBIbTh6OTF5SzY0aTE3c24r?=
 =?utf-8?B?UE1XbFhHUHdOMFhWYmRuL2xsa3JmZ0FEUnBEVWN4Z08ybWZkd0ZHbTQ4M3hY?=
 =?utf-8?B?ZWdtZnFWY3FySzY5dm5xZVhvZko3b3RCUzg1NmZYY21USkpyeGJ6bFFiUnc1?=
 =?utf-8?B?dTQvT2VMRE5jOC9aWmlRT0hSQTdmSEppVTAzV2krMWo3WHUrYUVrTTdRR2RP?=
 =?utf-8?B?NGhWcnpPbngydWY1NitqeDNDVi9pYmIrMkk4SUY3MCtjbzFTUFVsa1NsT2NI?=
 =?utf-8?B?WVZVS1hJaTZvSmRGTFNBSkpwN093eVBxWDFkTlRvQ2RWOFNKWnZKQWVDTHlt?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ef6acc-7e21-46d6-14e2-08dc976e7b47
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 12:33:15.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WK14b7qOIrhJ0IYnngR3VvE0Xx+KWx6Ucwq2JfAfeygR38F54ksxoI9sg74910GVOE+TbqT0GnKPbtxWji4qTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3486

On 28.06.24 14:21, Yi Jiang wrote:
> Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
> ---
>  ci/kernel_5_10.yml | 15 ++++++++++++++-
>  ci/kernel_5_15.yml | 15 ++++++++++++++-
>  ci/kernel_6_1.yml  | 15 ++++++++++++++-
>  ci/kernel_6_6.yml  | 13 +++++++++++++
>  4 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/ci/kernel_5_10.yml b/ci/kernel_5_10.yml
> index 44cd6d6..36c2e06 100644
> --- a/ci/kernel_5_10.yml
> +++ b/ci/kernel_5_10.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2019 - 2022
> +# Copyright (c) Siemens AG, 2019 - 2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -61,6 +61,19 @@ lava-test-5.10:hikey:
>    variables:
>      KERNEL_VERSION: "5.10"
>  
> +build-5.10:rpi4:
> +  extends: .build:rpi4
> +  variables:
> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
> +    KERNEL_VERSION: "5.10"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-5.10:rpi4:
> +  needs: [ "build-5.10:rpi4" ]
> +  extends: .lava-test:rpi4
> +  variables:
> +    KERNEL_VERSION: "5.10"
> +
>  build-5.10:beagle-bone-black:
>    extends: .build:beagle-bone-black
>    variables:
> diff --git a/ci/kernel_5_15.yml b/ci/kernel_5_15.yml
> index 52710fd..e17275a 100644
> --- a/ci/kernel_5_15.yml
> +++ b/ci/kernel_5_15.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2022
> +# Copyright (c) Siemens AG, 2022 - 2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -61,6 +61,19 @@ lava-test-5.15:hikey:
>    variables:
>      KERNEL_VERSION: "5.15"
>  
> +build-5.15:rpi4:
> +  extends: .build:rpi4
> +  variables:
> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
> +    KERNEL_VERSION: "5.15"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-5.15:rpi4:
> +  needs: [ "build-5.15:rpi4" ]
> +  extends: .lava-test:rpi4
> +  variables:
> +    KERNEL_VERSION: "5.15"
> +
>  build-5.15:beagle-bone-black:
>    extends: .build:beagle-bone-black
>    variables:
> diff --git a/ci/kernel_6_1.yml b/ci/kernel_6_1.yml
> index 1c6a6d7..cd7906d 100644
> --- a/ci/kernel_6_1.yml
> +++ b/ci/kernel_6_1.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2022-2023
> +# Copyright (c) Siemens AG, 2022-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -61,6 +61,19 @@ lava-test-6.1:hikey:
>    variables:
>      KERNEL_VERSION: "6.1"
>  
> +build-6.1:rpi4:
> +  extends: .build:rpi4
> +  variables:
> +    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
> +    KERNEL_VERSION: "6.1"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-6.1:rpi4:
> +  needs: [ "build-6.1:rpi4" ]
> +  extends: .lava-test:rpi4
> +  variables:
> +    KERNEL_VERSION: "6.1"
> +
>  build-6.1:beagle-bone-black:
>    extends: .build:beagle-bone-black
>    variables:
> diff --git a/ci/kernel_6_6.yml b/ci/kernel_6_6.yml
> index f13d28d..d840d26 100644
> --- a/ci/kernel_6_6.yml
> +++ b/ci/kernel_6_6.yml
> @@ -61,6 +61,19 @@ lava-test-6.6:hikey:
>    variables:
>      KERNEL_VERSION: "6.6"
>  
> +build-6.6:rpi4:
> +  extends: .build:rpi4
> +  variables:
> +    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
> +    KERNEL_VERSION: "6.6"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-6.6:rpi4:
> +  needs: [ "build-6.6:rpi4" ]
> +  extends: .lava-test:rpi4
> +  variables:
> +    KERNEL_VERSION: "6.6"
> +
>  build-6.6:beagle-bone-black:
>    extends: .build:beagle-bone-black
>    variables:

Two things:

 - I strongly suspect that patch 4 needs to come first, or this patch
   will break CI

 - I would prefer to switch some existing hikey jobs to rpi4, rather
   than adding theses 4 extra ones. How about only switching 6.6 to rpi
   for now?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

