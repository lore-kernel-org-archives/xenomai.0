Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528DF17BAA
	for <xenomai@lists.linux.dev>; Tue, 16 Jul 2024 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721109486; cv=fail; b=dhLkb54rjj/F+hom6gNQyOpdCSacjkFix3A/pwHM+ed9OWjJnU/uHk9SZfhLjHymMNKg0sBcdHzR/I6mQhgccqBUwajiQ9en34uNXIlRv5EXBQUMkXIGg8tOJa8Tcv+IdkoGfLD7FkxdDxWl/efGJRJU1nekGZ6MkqxgNHCbu3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721109486; c=relaxed/simple;
	bh=e52jePYcNvfR4kSE7QZ0IYwG63QZHVDoxRXrQ3hnn5c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fkVc8xzp2VI0VowfdNeIPHUe6/uz0/Nnlw/HCrc9zC6s4M2nqCHcqkd1WbAVpTOon6nTdogDVAjr7Wk3fKhrln1e587b4t8p8rw0QTTXp5KIB/YQ7209Sij6gRTlnpQTOfEZ+ZKegXK5kWpVhP68CYKPQMogBP848oD+ikRH2Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Aj2E6uJs; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Aj2E6uJs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5b1BFuh2q6osg7n/ai5gc+DRNGyoyQYHPYw+YkYTvpX9C/Jg9kYGbWGzjIq0Q1mRb7E55y9MCta7j5+SMBSsf3prDDbow2hJjGnKOzQ6V+bqSzMIKkfuClL+RJ31wE3F0pQ+Bj4iUXD3FKKzFt0vRS6HbplW25VyfV15oARBBdpAO6k2AbkfvORPx/rh2g1A0hZ4PNUJcCa8AAJ2Dyi5nRYmkOuA7LP58oqwMVCmfnt7kDJqwAh/HJhPVxYIaaUNbkXS/kv76T0EtxtsJ4oVnPT7WywmLzP0eoC1qwmuXOPWj4ieuVhNN7LPpn4FsGv0VBLvjHPtBEXP/lY+8hueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0VS9NlkDuc1Z21v3CgppjKDiOn+Z9ICZePk7bMoOFQ=;
 b=b1z0JsyT6v9bwP0PgKk/vZ57HkycpzQ9vDvNzBGzXcBmDO6gs/kDkIFQssNknkO1OjlE0LFGh1RMKLFp9B541cdLgCAPihj/9YepuVlwM1BU3sIRoWxTcnmH0AZ3INxsZxBL07Fpy0tArIZJKUhyJKSHjVn00bV936K1Bb+NeluZf+DtfBMgVu+fugCnsWLCqkJzyD5C/89kvjYlilyiGD9J7jCBxXEHUim5rEdBIfVpcA+zE1VH1Q1SrlSfta5a1j341cCdMlscGsicIlU1BV7yOPbt7+UY942q9YI61ll3gYqqnZsTyov0S0PtYSvWwUGgiwbxA2yoc9/+51kzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0VS9NlkDuc1Z21v3CgppjKDiOn+Z9ICZePk7bMoOFQ=;
 b=Aj2E6uJssD4FMGPXSYPUBJWOfRBHLGADdBmDKW/9XnJWv/zMCMU8rzMPcCpeLR4ZVQ5SWJE8AicguJuR3u5YjX5LZTFMa/h8FgU6WiUq+Uu9QQdJgAoXfUg3WWTGXjk7/9w0eJKSpV1mjQ6zAJLyuJkrRchoZzk8by0yPGO76EftqZUPmk/saka2MN97etRGDfCHMo27hQ9g3W8mZ/lSVpEJZVyOxtHBQdAAAWCUuibSfGOYj1FVZ4Si9dSJf7yN3d53xPPLrm6cvPLPDEr/2Q6BxziVtHrm4bIXTvIW80dZX8+YP9NQ8mZ3vF6iG3GJgWsMTIJbygnj9kxZctfeYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PAXPR10MB5541.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 05:57:59 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 05:57:58 +0000
Message-ID: <eca43d81-15d5-4153-b402-b154847b7665@siemens.com>
Date: Tue, 16 Jul 2024 07:57:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [xenomai-images] Ignore name when searching for failures
 in junit report
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20240712085232.2989424-1-tobias.schaffner@siemens.com>
 <d01917ff-79cb-44f4-b051-e393be802bd1@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <d01917ff-79cb-44f4-b051-e393be802bd1@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::10) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PAXPR10MB5541:EE_
X-MS-Office365-Filtering-Correlation-Id: 828e796c-867f-47a2-5007-08dca55c3ea7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW5PNjh5TmxmOFdIcmY5cDV3bW5hL0tBeWNiRERQN3BFZ0dwWVpRMmJzcHVZ?=
 =?utf-8?B?aFdnakJZekhWaEcrdVV1aHpKWTRka0haZjdRbW05ejBPNnFVcEVmYkZZVWpm?=
 =?utf-8?B?WUxYSGdISEM2bHBCTFIrMmVIdnp0T0pFckMxdUJMcnBKS0VPWTdtVVREQmJB?=
 =?utf-8?B?OWRtNXlvUDB4WFBNQmZTQ0dWbFk1d2dtLy9kR3BFenoyY0ZiTVFQSGxuVFd6?=
 =?utf-8?B?dEpsRzQ2Q0QyV3hWQzJSZWF0d0d6OTFwZWM0cDN6czIxSlE5dU9YaWFLZ1k5?=
 =?utf-8?B?RVhBL2JqQXdhTGVORTdoUWgwbnRBZGlzUXlJYmM5SEdsMVlEcjJ3NWR4SVhp?=
 =?utf-8?B?LzRjcUJUOTBGT2Q1cGNuV0J6ZXFyT1U5enpnN0FBbVFTeTFlTTFrbUZKS0J0?=
 =?utf-8?B?dkx6bEZRT2VVVGlTaHRvTnMrb3NPUXZHNlNyaHozcWhwNUtwL0JjdHhIOHky?=
 =?utf-8?B?RWRobkpJL3dyU0NFR0o5enVzanNKOGprOVd0dWZRQkt1UlBpL1pnMTVJV3N2?=
 =?utf-8?B?b3pzcDBnaUlmeEx6MnBoc25yQmp6cEVQbjdHWnpQTVFDUEo3ZHMxdVY0U3hm?=
 =?utf-8?B?VEw3bWgxQ29RdC9IbWJKc09YNzFyWnZWNml6dnRsTnV4MlAwUDJFbjVJemhU?=
 =?utf-8?B?cHhGb0YwNkozUjNIKzRrNDFjTjMyYjhWVXNGak1udUc2UkVJTDYrcnhOeEFu?=
 =?utf-8?B?d3ZZNmx3b1V5dHcyLzZSdXNzRzBUU3M4RWJ6Z2I4M3VzOHRWR2doRUdZSlRU?=
 =?utf-8?B?dVpMdWg1OGQvc2x3U2IxSkZLaVczZ2x4YWNySXFvQ0drOGxwUVhjR3Q5UkVS?=
 =?utf-8?B?NzhiWWI1aDF6eHoxZUNlUzRMbzJ1bWJZelpwMmovNUFES1FvelZ2dEJjTW9X?=
 =?utf-8?B?L0hIcjZYdVAzZUpYRDFZcVNhbXRROVdyWTliWFh5NmxXQnVNQURLUXcvU3px?=
 =?utf-8?B?ZzkxWUVKUGxOZDEzaG5YVzFnWjY3VVA0VXdmZVN5dkc1UHpJSkczSHJVcE5S?=
 =?utf-8?B?Q3ErT2V6S3FmajVmOXI0aDZsMFJUL1FIak9DZ0tUWEtjR2JGbHJWUXBrbjhm?=
 =?utf-8?B?QWVKMlU1TTVXUlpWUEJUcGtjSUlxQ05LcjJxM21IbWY2Rm9yWGxYZmpWN2M2?=
 =?utf-8?B?Y3Vad3dyR0hnTjE2VnZpREh0RlRlMnpWZGNoSW9mZ3dCUVR5QUZudEYrRmgr?=
 =?utf-8?B?cWx6YVFtZlBsb1d1T0t6bHAvM1JYb0R5Z1NIeHNRUThFOHVLcW5maGlNTXFm?=
 =?utf-8?B?L3V2ek9zQlBydmR5QXlsUlRqMDhaL0prN0xwdGVBNUlsWnhPNEp4Q3h6M2Rm?=
 =?utf-8?B?Z3g0UW5DdWoweUpQUjZHZ2c0K1ZYMmJ4VnExWnN6UG1ha0t6OElpZGMzQnR0?=
 =?utf-8?B?QllZdFVCNnVUVThSR1FuSVh5VUtKMUt0RnNNNWZhQW1abWhJa1E1Y3hxTSty?=
 =?utf-8?B?ZjRrL3pIWVdDM01aTWVmeFZxZUJ1eU1lckpkdTFEblZSRGk5ekl4OGo1MnBY?=
 =?utf-8?B?Ym05YTVOUmxRaG8vcTVPWjN3VnEyQTZ5Mm5vdHY3dG42TDZBNk9SMG9VbEV5?=
 =?utf-8?B?eTRBV2lMQXZmdUxIM1VBSVRzMUxWYTdscW5KaGJXdnE2eEZ1RzdmbTNTWEM1?=
 =?utf-8?B?clh2S3R4amxZRlFPSmRRY2NWaEVKVE4wZzFUS3RJYVdiMWFTSGcyU1p3VUtt?=
 =?utf-8?B?WVpNN2k4SlhlU3VLRUNodXJ0cmkvTFoweDBhRjFhYVdhMmRDU0ZVTE1XdzNR?=
 =?utf-8?Q?M2hyQb2T+jwhQLZrVo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjNCZllic3R5T1NBVkpmQ0tlZXh6MGVFdjQ4RC9ocFd5bUwwUEtsRDNKbkNy?=
 =?utf-8?B?V1V0Yk9PNnFUdkZqTXE1MldrQ3FZNHR4VDQ2eU5CaXZFbUNnd1ZXOGFibWFx?=
 =?utf-8?B?M1BPeFRQNHZ3ZUlzekp4YmRyNzFFR1h3NFpwdk9YVTY5c0FxT2RDNit5UHZF?=
 =?utf-8?B?UkJmbTMxRW9YMFJlRDlLeVoyd2s2VlhobndSOEVQUUpyTU5SVlFtMWRZcXVC?=
 =?utf-8?B?TjgyRE1udFU5RzFkYWdrc1k1YWZUanNna1RES1U1N25sdHg3L240Nis3RGFM?=
 =?utf-8?B?OGZ6ME9TOTY1VlBJU3hSWHY2WWhDZWNaVzM2SEZ1WHpHR3I5ZVFXZXk3VFhO?=
 =?utf-8?B?NmlmODdubVNSQTJFWXBTNjVZY1p3Smx0REVhamlJSzN2VDQ3R29NTFphekEr?=
 =?utf-8?B?TmptdDlyTnJQSGRiWEdad1NUMzE0ckxUdmgrU3ExcloxYjNqUW9TVklBTytw?=
 =?utf-8?B?NGZ3L2hGN3JYRzlSTzY4aG9rdXZMeUFvNUU0Z0RKUDJwUjQxUTJ6MTBkaFBx?=
 =?utf-8?B?d2xUTS9SMUF3djlvMThDUEZ5ZFRNRXA4ODJvMHEyOEpDQ3BRQXQ4Q2k0aHFp?=
 =?utf-8?B?SG1sTEh0cnlDQjRLSTNrSUVZZDRITW10ODhqZjFtK1JOdFZmQkJCVWZ5a3Jn?=
 =?utf-8?B?ZHpNNzBqQnNFakRJQVlyVGpnalg0c215cTY4N0F5cnpoOFdtbjFna2RUbzBB?=
 =?utf-8?B?aXZEd0dEazF5NkdrM29zY0h1eitSUC9PL0Z6N0JhZ2pCeTI3dndTaHlQVk5O?=
 =?utf-8?B?d3M2c2xmSUgvbFpNVm8ycTcvcStNOWJkbUhJTGpCV0tQY29wdXFiMHJWbXlE?=
 =?utf-8?B?ekFlM3lRZzZTMGs5STkxN21OdGthU2o5NGlyNmJQQnpUeUxiT1dSMENaVzM1?=
 =?utf-8?B?VWpnNlFSMi9iR254ZmVoRFB2VFZPSDNZT1F5dkV1OW9sOHdhY1BBdmNvYU9F?=
 =?utf-8?B?eU15MXBrSFlqUEVCeUxRalVWeXRNOUMzRFhMeU5TbmNBZ3dVSVVTSG1HbmdX?=
 =?utf-8?B?V21QTXVZQlBpRXE3YXorK1RqKzJFZ2JEMU1iUVpvSGtOOGY0MmxMbGc4S3Nz?=
 =?utf-8?B?ankrYmNlUTBZdmtDSnJDU3pZSVdURDZ3cStPd1NNckNBSWVzNHVzWERZM1l2?=
 =?utf-8?B?WE1Cci9LL2xBVlgreWdsbkEwWGpOQmJOZ3NmVkd5WXRsWktDV3lDand1aGpF?=
 =?utf-8?B?Yk5VNVYyWWlsSE9neWYyNzJsQnRETktZZmRLSVo5aVFqaCtuTHkzSFlCSzl6?=
 =?utf-8?B?TEU4QUVTYnpjUW1SWUVjRWxoamlJU0p3V0cxVERNZGtsQkwwN1I1Zno5cStN?=
 =?utf-8?B?YmtvQ1NtN1ZnNVU1eUlWa1h3SWwrMktCUDZRVjdiWlFsRnkzQWhDanZvRDhm?=
 =?utf-8?B?MXcvdWtDY2NwYStwRkZtbjF5Uk5BNGpTUkNWTC83RGVGKzRkSEhTQ2p5SXpt?=
 =?utf-8?B?VnlDQVlrajc2M3o5MWdIYThQQU5SVldCeUFrV1VXU0NncisyU3FhNEdDRE5B?=
 =?utf-8?B?b1BWK3B4NVJxZWUwWW5ITTloelNhUHlWcWozM3BTZ0NXdVl2WVExSXJKckti?=
 =?utf-8?B?UkFBTWRrdEoyRkxQOW9TeHQ2dm8yNGZvaS91OXNQS2hIQkZpUTlwU0hZRWho?=
 =?utf-8?B?UDVnZUh2RW9wNjM3dVlCeWlIbzNUV1BNSjBiTDFQdWsrL1hpVjFmQ24rb2V6?=
 =?utf-8?B?aXJ0RmpxSDk1d2piNzB2VGNsN3ZyTE52M0FCcXN0bDhNbHZCNnQ0TW5nRnJS?=
 =?utf-8?B?cXlyaHBaU05DVzgvUTZNYW1yV0w4M2JZNlI4T1BMRldlVFN0OWxHQUpCbzlD?=
 =?utf-8?B?Vy93bDVJd25IMCtZMmRCQ3Q0UVZSVWlvWU9Vc3hEWFJ3RG5FOXZ6aE1pMXJo?=
 =?utf-8?B?Q3ljVWJmRjJtWTNCcEpVcU5XazBHb3JWMFhadnRiMUZNaWRoNDUxc1M2dVNs?=
 =?utf-8?B?S3I2Rit3cGs2NWpPRnl0SVpobXhQbXBoRmdsV3o5TEVqUHZUVndHMnJmR1Zv?=
 =?utf-8?B?U0o2UG9FaGhUM2kveEo3dGRnaFFwcG5CME9LekNWZ25jeFRFZWJxd29GM3JG?=
 =?utf-8?B?bmwvZWR3Nzl6TUtOVHltVTZGaHFNTkxKV0dZOVl6ZFdmNTVVd3FwMUtRR3Nq?=
 =?utf-8?B?V2Rrd0ExV2xJcXNCZFFGay9SZ3lVcDR0TU5UYXlXSmhnUUNBeVcrdEtDN0tF?=
 =?utf-8?B?Q25rYWZnSGRwekFlaTRZNjllN2srcWRFcUZEUjZOdzh4bThkS2kzclZHV0R1?=
 =?utf-8?B?SGJmMUVwTlZ0c1Y5cTF4a05pS3N3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828e796c-867f-47a2-5007-08dca55c3ea7
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 05:57:58.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KBJ4ZdsQRERwylFVjWcCRZ6kHm2CUq6s9NiTTFfW46RXRRwWweRTqa255K4c6jRaojU+LdZPzFEtAw3DrToWGnXMhPYmWz+miqjM1MLm5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5541

Hi Jan,

On 12.07.24 11:01, Jan Kiszka wrote:
> On 12.07.24 10:52, Tobias Schaffner wrote:
>> We only search for failed test-cases that have the name job. This is not
>> correct. E.g. the xeno-test result will have the name "xeno-test".
>>
>> Fail if there is any failed testcase found in the junit xml report.
>>
> 
> https://source.denx.de/Xenomai/xenomai-images/-/commit/22db8c107109eef90bc5f93baa5a38c2e7f50f5c
> 
> If you find a case where a test failed and that did not leads to a job
> failure, please let us know. But that should likely be addressed in the
> LAVA tests then.

If the shell command in a lava-test-case call fails this will not make 
the action fail but create an report entry with the given test-case-name.

Therefore a run with a failed xeno-test command will look like this:
Results:
* 0_xenomai-test-suite.xenomai-test [fail]
* lava.job [pass]
* lava.power-off [pass]
* lava.0_xenomai-test-suite [pass]
* lava.login-action [pass]
* lava.kernel-messages [pass]
[...]

We could make the whole action fail by not using lava-test-case but this 
would still not make the job fail.

* lava.job [pass]
* lava.power-off [pass]
* lava.0_xenomai-test-suite [fail]
* lava.login-action [pass]
* lava.kernel-messages [pass]
[...]

Any input why and how this should make the job fail?

Do we have an example of a report with an failed entry after a retry? A 
successful retry should not lead to a failed result to my current 
understanding.

All the best!

> Jan
> 
