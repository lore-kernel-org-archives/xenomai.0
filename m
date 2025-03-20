Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC1188915
	for <xenomai@lists.linux.dev>; Thu, 20 Mar 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490286; cv=fail; b=gcXyu1zi57qYcez+fFRhmqHOrGIzT5BNdQgTqwQ9A9tmtktpUF0+neVGPjHZqHxb/6XBTrMAEE8aWH2rWU7cS6PVVzT20ANZ1lQloSZoXpJTmNoZSKsAZq5o2Oc1shbtwd7vwT9XAUnYT7fEBCcGQ6Ac6NySwINQKi9X3akXH1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490286; c=relaxed/simple;
	bh=jeOIVbiRuamqxGc4UQ5/cgXiag6MCEy/eY1NcblDLTM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g3rmdidFvXlCBrtQkI4czYnDK+CUz0mIhy+MUaUNYNrnyZU3kiafiYsNKeZKZAkN4dO9l5PEw3BGGFGpFnh8QkGNKIPY6gUojlwvjnw9+gBU1CUiY3GuASTnukBqd1XAxJ+Q0sZ0LA9GjsrwpR/P/QLhErNaO2YiF/YvhYooPAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=u8kyddWK; arc=fail smtp.client-ip=40.107.249.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="u8kyddWK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8Bxt6rR5xMGKoXi9R0w4KUlN3m6FKSrTVhowDOflxJrmLIKCccThLwnEf/NTOe7PcOqrY5AnZ2dDlWs+q3SUBZG+HdYxewXbZkWzT8ibPCfwkZJDZHsgDnyIQw4Isd/TTz8a30aGpG1QqhtevfoD6RWpLH69GRK0PkPQRfvvOwcI69arWd9UuUqYst7XUHvH407VdkyjLOT5ab73ynjphFf5Ldms02nNmh5ch8EvBp5MwvTOdrnWiZ/GHzVP4TzTieJb2FjWAsNs4MMQumuUpbUlXPPRmrcNlUsEydhtodGZtc/nPf/FuKFAwkEj3o4SkfijsZekEgoRwHobhGceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u04DJgukrQv0JSyzEZ1TVtaJFb2+k+WVYenL6XNTQfU=;
 b=D6rASUNHUkY8n5kTxNRGfpkdWJO5KO3LV73udgMMRnorxEV+4NZQPpwLz9+NPOJUYMO238DdZDgun+XzpC3jQNiYOglrdDrhmTNEC+jwJE6psUx4XQjrvUgmg5vJveXTB8hyokbialXdTv5i5hStMZNc/97OHz6oweANwh1FF2rEPkyH7snuGd2QuyKMiT/XQlqy3+ZMkxn7OxqxcDfGs12DiLxsP3rL+yahiK3iOa+an0cH/hOnWHn5zfGBuOs+4idzU4qJfDLjyScqBdCCkKLZvuKf2Qj3O+R/ufDqUQ0HqY06fiDEWlIefYdJXQ1c221iC9ikuI+1gVOjLaIgjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u04DJgukrQv0JSyzEZ1TVtaJFb2+k+WVYenL6XNTQfU=;
 b=u8kyddWKY3zlSJVSFFSCwZ0O2UwJGCfdWrNtjslwF8CLWVGduLBENUqxt8LDwFslr8Nbh6iadVu35MNrGxFd8pxAb77N9G45wLVSvxdbSEYJmZ/aW/leGpZNfNiJRL0izjs/rbdqg66wgY8ZNUTTpnRhyj7Ox9UgUDuv8t1hb6xBeaD8bP752KyPqfHNnvY6fndrCZQHI2DwWKbUKzE4AS7AyP+WcgoZkhij/ru0DQMVsKM4INewhxSlmvGobnPDKTqhpaJDHgYE6Tsf6vm6o6EcOrHgndiMtGoC+JijEgBsVx7mIEhFvhswiEZYyUVeTjkEZC4ONBDMMu/8aCfGXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7413.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 17:04:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 17:04:41 +0000
Message-ID: <e6cfc82a-1b3a-4dc3-b390-8c01728c2ed0@siemens.com>
Date: Thu, 20 Mar 2025 18:04:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
 <174dbca228b4005ac65239f3dccce36f40cd1c0d.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <174dbca228b4005ac65239f3dccce36f40cd1c0d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: e8256217-4286-42c1-7038-08dd67d14dc8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekhzNlVtUWY3RHNYZm0ySjdpb2hCeFVwMUJYK3lUNklTWFlHVDI3QVkxdG92?=
 =?utf-8?B?UmJJRGNzZDFpd21mNis0bmI3c253MFh3dUFUVnJlRTFQU2lvRU1TZjJielpG?=
 =?utf-8?B?ekNEa3kvUFB6eVZrZE83Q3BOV2xVUFZqZGlBVTQzQUdCZjIyWklsTlpkS2Vj?=
 =?utf-8?B?K2dKRTJoWENERTNtbCtmRFUweHJIRDRHUCtDcnVsaDRCcG9PWTFvc3gyYnJG?=
 =?utf-8?B?Vk9EUU1NeHdycENYNE9BVEdwRGJNelM3alh4KzZJTGNSOFRVZlpKYmZTZHVC?=
 =?utf-8?B?L0ZSQmdhc0ZYU3VaL1RyN29DbUFhamllaHZubzdVUjdPclVrU0MySmt5aEFm?=
 =?utf-8?B?clJyaEpkUERiMTV6TFgvcElCOFdMbUlpcjlEMGJkNzJpRWdNRVlFS2RKMHQ1?=
 =?utf-8?B?UkJHc2FtTUorajJIYjFsM1lCcTh5aWpwVFBWQllIL1FvUFI1eWxEaHNkeXZV?=
 =?utf-8?B?dE9LL1lsTUJ6cVpualI2NVJkcm9GZXlQVmtBQTBoNWRnT2JObHkveTkwSFlS?=
 =?utf-8?B?czJQbjhITkhkTzJuNGxEVEQ1blR3REpVRTFlNFFWNVhoeDJWZ2ZvbG8vMG0v?=
 =?utf-8?B?RDlDcHVJbWsvMHZLY0hEZHQ2UElCQ3JqMUZxdHpLNXdjT1R5Mlh6UUZSY3RM?=
 =?utf-8?B?YWpBTWZuMzIwWkdxNEdJVG04RkRYL0o5RE9DTXFOOU1XbEoyVDZpdHNWV3dD?=
 =?utf-8?B?aExoY2RmeW1LWGxQREpkcmZWVkNNM1puY2ZaRG1zTnlJQWYzTERjcWpkSkIr?=
 =?utf-8?B?clpFRzZmQkRBbVdFTjVvVWpBSHdBR2Z5b0gxK1RTRWcvRDdvV3hFQzB1L0Fw?=
 =?utf-8?B?U25RVWo1YVZuQi9Yc0VXNzNtVm42dWh4N05SN05KWjZmSnhYZkJDbVBvR0hm?=
 =?utf-8?B?U2lPVTFFUUtLakk5dHZaYUl5ZndxVE81RHZnOG9RaEdjLy81WTJqMzlkZ05t?=
 =?utf-8?B?T3BLdjRhN2hlKzZ3VTlWZ2ZIRjJIZlQxbkpSOTgzUk15M1FvSFVZQmYrK3lp?=
 =?utf-8?B?U3UxZWJibXorWXorckZaSFk5TDlXUWkwck4xOHJhMXZ0Uk9FNU9iTEZEd3Jl?=
 =?utf-8?B?bnRyTGdDZ21hUUh2T2xGbUVmQ3Vab01ReVd2VTQ5OC9jOGdldGpab1VPVGlR?=
 =?utf-8?B?N0xld0pZaVE2TkRZaVJIU25GTnJuUTdBbXV4WDJ2K3I2T2xNcjBjdW5NbU45?=
 =?utf-8?B?WlhyTkc5Ylp4M0NjNVkrZXhqS1NVUHNwUm8rQnNYZmRjMmRrNjhZVDJsenUx?=
 =?utf-8?B?d3RxZGdhRmx6RFlNWjNvbm9LMUtydU9ZRWdRS1hNZnFwSGVWdXFZZVhRM2dJ?=
 =?utf-8?B?TFdTdk9zekVFT3R0bXVMUThkdE1ndjl4RWQ1TWllU1RYYVlkTlM2WkxBcE9H?=
 =?utf-8?B?QUFnZVozcWF1Zlc4cHhvWUxjczI0TjZlejlxNHhvMGNsUENzSE9KRWlJM0ZD?=
 =?utf-8?B?QzV5QUdvYUYxZFExUXZpNDhLTmVBTml2RGJCQVRlYzRmeTF3dDVvUDByNEkw?=
 =?utf-8?B?OUtYazE5WFFLU2Ura0t0K3BQS1J3SmF1VUNuTEdPR0VXa0NzY29RT2JqNnJm?=
 =?utf-8?B?MzcrWjIyTnFGZVNpR1NlTlUwRzdYRTVVOEdHVFpEQ2pVVXFVYXo2aEtjRUVJ?=
 =?utf-8?B?YU1vb0hjRldpV1FTWmJGSmNJZ2liSlRZNFJaQjBycHlkUEpNU0dZZVNtT0JM?=
 =?utf-8?B?NVV3RWdsaU55SXdNVmd2T3EzNUg5aU5Ka2pDZFo3akptK29xc2szTWpHTXJl?=
 =?utf-8?B?R3E0Y1k0WTZUNFRvaWtWUjNNeUFzVFdwVWd4ZVpFZVNTeG9ud1ZNdDdNWDV0?=
 =?utf-8?B?SHFidE4zM1JsSThYdU9xODVWdExZRzlpNkZPczl0SEw1Q2pvNE1MN2lEZVFl?=
 =?utf-8?Q?aI0ALojNKV9nY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXVhZVh1ckdrYnhTNktSRFB3V0FwV09aZlpCT2FuaHkyVFJqd1ZJY3RhK2hF?=
 =?utf-8?B?ck9hMXJiaXpyNno3dDhnRURreGlTS2JMd2NnMGRTU2VnbDNQaFQwWVk4MTkx?=
 =?utf-8?B?NUpDclpIelJlbGdpdlplSjBWOGJQVCt2RmJKbFBEK2pVRnJZa1R6M016c0VJ?=
 =?utf-8?B?VWx6YTJjdjhtSFNzRjNlcytHclAwOWMrNDRGNXVQeGNFMFZqVnN4bzh3eFdT?=
 =?utf-8?B?T1pvck5Bb29IcFE3Y1pEa1FORXMvenl3SVh0eTkvUWRXZlJKMGU1MnFlRkRQ?=
 =?utf-8?B?VmNtSDVYSkNwVStZdGY3K0hHYmN6c05PbVVadnNGcGJNdVRIVmhDZXRrd3Jo?=
 =?utf-8?B?RVozRVZERmRrTG1GcVR2L3p2M1E1anFldnhkUGdUNWRlckcrTlNveUs0SGcr?=
 =?utf-8?B?YUIvWUxXZ0VZc0NJOW0yR1ZaWjl0QUg1bVhrTllKQjk5SFV4K04rUHJsUUtX?=
 =?utf-8?B?UTRyR0NVemdyaEVQMTBzZEh0cUZCLzlzM1hiVEcyRitVcUVNMlZQOXJMYUVN?=
 =?utf-8?B?dEk1MytSdkRsVDJtc2drdldRRG9aSVA5QkJzM3R6eFNacGZYOG56dTRjd2JX?=
 =?utf-8?B?bURLMGM0THIrYjlmMlN4OEp1Uis5cXJiN0RHdVdoZ0trRGNiazRUM2lXVGgr?=
 =?utf-8?B?alF3NEdQWUc0UTh1b0N0eGNGL21JOTN0SlVORkNQMS95dFEyNWhnNlVMbktk?=
 =?utf-8?B?QzAwZTg1MHlMZytMWEFoaDZKRnVta1dWK2N4MjY0a2hqZVFvM1l1RnFyOWh4?=
 =?utf-8?B?NjZFZENKRTFDTUoyRjY3LzcxUGF3dWU4U1ROenkvdWhDZkhkSGttek5pWjV6?=
 =?utf-8?B?alNjWDY2Z1RybkhvV2RHamxOYmpwT2lkSDV5cGZJeG1hTGpXS1gzbGd1Z0Qy?=
 =?utf-8?B?Skh5ZWxRY1VJVHZrMk0ydTRKV29OZHRJRC83Ynk1UGhBV3RTRERJVFRBNXF5?=
 =?utf-8?B?QVVRaWNPRmNGeldUTjZEaHpLZER1Y3BLOVNkdDJJcS9OU21IbVJqak81YjJ2?=
 =?utf-8?B?dUludXdsVktlT3kvUE10S1VVVVdwdlFFQXlFT29KY1FkcVozQTN1cDhkUVhB?=
 =?utf-8?B?ZWR1VVo3Z3k3cysrUVl3UzFVS2c4cmRaMnBldk03Tk1QRUNsdzVhazd5YXJo?=
 =?utf-8?B?TlQ2a3R1QUhHNWVlVXZZaC9uRnZwUU8zeXRUT0lwK3dXYTRYUkhra2pqOGVh?=
 =?utf-8?B?a0VkMmFLUG00VlFqL2cvY2M1TjNvczdoS050WWJPMTRIOCt5T2NBV1VuaEhH?=
 =?utf-8?B?YlhmejB6YmkxS0NHcklMMnFDZlF3ZlRBOWtvclViNGNaNHlxKzU5VGszK0U4?=
 =?utf-8?B?OVdpVW9tdS81Rk1OWDJRclZKTDZCWW1QNUVTRm1PT0VIVG0vdDBIZ1ZndWNT?=
 =?utf-8?B?cTV0SFB5NVZPVU1jRnd6b010N0NRL3U1Tmp0bmRUNjlHbzRMV1BSYVJXN0hp?=
 =?utf-8?B?WFhUeDdsOGZXRXRIakR0QzZFYmZCemErRThzV21qUHMyY05kSjBHcXVMMUZ2?=
 =?utf-8?B?a2kyNGdzOVhIY1hqc2laOHFWU3pHd1RNMkFEY1d6VCtpdjA5cVNVTE5IbVdu?=
 =?utf-8?B?aUh1OU9KZHJvZ0VHM3JrYkk0bHA0bk9UNVV0OW9nUkNpY3lwYTJiUU1XV3Vm?=
 =?utf-8?B?SHVldnhOamVTR0ZWK08rOE9wNGN2VldZTm9IUDlma0hTN3NZR3VRU01aWFNT?=
 =?utf-8?B?UnRiTEVhZDVFRDBkeEtMbEk3OGJFdlZEY0NJUkZrUnVnbkVYeFIzZmU1bFY2?=
 =?utf-8?B?RFhZVkpvd0FwelprRnhrVTFnUldBVGw0aXY4TUN4dDVZb3ZoSU05YUtxczVi?=
 =?utf-8?B?WlpXb2Q0Q01SUlkvK004YkhwZGoxRmpKc29DZlpiNVoyWUt4N1hLVkRJeWtG?=
 =?utf-8?B?RzQ2N0kxNE1zUFlPMFdZME95RFBXc3hEOHVnb2hVaDZNVzNpMVJRalJQbjB5?=
 =?utf-8?B?OWhUMWI3VDZpYW9ZMDE4YU5qWkhkb0FlaW9VN09lZVAzUEIzMi8xeGpWMGFa?=
 =?utf-8?B?d3JKa01yM05iS3VQMm5sSFExMVl3WHhGZnQwendzL0lJVlNFYVAraUdNaStw?=
 =?utf-8?B?MXJOcFkvSTNVQ2ttdnBDOUozWXBjUDBXdGM3MitZQlovN1F5QmxmbzJKL1du?=
 =?utf-8?B?aExuQlBaWE9ialJTYTRTZ1dpOHhHeFFiWWZUcDBVU29NNmJON1dDcEk2T3Mw?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8256217-4286-42c1-7038-08dd67d14dc8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:04:40.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SX9EpA21qfSu7OXM/uSy9vVRUNIkfueF7bX4Hn4+WGwI1K+BcZMknCipstu/Ag35TjjuVanuT9wTomIINWd90w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7413

On 20.03.25 17:50, Florian Bezdeka wrote:
> On Thu, 2025-03-20 at 17:41 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> We had unbalanced hard_cond_local_irq_disable here so far.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Minus one hunk that is already in current 6.12.y, this needs to be 
>> applied to older stable versions as well.
> 
> How was that tested? I think up to now nobody really cared about
> hibernation... Will that really work now when I try to test that or
> will I run into (other) problems?
> 

This was not tested yet, but the affected code is patched since an
eternity. If we don't want to support this anymore, we must remove the
changes AND declare CONFIG_HIBERNATION incompatible to
CONFIG_IRQ_PIPELINE instead.

Jan

> 
>>
>>  kernel/power/hibernate.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index 733b1a196f09e..e1c05f276a453 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -352,6 +352,7 @@ static int create_image(int platform_mode)
>>  	syscore_resume();
>>  
>>   Enable_irqs:
>> +	hard_cond_local_irq_enable();
>>  	system_state = SYSTEM_RUNNING;
>>  	local_irq_enable();
>>  
>> @@ -522,6 +523,7 @@ static int resume_target_kernel(bool platform_mode)
>>  	syscore_resume();
>>  
>>   Enable_irqs:
>> +	hard_cond_local_irq_enable();
>>  	system_state = SYSTEM_RUNNING;
>>  	local_irq_enable();
>>  
>> @@ -628,6 +630,7 @@ int hibernation_platform_enter(void)
>>   Power_up:
>>  	syscore_resume();
>>   Enable_irqs:
>> +	hard_cond_local_irq_enable();
>>  	system_state = SYSTEM_RUNNING;
>>  	local_irq_enable();
>>  
>> -- 
>> 2.43.0
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
