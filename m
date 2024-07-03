Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE1181D0A
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024892; cv=fail; b=m+RVT8D7DQ8bQ1Wcm/U2/DrchNYMgMxQo5JOf0lfnxyDIM8KsKkmcuOvVfSgctk/4gMNEoT2qeLVph4agRblur4pSc7D30miRGqJARU3GJu8SleLaQUrJ/AcyOaq+3MtJ/mDKN6Peww7xtEkwURpni7cDb3BOOb2lM+bLYPV0fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024892; c=relaxed/simple;
	bh=m+QvpIN+l67TEAexCoELHDOwInRM2np4Umdnt+IVleQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aL56B3w4MYG1uYbu/Y989lSuejjOz/wrvsPYP3L8vzToe8+Cqtxo9UM6M7Q6UXc/XHmk2HPi0EjAA7ww2RW7yV8cNl8cvsQpavRfmYjzy8rcvySMZqTME3Pssc3sWm4Nqtwfs9aIm3XkpBi2ExWglpb9Mpm2HQEgFLe3dlHuADY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sdctWzh+; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sdctWzh+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aitwQL/KTraM8WKNC+VWrxTJd+Epl0UfZdbQo1Vsm4vqcNEcjFPHhWCwKC0J4mZIgXf0qBBhvwWE3S/qBHVo6EUGxTsCz4zrrF6JVtO8bXCbALo3GlbA53ayqXacO11oQ2fQCgpR2ouP4QZjYq9pOuZf3wkQ2HhZxxdN37CmWvV7cgJFBZq0iQ/BCNmKQSA591gmsUExzY3aUwrr8L7Jvdr8qKPVdXy7qP4P3CGGPUGtGuYkGn+N7ZJTKgYaqpSP+44V7//YihV8ZBiOCZq5wIGuZel+R0fnv3PKTE7XC2cK41i2qM+T5A48wDMyw6qDJki2JuNMgYBnmxPTTOXciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HduA8/19/AJ1ccJHSxTeX0jDwyafrEut2ZUA86bUlY=;
 b=DJpG9+tyTaZC6n3AL1nHpeWxaXWmjytUv5G30zY8rC6l/2P4H7H4ijMNmPLHI7lfLxWLqKdn3ZvmCmxMzxBPjxCk/awsTHdt90JM6BaIlotqMqOGnRMp2NMVyVVehrLCevAD4KkGAIvojvuG9/+dVDmZ8WwWe+lBE854wOUYOcqK54rGIHCWpT7LuE7OuWlysaWLS7y+gvRV2PMNBSm7cD7CWb59y9URoUotYvT2ZfjPGm3MjF/rI8cQaj/S47yHP1rFJNzUAaalyj1cE5bwXcn4/7OBk9fka5CYDDjxSVDrM0EZfsX65TfEiNOyWrp282APRxD5WlwOgq0b+JFVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HduA8/19/AJ1ccJHSxTeX0jDwyafrEut2ZUA86bUlY=;
 b=sdctWzh+Q+Cf4xGZJIaByZkh2+lSRr4bPmxKyDkkO4Ns1RJ6yhdMLoRIqGXtwIz4hXv1ovpC3UfyndMhtuxmALMStWbvko+VRVnNB4pxBz5RPJ0xNO6yk/35Jg3uXvaGvojJ/5zSNiMvcCy7k0j6aAZ5+GShpxAWl2zI5Sm7iIPKzbhxlRKtPepk0m3SlANyahCDQ7+8OBt8YMDmJVQopfzo2sOUcoJYGsZXE/psTKNT5D6vu6ZlZEi/tN/gs/bc5RkCcrPeeedez5G4RBJJDhK42CyK5dUXx+TK3dfgUQJLhStvi4fyvF2RB5NjAglGv11OTvWcBrtxfQfNkhF0TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5772.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 16:41:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 16:41:25 +0000
Message-ID: <5ede1870-d80c-45a5-bbf0-f7b09d517450@siemens.com>
Date: Wed, 3 Jul 2024 18:41:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ci: add LAVA integration support for Xenomai on
 RPi4
To: Yi Jiang <yi.jiang@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, quirin.gylstorff@siemens.com
References: <20240701070807.14465-1-yi.jiang@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240701070807.14465-1-yi.jiang@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 6661e5d3-8526-43b4-4cd5-08dc9b7efa79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkNJdVovRzArQ29OQUdGKytlM2JONmYvMTQvTVZtS0R2V1ZXaTcwVTMweWF5?=
 =?utf-8?B?cjBFeEtXem5POGNDQ1psSnBZaFZ0UDZVTFg1WjVtV0pUK210SkFqMDZVZlFt?=
 =?utf-8?B?S2ZWbVJCWlViRXlneFZFdEErQVRRR00rZElCdWxhV0kxWGhNazZGY3RGbTRY?=
 =?utf-8?B?Y250QXhaREloVUdZbDhqOFg5ZkdyNXE4M0w3UWVtWkJjVUtsaWJBblUrZ1hl?=
 =?utf-8?B?UVMremhsc0pEMmRjbU5OMVlCa0FoR0ZITGk4RkVNVGYzREFHeXJNa0ZNWGt5?=
 =?utf-8?B?Z2xxVytWQVVRNHRWVkFqSVVRV1ZwNXhCdXc4eFdZZ0hDbnArdEdIK2lJYzRh?=
 =?utf-8?B?SXZIT0hoZFNPQzdFbU94dExES25sQk5BeVI2cFhoRGhySFhFd3Rvbi90Uko4?=
 =?utf-8?B?SnpuVCthLzJFa21xTlJGWWlnVWltcHZVcmduaVFKR1RScHJEUHFiZXNtaXlj?=
 =?utf-8?B?SWYrckt1QUdBVHNpaXN6WkFwSkd5NmdDRi9rdnJ1NHhoK2QrZzQvVXRMNFVW?=
 =?utf-8?B?bHZXY3ErQXB3VXdVK1dFZTBVcVJHTFBUejk5OG9ZMXFYTEtYY0IrS2xPaHhE?=
 =?utf-8?B?OStCcXJtbks2V2Yxajg3Tk5pSGdMR2FteGhvY3lJRVNLdENQYW43SVR5SjQ5?=
 =?utf-8?B?emNUK3pYUmZDY0g4NitDZCtSV0pWV3JhazMwdTkxazBvLzVvTHMyWEZNbVFw?=
 =?utf-8?B?d1hGUkpZbENSdGVkK3NHZGtEd09GNlRnUDdxb0g4MTNIT2lzdDA3aEpZQ2dv?=
 =?utf-8?B?UDJQd1U2SEk3NzFxYlVpcEE3ZnVvTXdzZjlpWWZuMW9UajVydHlEb201K1cz?=
 =?utf-8?B?QmcwbThiNk1ONGlxOFZnK2ljS2JkWk1DQ3IrSjNoa0pGZFQrZnlwTWg2WXQ5?=
 =?utf-8?B?ZDBWNGNTWXhvSE1vNUZ3RWI1WEdWV3dXQjR2aWhGbUFMUEpQZ2ZJOVgyWDJk?=
 =?utf-8?B?bGt2ME9ET05FU1p5b1I4U01hWFFRQ1prNjR6QkhYTXg1djJTazRUVVBvTHk3?=
 =?utf-8?B?UUFDVjlRWVR4d2QwZXRIQ3JUUUdZak5LRklyODlacENxaXBpOWV4M2FWMjhu?=
 =?utf-8?B?SlZSYzA2OWFFdGZSOURLc0UwYUd4THl2ZlVjclgrVEpWa0FvVGRRd2xFZCt2?=
 =?utf-8?B?eFpRb0puelBGQVE3c1pURWZKb1dyTnRQTVgxNHFJZDR3bUNZaUdvekxhRW1k?=
 =?utf-8?B?cUd1QU5OcUNMN1gxQzJKWEhtaThHdXljaFAyZDFBZkUyQk1tbGEzU1hPMEFH?=
 =?utf-8?B?NjB0WHlDc01qWkFLbStTM2c5RnZrU2xoNS9VVkczdDZXQ3R0cGt6VUFQcmFu?=
 =?utf-8?B?U1U1d2hIbTB2VjNQZWNHaUVVSnFsYVBDaWZTWUpEUFc0aFcrYXZRbTN4TllK?=
 =?utf-8?B?UWV0bzBWRXVwQVQ3RDdDbUxDdHlCalhlYXhObzYrTm96aDZRdnk0aVlrWHUw?=
 =?utf-8?B?dENmK05OTEkwR2ExMHY2QkNoazZ2d3pzNEZMaWYxNTV6TGFxcXVKMXNzb3k4?=
 =?utf-8?B?SVdUV0tQTmZ5MzlvZWdvMmZwTXMvZGR3UVNFM1phc0pDczF5WWgwaSs0TWJN?=
 =?utf-8?B?eFZEWm0wWTFveHhPNUVBaFNOUEVMLys3c1krcGQzSTJyNDExUnBPM0NlN2VC?=
 =?utf-8?B?UkcwY2JBaDJ4L1JPV3BhS3ZjY1hCTGxKa3poKzVFUjNlcWtlN2hnOGNHRWV3?=
 =?utf-8?B?WTdtNWw3TnpjLzZIUlFwZGFZbEtuQVU3eFdrUHlJZVZseCtLSkRRaHpJWXdj?=
 =?utf-8?B?OVpGQXZ3RDZiNVhKenQrZ21acWg2OE1abU1IYktCRUtrZzZvMDUzRVhIU1Jm?=
 =?utf-8?B?ODNSQWVaQ3FYQmhHWGM1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWwyYU5jNS9ITmJyc3VCdkhDZ1I1RmdwRVk1OXZWR1VGSDg4UHh1RHdGbi9I?=
 =?utf-8?B?ZDROZ2lpQzBKOTR3amRFQ0dBTzNPZ0ZXSlFGY3dvR3dQV2EyME81c1Z1bzA2?=
 =?utf-8?B?bG5yOWd1MndSN0FSVFBFUnFrZjIrV1p0TGJ3d2VKYVdLNEdBOFBrRzErb3Ji?=
 =?utf-8?B?YkwzQUVVTFQrZ04vYTJhQXVad3d6L2RzTjloMkVHVE5tK0NEcFFjRTFnNlk0?=
 =?utf-8?B?T1p4Q1JBc3hXK2ttK1N3cmlKNXZNSzNPL1YwUDBZdk9KVDhPWDRjSXdLTzhp?=
 =?utf-8?B?MGtBRCtSV21XVTJZV0FjSGVuUVJaVXJFVU1oQm1nVm5rYjBUWWxHMCtteDY5?=
 =?utf-8?B?REgxdk1sM0tRWDhLVU05a2Y2UUd2WW5OV21aVGpNQ3VGRWtrWmZHVE5lcTZa?=
 =?utf-8?B?eWJrZzVEREVVS3h5Z2NPN0VvbWhMVzNYdGk1TEdpa3B6ZzJSN1EzUkcxbkVl?=
 =?utf-8?B?SGg3blEyYllueis3SXBtZlpuWXQ1QzVQRmFiZThCZU9ldmtyV3hLeGhHdmt4?=
 =?utf-8?B?QkE0T3dmMjdLUzArT3FmSkdhTjB2TG9EcXVnV0NmUU11WmxmN1Z0b3RYdmoz?=
 =?utf-8?B?Wks4YVF6Qm5ndDBnUkJGdE15bnJWbkFhYUliM3JXSDU4ZXg5UUVwR3dSeGpk?=
 =?utf-8?B?cFZPQkZ5L01RckllMEt5b3lZOVVmM3pSc0RpN0JsRVoyU0s3VHh0blBLaCtx?=
 =?utf-8?B?UHQ1Yis3b0hYRXNsN1lOWnY4d3B5dDdOajZjOUhJc0hFWTVSSzFtak05aHhu?=
 =?utf-8?B?VDlrRVYySitacXZ4M2psa0FsRDYrMU5LOGdQWlFPUHU1MThzWi9KWTY3VVBG?=
 =?utf-8?B?bU5nT09ZaDJIb0cxRDNQN045S0J3SmNFRzFpRnFBMGhsN3VCMDV0UExWK0Jl?=
 =?utf-8?B?aG5mbGg1UmEvZ3A2UG4ybjFWeU1lVHg4cXpEa3RFKy9zM2NNWjdsUzBMZ0Zn?=
 =?utf-8?B?dzgyZUxwc2dnVHEzcVg5VU1VdndRUEN5MkZoUnlDbUZUcUNDRXU4Q1ByeUFa?=
 =?utf-8?B?Ty9PbkdCeU15NVRLcDVKQnI2bGNLVS9nY0VMTzVGRVk4VS83UWhjMHE3b3Vj?=
 =?utf-8?B?dE1HMWVQOFAzekgwY2FKNE5kK3JKcWszaFFoSWl1V1N3NmZOTmNQYWtCc2Zr?=
 =?utf-8?B?ankzL1VNTlBPVVJtdktPUm1xOS9NNk5hYVJocG5uVVR4aU50aHgzbkpjeUY5?=
 =?utf-8?B?REs2TDFEejVxcWE3YnROdEgvMWFkbFdNY3FKTUNJOHhBMzYzSWFNa1pvL2dm?=
 =?utf-8?B?dm5JZmxvU3k3YTgxU25PYnJqRVY3WDB5cTFwZmxmRmE1bTZTS3lZZzA0ZXEr?=
 =?utf-8?B?blVvMEdiaUtmSldsK1VWdzJ6MEp3OThmd0RZUDFVdTRVcDdNeHJLeFV3cjJk?=
 =?utf-8?B?eXlHS0FlcmV6cmgvTk56SE9QbnNIOU92REhUS0FtbmFDUnE4aG5VOGdUQ1lw?=
 =?utf-8?B?ejE3NnIwcTdUVkYrSmRLNEFIUkNoSElGT3RVbDVUazJkWkhURSt6aitCRHg2?=
 =?utf-8?B?T2h3ODVlS24xcksrT2hJam01d2NKVlc0bDFDTHlxQmRxWUV2eThhOHJSL0hx?=
 =?utf-8?B?RTRsVHVmbDdRVEJjK2ZoWjhkYzBEWHMxSytYRGM1VGZkWUxObGlIbnJpdlFo?=
 =?utf-8?B?TE1ZNS9xMXQwQkg2R3BLN3ZWdmhkS3NDa2dFVXltOW1uQnN2dXRjQmJFOEpB?=
 =?utf-8?B?eEFRNDU5WFFwb0d4MFcxS1ROdC9DOWtLd0FMcVZOL3hpWXVkbmVueFJ3dFBl?=
 =?utf-8?B?enE0R2psdnJhR21OREw2cURFREk1VjFJUjIwbW95dnk4bWlNL0w3OEpUUE1Q?=
 =?utf-8?B?Y2ZEQWZBYnVHemdWWnlCUUErU0h0M0pBMmI4b1g4TXlmdjdNaEIxNTZNV1J3?=
 =?utf-8?B?cVFEMkNvMnFncUxqcXBueWt5bDJyQitHQW1acytPdEJFODBJV1VQcUVoWkI3?=
 =?utf-8?B?UnROZjhWTllqZHhuRGV3R2ljalh3RkdhVTBhQXo5S3VrSnJQeHdoWkdXU1B0?=
 =?utf-8?B?eTgrSWtVeTJROWxEaDcxYTRLYlkwa1hNOHBvTVV3d0Zzc1JGaWN5bWh6c3Bm?=
 =?utf-8?B?K0FNQnQwZnZHTWVWMFdaVU95SUt2WWdJc2tYeXpYOHJBSjZWVCtONUNlaldI?=
 =?utf-8?B?TURrY01UQklPcnJWRE9MZGdsQWxiajVITUk4OWp0UHFpWFFwR1hYYlloTkJo?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6661e5d3-8526-43b4-4cd5-08dc9b7efa79
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 16:41:25.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKIzqpBFcUqMHu8WySR/+447dyPXK+U0mh3OY/vFSncA/BWXmY+xpI+//9+5/xWxxgUZdwlIdgNT5hFWBs6Uaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5772

On 01.07.24 09:08, Yi Jiang wrote:
> Hi, all,
> 
> this patch series integrate RPi4 to the LAVA, which support Xenomai (kernel version 6.6) to be deployed on RPi4 remotely.
> 
> Changelog:
> v1 -> v2:
> - change the order of [PATCH 3/4] and [PATCH 4/4]
> - [PATCH v2 1/4]: add a new commit message to clarify that U-boot cannot take use of the local DTB file on the board, therefore we must provide the DTB for LAVA.
> - [PATCH v2 4/4]: remove rpi4 setup for kernel 5.10, 5,15, 6.1; remove hikey setup for kernel 6.6.
> 
> Best regards,
> Yi Jiang
> 
> Yi Jiang (4):
>   ci: specify the dtb file for rpi4 in machine conf
>   ci: add gitlab-ci-base configurations for rpi4
>   ci: add test job configurations for rpi4
>   ci: use rpi4 instead of hikey for kernel 6.6 deployment
> 
>  ci/gitlab-ci-base.yml       | 14 +++++++-
>  ci/kernel_6_6.yml           | 10 +++---
>  conf/machine/rpi4.conf      |  2 ++
>  tests/jobs/xenomai-rpi4.yml | 72 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 92 insertions(+), 6 deletions(-)
>  create mode 100644 tests/jobs/xenomai-rpi4.yml
> 

Thanks, all applied, and the pipeline worked fine (for this device, we
have an unrelated regression on the beaglebone right now).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

