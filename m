Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5219C3446C0
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677450; cv=fail; b=hJzugLCwb6si+IjSRU6CZfwzSMBJ63jWG1KCELashYPM6kHf7kgYBIEflylLZn6OWcK5wSaKjdxdh2Otf8MAHLCT48KGzZktTRHuJFBs2knTGgAvCxUYOS21GSjauS7e50TnlfuuVNMWwzmtsHY+H1v1b3wfk8duW7XjOHezXMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677450; c=relaxed/simple;
	bh=jpShtzmV/Octt3gNjWsRx7xqmN20Z3CQhjpJ7ke02uM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J1V/e2CkeMfnaIViSpqwtysGIRRkHXViVt2MVnnSWLKsV1McDTg4CXqATnoCUE4CVSeGIsogl1esGwiWyTaes3QGCqbKfSvUWuH0b/NnMyjWnn1wtaFEXHlHPnAj7J89PsKhH1Z+6dUuxjfFTJs8XYJUNjtVCX4/1AHnHiptY98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nF2jJ+zw; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nF2jJ+zw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+nLGaOi3F9ehBqfOIVHMrGWfZF4Pxuemb46AhkKTRLU1lma00yM6V5+FqyaG7KvtIAldEMCChtrkb6LLWEBZUatgdnIah0nhBnFNpIVedQVEaL0dL4uYwBxkV3jCCCGomZXOMG1Jre1bTM1Kv2fD0AodlrS/AFayw9mrneN2atdAIzYojxAx1KHayXbVZnG17T2Z40R8gaf8ZCh/8WAQmzzYHKM1bDs8q4xZ1yMxUDV9o1ovsGs+s3TuMQHRsg88TdnbFeurFoPE1/WY9+lJ1xqv8qoIedMS/IsjmfSjUitY5d/1GXD+EWNlhQ6tDyn2SX9V1tzqC/S6Wtx5iQTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdy+X761sR3rHChPjko1Gn0KAZFeJYuM3rqjj5OWBVw=;
 b=mxSiv36G4Mw8BsMk6MrXvbOQ2Wmsr+5/T4aJRW19v9F8I5N+VNJyrAzOokmFgi4KxOpeXqAmbwm9xHDFBNJhp41u/rK0MprXaVxgC7H7w6VPkRjPIdL6YQPmEa/64ELrJ4fHZHd+cBVZhg4VXJ9Blu0HjnoyJ+f747qhPUnoU+ly6fZiRZUI9bH4489VAJa1thn6F2dSVjSAwa7trpHgxRecG03/atPQ/FtG4aMrsfWnmDKLn0TY3hNtBstZMH8u0HvvsWxNYSxqINHlfw1CnsQKpNVEvFy6/eg/HNmzFBK/lRguU1HJ5g2jptEWbUYRp+sxBC+5CPVZUEIdIAn46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdy+X761sR3rHChPjko1Gn0KAZFeJYuM3rqjj5OWBVw=;
 b=nF2jJ+zwYPTLlbdt5g322mkNBcZdgF6937J3lVDcId4iB+tfcNpG1KnlR3Fs/WHz5L/dQs62CteoD4R8xoyHzZpstujIeX6UVt2li5zcwmwt1JTjL2LSqF/rF8laY+QyIzO010HWbD2eXZYpcb+/9eLO7v4DeQq+JDJLLyL9IDyZj5xMfp+l4+C0UJ1Xd+LoAr3IfCSovd+6ZI1MPDpc/L7t/kPIACPqVnIfFGF0wLk7nKLpAbHCDjFMRpB3QXNWR4XKJAohDG6L9aDUlNWdA8gKQoeT+VnLtg7y/9Qi1dQn5x2LP404Bw1FjZKP9FjI0TADJ0m5Q7KvOsIEhK8TEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 29 Jan
 2026 09:04:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:04:04 +0000
Message-ID: <7c005403-39dd-48d6-adb2-0c9cd0f7337d@siemens.com>
Date: Thu, 29 Jan 2026 10:04:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] libevl: exclude the ptrace-sync test from
 stripping
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260127194125.103127-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260127194125.103127-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0272.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: da5327cf-733d-440a-07b9-08de5f155a13
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUJRNHNNZDAvZmdhMVd3ajlyRkpwYXhublBOZ3VDdHQwRHlJaUg2RmJ3SWpw?=
 =?utf-8?B?YmwxbHVkaDVES0MxSnFiWFZZRDdFMGJtSTAxc2lBaUhSMTExbEJBRGtROFgr?=
 =?utf-8?B?OFNVeEdCSEx5dmRwWTlWZGFXUUFZYmV1VHFzbXRqNXpkMGdmY1JmdTU0VTBE?=
 =?utf-8?B?em9aYThIbkFrdDBlMVg0MkhWMzh2Y2ppRktTWEFMeUZHWGdrZDBLQ0hqVlpv?=
 =?utf-8?B?S3ljcmJGU1RCNzVSaXZoMzhUT0hkMVhYUW1zeWo0elFEV3h5UHhjUHc5M3RY?=
 =?utf-8?B?Yk56a2kraGZ0NzBjTUVkdnVqTm54VVVGMXF6bmdZeVJXVS9GMG9KblhhanB6?=
 =?utf-8?B?ZUN3THVkYklDUGRkTjdXRUFaT3Fmd3hERGh1RnZYS3FEaWgyMFQ4Mjd3V0t2?=
 =?utf-8?B?RE9Dc2gwYTlaMUhJT0YwZWI0YndLOGdzWXhtNFl5eGxSbkZ5T2xXYjl4TFZ4?=
 =?utf-8?B?WGRSUVpqYlNsWE5oNEl5QjlUZ0J4SkRjRVp2QWlrRnhraW1KL0FFdjdybFhN?=
 =?utf-8?B?bGhHNGNuMVpIQXJLNkpHRnIyTTZGZ3BQV2QrS3pmTjlYOEJLMDV3VytzZDM0?=
 =?utf-8?B?MTdRZnNXMFR6eE83R1hzc2N6TDRwNWtNbklYSzkwaGFtM3pqRVF3SUNSSU1u?=
 =?utf-8?B?YzhmTGEvdkZmQ3lWSEFTVkNSZFJKWFFJTW9OcnRvUFZRTnZZeXI0T01OMDZa?=
 =?utf-8?B?R0dKeEUrTnVkSVgweFpCcDNXVzJreXhHaDk0YmVSNU1pa3JYUlBIYThiUWNm?=
 =?utf-8?B?RFBnVzMxQ3Rnam4vTlNUTkhCbjYrRnBEdGFYWkkzVGZMM2xHT2U4RzR5YkQ0?=
 =?utf-8?B?azRUaE1weU50OFZidVFNYkVBMHVMWlJud21CSFEvSHpteElxaUZNdXk0M0Z6?=
 =?utf-8?B?Uy9IaktVRXZuTW9lVnNTS3hJU3dlbnFGOVUxUVhJdnBFVG1uMFR2WDdhUk43?=
 =?utf-8?B?Z1Fud1NiWC9nKys0akUwTDRMTWZmR09RS1VoRnBLWHJIZFo3M3F2NkhaL0Vm?=
 =?utf-8?B?SzdZWGd2QkZ6eUY2MnZENGRxWTBQVTBWT0hNamovZ0ZHemZ0bnhMWGR5RjJt?=
 =?utf-8?B?Y2ZaRk9jT3U2MFdrYkd3KzJ0cmxBZEcwT2ZjTE11NWYyNGtaQWI0SFNMRFFr?=
 =?utf-8?B?UnptUGd4eFM0ZWVkdU1vZ0g4VHJiZ0FCOVRGWjJUU09hNUFYcng1Y2JWMnli?=
 =?utf-8?B?SnBxTmV6OG5qZmNxWG5qS3VOZlNDYmdLaHdRTDY0KzRvaWlzUUZQdTZvVGcv?=
 =?utf-8?B?OUsvZjJxZGhWRFpEZHk1cTltSCtYSmJENmVlUENlKzV1Ti90b2RacU1pR2lx?=
 =?utf-8?B?UXA4cGFwWUhBaEFTS0lxUUxkbnNKeFE4ZzNKUHVwZGd2aldCZzhlcFRINDlZ?=
 =?utf-8?B?TXpydVFtT3V5SlRPRkxrQnpERUUzeFowSFYwUUpNTUxrMGJCdFl3UzRrS2Jz?=
 =?utf-8?B?cHc1SDFNV3NlNkdYV29sSFc0dmp5OUR5Ympva3NFOVFaUHB2aGo2cDJ1U1BQ?=
 =?utf-8?B?cysyN2xxYXVaSCtIQUJmamZpREhTdTBnM0RSV0RFUjV3Q1NmYWdYeUNRUFRW?=
 =?utf-8?B?WDlKMWh5USt1cTBscXFhME1wVXh0MXpjYVU5SDUxN05JaFg2NkluK3V4RDNW?=
 =?utf-8?B?OUJIcFRMZkpyT3JwS3ZYTmFtb2hwSnEzTXhkaDVnV3RFT1hZN1N2YS85Sm5G?=
 =?utf-8?B?Wmc1ci9TaVdDZzFuZXczclZObUlONUZac05vcDdMTE5ONElCYjZvZjNKYnll?=
 =?utf-8?B?RU1GcTIyQ1FmNjBtSFpQR05XYmk0ek1KYnFWN20wWTU2RTF4ZEVUN2pKUTlL?=
 =?utf-8?B?ZE9iTFF5TExKRzlQN3htYzFlaHhUUDZCQXdqU01Qdmdmck1jSWFRd1ZkU05T?=
 =?utf-8?B?UjAvRjVyRjVKRlNEcVgrQm56dWJqY0ViQkFnL0VpbWdtTzA3M1k5Q1lWNVBm?=
 =?utf-8?B?SDdtNXBxUWIvbEwrVjBad0l3c08vSnZPK1FHYXEvd3pQd3JtRnZaWHAwaEVE?=
 =?utf-8?B?aU5Ob1FrM0NCRHhSQTlwcUp5cHUvWGVqWUhHaHZ0OGRzUzJ4Z1hmWDNTT0hB?=
 =?utf-8?B?Q0o5d2d4dUVnd3JxQjhvNittQlcxOStRQytvUjJpS0duTVJKaTIyaTMyY1Vk?=
 =?utf-8?Q?5LIg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHhYZUFRb2EyTlpHb3BiSEpFV0pYZnMzQ0RWcjlBaFpqWjl6Zjc1Ykg1SVBZ?=
 =?utf-8?B?a1gwdjdjVjd4eFNNODE1UjVMQzFXRVMwQlZIVk5SSzNxM2F6aW80UEZVOFFC?=
 =?utf-8?B?WFhFalVJUlNmU3JySzhZN0FxWTQva1g0Z2gwQ0V2bDNlY3U4UWZ1NU12U3py?=
 =?utf-8?B?S1N6MjRxZmZCRDRDaUU0K2Q0SzltaE50SkZhS1djb3VaNHJsRzNSQ2tNazhh?=
 =?utf-8?B?Z0QwMFEvNmlCMXJWaXNFRElqejFxWVNqOS9zSnBOcTI3M2pSay9YWktCUjVK?=
 =?utf-8?B?YWw1TFdDcng0eXJ0a0llVFdTb0ZycVU1RUtjWW9SamRPSi9PMnJPbjhPL3g0?=
 =?utf-8?B?TDZBWDhjZWkyM0NrN2FkN09MdTN0Sjl4dHlObUN2SmNxbHFxY1UwTGg4Z1Rm?=
 =?utf-8?B?OXViSVg0ZUNLNUp3NEdlWWZNc1VrS2t2SjMxTHJNMzBoTkg2eUtjY0J2S0dV?=
 =?utf-8?B?aG1IK2JmL2lSdWh0WUdKd1NlZVc2ZjBSMU1qTXc1blRweDFkK09KYzh2cUxx?=
 =?utf-8?B?S0FKaHZVZjFoMG5aK08zZlN2WmppbmZBQVNEVUJyNTRKcmFOdzhhSHFDa2dM?=
 =?utf-8?B?Q0NyVmxhaDhXMkszbXI0U2s3M2FzSHlPM3cvVnZCY3d0WE1uQWFvQitnVllG?=
 =?utf-8?B?cDRwTUN5UGV4enhEYzlGU3VGbHJlaDQxaWlIS2lCbGFJaDI2UVJWak9sV2xO?=
 =?utf-8?B?NkhLaFJZcXVCKzkzWGY1U29YdmlSeFJ1clJDN1pad2lFb0JyeWJtam14aHFC?=
 =?utf-8?B?aEJWNStSNElJQTdoZGlWYzRQbDBNeTA4MVlEazlVaklQcGwvYWVmTEg0SkY1?=
 =?utf-8?B?WFNySTNHMUkvc0RRaHR4YlNqZ2dNWGhjMkN1a1JIUHJPRnhYZGJvNmxWT0tk?=
 =?utf-8?B?bmxQd3lhdXVtRW9mY1d5K2hHLyt2b2UveFFyTGtuV0p3VERiOEJYaTE1Z2Fk?=
 =?utf-8?B?MGc0cHdXWjI1SGtQRWQvNm5Xc04xL3hhdkxZL3RaR2pab0dBQitpdm9tVEU0?=
 =?utf-8?B?czVoK0ZJMFJwSTdrK3ZNa3RSZk5yaWRmWm9rUEdhSXhUMW83blhwb3dEclVG?=
 =?utf-8?B?b2l0dm5wYi9NRTJ4TGVOQ3RGL28rWEo3cURhVzVsU1UzVHNxV3A5cmZDS1dh?=
 =?utf-8?B?c294S3c4R3Fla2ZmUjFKZjZCbFFjTjUzK0tjOEtBYmExRVFqM2xydDZGM3Vr?=
 =?utf-8?B?N2hHZTNra2FZeWh2dHZvYkJKVjNSL0RjbWZVTHBEZTNDanVVNXFVTmlIMnN2?=
 =?utf-8?B?VVcwUDJBdS9ZZmxWZ0NjeE9ma3hac3lwTHFibnZxWWorMGpmUkg3ZDZFNjRH?=
 =?utf-8?B?a0RUZUpGVXNFL1MralJpY0xqTWVRenNJUk9qTTUvWWc5QjVqWjI4S0NtSU8z?=
 =?utf-8?B?ejRHMjBGN0pRMjZLUVJRSTlRTVMvNWUrbGVydytiVDRubDV2bzR6OWsxRFQ5?=
 =?utf-8?B?OVFnbGJhR2dPRG5oelNJa2ZYeUQyYndhd0VKZEVabjk0U3d3ZHd4QVExK2t1?=
 =?utf-8?B?MCs3ZVpWbUR4K3YwdHlNUXZZREtRd0ErejlLeGU0L1NPYk9sb2VsR0dPWGdU?=
 =?utf-8?B?OE41WHVZWlg4NFBaWE1EcGlwTC8yanhIQmNpUHRYN2ZlTE9JWEhjY0paYzgw?=
 =?utf-8?B?aFNmOWxYWlFhMnFKVlpka0hLNFpGQy9WR3pSNWptUG1TdGd4UDJGOFJWM25E?=
 =?utf-8?B?V0xBQ2Z0UDh1SWxFYlYxdlU5eHUyakp4TGlOeERpem41a2tGZUJCWXhLUlVQ?=
 =?utf-8?B?QXgwSTBFRmx6Y0xVSnZQQTBPLzI5NzkzaXJwQ09xSFd6SHVLOUVzaTVvTUly?=
 =?utf-8?B?Z0lleTZwR0NqNm82eHhCUUJJVjNrdlRSeEdNWS9JQm4vMjJlZnA3dG1QQkhH?=
 =?utf-8?B?cjMvdVlITEY2eEk0Y09vN0hyTGk1OUF2N1Q5N0pONFl5U00rUWFoOEx5Rnlz?=
 =?utf-8?B?cWZwMmZNSU5saDVLRW0yNTFjQU4rWWRhRHpsbGlZcHY2bEd5RXhqemVROEVs?=
 =?utf-8?B?ZVh6SVNWbklGQ1RZc3BRdzdTVUtsNXp4THV0QktOOEorWURLOWRxSy81R2g0?=
 =?utf-8?B?V3l2WWlOeUlFY0M5Y2x6UU5PY3ZJRDJaWGxjNVFsRVBsczM4bkhhVnlmNnZC?=
 =?utf-8?B?SDVMRllDb0pmb1dKa0RxbnpWbDRsSTNoY0hockVxSmlaakUxK0ZQellVVWxQ?=
 =?utf-8?B?QmZLQUhhdm5VdW1TcmY1MS9zUVVaeUkzMEVMREQ4VTRtY2tQb1JZQ1A5ekEz?=
 =?utf-8?B?ekoxc3U5OUMwNDdackl0Y1R3OVhNQW5YWlJtclZQLzhQNWFrajhWSFV4MThG?=
 =?utf-8?B?TzBsS1gxM0xKdW9RcVF6dEZGa1VMWjFtMlZSeUFWeW5LV2UrTUxodz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5327cf-733d-440a-07b9-08de5f155a13
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:04:04.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9MJfMGtCi5sT/1wsB+zgYJTJ2jVBMWxl6KlB5nyJ7YrNbnH2gVdwygPEW3BKC9ii7X2YcxqINCq9Lqk45YrvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8064

On 27.01.26 20:41, Tobias Schaffner wrote:
> Only exclude the ptrace-sync test binary from stripping instead of
> loading the symbol package.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-xenomai/libevl/files/debian/control.tmpl | 2 +-
>  recipes-xenomai/libevl/files/debian/rules        | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
> index 89c871a..93caffe 100644
> --- a/recipes-xenomai/libevl/files/debian/control.tmpl
> +++ b/recipes-xenomai/libevl/files/debian/control.tmpl
> @@ -13,4 +13,4 @@ Depends: ${shlibs:Depends}
>  Package: libevl-test
>  Architecture: ${DISTRO_ARCH}
>  Description: ${DESCRIPTION} - test suite
> -Depends: libevl, libevl-test-dbgsym, gdb, ${shlibs:Depends}
> +Depends: libevl, gdb, ${shlibs:Depends}
> diff --git a/recipes-xenomai/libevl/files/debian/rules b/recipes-xenomai/libevl/files/debian/rules
> index 07c28b9..a704dff 100755
> --- a/recipes-xenomai/libevl/files/debian/rules
> +++ b/recipes-xenomai/libevl/files/debian/rules
> @@ -15,5 +15,8 @@ override_dh_fixperms:
>  override_dh_auto_configure:
>  	dh_auto_configure -- -Duapi=$(UAPI) -Dinstall-uapi=false
>  
> +override_dh_strip:
> +	dh_strip -Xptrace-sync
> +
>  %:
>  	dh $@ --buildsystem=meson

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
