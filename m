Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D25367B7E
	for <xenomai@lists.linux.dev>; Mon, 31 Aug 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187621; cv=fail; b=EemggTKvZP5VNOoFmBZYH65+sagUwWI5U8VPIrmFS7IJugVtbX5/Ljs1ajgAWnaBDriPkchay3shDuFiWkZ/jzKL3XAYN5wGAgUc5EFcMVoobts2BNTYGau933COFEUPTSu3nUWHoTlPUZ3+o2mj2Y41BK6ILEXllw+fuZkVbnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187621; c=relaxed/simple;
	bh=9rauGGoxsPLZ55YKpDM3iMVA3bcUlz1s4UAqeHVBSdY=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKobHMKxM111v+FZb8ZxF70BW4cqoTFWoAZwdTjAsc8qayALVmnRJro1csca6c6AovqKgG48Ld88zQK+iSfao8u/F4VNmyJ9bOS/OkhzGTj+/GW7oTXbXDclSnui+3fTKVNSdfECkLfOezd7O4DGcHyWDxZIZdulQZFWR4hnHIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=khGVlTWs; arc=fail smtp.client-ip=52.101.83.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="khGVlTWs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnbYbW9M88FNIkpJJ+0QuveB2hz/oQOCeNvpZnHp6u9vDDNzdaYgsLrTIZ0BMVaxsA6IU89rApSv47gxuJHZqXyLFNO0FSEtQxaFFWHSznqdkKe+LxiVVzW1lAB9RXYUlGD5P75F7MdA2SnnbCz7TOHl1oRoo9DtWnobW/NUwmn5J0tNaBGA/Gk1gOfnkl6XPgm6XaBjX7oqjDyR3tNzaFSLBWgAznjzk+CLNpij1TO3L9DOhlKrEPAAF2pjoFSHMxL2RdCGHRiWlGEFUkp5sCj/qoTDLA22AVjvjarM2Ms92oe7qMpcxXCAqOPmyzbU8nDvPEaIGZESccWSGRBbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vJ8Q73etirtC+XKSym94ZXN6Vn5KfbGO7D6ILHH/B0=;
 b=hD8QMgokkiwtAGx/84ocZk9ZkL3MscdAsUuzESxJb9O528ch8/FOOYys3FDfjd2BSLVhB1+++nlYMXSINiiOnnbjYn9FJBV0NDvbS5czpI/7j2P8HQKGRqnArZO8TC4K/v3wATL9rAuavr+ifQNE/8DQvmCcwdzbAaCJ0xIDygaWFvJYAYFtJiyCa4ojmo8/dvmXL4kOgj9BtJbUHjFzEPEh6776mQ8yFQv4Jk/nflCi+EzYlcQL3ijX3RvTlNJsSg9azVuXWszN6J1G4npzNqRKCIlKUH1YgswrY/bbKLY5bkD/7JusMqL00yHJT0FzoOwiC/DwkzbHOG9TJ5ZQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vJ8Q73etirtC+XKSym94ZXN6Vn5KfbGO7D6ILHH/B0=;
 b=khGVlTWsGi0qnWa3rPjaozT0EyFRy9GzCXQSajI9TRjfhLFMgy7lZp664684rVSPrgzMiizVVmLibatXREkxSWA+gXSGION3I+AxJ0jP8Tx675YIdt6YpH1xGN7Zw+gq0lucTzl0kYyXFF1TGWlo57g12NPJv97+4ImfqX3ILychM/QCRlkFwrnPuSX9EpFevsjosQ1EXF6pRxQ1SXg5IYZpUjENr7UxR2EZ10eWeQS+OH8wcM0cwERy2w6wzHI+AKsZCY0uf9xJgpSK591lJ/7uvuG0PVc14nHqYtBfhSaAsB6iHDzf7KCulyRwlLoosxuPg1yta6u8eiN8GQraFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:46:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:46:56 +0000
Message-ID: <8b652e16-9543-49a7-85b7-2472e2031c55@siemens.com>
Date: Mon, 31 Aug 2026 16:46:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: libevl: sched-quota test lacks success check
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
References: <86d6990a-349c-42f3-a054-494422298386@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <86d6990a-349c-42f3-a054-494422298386@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:530::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f4f618-92a1-4bff-e765-08df076eb36f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|11063799006|22082099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	y9zMdiVJkxpt5aUpLwoQ5znQmqUcrN+5VIH3GTy/3uy4Lu6JRDsdmtfMZkvpOyqNk+SotDNZG0sG3tDPzOJ9HBVTA2J437d0kCi2bWhIu3x8JO2Fv8M8mCFT7OunTlgOQkE1yTw2xUxrTBaqgA4tdcPAVKfeO0gCa4LJMgRVEuR/YSFjFyVrYXgJkWoZ+Glu6i23bzfm/ALszEMKAvzG9hmmFD444aOQ48e/yW2M688zd5weT7kgvv21MxhIcvD2/XuyWJIoyFygiI0iXcau2bw2Gnl7Yfh5qGkpXVBYyh/TlaTcvC5p9UWWHT8Ii6Wbi2qTVYTMTuRPVc5zGx0ROn0ovRQVK4nay80yC1LXakxDOxyY8Jdz1BCb9h/uGqmJ48lBRPpleiLVOl7XBSoJuR8Q3/qZ04EDafx05Ixn2koO++oHbilF3eO31KXqzdpQSgQAb+HH28ZpfycKXWBx5K0bqxbNPcpMeIAuAnp86hDdcOBi/0s2MaxpmzdQmbxus46WSFELR2qvjsfcz8ncUHSO5ucvS1IDfSTZsCA7HA7QBWAO4LE4fTejj3qCyk5mXBIJftakchg494pjD+dp/+ZK5gBdzE+6ZHsklwCp+iwTyShzkxYnRMQJ29Ruziug0jefOQAe+kFx90wn0VmVlEpBqYYIAJTA5SS4MLBJPpI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWZ5a3M4M1VlNlhWRzhyQ3M4Vm5RY1psLy92VlB3UUthVWt4ZytodFJCNGJt?=
 =?utf-8?B?bWlKQ2ZzckplN2hTOHVvdlpPR1U5cXNKM014cm93VWRIVzd0UTV0T1lWUG5j?=
 =?utf-8?B?ak92VE1rV2JxQjFUdDZseXdwWThrbDVjaUxkbXJGQmRVMHREUEtjN2R4Q2VT?=
 =?utf-8?B?djVuTUtNNDJJSVVqaXR6RzNqclorcmg0N09wT3NaL0EremdvRm1mbkZuYkty?=
 =?utf-8?B?d1gzbEtQOFQ1Q0ZJMjdkUm1ad3QvNlJQclRZY3lFeE5SR3hieDhIN0VFc1lQ?=
 =?utf-8?B?QXh3WUladURqcG41MVNYS1NEeHhTdS9vbXJlKzhMejZZclVMTHNIdElSeTk1?=
 =?utf-8?B?d010c0VDdW9Jc3diQ2llOU5WTGQ0TngzN1VWVXNxQW9YV09BcTlycEt4ZXRZ?=
 =?utf-8?B?VGYybUZzMGJNcHpMNzhWWjhzRDdneUtSUXFJTS9jRDUrK2ExT2hCRm1hYUtw?=
 =?utf-8?B?bFo4clpRQzVobjlma3dVbEFyTGFVYUpPM1A0Snlpa1FlMUZKdURnd1FhK2pD?=
 =?utf-8?B?bGsxdnJ3Y1V4ZHI5L2RXaVBWWld1TUlHNVRBNzgyancrM1lNblpPZkZ4TldS?=
 =?utf-8?B?Yk1ocWpOWlI4YlZKZUI1dkFWUnkvZU1tZVE4dEdZZmJxSWRVMzBiM1hhQzNI?=
 =?utf-8?B?cFhQZU1UeC9CelNiKzlERlRZVEJpY0NFL2VpaG1XYWN3a2VUU0JieWFQZWx1?=
 =?utf-8?B?bnpYOHBmM2NmS0EzL3FycHhQVUorVHd4VnltNVdscXl1bVA2SFNHMWJZWlk3?=
 =?utf-8?B?ajkwUk9CM3JGam40bWZ3cW5pbGtnNUxPSjYrQnlTUXVEMS9nMzkwdWpMQlVK?=
 =?utf-8?B?VVZ4Zm1oWDZOZy9kaDJuenZ5c25UdWdORjJVUGl6S3plUVFTSWRFTkcrUkdQ?=
 =?utf-8?B?bi83L3VyVmJkZk43ZlZIdlBjTmlIZHVxN3p1bitDQlk1ZXVqZkM3U01kUE15?=
 =?utf-8?B?V3JBdldFSGRKMGRnUVJvakM4Y0R3VlZPVGVCa3c3V2QvMTBJOFRkMXVlTVlG?=
 =?utf-8?B?QllzeTZBL1UrWDFCOFNjWTBCSlB6dE8vNHJUTzJJQW1hTDhRMnFZWEI2VzlZ?=
 =?utf-8?B?QU1sSm1QSUdOV1ZFRmxTN2NlTVcvK1ArNmFNN0lYbHNsRlZ0bmVKOVV1Rld5?=
 =?utf-8?B?Sy85RTdMSFRmSU9BRVNSbUdRQ2d1MmUvT1I2SDdVRkxJL2VENmRkM2ZNdE0x?=
 =?utf-8?B?T1BOSWhDRnc0UlZKdXZyQTEzY24ydFFheVB6SklSUldiNE9jRTFiU20xZ3di?=
 =?utf-8?B?NnBPdTNHZCtxWk5RUGdmb1hSN3VCeWhZYlJwdEFTaWtYSHFoQVAraC9wR1hS?=
 =?utf-8?B?K0Zrb0c4bDd0cWNUSSt6OCszcit1WUVQVU54K1ZuRDZrYzREeGF4U1lCUUll?=
 =?utf-8?B?SU1GS09xSjVUNm4vWUNEQWlxOVV5L0xVTUw5eTVnbktEVGdmeGhpVEE1WlE5?=
 =?utf-8?B?Z3M3VHNsVFFvc3B0amZKcyttRTZ5UUcxbmpaNG1vWlhxbzRRY1NrM0R6NGhp?=
 =?utf-8?B?YjlVS0FUMWhDdzFIUFpTb2ErcUdtc0JGT1o5bWlTVkkzSnBqYXZXMkphVDJO?=
 =?utf-8?B?WDN0MDlCQUtxWEg5Y3hzQVRLTHFXclM1NkpPR3BQZXdUMGpKblJKVXdSbTNE?=
 =?utf-8?B?dWprbXhmcURPQkpFSC9OWlJiaWp5Q2NZVGJ3SE1Cam54RTlJcUxjMW9kNlNs?=
 =?utf-8?B?VUVQMXU2aXJMNkRONlpBZnAwc2hBdFFkajMreTh2N1h4Z2g0SC9aUmxCekdG?=
 =?utf-8?B?VmZpc3FPUTljcWNrRTZpeEJRNkFMWitDS2FTM3VmRVVvc2lEWSt2cXRDTW5s?=
 =?utf-8?B?ZmJ6MEx2UnRPeXFPK0lsQ2pHYzBxQ0R4WDVzY0xOTk1zcmkySitya2JTMERv?=
 =?utf-8?B?MFA0ZlFHUEZVNnlKMGJkdUhFOFQ2c1o3MTlqQnpKT1ZsSk9kU0dBbWI0Y3lq?=
 =?utf-8?B?ZUVqTFNKdVp4dTRMNndWY29tdEN1SFlmT016MDVvYXhCUDZKTXg4OU5YOHBt?=
 =?utf-8?B?TXIrZENGZm9ZKzFhR0NoOGhvRm15bE1KY2luUHlFY29SeDd1UHhBb05qTHNE?=
 =?utf-8?B?VnJYY20xQkZsdHRHZlVna1hxcVAvS0JQVmNDci9YeHl5aktrTGlvcFdBaWg2?=
 =?utf-8?B?V1Qvdm9nb3d4Y3dOWTFldExWcXVmbVdhRURiRkhjRWVBRW1ZcTIyWTkvRGti?=
 =?utf-8?B?dmxTODRhbllWbU5VbmpyRnlGd3kvdnEvbGpuQjdIaDRkZDdnWkF4K09mZ1VC?=
 =?utf-8?B?ejFMQnFYcE5aS3pEcUdnVXpRM2c0WU1GTWNiZlJ6Smt6RWYwQVVvL1hVZXZS?=
 =?utf-8?B?MHZMNWc4SnpOY3RPS21BR3hDbEsrb3RwYWhMM0dlVDkyc3BMMDVXbnBEZTg4?=
 =?utf-8?Q?7IgzZdfU8nUSbmHI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f4f618-92a1-4bff-e765-08df076eb36f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:46:56.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJgc38/rydyG3x5TXa89dXGf8CF0tBVbD47u9Dl95e4OQ/GPmKZru7Q3itTsv76q0X/KhYt+1lLqzfyzriKMTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7321

On 31.08.26 14:48, Jan Kiszka wrote:
> Hi Philippe,
> 
> trying to port the sched-quota fixes back to xenomai 3, I had a look at
> again at the libevl test. And since [1], it always succeeds (unless some
> function returns an error), no more checking of percentage boundaries.
> That's not helpful for CI, though. Would it make sense to re-introduce
> this, just with an exception for VM hosts? That what we do in xenomai3.
> 

But first of all, we need to fix the reworked calibration of this test -
it happens already under quota conditions... Patch under preparation.

Jan

> Jan
> 
> [1]
> https://gitlab.com/Xenomai/xenomai4/libevl/-/commit/22ed65d951dd49b159e52c498dda49b2492138f7
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
