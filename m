Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F05324B2C
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599062; cv=fail; b=J5YjKMJr6y2gIk1ctxiDI4ha9iSbw7rr7XUB7WINkPM1ao1Ygb9JEoGAVR0uBAm81NyCO78/kZQ3KrcELof9LqnERFc2Sl+Kwkxos1vhCHoUsa/i8RKgXehnhzp2aVHQXDZNyw6i279HkGcN9oVwkv0MMK2+cM9ZqJCYzyQaYNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599062; c=relaxed/simple;
	bh=+hbVLy1NaflzCghcb3ECIdy7dck7HScBjAamgjfPVJY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UrM5ndzSuYxXDuBuuek4hOEXUvnenUesbGvUwLARrAOn87kaq4qF1h9mJItztzB4Ctxdzkhlb0MwGFT/Rr7BdS4z75KZSk+wqgd/ePqgvRcpHLX5X5OSsPP/KK32807kAkALyX+N4sSsY5g40LoAXsy1szFC6yV3qIHHPOGRggM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=W7zCaoo3; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="W7zCaoo3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iz3vuO76fbCK1IUow9XOhf1LHlo6KF7E/Z3q5GpKrD3HsQua1EgyWXDurYu9yDqQmn+FnLqRis+N1ULPZ1UUCsmXK5I5EaoI8j6e4qiuAljDmim7oE/611XskLa2fQOw3yEJ3aKS/KChcP9EyNnNcAsX69g27r0RTV/EEljYEzh1DUyA+e3gUhsFMbpwtiCNJEfefmxQNnZIsonrDYedH42z0ROjPIwvh2t0sudRWom3GJlH5TW8JWxzg2c9emvA4DjmdLV5NaGiZKB5ojoEDA0Oef+bmWMICJk2sjbe1wnW2hYURXp+DOMyBor1ucmDcypizKDQ93sMyVoOLntW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mtk48fOhuFoC2iiMHoeI0u1C9ipEk1mGz9ifLO3kjb4=;
 b=g0jId+g0tP6VkJ/sMTCgi0yfC2EdXRNawN7a0Q9xZg797IujWplFDZepTQ2acGqAb98zYb4mH+8LdCmdGyWq6Y3yIJtUrvYKPR+SxJ7Zx2MP3Y+802X2LOxckOCGsxY0IgZxVtLyzdjH+vyLagcV9yoF0/KWU5R00a0gMrjrqMETyGfeQbrCAFJWHMJmfHM3DdzUB589BYsIfYa4US7R7eat11DV316F3cnpwsX35Z78BRfbWPgWdkHZm4oXx8deniVJSjr09A4YbE6nak60EQAnLbnuvV8N8qMO1yCSNBljA3Cnt6KC6bVe72LLlEfnoLQERqdAyls4OXNSyK9NuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mtk48fOhuFoC2iiMHoeI0u1C9ipEk1mGz9ifLO3kjb4=;
 b=W7zCaoo3Gumo40wYpufaxNrlW+krSSkl2j+dQooPM1kTp+LsnFoc8dqntapgvxectYzG1895rzdXWzEhrkrFZtMtKGyX34+aGLbG2xmouqeUmv0GzMMReNkhbxDyfwQSXKKEqjQoJJNeILQ2wUI6KFkogYcTguIXKebAJ1Z7+5L/3Rjhbqr4MNj+o2w9cwGvqwK3ScOT0spgJuxNGLNCLp0/G4tNxeaDh8RSk2ToRSmES87PBPiA5sC7WszSAuo9LstpgO/nsH6rOgk15pFpzexZy2zod+QfQaxylYM16J0f8CDrsptFY5UO5+bDlue8Ht6h/kmDrlm73Hxw9JdYqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 14:50:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 14:50:57 +0000
Message-ID: <420e254e-667f-4799-9e4c-4e4ee2cb4e53@siemens.com>
Date: Fri, 20 Feb 2026 15:50:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/20] scripts/xeno-config: Allow disabling the y2038 /
 time64_t support
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
 <20260220-wip-flo-fix-time64-32bit-native-v1-20-731c773e72cc@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-20-731c773e72cc@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: be1a4b9b-286d-4116-a6ca-08de708f7485
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3FpSkphWDdkVEtmNkx4RXRZU25YS0dGVHBMYW94M3QvdTRuVTVYb1I2QkYr?=
 =?utf-8?B?RlAyb094b3RXM1dsM0dJaktnNnRjN24zcVg3N2RmQTgwK1p1bXUvSTZkZDhT?=
 =?utf-8?B?ZTRzenMxM0o0dXJ0dzQ5QTBMLzFmekRTQ2Y1czFuVmlaaEs0THhPODRuNHA5?=
 =?utf-8?B?bzZxbWNISFVLY29icVlkQVlXbnpNcXBwVGpNRGZINWYzR3I4R1greW0wUGhh?=
 =?utf-8?B?L3VHY2ljOXVNMDdneFc3MnNnbkNpQVZNTzZEVnBxSmcyN2hQRVhrWmFibVJ6?=
 =?utf-8?B?VzlXZjdEQU4xai83KzVWMm1oeWl4ZkMvQUVRdURyeFdocm50WGFoNXFhOU9h?=
 =?utf-8?B?QndxbXhuZlFXSnFZMUZGTGs3dUdBblFhTG9wK2RFYisvL2o5d2RETWFnVkpy?=
 =?utf-8?B?QWI1Nm1QYnJWMk1JQVVsdE9vd0h6a21jYTl5bFFRdWp6SmpPaDIvc01OVVYy?=
 =?utf-8?B?TVp0MUhnQ3U2aXlvc251Q0VuUERxYWx4Q1FYZWpTblJ5SThzZnRsMUkwRWlT?=
 =?utf-8?B?Q1VodlZWNHpIeVp2WUtZaW1LcnpCSUdWZkZ0N1dNTzN5Y212VS9VZmtpWkJZ?=
 =?utf-8?B?U0xqS3lnT0FWK0p3U3JGUkdGMW9hdzNKczdacG54M0NwTUU4N0k5QVlxL0U1?=
 =?utf-8?B?K245M2UyWW1zQnVaMGRzKzhLQnRVUHdYOE00K3lYL0ZtaGF5Y24zSXk3bXoy?=
 =?utf-8?B?clFIWHhvcXYrWU5WK01pNEtpQjRsdGpoNXNDZ1djUmRiTkJEQ2FDV0g0bTds?=
 =?utf-8?B?RXNNdE9XUXFQbTE2dm5JSTl6M203MkM5UFFKcmNPN1JEamJFRzNBRHM0bTFo?=
 =?utf-8?B?QjVMUFdDVkVwTzc0N0oyQy9YN1NTejVJS2hIclpWOUV6QUc3cXh1V2JGMUps?=
 =?utf-8?B?U3IrbGt5RXVNTWtKZ24yQ2xPdXA1M2QzN1laOHVpQnVBOUF3a0MrTVltUTJw?=
 =?utf-8?B?cFI3NWc2OC9mLzFYSXptaEZaZE1xdnBoTzNJZFJDVXRSRUlqOTEwcjMwaFdz?=
 =?utf-8?B?THBLOUpCV1Q0dDBtdGNFTXpHNTRvanlGeDlhdjdWZTNPQ25mQzE4eGw3bUlR?=
 =?utf-8?B?UW5lMENPaTRqaUQyL2Vid0htUDlYejZrdEs1alZ4RGhNMllDOHRXU3RqaXVG?=
 =?utf-8?B?cEdtMFJNODhCMS9RTHpWWFVLZTVaRVpvT3lHbEV0QjB0ZlFMYXZFankrV05z?=
 =?utf-8?B?N3BJNlpseUpQc0k1M2haZzNSTkFHSUFwTzZWQWptekF0NFlIMVNoTnpKK2VB?=
 =?utf-8?B?ZkdmVUczdFpMYldseDh6SnlvOG1UOFJWdlJ3TmRWVjRZTC9XVCtXdFFTN1JJ?=
 =?utf-8?B?dmdkdDNvODFWWnhzUzliMTRKZU1kRHZ5K1cvNjhHTUZ1eERwUTEwbm1objQz?=
 =?utf-8?B?VUlmZVp1RWNKMG1SR1gxRkdndmtFcTlFZTE1K0ZuQ0JqR3k5blhjUVVlbUZy?=
 =?utf-8?B?a1ZTWlBuQS9zUFI4eE5XRUVtRWNqRU9YTjYvTFJ6NUpkeWs1TWQwU0R5dDhZ?=
 =?utf-8?B?TzJUZi83QWRBdlFLZ1BPelUxaTNvQkNSdzQ2b0hFTEExSWk0RHZxT21vMk94?=
 =?utf-8?B?by9qZUNUdHl5U01jN0I4N2RQZDRMTk1CUFdYZ3BySnpvNVV6UDZ4QnV6TEdy?=
 =?utf-8?B?QktjcXdKa2ZuUGpCZTFTUlY1ZWk0dFUrYjVNM0s3QUZrYmU1VC9haXVDZjZB?=
 =?utf-8?B?UXFzV0t4VXpvWWlsUU1qQUt1SjNpRnFqUlM4clIvdWZOeFhMQ2FuRG5GQXlF?=
 =?utf-8?B?Ulp3dnc3SXRWTzN4Y3o2eDZSbjBkYzE0NG5SYXFvZk0vbDhUazBCdTRpUWdV?=
 =?utf-8?B?Vytlb0FudDd0UzhnTWR6Q1NoUTg0OG1kbjNhNFV3R0hkaGtiMzQ0YmtZOENB?=
 =?utf-8?B?MlJRYUg2TDBIWW5zSC80eEtVbEI0ZExuWUk0SEgxS1pOc1pyeHpNMC9KQ2lR?=
 =?utf-8?B?cm9Vd3ZHQjNXb29nbUNNREY0KzlXQjJqTXh3Si8vQko4c1pyOS83RkJXZ1dx?=
 =?utf-8?B?clZhMHZMUW96QUJSbTNBbmFoTTFVNmNldExMUG8zYVRrVUNkRFJJK2F6WVlk?=
 =?utf-8?B?NmFsZFVuTzBNc0M1WStDaWQ3Qk5WKytzYTlRYlE4eDZuV1JqRTc2QmM1ajc4?=
 =?utf-8?Q?QbfM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3lwaWlHN0ZFd0thbXlOYmpvZkV0ekcvaE9qYVpERlFRUWhQdXp0UDFDSGp3?=
 =?utf-8?B?MXJSZjJ4bFRrbUFXeWF1R3NEVjgvcGZoK293WDliejhMbFBUM0RWZmpmV3Vv?=
 =?utf-8?B?MHI1NFpXUEN0VUJtVzMwSkk3VFZlWjFsYXNtMUdFVmhHR3MrcTNtTVR3aGo2?=
 =?utf-8?B?ckhpakdYZDkvSW1sc3Q0eG5MV1JkSzhlZzdhbE1HVmJta2Z6RzRGT2xSektr?=
 =?utf-8?B?dmtCOG9IMmU4ZnY4dWU3dVl4aG5Qdm1GRHlUZzZCZndtYVNtTHcxUDQ2V3Nh?=
 =?utf-8?B?S2NkbEtDaldITUlaZ015aXZrVHYxQ3B6WXdQTzVkaVNCb1YreHVndmN3Z0xx?=
 =?utf-8?B?MGxHS1BrT3VJais0Z2ZLaGxpc2xuTjZTVnV6a2pIbDIvdUF5R2NsMVUrdnhk?=
 =?utf-8?B?YVNXRGRTYkxuZ1o2RDM1VWNSNTl3S0t3c0cyNXBoRHBEWXcwajNKSlE2Nm5D?=
 =?utf-8?B?dWJ2STZNc2p5Q2hxSlhkRDVpQVl5dUlpcFNKWEtSVXpjVXMyemJUamJpQlp0?=
 =?utf-8?B?ckg3U0tpM1pSSFNPY1JMYmFQQ2JQRVRwcWYxRTJibDVrL3M1VHVaamVBTTZ3?=
 =?utf-8?B?TjVoNmxuZ3NCQW5OL1ppOWpuTDRidHhEVW5tY1hYR0NEU3BYRHJmY1IxaVAx?=
 =?utf-8?B?U0FMUGtHU2dnc0RpMGluSFZvajRhdFhiODg0eWtwOFNuR3ZjcVpwMXRIeVVE?=
 =?utf-8?B?WjZvdElRZ3dGM0VnQTdTWDJUVnRDM2JUbENQb0E5eUQwZ01ZbmFDTHVXc0hQ?=
 =?utf-8?B?KytZMUZ6NmFjeUZtQmt2S2lONGE0K1U2VW41UDRzZ0ExNmZFV2kzYkd4ejVx?=
 =?utf-8?B?L3AzWitXajNEVjhCRk5tU3NzbGIxdExlbi9qMC9jbGpZNzhzTDdDa3Uvam9H?=
 =?utf-8?B?RnZnSE55dWlFSXFCNVIvUUp1VEtEbGhIeTFjL0JpYWZvS251R0RScHNpSWpr?=
 =?utf-8?B?eWE0NUlOOTg4cVd3M1N1UXZVTytTcEhKczAvdmZpdFc1b0hZSlZhcmU5MGVE?=
 =?utf-8?B?L0g0WC9DN3RlMWQyMU5IWXVkbjB1TXh4Y2hvQTUvT0Zxblp1WmdBb3BTQ2lr?=
 =?utf-8?B?UXJMZk5rNk5XUXJXTUR5dHpHVkI4NU1LUXFzbnF3MEtqTjBPVHVRN0paZ3JC?=
 =?utf-8?B?LytodElWZVlFcWtlZHY0OG5hQmQ0VUx2R1ROclZod3VWandWUnJuUzNpR3ZV?=
 =?utf-8?B?cHowNG43WmxoaFdQWlhXZ3dnMXJPYlk3ZjQyNy96UFZxOGZ4YzdnaU8xdnkz?=
 =?utf-8?B?aXVVeDltWndDMVlVdWVuejJ5WnhwNUZwbkN5dFpiZGVzVmprRlR1WFZjUkVE?=
 =?utf-8?B?eWk2SnJXYWxua3YvR1RhK1VQK1lZZ2V1YUk1Sy9LbmJ6M1U5M3dxVTVEbW1s?=
 =?utf-8?B?RW9UelM0RFZPcWtqNEw5SWh0WkpCOHhKOTh6UHE3d0lpeitVYmtJekFkbVJk?=
 =?utf-8?B?ai9Dczl3N2hQL0M3VXI4ZHlxajB5bFBaNkFiekg4bmVkYysrUUtwSjdINVEx?=
 =?utf-8?B?YVVwR1p5QTg0Mnc0cVNnakk5V2x0eHFrOFF4WXBNamNIK1JHUC9WTnAyNG9j?=
 =?utf-8?B?NmRKU1FKbk5UY2xpeVpqbmNOSTNRa1NyQmgwRmUzcGNjNzh4K0dqTnJYS1Y2?=
 =?utf-8?B?cm85aFlYQ2tZSldUL1lTRlg4dTdyakhPWXIydlk3dDMyMFNGNVk3b1BJYitY?=
 =?utf-8?B?WXdubDBlZlRXaFFNb0J6UFRSR0Z3UFBaQXk3cFNwZWxlWnZpQXZMZXhHMnBS?=
 =?utf-8?B?ejBTZU9VNWppSFhGaFF2dXN1c0IwWVpheHhqSWwwVzVpbUxKTTM4UTNWTmxX?=
 =?utf-8?B?MnRMS0JZdXMxa3VXK1hqMnZpbnRURnV5MTJQaVdncDlKd0x0Y25NNzA1QjFa?=
 =?utf-8?B?Kzc3c0hsSXFwWnJsb2lpbkQxU3F4V25EaG1EMmdUaHFHR2FmU1NkTDBpZVFS?=
 =?utf-8?B?MVNpNXk3VU5qd0l1dmgyUjhyMDRKTUVwc0RyYnl1SEdjTDJzWjBtSmtCYjhz?=
 =?utf-8?B?dXV5b3F6bjQrcUJFbUJZUytBVGx2QVpMZlJmTWIxTnBNbmZ3dXdlT05QWlFa?=
 =?utf-8?B?d3VMQ1c4cFJJcURyZXJhOVN2VUx1UlhQTkViQUZqck8yNVlDbjVsVjRDSnZj?=
 =?utf-8?B?RWVRa29kWXB3ZHJjMi96UTBsSmR5OE8xRFQ5ajdXa01CaS83UHN4ZHpGcDRK?=
 =?utf-8?B?SG9STWozbTVrcXpVMTBDTEYyaDQ4Sk1lL1l0V1RIWkpaelEvekVKRTlVUC9k?=
 =?utf-8?B?VWtoU3oyWSsxVFU1UC96akJsYjRaS0kxbk5wZS83OTl1VkNra2NBUkt3MWph?=
 =?utf-8?B?YWFQaUwvVlQ2aDJ0UHhpQjhUTUFMOWpuMmxCdk9vZDRpMFZCdnJ3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1a4b9b-286d-4116-a6ca-08de708f7485
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 14:50:57.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axuYMzBy2mxLEgzIaitXfHcd3dKpqiHAC1d0Br2cGiyyn/nYNKAOQxoCcM4FbgGUUd+hPmWdGynzOOxU3RBPWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6174

On 20.02.26 10:09, Florian Bezdeka wrote:
> xeno-config got a new cmdline option --disable-y2038 that will disable
> the time64_t or (year 2038) support inside the application that is
> being build against libcobalt.
> 
> libcobalt provides both interfaces, so for native time_t and for
> time64_t at the same time. By default, the time64_t based interfaces
> will be used. If an application does really want to go back to native
> time_t --disable-y2038 has to be specified before the --cflags option.
> 
> The new parameter is only useful for (old) 32 bit applications.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  scripts/xeno-config-cobalt.in | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
> index 46b6c11b92fe20e4474e0173a211b18dc5cd7e3b..ecbfefb8f0a9f7ea99864d07e5f717841ef5da4e 100644
> --- a/scripts/xeno-config-cobalt.in
> +++ b/scripts/xeno-config-cobalt.in
> @@ -62,6 +62,7 @@ Options :
>          --core
>          --info
>          --compat
> +        --disable-y2038
>  EOF
>      exit $1
>  }
> @@ -173,6 +174,9 @@ while test $# -gt 0; do
>  	--posix|--cobalt|--vxworks|--psos|--alchemy|--rtdm|--smokey)
>  	    skin_list="$skin_list `expr "$1" : '--\(.*\)'`"
>  	    ;;
> +	--disable-y2038)
> +	    disable_y2038=y
> +	    ;;
>  	--cflags)
>  	    do_cflags=y
>  	    ;;
> @@ -233,6 +237,7 @@ if test x$do_cflags = xy; then
>  		;;
>  	esac
>      done
> +    test x$disable_y2038 = xy && cflags="$cflags -U_TIME_BITS -U_FILE_OFFSET_BITS"

I did that undef in my mmap patch as well, but I wonder if - at least
here - we couldn't filter out both defines from the given cflags.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
