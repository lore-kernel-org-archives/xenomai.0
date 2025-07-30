Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E58D24B26
	for <xenomai@lists.linux.dev>; Wed, 30 Jul 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894687; cv=fail; b=VYtoCcoBnfRlh2uHGXqcDCGr/aoBkyWXSAxm9BdJw2SrrO8LLLHxFIWM4+MGkEfxNOsI3cKQIyU9r8VmlQBV0Bjs5I1EORCBbuwehfYBMh5MOzXXSsor82HHOFOcMtZH3T4uH0Sz0y2lHcMakLSdUiNX2gZViz+KOCs7PzVE9oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894687; c=relaxed/simple;
	bh=53/K0ecOshxWKbd1UOeDUBeJZM2CbL1Vr439b6ALwTk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sKvyuFiBWftfKOlpHmYcAn69i0mP3bt8gZGoT1I29n02LC9qGzlIjyEgnfJ1oHtLQXzDkC7UXvvtuvNM13wRmOSEuUEn67dFxX4QoyxV2zmYTiIVNXRY++r7WOPBv4WGZBZ4XwP/PXKYnpGlISoFeL2snjlXN+BVeFqDm2/FvyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HMhRW+fa; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HMhRW+fa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaIFVUxQMUvM/HD390qPnVRmUIuYEngnhcF6j3iUspg5VPkBnO7qbRxN+JDIHYwAF6pIEi9T+YCaYO7Q3cdYbyc+vRejBmei6pNXaoZMKsBNodU535tPJND6bLEqoTGqRX7LAisBgk8XxPdgJp+BfTKfwmf461bw7INyUgKCDddCRR7uMceNC53fSfLbLaYp30z5+zQitNB+gg53kcrtwxAMskbGd3jDEHGtlR+QBbk+1uEkVfP9+92jUfN88yBt5mmQ/xAZRhIr7JHHjvkfFf3oRe9ADhOVle8hrSh/H86NGVUws86NuRGGcPb6UMO1SaeCh05DKF2wrDl+MHnSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrxC2z/jVgqCQ5YNLqWkIcYbm1GVczIG6ApjdxrSqt4=;
 b=LLEDXKoxJgDqEtgs8NLQ1F7e+ZLrVQQtLwWY88z1F0Jji1qnnJqD0si1JUq2jtb9qxZcU6roOEqcYzyI2bDFcPtgZEf0Akea9qJw5SLJWVIAvzqPShvDZZzuW4oTRoZcFnMfjztZ2rPJK/YKghzc7cpITyy4VMBuOYJSMWR06dUjXe38wKyNuvjRb6kAcjpBbUCKTlWFxcJDkrwrSpvVwEE3/0xmJ/awK9qJ+WVHt1EIKORNXhpenVAaWcBkzemq7ANhkt1bZLXMfCT5f3H8Ihh9b3IvVRVIPKU9mOAKD3ude8pfaS2X7xjS7q3m6TiNGdhCuImA7G2Qy3rGDzJqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrxC2z/jVgqCQ5YNLqWkIcYbm1GVczIG6ApjdxrSqt4=;
 b=HMhRW+faDovqZf2sSjA2vBgO3bQmD0+yKzmuZPHp7dYRihsX2IqEIEVN9L8Lo6vxMW2DFYUVo1bm8ok/ASf9EBFzhVXDSyGCAnEr8gysx5urTIVtPNkSklDdTOFsfhrYJ/AVe9wJGb9xb6tXHHZNDqBF8VeNxux5bBO4qrswXfz126CRSDwdstbhzLI3qUqRQHQENpPRAe1nM9vI51ZZtdAk8vSLLNHDIRpMumHw/3q0FZTkpdnQvtYf1+NE2gI5MCThxISnF9khZj0GokoHSKIFiWjnmYxQZqMktBDu7rRD2Q9qbvgHsl0GLU4SR34ziXFuYn+WabFWTPBAT+X+Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 16:58:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 16:58:02 +0000
Message-ID: <e6ad5652-5d03-4010-9117-0b7a50fb3d40@siemens.com>
Date: Wed, 30 Jul 2025 18:58:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lib/cobalt: arm64: Fix syscall macro argument casting
To: xenomai@lists.linux.dev
References: <20250724120012.1656476-1-aspirestro@163.com>
 <20250724120012.1656476-2-aspirestro@163.com>
 <137f95aabaf6a5916d4abcfa8b4f384234427cea.camel@siemens.com>
 <d277uoith4zyzlgldu2226s5yrejlnp3ndfgznayuj2mbg5kh4@lhosq2w642od>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d277uoith4zyzlgldu2226s5yrejlnp3ndfgznayuj2mbg5kh4@lhosq2w642od>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 7058bfa0-9cd4-434b-1abe-08ddcf8a3e96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmJ2MHdqUHArZDFEM1hWTnJpbmRYcThRaFhGWWcvOWtDdzJBR3FBUnV6UUN4?=
 =?utf-8?B?c3AwRWNOVE52YVRtNk1VTGRjMHlvNGpwQncvT1VDS2F6c1liTUlOYzI1N3g1?=
 =?utf-8?B?RURYcmFidXZ2bkh5NFA5aDUwSVZmT1BGazJROUs4TW5ldFRNRmlqNFc5YXVQ?=
 =?utf-8?B?UFhEczdad0Z0eHVDeFJlUzU5UithWHRHYzNaTTFodWJBdGRCT3J4TzUrdWM2?=
 =?utf-8?B?UFA5SXhCLzJuOGtIZFArRHNWZjNTUmR3OGhjSGEvWHJrcTRFQS9kakh6Vkov?=
 =?utf-8?B?bVp5SlEzMGd2ejFDUEpLZW1hamJpZ0lyWU5UbTBLNjNFbk1FVVJpZzRrd3VC?=
 =?utf-8?B?S0VBWENrekhUdkZYVWQ4MWR6LzZkVFRrZjFhdzJ5OGJLZnZ5cEo2Y25KUEJE?=
 =?utf-8?B?bG9DSHZTMDdGcjduMTB2NHV5WjNkZERiWkg5T0IwcldlYWhnaHZRNndRUmNi?=
 =?utf-8?B?UWRLSk1lTDF6OU9XL2RMUmo3YU5Ibjk2V0F3UGFmbEZMTWF1UGRVYTZnUFpZ?=
 =?utf-8?B?V243QUZDbE1CWWlaSmd0Zk9Vc1pBcStoN1Avd3FBR084NHRLZFNTSE5UWStQ?=
 =?utf-8?B?K3dMMWVVRXV0bW5DU0pSUUtJU1JzNnR2ZGRES3B3Wi91ckxoZXNzMWtybG82?=
 =?utf-8?B?YTZBb3pqVFltQjJjZFIwWE9YaXplT0xDbkoyS2RKbEI0MWhYNGYxRXBhalQ5?=
 =?utf-8?B?ZTEvUzI4aVMxNEo1SE42OGRHRDZIUmZZUjRwd0x2QVEwbXk3ZW5sQ2UzU2Fo?=
 =?utf-8?B?c0dBdWpsRUtPeG1TS3F6OEg2M2lkMHBMTmxKUHhqS3pRVkVmN0tMQ3gzZ0VU?=
 =?utf-8?B?UndvTHFxOUFyOVk4TXZwZ1QzV254ZXlsQ0lWM2tjcmpLVFl6VnY2alVnTlVW?=
 =?utf-8?B?cUJwRnVURVRwTGV1aGE1L1RLdUxJeEc2eFdmU3BEbXVNTUV1MCtVV1RlMWRx?=
 =?utf-8?B?NWdGLzBpQWxpTGZxU0Vpd3pSS2hEZDMvQ2tNUllNVXZZVlp0c2Q3Q0VKSC9u?=
 =?utf-8?B?WDNGcjY4K1R5TlpNMjAxeEhSaWozM0VIRXo4dWpVSHVaTTdkWkJSU1Jxd0V6?=
 =?utf-8?B?NHBYSzJLaW5ZL0hubHU3ZXJvNU9vVGx5QjEyamY4UzRWYnZOOWVwN2R6Q0l6?=
 =?utf-8?B?d2tCaUdNZFNQK1huVTlOSlBoZ1hKakpJMG91aUEzUEtJWXpHdURFNWZnMzVj?=
 =?utf-8?B?OFoweXBsakMzejVqQmlPcXpENkdmTWRHSXdnbGIyQm52VTg5QjRwZElvemIz?=
 =?utf-8?B?UGR2TmhHaUx3ZVFEMnRPa09yWlphY1ZWVHY4L2xZTFFjQ0drWlozL3V5NVRj?=
 =?utf-8?B?Z0pnNkR0NFB5bHU0NGwxK1FmK1RSUExBaDdZNkZxdjZYZE1QT0wzU2NPUWZ5?=
 =?utf-8?B?Y3JKa2Z5WEtuaWpJZTIvZGtDdW5ybTRQRkxSK0VvYm0weXNCNHhUcTdacTVY?=
 =?utf-8?B?ZnNKanl5d29ZVVUySWpGR1NrTWlRUzVzZ1kyRHVuNDl1QWt0SVhWTkFDN0wv?=
 =?utf-8?B?OFQ2UjZ0RnpUNWQ3YzkwdVVGa3p0KzNidit5cERPVUNudWNOYkpKL200T0FF?=
 =?utf-8?B?eWtISGVvdGdxdWpidGZtSmd0K3N2Q2Y0K1BZTXJIL2s4Zmo5ZWVrbnE5VFg4?=
 =?utf-8?B?QmdBRHJudU5xeW9YU2R5M0xTakRRclluOHZqWk5DWDcwVGMzcEhVSkdmSStR?=
 =?utf-8?B?UkZmVGk0SmN0SE5OWEFWdjBQSDluRnFSaC9USlpFMVIxQkFSUStybmlZd0hH?=
 =?utf-8?B?cTVldnhLY042K2VRM1pmWGxReFBLeFVxSzdhQzZ0ZWpmOVFTUUVHVEpIUkZz?=
 =?utf-8?B?YXRIRXRoQTNjUkhSOTB4bWpJR1VRd0tNa2lHc2VnRit2MlpYRjhZdFMwTTYw?=
 =?utf-8?B?QkEwRUxZcjRQL2dIaE9yWE1DRGRlcFNZdUNSN1lERTRLOEVnalA1eGllajhQ?=
 =?utf-8?Q?IZKg4JWKhOo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0pONkczVFRVck5wSzN4c1B4WDJSeVJVOHYrcDYxUEdCNlVzMURBaXVPYURK?=
 =?utf-8?B?dGpLc3hVanpzc2o3dEFsR0h1ek9WWm1Gb1ZyczduSzc3REtnT0VVb2tHOXhP?=
 =?utf-8?B?UEVnZ2hDcDQrUFJSdlFjWHJYblFIeWQ5d3lJTjUrNWNpWFNZME85WXJvTEFj?=
 =?utf-8?B?Tk13VWVkOGl4d0hmbDAxZGt4VGNIb2JlOTZ3c3FZOGdhZUNoSmF4cWdUOGNx?=
 =?utf-8?B?VDJIOUo5SHd4d2xJbml3UzBCczFlQzRMZ0piSGl1N1hLSE1HOXUzRzVZcUdQ?=
 =?utf-8?B?RHRBem1mUkVXS3lqU3p2WUZ2NWtPaEUwbzNqN2NlRGFEV3F1SUVQMGhTTzV2?=
 =?utf-8?B?ZDV6UGU4VEJYZ25yYXBZa2F0cm1aNUFmSTNYUmxxdlRPTmt4elFDSGtMZVZh?=
 =?utf-8?B?TUJZNzFhZTFwbEdGc0RRZFFBcVk0bFNKTnNLZHd2TGlYUE9xZkQ5WjNLQlRz?=
 =?utf-8?B?ZE0xZjF3dDJtS0NtNkgyRDBVTC8rMkJYVjFsWjhxVTJkMTNhWnBaYS9MQ2VH?=
 =?utf-8?B?WitIS3FmRExpMmRyanY0NFMyT0ZCV0I3OVF4dXkvVjgzQnhWM0JveXV3RGtH?=
 =?utf-8?B?Z1pNZGVRL3d1RE5PN2o5aysxZUMwZ0ovOC9QTk1Kc3EzR1lBNjFNK0F1UFN4?=
 =?utf-8?B?Y20zSXZkZzdWRVFiUHEvdjlmR2M0ZmZVRTdWREx2Wmo4SVl2b1Vhd2x2bThh?=
 =?utf-8?B?eDdKRzUzYi9YZDZtZlNRMmw4WGxwcVhMVG1xQThiWnk1c1Zjenl4RmVMYjVo?=
 =?utf-8?B?OGhpNW1XSzRoUHloMzNwOFc0QTVUc3VGMGQva25vQXB1WWZPOURYU29wV3BQ?=
 =?utf-8?B?STRSbWhpV1I2V2k0RGhBYWlPeDFkK3BUc2Y1UE5FTXN1NDRHTWo1QXRnTGNj?=
 =?utf-8?B?alBpWHpVblE2ak1TRG5wL1F6QURUK2ZwUm9tVXVmN3EvL0pMUWpPczFjVm9t?=
 =?utf-8?B?QzVuZ3UvdzJYUmp6OEsvY0tkek1zd0NVTjRtLzhqVEVKbGtNM2tHZ2dyRjBV?=
 =?utf-8?B?eW9ITDk2MjMzQzFMcWxhOFFNWGdQTmxKUHNkOU1UM1o5cDFmOVJuek9UeUc4?=
 =?utf-8?B?S08yZUd2UzZPcHhxaHg0TkFSdzNWTmtiWGVqSlptZ2UySU81RFZQTEhYUGRq?=
 =?utf-8?B?QjQzbEhBbjhlbXI1ZlRQMUR0citNWGhpdnNhb3czclVkczk0aEQ5VEprVzY3?=
 =?utf-8?B?QmZUakw0QWRNMDQ2S29sWERnOUpNNzQ4VWZ1V2RhNjRpY3NSSGlMMFpYdUJ2?=
 =?utf-8?B?R3JvWFljYzlObDRkM21wcTl0R1B0K1FUUWNZdTVwZEoxRGovOEcvRS9mVVFu?=
 =?utf-8?B?WHlVNk1UN0JzOHNnZlBndG8rNDRtK3NoU0NiYmJZVjAwZFEvNUo1emtpeUQ1?=
 =?utf-8?B?NEJxdHVvZTMvQUp2Tk9UWGdpTXpoS1hqOHFYb2w2ckJzakVwSENFYnhYRzh5?=
 =?utf-8?B?RnRLL2hJL2V4ZEZWU2g1dUpWVWgrY0xSVnRXWW5LcVNYc0RnU3dyb2I1K1dk?=
 =?utf-8?B?L2EwWjdBckgwUVlUL0NUV3IwN2VxZnRRbExlUUNwNDViOXJ4REtvNEZVKzN2?=
 =?utf-8?B?SDJjUkNxZENIenU0WTZqK0oxZ1Z6aVZkMG9kZWtRWU9CdUNuM3dibHNQTmwr?=
 =?utf-8?B?WHYzUGtTS2xROWx1enhKVVlTRGxHb1lwZUJaQ25Za0k4ZDZISDVDbnh3VXBQ?=
 =?utf-8?B?b0FHclZLLzY2RmM2eHFoMnQva1BIUUJGMXV0VncxaWd6cVNwZ251eVpkRUI3?=
 =?utf-8?B?K2xocDlaUXpHWjFXQllBK25WaHlpMHRUKzlpZUVVMTFPb01TYkErblcvRU5q?=
 =?utf-8?B?Z1VaR3FjMUJuYkZJTm5sOWdPREszRE8vL0Z4V05udVBReWZFbmNrN2lnWElj?=
 =?utf-8?B?bEZyQTFyTHl2ZGxPRDQrMDM1YS91dzVNdlp3ZHhndEIyL0xjL0NwMVowa3ln?=
 =?utf-8?B?eGlZZW9ybFVDWDErS0Z1TGN4NjZHQStsZFdqaXdMUk9YanI4TFh1cTdDRzVM?=
 =?utf-8?B?ZFpBTmpIQ3JNcmJtdW5ZSUhrcXJIcUViSjJzekNaSk9zMFduOXhBU2t0Nm95?=
 =?utf-8?B?ZlNkWVN6RWM4eldHZ3BVZDZ6bzR2N3ZjRGlnQVI4Snp3R0cwT3pwSTNzdGI5?=
 =?utf-8?Q?+D6FZcYiYwGMnSs1RRRxTzxsR?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7058bfa0-9cd4-434b-1abe-08ddcf8a3e96
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 16:58:02.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zEI+u/MkofNrTWbjWNr5Y9SiYtsyHYyy+oqB78aK5IN37O/KJjRh4C61xLk3nmboYq4gq/a+nayRPvjWHmI1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6871

On 25.07.25 14:26, Haiyang He wrote:
> On Thu, Jul 24, 2025 at 09:09:39PM +0200, Florian Bezdeka wrote:
>> On Thu, 2025-07-24 at 20:00 +0800, Haiyang He wrote:
>>> The Xenomai syscall macros in the arm64 header file cast their
>>> arguments like (unsigned long)__a1. This can cause issues when
>>> macro arguments are complex expressions, due to missing parentheses.
>>>
>>> Update all syscall macro definitions to use (unsigned long)(__a1)
>>> style, ensuring proper evaluation order and preventing potential
>>> macro expansion bugs.
>>
>> Good catch. If we apply that, we do not need patch 1, right?
> 
> Yes. 
> 
> And I still prefer both of them. Maybe more cpu arch would be introduced into
> Xenomai. The way in patch1 has better compatibility.
> 

I also prefer to make all syscall macro agnostic the parameters that
come without braces. I checked arm and x86, and it seems that only arm64
had a problem here. So, I've only merged patch 2 now, enriching it with
some impact description derived from patch 1.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
