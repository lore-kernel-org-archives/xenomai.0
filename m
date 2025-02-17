Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2054.outbound.protection.outlook.com [40.107.103.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA0212B29
	for <xenomai@lists.linux.dev>; Mon, 17 Feb 2025 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784287; cv=fail; b=cyfpRR72npISxgpI1nH4D1nJsmAcNz9Tka85hMFTJ38UIx794RGBpwLY4lFsaBEZ3AC2z4cBz4su+oMTulYnYRYjRhMfwQ+gZzQfzFWgpEM1oMC49fGrWKs5G5/oVbLbGR4GQrFt8W/Gdu9cWsbnS1oIrRglFFMyXnUgm1FFihA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784287; c=relaxed/simple;
	bh=hgwzu4pLDV0mELri+HKZTndBfxWXiGJaK4coEpqMFUY=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XocZsXilItjSuPx4/OFQWvjWMTG1oxrWBi3XTXSQvS8lTwyr+XJcwxpd4WK43CSWHJu8AeI+5NuPLzUbNnRwPKojE5Uk7dCmBvniB0zmDcpr3i2URsE9khsNa33rV2iQ5IlqCRnHn4/pwugafx3XALMsDMZVKRSj5RAtRJ4hvPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dJRAbmOh; arc=fail smtp.client-ip=40.107.103.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dJRAbmOh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiV8eSIcEH1jy3Mz4rPDls4ROnupu3pYSJ/RI66te2KewCHD2DmicfGXScl5NpcuAe8fNzafmn+OE8ccLq2SAbVv9QtBfB8t2rayAiYxq5XUVm5FrgjjUAhAu5l4ACXkvaA8vGg4JiaU6ZXJcbIjvM1rggGmjkwOaJXfm5V2loLgFRoRMSdGAecQmaplxwZltP8EXTC+fSVeUSfQ4T6jUoF1lcfJJd4Tizq6OZ1WMivHlFuBtrYhFyh2DVaDMYtfK5THHWwW+VrVIaAgngltTDWggUzPVx8nDfURZ50UsyNs5IGheXRcHHX34IhXdD90pKU2OUlhwH+jxYBdEMGFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noPPFy2PE9HvUUpqd5XeEwI1maeo1vmbI1q94K6T90A=;
 b=NVeReKnIkA7C5AmPciykO3C3Nx91y9+/Gv2YFir52akfEc9NYTj7WkNFqBfItxc4ubiruaoxPwESESpv9Kt0i1uoEBwBdE1T21YuJ7inChIM7GWUbuI7QVzSFYYflZHu2KntyB87A4/6nBHzuMcgYvLzVp7IxHFdntK90c7jg0xg2R8lDf7crSfxGvJRFHraDlJfMRdnZ15FhbTasEkzVqYEsrtNCTn8ZJXbA0HsCdeVuLzSjRT0FGtt7SNFTV2BqhNVbvZC1ftLaQHjidde7aWTQmfNBgk3UW+Na5H0mbBeWXl8MYFvxGNn/Mw8aqYufHLrscCFgmbye80IPvs/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noPPFy2PE9HvUUpqd5XeEwI1maeo1vmbI1q94K6T90A=;
 b=dJRAbmOh//Uol/1cEtbx2F908h+DLuHcdylt3fW8MbZeUDUhhtOxquTRgcvlrglzIylISKLtzbUJYLMIHFvfviTNwQnE+PimAS6qwYSbcVzOtEMQ9UUfwftVo0urEASQLq4BZq8pAPlgydTZwRVXMvqQYOccnaO5TQPgzKYYG5RKugec3kxc+Bacn9H8PDujcxRnRAaKvnFs83ANZX60binda2+BxK3TbsTA4f91eww4l76+vOcm/X06esZE2p28WFpJ86OUc7A9FwN5bI6dV42Yov8g9gHcJWQub/Unv8tWSVz+2hX8M8gLvqTlWYYfg0/zGRwWdTb7KAG27UGOIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Mon, 17 Feb
 2025 09:24:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.009; Mon, 17 Feb 2025
 09:24:42 +0000
Message-ID: <a2fd2f2f-5166-405e-8518-ec3661977cf1@siemens.com>
Date: Mon, 17 Feb 2025 10:24:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with moving from Ipipe to dovetail
From: Jan Kiszka <jan.kiszka@siemens.com>
To: =?UTF-8?Q?Marc_Str=C3=A4mke?= <marc.straemke@eltropuls.de>,
 xenomai@lists.linux.dev
References: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
 <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
 <108e740c-9919-4cec-afbc-0ae2f08922df@eltropuls.de>
 <67a95cb5-71d9-417a-93fd-62c9a4de60a3@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <67a95cb5-71d9-417a-93fd-62c9a4de60a3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0347.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: e084f2d0-842f-4812-a878-08dd4f34e8dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXdOYW9Fek1mRTNZNmpoajllcVZlSXlGZmNhbmN0Nk15cFJkekJPYkZ4eHN0?=
 =?utf-8?B?TG1ocmJKV2JEb2NTOStWSmhRNFZIOWswZndxakMrQW83QTNRNVFaR2tSOEtL?=
 =?utf-8?B?ODlid2dJeE83YnBNdlF1TjZFSHhzenVYMjZoM1lMYlFvWUVuVGxWL09od0FG?=
 =?utf-8?B?Nm1ZVnVtOE8xQXVuZXI1cWUraHFMcWZNSUcyM1UxNTQyQk1EaldZVkpMSHR1?=
 =?utf-8?B?T1J0YXd0bUhuYU1YV2NBdTA4NnE2cmVMMmJRb1FQdFR5b3B1WCthL3JLV0dB?=
 =?utf-8?B?WjhGdWMzK3VKVlFKMWxGRDR5YlFNZlFIcWNSdFhGSFAyM2tNaFRLcW1kZ2h1?=
 =?utf-8?B?d3krOFR0UzJqSzQxVXRBTTVXajZUSzJuTFZkdlArUWtZWTQ3N2RoVDFwOXQ5?=
 =?utf-8?B?Sk1pLzMzMTY1WVJOT2w3a1pSNjFEZDBaMllzeFVHZy92Y2dLalBGZjlHMjR4?=
 =?utf-8?B?VGY1RkJFQ0p2ZTdDRVg2L1U0T240blN1MUFmaVdMaVlZZDRxcXdiZFdrdlFq?=
 =?utf-8?B?ZjkyMUl4Rm1XME5VckN4MUptSTJraHF3eU53bFN5WTRSTXZ0K0VRTTVIY2xO?=
 =?utf-8?B?MDBOYmpzdHEzK3NpWUFmTWh2dUFQZGdpajFHdUxSdU5rQ1RWUWUrNjN3N2Jm?=
 =?utf-8?B?RTlJRElma2hlSXNIb3VYVFlNZWo0bHM0Z0NNKzQwa0VEOWxCcnlZY0RRZmpJ?=
 =?utf-8?B?MTAxM1ZuZVp3ZjNmdGJjbmJzeGt4UW1Pa2oxbUw1U3NtY0JwV0gyUnVIMCtD?=
 =?utf-8?B?ZE5SKzkzQ1ZrYlRwZ2FXNGxvcGtiYXZ6YTJGc0ZrbUdKUlR5NGV1aUw3Q0g0?=
 =?utf-8?B?VDRaQmN3cWZKUjBmMnZkR1F3bmluU0pqekpFS21VZjNPdmxSMW1FdlN0SWlD?=
 =?utf-8?B?ZXhZTzlUbmlxQURQSUlFdjIrbGY4Z3ZMclFOMmtMZlhqREJ6MGFTdnRSbDhG?=
 =?utf-8?B?OERYMEo3elduejBLc0xRYjhEcWNCdzFXOEJXYVY4VE1wYW1YdjNtN3hhUzJB?=
 =?utf-8?B?Q3JsZFBOMERMRkIycXU0R0E2aTZxVUVFYlVqY0FxNkcxNzRqdkpKNC9VUENT?=
 =?utf-8?B?K09VOXQyV0d3TXBmRjMrSnVmUUVJOWk3RDJ5ZU5UcVJtaVFPTUozVTQvditM?=
 =?utf-8?B?eWV1eHlBR1FrL3FnR0FTc3pJYjBlcGFTQ282Y2xHTE5KdUR5MkIrWS9RZzkv?=
 =?utf-8?B?QTNmeVV6ZE54N3g2Q3dXcGlIWlEyR3JxTG9VcHQ5cHhMUVpjanRHTjBSR3Bs?=
 =?utf-8?B?NzZyS0wvNW5rTkNVUFVNMmtKYVlMcUVjYUFabXJ5aVBGdVE0YmYyakVMLzFO?=
 =?utf-8?B?OVVIdlpESXl2TTJ5TWtEMDNCQ25SZGppU3dETkRpN3NwL3FvSk5idHc2QW9i?=
 =?utf-8?B?anNiV1U5WnNtZXFtS2x6QUtKTjhFTXEveElaNC9vbW1vTUVOS0xXeDQ4NDE1?=
 =?utf-8?B?TkRoMU9qbzVkVXhZN01RNTFjM0JraGgvZE9vL1VIWkY2TS9NNjVkZmhTNEtq?=
 =?utf-8?B?RWlDMCtQWU5DK1dkTTNENVRFL2p4RTdDRlNPdkVtK0ZtR3FMcTI3RTM4NHJz?=
 =?utf-8?B?TVlXdTErVEhIN1pGL0VVTjEvTmgrUG9mUjF4WllOd1pxdW9yQWRaNkFGN3gv?=
 =?utf-8?B?QXZ5dlRxQXgrWnE5V0pEN2V2TWhlUlJtb0g1M3RwQWtBN3BPaHFpZmtUU1E3?=
 =?utf-8?B?VFRhOU9jNFA5OG0yZmppQmloTVdZbDR2Q1F3Y09BNVBjM3hUVnFQUTFsSWc3?=
 =?utf-8?B?UHY4WkwzeFJhTE1iTWdiK2IvWmVYbHBZZ3ZCWXU4aFJQSzVCemdnaXBMVXVq?=
 =?utf-8?B?TVhSbWkrNlV4c003UWF2Nm5laG9vclpEL1JBVkoyVWgxZmxaQ2lWaWFwQm5z?=
 =?utf-8?Q?zqWZ89b3MTAiM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2VUVk1qdlBrWk55N3ZzN09aNnBCVTVVdWVXcW1lTVpwRjlMUHMrUlN2R1F3?=
 =?utf-8?B?VGg4aVFIemtVSGd3djhKcTlVWEl2YUsrSEl1dzJUdkNKeHQ3Sm9mUXQ2L0VO?=
 =?utf-8?B?U1BpN3QxMjZMZ0RsZXNpamNWM25RMm1VYm9GUFpuSi96RU5CcE9VMmVYbDlw?=
 =?utf-8?B?aGFPaTZDd1ZYMjFzMGNYa0dmb21aV1RpUmplUVE1OGNMSEdmZ1oydGw3RWhj?=
 =?utf-8?B?MUN1U1J4K1VWaEdBVUwyMit0QXExRVJRUngwZlhsRzBpbm5PZ09peWhmQVhS?=
 =?utf-8?B?Y0psblR3SXNRUWF5MElJSkZvUENwRjBOc1VBK0lmMHg2bFFIZzNhakhLUkdK?=
 =?utf-8?B?WmoyWW0vcDcxajdIRDFuOFM0ckZhOUdTMzJMOHpOUWMzMUg3NS9GOGJPVTdR?=
 =?utf-8?B?ek8yMEhmZWVDRWpRWThQeXczeFBJWERnQ1RwdkJnZWE1bm9lTm8zQzVsWllR?=
 =?utf-8?B?Sk0xSGsrVVVNRm4xQ2tXN2VnZi93aEdDS1NidU1Udi9YbjRNaXZ0bzZZQmZr?=
 =?utf-8?B?WkFUeWtyUUh2K0hnVWJvY2lVbSt4MFZKYk9pYWJQbDFWSXBHdWdlakhBZjN2?=
 =?utf-8?B?T2RvR3FybG5kS0FGRWdOc2ExRWpabnZ1Nmh1T0NvS3Y2N2J4b1REWCtaNVdV?=
 =?utf-8?B?eXJsVlRoUlllQ2lGUm5zcEVFUWlSVHdyRGlCM1V4MlBqMXBzM2FLNXN3enRO?=
 =?utf-8?B?YllxWmhnN2o4YzA3cnRaZHloS3dZV2p3SEVDSkNia3FCOGErSUNVQWU5ZHU3?=
 =?utf-8?B?OVM2Qlh2TitlNUl6SStYSkR4YjQzb0NMU3lPM25pVHF0T0xoLzBVRFhZRkQ4?=
 =?utf-8?B?Vno2VDhPaU4renRXUWUzL1FCTEVLVzhJRnFiYnpXRWo5M2hPVVZSZnI1RzB0?=
 =?utf-8?B?d2tod1hMMzh3QXJDYUk3d3dlNEtMMDFCZ0pLckhvbm55Rk9WQlo2WXg2TDNH?=
 =?utf-8?B?ejV6ZFVMeTRGM0JMdVhzdlpKMWFVZDZIK212cFNxZHEwSWlXZmFXL0VhbjVT?=
 =?utf-8?B?ZWhiS21XYmVkWnZHVHVlMHZ5Unl4VVNKRHAzUnFaSEl5NWlDd2VGbHgyTE5m?=
 =?utf-8?B?cWpML2FqZ0t2Yi9qeExIYlNsMkNsNGkvNXFpOCtuYTVkcUdCYTgvNU11NzlB?=
 =?utf-8?B?OUxhUkl3UUFtRVdiaDl2TWx3TWRLN3lUUmtobEFiQmdBRVdHeENtNlcwM2ta?=
 =?utf-8?B?ZUFjYmxlTlYycURqRzEyam1Gc0NrMGExb1VLQ3Y1YkRtY1ZkZ3M2S0RTTXhR?=
 =?utf-8?B?eUM4enYydU56cml1aXFFRU4ySS9tdzFPOVZpVTN0a0gvQW5udW92VFlBMkJ3?=
 =?utf-8?B?bVp2ZllCcGttNitMUC9LclVWRGE4OC9TaEtja214NjMxRXVNdXhNT25RWmU1?=
 =?utf-8?B?dVdUK0V5KzE3aUZaSkljQ1MzS1JWQ3Z6V2oyQTEvc05GOVR5ZUFraExFblk2?=
 =?utf-8?B?Wi9pMVBSUkpUM1dBYnUwdlM2aEtyQ3hpV3ZIbXhML1RPVGl4Mnl6OVZVMmNG?=
 =?utf-8?B?TkdTeU1mT3BsNFFzSDMraGxmek9vaE9rSFZJdnkrU1pZYkdzVmxQdlpaa0hw?=
 =?utf-8?B?MUNWazFwQnMzRHRoSWhvNWtjLzU0U3RldTFHTm9qZis5MFNmL1JoNFY3RGNk?=
 =?utf-8?B?K0IvRVlHSmJsV3FucHk0S1M3UGNidm9FTmtZQTNtL0FlREtwU1NCZWZ2VXR1?=
 =?utf-8?B?K3BkbVlaNWpIdHJQSjVRdEFEOTB0NCt4M3RjZ0dKYUQ5cXloOEo2dzVFQjcw?=
 =?utf-8?B?UmtGZFdGVHFyYzBQZk1lZzBuMWhqaCtHaGZ1YlRoWmRVKzZMMTd3SlV3Rkcx?=
 =?utf-8?B?M0huYTU5Q05PdUE3RTVrL2xlS05JS0k2cGZxQ1NGckZBbG1yKy9tcFJRb2Fu?=
 =?utf-8?B?dE4wclFBQmtJNUdqL0dtWkFLdEIwayt6dktIbXV6eGZncVNsUGh3cXpiOWpw?=
 =?utf-8?B?b1RaK0dpYkhOR21HS05XL1YyQjRmWVFzTnFlbXFIRFphVTRlYWp3QjBKY29v?=
 =?utf-8?B?OVVnRUVZd2h5VVlYZER0cWdSTzhSUGx0OGE0dUFDTllLYkxBbmRkang0UmxP?=
 =?utf-8?B?Z29oVFFEM3NMTXdzZSs1NDJyWFEyT3NRb3dWMWp5TzFScUZvaWI5cXlVeDlB?=
 =?utf-8?Q?rumSUk4hO/xPuo5dCkdBo+Kdv?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e084f2d0-842f-4812-a878-08dd4f34e8dc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:24:42.1312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRn/6wDkTPckX3ELCbGA18nwNVP1iSDWaagdtBz8Mvsb9FtetZ9ahATzhjOVfkxZ3W4uto5Y/Y4TZaslQ0OTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6057

On 17.02.25 10:21, Jan Kiszka wrote:
> On 17.02.25 09:50, Marc Strämke wrote:
>> Hello Florian,
>>
>> On 14.02.25 16:34, Florian Bezdeka wrote:
>>> Does your problem also reproduce on qemu/kvm? That might help to
>>> simplify the debugging process.
>>
>> Sadly the issue is not reproducible in QEMU Both the "bad kernel" and
>> the good kernel boot just fine.
>>
>>>> How would I get more information from the frozen system? I turned up all
>>>> debug settings and get basically no output. The IRQ Pipe torture tests
>>>> run ok. The problem only appears if xenomai  is started during boot. The
>>>> failing kernels do boot with xenomai.state=stopped as a parameter.
>>> Might be a bug in the IRQ pipeline that shows up as soon as you enable
>>> an oob stage. A boot log might help to get some more information about
>>> your system.
>>>
>>> Is that a boot time failure or something that happens later?
>>>
>>> Florian
>>
>> Is there any other idea to try for debugging? There is no way to get a
>> serial port for logging on my hardware..
>>
> 
> Hardware debugger? More a rhetorical suggestion. I suppose some JTAG
> interface is also missing.
> 
> If your development hardware even lacks a UART, someone tried to save
> money on the wrong end.
> 

Does the board have some PCIe or M.2 extension slot? There are UART
cards you could use then.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
