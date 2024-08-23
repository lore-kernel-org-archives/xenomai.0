Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EBA139D00
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405279; cv=fail; b=cx+WLHcDOFI2dGq3xICH8SdHEwK6mcvhCGNMBPUnC23Nsa5KqQ84jGjU+O90OPDc1Hw4qmG8twTlUANUjDupsW8S+krUn+IqdRURZKkwNODmTSUrG3D4WP+19w0ON9Yo+Mbo69r0dM9X2RAMvapLmgnyuDPuNwmO7h3PkkCLhsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405279; c=relaxed/simple;
	bh=jNBaL8y5KWSt1UAFArsL+UdwaJxeqx72PlSBiYVmGP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T+C6nVx4UaOiBVI880f72Ekvh9MfgZl7sa4Vb4lofuU50KGcC9Tvf10A4C7UuyXtTpKZFYyfZCLLRbnmqFAHcarnluYniZEtt7PZzbCz/DVUXm+/8e06GVN8AioLX+KxjqB4cmpi8c/9apMLpvBmlzC54SWt8ILA8nvOkqovAWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FKuitEHK; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FKuitEHK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0A7NFqdK0cugcookfWlR7+L59RTjupUCTtIflr7Y+eMMbhyxV36ZMhPnLeI8QIlvPdmKtTsMaAbg8TtUX1CJzbmL05V1ymWkBtiCaRAcv+jszMiMsEEc+TNCRuHIcuUNJauaxYL75U+zsoyVD3/0kTJUCMuc19rwxsCx1YeKH9Q7IRUNd8kwg41nH7Rpu0L/4u5f5d/yCAl0cT5POBllCF6kQG/R0cWXwIyl1+KHvZWwacWavylu94e2RzyXBZq5+1MwW14KGWgAgxhaeL5GQC7w1pIT28/avht+JCWPqeC3BsqHaxcHKzWU/bxxWjRQdn5zoyBequUZcRKj+nmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwiXEwb2NQtATNW1AuwRKVrxEhN/pIVeQ2vje3QM5EA=;
 b=GBPfnw+Luql3JYvY+gI4VNnm+nbiGlXCc6QMGariS9qbKdFb7hPkCw2RBSlsbimLV0Tr4v6AKHqYlIbDg1JwgT3C7FqtG0/9XerPKlxnaOKnD3tt3LqMcN7O9pxgpJsg6mpo7FZ7Dg+GVHS+spgQbIPDJQTt6D7fWm6hdSFIPj6jQJMk/Zy9WY+N+vGqvvtHut/JcYc54GM3yRM/+gX8z2mxpxLaVzPcVNEov7gngV+a4poVGLSORfFdSlmyk0tO3EMXGGJXktJfX3iM69Fz4hyyrSJWssNxU6QLsAT+cKRwTyKmTx7P9vRDaeP3vNxbXfBYlwOIE/iV8dkHcspDHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwiXEwb2NQtATNW1AuwRKVrxEhN/pIVeQ2vje3QM5EA=;
 b=FKuitEHKGdLDDPxoPYEC1oZTV6HwPmZzfYQpruQiF+eDevBfiagE3ioiV20MAnnBFyA5+c2jtsnAYknshdZia8r5LlPGvkrxbOktvOC3ZPHiBwwXYc9vn2RltzxXrlPbX0qUHStvqHOhktk0MqPem1xnGfpMGKHLJ6cz2Dnmj+vCPA1ulmELI0nQ5zmZNO/SsXD5OAmkYVuNklATqXx/fH+Cx2cDSNAdiah276APF19hD0bWRYVp+8idrRgANGcaUwbeC5js+T5ezv44rRl8G5exCXYBVsaJL1UOTB0a+8/Nxe/p1XHiyGzvzZByAw/6GApxMCKj1iA7W4JmxpmE8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7526.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Fri, 23 Aug
 2024 09:27:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 09:27:52 +0000
Message-ID: <a6a3373b-fb88-4d49-8296-ba9d02008ab3@siemens.com>
Date: Fri, 23 Aug 2024 11:27:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] doc: Fix typos and grammar
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240823065247.4884-1-simon.graber@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240823065247.4884-1-simon.graber@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d3afc0-f15f-41eb-c9a5-08dcc355dc8a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTVGTDFyTk92Q1BEVUtXVy8zSmwwVVhCL0xqUEFjcitmY0xCRWdQcm1uc3J5?=
 =?utf-8?B?Z0VLOWhoVk50Tk16VEM1K3dFTXhUUzZPTWlzZTlWV25SNm5oQUxBWS9UODNX?=
 =?utf-8?B?NEg5bW01dzlFRDF6RURISWloeGdlaHI5eTdqWmFFRndNSWNlc24xUjdBZ0Iy?=
 =?utf-8?B?L2MzWFIrQ29WVGtRVzBBVXNYVXAvVEFWZlUvNmFZdDlVQmxINmlnNEhTYnBX?=
 =?utf-8?B?VnR6eUNkSitENExFOEVjVHZudUlZWDU3VUlqNlo0VGxidWpEQ2N1Sllldm53?=
 =?utf-8?B?Wk4wMXM5TDQxMVpwbCtiQms5cUc4dGJCVmp6OXU1dmlld0JxN3NFRHVNRDd6?=
 =?utf-8?B?RXZoVHpFS1RoZ1RMN0hESS9lYlBrZjd4SjZJU25BTUo1VUFRYmVncXhZWi9l?=
 =?utf-8?B?Mk5XNU1EalJTRHJsb1FQZlBBTUtSMlZXRi8weDZzNnJOblVaazRKMWp3RUZp?=
 =?utf-8?B?ZXdUNFI4ektUTmNFbTBaOVhCckczZ2pOc0VkMk14ekNvN0FLcThVN2gvRk8w?=
 =?utf-8?B?cDVnc1NhdmVLQnFIakJHZDhXZnpybG0yYXFkU1BaYUhoeENQMkZlVlFvOHFZ?=
 =?utf-8?B?aUJDUDdaZkxhdyt3dDVKcUd2MDJPcWJRMWdkY21MUXJVMlRGemp1OFZvMWdn?=
 =?utf-8?B?VVBrMVJsRUM0dDE4UUN4dWY2TXdBa1NHMU1BdHY0aE5OSEg2QzJxL0NIRG1Y?=
 =?utf-8?B?b1o0d21teTFVV0QzTXJOU28raUgvdU9xT3RjYkJ2RHhoZlV6Wmxzalloemhr?=
 =?utf-8?B?SWMxL0xMcmNqbTNicHpleHViTEwxUGJZT1Z5aUNOZ3VsVXVqVVBzaHZXMDFw?=
 =?utf-8?B?QldpckoxalFnRWUvOHExWXdVaTQ1ZElaR1p5bjd2QlJEQXliTTVPZENsOGhu?=
 =?utf-8?B?amZjQjNwallTcS84UGlFRldsY3FCdTBmSHFscUVGb2hOM2hEdzlLak5wNGs5?=
 =?utf-8?B?RG9FSERiZHBYejBjNWpTNDBOZlY0ODVmNXF1S0doTDFsU08xdFFkK0t5bWI3?=
 =?utf-8?B?bW5tVVkrbFUwdnVDQkhVd2R1TGFRYVRQTitZYTVjekRyZDFzeG9zdlZUMDNT?=
 =?utf-8?B?U0pXTjdDbmI4bEIzMlFUZ0RnQXRyMXBqRDRXVTNIemIzVUNLQm9sMjB2Ry9O?=
 =?utf-8?B?UFlQTUdsZ0cvVmVpNGhuZUZFaGdHUC9TOTlJZEI5WWFic25Ud3lxRWVhTXJr?=
 =?utf-8?B?YWUrSUV1SHVEekZZNkJIUVlFTkNHaDdxL1c5MWE3b2NYcmlNV2pkY01yejJ4?=
 =?utf-8?B?UnVLaDMyczJ5Z21mR0RWR3JWTGZoaTJEcW5QR25HaGN6WHhhRzBkUG1XNXEx?=
 =?utf-8?B?eTJNbkFTYzRPYzh2MzR3ODV0Wk90cnJ2SlhPUzN1SjJLVnpOcFpqVERwSlU0?=
 =?utf-8?B?SkxKMC9RcVlxNXFOcnUwRGdodkJRU3p3UHpOUE95dXo2SGNUSGkvS1RkWGFa?=
 =?utf-8?B?WVlhaDFRL3cxVmx2Z01iTm4rYVdlTUgrQXNrWXBoMDJsSVJ0ZVlvM0dwTEkv?=
 =?utf-8?B?VXZvbDdISkVTaGxneVNwNUF2MnYzdWdCWkc1L3ZVZWtMdnprdHdFT2JrNmNW?=
 =?utf-8?B?czZZK2FQMmR6VzduaVFrNHlTL0NuVGFsUTV2YXMwOEMrU3pEbEJsMzJSdU5V?=
 =?utf-8?B?RTZCNDBmS3pvZit5WE9wZ1VvVFdQeUdNakYvOXVsbHROeDZ5SmlCODhlUGNW?=
 =?utf-8?B?TjYvTWtiRC9pRVdXd01QelpGc0lIQnpRZVpBM3pLSmNvKzNYZENGLzJYZ01j?=
 =?utf-8?B?SzErMlRaalJOT2hkaThYS0NCRFo5OEZEVDA0dGUwTW1vNFdCR1ZEb2pPOEM0?=
 =?utf-8?B?RDVza3M5Z2phenlXVmVTdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEhUUUk3VHp5d1pKNi8xdXhJTjE5WGRoZXc2UWdrUm1KK3p1OWVUK0RJNm95?=
 =?utf-8?B?bDVOOFI2MWt6OFZ1dUo4M2duQWxpTVhkb0t1SDdaV2tvNi90eTVhRTRmZ0ZW?=
 =?utf-8?B?WjZzTjcrbmFpSWRkWHdpQmR4TEhLYnMwUklhU2s5NS9vaWJ5RTVSb1Q4c2la?=
 =?utf-8?B?MGFBY2Fnb1kwSmx6TW9GNzJoWW91S3drZkd6NmhieEpoZitsSGZ5Y1dDdHc1?=
 =?utf-8?B?cHRhdXBoZ0JCcGQzMVBOeUxrS0lMd0JhekJ6T085VmlteVNLc2tyNUNlbkRm?=
 =?utf-8?B?L0xTclIxNTZPZWlLMm4yQ1h5eFI2R28wVHV0andJY004c2VvcDAvclZGTGpY?=
 =?utf-8?B?ckJmMUw1cWN0cFcvUFRsenZ6cHU1U2RLeGhBTzBJNGhpaXl1YkYyK2gyTlBS?=
 =?utf-8?B?MzZPcnE1RENDSjdaNzcyVjBwZlkwZXNYb2huQ3V3bCtqellwdEE2ZHJHRXFI?=
 =?utf-8?B?S3MrejJ1bUw5QnNUQlVMM1Nwbzl1ZzFtUHgzZHc4bEkxUHRWUkEwcS8vd0h6?=
 =?utf-8?B?bDBYcHkyMmRQdU81dXhYZ3VIdnFqaGJVMDZhZGlwTWVaYlBXQ0NsSGhIbUJH?=
 =?utf-8?B?ZEoyUUNlTkEwRjdjR1UvSXZDdy9sOCs4eFhNSmM4SG1zbnI0a3ljdmcwSTJt?=
 =?utf-8?B?b01KYm5KRlJ6VjhNM1kxYWt0SFEwa0RRZGpNVGJNZVdSVndEdHBwQ0F6UDV5?=
 =?utf-8?B?STVEUWlyMEVHbFNUaldZY2RzaW1VY0tyWnA1d25tWEcvMDdhQnhZSjBDWUlN?=
 =?utf-8?B?dkIxMmN0VUxkRmtEbDRpQ045R2hkQ3ZxNTQvNytIY091djlsTVNQa012dld0?=
 =?utf-8?B?SEdNREI2dkhwS2xuUEltVzNnWm96NVpUMWRmclp0L2JwRFl5aWEzZ2Z6MlNh?=
 =?utf-8?B?Umxab0pwenFuRWlPb0NKOGtiL1hYMGR3QUVjSXhJZStPYTZndTZrWmN6UEFE?=
 =?utf-8?B?MTlkeXRxK0RtUThCODJkNGRzdHlYa0lpQ29xb01mUDhIV2VydzZjQ2xLbW8z?=
 =?utf-8?B?c2ZTSk5VaGVmM0M5YkVUa1ROeUo5NlBNa1pUMWhweDZGV2F5R2dUck9MTXJm?=
 =?utf-8?B?VWJ2c2ptengxU05RTGdZdkowUGdDdDNBazZvQlZ6azhlWXVtdWtIaWJIMWhu?=
 =?utf-8?B?K09hZGQ4ZVE3UXZlOW9NdFFRNzlxaVF3YzA1LzBNdjR1OXlTMHJya0V5TE85?=
 =?utf-8?B?b3hoU2E1OGx1T3hqK285MGo1TkRmTGQzTnc4K3lyem8yTmh5VXpDV2ZkZTlD?=
 =?utf-8?B?LzVLVndEUXVTVGpQMGgzWGt4bVFqRnd0djdvUlFYRGRyaytCRVo0aXBjQ0JN?=
 =?utf-8?B?YU5TT1c4K0pGM0tuYjQrazFWRlhSeTZWVmpsaUJ0RU5Ma0NpOHRqdHg5Qkkr?=
 =?utf-8?B?TmdOYVRSaUlpejZPeE8rME0wU0JFeHRNTkExQ0VkUG5VUFRqZWNrMWhqZ29m?=
 =?utf-8?B?UnBpTlRRUmFXd2o2aTZMdm91Z0J3dExjWS9URlhlakFyUERDS0tYeDdpSFdk?=
 =?utf-8?B?Zm05akFkNERranpZUDI0bmFJZFF2eFhBRmQrRjF3NTNEN2hRY0hrUjJqbzVn?=
 =?utf-8?B?SVNMMzIzejJVZm02OWdKelZRR1VFTmJzZ3I2VGtjeXR4TVd2b2l5Qmp2dW9q?=
 =?utf-8?B?UGNEOXNiYkNacWpUV1BVN3hjbmF6YWszZ2pIeWlkWlBDcXlERXFKblV4WUJL?=
 =?utf-8?B?cTNadFUvNUtML2xXQUhFVC9CaDdFTDh0eWZoYzVPYWx6UUlDSEJBLzlmdm9N?=
 =?utf-8?B?Tk5CVUtFbFVxSmhIZW1xVTNEN2ZXWnhvVStuTkFOUHpzYzNwQTluUkRZQVI5?=
 =?utf-8?B?SU8rMDFGNWkwMXB3NWpla05WbVJHZSsvR056d2pjOG9jeHJUeG9Sa21ubEVr?=
 =?utf-8?B?eWxCSnE2ekxkM3FvbFZWVURMWTZPVS9ud3psdUJYUWhVK003WTlWL0JjVTIw?=
 =?utf-8?B?RzczQTZybzBEdlVyWHlBSXFEc2h5TEVDam5qVG1seTRuVUgxT25LaE5IeGkw?=
 =?utf-8?B?ampQUGpjNkhucUdNSDdOMEZZVnUvU0FacUlzK0pHU29EM1VHRXJjVXpTc2xp?=
 =?utf-8?B?eVQxaVhIVWpGWXVLMjhLSWdkRHBxOVBBWGdCdjNuTTg1SDI5NHhJTGZ2bTJN?=
 =?utf-8?Q?zGiGc3FE/WF+6XQeOCc3DwZbs?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d3afc0-f15f-41eb-c9a5-08dcc355dc8a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 09:27:52.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyfJiv+Mzz7OxcAI14HTi0527wnyLFlyS909UowDJdDCLmRKuiGkvfzrN+Z2df5Ga2RcDwm3QFlOSDd1gsV/Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7526

On 23.08.24 08:52, Simon Graber wrote:
> Hello,
> 
> this patch set fixes mistakes I found by running hunspell etc.
> on the doc/ directory.
> 

Thanks, highly appreciated! Applied to next.

Do you think it would make sense to install that tool in our pipeline?
Or does it require too much human interaction?

Jan

> Simon Graber (2):
>   doc: Fix typos
>   doc: Fix grammar
> 
>  doc/asciidoc/MIGRATION.adoc              | 14 +++++++-------
>  doc/asciidoc/README.INSTALL.adoc         | 14 +++++++-------
>  doc/asciidoc/TROUBLESHOOTING.COBALT.adoc | 12 ++++++------
>  doc/asciidoc/man1/gpiobench.adoc         |  4 ++--
>  doc/asciidoc/man1/slackspot.adoc         |  2 +-
>  doc/asciidoc/man1/xeno-config.adoc       |  2 +-
>  doc/doxygen/xeno3prm-common.conf.in      |  8 ++++----
>  doc/doxygen/xeno3prm-html.conf.in        |  4 ++--
>  doc/doxygen/xeno3prm-latex.conf.in       |  2 +-
>  9 files changed, 31 insertions(+), 31 deletions(-)
> 

-- 
Siemens AG, Technology
Linux Expert Center

