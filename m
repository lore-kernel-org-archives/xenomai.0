Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2E2BE641
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247335; cv=fail; b=RijcGcRnsuiroHEmUoR2d7VWpIEs9MQ1SepuJfUN8jBnlIXYdnfyuNZPnmrrh6JMpNGNldtx3/exsZigYPem9xAtzH2GTGlUZmLCPKiHo8EEDOeCmefsg6AFKfCsAc5uA+9MM15MJllTE33/UrBN3tAY8Eby6V7BwUU8Qv74E7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247335; c=relaxed/simple;
	bh=rlLEyFd91p8sNiEqq6ucTGJslWUhN+QjqUXAZGG/5yI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=noDBWDyR2tWH6KAaxYfawA8pNFAHPBJgdlwmJyFmq7oDjDurvs7WBe6sWsULenV1HUsCuPuxy/0HYKCi/48GaTRFFK95ul9IlLlyzI+Q/Ve0r9x+7MOUHMdZVySwuaalM7s2EG8tqeH5xVPTMhwry4YJoRnqkNiL5l0JXdgCwog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aOrLf9t5; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aOrLf9t5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBLk/+r1ofY+O0refmfYZidMfvvs2VfWKVL8St8ugupRhme3o+7CIuhTgQI02mtBcscQZNJ56arbwRkr15z4FLPaSCYIXxNtGvULg0b2iJi43uNnvlzvhSOKNenzdZbt5q6xN2B4UTxjsKmxAV3paO5t1YPReLP6YFhm510Zr3uuqWt2UHznx3ulXG1cPDHIsABcjknn1/hZ1x63T/yeuPKQh4TsMwVqE3/ODt5qzscQL703G4vsC/dNIJ/ykXFQ+NAMB+ZoB0hIKHxJ5U4ijaN1hBl2/J2Fx/4+jhzqUevsi7RntV1eMwHUXIv95JsKJfYmiR++YnZul5E5ykM4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXtxORy30jzF/qEO4USh0vk/bnKvrVgqU4TZu3dRR7o=;
 b=BXzDlkhCqlKTUg0Hknvh3sPQO1w1EbPGUkiaeHNEOSulYdAcEurZ15l85mt7gMHLhtncY/YaNaFckwjgs2fnmFwF3jQQZLbJoq6tFCJwHY/VfPprE3AAEeY6hm+FtmQqMuCK35zt4qquy6LeSO9SNvU+NFqfBN7zwoQW6zPZLFC1LNVcx2iM4V9atQHd/5R577CDS2vdjwSeB2CKypZA6LxEt74dNMewDPeszETrK//QrrmacLRvGc7sjOVYkU3HxyHhGccBb/nrt91lqieJwuolIM2hH+Kj5084dN48exPaD2LoWXpZpa/epkx5ku302wZXXGjRBNBwSoZlW7+P/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXtxORy30jzF/qEO4USh0vk/bnKvrVgqU4TZu3dRR7o=;
 b=aOrLf9t5NpWvQ94x1JcswHgmyhvtfn1OZn8J0SLGameIqY8HRsNHPMbwur1h3IivNh6zVsXNFrhmDFtoccZ6S3doeKfkltsQIXBqnnBnoT/FxaY+zCGolDLDwBZ0N06HKUDoLrmzHH9Kr9Rsu4whrInp8tXnvKZnuldlbjSUFvkgcnLklqRXOHwIGiwY4VGSU9fniFTGje3+klFvTk9bd1ekSX8Bg1cKKdDbdKyXAU2XfeyIeQoMqkw03uWWm6XUA6ItMaVRiZpqNdso/9ygwNXk6qaKPW/M8StMfhfcEd00qQ8fKzsF/FdIuO2bE2Z6hQhfgibPio9ICeuxvGddxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB5PR10MB7722.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Mon, 16 Feb
 2026 13:08:51 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 13:08:51 +0000
Message-ID: <90844c35-4fbb-4921-a9c9-a6864c383903@siemens.com>
Date: Mon, 16 Feb 2026 14:08:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: irq_pipeline: likely/unlikely macro usage
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <ce7ec09c-1db8-4ee0-921b-34fde4c0f59c@siemens.com>
 <edce8462-588e-4068-bfdc-fcc4f6819b52@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <edce8462-588e-4068-bfdc-fcc4f6819b52@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610::37)
 To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB5PR10MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: da8d7b97-6f88-4193-1abd-08de6d5c8757
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXlnZ2tDd1l1T1o4aHRyQ1ZUWlYyZWFVZmVCYmMyU05MSHlYQkVzeVQwc3h3?=
 =?utf-8?B?dmczd0FEOEV5ZDFaNTIrUnFkRXRLSi9OcURRQkVhYWN3TDhwRVh5dEFCNk9R?=
 =?utf-8?B?NG9SRjhhalM5V0pJYnAydFNlOU1ZKzBUTTAzRkpoSXpsd0FQVXI1Szl2cEpK?=
 =?utf-8?B?QjFmZGZyWWR5M08wY0xYeU1pWHhXbWpQQ09DOGhpSUhESVhsekFxcEJDNEIw?=
 =?utf-8?B?L0dDQ004RUw0bkxFRXIwRlhEeCs0TURqTjRGNXRaRnpMeVVLS1djVDljcjY5?=
 =?utf-8?B?SmdxVzhyZHZWR3llZ3NtRkUyQ2FJcS9BQ0h5SU5yMFQyNndXeEtwWXkvZURq?=
 =?utf-8?B?NGpESVFqbmtMMUJDSFVSdG9OYVBpYVVJczlnc3lZdHZHdkwyRWsyZklwMi9K?=
 =?utf-8?B?MlR6V2hSOStnVUdGUGFEZm05aGo5eGQ1MmF4R096MHp5QTFTWmlxMTkzYith?=
 =?utf-8?B?Sld2Tm5XZFZpRU9xWkJlQUVGdnlXZ3REb3NhdTROMGRkd2FMSlMwSStJWEFP?=
 =?utf-8?B?OFhDRHRwc1BFc3V0K3ZHM3R1VFY0U2JRcTZPY001RjhYOUJ1bFBlMDd4QUxI?=
 =?utf-8?B?R0dmdXJYM01xS0xkRmROS2I1L29ScDN5T1JvSGN2OC8zTCtxTThxN2tCQUhS?=
 =?utf-8?B?dGlzeGNYSGpxM0Q0Um4yK0YreFlqQ3QwSXMwM2F3dkZhc2FzeTRob2Z6YTZV?=
 =?utf-8?B?cFVQM004UU5FOWRuNkN5aDhFY1Q3Qi9XdkI2Q3ZwUll4OC9VVytDTXZJZmNH?=
 =?utf-8?B?eGd1ZzRsaXpUUzF1TSs0S2twdHBvNE4rMDFoUzlnZEo0cXptWm1rSmRuNnF4?=
 =?utf-8?B?VTRnTEFGOHZ2ckpzU3pqTy9lQnBKZVRtWW5lVmJ5aUtqUlFXaXVoUzJrS0ZQ?=
 =?utf-8?B?TVZoeUwrYkxjOHFObit0NHV2SU5KdThGNkdWL3pRSFNETDIvS0ovb1NlSy9I?=
 =?utf-8?B?K2U4MzgweVpXdTA3T1crTTRjVDcwSVF0M1pKRkd3U3pNdVdSYzNnMlBNTWF4?=
 =?utf-8?B?QnZiRUZXdm5IdVp1SHNDVmY0UkxUM2k5M1JZQzRVaHNQRnRJcitGak0vY1dQ?=
 =?utf-8?B?VytZeWh6Nm5Fa3BLaGl3bVB1b3V0OEY1Q2Z5bUliNWw1Qk02UW1MMlN3cnVZ?=
 =?utf-8?B?TUxDREthZjBZREFnV05zbWVkbFc2WlBaSmR0cEFydWVIUGV6a1NhS3JQOUZl?=
 =?utf-8?B?dlZ3REg4ZkE1NUZhb3lSNk11WjI0bmZyNDlHY2I2OXZHR0loOUZnVHc4UkVp?=
 =?utf-8?B?V1p5UkJ3VFpqUmdsN2tpdElONG9hanozTkpCKzZpQ3FTOTFDd3ZSRUUyejJt?=
 =?utf-8?B?K2pwNndZQ2xqd2t2L3cwTkJDeHJ1eXRQZnErN09LeE5aUElwaTJsem1TUVZO?=
 =?utf-8?B?OUl5OUlXelFOcEIxZzRqb1E5cEdNSXdLc25yYVRtZXZSYUxaM2FUa2IwdDRn?=
 =?utf-8?B?UDZJVHF5TWFqeXpRbU52NlRsU3loSUlXZE5aUnA2K1J5ekppQkJBTW5BUGd3?=
 =?utf-8?B?K0hBdWxwSGl5MG1zOE1zWFdodGpIbDFVeGlNblBrMUF4OEIrN3RiTXh5OStL?=
 =?utf-8?B?WWhsSE5uZXBDd3pmdWdKOHhRdUJMVldkYmxIUzk4Z2x4QWR6QWJIVTdwVWdY?=
 =?utf-8?B?NUJIOXppOU8rZjh3c2xsSWllNHJuVmpHWUlnWHU3YThVZEt2M1lrS2kwQ05E?=
 =?utf-8?B?MWpudEkrRHpQQ212VkxKUkRIVE55R1c4bTkzU3J5alNtenZodEVXY1dhYjNX?=
 =?utf-8?B?ZGhTMFloWnVydGQrM2RuQnplWGE0QmJ5RmFJMHZrVVVHZ213Qk1TYVV3WVVP?=
 =?utf-8?B?SzdaYXhucERNMm15SFJCREV4bFc2Si9yV2U3YXdqT2NsY25QWUMwTk5ZdWRz?=
 =?utf-8?B?VG8rM09Jb1FDODBMRG9HUWJKQ2R0Q2R2VG9GQ0pUUC94UFZsbHN2MzhVVk5R?=
 =?utf-8?B?ZFZsdDc1TmEyM1NWanFoZnhETm95S25uZC82dm92NUI2RTFJUGswY1NmRExy?=
 =?utf-8?B?cE15d2NlTnp3MjluOGFtMWxiUkRrTGhHNENJZGtSS3U5M3Z0cXBFaGxNcTBt?=
 =?utf-8?B?eHdhZ25TVll5M3lvMzB2dk1QRjJhaG1nUG5xbFNkT1hpaHBKRFQyTVpVRkxP?=
 =?utf-8?Q?yOZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTcyekpFV2dibVR5M1VhMXA1emRCSi9rSFFobkdrY0Y0bHRnN0p5U1lLamNL?=
 =?utf-8?B?eHozL0RVb1Y0MjZGN216VnhkTHB3cE5MeUJIZTBWOXRRWEpBOTU5Vk9zb05O?=
 =?utf-8?B?ZU5hTFdLZERKbW5KSkJ0QXcxZzFUR0Jod25CUzV1S2dzVjBGTk85ZEZqWXpp?=
 =?utf-8?B?VXJDWG54eSs4OHV5TDBDVW9OMlBnZmtnSXMvS0szd3RidjNWSW9yZ2NWakx3?=
 =?utf-8?B?THRhZXROUm1LRkkzdDJTQ1l4ZDBoSytKcHBhUWMrUEhlQ3N4YUhVenVBVkE3?=
 =?utf-8?B?WFNxcURvV3huYTh5VURqM3hBbVhVc1NDWEpvNVFIejMyU29QUndhalliZ1U5?=
 =?utf-8?B?WnRYN2ovdGVKMDQ1NmhscllNT3ZTWWEwc3lydllYbG1xVWN6UnpjbG5YZitC?=
 =?utf-8?B?K0FFclA2bTJaSm82SXVHRmt2VVFMYXN3SmRlUGdncU9ycmVYcWszcVNxVmFp?=
 =?utf-8?B?ZVZibVkxcktqdm15SDdaZlAzLzlhTUdrQjIzb20vbFNnMkFtWUEwckNxd2hG?=
 =?utf-8?B?RkNtTEZzTHEreFdnYjVjRlRjcTNGcHRtZi9Fb2NDWmlyRXJBWXd5S0RDZlVo?=
 =?utf-8?B?SXkvbHVYc3YrUDFXTjB1Q0djZnVVd3g3Q0c5ZG5wTXowZ1lid0FWWUhMUGdu?=
 =?utf-8?B?dXVVbGNwbFdMM3pRclpKQWk5bGFNVGxUWVRSZGtBenpPRVFoVCs3Z1VZNHdl?=
 =?utf-8?B?ak8wWk9KSGE1ZUx0aWo4L0hXWUIrZi84bHYxT1dXOEpweC90andOWFBiK2Rl?=
 =?utf-8?B?K0Z3aUJpUGJ4UmJNZ2hPY0Q2bDJadUdLbGxlSlJyRTZFM05nNEtXNVc1UEs1?=
 =?utf-8?B?R3hHM3F5VSs4MXYzQ2NFb2ZERWRRTnV1Y0ljdzIrUUgwSzIxaVZ0MkZTdnI3?=
 =?utf-8?B?V0FkS3R5UVdyaVBtUkFpQ0pBTlR0YThGd1VIM3g4ZndQV1hndzZLeXlrM0VT?=
 =?utf-8?B?dkFNTnU5T3g3OTFwSEVZNVlMSkFFaTZwWHJaaEVNaGxtYUEvQTJ3RUsySTZF?=
 =?utf-8?B?MDgxNnYwUGIzY2ExNVphVnVOcVE1cVg0OVgzV2FlL1FaSkFwYXNXRE9IU09N?=
 =?utf-8?B?djNGVkxkYnRQQVFmYVhscGNjaUVSTm5NWDJ0dm5rZEZLRE8welRaRjN4WTdr?=
 =?utf-8?B?LzhFS0FIbmYrUHVhSHJqVzRPSzV3RnlweGVTWkZncnlsdDJTb2M3bWtFc21l?=
 =?utf-8?B?NjBJZmZUbDU2Y3R1VSs0Qnc1dEhncGFTSDY4bENqL0JrOE03RTJ2V3lldDB2?=
 =?utf-8?B?QktLVjNxN2ZVYWNUbGVJVkJmL1pockUzSDQ4ZzJIUUR3QVExbFhXL1ZhRG9R?=
 =?utf-8?B?bUMxeElxbk5XZHZyOWtSZWE1S214QzhBa0tUYURLZ3lqZWxZRzVFTzQvdWlp?=
 =?utf-8?B?L09vdmpqNndFbmRjY3JQVHUrWm1BZlU1RnlFS0FuWW9jZHNJS0VKcGMwbGs5?=
 =?utf-8?B?NFV1WHNQaE5BamQ2ZjZhUzErcFlZbFZRWFZwK2h2V2Q1YUtETHBReXVoSDVo?=
 =?utf-8?B?WTMxd3UvMDFHZEw0cDFnZjJ1aXlUWkJ0ZUhIUjRGeEdITzBCT2NjYm5GZmVV?=
 =?utf-8?B?TzNaZGI1Q0xVN1h1ajRkcTN5Q3FxODlRMG1QcTNxclhoY250TG10dlltazVY?=
 =?utf-8?B?SkErbVBOcXlBeWR5YUtUSkVEZGFocDN2M3pmeWhXMW5RSVA2R0pGYnJ2SU94?=
 =?utf-8?B?QjY2b25teFJRUDRIRkROaEdrYnhoTXVST3QzekZGT3oxaWtUb09nOTZxbUpY?=
 =?utf-8?B?ek9aR2pONUQ1ZmhQUVdaS2gxZ2RlNUVWOHl0NWNjd3NuNEZ0MGcwaXdnQUtx?=
 =?utf-8?B?ckZQbVBhN3pBQlVXVkVzaHVFZ1RsbTN4NS82OGd6amMrdnlHMmVMMVF6bldj?=
 =?utf-8?B?eG5KS0ZzTEFOTDVCaDVaNUFoTmZYYzJwQWZIaWdWR05YUTc5NVBnZE1yT0Mw?=
 =?utf-8?B?dklLNVFMeSs5bkU1eDl3MjRuR3BEUWc0S1Z1c0FIb0Z0TnNqcDVwMCsvcVE5?=
 =?utf-8?B?V3FTa05CdXdWZmZ0QXNEZmFmN3lYWVkvSDBtRlRwdnhpQjV4Mjk0UUkyaW52?=
 =?utf-8?B?Y0t6ZnBSWDJ6L0thK3hNQWZNS0l6MzhYbmEya205L2FKQ1c2cHdGY2ZjZk1D?=
 =?utf-8?B?dlRyUy8rSFl6aVJXb1ZzQWkwd1lad1dZSVNSWGRDNHBwQXRwM1I2WjNFYUs3?=
 =?utf-8?B?RzdzTUdLTFp1MHpKSk43cERTUGpKN3NvRlkxbDRmM0ZBSWhKbnBzVzYvTnRv?=
 =?utf-8?B?K1ZFeGlNODBWRVg0c2lFejlWYTVONmk2MlZMKzNmZmZGZnMwUUg3ci90K1li?=
 =?utf-8?B?YmVVM2Z0ejQ5MXBJVEdZWXYxdHBnQTdtN1dCY0dFQnAwbWhnd3psT3NyMG54?=
 =?utf-8?Q?uEojifZaK8GgFZY8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8d7b97-6f88-4193-1abd-08de6d5c8757
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 13:08:51.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1BkToz1OChOp8gbia2PCiet5a/7aISgxs27XPpWuu7L9l+0FX2qlHVT2qZYBa6Ps0RSx3E+aM7HPe0B0l0WHlTY2vpgqMJgnfsa7FOfCNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7722

On 2/16/26 13:51, Jan Kiszka wrote:
> On 16.02.26 13:26, Tobias Schaffner wrote:
>> Hi all,
>>
>> while staring at the irq_pipelining implementation, I noticed that there
>> are some locations that use the unlikely macro for the OOB fast path,
>> e.g., [1].
>>
>> Could someone explain why we are optimizing for the in-band path here?
>> Although the in-band path is indeed more likely, I would have expected
>> that we would want to optimize for the OOB path anyway, since this is
>> where the saved cycles really matter.
>>
> 
> Likely/unlikely optimizations are generally tricky. They are hints which
> might even be ignored by concrete archs or in concrete situations.
> 
> If they lead to consistently higher latency for oob, I would agree that
> we should lean to that path instead. However, if they reduce the average
> latency for inband and practically do not increase the worst-case for
> oob, it might be a better decision to take that performance optimization
> because the worst-case latency is what matters for oob more.
> 
> But it remains a fair question whether we can answer that question
> whenever we added [un]likely... Did you find inconsistencies in their
> usage as well?

No, it does not look inconsistent to me. It looks like the more frequent 
path is consistently chosen. And I wondered if this is correct.

Best,
Tobias

> Jan
> 
>> Best,
>> Tobias
>>
>> [1] https://gitlab.com/Xenomai/linux-dovetail/-/blob/v5.10.y-dovetail/
>> arch/x86/kernel/irq_pipeline.c?ref_type=heads#L260
>>
> 

