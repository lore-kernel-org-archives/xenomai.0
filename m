Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6E285CA3
	for <xenomai@lists.linux.dev>; Tue, 20 Jan 2026 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927866; cv=fail; b=c1LMxIW2hhxHDFlMMxEdSnzcQ5/gJrz1aqgLRvrZ9Z0Tva2tioKvvy/dsFuT3DfACSR3Ph04nt1SGhe6bbRbA3mEfdZYNaJPx0Kyahe9O/okGQQ2IlYYqzHldUfS5TLdL1+Vati8aNMA2xLGOiwQWu90c1do0WOlo/bxZAtXOwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927866; c=relaxed/simple;
	bh=a4M7THEKfug4RKMsL5JOsgzerLhTH3lo6d2MYeVlpM0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U0DQSjVxLtku/aRKlH7PimjcQFpOMve4P3MrBpBob7u+C5G439MM7WELYqTHYHl1WY9TCeHGmNPdkerOi2p0SDHV2ZZEbV46mQlXsUtuTIhXB3SpjzOAlKKNTp2UzmHIqnLmhBgdr9d1gv5c8TwUsgPnR6HSap4Euv7dVI/i+nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MntDCilW; arc=fail smtp.client-ip=52.101.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MntDCilW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjRVywopYOe/z29YtM4+1sQkbuQmQh8okq9J8EckJGR4VKqr4DlEqgdgbXCsg1j4raC9plzIBjsox8w1A5MpjmJZHetNJwao76a+59v5G0LOqivYVCdvtCSUZZ8uWWUC8ImMQgpuMHy/g6gZv+8+TToFlIeSDywuXU2no9eW9RQrDbrfuShp7BGMkiXyc6h+Ffchdc8EvRYDfrqJ1FNtdylEHHGKJO3zpXhYqSDRIbZjz1GXYzSvXpb30k4aDkL5wF73J+9WCygbz4IgC2MXV/CCWYnZxf3eZbR5i/Usls1xXmPvfoaES6z4eIl5+4rfT7gx5w3+38kgdcWAaciNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gpQVmAGYK0gTbNwkgJifYRFUIf2rm1J8MWNYHrwoGc=;
 b=WoOYJlDuqGP1KrdW/KvPLaE+7FkuDRFsyBhgaQklRSd9LAmlGgYMO4srZxDCaixkcRR/xdLXCqHXm7pPgIR0hpPAUUDDFjnQeFQaubDpiwTTroQ9W/SfAU9pSv+PUjINizdvtxIOpqWL0tLuVyYCzluZeOa2bIF236CXj8sJDPRvL9uGeo0IHBnIIXu5wYTGnEzlRbtWkmM2Fco4532cTqWLMs+aSn3GVnS26r1AXe5VTA/l7jiurIo2or1eeUkBXBMD8/MCQlmleNNxHrK0fQSmxMOUu2/R9fQrqQ80VpOecbpDqV0N2wDNMA5hY5jdGb19KWFXyvjDsHT89FCsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gpQVmAGYK0gTbNwkgJifYRFUIf2rm1J8MWNYHrwoGc=;
 b=MntDCilWA6Mvlp5v5erZB18aPQuOZlMH9t6MFRk8Rtb59I1P1VZHWRmeXP6VDIxUVscAUYEB+PqjJUuzzCRqlxAcQSkRBWYHOQFEmtliy7gNntxODiLmI//5MlF0n0RcWXD7wYwKL8XqmZB51kOWN+FdXohNsjg14A3m+CsiVH3CbZnN8dj+42Wp/SsorLgGet98swl3y7bzEuRQ+29fBTwQM87f+WVPwxGJwYU1nEfYXXLwd4IE+hlB2jQKrswYoPY0sSM/K3Z2AXzrr2m4MpB5v9mnO0u3Gan7DTH9ELpqL31iDRsLl4oxB8TkRCCIGxCTAWCu+/iUX7zRlB5EWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7267.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 16:50:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 16:50:58 +0000
Message-ID: <e2d6784e-dd41-4d34-80b7-6c2c5aea327a@siemens.com>
Date: Tue, 20 Jan 2026 17:50:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] riscv64: Add support for RISC-V architecture
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260113085048.1380995-1-tobias.schaffner@siemens.com>
 <20260113085048.1380995-2-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260113085048.1380995-2-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 5864f0cd-b617-4acf-5679-08de58441648
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGxoL1k4Wk5DTzZVa01kT1YrOThBQjhYVEk4Si9MTlFxWEtxQnR3RTBxT1Rk?=
 =?utf-8?B?bndwOVorOWRFTVZoWEV6WGRpZWpraEFsd3FIaWF2dHo5NGVmMVVIMzMwNGVk?=
 =?utf-8?B?anFkazRzRUpoQUt2aEVZR0txSnF3TkRydUl5N0ZPZ29tWUQrTVhrc0pDeE9W?=
 =?utf-8?B?MVExQ1paL1dWZm83YS9tOWg3K3p4bnBjWjBqNno4b2QydFU0TkRNWGhoWWhF?=
 =?utf-8?B?cndOdHFMeWFmYldMZ0IxcUpUdHRvUGFMMHBBeStiNm9lV0dNeGE3SmhqV0JO?=
 =?utf-8?B?cjNzdUd4Z0JuMDFiMmMzdWIwampmWFFYb2lrbHcyYm5TenUxRnFoTHFka3Bt?=
 =?utf-8?B?bW5jeFkxZDZDWWlmdmRZOVhHMmhCTDBSUGFPVFRtUnZvR1gyaHFFN1VBZWo2?=
 =?utf-8?B?NEZoaTFvZUhhejVtZjc4M1BLSGcwZ0d5NFBQRmJtQXhXRklrTEtoaWNleldL?=
 =?utf-8?B?N0tiMVNPRmJoRm5zSTNTaFBpTFdiMWphVHNPcWI2YUZCUW1LR0d3S1htMUZK?=
 =?utf-8?B?aTVQNUxQcWdwM2prUWNOZ0M3WjFScVhIWHkxM3FPOG5FNGZQTnZ2N1ZuYVZT?=
 =?utf-8?B?RTJFOW9XOHUxcWtCMTlCR1krMnllWEl4cHIvTHJuNEhubjVUT2NuUkVpdWU2?=
 =?utf-8?B?OEJVWHdPT2ZQSE9hZnFtaE5ValVidXl4RllmU3NzNkE1VHFsV3ZqdmYyUVpr?=
 =?utf-8?B?UGFNRm9XMXdmdVVCR0JvQlM4TWJEV0Mxb3lMNVB6Y3BsS2VkVU93T2pYMUlU?=
 =?utf-8?B?LytQek5kU2tDRXdkRWpMM0ZmdGxydDQwZTBVN2dyQjlxbFZ5cXVtWFJ1S1l5?=
 =?utf-8?B?L29MNDdPTDR5N3lOY0VKc0hEbDZhSWxNckxjZ3FJTmJxdmtyZGRxSVJWYjlx?=
 =?utf-8?B?UENvbDBXU01CN0UxS0pWMGtISFFJdld1TWZXN1h0ZUIyMCtxNEJ1RHA0eG9o?=
 =?utf-8?B?bGlqeDU5K3M4cFlrZjNEbVQ0SlJTTlNsdzE5bFRDRE9Rb3d0cVdLbWIvK1Fp?=
 =?utf-8?B?ODM3RW1qQVhPT1JRbVp3aERKL2lGdzVjNWszbDRBVUdPM1RMalplbXAwcFJr?=
 =?utf-8?B?blpzajBYblk4RnFtNFBEMlBWQk4rUmo1aVF5R1FkNW9ibzlhRWFMdjRGenNv?=
 =?utf-8?B?NDduMVl4ZjZNTVJwT1QrMTBINGl5Zlo5anNlOStNUUt0cVZPUFBQU0g5a2Z6?=
 =?utf-8?B?TXhXTzNSV3ZGaFNERDgrZmtSUGR6U2hyNkZNcWpXUjUvSXdZTERGZm1nNVdl?=
 =?utf-8?B?aXlpaWJFUFh4OEZ5MWN4ZlQ1MzRuQ1RLUjkyVVErTXZ2S1p4K1pvbTZScUpm?=
 =?utf-8?B?MnlsaW85NFg3OFl3YlhzNHRqYUI0RkNubFAvQ1UzNDRnaFRmZXB5NUdSQzFI?=
 =?utf-8?B?eXZZa0UvSktoNkJ2TVFZMHE5WWJ4M29OSm1RbG5CZVFPa25Bc3ZrbnZnLy92?=
 =?utf-8?B?YnVaclVsTHM1azJicnpvSTQzZW1rSFZnSEh2STNSUmRCd2duRENOOEFqMWE0?=
 =?utf-8?B?Q0Nhc3BVaGxUYno5b1p5TDlzMWJ4UitpNWltU2VFUkN1M3NSbjNsdldCWWpQ?=
 =?utf-8?B?NjdHY3ZVWU0wcVFTR3d2NEI0ZzkwTTBtZWJnUUFQbmQ2ZnhkSzVmVGpVLzlI?=
 =?utf-8?B?TkV0T0pTYWx0Z0FIMmJVVHJGZnhGckJvWjVINWZzdGgwNTdNeC9Vb2YxYVc5?=
 =?utf-8?B?MXhGNkZvUWxYcHZSN2U0NEtxNzFWVXByNFJsU0lvVjZpTXNCVmJVTjNaTjJo?=
 =?utf-8?B?VWRwVUowUVN2VVBXVXdpUzBEMFRqd2VYZkRFVndiRENqY1NibFA0VUViRDdo?=
 =?utf-8?B?dFJLWTFUd2ViZXB1RGVJd0FOVk5JYXFXRDk1RTh3RUcrUS9BNVFFL2ZmS0cv?=
 =?utf-8?B?N0k2c0FQWDhrL3hXaDV3WlRDM3ZRRzlwV3UrM0lNK25SQUs5SnVnYzFZSS9u?=
 =?utf-8?B?NTBPd1NZUElQYzFJSWRlOWMyNjZyQm9jY2ZoTlhBYnRpYzVhMUNjSjJ1YnUw?=
 =?utf-8?B?Yk1Wc0Y0SVdTR0FtTUVZRnMxalZ5bnN6L1dpK1NZWVFqclF6N091aktRbzhw?=
 =?utf-8?B?RHI0VGdpeVhBZVVUTnNUTElRKzJLQXdrZEg1eEZrdVVaeFRxVjBMRnltZVFM?=
 =?utf-8?Q?ZT/M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ektWajNOQmpVOW1UOHdYOEVkNnlnZXBYMW9aaDlEMmFldU5SREVUQ1lGTzBU?=
 =?utf-8?B?T3JCeGdwL0ZjQTlERU5rZXNLOGVwSnJIMVQxRjh3UkQ1VXJWOGZRYnpjcVp3?=
 =?utf-8?B?ZjhFbG5TeFZyeTUwUmhWeFc1WStzSUxjVHFpNDBRMkFkeWtJc3JmUnNiRFQw?=
 =?utf-8?B?RGRVL3JQT3NmUVovbUJVUEQyZ2ZOa3prWmIvU2NXdWs0VndsSnVOeVFiUVcv?=
 =?utf-8?B?cUhkYUVaN0NrQ1piVXNhWXZXMzVyMFltZVRTS1UycFE1eEs3bk1oS1FzeEl1?=
 =?utf-8?B?U1R4SUZ0YXhub2JiOVlubXVoVmYxL29udDBYUXBJWnh0VGZOOGFTWUpPSjA0?=
 =?utf-8?B?ZXM1MWRtQWxEdHA1Z1JIL1JDTVpWSWFhUkJ2Y0x1U1p2UWFlMmczOUltcEtE?=
 =?utf-8?B?RktLQTIwb0NheEVyMC9iQmlzaUgvNmdoSzFOczZ6R1JzWG0rZzBmNTIramo5?=
 =?utf-8?B?Z09DUlFSTnRrMmEzN1RQb3cwemtKZjJNSHpvN09wYlpVWEJnaUl1K1RCWVpL?=
 =?utf-8?B?c25adnNpNDVYVlMrNGJ0ZWdrM1RNOHBKcHF4dUJqSjgwdDZBeFRyd21nOHVv?=
 =?utf-8?B?RDhpcmtVV3NzOHhpVm40WUowUTZXRFR6ekNWSytDbHdoNk94eERaK21jZzNK?=
 =?utf-8?B?ajIrRzB2VmhsU0luRDN4U0c2aHVTRFdsZU9tcUkyelZMeGpHUWNlWWsyVkJm?=
 =?utf-8?B?K0lkMzJNaWdKdkdwbU1RUi95dGRtbUFZa25DVUZ1Q1U1MFN4aU9WQmVvd0Fz?=
 =?utf-8?B?UWx4SDc3dVZVNWt0ZXdmeDlDR0tqNlJRL05aeitJVWlzUHA3aTFwaVNram04?=
 =?utf-8?B?OXV6QWlxT3ZiSDREVGlKSGVaUjRLT3NvdEJXcVI1SGw3L0FJaU1URTZIeFh1?=
 =?utf-8?B?aW1GNG10RmI3Z0ZJYjcyWW5xK1c1Q1ZkRTBWVm8rRUZjZjNPNzNLUVRPcFN0?=
 =?utf-8?B?RnFEQVJvK1dQYlppTG4yN0dkYXdNeWtkZFJ1U1BsR2t1amdpWUdYUWp6bFcv?=
 =?utf-8?B?NkNsUlJFYlhGMU1TUzRhVXpjL2VFNFVUS2gvRzdEdEF5TVZJYzRXempNbXBH?=
 =?utf-8?B?LzllbUt2SVV5SDRzSTRvZFBvbmxGWHd2Tkd0Um54NmcxSXMrMEsxOW5xL0NH?=
 =?utf-8?B?Z24wSGttSDRvcFRWRWZoQ0hUNWlyUVRSY2p2bFhDRCt0cVBEZUlTenErRUxZ?=
 =?utf-8?B?QjZ0TmlreTFNQTlEQnFTZ21sem85QkNZNFhHdVBXTEMyaXk5NjljZXlUNjBj?=
 =?utf-8?B?M2pPR0FvNTNVdkRyZUNIVzlqWnBFUlA2Z21RSGdNS2RLY21VK0gwTmp5Z3kx?=
 =?utf-8?B?ZXRVek90dkErRldScUZSbmFIaUVRdG5sL2dKaVpLNUxKN3FCL0dWZXZDVlZF?=
 =?utf-8?B?aTB3b1IxM2YyZFFSZXNTZG1xV2IxeVhNNXRhKzF4SFdCK2R4QTI0cG9LenAv?=
 =?utf-8?B?WEx4TFhiLzNGTUdwelEwS0VTMnNyVTdTN002Y0R6UTR2azNXdVRLZWVpbmtl?=
 =?utf-8?B?ZzhDR2dvdWVOUHVTaHZKemVuVEU0cUczUDh2MWZzdDZyVUNUTitHYWZJTFFr?=
 =?utf-8?B?M3o1MnVnUDJaZXhVczcrSFVINkhQK2RkRjFqZEc2RVVJNWhTcjNxbTdsMnJT?=
 =?utf-8?B?ZE43c3NxTTRqc2E0MVBUMlJCcm9rNy9DNG5kOGVBU0w2WEtmSldiYUFoSUFS?=
 =?utf-8?B?andiUXNNWjdGZ05PRFBSZTJBbUxPeGpzelFRRzM1ejl6aUxFRENGNE1lUjZh?=
 =?utf-8?B?UzZRUGI0ZnhvRHVxM3BuY3hMY0J0aGJpZGxBeFRSVkpyMERoZTVSSWtDZGl0?=
 =?utf-8?B?a2tRdDhYSkFEcmJ3Z20wcWF3YTJLcXJNWDlIZmI2cFdWQmFjY0dRdE85RGha?=
 =?utf-8?B?TlEyRWUzelFmM2s2RlpEendNQzRLbVNnd1Viazl0T2NtQW5kdTRjWXVSRTI0?=
 =?utf-8?B?akJxaU54U0N1R0Yybkc5QS9kbmNxYmpIVVE0YzdNaUZrS1lqSU9oZlNoRFdL?=
 =?utf-8?B?NmJ4OFcrR29ZSzBSVnhGQjJ1aWpQY2pvZkNpNDlFbkFPSXdGT1o2K2NCZHNu?=
 =?utf-8?B?MXc4RExPZEZGalV3VnZiV3FyMUdrMzZVZXhmSVU4RTkwdnVwekRxVStyc0Y5?=
 =?utf-8?B?K0Vlbk02NnBXNFM3RXZOMFErdTlkMnoreFd1eVNYby9rN3NKTDBDYWREcVNq?=
 =?utf-8?B?ejRNYWUvS0NGSXdjNUpqR1dmT2hxd1cwT0MyVjJCOVFTY3RVRHFvVTZCTm5i?=
 =?utf-8?B?bU9oZ05Bdk1WRWsvWDBVTk90RkZwNGkxRTlUM2JIL25Ea3YxOWpxbi9ZNTNp?=
 =?utf-8?B?MU1OSjFzNjVZWU8vbnVuS1dVcGpObEFXZDlCbEROeS94QURwNS9mUG10Z1VB?=
 =?utf-8?Q?e/7uEcwfA1ZQZP/8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5864f0cd-b617-4acf-5679-08de58441648
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:50:58.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gZYZ8IrvXCyJQi7FI3LkfISN8yXtF1aVXs5CePmW5PGusu8X8/TD5mtY6Q8hdybu5M7bHtP1w3WawAny3sK+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7267

On 13.01.26 09:50, Tobias Schaffner wrote:
> Introduce support for building EVL for the RISC-V QEMU target based on
> the current wip branches.
> 
> The current wip-riscv branches are based on:
> linux-evl: branch wip/evl-riscv based on v6.12.y-evl-rebase
> libevl: branch wip/libevl-riscv based on next

I would prefer two things:
 - use a head-based evl kernel branch, not v6.12-y anymore
 - only adjust the branch for riscv in the existing head recipes (kernel
   and libevl)

Jan

> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  Kconfig                                         | 14 ++++++++++++++
>  conf/machine/qemu-riscv64.conf                  | 15 +++++++++++++++
>  conf/multiconfig/qemu-riscv64-xenomai-demo.conf | 14 ++++++++++++++
>  kas/board/qemu-riscv64.yaml                     | 15 +++++++++++++++
>  kas/opt/libevl-next.yaml                        |  1 +
>  kas/opt/linux-6.12-head.yaml                    |  1 +
>  .../linux/linux-xenomai-4_6.12-riscv.bb         | 15 +++++++++++++++
>  recipes-xenomai/libevl/libevl_riscv.bb          | 17 +++++++++++++++++
>  8 files changed, 92 insertions(+)
>  create mode 100644 conf/machine/qemu-riscv64.conf
>  create mode 100644 conf/multiconfig/qemu-riscv64-xenomai-demo.conf
>  create mode 100644 kas/board/qemu-riscv64.yaml
>  create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.12-riscv.bb
>  create mode 100644 recipes-xenomai/libevl/libevl_riscv.bb
> 
> diff --git a/Kconfig b/Kconfig
> index 178db97..9f7f793 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -17,6 +17,9 @@ config ARCH_ARM
>  config ARCH_ARM64
>  	bool
>  
> +config ARCH_RISCV64
> +	bool
> +
>  choice
>  	prompt "Target board"
>  	default TARGET_QEMU_AMD64
> @@ -41,6 +44,10 @@ config TARGET_QEMU_ARM64
>  	bool "QEMU ARM64 virtual target"
>  	select ARCH_ARM64
>  
> +config TARGET_QEMU_RISCV64
> +	bool "QEMU RISCV64 virtual target"
> +	select ARCH_RISCV64
> +
>  config TARGET_HIKEY
>  	bool "LeMaker HiKey"
>  	select ARCH_ARM64
> @@ -58,6 +65,7 @@ config KAS_INCLUDE_TARGET
>  	default "kas/board/qemu-armhf.yaml" if TARGET_QEMU_ARM
>  	default "kas/board/beagle-bone-black.yaml" if TARGET_BBB
>  	default "kas/board/qemu-arm64.yaml" if TARGET_QEMU_ARM64
> +	default "kas/board/qemu-riscv64.yaml" if TARGET_QEMU_RISCV64
>  	default "kas/board/hikey.yaml" if TARGET_HIKEY
>  	default "kas/board/rpi4.yaml" if TARGET_RPI4
>  
> @@ -67,6 +75,7 @@ choice
>  
>  config XENOMAI3
>  	bool "Xenomai 3"
> +	depends on !ARCH_RISCV64
>  
>  config XENOMAI4
>  	bool "Xenomai 4 / EVL"
> @@ -212,18 +221,22 @@ choice
>  
>  config EVL_KERNEL_HEAD
>  	bool "Head of latest EVL branch"
> +	depends on !ARCH_RISCV64
>  
>  config EVL_KERNEL_6_12_HEAD
>  	bool "Head of 6.12 EVL branch"
>  
>  config EVL_KERNEL_6_12
>  	bool "Latest 6.12 EVL release"
> +	depends on !ARCH_RISCV64
>  
>  config EVL_KERNEL_6_1_HEAD
>  	bool "Head of 6.1 EVL branch"
> +	depends on !ARCH_RISCV64
>  
>  config EVL_KERNEL_6_1
>  	bool "Latest 6.1 EVL release"
> +	depends on !ARCH_RISCV64
>  
>  endchoice
>  
> @@ -244,6 +257,7 @@ config LIBEVL_NEXT
>  
>  config LIBEVL_RELEASE
>  	bool "Latest release"
> +	depends on !ARCH_RISCV64
>  
>  endchoice
>  
> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
> new file mode 100644
> index 0000000..96a0bc8
> --- /dev/null
> +++ b/conf/machine/qemu-riscv64.conf
> @@ -0,0 +1,15 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require qemu-machine.inc
> +
> +DISTRO_ARCH = "riscv64"
> +KERNEL_DEFCONFIG = ""
> diff --git a/conf/multiconfig/qemu-riscv64-xenomai-demo.conf b/conf/multiconfig/qemu-riscv64-xenomai-demo.conf
> new file mode 100644
> index 0000000..a789b9f
> --- /dev/null
> +++ b/conf/multiconfig/qemu-riscv64-xenomai-demo.conf
> @@ -0,0 +1,14 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +MACHINE = "qemu-riscv64"
> +
> +DISTRO = "xenomai-demo"
> diff --git a/kas/board/qemu-riscv64.yaml b/kas/board/qemu-riscv64.yaml
> new file mode 100644
> index 0000000..a659c2b
> --- /dev/null
> +++ b/kas/board/qemu-riscv64.yaml
> @@ -0,0 +1,15 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +machine: qemu-riscv64
> diff --git a/kas/opt/libevl-next.yaml b/kas/opt/libevl-next.yaml
> index b9c858e..d7aa62f 100644
> --- a/kas/opt/libevl-next.yaml
> +++ b/kas/opt/libevl-next.yaml
> @@ -17,3 +17,4 @@ header:
>  local_conf_header:
>    libevl-version: |
>      PREFERRED_VERSION_libevl = "next"
> +    PREFERRED_VERSION_libevl:riscv64 = "riscv"
> diff --git a/kas/opt/linux-6.12-head.yaml b/kas/opt/linux-6.12-head.yaml
> index 27d4845..4243c18 100644
> --- a/kas/opt/linux-6.12-head.yaml
> +++ b/kas/opt/linux-6.12-head.yaml
> @@ -16,4 +16,5 @@ local_conf_header:
>    linux-xenomai-version: |
>      PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
>      PREFERRED_VERSION_linux-xenomai-4 = "9999-%"
> +    PREFERRED_VERSION_linux-xenomai-4:riscv64 = "6.12-riscv"
>      LATEST_GIT_BRANCH = "6.12"
> diff --git a/recipes-kernel/linux/linux-xenomai-4_6.12-riscv.bb b/recipes-kernel/linux/linux-xenomai-4_6.12-riscv.bb
> new file mode 100644
> index 0000000..431daa5
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-xenomai-4_6.12-riscv.bb
> @@ -0,0 +1,15 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require recipes-kernel/linux/linux-xenomai-4.inc
> +
> +SRC_URI += "git://gitlab.com/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=wip/evl-riscv"
> +SRCREV = "${AUTOREV}"
> diff --git a/recipes-xenomai/libevl/libevl_riscv.bb b/recipes-xenomai/libevl/libevl_riscv.bb
> new file mode 100644
> index 0000000..a025dcb
> --- /dev/null
> +++ b/recipes-xenomai/libevl/libevl_riscv.bb
> @@ -0,0 +1,17 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require libevl.inc
> +
> +SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=wip/libevl-riscv"
> +
> +CHANGELOG_V = "9999-wip-riscv"
> +SRCREV = "${AUTOREV}"


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
