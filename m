Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6211758F
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025684; cv=fail; b=eP3HA3mwJU/50Vp61DwgpeSpc9BjmW6ywHx3+VsagM3Og5V7LA0psDKtCnoVx3y7iKCedwXpfgP216mfQifoglvBjBg/PGFvPHkZEK08fHNAP9npqfOnraiKG7TIRFQrtncPSQFh7tCIupsI8OTZcuXUCR0/bFiE4t98ipi3+bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025684; c=relaxed/simple;
	bh=WAXC45rYj1T84O9ahMU+MSi0xL0U8oLEPAZIhNpFk50=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VyFU7gJh4nxjJMmQ0g6sTGIf9KwNJhFxnsVgtDWZZqD3l7JJETrw4oeHVb8yAQgR2VJsNKNpgKv2ANIBifx4ykandIodTX9X5OsSRq3nrqH4H0YWLAQFL6Hq0d+gtGicPfjJ7Trst/b5JWNe7wLDLBbQU+uH25LBOAgDuhnjD08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VWF7Mez4; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VWF7Mez4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYh1wtiuwSjTxs9I10ANI7wsv08XuszqeHM/4vQs6z9SVI77uQyfRjpKEJgMoLFqm3KGsNi+L4JjUtVak1FgoLJVwqYpiILPl4JrygjrHwelOiC60Fpf4LJkbnRqhNZ8L5PP9M1QsZeLpT4uVkiJU05By2iR7/GqgGkDAcUJQDpg9g5hP5gQgr5rhsDzhWWfPwrKkfShAzcgDrH/jVk2d7FReGsobYuRtPIMbnvD27D4ZTWkSkJosvb5s83GERHtb4+1gvsl+w3P9AB487kasX4unTFZoyOqwZ4N5j2GJRTXWVQlMygp/6FYW1aH1fL1ZsZ9kevs1La/1t16bWSVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bj5QfKeB7K+MDOhgjbsAhx9MNroIe+x+p/X/g/LBd8=;
 b=N6k1z+9QpEriz5I8YDDhxWCzbDFblyTyAJfnzFwmur1pmbe8FLfnZsL6tORcclwxJaElpqtHQRY7Z+K1MrfQCZexMny3EYhI9tJxMyEUDxj3Wz+ZWUXfDMJ22CDX65Z7u7PlCq+a8y9f8dggwoXAGGQBQ8K0ymc6KgTMiFxva9IJhP/xP15YIROIxUsteQI9PEN9FqSn8yDDFLD8wb12M0oqP+T4pUrHhxkUg1H/PJ6GTD/JOhL6vnUbQmo2aOR+6aBLo3QYp8Q4+ZkQZPYeKLkbnbObnH5Ghn3MXktjis9+kqPD/NGPD6Y7ITdLcknnu6fyZ5MOP9aC8lSREhqtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bj5QfKeB7K+MDOhgjbsAhx9MNroIe+x+p/X/g/LBd8=;
 b=VWF7Mez4tNKVLl/mQm1illm7MpIi1/S3KikfbbQtovk3errdN2HQWhgqL8XYSfOWbT2VW5Jm+sZjBROtLdxUuUnCWu0NvQV+WxDN6FD5Jr76UgaWjnpa523lmglumrdD+yXsdxvxT9fXz06OWTBGo9PgVAc1ZlMdwqkCyEKaicXmvxETbrPpd8n+j+plqvtiT0dxh+HYnR+BFkED3s4k6Udv80/w0rlZ66FDbGkaIwfSjfXQ9uywU3TRJk3dD9s28JzcuqVvb5FLqQvn3iZGx/JKGe4eS5O3FeqVUT07KMpyvL2wsVJbpIaazm7cZMnVGKLc14G1jU7x33PnKRMB7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8054.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:654::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 13:47:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 13:47:58 +0000
Message-ID: <006108ec-7fcd-442d-8009-5d16118d87da@siemens.com>
Date: Fri, 30 Aug 2024 15:47:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Enable sstate caching
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240723140801.1247672-1-tobias.schaffner@siemens.com>
 <6239feef-9326-4ba9-a744-db774134b128@siemens.com>
 <aae26c91-4765-48d1-a02f-3f0e5b4521b6@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aae26c91-4765-48d1-a02f-3f0e5b4521b6@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a1ea73-29d3-4720-38be-08dcc8fa5b92
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHhGNHl3bmVmc25GTjJvY054dUIvRVlwUEpIUkh2VUdBdSs2ZmR3Zk5EUXhV?=
 =?utf-8?B?UVNwVTZ5S0xRN2hvZjdaVEdaQ2Fza0xKUnhrbFI0QkZrR2crMkQ0Qlg0eXhW?=
 =?utf-8?B?c0ZjV0o2SUl2YWNodEIzcGlHbHVTMGROZUZJWStWcGF6WHB2aVdRKzE5Zzlt?=
 =?utf-8?B?RFRJOGJURk4xb2N3N1ZaRjNYM3k5dVFtN1RwSmdkV1ZLZHh6MmZsTjJoUFBu?=
 =?utf-8?B?YjZYcjBYeUdTNE5UWGt6TVJZK3pucUlKUlY4akVmTUJ0blJGU096L1JiNEhY?=
 =?utf-8?B?bGdEWmhMV1VVT2t6ZTU1ZkxRenVwd25meFdmSy9vRGdweTh2YlowQ05RNjlm?=
 =?utf-8?B?WVlZOUQvdHFEaS8rdjVoZ2YwZjhPVTk4WG1jVnZkQy9FZG5BY0xKRExyV0pk?=
 =?utf-8?B?UkRWb0NUdldGSUQxTk9tdkR3SVN3a2xjTm5tVDVpVDRCdDhxSTFzSTV5UTc1?=
 =?utf-8?B?NFpGK0MvNnRPTFNhS05KazBReW1hV1BzK2h5K0hSZXR1WVpUUlBMWHJqb3c3?=
 =?utf-8?B?MFUrTkFzdEVpWXkvNjI4Z0ZuUldxSERhM0lOazQxaUJVakVEVWl4d1pTWmw5?=
 =?utf-8?B?ZXJTTTlYdFp1Z1pWRmJTeEx2OTlVNnVEdU1Ec2djcnROVlRQOHlZQnJ0NnNV?=
 =?utf-8?B?STErOHVXT3VtS1pNOWJyM252dGNtQVBqUUY0WDg4RlREU1dmaWE2RG13Vlpj?=
 =?utf-8?B?OUZOL0psSFFqYkNHSGRrbVpzcHRIaUNBbDJpMVQrYTRKVnJSYyt4NXVUOGIv?=
 =?utf-8?B?NU5pcGthUm9la2hTVGNwS2ZpYlR5d0x2eFdnQ1dKZklTNWlIWU5HZy9uang0?=
 =?utf-8?B?bm94cEFnT0czbU9MK1gvU2VnVWpEUC9hRXVoOWJIYnNRVStNRVF1K0NyWDZM?=
 =?utf-8?B?SThyMlBUZWNUamd4Q2lsWmtxeDh2aEE0ZnBLRnA4U2JTc0tFdWxoeU9mMWxI?=
 =?utf-8?B?QzdmR1A5WXhEekttSWZnOTZENGVHcUxiRzNIZ2lJdUtYRThmSk0zL05XRDNG?=
 =?utf-8?B?S002N0k1WTRWbDNiMCt3TkRpSHQxdFFQZ3pPVkRhankrNHZ4aSt1Tmd2YkFi?=
 =?utf-8?B?WWZZbC9qZnlKcGp3YzM2MklWaXEzRkJ1RUVRZ3Y1MUU2NkJIQnB0VDAzc29m?=
 =?utf-8?B?cVo2NzZhYzdwUU0wWU5ISmRGKzNHcGQ2aGVjWDJuMjNiWDNVeVdvL0RjM1E0?=
 =?utf-8?B?UTkzUCsxa2ViZC95Ui9SK1RGdWx0YmJuMUwyY3JacHpYZWNqZ3BBSUxpNGFz?=
 =?utf-8?B?aHhxelRVVTdma3Y2Vm9uMUdhd1YzdU1kY20yVm45bzltWGZQNkNKRms4a1Jm?=
 =?utf-8?B?cjJCbzRPd2xKNy9Gd2krUm5jMEpMZ1ZWTUFvMHVZRWpaUHJBTWYreWFWZFpv?=
 =?utf-8?B?eEFKRUZJTFdKK3lscmkzQ1FYY2p1YWVPZjh0bGlFY0p5WmcwVTNQdzVPV0ZU?=
 =?utf-8?B?eVRBRGU3QUNBOEthbm1yT3VqcER6dFpBNi85TzhIekJWbWlwK2xuWlpyNVJC?=
 =?utf-8?B?VUJiZHJYVVJlMVRNalFPckltb3J0Z0lJK3p4QXpWYVFRWVVWUXVvMW1lbllW?=
 =?utf-8?B?UTU3UWFzbVpPMUJxM0RXS2Y3eERlR1dadEM4RHJpMkl0Z2gvc052L0w4Vi94?=
 =?utf-8?B?UVF5aEJYZEV5L1pES0dGL2NtNHJtVkY1L1FiM3cwTFpTQyt2Vkd1V0JqNUFE?=
 =?utf-8?B?NDJQR3NaR01PanBEb3VNb05LL3RWN0VUeTJ5R3BBeGIvT2FRWjVHTGNtbk13?=
 =?utf-8?Q?/gY4kR99H+4kRqjZug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGNGdDJqZHNZeGc1TGNkZXZrN3JaRElaSGhqb0d5bGwva3ZqWDdFaVN2UHZZ?=
 =?utf-8?B?Q2J5SlpQQWlOWUk4T1FETmxwZWdrREtXZG9KcWRjUVc4SHlyQTJMT05NK1g1?=
 =?utf-8?B?QmdMM0hIRzd1NGVPN0JNQzRVckVsY3pRcGxDYkdyL3N4Z2NZSHdzSlNIa0s2?=
 =?utf-8?B?Y3dINDRkb2J3VjN1RkNWaWNmbU9DUmhpVFRpMEIyMVR1N29qdUtnZkVPK21x?=
 =?utf-8?B?cHBXSnBwcU10Y1BMbFdsaGVPREZkemVxMlpURXhZalpzdCt6VFYwWXFsRERP?=
 =?utf-8?B?b0hwOHBVYU9qMWp3WnhLT0MwYXVYNkZadHdPUDZidkxPajFYUlFES3AwREZ6?=
 =?utf-8?B?Uk96cFJxWUExV0FkaVdnZk9zR2pqNkgxN3dVZ3dJRTVLK0FyMDdaYXA0ZDM3?=
 =?utf-8?B?VUs2UzhPOWVsMEIvQ0lpZk5BUSt3QlZWblZ6d1BpWkFkVURnSmI2Y1ZQTzJJ?=
 =?utf-8?B?c2hQbGUyUlhxRnhaTEVyWE5ydWFEYXdSbVJ5MExlTk9hTURLYnFpNWVYUmIy?=
 =?utf-8?B?MVcydjk0aEEyS1lpZ1dFTXpSSnZJMmNrMmR1TjMrQml5SE5JcWt2M0E1ZEVv?=
 =?utf-8?B?NWFWTE5WZ3ptN0FkTW45N0p3aWdEL0FwUHZRSVlENGdNanNzT082TWlMeTdO?=
 =?utf-8?B?dWhZL0xPUFdFMUZWQmtWdlVjTTdQRVRqNnJpcUcwcy8ycFZlS0taZFpoS3Bl?=
 =?utf-8?B?NWlQVU9TanEwSjZXTVRQREhycjNKbWNoT0FsWkpXVnRHUXN2cU95Z1FoS0k0?=
 =?utf-8?B?ci8rekN5TWhQckhpdlUzbVhocG1KWE93SGgxVXNGRXlGbFJsR1NEbDZtbEdL?=
 =?utf-8?B?S3RCNWZNRnlLWFVmS2pCeE9pOWpxYWtheTZ3SDR6ZHdxZWhkYTFVK1oxNW92?=
 =?utf-8?B?dFJXcEV2Q0JhTWhRUUpaUmkvUVpNajhrMzhNaWpvbjZjZ1B2Mi80aCtiWTV4?=
 =?utf-8?B?TnFqeUh4QlBHS3UrbGNUa3E0NHJoMlpvSG5BZXZyaHFYRFlIQUpLRlJVOWZh?=
 =?utf-8?B?N1ZZbUFtaWcyVHl3T3BrMFQwcC9teENrcCtKRm9LWFcwVytzd1RKRUJ2ZGQ5?=
 =?utf-8?B?ZWFPZmNqQzN6SUE1b0xTZUVOeXZGRm5mT24wY2Joc0RVTjVuRXZuSTNjS2Yz?=
 =?utf-8?B?Q2NWTEllV055YnBHbTVnVHdJRWNnVmdjc0cza0tERW9PQ0ZYaFc2ZGpTMXVm?=
 =?utf-8?B?b0cvTFFONllVb0pZR2hGTXNiMjNwc1VqcmdibGRkWE1GRnJHKzNFN2crdkE2?=
 =?utf-8?B?eDBiNTlJV0J5bzNoWjFabnE1aGNZdThiSDRaRVpHNDd4WkFBSFVPTlJZTEJq?=
 =?utf-8?B?R2Q2dk1SQjBldmxxUzNYK0MzWmN4VndkaHcwMUQwRUdLM2V0dFJNeDZ6bGk4?=
 =?utf-8?B?cUdKa1lxTGhRdFJVM1ZuWWFvRnRFOEFVQm9RbGozQUhrVXhwRmJHTjkrdm9J?=
 =?utf-8?B?UmhRR3Nna2ZWUDZLMTVmSllZOFJ2RzZEZkRQd0J2WVVxeTd1Zi9TSzVsTzlY?=
 =?utf-8?B?UjA2dS9tQXdOS1Q5TWtzVGN5WkcreFdsbXZEdkl2VlgrcnVFRVlKbUdmZ3Vv?=
 =?utf-8?B?WEdwdmZjTWVtOWFXL3Q5V0ZHSkVDV2lxZFFEOGVwZnJyWE5aUXEwQjM0Q29k?=
 =?utf-8?B?VmROZW5VdExLd0VXQnJtQk0vUklVVkhHYTFQMHdCR2FzQmZHKzdSUUVFREVv?=
 =?utf-8?B?dDBEOFFNbzRXLzdSN3I0VEdqSldIY2RsS3d1TXlyeTh6cXMva09iSVVoSnVK?=
 =?utf-8?B?bDlLRGhjMlVibEJqTkpqc2FuSmJOR09YcVB1NWpGNDBDbjRKWHVWMWR3aFpn?=
 =?utf-8?B?bzkzWGFtOXVNd3ZKVnhHd3JqVzd3TXZDbExHRDBBRUZKWHpFNTZkOVlnc2Jw?=
 =?utf-8?B?Q0s1WXZRcmZ6NUp1K3dVcW9JV3NNRFY3QUIxYUxJanU3QjJ0M0Q4L0tscVRJ?=
 =?utf-8?B?UnIxc21EbWZmbXlKMys3SWsrQ0NEa05QbElvaU13Q0tXazBOOFY4ZCtrTUZY?=
 =?utf-8?B?UGhTU1IvcGtod2w0UkpFVEdCSWJ3Nlo0VzlKYUtYaVZndzZGRzA4QzU3L1pW?=
 =?utf-8?B?RTdvTThyS0V0eEkwSEVKVFZiazloSHRNU2JMTnNzSUU2M3Z6Yi8xWkx6R0or?=
 =?utf-8?B?cGdLOXVDRTJkRFNEQ0k4V1FlNzBWSXZmRXNBS1RNMU1wZ2FpeXdaYzRqTVll?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a1ea73-29d3-4720-38be-08dcc8fa5b92
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:47:58.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2N694/zcG1bYhdj7PZgElHz/KjsXDSHiyxwif/LpxGdo7bThtKi8qZQbrcj5FPIlFEcJJ+8tTewR4MR+/1cVfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8054

On 30.08.24 15:44, Jan Kiszka wrote:
> On 07.08.24 23:52, Jan Kiszka wrote:
>> On 23.07.24 16:08, Tobias Schaffner wrote:
>>> Enable isar sstate caching to an aws s3 bucket by using the
>>> SSTATE_MIRRORS environment variable.
>>>
>>> The isar-sstate script is used to upload, analyze and clean the remote
>>> sstate cache on every build.
>>>
>>> Cached artifacts will be cleaned every 14 days. This can be overwritten
>>> by setting SSTATE_MAX_AGE.
>>>
>>> Credentials have to be injected using the AWS_ACCESS_KEY_ID and
>>> AWS_SECRET_ACCESS_KEY environment variables. This is already done for
>>> download caching.
>>>
>>> Currently the size of the cache is ~20G in size but I expect this to
>>> rise to a multiple as soon as this is used in productive environment.
>>> Keep an eye on the output of isar-sstate info.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>  ci/gitlab-ci-base.yml | 47 ++++++++++++++++++++++++++++++++++++-------
>>>  opt-ci.yml            |  4 ++++
>>>  2 files changed, 44 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>>> index 1dc05a8..f5009e3 100644
>>> --- a/ci/gitlab-ci-base.yml
>>> +++ b/ci/gitlab-ci-base.yml
>>> @@ -24,12 +24,39 @@ variables:
>>>    TEST_RUNTIME_SECONDS: 300
>>>    TEST_MAXIMUM_LATENCY: 0
>>>    TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
>>> +  SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
>>> +  SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
>>> +  SSTATE_MAX_AGE: 14d
>>>  
>>>  default:
>>>    image: ghcr.io/siemens/kas/kas-isar:4.4
>>>  
>>> +.sstate-prepare:
>>> +  script:
>>> +    - kas checkout kas.yml
>>> +    - echo "=== Prepare for sstate at ${SSTATE_LOCATION} ==="
>>> +    - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
>>> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>>> +
>>> +.sstate-analyze:
>>> +  script:
>>> +    - echo "=== Analyze sstate differences with remote ${SSTATE_LOCATION} ==="
>>> +    - ./isar/scripts/isar-sstate analyze "build/sstate-cache" "${SSTATE_LOCATION}"
>>> +    - echo "=== Check for cacheability issues in build/sstate-cache ==="
>>> +    - ./isar/scripts/isar-sstate lint "build/sstate-cache"
>>> +          --sources-dir "${CI_PROJECT_DIR}"
>>> +          --build-dir   "${CI_PROJECT_DIR}/build"
>>> +          --pedantic
>>> +          --exit-code 0
>>> +
>>> +.sstate-upload:
>>> +  script:
>>> +    - echo "=== Upload sstate artifacts to ${SSTATE_LOCATION} ==="
>>> +    - ./isar/scripts/isar-sstate upload "build/sstate-cache" "${SSTATE_LOCATION}"
>>> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>>> +
>>>  .common-config:
>>> -  before_script:
>>> +  script:
>>>      - if [ -n "$ALT_DNS_SERVER" ]; then
>>>            sudo sh -c "echo 'nameserver $ALT_DNS_SERVER' > /etc/resolv.conf";
>>>        fi
>>> @@ -40,17 +67,22 @@ default:
>>>        fi
>>>  
>>>  .build:
>>> -  extends: .common-config
>>>    stage: build
>>> +  before_script:
>>> +    - !reference [.common-config, script]
>>> +    - !reference [.sstate-prepare, script]
>>>    script:
>>>      - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
>>>      - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
>>> -    - du -sh build/downloads/deb build/downloads/git build/downloads
>>> +    - du -ah -d1 build/downloads
>>>      - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
>>> +  after_script:
>>> +    - !reference [.sstate-analyze, script]
>>> +    - !reference [.sstate-upload, script]
>>>    cache:
>>> -    key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
>>> -    paths:
>>> -      - build/downloads
>>> +    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
>>> +      paths:
>>> +        - build/downloads
>>
>> Strictly spoken, this chance is not needed because we only have a single
>> cache entry. Anyway.
>>
>>>  
>>>  .build-qemu:
>>>    extends: .build
>>> @@ -59,8 +91,9 @@ default:
>>>      - if: '$ALL_QEMU_JOBS == "true"'
>>>  
>>>  .test:
>>> -  extends: .common-config
>>>    stage: test
>>> +  before_script:
>>> +    - !reference [.common-config, script]
>>>    script:
>>>      - scripts/install-lavacli.sh
>>>      - scripts/run-lava-tests.sh ${TARGET}
>>> diff --git a/opt-ci.yml b/opt-ci.yml
>>> index 01d5c07..e1466a0 100644
>>> --- a/opt-ci.yml
>>> +++ b/opt-ci.yml
>>> @@ -23,3 +23,7 @@ local_conf_header:
>>>      IMAGE_INSTALL:remove = "sshd-regen-keys"
>>>      IMAGE_INSTALL:remove = "expand-on-first-boot"
>>>      IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
>>> +
>>> +env:
>>> +  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
>>> +  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
>>
>> Thanks, applied. Let's see how it will behave.
>>
>> Jan
>>
> 
> Only saw now:
> 
> 2024-08-30 13:22:20 - INFO     - WARNING: xenomai-stable-3.0.x-r0 do_dpkg_build: Export of 'AWS_ACCESS_KEY_ID=[MASKED]' detected, please migrate to templates
> 2024-08-30 13:22:20 - INFO     - WARNING: xenomai-stable-3.0.x-r0 do_dpkg_build: Export of 'AWS_SECRET_ACCESS_KEY=[MASKED]' detected, please migrate to templates
> 
> (e.g. https://source.denx.de/Xenomai/xenomai-images/-/jobs/894592)
> 
> Is that an isar issue (but we are not that old), or are we rather doing 
> something wrong here with the export?
> 

We are we exporting these into the kas env, to bitback? They are only
relevant for the deployment script, and that runs outside of bitback.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

