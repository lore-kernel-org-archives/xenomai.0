Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795530256;
	b=UShpRiWpG0ShZkirwLRh5vGiz6BnfrXM2zhWhLv/LHkPiws2YeQ5JJdtRgL8sARS/Bcy
	 HFp/inHKxQrzwGTsym33h8QLHxjOMD3MsnnGtTNT8pqtgGPDKYqgEcTphTh0KrQAfAuYQ
	 5KChSiYhARlMToXilYXURIRDlcgJV68u9aFWXRapZ1BJvm/CWv6VRb94m31niUGTy9766
	 G7X7H72Hz0ASKIu2K5D/s4N5VKvGwu/E3rmSngGCCD7nR3fXoJAPK8zYBasGH1WEcNhhy
	 she8unqyNVEOMmDW1pgmnpMrF+d1iEOldX2W+ljrcnXNDaRcMTJRLr8e0UHUCrLmJiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530256;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PfcaMgnDudCTXys141ah0vtnaabRa5AxnRgWu+g4NM8=;
	b=rruwQ2BsrnPovzxC5eDGr8HBrbJEOi2Ii+VC+meXBhW8baHDBS/KyL+eAPLN3ihHBTEs
	 G8dI/bT36n+sa8YCFLbxQVZ99O9laIDh938CzW8glsLRIM37/VUVCd6dDU4/PlqQLicK5
	 fIiSJ/qFy8nd3nTN7joAc47l25nOhgi6u8eoHDPfb308AQYcH8igVDE3geNKX/Jjgp0N0
	 P8sTTEG/urq/U5wlkvupGum2Kbi6R11z0ChS6gd1+/CBbIe/K6U/HASJlCuQJm3gptGBA
	 Vsp4W/DwPjXX6va6l980jaNUCCjDf8gg4CWzHsM69su/4yVBedDro0iqM6M1IEJEslg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="Z1VfFxH/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.67
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7F606A31E
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EA7F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Z1VfFxH/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zReIEKhs85SSSV9ClUEA3DZMJgHW1i65JuVL0Us4cm8ENFmHq8CzhtO9t8a9bWnTOU9p+XQTfnaVUYeSahHHPmI9xrPS7Sv7oEgpBpT7U+YXF3NqilHOEWJdNfS1TDYnqCjzOwnYuA8hEKGibGAqXV9/lCAN5JlRzlumBfCF/0996AlzOVThGDKcfyyz3XSEUbTr68ys72IFCe1RHjI0C98tcgkGdsyXeFJv9S0r7XMYOro1LABjIeoruaWcKnNQYYevaV79BmrXltB4TmPZ/uk3pMnNKyHobwOvoHJpSmyr0XwyVvtmOcOBstJgFcW0aS7oTb27WoAGcsjfeCk59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfcaMgnDudCTXys141ah0vtnaabRa5AxnRgWu+g4NM8=;
 b=brA5zZQmjpEDk8T41++JTtvZkRP2PfZllmPAfdw7a4gMzmXDU9L5Ly6oarQS8RDULneBayjvyMKygBguPzTFuMGPJQZWJ+menqYObPLbnmtb/SllcpXHjQCHOoZW2qv4Y2DZP8TtubLMbxT3Z6o3SOxVOVU69T54DfJHFzKJv98m/kPwoen+e86DNAX3J6oxBHMbpqMRWUY1Zb4b17bQa/psEvu66eeuw2L2YvDRBhdMvnuukDdtjpieSwwYXR3lOeuS6WYsW29gmQyHJeeZY3d1nuPswH4CyLlS4ijkWIvrQWXRk6Xh1l6ESDoAraPNIcm50+Hm0leC7wpgE9hOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfcaMgnDudCTXys141ah0vtnaabRa5AxnRgWu+g4NM8=;
 b=Z1VfFxH/JEI9ukCvP3pHgXx3LsehZyuR4LSqiWMr2HhUOtWzJrXgPVn1HJbBRlSZnL+eFyhIFy/3At8O6Mauc81V0oUsW7B4F3nCxDBI0nUrQHagjR0CaLSaLIwJgZ6lAtuwpdFF22Mdy+yRdekM9cQkml6XDAdYth6AO/fBNDJlziHkgjmVCOTQaFQkfKTgucKVJg9Q/djbZsyGMNrLECq6O71Hqt+lwEB/AF5UDHxU97tF3S/Uo3uNe+r+kggJRtsRLmKt6/B6SUPTyDKalD0wk9eeZNB9/4sj+SXl3qFDiaGEX8BOZHc/BOkQqPQyc2ytUVePvCLRSPS/c+UadQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM0PR10MB3169.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:18b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 14:24:12 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 14:24:12 +0000
Message-ID: <a1f798da-7535-4cf2-aae5-412953ccabe0@siemens.com>
Date: Tue, 24 Nov 2026 15:24:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Cobalt build fixes for uClibc-ng
To: Yegor Yefremov <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20261124140303.3336015-1-yegorslists@googlemail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261124140303.3336015-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM0PR10MB3169:EE_
X-MS-Office365-Filtering-Correlation-Id: a22b28b7-1d67-4147-4faf-08df4a369c95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|261009223027099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003|261021123027099003|10067099003|261102123227099003|56012099006|11063799006|6133799003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	697VkJBr6FTzjvHtf6cpSJSGQij+15ogTAQvQeqL9Qn0VUmlUD4AxuDW5X1/+H8rePC7vT4DZZIrLSI5bUWYpz9tnAMATuytPiuzz73XqhqHBNgggITyqO7qEvDOiqwkjSRvIWSDPNbJZe7/kbVGgJpIwiXjB73AO+Cwj1BuUSUkY6mvPKzgw5wxA5fD9WYPkQYRyVoz6zL+fHaiK0UNY6Iap1yMzkiEiBw+j/kKHruftb9hV35sMZvy/pP11tuhTmy/PYtkFczVkJ9KHQ7UqyA1ZnlXL2bUhy54ZBk4eAN5Z1/m/ukkIpuZ0eESa/1xiBkfxGXbiFBRY2Fs49YpNOaVABg02CYyHLaY8GyytNlHlQxcfMgPRijuqtafTK4BedLqtbUHHxCxUNtYzEExU4huCWQC0rXv5RNie/432wmd9mnTzkqFBGcgkDUD6FKdEw3khY6DtGdzvR005ms+4srFjWKXnTyunnluYivoYLiX+411fZ9/5wpEtCwkYQ3RvTAPOvCxFLu0HCJTY1MZXbITAFUANoICdtbCHr3rpvP8c4ZcC2s4VhhCUOeQlhEgtYaMCkfkExCxkwu/m5icmhqXrcolHAgQ7QHRo7sfLzKz9Uzwl82ow+fLcH8Z5V/nZZcwWG0VpQrP215YSx/bIeqf57YcqnMr7MTB2BTWSlg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261009223027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261021123027099003)(10067099003)(261102123227099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlpnOXJBTWVMZ0hkTWZyMkwyd2V3UTlURDc4UmNqOWZFYmh6N2RTcWNIVUNw?=
 =?utf-8?B?M1N1anFsZU1SMUZaRGJFZjdJWklSTjlNcnRibWg2aEd6N2l1a0RQYjFKZUxL?=
 =?utf-8?B?NThWYVlXRUo1ZXUzL1hpYkZLSFd2T2NWelova3N4b3lManA3TXNGKzJFaWJN?=
 =?utf-8?B?OVhTMGVWT05LODRqandDdy9mTWtVZjhXMUJyMTE3L0xOMTZJYmVnVHNjdEtY?=
 =?utf-8?B?TVFJc083ZkFySlQ1V0dWWGVkaHlhSjltM0F6Z2pxVXJsbE5ZdFo3OCtySS9B?=
 =?utf-8?B?bkFwNGNjM1crVmc2WThBYlgyMnJNdytwbC83QUdScWkyYmtWcGlXQVNMekdJ?=
 =?utf-8?B?ek14TUJKMzlac29Oc203V0Z1b2tBNkhZZ1JkaUZqWHZVeDN4TFUvUHQyNzhp?=
 =?utf-8?B?dGFqZkVFNFdYakYvY25KTWkzZkVsNS9HSGNYTlJJL0luOUtCRE1NYzREWkJJ?=
 =?utf-8?B?R0ZiZFZNS28yNkQ0VkNDTnlLU25iWFYvZ25taXBpc0wvU1JLekVqSjVlUVh3?=
 =?utf-8?B?dGxScWZ0Y2J1VkpRNXpSNDc5cGFra21sTGhiSG1SUEhqZTlzeEVoVEZESEs5?=
 =?utf-8?B?UmdzMVR0OXBrKytvR0dSR1o2SlV2VXk4L0VHYXBkYUd1SzA4dlVnbnY5cHBw?=
 =?utf-8?B?WXBUeWlEL2xGOVdoaG1JbnRIZnp0dDhmNWZrVVlobXRtcXBWbENoOWNLYUlB?=
 =?utf-8?B?N01OREVnZXc4ckNZc2VpdEhJYnZaaENnc1cybHJPS1l0YWw5UGVWN2tGd0dW?=
 =?utf-8?B?YUZDMVV0SXZCczAyRlQ2aTRweW9VMnlKSjloQXdPRXFhSGdaZ2ZtVXZIWjdk?=
 =?utf-8?B?K3YrWk0wRGNqMTAycXVmTWxidFo1OWtIRENMdVJWdGpLTU8rTkI5MnpLcGxX?=
 =?utf-8?B?VXEzVkp6WEhTell6YVU3QjZ5dUhKdml5MXVjQnhoL0I3cTFZaDZDaGoxWjFm?=
 =?utf-8?B?OTVTUUVzd0JqK2lGNmV6TnVTSWcwRURON081b2ZnWkNQRTc4eWZxcXBrUzhN?=
 =?utf-8?B?L1NZUWRRRUQwNldnSkNSYVBmNlp4TmpHYmY5ME81TnZJZDBsUGpLQmtFY29V?=
 =?utf-8?B?RmhzN0R1c0p1aEdyZTFNbzYyeHRQak1CYjBjRU9SSUU5TUJ1Q2lrVmtPRktm?=
 =?utf-8?B?QkQ5OXV3cGdWb3EwMGV3WklWUFhtUEpIUm9NeDlic0FENzVWYmR6OGlQQmw4?=
 =?utf-8?B?cTkwd0RYZVFUbTVHZEgxc2o4Wm9GcXJWdjBmR3B2c0cwNE9aWXlENU9md2hu?=
 =?utf-8?B?OWk4OGN6ekhSaFZqYzdIK3h6eTB6TkxmdUlPRTNQbEFya25vZ2k0VTQ0S3dQ?=
 =?utf-8?B?c3BnNldlSWJjNWhQbit5YmpXY2loWXBHazZsQlcxLzh0aWdHa0hqa3JWaXJo?=
 =?utf-8?B?TkhHaTNseGUyYnBwNWNUNmtrL01iNDRkYXI2YWx4Wmw0ZWdRV1JtekFqRERJ?=
 =?utf-8?B?UTcwdHJ3SzUyTWlYdW5WRFBXa2YvUnlTaDlRNU1xdWZFc28vanBIWWJDSUdx?=
 =?utf-8?B?b2N5SWs1TkYzSHp3TWxXN0t4Z0UxK1N0SFlFS2FDU0wrL0dxRTBMUzFSWDhS?=
 =?utf-8?B?ZTBDZHpzdDZRdnpNN0t6a2NYVEdwZDd5Rk01Vnh4bVJYbTAyN3hQeVdoaVRN?=
 =?utf-8?B?UFNucnB5VDdyeHJXNmxYR1BuL2NtRlE2anhHa2V6bnhIWmcwSU0zL2diUk1l?=
 =?utf-8?B?ZzBBOUErRy9SbEZ3ZTFaRzZWR05TM1hmeHU1MHVRRVNkdDFiTUpLYkNMT1RK?=
 =?utf-8?B?ZXFxUlZIL3BJa2d4WUtNWTZIMVNHeXFPRURjaXZUWno5L25aYSt3Wno1SEI2?=
 =?utf-8?B?ZWZmS3hiZ2pIbWtqbUpTTmQwb1BESlMzSURtdnNDTmxxV0o0c3lUL3RwSUJw?=
 =?utf-8?B?QTFIbUY0YWJ6UlVvNUtVNlo5QXBRY3VpU1lIRXFTSWI1NENvOTlLMHZMVDlX?=
 =?utf-8?B?dCtEckt4dkVHS2lvOThZL0dxdXF1WmpTWmpuVE9ZVVhxczlrZjgzSnFDd0ZP?=
 =?utf-8?B?K09yUnlGbjJZTkg5Z2dlaTdtZ0JqRDcxTGlEam5pN05mR0RYdVFsc3NBeEZy?=
 =?utf-8?B?N0ZzOVI0VFVSeldzSTQwbXF2MW0zVllVNmJjUnBJQUJuMnh1cHM3Rmw1ajht?=
 =?utf-8?B?Wm9HekttV3F1VTBCK0V6engrTVE5ekZuM2o0Tnk3eER4a2tibXI2bEp6MG9n?=
 =?utf-8?B?Z3JCSTRrODZ1S3lUcktOK0grSVgvckhMdUVSa2lqck93RlNzQlhRV0hsYm11?=
 =?utf-8?B?WGtXSW16Qlg0NHZvRnpmK01DT2NlR2lkb0QvdWtteCt4K0x3NDdZbFdPYzAv?=
 =?utf-8?B?V3VidDRIV3F4L0NseHU4b05JN3VDWFlYcHEvNUg3SDd5aDNMNHYvdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22b28b7-1d67-4147-4faf-08df4a369c95
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:24:12.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glSI5+sGxRClnvXDkbZZnJzXoT+QvbGu2vkEgVmQD/tTDfeYb6yNyVTFRukUJ1TJ3B13CcZsgL3paZBL99lLjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3169

On 24.11.26 15:02, Yegor Yefremov wrote:
> Cobalt has not built with uClibc-ng since v3.1.1. These patches fix
> the build, plus the clock_gettime() vDSO selection, which picks the
> 32-bit call for uClibc-ng with 64-bit time_t. They complement Jan's
> mmap() off_t fix for uClibc-ng >= 1.0.58, now in next.
> 
> Patch 2 is only needed for uClibc-ng releases before 1.0.43, which lack
> getauxval(). The Buildroot autobuilders still use such a toolchain
> (br-arm-full-static, uClibc-ng 1.0.36).

See my comment on patch 2: This is too old to be still supported. If
there are active ucLibc users (independent of Xenomai), there should be
also recent versions supported.

> 
> Tested with Buildroot's test-pkg on next plus this series, building
> Cobalt with the testsuite, RTCAN, Analogy and the pSOS and VxWorks
> skins:
> - armv5 uClibc-ng 1.0.59 (time64), GCC 15
> - arm static uClibc-ng 1.0.36, GCC 9 (getauxval() fallback in use)
> - armv7 glibc 2.44, GCC 16
> - aarch64 glibc 2.24, GCC 6
> 
> Without the series, both uClibc-ng builds fail on __OPEN_NEEDS_MODE,
> and the older one also fails on <sys/auxv.h>. The ADJ_SETOFFSET error
> only showed up once these were fixed.
> 
> For patch 3, I compared the vDSO symbol the preprocessor picks before
> and after: __vdso_clock_gettime64 instead of __vdso_clock_gettime on
> uClibc-ng time64, and no change for armv7 glibc with or without
> _TIME_BITS=64. I have not run it on uClibc-ng hardware.
> 
> musl is not covered. It defines neither __USE_TIME_BITS64 nor
> __TIMESIZE, so libcobalt would use the 32-bit time syscalls there as
> well. That needs a separate look.
> 
> Yegor Yefremov (4):
>   lib/cobalt: Don't rely on glibc's __OPEN_NEEDS_MODE
>   lib/cobalt: Provide getauxval() fallback for the vDSO parser
>   lib/cobalt: Select the time64 vDSO call without __TIMESIZE
>   testsuite/smokey/y2038: Define ADJ_SETOFFSET if missing
> 
>  configure.ac                                  |  3 +-
>  .../arch/arm/include/asm/xenomai/time.h       |  8 ++++-
>  .../arch/arm64/include/asm/xenomai/time.h     |  8 ++++-
>  .../arch/x86/include/asm/xenomai/time.h       |  8 ++++-
>  lib/cobalt/parse_vdso.c                       | 31 ++++++++++++++++++-
>  lib/cobalt/rtdm.c                             | 14 ++++++---
>  testsuite/smokey/y2038/syscall-tests.c        |  5 +++
>  7 files changed, 68 insertions(+), 9 deletions(-)
> 

While asking the AI for ucLibc fixes, could you please also let it
cross-check if the fixes will work with musl as well? It should be able
to do that without BR as environment (it did micro-builds for my other
path on its own when given a cross-compiler).

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
