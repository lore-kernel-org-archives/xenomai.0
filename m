Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3E15624D
	for <xenomai@lists.linux.dev>; Wed,  6 Aug 2025 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754453303; cv=fail; b=XRnLzjLDSy1F7pHgjzqzA+gZurXF+4JVQvdD3FSmN88OCHziqz17UW4DAt8MPDl5YB31PY5YqiARdj1qI53pgO9YtSzgDjHNuCsNZ+1IKSl1HMwXvNGLilTh87HpsTW24sZ+QuJGljAGb7ABEHEatZiYLqOfCXa/lyPsqd0slrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754453303; c=relaxed/simple;
	bh=kBghKIHYbgz4U0cFh7qukgMsh5NBzf75k8bpeuepgNM=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uFVKCWYM5qL//py48sm5FDycQEhh/M0kk1xrDvJgU771Nc2Yt8emVNfiSZnspsgNu8OlQAxB6Zu3M41XvnQ4FWuVLxEyVmGk40ni6OtK3+HT4z74VHYr/sQSJmOfPpmHQ7MnLrVEJHt47FdWdEebI+/MHbjHseGNeSzPm/ArK3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BRxZd6Gh; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BRxZd6Gh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnGaVT+WXYLSHMoq3KuB7hKRlhXdogw+b6Hv/MtTYgtbdn21OKkDu8OVxno27X1/FEh1YhCm3pc2UhlUfo6zrgWF+3Wdopfwi6TJgeNfJauzt/RMLaf3OLHZk6tIy2KEnXn+6C2QFoZicU9jRdyZp/kdnaL8tkoCKJRZzZ2VOTtt9jEXbG/PbxK+ySFqfif2Jvzv/tlt6HngCcDWoaSer+v1G/Mriup0KMS3scdElT5lsbydnJWYS9gaEG6pBMySyIiXfZ4dq+K6T/iFI0NW4baP2gfKOJLUyWTLWCKweZg3MJOqxSyEdhkxKqZytHYbxPxctAWQ9OUPZTnUG6TWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrL98nBCf5N3aRAn2cbR/y9u0rbWMnUTjALvR27WZ8M=;
 b=RSYPaT4ezEGLf+OQJCXgKW9z6Sx8epCQYhGNX77DdskjUcoVymTBCdX+axJ09ma18qYCXUfA7I+qSdc/81xOvd7xC2bYV3vK9oknXdYOirKU9SnFsD3Yz+3Du34Sj1G2R2DVMslNhNH7QUrpE4S2sR1vY89REculJ6UtfTT1pRD2RSXy8zu7cqT/QtY5Nu9HjWN/HNFfWEMxer0IthIbZlFJENDk/t6CTgjyPwtT5kUk395y5ARbFCByNrMpRaNh6mH9r47OOysu1698yWLlIzZQvHeVxzyRYT8RBjpETDjRI4K0JT3pSw5fYmsrIXTZ1mxs5dvLiLNh39wqwHVH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrL98nBCf5N3aRAn2cbR/y9u0rbWMnUTjALvR27WZ8M=;
 b=BRxZd6GhKz88zKvWpKk6rkHtKodfbK2G54rTx+yPHxo+eJwUtg7I/Y4Mygw6C8yg11dTr57Hl5N4tdT+42QxFB1yL0K9tzsSYODXZlAi4/bpeDRS5s4Pqkl/tbE7cbwfItV9A5/Nc6nBVKqAxAogi+utQZl3qWE+rwZQpVYgOQSJzfvsQnmSTL2/EE9yA9nNBn9vDYrmqNbkkJe9UXOSS58I/T2jyrrsv4y4snlKwX26Vu3CGQHw8YqxNYM4lCzCPisFaNqguR1sOoQW75Fgqg2b8WR2uutNXYkhimtwvA/C1+wcQv4Gx3FtwAKxbvUzB/uLLaa3T1Q/LTCVTa2Kpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7492.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:08:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:08:19 +0000
Message-ID: <5e44c6ae-c6ff-4a31-8256-d7f7fc4dac21@siemens.com>
Date: Wed, 6 Aug 2025 06:08:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, August 6, 2025, UTC 7:30 AM
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 474952c2-ebb6-4317-68da-08ddd49ee062
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjFEcCtYbWJSQXFMeUVycXE0QlFqemdkRyttSEwxalRINTczRkhYekJtUEda?=
 =?utf-8?B?MEtVbllzUWZ1Q0tFVVpXQmpjbVg3Zm9jSFNmMUZOY0RTRmNiOUN2Y0x4d3F4?=
 =?utf-8?B?Q0VqZk5kNTdWci9CdUpuL2MrNTFMeXlxVzlpNXRIWGFmL1dKWW1jbUNIK2VU?=
 =?utf-8?B?RVY3VENySGZmZ3luQXhHQ29jZmE1dTRJaUFocjRiRUo4QnBDS0c1cUJKdTND?=
 =?utf-8?B?dmg3WS9DZXJKTVlucUIwVC9rSjVRUU14ZE5HMUIvRUhLMk90Ym9rT2VLV2Rv?=
 =?utf-8?B?ZzI3R3VaNWRlRjgrYTJjZEo5Z3cydnJtT096Z0tEVitDbmlZR1RaMEs1TGdS?=
 =?utf-8?B?R0VNSjF6YmhzZk9YbzNJQ2RScGZsVXIxUW4xWmRjOEJlZ2R5dGkrZUJ5ZVNQ?=
 =?utf-8?B?dktCQU1VbHpDM0JkK1JmbS9qeU1rNDZrcFZrRk5WaEY5WmR5NmRTZTNXM29D?=
 =?utf-8?B?dDNYT0kzeTRwdDFLU0pOODdlUXo4WU1MZ2lkamJRaXZLTXRNZmFTWk9rcm1z?=
 =?utf-8?B?dTFKVlhDdFdzNjIraTJ6ZWNYUDdlUDA2QUdKNTRCYlN1Vll5Rlc0L2Y4a0xE?=
 =?utf-8?B?RHIzaUs4aVVTM3gvOUdFQlVvS28zMzRCa3Z2UkRLNmhzQnJhVk9nMUVna1pv?=
 =?utf-8?B?RmY5b2UyUFBHZ2wraW5XSkt1RHU3K05zdEVmTllmc2dXYTRJVlcwMlFlQ01X?=
 =?utf-8?B?NU9aOGNLTHc5ZDBpdUo2Vk1sL1JFVWkrRXE4S2FWbmNmaE4vRnB3anJRaGcw?=
 =?utf-8?B?amsrS0lTdEJlbGo2MGc1YTVsYitMTi9xY2dzaDlKZWRObXoraTM0dnhwelVx?=
 =?utf-8?B?ZEFtRGdGRWdrTWh1K0ZweG1tWlpzeng1Y24zMXF0ZGJsRFFTdVJMa0pIeGZZ?=
 =?utf-8?B?VFYzT3hweVlrQ1VSU1hIMDRSa2ROWDZXNHlyMFhtenB3eTd0MHNkclNBV0xS?=
 =?utf-8?B?N2Nvc0owMEhhVC8xb09tY1JhMS9YNGx1ejFUZjYrc0JPM21XSVh3bHdHanE1?=
 =?utf-8?B?VTJ2ZlB5d3dKb3ZwOGVUaTV4WUZic3Y5T3pCb0xQWWJ3OFA4NWhGZU9INzVu?=
 =?utf-8?B?TFRNbmx5cFI5dEpKTXZWVktvWGYvTGdjSmY0RHF2ZzhPQ2psSGlmTG5BOGVr?=
 =?utf-8?B?dTdBTjVhZ2lCZWdTdTZHUTlqSlhsMjlPNzJhSjVraHFhRFBZUnQxZWRJMG8x?=
 =?utf-8?B?Y2Rld1Z4VTFyWVB3WC9iMVArZldKcUt2cFR6Vkd3N3dZN1Q5b1hvK2tlcGFa?=
 =?utf-8?B?UUNPRjNHZDdoVlIzdzY5Mm1tZk5peUZjZHFRWUQreHE0UnNRcE1GZE9FckJy?=
 =?utf-8?B?UmdiYlA3NVR6REFjS2t2bHBlNW1CTEhyY0Y4R2toazRuOERJT2dlSm9SalB4?=
 =?utf-8?B?Z21YMWtIWnEwUVV6SElIZld1ak9vdlRzeFJTUHNMMFBWdlZqd2s4WThRN1A3?=
 =?utf-8?B?ZlAzamFOOW9TYWdFcDJPS2JqL2hYNUx4Y0tXS1VJWWU3Mk5YRitMdzVURlNC?=
 =?utf-8?B?cWV0L0JIcHdNbXZ6NG9oakl4NVUvZHVmSU5UVENlWFFpQzRnSk5meE1CSjl1?=
 =?utf-8?B?VkVyUTN3dHhkV1cveXBwbXhUMlpYRGlHcktLYjZKejNoZFdTOWxtQ1FIUXpi?=
 =?utf-8?B?SFpNQUhhOHJPY0ZGNXh3dWNmVlpjZ0xtZFZGcnd5Y29NRm5hdmYzd29QNFlY?=
 =?utf-8?B?RHZMbDBndlo5cWdrSUF2NGZrQXFXZlpYdDhKR3MzUWI5UzloZHN3czJuUGZ2?=
 =?utf-8?B?bXYvVkZUb3VpdzdiWDkvVHNpYmZaUnFCdHdpbVBzbkM4T0VEc1dSYlNuK3Bo?=
 =?utf-8?B?Y2NjV05SZ244Ny9aRjBsbTJ1SDZZZHIxQWR1VjhYdmNsbWo3U25PYXlVMTFu?=
 =?utf-8?B?MFNUM0NUUzRuL3g2STBWVVRPckdTY0VTdHhrYVR5aHR6dWs1NVU4ZlBCSUMv?=
 =?utf-8?Q?LzZXCFIarY4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHQ2WHowRFRiS05xc2lWNDlHNGNpZjd1cjYrZW9HSWUwM0Q0VFlWcCs0WSt0?=
 =?utf-8?B?YnozOHY3RTN3dC9GbzdpTHhLZVJjQnpjSU1uNDRubm1yWi9hajNjWWhENGZq?=
 =?utf-8?B?NERvRlI0WGpMTjI3d0tPQ2lKbDNtN005aWFNMC9HYndzN0pGMm03VmRoRCtI?=
 =?utf-8?B?aWIwcmROSU1FS29YTnpYREE4SDRVTVEwSlR3TUZCUTlRMHVTc2R6WVQ5bS9N?=
 =?utf-8?B?ZjBEN25Bc2Z4YWd2RDUwWkNmdzVZL012L3d5RTBvOGZidnNPNHNZa3dhTnFa?=
 =?utf-8?B?aVhtQ0V3K0N5ZUZyWGF5MVJybFBWU1JuaVk5MjU1eDV1ODZIdFF6Q01IZ3Vw?=
 =?utf-8?B?K1NvNHV3RTdHNUw2eFVINTY2UE14Unh0YkVyYkJ1NG9pQXFJUDhDckQzdFlC?=
 =?utf-8?B?cWxDWURzWW4xZVJGbEhkZW1HU1dZcmthcVZrOG4wNWFjbENlOVJQajhFb3cz?=
 =?utf-8?B?ZDZSaGFJWHpvUjJ5eHdlWDRMTG5kY2oyT3FxRHdOeUFPSFJjd2g1b2dia2ZP?=
 =?utf-8?B?WEdSNmE2Ty9zcmdabWJPeVZ2RWhsQXM2a3JqWTViUFJpVkhiekk4RVlNeGVX?=
 =?utf-8?B?c2c2SlpsalF0K20xWTJ0NEwxa1pDcFdjdDhhTDdVS3N1djAxRDJWK1dFeEh0?=
 =?utf-8?B?M2NBNGV1eXJndTVPbFROVlk4MWxGTEJZaTUrSERXbFhtWVAwNW5uUm5wOTJF?=
 =?utf-8?B?d0tYS2w0SU9WaWFMVjlmdy8xbjZBSk13ZHo5RGh3cE1ON1VuOWJDL0xkVzJn?=
 =?utf-8?B?ek9tU2c1OERqanEzeGJiQi9Rb1JIL3Nhd2ZFalZLbE01d2M1TXRRblhZNjJ4?=
 =?utf-8?B?ejdzYnJZZXRxK0Y4OUEyeXU5Y3NTS3pRdHp1cDBmdTQrcVdFOGNHS09OenQv?=
 =?utf-8?B?djY4YTNJU1F0UFVDbzcvSi9zSnVaa3hMWTBVU3p2KytYT3paUjlEa1FNakIx?=
 =?utf-8?B?UVQ2VzVZR1lWQ2pqTmJzdnVHWFUvWGNWSGlhL1hPNmJDQXBkQzJzb05WQlJZ?=
 =?utf-8?B?Yk12b2VXQkZOWCtVdGFFQ0Q4d3B1OUw1d0swSzNIY3pCOWp3ZGlOaElZcjZL?=
 =?utf-8?B?RmFqb1hhdHhRMmZhYzZWOWlrcmRzc2xEU1JxZlhPd0FSYVh4Q3o2T21pelRl?=
 =?utf-8?B?OU9KS0d6QU01ejFnWmwrcW1qSlV3TkJ6V3J6NU40aUZxZ2w1WDdtbkpjUXVL?=
 =?utf-8?B?anRCNjdlWkg3Z0t5Ukh4cCtBMmxHN2hZWDZWUWowOCtDUnRJVERjTDRCZmNk?=
 =?utf-8?B?c0JCV2NUZUVRQ1U0QnZEbkZrWXcvdUJsakt5VWZYR2pFZ09oWHFya0dEWHJn?=
 =?utf-8?B?cnk4c3J4OXFiWlFycVdlYnJIZVdzMVZzSEtpK2xHbnM3cmpCZ3k4TytDOEdV?=
 =?utf-8?B?b1Bsdjdrb09xUnMvaFVPNVQ1NUdtZFNYSExLdzU1YzJUQTJWOWVsMEJEc0N4?=
 =?utf-8?B?dHV1Y3gya0RmNzNwVm9XZm5KR25Md1lLaUNJVnVPYmJ6Z0F2QVNmVmZHRU9U?=
 =?utf-8?B?ZzNyOFY3VTlLN0pUMTFIZnhQOW91YVRNRjJtWDM3MzhMWVVCS056dkovUU41?=
 =?utf-8?B?NTV4YVFrT25URG5XeHIrckhkR3MvWDU3M29EcVVBenpZTWY5cDBCbHZlSVJV?=
 =?utf-8?B?RGh1WGFHSzVUc1JVa3E0TW9rcDNUQllsa08zWGxLQW5waHVxUHh1ZmFBazFX?=
 =?utf-8?B?SGpXMDZEdzcwS2tOVUxnblN6bVAxeEdNeTR4clVHb09oQ1dQdzFHVDM0VXM3?=
 =?utf-8?B?bUdtVzdrNUQ4d0xZWHBqek9PWDBFTXZaT3BzMnZWdVBKeVUwbWZTMEZTS3Bl?=
 =?utf-8?B?cUVGRUl6YisxZm1wbnI4b01VMkNXSmFwL1RDNm1LMEhGeFAwY01lV0U5YjhN?=
 =?utf-8?B?eUxuUEZVYUdPWVFYRC8vcml4eThZYWQ0V2NoU2lWSW5xbEptVmhEcW1EcUwx?=
 =?utf-8?B?THllQkdWSjZHdDk1ajUxNm9kaU5Od3g3SHpMM1hLeWtUYTZNNi95WG1hQ3Fa?=
 =?utf-8?B?cTEzOUpLaVNjck9GeHVYWG0xc0U2SEFTMkNmY0NDMTNlc09RKzA4MWdTTFZT?=
 =?utf-8?B?K29VY3ErMVNNWG5lK1cvOVVVK3pkaHZhNG9PWnJFV3J5ZzJtbnNhbmFNK1JC?=
 =?utf-8?Q?hESeZvs/2zDnGtXZ2VtsMOeXQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474952c2-ebb6-4317-68da-08ddd49ee062
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:08:19.2888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0a7mz99ir+kRlihBsBlBNFqOojI/crbNo9WApYx4D5Vn4cur57cmZqQQGVpoqjgRgGKIgIBi9f5biCwZoRLNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7492

Topics may include but are not limited to upstream/downstream project 
plans, status updates, and technical discussions. It's an open online 
meeting that anyone can join and ask questions (you may have to wait for 
the organizer to let you in).

Time:
Wednesday, August 6, 2025, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
