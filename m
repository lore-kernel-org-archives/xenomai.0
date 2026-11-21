Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795280187;
	b=jBFWre0Mad9SpHwRPndQnN2yq7W9eco4zeUfBI/b6eov4RgzVrJ3snj+HXI5PGfLTXK2
	 /nmeIekNF09ckC9ZXGyj/VgkCwxphfJGBByTjoGScAxNi1iWfh214lexAeB/WRa8ABfXh
	 zE4VZLTsri/2lIoJQAG+YX9fVlpdfBXqXV4fvc6BgNZnM8kXqOj4MQDnM6u9SZbZIEEug
	 OsV1690c41y4a7ZI35GC6JW23vKdOP9rBPdNoX2Pj/v71UR5DWk/gZk3Y7FUEXu7A7ljj
	 u+ZtO+L5nCTmVTVk/GgPEkUEa1JqK6Wy9ULi54IzymHETQ18cJ1Bu3RP1s4xJ/ADvrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280187;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=l9RNWfLMXMlZQBELGRZR6AO9hvt4VsmYtnkK5WwokVs=;
	b=d1KVfcxoimJ8FTNytVwC5xndavME1OLSXRaHSsBWWdWBthdgV4oTv92Ur/rc5+w/3yFU
	 Gv4+z8PqaVpPzpbqgWwkNJUda4jOBi3sQn8SlOm0FYcghGRpOuzx13514U3n9ymC5DlAY
	 oDMK+Q1x9SEnKgEfUirzS7b0qJOjB/Gj2zs9vl4H24lGjtq6qKgDm7bD4d7HgXtrL7yUD
	 oJFzIpph/2vXPB+ibg/pX5ZyDNjeVBu29jdhNmY7AYtkBP4Sdl37Xc+52/RAu4d8BuJ4K
	 9T1HoSHytTgAOpGdqNTajY2nW7/qM2d4bAthX0Hqaj5339JZwEK6C2q12ysG8qkbIbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=yWDJORsu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.7
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC9606A32A
	for <xenomai@lists.linux.dev>; Sat, 21 Nov 2026 16:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CFC9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=yWDJORsu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8RuzLPjYEmd44VBcq4BTwKtlF1Yr3zrbqXHGnW2M5SYcs9duSgZtkgWysxgDGmF93QOeAYo6HopaPAr+6XPRwWkFTRVS+gX2xAHTCDcmtPfxybAVzRpYg6z6EilJmPiyWMTO3q4HAmelaNmQH/j8Wi69+My0SLV5HVWDa82jD8JdoCeZDFHvxUgclCsPyaSbCWUV1rFnT8L6eOsJCVE4Sbyk4W+2ztxUyvY4A3DcBVwHqiILraEUruzeM2HRbNGHQQAGHlWEPL/zfXoKq5d25I6GSOBTzv9Zo80TxlG2G/PpKYAJ3uKhXt/xu2OWU/oMZLLQ42JJndHKjLKKQ7i/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9RNWfLMXMlZQBELGRZR6AO9hvt4VsmYtnkK5WwokVs=;
 b=Mvo/XCfsEYk/hjiN2wyM7AQNVFxfTfMpg+PluCHDReTxWDgtly4Zlmj05ZDLCSiykYBNQHdZP7Uf+TuU9EQ0sVpgXURIDF6v4XqKKNr8MnaGYdF8P3d4VWNlL8zwRzWqo3toy5zNxuNwob9wsT4FHSOZJm6tg9Lr3/sjwtGjExdAMs/Qt9BItDDpWMUcSGyIPfK6ql1++MmAxCp4IXJHpB+xiF21C/rAL9GX5FwSY5YwefTfvwLHmNFejluCq2b9U/8rwNbhoN3AqtUoIKx4sQgRRhD6hEnfqTE/IBwjZ8vS0j43u9C/ecb64+Ny73NoDdaVoxQkPSoNMEFOMgviHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9RNWfLMXMlZQBELGRZR6AO9hvt4VsmYtnkK5WwokVs=;
 b=yWDJORsuto0Ui03h2NlSgcMpuyGRMUz0nE+IuNPAWywkEpxyRMFDrvEfJ2Y+Lwd4rC4dKjUdPUil8inMjBOBb9C5tcHFWdY/pkE312XNuyLzwOEw5PPf9iwIjuJUUlonIXP5aQkGuf99CxB3h0KlgCOK2dnVgZPfZP86qFelalCCetuzlkRXXIC3P1tleRqdlmZ2vUprgJZJemhXStPz9IhpnErDLkwRxHwU0hQ/ya8yXOturnQrgNnt4Ocj7WW8ec+sgP27+WKyk57Uh9VrE/7g9Z0t0WeJxyWHvppIsIRxMuN4ju3x/0UzY20K5b3ksyKY89qQrgdPYt8JbnD34A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB7024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:598::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Sat, 21 Nov
 2026 16:56:20 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Sat, 21 Nov 2026
 16:56:20 +0000
Message-ID: <be5cba54-2aad-4dff-b119-054aa4f16330@siemens.com>
Date: Sat, 21 Nov 2026 17:56:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 4/5] riscv: dovetail: keep hard irqs off for page
 faults handled out-of-band
To: "Bezdeka, Florian (FT RPD CPC OES-DE)" <florian.bezdeka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: "rpm@xenomai.org" <rpm@xenomai.org>,
 "Kiszka, Jan (FT RPD CPC)" <jan.kiszka@siemens.com>
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
 <20261117123925.597027-5-tobias.schaffner@siemens.com>
 <3b8d95a887bd9740e8ea877e0ac276d6588fc87f.camel@siemens.com>
 <2d17cfe9747a8f98da78fb6fbca52908577b538e.camel@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <2d17cfe9747a8f98da78fb6fbca52908577b538e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: cabf8164-0c30-48df-c807-08df47f05de3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|23010399003|11063799006|261022075727099003|4143699003|56012099006|261022105027099003|10067099003|261026140227099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261102123227099003|261009223027099003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3Z0O+UAE6OXrRtUkw8Nqha2QxaEwdHLjuV4Vh8/etnrAreVM0RkJJ2xaaeghF4rHDH3+v0vaJk302YVcWLDi63FqjIvdZUSa3Mmd7QYdnJG25/Mrswi2Tt+GTGCi6sGuLV2/cRnShKQyArEVajkdczoL0RafYDh/TIZJQzoDJmoUunBNwDxrdrqquZZd6ow2m23PFgRb1lyqQ2WkLbutl4numoVasctJumrXfDGOPBQnrH3jgrlS1sPtVcSKynwjJb523LSfNoLNp5sz2dDggeLIZX0ti1FCKeVZzUCaIJFcl9m+/FIXtx2xMnroZ6njlp1vgLztcYjpbmLKgW4ouvfJXtdfiPGdo3knmkL4EX0RahH1swtPHpsZmXO42Dl3I1JmTQ3350XAKVoISCh63Rtew20MCYFbUc+1Lx/glGAXMSB+EQX5yclAJyIGvCuTMzlYkn1W0Q5jkNGyMetxaZjqmKz1oDkai66b5n75SBWEsPy2E/Tu0+CiM0H+WizmmKXRQwPoEMRNMo07WQQLebcoQ7DKzcwQollX5AD71F8IcZG+W1+IWBr0nhiYy0x+6BZi2mWMZvk6PvdiiB0pUajVoNUBqqU/x7yRvVfHpeJOr2CNG5yZoSLpo7+2AlKYCoUGeuKBiJf9by6mHnI5bfmixpnMmxakLPOw2MBh9z4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(11063799006)(261022075727099003)(4143699003)(56012099006)(261022105027099003)(10067099003)(261026140227099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXhqZlVramVXNXptazlXU0NyOWlHZ1FORWVWWGRSeE1oUForWHEzZ29JbUd6?=
 =?utf-8?B?dldQd0VjMnNvT2c3bGdDQkk4YzJFR0h1Nk5vTzRmMkJVS3Q4bXVpMVdhaTR4?=
 =?utf-8?B?TG5XSmVTWmpHaHZUc1lvYjJLUmNGdHJSclJLTFdzcjZDTjF3eHR5VUpSV25M?=
 =?utf-8?B?Z1dUWm9hV0NRN3MyQjlrODNURloyd0NEZkMxSDFTUDJXM2ozd3BMa045TmM5?=
 =?utf-8?B?cUtRMGpJR3VEZDQ3cjNRcU1OUU15TzFHZTUva3BtVThtOUhjdlN6Yk1VeFVo?=
 =?utf-8?B?YzdPYk9IMi8wdUlEcWoyaE1tVzVVbTBaQkFjN3RGVWVOY0xhR3FSajdBai9t?=
 =?utf-8?B?QlVnUEtZUWFQSkMvZFRJcnQycnBvYWkycFprM3NoN2tpRUswWHVkZmN6QVM3?=
 =?utf-8?B?a2d6L2REYjJwUkY1dkF3eUJJY3puY0JyVndsaHBvTktmYUl3VFA0Z3lEeTFv?=
 =?utf-8?B?L2NiczYyRzgvMU9ocXRjZGdnQSttajZxb1ZNNFpCSDJBUEdVY1JDTWhmUStS?=
 =?utf-8?B?NkpYNDNDRE4yY1NWNEhzcXFZMkJrNUN3SkxIelg3T3crMkZEcnpHdE9ZR2c0?=
 =?utf-8?B?L3NaR0VpWCtNa0MvYTNrUG9CWXVlU3V1eUVsaUdHK0Y2cmttcW9jNXVCSytJ?=
 =?utf-8?B?ZUJtenA5TG84b2VpOTByRDdVeGp6NTAzOXBQWDdOMC9PZzVTckFOSTVUSU9j?=
 =?utf-8?B?UmRVYmo4Ync4cXVFWW5UVHBOS0hEVTRDSGtCYmE5L25OaVIrRWJtYVV6YktO?=
 =?utf-8?B?cUtnYTJHUGlCbWtVc1ViOEZpc0g4WDczMFJRZnBaS0dhOW12SDhlNTZqSFdQ?=
 =?utf-8?B?MXpJUGVEclNvMTRwVE9uRjV4M0szc3d1TWkyQzN3Z2FVMFFXb2M4RXhrVTE5?=
 =?utf-8?B?NDh0VURxRm5jc0tULzZibE9YVEQ4MXMvc2krVHB6MkFGUW40bWhHbVFyWk5O?=
 =?utf-8?B?UnQxaXdsTGhLSnExdnhYQVZMY3lGZFNsbFNGQTBBUkQ4WExlL0RRbGdSamxW?=
 =?utf-8?B?V0JIRXY0QnRXODdYYTljQ0prQ1JXa0s4K0hQbXZ5YTZJVGdydjIzQ284eVIv?=
 =?utf-8?B?dGg4c0Joc3pFYmwxR0Y0UHZrMXFJckU5M2E4WGlURUNtV0Y5NEIyM0NhTDAy?=
 =?utf-8?B?bE8zVEZnWWhudFJmWkpvZ0RCOEd3Q0R4c3JMRHJBU2UvUC9GbWVOdWlHOG5L?=
 =?utf-8?B?bHVzQ0xNT2swV25QRGtvSnpENkExeHhxL245QlZXV3VqVm85Zk9ZYkJKZXpo?=
 =?utf-8?B?L1Rzc1EyQzRZWi9tbGRicU1RQ1pTWU5qUzVqMksxWGlTS2VBbm1RVTFFZHgr?=
 =?utf-8?B?RjNuaVROMXp5NzMrcVNENjdTT2Q2eUp1Zjd4RE1yT2dDNFlXdkhaSzFabTla?=
 =?utf-8?B?d0syb2NQQ3lnWDN3MEt3a29pZUxWbDZybHBVbHpKVUV2SUNKWFMvWWpwd0Zx?=
 =?utf-8?B?WXZoV3QrRXVjeW1zSHdOWS9GMXpBaVBET2U2RS82RktXVHNublpkQ3JnRDVj?=
 =?utf-8?B?a2V2b3VxSzhmVkdibkNiZHUzcFVlR0w4SElCbVh4THc0dm05RHJNOEZ2T2d0?=
 =?utf-8?B?dUs3VjUrUTk2QjB5RVoyUHlhMXd6ejE1c1BaclNMVjBoRXk0YUl4Nk55dFRs?=
 =?utf-8?B?WktjU1Vva1pkdDFTUDVsQVdHVlh6S21QMG9nazlSSm9mQUdQMURhTDRZdklm?=
 =?utf-8?B?c1Y5bm1BQStjVzF3eWpmMmtWdlhIbDhybk5WOWh0OHVySWYzRVJHMm9uN2F0?=
 =?utf-8?B?dE9EekpYVjY1OVJXWkVRYTdjenRSQWdaUFlNb3gvZzMvUzkvQWdRcy9YaXc4?=
 =?utf-8?B?M2hBNlJjbkhza1M1T0k4dGhDVkRVUjVOQzhMQzJ6WGpHR1JWbm84ZWlxaFdv?=
 =?utf-8?B?TjI1RnkwUHJsN2NQdjRtYnJjRUZqWCtqSTMwc0VIMWx6YXpNSVk3eVdkRDhu?=
 =?utf-8?B?bGZ0cWhHTi9iZ0hSTlJhWUwwbWRKblM0QTUxVkNUcElwSG5qbnBBT05yTXdz?=
 =?utf-8?B?dE5BSlAyclVvbUFpbGxvcHU4VDREVlBkcUtvVDN6QmMvSkttSEFucG1JcVpo?=
 =?utf-8?B?WTdnbjh6ekZ3N3VBdVpqU21BcVdoOUZXRWdmQTFTWTllQjdUSThRVVdoT3d3?=
 =?utf-8?B?c3h5Rm51L3FaU1RlUUROV0RVUXp3c29KM3BHR3NYR24zZnl6ckZ6dGlOOTZ1?=
 =?utf-8?B?MXBTUkhvZE54SkRRU2ljZXhmaGRqdVN0QzNOZmxwUC9YTEdwNUpZUnJLY1VN?=
 =?utf-8?B?ZnNkYWJwRlh6WnVOdFMvWk9rbWNSZEk2ekxnWnFWYXZ5ZWNXTEVGWFZ5SENi?=
 =?utf-8?B?aWxDNHBiQkthemdsZE9RdHp6QjFoYW53T0NscnlUNHA3MklTbmNnWm40S2p4?=
 =?utf-8?Q?tlioboFBwy4Kna0eoaddJYAKq4YG6+I8YVG2pmF1+iJm0?=
X-MS-Exchange-AntiSpam-MessageData-1: bZQiiAFqie79Iv5knuYdp8X3KrsZQddSNCA=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabf8164-0c30-48df-c807-08df47f05de3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 16:56:20.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyLydpU3oF/Skc2PeESecZ7KGW1YYuY27UPRmsPZM8rwK8xdJ279r3SZz1bZBqY2N4/2cBNizl3n+eplNI7YrQnMirGlF7NtWt2NPvcMkVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7024

On 11/17/26 22:12, Bezdeka, Florian (FT RPD CPC OES-DE) wrote:
> On Tue, 2026-11-17 at 20:24 +0100, Florian Bezdeka wrote:
>> On Tue, 2026-11-17 at 13:39 +0100, Tobias Schaffner wrote:
>>> do_page_fault() enables hard irqs for kernel mode faults whether the
>>> companion core demoted the current context or not. A kernel mode fault
>>> the core leaves out-of-band, e.g. a faulting kprobe fetch argument within
>>> a kernel trap, then runs the fault handler over the out-of-band stage
>>> with hard irqs on, where an out-of-band interrupt may reschedule in the
>>> middle of the outer trap. With CONFIG_DEBUG_DOVETAIL, the BUG_ON()
>>> checking for a demotion fires instead.
>>>
>>> Toggle hard irqs and the in-band stall only if the core demoted us, and
>>> keep the debug check for user mode faults.
>>>
>>> Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>   arch/riscv/kernel/traps.c | 17 +++++++++++------
>>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>>> index dddb30711440..9f8dc6bd7b85 100644
>>> --- a/arch/riscv/kernel/traps.c
>>> +++ b/arch/riscv/kernel/traps.c
>>> @@ -489,21 +489,26 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
>>>   asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>>>   {
>>>   	irqentry_state_t state = irqentry_enter(regs);
>>> +	bool inband = mark_trap_entry(regs);
>>>   
>>> -	mark_trap_entry(regs);
>>> -
>>> -	BUG_ON(dovetail_debug() && !running_inband());
>>> +	/*
>>> +	 * Dovetail: a kernel mode fault the core did not demote for, e.g.
>>> +	 * a faulting kprobe fetch within a kernel trap, is handled over
>>> +	 * the out-of-band stage with hard irqs off.
>>> +	 */
>>> +	BUG_ON(dovetail_debug() && !inband && user_mode(regs));
>>>   
>>> -	if (!user_mode(regs))
>>> +	if (!user_mode(regs) && inband)
>>>   		hard_cond_local_irq_enable();
>>
>> Handle with care, just a 30 sec scan:
>>
>> That one looks strange. !user_mode() means fault over kernel code. But
>> what if the hard IRQs are disabled in the parent context?
>>
>> We can only (unconditionally) enable/disable (hard) IRQs over user
>> context.
>>
>> Seems that was already wrong during first riscv integration. Or: Wrong
>> API? _save() _restore()?
> 
> Even more confused on a second glance: That is already handled inside
> mark_trap_entry(), just without the !user_mode() check, which makes this
> a duplicate - for the !user_mode() case.

Yes good point thanks. I will send a V2 that drops this completely and
checks the parent context more carefully.

>>
>>>   
>>>   	handle_page_fault(regs, state);
>>>   
>>> -	local_irq_disable();
>>> +	if (inband)
>>> +		local_irq_disable();
>>
>> That was clearly a bug.
>>
>>>   
>>>   	mark_trap_exit(regs);
>>>   
>>> -	if (!user_mode(regs))
>>> +	if (!user_mode(regs) && inband)
>>>   		hard_cond_local_irq_disable();
>>
>> Most likely the same follow up problem.
>>
>>>   
>>>   	irqentry_exit(regs, state);
>>> -- 
>>> 2.53.0

