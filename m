Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211964;
	b=PgpJ35Uy2X5+/PgJqR489/CevcV7C2QzxF/HfBEkK2rp9CfwXvr7moQO2vfarEp0wWwe
	 0gxzj/yYuySiP29nqLPmD5mUIz2e3gO2PQBprbuwA/rlHdPe1QFElQdAagwkNrCn789Xm
	 mW49jmo07jfOGhxw8htb1dSOa1g7mOf8nSjp88WR2TBOaMHP3o2nvQVfzdF/QLel7Fapk
	 pgQdlDbUfvOo5l/vfpfDd/f1lt/K0MTCQDbN4svxxDCc4qg0g7ELKwvLLy9ZaxXttVuz2
	 EBG2H+9pXm5LZMJfjE2+OlycLF6oK6eSskz8YJxZvqzcBMciG4mjO7PqvqvCGACPCJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211964;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:From:Subject:To:References:
	 Content-Language:In-Reply-To:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-GND-Cause:
	 X-GND-State:X-GND-Score;
	bh=gfMqJdZ5pAiiGb42GPHCvmzUoa1YnZE9KMk9C3z94iU=;
	b=XX5OFmGT7HCHZnb1zW+JjvAX5/NkftN1q2dSvg4AqAXA54pBCvu+nOHlX7ztC/Zrap+e
	 axHRVjEx78rnpn4jwINO5s8gpMb9FJHkEhmkm1qn2C0kfaXkqDUOAMeakKI+jgi68941x
	 weAeCtk1VfJe2vo3D/UQp4B+d/yRxgjn9BhnUtnb5oESiOL0Eqq2EhN0cTs/XAwf3veXT
	 jbqulPJoPwT8V7N6XgX6dg2INgO/GEWo3GMa9asEZyaDoLdapJhMxSU21x9manjRkQ6lI
	 jhxmYjwc2SKmv35pDZfkrgnNYgcFR4GVoz2G+mkKc1JVbKi+yoi0TmbR+fkxF8Inppw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=0Ll2zLkT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD561606A31C
	for <xenomai@lists.linux.dev>; Mon,  9 Nov 2026 08:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD561606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=0Ll2zLkT
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id E46A03EDE5
	for <xenomai@lists.linux.dev>; Mon,  9 Nov 2026 08:12:41 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id AB55B27E00C9;
	Mon,  9 Nov 2026 08:12:41 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=0Ll2zLkT;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c207::3 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6mFYvx1cGmBmkLwYohLoTSeWGDmOdsTHh+p1fO2UPr0HFcNOiT9eT16kdScf/JzyYxaeKyaHkEupzwY/Q9R8z80WwGF3Ny5nZI34Gm7LJmDF4p1Bw2IyzxFVYkhPYON9V0C+k6NUfHvWtPHKrggfmMkkwB+2xC7KjPAJc6FNeQBZW9Wa6DcQHCOqR5ySwmcapYTMVwM0V749ONloCMmKePYukqGcXfkNWG7BGmE6D8bRtp14KOSgNxKUzpynyrXGvilkknD8uBuIS6G+e/VYF8ZmF88qcpGKVcCeHWPS6fY6VqV+IBN172jz+k+sRYn8PaUS0UlU9QE3i3uFqMdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfMqJdZ5pAiiGb42GPHCvmzUoa1YnZE9KMk9C3z94iU=;
 b=so9F32IfAW9g9hIcLJM9CfKe93baK6if+cqhOpEFJVUqmWkJ1TdCzCgG7cyl9NHwK02ygJu3U0gotHh+JfulLrE9P7KUl0diWY5k7pCFyGi+XDFWZEvawpXj011OUZoNC8VYCwVjxLp8LSETumUryVm+jBgYdhXWL44P6/wBmK6DjD2NJL6D0dju3/aN8EN6/L12/MwjFrwEyxWeIkMfvXz0xT29wEONebJZFe1An3joPjybTkSBK4NjTZGjM5qMFVLbPmn6XW6/LLat3NyjX9Nh1kwokCfat+v9ECrM7NuIeejWsdNMpWicShjLWDmOi31tL9+4z3vutC9AdR5QTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfMqJdZ5pAiiGb42GPHCvmzUoa1YnZE9KMk9C3z94iU=;
 b=0Ll2zLkTt75xx17BXBNZhdgZXrMkxBhxsWGU6IC3ZJdu321aXB4MFabcdj3J+SqICPlJ6GxIEFCK9Gh4lwrrHEz9gM68++1aPco6ereTynvwEo15m0y/XlYHhdsP89N1rxIZ/b7HJX74yu5e2ju967DUP3FQI6hPT148gqmIt6/+VtgcZHcMhdNm1kMETEqxPGVUq0LUkh6qfWYZnbXNjQrbjC8Z4BM74Hsg5yogL3nrjr+wratJHdaPtut68R71Z3IdlWWbGB5r2d4H7c3PwKmKAU9DjSSGM2m8UgPnzbPXGo10bwLIFFFO1lf9slRA2hanXJBpkSeNVRI95Tfmqw==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM0PR10MB9647.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:743::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Mon, 9 Nov 2026
 08:12:40 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 08:12:40 +0000
Message-ID: <2f03a05e-d5c7-4c01-8f61-6f68a10ed298@siemens.com>
Date: Mon, 9 Nov 2026 09:12:39 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH 1/4] dovetail: Track the owner of a trap
 notification by exception frame
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
References: <cover.1794208121.git.jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <cover.1794208121.git.jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM0PR10MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: b41a0f00-b045-4f99-ad71-08df3e393929
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	IJfU8kfC3KcT/8+IXTJNV8DZAky9s7K/4W2hXFvEgphBhIJv07u1wCptaBR86+X2MLe0NYDN4eZvzwaiRpKTY30QKqXT5mmRess4V8nRNO+r3ccGx84aTSV+gVlaVfMlU+pI0i+LMEZ87wauyaI2bhiFg/MpVs5W4afVok8NC7JQCNz9MB5Zjb54SRri02UmvpdN2n9EFeq7tShNARJpOvwMjX0b9QGpszSulhSli8j6DiwgjPAb0EN6E4SmGHfYPgBt+FV2c+kmUDInk3AquRgNRACBT/iKLNftC3WYHlupa4pPBEQ0kxPOz7wQrKEUQcLYDYnyO7uBVgUSrX5yUu8Wac2T/1El8LGeg4pee/Umy4dzq2a7usr36OTi5isRqMRhgvgVRwlgwBHIIJ4HFBXiuI1deMt53iXIJKAK2okZEHQ1c0PyBmM6NuawxzlBhMXNrdExp4LAh9uCANR7EvM4GnVNjoTceqLlFdS9YiI4dvu7CKcSFfjUtZEVoIqztVM3SUPS9IYwnkHB31fkoVLQfkdYyDSmAJiSTTsTXsNbzlBLQFI78pQh1fVnOpNq8eC/apD6XG7wHAE97AHjBeHC+ET/191W5YuuA5rhNxIQ0It5d+3H9sZ4jFKdffHSqdF3rORKL9+KIIEQs9w56wWb3CXr3AWy6RT+xHiZs9A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0FHM0RBQjlhOVBiUFdkd0M4d3Z5M0FSQVhXVEFxaFJiemJPRWkxazJVQkVj?=
 =?utf-8?B?V1gycUxwNDBOZWFOWnkveUxmUGJDZ0U3SFN4R1VsNTBmQnowQzdzWURnN1B3?=
 =?utf-8?B?U0ZwK203bGx4NVV3cyt6ejFVdUhkak5FZk96bmtsSWhIUE5oZS9xcXhNb0U2?=
 =?utf-8?B?ODRLTFdqV2xvdEd3aFhLdkZObUhKUnU0eTRiUUU1Q3p6cVRYZ2lkWmtzYkRC?=
 =?utf-8?B?UnUvSDRaWHd2VWw0NUp1dTRXMURQNU1ydUsxa0lNdHgzdnVueTk4aUN0L3B5?=
 =?utf-8?B?R2cxVUZ1YnEvMk1jaitBbVplb3VxeWFwU0xveUt6WVZDNmN6azNSakpDRWdq?=
 =?utf-8?B?YVdoNzhxTzdYcEMzcnBRUzlTczF0dmMvR1lyQld0cnhNQUpzSU0zTVBrektj?=
 =?utf-8?B?OHQ5dFNNVnBTZmd5K09qdk42Nnk5Rkx2NDJQaFgvRmpvMG0xcDZEaWkzeE9J?=
 =?utf-8?B?RWdrV0JISjR6Y29TZWRvV2VVNjVrakZ3ZWNCVGRVUzFmd2NybmcvcUNUVTc1?=
 =?utf-8?B?UmQ5VDhSUlFrM3FkeE9ld0Y0NDNRM2VtV3g0ZFVpbEJ6UTNHTkJueGUvZHlK?=
 =?utf-8?B?UEJzSStsN3l6VGdrbTl1VE1DOHlEMUM1cnhIdUZqZHA2cFNOVG5RY2lMUW80?=
 =?utf-8?B?dEp1NlpoUkt1VDNlQjlSZ0ZBaDYyMlZkbGNUSHYyY0xoTlRiOHFoeVZGYzQ2?=
 =?utf-8?B?SDdvdlZVcGVTcHhwNVRCc1JySVEvL3M4RXhURVlSVkE5M0RReUs2WGU3aGNj?=
 =?utf-8?B?SW0xYTVVUkFCMEJMU05sYmFSYm9RRCtkYjFvaU5VNEZUb3FvamhVc05pZCtP?=
 =?utf-8?B?WHdScHVTRTYrY2VzU1FWQnNvUjZBUFFLdXJUZS9McUh4Tkd3UnBBM0p1N2dE?=
 =?utf-8?B?RTdPdFg3MkNsWEZ4TkNtVm1jeXNGV2syTmlvallMd2NKOHBtVi9jMlEyVi9I?=
 =?utf-8?B?UzRkNU1yRE9xMWtvdVhxclNKOThwUVY2WGVLTDQ2VnZ2WmNjQ01SeEtWUmZk?=
 =?utf-8?B?MHA1eTlNSEROWVc4VzZCSGdTMjVGNUxZbTIydFFXNlFLVS9CdVJsc281MVBj?=
 =?utf-8?B?OHlqdEhjWUpoYVFPUmFsNnBIUzEwSnRiOTNaalVBeWoxVGdSbnYwNkZvcjk3?=
 =?utf-8?B?NlBabytjZGxZRmJ4dlZGNFZ6SHhOTzJZcm92enZEbWJwdmk4TGlEQ2FhNmx6?=
 =?utf-8?B?NnRMMFJPTm9MUjhncmN1SWNaMUJ4ekVReGU4eHpGTDJPQkpaYkxuVVNMUW9p?=
 =?utf-8?B?d0FyTm14MFhEcm5Yc1FHUEw5L3pxd0lkQk1wN3hLSlRxQ3BTbllmd2VDNjJZ?=
 =?utf-8?B?eUdPODluWmk1Q0U4MHZLd1dnSWpkOTcrOVp6RHBrRmNkY3BaWDJocDZvd1k0?=
 =?utf-8?B?SFNuaXlWaklSWi9KcjVnRWNyMTl0OVhXVDBaUDNicE1YUkRIcHNBdmdUUVNj?=
 =?utf-8?B?OUo4UFV6a0x5TmdZbGFPa0wvY0RiZW1QQVZaRm9FMnNYRUFBaDc2SlVvUWVm?=
 =?utf-8?B?WXcrQ2J5b0F6K25zSEx3SkRCQ09EWGJJM3JVQmtjWmF4QWhYQUJyWXNyc2FF?=
 =?utf-8?B?azZMM3IyaU5JdERKMlJOZzE3ZkpGQjVWSVpzVG9XaHkrRkhFRTRXSXVXMDBN?=
 =?utf-8?B?WWREOFpFZ2czbDhlbVh4MHhyK2tLaTh2MVVRY3lCbWdQUCtJNTVwVGl3U0Rz?=
 =?utf-8?B?dGYzWlJCUE9VTzU5aVNMT0p2Z1BXcllFcGl1TWVjaUhweTBUTzZHTkxqanpm?=
 =?utf-8?B?bjhweGxkU1FqYkpaeU1QSUNPdHN0UWZkVGpSakoxZnZGLzhweWtIRFFWN2hG?=
 =?utf-8?B?V3pGZG5vVllpendmYm5wTWxkMlc2Q3FZV3BOSXVncHdCbjByU3RPUG51UUpJ?=
 =?utf-8?B?YTFGOTRnd1RLRXVqVmFxcnBGYjdCZ05USEFVTUFNbmJMdGVjcmNHYkZQOGdy?=
 =?utf-8?B?YnZ1aVFISHZpUzdwbkNLdUs4emlySFA5WEtKNHlDY0F6dW1TcnhzYk1WSVR3?=
 =?utf-8?B?dll0WURub1FzMWxSSmdaUEM2a2czVFp6aFFQNmxOYnpBaHhBS1NjRExNWDQ0?=
 =?utf-8?B?eWVHYUxWcTZ2cGlMMWxUYU5VZk9PUzZZak9rL1JzK1h4VlNZTE5ObCt0K2RS?=
 =?utf-8?B?bUZTc0piSVZZSlVVaDM4MHRacFd2OStLQW9UdEtpUWE1dG9OaTRXVjFGWmF3?=
 =?utf-8?B?cFhpMDltVkg3SHJRaGZjY3hmbDJLSnFIWUJqNWhwZ0VnWmlaWVM5N2pQbmY5?=
 =?utf-8?B?RTliWEpSRi9STi92QVdUVHp6L0d3ekVTdk5zUEh3R2NwMmNEN2RiUFJRUG02?=
 =?utf-8?B?SCtOdkJkSmxRWCtPNm04bWNlWlcyenRKQXpCcUErQlZNSUVXRzdWZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41a0f00-b045-4f99-ad71-08df3e393929
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:12:40.4113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4aUDqfuzQQxpN/upPgDDaqvc/CZHsOVL7y6AP0M+E/3grzoBCznQba+vjf5VaBE9XpcKreTzKjJWp0cbJD04bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB9647
X-GND-Cause: dmFkZTFrFPEhFPgoYxCtywDHBNekYJ5qasOM17bolBcWyWY7GAJLWD3nct3omPx4V8rq0yzY4oK7rCCuLEiw0MjArS5hHEfLOHvKEtz7gh/EwwiAJRySN2W3EErZO9qHAwqvukE9lc8hSUror4tBURZS21oq1ZZ9I4xXjYQgoXXVisAjCLoqkdGZQK0frSbCIj3xsJecnJAxCrZOu2jI+BjUj2VLL3h0yrzX+eCXzII7LS7VN6l9Z3MChkVdXaVimoD1FHJJINik4JjYY6xMEumR09SGBGTHKwaQtj2kKfPKWZ/Ty85clxTubFQSXaEn0kban9mqY88YAtfwUi6S8moEDGR0qFbD1TERFZYorJ+4AGcsOuz/dE5JHQMy7CZt1aVVRjLsClzL6azA82XsdEWmsoAhVmZ9xxWLLT3cXM2pcO2fNGU9/qltnIAs96GtvXl1TeACuX3GdJanVNAuERGc8hsTMM/2v8vLiYWu07oL0/eLpKJj0NrBNyaP/fvCyjVJL4oRxZFi+ST7QNbSD+pZZiz/mCxi63awtEVYYCHELwRXGddWsTgJ822Rfvnd8knERl70R7JKFemaBNqceTOJoXRV4savbHsBbWIAohbcrn8gjaVam398tEyeHT5wMy/W3u7hWlb+3iLNcvzvjwOSa304RUc93MknJi9LGW8WvVGP/A
X-GND-State: clean
X-GND-Score: -100

From: Jan Kiszka <jan.kiszka@siemens.com>

Trap notifications are guarded by _TLF_OOBTRAP: oob_trap_notify() only
calls into the companion core if the flag is clear, and sets it;
oob_trap_unwind() calls the exit handler and clears the flag whenever
it is set.

This does not cope with nested traps. A trap handler running on behalf
of an oob thread may trigger another trap before it reaches its own
exit annotation, e.g. a user access from an emulation handler faulting
in a not yet resident page on ARM:

  do_alignment()                      <- notify, _TLF_OOBTRAP set
    do_alignment_ldmstm()
      ldrt/strt to user address       <- translation fault (SVC mode)
        do_DataAbort()
          do_page_fault()
            dovetail_fault_entry()    <- notify suppressed, fine
            handle_mm_fault()
            dovetail_fault_exit()     <- unwind fires: wrong trap number,
                                         wrong frame, and the core may
                                         switch us back to oob
    ...emulation continues oob...
  dovetail_fault_exit()               <- no-op, flag already clear

Since _TLF_OOBTRAP is per-thread and the thread does not change across
nesting levels, the flag alone cannot tell which trap occurrence owns
the notification. The exception frame can: every nesting level pushes
its own pt_regs on the kernel stack, and the frame is already passed
to both the notify and unwind helpers.

Record the owning frame in the task struct when notifying, and only
unwind when the frame passed to oob_trap_unwind() matches. Inner trap
exits become no-ops, the outer exit unwinds with the trap number and
frame the core was notified with. oob_trap_regs can in fact encode the
semantic of the _TLF_OOBTRAP flag, thus drop it.

A forking parent can never be inside a trap handler, so neither the
flag nor the owner frame can legitimately be set when a new task
inherits its state. Add a debug assertion for this in
inband_task_init(), which turns an unbalanced trap entry into a
loud warning on the next fork instead of silently propagating the
stuck state to the children.

Assisted-by: opencode:Fable-5.1
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/include/asm/thread_info.h   |  1 -
 arch/arm64/include/asm/thread_info.h |  1 -
 arch/riscv/include/asm/thread_info.h |  1 -
 arch/x86/include/asm/thread_info.h   |  2 --
 include/linux/dovetail.h             | 12 ++++++++++--
 include/linux/sched.h                |  5 +++++
 kernel/dovetail.c                    | 10 ++++++++--
 7 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 23cae59037c1e..12ab7e49b7b76 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -196,7 +196,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define _TLF_OOB		0x0001
 #define _TLF_DOVETAIL		0x0002
 #define _TLF_OFFSTAGE		0x0004
-#define _TLF_OOBTRAP		0x0008
  #endif /* __KERNEL__ */
 #endif /* __ASM_ARM_THREAD_INFO_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 48563d782a99a..934b080246146 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -144,7 +144,6 @@ void arch_setup_new_exec(void);
 #define _TLF_OOB			0x0001
 #define _TLF_DOVETAIL			0x0002
 #define _TLF_OFFSTAGE			0x0004
-#define _TLF_OOBTRAP			0x0008
 #define _TLF_KERNEL_FPU_PREEMPTED	0x0010	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
  #endif /* __ASM_THREAD_INFO_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 820a596d9bf65..11164e12317fa 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -140,6 +140,5 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define _TLF_OOB		0x0001
 #define _TLF_DOVETAIL		0x0002
 #define _TLF_OFFSTAGE		0x0004
-#define _TLF_OOBTRAP		0x0008
  #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 6da425bc87712..0c9cdf60e3f12 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -218,13 +218,11 @@ static inline int arch_within_stack_frames(const void * const stack,
 #define TS_OOB			0x0010	/* Thread is running out-of-band */
 #define TS_DOVETAIL		0x0020  /* Dovetail notifier enabled */
 #define TS_OFFSTAGE		0x0040	/* Thread is in-flight to OOB context */
-#define TS_OOBTRAP		0x0080	/* Handling a trap from OOB context */
 #define TS_KERNEL_FPU_PREEMPTED	0x0100	/* Dovetail: kernel mode FPU section preempted by OOB */
  #define _TLF_OOB			TS_OOB
 #define _TLF_DOVETAIL			TS_DOVETAIL
 #define _TLF_OFFSTAGE			TS_OFFSTAGE
-#define _TLF_OOBTRAP			TS_OOBTRAP
 #define _TLF_KERNEL_FPU_PREEMPTED	TS_KERNEL_FPU_PREEMPTED
  #ifndef __ASSEMBLER__
diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
index 1140c5b7c99f3..645d1eec32aa6 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -62,10 +62,18 @@ int pipeline_syscall(unsigned int nr, struct pt_regs *regs);
 void __oob_trap_notify(unsigned int exception,
 		       struct pt_regs *regs);
 +/*
+ * Trap notifications do not nest: a trap handler running on behalf
+ * of an oob thread may itself trigger a fault (e.g. a user access
+ * from an emulation handler), landing into another annotated trap
+ * handler. Only the outermost trap occurrence notifies the companion
+ * core, which is told about the exit when that same occurrence
+ * unwinds.
+ */
 static __always_inline void oob_trap_notify(unsigned int exception,
 					struct pt_regs *regs)
 {
-	if (running_oob() && !test_thread_local_flags(_TLF_OOBTRAP))
+	if (running_oob() && !current->oob_trap_regs)
 		__oob_trap_notify(exception, regs);
 }
 @@ -75,7 +83,7 @@ void __oob_trap_unwind(unsigned int exception,
 static __always_inline void oob_trap_unwind(unsigned int exception,
 					struct pt_regs *regs)
 {
-	if (test_thread_local_flags(_TLF_OOBTRAP))
+	if (current->oob_trap_regs == regs)
 		__oob_trap_unwind(exception, regs);
 }
 diff --git a/include/linux/sched.h b/include/linux/sched.h
index c4291b7f7b6ea..3012926e8e355 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -74,6 +74,7 @@ struct perf_event_context;
 struct perf_ctx_data;
 struct pid_namespace;
 struct pipe_inode_info;
+struct pt_regs;
 struct rcu_node;
 struct reclaim_state;
 struct root_domain;
@@ -1302,6 +1303,10 @@ struct task_struct {
 #ifdef CONFIG_IRQ_PIPELINE
 	unsigned long			stall_bits;
 #endif
+#ifdef CONFIG_DOVETAIL
+	/* Exception frame owning the pending oob trap notification. */
+	struct pt_regs			*oob_trap_regs;
+#endif
  #ifdef CONFIG_LOCKDEP
 # define MAX_LOCK_DEPTH			48UL
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 16ac66e4529f5..f196a9815dabd 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -22,6 +22,12 @@ void inband_task_init(struct task_struct *p)
 {
 	struct thread_info *ti = task_thread_info(p);
 
+	/*
+	 * A forking parent cannot be inside a trap handler. If oob_trap_regs
+	 * is non-NULL, some trap entry was not balanced by a matching exit.
+	 */
+	WARN_ON_ONCE(dovetail_debug() && p->oob_trap_regs);
+
 	clear_ti_local_flags(ti, _TLF_DOVETAIL|_TLF_OOB|_TLF_OFFSTAGE);
 	arch_inband_task_init(p);
 }
@@ -284,7 +290,7 @@ noinstr void __oob_trap_notify(unsigned int exception,
 	 * to the in-band stage, may return with hard irqs on.
 	 */
 	if (dovetail_enabled) {
-		set_thread_local_flags(_TLF_OOBTRAP);
+		current->oob_trap_regs = regs;
 		flags = hard_local_irq_save();
 		instrumentation_begin();
 		handle_oob_trap_entry(exception, regs);
@@ -306,7 +312,7 @@ noinstr void __oob_trap_unwind(unsigned int exception, struct pt_regs *regs)
 	 * stage. Must return with hard irqs off.
 	 */
 	hard_local_irq_disable();
-	clear_thread_local_flags(_TLF_OOBTRAP);
+	current->oob_trap_regs = NULL;
 	instrumentation_begin();
 	handle_oob_trap_exit(exception, regs);
 	instrumentation_end();
-- 
2.47.3

