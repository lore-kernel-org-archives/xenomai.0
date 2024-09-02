Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2331EA73
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281213; cv=fail; b=NsMUEYgGeSlo+kBsESetMod+wqVxqh4lRXALhqC5ZnZ51I4wUwO+xUlbHduJCr86mmiz2levehtbFflYf1DXtQOYqjwVaw4Rdhvb0D4NH/QE0X0XL0GDFTICH1TBsc2sCkhWx+O8qX7YEcHJ0xVBEzymCNWFXJ/XPTCGrrCtOZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281213; c=relaxed/simple;
	bh=8CzsCs7pymIiXuOPC16jOQVFTtZv7S0FbiKIBQX34+8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W1Y5Fz51oqHrr1hjJbAmU3XsSI1zIwEW9UqjuaO59MH70Y3HkeAs+clQGqyAJgoswcwOdZsIEqC9osFiXzaoQuxi8IdoAq1e479rO6GgR7g1tsUJl1TXMXL8qfeN4w6Zs+sIaUo29fstO9uk6VOKK0/cVpSTBz1ut6zSJCY5l8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=R2FPw8d2; arc=fail smtp.client-ip=40.107.241.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="R2FPw8d2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWro+mUh7jDu/v6jz8r0TnaOOefGrrQgqKjMyTfElpEKsP4iazdm/sqoQlCLU4zsCUuUkwNJ2ec6dNJD1YqsSARTjYvosGBB3akwaXW/hSetrcxYngQUpWl70ngAhDAQiHlhkZ6S8Os0aJiQccJyLn9LNQd06gD21o+NfzJnb/i68c1rQWuWQIROSkGdGt3hGpY7R8FA2W1o1Ymv7DUBqq3fz4dYzRhu/6bgckbO9rTQhe4igUx5Hr0PA7ykpRQtogNt9qYqCGMJ6ZjG1Sjg6iL2OO18UxexBM0AwoIvfGOQMqD4cPcwBgeTPRQA7e+0Wd11rWHbPVO0+B3TjzuBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixAPxF+Ey55AfM7zK1BCcBasBgrw9YBoEHAputpVq1o=;
 b=ebc14qWvsCN8aWxWzTDSPPAYdINH+f8xxHYrtVAF3FuVSKBCo2XpDRAxTdgPSM9W2RdeH6G5JeSqV3EcGJG3Wiha7JYkhRcwvAlozM3gU3z22QFnyWsHT87wIUBesmT0jssZPygFmWyMHZ6pC6VFhF3UESL6IgDj1akEB/kIUFF4gR0nux+loXwhIoja/25S3TE5Wb7TTTS+pyFIDF4MaP4HT3HZ7Fe6tbrK24GxkK+91EXnOej8pz5m6LTy1Pyd7bbt5yOwB014jQBshWP1xjqUoNQkvIR8IM2xjvGZc6SItxYRKowOxxr1xxSfWU2t7WORapE4CxgoukJulBk8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixAPxF+Ey55AfM7zK1BCcBasBgrw9YBoEHAputpVq1o=;
 b=R2FPw8d2flMoATOwPswYC0aXPyRZLA/hWCKBKfG7Y28JRS+El355wEvO1UwroQqkSTtO9tVQYRkDTBfNHCgHIArtbWfTLEuxyTexDz30isU712eigGsip3mbgOVH7JzMjs/whoMrf0uE5k5OOKHNLFt5hSfG28e1DXNGgV26JDhJRqZCRFJJaQpqg+Otrr5ndYCWBHwAubZ+D1Ukz3CvV7hVolccdK5wHidz7TLfYMViWI0si/FD4iawhmKdg894dSthGglwHqn/q93M1Z+jnDMMPN6oNRsXNfevpni5ICksmlGwGVJQv6t1VPeViV5U7qQh+YrQ4KECs8y/OcrZrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 12:46:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 12:46:47 +0000
Message-ID: <8315330b-ced5-40d5-8ad2-6b4574e56e8f@siemens.com>
Date: Mon, 2 Sep 2024 14:46:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] alchemytests: Set cpu-affinity by env var
To: Simon <simon.graber@sigma-star.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240829083526.24536-1-simon.graber@sigma-star.at>
 <20240829083526.24536-4-simon.graber@sigma-star.at>
 <01d5e55c-7fd8-4aa6-a9a7-efdf5bd3f740@siemens.com>
 <692e3344-9feb-46e4-a7f9-4378c3831c26@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <692e3344-9feb-46e4-a7f9-4378c3831c26@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0288.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4021:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ecc3ed-0578-4cae-7f86-08dccb4d4e6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDhrTjY0Mzg1M1ByZkZtSkJNVGZGUFlYdWp6MXNhTkVzTmZETWRGOFhqZlg4?=
 =?utf-8?B?TjMwK1phd0J3Mnp4T1o3VU9FQklVd2tXdW1NM3dUZUljTVZYSVRCTnQrTkY2?=
 =?utf-8?B?ei8vTkp6eEhQY1JJcEN0V3NaMVhZWmlmZU1XalZSdTNxTXFFTmRlR1ZIOXgx?=
 =?utf-8?B?Rk1OdzExY0dMWEV3NmhuczU1MlFHcEwwNi9MSzExY0NKTFZ5VkJaSnVQMmRK?=
 =?utf-8?B?S3AyRC8rSzVpSnVIbkpPamJMVGRaWm1kb08zdDNCS2Y3VVo0T2lnbzA0M28z?=
 =?utf-8?B?MzVqeDZoOENUYkNmNHQ3a0dEdEQ0VXF5d3dIcGdXclhVcHNnWGpHblRlVlMx?=
 =?utf-8?B?c1BrdW1yQjFVU3hBM21ObjRXMU1kRmUwQTBCLzBtaGwwNTZhcGxjTWVMbmh2?=
 =?utf-8?B?c0hsTzkrWExmZE5BZ2IvdXdpdmM2dWpFUWk3VVJuREpqUjduVktHTnVvSC9v?=
 =?utf-8?B?dU9ubnQ0Y0FWV2ZuL095SDBTSmNCcUxDUWp3a2VWY3hpaE9qb2xVSXRZY3Qw?=
 =?utf-8?B?WkFxaFlGSkNaMWlSRUhmZTdlaUpRZmpMemxaeWhmRXNWSEU1cm1vUm5jQmNF?=
 =?utf-8?B?YlhkU202a1NVU2xsdGNjTG4yTzQ1S2l3RExXS3NFSzBrZEJ4UTJhYWw2TG9K?=
 =?utf-8?B?aStKZGpxWEd5SEJqVUNpb3hWdjdUMnFRQ2F0VXZ0MFQ3RytDQ1pZY0ZMMGZP?=
 =?utf-8?B?Vy9RcnltOUxtUktYMEIzdHFDL2hHdDJWaDRIaEJnRkZLcnE1bk9zODhJd3ps?=
 =?utf-8?B?KzJpMXdqeGhIYStYdlY4UG9FV0J0Tjd1bERxOGV6RlIybHR6N1J5QU1BTEpY?=
 =?utf-8?B?WlVpY05McjlhMXlBUmdTcTNrWXJjMTUvMHB5OUVVS2Vqd0xQVVV6S1dROGor?=
 =?utf-8?B?ZXhDb3c4Q2IwcGljZ0NzSGRUYXowU3Nna3Qrdy8vMHNCQUgyR3dvSDJ2QXI3?=
 =?utf-8?B?MU5DeVl4eEtiSWRpa3BKYXhnaVhmWUhOSjhHVXZyOHJuRXI2bU5YR09DZUVH?=
 =?utf-8?B?UGQ5b21xSkhyQkw3SEtidkNrek9qdUhRL2lCTE4wOUMyMm5SRkJraFl5V2sr?=
 =?utf-8?B?aFBOYTZ1eWcvWjVSZVB4S0EvdWx6ZTFQZk40RWJZaXl5MFhUeU02bjZBV3h1?=
 =?utf-8?B?TDBvbTE0SHpIaHlqeDd5WXdNOW9aUGV4cmtrOGZBUkE5M0lLbGJ0T0syblk3?=
 =?utf-8?B?ZDNQbjl1OGhYYUdVRHVFVEpVS01mcUR2RWV0V2pSUGZWOHgzT0hyWG1sZFJD?=
 =?utf-8?B?RUxYYTZIblJ5WHFDZjd0VDBNV3N3Vk9IeFRPZUV1cS9PNEs0RzZMeTV0YU8v?=
 =?utf-8?B?Q1NSSnZyT3V5eFBBS2JhVFZjRHpDOC9vSmxOY0dkeHJXNEYzRDlsTXk0U0lV?=
 =?utf-8?B?cVhhWlFoNEljVUlYN3B3bXFpdGlXZmJ6OTJvUmJoV3pRZWFpRmt3ejkrblcv?=
 =?utf-8?B?SnRBZDUxa1RsVjkzeG9KMzN1YnZEejZ2c0dNaHNmZEhCcnREcHowVDVqRHNm?=
 =?utf-8?B?NEx5Ymkxd0d0NjZ4eXhLU0tKcWtsYW90cFU1bTNFZ1gvdThlTU1DaU5xWVk3?=
 =?utf-8?B?WU5BQzNWemVjR2lTTlRwWWZXV3MzRWIxNlM2V0NQM1ZhZ3lKYmxxYTByeUlD?=
 =?utf-8?B?YkhMUkdiU0lFRUY1c3ZTcjRLMUFPNklVekNMMkh3c1o2U2UveHg3WTJkMWU4?=
 =?utf-8?B?dzE3ZDhkZjRtdUhQYTFZNG1QM3h3VDdSYWQ1RmxISE1xZkFOM1ErSTBXTWVW?=
 =?utf-8?B?eGZsYnhDNy9hOU1IOW1vK2poRFB4azdLL1U2OUFJL0VqeHpnM0lGTWhlSmcw?=
 =?utf-8?B?c0FHV09QL0pTQ3FScVhLUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXc2NDVRMG9zb3hQenVCQTZjZE5zMVIrWnluR1JqbnZkSG0xalY5UmlXWk9O?=
 =?utf-8?B?U1lyeTRHUTFqLzlGSmtha2J0OFZMYkhSNmMvamQ5ZVEzajhubTY3WVpCSmxP?=
 =?utf-8?B?Y1dQWkdoZkZrOWVpYUFDOG9hZ3RoR1VNbWRnNk02V0JpV2x0cEwzbExRbHBU?=
 =?utf-8?B?L1R6OU5jTXNMdEJjQUhiMkMxRnZYOHlRb0lXQUFrVG85bm5zbXFpbEk3QUJR?=
 =?utf-8?B?TWpPUmRranZleG5tOW4xaCtRb2VRK050OUdLRTJEdGRHaHZ1OGlLNzVXQzNw?=
 =?utf-8?B?Wis2MnZnU2JqbHhVT2IzRkFPMC9jOHIvM1J0cXFHRzBrTnRqMDRQdGp0YXFm?=
 =?utf-8?B?TEI1V2MzODBUcVl6MkVHK0VQMXptR2I0Nm5qZ05pV0I2UXcvNGZoQ2xYdjI3?=
 =?utf-8?B?SlgrZjZKQlUxb01vMTUveHNqT1JpWjAyK1pRWWorOVNQOWYxMnhRaFVYSzM5?=
 =?utf-8?B?ejZ4dGtsUVpTRE11eGQyVHF1dkxVbnp5Uk56VTlYRlZkRWd6QWhPdFVwL3lD?=
 =?utf-8?B?aVJ3dnNFYUZMbmxsekZRTTdHSGlVZklkQXZWMVFsc1hYNE5iaVhqUkkvaUc0?=
 =?utf-8?B?ZU40VTdCeUN0U25oTDNPbGNLVE5yWFRYNUd6UTkxR0dSMk1aY3o1UGpkTThx?=
 =?utf-8?B?elJlYTFXNHIrNkpVMkdJVzBENHhIbTJDRTFXc3lYdGhyUEtiNERYSTVERTht?=
 =?utf-8?B?V1V2UmxmWTJscjBPdkFEaXMycThpSFlJM00xM1dZdEFQWVJNRTRocFZMQVV5?=
 =?utf-8?B?SGZ6ZnNVU01EZURWYm1McHJjQ0FQMEFTWm5TZTQvMmNGaGlHNkVZQkE2YmJl?=
 =?utf-8?B?S3dmU2w4d1hqVUgxdjEwN2I5UWhUN1lyL1FXMzN4WGNBeGR0VElWelArZFFY?=
 =?utf-8?B?enlNRFBXcXdTbnpZRE96ZHhSM0FaQnowUWIxdVB1VTYzTWk4YTlNaUJabDhT?=
 =?utf-8?B?Mm5TcW83ai81d2IyMEYyNjdFZEJZeE02ZGR3WS9nWlc2NHh1OFcwaHpWYnV5?=
 =?utf-8?B?cnVtQTY0d0E3dmhTb1B0U3dsaFVFbHVOaWlVSkVZNXBlS000WjdqbnpHZWo5?=
 =?utf-8?B?VGtFMW5YK2twRDg3TjYxV0hXbTBUNkdyYmZUN3lzZnpPaEZSSndBZmwrK29x?=
 =?utf-8?B?TlBlRVlNSHluR1lFOTJxbjVQMGI2TVFiNys5VjZPN3ZUSlo3bm5LWXRneE85?=
 =?utf-8?B?bnpsTmtTT1o3b2pMeDlWTmhXRWM1dkFCckxPRjNoL213Z2k1Zk5wb2Rmdmw2?=
 =?utf-8?B?bXFEK3ZlOWk2WUc5WUplUFJoMWQ5YjRrSS93Vk4yRjNhYWUxZjdZejB6MGlF?=
 =?utf-8?B?VkdRd3EwMjJEQTJvLzgzMkdVblR2UkR2Y0ZiQk4zU3drQmlyZU5WT2xoZkJw?=
 =?utf-8?B?UWJyNmpOM1JKTWJJbUZzblFhSlB5WXUyNWhnS1BZT1BlZDAyeVpvU01uNytn?=
 =?utf-8?B?MUttUlB1UjZrVE5mbk1KNlFpeHU1QSt0QmZXR2prSkpZZ0xydGZYeENmMkNZ?=
 =?utf-8?B?bDJsY1JQak1STGFMUDZLSEpaVzd6RVZuQTJMMXZZWlBBNzJuTC9PeGVZMTQ0?=
 =?utf-8?B?L3c3M25YTU9HRzNVOUlVS0tYeEM5bU1jc1Y5aVhtTFduVmppcUJ6bVFROVEv?=
 =?utf-8?B?Nzl0OTMvRDZEZENRY3hFb1paU2tkbWVjMUFmV2tpeExRSmZJd2NyT2g1RStn?=
 =?utf-8?B?Zm1GYm05V0xCNk1uUU1XS1UxdEFkUHNKKzlBek80SWlPUW5pQjJVaWo3QVhU?=
 =?utf-8?B?WkFXaVRzcFl3WnMrRzl4TXVDckNXaHZJcnJzRCszN25lZHJjc08vL0psVXF4?=
 =?utf-8?B?TWhhbVIxc3Z3Q0U1WlBXc0J1S0loUENSRm1yRGVha3ptV1BDbXpqY09DbG1t?=
 =?utf-8?B?SFh0Q3RkaVB3Z0pQMjh5NWJpR1JUYXRsQmxhQm5QbklCNUp3ejZtczIrcGJC?=
 =?utf-8?B?N3RIaFFxU1oyRkVXTzdzNDRyNy9nUjd0OVhzaEc5WGc1Tjk4Z2hwUU1QRkpi?=
 =?utf-8?B?cmJtMWhTeldRd0lSRUJOcXdBU2tUQlRONHVJQzYwVzRFWnQ1ZkNoZ3o4YXcv?=
 =?utf-8?B?NHlKcDdGNXdtd3pRUXhadEx2OThScEtldUlxN2hXcTRFRVdMU0lDWXJOVkov?=
 =?utf-8?B?OVB3NXRna1ZyTE1IakVidXhwOVcwcjhQc3pIUG5xUnU4Zm5xV1hheHVxa0VE?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ecc3ed-0578-4cae-7f86-08dccb4d4e6a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 12:46:46.9763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olTQNo2g/sCU4qASlBib3OjyjH8okz2Ti84Gdg7oPC2eRwy3jXhbhfl3moKWPIy1JlV/74JFDKRa2IAf/SnaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4021

On 02.09.24 12:37, Simon wrote:
> On 8/29/24 17:41, Jan Kiszka wrote:
>> In any case, the advantage of the alternative passing method should be
>> rather mentioned here. Just looking at the code, one may think it only
>> complicates the task.
> The tasks launched by run_alchemytests strcmp() against argv[1].
> 
> Checking for an environment variable would be more readable and less
> error-prone (ordering of args, -- or single -).
> 
> Once the --vm arg has a corresponding env var, the tasks can rely
> entirely on env vars.

So, this particular change is more to demonstrate and implicitly test
the new feature, not really a value of its own yet. Maybe something like
this?

"The alchemy test runner can now make use of the XENO_CPU_AFFINITY
environment variable by setting it before dispatching to the individual
test programs.

While not changing anything user-visibly, this stresses the new
interface in CI and allows in a later commit to pass the --vm argument
via an env var too, removing command line injection from this test case."

Jan

-- 
Siemens AG, Technology
Linux Expert Center

