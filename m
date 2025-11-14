Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1E2AE78
	for <xenomai@lists.linux.dev>; Fri, 14 Nov 2025 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763098722; cv=fail; b=FzDGCt/oTxd5jrFkwtzhmXiS+19PgAG+F1IfHUZYwmr5H9YObxbZx0ySQ1hxPhuMKPoGwI+TV/ob2U6QYxfQOgfhSNFlqPYCqFu81ok8B08xQ+uIAW4MAhTYml1tOId/5luL5czS+kpq7FLrrbRrYLv9vPj8UTgQxo52YGlU+2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763098722; c=relaxed/simple;
	bh=jvxZhNNHVB1Fr0bjMXB7TLDnkT+HWqXGSTeyx2esChI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqZcUYUm0HSBBWcgm/xbCdBfWzBF3eJM4AEl6S09ChxCTRC1zzPtHrGNA89Ly9BAXEie8rttwN2XgJOMn7Y6fNtoLKlxXk96gX5td9gqX29CjwUZKoHl2E1+FSo75hONW/hPkh7cuAGe1e50dYmtCkPp0aHmAyfRNeKrUR+ZIr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=V++9hW1k; arc=fail smtp.client-ip=40.107.162.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="V++9hW1k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0pjyL8e8iarCzXPmcYjY4iJ9hgHHfLBA7vMyO5MEJcvl5uHsKMvvuqv19H3U4O7ekDio5HcN2+7qg0gdZx8TY4wFb5GM8NlQ4wep0yPUpMjj13zoA+yqq8WQdIOI8/atj/MxUicZ8sXCCbqYAiZjpbjKt8ZYImmlwn2UwSUMwEQxl+1gvvSRra/3c6hmuZgJ7O5mV/gth0EoDRWtjx2GY9rxG8VGbGUQOCSuqph7XcytvQDAS0cwmEUETaC05Q9vZHayKcJpWKOus5mxFqtbJIJaaWMDL4Y7g7LXc90uPYGqHFBufTjSqVLb9n9/yt00HgkPyba9DlzKo4QZRHf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkXpX3JhvyofzIcFIWr4ePwUN+vGDymMotcNpiblzR8=;
 b=P0C1p/cIf1VqxUpDJZpP7sh/0GyCoeeGQNOL/FNcoIfdO4KQiorxfngJjN7dO4c9Rdy6OMeGGU4ezrUfxT0fScUuM33BMUY2a5ZTi/Mdfdt7RVc0jCGd2ltIAVhFWz8f4DwvdLcltrZDqW6kjWCQRfR70Zl9vjT/AyXRwfX2NToaAhEWswkE3W2355Oyztga78L7p5rX40CTUVCsBLgaQt2R7eZNwtDdxeZEGOxrvCYDGWBJU7to8dVnhL/Rsr5qTCMMPL32R9ufQe/zLPiNgidpxz2wky0X3K5EqNiyFbbZg8dhK9/OEBfh8QE1/SyNte476xaL3TysE8wpABwGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkXpX3JhvyofzIcFIWr4ePwUN+vGDymMotcNpiblzR8=;
 b=V++9hW1kH2Atdcx9dpHCvfcMclG6igOTKGmKs6YKT7XZx8EWCr1YCLdZSin4YiOI3MmQZbTkBqOaPcXpuDev36hfTmvrmY+WG9BXKJotGH4zEKwAUWcgyL2GoyaBWC8a4ftdnRDEgcBN2uNtwKkvMzDPiAi7Evqs5h4cPD3CAcoXfGAN5tzyGFfssHPFBqJGH/1CF2pPnCixLMrKinH/b2SZ7bWP/AZatI/43SKy9luFXYpjtjPKEufHkeuxMXl+R8O17Kq0WLuW39v44Y+PWB76hdJnXnNP43LUlCLKo3BzuT8lAzaMN+WpvueeCkOlF2p/ivaQgekvXQtY3SN5bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3267.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Fri, 14 Nov
 2025 05:38:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 05:38:37 +0000
Message-ID: <78da3e59-a848-4019-aa53-639f2ef22f33@siemens.com>
Date: Fri, 14 Nov 2025 06:38:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: schedule delay 15ms
To: JerryJun <jerryjun123@163.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <4c6fa8a7.4dce.19a76af1422.Coremail.jerryjun123@163.com>
 <d14c720e-021e-4fc8-8aba-340903db0fdf@siemens.com>
 <25a5a707.3daf.19a7b5f1c16.Coremail.jerryjun123@163.com>
 <077351d6-f855-4034-ba1c-3c9f2b713743@siemens.com>
 <17aa2896.2b1e.19a8043a959.Coremail.jerryjun123@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <17aa2896.2b1e.19a8043a959.Coremail.jerryjun123@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3267:EE_
X-MS-Office365-Filtering-Correlation-Id: 2222ccbb-487a-4411-220e-08de23400f65
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QldmaUtNYzlIdmFmYUdvM0UrTDF2RTNWWnJ2aUp5WVV1Wm9UcVRVYk52WTRX?=
 =?utf-8?B?YktxZFRGeTdtSnVOSkI4THBNaHlSUlNZdDhQbHJuaHU0b0pOY21YNU9pTnZl?=
 =?utf-8?B?WWhuaXhpQ2RuYzVrWU1yZ0lLbDJGZ3dkSFE2U3M2MXgxZzBodFRNK3BVUXhs?=
 =?utf-8?B?RnoyMUdSQzZXbTM4Y1FiTlh6RVhQbGxUc2t2UXlPdnZrazBzRUtGT2t2UWdE?=
 =?utf-8?B?TndJd0RZeWtPazArRWZaRjRDT2JQUkZPei94ZHlHWUNVaEk2TnhmL1UyLzBU?=
 =?utf-8?B?UCtMekcrRGJCOVZBQVVxMWhsRkRHMGlFQ1B0NEt1YklnK1ZYdGRyUmIwSkV6?=
 =?utf-8?B?MU9peGdGV0kyTXIyaGRBYVlSMFlVWTdldDdFVExmeDlyWFhvTFFWdVJJeGNQ?=
 =?utf-8?B?YzE3VUdQY1B5MDh6K295cXZ6QVBnWDBJYVlNck5nZThNU24rcXNlNGJ0ZUdx?=
 =?utf-8?B?RTNlUm12VHYxVWJSOGJQUWlkanV0Tk0xK2lreFZDbUhTN1dTbkVmK21jd1hO?=
 =?utf-8?B?STB1bmNDQjV1TGVZL0ZQUU82Z1l6cVoxZEZTWkNKNWFWOENldWJsZCsrbS9h?=
 =?utf-8?B?aHVOMzI4OEFwT3JiM21vbGZ2Sk92VXc5K0VtN0Z6NlFOcUs0eVAvSmp4NmJw?=
 =?utf-8?B?eDhsRU0raFZLNFhZdS9HQWRqbVQvSW1Tbk94cnZTY2dFUEJzaGh6MkZKN29w?=
 =?utf-8?B?VVliNHl2ZC9iQXVZY2pDWEpBTUxVNnRUc0c5NUVuRVZrZnZZR3h2Y0xtRy9V?=
 =?utf-8?B?QkNyNGpqcnJSRkFzRXJmZzNNTzlXQzdxemw1L0syZmhWUmZEL01VWGxQdmFM?=
 =?utf-8?B?Ri91VDl3S1duZDBoWnFieDJRNEdKT1VtUE1OL3NYS2lXakRSVWlmT1dUMDN4?=
 =?utf-8?B?TndOQ0ltSjlEaFJ3L3N4Z2tqMHlLdWluM1NnS2pyVnN1ZEdIYUdQOXNPMEs3?=
 =?utf-8?B?QjJGYkQ4L2hJRmlvVnFNcitxWE82ZXNhZHJhZVYyMkp1dy91TWJqQittaENO?=
 =?utf-8?B?S0tOTXVMK2RRWWRvTCtXbldWRFEwaTNneUhqbjBueGNraWQydG1QNnB1L09K?=
 =?utf-8?B?aWlVRWZCMHdvZVlESkEyNTk0bVl4T2tIVGd6eFpJK0FoSTlzdTl6eUNKZEJK?=
 =?utf-8?B?UFA0eDVCSVJDekdXdnZSRjZXT0FNdFltazk0S21Za09YdjVTNzlzLy9JZlAz?=
 =?utf-8?B?bThaNXZLdmN1WWFSdHR0YngzNnp6VVMxZjdPa0lMZndZazVlTjhyM08xdURK?=
 =?utf-8?B?RzBxcnFuc3hXbUkySXJvL2ZiU2dVL3VKKzJvd0RIWEZRRi9kdDAwekEwZGRV?=
 =?utf-8?B?aXNHam1aU2VXVTBQbEg2L3grZjBFaDhTL0JRdVdqaEpkaXJGU3hmd3JxWXlv?=
 =?utf-8?B?NGpuckVZZVUrT0QveGhXNiszM0hFWkh6eFo5a21NbkVrYmVHRGN6RDYxblIr?=
 =?utf-8?B?enlvTEwyVFFYSnFNRndWTFJMeWxLdmhuZ0o4Q21FMVNMMmtZc2JTcDlWaTVF?=
 =?utf-8?B?OXFOYi9Vb0JVVjZGcGJwUERlRWxBNzZRZTFsVFUwZFRJcVBqQ2FvWTY3dHdr?=
 =?utf-8?B?VW1SSm54TWM1MVc3cDRUbmx5NUhvaCtKRFZaY0FsY0hGOHhLOG9ib1VnT2RV?=
 =?utf-8?B?dis4ZFlPYVAyU0x2THIya0J2TDhaZ3ZqTmQ4ZWQxU1pFY2ZFeWZEMll5SXkv?=
 =?utf-8?B?dFNRaVhXOUNWWkk2bmFTSE5rbHQxWWVNNHA0WG9Na2NFTDNRUFA1SXhhd0ov?=
 =?utf-8?B?UTl4SHFjZEZJYkN0VGJHMjVKd1dUOHNPUEZDT0NYQ1ZCRGxzdlVYOVZCUkpm?=
 =?utf-8?B?RXV6Tm5zUC9HZFNRUldvY2g4UVhlK3NOd2FHeXlLckREVWtEWnRiczVLWHhk?=
 =?utf-8?B?K09GOWhJSStpZWNMa2tBNVNkZUg5dFJRc0NJN0VnQ0ZxZ3FhWTNyd0V6Q2hW?=
 =?utf-8?Q?8a75YUWJcPND3foA8C/6lBsasdyuEcHZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTE4SThQR1l1L0pGVDhHOURqOEFPTXdUY3Q0RDBuTy9qbkt6K0xJaTdFM2Z0?=
 =?utf-8?B?ei81NGVmdVF2NFVKOWlFdm5ZVDA3bVc2c1RYSlIxbklUUjZ1d1I4OVdRVjN2?=
 =?utf-8?B?ZW1zZFpZRTA0RFM3a05VTGRvaDdMS1BzQ0xUajBJUWpRZGxlSDNOSDcyR1Bq?=
 =?utf-8?B?dGhkaGFYQStLZTRqZCtxSzgya08vZXdSam5mcUJaUlZMOWRNK0tNZ3RURURt?=
 =?utf-8?B?Wjd4MHc3WExHOEVUR0tWdEJGMWJXYktBNlBDeEVYbURxaFA2eEdvUExBNFNz?=
 =?utf-8?B?L05yWWpUWUZxcXU2U0sxNDRCRXNXaEVqVHpGeEMreG1HNm5QWjVDOWozS1VN?=
 =?utf-8?B?UE0xZmdjYmQ2eHVjV3ZTbXRjdEFkWXBEdEVmOXdObmxRS1Radmp2OEpFNi9E?=
 =?utf-8?B?VERWVGFtVC9rTHpEVFZIaGtBc3l3akx6aTNCRlZSUE0vQlo5UnVoQ09ERndh?=
 =?utf-8?B?bXQyY3U1UG1lUWQrZEFPaU85TnJEOVp1Mk5rNmdNZ00xaVFrV2RFSDVJQnBU?=
 =?utf-8?B?VkRXSTJkVW8rNGJLdm5sS29ZeVZMTGoxRG94NjFwTzVlUkNhdEJVb3hMYnRv?=
 =?utf-8?B?MDJVb3BVcmZxOThzbXRDTVN6SVMvRW1pMkJHYlZDZ05wVTA4WHAzbk5ndWgr?=
 =?utf-8?B?RWtVMThJQW83MVBCUFlXanBPcDREcmY4eHNmSjgraXZwWXNZMnU5S0tIVGtO?=
 =?utf-8?B?R3Z4b3BiMmdCdnhocVg4bVJqNFliOXQ0M056N3FpZ2xFOHpVa0k1SlFybGR1?=
 =?utf-8?B?akl4dFFsak1HejRCWUZlR1FRckcvMyt4TGFPVnlaZW5ZaFAwbHRHMW54Q2s3?=
 =?utf-8?B?WDRwbGNZRTZkeWVUVTVqTjNJb3FzNVY0V2haVE9TU1hKYUNsRUpvREZ0TC9q?=
 =?utf-8?B?NUp1QmYrQ1NnMndSMFEzMURrZlFhQldWUDRucWczWWlVcE9HQTl4STRybXNT?=
 =?utf-8?B?a0VOZVBMRGJ4dXJuQ3lmb29DU3UxZjhjckdKUlp5NXhhckVvRGV5Rm05ZkZ5?=
 =?utf-8?B?cEdCQWpONjZKUzQxeW9VRmhtUElIT1gyVWMydDVLaC9YbXRFMTVPSGp4QzVH?=
 =?utf-8?B?Q3ZDcmRZeklscS9PbmNjUnhzc0pBdVhKOUtvbFp0aXBTbnhVM0lGYnVXL21J?=
 =?utf-8?B?RzFWb0V1bXhZcWhibGJrOUNMOUxqL1F5VWNxVEh2ODFWdG51akpWaUY5OG5s?=
 =?utf-8?B?SXhNN2hSaW83TkxYQkhOYngycCtObUNweDl6MHhwQVJYTWU4emxxMmVjMjNQ?=
 =?utf-8?B?VkFscTNsY1lhdGp0Y2pmMXpPcWJIYWtuMlNOcVIrVjFvNmlhbjZtMDhaWmlR?=
 =?utf-8?B?SWRMWUxUZEE4blloNW56QUVrd2M0UE4xN3IzRXEyNGJkZ2kvVDNJalBaaXlG?=
 =?utf-8?B?b21idFZ2MnZQNktrb281ZzlHSE5qWTJpOUtXanllVW1aWVROS3ZwV1ZxeEJV?=
 =?utf-8?B?dHZSbVRRNzBOMVMvTWcxVzZBSGdTQUhhRy8rMFpPeG56THhkWXJNSGN0aVRL?=
 =?utf-8?B?S2VvRHlDYWJpWExLeldlVW44MVFzVnM3SllzWWlreHRmV2pleU5DcUhBR0dp?=
 =?utf-8?B?QUZjR2ttMHl1aitNdGlPUmhGSWFPdDlQeitqVHhsQnN1d2xHU0tFSnI4QVBI?=
 =?utf-8?B?RmhjZkFDUVdKLzRLZHRsa2U5S2Mzc0w0YXI0MlR2VjJYZmpRSi9xM1AxdnNt?=
 =?utf-8?B?a3hzckV0Y1F3MEo5enBrRnYyaW9BbXQxTHhYRUJLcUM1MW40WTRGYzFTeFM2?=
 =?utf-8?B?d2Mxb1pmWU85R0hQb3VaM0FKUmhaSzVOM1B4UEw2R0l5dmk4NzNTZTV4akhj?=
 =?utf-8?B?czdhNHFYNC9SeEExd1U4N0tzelJwdnd0Z0QwVmtMYnhzbTgwUjVsdHM1dVRV?=
 =?utf-8?B?UEMzUm9WWVFTZ3RBTTVyNEI3MmFpVUkyb1k1d2VqS3dqVU9VREhBMENmSXlT?=
 =?utf-8?B?bVQ2VUxBU1lXTStXTXhHdFB2cXhYWjBicCt1RjFQMUh5cHpIWkVEa1lueWQ1?=
 =?utf-8?B?LzRNaDFvMXlEUk9BQitTT3ZRT094Rkl1Q05CeWE3Mk1idlVoc2h6K2pDS0pY?=
 =?utf-8?B?dWh2eWtKZDRkcmRoeHRyUkZ2dHNSQTZCSWVZdjRxKzJvWUtBUDdLWGFNV1V1?=
 =?utf-8?Q?H2yM1t4i1Jf+mehr2vXjrTaAz?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2222ccbb-487a-4411-220e-08de23400f65
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 05:38:37.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oga16UatiDJY0PTa98xLgTJkVYWdN9r3IDyYCe0I8BQiqYYVh/kk/FaRaq9UHvCyz0uW6OqxmmsAII7AAeQsJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3267

On 14.11.25 03:48, JerryJun wrote:
> 
>   We added some trace event information, but from this gap point (6208.695948-> 6208.708726), it appears that the Cobalt kernel was frozen and no interrupt handling occurred.
>    include trace point events :
>     irq_vectors:call_function_entry                    
>     irq_vectors:call_function_exit                     
>     irq_vectors:call_function_single_entry             
>     irq_vectors:call_function_single_exit   
> 

If there are no interrupt in that phase while, e.g., some timer
interrupt should have occurred, then you should definitely check for
hardware/firmware related delays that the OS cannot influence. Or for
power-saving / thermal-throttling causes.

Jan

> 在 2025-11-13 13:31:54，"Jan Kiszka" <jan.kiszka@siemens.com> 写道：
>> On 13.11.25 05:00, JerryJun wrote:
>>>
>>> We conducted tests on the kernel version v5.10.245-cip65-dovetail1. The test results are attached. During this period, we also performed latency tests, which showed a 10ms delay at 7174.313414 -> 7174.323086.  irq 114 is net driver interrupt 。
>>>
>>
>>         swapper     0 [003]  7174.313414:                     irq:irq_pipeline_entry: irq=114
>>         swapper     0 [003]  7174.323086:                     irq:irq_pipeline_entry: irq=33027
>>
>> So, that is the gap. Did you also turn on irq_pipeline_exit? I'm not 
>> seeing that event in the trace. Furthermore, I always for get about 
>> that, it is useful to have irq_vectors events because those include 
>> timer irqs. But it is unlikely that we missed any in that gap because 
>> they tend to trigger activities like cobalt_core:cobalt_timer_expire.
>>
>> What is more likely here is that your hardware or firmware is not 
>> letting IRQs through. We could confirm that if the issue is reproducible 
>> while have function tracing enabled. That comes with high overhead, but 
>> the detailed result can tell us what the kernel did while there were no 
>> interrupts.
>>
>> There is also native tooling by the kernel to detect "hardware noise",
>> see https://docs.kernel.org/tools/rtla/rtla-hwnoise.html. Due to its 
>> nature, this noise would affect Xenomai equally.
>>
>> Jan
>>
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
