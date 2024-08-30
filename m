Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAD4B5AE
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032764; cv=fail; b=cQBgSllrIelh8FbV/Ls/LUm3j53xpOHdHBLPJ8/Dh5wu+eVNfM5Lk0myctBZyOkp0+4tEW3cSYu8/j/MDVKybVzC5rGlwkmeXg8/m1g3MpXq74IAWCYt8h5pb//CLt8pl+5R+/I0dNr+1T+9EPffht4cOx81Ab5hwEiDVgFY74Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032764; c=relaxed/simple;
	bh=IHWhm0ypEzcBvGDyUm4K1JjYYIMx3bn0SJkuhROzCdw=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J3odnje/8j6EyeQ1dKAqd51YlzOKurbONTs+zlINjVwJA2HfL6eA5wqpQ9sN8M7NGsTp/3xBF+9rLoDsKqD7eIA1sxpWZz/sNkBU8HzGR4Z96yR+mZl+MId8TSfMXb9RxJV7/8/FLu7YXT2EGhuRO8i9v92FuNPLGqWm4EpaviM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RMnioHyf; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RMnioHyf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSefyN1SR1+pgKThW/DMMRlL2ICmB8GXL/hlncFpDbQtkPGkEL4gF8X4wJbw6LPnFM4hGCrrLXY0q84dPt89XkQL8bB9ckYVoQF9yUIf8yMkiTOWPLzw81STcrytJeGRExtMRjxste5koWn3dQJ2DyAE0IKLxKURvQsO6YQIRfBR0XFYINzrx+kj9Hz0PtfxLIg7vtgkHN0z280EBFZXOkOxiDujQsdo/quR6Ff7gR9WAEtySCMu6Lt9euIq8JkSeHo06TVDhGvmwHeJLrQPNN9msT9WTJpu+VJZ5HETsr+p4ZCGH8Oz1zZHfdXGEyM8E22E8QzBn4+8oWfflkWiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHm5itsFC77XqjK14e4nX58EvT2LFqriATmGdVgBmwA=;
 b=QhYdJ5LiC6QSbgHXDp6lRaeggfvPo3EM79In64NfibfwA5DEkZa94xLRBpOUFKnvSS0xvxIKUiAIuw3gnslMq0S80lX1J3GeyY9X4UVV/6kVJaA1DVvFCOt44YniJEVQvDCLncJ6/kDPDXarpqtj3eGKCjiYzmy1v+l4jgHvdeEtvx4wMV4+kBOIPErtv/XRiI5K14wdjBehr7TXaoaGtXxTi96MvvnebCfq1mLMD/rO87cbvOurbX/prWU3qeWpqYEVsx47BabFZ/r21XrNnRlq6ee1MDcQMSli3L/t4+pP6cFf5Njh8rY63QlVx8Eiab6coDH2e2eO10m79k9G1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHm5itsFC77XqjK14e4nX58EvT2LFqriATmGdVgBmwA=;
 b=RMnioHyfRiyK+RvQ0ecBx+vE6Engn6BHRlynZmZQcQgAWjsb1op8eQs/nlpi/ep6u4t+2a/lgPSz5x/TtTErf037/EYwXcYcNt2SP1ZyrfZDBeBWcwidWCAbZK1lf31fb7xD0Mfz3WsN7VpmpyrlVPhO3tEjsWqXJPXbJ+G5CDvyjpvy7ZpUKkz02ID5gfT0QSVEiR8RtG0Bo+FDg+Vnv2ap7oZZ3FkIRk2AzaIsNAx1j9nyhC2gIp7fHt1BiqxRN/6cfZRbsH+i+ZXpi+MRp7ofXn+zCwBv87iQo3dowfB8enu1jB2PkdOZlwZ6R6QsCPshw4OrMVqD7D2XnXBLxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB7962.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 15:45:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 15:45:57 +0000
Message-ID: <8621f46e-1308-4cb3-bbeb-795c5c43cd58@siemens.com>
Date: Fri, 30 Aug 2024 17:45:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] linux-xenomai: x86: Enable IOMMU_SUPPORT
 and IRQ_REMAP
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Fabian.Scheler@siemens.com, xenomai@lists.linux.dev
References: <20240830125533.30195-1-Fabian.Scheler@siemens.com>
 <eddf3b21-f0bc-4a10-9361-6ea353554509@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <eddf3b21-f0bc-4a10-9361-6ea353554509@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0275.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac56697-1d10-47cf-091e-08dcc90ad70e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFVsbmVId2FSSUhBa0hNWFc4b3UzeVdvZWFpMzVtTXkzb1pxMW1rSkZBY0ZJ?=
 =?utf-8?B?SmRYU2RTT2c0eURSNU9Gd0lnL1FUeHp2UWsvMnROa1B5MDVHZzdGa2Zia2Nq?=
 =?utf-8?B?dUliWllTbHFhVUxCQ3lLQ0l6YXg5MG1md20zZ1d5U05mTHovaG9JN20rQTJj?=
 =?utf-8?B?VlZYUWN2cTR1VERqc3dtV3hkejh3OEpXMldJOVp4NmsvQklvS2xHWFQwOFYy?=
 =?utf-8?B?aXpiTUU3OFFxYWFLUXdmeWM2UGpEUUNWZFZqYUU3c0NSR0pDdE5EZTY3THB6?=
 =?utf-8?B?WmZWdXh0Y2s2OWZ0RmpQOFZjYnNaWVpxM01FZXZneFlNbE0xLzh1cTUxSUNl?=
 =?utf-8?B?VVhUQllENGU4S1JKWkFxdjZ2a05XRWw4cXg3SXlDVXRrOFpYUjBkQ0tvVzVB?=
 =?utf-8?B?dndRaWJWMTZnMkNDc3R2V0FKRmhxdTVnbnZRVDUyTzdTQjBvcnhiUFBRMkhB?=
 =?utf-8?B?Y0hkcFJPZTBPMGVRL3IrV0xjOTd3WkowVUtJWEJVc1JJSGYrZzJERUpSQWpT?=
 =?utf-8?B?VEhUdkhqSzVVdUFpaXZ6MVl5VFFUUUthdUg0Z1QxWlVyVitWdFNtTkdyNTl1?=
 =?utf-8?B?TVRKQ2h2SWFyRzRaZHBxanFrUmhFdTVUWWU3MDB2Qld3T2ZjRzQ1TmtWV09V?=
 =?utf-8?B?UmZHUlJQNGpaR1pCaW1seGszWjVQWGhaNE8rMWd2WExneTY3ek95ckQ1S1Rx?=
 =?utf-8?B?bzVBVU9IYmZuemJOUlZyTVkxenBNRXA5T2hrVnlUL29jTHJrRU1OclBYSE5R?=
 =?utf-8?B?QWt4dFpzQ0ptYkdIdHlHNy9DZTFWOXV2QldiNmpwV0g3OENpMnIrQ21jRERy?=
 =?utf-8?B?TlA0VUlTSWFmT1daKzZjRGhRVG9GTGZFYi80R2VCKzRRWGtyc0I2UE1uOERQ?=
 =?utf-8?B?Ui9SN3dXMmV3R3o2WUd3TXZMWkcwZHR0RjUvTkRWRjJVVFBVTTdhbXlIUFFW?=
 =?utf-8?B?NmdGTHR2eU5TeU5VY0VJZ1htR2NpK3NuQWRBOUxNU0s3UHhnMTVtYjkwZDJh?=
 =?utf-8?B?OWFlVXJUYXZ2UzUwS1JXanliTzdPSDVrSWRwc0RMYU1iOHYyVHBPR3JXZ1pJ?=
 =?utf-8?B?K2xpMWpEbiticGxHbzdCdlg1TjhJdXM2UFJTTnRFaS92SEd3ZE9KcmlscU5Z?=
 =?utf-8?B?SnRZYW0xTXhieE8ySkVTYmtFNEkxQmt3S0xNVWpSUzFuODdPSGdJampTTzVi?=
 =?utf-8?B?bDJjcFM0MGJoL2pJajIzNTRKTmNLYmhUQmVyeFRhckF4Zm1IaDNOUnZaWXJr?=
 =?utf-8?B?OWl1Z09ZTHFOUnpxNTdSWGp4aFdsaGRvK1kwem1GQ2FOYzdyNWUvYUk1YTlW?=
 =?utf-8?B?VGNVUnlURUJ2UVpEZllTZGNKQTBTOVEzMERHempCcFprUS9tRXF5ZXdweVlK?=
 =?utf-8?B?WHFwR2FVOFJFOTZQaGFMRjVQR0hrWVdTbUpOTWs0dzV2UnZCUUcxK0hiVGhv?=
 =?utf-8?B?aFEvaFJOd2xzaGZCbnlLcmZGTmE3SmZQZW9lTDVOUUl0dVBjcGhuSUdhc3lG?=
 =?utf-8?B?ZUhtYlpUUkdVYnBNeG80NC9mS3NjcmJOYld4R3orK3N1S1F0ZElzTzMzcEtV?=
 =?utf-8?B?TGE4TStrczZyQU14N0l3azVFbHBVNU1rODRaY2xEOGNyL0tSNlNTbUNKaE1X?=
 =?utf-8?B?bWt5RTlCS0xUVzhUUlJiRStwOVNndG9jMmJYQzhNZjZ3c1FtYXdzT2JrM05F?=
 =?utf-8?B?VDcra0FDUWVFR1VKR1dzVUNPdEMvNXhOYWpRdGRZT3IrRmpPYWRPdFpQcUNr?=
 =?utf-8?Q?KfinyodkYA9kl8FFe0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFlpRnh5R3V6ZjQrVGppb05YNWRUU3o4NHhzTitLczVzVHJ6YTd6NVJmSDg0?=
 =?utf-8?B?ZU5aTkdQNDI0ZE9QSG14Vkw0YUw0eXVLQ1k3SlZmZ0RWQ3JFMm00dkNEdys1?=
 =?utf-8?B?ZTBkS0E4cXRsM2VzcEN1dWhYNDAxbW9SOVFxS3JtdVozNVR4TkQzL0tYckxE?=
 =?utf-8?B?TDZYcjY3a3FrWUw3WGRGOGM5QmlnazBQLzN6WXVlQ3FBdXFZeVVXSThCM0VB?=
 =?utf-8?B?ZVRndGJUSjhHVXN4Q3hqdkpQVHRjMXNOYXBjVG4zSyt1aUNweXJ6SGJocmJW?=
 =?utf-8?B?WHh1dzFqK2hIQmhXc0I2Wkk0MlYxL2Vsejd5L0lyVU9tR0dzQW1uNFZTb3hi?=
 =?utf-8?B?bEpCemNxZkNqM1VHRDVHR2NUYkZEVUtsV2RsUGUvbEE0cG5HMTFaNG15K0Qy?=
 =?utf-8?B?VkpQVU9ndmxtRjRsSkMvRVVCb2Y0bTVCTC9QVmwyRk51NndkZU5yTVVqc0JF?=
 =?utf-8?B?ZC9MTjJOazVSanJ5UkZJOHZJamtvWUp2NzE1Zy9wZVNWQ2Qrek82QUdjREZi?=
 =?utf-8?B?UmIvWWdCR1JWZUNaVzdBUTN1aG9VRytlempidkowUVE4ODlWVVFiTmI1RWln?=
 =?utf-8?B?OEVSY0FMOHUzeWQvZXdVZmhESE90U0t2S0hvYkowT0s2Q2xRQWk3NXJJbmtL?=
 =?utf-8?B?Tm9RSEhuQjBjT1NNSTRFTGNCSDdzWTRXY0drMW5KZ2pGYWNLVXpSYmZSTCtl?=
 =?utf-8?B?V0tTb2tTZkFRQldWU0h2Y0Z1dW41NitlOWNhYUc4RHVXZHREbkI2QVBHcnQ4?=
 =?utf-8?B?ZlZUaDZaSzFjR0Q2WU14K1VOQktCL1ZMTjFYT1krSG55MEJaYTdOMHliQ0FN?=
 =?utf-8?B?S3FZb2hBcUhuaUZsd0w0TXF4Qmk1NDRvbjF2TUJ5ZmpIQ00yZThCaHdwODFX?=
 =?utf-8?B?dm1WT1BQVGRjQ05aZEU4U05GSGV6dFMvMGlMSUlkWnlJQnpJNjl0bDIvSGRl?=
 =?utf-8?B?RThLUkJ0dU14ZC9EVjM3eVBnLzdMN0xNR0hwY3YrVGppaUY5UWZSSktmaWNI?=
 =?utf-8?B?SHpPdXoraGkzRnRYa0RWeGNnRG1wdHozVVRObTVlK2E1d21TUjQ4MHFLeS9i?=
 =?utf-8?B?QjlteVFldGNkc0tQODJpUTZaUE1wUENSM0tpZ0VncWxGM0xTeXVLTHA0MlVO?=
 =?utf-8?B?QktUMjJtRjVrbzhXejRPTElsNWNOVjAvVTBFYlZQVjR3WmR1aXJDK2RvSEhE?=
 =?utf-8?B?ckcrOWZ6SlllZGllK3E1T1lEU2huclBkRnVmYUJ2bGxzU05qWmVHRFlrMWdu?=
 =?utf-8?B?THNwQUhRR05aZzdsaWp5VHlPa2pvdEcxZUFjN0RWV0xUK3ZyckloQ2FSWlB3?=
 =?utf-8?B?V1J4bW5NK1J0TFI0MWl2NmUyQVliZFN3TjJaVDBGTTMrUVlhT094TDd4WnBR?=
 =?utf-8?B?Smd2d3dYR0oxV1VHWUo3Wlowcm9NcU9jamdUdlFMMy9CdHlrSkpKWnZqeUo4?=
 =?utf-8?B?TmNZbCtUbUNEeXJrNjcrTVBKWEorZ0FVWkx4NThVNTJsVXlyazFEYlBqd0Vz?=
 =?utf-8?B?Y0haaktWRlF0T1g5emFIbGM4bkVYcys1RktiYzd6cW9WdEEvRzBnZmc3THBL?=
 =?utf-8?B?ZWU1ZU1RemN6clBYMzltR3FST3l6SVRtc3JtMTNtOW5wanVLWmpCUzE4eGR2?=
 =?utf-8?B?M0dIZVVUeVJoYzRBMVNUdzZCQlB2R1R3cVVZNm5oSnV2b2lNeEVDbngzeGIv?=
 =?utf-8?B?NVArWEpGQ0tKeUZBQWxtaTRDOXdUdUpCU3E4Qm9EMXA1a05sQWNFYWVjRU9M?=
 =?utf-8?B?dUk2R2dkQ0laYzVCbEtWQVdCcVpLRk5JSVFRU3BNMEJZTENGdUJ3M05Velpm?=
 =?utf-8?B?NWRRU3l5bWZIK0hTVjJya2xuZkVVb1NTS2VROWNHT0JRSUpKNFl4Z2x6ak9I?=
 =?utf-8?B?TDZDaXN0MmZQbVdORFkwZWlXVE1ZZWt1N1lOaVRyN3QxYUllTERPcGFKNjFo?=
 =?utf-8?B?UzlVeWVCdUw5WWkrTHVIbDBRQmlJK2dvdGdWM1M4YTIwSmYzbU1DWXBBRS9r?=
 =?utf-8?B?RmNldUd2bDNWTC9MUFNzTnhVdVRjTkVLNDFQQnpoeFM4aVlPQnZvdmt6b3NZ?=
 =?utf-8?B?TmZweWZSR0ZlVE5yK1B0NE5lS1hKTnhudkJKYXhTMjRWV1o4QjIzZkFuN0Iz?=
 =?utf-8?Q?s6tLmPR6SYXRN2MsajcR56hU8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac56697-1d10-47cf-091e-08dcc90ad70e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:45:57.5473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGmzMv9cuYcxYCkva5n5M3Rc/f3Dzr3TwByrXc87CQX/K07wcBY8zPEk8yTolEYMayx480ahfB4LlYLeykaWTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB7962

On 30.08.24 15:09, Jan Kiszka wrote:
> On 30.08.24 14:55, Fabian.Scheler@siemens.com wrote:
>> From: Fabian Scheler <Fabian.Scheler@siemens.com>
>>
>> Booting up the demo-image on an x86-testboard with IO-APIC failed due to these
>> missing options.
>>
>> Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
>> ---
>>  recipes-kernel/linux/files/amd64_defconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
>> index 4f58c34..a0a516f 100644
>> --- a/recipes-kernel/linux/files/amd64_defconfig
>> +++ b/recipes-kernel/linux/files/amd64_defconfig
>> @@ -3424,7 +3424,8 @@ CONFIG_CLKBLD_I8253=y
>>  CONFIG_MAILBOX=y
>>  CONFIG_PCC=y
>>  # CONFIG_ALTERA_MBOX is not set
>> -# CONFIG_IOMMU_SUPPORT is not set
>> +CONFIG_IOMMU_SUPPORT=y
>> +CONFIG_IRQ_REMAP=y
>>  
> 
> Thanks, applied.
> 

Looks like we still need more switches:

https://lava.xenomai.org/scheduler/job/15684

Jan

-- 
Siemens AG, Technology
Linux Expert Center

