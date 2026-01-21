Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0143D6462
	for <xenomai@lists.linux.dev>; Wed, 21 Jan 2026 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981666; cv=fail; b=IgXEPrPtHPUXNvGk7Lw48Xl1D5OAa32/um/lMftS8nHqalD9M6it3iXTmxz6pP7rJUXb0lGxkXNbKJQHWbaTiJUv/0L5zBTN/NgNyUviPvJ+xqIoCf+6wO6e80mcEWgtTbhv4fLuU/7vlRMt7heu5ON5NHAOHwm8wOqP+86YX70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981666; c=relaxed/simple;
	bh=vhFKmz3pXTTkcgmEfxYC9BkM6fkUI0padKWYsCSisjA=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=jgCGxTCe68Iw4QRVa6xFWy/Tx1aBaRHWwMXmQW9wncZYLiJE7WZOUPc0S+ji5THYlMVRbrSJLvz/zdg2gaSvLQ6bJPa5srYkl7dzRZ7c/PXKO27mfNbOddptCpPhL0HIWchR8N3IO8wW0sanuNxaHoZzoiJp2AUnFSbKNrzBgew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kyWmhUN+; arc=fail smtp.client-ip=40.107.162.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kyWmhUN+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfFk7G+tn0E8hCJt3AHb/RTkSgqxjlm8Sw4H6zRupSz4+3k+66AkoqCxms8E7ZTvwzciEjWwjhzP3t7Wm3zoZIcbijCO8X90yaGFMBUS/cJfGpvTePkk1p7fGRch2ghgPl1FI0+2caftjK6mCqJSoDWZ9Q4ktsbjmtOCapdQ8byi0kL+ye0/DhSpbXGmlf5qYqqFnf7EHg/OM9qjNYJS6cXUNr04jpOPnrjaMPWdd0itGYjwwzeLfqLfsYzQDkrfC6LypsDSLzFRSf2/5NCeDtYbIel5ZYR4o2ZQes59ksuNEt1fuBn28akulaYU1bT+pC77AELYdQKfTygGJlcHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErSO23qrynz4pH8msJBqbRDRKAK6E+QhmSa1l/gj4c0=;
 b=nsWPUF6r12Cqvyyvjgd6VmLqKKJl0U8GdaWYtFW67VxZxhHWbSLY4oiXao0T9+g5vvkVQbdduZR+PIKeAkzSEqsWFzRFZ1X5793xk95t3wG107kREJaIVetU9W1452X3bbRUfzcd7Rb/3WRn3UYNTlbwq9MC6uste6AmqyQ2xlc1v9o7jMMrMFQ9406fPx168aOIuiwRqAtN3fAt6V5EZVL451MJAdgM7GAq+QPvCrUdDfpAN4ghf4RvXeFbdX5SDdsdwj3k17stIAb9M/hC79+UhULvIeoEG8Sg5lwbZRiQjTkQFA7R0yLA4RETHwttYvWkSDoQM6skYVkxPktNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErSO23qrynz4pH8msJBqbRDRKAK6E+QhmSa1l/gj4c0=;
 b=kyWmhUN+asVbJGPb5pOvuWZ0CoGUTDW1/ViMMiQTl6gTy1h1n7ctQ0J1TdjOpkQlnF5bReOvto3LhCU0Xkgqyvp9Ce2qZlKVnj9u9I4skNe0WRYINkkcmklHjO2f9Zom4h1zjyiH+xUcrD1CpGgchNJk0bSWNPf72hShpDpK35RKa1cG2QuJSq2QPuPbNt/i7cUd1RpmxhGgqzDx/qiLPuGY5uO/YKcwDE6I5kRMFROVjMBmPmAvkh1EB8PhfYJV+p7Nlq0pMRVtE4D5DiQJ4M03u5XlU0cJaWP+k7oleglA2HI+Z5gn0vi4ndKLbx87GM9dE+jXmiVDEeWgtDHI+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8232.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 07:47:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 07:47:41 +0000
Message-ID: <dce6da1a-7ebc-4d5e-af4a-bf55142a95cd@siemens.com>
Date: Wed, 21 Jan 2026 08:47:40 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: Meet & greet at FOSDEM
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd8c4cf-6fda-4cc0-9078-08de58c15ae4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk5VRlI5dWhSUHRYclo3Ujd5QSsyb29pZjg4L3NGaUFKT2tFUzFkV2lzREFx?=
 =?utf-8?B?ZUozQ3JUUGthOTJoQUtOcHE5bHhaMXJDckVIdXIyRkwvSVYyNDhjdHNlZllS?=
 =?utf-8?B?ZnZHaDRkWC9QUWVCMmJNbGZWc1BQeVVzeDNuS1pwK0hidFhNbGQ3SHhaaXNU?=
 =?utf-8?B?ck9uZXZwR1lHT2VQQ3NxenBJQk9YbFRXQ25KZzE2ajJrZ3dCWG9nUDlmQXNW?=
 =?utf-8?B?NG9ob2Y4YkE4UnFxZHVKaE5Xc2tDdDdGQ1htdVBNc25qNzZYVDVPRFI5QUU1?=
 =?utf-8?B?SkppZENGR0poMHhZcmM1VEpqWnFKRXVNaldXZ05IUy9kVEtodEdXV2xuODZS?=
 =?utf-8?B?NGJabXB4UFZWdXJzVlJHWHBZSC9HNWlreFgrZFIrV2w3dmxCWW5nOU9uMENW?=
 =?utf-8?B?eXJ0c3VDNVpRczZKcytHamtLam1WSUFMb2VqUXl4QStQU1h5dVRoZUcrTU42?=
 =?utf-8?B?TVNPOU5YQnVOR2dVREI2Y2JkMWVHanU4Q25tNitDOGFpRjJZY0VTdURwZGgx?=
 =?utf-8?B?U0kxUTRzUFIwZy96QXF3ZnE2OEJieC9VNkg2UnFkczdlNnNRM3JuR0xSTFF2?=
 =?utf-8?B?WldRMU1HS05sT3VZREYxa1J3QWpTb0VTb2FEYUdmMWNGM3pMM3lSMTRGZm0r?=
 =?utf-8?B?bW5Td2dOOFYxT2tPWk9tdktYMGJVQ2tsb0cvNlcrWlRWdkRDVDlZTlNhWXI4?=
 =?utf-8?B?cXEwTWRnUEFXeE5jb092U0paWmVuUlpqS2tjcEp6L3hla2RETTRtaUdxOUI0?=
 =?utf-8?B?OGdMWnZTYXdmQ01sUlBKZ0hLc3R3eEVMaitJRDFVQzdLMlRrYWp6V05RZTY0?=
 =?utf-8?B?T1luZ1h4cnhzRE9YeWg4b2dxY3NiRWxjWHNsOWNPZHFoMGVVZnk4UW5zWkxi?=
 =?utf-8?B?SGJkcGVyVDZxQ1N4U0I4cWY3N2k4dVdHSC9LT0IrRURtRzB6YVdWMWZ0THZy?=
 =?utf-8?B?ZWI0OFQ1YTF1Si82VXBsd3ByRHNkZXN6Qnp6VUpEcDV0L3NyK3d3L0xrZzZC?=
 =?utf-8?B?YlhLUGN3bVR5emJnVGMxdldLTW5UUE42WjNnYWRWOXNMVTB3MHFJdStBcllJ?=
 =?utf-8?B?RzI0bmlUdFFhTVJsUlNpbGVJSzVaOFZTZkViTjJNQlJZdDNCMmhZdHNKUHpP?=
 =?utf-8?B?c1N1THZ5c1hHN3VJN29hdWEwcjhqa1FnczEvTFlVL3NKR29CR3JmQWZuYW1P?=
 =?utf-8?B?M2kwaE9BajFWMldDcU9mQXdZNmpHZk9iOHdCc004TjBxNzZvdGJyS29JNWhM?=
 =?utf-8?B?T01xUEZkNGZpL3ZFSDJoM0RVRTBqSktjNHdxei92U2ZjamgySG96bHo1dXVK?=
 =?utf-8?B?Qjgwc1NYcjJYdVpxWGNJck1YMTRHNGF1R3JLa2VjL1RpWVNodXFEZ2RLNmFy?=
 =?utf-8?B?a0owUnZ1Nk5ScjdsSnd1KzVMNU1XZjB5N2VXQzVqUk4ybnRod1NNbDArSzZK?=
 =?utf-8?B?L3ZEY3Y3L0tZaG4vMnhURmZUaGdxTjhjMGVrNThSNGsvV3A3aS9JN3pJVlk5?=
 =?utf-8?B?ZWlNZ0RBaUxiL2NLenI5MGMxRmEzd21xRlQvZkc3NmRRdzEyczM5SDM1WUR1?=
 =?utf-8?B?emlHUzJROCt3YWZpdE9Ea0NCcDlJb1BXaS9DVTJKdytjMDlFVllHQWlGNDU0?=
 =?utf-8?B?aHF5ckpQYVIwRytud0hrQ1hlY0JHYU0wcEkwYkxyUVlpTlRkWlgrRmplZFY3?=
 =?utf-8?B?Q3VzcmJ6WjRNLzcxWHF3WDd3bnhrMThBS3VaNDNUS0poS0VVck1MNjhhaEdu?=
 =?utf-8?B?MEl5L3Nad3Z1MjBLbHlIaUZBcjN4Y0N0bUt2dDUrL0hIMlhXak5RUWNQUlhT?=
 =?utf-8?B?QVdLT0JTOFcyTkFGd01pWHNaVUhFc0JaK3JWeGV4Y3hzc3Awd3h2emFPYXRS?=
 =?utf-8?B?dXQvS0FtRVIyd3ZWK2R5N0QwNVpGTzhrYmZqWWpyWnpIZnJlMkl2azJtT3RX?=
 =?utf-8?B?SmUyc0ZPbndrNy8yOHZqTzZaQnFRVUtxdzNTbTYzNFFNa2pHM1lkVU80OVQw?=
 =?utf-8?B?SzFYNGlZUlVqcDlFMXEyWk5XMW1hQlEyTzd1dEN4ZEJqWGNVeksweGlhWVoz?=
 =?utf-8?B?TUxmSERIT1BxL1p5WEt6WFk5U1AvcDRuVWtlVml4eENKQ291dVZndGR0YmdY?=
 =?utf-8?Q?RymU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlBYMHUwazd6cVRNTXNVZXNlbWZjSk1jMndMWHNwMWtPU3JVUEtqKzB2YThU?=
 =?utf-8?B?dmxBVno3aU5hengxQUMrMDJxNlc5ckM2bkdKb1FCY05jUkVxcnlaeTl6T0pY?=
 =?utf-8?B?NWt6bWZENjRtZkl1ZW9QeElTeUZMaUdtSzQva1c5OXZXSE1oRGQzdmI1akM0?=
 =?utf-8?B?SHh3WjBvdFQvT05sSElXS1pNaGhQTWhpazM2NDdrSm9RTitnb2xLZklhMGNM?=
 =?utf-8?B?c3FWclF5dVEvc0pSVDJLeWtLWktBeGJPYlZqdnFLekFmMGV2NHlpTDgxRnht?=
 =?utf-8?B?S3pmRyszNUJETWZVU09NZ0RuMDYvQ1pYWm5hN2s3ZklvekpXQjRmZ2pmMUQw?=
 =?utf-8?B?aHVJTWpGMXB4cVUrTmNodWU2NCtYUDE2ZGpaNWdzUXdNdkRKRW1VQzE3NEdp?=
 =?utf-8?B?SEJXL3VnQWZFOFZCRDZHOFVPK0tRQW5qUDZxcWMySm9SdFFHT0xrd0czZHRv?=
 =?utf-8?B?aXBXNWNBc1BtcXh2REZMTUMwRWFQSGljcXJnc01qNTE2N1IyTEM3WDhSRzFV?=
 =?utf-8?B?SUhhb21qL3F4bElQOGx4T2hvOXhTSGc3SHErVDhMbzY4MnZyY1RmNDZIZDdB?=
 =?utf-8?B?cTVYSGVycS94TUREL3J1R3NmNmhOVGtWbWJkN25RckJ4NHBoM3lHTlhLWUVS?=
 =?utf-8?B?M3dDZzhMZEFmR2FnbnhsRnJjK3JmVlJ4QVZNeDJjK3BzZVdidzBMajNtdGMw?=
 =?utf-8?B?QWlOb0ZJelhORWRSdGFUL0FtL3ZsZytHdVRrdjVPYnc4Mi9WdVBtZVpSYkRT?=
 =?utf-8?B?VEN6b1g3Ukc5ZVlIZFhPSDBqa3d5STRudHBJVEFHWVcwNlNTcWZGQ3VGSjBm?=
 =?utf-8?B?VGR6V3F3ZHE4YWtlRXpqUk9xcHd5NFAxSnFxN1RYWlE5Qkw2WjBOVVQ1Mm4v?=
 =?utf-8?B?eHRpOWNuVmt1aTB1dFd2b21GejVDbXJ3alJhYWR2U1U1MlIyTkI4ZDlCZTFH?=
 =?utf-8?B?V3l4NFhzVnpvU0ZWMTRBcjZYc2QwcDRWQmhnNWFJV25tRHFPYjRGQ05RU3Vw?=
 =?utf-8?B?cFFENjJHRzFTUTVEd3NEZFdFaDRmNlFxdVVYQ0FyblpGVjVDaVFINEpGOTZa?=
 =?utf-8?B?dTBjNGtkUmpqSzUzUkRsdGhFT1NRbS9IREUzMjNZZmppMUNJL3BUZiswNFBU?=
 =?utf-8?B?Ym1QWFBGSjAzVlJLVGR3bW9wMnpCVWI3MDF2TU1pYWhJc2w4Uk5EeDVySTNi?=
 =?utf-8?B?bml5S3psanZIbmY0MjlGMTJxcHBWai84K0RXVlgvQ2lJVjg0cE1KNURtQnJJ?=
 =?utf-8?B?Qy9xT3RlUXQ5a2t5WFpuQ1hMaE4zekZIOGd4bHJYSVVIdGcrVWlmOWNpSUlt?=
 =?utf-8?B?UDhPVC9taG03MWJpbE91Mzg1Vk9SSjlDeFdFaHlwdjBzZ0NyK0dNS0xheWty?=
 =?utf-8?B?NndKc2lTZDEwaUhXN3JWN2tNZGcwbEp5UUxDWWhKemhtUGZIZ0lPeHgzeWs0?=
 =?utf-8?B?SmxUSVhwZDc3NjI4U0FHYlQ3b1NybmowazJqOVAyT3dKWjdMMzRWVWFoTmNC?=
 =?utf-8?B?aXdOUWFjbzVkMTJzdE5FUHFTbUduNmpKZlJCazdMbW9LWXlXK1cvM0ZoUjJX?=
 =?utf-8?B?OWJhUHdvUGpzV3hlQS9kYnRHUGFnTW1BZWtlY1hHMm1ScTN6WGF3STVlditJ?=
 =?utf-8?B?cmlYVUd5bXhpWGIzRDQyUDk4SDhuUmlTc0RuVncvbDk1OVZwTGliLzVMY2VN?=
 =?utf-8?B?OTROVk5MdDVMdVVCR3YweHp1UGxqTHBtOUpjd0xMTGw4ZnBLdWlkT1luenRZ?=
 =?utf-8?B?QTZhMEw3Rkg4TXhzcWxZL1h3T3MrVG9OZzFjSWF5RzlvL2FMdmFKOW9hRlBY?=
 =?utf-8?B?UVVxZlBUejVzckxYVnFHL1FHd2RveUNRZVVGbWwweWhzcWwyQ0poVTZ3bURt?=
 =?utf-8?B?VmVtM1VES1pHZE5BOVVsSU82dXk1MVp6R1RCVnYrRkxqemgwclIzZ3VQNXVU?=
 =?utf-8?B?WFh4dVdBLzQvbEVPbE1hbUhFQllhS3hoVC9QUEdHY3R0dHowNDNtem5uUkNp?=
 =?utf-8?B?T3BtTEFiM2NZK09zQU9FYTNKc2RVaEJld01SV3FGc0U0RlZKbmVldFBxYW1r?=
 =?utf-8?B?VjY5bGliWWRTVW5wRGdvcUpyczBTNHZaYTZMS3NnbExTUXFKM2JBcXh4Zm0z?=
 =?utf-8?B?WmlualJHcHhacGw4aE5FYVQzOU5IQXRJZ2pyUW43YUNZY2czTVMyR1JOQkhv?=
 =?utf-8?B?dFlNNGdkVEY5dVVFQ0FRTFFKYXNvRnhDcThKMDIzaUNaWFNURHpSUjhpak5z?=
 =?utf-8?B?Qk9XR2hFNDBkNG82b1hON2hwNmxBdUtBWVU2NERhMVI2c29YTUI0QUZ4U1pI?=
 =?utf-8?B?R3hMa09KR1RyZnUwazFVd1lybzJkZEJZb2RlVDgzSVJObzByWWlmQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd8c4cf-6fda-4cc0-9078-08de58c15ae4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 07:47:41.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQqX7rDaqp1VAkMJJRD3Fvvj/AlVLQsDWTgg0qg7ci7hamnwR2s8UNCzLs3nHiIppSEdBcTl99FcIlIlZGMgcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8232

Hi all,

in case you run around at FOSDEM next-but-one weekend and feel like
chatting about Xenomai a bit, just drop a note, I will be there as well.
I'm always curious to learn about use cases I haven't heard before, just
like I'm happy to exchange thoughts on how to evolve the project further.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

