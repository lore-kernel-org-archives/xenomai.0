Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795782333;
	b=fsItdQfcXpVfr9SHz9U1FMJkTy6Vxo+g8lEfHvR0ClVtJUnzKrlVIhZUv9qyWv94Ruqj
	 zLUdAx8chiAZ/XaC1tncN5FNtV7uoOcq5S0dmRsFdhQXudy2o01v9XvGutmNy8buqy0X9
	 X5I/fs+OQVs0G+hHcpO3HSdgf7Yyxio7PfXb+w4cAmj/4YnA+y/S/Uz8Wtd02ozfrTLwH
	 iA1d5GuCgm9pU9L4AZmc1qmWRkkiRhgahs3rePYo46Cm2CtUZzYdHKoTRYnqEoO+VqV2H
	 RcjeS6djEc66qGD1ePkKm88PiNSFu5jbZ3EJUjxopKhuWAh5Ho7tBFmkw6iUI4e/KuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782333;
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
	bh=5KflJs6l7sznOHctdYqrcU4YgQA6UQoI2sP7zI5RTKk=;
	b=QjIwOf3HXPX0TGIFVj0SCKPltKzPmWxADI9LYzAgCqql/NlnQijZxf27uiTgAar4i+yB
	 u04F+cYHdYq2iHSwIhsAlCR6xp4ktn2R0xpI43oaouQ+/Zq8FC1PjSS9cUui8I54iRQVr
	 C5DqfISAak2g027+N6CJsR46LzQ+9hzo4cfcn1bkJJt5g0o0vNGy1Z+N2OMF0unIynCPc
	 BUum8n+MxIdQ1KvxqZVw/eS4gWp2cV0ddRVCL+/uY8cOHjVH5VJhWIvEnMUSBh8DqFYk1
	 ZgNyR/2ywiIYxbMADRz3q3h1WY238KvQvKhwazHSl9ZnKtLnBf4Fix5JpC8b0hyTmFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=d6CIgs0o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.40
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE37606A31F
	for <xenomai@lists.linux.dev>; Fri, 27 Nov 2026 12:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE37606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=d6CIgs0o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWEmO93eMWXg7smILSzjBQLZAQelTpPCNrRyLOy02sDosWPLxy7Z+qrcNQou2P1E+vkt1Jy4SF4K3hOXKDyYWKxNfWFQIkc9H7JZXfgGDOyMANRqWrm5neFyVqdTS1Jr9fKkL/bjKjwc1XlRdwngIUK1+4/YpjxocEhOnyAq9aYIjO1tF2bFd01iYhdk5bcZQ1k64QlEtBuA2460j+6hBXb+FM3VZznJFI3nWmdTCirPiW6yFU3iuOG5Ted2exsZOl/8A5fG4enKFAIWKnZunBVu2ce6Ru5ghwDMAboy7c8mNZZKrALir73KWANwOSAflhpfF8LnmQsSXjLeWYqAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KflJs6l7sznOHctdYqrcU4YgQA6UQoI2sP7zI5RTKk=;
 b=PN+lqi6+qpSzJJmGA5IYt44uVKbph+VGNJerIncnep4qSHFCNtcy7qcbetSLVjSmTPbaIldV5md4j2ZsVQwwBwnrmXd1Y7t1/RUkmr58Y3ajyUumTNQQ7NTYhSw54EN8X/2bHZhseeRNPwIQFZ4IvzCkMyHy1pfBISE8q+kx8Wg6xvQz0iZh8hqkIv44l9xs4qzp5qzeU3oHUS7NMifpo8QBcahydpXUVm86act8mxFuI8eS/7FrwE1KhyzqjhRrlmRc3lbA038Oo4/xmK/eL7s3IJuSjDxCfgG7U9g2mZdJ/mrGPQMnlYWpfTlAGHr4U6vqqpWb59GAVk9J7aSEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KflJs6l7sznOHctdYqrcU4YgQA6UQoI2sP7zI5RTKk=;
 b=d6CIgs0o4Dipkynjniai0/M2AIqiOyENlXbUgT6fZfwv7mVv5gK7KA5Im7dN/o8Bs5HYbPnAoD5HSd+wEONutKYGhFx9z/sPQJ0MmEXImFyqG269JGW+EqY1ybAnhMSTD10my8evmMSk+e6KNgKhkX+fphc5TpuYQzvU1VHc5YJTAxGSUPES1NhGITNT8VtCbGMCVp31QqCIXwZCcGMPuJ7V3F7sLnJK4Pn/Kw5biAkyOY+a2MXxtrvfjLvu9ZFK0LEVwfw0+wNCjkzX3qgObI8rvu2hNoCm1MH5m0Cd+WIfNXRU3efVz8+INH00ZxTAoYQ0YJN7fT/BQ5jPtmeufw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM7PR10MB3654.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:141::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 12:25:29 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 12:25:29 +0000
Message-ID: <235eb17a-e818-4434-8c5b-81dc9371e43c@siemens.com>
Date: Fri, 27 Nov 2026 13:25:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v2 3/4] riscv: dovetail: inherit the hard irq
 state on kernel page faults
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
 <20261121165933.57310-4-tobias.schaffner@siemens.com>
 <DN2371TJAB7G.334DTWMEPJTQI@siemens.com>
 <915d53fb-fc8b-4c07-935f-a9d4680ee8a5@siemens.com>
 <87afa16be7aada0d995e63364bb9e7785af24675.camel@siemens.com>
 <5e8681d8-7d2a-4337-807d-80eab19d36cc@siemens.com>
 <e55022378f5d521c20e037597c04a8698b615a15.camel@siemens.com>
 <0a1ae6c1-55ef-4e48-b9c5-b3963923701f@siemens.com>
 <09e0fe247ecf465c589e189338d58ec78f7eba98.camel@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <09e0fe247ecf465c589e189338d58ec78f7eba98.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0276.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::6) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM7PR10MB3654:EE_
X-MS-Office365-Filtering-Correlation-Id: 2434db79-93bf-4115-f1df-08df4c818613
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|23010399003|1800799024|55112099003|10067099003|11063799006|5023799004|4143699003|56012099006|261021123027099003|261102123227099003|261009223027099003|261021121427099003|261022075727099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZSJHIvm3HEm70+3cpb60dyWKbAciZuMa/NtMzAuVUx2Nl2Fu+sro/Mug4SInssvCbHes0So8vOOMYIMVK4d4W6jJPYUD/F9810L2Xk/lcQwqq0agTcg1OGjHuU85NQt9hxOWPx6Zz9yQY5br4EckbIeBbtTMjrQPfFiWi4+YDim9jk5qDylNfD87cLYAUEQ/fAKzhySbilUS0mZPf9t7/XkDiHZjquF16xcadnwP6ayWqY9x6aWOimVxymMwPgoedW47srkQWrz4E2+xnSPIqdM8PflM+blTevPzKE2n3gviY84QLF5KrrFvv5xiA+KQqMvlDJX4OAjj0ec4SNmID+N6nP3z3KTWVOrM2NRnO405gUvreCmWiPgDpEWiDxLS6QWOChWGWE3y+594e74lkfXwc8dmUyoAlqt4k7Mw1ZJxApTAzvlLJWAhBwVpaK0gJP1mjD6afbtK+I/BnTeogPcbPf9LavQDHqjj69GNnLME7d9Ml0iyRF75lwiCeeAtLU8toPi4YfxbDh+lOmSBJLeyUjfWnRpsVox4sCvKhtnM/6PIP7mVX0sK4zdEP5V6yaRLl/+5Gc9XolS9M5dZggSVVXajdmNqrA0GjQAE/vQltDqKu8uhmpLeA7KlAADWTDekoIxJs5IJ/Fh1SUwROMcmkfm3fkMvohKqdKm1Jfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(23010399003)(1800799024)(55112099003)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(261021123027099003)(261102123227099003)(261009223027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU5ySHIrckM1Lyt5M2p1a1VVemdQWS9XWnZzeTgzUkEyaGJmaDFUR3VCTFRS?=
 =?utf-8?B?OTR3aVZtOVBiNVJDY0RwZnRXbU9DUzRJVVNMdmUrZXFNem1KOFlIdG02T1Nv?=
 =?utf-8?B?czNZdTBidkxCc2toWEhldzFVNGwrVDB4NlNlNWVtL2xmTThURCtYQmtzVkp1?=
 =?utf-8?B?UXRaOS9xT29FcEFTdmFrWitVRTcra3NtTGI3cTFiVnJ4ektETkQ4Znl0MDFv?=
 =?utf-8?B?dGIwUnAzamlIK0xKK2FZaUZVemh6QTNhWXRiNmZBYW9vV1p6UHM1N25aZ01a?=
 =?utf-8?B?eUNBYWtBeEs5UVlobWw5M2lIbk9EbVBIRy9DMXk3NythZDdGbWtFY3BDUk5y?=
 =?utf-8?B?ZU5DWHlFa1JoREZZeWpQUExDOE9KbVpTZmRUMGFORmJNRlgyNUJYcGl1dURT?=
 =?utf-8?B?c2c2TnBTaFc1YXRaTzZlc3hnYkd3elozYnRkZ2NwK000SmViWUtMZ1ZqaDVZ?=
 =?utf-8?B?Nk84V1BhNnFrWnhEdC9yeExqZlBNZ2F4ZUVXcDVIblYrU0wxMnA5ZkllQVBk?=
 =?utf-8?B?K3ZFSHRqMUdSU3NHOStLbHFUWUZtOTFxd3RlamlXVldvL2JLS1FpQjBjKzg3?=
 =?utf-8?B?cGdCTzNZaEE0SUI5UjNYK3RTa3FzWXBoZ3BtMm5wZTV5OWYrc0NlY2dkTkV1?=
 =?utf-8?B?bi8xYnRIVFdwek5PcXc0aWQ3NGh0bzljUjhKa2MvQVJBNVpmK3NRZGo3ejFz?=
 =?utf-8?B?OE40VHRVZm9tajdhL3d4SzU5TDNFRkFqMytCZ0hrdk5Ud2lRMnJVZ3BQV3RS?=
 =?utf-8?B?emI0YllReFF6N05EK2xjdUQrekF0OXhzU3VDWDl6ZGN6NHBQbEs2R1Eranp4?=
 =?utf-8?B?dEorL2xkby9iR3hpL210Zng1KzlMRXZlVHlMa3krcnJiZWRUOFRxSWZ2YTEz?=
 =?utf-8?B?T25zNlNMNUVFUWwzZkZQTFUzamU2Vzd2VHkrMlV2NDJCaFpEb3VGTnhZQUIx?=
 =?utf-8?B?RG12MEpBL3MvdlIwWlpGd3lpZ3k2UlgwV2puT25zRzFvckVIcGJSMEJjZHBG?=
 =?utf-8?B?a001OGVMSmZ6N3hNa1ZWR2N0UWlMcTRDZmdaakxUcVVQTG5lOWtBOWIycU92?=
 =?utf-8?B?TWkyMmZsR0htM1h0cUphdjU1SlhuZVBSRkttck5BcFFzODVpRytFWjAwQW1U?=
 =?utf-8?B?clNqaGZ5QVkwcUZFUXk2WU1zUHZIcjd3TlFMNjJWWEFEUUk1VEtRcDZvY0cw?=
 =?utf-8?B?bTJSaFU0TWVKVVNFTU80UVA4RlUxYVRmeFc5ViszbW1pdFFQY1hlUUs5V1lB?=
 =?utf-8?B?aXlwdjhiY0xxUmM3cDhlZFl1WDhYazdNcHdkUHRldDczWTB3bUtDb3JyczJq?=
 =?utf-8?B?ZDNvaWgwRDRkREpoT0Qzb3hXTG4rM0QvL1VxNmswWUlkSFA1QmJ5Qkx2M0Q1?=
 =?utf-8?B?QitDMThvUlErd0g0YTEzVE9Na0pRT2NhMEJINjJCYThBUnBDb09lRkszUjBY?=
 =?utf-8?B?NFJoRUh0R0lXTkl6SGEzSi8zSUIzSi8vQk5YWUpSL1U4ZTRTOFZueWxmU3Br?=
 =?utf-8?B?YnpWSFNVaEVuVjlRalVyRmgxN0xZSkRyczJoZng5SURhQ2c0MElkcjUrZUpq?=
 =?utf-8?B?R3VxQ3VIWHV2TWpKTFZBMTZ2UEFGdXJJL2FIbFdmUzN1d0ZqeUxDM2ZWaTZr?=
 =?utf-8?B?V00rcHpzREIwS05wNWFKZks4MkpoMEI2MzUrN3UyZ1RXdEdLR1U2b2dOVllz?=
 =?utf-8?B?T0pONGQ4NUtMRmZZS0dMOGIxa3VWYjJyTkYrYkhYZmVlajY2amw3eVc4NW1P?=
 =?utf-8?B?ZzhGaUlSTFV1cXF5bDV4NXIvckgyR2VyV2xvWkl5cllVK2ZwNjVUbmY0WkZD?=
 =?utf-8?B?UUx5SlJId2RPc29meEZjVWlGNWVVZW96aE5rUlJ3T0NURjFEQnhyR2dNVk1I?=
 =?utf-8?B?NXdEZEVmN05pS1k4MThVU3lwdmRFL0UzV3lCa2Nsbk5BVE92TWdMYnFjRHNR?=
 =?utf-8?B?SzVISzczSDBhQWJ3RU90Wit1dEN6a1hOdXhFKzBsdGJoL1BKVG9nd3lmeGFL?=
 =?utf-8?B?S3BLS1ZFdHhwRENFbSsvUmx3UkJzUUFUbEFrQTZlQUIrUXM2dWN1cSt6YUky?=
 =?utf-8?B?VFRQMlBCNlQxRksvV3gvdHBEclNtbGJ2NW9BWUdzNEVHUjljSEd1QU9VZWtx?=
 =?utf-8?B?M2FCUjgya2hwL3RUaDA4UU1hakl4bXluWGJsd0ZlNEVHd2hheUVObFdEMkVT?=
 =?utf-8?B?SGc3dTl6RVVUN2IySStrTUZRUlhrSWR6M2pycUN5UVFwR1k0YlFselVNcXp3?=
 =?utf-8?B?OUJYT2xneHBXZlJTKzNLaHBQZEJ4TzVJQjRYdERPMmVhODE5R3o1c1lrRDdC?=
 =?utf-8?B?RThUU1JzZnZVZlBFNVBMMk9ndUZOaGNZemhZTHROMTd0WDltVUtCNTZTL2tz?=
 =?utf-8?Q?n6uWumQXl/Ih1sllUvWn3zhXVZTtRfvzsfw+tTYneoavf?=
X-MS-Exchange-AntiSpam-MessageData-1: 6w02M2KfAGpgkKEGzQAXfm67Bv/rFatl9Dg=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2434db79-93bf-4115-f1df-08df4c818613
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 12:25:29.5902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IXgsofWwk5SJtztggiIY5qAceRfvomsciQBCM8b36JESe+scKeM5GrWz5/e+2ojjD0cPz9MImGDPCdgVB/ADv1alHDCcrx8wuXlwf2ixWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3654

On 11/25/26 12:13, Florian Bezdeka wrote:
> On Tue, 2026-11-24 at 20:53 +0100, Tobias Schaffner wrote:
>> On 11/23/26 23:12, Florian Bezdeka wrote:
>>> On Mon, 2026-11-23 at 14:43 +0100, Tobias Schaffner wrote:
>>>> On 11/23/26 13:05, Florian Bezdeka wrote:
>>>>> On Mon, 2026-11-23 at 12:39 +0100, Tobias Schaffner wrote:
>>>>>> On 11/22/26 23:18, Florian Bezdeka wrote:
>>>>>>> On Sat Nov 21, 2026 at 5:59 PM CET, Tobias Schaffner wrote:
>>>>>>>> A page fault may hit kernel code which runs with hard irqs off, e.g. a
>>>>>>>> kprobe whose fetch argument faults within the breakpoint trap. The fault
>>>>>>>> handler still enables hard irqs for every kernel mode fault, so an
>>>>>>>> interrupt may break into that code. If the fault is handled out-of-band,
>>>>>>>> the handler also unstalls the in-band stage over the out-of-band stage.
>>>>>>>>
>>>>>>>> Enable hard irqs in handle_page_fault() only if the faulting code had
>>>>>>>> them on and we run in-band, and stall the in-band stage on exit only if
>>>>>>>> we run in-band.
>>>>>>>>
>>>>>>>> Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
>>>>>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>>>>>> ---
>>>>>>>>      arch/riscv/kernel/traps.c | 11 ++++-------
>>>>>>>>      arch/riscv/mm/fault.c     |  7 +++++--
>>>>>>>>      2 files changed, 9 insertions(+), 9 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>>>>>>>> index a8e37ec27cc2..47799f18fa7d 100644
>>>>>>>> --- a/arch/riscv/kernel/traps.c
>>>>>>>> +++ b/arch/riscv/kernel/traps.c
>>>>>>>> @@ -488,17 +488,14 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
>>>>>>>>      asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>>>>>>>>      {
>>>>>>>>      	irqentry_state_t state = irqentry_enter(regs);
>>>>>>>> +	bool inband = mark_trap_entry(regs);
>>>>>>>>      
>>>>>>>> -	mark_trap_entry(regs);
>>>>>>>> -
>>>>>>>> -	BUG_ON(dovetail_debug() && !running_inband());
>>>>>>>> -
>>>>>>>> -	if (!user_mode(regs))
>>>>>>>> -		hard_cond_local_irq_enable();
>>>>>>>> +	BUG_ON(dovetail_debug() && !inband && user_mode(regs));
>>>>>>>>      
>>>>>>>>      	handle_page_fault(regs, state);
>>>>>>>>      
>>>>>>>> -	local_irq_disable();
>>>>>>>> +	if (inband)
>>>>>>>> +		local_irq_disable();
>>>>>>>>      
>>>>>>>>      	mark_trap_exit(regs);
>>>>>
>>>>> Below comes another hard_cond_local_irq_disable() call that is a
>>>>> duplicate as already handled by mark_trap_exit(). => More code to be
>>>>> removed.
>>>>
>>>> One is for user_mode and one for !user_mode().
>>>
>>> Can't follow here, but I agree: Some on the confusion is/was on my side.
>>> Let's bring back the complete sequence:
>>>
>>> 	mark_trap_entry(regs); [1]
>>>
>>> 	if (!user_mode(regs))
>>> 		hard_cond_local_irq_enable(); [2]
>>>
>>> 	handle_page_fault(regs, state); [3]
>>>
>>> 	local_irq_disable(); [4]
>>>
>>> 	mark_trap_exit(regs); [5]
>>>
>>> 	if (!user_mode(regs))
>>> 		hard_cond_local_irq_disable(); [6]
>>>
>>> [1] and [5] open/close the trap handling section. Entry into this area
>>> and exit from it should match. But: [2] is inside the section while it's
>>> counterpart [6] is outside the section. That's a mismatch (even if the
>>> code does the right thing, more later).
>>>
>>> [2] and [6] must be in lock-step. In v2 only [2] has been removed on my
>>> request, because it is a partial duplicate, right, but removal likely
>>> leads to confusion.
>>>
>>> [4] must only be called when running inband.
>>>
>>> Now the most confusing part, at least on my end: My expectation was that
>>> you follow the same pattern as x86 does. But that is not the case. The
>>> page fault handler on x86 does not use mark_trap_entry/exit() at all.
>>>
>>> That's why cond_reenable_irqs_{user,kernel} exist. That is - so to say -
>>> the IRQ mask touching counterpart of mark_trap_{entry,exit}() on riscv.
>>> The fault handler itself is directly calling oob_trap_notify() on x86.
>>>
>>> hard IRQ enablement inside the page fault handler:
>>> I went to x86 today and reviewed the code again, mostly to make sure
>>> we're not following a broken pattern. Outcome: I consider the x86
>>> implementation as correct.
>>>
>>> The main logic (on x86):
>>>
>>> 1) Re-enable interrupts following the following rules:
>>>
>>>      - Fault over user space: Enable hard IRQs and in addition,
>>>        when running inband: enable inband IRQs
>>>        (see cond_reenable_irqs_user())
>>>
>>>      - Fault over kernel space: Enable hard IRQs and in case the
>>>        inband stage was unstalled on fault entry: enable inband IRQs
>>>        (see cond_reenable_irqs_kernel())
>>>
>>> 2) Notify the co-kernel, by calling oob_trap_notify()
>>>
>>> 3) Call the fault handler
>>>
>>> 4) Restore IRQ state (see cond_disable_irqs())
>>>
>>> Coming back to risc-v now: Starting in do_page_fault(), I see a
>>> completely different order of things. Starting with mark_trap_entry()
>>> being called which notifies the co-kernel first, without doing 1) as on
>>> x86. At least the notification has to take place under the same
>>> conditions as on other archs. Otherwise we might confuse the co-kernel.
>>>
>>> I hope that helps (and makes sense).
>>
>> You have a point regarding the ordering. Thanks for putting that much
>> effort in describing this in detail. That helped a lot.
>>
>> I will have to spend some additional time to think this through.
>> When comparing both I also noticed that some kernel traps are not
>> notified at all in x86 and arm64. This will eventually make it a
>> bigger change than I expected it in the first place.
> 
> Stay focused on riscv for the moment. I can have a look at the other
> archs. What do you think is missing/odd? Any pointers?

Sorry for the late reply.

X86 and arm64 do not notify kernel pagefaults but tries to fix them
up and returns in this case. Seems I missed that and tried to handle
all page faults the same way.

Does the pattern below look good to you? This is nearer to the
implementations of the other architectures now.

It shows the overall Dovetail and EVL changes on top of vanilla
7.2 touching page faults. Thought this is easier to review and discuss
in this case but feel free to directly request the patches if this fits
your workflow better.

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8c62c771a656..689861c7cf5e 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -413,14 +507,75 @@ asmlinkage __visible noinstr void 
do_page_fault(struct pt_regs *regs)
  {
         irqentry_state_t state = irqentry_enter(regs);

-       handle_page_fault(regs);
+       handle_page_fault(regs, state);

-       local_irq_disable();
+       /* Page fault handling might have reenabled interrupts. */
+       local_irq_disable_full();

         irqentry_exit(regs, state);
  }
  #endif


diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 04ed6f8acae4..483537214567 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -79,6 +79,7 @@ static void show_pte(unsigned long addr)
  static void die_kernel_fault(const char *msg, unsigned long addr,
  		struct pt_regs *regs)
  {
+	irq_pipeline_oops();
  	bust_spinlocks(1);

  	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT 
"\n", msg,
@@ -111,6 +112,9 @@ static inline void no_context(struct pt_regs *regs, 
unsigned long addr)
  		msg = "paging request";
  	}

+	/* Dovetail: switch in-band for the oops. */
+	oob_trap_notify(regs->cause, regs);
+
  	die_kernel_fault(msg, addr, regs);
  }

@@ -275,7 +279,7 @@ static inline bool access_error(unsigned long cause, 
struct vm_area_struct *vma)
   * This routine handles page faults.  It determines the address and the
   * problem, and then passes it off to one of the appropriate routines.
   */
-void handle_page_fault(struct pt_regs *regs)
+void handle_page_fault(struct pt_regs *regs, irqentry_state_t state)
  {
  	struct task_struct *tsk;
  	struct vm_area_struct *vma;
@@ -314,9 +318,31 @@ void handle_page_fault(struct pt_regs *regs)
  		return;
  	}

+#ifdef CONFIG_IRQ_PIPELINE
+	/* Kernel addresses and hard irqs off code can only be fixed up. */
+	if (!user_mode(regs) &&
+	    (addr >= TASK_SIZE || regs_irqs_disabled(regs))) {
+		tsk->thread.bad_cause = cause;
+		no_context(regs, addr);
+		return;
+	}
+
+	/* Enable interrupts if they were enabled in the parent context. */
+	if (!regs_irqs_disabled(regs)) {
+		hard_local_irq_enable();
+		if (state.stage_info == IRQENTRY_INBAND_UNSTALLED)
+			local_irq_enable();
+	}
+
+	/* Unless it switches us in-band, the core handles the fault. */
+	oob_trap_notify(cause, regs);
+	if (!running_inband())
+		goto out;
+#else
  	/* Enable interrupts if they were enabled in the parent context. */
  	if (!regs_irqs_disabled(regs))
  		local_irq_enable();
+#endif

  	/*
  	 * If we're in an interrupt, have no user context, or are running
@@ -325,7 +351,7 @@ void handle_page_fault(struct pt_regs *regs)
  	if (unlikely(faulthandler_disabled() || !mm)) {
  		tsk->thread.bad_cause = cause;
  		no_context(regs, addr);
-		return;
+		goto out;
  	}

  	if (user_mode(regs))
@@ -333,7 +359,7 @@ void handle_page_fault(struct pt_regs *regs)

  	if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & 
SR_SUM))) {
  		if (fixup_exception(regs))
-			return;
+			goto out;

  		die_kernel_fault("access to user memory without uaccess routines", 
addr, regs);
  	}
@@ -356,7 +382,7 @@ void handle_page_fault(struct pt_regs *regs)
  		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
  		tsk->thread.bad_cause = cause;
  		bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
-		return;
+		goto out;
  	}

  	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
@@ -374,7 +400,7 @@ void handle_page_fault(struct pt_regs *regs)
  	if (fault_signal_pending(fault, regs)) {
  		if (!user_mode(regs))
  			no_context(regs, addr);
-		return;
+		goto out;
  	}
  lock_mmap:

@@ -383,7 +409,7 @@ void handle_page_fault(struct pt_regs *regs)
  	if (unlikely(!vma)) {
  		tsk->thread.bad_cause = cause;
  		bad_area_nosemaphore(regs, code, addr);
-		return;
+		goto out;
  	}

  	/*
@@ -395,7 +421,7 @@ void handle_page_fault(struct pt_regs *regs)
  	if (unlikely(access_error(cause, vma))) {
  		tsk->thread.bad_cause = cause;
  		bad_area(regs, mm, code, addr);
-		return;
+		goto out;
  	}

  	/*
@@ -413,12 +439,12 @@ void handle_page_fault(struct pt_regs *regs)
  	if (fault_signal_pending(fault, regs)) {
  		if (!user_mode(regs))
  			no_context(regs, addr);
-		return;
+		goto out;
  	}

  	/* The fault is fully completed (including releasing mmap lock) */
  	if (fault & VM_FAULT_COMPLETED)
-		return;
+		goto out;

  	if (unlikely(fault & VM_FAULT_RETRY)) {
  		flags |= FAULT_FLAG_TRIED;
@@ -437,7 +463,8 @@ void handle_page_fault(struct pt_regs *regs)
  	if (unlikely(fault & VM_FAULT_ERROR)) {
  		tsk->thread.bad_cause = cause;
  		mm_fault_error(regs, addr, fault);
-		return;
+		goto out;
  	}
-	return;
+out:
+	oob_trap_unwind(cause, regs);
  }
