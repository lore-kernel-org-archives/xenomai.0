Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC733BBB9
	for <xenomai@lists.linux.dev>; Tue, 20 Jan 2026 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927679; cv=fail; b=F4uDBAHY6AA/u4cLznsRdwsyCBwtTeop1Jj/zVvTJyETrBvdxOW5YLFOGO5Qnld4Gr+P51yrLTzfaKCnJEaq7S/t1pMNfmEhlGjYjIHz+9UTl95XP3d5y4h9n2K1wckfrVDnscqfS2GQ6cTje94sG0IRRrCqOhAmJT/RiaEjoVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927679; c=relaxed/simple;
	bh=aL1R/EH4n/eJREBBL9EzgV3/YCuXCxYwfu3pRCBKdDU=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=Ur24PZ5Cg9Xm5ILoj1YU5aLrScyv/6e4plhKcN41vqvCUGuIaR0+mQfjf/FdWt7CrtF93B+DCz+3qgUDsBl1x3OomEC/QjYyDhwuAmbycfHZIixJk88jpmUgAeRl5/s7s6pDG6wbh47BO9ej7nabHY8mCNvHiBGU0D1yGU2nCXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Qi0mJngN; arc=fail smtp.client-ip=52.101.69.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Qi0mJngN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5hnlRZQOJ19je3eK/u4wBBkqVDgkQLScAe4SHQoFVMU6KwMTO3NR4fa3VvjeiQibzSssyhldMCDp0HNDc39NsitBF4jMIvH+9ysRJB4HnK5CZ8nSIHX1+nGDn4HFMI/YudIK51uUhloRusCBMVkwFjVnUI8fOpgyW4Hoi0joyvvVc1FB3WFM/IO0MK6U/lU1aJoAk31CRuXESZUEqxFSNCHCsbf2e97sARVZXzfbV8/Mf+oIp++lkkwrBu9Mi7OIFIN7oN9nhUXbCFejgAF2PDl4B9RLSrEBXnYXjoZJS3uAFkIQtJ/cF4FiT0oQTDnlDmD1K+AlpfXwrB8N0B88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKrJu7YVRg3upcmv3aOTXItfzkNfnuiAr3/tBhbbUFs=;
 b=flrbjBNHDH9MlO5AnKwAsMfMZ3OwbBymmfvYwLC568HqXJrfn2CxTzKIX2uk5av2pjfJHRj5R2sdusFPb2Pz3Yd+L9jxZDqArXkxDRmKy32aX1tsyGywfrb7QgkBGabFyu+8GN3d8hZ7uexpzPvrjInLIkCp8DtSFqlXs6/zaJ8wSiCCn/vUZGD0A3V3O/m808mzvy1QB24gdCLSbMLJXtjRJKjB4seS9lzlQsnjSflB5uaT2nPGirUN3y62T27xpV9FCFkuyyf2WQxhEXJIDlB2VnRlSvDw6eIsi4ae5im/0XzIP3hLI+zGQkXw7r68OCNsGx2ELCzmwkHRBddBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKrJu7YVRg3upcmv3aOTXItfzkNfnuiAr3/tBhbbUFs=;
 b=Qi0mJngNX1zSo8LTaxnF0VUGtaqI2bFl+MiG452sB3Aj8uobfaOWOFRb+z1phqek44kNNCnkhVCEf68EPdqlYhhc7qtKX9xSiBinuYuUgllMF3YQcKhVpLXOxMqvsy9pc5zwfL7+0EqsezRdX6Yj2Y2Dv1kq6rOjKa48Z3euAutVz1qa3mGaVyhNZQ7J/1pVcc7GVhR5mGqxIEZ/OnlkCzMdvihZ/d8xsC3CuAtgvnHOuoxwIlYoLzk4BMSOAsO+8sgDRJJ9edK0DoUamoHMv0CYe9MHFcBHzGcTWkdCblkj3Bzs+mbTN4G2gEBnyVDrMdSLkTfXilNzHRUxwrJKvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 16:47:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 16:47:44 +0000
Message-ID: <51187364-2bf5-4370-ba9f-e884aebc3ae5@siemens.com>
Date: Tue, 20 Jan 2026 17:47:40 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, January 21, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:610:5b::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 314eb350-b9a9-4586-2026-08de5843a277
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3BxUmo5bFlPdFBLWkVlT243aXpmNHoxM050dFRxdXRPR045UHRJM2haVG02?=
 =?utf-8?B?SXNKV0M3elFqQ0VBUE44UTVUL0wyaittSjFJRDY3Yk5DcTRmbzA3Z2hlTjFw?=
 =?utf-8?B?NGw1YkxZOE5BL3J3bEZvNHNEamVLcUtjRnJZWWZZc0ZEV1RqZ2UxZHJhMjBw?=
 =?utf-8?B?RHRlY3ovSTN0dWg4V1VxcFlqWEVOdzJ3RGFNTGswZGxMa25Dd3EwaHd6RURD?=
 =?utf-8?B?TFcrRHByWHVuZ2hCZlRJa0FaZ1JuZGRQVlI4RFg2U0o2S2NST0U1QllZUTNi?=
 =?utf-8?B?VnJmVG53NnhTV3VMZnc4K0FPMldXVEtHL1kvQnZrQmh6TFVtS2Y0MjIxUHJ6?=
 =?utf-8?B?TWsvd3dXdjdMekFRc2s4SVRrc0VtQStJTlcvdU82bndDVStZMnN5V0hPS1J0?=
 =?utf-8?B?aDJMbUJabEpBSjN3cGVJbVBpTXgwZThnNVlXd0FSVmhSU1k5Mkx2VDNPa0Yx?=
 =?utf-8?B?T3RuQ0lsWTJaQ1BLcGh0ZU8yaG9WazEzUlplaVc4UUdmcm0zZ0pHWW5hU1A4?=
 =?utf-8?B?blA3VlNDTGdseWE4ZnhKTmk1R3owQkw2NnNPS3VpOElGSkpZZTFsZWJndE9I?=
 =?utf-8?B?ckQ2SUJaMCsxRnZER2paK0J2dzVIWk41UWt1QzJhNmgzSW5SSnBNT0NkYXc0?=
 =?utf-8?B?R1JBNUx2dTczbW1QZHNQM3RrKzNYUzg4N1UwMzNvTkhxd3RGZ3I0TktxN2xn?=
 =?utf-8?B?RWpzNTZWT09wdnp3QVJLVC8ycHM0Qzc2aExDc0w2OEE5bkoybW5PU1ZPR1Jq?=
 =?utf-8?B?SHBYZW81RlRueGtmYVF4Zmw5cU43ZThoNk52MnFHK0xvTGUzLzFuMjEwckdX?=
 =?utf-8?B?UHZ0K1N5R3RCTzNYUWNva25wVTNObHJzc2hEZUh6NmxTSUcxYVYrc1RrR01C?=
 =?utf-8?B?eUdHUG85VmtXOU1adUFWNG45Z29sRjVnbHZLRURFZTE2TkNnVmNKZ1BlcG9k?=
 =?utf-8?B?L1pXMmd4Q0JIL0FibDVDQkxSSGVMTnQ0c0hWSWQ5SE5acjR2SmxFNHI1Sklm?=
 =?utf-8?B?bzBQRW1TN0I4OTY5QlRYc29mcWFSWjcrdzR5NjJyVHo2QlVWMDJnU0k5V1d3?=
 =?utf-8?B?NkpUNHJvSTg2UGppTFVnbE1oSUhaVWxoWVdvQWMzMUlGZUQ0YU03aTRnZUx0?=
 =?utf-8?B?SFV3QTdRV2dFaTFCbWRVWm1GQWs4cldQTUd5QUNMNmhTMXNiS1NkM2ptY1BC?=
 =?utf-8?B?N1k0ZnVtNVpPdFNrcHFRVUtkZitWcXBCY1BwS1FSTDlYdWM2ZTVXdVIyR3VQ?=
 =?utf-8?B?V1h6cy8rMzdRNnNtQ2hJek4yTGgrYlI4Z3lkSHJGUDk5UE5CZFZMYnFjd2FT?=
 =?utf-8?B?cmxrVmxDaHlqd1M5bDErRXRtVUFjYW9BSmZYUlVSVVdlUnQxcHA2bGRNOERU?=
 =?utf-8?B?SjRvMG83aG80NTlEMnRzQW80YTdCRTk3b1ppV3dYVUc1cU5GYWk1K3hJdTJD?=
 =?utf-8?B?K0hzdDZtTWM5Y3NDMER3djE2dFV4YVZZN21BcHc3RVN5anFrbEdRN2dlRko3?=
 =?utf-8?B?UDJyTGozZ0NRSDZza01TL1V1NGVUODFFT09NNXlEQk9rTE5mL3IycExkbTJU?=
 =?utf-8?B?aVgyTDVJdzlZTWVzOG12MXdoSXZsMTFpRWlQU0E4MWNCQWNjUEVVYzR1OEZ5?=
 =?utf-8?B?Wk9DTnorcEozeEl5bzQ3cUhzV3F3OUdpdmYxMmgyTVZsaXphQTFxVkxONWVX?=
 =?utf-8?B?MGZrRGpuUk5sYWl3NUU3WGp4dnZaTytCempDQVlrdFlWZUZBOUlpa01wMERM?=
 =?utf-8?B?OVZCVFFESW15WDI4UU93cytGZG12eTVJanFaSWFOWkJsRzdWdFcvQ2d2d2VO?=
 =?utf-8?B?Z01oeDhIWEJOdy9kQW9YQmQ1R2tKWFBaazVBT3p5K2tzVDhuTEFXZlcvNWwx?=
 =?utf-8?B?SVNPOTRyVzVscjhsbm9qSU5uTU05aUxJcEFIbllsZ283TjNMMkFBNXNFU2Nw?=
 =?utf-8?B?QkJnRk9PYmJPUjRiWk04aW1xcXc4S3VGRFAvdkNrdDkwSTIzZTdiei9pTVN6?=
 =?utf-8?B?WGJ2NWZzRnVGOGVaYi81cXlDbXhUdHJvRTVhU2FJQ3lkMFo5ZFRUOWx3V2hT?=
 =?utf-8?B?QlJVNjNDTGhFdk8vT2l2OXdmUUJDd1VOQUk2NkhNU21HMTRhRDVKdUFNSzM4?=
 =?utf-8?Q?tZdg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFhVUVljVEhwQytoRmNUREtSbTd0amd4YmwreFNFeGwrREFMY1UyVjVURmlC?=
 =?utf-8?B?ZExtZUJKN0lJZlZKVGdNQ090ZlZHbmoyRnl6c2p1MEd6TCs2UUhmQ1c2cmMr?=
 =?utf-8?B?M2FPYzFlanVjNnppaTdFS3U0VVg1cmZ4UXd1ZUdlVkZTcXYrMEEvUzZOTC84?=
 =?utf-8?B?S3lqMmtHZVUxY3NkcnBBcXRwa1VuQzdNT210WVIrNGgzNDIxcytwcUFEYUVD?=
 =?utf-8?B?Q3pNbDlxLzdOWGNPanRILzEwbVpPc2FVZGM2djNHT1ZUbkVsbFNwdllOa09m?=
 =?utf-8?B?akozbHI5Ym56YUdFL3B5aFBjSEhNYktoSi9vQjZIWW1pODZuM1htQTZxNEpS?=
 =?utf-8?B?aG80NkJ0bllxalBOVTk2Z1pvSk03QlZxbG5IZGIwZWdGZFFRU0NFK2NTOEU1?=
 =?utf-8?B?eDVaenlFU09XVjZ0NnRoR25OWDFUd0Yrb0pUOW52T3cyTlNacGVIbFBjVUtv?=
 =?utf-8?B?OHRXYkdCSnJCQUhhT1o4d01jMEwzMXpUMG9zWXNzbTlsVWNQNW9hMk1peG9t?=
 =?utf-8?B?TnNiZTU1aHA0WEQwaG9jRUJBaHNvOTlTZUxKaDhzTlJJcFJjQ1dmU1U3VnhZ?=
 =?utf-8?B?bGZ5ZUovUHJqbkcyTXErSjEzeVhUM3JqMXEva3BGWER5K2Q2cXhTdzZIQVJ4?=
 =?utf-8?B?b3BJclY4NjJPU1JGVmdvV2RKTjFrQlhEOWZhVEE5WjR5T2NsNEEwNm4zWkQ3?=
 =?utf-8?B?L2VuekVKMzJwVHVrOXp5SGFTMWd3eTl1Q2E3T2ZwcmhpNUhEVk5kVXV2T2g1?=
 =?utf-8?B?ajlqN21NNml5cVV4NlhjOThwNlZIV0lQQmJ6MmVTQUNtaGMySDZaMVdPTmVG?=
 =?utf-8?B?UGhVWjdTZG9MNWErR28xWGNIMVFteUQ1RnFHNU1wbGxESGZOOURIVHNjZVNG?=
 =?utf-8?B?TGJaNEExRWVpVGNqeiszT1YyV0RnTnZnQ1VvcUVJa01KUGR6UU9Dd2xpOWxy?=
 =?utf-8?B?N0hCT0RmU3JLem0xemwwT002TjlqeU8zd3dyWDdyaERGTmlYcnh4VlpEOGxE?=
 =?utf-8?B?cHVYVTNoeWNkYUdvS1cvbmY2dHp0TVMxdUpEaGFnbVhvR1M1bnhLeXEwaXM2?=
 =?utf-8?B?RHRDSjJFMVZPeUFsb1RXZ2RzL0FySWl0aFNoeW5kMWJsWkt1THRwTkRyOWNL?=
 =?utf-8?B?OEU4VVQ5Vkt3TGZMTUZEeTFuSkc0Q0t0WTdqcjRUaVVSYlE2R0hpa3hlSWxU?=
 =?utf-8?B?MVJPcjEvd09NYnVxb3hnS0Z1dmNpTElmS2dZcGFOQzc3YmZtNjc4YitiWnAz?=
 =?utf-8?B?RVlHeWVFNTI3b2x5clUzaUR2amo0bjd0WnFuK0VQS0ZGeStOTUoyS1RVSDZw?=
 =?utf-8?B?d2lTeEVtS1lSbFFnWWRnaUJXREN5NGs3Z0FGbDFkbVppNGQvSzlJNENkaG9Q?=
 =?utf-8?B?eHZnRGhyU25xTVlSaHRFcDJmTXFVdXhNQWZzalhjUjBYTmVKS0JwWlFkZFpL?=
 =?utf-8?B?WmxKMUpvUU1VSS9BVzk1YmNyaDMzQ3cyUzZ5U2FoVXBjVXAycndDSVhuLzNM?=
 =?utf-8?B?Mndoa3VkZldWcVNjZ1NIdXhFcnZGWEg2UDFpQXhkZ1dreGdKMm4raGNhcGM4?=
 =?utf-8?B?YVVQVStWYzFpV3V1ZnJpdE1lYTZJYkU1WXhxdjNDOHN0L3RmVDljQWxKZG41?=
 =?utf-8?B?RHQyaTZmNFliS2JCeTF2MUJwRkVkT0VFdFZIUXcyYTNTSHg3NXdubjBVWHFS?=
 =?utf-8?B?Yk8yREJINU9XNTVXOTlrSytDTWNaZFRTUVlQcjdBVUlSOVVsS0VYdmNZRTBS?=
 =?utf-8?B?cjh4SFNCMkFmOFEyWE5VZEtSa3ZiUnMrc2NPcDFERFlES1h2Q1dId3hXM085?=
 =?utf-8?B?VGJ3djIyM3pLK0hWT3U2MXRadDh5U1RhcWh1L2thRDlQdDF0ZUdWLzUwSy8x?=
 =?utf-8?B?dXQ0NC9yQzZUTUtsaVZWZTFzd3p2dUhMTEZEODBJM0hDZUt5OGErbHFETytG?=
 =?utf-8?B?Tkd6ZnJnbzJvblQ2K0xNVEErNExlWlhSTTBZUmhtNWlGbHZVa3FsWU1tLzNP?=
 =?utf-8?B?R3N4NGpVR1plOE5BSWFXQTl1dDhrU0ZuZElMT2EwQTQ3cVYvZ0h1aW5lVDNk?=
 =?utf-8?B?YXdhaGYvdFh6aWVvMVZKeHo3eEMzbWViN0NNNmk3U1BSZEZIdHhTVGlzVkx5?=
 =?utf-8?B?SEJ2S3BoaStLM3NiTi9mOXluaTdsdTY0VnI2VkVFOHBUYmh1UFl3V0tONWFj?=
 =?utf-8?B?bmpKZ083ZGZEMmNLa0NnRFdPWTdpUzBPcTVmTFNvalBEU0lpallQandkS3pK?=
 =?utf-8?B?eGdUVHZteko3alA5czQ5ZDdlR2dVbFFIUmx0YkdMSk4zanc2RHByS1lQT3R3?=
 =?utf-8?B?eDJxd1BON1dnN254djNFUmdvOUdWOUlRS2IvaDN2YlFBNUh4NmJmdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314eb350-b9a9-4586-2026-08de5843a277
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:47:44.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EY1GwCR+jeVUVjZm4jkZ1c3ffg2vnAt36RzzvQ7/r8nxyFK8tqJkYZ+FbCWCRhpe5f+Io+qQ0kRCuPjrKUQrvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6166

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, January 21, 2026, UTC 7:30 AM
Paris, France CET 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Happy new year!
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
