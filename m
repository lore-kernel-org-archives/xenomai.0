Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB99385D9E
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605980; cv=fail; b=ozx6pL+LmelKvHw422a4ohMI9bdAm0BGDT91DFhKp6Sp3I76SsRWysdP7NECo/Lp8M3WdJ3dJs/9xqYfMX6yawxtKIOBfp78Z0OvhArMMx/mAYjmsv8W+A+d0U4etv1YZCFrLYh6DO0VPZcKUvINVqakIuWLNbVMpDkPu9i51Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605980; c=relaxed/simple;
	bh=JClQqLKrcnxG+okw5xJkqmd+4B8+bz/DMnKbu2Q2GRY=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=f3GTt9iQnv8zFhGLaAx1+cDRmy+ufGj1tNV8UTg1MVMeUWFYHpJG++QdWigXPa1qI1vj55uQfjdDx/Hhe/DRjsTccqquMjU62GqLBVmXSZfSYH8Uv0wJzo+0LmbaYrKtShdLfWFy0Ba2XI7FhvSH6IWzQLwORhUqRr0WxqhSKp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=I+U/FXAT; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="I+U/FXAT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIKsf4MKqdwlvXbOCCIrHfbhrri1BWrZ65SFhCyK10e4hc48D45QRticB3CI8CuwbgwAlOYVlKew/o0M1xf+J4IjoRJs5zVP6R0LJ4aCjcG4ynUlyA1UoxZsu9h3i/4a0JktexbVEMbrHNch74qApfuFuC+GZynNOvIT+pa/W+/EYiC8qQZR+cZ14SLgAsehN9TBvNXpgR2PJRL99Wi42pOYfNCOMkGysjgiYO3jgctAjM4cFBJrg5FILb0YRUu1YrqE/wh8dIGwkm0tMxWOIcTqk1IxesuzscJhqBDRnVtj5SZPk3mkUfYJ4/cykmEQ4iOujSDioIwSmwogoKpudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JClQqLKrcnxG+okw5xJkqmd+4B8+bz/DMnKbu2Q2GRY=;
 b=aWI82iixCCv8O68eD4lcohVpylMuFUUCcZG370NclHtiVz8VxXXIEOOlQ7QtKeW/cpzoxg4oMLDqqMq4smtRo5C7xqhMgtc52lf5/du9ktTxT0rG809fa9s9PRF4ujzqkIb6jjRvkl+YvACOFPAzI/IK7EPKgxn28gCKvcgRuOoe2kX5w6c7Gyz1K3L7nkK6T/KtHua3XgQRdQzAmrwiQg/M+CDsQw2P5Ax1NUrR2+8WuVBlKO68ZqZoCu35xUhvItiKrTjdLomi950n5Bp+b6MNMN5DkUKsaM58sYej9R8z1P27nR6rGeiT8k+JeiGCUZ4o/pkdDrWVDCGmKIt87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JClQqLKrcnxG+okw5xJkqmd+4B8+bz/DMnKbu2Q2GRY=;
 b=I+U/FXATnJnAluGNZpV7m2aPSB7xeFoM9qgPwTl+Uvfmjn1JZURgGEIFqzotzXemuw3i4arMRqcaHRH35nVBVlnB+poXnkqjCkEXDH3Dt2sveAr8hRPEyH/48w75XvwMfZmDfAwni0VPobD25TR77bLGB9tNWvKIHzS7H+FbQHA+tYjE0P5WVuE6X5/3iOKUypZK9rKYOrMAc2XGyfi0yHPsn1PKkvlDn0a7ocQVAhDkd5TW7DYK+VozKsBSkVm4Zr4g69Khn/3Er909ODwNnXFuntKvvhD4VYZBj0vF9a/DyrQ/wGDY0huwiJnx97TncnBHW/3COmsxeIHMDhxYmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5817.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 17:12:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 17:12:55 +0000
Message-ID: <35d15a5d-83c2-4a1e-9b85-c748635dbe66@siemens.com>
Date: Tue, 12 May 2026 19:12:53 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, May 12, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1084fc-950a-480e-33fb-08deb049b4fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|4133799003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	hVS7ai10nVVADPlrzDgOE5qM6JHiHHjUY++y/bcxrYYJ1kXYPo4mkM/oRHTFXm8yBUqhtIdO6mQd7q0cEmXhhhr26Zd4ErlXKelVrilu6D+79ztrlnL++YxzrTEvT4qo1sJLElrzJYeiuhlCEWYurVwAzRJSyBupy/OuLlEtSlwIaBIcVWVUcbif2KRW8/gHJPKmv+0KXVCuhu508pcJR2GTORfWbcoDCZ5NcKJKz68tyHJHYGpkV2Au/tKYAkdCEHIssItA9WTL9a6cd6J6UdH83n+7VQiYCbl3GDaLRDQLhBqcoBcMGIb6ice0YrmjBfQW728erQqccMey7xIr+51WiKzqY7FDEvj2SQkoUrI3gJ8uCncj5BNKpgOV1rEGTm/DVjLmc1dxoEmLXxSO5pP/T1X6EsjjGszk3VXQewXTBgzqAFQKBuaOykpMBwNg6Wac9OnEkvwzhWqjmIq2+5XlKzKYPmXtp7dcNnmMNZUmpz2QOT2AHPPMNwFbZLU8hsrsUFVtqtpS1GkRiom9GrJGpv7i2LBH4Y6RQsu8t62sDQ8amIjPjYTBnQlS+JRvLn78yo5huQBh7NKiuxh8Oj+CVxtFmvJiozkas6yzE/h2MCtEjAxmyq63NR1IUzgSrrup60ioISv/cZWTVqNhSGUtn/Q00V1djM1WGwp1qPAAiALEfc2G3axEO0jyqG/g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(4133799003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk4rSUVZOFByRWVEYXEzMkphZGpTV29WTkdBS2tXQWh3TCtZWEFDRm1HenRJ?=
 =?utf-8?B?NTAyTVZhcjVreGFaK1ZzNWZvNFRyU1N1ZDRwQXgzaUczbmpIRGh5ZURUVzN4?=
 =?utf-8?B?MFFPRGp3WVJOSWRpTFZzbWxRdHFwaisrUUNzWEErYUNGQzF6UWs0R01ZWXpY?=
 =?utf-8?B?UWZaUHpLcG1HMFZUVFdna2MxL1NGcmo3RXNZRnhDYW9Lc0xqeDZzd3QrT1hr?=
 =?utf-8?B?bFdaSWdlSmRQd1FZNEN0ZytaVTdLek80cE1xM2g0UjMvYUUxREY0cmFDOEpo?=
 =?utf-8?B?YXI0RFZvZjVEQm16SmROSWFHMU8zY1lYYmVabHVjdHJJWnh2NXB6TEVKVC82?=
 =?utf-8?B?amM3T3JOem83ajVHM25nb0V2RGwrQUcrUit2KzBPQjlSb3J5ZDhCcmZPR2s5?=
 =?utf-8?B?bUlkNkNDdGdFL21ObnkzUFFRdktxQi9JZnlyVzROUU5uVCtsS3lrc1E1MVVQ?=
 =?utf-8?B?ZVlpNHNybjBJbFRCUlNhdmdtU2p3MUEvYjFnck5TdzM3bVJoUjlPZ0dhMmha?=
 =?utf-8?B?REp5OFFtdjR4cEdWbE5COXVrS01GSWM0MEpYTWQ0NUxteG9FZlVPblVGT01Q?=
 =?utf-8?B?OTZ2N1lwcTFydGpTWlFQcXkwUWNWc0xrV2RkWmxiV08ySzk5aTZRYXBMVCtR?=
 =?utf-8?B?YWNWdkxzMGplVFo0eFE2U3dpZmRhZlNmUi80MGozQVZRY1ZsVGh1bWdGNlRQ?=
 =?utf-8?B?U3Mxc255SnE5aFZHWlk0Uk9rUXcwZTNVVlArMnFyUy80OGZLNzg1RzFTMXk3?=
 =?utf-8?B?aWtvQmw1Q2gyQXZuWTZjbGQ1clg5Um1DZ2d3bTlHV09OY0hpUEFKWlRKSDFs?=
 =?utf-8?B?TWxyRUp1SlhkcW1JUkxUV096S3U1R2lUWld1OXo0TEhQTExJMG1UQzltbmY2?=
 =?utf-8?B?RG1mNVJiSzIrRWhKRGxnN0d0eStsZnM2U3M1OWdMNng1VUhVVWY0OFJpcExC?=
 =?utf-8?B?SUx0Y3MwejRna3VhOENlSmdyeXdsQVFpQmJudW8zQ0paaUc4U3RyUVd0UEpF?=
 =?utf-8?B?dUNMdUExRXVuM1NMQ0NtRHRqSlJIZmFJa3F6K0pFa25pOTRXb1RyUGoyZG05?=
 =?utf-8?B?MVRRRjZtV0JLQWFkT1pXME5Oa3JQRU5KYWtZR1hGM1FXTXZwVk1qZkhtWGRI?=
 =?utf-8?B?R3A2SGVpRHB0L1hmOEJ5ZnppY1ZBaHRTd1hHT1JnMzZmT1dpOXQrV1lrbWJF?=
 =?utf-8?B?V2RoYnNxaWFMM2RBemFZT0ZVb0pObmxnMXlOTkFUWVNIdkQyVDhVYWJRbUZU?=
 =?utf-8?B?R0ZVUlNsdGQyeDZDTE4rNkdNZHh3T2Raekc0ZEtOOEx4T3ZqQmJXS0xzeXF2?=
 =?utf-8?B?akQ3MmxocWlTM0VVV3dVbVVReHFUMXIxZm5QQ3hValhwSGgyOVAzOStoLzY2?=
 =?utf-8?B?OUkxWFA2Z3Q5QVhKZ0o3MU4zNWQwTERyaVBLZ2s2QVBtWk5kOUdpM1UycnJ1?=
 =?utf-8?B?UDh2ZDdsaW5Rc2RaOHBSaWxvaEFNUnFjaVF1eFpxTlFCeUxReFlJczY0K0hx?=
 =?utf-8?B?UENuMDJpWW5LaTRrRjJhdzI3akVGd3FadHZtSlA4S0RVdkJrZ2JRbnZ5NjU2?=
 =?utf-8?B?R1dEU1R0ZFk1MVVGVzlNcTg0RjJMZHMwQXNodW5ZMkgxWm9zaWlCVEw5ZGtY?=
 =?utf-8?B?WjU4NVl5NnVDbXBYbGFBdHZOeEl6cE9WZFd1cWVkODBqUHlNZW9mRUpGTTdL?=
 =?utf-8?B?Zk9zNjF2RDR1T2U4aGhXWktlTG5wSm1JcjV0SmZBV3pqV1l4NGQyK0xKOGdW?=
 =?utf-8?B?QU5OdjI3dEhramhmcDVKeGsxYTRWM3ljd1l4bEkzeHZKcU54dHVDVi90N09Q?=
 =?utf-8?B?S2REeEl4emJwM0ZwditUeEFQcjR2ck5SZzZXNW12YlVOb2dNQVBkT0o3RVg0?=
 =?utf-8?B?NDJyQmtueTN4ekwxKzNtYUU1NWdpci9DYnVlY2NYRVNCelIzM2kvM3lmdFBh?=
 =?utf-8?B?dnErN3pHM0JsT1p2Z1ExdW95ejJTQWxVU1hqWHdEcjF4ZUxDQ0tzeVlRTEFT?=
 =?utf-8?B?R2JZVVIyd2c0NjhNRVBOWDUxNjkwdXdMb1d5bXNISEFGQUJ0VFlYL2Q1V3E1?=
 =?utf-8?B?VVp6WGlvTTNWYkZRYm5RSmc0cUlGRHNSVHRtMG9NRzRHMm02OFdxRnZrZDVG?=
 =?utf-8?B?bTgyZEc1Y2N0ZUFmL2VsY0Z0YUtBdlZ1SXJ1WlhlcU9WcjhaYkxmczZSSW5t?=
 =?utf-8?B?R3daZEQ3NERpeGR5dVorNmFqeGd1eDNHUmh2MmtHTkh4Qnh1QThLWE9IUEFB?=
 =?utf-8?B?QVZnQkZrZkRJUzVacitpNVBDbzhQeHh3UTBTZFdNV0VFb3FZdmxmMnh2a0VZ?=
 =?utf-8?B?bnV4L1VWVGMyc2hLY2R4akJOWmEzenlaUXlKdFBuS0hDVFhCM2Jpdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1084fc-950a-480e-33fb-08deb049b4fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 17:12:55.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHSloyH5jtHm4YVV3QQSQ/d0FDEFkmxB9btU9nLvKt3buEKYNQdivfXp8cJumaPBZigl6GO7HU1ZPP7bCpo3wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5817

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, May 12, 2026, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
