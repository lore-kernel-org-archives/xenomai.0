Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F9B22F11
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310847; cv=fail; b=rg2+K7dS6kZf+Lfi0bpl7np7sri+VF9Vqf1+IxhHJSbUuOI5pr9l4AdgsJQlS/yrZl/3mkZsChcwjejn3ddZkGCBv/45/fUET+DfZGRS5ZCMReImz1g6Kv95G7QcXlCKg3nqekk7REOGyCpN/snXYNnVPtQibX4BEIBj/5BRLR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310847; c=relaxed/simple;
	bh=FzZEkdpuQNX7ilLR5DLlAuGPALrp8MyXoP/DKOpYkOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QeiKwomUC84PC6FA5oF99lZydp2Hk3OJuARbdLFomXhrtqvxvEL28cUWIq5EKHL2tgnLyx5bTC5cNFAkRP9yjoLTXniTA+uQO6JK4HQvl0QnPQmL9MSsw1isaoljGw5STU8IoexKiT7y098106+6akWdOZkBqAr0LlMC8U84oO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Cp8WGwIM; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Cp8WGwIM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4wmarn6+wr02siD30WW9MfYRu2GJfQmZrvxLGg/M202iOZQoxImvVqzJO7K8oQRYgxhNlsPfLq6ATbMN9pylkC+2tdLtPqghqz4FDxNm/BS/MQ96hQ2LzlliZVsWtiR+LupY/2M1en2yE0u6rWpLmbFAfrrrb4jo0MnGMnyYvkUsKsyRuCBopjsIcdl9OiFqQFQh+S3Mi9k9rm1ESj2FrFxP4I4trRQ+kVsvzP6e3uHzpyeJ66eR7E1D4cHcMVJz0qsF1ebnGTltnwiRVa+6yoUiVEfei0BR6rrFPqaJo1EiJF9DttalWKlxxmz2lOC1Th0LEiJqgo0WoXGGelzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiwbztOtD5Jhj1MmrkMyTTsuiDM29lfgcH4tB6+D/y4=;
 b=IjLRhs0BmUEw/7qTSCvmT6QXCrzuo/78e/NkjoRXLxE6nKJZJclIrViNwoUJOq2TaOPpQxfpg0HTVrDy7xNV3xafAsVuAIFqtnWIJmLj2OPtl85os2ikzciFcQuhf6mhEjWN6CGun6f+CBvzBU6PnMH/BUwAUXsN9LOmPdElfiPltcFHQmqk/I/oUvPfDLF8/XbGkdBqJnnDu8MM4ZTxbB6VPH9ZIQCS0mk+fLs1G9+0pGJRx/o5UkxtFI4gLPsNOsJiKDXX5zYQpXNMyYMBAV/ruUf78vUy3RqxWZ5dED+Rt81BBU9niRiTBgvv5w9V3xsHCJVOx2SvGrqwaBTqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiwbztOtD5Jhj1MmrkMyTTsuiDM29lfgcH4tB6+D/y4=;
 b=Cp8WGwIMK0KdslMpea9Lp5fiicXEOU+MZuAhj386ge2MVoxjsYQILZjCLF4hBRakJW2LanRczHn+ZC0vMq/5HApkByF8gpyQnHbBKrXfUZ5oHnCPB23Whzq141w58biR2YAQyBq5JTX+pR5/96HSPyuHZf3eCP02bp0qY6iG/fn78ljNmbWcN8RXf76KWzb+hZtH8lPawYKBQrRQqdsXzDm7zZhgmaYu6t9L6TlZijY2jkm+H0ps4ziqhTrmUa8kCxUYNaERFInOI2JP+ERgZ+sX00VMMfYxh7spWLFAwxG9wtoRcLLmCdOzUrv5OU/J1l+ISm4UdW54OLvnfJDd2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7121.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:458::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 17:00:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 17:00:41 +0000
Message-ID: <8545b508-27d7-4e47-b981-6814bd56da89@siemens.com>
Date: Tue, 21 May 2024 19:00:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] driver/gpio: Take timestamp according to used clock
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20240416085911.62073-1-clara.kowalsky@siemens.com>
 <20240416085911.62073-6-clara.kowalsky@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240416085911.62073-6-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 660a1918-137a-4980-6bde-08dc79b78c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW1veGRXK2RTVFA0WTlDRndhV0dTeDJGdG5CaTNBVnRmRi9GK1NEaFM1Q2xn?=
 =?utf-8?B?bTh3blBFMURKdWVxZWpBM1E3SVVTQldmakl1K1Y2QTIwdDZmUlE4cHptS0dE?=
 =?utf-8?B?UG5ycUFTMS85SWtZYUlXM0dlc3k3b0tXWHN3SWJKblh2MXkzRmdBQmJhU1ow?=
 =?utf-8?B?WVJvMUU1U01Jd2wrSllFRGFkREpSUnRjQyszZ2NYVEwyRzdnd24rdllvMjNT?=
 =?utf-8?B?ZHZYdVRaTGk2dk1Qd2cwOEUwcElUNHNTWW04ZE4wMkkzQmthOXhxOVFxS3h6?=
 =?utf-8?B?WVV4aHdxZEdPMWJxUEs2SEx0ZGtMdUpxUWR4Zmx5NXZ1c0l0SXV6TlowWm1Y?=
 =?utf-8?B?a2VrcEZ0azlwaUdGSWpsZ3BGc1R3YnE3S3BFQWJ2U3hsL0R6TnZLZ2JVYy9W?=
 =?utf-8?B?SGZPMEtMRGpYVWpFS2tDSkhIU2hPNXFERzFaamIvVmt6MzFZRmNZZXA4YjQv?=
 =?utf-8?B?ZUdrM3lqYXRTN3FYTVc1N3B3Z29tbStaUEV4V2hZak1FK2RRZTM4OWRLYTF6?=
 =?utf-8?B?RDRzM1NZR0U1QW1hbG9veHNFcFBNanE0YTZwU25rSWpwZjg1TXZrcUduQS9F?=
 =?utf-8?B?cGk2RlhBcFBXVjU4VVNrZGZUU2dLQzhrVi9YMkRGQnVkT1Y2RUVIODZPSVZJ?=
 =?utf-8?B?TEJRV1hibk1GRXB3RUtuMWZ2UXVFWUpFUzhUKzArQVluTThKSm5aWGpUaWFh?=
 =?utf-8?B?ZDF1TFlmMEp2dkpOdTU3d3pOTmJWUmxGczdQOThaZEhwd010NjBqZnRieXcv?=
 =?utf-8?B?SkhsZ3l6TUE5V3BodjZYTEE3TnkyOEg0c3RqZkg5N0FNYmN0dFQra0ZDdUR2?=
 =?utf-8?B?b2R4SnREK3BGRXc3MTQvTEFqT3BXeVovbFVDUTYxOG5Dazg4NGorWU5ObGZK?=
 =?utf-8?B?ejVyMkZQYTVjeS9ZaklhZ1lZcDdSbUlESWpxL2JNZXI0bjUwaGMxdEVNdjFC?=
 =?utf-8?B?Z0tXdHdaM3V3SGE1bk1TSXpCc1lMdkQ0N3JTdmRKQWk2STUwOGhtc3MxZjZB?=
 =?utf-8?B?dWhvcG9IRER1Q1ZuV25xd2s1QnhOY3daVmh4K29PWktMQUFDYU4rYzFMWVRX?=
 =?utf-8?B?MjBGU25sc1lXYlovYXl2TVV6TlJKMG1JRUY3OWpFamYwTTJOcnBPMWp5UVVy?=
 =?utf-8?B?MVA0NmlSVVdUbmRKb1FwbVNsZUM2dUh4dFkvOXF1QVVHSzVZZElKdXhMMnpZ?=
 =?utf-8?B?OG9oTk5IdFdocDZFL3BYRlBsRHZOdUlDSnlMVTBISWpSSFNwUmtDaTlaclE3?=
 =?utf-8?B?aHllYXcxS3o4bEJiaGlkT2l0OHpvR3ROWk5EMFdLSjUvY21OT2NpOVBZTEti?=
 =?utf-8?B?dnJ4T1J3ZmZIa2xBVHVSTnhmVmkrb0FXeVF3MDBYN1AySlgyUDBUVjU2WFJw?=
 =?utf-8?B?NnBxVldHQ1F5aE5qZVhUQkxucW1WczdIRno4RUMxWC93cWVWSWkwVlNXR2N5?=
 =?utf-8?B?MXc1eGxRenpISkhiNTlyeTNRZHZDeGJucjEzQUxRQjkxelhjckU3aGVvVG5z?=
 =?utf-8?B?R2xnRXVaZldZbDRxemtMV0FtczJvMUg4dEV3WjgwQlpIaEU1TWdqRUNQdlg2?=
 =?utf-8?B?dVN5MTNlcUhCT3lZMmxSdFYwZ2syZG5STG5JcGxnKzRSU2lqY3hXRmZPQjhJ?=
 =?utf-8?B?cUI5a1FaOWNzSGZVUFhMejVTRmhjcU1vWXlxRE93WjRmN3BibHZ6b08zb2dp?=
 =?utf-8?B?Y3dMMnRCQWJpSnlhdTFwcUt2WEkyK091bWFTWjNRZW9mQnMraUFwVzRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGd0RzE5ODhwQnY5VnRZWWo4NENmYXRjemZnNXdyam1kMS90YVNQTHE5N1Zs?=
 =?utf-8?B?dTVJeFJTS0k3UTJmT0VRb3Z6WGY3M28rWERxU21aNmhRYVJqR2dDYVJPNE9z?=
 =?utf-8?B?czNXUDR6T0FlQ2JCQnlob3dacUswNVQ4UElsYnJuRmRTcUk5cy9uZWhTNHVD?=
 =?utf-8?B?Z1NuZXMxR3BsbC9wOXkvQmNGY3pLNnY0MXFsSlZqUzdQbUFFV0lvUktWNDRx?=
 =?utf-8?B?YnpjVWZSRWxadVpmS1JydjRFVnBhbXlZdXdlNjVUUU9SaGQ5RVZ0NWIrb1Bi?=
 =?utf-8?B?a2tXdTZqNTJ2T25uTDdHZ2dGRE9BSUUveDNrRHJBSFNkVm44amU4ajNDV0Z4?=
 =?utf-8?B?NXNMMndHSzB2b2Y1NXJBZm92Tm0vT3oxbmRrVUUxZEJNa3dUQlE2LzVkbTN1?=
 =?utf-8?B?QWFCNjVsQ2F2bWxvYWh3Vm9SeXJNcjJJZ1gzd0RsNUZkdFhFSk1kWVk2YXdR?=
 =?utf-8?B?Z0dTT2V4SEZvREVTVzRiMnBZZ0Myci9ieVlmT3lNQ1NHN2hwdTNaYU92T3RP?=
 =?utf-8?B?MEs5MlhDc0VMRkxVZmJSblEwMXlodXNROWRSR3F1VS9nWnpNaDdlRllEelhD?=
 =?utf-8?B?dDdZV3ZnOVhLOTFPUnFpNzNOM1h3Mzlmb29nZHZ5QkRJbXhvT2ZiaXEvdXl1?=
 =?utf-8?B?ejRyc25UQzQ1R2dqdTlYeDQ0ZnYwZldkV3ZlTmFxUzlDTWRrbzNXZTNqSjRn?=
 =?utf-8?B?a0RHSVJqbWlVaDAxdXNFZ2RwcVJtUGQycDdnRktjQ1lzSUdKR25zWEFDL3Bi?=
 =?utf-8?B?bVNzbXd5OGxWVjh5TFMwRWdIZmJ4Vm1aUGRzemhsWVhCUExFV1h3ekpYZFFZ?=
 =?utf-8?B?bXNTYkM3Qm9BZ1QzMG9UMCtCd2pLS1RhOUJiU08yczNhRHA0YzZlSlNmVjB5?=
 =?utf-8?B?MVdqcytMbG9Yb3ZyQVNXNHRFc0ZZaGF3aENacG9Sc3Q5L0xHa1plRUEyaFFj?=
 =?utf-8?B?TUtvWmNodzM1eDh0VEhVeHIrNGRwci85VUZqNHpLZCtYN08rdTZmSlBLZTl4?=
 =?utf-8?B?ZU1IT2NNbktmWWlMT2FkRGEvclpmT2MzZEdDb3RwdVEzWk5RSWttaGYranhi?=
 =?utf-8?B?a3lWb3lSK3N1S1lNNGE0dGtXaERLSldRS0k1VE9BRE1QcVJBcTJ5eW42TERm?=
 =?utf-8?B?aThLUkdBVjJ5L1FCOGxLOWxPa3VvVzIzcW9IaCtBVHFmTmFBSkpLY3BUcXdM?=
 =?utf-8?B?bWlYWFNoaEdpVTlIZ1dPMXJKZ2krT1h0UFhQS3FCQ0ZjOTlIbjlwcDN6aUNX?=
 =?utf-8?B?T1VZdGhYMktjbURxQ2RtN0kzcTNyOVNHZ1FzdER0L01GYlVMZkVqdE9QWFl1?=
 =?utf-8?B?SGV0VjFrWlpVVDc2dElwTXdqMUpqRFQ2RkFGY2tjbkdQZEJqMjRLa3B6M2hW?=
 =?utf-8?B?bytvRXpnNXBwbWV1QWlVUlhLcWN0d290am9aYklUb2MyTGhVSlZ5TUNJUTUw?=
 =?utf-8?B?MmxBVEQ5WFJKQXp4OWRSVzJFVnJYbFRha0VtYWtHbjRhTzZFOG5uUVc5dzEv?=
 =?utf-8?B?UHQzMldqMUYrc2NyQXdnVFIxTisyMWx1N0gvNWNtTVVBMEVoUXJyNWJPREpD?=
 =?utf-8?B?TnNRYWcxZ01PcFBvRm5IcVBZdXdqeUt3Y2o4cmZWMVZPR1pSc2N0Tlk3cStI?=
 =?utf-8?B?Z1o2MjRDb2V1NXd5amNQeGhMZVBxT2VDRTRFZVE0RkFoRjJVL05XS3BGVndQ?=
 =?utf-8?B?N3lqS2VYNnQwdUFSOW1GR0pmVzR0T3FOYXVERW5EQ3FOeHI1V2RFNng4UnJr?=
 =?utf-8?B?eG1DK09HKzRqR1U2b2tVSjk4SFN6T3dwVHlNY2ZNMDNydzRSUHZzT2N1VGc3?=
 =?utf-8?B?K2pBWk5PYWhQSFlJeXlzcHBReVF5SHBGN3VDcWZJVU9wcTAzaTUyd2JDZ2dO?=
 =?utf-8?B?RDN6dndra2pscXJnWDhMWlVRVW94WVpmVlZKeE9Yb3hqTEozRW9IU3NGOHAv?=
 =?utf-8?B?ZklDTTdwYmxTbnd2K3gzdWV5T2pRMFd5dFpGbXJPS01TOGg1WmlyTGltK0NJ?=
 =?utf-8?B?TG54WWxwZWtpM2FWR05JRlp6K3VKL1ltajBvRkZLLzNvZUtmaGplYU0rQVdG?=
 =?utf-8?B?TWU3VCtMcVVXSWFicjRtdFJENzZpdXVIcnFaMVh2ZVBIejd4cit3WElKM21W?=
 =?utf-8?Q?xSuxCjPj59wHqXTYFDo8Mlk2L?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660a1918-137a-4980-6bde-08dc79b78c01
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:00:41.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XiVxmQfmqk6afxxwC4mW0eRQgzouYRCjcMfwODQZ3jjoJwmaeqSgdCCynRp70c25Ehdun4AY64b/H9iEXmQpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7121

On 16.04.24 10:59, Clara Kowalsky wrote:
> The log of the loopback device shows that there are problems in the
> clock reading and therefore in the diff calculation of the timestamps:
> 
> ----rt task, gpio loop, test run----
> index: 0, inner_diff:       12, outer_diff:       25
> index: 1, inner_diff: 18446744073699568, outer_diff:        9
> index: 2, inner_diff:        5, outer_diff:       13
> index: 3, inner_diff: 18446744073699543, outer_diff:        8
> index: 4, inner_diff:        4, outer_diff:       12
> index: 5, inner_diff: 18446744073699553, outer_diff:        8
> 
> Inner_diff, the difference between gpio_write (write time) and
> rdo.timestamp (read time), should always be positive. However, as the
> selected clock (monotonic or realtime) is not correctly used for
> determining rdo.timestamp, the case occurs that rdo.timestamp is smaller
> than gpio_write, resulting in a negative difference and in an overflow.
> 
> To fix this, the rdo.timestamp is correctly read from selected clock,
> either monotonic or realtime clock.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  kernel/drivers/gpio/gpio-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
> index e41c64050..8ab9ae43e 100644
> --- a/kernel/drivers/gpio/gpio-core.c
> +++ b/kernel/drivers/gpio/gpio-core.c
> @@ -233,8 +233,9 @@ static ssize_t gpio_pin_read_rt(struct rtdm_fd *fd,
>  			ret = rtdm_event_wait(&pin->event);
>  			if (ret)
>  				return ret;
> -			rdo.timestamp = pin->timestamp;
> -		} else if (pin->monotonic_timestamp) {
> +		}
> +
> +		if (pin->monotonic_timestamp) {
>  			rdo.timestamp = rtdm_clock_read_monotonic();
>  		} else {
>  			rdo.timestamp = rtdm_clock_read();

This looks wrong. Can you explain why gpio_pin_interrupt and
rtdm_gpiochip_post_event select the wrong clock? Or do we rather see
some overflow here so that pin->timestamp here is no longer in sync with
its sampling in those waking functions?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

