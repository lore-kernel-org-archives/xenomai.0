Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60F1C9452
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330169; cv=fail; b=M1jXykQkfjkHsZ3KhoIrlwA23M4X4FTJc4/vUv12OiFLU1S635JkdASsRtQAFGKL4eRJ0pM/PRDEStkCDf50mpNreOI52Z6OM5+PpFsAGzJKwY2Re2xKC8vJ8VbgQEUsn7y5ixne2mpcmH5TYvbUkWPJd4WtscOYqYy1nqUbbL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330169; c=relaxed/simple;
	bh=tXoS52Lpfv3nRzlmmaazwFkpY3ue//IiAjxiBC+0dDU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mo6QCrdbm6QzYbOd9ZWV1ltHXruK9SlxIC6TdqrumrQijweiBpdB2z4YSax5DOp61ZLRj3KpEybaYHkhUd518p6mymRWNOetL0PutV5QBLHt+GMt9kxO8P4rXzk5rcuvzBXqWcle3RbKKN9mlo5Xi0f3GkZouldgqqPD2mVg2B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PpGYi8Vm; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PpGYi8Vm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiuWBWdQVftFQvTbCNa+MYYSoCm62az3Ud68cAj1X4rWlb5noSmJWRZk/WqCV7GvG/sw+WDpLGlezLPoA+UCCItmmW1XDGV7mdVoskRUNu6mBhpTjQ17j38v6xmKVX+LT6861ocEPxmdhU4UJ8eY0F7ICcZe01FTJw30F/zsP/og9DzT9LXdG0WNhX/UC/8JDZZwBpv/Af+WSDL+IbIZExR7tJy94qEKxWQmlvguLGkd5JCTbLXI31vtUJMXOTeGXa1hc/V097cAAbdJZ+M7CsNVBWCX50vkZhtrjM7G/G2HRdXEU+YWWR+c+b+FKgqC5iwkauQYX/14jG8/45qXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WvmzAqXEUY0qqBKhqVb2SAJnHlNK8mpKPvkepk87oE=;
 b=qwhSRPArVBtTac3OvoLFrE1VE4TGhd3SzyG4ZibDXW/34Dq8w+4fK0hyy8jzm4AY7qVtjE9iyOxjc4SxGAi4VJ3BXZYgLEWHrfimp0Pi52rRjRJ1fvDzT6/ZGTfweQsECtNrL+O37u0DlQRUhs9rlSGgNozYf6KHfG7czXZHPH5kkLNuXLVZDubj+cK7wwZha2lY9bERWPzszrdTNgpDCBTWPWMMS9/2qA2JtIaBb6mmDavwVBQuWOUNrQg8XqwFEheg2fn5RPIOR5rkI5qrKGRQIoI1nJbdGwrTlCpPIz5m/JefBFlcDYwZI2Du2zW03tiKJj/iHXD8C/luyf/jBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WvmzAqXEUY0qqBKhqVb2SAJnHlNK8mpKPvkepk87oE=;
 b=PpGYi8Vm7O0uTdDWntKS+5Gtt6dG7CxfbRddA/1HFzogP+WtnUfDa+3wApn1RUr7fyVzhdknFcv1NYRFiDrFb1Wbe14lJquGr0KfPWWZ+z8xSmFKVP3WyBbiNhVWRTSCe0OT+mZ8uPE6jBEdPgrTTsu2Ph8GyxtI0Mx4CIKv2KIkCpwTbV2R2WYHYzslOy77HJcNeE/IWBj9ctKCyW+6de+MSqigBlAPm4dU7ATk76DeDgNsViTVKB+BrKgx8LNLu+tY1F+1qK3wx/GlvQogHQ/uL0tNT5OfN+VYdasZlVcB9V/zKncBPvrZ16VeFhjaqGkeudRxvGmJmRBCRXVb/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA4PR10MB5564.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:261::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 12:36:01 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 12:36:01 +0000
Message-ID: <e5c6dba6-9450-4864-ac50-e654a896ed6a@siemens.com>
Date: Thu, 22 Aug 2024 14:35:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lib/copperplate: Get session name from env var
To: Richard Weinberger <richard@sigma-star.at>,
 Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev,
 upstream+xenomai@sigma-star.at
References: <20240822080737.17939-1-simon.graber@sigma-star.at>
 <6235310.YiXZdWvhHV@somecomputer>
 <bbdd9183-fd27-4cf3-b7ae-358498aac6ef@siemens.com>
 <3358517.AxlXzFCzgd@somecomputer>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3358517.AxlXzFCzgd@somecomputer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA4PR10MB5564:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a06f8c-36fe-4b20-229a-08dcc2a6fae2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RE9KSTB2SHU0SWt0NkZvV01PaHFDdC94Q00wVHJoeEJBUkRodVBpR1gwRGxa?=
 =?utf-8?B?V25vdFdhdUhvYmRZOFlTNUNURHQwMTNVaksyRUQrM1dMcy9oVTV5OUZiK0lE?=
 =?utf-8?B?ZTlwK1Z4S3Y1dUxGeGFnR1VmazdCUlMwelU2WlhpUVVXRUk1ckpnbEx3VlJm?=
 =?utf-8?B?cVc0WkJZcEM3dlFnV2ZFNFdJUVpBK00yS3AzSkdtM05ZZGhxKzlXT1RYYkkr?=
 =?utf-8?B?ZlNXY1dwUjYxajB0cXhYc1Y4Y2RwVVZkOXEreHBuUnk5YjJCazlLckZ3TFpl?=
 =?utf-8?B?T21RVE9NMWxEWDFIL2dKTFNDWWsyZTluWHNPQ0ZwSS93ZXJvT1BON3IyYmJq?=
 =?utf-8?B?SzFpOXJnYmFZMkRENjRsK0RocHRNSFpyZkc3Q2w0M1VSb3IrU3NtVWI0UTBO?=
 =?utf-8?B?UkNiTnUwWUNCYlRDeGVmMHFxRVhrUDBoL1RxRlAveWJ1ZnhGV3Frc3lnd2Jj?=
 =?utf-8?B?eXY5YnFHdmJtMWQ2d0NlcnE4TlIwcXcyR1kxWjFJWEZzZGd5WlhBSGtyYjNB?=
 =?utf-8?B?V2lLOW9ROTBuR1pLUHQ5Z2hhSHdqV1JGYmJFbjh1V2s3TXpNUHZmLyt2UlpP?=
 =?utf-8?B?Qkd3SklvcEdsdElGNVFGYUhQYjJMbXlkQWRNRG92Wnp0bW56ZDVkSGc2bE43?=
 =?utf-8?B?My9YbUxFUlhyVjVaQjBzSklpWE5WTEVoSU9CL1E4QjZaZW5GMG9FK0RQS2dD?=
 =?utf-8?B?WHNsbkVXWHN4Vm9QOXZCVnZzeHVMekJPNG5pdmV4Zkt3NHRHL2JDVDdCSDVJ?=
 =?utf-8?B?V2hTMFhVZ1FpZW9SekorWVYxK1ZXdUpqa2pmejEwOU1zN2FOQ3pmL2QwdHNF?=
 =?utf-8?B?RTgvaWZrSjFaSDArVlQzbGFhVkdTZThvbm8reSs2cDNkd1BESC9zZlZ3bUNu?=
 =?utf-8?B?Q1o0NERlZ0grVEtLUUdKU3k5ZGwwZThxcmFxUHBsSlkyMGVzQXc4bWpNT1ND?=
 =?utf-8?B?QjZoV1hVYjd4M2VicmtlUGpIRTc2SjcrY25iM1FqemxjZjVTcFNXNTB5MXJJ?=
 =?utf-8?B?N1ppN2FIUXBpWUZYWjRVNXo1bisrUTFLQ1ltVCtNUUoyZk92akZ1NFR2RU9V?=
 =?utf-8?B?aTJVMFFWdE9PaitQYXdtNit4dDVRa2dyZVlFSE9EeHRublgxd1BHTllpdnlp?=
 =?utf-8?B?dlp1Y0ZiTUhndjJvem5KNDdJSWovVlh3S3dMMkd4MU1mazFBVFlXcUsxdkJu?=
 =?utf-8?B?dWV6TTFjQy9kTDloRVpzVkx0ekNWMCtFV1JkcHYvNmF5Vk5UUHc4TUJFK1lj?=
 =?utf-8?B?QnR6YWl6MVM4YnNJZmNQeUc0UjVHcHhKd1BScFNYMjJRTlJNOTVEd3NxclZh?=
 =?utf-8?B?MVpybUFUOXY1eEdxZ1RiWHJ0SU5yZHFxZmY4Z056ZjZnMHlzVWtuQ3FnWkIy?=
 =?utf-8?B?bmcyaStjRGhHbEV1ekdPUHRHa3JXam9LcVdJQmJYRTlXa0pvYWpKSTlkTERB?=
 =?utf-8?B?KzVvakZ2K25VeFVubnNxQms5aWVjSDhkNVhDUUlMZUFQNm5rV0NmcGtaL0l3?=
 =?utf-8?B?OUtnbWhidGhoTEpPUWkvTlJqaXpmVFVSSS9jeStrYXlxWnVwamFWVHFIaUVO?=
 =?utf-8?B?Y2xRamgzcGFyK2pMcXViVk9VaG1nTEFzMTRsMkw2bTNMaFVRdVl2WVRvT08v?=
 =?utf-8?B?ZS92NzJ1eFFsc29FTW44UXUvc1RNUXBqcFVnNXdUa2R1U0dJOHFubU0wcS9t?=
 =?utf-8?B?QWg3WWlzWWgwSlltRTgwTjVqUUY5ckY5TUlqMzFqZDRBTkRqR255WWw3ek1I?=
 =?utf-8?B?cUY2NVhGUlRkUlhZRkI3elkvUHVMa09LTHF2aGRhR21MTXB1YWlCWlI5L3Bi?=
 =?utf-8?B?cTJralp6T25jenFGSTNZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnQ3R01QZkpZQjBTdlRqeE5TaFppNStUZmI0VkNNc2tjZkFUR0tZR3c2NXFI?=
 =?utf-8?B?bHc0NkJiWWhUN1hFTWVsSHhucHk1NUoyQ0xIbWx0aFpqZjQzNWp6aTMwZFJH?=
 =?utf-8?B?RWVIWEdTTEY3ZS9TME1TU1V1ZGpjRGpuY0pWL2hrS1BOY0lIL0lLamxIOUxI?=
 =?utf-8?B?RVJRSVkvbmpWK2kzU0JVay9RYVF2c3d3a296Z1BUUmtYU2d6akNTZXBrMGhn?=
 =?utf-8?B?ME4zbkMxeHYyZEFVYzA0RlVzUXdXb3FMcnVPWEV2eDAyM3ZiVHk5SlRmVnQ0?=
 =?utf-8?B?TEZydkhSRWdERjJSeU9Sd01zUTFuRUNiWlRWUU0yc3FDaS9VSFE0WE9NOUJt?=
 =?utf-8?B?cFM4YmVqZlBVaHE0MHZXYzN2aHBxZzFRQVRoblNFRmdyMjVocEM5UERMdkZr?=
 =?utf-8?B?K1RrdVVIaXJ0U3AzVWdDaHJUSGlPS25BanNielZ0SGE0YUtQbExOZnkveTN5?=
 =?utf-8?B?SXV2bmIySExCSjlHV2l1QnpXZXJFSHhyN1ZHYVlqYnB3MEcxTWJMTzFDZ2w0?=
 =?utf-8?B?dzlIVUNZRi8vRVlPVVFYUjZEaVpXNmc4cUZEbFBhVldxSjhSOXM1NUIxZGhY?=
 =?utf-8?B?V1dwRytBTjRQU2s1SG94OGhkeTREKys4QkJKa2NZM3pYWWFqVXhlcC9XZWVC?=
 =?utf-8?B?Ly9WVzhLUklQMVNzSVRMaUxaZWhRNElwbWJnQkVGUGZlYlNjekZDYjZiYWRj?=
 =?utf-8?B?WnozbEpkSW1qYVQwZnNaWHBQdTRDbWtzSkFNeGorSkkxdDdUeEpEZFdoUnk0?=
 =?utf-8?B?ZHFHZEJraXhzUnVFSkozMGtXbEF4dmtGckU4MVg2RUcvM3IyQXlNRTBzaG96?=
 =?utf-8?B?NWsxUnlsbzlVZ1hXTGpzZVRjSHpQZGYxK3UzNnpiNDFIc0RjSDFGNXFMOEtn?=
 =?utf-8?B?WVhkeFk3SUU3eUdaZHVnWFljUHQ4cDZhUjJzeFBpNFNTVWxFVTZZay9LTkVW?=
 =?utf-8?B?Y2pxU3VCME1IOUVITm5lUmVpeEpKVWs5cGpxYnFHUDlVUWI1bDZqdjJiT2tQ?=
 =?utf-8?B?YVhBRG1JY1cvTWVPdDEydEh5bW9iYXBpdFNpVjFJSGpWQ1VNNjBzb3lZSG5X?=
 =?utf-8?B?Q1pVTHdxMHhZSXdsM1RkRkN1RnhiV0d6dU02NU9tSGF5aVBleU43NnN5NDZa?=
 =?utf-8?B?WW5lNDZCZXR4cG1xSXdIL1ZSTTJzTFBRQWJkQ01TQVlkaUtWVEYzazFqZkk5?=
 =?utf-8?B?UEFwR1AwS1dXMVRRK0FzOVRhTEhrNlhGUk9GRFFod1ZoTGdlRkE4QnZzMllx?=
 =?utf-8?B?TVdYTjd3WTJNa2c2MFpjNVQveG5hUmpScjNHR3Q0RnQxaHNXSDVSbVM5RzhB?=
 =?utf-8?B?N3Q2Y251WUg4Q2UxVHEveVB0cm52MEF5UGZpSU9CU3MzaTZNUVpPVi91WnFR?=
 =?utf-8?B?WXVraForbkRKKys1SFBRcmQwekZFZHNJbkhwMGdZMUp1VHR1YzUrTUVBdGxY?=
 =?utf-8?B?S1U1SGw0RWl2WVNHVGJuOU1neFFNU1lLaUluMllVY1Y0SkZPSGY4VGZCa0o5?=
 =?utf-8?B?RGIrR3lkKzZJU25FaEdaalpmSGc2cWxOV1g4VXJZbHRuWnoxdkowUHpDSGVL?=
 =?utf-8?B?WUhJZWkzTTFKcU5wTk5jZGNoK1VnZjB6NXlJZTZFSVdSNW5tNHV3ZXlvUUE4?=
 =?utf-8?B?SGpkNlNIR0NZUXplaXpKUlVpdWg3QVNJZTk5Nm5YL2FVNzVRWVg0VUFKN2Fa?=
 =?utf-8?B?S2RpTU41WERtSnZSSmcyT25nVHQxZzVydnh3dnJJRGpTbTRlaGxmOFcxWmIw?=
 =?utf-8?B?Z3paQUlVbDlHTjRRVlllcW5GMERzaStWeTBVeitUeHpNdFZ3NEZvSGhhclRC?=
 =?utf-8?B?aWlPd1MweWJZRVF3MFJ2cy8wNHNhM3FXQVF1cVA3Szl6bzVRalhsRlplajQy?=
 =?utf-8?B?K3pPZ2F4QmlIa2g0dUd1a3Z6NnJKTUtpZXlSalIxWW5QK2Q5S2xTK2hpckg3?=
 =?utf-8?B?WCtGSkRCQ09ERys5ODdWTkNQcmRTSDZxSk5CTmNvUjYvRVphcDFmdHJ0MTFo?=
 =?utf-8?B?dUF6WXZPQ3FQQmRnSnRQd2hQamxYYllWanVpaHBYLzhRSjJQVFc5R2pBSkFy?=
 =?utf-8?B?RXd0NmJtSGVxb3IxTFBvSkNqaXl4YUtGY205NGxkSDZzVkhtd0ZPTzA1OXJ5?=
 =?utf-8?B?WGp5MHR1QlJCaERyMHFHVk5PVFhjaHpoTzNsVkRJcU5RMlR0T2xMb1kwM09W?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a06f8c-36fe-4b20-229a-08dcc2a6fae2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 12:36:01.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9Bl/BtTW9U3R2JVx3gV9TDj5Fi82Z0oZaTL8/3iHMgeCTSrYmNKLN2PNRPVpQuXx4yyAKoBxAomEeRdW03s1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5564

On 22.08.24 13:16, Richard Weinberger wrote:
> Am Donnerstag, 22. August 2024, 12:59:54 CEST schrieb Jan Kiszka:
>> On 22.08.24 12:57, Richard Weinberger wrote:
>>> Am Donnerstag, 22. August 2024, 12:51:34 CEST schrieb 'Jan Kiszka' via upstream:
>>>> On 22.08.24 10:07, Simon Graber wrote:
>>>>> At present, for two Xenomai processes to share resources, they must
>>>>> be started with identical --session= parameters.
>>>>> This is cumbersome for extensive projects involving numerous helper
>>>>> processes. This commit allows the specification of the session name
>>>>> via a global environment variable, namely XENO_SESSION_NAME.
>>>>> The --session= parameter overrules the environment variable.
>>>>
>>>> Hmm, did we discuss priorities already, and did I say that this ordering
>>>> would be best? Then I'm no longer that sure, and my feeling is rather
>>>> that env should overrule command line. Still looking for other examples,
>>>> though.
>>>
>>> I remember, but the other way around.
>>> Env overruling commandline seems not natural too me.
>>> Passing --session= to an application and seeing no effect is not
>>> user friendly.
>>> IMHO, the environment should be a default/fallback.
>>>
>>
>> I'm all for least surprise, that's why I'm looking for existing patterns
>> now, rather than personal (my included) feelings.
> 
> AFAIK, at least git, curl and GNU make give command line options precedence
> over environment.
> 

Good points, then let's keep it like proposed.

BTW, all those new variables still have to be documented.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

