Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F1313524
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082533; cv=fail; b=SPp6bczklHWZ7GlBswiPThm2ufbzSVpLFkwhURoIHUHh1vW9ADLFsAZ2VS3cJ2K8CyI3W9xWp+W5xh1bvCnEcp2fvij8A5STWJ0HIgy8h+9uBDik9CJYnEASfs9zffQa12Pf9Fx/damn0GmZuqxIpYdmg+UDAoBNS64Lb/ich5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082533; c=relaxed/simple;
	bh=/FvEU8Fwd4EX4Yh3z51+XPkprfUFqr75a31e2GTCRqs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MQcALBFZ3U/feXoEZTrAwKM3Eb6rUTPjaLdmJycOIkELL5E20PsOAHp5aU5i68281yOdSCCJ28gC6zzOnyNUjo3ko3QWdt0ohzmDRTBqM7vurx13ZfmJiNeX0V5OLMLsm7xqDRF00bDQUQ86UJzLNP7PdETIJv9KiMGtA5c2FYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Q//pcD3k; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Q//pcD3k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GC3bfgFJC1RlmR463OTECBK6Dm2uL9vrxUwZ6kRI+/TJL23sp7TPQZKvIxTnVLIjSIzDlb1u+R7VJO2WvUmPXG/H61cFbqPmVXujWgYbDorZBkGjdc5itAnkFcpNuWhkvoPLWnhIhY63XIlb6RuEbx3463ByWVBSOsHAfKkj5Vij19nmhplL6olSCZVxdPocT7/NiDZc/KbPXONpN/6nRrg71+9L2+CrgBNDhjW5lBCWLZaOmWe1j1dlQ7XyOk9RCfTNwbQfO8G/xS4ri29hHTc4fCiV4NpsJ3AuIK2VZvs+wT9PYG5kIx9802/bHmxAaQO78m8HvfcBxclYWv1l8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dGmPKUlnxsYKqOZS2+xY7c2OHLoC9pFmVEpiaT4kPs=;
 b=J9SPxsUaFxeMHoH92OG3Tp+Cffukyuj0kQjufpoGXvbQX/srA1DCgPHauxpJX1m+UkP+7VNhsK1tRTEiS3nKMWSZ00o18Nbou1O2crEoEDp0UVlBgHa5afXEPMDUNxtkPf6+heVW+Y60as0dGRGbdVl2HEB/lcLz0fIEre4pSQkXOIzgeTJqcGM0K+5AQQelljtSxwxomBnmjc8J3XcpRwV6KndexBh1x5V8/RtYFpYCyRtwR8ZZgulo6ygPeQ4wdL5jSZ0TY1lY218SkJmh8iIIG6D/kG0c/Ie44kHp/rnsUcHPF1LhkN3lMANFAcZdCnkhOXtMkPp40ZKXzCW7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dGmPKUlnxsYKqOZS2+xY7c2OHLoC9pFmVEpiaT4kPs=;
 b=Q//pcD3kenY2xM0oWhl/FgqXtLEED/1lpcTjQop9DmiqPjrPJ4DEdO+TlTYXiPA0uVJKyR0K3VPYzCEA7oSK0tHTsVwXo+8HUqD351jRK3fLF+8FLG0+RRxkemZACdd5X7KyYxOqG+mndniyLovOk4yhOxzbuLHPvM35/EcCz520QrrKDyoYlZZVoBl16e3PdpHgnvDdo267m1xnsBnCXXqEBQHUyI5RFItO9IcjVluMFZBdhOboDAhE7/bd7OGWjAkQNl6kXnOgAbDqChTppAFRZYIgbLboD/PJE6ELs1MZUw+Af5usCFXFF9EAOjFzRTmaCmzSw3imcL1xSNdHaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB6922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 11:48:47 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 11:48:46 +0000
Message-ID: <d07727a2-5298-4ecb-ad5b-e6c854bbc0a1@siemens.com>
Date: Thu, 22 Jan 2026 12:48:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v4 00/12] riscv: Add dovetail support
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
 <fee490c4f759ab6c6b88e207f4ece1f285179eac.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <fee490c4f759ab6c6b88e207f4ece1f285179eac.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: e1518dfe-7258-455e-a89a-08de59ac3368
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVlqM2x5SnVvWnpBSUsvM0dxVytaek1pZ2pLSE85Y1E0ZDJ2cEx4TDRCdGVQ?=
 =?utf-8?B?ZDBjSDA4MVJQNGFaTnFmbEhLRENKUzdFdFkwT1JMcEJ6UFZ6R29rd0k4Unky?=
 =?utf-8?B?dkRhc05EN0l0SXdXcGpERkNiQ212SHhHQUFuNUxncnN2eGZXdG43cTd6YTZn?=
 =?utf-8?B?V0NMc0VxRkJWMDZlbUFydUlDUWdSalVPZ3pvYkZyYS9sdHJzLzVCUUM5V055?=
 =?utf-8?B?amZFS1R4TDdTeUc2R2xoRDd4QTYxQXltc1FlOXRpc2J4TzZ5dkpLOFA1UkhD?=
 =?utf-8?B?dWlzV3lwNWR1UUMvV252a1R6a1ptWHZkbHQrNG95NGtMb25zU2RpSFJ5dlV6?=
 =?utf-8?B?Z3gvZi9ZdG5vTVErWFdTRjFFdG1acUVqb2NpSGh4YkFhUTU4VGVFclVTSW9s?=
 =?utf-8?B?SW5DdW9kZVJXWit2b2hNL3dwZEJERHZFYWEzc0MycUx1SGo4czBvQVZvcUl4?=
 =?utf-8?B?b1J4ekVRTFBaVU8wR0JjekVjbkt0UitDWHk3N2lrVTZaKytRNlIvSUE4b1Uy?=
 =?utf-8?B?YXN5MG5meXAzVEdhcnJpVXFSTUZWUEIxaXVJY1pkeHdRRkxYYTBvTnJNUi84?=
 =?utf-8?B?WGNhSTJZRHIxNE93VmZHUjJMVGxYU0NHUlRTMEtXY1pNbVkremd3ZDBRTVI5?=
 =?utf-8?B?ZHFIa2RaaUsrdDFUWnpYczB6U1lPQTRZY2VmazZqSDJWRkJ0SWpOeVozNTNx?=
 =?utf-8?B?YmYwL3hmTThJL1NhMVZ6bmt3K0dMeVRkR0RwNzIvNURnRXUvazM5YjhVWm1K?=
 =?utf-8?B?Rm1oazBaNURuRUZjU1Q1Q3VBbzdBeC9DNFpjWUFEbU1XRWRjWUN4TW9qcktB?=
 =?utf-8?B?dkw3N1Ric1UwMkpXTUcrbTFRWkhveUJoRDFBRndhQkx1dzlrZlg0SncwSkJZ?=
 =?utf-8?B?aFlLeHdkT0FZaUp4ZkpOTUxRUWZKdkMxNnhGUmkxZEJYUThpYnR0a0FmTUhV?=
 =?utf-8?B?ZXdsa0dIWTl0TjlWT3U0MGtJemF6NnBlR3g1c0xobWphbEtMNmZkd0dEOGh3?=
 =?utf-8?B?Ri8wU281aFl1c2k5ZjRUZ1BJWEkyY2RJeXB4WHorQXNsL3hpUExQRFEvUERD?=
 =?utf-8?B?bFN4d0N4TTZ2b25jWGIwQ1d2czUvMzRaU3dJYUIzZWYvMUxzL1grenpBbzgy?=
 =?utf-8?B?ZG5kelN3SERGN0FqS0s0MnptMGcyQmZVRXl1bmNFZllubmFGZmNKSlZnVm9v?=
 =?utf-8?B?MEsxLzZ5NG45WjhkSkdDakpwUDZ5RkZZdzZGVklLL1FWVVp6TGd4a3BiWTJ6?=
 =?utf-8?B?dGdOZVBqLzFvS2lwa1hWYWdUR1YvZU1NK3p4ZUZTTExXS3J5T0lpZGoyQnFw?=
 =?utf-8?B?eTZzc29wclJFUE1ZTnJlNFpsQjNXMC9hTGtzWXJNcURnL2NudXlaN0JDWjdz?=
 =?utf-8?B?TTJBekFqWXJrVTFLTUU0dzAxY3Izc3JucjhsQjNnMzhUbTdsM2Z0OUZkcTA0?=
 =?utf-8?B?MHBzN25qRStpblNJQWdrUVdXc3FPdjVWTG5LY3BUTzQ2QmwxZjFxVjJBMXht?=
 =?utf-8?B?akczeFFDbnJDcVZ3aHJVWm5uK08reFEwRzBqTm5CUWxZUWFnMExSWTd0UFRa?=
 =?utf-8?B?Z3lRU2tVb2N2S3d1WklpQXZKZzEvVEFVUmdtQzFXbGNoVklMbkJoQzBETEpT?=
 =?utf-8?B?dWQ0MlF1bVVKajZmdE8rcGl4VVhaN1V5Y2tJTjVNOFdXV0xQejZORDYrR09j?=
 =?utf-8?B?NVBSelNrNk1UZWp3MndJcno5clVFUUphNTl0R1pPS1YzNlI4cHFLWWdMSWxF?=
 =?utf-8?B?L2NITjRscmUrbWJQejJtOHhiRlRiNFBOa1hxVU82RmJwQSt1OThKSkJrdmxJ?=
 =?utf-8?B?aHcvazZkRFZ3MU5ydFdsWFpxYmxtSXlFZzYzZ2dISWlwTE90SXNIZVQvTktY?=
 =?utf-8?B?NFNtZTZicWxBcG5rR2xuME5BUDZ5c0xjQUQ2VzBzbEl1UE1UcHNVaG5lazRj?=
 =?utf-8?B?a1BGRFNTcmJLalJucm0veE9ORnhWa1lEaUkzbDIwMVRXSEdPY1dUbXpTVG1n?=
 =?utf-8?B?d2t1SkF2ME5kakdYUFVHeXFQdlE2dHRrR2wxZ2FOaStNcU9qSEZFV2Nobkt6?=
 =?utf-8?B?ellXTmdEaDJjdnU4dUhkd1R5bnp4TWU1bnRZbkIrTndiZmJORFcxWE1sSVhw?=
 =?utf-8?Q?iYvM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlhqU0tRVmwxQU5uR1NtT3BTQ1MzMWlZTTErQUx2M0tYQ2hPbEdmVFRxcXg4?=
 =?utf-8?B?RHp1TEVWMXI1YWIvV01USWp1UmRkcS9sVVJCd1VXVHVXU0RSR0xuR0hMRDZD?=
 =?utf-8?B?Tnl3NVh0bnJ6TDh6eCs4aTZLc1RTQWUrM01SQXVZeWhQZ2s3M0FNelFrVlVR?=
 =?utf-8?B?QUtDcFNYN0p4VHJrcUovdFRPaVRDS2FNcXpkUGJuVTh3WUJ1RTdyZDB2VWoy?=
 =?utf-8?B?S0dNM3ErM0sxMmpuRnFrcmd5cVNob28vcVJLU0FseWpzN1N0Yjc5YUIzdHht?=
 =?utf-8?B?QzlUNzJ6N0l2Y2U3UVFUbjJvdmlXaXovQkliNmtrMjhCVG9ieDdydXE2OFhB?=
 =?utf-8?B?Z0Q2NVJhS25JSmFrcnJ5K2NOdVRzSlY4YVRrOU8wajBUdE52bUJDejFSVDN1?=
 =?utf-8?B?SEY2L3ZpeXBjU0kza3RpQnJiM1Izd20yYVJhUmt3eTQyaGRCNnFFNkc5RUVN?=
 =?utf-8?B?VTNucjAyb1EyVmNpQ1k2SHpkVURJeVRyZ0FQYVB4MVphTVhtQVI3S0dEL1Iv?=
 =?utf-8?B?WWpOaWduTy9sUVJOU0RLM1pVWFgwS2k4b1M1QzgyTFA0ZG1hWWU2WVFQangw?=
 =?utf-8?B?R2FLYzc0UnhPUWRkUS95OWdqRTRGcmN6Z3JoZWxiOHoycC9wRERzbDBabUM5?=
 =?utf-8?B?bjJHaUljVzdsbW1EZ1BaN2FvU2dwYkdKUndKeDJXSHBITFNtMGtVMUdiVmVJ?=
 =?utf-8?B?dEovNTRySVoxYSsvSm1JZzdCODJkR0dLUk9pekp4QjZUTDlFZE9kZGo1TlZT?=
 =?utf-8?B?QXB2SmxVVFEvVWxSdE00dnFTVjh4eXkwaWU4WTJ2bHRtcFBUZ3V6QnkwYUc3?=
 =?utf-8?B?Yk1PY2huVnhpVGxaRUNYQkUrbk1tZk1hVFJQN1g5OW1NcXZQZDdkeHpVOW9S?=
 =?utf-8?B?eFhGbXYyYmMrUUt0RXRXcTFpbjhId1JmR1hMaXRtZG5BdWJrOWJEQ2puRENt?=
 =?utf-8?B?WDJLLzdLTFdpdEZyU255M3RqcDM5a0V0czZqWW5OTzc3RzVRa1lLSjc0UC96?=
 =?utf-8?B?bG5iM0tLY0pnU3VUVkZVSTBzZG9zVERZSkRQZEtpTU8zUEZXM2o4UzZORWpB?=
 =?utf-8?B?aHR3TDdQZUhva3ptekRPYkRtazNML2VUVllyamVUYmk4cUJaUTF6cm9WZnov?=
 =?utf-8?B?bjZTMzQ2cEwvVnRDaFVMZS9TbkhmWnh4NDNEblJOTng5T1pUNFBVR0NsSTQ2?=
 =?utf-8?B?N09OVWc3S25RMURWdTJVb28xWXFpdDlzK0tBemsyUWkvVUExanN2SWwyWDNT?=
 =?utf-8?B?TzVCTWkwSzc1b094WTVWUms0WURWYStKenNnaDRuOWVjR3IxZW1hUm4xZmhC?=
 =?utf-8?B?Umk5dEJzbk5uYUw1dGt1c3FjT0ZIZzJGdERkSCtZTEQyZWczTCs1RENITkN0?=
 =?utf-8?B?YUhaK3lEa256MzY5Nm5hQ29GMlB3cmRac0YveTV4Q0xwc2ZLdlBEQTJmSlAy?=
 =?utf-8?B?cmtGYWFaNFBkbHU0Yml2cWRlbE5Lb1VoZWpSTGRHdEhySFlVSjV6L3B2Qmg3?=
 =?utf-8?B?TlhrUUtTQkphZG05RlZwYkRiS1J5ZUp0WlRUY2E2WlVuWFgxakpPa1FaUThI?=
 =?utf-8?B?K2pCSjQ0Uk9aekh4dzdoRGNmODM3TWFSMy95ZTdhaFFYNHVsWGZDWXg1aGJl?=
 =?utf-8?B?WHN0VE9TUjZ6UW9PdDlOQWhaM1UxUm9pL3lNV3lOMStqbGhsY1pQSXVjS2FW?=
 =?utf-8?B?di9JMVlXZmVaWW1HelhIRE9DV3U4cS9YN29lRzVaaFdZcG1CR3ZtZEN5N0JY?=
 =?utf-8?B?RjR0UTMrdk8vOW9BUXlJRTlmYU1oZ3F0akVoWHgzRUdKMDNqemFpUS9rSHp2?=
 =?utf-8?B?Y3ZRR1ZTaTRUR0wxZFF3WlVNbUtXWDZLdTJIVmVoaWc2dTEzMnhtd0NFYzQ2?=
 =?utf-8?B?dzJJcHZlUTlva3FycU5QSjdCK0RrZjZDQXdXV21qNVd1YlZDMzc5aFV4Tjlr?=
 =?utf-8?B?S21nOFdwRW0zTEE1UkttY29wdUZ5L1lHWGVZVjhCMHB4MWtEa2NubmRtS2lK?=
 =?utf-8?B?b2Z4UnhjNzZhQmh6MGg1QjcydHAvc0pOc1ZHRUJhWm81ZW1MeThod0NhTEsv?=
 =?utf-8?B?S1RUdEVPOUREdmlmYS9lZUVzeWc5aU5sV3RValovRDdNUmthV1RiRDBBNlo5?=
 =?utf-8?B?KzE4V3hXSGNRc05aV1RHQTZYMGhwazZrRGxUYUsyQlpDRXd5Qkd2Zkk2Z1No?=
 =?utf-8?B?NTBuRXpsMGpXQUhvREVTcVJJRkJ3dUFNUll5RGRsaEV0YjFTM3Qrb2krM2ZK?=
 =?utf-8?B?cUk4eU9wR0ZaMzZXajd4WUxHdnZ4anJOTE1lU1Q1bklTRmd4UWUwdE53YkJy?=
 =?utf-8?B?a29Va2R1UGxISklodFRXVm1TRW95RlFkZDBOSDM5WHFiNWVIOE9pVzBEU1Vh?=
 =?utf-8?Q?3ZJiBBcGVpfkH738=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1518dfe-7258-455e-a89a-08de59ac3368
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 11:48:46.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fd43HHPfPYlRglTrtBEB1RRMZx1jtY86/H/SWY+S7BXtUanPMU4dIBMWpttcft4W1dw27s0KqQ1xRHXLhHY4YJvtWUl1IZot2zkcWrtMCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6922

Hi Florian,

On 1/22/26 12:05, Florian Bezdeka wrote:
> On Thu, 2026-01-22 at 11:22 +0100, Tobias Schaffner wrote:
>> Hi all,
>>
>> this series introduces initial support for Dovetail on RISC-V.
>>
>> Feedback, suggestions, and especially reviews are very welcome.
>>
>> Changes since v1:
>>   * Disable independent irq/softirq stack usage when pipelining
>>   * Drop KVM changes as long as they can not be properly tested
>>
>> Changes since v2:
>>   * Rework trap handling
>>
>> Changes since v3:
>>   * Included the IRQ pipelining patches to have all riscv specific
>>     patches included
>>   * Rebased to dovetail/v6.18.y-dovetail-rebase
>>   * Merged most of the fixes
>>   * Fixed IRQ Stack handling and enabled IRQ_STACKS again
>>
>> Best,
>> Tobias
>>
> 
> Some questions:
> 
> - What is the stability state of this series right now? Any known and
>    open issues?

At the moment I am mainly testing against the EVL-testsuite [1].
This includes running hectic.

There is still the "riscv: irq_pipeline: synchronize IRQs on exit to 
user mode" patch in place which is a ugly hack. I want to sort this out 
soon.

Except from that I am not aware of other issues.

> 
> - Which platform(s) was/were used for testing?

This is not running on a physical target yet, but this is the next step. 
I will run it on a StarFive VisionFive 2 board soon to get some first 
numbers.

> - Any stress and over-night tests that were executed?
>    I'm not necessarily talking about the CI tests that we do. I'm more
>    interested in io/cpu/memory/swapping/suspend stress tests.

I ran hectic for a longer period of time but far from over night.

I stress the system with stress-ng (stress-ng --vm 2 --vm-bytes 1G 
--mmap 2 --mmap-bytes 1G --page-in --matrix 0 --matrix-size 64) while 
running the evl test suite.

> - State of CI integration: I see that some risc-v support was added to
>    xenomai images. Is there real HW behind already? If so: What kind of
>    board?
RISC-V support is not yet merged into xenomai-images. I assume you are 
referring to my internal pipelines. These are running some custom 
patches that allow executing EVL tests with background stress, as well 
as building and testing the RISC-V custom branches.

I will send these patches to the mailing list step by step.

At the moment, we do not yet have a RISC-V board in the CI. I planned to 
integrate a BeagleV-Fire board, which will also be used by the CIP 
project, but I observed large latencies on PREEMPT_RT that I cannot yet 
fully explain. See the discussion on the CIP mailing list [2]. It is 
possible that I will stick with the VisionFive 2 board for now, as I 
know what to expect from it. In any case, I will integrate one of the 
boards into our CI as soon as I manage to do so.


Best,
Tobias


[1] https://gitlab.com/Xenomai/xenomai4/libevl/-/tree/master/tests
[2] 
https://lists.cip-project.org/g/cip-dev/message/21503?p=%2C%2C%2C20%2C0%2C0%2C0%3A%3Acreated%2C%2CTobias%2C20%2C2%2C0%2C117149606

> 
> I guess it's too late for 6.18 as we still have some problems for the
> existing archs, but 6.19 (once we were able to catch up again) looks
> doable.
> 
> Florian

