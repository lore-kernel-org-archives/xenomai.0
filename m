Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1923D7C2
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273622; cv=fail; b=tX5/QSDEEcx4PbQUxMk7Kl6dOndvdQ3Peix7tewb24E7USvHP+kF9jsY4lI3TFV/TUfe5s0MsRIzGqvMKoxy2Aifw8BozGYLgg0G1OGzlaMhZeZSnWjaeMhaBL+3V3p5le434MR9WT3XRwXIbGh3abQZIIZ2KcQGD2PQVRYvYi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273622; c=relaxed/simple;
	bh=JJJDOBlrvatFWH6UUImk3TqRS7Z1Blgfb75MG7qr1XQ=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ebol2BO92Ah1y/rmmmG3zvZW+xhtZyg47xAxw+OBiBBbm7wCiIdSh67UacRUEhuCx7MAeWnmqbuSOquye1w3JoUK+FdV+Ll9utziN+uRs02VfC7IQhFG4GXHet2+z6K/EwWXQsrmxKU1oHER/t+BxCLOBy8AI+39FPQmp4kJsZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YlX21Swi; arc=fail smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YlX21Swi"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 7327642FE4
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 09:20:17 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 2648D7803CD;
	Fri, 19 Sep 2025 09:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTo1xv9ZLbmEaKFiYMrL+aOypvlI/wk9KGw29RCkA2hWqVkHh5LKfMeeDFOYv7UAcob/zB2O782Yv+d8iz0r8nIXW80GNfMHbfbbH7P5X9JlvFwIYaXerQJ5pJr3aGElbaDzVuLniAB7mXH5LQoBUACK25ZYTNxdb/xpIkZU4sBAPI1+hw33ThXPwR26oFpmZEU9aAb96Xga3rGdBKz8/RvJyzk54bTlB9pOzNtx1DaRdNtIq5/bUsgMTdYDkJFZJCFiA9Wsf6uDTjkzAVmzD2ZqVL/5c7tzJRBd0BxAHd0OAkjETQDp7DWC02wV682tOGcmj8eCeCU71nkOvZXlag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjqALzqQFOqoP+i4twTomjxBRoBWlZEU4iAyqottumQ=;
 b=O1Tclmn67fZgAzwZydxLHKRuCCtY7MP+iegLA2E6lSsVXPJlxgioC8vpZzcjW5LA9GePEzzP67uxA15Ke8zTBypeTfP/iQwsYPL92FZjsEgj7OK7WMb/pCHtRPqo3R0r3Dz92DgEJwHqDwam1jXa66+iikY8iN1IjLwqx2DM/S5LZSemV1bBHdXMYARhrn6/eFAW+Jo8moy0xXow/d1Q3GNBgyBWjlVLjdRAZqCqQLK58Aw5xlPMfBLSEXPd8zfkjwyhjhNZzk2ruTi4mHBsxS/8WOo3O5htuD9FDoFSI4dRPywklRWrDSRzNRyDFyk03aBr8PEey/P/92bJ6wuBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjqALzqQFOqoP+i4twTomjxBRoBWlZEU4iAyqottumQ=;
 b=YlX21SwiBHEUuruxtddQt6Kt9GfKTl3PX9Uj9Tql37Z+beipREgnQ0hoAp60YiQiXREN8XdYOkvffteuG0HbR4n2n4rapZw4/aM2EQZjHayHTuG46WtcDCJlphFev2rW9Hhr1bGAH1pxZiiW3cA54UCTB8DFhLRHriB0xa1DvzpCs3YEpg8+rrHvYL2DiEZ64dHCAyIvxnz8vK0a8Bm6eY8Y8KGjdvEkq0fKwVCckWHwoG8J92C8PeuoVgfsugJG754ZLACRMCStnFy4a43bzkp1zZFFMBFW62+/v2VXDVmLhDrx09i+7T+dEPvO8jYkHARIQ5wRXO/nVzXBgWz8KA==
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB8PR10MB3242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 09:20:14 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 09:20:14 +0000
Message-ID: <cf972620-4724-4fd7-a9d6-dcc3cff85c29@siemens.com>
Date: Fri, 19 Sep 2025 11:20:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org
References: <cover.1758264904.git.jan.kiszka@siemens.com>
 <b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
 <d2758514-a501-4889-b2ab-023e0fca1982@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d2758514-a501-4889-b2ab-023e0fca1982@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB8PR10MB3242:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0a5d51-3e0b-482d-77bf-08ddf75dbda0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW00dFhhK09yWTF6MDZzUHBoZTdRcmFBVlNCNi9ydU5HdXhLSXVIVjgwTVNI?=
 =?utf-8?B?WTFycWU5RmFFanFnZG5DK25lalQ1S0hoNGc1dnFSNFhsZHQvT0JDdU9hZzBi?=
 =?utf-8?B?Z0NLQVFTbUYxNTVNZVhHOEVTMENzWG0rS1NrVjYyenBKTXMvVnNjOVpabzdq?=
 =?utf-8?B?ejNCUG1tcHRmVGNZMXU4MWR1REQ3Q0JzNW1MMUU2TlhpbDJ4c29vNGI1bk5Z?=
 =?utf-8?B?d21jcGlYeDBkNVNqTlErSjNsa2pqT2I1KzMyS0xUWkRNSmxKSVFOd1BRakd1?=
 =?utf-8?B?d2FucUViUzEyeS8vMXZRWVV4cTJXUVgyQ1F6cFFVMHF2VEtNc1RkaVVhM0JL?=
 =?utf-8?B?SU9wS0ZiYVZlTHV4MDZtV3RYZ08yNjBZcjZMZlBUdmloeFJ2anI1bmdBYU9K?=
 =?utf-8?B?d0ltN2hqUUpQVHVpLytUUjR4QXh3N3o2VW01T0tjYTlFcU1Tb00zNjEwVU14?=
 =?utf-8?B?RTJ6a3lUdWMvV3k5QkYvdmd2ckxnaVBLQkhiZDlCK3pubUQrbHN6UUVUNUJU?=
 =?utf-8?B?KzRrWEZVZmUwUkxEMmEyTXFmQTRmZG4vR3lRaHpCenljYzIyNDdTUVhhOWoy?=
 =?utf-8?B?YnRwVGtrUXZ1UGZpOVpQY3N0dE1CdjhrMkRTWTg3aGtoamFLdTYrVnJTZ00r?=
 =?utf-8?B?VmVJSEI0K0tZNXptenhPTG5iUWlsMklpNmZZc2N4anE1aGVqU1pzUmNtMFF3?=
 =?utf-8?B?OENMalNtSUJjU3dKYnZuQnBJRUdPdkJpQThiT3BnaXVEclp2azgveVc1L3Vt?=
 =?utf-8?B?WTQreTM2SFR2YUxHS2t5SXV3Q3FsekpIa3lBY2lOZE9vTzNjTUM5bkpZU2dK?=
 =?utf-8?B?RFhSVUdKTEFDSGFZclpJRVlxTmthTllXV2t6UmpWTXBCTEFhWEZ0S3B2Y0pW?=
 =?utf-8?B?UWczNHlSUHBzWDhaSTRSalVPUEExaVU1K1BwcFplOTJWUDlsa0FQRTZ0ODlm?=
 =?utf-8?B?NEc0UGlHNFBCT25xMDRyRk50QmlCUnZWRmpxZWt6SWFZajBrRUlXcFlNQ0lG?=
 =?utf-8?B?cUlicmpzdHppNThTWlRrMjMybUlKN1V1cGJPdkwzZ09hYTFOblh3cWwrenZB?=
 =?utf-8?B?RUxwdW1KY0wrMWRubXJYY1EwYVRkZ0RLVnh4SXVlaVpGNlpGa2ZYaDNaMVZL?=
 =?utf-8?B?cEJTdXdwUVlWamFkcE1xZHY0djhFVVpLMndMVXFFNHhyOWNQZWxja2dlTnlG?=
 =?utf-8?B?aGxpNU52R2xheTQrUW5FVmIwR25LZXJBZUIzdlQ4ODZmZ0JLUk0yNzhFczN5?=
 =?utf-8?B?dXFnV3RtMGlNeVduenl1NHRlaFRXTDBENVRoRWpQU1J3NnN0YWMvTFNKWWto?=
 =?utf-8?B?OTN3amlqZGxKZlB3cTZvTnJIWTFxNXBjNmhpYmNaQ0FsaWxaSkFoQ1FOcmJF?=
 =?utf-8?B?aGFUZTI3dFMxUVdoYWl5WDVZb1RwNTJDV1VRY1FEZDdUTTlCVE9iZVZKMVg0?=
 =?utf-8?B?eUhBazZhNmpMQ1VTZG1Pb0JGVnRPSkoxRWVaOVNkZHV1alNxWVoveUFvTmFs?=
 =?utf-8?B?NFpLZVo3Q2gwS290cHVJVER2Q0Z2RFhmK2tnSDFuaU80S1RSSU1UTDJ0MjU0?=
 =?utf-8?B?UVcrQU1yenVnU0hWamJUVVJ4WkhIRGg5SFNLQ3A1RFVwQlAxSlhTR1lrV1Jo?=
 =?utf-8?B?WW40MkJlRUcrL0NnSHJUWVpSS0V3SGpMaG5aRWR4QmpWd1BZZzNHUVdtK2tl?=
 =?utf-8?B?bnRreGZXZ0tHcCsrYjFSY25KcnozSG9lZU82Ujc2MHBmU3JjUFJTeGR2Q2FQ?=
 =?utf-8?B?UDNNa3lpbE5ORklEVWE3cmdtMHZ4TitpYTF6T0UwU1pqVGdPZU4zK3dpVVZF?=
 =?utf-8?B?K1JSbitoL3BVZ29NUVN3SkRXT1FPd1Y2amd3bGtHREpZb1hyQXdiUzVNbzdz?=
 =?utf-8?B?OGpkbmhTQ04zT1ZzcU0vYkFZYVpPR3Q3b1ltTGRvZ1hBRzRPcERCNHpIbVJO?=
 =?utf-8?Q?wiSTAJmY3ns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVpkL2lLbG5pS0dKWVdYenNza05DcDcrdWdCQStPYkVoM2NldkVEQnVlelJy?=
 =?utf-8?B?UmhLbUdKK3htVVk5UzNmcWpGeE55eUc1T0R2bWZqZ3lKK3JESDJvT2xYYVB6?=
 =?utf-8?B?RVBaNnJhOEduazN1WHQxR3ZMRFA2NkVNMHlvVkRnc1VJWXFEQ0hsTHdrdjZo?=
 =?utf-8?B?NkYyMTBGOVVjRGhJWkVmVWJCWjFUcFVLMkxDTjNSdFZCSVdjTlRiWm9Wc3BK?=
 =?utf-8?B?Q1hKRTd1Q2V0OUtXQUEzbHh6bVpDUkNqOTZDY05vaWhGUXQzTHFMc29DT0Q1?=
 =?utf-8?B?Um5uMFhIcFlMOE5OWi9MbkFaS1RGVllydlZ0TWV0VVZyWUV3ZWRZS3BXcnN3?=
 =?utf-8?B?UTkrL29MTjUzdGM4aFJtZEphUDBOaTV3NXBnenNnejZTT1FaWTFNdGxabWpT?=
 =?utf-8?B?WStMWjRKbzNaZnV4Lzk2eTd6anJqdFljUGx5aEZHdGxhaVNhalNGRWs0WERV?=
 =?utf-8?B?MFlnTUh6TVZ2KzhDdTRZOEFyV0JuRysyRllVczJxaWRJdzAySDlDd3VLeWVj?=
 =?utf-8?B?Y0ZLS2J6WVdkZ1JVM1lqa2o2aUpoWUQ3Y3dlbGRoKy8vNUpGb2F1V1BXMjY2?=
 =?utf-8?B?WDBWdFJOM0VrWloxVklmcm9kMUVnSm5FVVZGazFXT2JtU0lzcEJiSVliNHV4?=
 =?utf-8?B?aFFhandCbXBPeDdtQlFSWXhtSWQyUnVMTmc5STkrZ09MMW5sRDhYZVp1MGJj?=
 =?utf-8?B?OTA0ajdQR3MxbFJKL0xVam9iTXJ3TzduR1VacnlOUkQ0TENZSTBrRXZLMnp0?=
 =?utf-8?B?T2s4aHIyQVo1UTRYc0RaUHQxMEw1by9rWGJqUC96cnkxYVJBTVFPQ2syc21S?=
 =?utf-8?B?SmkrVlJJVjdzZ29ETDRTbHFqOEVINC85WDVHSnJDU1NTamVGeVk4WXY0WmdI?=
 =?utf-8?B?N2dma2l6MU5HdkdEMm96Lzg2TW9PQ2RxY3dsMUpieTNKSHpob2VjcnAvbzFZ?=
 =?utf-8?B?UlQrN05Ec25ZalUxNm1GVzB6VVlSclpkSFFuMEFyVFpxS1dhaDlnSjhzUmZR?=
 =?utf-8?B?WW9odlJTRk8vaDV0amoyWS9RMkc4OWVPS2x3eUxWbVlnWnhONWt3clVIQ2g2?=
 =?utf-8?B?dUhjWkRWQkJYMzhCM2prRXVQdFVtMTNTS29JdVlhN3FKcy96UzdkZWpjN3B2?=
 =?utf-8?B?aHFKellYRjJjVnR5emZ6U2UzUXpSWTVaWmlOcGMwMGZPUlhUZ1BIYWdWL1Zx?=
 =?utf-8?B?SmJBQjZhbjhJMDlvTUFldngyN2s5Q0V3MER0ZWx1SGlUSkJpSnBuV2dWTzhT?=
 =?utf-8?B?cDhjLytMaExsOEo4eHpTczM1WFNEQk5qT3I5YlovOUsxa2I4STBkdGQxOUlh?=
 =?utf-8?B?Vkl3bEVJTEpQOGJZSFR4N2o0QXc3Y2RBanQ0L2lVRVlCVTFMT3Q1bWZDdnY3?=
 =?utf-8?B?cit1Y1A5eTY1VkpRdWtJdDFmZGFOS1NOMjRvVVlXTjRIUk5pUVFIa044M3FW?=
 =?utf-8?B?NU54T1NtbWtFRldrRGlJb0VmWnVyQ0Ewci9DTVJjSFVXb3NoQkR2aTJVOFN1?=
 =?utf-8?B?TVJsRUVObWFESXM1ZDBiOEtqWm5sK3psNTB2RVhCN1ZJSG1DNUpHcWE4VGNh?=
 =?utf-8?B?NHQvN2w1Um5lUk92OG1zalVEb2Q0WkhYalRKQ3NDOUlHTFRMb2htb1dkbVVy?=
 =?utf-8?B?TnZSOFhQS3RKUE5GMEswaVpJcldjcDYyUE5NNis4cExWS2kzV1gwNlZOMXJR?=
 =?utf-8?B?TXlvdUNWV2lpc2VnRXVpUk1JTUdnUmNpb01BUWlVOG82cUhtWDBpeVFhVGVY?=
 =?utf-8?B?d1FjTjh4ODB0dG5BcXlNS2NqZlk2ekJCQlZDdWJiWXUvZThzUFhUQ05KalJ1?=
 =?utf-8?B?cFVuUE1sbDI0alJWdmlMS3NjNGFhU2lJRGlmdHI1ek5ISEREK3lWeElvd2hW?=
 =?utf-8?B?Z29yNWxobys0MVduRXR1NTk5ZkJBTTBtS2h6TXFkRWxSaEt4WkVUS0w0NlhJ?=
 =?utf-8?B?bWxhTW9lbGpNVTFXVkVHZlFVQ1ZNSW5tWTFmams3ek41aS9XbW9jTXFzNjJW?=
 =?utf-8?B?RjBUcStFVklxcGRIQkl2MzVQU01XUWhSZWtldStPYjVnZGxVYW5JRFMvdExv?=
 =?utf-8?B?UjdrU0JtTEh5Nk1zYVNVYTFNSkZKUW5FdnhNSldKY3p0NzRHdlFKZnpLamdh?=
 =?utf-8?B?d0VKOCtoN1doWVIyZHh4dHVDU2VvS1FVOUR0NTdsVGZQTnFmQXBEa2hDSUNs?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0a5d51-3e0b-482d-77bf-08ddf75dbda0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:14.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0IoCxeot2QnGLV1mdLWf+uJ6Q6JHr7Cv48cdR4lXKGor0+gQsZ533uehJ6OlnJz/QgGkvVoZpS4ffa6PG+HRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3242
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=YlX21Swi;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c201::6) smtp.mailfrom=jan.kiszka@siemens.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffgfuffhvfhfjggtgfggsehtjeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepgeekkeejhedttdegueetgeegveelvdeuledujeefjefhvdetgefhleeivedvkeetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddujedrjedtrddujeekrddvudefpddviedtfeemuddtrgeimeduhedtmeejieemmeduheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddufedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On 19.09.25 09:18, Jan Kiszka wrote:
> On 19.09.25 08:55, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Not all callers of this function do that themselves.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm64/kernel/fpsimd.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 83b8492984982..ba804fcdfdb3f 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -1951,10 +1951,10 @@ void fpsimd_save_and_flush_cpu_state(void)
>>  	if (!system_supports_fpsimd())
>>  		return;
>>  	WARN_ON(!hard_irqs_disabled() && preemptible());
>> -	__get_cpu_fpsimd_context();
>> +	get_cpu_fpsimd_context();
>>  	__fpsimd_save();
>>  	fpsimd_flush_cpu_state();
>> -	__put_cpu_fpsimd_context();
>> +	put_cpu_fpsimd_context();
>>  }
>>  
>>  #ifdef CONFIG_KERNEL_MODE_NEON
> 
> This one is actually vanishing when rebasing over v6.1.151-cip46 which
> has
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=8f4dc4e54eed4bebb18390305eb1f721c00457e1.
> 

...provided some "flags" argument is provided to
get/put_cpu_fpsimd_context which I didn't do above, and which should be
done while resolving the merge conflict with v6.1.151-cip46.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
