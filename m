Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29224167F
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976241; cv=fail; b=qySHqV3Oo9ZZ7fmN6lhON4zEPFknO7eqCka1zr2j+wCTF3UZ1gzDLdm2RUfAgNJDwKHf+lsE+N1WHGMejnuEmTQpRqnZLJmTSiy2z5u6F5GlxQ+kTA0CWkqcivYhvzm5IuwJt340jj7RHBfLFU6XrDi4Bskic/Iy+o5k0yKfpDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976241; c=relaxed/simple;
	bh=cUi+/41MKAvlm8+jUYVrKG/tAr5bEZtSNN0NadndlkQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LY7eTmO7rSKIDQzFnksUdgUAHypZ69e06G8j480BH6rQzeJ/ybqtvFKn3vKHpBKPEbPzoExx5RkEHjD2y6TMV5okOaOqlrQ0wnUg/3Lonq4taU6T/BAEe6aOYZUAxBfJ/jsB94C+he0Hz3c/3q0hTuxOuEv558PLbxO8lmuwqSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xDT7/8Ol; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xDT7/8Ol"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STxUOt6SLCSgNonfXLGOaBSQ0SitHsXkdr5I6OCG1ZWn4zwQDcV8Y5XiUErSCJfX5gi8qTpMxxtR1Q/p5Bu3EqkOpb+1EYALJKwKnh9GjwZzI9zyeKL2N/lg49S2pTzyK8WA3SNhaNFizTlCj2Ojw7I7XuSIk7VMPU1tdf+7nxRcyKorXZdoO7SegYbP+++40/ZfKqGRvAzC8ri34CwvzdDFoJWyPGL2Ot+pTV2k6OxtifpmEHw9do60Pn5J05PbVkMc2NXf5yvkbRdddk6DH+r3LxowscONXqXWk2P6q2ZW0YHLLZKCJBQ4V8g4Q3rNqE4+G0hlkSU4NvfJeeDs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9zGcC33SaWMPlHB46kD+RBzj1ltbgAmbnUi+ukd+gY=;
 b=dY9U+WgD0XDNmF60Hlkv491C8lLU9UWILP9k1hvnNFNoR9kY5Wdrimt5MPlVGe3rRZRFmvxPbp83X9032pq62ZMqAFw1zVKkAe8ehl5hkZJwc+BXYiRc0cep5TSrkls1l/TYkkKgm2gbI3r5Eh+WmVfqHnB9DNLkyHpu4XZF1wOxAKavS1F3aNWLj4qYs/IcK/yimg0WsqRwjOMqKWePLNSTK7CZwfHLHqsoRYI76xI0latRDp/0fGN8F9GQF8y9BgsEargj2mo+BSb9+5dxm8gG9oRJyUm7PzJBRZIHZaKRoEA0gNzJZfB7X8a65aeMmv8bRXO/8SVJvZ1U0gsPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9zGcC33SaWMPlHB46kD+RBzj1ltbgAmbnUi+ukd+gY=;
 b=xDT7/8Ol2vMD8e5IG8iW2GDE2rhYgHCGWyMYLwQ5Xrm5K4m3nD8t76cvyDEhqsGMz8XDxBTtRJ26w55y/ylCQUMKPdUMrxgCC95qiuBBe4ANmxdKF2rT22DR2Fb+gGoPO4VhA8ZJSkOyt0j7mvB6/Gfue20Jv6BFJIlf7CDGtXYpLEUPHVkLNonTYBgArjz60DR0GaYLvTqBl0H5x7g1cK/nZuSIO+CSwcILK9Q/FG48c+kMdA89qVcSLIn2rzFLLttga3n38uYq8xc+I1Zz2nIPy9HmoR7gFslhChmgrszf7mvXBAM3hEQpwttlLzXwLk3iBp+6kqz68vOQNfK7RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB4PR10MB7015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 08:57:15 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 08:57:15 +0000
Message-ID: <1fa2c73e-938a-4453-8cea-4557973cf43f@siemens.com>
Date: Thu, 4 Sep 2025 10:57:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] ci: Retry LAVA boot action up to three
 times
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: quirin.gylstorff@siemens.com
References: <20250904084307.1090704-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250904084307.1090704-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB4PR10MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 089d4a57-3c73-4b82-4a31-08ddeb910b59
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVQxKzh6SktwdCtTdmt5dGtId1JjSWI3bUdNSHg2b0hKWXFoNFFPZEZ5V1dj?=
 =?utf-8?B?cVJiUVRLWkZuR1dMN2dhbUgrc2luWGdRQ25rSjVqanNSOEVseXNJMDFQVEpa?=
 =?utf-8?B?L05yK1ArSVFScW90YXdMSnRiZDlEcHdlS1FXakxOR1BJWXpuWHI3YkIrdWNG?=
 =?utf-8?B?NDEwNVkxZCthY0JSTE5uMCtBY1pEbWNhWFhWSTZiZEVURHJvbkdUMFk2Ukx5?=
 =?utf-8?B?VmpTRXNVYzd0d1hQMFM1ZUExejhzSEcrb1JwNW1vbUkrQzdkV1h3SUNjMC94?=
 =?utf-8?B?WjVCY09QZTVkQ0ZweEVNcEN2SHpIUmhMNCtQSDBBd3RVN1kwMEIyaXRXNUsx?=
 =?utf-8?B?cU1lRFBKb0pQRnI4SmY0cktIRWFNaVNWRnJPNnRKYkYzcEdDWDZnZEN5N1hX?=
 =?utf-8?B?b25acE93bWh5aDJyT0ZWVEZiTUpTSG1LMUI3TXNCbFBvS1dnVlBlM3RleEdF?=
 =?utf-8?B?eDNXaE5ldXRxNTNDUzlUaFkwNll4UXQzRFZFWlJQN1lSdnp1UWpKcEFiSkxw?=
 =?utf-8?B?Wm9EVlpLdERLZzNWa1pXaHVQZ2RxcDhTL3hwYktUTjQyQWU1YkE4L25PdTlC?=
 =?utf-8?B?anVLaFA3UUVOb0lvVG9yWWE0SFFXQUpWeGh4VXlnYW4rV0JVQURreFN1NFlC?=
 =?utf-8?B?cW96OVJyYWY2bHl1Zlg2MS84Ym5kOFAzYmJrRjRtYmpDQ0c4cFB3UG1EMmgx?=
 =?utf-8?B?T3E1NmJOYzVXWDRkNFpjcjNmNWRlZlhDai84Qk9WdldMeDhobnJQQlJoanhE?=
 =?utf-8?B?bXZacUowRWlwRlFIVFZiM3NwR250dExXT0NtZkx2cGRLWVUxSis3d3BVYURt?=
 =?utf-8?B?S0xKK3Q2SFNSNDdJZjc2WkxEcnBWZ2lvNmpEaGc0VS9aMm5OR2trOUx6bUlW?=
 =?utf-8?B?NnNtK1pmUU5yOUpTeXR1aXh3OTJXY05MaUVLNHlYNmh0OGM0NVJ5Z3FndXUy?=
 =?utf-8?B?SnN6RXA0MUxXbFNQWW5nc1NsQ1YyUFlZMS9ndmFVblc2aXJraEwvcTVNVUJr?=
 =?utf-8?B?M2lZZ0ZtVUVabSs1QTVRQXZoTytpbi84MEsrYTVLYVhBdFRTSnVHTGw0dC96?=
 =?utf-8?B?cFhZVTU0WUJEc0puZ3NaM2JwUVV5bzZ5U1NuczFVeWpnRzduTnF3N2F1NkhT?=
 =?utf-8?B?V2VRdTlucmtMS1lGYjBRTkJlRy92cHNwQmJEbTljUjNRY0RNWUIrVlNVK3ZC?=
 =?utf-8?B?amVvZ3ZRQmNjWCszTnpiUUVVMmNYQzRtWm9vTjRvaUlEVnBwQkYwTjJ5OWNM?=
 =?utf-8?B?RkExZEp6TzNwRWc2d3NsRTc1R1pxSHlvSlgzK0N1RFNRbVp2ZlJFSkhDOWpy?=
 =?utf-8?B?WnFmanQvNUY5YnlrbXVGZDV1YTlZekpRSUFFRGlKbVdPQlFTZ243MEdab1Na?=
 =?utf-8?B?dFpzZW0xaElsNHNsRzgzd05ubWR6UkZNSnZBRzh4WTJzTzJNUzh3T0k4c3k4?=
 =?utf-8?B?dnJwODVlMWNWZ2hGOVRkWEN5anpaK1duaC95VlNTZzJabjk5LzJHNGx3RUN5?=
 =?utf-8?B?NlBOR3lLVGFuMWcrVk9lM2RsRjQzOWxnSG1icUJnS3Fwb0M3cTIvejFCYUxy?=
 =?utf-8?B?MVJWUlNyc3ZZTXV4MlBsUzg2cytiTjZ4YTVEWkpqWkRQTHR4ZCt4SUxELzVw?=
 =?utf-8?B?R2d0c25MQ0ZJNTd6Z3R5MUNLR3V4Z05aaXBsUGhaVXdHUDZIbVJvZXQ2bTgx?=
 =?utf-8?B?K0tEcU9ucWpwRnEyc1drOGhNQ3RNc1ZHYVdCRXpRdTVlWFVVTHFtWkt4KzdZ?=
 =?utf-8?B?dHNEMktoL2JNZlZqTFAyQTMxYlFvWlkzNk9rSURmdUNQeUJEdzJXK2xaanEr?=
 =?utf-8?B?bWZjY1dXOTdDTk5nd2xXUnRJa09ucjFTRCttMTVtdWowWGxQcStwbHRJQWRn?=
 =?utf-8?B?ZEhDaEhmUDhlMHgwRG8zVW5XbTJoemd5LzlaNjVvOVo2aFFMZHZjOVZYSHRO?=
 =?utf-8?Q?diB+2I4bw4k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTBSVmdYcjZBUlBLb1hCTmp1OWxSZjdOSGNDdy9jOGVyeFVXQUlNdDQrbkgz?=
 =?utf-8?B?RVlnOXF0S2dQODlJV3NzUE1aVGx5NU5wUnpmZnNiUTEyR1ZsSy92cWtkUitu?=
 =?utf-8?B?Mk81VGVFamV0SXkxbDY4elB3ZTd1amg2aVcxeFNjS1daK3BzN25nTHl2bDAy?=
 =?utf-8?B?blk0eG8rbWorcExIUGs2bVQ2TWd3dkhWeThob3dEYjk1MFUrbVpiZ2VSOFQ4?=
 =?utf-8?B?OC8wOXlQbDI2N0RNaUFIejhJTUZyeWJxalIraUFrSnlrM1RybTFuSkRPWVp1?=
 =?utf-8?B?YzRMTG9tb2lYaWVLN0NJR01iRU02TlBnNDlGYXFHMCtqTFJRandtUWlGN21o?=
 =?utf-8?B?bDFOUVNjZ2ZCYWpkQkFvYW5aWTV6Mko3MGZRTmthRldWc2NGTmJ0MEtiYjlH?=
 =?utf-8?B?TGZ2VER6TGorS2J2SDRYTkVkS3Y3TFZhVlpxTjhGaDV3UkovOHFVcGZrMWNP?=
 =?utf-8?B?UVQ1R1BMZVZoN0NldmNxaVJFa0RnWUFCTk8wbk52ZnArQ3NMdzRqR2NFSmwz?=
 =?utf-8?B?WHUyRXkvSmlnUVpHYThpTm1NN0RLQkpZY1BxY3FYekpjTWpUWGczWTlyZ1R6?=
 =?utf-8?B?SDJ1aTVRdityMFZucExxWElPY0ZlMjI5NUcyZW9Ham9nQjB4MmQvRjZhdmhv?=
 =?utf-8?B?K0szQWhGV1NCQk5PWEVDT3hBMDUyRXQwQzMyUGVtY1FPN0k5OGRFSlBXdEJZ?=
 =?utf-8?B?eXd2MzVJbURXR2VTRXVlNEZ0UnlIdzJFYjZWaUpJQmozQXRIL25IdStrS3Bu?=
 =?utf-8?B?ZEhGUE5PT2dudUEyUkw4NnllYUFxemZYQ1ZhdjVoN0s5VnhyY1lNaVJTUnUr?=
 =?utf-8?B?cnJHYlFVVHdNQTJMTjJnUUJKMzNnWDl5eE1Cem5oUTVUSUpyNUY3Y215emFM?=
 =?utf-8?B?ekU0RkpmZy9JWk5uaTFGWHQxRVIxK25MKzBBOFkzdWdkc2toQnp1TU9RQklD?=
 =?utf-8?B?QUR6bHNwV3hTSFBnOWRmVElLV0RXaTZ4Qk1idFVwVVk1VGFtUVJpUXhSTTNl?=
 =?utf-8?B?R1dHUFhwWWMxT05LNm5UaWl1Vk5lWEhpT3JLQXRmQlEzd2hoVjdGOW1Ca0FI?=
 =?utf-8?B?RVhoL0NoK3JNS3I4Tmg2bjVJYkg3S3V3eXQ3VDFSR3lPVTNpY2gwYjhhT1B3?=
 =?utf-8?B?ZnJiVy90ZUY2ZVgzU2xwSEp3Si9lRjdqZWFtdVQ0S293R0tPcEx3RTJXVHhp?=
 =?utf-8?B?WlpLRnc4QnA2N2prczhyT1FhUkU2V2FMekNvQXphelZRdFp5OVVDeVpYejZp?=
 =?utf-8?B?ZEFBSW5NNFMxbjJQS2RPcXMxNGs4Z01JaEEvenVKSXd3b3ZhcTF1cFZyT2FI?=
 =?utf-8?B?bTcwcXp0Rzh2VktHRUJQWkJMOTNralNZaG1INkZ4bTNUbVdWbUV6TXBLOGlh?=
 =?utf-8?B?NGY2WWY1R1kyYnZUVnVBZXMydmhQSDdCeTFpN0pLQzNQdXdGVTlrYjRiVjdx?=
 =?utf-8?B?MDNuVUVZYVF5dzJPSW5KSFBtVnhIaEFBOW1JbDQxTkVvaUVaWStlckFmc2Jr?=
 =?utf-8?B?eTNZbVdiQ3IwbUpiaStyU0lteVAwaGR1RVB6UklaazVlS1ZQZ0tBaVU5YU1W?=
 =?utf-8?B?eUpZdGhzS0tpOUJHMlFjN3Vmc1J5L3BqbU5hZlpqdmc0WlhXK0JoTEFKcjBZ?=
 =?utf-8?B?cXlmS01HUnFZVTYzVkVhck1WOVNidWdrUU40OEF0WW55cFdNckV1MGxncWpv?=
 =?utf-8?B?dE9LbEJQWURFWEp0RGRDcU1hK2FJWng4MldIMjBZREVUM2RYdHhwT3Q4bW1O?=
 =?utf-8?B?T3NvRFNMUzMxNCt6Y1ZMSlQ5dUdmc29sazJZMGNZT3hjcmdiNXl6Z0MyenQz?=
 =?utf-8?B?Z0VmR0lndXk4NGp6OWlDTlp2dVNwTkFjRTAyMWlxRjhDZTF2Z1FHaHVVUnJD?=
 =?utf-8?B?VWg0SHI0Y2FBNWlHZVdCK3hJcFhpVlFmazdYZ01YUlVodndKNHNCbkVocmtl?=
 =?utf-8?B?RE4zYlZSQUM0cHAyTGVpQzBpN0VkNUI1SUw0aFhBMGZvS1U5azMwbGtQcnpH?=
 =?utf-8?B?RFdMVElQRVVzejZrTGdQRzcwVzZQcWVxTDZoSmVqT1JHSWNZOFpFUVFLVSto?=
 =?utf-8?B?aTd2OGthdGorSzgrdmdGU21wVkdYRU1Pd3ZzNEZmeWNaVWlEclovdUVhVUEr?=
 =?utf-8?B?WXNVbnpsM3gySXlqUm5YU2dwSGxVZisyZlpRY2VKMGwvcHlRMDNtL3dtMDRQ?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089d4a57-3c73-4b82-4a31-08ddeb910b59
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:57:15.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+Ps7+7HiufvZ2ftO/AtdQM3wzzbdCRuWsBolFQ6SVBJyutScczaA5UEy/u94TfYvgpGqbD2AE3FwZJC1yoFaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7015

On 04.09.25 10:43, Tobias Schaffner wrote:
> Increase test robustness by retrying the LAVA boot action up to three
> times on failure. Failures are detected via server-side error message
> matching. This logic will be refined in the designated repository.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  tests/jobs/xenomai-beagle-bone-black.yml | 1 +
>  tests/jobs/xenomai-hikey.yml             | 1 +
>  tests/jobs/xenomai-rpi4.yml              | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
> index 8e47dd6..b7a95bc 100644
> --- a/tests/jobs/xenomai-beagle-bone-black.yml
> +++ b/tests/jobs/xenomai-beagle-bone-black.yml
> @@ -41,6 +41,7 @@ actions:
>        compression: gz
>  # BOOT_BLOCK
>  - boot:
> +    failure_retry: 3
>      timeout:
>        minutes: 5
>      method: u-boot
> diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
> index aaf8949..27beb07 100644
> --- a/tests/jobs/xenomai-hikey.yml
> +++ b/tests/jobs/xenomai-hikey.yml
> @@ -40,6 +40,7 @@ actions:
>        compression: gz
>  #  BOOT_BLOCK
>  - boot:
> +    failure_retry: 3
>      timeout:
>        minutes: 5
>      method: u-boot
> diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
> index 50ff9ee..4074825 100644
> --- a/tests/jobs/xenomai-rpi4.yml
> +++ b/tests/jobs/xenomai-rpi4.yml
> @@ -40,6 +40,7 @@ actions:
>        compression: gz
>  #  BOOT_BLOCK
>  - boot:
> +    failure_retry: 3
>      timeout:
>        minutes: 5
>      method: u-boot

Although we are not seeing issues on x86 (at least I don't remember any
right), I think we should apply this consistently also on the x86 target
- ie. on all physical ones.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
