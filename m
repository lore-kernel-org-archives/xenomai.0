Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795340270;
	b=tABAGzrwUurml8kuFyiX7ewLpa5dv30Fvh9aWhfhjB13VxI5bQfdP7vUEFBiLkPfCnSa
	 KyOptIcaN9akU+U7IIK0Z7lMSxxWuOWUTGmoFutKImDttWkSXbBzps64T5Z28jVmj2ilw
	 kobd+qKs5DcrKJgkkWw/a1tq5Aa11RnZah6x4U9HEm9RxDBkFTsBr4gC8GVst/peLVRYm
	 Asmo9vMyzXGSmosGWEHU1R62i5OcROH98rqv+MUhAVaQL95mEfsVkmSUSZHxgoC5pWLd5
	 yhjkw7Bej5HNQzPt+4kj7PEN7BzaGaG5JX60YeU4vCwzTAlQIF8mFB0iQcWPVxx3crw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340270;
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
	bh=SANYw3d2LmVUWqZIK8xq7Co9wWdMlvNWQ8aOTlXMHqs=;
	b=V56hUlQ7LPnSNA75FTqLKPhNnJ7/8Mmb/LjOX6gxrn9JJM3GI1rGCL6LtkayRJvG007X
	 drovoWrGiEnzRumDY1nWvUg78DXi7h2GY6zDdlRjWkncyIl5QFSXU2l6aF2piM/jjY7R6
	 5Gh5eylFRMKnoB1sxgtDYUUfG3CwdSDshL5l+PQ4L1Zp6LT3H0uwnIqAoNuxqGZRb5Qoo
	 EduN3RPlWkelxZ0Imf6p76YoY5aIjqqGt7Wks1Qj+wIGS0oLOhmfJ91yuWYeWjXRb22Ej
	 S/JIPavZY5O5er2fr2jIDehFNIV27q5BYwUnXpNxebpMM1y3PIHMazc1NIZnSlCpgtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=FYaxOVZP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.54
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578F606A33D
	for <xenomai@lists.linux.dev>; Sun, 22 Nov 2026 09:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3578F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=FYaxOVZP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iey6A50AQyjmU9/b5LEA7nDBzph3qVF6IJfxmtNE5l2bLuOcD8hJ078/YmXaMedZJTu1UIFD+7OgDrV4XplFilDuppULJBcJAVU0ieBPZ0n/lEV3TGW5D7IQu1o2F9saZNPVE0ixGI9ygpFamG85z7mH0UTBcOi17PEpqOgt7904cdhHrj8/037cUqIZjNaDibKZAxl+ts8lnPKuCNHvClpwMlfggrXT9Kan0bX2nQFkSIgAuIua9onye5Cga0uiKoVfIrAPI73um5qejecEmrkqnjwnbwDpm2kOFLcuDWOZ1d1JSX5/uPtobcJz+Pcet5i3dxOGaLY0FKIT1AceJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SANYw3d2LmVUWqZIK8xq7Co9wWdMlvNWQ8aOTlXMHqs=;
 b=SFsWkQWMgJkVuvO/3Ahe5+JIEx/C0zCtVgOiABIG0wUhRL4dEOpVgrT+5+GQbSMHNW3S4LnOUPCxsIN76utJAKqN7516oFJWmXvidMdw9GS/H4kqwLsQR4HomuAQOonFX7xjOj7JQ0xJl63fl3lRz+ycXUfJln+s4ztWk5j35M6Go5rduc17weJJUxoFJKFJDUTgjCg6WPs/VL3Qk/EpGIIPI5qlgOhA3Rjq/P3XUxkXxOpueokJ6tIs2Es6yuT7qauRGlhWrf3n8/6dpkJcn0o5fx0SGgQcn6eJb+/fHbgwpBFq8vCpyWZ8oFD+3bVZ1kIYOu7FHJC0lihd2XYXSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SANYw3d2LmVUWqZIK8xq7Co9wWdMlvNWQ8aOTlXMHqs=;
 b=FYaxOVZPymLTm2leApYAhXu7b3hjyt6hWmuGP/KSsB5hWQPw95VYq50T0nFBH1/sx1o9LHM6MbiiIP71t1WCWE3DyqSk1adhIAw6BFJiJICFHP/KL+GTtffgTIm9Rrl1wzDZ+92M39FD+DvNMQGmXy+aPn2E1pqDh3wiq4UmCh1tsPwRrm7W8UQNV1WgoIk3oFwQlu3zxjwqGCPVVTezOqY6C3FAWo8cYha69cTqUejuxB+TFVg8zWrIRemqcs0+vwdWJke6g56jcwMomAg4JEoMcPIiPaqa58/Wjh7IfU+J6K93ZsPffmzf8XQkRsPO5CC6vTq1o2zkJiZzncjKRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB6614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Sun, 22 Nov
 2026 09:37:47 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Sun, 22 Nov 2026
 09:37:47 +0000
Message-ID: <e20f3719-de64-4124-a974-51b500254620@siemens.com>
Date: Sun, 22 Nov 2026 10:38:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH dovetail 2/7] dovetail: trace stage switches
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20261110180847.633167-1-tobias.schaffner@siemens.com>
 <20261110180847.633167-3-tobias.schaffner@siemens.com>
 <4c0e980d-32d8-4b2a-b369-ecfb6f190f9e@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <4c0e980d-32d8-4b2a-b369-ecfb6f190f9e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e75a20b-01ac-4326-3461-08df487c447a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|23010399003|10067099003|4143699003|11063799006|56012099006|261021135927099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DMHVmhY8yJITZlzU26MQY0dH+VW/QVTaZlui6udKqYNjGB4eG/BLUkLzUh/X6RyOOwlbeOVG9G/7HukqYLzqAnnokowNqpWwdVhnhy3QhMIDMHWVxWy04eMtFEI0U1k3ZfjykgliaHSP5+rCW12qJexuP22t4T9xDSXpgLSf0oWshXLHVjjwKumXppq+VezhYv2CsgHCqD64bYqvptWYq4u8+V5Oxc78vUOF+GkPhzDawbQ60TPFQzuMGScEfKOvM943S2TiVfuqAxeB5/XKYf322afah3sZcHoXIGvzLe5mo7hGLHjGF+Z7Xi9PBkLmD+HVEUvMgdJL9zir4BOF+3pgn9qt1CP5PGLM8ghk+cG3Hkq9+s6fYf272fBzPxRivrSIg3UOI+bMSfebhqnNSozLLQFuRDF29in7yVMjeXfFaJYZdYpJhSivOG4WrSC+OH/HX+GRnMXFs309FuG9vHlfsmHDAGqDihqdiEc7L02uCw5R5EEym6Tnil9yvepnw/Q1BB/B3W13kz1FhsYlEpNJRQaOWpv42N9t2YesXolSXNogNg5moyZgRrwlt3ZatNuV6g16AifpZVodsaDXNSNPsyn5b9pbnWX+mVDSZmLBF4lcsMZilOp2leaLSeUhiPtb84LFU/UO0AWO6YA8Zizdrqm5rPlfbkSSWjg/EW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261021135927099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ykh3VjVrOHMwR3hPbklzV1cxTmRlL25tOUNROVNEdE1aY1FsWVRlN3JkUjlV?=
 =?utf-8?B?SXhsK0c1UmQxREhGU1BTaXNMdUp0SldIUldqOGlyS1NWbExGMUpXQktRMlJw?=
 =?utf-8?B?RUlpc3ZOSmNkNTF6clFpS1d5U0cyUmpzV0FQS1hwVW5jSGdCMGl3Q3lTdmlP?=
 =?utf-8?B?a2RmNHY3bDc5RTZGOEhIbTlxRE0vT2l5UWhWUW42aTdmS3c3WE9XOXdVUEl1?=
 =?utf-8?B?L3NjT1g0SE9mNmxtK1hjOGV3SzVhQnM2UmdCK1pJYW1SWUdTMDAweEJJc2lH?=
 =?utf-8?B?eDNNZnZTaXlhQ2ZZQjFHeVA1S25LazRQV1pZWmtCcElKWDhMQnMvSnhVY1BS?=
 =?utf-8?B?emR2L2pKWHlnSjJ5MVRHZmdsa3FzTVVVU1N5RlRZUHFjVjB5bVRhSDJ5QkZx?=
 =?utf-8?B?WjNmRHpzbHg0ZFliQ1NGcHVhWGNCRDU0MzBxR2ZORjZMNm1RZVhpalRpRTdz?=
 =?utf-8?B?QjJxTERzMWJWQUtGYU9xSW9GWmg4TU85N0pTeVhyZTZHL21oOXVRcGJWeWlr?=
 =?utf-8?B?V2ZWY05Gc3ZtaGo2QkxydXdzblJMWEZrVmkyTDBZaXl6Rm9rUTJWN1g1cmhG?=
 =?utf-8?B?eHpuMGUvdTk0SHRuaGdlN3lJcTY0WkNUVFpyMEVuQ1RmenpxWG53Y2NkaUM2?=
 =?utf-8?B?ZWNPdXdnelkrajVCUmw2c1duZTVnNkhQcHlhbzdMVWljajlFTzgxcFdaWnQz?=
 =?utf-8?B?ZXErUVE5RlByQUlvODA1VVNUSkFNRHZPcG1XM3lqVlB2eXVXcmhlR0hLcHYr?=
 =?utf-8?B?Z3VyaG92SDZrVHM1MEhEYjNaaVo1ejV0alV5emN5d1BrWU85V29ZWGdVanZj?=
 =?utf-8?B?QzF6SC9EeVhQbmJLWEFUbFhjWEtVWjJCdlVKTDRtazlTeHhsOGdXT2ROa1lJ?=
 =?utf-8?B?dU5aeFpsRE1hTTRzVjU1MGlzK2p4TktUM0lzQWM4ckJaZ2ZwTWNDTjFlVjZY?=
 =?utf-8?B?SzNtTVVGamNIcUNqOEVTdlY2QVZReXAzUFJ3OWpSSzhFTGtEdjR6ZVZCL2JB?=
 =?utf-8?B?UkIyQ1hsbmJNZXhRSS9XR21TeTJ6NlVZUDEwVnZtZFFaMktRNTJFNlhNbHBS?=
 =?utf-8?B?OWFCdHQyUnpsR1R2c0kxM3RWU1M0VUVLUElOU1R3cU5oN2dQMGJTbWZnQ0V6?=
 =?utf-8?B?N2Y2SzlHZnlySHkwcjAyOXIrWnJUeWRSbG1neTkxM0prWmZvQlRUV1BIajRQ?=
 =?utf-8?B?Y1N2SkZBU1c3ckdPSkFpWXNORjRoa0s1cVJNay93cGxtS0NCSHdURDdXaXlK?=
 =?utf-8?B?Y1gwYjhZb2tLa0ZYbW1PM2xKS2ZFblUxSWlqU29DS2pDUWVjaG9ERVN1aGZs?=
 =?utf-8?B?WmxTZSt3bUlDSC84ekt6NWRCVExEYlNpTS8yWEdyZDB3N2JBT0VXWTNwQ2RH?=
 =?utf-8?B?eWc2UnhldVE2UDVwVlpGc0gzeTcxUmZZdzM4aC93VlljKzdTTGNFWWNVQzRz?=
 =?utf-8?B?Nmo0ZlQzNGdBU24walVleXFJVXllOVMxbzlLSjZmZTBGZjVTMlR6bWd4eVFm?=
 =?utf-8?B?d09ENUp6elJEVmNzQnhmMFlCRkFreU9qV0lJeXgvT0xWY3JFS2svWFlkNUJD?=
 =?utf-8?B?NmhOTHlwK3UwUS9lMUZwQ1BSc0xPcHhEUU04a2JjbW1GZENtQTZGTWxMTmxC?=
 =?utf-8?B?L2l6YjhmOEEvWHRTWTZXd3RQb3VHa2dpMGdpTnRCNWRvUTRnaGxrajN6d0Vy?=
 =?utf-8?B?OWNEMDVOeDRSd3IwTG5RaEJ2VFNRRUxQTlBlRko1eXM1VTZkTEtXYXN1aEJK?=
 =?utf-8?B?REVRaDFMWFJXZjRvNHFHbUY5S0dSc0s4UTFkMURlWmdRVnBta0dNT2w4S25I?=
 =?utf-8?B?QjJPZWlUakZHNUVrTHpSL2NQRGdBaUpxRGJVNFUyVGRFRUp5UFZyNmhmVUp2?=
 =?utf-8?B?dEtNd2djclUvbllyZnVaakZFbXlFbXdYa2dORks3Y3AzMTJxRVZtSW53eE5O?=
 =?utf-8?B?QlZhU1VPNzJZR2ZOSk9zK3hBV1BDbDFjUFNoUVNab0EwcTRhck85a05UbXJv?=
 =?utf-8?B?MFZjVVZzUWVjWmZGRHlSZjg3Qlc0cElhNFc5d0NQMTQ4ZXpQYW5pckRnYk5K?=
 =?utf-8?B?VnBLRC95VmpmVDZuaXpmRWdCdWQvMUFHZ0NpaUJvMWQzejFrVGxSN0VKbjZq?=
 =?utf-8?B?cEpLNjlRTEMwRWRmeGZwQ01UajZ0a0dXQnJ3bFpqOTRLYk5EQXluS1ZJa3lC?=
 =?utf-8?B?MFo3QkJKcy9UZ0dPZVdLSDNGaGI1RGVoZUErYXJWUVYrQ2ZVNlFXRDllclMz?=
 =?utf-8?B?QzdJdWpuQXdOdU5XWFNpNUp6THFyZWFwK29zK3N6TUlPRHUvbThROUtDZWlG?=
 =?utf-8?B?Y3RveER2RTR0dVlMOU1TMlpueWZTOWIwLzZkZVhIc0N6OHRYNmFqZWxpbENj?=
 =?utf-8?Q?ePiDD0z3mznoiMe7TlXkXBJnvdLjD4Ycj0rsQAGt4moeR?=
X-MS-Exchange-AntiSpam-MessageData-1: Hux6dOJ0bPeYwf4+iYxFu6+lvgoPmjpH99o=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e75a20b-01ac-4326-3461-08df487c447a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 09:37:47.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Jje7FGqx/qOUFK0ZBZKP5fk6PjILRR1Xq2DB4qyFqgxJ+dQQjeaLROTP7MdgNsstIStLbPWJ1xQ08t/ufhNls7IQ+DqrtUe6HBpP6nFPfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6614

On 11/11/26 08:40, Jan Kiszka wrote:
> On 10.11.26 19:08, Tobias Schaffner wrote:
>> Add tracepoints for a task leaving the in-band and the out-of-band stage,
>> for use by the Dovetail RV monitors.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   include/linux/dovetail.h        |  9 +++++++++
>>   include/trace/events/dovetail.h | 23 +++++++++++++++++++++++
>>   kernel/dovetail.c               | 13 +++++++++++++
>>   kernel/sched/core.c             |  2 ++
>>   4 files changed, 47 insertions(+)
>>   create mode 100644 include/trace/events/dovetail.h
>>
>> diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
>> index b41ea0f8fc4e..5ab07e69152a 100644
>> --- a/include/linux/dovetail.h
>> +++ b/include/linux/dovetail.h
>> @@ -18,6 +18,7 @@ struct files_struct;
>>   #include <linux/mm.h>
>>   #include <linux/thread_info.h>
>>   #include <linux/irqstage.h>
>> +#include <linux/tracepoint-defs.h>
>>   #include <uapi/asm-generic/dovetail.h>
>>   #include <asm/dovetail.h>
>>   
>> @@ -163,8 +164,16 @@ void dovetail_stop_altsched(void);
>>   
>>   __must_check int dovetail_leave_inband(void);
>>   
>> +DECLARE_TRACEPOINT(dovetail_leave_inband_tp);
>> +void __trace_dovetail_leave_inband(struct task_struct *p);
>> +
>> +DECLARE_TRACEPOINT(dovetail_leave_oob_tp);
>> +void __trace_dovetail_leave_oob(void);
>> +
>>   static inline void dovetail_leave_oob(void)
>>   {
>> +	if (tracepoint_enabled(dovetail_leave_oob_tp))
>> +		__trace_dovetail_leave_oob();
>>   	clear_thread_local_flags(_TLF_OOB|_TLF_OFFSTAGE);
>>   	clear_thread_flag(TIF_MAYDAY);
>>   }
>> diff --git a/include/trace/events/dovetail.h b/include/trace/events/dovetail.h
>> new file mode 100644
>> index 000000000000..785a653252d3
>> --- /dev/null
>> +++ b/include/trace/events/dovetail.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM dovetail
>> +
>> +#if !defined(_TRACE_DOVETAIL_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_DOVETAIL_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +struct task_struct;
>> +
>> +DECLARE_TRACE(dovetail_leave_inband,
>> +	TP_PROTO(struct task_struct *p),
>> +	TP_ARGS(p));
>> +
>> +DECLARE_TRACE(dovetail_leave_oob,
>> +	TP_PROTO(struct task_struct *p),
>> +	TP_ARGS(p));
>> +
>> +#endif /* _TRACE_DOVETAIL_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
>> index da4016697b67..98892f0a63da 100644
>> --- a/kernel/dovetail.c
>> +++ b/kernel/dovetail.c
>> @@ -12,6 +12,19 @@
>>   #include <asm/syscall.h>
>>   #include <uapi/asm-generic/dovetail.h>
>>   
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/dovetail.h>
>> +
>> +void __trace_dovetail_leave_inband(struct task_struct *p)
>> +{
>> +	trace_dovetail_leave_inband_tp(p);
>> +}
>> +
>> +void __trace_dovetail_leave_oob(void)
>> +{
>> +	trace_dovetail_leave_oob_tp(current);
>> +}
>> +
>>   static bool dovetail_enabled;
>>   
>>   void __weak arch_inband_task_init(struct task_struct *p)
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 3ec77a682c4a..b2ad0ab0626c 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -10689,6 +10689,8 @@ int dovetail_leave_inband(void)
>>   	 */
>>   	if (likely(__schedule(SM_NONE))) {
>>   		arch_dovetail_switch_finish(false);
>> +		if (tracepoint_enabled(dovetail_leave_inband_tp))
>> +			__trace_dovetail_leave_inband(p);
> 
> Why does trace point have to be conditional? Rather unusual.
> 
> Jan

Yes this one is technically not needed. We could directly call
trace_dovetail_leave_inband_tp() instead of using a guarded helper.

Its counterpart __trace_dovetail_leave_oob is a helper that was created
for the usage of its tracepoint in dovetail.h because calling a
tracepoint in an .h file is discouraged by the kernel docs.

Guarding the helper with the check if the inner tracepoint is enabled is
saving us a function call.

I applied the same pattern for trace_dovetail_leave_inband_tp to handle
both sides in a consistent way but if the result is more confusion maybe
that's pointless.

>>   		return 0;
>>   	}
>>   
> 
> 

