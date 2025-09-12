Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C11D63F7
	for <xenomai@lists.linux.dev>; Fri, 12 Sep 2025 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655338; cv=fail; b=V7/AUFL1M5/KP3X5H9dyaeFtIaqcqhMkG11oCqGWstlPcWzqJHKhS+Ds0xMhLG83zn2KVVz5NWiK6HD6qADJ1pnN/ZjoMcxs9W0JZ89A8ZG3WlE2srYbit9LA0wQnOTbTX+hxwgzesBg+JgJ2dRsE0f2R7RaX4M7YKdqW/ooPhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655338; c=relaxed/simple;
	bh=tcCv6d231e9VfMWwSO3puGkIL0rU30PXV3sxuDk8yyc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LVn43fiNqIs4FK3o7cLBL3K9wersMCLYbORhrE3W+oGfr20MwE9zmxdEx7wnuQ/9sEkfuXoPowfSDjmyDsqoprWCXC0UPo6EzhYcGWFETJ1kan5MHjeXoFhEwuHRdEn7+9vXS3bn3l2cnXR2xQgKtK8XHd1rW0cSc5SFQ0HcDR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cuMPJp6N; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cuMPJp6N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vg3juDNhntalWDH+zKiJVQfV8VIE4x+/Vr4M3u3WaizRwYWe+/deZBBqL9XWY56p/z45yRxRTb1XA8kEl1YXLWZe9D0HTZb2alfDJHZP6aqflZHve9refjRp4J1OHwGNYRqPq6hlRlcw/q3r+FQYWw10puqteo1bsFfNiFjQ69TWuSgorT8Otis4taoEGR08M7OitYmNGTXpvjSjZy3qVhZ7D5Bi8j3TNO0pBTvSDT0Yv59VmENEwC4k5yVJF0EMVoFSKctZjpRxlxNaZJv2Xl82X//W3MC4UoYurddow1WN/vEGeJJ6GEKtUerRyHo5KCcwxbh/rqG8TAjPZ/yI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpKkE+8tHfCHoP0x58UBlWpwhoEfqridi4PucdJDlO0=;
 b=lEnzLocL8tC0rRIRuWfrUdt17hh7SA+hXCmLc2tW7capWuqiESnzHvM/U43k8BPHw/Qzk97yafpG8muElchNBbAItdhfyBs2pQxxk5gHQ0E9si85yfmOMmqMeQv2RhGyomN1XiAC4wMiexikcDuCHk4ZFQxSLeR021TNvdLGJn/RwII6WFXp1xU0u+UXtxaiDE7UHxIx3wSrUJqQ2XfRWDWiMXeepTRxKDkVV0p5sd0/EfYoVM0fRm9oKvjBwPgjwemYAE705cWSi91cojX0S3ahPKp9PhAcoahwlxJSO4LM04YRZIm8SFpWq4SLN3MSC56OirotMJ9U74cdMv9rLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpKkE+8tHfCHoP0x58UBlWpwhoEfqridi4PucdJDlO0=;
 b=cuMPJp6NH+dN1WoTZQX8SodGYQ/d97bPNNz9Q/lSjXpBBY154JSNMXWdGFsimL/IvLIUiEcX8qpC1sIZU4wP2kDU2KEEPYhPJ78nicZJIdtsH+kWc+VAtqETqE7ushJN34i60i8RE5GBzyfX4RKIWxyd5WBnwcNN+/gQrfrH7gpdQsat0ZAhyw9f4dbocBJTdFRRrL6LPW4ZZZfxwfw4xakNrNwKWhpyDBt1pnKgURTUeX+HA4uJCoVUSsgfly9SfaEG4TA5E1Z/qUXxtG2DlHR8OTN6AJpTGDafuB3xz/h3PBXEZs7NOWTMHh6oy27tD58DJ9F7SBAGtpHPGGXzPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAVPR10MB6864.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:324::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:35:30 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 05:35:29 +0000
Message-ID: <8fe896da-950e-4f76-9386-accd3b87c1d5@siemens.com>
Date: Fri, 12 Sep 2025 07:35:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][ PATCH] armhf: Enable audit syscalls
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, xenomai@lists.linux.dev,
 florian.bezdeka@siemens.com
References: <20250911121216.2585340-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250911121216.2585340-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAVPR10MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 29db332a-378d-4069-5b2e-08ddf1be2f4a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWMrcEVUdXZla2pXVkF1MXc5Q3hCc0ZxUFhDWWpSZnE4Q1ZwclZYWkNMRnQ5?=
 =?utf-8?B?K2RKUlpLS2NCc0lYQkJucEEyeFZQMWJML0F1cUNnblFwdGRiRDJleXB5clpI?=
 =?utf-8?B?MFJIZVl5QmMxaGlwZHpJL2FDUkVKS0NYS3g5dkVoOFlYdlBubHB3d1Mvemhv?=
 =?utf-8?B?MGxXVzFFaHlPVm80VWlqcjBBbDJvUmJJeFJLSm1ydFFKZEMrc2pnMERyTVBV?=
 =?utf-8?B?S2JPaEhVRWlzemZTMVFCR1Rja3BqS2s1M0RCczlpS0M1Q2VBVXJwYk5RZ1FG?=
 =?utf-8?B?MUFyemdUOHFqZHU3Q3pndUFYb1ord3VKZ2FTNGo4Y3BvcmxBNHVqbkl6TWQ4?=
 =?utf-8?B?dUJkNUEwejlRenpLdnNmZnJMdkcvYXBnVTgwTFJSSW45OFc0OEdTODZNWWtx?=
 =?utf-8?B?UEFnSEQ2WXNxSnJiVUZVYmExR2tHSEc3ZThwVG5scUQ5VmJHTHFML01nRUlY?=
 =?utf-8?B?ckxMVllQNHFZc2xyMlVBbERRRThIMTR1R3FxazZDaFNDTjNaVnRSR0pLbHJC?=
 =?utf-8?B?bFVSLytoQVdIUGdwY2hHZDRKa0ZJKzVBV1RVaW00R3NKS0U1ZHBTZnQ5UG5m?=
 =?utf-8?B?K2FueHJVZFk5UllTeGFVTjBzZTE3L1Z3cUZGN2ZaYmRkb0prNzVhaTlPSG9j?=
 =?utf-8?B?ZUplQTlsVVBUTElSODJEVEFXZENqUG5YTHNwb1lCd2crRHdlRklDdFo5dDJ6?=
 =?utf-8?B?TmcwQTJETEdENks3MXBnL1E3WEhNUXRneDBCV0NYZjI3VGR4TE1DWVFONnVV?=
 =?utf-8?B?N1pyYU44Ym5SenQ0KzlrM05WOXd3cFlSNTJNU3FhQkVCQm1SNm1NM0hmZHdI?=
 =?utf-8?B?NHp2ZlpQVFRNZmthZ0NsT2JOMW8rcVFJQzJTR2RIRDAxckdDNUNQZHZwMS9z?=
 =?utf-8?B?MTd5ZWRqbFYvSkJDSU9QOGU0M1ZSUHdvVm5kOVpJdVVyR3lDZHFjazVZaW8v?=
 =?utf-8?B?SnBnS1d0YkRqMmxlamhmZm1XL2UrYWhGY3QwdkJHY3ByaUZJSW5sMUVZQ2Uy?=
 =?utf-8?B?ODUyNHBXaGdvT2d2TjhHVHM1TDZLM05aWE0wTGNEcytVVzEvZCtBTEZBK05P?=
 =?utf-8?B?eDV3YjlrWXc3UlRHVjE0MDljcm5VZnFwKzBvNVZNaEJxNWdqTlRJNjZ1cTc2?=
 =?utf-8?B?VzVhNE5uM0xjSytnbkJSdVFPWFJtMXlsVkxoamV2blRVcVFpa3lhODVFM29E?=
 =?utf-8?B?Y3NGYm1pOGdPR3N3VHhoMStFQndtQzJSR0tWTm1OMTN6a1FHVXgvUWUzMEZT?=
 =?utf-8?B?RzhIN0tHLzVSb1J6c2VjdjFTeTVWNW1qM1FnOUdVZ2ZMRjVVNTZrMUtMRXJ3?=
 =?utf-8?B?RjhJc3ZqWlB0QjlOcFd2TjhzUlorbHNNb2VCc2Q5SVZWMjV5S01iYnNLV2xs?=
 =?utf-8?B?VnF2dytTbEg0cGU5SzUvSys3cXNkT1hKeG9nNmZSWTNUUTNaQ2hGWklKRXJu?=
 =?utf-8?B?UC94U1MyTkxLTWNmSWZHb3BaWDhzVTFaZTBTQllqelBScmZGUk1xTUc2YW0r?=
 =?utf-8?B?MmV4Kzd3VEFqK2RXK0dzSTU3RVFkMDFFUzJyck9CZHlKcnNERm5kYWN6UmNG?=
 =?utf-8?B?QUNHZ2JPZmY5cFdPbzJIcTB3WTd1eEk5N2JSaWoyNW03Y2ZadlhOd1Y2cm1m?=
 =?utf-8?B?cWVpSG0wYVIvZVkwS2NTenR3dW9ibk42NGVVekExMnZwTGtCZ0o5Z2VSRnM5?=
 =?utf-8?B?akJqZTFVNDhVT3FvMU1FMU54a3hLZUJXQzl3ZmNITWVzYnBDSkRYZmlVWmpx?=
 =?utf-8?B?aGl1cmo3SmdNVFRzZm5raUs2SDhTTkl3SE1uVEhqWEhhaFF0OS9MTnlpbDgz?=
 =?utf-8?B?TVByalhPeVlQQXNGcXpEUkZtUTZoK1NhcnBqZldXVlBMZDU2Qm83ZkZZYTU5?=
 =?utf-8?B?NGZvQmtxbnFtU2p3UFB4M2RFZXZqNGIxR2NaZlRmQ1UvVTRrVVBYb2RTR1Uv?=
 =?utf-8?Q?DMaZNTYzL4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1hWNEs4Mk8vUXBMMGwySG9HYmhIUmNsOEVCaTNTNW1tK2VBeUt6V1M5cWc2?=
 =?utf-8?B?QzFPangzSjc4MFV0MWJkY2ZUM0lielV6dlE1L01Vb3g1SlgxOWhtMVV2aHVm?=
 =?utf-8?B?SkZIRUcveEVETExVTGlUZzIxY2J2QUI3RWtaM2ZQMDJuY3E5RE1xanJKdTFF?=
 =?utf-8?B?ZzZhMllyTWovQ3FSVnMxQ0JoK0Rla3hwY1RtRnVzbld0ZFBHTUFDTlZJd3VX?=
 =?utf-8?B?VytPV1hTRFFQZXg4bjhhMGVieHhPSUN3ekRVY1hTdlZCOFltdFdRSUtRcG00?=
 =?utf-8?B?eVdtTXBQVnVtNkJDMjZ3Smpkc1V3alpFZ2hDa0FDeFVmL0RuaGpQM3JCaDJX?=
 =?utf-8?B?cnpOMmI4RHpYS1JLMlloNWdZVEIwbFNvRlkycCtzU0sySzk0K1Q0ZHBUeSsx?=
 =?utf-8?B?eS9YUU5jWlRPaDA4cTBBbUQxeWE5VERiTlpCVVdzc1hSR2xZOGRPSGpGSWtM?=
 =?utf-8?B?cmRZU3VHNW8zVmxYeHZZRksyc3lrRTlqK05sQllKQTNYM1hqZ0JkMkx4QUE5?=
 =?utf-8?B?RHVQRmZkMUlrcEthaEJ0emRhNUdUUjg4NDcyZVQ3anM1MUhPVjEyTVlrdHZj?=
 =?utf-8?B?VElhTmZyaHgrTDlBY2czRUpoTU5mRzluR05lTWd4YzIzKzU0QUU2VTdZdjJS?=
 =?utf-8?B?S0VmaG9neXF0WlZhTm1WeWM0MTRUVjJmL0RpMzVpZWdOUUlFRy91c0J4WHRC?=
 =?utf-8?B?SHNQT1dsY1E0YTR3QlBkc3lhMkdrRFhZSGUxT0t6b2FTNlI4MW5ORTExSmNo?=
 =?utf-8?B?citneDVlVW04ODZHcEQzd3FTcVJ1ZFFGcXROVDFYRVlBSDRCWmhuaFpvZE84?=
 =?utf-8?B?VzA0UVltZ0JTWkljWVgvbUhEaVYvMUZ6MTIxTHJsQ0FLWEEzcDc1QzJlWkRs?=
 =?utf-8?B?MUxaT1lYbVFZc0xCWUpaNXN6b054emEzL1NmQ1MwV3NDcVlndFViUW1uOU5V?=
 =?utf-8?B?ektBL2pBMlNWS2dkYlduU2RKd3FWSjRDR0pZeVVsMnp0RGVDejc2dkFtVU05?=
 =?utf-8?B?OW9Ka05rbno0cHl0YS9qYU91VzdscG5FOGFneUYxTkh0Z09ib3VaYkFkdVAx?=
 =?utf-8?B?dTRCdTRoVUVheTF2SjhHeEQ2OWlCSmlLVjNINmhncEJkdGthSGMrMStmWHBz?=
 =?utf-8?B?RjMyRUxzWVdMdG1GeThZWXlJOVlPbWhZWHFHcjcvQW52RmlKZHJWZ1U5c2hs?=
 =?utf-8?B?Wkk1S2xKNEZpWllXSDgxVTJ5ZUhrOVVTWHlaRGtrNFUxMTRIVHhQalR6U05a?=
 =?utf-8?B?aXJoYWlvTTdQZUw0UXg3NTlKWjNvT0hzUnAvU3E4MUZrV045eDlyMnVmeWRm?=
 =?utf-8?B?UHpobVBMUEFBZ2o3RllHQzdOTjVDWEFoWDFGaVJmTGtTYzVKVThya0pQZC9C?=
 =?utf-8?B?RUdFZVhtL2c2T2N3VE9Vd0c4S1l3QjM4TjlPRnA4MktHdkZON25XM3M1MmZT?=
 =?utf-8?B?a2ZFZUttd0YvOHowNW83WEU0N05URXlSSUFYeHg2Z2p1NldjdklLRHVOZzRq?=
 =?utf-8?B?K3VON3hBRm1ybnN2YUtpajJUL3pGOWRqZnZpNkpLendDUElQYTdhNkxGcmw1?=
 =?utf-8?B?QmVOS1RuNXBITHc5MjVidFQ2NWdaWUdmS0xML2JWTlpuN3crWG54WGVhcjNS?=
 =?utf-8?B?bnFSbHVaelkvR0UyK1BvS3FtNXBsVGQxWmNPWHE5RUxJbTlraTc1RWdwMUda?=
 =?utf-8?B?c2JPZkZLVWtjdTBUR0R4b3pjRzVkYk1QR2tDTFFBRlFQNmFITThYWFZIUzAw?=
 =?utf-8?B?VUcvYmtNdklXeGlkdFhtSVR0ZDFKR1d5VDRFL1BRRXBVcXBuSGxHZENJSWVk?=
 =?utf-8?B?TjQzOFpqMUVpOWduWmprdGpZcVA5aUNQUXArZG5XdHZ3UDVnQkhRdmpvVjla?=
 =?utf-8?B?S3IvZ0hLV3BBbWR0MjdSaU9BV1hhV1VETkJjbVBSVW5xMmtBUjJJQW42VnYr?=
 =?utf-8?B?THJLbSs0c0U4QnNQa2tQZ2pFOW15dlhydWxucHVwNlBtM1pVTnMycXBDaDkw?=
 =?utf-8?B?Q01jM3VhUDlLcHNWUWxoeEluYldkQ3FDNGJiWlRiWGR6WHpNMlg5ZGx4YTdn?=
 =?utf-8?B?U3BtdVd2bmVhTk40QklDRU5TVVBrTHVOaGh6dXJ6bUpqTHg3ZHJGeHdNSExO?=
 =?utf-8?Q?bkRW9ybvyEl0wGZHz2ibN7C0Z?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29db332a-378d-4069-5b2e-08ddf1be2f4a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:35:29.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1K5B/yOdICtOVUAw4Of3YtCRoXu465ZJAbY8xG2CLH6sbcv0qkuFz3Shj2CyKK4icQHucGis2TpiiTl6IBdxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6864

On 11.09.25 14:11, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes the following error during the execution of the LAVA
> testsuites:
> [[0;1;31mFAILED[0m] Failed to start [0;1;39mauditd.ser…e[0m - Security Auditing Service.
> See 'systemctl status auditd.service' for details
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-kernel/linux/files/armhf_defconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
> index dee6f5e..7f370b9 100644
> --- a/recipes-kernel/linux/files/armhf_defconfig
> +++ b/recipes-kernel/linux/files/armhf_defconfig
> @@ -56,8 +56,11 @@ CONFIG_SYSVIPC_SYSCTL=y
>  CONFIG_CROSS_MEMORY_ATTACH=y
>  CONFIG_FHANDLE=y
>  # CONFIG_USELIB is not set
> -# CONFIG_AUDIT is not set
> +CONFIG_AUDIT=y
>  CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> +CONFIG_AUDITSYSCALL=y
> +CONFIG_AUDIT_WATCH=y
> +CONFIG_AUDIT_TREE=y
>  
>  #
>  # IRQ subsystem

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
