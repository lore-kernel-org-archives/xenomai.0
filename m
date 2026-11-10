Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333672;
	b=c04k9DB68KmX6Hbj+gLzRAUYiRxyA2gRYUSLEBYG/TYRHXK1e5AOGeQVz0byzIaudpah
	 iXbfzq5XJ64pdNu+8JoufWn0p03qeqBdoNkusSKN84VvOcci7/CiT+smTjOFHu5ph5dXq
	 5LGkTTVPZg8Bu6MzUAifJnjXtE5UwKQLwadSUYfo1hup03bmHDHln1055Gx6T5KPTMTtf
	 mO/30LwyLgAi4nz+38s+97OJc/D34fqZat9+4043q9Elk5+zf/RliGaOeAG1ofQNBp0JI
	 psxsC3aRyW4Ep418QG3EekJlGrtVlUTLnjfjnj+bfclbrGdD7swFI+8v2xJs97mqbXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333672;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
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
	bh=C8FhImQ+UQ7vuU7uOjmRWOR5OkD6tRKJpQRGTyT+zMA=;
	b=0VWwHzMpEnrCi19ibpvqsHtB2PFKzokVyejZ2tA5EFdepxDdQaH20AhR0haa+2JLglXS
	 R13PR5ZBg+13vNQWwhRw6Gu3SdOgu4Ip/wgElQPv0Rt0h80RdUEANDVes3HFZAdHVhRJx
	 pmwuPlNN54iq87a66yKxLdNcGVNCZsQ5dV1T+RclUvxQ4x7KSZ2Vqd0gXqeq53tSmWhRw
	 5YrDQU1cj6EL3OOgg5L1ENHFTWu/un/sMw9Wdy56MdIlEYC7aeMori4gfw1YBtUnIaFNJ
	 vsVyIbP4Zz/b3cgRZe7MPanib6nLH7bFt4eswzapXhIelmQLurTZnl41ZUb3vYnXWjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=s9wW3cSy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.15
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A3606A325
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 18:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 160A3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=s9wW3cSy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olgf9mjJl2O9WYEiJVAJxv9BcMfyIdwty+gDTrEelmT9BdB7urSPApY02La/N8kBcQA9hHNjCL9imvoSELhR27cb7vNQ/X3AHS0lYPbDMnbKINWt+38ToHODi6D+2oV/7HEi7iHlufmkwKfnwMkTpB3V0oOKrOdvd+QxatbA9Hg28jK8T43+dpr1aTKtffCnbXjEP4pEWlBp+h0TZL2wIXy8JA0FsCDERbUmdm60Qc7BWftkfJ2yNEoRiTgMPE9FCjhLtBDExTlT/C9pu560BvCw3bXIzoWqDYzdJTYcHzouxfuYPb6KMGERnyUwYK2+I1bGgu8a5k8f0mtNP7j6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8FhImQ+UQ7vuU7uOjmRWOR5OkD6tRKJpQRGTyT+zMA=;
 b=Yn+59D7QflBd6Gvo/0G/AeiG09OOGNTgdXAfv4oRI+EsL+UuH2dasYMlbBFVMIY65pONFysDYh/qG0HY3e0xUjWDfxIX8XCXg6zhy5DG+gHAczTRkul6/75mXBoQEaYzULuSE/z0NPfzkvc9dUqBHguC1BTYJIOOwnEJbEemWYGRndM2NJ1zUPYonb+xHpSfhgP2CocWqzBEY3s1SoHXm75IOUMWpB/bo2YM/CP4lNp9SYDbOesymcxXG9TlVSay9ZsSMvcLm4EXfsn5hW4fs2tQz4s2NgcP1DYqR6o4L8ZTnJtTpxFmI0gHgzn+2EGkpdaxLYPSI6DNW9V8rBVwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8FhImQ+UQ7vuU7uOjmRWOR5OkD6tRKJpQRGTyT+zMA=;
 b=s9wW3cSy+C9f+l1sO3a3tpceyP3OAvXlhP9sdr1tx8KiPZ1aEJF+SAIIj+jw9Zjcw//3pluNrglOdgkvjlBB0jBsTvlHOlHD1M8vL9t3ZVY3iOSgOOkuYTMSuHqM9f6uvu8owN5ixXLCLGXRlG997It44qIjhGCEQbcznnSJgndjJL9YyeOIElHPl6v74HtlAXzdedna1LtHFKvi0jJXoTA3DLIbxU03ZbR9Oy8LU42RqOWPH0stxF0B98/3kOP23nLYjvvQkHcsFBDHqEHqwH39ycAer5sQ7zezSH8DcXxjGgLx1JeAn2wVehSPm7KZU7tgj4V0DzHEGA6raqhJ6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA2PR10MB8679.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:41b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Tue, 10 Nov
 2026 18:01:06 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 18:01:06 +0000
Message-ID: <614c806a-79ad-47d6-a5b8-ebfa0ebcffb3@siemens.com>
Date: Tue, 10 Nov 2026 19:01:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH] arm64: dovetail: Notify the core about compat
 alignment fixups
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <4d7b7926-4a09-40c0-b4e8-d5512f8107ef@siemens.com>
 <87wlqk6332.fsf@xenomai.org>
 <2d9eac38-825e-4038-8b9d-9b15dc1c1b4e@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2d9eac38-825e-4038-8b9d-9b15dc1c1b4e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:50f::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA2PR10MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b10b0c-97f6-4d25-2295-08df3f5497b9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|55112099003|22082099003|3023799007|56012099006|261022105027099003|261021123027099003|4143699003|261102123227099003|261022115727099003|261022075727099003|261021121427099003|261028144727099003|261009223027099003|10067099003|261026121527099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	KJ/fjDcyfvqpBu6U9rke5aEQuHgmzywdVrY+Onm+sBYvzIVsopVpUPL7WLNlbtaMttkYTbtpOtBYhoxefKiKwl5ZSbGjxguuf2gM+EwZrtZKqOxqFE5t7W2L9NNctx8g1WnoalAnlOekrwWVrA0Ki5WVFnHpxEtvMc+3KEyI6FKkSBJg8BJNcWNOx1dkY0o+gaO/dZ4Xe4HX72apQfWw5CbrezYX1cMAOGze2gh5NA4pl1+mS2Xna+pRrNt72qKzZB53Q655ZNWI56LZqe9yqFT8Hy6lbaLvkPol4r2M/ZTRfBpjbp0WZs3FCIHOkhrX/Cr1FB4YpHEO2gAK0gC39ICqJgAWSnHKeYY2KTm73GR8RZ/nY2ZA4y24Z0gX8Aj9zyVJ4i2eonsCmpeXBrPd46RVwnMI+iuo/WVSIk3gRc/MOJkcWSObtEo3np74xd7IKSFrRKxlIaXtWWbVLSA1GL2mZ/DWphP/C2tAJrl6IvWubK8U6qKicLmiq22vp0o5szX2J3AucxXeleIYXMVw8AVYxQn52sANuBj5ZiLktxSgGxrPm4Q0wLYQtWk3D2buetvCVtQ56P+JRKqWCD8XhQBWjyLnlYDBQotGolKC90ANlZGULt54jdMnYv2To7e7vr8X+qaxI4zVcxiQx5/jwak3MnnHR9t50VXjWNzRF68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(55112099003)(22082099003)(3023799007)(56012099006)(261022105027099003)(261021123027099003)(4143699003)(261102123227099003)(261022115727099003)(261022075727099003)(261021121427099003)(261028144727099003)(261009223027099003)(10067099003)(261026121527099003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTlvazVHZGNyU0tQNkJJaFQ0QkhpVWRqS3RIaVdldXF5aGN5bDUwZXV4b3NM?=
 =?utf-8?B?WkozNVZDeHp2eTZwVHlYb2k4cHJwSjhqVVI2bWM0aDFmYkovaHZPelluRTV1?=
 =?utf-8?B?SDNQdGlHWXhLcmR5V0g4VGEvaVFseStSTytlRnJ1TzhPdUx4YnZiMHk1eW5t?=
 =?utf-8?B?MEprSCswUndMS1FJKzh4WTVhQS9STFhzUUh0aFNaekdWdmxIa0lHbGZhb2N4?=
 =?utf-8?B?SzVDVzdOQU1QQ3JIMFpHei9WelUvUFpPaDRRVE5GMjNXOTM3ZXlmcTJWa0hP?=
 =?utf-8?B?cDBOMzl0YlZHUGlRVk5LY2ZycHdhRVUza0tkeXBjemtQejBoQ01GOG9yL1h2?=
 =?utf-8?B?RTBUWmJPc24vUUxkRWJ0MlE1VS84VmxWcFczWGJ2Zlh0NWxZNVZxQWw4TUdv?=
 =?utf-8?B?dXA4N2xWMUFOb21LL3kyQUs5a1grdktybnNESjZhOFk5OGJaelV6dTMyOEFV?=
 =?utf-8?B?NjdDa3FiQUdqdWZVb2U4ZWs1RFBabWQxY0pjdUxSMkdTeEYwamdrQzl6eXpa?=
 =?utf-8?B?OEI3enBneWY5RHRyUFR0bnY2R2U4VlBibm9KdGlkOTQ1NUxSaHptT2JHeEw1?=
 =?utf-8?B?ejVTYWsyZDYzVmhtMXNRRnBaTmxCZENlRkQwc0RkRGdrall0Vlk1dzlWS3pl?=
 =?utf-8?B?MUNvZ0xDOXFLZjZ4T1hFMWFZYVluZnFaUnlEcHdrRVVIUGFVR1hxVTNSYzhz?=
 =?utf-8?B?QkxicGUrQlNSNXdRS0ZZL2JwR0NCMnFhaGFZc0tPWlozSFQ1L1M3czBqUkY3?=
 =?utf-8?B?TTZkY2tHdU94REpFczZKdzlwaWRob0xwV0dWTkRZL2YxOEtGOFUzdGVKVGM4?=
 =?utf-8?B?bHdtQjhabGpWbE5ib3hvbGlxRXBleS82N0hJUE1QRlBUd2N4WGl3SmNkbDVp?=
 =?utf-8?B?MzV5YjZDKytVRUw4NU1IdWtnZXlFRGJBdzhTRlRFUlgrakV3Z0pvaHo3Wk90?=
 =?utf-8?B?QWpVR1ZHRXJvZ1k5NnN1SG9DaitBalBVSVBRcnB6cGc3TVZIN0tuS1BPRmRH?=
 =?utf-8?B?ZEp3ZldjQ3JlZStta1RkTysySkg3NjNpSzJDa0QvM3d3TDRmd3ppSkRFbjBZ?=
 =?utf-8?B?WXI1cWtHRys2R0JRNFNMTTBIR1NPTVArMlV5S0VsY2N5L1kzVmVHUlBSZ1RW?=
 =?utf-8?B?WndyYWpieHdJRjRHQ0lEbWxtcE1yTHgwUU9KOGp3RHErZGE3aS9vT2lzdjV3?=
 =?utf-8?B?ZytWdUdkaHJJakZpK0hxS0F4eUlQTDdPd1VhOGxZS0VYbXVDdXJYcXd0Y3U3?=
 =?utf-8?B?ZkREYU0xSitWYWpCNXNLWUlRcWJ1VHZXaDVkTW9xWHM2UW42bjlwWHZEYW5I?=
 =?utf-8?B?bExibTA3NDlYQmdzLzA1WWRnOStHNDlaWlJoSkVYY1I0R2VVQmtqQngvaDl0?=
 =?utf-8?B?VUhkTkN2SEVaNkR3VGdXY0owSlJ5RlhVNkFXL2tlalBoMzMwSlZzckR0RzM3?=
 =?utf-8?B?ZG9qZ2p5NlZzTm9KUGhNNGdueXBpeU10Y3JKUVppMFh6emlNTjdTTDkycU0z?=
 =?utf-8?B?YjNjdXhmT1lzNVZJSmtHVDUwOVVHZTdTWkgxQmgyNm5GNy9WVTFmRHBPS29h?=
 =?utf-8?B?T3ZOczZxbVhjK242VFQ2anZKcTl5M1oxRzZuTTFid3NHRFUwbThmbVpKSU9l?=
 =?utf-8?B?d0xlR0NHZXhsYzZORlVmOHNuTVJpTFdJR2YxUjJwSmFpWnI3SG13ZXFYMDJD?=
 =?utf-8?B?NEs0c3NtK1ZMME05cDRoSVZtN2RWR0RKazhhQzNpUUJkY3dnaTk1MnFVUzdi?=
 =?utf-8?B?UldITXduQ0FXejZrVmV4V0NESEJ4TE5PbzIvQkttc2w1ZU4vRUVIMUttb0JG?=
 =?utf-8?B?MFpZbjk3VEh0Q1NEMHNPWThqbjYzSXVvRWhPaTRwaE96VkN0bUYrVHBvcFl0?=
 =?utf-8?B?NkVjbFJOLzU2ZWJXcnZsSTNUVit1b2psR1NWNkhwYmR6WkRYaGhyL1RUcHJn?=
 =?utf-8?B?YTBmU0RqSmFDZ3lDRXc4eWJIdHZNanZRRStZV2xscSs5Sk9vTUMyU1lQMElT?=
 =?utf-8?B?R3FNNTNtT0U5eHUzSDgvYmhUdnhKMHFyVlhEekU4M1ZsRXltMms2RnNLd2M2?=
 =?utf-8?B?cFkvM2lsNHM4VjBYdnRBSDFKMzM2SnBxNzF3b29XV2FhTXlhckl4U2wyV3Az?=
 =?utf-8?B?aDJtVmh5dWg1VjZ5djVua1FJT3ZSUG5PcVNGMnpsNEVRZDNIbHRpMWVURGlh?=
 =?utf-8?B?RExsVzRTMlpRQit4TFBjQytHTHdQaExzVVZ5WkQrbFJTZ3djUWFubGRMNGxG?=
 =?utf-8?B?Q1kxejJRYm1PUk4ycEwzaHFYYmRNZmxSL1pMc1dpZjJaYUF5Q3NQdExyVEx5?=
 =?utf-8?B?T1lCV1N5SVZCc2pvL1BmVXIweDkvSHZZclRrT0Z5NnZaMlF6SG10dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b10b0c-97f6-4d25-2295-08df3f5497b9
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:01:06.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUc85xKR+tLawKv5ycGLCclG7iPFPTcQezaf7GKKqQh58UXKTZr56Nywl0QR7eNqMhXrZpPxOa7JoSzgIDIP3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8679

On 10.11.26 18:47, Jan Kiszka wrote:
> On 10.11.26 17:52, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> With CONFIG_COMPAT_ALIGNMENT_FIXUPS, misaligned multi-word loads and
>>> stores of 32-bit tasks are emulated by do_compat_alignment_fixup(),
>>> called from do_alignment_fault() via do_mem_abort(). The companion
>>> core is only told about the trap when the fixup fails and
>>> do_mem_abort() falls back to signal injection. If the fixup succeeds,
>>> an oob thread runs the whole emulation from the oob stage: it fetches
>>> the faulting instruction, emulates it by accessing user memory, which
>>> may fault in pages, and accounts a perf event, none of which is
>>> oob-safe. On arm, the equivalent path in do_alignment() is annotated.
>>>
>>> Notify the core before attempting the fixup, reporting the trap as
>>> ARM64_TRAP_ACCESS like do_bad_area() does for the same fault when the
>>> fixups are disabled. If the fixup fails, the notification is unwound
>>> before do_mem_abort() goes on, so its own annotation pairs as usual.
>>>
>>> Assisted-by: opencode:Opus-5.5
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> This was a found by pure code analysis as most setups have
>>> CONFIG_COMPAT_ALIGNMENT_FIXUPS off. It was not tested yet, working on a 
>>> setup.
>>>
>>>  arch/arm64/mm/fault.c | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>> index 2726eb3fa2d46..c3532ff0440ad 100644
>>> --- a/arch/arm64/mm/fault.c
>>> +++ b/arch/arm64/mm/fault.c
>>> @@ -867,9 +867,15 @@ static int __kprobes do_translation_fault(unsigned long far,
>>>  static int do_alignment_fault(unsigned long far, unsigned long esr,
>>>  			      struct pt_regs *regs)
>>>  {
>>> +	int ret;
>>> +
>>>  	if (IS_ENABLED(CONFIG_COMPAT_ALIGNMENT_FIXUPS) &&
>>> -	    compat_user_mode(regs))
>>> -		return do_compat_alignment_fixup(far, regs);
>>> +	    compat_user_mode(regs)) {
>>> +		mark_trap_entry(ARM64_TRAP_ACCESS, regs);
>>> +		ret = do_compat_alignment_fixup(far, regs);
>>> +		mark_trap_exit(ARM64_TRAP_ACCESS, regs);
>>> +		return ret;
>>> +	}
>>>  	do_bad_area(far, esr, regs);
>>>  	return 0;
>>>  }
>>
>> If oob, we can expect MMF_DOVETAIL to be set for the current address
>> space, so .text pages of the caller should have been committed. In the
>> (unexpected) event some are not, get_user() and friends would still
>> recursively bump us to do_page_fault()/do_translation_fault() on a
>> subsequent synchronous exception path, which would mark the trap entry
>> eventually, causing the core to downgrade the task before damage is
>> done. This should work now that pipelined faults can pile up
>> safely. Anyway, I'll wait for some testing, things might be more
>> complicated.
>>
> 
> Working on it. Key questions remain, though, why we have to (or not?) do
> this differently on ARM and if things like the perf handling are
> acttualy OOB-safe today. The LLM is rather brief here, I could also
> challenge it while finishing the test case.
> 

And it's still an LLM: After poking a bit, it admits that there is no
major OOB problem, and the main reason for the patch is to align
reporting with what we do on 32-bit ARM. It still claims, though, that a
"sampling event (perf record -e alignment-faults, BPF program on it)" is
not OOB-safe:

"So the concrete failure needs a sampling alignment-faults event. With
CONFIG_DEBUG_IRQ_PIPELINE, check_inband_stage() then prints "IRQ
pipeline: some code running in oob context '…' called an in-band only
routine" with a stack dump. It also sets irq_pipeline_oopsing, which
turns off every later pipeline debug check. Without the debug option,
the irqsave guard's restore calls __inband_irq_enable() from oob, which
flips the stall bit and runs sync_current_irq_stage() on the oob stage.
That's an API violation, but I found no real damage beyond it. The BPF
case is worse: an oob thread can spin on a lock held by in-band code on
another CPU, with no bound on how long."

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
