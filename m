Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1823248886
	for <xenomai@lists.linux.dev>; Thu, 28 May 2026 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953926; cv=fail; b=b/onF3gQfkDmvqSRB86nL15LFxRzn2WUgJFjosFpxqCV2NMFEUHWN/+8DodG7Pen12lQqnwQ8CtBZ2NxuaVH95/9nRxcdpW6mjS67uRrvOxK8JmCvzVow9V0wxgFmzOaepIu9bZtEXoW7rq+5InRGVPbdHRRsR8Ten4f+/qhO8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953926; c=relaxed/simple;
	bh=D2b0jinkxocQFPZXzDMqu7DG1SKPiQoNNkj+8qwJdvc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X0Fnjydva1jBVEGI2mgVywbZvtnl2WOrPOG1Hf1cecXCh1Rc6kswmH7cQWtDh+ZgitobUj8cvyHsRaXKJ0KodkqwvZwy0SwaroavK3LtihQQ5IFSeOjp1aMPHos1CGBXsMkjrkpuMyDV8a9qcJyN289i5OfCAPyZIkaDIzUzQ5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DHttrgyE; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DHttrgyE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJHq0VwMRuCjxoq0Fv5/N0lVc0VzgrkgXqNEhKW9t8ESvuitLhed7G22yOOirX/d7Mf6cmG4ZonLhXiTvq2QUGXwBDrzRKNq3Kv0FmHNuILZvDxn+9dCpLsyIOo7G4vcDcZaDArUwIJ3KwKoLsToseJDBBmKZ85U8+LkXDsHMzdetTFQo1zmFCTIUKq7RzfWvJ+gBxW10hcsODtMypKIXX/d+vjSaOLVQrLqp9rXV9LUSm2mmKF7OAIR/FTCSswgZ2KEjsKKCPuLw/2j0pQ7RA2nhxV4XYRo6+sY+iSVQ4YfHpKe1UMvO8wmE0YrIinm44z9ugZnPdGDSMuVKqwnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9WgfliZRRlNmIET+nPq2pZHsQR7Hqg8dU69OslC864=;
 b=az8G8PwPOHZEhVJPTDD3Kxf0s8qgrazKdzKLVR9gQV5yyhCxPNuzMcTsPDpXj4i0D5Xfe9vvN01gJ6BNCW7dXfvOFKWjtSUy7tc7Xpck8CSKhBL3JvS2YlLhSpvYSf8/+mAQDQPMF4vY8ZqODZLplLOKGPA4yfZGTCEOkIMP+kv/cW2l/u0b0r1QBAP+aa8mSsskYaW99OTQbLtfyClfeTRsiNldNxn+9rg+zmyfDtPngDpYNDHGpkKcn7kRa7AtI47kt0lO5MSO66Ph7gqjvKske2NXOjvWaTF/pc7zsTMuTpf8pvxfiE6XCVgkCJ1AlB2FCUFoqjdhqr6aKK853g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9WgfliZRRlNmIET+nPq2pZHsQR7Hqg8dU69OslC864=;
 b=DHttrgyEr5zSI2S8dnAGV1h3vW2I+XjpCvUz5jFb5XRmmOzVsXWFb12Gm/dYe7pnzQMf+rfjSpcDvKv3jRMGZf8rkmydk5aLkcrL02z166scMTSedn5Nd9mFNQDkcC0pTWA7oGzQhEkQ7tG/DepNxGKNCofEeRTa+ROYNpcnonkx72ypuXJX4/vjMzloRWxXMyUdUEdG05/ntYW+bukgDB18diSEQItxqYJl0P5ME4o0oEQOxLvLACrnjQ3CKTL5YA58oYcURGkWKnyfz7Selv9sGSH8Bw1PSWLb1+heDCULxMhujfBpqmBCqHQ8t2KKtt+WY5gM+zXyBPEsenR9Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:142::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 07:38:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 07:38:41 +0000
Message-ID: <8a1d6f8d-5937-4d24-9c3a-11cf70d9e050@siemens.com>
Date: Thu, 28 May 2026 09:38:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add support for Dovetail >= 7.1
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260527-wip-flo-7-1-preparations-v1-0-b65d1304bb6b@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260527-wip-flo-7-1-preparations-v1-0-b65d1304bb6b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3559:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ce05ff-a307-4637-2d92-08debc8c23b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PqpZc7UUbvDknnOe9MCTdzLhbM6EPTETowqvxIV+soSITTJ5kajRgFrug4aOQJ96whTOLOj8AKOt+72euYR5ZQzvmsuRNPZNt4Tz1et5Uqkf9ACWVEbMJ+2vvruBqT7JLIYmV/ZU6djPQMxbZqrbsrSVAz6KvAgr96qhkRc+WgNQJte0hazsPAOyesXmgV1FofgkKY6N4wohw8lFlmaTMGeoCagvFtuDyed8gbGhqyGdQsTSq6UQuHd59uzOSaGIaJl3sldTzlj2M725H8vk2eWOB14E2hWdZM7eGpukwd6yBVEokKkekOUVeFpCibqBlwDxnXW60KUwOEqxyZl1y7d1pwSPbaiLywAHyGGSV5xxpumf+790dX2al8Terml/miYoXunxyWjga0DKPZ/d+yewCpXRx3TAfYZLTG3bysreUFamXYMGbh4a4pWF7WbBLByg+sjZYmYBkHolLAbHhAjFFVej7l2h90N45lMnV1ATJ/zkJFhLKg6i9JOp6Wcenm4QlMvSXMvK9D/qC1LrX9t9XuwU2YbyuzWgr7gYk2rnvg4z4vCfa8IirSOlPlaDghiH1kYh/5yNYzEX7bX57iuNzTFbfv5w6+XTNp18Zhf6UciSiZxMx8aEe3UXMHV2MYI9ujqgto9b9hEZNmR0gkrT/eeNncF+rY2yKqRaUWStsgNovX4gD7SRR+UuPOpm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnN2dEtFdEMwcEUraUticlRmSkV4SXU1VDRiZWtKb2xsQnYvemJvT3N5VFF0?=
 =?utf-8?B?VVZ1YUNhZHlGZUg0cHNac2grVFd4R3VNNlNIVEVXUEFzOTVMcEMvdzJuNkZz?=
 =?utf-8?B?L1htMHltNHVSL1p1V2lXcXdFM1RBRDJzaCszaENLSHZjNG5oTVVUM0w2YzV4?=
 =?utf-8?B?R0JYUnpkYzU5ZW9wa01vQ2ZoRTV1TmdObFJOVjZYMFhUMHVraVdwSmZneFg1?=
 =?utf-8?B?MWgwUS9ZcS94UTlTMUI5WUVxb29qaW40enRQdFVQVkZRTU1Bc080K3ZHQnN6?=
 =?utf-8?B?STUyb1lGNFNrSnZZM1NVbDNPU0JLRk1NTjlNWmMvajN4WlBPSysvSlRGSHdG?=
 =?utf-8?B?Ni84VndpNU5SWjFFdy9lcjdJNHgvYTRlL0NnMDg1V1l2UUp6VDRXeE0vTURE?=
 =?utf-8?B?UEVqN1NTalA5SklJL0xmYmZOTERNV1ZRb1pnTHcwQ29sV2xScmMyaGRGdWtz?=
 =?utf-8?B?TGlRQU9ReldJOGFOSXg3bW42c1BHcjdIdGZIdnd1QnEyWlUxNmthSm5rajNG?=
 =?utf-8?B?UjIvVFgzbXczeEQ0Uzd0OXFoSVpjOG5WWWdaZklCRm5pTzVQSEM1SjhSNWNr?=
 =?utf-8?B?NjhOd2lvK1pNa05xNTRMUmR4dzJZWU5jaDVMRGdLMVJpQ1RKcTBQV0E0TFZR?=
 =?utf-8?B?V3ZkamtSYkxhWkJLZEdidmx2VlZsdXNYTFVONHNyeHpXVGVCd1ZEZWI4NXBG?=
 =?utf-8?B?UVZNYzA4TEFMRGdWYkZwWUMvSkdNb0pqMFl6MUJhY0ZnMVU5MFpKSFc1bE5R?=
 =?utf-8?B?L2VrbVhyTjRqK3RNVk5QUGFPZGQ1SGpCUmQzcUl2ZlFBSVVMTmxGc2dGYnA3?=
 =?utf-8?B?bEVqbE5KQTdCSjBkTGtNQVNuRjlXM2VEbGtvS2RoYlp3R21uK0lqL0JnZVQ3?=
 =?utf-8?B?Vnp4OVpoSEdYWmJkK0FoRGhCNjZFVTJVY2NvaGQ1M2ROaS9rbzZDSGdJNndk?=
 =?utf-8?B?SWVHMGptZ1NiQjh0MmFtT3g0Q1pVTDFxbWszK3ZuSGVjRURTYm9LNDVLbUJV?=
 =?utf-8?B?UnZqQXJ4ZFliaFJibjZmVlRWaklIN3JvZFdycTYrR3hzYW8xTFZnRTFVZDFz?=
 =?utf-8?B?QWlVQldLakhEUG9nOGVXeVZMM3B4TzlqTVBHaDN1WDlRbHpJY1Y0dHltRTJ6?=
 =?utf-8?B?ZTRQWkl1SktCSEs5RVdjbE1vaHZyeUl2WEpmTkJldkRwQ3JqOHFQVE1IbkFl?=
 =?utf-8?B?RFUxWUUrSmRITVJSL1lFZUtIdlU1ek80U3dJWjNoV2pwczN5VklXNktLME1C?=
 =?utf-8?B?eFNveTZuQ0h1NHRkU2huc3k2bE1HRlZhTWRQNHVpa2VxcVpWdHQ5ZmRuTzVQ?=
 =?utf-8?B?ZGcrU0RKZ29YWnA4aDgzSmY1cW1jSExET2tNWWhXbUhwV2FKMzNGemdsdjhj?=
 =?utf-8?B?ZDFGOHh6WHlrUnJhelZmYXlTR0VadnRFZ3hiV3c1bFU5YkhHL00vSWttd1Ni?=
 =?utf-8?B?TUwrNWRJVVRjakdsK25ZaGRUd3I2czZVU0NyUUMzVk9YZ2tjc3FJRXZWTEF5?=
 =?utf-8?B?cFVsaThvYVdhSnRJdmRuNmdtbFUyaFF4QzFVQ1c4VGk0aFk5aTNZMElPRjQz?=
 =?utf-8?B?K0hoZFc0bDdxSnNTNFhnUE9tSm1IQWRSUXVxRHViVFJ1YmJ6WjZQTythN2xJ?=
 =?utf-8?B?aWt6V3dRcUJsR1RXWk9KOUVUeVFHUDFCVlJTd1c3ZGs2bTNCYWN4ek5ERFc0?=
 =?utf-8?B?SlNsVk00K0FTb3NielhUK3Q4QXFuYkFvYjJMS3V4SWxJenAyK1J0aVUvcVVx?=
 =?utf-8?B?a29yQVR1S2M5Q2VIdmF3UVNyd2ZyblNlK2xhYVVpTUtWTGdFUjJXOThYRXpw?=
 =?utf-8?B?R0t3UzVCOWVtVWI4bEdhZ3hKUVBmQUlrL3dnOVIxVmE4T2ZhUVlTTnRvbkYw?=
 =?utf-8?B?YmZHcWNwbmh5TzFTZ1Ria08vTGJzVEpKNitGSWFacW1ESWI0ck9zT0kyS2sx?=
 =?utf-8?B?WG9VWi9wNE5vVDl6VXplZHBBaDZRcDFSZlAzYzVkYUozbjVpcnByMGxFb0ZB?=
 =?utf-8?B?dkEzVVE1cTlsSXJ3cmFCdUV0L3ZJaEg5dzRUeEwyL2ZLUktGY0t2azFUdTFL?=
 =?utf-8?B?S3BZUS9mTXpXdDZkRG4zSHNCemRQVGZjUjI3bm5WZ1FEbWFEdEFXRDRUSUtY?=
 =?utf-8?B?OFlPT0FKNkRGZlA3cEN4VllQUVA5RnAvN2xXQWljaW9QT2JJSllzQVd2bWJn?=
 =?utf-8?B?RmcxL2xkWG44S0dFczFBQ212UTJ1YzhueEZTVmU0T3J3QXdVRm9XSGVkSUlN?=
 =?utf-8?B?OVJxYnhNcmV5SzhON0xlWFVITnB2b0hCbjdCUzRVUHFUTVFDbU92dyt4ZkQ2?=
 =?utf-8?B?emg5Y003RnU0eTFrcFV6eGF4LzBuSVIwYUlQMXREYU56NmlUbWczZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ce05ff-a307-4637-2d92-08debc8c23b6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 07:38:41.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rorL0BmdIBDteFAvCw9hQYlLJR3vEO7URIjA+cT5TxKwfqIHWk3/olJ4oDKLppVqe2ILc3ylme1FRqkrxFqxzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3559

On 27.05.26 16:07, Florian Bezdeka wrote:
> Hi all,
> 
> These are the necessary changes to support Dovetail >= 7.1.
> 
> This series has been tested against 7.1, and 7.0 to make sure older
> releases don't break. But: It might be - I haven't checked all supported
> kernel versions yet - that the SPI changes need backporting. Waiting for
> a full CI run to stress those cases.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (2):
>       drivers/spi: Prepare for linux/of_gpio.h removal in Linux 7.1
>       cobalt/tick: Prepare for removal of CLOCK_EVT_FEAT_KTIME in Linux 7.1
> 
>  kernel/cobalt/dovetail/tick.c                        | 4 ++--
>  kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 6 ++++++
>  kernel/drivers/spi/spi-bcm2835.c                     | 3 ++-
>  kernel/drivers/spi/spi-omap2-mcspi-rt.c              | 3 ++-
>  4 files changed, 12 insertions(+), 4 deletions(-)
> ---
> base-commit: 9fed9de228841e7bc6e3f55fdb44374f15acddc5
> change-id: 20260527-wip-flo-7-1-preparations-7d20c44c9169
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
