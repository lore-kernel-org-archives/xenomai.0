Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE36F53E
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812099; cv=fail; b=XEwhzVmK5f+3yjERPOp0ITtyS2KSbjrF3UgV/Q3ZjbVEKUZj3be68XrQLUJa/m0pDZLwCoa17OgnvdGnFHOmj6WTfLplacw6ZxSzT4dUO4xh3WjnnkDbhXuWcqNYA06LNPMYksDHRFDJyrbLGE971LAEQvvmuyckvd8a4NzOdMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812099; c=relaxed/simple;
	bh=UfWVkZK1Ho4ayIwSF3Id588e76qLNoDHDk4mfSTviaE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cdxo4X03IoUz5YQmsTpl3nA3EtuwMCUbS4qpxA6j1NBwAYY2/YeEeDIZ2YmSxvGAPyAKJx22HW7gy3dW86+woegWTSUDFcFUnnNWyiA6iYZRMsYKsOfVu+LyhUOjJW1mN9rG7m4fQv9wEWo8MrPK/WPcrvAU9q+KDbwiPMs45Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=F2GZdMAF; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="F2GZdMAF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sla3b8Aw0kO3JnDy58urMnwgY3Gn2OctJMIOTMoVDUEt6A0WuuLdfL9y+lDSFzQlPXq5VFdaJVGvToauXezO1FzComAAWh3fF0D85gUf06J2/yqZFUEGS/U1aTPlB00koYbHENq3Kdko0bRR4WX8W913C+v1OI3ZxKuWulaYOjXz0OfqIJYfYNRJl2GXbhxGddkacIZfraNYTtQjbe3FUFL42APYmp36lU5c1/Ht0sY/EnECPsx6o3DVeI1Pa1DWnhITIHh8fk/FCeNqYYM62/T/dUMf+Udp4Ng48iHXpvY5ry1J8iog4AnSoLdaraIIw/GyQYWH6T7OHdDhWIlSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7LzK9SX5Qpej43pGVHfDBp+fw/wDWk/tIE3c6KzHkY=;
 b=iDlEI8fZZO/C1rd6SmA4YPsqeSveHxvdD71o7+G+sGGSmVuPhrn0MEUBGuqF7S3ztPX/7GH+P7Inv+lfGwGC+oHL/I8b75A88pIwTrbxcVe4GAnbXugm29BLYmdnxcD+ZpNZ38/jVjffw8gvRWkhXjAXfDXpteH9xclbqlUyhJVZpVX1Eb09hUwhnydfyZiJOsJRQtUClut++O9i9+6MbGxtncs9pmg1OnRAI+DFWb9DrCFibFB4825Xa5O6vTFDHC1qBCNSrseZ/DIuSKnodTL2UzzCpMvFdS0v3Hqte19Kv5B3PR9mYlIUXeSqMkGeEv9wLoNclwKuCjjTPwtXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7LzK9SX5Qpej43pGVHfDBp+fw/wDWk/tIE3c6KzHkY=;
 b=F2GZdMAFU5PxIdXzxa30j3j45iSbrcRd7rmAOig4IwJn4vvDaPF3hygIwtmcLkyhO3bVLzSN8tmdWrCKmwdEj62L0OXHoO5Sk7LOtFKW6vCDjOBriuZqeV6L+l/Bip8nseaPCB5csmhUWXsE4BbCc2Q1M9cRjWf+x0Bp80P3hcN0qi5igdgQkdj/Y9je+SdcWiHKZ9/qFtObq+TEJQW1kFmaDcao12OX3aL/N5C1/m5NBtEmJV6ZGTWjCsoRKti+jZ0HsL6CGUxLrygwziJCNKyYHAtmusDMu1/Qao5DKxmf1vToH0hLC9yyhw95vP3CsDFWhSLnPf/od4vsR9ZzdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Wed, 16 Apr
 2025 14:01:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 14:01:34 +0000
Message-ID: <af3a7b56-570e-43b1-8257-9ab99b8c8f7e@siemens.com>
Date: Wed, 16 Apr 2025 16:01:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Correct the default value of xenomai.sysheap_size
To: Haiyang He <aspirestro@163.com>
Cc: xenomai@lists.linux.dev
References: <20250416135148.1943000-1-aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250416135148.1943000-1-aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b50f9b1-32fe-4763-0c33-08dd7cef32bc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUN0ZG1ObzgzS281eklHMlc3VDRwU2U1QzlsbUZFN3phUnZHaG44YlY5ck1i?=
 =?utf-8?B?Qld1YXVZSnd3eVJscWJnTEFEblM2Wlh6cVdQdUtPM2pndmJDWlN5MUc4K0FZ?=
 =?utf-8?B?RFdYNzAwVXJYVExONWd4VnJkcWt0TUV4bWFUOHZwMm9YREYxek81VXVJYmhI?=
 =?utf-8?B?YnA1a0xrcUR0SUxqSUJReUpRSUpFbnVjcWdsZUVSZTZLOWF0Sk1ZK1dkbUZa?=
 =?utf-8?B?cm9WQ2hjQWhYejA3Vk9qYUNjamtRTUxFZTlzV0RCZHNuSUV1aENDRkE4b01m?=
 =?utf-8?B?cGF4eHdhT0lDOEJyQ2N6SldOTHNNSGxON1hZM3hBUGhaL0FhblZrUVNHQzlt?=
 =?utf-8?B?Wm9EZzEzSm5CSWhPbVlFRlB1dUZVZ2FXUnI4MDZrbTNsWUx0aWE1cjVwRHgz?=
 =?utf-8?B?dDdJYlprcEFkcjFXa3ZTN291MU5DTDY2bUx3aWFNdTdDODUxWW90N0NsaDBv?=
 =?utf-8?B?amdBZlErV1JMYkZVLzdzREtkU2l1ajFMUDA0MVhJNHpxQkF6aFdwMlB5V3B3?=
 =?utf-8?B?eC8rTU1pZG83Mk9XU1JXZC9DSzN2UG5RMm5DUGM3ZlJVV0FMVVpZQjhmTjdr?=
 =?utf-8?B?YlVBbGlCeXZ1bUo0cXV0VFVzYXh2bEtmaVJWdEd0MlV2K1RCNFlZL1ZOdW10?=
 =?utf-8?B?R3lQdWxtUVhKUU8yalgzcFlUQWM0Q0FKSTI5OGpPZExwVEdXSkZYYS9rVW5h?=
 =?utf-8?B?c3dYbkh1QmdKNysydDlNUDExNndNN1lMbE4wWlRUMVU4T3M4S1dDbERVWXQ4?=
 =?utf-8?B?UnRRcVgvM3dwak9ZamRIbHdvbU1vbks4SmJiT1BndjJrdjJNZkZDTU1ZQk4z?=
 =?utf-8?B?TWZlYTliMGlIZ1BPNmUyZ2xBY05kZTlxVkt6d1liWjVYTklqKzNTdDgzR1Fh?=
 =?utf-8?B?dWhJZkR3T1BlcWNCVjdkMk9qZTkwS2FNdVpoNnhhOGRqQ2dOSjgveUZPZjZW?=
 =?utf-8?B?VkY1RnE1Q21ydmw0N1BIUWNxY05Ua1BVTkp3dUMzWkRVM3BuZmRNL2ZJWnBp?=
 =?utf-8?B?UTU5TkZxWGRlQ2x6YWVMb2Z4MzEzMEpjSDJEVnhhczVYb2tsa2gvSDhUWEh0?=
 =?utf-8?B?a3dUb3VpeE5IY3VSSTFGaWRVd2E0MDY2bjFveCtJc21xY1h5M1RhejRVNDly?=
 =?utf-8?B?QTlDTWxmWm1sRVB6amJrd2lHVWRqZC9KQS9CenVjMzdOQmRJOHcra0lSQ0tx?=
 =?utf-8?B?MVo0bTQ3aGREY29KdUd2aVhJaERucGdnQmRxT2ZvNmFiaHVSYTF0NEhQMEs3?=
 =?utf-8?B?K0NYYmNCcFo2NjFNZzd2NlRRQ3N3dkZFa0g5QWJ0OUh2cldabDlvUWlZWWVr?=
 =?utf-8?B?R1dCVHlXbkYxR1NVVUtXVmhkSk42bis3SkdEQ2tRYWR3ZEtObTBtRE11b2FU?=
 =?utf-8?B?d3NzeXFWS0ZjTDJnZzlYUGNiMG1xbEFtMm9EcUc0WHdHMG5xTVpHc290cnd1?=
 =?utf-8?B?ODUyak01T25kVXRCT1NNSHlmOUYrNU1TZ1lHTWlra0RES282MFVHbWxhUVRz?=
 =?utf-8?B?Nml5K21VTnhDd01FVHhFZmxvTFJqdkZid09yWnJ2SFhjRzlWQmovRGFmQi85?=
 =?utf-8?B?bXp3YmNsOWNNTnV6bDJkODlISlB6NnBjTUFkM0RObjdpd0l6ZVRxK3loZnlC?=
 =?utf-8?B?eTBRc3hoaDFaa282SnVSS1lFc3gvcmxxdmR5R1BQekY4UVNNN01tZDVHVGl3?=
 =?utf-8?B?VDhBYmNRQ01Sak5jUHRwTm13NDJ5MnN6d1o1Y2tSa2JFeGx2NUVycWJseWtR?=
 =?utf-8?B?MXlycHZiWjAvS21NcWpFWDh0aXg3SUptczI5NGRQWmlZdDdEUUdobjdkYXNL?=
 =?utf-8?B?NDVqRXE5UkZHaVE2LzYyeXZlbmRvemxNTkFjZzFVYnBoU0NpdmhrSE9tdmk5?=
 =?utf-8?B?Uk5iY2lDTGxDSHNFeHpyNE1zWno2VHpnYzZPL2NveHlnSkFCYzJXSzI2Y0xr?=
 =?utf-8?Q?NiTCQXa/+6E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnpXUFE1MkMvaUtZOUlMNFlDNEdIemZXUXd6UzhFTG05cmQ4Mlp5cmIwZlFh?=
 =?utf-8?B?Y2FZNy9LNUhJK05YVE5jV0N2RVg1SzFFbFBZVUJSYnREUTdLVmRGYkFQaEdn?=
 =?utf-8?B?ckErdmFnQmk1NVhKU1hOT3RQRjBFaTZaZVFwNkhabW1nSTQvTnI4TytHMTdL?=
 =?utf-8?B?bHFBaCs2WWh5aG9qM2M1QklUZG1oUGpYMGlrRXRFbE1IU0NoWFpmaTRWZGdP?=
 =?utf-8?B?MkNIdU1NN2xiUmsyZHpVYlRqbllrYkFrT1RCcnhYaTNaa0ZrNVpiMVJFL1BF?=
 =?utf-8?B?cEt5bnFiZEpDbFNFRjRLc0NvNThGVHVvOUc1cHBKQldxN3ZkTGZEakFmTS84?=
 =?utf-8?B?TWhMQnVCdkd4UDhQMjRrSEoydXlJM2xzVVJINVE1K01WeGVNMjFTakFNcHhD?=
 =?utf-8?B?eG9LRHZyek4yUVNXQy9pd2pnVllBUXhDeUdPWGlmZHRBRFdWbXkyTC9lOUMr?=
 =?utf-8?B?a1gvcU1BeUltdC93Y0xyUmFyM2JWRXNVTXNyMXFwbkJXdjVjOElaMHZ2OGJM?=
 =?utf-8?B?bmV1N2E4YWlZOVBkZ2JHNlZSU09sMmc0SzRvem9uQWo5QWt6MWZjYUhrQm8z?=
 =?utf-8?B?TnVydVZETm9SZzJtWWYxYWlQWnVkME1xQmU2NlJZcFRZMFJ2YjUxWnJmWW1G?=
 =?utf-8?B?OGtvOUN1MWFwdEg4R2s2cnN0T21UbjRpM0JIU29Sa01wQlFPOVNadGxWcFVo?=
 =?utf-8?B?bS9wTituYjh5SmVFMmgzcjZ1UDZSWGhZM0VnYjdCVmh3ZjhwcjV1UXY2ZDhE?=
 =?utf-8?B?VStEdUxjaVZRam9sT2J1YXdPUE1iYjg2SkRBTDBaUkV0VEQyWE95ekZoUys0?=
 =?utf-8?B?NTFUNU8xWDdMTDg4cnE1Y0FYRVd4bXlRNHllMUdvYnRndVdHd1FmYlY2cXZa?=
 =?utf-8?B?d2pWZmNQOTRyczlBNC96ZU9ZWUMzN3p0U0djcnYwYVNKVHdSbGIwakRmcDNu?=
 =?utf-8?B?WGRweW1YK1hrNFd3dzhnSXVOUmhFOG9IdTFzNXF1SGNzTktBNk84NHBhR0g1?=
 =?utf-8?B?bXBjU2NVMjNFeFp6N1kzd1ByUTQyMk9wc1o4UDArK2orTzExN2ZQT0xWUkVP?=
 =?utf-8?B?bWpvc0psYnVjdFBPek5ZaFZEdm1vbmRQdGduRzRUOU14T1dVSDZwZlJ4UDMw?=
 =?utf-8?B?U3FNdllHaFAzbnBYUEF0NVg4YWFEWU1mQ1lEZkhkTVBWWjBpWXBBTkNWN3Rk?=
 =?utf-8?B?NkNpSDE4a2ZOTVZzZ0hMcGZ6d2tGVTZJQjluUmZOQ3FxcThRRmsvZmVpS3Ji?=
 =?utf-8?B?MXQvVnZtRjNkOUVROUljSmRKYTliejE1UVd5MDBuYVNWTWhiQTZYZElJQ09o?=
 =?utf-8?B?aC9VV2NkWWh4R3NsZGw4dkxRblR4c0swdGhueFRkRWRuOTZON2xBaS9FeXVp?=
 =?utf-8?B?dXJCRVBzWlNEQ1NxMmdxSjgxOTFPREFOdHVyTW9MeklXenFzOEdWZTZOQmFY?=
 =?utf-8?B?SWpDR1QzbjVoaWp0TUM2OGlDeTE3bmxlQXNEa0I0UGE3NDJ0azAxL2o4N0xD?=
 =?utf-8?B?VmVSaFlDbExVOTJmdlgzTS9xeXlzWndQa2UvTmpnVXo4bUdRcTRXUEhGdzFi?=
 =?utf-8?B?VW5qMHVwem9vRXFaWUdmQTBFYjZ3aEdKQ2JibEQrK1FVNWpmQ0pXV1Z4NllQ?=
 =?utf-8?B?VUF2amp5UEgxQU1zZUxpTmZacDBsMld1aFV1Z0RiOEZLUXNZQVlqV2xVU1JE?=
 =?utf-8?B?QUwyTGU4MWRIQ05VTU5kSlNYbllaS2JYeTI2YnJuTEt5NkU4QmhxWUFWVEJZ?=
 =?utf-8?B?b1doeWdEa3htdHUzUXFyUkw3NytzbEZPbTZDZ0ZUUUxyQWw2dHNxRmg0U0JG?=
 =?utf-8?B?cERjRUwrMWtGR2JMcDZYNUxzaDlTbFBQMTdDN3JJMEFoUFJsTVVTb2k3MDlS?=
 =?utf-8?B?THYwa2Z4MUt2SDFoNVJNZ0JBUTE2SjIrRkdkSEU2MGJaTDFxOC9NeVI1MXBV?=
 =?utf-8?B?bFZQdjZhN0s3K1dKQnM2MEhDSEJQa29BTXZMQkFKWlBBQVRZdURidHZqOXg2?=
 =?utf-8?B?SnZNT1RCK3NMMVlvS2R0SFU5L2djQ1V5TFBjZDYyVEhZM0V6anJublFUWEpZ?=
 =?utf-8?B?WHFlWXlHVkpHelJXL09tYUFLMkJjRGtvckpFaEhOUGs4NGpTMEdhTE1mSHp5?=
 =?utf-8?B?RElJa1RBU0t5b0hMVkVnTDhDZUxUaERyY054WEtUL0RCWVg5MkUzWjBNSUIy?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b50f9b1-32fe-4763-0c33-08dd7cef32bc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 14:01:34.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dj8pXGyb0SgI6jN2WOg4xXEJYTNm7Wb3p1e/JOab13E8n8IfaRG1XXQLRvlHtAJBW7SRR0lA2lX6MrtWUooBuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9076

On 16.04.25 15:51, Haiyang He wrote:
> By default, the sysheap_size_arg equals to
> CONFIG_XENO_OPT_SYS_HEAPSZ. Ref to kernel/cobalt/Kconfig, the default
> size of system heap (Kb) is 4096.
> 
> config XENO_OPT_SYS_HEAPSZ
> 	int "Size of system heap (Kb)"
> 	default 4096
> 	help
> 	  The system heap is used for various internal allocations by
> 	  the Cobalt kernel. The size is expressed in Kilobytes.
> 
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>  doc/asciidoc/README.INSTALL.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
> index 60f1f9149..04c102822 100644
> --- a/doc/asciidoc/README.INSTALL.adoc
> +++ b/doc/asciidoc/README.INSTALL.adoc
> @@ -132,7 +132,7 @@ whose members should be allowed such access by the Cobalt core. | None
>  
>  |xenomai.sysheap_size=<kbytes> | Set the size of the memory heap used
>  internally by the Cobalt core to allocate runtime objects.  This value
> -is expressed in kilo-bytes. | 256
> +is expressed in kilo-bytes. | 4096
>  		
>  |xenomai.state=<state> | Set the initial state of the Cobalt core at
>  boot up, which may be _enabled_, _stopped_ or _disabled_. See the

Thanks, applied.

I just need to find out (again) how to generate the docs for the website...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
