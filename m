Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B221CC71
	for <xenomai@lists.linux.dev>; Mon, 17 Feb 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805577; cv=fail; b=Uhsi8Ic1rO6piiJYapGtNctuMNEeHceutjDKAvaexCJMsm7ZnE5lz7/13zHmyACAHqI6vX8yHBZYsVlPxXbCeMwv4EZeOS4VZB7tqH1aJiFcSiJf182p1JHeS79lcN0KQhTtRDXPgLvX/3oBczAK0/2qa88TQHqp+YT9aOmiJt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805577; c=relaxed/simple;
	bh=QzZpCVFYGThdfVL3KB/gxu+TiGoo2FvaiBUb9sHDdGA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=huERTIWhz7wviV6U6znCxc2pbrvG6T3GGbuEB7xSSOXiCq0+VpfFzky6vFBgoccRxWkFFqXmAJ+1S6QWgnYDzJWzMJov1jcT6pjAvSfMvM+B+fPN1Wg70iwHbevGbMZDwcyLTclFw9N+l9yO1+zwG/+uY/RydaogkvU9YOB34QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qApdYwNB; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qApdYwNB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYzJv2iCj2g/HMOTdNT/AEG6/nYLixW7aBB66Oe+Li5rTKP5ICWTc6P6QpB/nOf0QO1+KCemzGIlGieWEML3qAB6aiuz+/6lei991IVevthpNrQCxOpw51gbZJkq6Ue4cPO5nRJReJXDw6OPKolPBH8KBGK679OhDIyBUMwxvIKrj9d56U+yLcU9BT8ur+63cvzdbdciQ73gTqE5m8aL1Bl/wZoUec68MTNX2pzxtsJKOHH29JF+OoQ6ZYPBHwxcxRmYcQtAjYdmkuEzyJch9jP58HUzWphGos7+F8gx6D23jBORdIu+lO/jre+0By1YLUB3n4wB4uImK69AH86dQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbWs1tq5zzGtF1Xz4YvjHX5yLwkk5Dry1xpU6KPhXYk=;
 b=uXyPfd3/GKPO21HBkulv/4cUCglSgnyrgs0xTxaNM4YLTOy5f3BLhCbcMGdANJLnpS4/sBLdJGgKHVFQO1SlL3PRn4158flbO9YH79LhSEUo8T2FY3O18oKu31fmoenD+qZKQKboRAIcA4mRr2swwJgqBFpw5vH1HyNkItWY57kODQSBULw/cvU9aP08SwteALVcObiwdKpAlmahIuu3BpZ8zy7ys/aaCUcoIsVthABA35lSZt3m1ZRxNrM+KOtEwxkS/W0/D1RwwB+XXEXieOKgyggNpesf8vB/JaAfEHVP3KZcbOWDsXuTNAx2QH/myE+HljlOQspUFk+tMpzlhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbWs1tq5zzGtF1Xz4YvjHX5yLwkk5Dry1xpU6KPhXYk=;
 b=qApdYwNB1Y+iUB2qa/peBpz3hFT30tsQhL3E10UJlRrfVwhrB3zMQQWRz8brrm3b77zgjawcHMCpUGNtbA+gPynWICwBtxFyIdFeE7RAVwfg3FS7iP7MDWTfov0QhF6cbhr5pN4PekzQ2D8MxQrr5ED03DQ6xUQFCwWtSKmnoioVOzZI1D5mDOKQ6OKVRSsCGbJ7kXqLZRbBNVc46qyNA5lOuUgdG8c3tF8LnQq2udpE6o6NVKBauXifyej9c+vjnkIeJUSj1rRn8PlwSrgSCA7buQZhpU3U1f8POqI9HeKJ4ZHSI9I1Og3SZyzQCqCSCIeXUqBgFlRzyMwUWvceIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Mon, 17 Feb
 2025 15:19:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.009; Mon, 17 Feb 2025
 15:19:32 +0000
Message-ID: <23280aaa-d95d-4ae0-8ce4-ebfcdb857e44@siemens.com>
Date: Mon, 17 Feb 2025 16:19:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with moving from Ipipe to dovetail
To: =?UTF-8?Q?Marc_Str=C3=A4mke?= <marc.straemke@eltropuls.de>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
 <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
 <fac0181a-eee1-4820-ad8c-ea2b88629f5f@eltropuls.de>
 <a398fe9f-d3c0-4254-8a9e-5fe0eff25f86@eltropuls.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a398fe9f-d3c0-4254-8a9e-5fe0eff25f86@eltropuls.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3331:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb2add3-4d31-474e-e972-08dd4f667a91
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHJudm5EWmtXSlQ0SFlTN1hVM1dxVXJvZitiNHdjYXpZOHozZ3h5TXp1MVl3?=
 =?utf-8?B?MHhYdUMrdFNzblNWa1R5UWVGRHVmNGlJWUNtUDFnOU04blFJUXhlZ2JJcmVQ?=
 =?utf-8?B?VXhFQkJoM0k0Y2paSnlKMTdTRHpzRFFtMFgybDhZTHpkYmtsZXNKRE0yMFZo?=
 =?utf-8?B?NDZmbVJKWGZIVnBiRUJtT2Jvbi9idGhIQ0xIRlNxakUzOUhtODM1cWE0WmZM?=
 =?utf-8?B?VmsxQzBSVlMwdlhlTjVEQnNWY091OWdiN2NzY0piSTY0LzJnMlo0WWswNDRL?=
 =?utf-8?B?dFBTT0puZEpCRXhJbkpPcjRCdVRUQVBvQkJ3TzkvQjhNdXNXOEJNaXB6L1BI?=
 =?utf-8?B?MkUwVmVPTWR3czJaV3ZMYVdEOXlXL3FDeGtSNXlRK2lucGlWUWVXY1FXTUE2?=
 =?utf-8?B?d1loMGlVV2l0TTZ6cFlnQVpZUW1lZmZGMFc4Y1c5UXA5THZVOXYzTjFYQmpO?=
 =?utf-8?B?M3g4cTZnaTJnbmFpSUlmZlpXOXBsWTcxMTEzOGpncGZrT3NNRjc4aVRmZzlq?=
 =?utf-8?B?M3pDUTBYTkJTdDEyZWh2SWJ6QzdNQVpPUTd3NGtkZGN4MkJwakhVWUV1Rmhj?=
 =?utf-8?B?bEYxeHFzWkxjdnVrSTJEQUhXcDMzRmltVlBuQU5TVFF1OXVoRlFHOUlyU3Zj?=
 =?utf-8?B?UUN3SHE5cVZiazBjZUJNV1luUkJwazdFcjhyZUx2R1Z0S056Y25QdmNIa1BZ?=
 =?utf-8?B?QXJrR3ZkYjNtT3lJT3RBRTRFejQyNlU2WWFqeXBRaGlvNzFDS1JDOGd5U0No?=
 =?utf-8?B?WTh5WThMQml0NGl6YnhmaXVhSHdHVEtFM0NNR2ZpUmtkbmJBUU1ZRkxKUmJl?=
 =?utf-8?B?cU1HeE41aUY0Zld0blJmanBTRXdJTWtvVjVRUHpJTk5sSlRsRFF4dmh2UnRt?=
 =?utf-8?B?NlNhbUxtcElxRFFtQVZ4SXU5TmZxVW8rdmRiaEpyeWo5NytSNWRXdGFFNjBR?=
 =?utf-8?B?THdLcnFBUHFKbjdDRDZlcXQvZWI1cUd4Z2tIb09pdHdhY0pIZWNsbEptbG8v?=
 =?utf-8?B?a2tudjF1TFFaWE5Bb2hJV3RmdDFJNlc4MStwR0I4ZlN1cWhMRHhEdEVmT2xo?=
 =?utf-8?B?b1Y0QXhBYTFVbm5NMm4rQ3FvV3lLWkM0WU90VjZ3OWhhMDdwWmxITi8yZTN4?=
 =?utf-8?B?Vms0dWwrUHMwSjdESkRkRG50bnNHYWgzOE5QN3BhRlhSWjhOZWZEZVEzMy9p?=
 =?utf-8?B?emVRVEFMNEVNM2F1cnZpMmFlZ3Y3UmM4UzFiNEQyNGNIWE5ySmYzcTBOY3E0?=
 =?utf-8?B?NjB5YUdwNGRXVTBuSHh1c0xsMHVXNjBLUjJxaDhub2tHd2Z6cTZ3NGVFdkZl?=
 =?utf-8?B?R28wTnkvcE9PSEc5YURVTVdVNHdYcmxNOFNjeENmeDBLMldvd0gwZ2E3SEtl?=
 =?utf-8?B?ZEZMSVJYMTV2RnUzaFlBMW5wMXZWUkFJNkVwdWdqeFVzRUtzbng2VnVJZVF1?=
 =?utf-8?B?N3JsTjI4NStkM1ZFVE5pTEhlRmFONWtYclJqSzU5alhtZ2tqNnZHSC90TXhJ?=
 =?utf-8?B?VG0vditRcmpidEhOb1JnWXJxemdhVjBJVTZydFlDQ0l2U09XMm55VGlyeHVY?=
 =?utf-8?B?aUJqZ3BrMXlodHVaQSs3YmdzWVQ1ejBVcWRGZlMra3RYMEFEbnhTdERiaU84?=
 =?utf-8?B?SlFBWVRVc0phbCs3bEVFV1p1Mm9mNWh0YnZiQnhyWmswOU1IaXVLOGltU1Zh?=
 =?utf-8?B?QzllM2JjODhJOW51cFpvaWJhdTFuNFpSeVlmT2IwTkUzVTNuSkF3alJJR2Va?=
 =?utf-8?B?bHYrbUlOSGFjNHNpRHVodnZNWGtIWkFvY3ZUVFdETndSemdldkp6WEo0QmpO?=
 =?utf-8?B?Z0IzUlRCNUY0WlcxMW5BS0NTdVptNTdaY21ZeWdweUEyUjVZdDhpQ2Z1Q3RX?=
 =?utf-8?Q?dXrW4m9P8DW5E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ty9PTkcyRmNVSmgwQno1MkVqbjhjLzRaQ1R5UERTd0xjV2Q5UGJzc1ZLbWpn?=
 =?utf-8?B?cElwTmdPQU1aa1hTMHhHSzZRUWJLbnhWZ3QxU08wbWk5VGtLbEtMOE9mZWd6?=
 =?utf-8?B?WDNVeVBZR3BLbVdGRFhhVktYTEI0c3o1d3Bac1BpSTZrYzlQbjczTDV5cHBk?=
 =?utf-8?B?RVBiT2lmbExWUzFqb2pkelN5VDdiTjA2d2ZyVXlXdzRGUFdWbitUeDJtWWtE?=
 =?utf-8?B?K3QvOHZ0Qzk0UGN5Z2Q2c21QMXVpOUlxZzNSeUVVVzQ5QS9DelBPWWFFSXhk?=
 =?utf-8?B?WXhIRjRQdVZwTGZkdndmQlJIMzdCS0tCb2Uwa0xsWk03Y0lKSmFpSHhGc2E1?=
 =?utf-8?B?UG53L0FKM3hGYkFBWHh2MytpQTlqWVVxL0JrTTE5R1daY3c5cnR3VmJtYVFp?=
 =?utf-8?B?QWpBQWtFN2tVdW5TUzRFQmVCYzIxakdsVENPUXdGcWVYVEdmc2NSeTF5OVJY?=
 =?utf-8?B?TEt4OFlFaGtSbDNFOEpESndkOFJKbTBXOUVPTzVBY3lqNTBjSHg2TG5Wd3NW?=
 =?utf-8?B?NSt2UDArdlFCKytxdERQcHgwZjZMUVpFaFZwK2xmbkQvNkRJa0I1VGx2cGpx?=
 =?utf-8?B?Mjg5aFRxZzdRL1lIeWY5U0g4T1N6ckZTQi9rbWJaRmJhYndzUDAxVzNlUkRF?=
 =?utf-8?B?Umw5QzE4Q3Q2Rk9qL1A3SW5YMHFpdkcrZUZXSkE1c1hENisyVzJwYmdRTlI3?=
 =?utf-8?B?WnU5Q1hPNmNKOHR4SUFGUlV3eGo1QlFKOVBrZURwdFNzalFrZFhDeDJjMWMy?=
 =?utf-8?B?bWRjYzRUVEpTNkdDVFcwWkVhS285UWkrVVFWZHJnWElNZWJnY2t1YVBoVFBH?=
 =?utf-8?B?WUwrV1Zad2lBVy9xKzJWY2pxMysxVzhXTGRNMC9XaUdzNnc4bXo4MjBMZTFy?=
 =?utf-8?B?bGhRMTVJNjIwdnZZSXhSbGtnZ1JENndBWG9LZUFLWStWTS94TnFOdVRPVWdy?=
 =?utf-8?B?UmpFZ1I2a08zVVNpeXBkdk9pa2RDVGpyd0d1UDJOZXk5U2RadG1hbWoxaHRa?=
 =?utf-8?B?VGVNdVBTVUFxY3NleVRxcjErNGFRUXgwU2FjMGtpbmpiQ1R0YUttSWpWN3p0?=
 =?utf-8?B?ckRScTVDTnIzYkJsdm1YTFVoV1VsRktKUFpQK3JMdGpaM1VQYU1DMjNJZ2ps?=
 =?utf-8?B?aHpMdFhiS2hIbTBzRkthcjFOMlRZU3VFTjNwM0FYWlNTWlVrdXNJREhuazN4?=
 =?utf-8?B?bjdQNlVVeTJTUG5EWnVTV1JiUGJZajN2YnhDQjZKYllkSms1RisvL2xSZW1G?=
 =?utf-8?B?S2draUxKYXhBUVRYYTFVZTZFR0dGamVTMUk1RmRGNXB6Mm1ONGpvR1Z0NHR5?=
 =?utf-8?B?ZEtWNGNobVVINVZNQkxVNlUvOCs5RGx1R3BFMnB3S3cwbXNla3NTeHJXb3k4?=
 =?utf-8?B?NWpiNkV4UzVGSzBUMUgvbUd5RWNDV081VC9mNGpDWXN0Y05yT0dVU2ZXNnpT?=
 =?utf-8?B?WGNlNGhTT2lzQTJDS0lWV0NhTGIvNm92b0dNMXZBWnhVR0JncnVIaXd6eklO?=
 =?utf-8?B?MkpsNWNHWTJrYVdYU1psZFZBeFZzZzdvdW91bTRkOHhOSTJNZFZCY2tHdUds?=
 =?utf-8?B?RlZreXZDa0ExZ0Y3MHZVZ0tsZHRkOWxGK3p6YjhYVGlPYVZXTDBHSHhPZzVx?=
 =?utf-8?B?Rmh1RDNHWXhQWjBDMlQ1SFpVL3hvdmp5Z1NDbXJXYUp0YlpEQ3Y4aHIxTjR5?=
 =?utf-8?B?MWoxQ1RUdjNOQjRhbDdGM1V2MlViNjdESExZNXc3cUQ5Slp3Qk8zM01LZHlh?=
 =?utf-8?B?UDNFUm1CTDRNYmxPYzlRcFpQU3l5c1RGZDkwcU8welZxSVNXd3cyRGFqYVZz?=
 =?utf-8?B?YUp0SUJFam1wVmRaTlNYZmJWWU5CWG44cXFCS0xjcG9hZEYyVHdCbEFvcGYy?=
 =?utf-8?B?WHlUU3RNM0FTR1N1TG0wMFNwdExTaTUxN2hiQ3ZnUVhvMmlRNmF0Tm1HdEhN?=
 =?utf-8?B?T3pQKy9UTEkxRndMbmJDZGRmLzFHRjZldmQ5UkRJUkFjWXQ3cDFVeHloa2tv?=
 =?utf-8?B?TTNaVzdBQVlrOWN3LzFyd3FRcm4yNkIwTTE3S3RFdmxhRG5YKzN2QmtNWmxv?=
 =?utf-8?B?QXpEU09idnZIKzlZQWp0cVBPZGh2WUtMNkRLcTlBWExOQkdtTEVLSlBZMHFr?=
 =?utf-8?B?eFdrYzBPSTE0MUdOME9sczdJT1pQVDFSbHBXeG5WUWVIVEY2aDYvWmMwTk43?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb2add3-4d31-474e-e972-08dd4f667a91
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 15:19:32.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKBO60gCGfc/t1MDUy1qMCrZIAUJdYCNPetQLQiN4cQwkgW41nTQqz6PRZHr30N9UzSnNof0NdNtk9wOxt+q5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3331

On 17.02.25 13:42, Marc Strämke wrote:
> Hello Florian,
> 
> On 17.02.25 08:43, Marc Strämke wrote:
>> Hi Florian,
>>
>> i cannot seem to get any kernel to run in QEMU ,-) I will need some
>> time to dig in to it.
>>
>> Marc
>>
>> On 14.02.25 16:34, Florian Bezdeka wrote:
>>> Hi Marc,
> 
> Interestingly the error replicates in Qemu + KVM, but not in qemu soft
> emulation.
> 
> Maybe with this Information can someone help point me in the right
> direction:
> 
> 1. Scenario: Starting with qemu_system_x86_64 without kvm everything boots.
> 
> 2. Scenario: Starting with accel=kvm the machine hangs. GDB shows this
> backtrace when frozen.
> 

This can give you different CPU features and also different timings.

> native_irq_disable () at ./arch/x86/include/asm/irqflags.h:46
> 46              asm volatile("cli": : :"memory");
> (gdb) bt
> #0  native_irq_disable () at ./arch/x86/include/asm/irqflags.h:46
> #1  default_idle () at arch/x86/kernel/process.c:743
> #2  0xffffffff81f1d847 in default_idle_call () at kernel/sched/idle.c:102
> #3  0xffffffff810e6bf6 in cpuidle_idle_call () at kernel/sched/idle.c:177
> #4  do_idle () at kernel/sched/idle.c:296
> #5  0xffffffff810e6e05 in cpu_startup_entry
> (state=state@entry=CPUHP_ONLINE) at kernel/sched/idle.c:395
> #6  0xffffffff81f1d9e0 in rest_init () at init/main.c:732
> #7  0xffffffff83038939 in arch_call_rest_init () at init/main.c:829
> #8  0xffffffff83038e1c in start_kernel () at init/main.c:1077
> #9  0xffffffff83042948 in x86_64_start_reservations
> (real_mode_data=real_mode_data@entry=0x13cd0 <exception_stacks+31952>
> <error: Cannot access memory at address 0x13cd0>) at arch/x86/kernel/
> head64.c:556
> #10 0xffffffff83042a6c in x86_64_start_kernel (real_mode_data=0x13cd0
> <exception_stacks+31952> <error: Cannot access memory at address
> 0x13cd0>) at arch/x86/kernel/head64.c:537
> #11 0xffffffff810001cb in secondary_startup_64 () at arch/x86/kernel/
> head_64.S:449
> #12 0x0000000000000000 in ?? ()
> (gdb) q
> 

You are just stopped in idle, waiting for the next irq (which may never
come if we have a bug).

> 
> Third Scenario: Start Qemu with accel=kvm and smp=2 parameters for 2
> cpus. The VM boots.

So, scenario 2 is single-core? Normally better to debug anyway.

> 
> The reasoning behind the SMP parameter was that the target hardware has
> 2 cores...
> 
> I have attached all 3 bootlogs.
> 

Can you also share what you did to reproduce in qemu/kvm? .config for
the kernel, .config.yaml for xenomai-images etc.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
