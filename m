Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3275184
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657369; cv=fail; b=ReS4XPfVJJS9z1xc8w2f2hOygS3DEbjSKw94OrvwU7+P0yXVZqdzDGZsVq3TL8D3xfwEW2AGN46mlJklt4BdnC/QTUd3ykaf69C8VubjDMn6BftRLZezdXI5Ok8DLyJrPyr8qRkH5cPIAPkIZAatEF/P+ZbvEs+5gji7gZwAr+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657369; c=relaxed/simple;
	bh=rx+73Idg9UbK+3NZy/ROGt1a0nskzDLkAsvQmSPjAL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fK/08xZxkWlju+NFoheKJoLiiK7N9J3/9aOxg4dtuOJug3eIuC9yaJoS7F3c5WoQO1yYGvZVjGHoD6Z5JyGiq9kWzrv3pl7iznPaVVnaqh1ltCCtb7NfLBS9MaKbSsBXYK7HuxVr8mkD9xBA7lV5rUPfeD0B0c/glHgFNn0lPhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rF79qlJT; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rF79qlJT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj9eTF0GipuDWJybc1L16qJeNv5LeEiB9RzFS+i8assEVqn6RdXVHmzMmwhYCtKdJX4rqLVwuRrRRGjYQiixAiBHpIUNkXf5EsgfrSZVs/KZSttzJuEjmX4Kgn1cZl7E4j51w/u15ZdtNGw55AHepE7lPra7uvRGyeoYnM5aGno91ufauPZMGVbY5yHXW15ubvSGuyz3ToMhA/aYYWThTG1I8Z96BalN2tEcShT/wM26KHtyd/Lm44YexpZimUxmnVcZaBtXKigXe+BrCsb6sSZRSIo33pO2DOUp7NXGIQZUe5S+8SZyUO0GQSFakPGFf8pk49+/aeleudwZPbSVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0tkD8asMjtj+D2VMVJOuffPXUKYBc5wArWEIvKHWd8=;
 b=V3qhAb0zGARkim5YZIjsqstUMT1Tq3hjppmU9/yO0GuXfrtvItFJCpvhnQNhncpSckgX8a3a4U4MzIt25j7J9sk/kVv3hMdeCSilqoaIDB2LdXlpSF/ZCGgJ9MGXn5kJNhHUWiasuRL7c42fZGI6UEpiIDOygS0iM5o2hn9dqywM7FhsVxjEknR+csInSGBr60tjGyjdF20A1JEyQo2TQRp3mimdtSroknNtMoJYP/1ZDorDohKrS311cpvJCbhv4TdeHl/gS67C/HDoQ0hOMLO5pVTLkWhoygaXvvzaqkXSzZUQ0m17O51wVo6nN53BitcpAJ7lzrPZHEm9FF52ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0tkD8asMjtj+D2VMVJOuffPXUKYBc5wArWEIvKHWd8=;
 b=rF79qlJT/oNFCU/XxEU5HC1DisZHNZlAeOZUwT1hwsZ8wi6J+YaoPujJh6VYCN74zHGgweb6Gp6v3/8t3KQOOmawxMPDN8MKnepqezezWV35h+mJAPHlF3tuBul3/1FM3Byi2n8+E7nFpI9kY8cfOwsgSDFj2lda57Xx54L9TemTk4n6CJXBY1z8EK7cnR8Ty/4sCFjnKstjKh5jXy8xXMF3I56D122AbKzDBpGP1yZI7QsSNJYv/c//fpaoQ5QFpKGVt660cCkO5lHbu70b/aaz4B7WeTYjFsTzEOTIgRl/RzxVfdVgW24YbEk4EbDBehBXSUoC/Jly2awwzX15oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6; Fri, 11 Oct
 2024 14:36:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 14:36:02 +0000
Message-ID: <5d65f813-3b5e-4dd4-8665-83d1af64a23f@siemens.com>
Date: Fri, 11 Oct 2024 16:36:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 6.x] x86: dovetail: Fix inband IRQ state
 corruption on out-of-band compat syscall
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
References: <20241010154421.23303-1-florian.bezdeka@siemens.com>
 <87frp4aqmu.fsf@xenomai.org>
 <20e035c9f61263d0085d6dae2d93829ee575b87e.camel@siemens.com>
 <87v7xy7lwm.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87v7xy7lwm.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 12486431-acd4-465c-1968-08dcea020830
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzF4OGVkVFhRMFJkOTVGS0dsb01OMmZ2N0RkL21OTW01dVNhcXdpV2dvbVhs?=
 =?utf-8?B?NkI4VVh4MytwVmZGL0UyVnBmeHhidWxObkhQVDRHQnMrbXJ5NHhZUi80bkdI?=
 =?utf-8?B?THZOVU5wVytkVFlBZUJhYWpIQ0luVzB2Wi9yS1l1OVI0T1RrWVA5b3ZPNHhq?=
 =?utf-8?B?MFpZejM2eHZublNsaWQvbWlUNXR4UDdXeVN5TFBwMm9ZZy9uNGFId0YzUjg2?=
 =?utf-8?B?RlZxMHN6N2o5V25kYlZrQWJkWENhWWdvZlpneTBpKzlFUThvV0JPSG50Nnk2?=
 =?utf-8?B?NkxGcHEzdTJuTzdnTWY5d0VWeTVkcE4rZVd4ZXZObHltK0c4M0FyV2dOYi9K?=
 =?utf-8?B?cEVhUGZ2VVc5Sk43dzB3MjRsUkUzclZvdGlvV0pQS1lNSHZpVDdRdnlmd2xX?=
 =?utf-8?B?bGpESFBuYXdhZll6VlFNb2ZzUmd3b09RU1JnREFPZFB0U05WcG1sNkM5NlQ5?=
 =?utf-8?B?cTAzVTFjQTRVMUNjZG51R1h0R2RRVVU5cHhudUZ4Y202Tjdmdm0vRXlyWEha?=
 =?utf-8?B?V09uMXBjaW9jQmV0a29NRE1VN1pPK1BNd3lEYlZjU1VYRUZjRnVDeE1QZzlP?=
 =?utf-8?B?RlRIaUNGYXpIbm9UZGg5cjR4Mmw4TlNrcG9SdXAzNXl0YWltTHFFSEpuRkhO?=
 =?utf-8?B?TVNYRU1IdTRjbjJ4N2lBNThMVVVNVkxFTDVsZ3AxWW9DZFozSUJDN2tMZnNy?=
 =?utf-8?B?RU1NaWNKSFpOdUlrK0xUYW9LU2xtaGNmLzBnTmxhR0lVWjlFSld1NkNrbUJz?=
 =?utf-8?B?MHB5UlZCMmNxTUZxenI2Sk1hSm15SGFaNHU5N2ttUVlsSm00alkxY2ZpTG04?=
 =?utf-8?B?L3Rhb0crd1E5NldYZ05COUZNSEZsTit5eWhVZ0dpS1NpamlQRVFxNWZzclBX?=
 =?utf-8?B?OFpYZmczUHBQZGN2YzFaQUczbFR6dUNWRjBJc21sTEhvYm42R1ljQWtWZ2Zn?=
 =?utf-8?B?VEtDd2hjUkRDR21FK01TMXhUbHA2bERJNW1jalI5S3ZGSGtqd3ZCUlFUZ2ZQ?=
 =?utf-8?B?bTMzSHhuSFJCcHZpS1NZT0tCYzFlWm1yRm90WWh4aWc5TStuZUtHUndLb2RO?=
 =?utf-8?B?cGU1RlgyZUp2bDBETnFBc2RwZkVMK0FxSUxBMHJZSnNEeGZvdmh6U0VwbDdK?=
 =?utf-8?B?aTBxR3I1b25Ba1NQMVUzOHhPWUNYT3liQ1Y3bHRxMGtwMFM2WFdTN1UvQVlm?=
 =?utf-8?B?RXFzVVhvSTM2dTAveDM4RmIxalVnSXZ6ZEN2NXZ5K1FSQWlUVFZRSXowc0pK?=
 =?utf-8?B?aVJiZ2xtUGtjVzhCTCsrcUlpdlhUczQrS2J0YzFFVEgwMk1CV0lJbE1NaDhS?=
 =?utf-8?B?WFlKY2RWMW5vREs4di9McXYxRStDUFl6R2REKytPbDNKNkMzMTlRSytReVl0?=
 =?utf-8?B?KzZsQ3VkQnU5aDBzZUV3MVpTMnZMdUx2T2RLVi9QMHh5MjRwODVVNTc4amxj?=
 =?utf-8?B?V1NXUlp1SG4rZWdYbE5Ec25ReHF5NFZXOVZzclE5WmJDd2hUVTdPYmwvaVFP?=
 =?utf-8?B?dDNJNW5EUEFybWlBMEZhZ0x1MnNjRy8vWCtZalBkU1BPOEdSQUZIMFlvKy9i?=
 =?utf-8?B?QnhTMlpkOUtYNHJVYzJrM0kxTllVYk1hODlWeDNZU1N2ZnFIaVNkSmYyR1Yz?=
 =?utf-8?B?Tm5RZllaaitFN2FFbHZBYUpONzNRZUN4clptZFVnek50d2ZXS1BiQmVqM09s?=
 =?utf-8?B?dEVlNXhML0F5OVNxYXllQkdBTENFVE5Iazd1Nng5YjdVRExFMlUraWFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2lWNU8ya3hBTzFjcUtMd3k1S0l3MkY1T1ByQjJUL2FTVzlEZHIxMFJkRVM1?=
 =?utf-8?B?UHlkUWVVd2orSnc5Wk1PWWhFWVluNXhLS3VtdkhmendCUE1LQ21QemhTK3NV?=
 =?utf-8?B?Y1N3SndqMnlrZndlTWhUbGUzZk5kMnJlRFpoUUdkMW1ycVl6L0RhZW1tSXg4?=
 =?utf-8?B?ZWxZcUpoMVRWNVFMVGJuT1kvbWtVbTJrWklyS3R1S2lXSXJVRFhiU21UbjEr?=
 =?utf-8?B?M1IyUVhoRiswbjlYYTViaVBOa3FnWkhVNjJFVDFEMU4wME5sWXE0aDFIa1F1?=
 =?utf-8?B?WmRPWDBVelRBZXFSckxWUFBJQkJndmFmR1hKbFZYQ3EzaE5aNWVTdkpVWGUr?=
 =?utf-8?B?K0U1d3hYZzFNTFhvcEdQWG5PNUhwT0N0S2trQlIvaDc4aTlSalE0bk02bkhC?=
 =?utf-8?B?N3hCcUZVYXppNlEwa1p4Q2wrTWYrd2xjU0puUnEwM2hubzhpUzhheGZVbXBB?=
 =?utf-8?B?eG5aU2lRcE5Dcm40NnJDZXFIQmZtdDJCZnJHL1p6WE8xTnlVS0g4ZWJSODE1?=
 =?utf-8?B?TDhBUXN2enFIam5FL1BDdGg5bWZVckF6dWJXVXM1NmZkclVTSlZ5VHVib3Nx?=
 =?utf-8?B?R091cjdkc3dHdVFQNThGckVOcU1RdVc0azI3U29DZklvcXc0NXJ5MFZ5ZHlq?=
 =?utf-8?B?U3FKdWNhamgydmRkcmtpWlc0K2xZNThZQlkwbGJXQXBMRHdTbzdIT1l2VjBY?=
 =?utf-8?B?dkhHYTlVS3pUUG9QNGtJbUdoMmsvY1VWRVl4N2ptT0k4QjRaNTJ1cEFHS0ww?=
 =?utf-8?B?T1drNXRrQlZtb1BtcnFhRVdGQStXTUphM0ovTElwOU5YOXl1RnV3WFgwL1Aw?=
 =?utf-8?B?ZTVvK0szSHFNd2ZaU0hlRlFCY1hiTktLM1R0aUtqR0RHMnp1N3dOSWhYL1Z4?=
 =?utf-8?B?SHlEUjE2VVk1aWp4YlZVTjJUTElGb2ZtZ1c0WFdBb1dZdVRVZ2U5cTFPZ20z?=
 =?utf-8?B?KytISk5vYUZlNExYL3Q0dUo2UUJWUmcrWkxHaFJJR0g4b0s4YjJqZEZWaENp?=
 =?utf-8?B?UHJHS0Z3R0pFNG9Remh1ZnRwTGNVdmhNM2kwNkNDUEM4Wm5vcHRFUnBsbnV5?=
 =?utf-8?B?YlVDczM5QVJjMTA2TVRkZUo0U0ZGQ2RwWW9rRlZ1ejMwSkRLdGFVTDBIYlJw?=
 =?utf-8?B?bTdQYU5yS3VBdWRJVUJYaWlzRHM2c1RqcGxDTVdQWGlqTUJpSVUva3BrMUp3?=
 =?utf-8?B?M1NMZDRuWk1DTXBLQVJVSjNheWx0aVYrcUtjQVJZOGZha0FrMmFYcXA0RGJp?=
 =?utf-8?B?NklTd2tnTlY0b09Xekl1aElYclptWUlTUnBLaWdFaWY1WUovd0lIbnBwU1pG?=
 =?utf-8?B?WEM2MW9QMk5aU3BLWjZ2azRYT1NudGJ4cGpNTFFSNHZmeDRMaWhIMWd5enJ0?=
 =?utf-8?B?NkRHNURxMmtkZ1dVWXI1M2k0b3RhUTAyYTVpTUQ0a0ZQLzU0VGpvK0Jualpo?=
 =?utf-8?B?THpmUXBRUC9laHNPcHoxNWRKdkdmUUpmcWlSY05KYkVydDBNNnI4cVljdTd5?=
 =?utf-8?B?ZkxTL2E4SUovcjI3Y2U0aGF6RDZFcGRweTRsMlZVZkFtMmR1NmhLZUdmNS9v?=
 =?utf-8?B?ek1ST2wrRzI4Mko2VGZkUFV4aG92V3dsRUp6bWgvQmtmMnlsNS9YWG5YazEy?=
 =?utf-8?B?T1FxQTFIeVJkMjlTYmpqNlhBRjFBVGprV1lVNUU1cnlFeXNROEtIVVdTZEts?=
 =?utf-8?B?cVpkUENadFpNM29DZWtScVI0bG1VcjN5YTVEK2g1UnFrZ2d2a0wvMU5NZ29m?=
 =?utf-8?B?Y2NxZTJOWC9aNmkwN0RQaXBCdWdmRkNNTkJIbExnSk1Ra2padGx0K1RKa1Fo?=
 =?utf-8?B?ODZwMEFrSzdjTGJpRHB0WXpuTVZrZXdjU21XQVliYU9WcWpmZjFSaDBHRENj?=
 =?utf-8?B?Y3liRmNGZ1doSjFFY2lrbHIyK0VTWkQ5UXR5and5MzJmeFRDNUJyZVNYY3dD?=
 =?utf-8?B?bHJVYkNnRWR0TFRDbzRpcWVtcUdQUVc5TFVYYjV3dVdGNXlYMFZ3S3JYcExG?=
 =?utf-8?B?cXd2TVJJTDVCYmRKY2ZBbFluM2hYMG9MQndlaU1icXBRMUJuN0xIRXNGOXJ0?=
 =?utf-8?B?ZDlUY0J3bWFtb041MTdCczVna3pUampIc2xVZEtkaHY1TUR1a2kvYTBlVDg5?=
 =?utf-8?Q?PBIMlMUxQnonspDWTAl0vm8dW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12486431-acd4-465c-1968-08dcea020830
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:36:02.9409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zteuPLfJ+YlYVv6UWb4YJwCYhkPZeeTCYrHgnV5w95VErIan9RHMumR/SDimzwilEygzI9hEOx5XHl0Xu+q7aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6698

On 11.10.24 16:29, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> 
>> On Thu, 2024-10-10 at 18:07 +0200, Philippe Gerum wrote:
>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>
>>>> The following kernel splat was found when running the Xenomai 3
>>>> testsuite in compat on dovetail enabled kernels:
>>>>
>>>> [  513.620975] IRQ pipeline: some code running in oob context 'Xenomai'
>>>>                              called an in-band only routine
>>>> [  513.620998] CPU: 0 PID: 510 Comm: smokey Not tainted 6.10.0+ #76
>>>> [  513.621003] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>>>> [  513.621005] IRQ stage: Xenomai
>>>> [  513.621007] Call Trace:
>>>> [  513.621011]  <TASK>
>>>> [  513.621015]  dump_stack_lvl+0x6f/0xd0
>>>> [  513.621202]  __inband_irq_enable+0xb/0x60
>>>> [  513.621249]  do_int80_emulation+0x68/0x160
>>>> [  513.621265]  asm_int80_emulation+0x1a/0x20
>>>> [  513.621285] RIP: 0023:0xf7f692ba
>>>> [  513.621288] Code: Unable to access opcode bytes at 0xf7f69290.
>>>> [  513.621303] RSP: 002b:00000000ffeedf40 EFLAGS: 00000282 ORIG_RAX: 0000000000000127
>>>> [  513.621307] RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000ffeedfa0
>>>> [  513.621309] RDX: 0000000000088000 RSI: 0000000000000000 RDI: 00000000f7f7aff4
>>>> [  513.621311] RBP: 00000000ffeedf88 R08: 0000000000000000 R09: 0000000000000000
>>>> [  513.621313] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>>> [  513.621315] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>>> [  513.621319]  </TASK>
>>>>
>>>> When entering the low level entry code from the out-of-band stage
>>>> the in-band IRQ state was changed. That is now avoided by calling
>>>> syscall_enter_from_user_enable_irqs() as all other entry points do.
>>>>
>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>> ---
>>>>  arch/x86/entry/common.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
>>>> index 467e2511df2e..13589f1ca89b 100644
>>>> --- a/arch/x86/entry/common.c
>>>> +++ b/arch/x86/entry/common.c
>>>> @@ -259,7 +259,7 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
>>>>  
>>>>  	nr = syscall_32_enter(regs);
>>>>  
>>>> -	local_irq_enable_full();
>>>> +	syscall_enter_from_user_enable_irqs();
>>>>  	nr = syscall_enter_from_user_mode_work(regs, nr);
>>>>  
>>>>  	if (dovetailing()) {
>>>
>>> Ack. Merged into 6.1.y, 6.6.y and 6.11, dovetail and evl trees.
>>
>> Philippe, I have to apologize. The patch is correct for 6.11, but not
>> for the older ones. syscall_enter_from_user_enable_irqs() does not
>> exist in those branches.
>>
>> I have to check why the build error was not properly detected on my
>> end. Can't tell yet...
>>
>> I will work on backports, meanwhile you should drop it from 6.6 and
>> 6.1. Thanks, and sorry.
>>
> 
> As Jan pointed out, your patch is fine for all 6.x so far, this helper
> appears inline upstream in some header only after 6.6.
> 

I think the issue is that, depending on some compiler settings, the
function may or may not found. It is static inline only for
kernel/entry/common.c, thus indeed naturally invisible for
arch/x86/entry/common.c.

../arch/x86/entry/common.c: In function ‘do_int80_emulation’:
../arch/x86/entry/common.c:213:2: error: implicit declaration of
function ‘syscall_enter_from_user_enable_irqs’; did you mean
‘syscall_enter_from_user_mode_work’? [-Werror=implicit-function-declaration]
  syscall_enter_from_user_enable_irqs();
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  syscall_enter_from_user_mode_work
cc1: some warnings being treated as errors

Jan

-- 
Siemens AG, Technology
Linux Expert Center
