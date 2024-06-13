Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394F12DD94
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292661; cv=fail; b=nfJTHu0lFYgdDx0IUxdyg4onmQa4HbGdqjZ6XtM0yRGt0wFsUcrcoVPzNR5PxR8Qdu4n4JkjYCPRGWoript/tL6sJjJAq/0lI92rFaMPKc6bjvrWc8HvImPnRVtmcb4ZGhuH5J6WfFf4x91FHCdJnpMe+uSejb+l5uZpb5tM1hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292661; c=relaxed/simple;
	bh=Idp2Ef3u+AC7f8NZn4CaDmOaneT64ZYN2dJh55cQc5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lRdyNJKBL7j0jZJKQXjKMlMINTxMe2/3J8o1Yk6eS3lmnovK/R3h/X73EIg8SYsraUbS7ZUZ3YrAR69OPDLjrrhHehEAX+xBjiZS4WeyHSPswzporWYLqgF/KMAwfCHiX+nIWLd/+Xut8nmEC+aIbryxgDyKlpyvZBSXDnLJwbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RbnjsaDi; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RbnjsaDi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHqEa/0t4NxhmfW2VTYHp6wd9Dbj4nFHwdhU6SCPGqEItUy0vRLRh7HU2djPexC3eHtkr6+uNHg8X4oeXwCLh5VW+fdC04nVx8xTFW7qH9YH67lRjm/703T/U/Yc3yUIDO8v+QifbJAahlIAvEACNI4/UMwiBaVIRuJJg5WWjZ6zL6S3UV8c5+dUfJzDTRiWY4ajVYogPe26cUZ9e7o3l21fk77nOvT1yxiVugZyXcfHszr7K/+4AecGdXm7mbX6yrpD5Uy4Ydga5ka/dN4AQxfTmyqALi1+FjUiv78tfzdVhqfwJZYjFkefvF0YE4ahmYfTIEdX9JG0Vvi4MxPgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=818Lpr56yNyPv8wHxg5ZR5G/NSQu6dP/VWFqBiC+HrM=;
 b=ZEoxYm8C1ABrYYi844k005axe/gmdSTW+yW+MFMdsJyQEpg14UL08C3adaUYvmFJKNSqzmYly8XkzDkhp5D3oY16NZEUnmoQ1JAyiOz75PXCbhwqm+6WRHeIbhaLt/dcb4bMG59dblThV7fk68xR//lZ519gSC/LJ5YNJ0Mmh96CrFow8C0nrRdw2/tJZIKyH2NxfmvqTgTekULTowwwG9sLQCp4RhOP84r3vBahJH6yxYhfCge+0PTYW5rKjwxCwcGVA0TD5ecr1tUNdh+8rcA7j08FJQoTLdlj2zCWBWPz6BjwRjqpUy5OuXoLo7Hsv40hjpIZ5+M+G+4ngjr/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=818Lpr56yNyPv8wHxg5ZR5G/NSQu6dP/VWFqBiC+HrM=;
 b=RbnjsaDiep1jJdrkkreWMryxn9TTQaArlRPwQFT5VcPra/9gaEjx0gw5pzS8FxnSQMNH3rgRq4kzRJ7inD8vQ1i/lCLdsAUiofhAz+Q5cyNrC9gmC+qehCcW2OZkIHgLebXv5NliBn0QuxJ8emH/y6AcmVnLeDxQcQnGMBq19kBVWMK3T69J3+V3QMR+dloWTRzpNDsA70XaZTABCdPME+dhEDtRhHJiipExdXK8S2lSw6yYfJNYBZr2XN3eER85tpdQLZGE9Fv2m9OvISiRZz0vn49PkZwOCZML+eIFUiOwCHH7PayCZvoBHA2gm1zfeYIK+BrMuaAMmuZoUQt/3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3730.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 15:30:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 15:30:53 +0000
Message-ID: <dbe94d71-1fdf-41d5-bc84-76923a66bc2a@siemens.com>
Date: Thu, 13 Jun 2024 17:30:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
To: Philippe Gerum <rpm@xenomai.org>,
 Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87jzisrkfo.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3730:EE_
X-MS-Office365-Filtering-Correlation-Id: 730b42b9-14c6-40ab-cde3-08dc8bbdd02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnpyOUdIQVdCZTYwaW0yaTlBQ1ZIRldOR2MwYXVYeG9FVVJjZkNSeDVWWGlM?=
 =?utf-8?B?K3ptRlhRTEFpbHpwMWlWS0xYTi9nVDNReE15eHA2ci9GWjFxUjNQVU9lb000?=
 =?utf-8?B?b25Da0xLUTZld0JCYkJGdjZBeFlLdldZYXVVQytsNi9Ic2Jlck9uSkJRdzQx?=
 =?utf-8?B?MDhnSFJrUkRoNzJiUC9ycHFlOTVJVUdpekVaMnZRZEJKUmd3dFpxSytoM1Rx?=
 =?utf-8?B?TXBBS2R1QW9VWFk1alRrcDVRRDYrWGZ2VlZzeEhjeklOYjl3SlNJQnJkNUcw?=
 =?utf-8?B?WGlQR01vbENSdmFXczlNdXZqbFdrdGFIbWVXdGJhVVlnL0ozajEreWJpU2ti?=
 =?utf-8?B?dkoycys4b2ZDNWhmOWZlK3hmb3ltR0JQUlJCR3pIOTNXSnVMQ09zRG1Gbkxt?=
 =?utf-8?B?b0JsRWcwSnlENnVwUjBEeGgrb29tOEVYUTlGY0RCSk1xTnowV3dHWk5aU2d2?=
 =?utf-8?B?T01BM0hrS1g2eVlvWVpGWEU0aUQyLzhtU3h6NktWazcySDRmY1NDV2IzZGFI?=
 =?utf-8?B?d293TDgrV1V4b3hXNlV6dVlTaXZBZUM2TTB3RlpNa1VWNitkQm9SaGlsbGRy?=
 =?utf-8?B?cm1Xd01EWi9HTVgyNzhaTk43cnRjZHhQVVlaS3k4cEEwUlJaNUo0Q1lnMDc5?=
 =?utf-8?B?eFUyc0xianRmUWwrVzE0S1Ftd0UyZ3N6bDN0dm9RNUM1cWdJQ2VVc2R6WW5M?=
 =?utf-8?B?V0svTWVlWjVIQVJxYzZ4N09JUXJZcENZeGJYL0gxZW1FTVJkcCtTQlJqeTNz?=
 =?utf-8?B?aHlGSnpLN3h5Tys0cFdHTXRFcHVYMFRxRHE1emFFZmZpZjVnNGF6OWxYQVha?=
 =?utf-8?B?KzUrSFRCTUlsYWhISTc2ZEt0SitQWDNzRFQzV0Z3a3lSRVRHTWlhbExja1Rj?=
 =?utf-8?B?RVNnTWg0d2I2MlFCSWpXR2xIQjU1RmpiK3oydTQ0WWtycEl6Uk1nUkRmc3FU?=
 =?utf-8?B?bHZWWHk3azU2VVNKaFhhZUFQSTZYbTV0WHZnZDZnTi9ObGxReHJGL0tUcjBv?=
 =?utf-8?B?MDVGUmZiZ045czR3M0FVeWxSWENiVms5ZnJGT3dXdEFOOGJsWUY1OS96Y1gv?=
 =?utf-8?B?M2pzalh4U2xaaGVML0pDQkhqNGhycS9OL2dXYjc4UjBvNnBXMFF1c1Zzendm?=
 =?utf-8?B?Z21YTUhkQ3VEbnZxQnVUTGxMMExYSzQ4NU9QUU9KVndFZHhXYkx1R3l2N21r?=
 =?utf-8?B?NzBUYUp3NXNEZk5ta1JCamsrT2p4SXZKcU5pVGVWMDJKMUdLLzNRWDdEdXVj?=
 =?utf-8?B?ck4rRDZ0ZXArU1IrNW5hNWlmMHJoZ0VpRm9aSERjQ0sycFhyQXNtTTZaVGMy?=
 =?utf-8?B?bjBRdlB6dlJrVTg4eC9yMklVb3Jmb09sWlRzUDFmT3pyQU5DOUhGb1dVTVJh?=
 =?utf-8?B?dVp1SFhlQi9HZ2kvRjZjVjc3eGFrZXAxNnp6YjJ6VC92ZEpGNk56MjhEa0Ru?=
 =?utf-8?B?aEtxdWRlbXJlT0lCUXh6UTVLRnNwR0NDYS9Qcm44Rk9Wb2ZPUUthSFNGWnJT?=
 =?utf-8?B?aThmNEsxaU8xUU1Jd1YzQ0FOcFFLY3dadnJVNStpbS9LY2pqY3dOcUplZ20z?=
 =?utf-8?B?aHRmNVMwRlFBeFNoS1NEZEVXL1BjSGIwOFBRRzRTTHlmRks2cm5sWUwzcnRM?=
 =?utf-8?B?eFB6QnN5YTBuZjFzQVd0SHV0QUxRdUs5c2J4V0pnU3BYS3NmMENrU3E2dVF1?=
 =?utf-8?B?bG83bUhSbkl4L3d1VjZTMUdjZlBWcEY2R0RwaEFzT0cyb2sxWHZqK2kzMlNY?=
 =?utf-8?Q?hJBNdjG4KzEEKDy/omW1AlrPLHNpfWBRneklYJQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjI0ZHZQTng4cVBOU0pIK3k2aUFSbjAvRWhFbmVhWit2bWpjZDcyQ0g0cis4?=
 =?utf-8?B?Y3hrTzlxUW9rZkI4WjVEQ04zZTdxUU5vNDU2dEZySmFCbXk5Rmc0V0RGSldy?=
 =?utf-8?B?M1h3eHZJQXNpWlYvVjJ5M24xdTh0NVpmRDFLWnVualNJZm9ra2laWHdCUUVP?=
 =?utf-8?B?TzZxV2JvRXhMTFdQRllPYTNTQVlFS3dHaGh1cUV4WkRoL1pObzJmYUtIdHNk?=
 =?utf-8?B?UFVVWWEzcUo3dDNqbG9PSXdFRVRnajVvenhUN0VSRUU2aUJkT21pRms2dUg1?=
 =?utf-8?B?dHlXY29MeExvVW15WDV1VWlyUndaMVUxaEUya3EwWmpaUWhjR3hGN2swN0Zn?=
 =?utf-8?B?WE9UNXhtdnFJMVVJdTZoWjY1dnZ5VE5ybkY2WWlON2MrU2lQbmdSQmZueStn?=
 =?utf-8?B?clpNMWRYanB5UElCVW5KTjRVcXg2Nlc5cG5ydkJNM3NBdnYxcEJGRHRxN2ZV?=
 =?utf-8?B?SkR0dEJWa1NOazRVbkhDTGI2dEVGVmVSM3YwNlJpdTJmTE4rd2NjbkVhZnR1?=
 =?utf-8?B?NzFKZWw4WkdKQ3BKZGt5djQ4TkdkdUQwcjErVFhLVThEcS9XV3FSS0ZTWjhj?=
 =?utf-8?B?emtrNEo3ZUlpQlRLR3ZqQksrRGgyZFlMYTk0NEtXNE80LzY4TVRXQ3ZWOWov?=
 =?utf-8?B?K1RUaWU3Z1RMcXQ4eXlaVmxsWld1Z2x5L0w3RkRHRnhSem9hMnRvZ1dhb3ZE?=
 =?utf-8?B?RUlxMEltdFJ0dllWREdMVEt2S3dlZUpubHJ3S0hCVm51aTM3Sk1CaFA4Mit2?=
 =?utf-8?B?dDVMWlEybXI3K1BHaHEyQlA0ZytacWVielN5eXgycURwcDdnQmp2a0xqNVJ4?=
 =?utf-8?B?cFpRWExOOTNIb0w2OGQzQ1lBN09wWnJod1lxK2UvdnVMR2UybDJ3NUJwdnhD?=
 =?utf-8?B?MmQzaXpDRDErbXFvZ2I1UkVtd2QyTVhvOUZ3aU82UHhzelUyT3pSdmNFeHQ2?=
 =?utf-8?B?SWZpdWxxSkVFZkM4bWdoRUVraFlOQjkwV1FhUWtReS9LdVZqMDgyL0h4bVIx?=
 =?utf-8?B?SVluc3ZRdjRBRnNoc1VQS3lmMzdKeFd1dERrS3pSNEpES1dCdktHT25DRk1G?=
 =?utf-8?B?OGRNbVF6Sm40TkxCVHBLYkF5NHExaTRDODJtbE9ML0oxZThaRExjeGhuMDRo?=
 =?utf-8?B?QjRTY3Iybi9XVkcyRXhpZ1ZUeXpTUDBjTDFqME9nL3hHb0JIL0dsU204QnBi?=
 =?utf-8?B?UTU3aE0zMmZDb2ZPOUk1S2FCZEFaZ2Nkbk81YzdoaldaQWhOVXRDZEx4cDFw?=
 =?utf-8?B?SExYR2czS3V5Tk1DNDh0N0ovY3ozcUxZL3RRajlZTXB2UzZ6bC82RWR6VVFH?=
 =?utf-8?B?cm5SVWxFdTQvZjhvSlMyaG5vNXRlVXdsRExIcjJXN0FNQ0lkbFhyK0ZUcjBl?=
 =?utf-8?B?UlAzS2ErYmhncm94dU5DdHV2Q2VnRXNPTm9XUUdqUURUS3dqSlVlWENWTWEx?=
 =?utf-8?B?bmtoVkQ1b2JoeHdiNEk1ekZ4dWVmRHdPQ2srM2dvWng1Y2F2TVdiZDFHUHYr?=
 =?utf-8?B?MUVhZlZTUE5IVWE0WlA5cWlRa2xJd1hUcjRtWlFxZThSaHZFays4M3BtSUF6?=
 =?utf-8?B?ZnpwQXpMYnVBZGdIc3JqMUJUNlg5ZWNPMFNrVzMyZmszVGRZUHJQeHJ3K2pG?=
 =?utf-8?B?SFI0MUxnaWt3cnpSTjRYN0s1MmkwV01yYm53UnViVStZbGtKSlJML3IzdHp4?=
 =?utf-8?B?T21udVdqVWkxVHVncU9FWHhtYVNmM3BvcGFTTVVnMk1tM0FhTFI4eEFBZUgz?=
 =?utf-8?B?Ym40OTJENUNka3pvTkVVQkwwSTlhVnFJQmxTb1Q3V1YwZG5kVFFFYjM0VTNG?=
 =?utf-8?B?eFZEZW5VdWNkN2FROUJDMmNubDExaW5vdDJsZE4zNEQ4RGVOQ3YySEVPVzlD?=
 =?utf-8?B?MUVYN1I3ditXQ3ZCdGJmN0sxQUpMNmQyUkR0VG1tQjVDVmVZaUpWcEdXSHVw?=
 =?utf-8?B?WWtIY21LN2QzOTFFVVVUMGxVc1RGbm1wZ1NIY2psSy9EcXFUVFh3cm5MV2pQ?=
 =?utf-8?B?emd4Ni90ei8zaTF6Uzh2R3c0azdScENVdDFNYWR0VlF4Qy9wVVVhNVNma2g4?=
 =?utf-8?B?S0VDV2xCYjJhbUk2bE5oR2JGR3ppSEl1TnM3a29zMWF6QTVlTEhWRDh2RVBW?=
 =?utf-8?Q?Ri4ck+ZrEW/nI026utBouKhbW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730b42b9-14c6-40ab-cde3-08dc8bbdd02b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:30:53.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxzp9Sf7RmUuirEaR8QJ2phw+UXVDtmyxcyVVvBU9nufEa2Ugx4QD7fXTsom8sJBLaiWOfo6tRLekXsbJ2/n0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3730

On 13.06.24 16:16, Philippe Gerum wrote:
> 
> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
> 
>> Stress evl with a load command while running the tests. The load command
>> may be set to an empty string to run tests without stressing the system.
>>
>> To align with xeno-test the -l command line argument was used for the load
>> command. Listing of the unittests can now be done with --list and --List.
>>
> 
> Nak. Compat with xeno-test is definitely not a requirement if this means
> breaking the existing evl command line usage. Besides, --List looks
> strange as an option. Let's pick a different option for the load command
> instead.
> 
>> The load command is moved to its own process group to allow a clean
>> teardown of the load process with all its subprocesses.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>  utils/evl-test | 71 +++++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 61 insertions(+), 10 deletions(-)
>>
>> diff --git a/utils/evl-test b/utils/evl-test
>> index 5c1c3da..fb85f69 100644
>> --- a/utils/evl-test
>> +++ b/utils/evl-test
>> @@ -6,33 +6,79 @@ if test \! -d $EVL_TESTDIR; then
>>     exit 2
>>  fi
>>  
>> -usage() {
>> -   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h][-u] [test-list]"
>> -}
>> -
>>  keep_going=false
>>  do_list=false
>>  full_path=false
>>  unittests_only=false
>> +load_cmd="dohell 900"
>> +load_cmd_pgid_file="/tmp/evl_test_load_cmd_$$"
>> +
>> +usage() {
>> +   cat >&2 <<EOF
>> +evl test -h
>> +
>> +This help text.
>> +
>> +evl test [ -l "load command" ] [ -k ] [ -u ] [ --list ] [ --List ]
>> +
>> +Run a basic test/benchmark of evl on your platform, by first starting a
>> +few unit tests, then running the latency test under the load generated by
>> +"load-command".
>> +
>> +By default, the load command is "dohell 900", which will generate load during
>> +15 minutes. To generate a more realistic load see dohell help.
>> +
>> +This script accepts the -k option to tell the unit test loop to keep
>> +going upon a failing test. Otherwise evl test stops immediately.
>> +
> 
> To be fixed wrt the comment on the previous patch.
> 
>> +Use -u if you want to skip the latency test and only run the unittests.
>> +
>> +Use --list to output all the tests available. --List will print all the tests
>> +with their full path.
>> +
>> +Example:
>> +evl test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
>> +
>> +Will generate load including network load using the server at IP address
>> +192.168.0.5, some I/O under the moint point /mnt, and the LTP testsuite
>> +installed under the /ltp directory, and use the latency test by measuring the
>> +timer irq latency.
> 
> We should use stress-ng or something alike, instead of the obsolete
> dohell script.

Fact is that dohell does better than stress-ng, at least in the configs
of the latter that I've seen before.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

