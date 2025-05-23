Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8CD2288D3
	for <xenomai@lists.linux.dev>; Fri, 23 May 2025 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001516; cv=fail; b=CtwaxeaLs8GeTrsNGUrFc8yBrabVdmu4+Q5/3RpD0BK3wsIxDxGIwRy/9vq5W4PJN8/cPl0FvV3Se6oQkoOQaw1Wv/iMbabDBzO+MklhP2HQoT67/3dpfbhgnuC/oXsAVnbF7FqCYS9VTYyDGnGmQ1CI+vPOJz5LRTzvtiNhbVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001516; c=relaxed/simple;
	bh=CZ595kQWpnor2CesISjMkR+gvDYMzChM8Q5oROqOvjg=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jxW1COJsN80H469PaeJBFpQEEPEfHeGR6ZOpK+r85iiefZX/jQKetauznJb17PG6AhTaGDc9U+r7ru5EP1hfo4+2PLV7FmI5kdpSIFSKD6FGn+ELQJ1jXIYGPTZ+QEg12Ls0BAFOq+2U+x4vVTSVXSSYKLELCkOL6zGl0YMMvcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=i/6uFxC0; arc=fail smtp.client-ip=52.101.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="i/6uFxC0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5uoWyxFYYVRTaZ1e2pBZen9OTKirVohTSBgiCdYtxWr9pf0h/yG/SXwXJlABYGbi162ca4f4nYJxKSHpedlsKj7BR+ZJmaWUN04RvwJSK31y3bqI+G48BKq+4843M0N/L6jcE/bzvm5t89C/g36qi/CHhQM1Q+jeL+Vx98OU6QcRV0FDwrlX90YSf2784qsdjyyz9KFf1hDGsEgzxJ34kuq+POw5BKRr0tRCg/YFU2t1KLRQNiXhEhp3UAO+j2aPeRL0FJq5gFsuGa9guc3icsMUZH8P7cj2OEcAdIDARzKD0tmSIbswx+ihbgB8g+72oF4bEneyQoICmTISOOP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYtgBHco/jkrCLD6BMZT/jPdOEGdR+YQ3wHOKirsCIU=;
 b=dZLuPIfW/ExVduEjrFzWSq5cCR3d1QEah+hfeEb4oIQGRX7snZglZ581DoSWYRDZL37iEUnbUvSgab14ay+UcANSI7LoEadB+66BRCoNmL9yvbNYlYJXt28Zs2Brxsq++ad8ZCKUeMcC95ZnIAm37lCYAlUm5YxzxPJeVAzWftT0uPvPkCMppsQje7+pdjp75mAzzXVpJNWlyzSiijGM1mnzI3PEBUUY3PVn6t3TxIujlIQVvfnKsHObzJABiwUd7iAjyBNbHkqhvIieYwZLs1Zx2LJjgeXkrymcBNd9Dj0EkyZrHmgTVgGwC9iAcNFUtsoDzdo3BSoFBkRd2APUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYtgBHco/jkrCLD6BMZT/jPdOEGdR+YQ3wHOKirsCIU=;
 b=i/6uFxC0D3ZBFvyIYR2BiShBx54B66sStzzlPwtfsRM1RKqEawsFNkWCu/5WZMdju5bFvv4jh2spTZr21U16/lUKnFMpp+TBLQcxGwU9oFdk/l+sweAigQfpMWcVuKxKmR1mOoI8Xx6pe/UmOGXnAOpUESsGdemJ/qSocn91UqkOKfd4YRTaUqlOE6DzL1Ij9wa0rrGICcpL+Feda0gyCKBy80LT23WFZZn7GbrBnmL8BZ745LGvdZIPKByd9UcofaAwz2NYnMgWMxH2/JTH0gEpNjvxRKaeabMpisRDeOtPxsBoiWT4N2sqN5RQPaCa3IzP32rCRtOMGTuiG/TWoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7333.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 23 May
 2025 11:58:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 11:58:29 +0000
Message-ID: <f05cf5b4-1e57-42f0-a564-bffd3f8c0ad5@siemens.com>
Date: Fri, 23 May 2025 13:58:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Retirement of stable 3.1.x, warning call for 3.0.x
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
References: <32ec5e8d-c8ff-4bf0-9718-2d61340812d7@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <32ec5e8d-c8ff-4bf0-9718-2d61340812d7@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 858fd308-61d9-4461-70e6-08dd99f1221d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHNPRDZ6WCs2eFFUUTAvRWphd1AxREIzUGt6YWdxUldPamx4Q3MyU1JHVUhs?=
 =?utf-8?B?dUFrS0lvOWhQK0J1bXhBeEhPUmFsOGhZVUhwOXJOeFlnMHUwWVkzQjBJVmpx?=
 =?utf-8?B?YWFtd1F5V3g0Z2dLU0VNMlF1ajgyeFp3SkJKeHFoa3Fsb2pzRHlXM0FXWi9v?=
 =?utf-8?B?VUxxWDh6MDVZUU5mZWpZcDRtWk9tdGVVLzhIclZheEJUeUh4U0NrdUorTlpV?=
 =?utf-8?B?UlhKRWJwYm9yRWxJVWJiY0trdFlrWFByV0FHaFU1Zyt2ZE9OenlqcS9CSldu?=
 =?utf-8?B?a2VwOGZHeEl2WVNyRUxpY2ZvREhSbmk0UXhMK0lvUEd2Lzc4WGtQVmw4S0Z0?=
 =?utf-8?B?KzhyMFJJNW1raTdJVThheExjNmtGRTZQZFJadFpjS2x1SllVcG9vbVNkMGY0?=
 =?utf-8?B?Y2RObnUxa2JrVkYwRWIvQWl3U1VVT0Irc3Vsd3ViRzVBaGc0TVJUUmoveDFK?=
 =?utf-8?B?VnIwa0JGQW9HaFQ4d3ovcDBOKzZvVWN2bUdPNjdDTFUrR0RaRFMzZkN1cm9O?=
 =?utf-8?B?MEpUeWpBRjNVQnV6dnVobmFzZWFRSlFuOTRjZVVJNVZBc0JUc1JDUUlMd21o?=
 =?utf-8?B?TEs2UkVPMzRXZk9GSEkyZFZ5TUgyL2xsdDh1bHdzcHZaTTJhMVovRjA4bEc3?=
 =?utf-8?B?dWJLR2xVbmE1UFQ1Y3JJRzU0ZnN6cUlTeXN2WkU3dlBYYlRwdFpNVWZENmdR?=
 =?utf-8?B?N0NGZnJtZkdaZGZZMFhNdWF0cGliYUhhZDN5WFRvRTllM0xMRndYLzlTK0k1?=
 =?utf-8?B?dDBJNkJKTmNOQ3JXSTF1c3RCVGZGK3NPOVF3b0VqL2pCMmVOcHQzektOYi9i?=
 =?utf-8?B?VzBqRmpuTjVKdUhqbW02U2gweTVRYUQ4UzhnY2lPbk9vdzRsQ21mMkprWnFT?=
 =?utf-8?B?SFVzMUhEUnprYnBsY0hjb2ZHK3hIZ1BJcGlNMlI5YWdRZis2YzBJZ29ueTlM?=
 =?utf-8?B?aUJBNjFoSHF2aVY1azNjSUFyYitOWjdFVHBSUlFwYkdMS3hyc20xYjdxQzdn?=
 =?utf-8?B?NkxiYlRheURTd2tUZ2V4dGppUlAzSGU5eS9FNTJTWm5YaFZyb1lFeHJFc21q?=
 =?utf-8?B?SVIzRWhjeUduNm1vUGlWQjNGSzRlcFFqUys0cHdPQmE1TGtzL29zYUYzZ3pF?=
 =?utf-8?B?cmx0a3J6ZVZsTnBZcGU5aGlUczlXRnhLWExBMGh4TW5LeHBabUR0VDdnY3NT?=
 =?utf-8?B?RGxiclU3Zm9nc1VDZ1A3emJ0bkRVUy84OGxIclZYbzNnREhBcC9QajVhaXJq?=
 =?utf-8?B?a1IzMmY0Mno5WHhFRFMvcG9oSUkvZHZrMFIwTUhXaEkycTk1bkxjMkVtNFhu?=
 =?utf-8?B?UkFrdFJjTzJwNmVFM0xxZkJGS0ViaGZxYytBNHJoWUR3bGxrZ01LR0FTSVlj?=
 =?utf-8?B?ZlRwRmFxNm9uRmVidUNoZ3dkWDdJK2FrSkNSOHAvL0J1ajNna2RSYmVZbzJz?=
 =?utf-8?B?TGFianR5MVh3dFJycTNGQlQxWEorWnpjL1ljc2U1NWd1OUgzRklkMG1XRU84?=
 =?utf-8?B?MXo2L1lXc2RndW5EblhiUlBOZ2IwTXA4cUhnK2VmM1RkQkhNNWdjUnlUdGhC?=
 =?utf-8?B?UUpIR1lLbVBVY3lZUUVvV2RSckFtYlEra2VHdkFYakVuRXJHSU9EWUNFcTd4?=
 =?utf-8?B?Ti95QXhUOXJvLzJyRDIvUlRGWE5oYjJPRG04VnF4aHh3Y0NCUllOOHF3R0M4?=
 =?utf-8?B?bG4xa0dESlBBb0VRUVo0ZGFFRmNYczBiZWZDdGtRM2d6RWJxRW4rT1Jqcml5?=
 =?utf-8?B?R0NCVmtTaDdiOEdPR3NzZFFMeE5uSnhiV1ExUEs5M3RSdTR6UTZKSEtNMjZi?=
 =?utf-8?B?alE5YUpTQkp1TmZ1L09NMkdkTlR6cktFak05bTk4R1I2WHpKaDdQaE9keFpV?=
 =?utf-8?B?Zit2TjlHbDJxekNMNnF2c0ViZUpoaWJYZnYrS2lqTStSK25iKzJLdFg4Wnlv?=
 =?utf-8?Q?VD8YZD3NvI8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhzbEozc29vaEZPZSszZnhyYkwzWThvampRVHk4cm5BaVFIS2Ywck5rNWtq?=
 =?utf-8?B?Uk5scmtzNGIwMkEzMGJYM0xHM01uN01oNkpmb2dNTEp5OURlWTNSYVNoTjMy?=
 =?utf-8?B?Yk13QUlTRkxTN3J1ZkZLa2s3WFFJVnNQS2RXM3hUSUJvNjhJMEhnV0V6L3cv?=
 =?utf-8?B?N1FnMmxaWUtoUnJuZW5VVEN1WnArWnRZR25mVlJzWUtnWTlXR05paGxiMlhq?=
 =?utf-8?B?emtLYjdzVDRRb0FMUkIvb0FoSGZERXlONk5NcVN0S0pPTUxNNFNXWEttNzBq?=
 =?utf-8?B?WEV4MmJ2Vlk2eHcyQ3plOG9JWHFFdU9tTjM5SEdyN3lDSFlrcEhUMWRmbkRY?=
 =?utf-8?B?VUo2NENtbG1jaGNCU09zdzdqZGVFdThTNFlxKzBtYXliVFRyeHQ4R3dCU1E2?=
 =?utf-8?B?Uk9IS2hOMUxITWpLL05RVjB3YzJYMW85MUtYS0tQdWVrMjQ3b3FZL2puWVoy?=
 =?utf-8?B?cWVrai9VeGFnNXJCNFhsZzZIcjhFaFhqZCt1SDFLWTRwcHpUTTU3WEI5WVRp?=
 =?utf-8?B?YVNUbnNMMmdIY3hhV2RZVnV0OXVRNjZDaUNOdGtTWjF4ejJncnRRaU9zMzU5?=
 =?utf-8?B?ejJlTWQwWXhReHppWGwwWGRaempGaDB6MlVySjJKemx5am5yeXAvQS9qeVR3?=
 =?utf-8?B?N0hiRkZhUGl3dVc4NEZGczd6MllwOCt2cHZwWTRmVnREcllUbjc1TEd4YmdM?=
 =?utf-8?B?R0FsTEZYRWd6Y0pNdVJBOWRjMlh6bS9CV0k2bnJLT1dzdko5RTlrQ2U4R1JJ?=
 =?utf-8?B?b0tDM0oxV005MmUrditGUUl6SWc5czlWZlFkMVNEcENTRFc5d1JLdk5MN0VP?=
 =?utf-8?B?czR6aG1Zd1lWU2h3djFoTnlxZzBSSGtnVFJxUXJsazNEYUUrcDNEN2FZekl6?=
 =?utf-8?B?cUFwVm1rNnFvOWhvTkluc0ZaVVMwYThLM0hHVzdUUXU4cnR1Z28wMHNVM0ta?=
 =?utf-8?B?VTYvR3FsWGxoV0ZWVXVlSU5oU2RZWVF0UzkxQUQ4R0JRdnc1Nk5RZ0svcGlV?=
 =?utf-8?B?ek5EM0pkdVIvN28wL3EwMW1wdUxoMW1UcjloMGhoSDJzOXdiNkVjZ0FoME8z?=
 =?utf-8?B?WmdMbzNnS2lVY3dhcG0vMWNlaHI3cFVnV3IxWkxKbEtMOHhZMkVuN3NqOVcx?=
 =?utf-8?B?bU9kMS9CZ0lIQVJSMEVVM0luaHlYbEk3QnZFaG5CcWhpZEY2ZVMxSm5jdy9B?=
 =?utf-8?B?WVVmbEtZUXFhZFlIOWVRUUY4SGtQWjQ0bHZjYW9YN0JQTlBMTU1PeWNxbkhN?=
 =?utf-8?B?WUx6aXpKY3RmYmV3QmN3ZmFTREcxVFRxdFFncnFQUGxqbjYvNS9udlBBeTJw?=
 =?utf-8?B?VlV5SnZscm5yRnNLZE1zYTdieWMyOWtzK1BUWnZyVi9DdXJOcFhXQTFwRW5V?=
 =?utf-8?B?OW1ncTdaOWpuS1NteXJlazBaNlEzZ00wa1VkcTV3citGdFJvaWZWSHNROHVq?=
 =?utf-8?B?aE9NZ2k5c1EvYXphZjV5Ni9FRmFXQ3E0bERIYWthR1hPVkthYTFMTHByMkhU?=
 =?utf-8?B?Snd6ZXNVdDZ0YkpFQVNYV296MmpuOE1qdmJFcFdLZUh0V1YyWUQvcEpRVG5m?=
 =?utf-8?B?VkJ5bDZCL09SeHVBWDUvZ2pDajVKSUhQcDJiRzhxMk51YnI1N01rYlR4c2tB?=
 =?utf-8?B?RUlFQzJHOWptL0VpMUgyYiswT1BjVlpyRWlQM2RwQ3cwWjRQYnhUbVJGK2ZH?=
 =?utf-8?B?SzBFaUE1bVdsRTNPMmUxOHU5TFYvNVZjLzJiREZYQXJEY21qSHBUUjFCakNP?=
 =?utf-8?B?Qy9kUUk2NG9ZWFB4YzYyVkZ0UVNtcGhZVWJqc0RJQ3NuRWJ6RGNkODRXTm9C?=
 =?utf-8?B?S1FnbFV5UURyV3ZGdDllYTNRQnd4aHgxSGtKUG9nTEtiREF4UlhUL3hLaVNQ?=
 =?utf-8?B?NERaRk1oL2J5ZE1FZC9kSUhVK1krcXNDR2RSK1RHMEZ0V0RJOEZJL1lENzlD?=
 =?utf-8?B?QWFQenYwdHFRZXhTSFhzUWVLSEdxN21PRUJEdHFSK1M3MWNDMElXTFYyTUNx?=
 =?utf-8?B?R2gwdG80QmhyR2N5NFlENjY5dmRhc1FmY3A1Nm9kQWMrNjZzaWdJTXIram1J?=
 =?utf-8?B?U3ZZYjhmQnBVRVRIYUxvTTg5cnRRODBNcWx6dXNrSWt3Y1V6Q2hGRmpzU1pO?=
 =?utf-8?B?QUtEa3pZZSsxdjNYNCt3K1djM2tsQWRZZkhjUzQ1cmwrSGhFRWVObjRTNW5K?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858fd308-61d9-4461-70e6-08dd99f1221d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 11:58:29.7735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeXY5JAevakdXMvsSRqakriKBvSvAI2GYoXNR1GztF6XMrpUuKfj//Nznl5gGAPLHTYI+o9j6kTIY8mHoiymIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7333

On 05.07.24 08:55, Jan Kiszka wrote:
> ...
> The 3.0 series will remaining formally supported, actually only because
> I have an active user on it and need to keep the test pipeline working
> for updating the 4.4 kernel from time to time. However, once that user
> moves forward and I hear no other voices, 3.0.x is the next to retire.
> Be warned!

And now it's official:

v3.0.16 was the last release of the 3.0.x series, almost 10 years after
it started as v3.0. Along that,
ipipe-core-4.4.302-cip91-x86-40/ipipe-core-4.4.302-cip91-arm-25 were the
last kernel releases for the 4.4 baseline. Related CI pipelines will be
dropped soon.

My internal user moved on - if you didn't do that yet, now is the time.

Jan

PS: 3.1.x with 4.19.y-cip remain active, though with only minimal updates.

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
