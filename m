Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD732C326F
	for <xenomai@lists.linux.dev>; Fri, 30 Jan 2026 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757529; cv=fail; b=Z/BJzF4BhCBc1MQnm1c+DJHYoCPhA62iBg+qopkoH6WdpMiBGLXauOKuVJyZND1rhBZB+ZrQuRDWf3QC1rpyMH1UIe5sbgMZiZMr49wxGhcT43Nu4m2aEMfYOSqco8miKONA9dw6SczEVYjzeJ0IfkYGxnyieCi5G+AAzMlWGuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757529; c=relaxed/simple;
	bh=6bYPShWVOsAZy7dLhxkovMqTS/BLPad7cfb3/M2krs4=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=bQBpPtp8gS+sY1C38jpkwJEupyuMa+knGahG7h6QT2wwkW75vHwgcv20wCCcHXB5XGDWEKwFNqfWxaLfNkbVUypa7YGEjdkfbHdIXQZpqIHiAiAbaBCdCDt6TE/X+6PAcnjSPIBw8ufjqxBhw+llJjbTB4YVJLHuwsQ/0WU7Vrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vo2iiGsF; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vo2iiGsF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiyNL85z9hvrH5uj1nIodkZglYjadt6iRQTTf6AbTUIUzuUbTsFHmhUAnqNYffSr2CcR9X8MDTGX4B/EIIAvbRkRM4Hb/UmYEJZtmI3/aiqaRuy2uqySRLzPk4RwqHZzS8ao59EysDYYy7rs5pSI9WL6ZJzKUgWI8+js4LnbX9/NDnjSgYAtmLF/d9lT/MlZTGkZ37agl2gOEtWgBz9VyylyOqwhQ9RMQNwjwJTASCFIrCx1e5UWEgPC+D+mX5ulRRj11QOCqfXoXrGcByK6IsQfvz5R1+ih3yWTq9jYojxvmClHwR7PtJjB0C1ZX1v6XTKUzz8ohu7a1lOuGuWVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANPoWFoETcodAbdfOmQE5g1nht+Bc4wm1wxK5kFNTf4=;
 b=qp0C7TtKaT00W6zVoyA+6zJahjYTnsKnjzXSeFSJUvX3USP2ulDeSqB1K9VGMrZNH2TOEIrAt9qS2sXEmirWIFEuJjiqDlhDW4UpSN+Tb0GHMcx75nbzc7H9xfmiXRag64gDLjg44dEZ3onkVe/BPhIbnYTvpmtmvDBp8MBzvmvELs42YZEBCOmjzYGKjkuylsYb2AB9FsXBQ+RIR5V3EH6NL6P0d4Tkpwh/RzomB2ABIaWD20ywxyfBGtqWHblatZ7Sv08F/UufaS2xUwzRePFWLIexFdnzQ5gi7J7Byn8Y9q9gIvlMt1tsZuIPxZu+uGbhOVPk0Lw4FXzMSlEjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANPoWFoETcodAbdfOmQE5g1nht+Bc4wm1wxK5kFNTf4=;
 b=vo2iiGsFqBzDt3ECggQCcnngordsB50gs7N/PELuXxB0D9RC1C5iiRCtTtWTZGZX7voOAT3D/zKkdzVwJOmfpGp7I5X3XQOBkISWHgMWCKd+I5jczbtXWXgNX6VtCbBYytemf8FTFR7M4705dcoNXmmcS2qbmxjV+yEzb9a40Eg1hMXf7OgSg/o7uLmTlut7SloJ3eK+Go+fUh5PD626NlX5pI2BAA/UEgDbG2GHV/T4b9rEd1ej4WmK2Bm7aASmXbT+EdU/ERhX6Wa/aa4568tVQscSAeiwWHjczuifqSSWih+wGwi7cRbEDmPWhZt4o2U/4HKfrGvZyJKn+BtWcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 07:18:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 07:18:42 +0000
Message-ID: <7303ef50-ae85-4fe2-99bf-cdac90a10c63@siemens.com>
Date: Fri, 30 Jan 2026 08:18:41 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] lib/cobalt: Avoid making mmap offset argument unconditionally
 64-bit
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: a5486a66-e9b2-4a1f-e3a2-08de5fcfcc0c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z25pVWVocHJ5SzdOeGJIREg1bDZDemthdnZxQjBRR3E4cXhjbTFwT29QTm1l?=
 =?utf-8?B?dmhnQW13TkJ2d2pIV3hwNk1kYkhPcFdidDNzZExpRFdPeU03dTVkMU5tMVVZ?=
 =?utf-8?B?MFdJQUFuYzFwR2tPS0tPanA2ZFYwY29obnlEc3FONXpMbENOVkVPMVdJTVpt?=
 =?utf-8?B?NkdjeW1iS09UMkxDekEvOUZuZlJMK3FwOENCejF3am5KZXpIQkwwcXJ5NzJV?=
 =?utf-8?B?MTQ0cHdCSGtsSzNReVM3YmtqSWV4SjFOL0VUVi9vWnRHUlBFbUhTb3Noemxk?=
 =?utf-8?B?dHI2WUczUktCeTF2V05wUXNCZHZmYVpxQ0VZaUJ2VlRyTk9TdmFPZExpeG51?=
 =?utf-8?B?c1JFTHZzY01LdnUwcHZWN0lZUnQzWUswVWgvSzBPVkkyUWxqZ3Yzc0ZCTmNV?=
 =?utf-8?B?WW9JZTg3c2s2VnB6OXBZdkdBRW5MbEZtNjZXUDhXMnRJV2NzWmhIRmhWMW9L?=
 =?utf-8?B?dHQrdXNWbkNFOHJFMUl3WTFLdmpIbXlTOEc5aDRBRWNtaXhCV21oeGN0d1N1?=
 =?utf-8?B?b0M2YWFjbkwwLzBUWUMrTENqcnBUTFNmZmhGS0g1bmtsNlVhdEMrbk14bGJB?=
 =?utf-8?B?bVN4bGVvMGJJK1NCMHdTSmN4b0RkeTA5RDA3YmM0cldKSEIyWDNXVVBnZEh6?=
 =?utf-8?B?cUcrNXRadzNzSnFnNjFTQUx6dy9kRjBqUWhYRHRaTHhHY0dINno0dStCMFZ4?=
 =?utf-8?B?d0lBM2ZlSUUxYklPZVlVWjBIVzEyL3d2dUFZZGVmcWNVa1Zjd2dxVGhYNjZ1?=
 =?utf-8?B?ODQrVnRDbVYvWmJ4WXZyaTFRdkZWRVJoK0xMc0ZlM0ZuQVVCTDFoM0pFNnpa?=
 =?utf-8?B?SzQ4dDZUTE4vL3YxaXE1eWd6UFlzWmFuWGR6dHBrTFRHOVhHVWNEZDRBSUhu?=
 =?utf-8?B?NGk1clpwMHdLRW0vVXRXZUsvOE5xN2tpSytGaHJrNUkrSDFiTG40aGYxbjdV?=
 =?utf-8?B?M2RWZ1RhOXBvU1RwMDZMcG42b3kxSlBmVkltdkdCemtWU29HM2tGcGVxajJK?=
 =?utf-8?B?NWxURkZpUk5ncXVVSWxPZTgvTGpzbzJrZ3J2enFUcmFmQnNXcUMrMWQ3c2NM?=
 =?utf-8?B?N2owclhxaW5SQ0hsUjU5ektUMTNvYVdxekRnRGZtL2xCMlJuK21aNUpqK005?=
 =?utf-8?B?WkRRVmx0RkZKUkxTemhBVVlsdmJnbjVyWm9CeWNmYWF2Sk5uR0VEUGdTWjUy?=
 =?utf-8?B?NGJuTUZjUVNTd0s0dkR5cFNjcTVsd0VHeWw5OGZVczNSb2xLZERYbFdLcE8v?=
 =?utf-8?B?a2h0bko3LzYyTGtRc2QrTSt5ZWpvbW1YcnNnUjVHaDJ3c0pSV2VTb0JGUjhS?=
 =?utf-8?B?MHhjWjgySjE4SmVBUHBJVU94NGp6cDJuSStFMGFsQUtSZlFUbFh6NktWR1FD?=
 =?utf-8?B?dWNHcEhDYXZlN1lJSUdWcnhwUjNyRVRjYjIrTFFtcnlaSk1nS3pKczVUWUFQ?=
 =?utf-8?B?cUFIWTVGakdEQm1yZ2ZydU9VRjEvNUlBVndRYkFvWWZjeVRzY2VGVnR2Mmpq?=
 =?utf-8?B?cGN3YkQ3MGEzdTBIdE5JSVpNMTdIT09sR2kzMzVKTGpwa2NRSk5IUW9nYzRL?=
 =?utf-8?B?TDNDb3RJM0FTR2FjWlhWaklsNDJ6SHltWFM5a0Y1aGJTcG52aXJuQUdzWFZE?=
 =?utf-8?B?UGhNUGxKc01BcHo0OU9kN2s3a2tGU2xaVkc5bTVvRDI2ZEg2VjZyMTRtMkN6?=
 =?utf-8?B?cW5VVlJKSUZTcHFlQzVldzk1MWowZUp2SHlaQUZxMUFkM3djNFFiRTN0RXV0?=
 =?utf-8?B?YzZET2ZsMnhUa015dFI1RmRoOXQzUjhGalo4eHBpa05hOS9kZHowbjZyWjBk?=
 =?utf-8?B?dVN0amNJS3JMaEc4YTFtNWZGM3hiRHFLSEhuV2tLaE5ueG1JUUlYa3B1MU9O?=
 =?utf-8?B?Wi9yN1ZRSXk4bThjRzBDemYyWkI0bG5EcGtEMGNTWXpQd3ltZWtrd1lPK3Rt?=
 =?utf-8?B?WEtpemRxUzhKV0h6R1RWTEd1OGUzR0FWK0ZmczMzcjBHOEU3V3V2aXJGT1BE?=
 =?utf-8?B?K2tqanppa0lVTHpvZkFlTlhOdEo2QjQrVmFObGdJRjNxQ1B6djVkQUVpcWhR?=
 =?utf-8?B?SHJjRmg5Nmhva0NPVDh0L09OZzVaYWloblRMODZNVjJsMW0xcTVJeWszMmg4?=
 =?utf-8?Q?WbPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clNhL3BuZVFrSmJGakRkTjdvenNzSjJvL0s0WVJXdWJSYS9rc2thQ0Q0Y2kx?=
 =?utf-8?B?VENZNW40WkJGM2dIUUFLZXJnRWVoaHBtbjNrT1NTQ0s5Y3Nya3VJRzRSN0Nq?=
 =?utf-8?B?OXlYWEhLVTFTR3ZCTGNQOWt6QkcvUFBsSTBKUEdKRXZZSGlwb2xJQi9qWnd1?=
 =?utf-8?B?UTE1RWhOeGNSQXB1ZU9HMTdNMUh3NDNKOFBCN0ZXQmhldmhVOWJWZzF4WDhK?=
 =?utf-8?B?Q0g2U21jWkJHZ01qQ21rQzc1Y1Zvb2phSVUyS3h6a0o1WTRVUG9wUXBldWNX?=
 =?utf-8?B?RjN3L05aQ1VhTWlnOHdCRGtUWW5qcFozNFVSOVU3MWpvY1JreGdNZkR0Z0RW?=
 =?utf-8?B?SDdFR05pRU5KbDhUSE1Cc2FLcVliM3N3RDd1Uk5CZG42dDNGaENiY0FRelFu?=
 =?utf-8?B?MHh0NHRCN1dvdXVOUnlaVVBLUlAzeThXbUJ1bUdFTS9yeGZzblE5R0NvUGI1?=
 =?utf-8?B?R2JiVzZnd2JueEFnbno4bzdGNWlTTFlYQ3RIOERXR1hCRUZVb0hMZHI4QStC?=
 =?utf-8?B?TWJXTTVMb2hVUXV2V1pkdlpVdHRLd1E1azIvMEJVbUR4cGNrQU1nRDJDeVFw?=
 =?utf-8?B?NHpoZXN6OFI4bGNScWk2bzBUZU9XWDBZUGFDVFUrZmdIVVdhT201dWY0cWxs?=
 =?utf-8?B?WkpzTldJMURUUnNkM2pPVEQvZDVkWlNFTUxpaE1lQ2ZxZEx2elJUYlhDaWtY?=
 =?utf-8?B?WFQwdGNCUWM1Vmg2K0ZSNkpJUEVZYjhWZWVDK3lNN3dQb1RNTmNTbUtUMjRD?=
 =?utf-8?B?RXFocisrU3hQZi82S2U2aTNxMVJnVWluTExxK0txL3ArUDM1MlNTMGYySFdt?=
 =?utf-8?B?R2IxOFhBb1h0cjdud1lCT3kyQkJEWmlxd1pVTk53VDE2R0FFMnR0RkhSVzEw?=
 =?utf-8?B?cWRwR2Z4WXpFai9CZ2xYMWhCNHFZZERrV2Fva1B0bjdma0FNM0NHcDdabndZ?=
 =?utf-8?B?ZXJOa0xhQ3Axa0hqeDhTRE1rOHRTanNZaUVTYkJwTzh4NTBzRTQ1WStGUGlP?=
 =?utf-8?B?QVlubVJWZzZwOFJULzlZdW5XZHJSaG9XT0dweU05TEpCbWRZRUlIUGptemlu?=
 =?utf-8?B?M1VjbFgvWEYwV1VVOVpWSXhQRGFlalpvVlU1dHRoT2JYM0prZG42dzExRmJF?=
 =?utf-8?B?azNmd1dLU3MvRHp1VGdUR1VIbjVndS8vbHZlWis1MVE4SEV2QzZuZjNhYjlk?=
 =?utf-8?B?bTNSWmhRb01SdWxibThtS0xtZjNabUdJYlBlZVI5NGRWWERZb0RpQ2pMb2Uz?=
 =?utf-8?B?clYwNTVUTHBsUEhuRlZVMUloSVUxdi92S1I1bEFqYzhYVGdYRjVEU3liNmpK?=
 =?utf-8?B?R3NXb054YnVQZm01UmNpQTZaVVN6alpNb0FBY085NExYRGFvTHZMSGRPb2xB?=
 =?utf-8?B?Z0N6WWRlb2JWVVVhR3ZVb0Vlcmw1MzJVRXM4ODJEWCtoajBCamxaci9CdE1k?=
 =?utf-8?B?YS9jaFN0cy9HZFJEU2FOdWJCb2xQVzRYZzU4aCs4eWpwaFRGMk1OZ09EVDdX?=
 =?utf-8?B?b0FpdWJvb0FJUUFrNExnUFh6aHFBK0dzdkZwVHVxU0RFcDBXcnlHb0tBYTNW?=
 =?utf-8?B?dzEzQ1RucVFyTVJRbDk3ck4zZnluZldGM3BBS3ZnNm5rcldsa2JCZEJDTEQy?=
 =?utf-8?B?OWsvYnFuTHRUVnd5UjRIdWdEVGN4ajNndlRFNWE5enJGMlpReENhc25MeWlm?=
 =?utf-8?B?bDc0MVA2M0M1Y1dicVhSaGNUWVpKeEFiM1FLSjF3d205MnloVnNuM0dENjVp?=
 =?utf-8?B?eVZqUW1pYndweHBPMlR4UjNLUnp5VCttNGtJWDdxUXNGZUtjZ3NYRlBud2pM?=
 =?utf-8?B?bWQ3SGVlTnVlQVQ4VFBjUnA0MDFudGptRzVLRXVXaDR3NFVyMkozK3loZnRO?=
 =?utf-8?B?cHBwZGpMUUlPS3VBT3BtQ0xzYmtVQW5BUXp0SmZFSFFTOFdzTTRJMzJXT0s4?=
 =?utf-8?B?ay9vczhWMkdTSnA2UGVPMVRkbUpqWUFoalY3RmwxeHhTNDh3dkVHVld5d0xH?=
 =?utf-8?B?Z2lsbXBBMDVXZWJKUzd6VllyVkVFZGhsZmhqR2VkN1N1bVZYd0Q2SVdFNHdT?=
 =?utf-8?B?WXRVazBkK1NvbWY3WUpzSytFcXUxS2MreVlSU2pKdDFOR0p2Q0VUU3VURzlT?=
 =?utf-8?B?eEZmYVZvVjBocE9JU1NZTkl1eVh3TVpyWVJnbHdoQnlVRmZwY2U1SlBwQUNi?=
 =?utf-8?B?TjF6UzdVVkJLUkYvZmpZQzBObDZmdm5NZ2pYRnhnME52Sk9EbHY0d2t4UmxD?=
 =?utf-8?B?TXRwQjVqUndlbldEeFFXWVVRSSsrOHBXcllxclVmWW8zY1RaVDYwOFd4V2U0?=
 =?utf-8?B?OE1NZkVwY2NqUGhjL2E2V3ZTT1ljQlhOSEI3K01BSzZORnQ5eGFwUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5486a66-e9b2-4a1f-e3a2-08de5fcfcc0c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 07:18:42.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCgNbXu4pJmVrQ4O1y5OMB49raHlGSaAZaBIV6Xld38HhJ9j+8Na1lBcqHrKIkJWHVCXZetmvLy1nmg/0YrWOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6965

From: Jan Kiszka <jan.kiszka@siemens.com>

When _FILE_OFFSET_BITS is 64, mmap is handled by the mmap64 symbol of
glibc. The original mmap continues to expect native off_t size, i.e.
32 bits on 32-bit archs.

While we require applications to be rebuilt with the same settings
Xenomai was built with as well (either both _TIME_BITS and
_FILE_OFFSET_BITS set to 64 or both left unset) which practically
shadows this issue, it remains wrong to change the wrapped mmap function
in a was that is incompatible with glibc.

Fixes: fb2bd6e647a9 ("y2038: build: Introduce new build parameter --disable-y2038")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/Makefile.am | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 4318adf185..fef2ec9b69 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -7,9 +7,12 @@ noinst_HEADERS =	\
 
 lib_LTLIBRARIES = libcobalt.la libmodechk.la
 
+noinst_LTLIBRARIES = libcobaltext.la
+
 libcobalt_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 2:0:0 -lpthread -lrt
 
 libcobalt_la_LIBADD = \
+	libcobaltext.la
 	arch/@XENO_TARGET_ARCH@/libarch.la	\
 	../boilerplate/libboilerplate.la
 
@@ -24,7 +27,6 @@ libcobalt_la_SOURCES =		\
 	mutex.c			\
 	parse_vdso.c		\
 	printf.c		\
-	rtdm.c			\
 	sched.c			\
 	select.c		\
 	semaphore.c		\
@@ -35,14 +37,24 @@ libcobalt_la_SOURCES =		\
 	timer.c			\
 	timerfd.c		\
 	trace.c			\
-	umm.c			\
-	wrappers.c
+	umm.c
 
 libcobalt_la_CPPFLAGS =			\
 	@XENO_COBALT_CFLAGS@		\
 	-I$(top_srcdir)/include/cobalt	\
 	-I$(top_srcdir)/include
 
+# source files that require native off_t size
+libcobaltext_la_SOURCES =	\
+	rtdm.c			\
+	wrappers.c
+
+libcobaltext_la_CPPFLAGS =		\
+	@XENO_COBALT_CFLAGS@		\
+	-I$(top_srcdir)/include/cobalt	\
+	-I$(top_srcdir)/include		\
+	-U_TIME_BITS -U_FILE_OFFSET_BITS
+
 libmodechk_la_LIBADD = libcobalt.la
 
 libmodechk_la_SOURCES =	\
-- 
2.51.0
