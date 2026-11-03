Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793694330;
	b=EJrUHoE7DDOrdvFc4dREkHHyBxaqnezYi0lpW5jBrnqk1BMfql4O6srfyQ4XaAQynMEy
	 5/hnAdCJKSmlN/0FCRfFcaqRLjhOw52LhtmxQsOgkaw2uadO9SypMX2C8UeolD4N24er2
	 aRSdSklNMwapup2QIJClu0pYy5Tb5V4oz6iR3wwyBTf2nQNMSd3wSY/mQ0whYNzBaZwvB
	 zGufLdza3DymDxTAm6VVCk07+/qPmdeOP15C2q7c3jdC1WTT8i+PxukiTZRV6yGwW659p
	 JEEMuV7X8n9JLjucv5KUD4EHzTB51ow3BJ2B1os1umJrtWymUAEvnmLySOTQ8IxpWLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694330;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Pjh4WM4pUzX+mQ4j0m63AnwmzCsPjOdC6v4BKBB3haQ=;
	b=AIOaokgSuyXYEI5+Q3jtsTMiVIuptSdOUnNDnIKvZ41f0q/s/J/kYvxju+5DRi9JWLXy
	 f/iisy1qW8FqPiXhWZD7uTaGWyzVdqpeHO6ERfp4AUcCa6H8BeETpfQwLZhx6AUGL/vEZ
	 39OpFi+ugZ5E8o3iNhIfTsEpe6mM+CZ1MMFe8T8/vqldEARrtI5yECfZiwGT2bmLBZUg3
	 Ni9Bn6OgGMqIBzFYSOOuB8kv/0InQlCpsOmPtT/PBfG/+7SbJ1pOmTkMDt+s+PnLwuCLb
	 cC6SZIvchFQZNEVHRc86+9GeoTWMZdcv+FtOOdqLE6Crlt6AxeUndQSjhv01mm5v5jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=c7zNvZ+C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.55
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0312A606A331
	for <xenomai@lists.linux.dev>; Tue,  3 Nov 2026 08:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0312A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=c7zNvZ+C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxgyJ2APeOWSkx3Z0cuk/7yGi0DykoGJktZRUt4YCnADnCu1cJ+BsCBNmpvLi9NovEhAHk04LgFelPfBdfp0WwqSvsYqOqhV57AnAJFEs18f/jvROnAyYXi6PeHw4WYVnl/ww9BKcCh3CZyMRS5fKzF0jwrYCcs32BaonvChT+7pvQm5tZKczH7HELh3X9s/CrkBLGWY9ORZ9ObVlnr6Qixt5giJucKbwoDsZmaYs731kkHBT15oKCsgktem3c2j5y3Rvx8Nhl6FvC+g1iUz4+uBZYqqiP8+/2pBLIhGuN4x24UsL/AxtcsJib4ykYHiU5sAsFnLfIv1wZAhLhnI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pjh4WM4pUzX+mQ4j0m63AnwmzCsPjOdC6v4BKBB3haQ=;
 b=vWMTP0avU/Xd1t4aeZq22Kw/Jdnv4QtUB1ISJ15NtqJkkSEXlHLT/gfIw1PvWdlTGPE4zdR9q8+Lk1r6WD0Sb7fJqc1sPN7xQ0K1h4dkSGagykG1jQM/sI4Y9pkq0c3qv/4GOlElLmdCSLBuuF6SexkhXMrHS9tsyySKDbMV9zm0QUNcARQ+ZEOU2AnIcTQ3UL7db1GO+ExaLLarR25WEbwA8t+KIObvqcn2vKi3g9qvwPnR0kXjMGP4r3KU8zr0QBGU/8iqc70BHv23LlnAFSrTsqsrx+nnhLpH95+C8eIOxDw0/KiCNAJpadPxWTJhQBpwlLSeD15E9PkEp196zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pjh4WM4pUzX+mQ4j0m63AnwmzCsPjOdC6v4BKBB3haQ=;
 b=c7zNvZ+CaA8v23YbXbt4iA5hgN2ooXniY2RI763b/u/midgRMweJQGx3PiKNjT1+fY6kX8PxuszzZxSfQvIv0wgMAa8FTbS6Gqxq6dTJ7DIuQs9/Mq2AfiBWH+owUUzsXQW8RaIVezJQwSedzSItpJMI7+Qwve7XsS8pDIeyuFgbsMxEUItMRqeuUJsDY8GvWp9ALcAvpFlmkKRD3MlT9SmnwsDEvJ8BOzOmcFIjTqiJ2DkjpXXsTuX5remvgql7mdxhOTFjgraYkZ8FAuAhspYbf2W/UqyLW1IoFzeSnpszG6aglqHFISXMr713yxKLnXOJgueiy74zgJkvAg0jiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB7430.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:595::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 08:25:24 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 08:25:24 +0000
Message-ID: <ca07b0e1-9f6a-40f5-a5f0-584112eb6119@siemens.com>
Date: Tue, 3 Nov 2026 09:25:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Dovetail 7.3 v3] ARM: dovetail: Fix inconsistencies in
 trap routing
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20261102-wip-flo-v7-3-fix-arm-trap-inconsistency-v3-1-1738670e743b@siemens.com>
 <ff32cd76-1dd1-4e0a-b1e7-ea069663c4ad@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ff32cd76-1dd1-4e0a-b1e7-ea069663c4ad@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::17) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1e5bf0-e55c-4140-a89b-08df3984023e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261021121427099003|261021123027099003|261022105027099003|261022113327099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|4143699003|11063799006|56012099006|22082099003|18002099003|261102123227099003|6133799003|55112099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	wSa0O9dd26XJQ4yR9Y0uPCUldJKDVy8LEWMsM7xfipizWWeiNTk7xtDqm50tjycIENjr9ErDWMgBKqQeg3aS3qvwWm2xT26AcGwiSXCR7bcaPBv1jx7ziLfWfQ+IkwafY3RVFSSOpIzXdtVfnyxCPplw2U822JeyXVt96cbNeFJp4XRYKzI5w5rbPXI6SCdenFrdyS637u5nX8lAq23BN4aXQYXaaY1ANN5kEhqt3QNl6/0HEZ4gYqDeMspweiPJjWV48RaxQ5adt1dJWZLLmreUagIm2WElPaP0w2PSJDGDiCU0MZX/sFk1C6TevMIKIYxzHn39c93E1Jy7XnyUl6o4065uzJGgvhlm8Z4tRDY3qE/eFjAVxsCUYKWI6uWMgdWnPKlkmN6We4XVx0E05h+TnfcYuOTjFtAqiLI2pHsfo0/IdJwgV8FH3SnHGvoauI+4s9bmIJlJRaaMMbTiOwZLJhQ7kwdTLkjmFIZtiNYbx53Np11qE1tXz+tZp1QKdw6SI1vEracvB7n/pc3Z9JFaTjGMPs1hFO3jU8Aiqh7pPad6WuT5CXGJjl9U1Cuvz+xX15O19YVEbNeuFAc4Ava5SQvmkzab12sij2SsKz7ZVsxJ7u3oAWM5SLLGLhDRKDFQspVX6HPBI/nACBM9vfqdwrXdq07FE5RGJftqDUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261022113327099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(261102123227099003)(6133799003)(55112099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW40VjBzbkF1cVR0ZWtIUitSNndEZjRyOXR2ZGk3UUNtYUZVQUNmVWdqdHVW?=
 =?utf-8?B?QjlRU2IwdHdqZ3ZpYm5aTkVkQWNSUFk3c3JKR2NVaHZjZGdONmM4dHI4NFJP?=
 =?utf-8?B?RUJ3aFNaSUl2OFBTWlBXZ2VLeEV0VHV1SElvNjJZMHAxOXp6K2hoTFVLUkVF?=
 =?utf-8?B?SlJIMG1pV2VlQUdLNVp5MGVOUDJhcy90aHJWUDZyaFNSYjJlcWhINVp6NFdt?=
 =?utf-8?B?YVNxUDZnTS9VS3pCL3pJS1orTmFDZDAvZjFUUmEvVThRN2lJWmcyZk85VlQ3?=
 =?utf-8?B?MUNuYmtTeVBJbWNvMDIzQ2J5YTVnQUVaSlNWTHdlVkVKZzQ4b0FuNjFwbTRQ?=
 =?utf-8?B?R3pGREpBNE1SUmxMZkNxQ01KKzRqSzAwTFFhSjI3Z1hiOXBmNmozNHBlZ1hk?=
 =?utf-8?B?bWp5Yit3MGhPTFVYVmI5SmhNZTNCS3NzbXVUczJBUVF2ek9QRlFBVkRhZXJV?=
 =?utf-8?B?TTJMRjZxMC9Dajg3aHFRWEd1UXhTbGxWOVhXNEZhbFByVlVkZ2VUQ0FjZFFn?=
 =?utf-8?B?UHUvQU8zaW9uYXVtQlJDYmpFdEo2Nlk0bC8zc3RNWmdxbC93cjdzbG1Ha0pV?=
 =?utf-8?B?Y1BVSmVpZHk1b25hUW5rcnJ4N0dITFluTWxyVTRad0NtdzFad2k0TXJCSWll?=
 =?utf-8?B?SWlRRWtiajhMN2hYdEtsK2xLU1Uybm1NdlBVbE41b3FUdm5QeDVlNGRxY1Nr?=
 =?utf-8?B?dDBjMmZYYno3cmkxaG1LTTFWTzN3aXU3Qmw5eHhSRVJaK3lvWHAvdnNUVWFp?=
 =?utf-8?B?N2lBWGxHcHJRSGRHaUlwb0xWWTh4TmVoeDBjRWlicXpPMFFzeGxaSkVNUVAw?=
 =?utf-8?B?L0VXYWJNYmhBTFFFbDk3ZGtOY24wbk9XVDNzYjgwQ0t4QzBhYVhRMHlKdHFy?=
 =?utf-8?B?S1NzSUd1c3JXTlhDb3IvOXM1ekswS2VXaTVkaHI3R0tFRWYraWFPSTBYUVNv?=
 =?utf-8?B?OGdtVlFJaGNxSWdxclR1Y0Z1VFMrQXBlSkhSL01VSTh4OVptZFhpY1kwcW5K?=
 =?utf-8?B?dmR6Mm9UU0xkTHpLLzNQUEQ4S243UjFZdmMwdks2dUJkaVZ6d1hVSTNRN1gz?=
 =?utf-8?B?eENxQ29ORnU4ZnVlR000RlJLU2hmWE8xSWIxZFVsOUdVMUJLNyt1cERPZ0s0?=
 =?utf-8?B?blVJT1ZzT3FyR2pnenBxazkvOCtzbExPQjBFYmp3ZHFZUVZUK0NhSENxL2Vi?=
 =?utf-8?B?ckZKMlBJK0RFb0VXQ3pOeWt2S041Zkt3ZnFBMXdranNTaEJzWjNUa1l3OTFQ?=
 =?utf-8?B?OW1SQkFlM3Q1NmZ6SkdPWFJoSlNOd2ZNZnNUSE1jOEhsSTJ3RlpCWGJTeVYr?=
 =?utf-8?B?NEc1SkZ3Tzcyc3B5R2VpMSthaHBtcEFESXJHdTY5YUlmNUhDL3FNOUx4L3lZ?=
 =?utf-8?B?MlNJQ3UwMzlaU0Vqd1VwWnE2Z2JHZGkwQkc1aE9PTm5ZK0JCeW5LVFpSeWZE?=
 =?utf-8?B?SVFPWld5cmZ0enVieHF4Ym84WTVVZlV4a1EzRlhvbEJlOUlneFhwSXNHOTcr?=
 =?utf-8?B?Wk9Bdm5RY0dVZVM4YkplV3hlbE83d1E1TG1SRjV2TzlJLy9HamtYL25RUXl5?=
 =?utf-8?B?UmlxMmoxQ09GNmtmb0s1bTZIS2lnaUpIQm5OeGQ1cXFSNi9iTGc4aXM4NXNP?=
 =?utf-8?B?MlpGbkM3aVNVREpuNU53aUc5RFNvSGFaT1ZlNW5GaERjZEFHRGtwblhPNmFZ?=
 =?utf-8?B?Qks0amxzZjhEMnJ1YVlRSWF3RFlvTjd1S000N0s0VmVtc1BwQSttTkxvRWJ0?=
 =?utf-8?B?Q3phcFNyVWtIYnI2NDZHRXBrOXEzbHJsclBJK1NYVzBKbFFINWt5dlV6Ymt6?=
 =?utf-8?B?VVllbW5QRWJuMldqb25DaE9ueVdlZHQvREdUNWZlUjAxMGVabVhHUVVPaks4?=
 =?utf-8?B?UzRGYm5NTU9zaC92dGlYQklsMUJSenZyK1pXVVFYWE9ZeFdiTWFLWk1hayty?=
 =?utf-8?B?RWQxOUpsQWhxaXoxR05wSzNIcUt1MEI0TGJqMHpKdnJ1ZWJHcUNsUjZreFQ2?=
 =?utf-8?B?dWkzQTRwb1ZzVEdCNGFsOFBnTlJlUkVqbnJMVjFGemtOa0VaN3BtZW5sUGNs?=
 =?utf-8?B?dUx5WEFEWlg2VFVxb1FVb1REOG1kc2crSkhBZlpQcUhrMmVyNWYxTXRCaDBs?=
 =?utf-8?B?emI5VDBMRDQvcEFzY0QxcU5ORUhURytJM2pqOVhVbnl3UVBKMHZCUUNMSkZK?=
 =?utf-8?B?cnEwYnZtNVp1VTBKcUVMZHJtOFNKdHlBSFB1RmtkejZaV0NPT3RDY08rRFVx?=
 =?utf-8?B?TG10TGdpdUE1N0JsSkg0d0tMRXVYdWNLMm1HbnJXVWpZaHpvMS9PN09sUitU?=
 =?utf-8?B?MjI0Uml5NHFGUFFhaDlxUXZzK2xVeTBIKzEzUTh4OGlIa0R2WFJBdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1e5bf0-e55c-4140-a89b-08df3984023e
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 08:25:24.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4Atj2gI5WQZ4vv2i4t5lNFlI3rCvgZNd61GfQH0HFffeOhn3z2QJevwWJ00Aw+PrE94AhncFtXyV5fW5M+5kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7430

On 03.11.26 09:24, Jan Kiszka wrote:
> On 02.11.26 17:19, Florian Bezdeka wrote:
>> do_bad_area() was informing the co-kernel about an ongoing trap
>> handling - but only for the trap over user mode case. Removing the
>> dovetail_fault_{entry,exit}() pair removes that inconsistency - we
>> never inform the co-kernel now, callers have to do so -
>> and fixes yet another issue:
>>
>> do_bad_area() is called by
>>   - do_sect_fault(): fault.c
>>   - do_alignment(): alignment.c
>>
>> do_sect_fault() already informed the co-kernel about the trap, but
>> with a different type: ARM_TRAP_SECTION vs. ARM_TRAP_ACCESS. This
>> nesting is removed at the same time.
>>
>> The second caller, do_alignment(), used mark_trap_{entry,exit}()
>> instead of dovetail_fault_{entry,exit}.
>>
>> In addition, leaving a comment in do_bad_area() why we do not have
>> to use mark_trap_{entry,exit}() here. All other users of
>> __do_{user,kernel}_fault() still have to call them.
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>> To: Xenomai <xenomai@lists.linux.dev>
>> Cc: Philippe Gerum <rpm@xenomai.org>
>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Changelog:
>>
>>   v3:
>>     - Fix ordering problem in do_alignment(), calling
>>       dovetail_fault_exit() after hard_local_irq_disable() would
>>       trigger a WARN_ONCE().
>>     - Fix whitespace issue in fault.c
>>   v2:
>>     - Fix wrong comment in do_bad_area()
>> ---
>>  arch/arm/mm/alignment.c |  9 +++++++--
>>  arch/arm/mm/fault.c     | 12 +++++++-----
>>  2 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
>> index 612db267f6246d5e5ed1c2e9291d51e315aaec25..f3be49a007a66357573f431125bd4cf8bed19c87 100644
>> --- a/arch/arm/mm/alignment.c
>> +++ b/arch/arm/mm/alignment.c
>> @@ -25,6 +25,7 @@
>>  #include <asm/cp15.h>
>>  #include <asm/system_info.h>
>>  #include <asm/system_misc.h>
>> +#include <asm/trap_entry.h>
>>  #include <asm/opcodes.h>
>>  
>>  #include "fault.h"
>> @@ -803,6 +804,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>>  {
>>  	union offset_union offset;
>>  	unsigned long instrptr;
>> +	unsigned long irqflags;
>>  	int (*handler)(unsigned long addr, u32 instr, struct pt_regs *regs);
>>  	unsigned int type;
>>  	u32 instr = 0;
>> @@ -815,7 +817,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>>  	if (addr >= TASK_SIZE && user_mode(regs))
>>  		harden_branch_predictor();
>>  
>> -	mark_trap_entry(ARM_TRAP_ALIGNMENT, regs);
>> +	irqflags = dovetail_fault_entry(ARM_TRAP_ALIGNMENT, regs);
>>  
>>  	if (!arch_kentry_test_stalled(regs))
>>  		local_irq_enable();
>> @@ -1001,13 +1003,16 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>>  		 * entry-common.S) and disable the alignment trap only if
>>  		 * there is no work pending for this thread.
>>  		 */
>> +		dovetail_fault_exit(ARM_TRAP_ALIGNMENT, regs, irqflags);
>>  		hard_local_irq_disable();
>>  		if (!(read_thread_flags() & _TIF_WORK_MASK))
>>  			set_cr(cr_no_alignment);
>> +		if (dovetailing())
>> +			return ret;
> 
> My token consumer says, that this condition is true for
> CONFIG_DOVETAIL=y, but dovetail_fault_exit is only becoming a stub when
> IRQ_PIPELINE is disabled. We either need
> IS_ENABLED(CONFIG_IRQ_PIPELINE), or we make this unconditional.
> 

...or use irqs_pipelined()

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
