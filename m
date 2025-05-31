Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012018.outbound.protection.outlook.com [52.101.71.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD682907
	for <xenomai@lists.linux.dev>; Sat, 31 May 2025 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748669706; cv=fail; b=r1Cx1REHO2WS6p3yq0aPnjRESjF1XKUexMom0PwumHTeOSqBTnPI+nRV272hUgM4O3mmeLho57GsVbr59olQRKtopiUnu/B1SAlC2tVZJKiGjBYhBlpWTUqI5QOq4EmBOCaHi99YxHpTdABmX8OaektRevqihfxfV+2sTkJN9TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748669706; c=relaxed/simple;
	bh=uflUGh35uPnfeqFvR2CsQZAomEcThKVb/F9K/ypYZys=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5S+avm/p1VilvaX/bx/dtz2xBATL1I0QRA1htHFqlvu3mY0NMDw6noKFta7sOU0Sn21JAt8aMPBu+B0hdW7HMtuzDBRjl8gwiNUqyoRbrAPRJXCLHHHEJ4J42SVpIKAuARCDd3KdGwHbzJtPb0IgztKyv6fu3EEERedkaJv3po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NCS5+bHk; arc=fail smtp.client-ip=52.101.71.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NCS5+bHk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHsv8R/dMTxv6Mw4GkiJLo/i1su25pf0SLNamgoyZU9Q8WyxjJo1oWYpVe+vV7SVJK90aLg4wFtG+qfgqjn1zPpgN9EiQgWa56naq690/76MBA4BLAwjxIJeSGi/nc28UIHWSq5xE0S1iDXSx2u4bTLidt8Q+5/MmR1VccMag40WV2C2uWGQD05KVMub2D5ITyGtVOEe1JDsI5pDqbQ4Dlm2ILW8R4F7pjYJOL/u/vP+JH0fTpK2zWNUjcD8SGF+n01EA/uLLxcfMXY+MqLuReWWo35n5ue7Ty0Gt7bciZZ1Uh5IiMgF4aucPuxXPZgCq2aAPwImpkMuD3sAf/X3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DxeDZ/Fl8u5L/cvLIof+5EyzwaPL17FJZPEWla9uOg=;
 b=uXWxB57NZF00TtzuHa9lWKtvGbszDGs5lQZq5pPgnIMsCZ80aLPr1gNAIAJEiN63G6JwQSbLAVO2r5jmGoxScFmvLX7MzUDwlNJay1+wyH49JblOP9T83UnLLTwyxJRVORD9wyG6by5lPx5yJjPKxuqjMg/A079Zv20ggJJr+z89W/nQno9g6TueH2Rw+TFQssQ0SWoKZh1AxL0whyol3RxIpgE+nyCwxzmWTol4Bljn0Mp2Rcjahm+WnFw504xphgp2sDdgR//b6r4bn/QkjotfAn8zGs+xJRq3owlSKCeyELF4wKDJRUkclnWSEup8g72XQLdbD24Rh9ZPVqvH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DxeDZ/Fl8u5L/cvLIof+5EyzwaPL17FJZPEWla9uOg=;
 b=NCS5+bHkyqOJ++42tTA3L7YH+2dPyPffANfHwpaLA6C9CCHgvlAb8ExqmnBx+aBgFTw0U0sBN79zpVZfvFUykoYUDhj0qXK+VNIry8W6NoAwATBD/n2ugVj+54IcwGVO9eN160rtLnTSRyKeB3LIwNcmt8arZu4KS6fG+57dadMttGAIbdKgFR/CbCngsIsAqspqvbDamxSX3CUMQdfCaZeGeM0g8RfRVGE9FBLFMSJcH4iwwO6tjX+p6bPVhYKfjjvhR6/sk/+pulr0n0J5qSH1PgZxQuzbUxMydi75tMMUJsXVvsmSVp8/ho5cPg0s6s2zA1km/yjPqsgsnhrI5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Sat, 31 May
 2025 05:35:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.025; Sat, 31 May 2025
 05:35:01 +0000
Message-ID: <ecaaf336-daff-4ab3-96b6-a5c7f6633c4a@siemens.com>
Date: Sat, 31 May 2025 07:35:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Port of a RTAI based code
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>, xenomai@lists.linux.dev
References: <1d29632f21dc51b0f1d5434b8ccd16239bb73c37.camel@lapp.in2p3.fr>
 <5b7a4ded-2147-47c5-887b-c400694c9eec@siemens.com>
 <d7232ade8a28894a536d697a40942416ff817550.camel@lapp.in2p3.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d7232ade8a28894a536d697a40942416ff817550.camel@lapp.in2p3.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce827e2-234a-4795-9d92-08dda004e367
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmkxRTB0SVJzZkQ2S3d0WVA2SFB2WU9KT2xwTlc5T25zL3hCUVR3SS9jWDBE?=
 =?utf-8?B?NVpUa1BocnI3WFZCUHo4bmxpbTk3Y0d5Z1Y0ZUtqSlRDQmtJaEQ1VjJkUmhi?=
 =?utf-8?B?ZTFJWUtoUkgzZHVpRFhSUm5UemlhYVh1SzlwbUJIMWVXV2RVQjB5Z0YybUlE?=
 =?utf-8?B?ekVVR1dpalFHcG1iNHlCMkRESlNIZXpXN3N1ZlRpVm1pdEFiTHRlbUpHUjVm?=
 =?utf-8?B?SHkveWtPdkltRDliMjF5NmQybmdhanlFSVdlTzFyT0hmREp3ZVlpQnJwWm1T?=
 =?utf-8?B?cEJCa0ltb3ZuMldPR0RvVEIveERoQmhBVVhPUXI2VjY3NVN2Mko4Wmg2M2ln?=
 =?utf-8?B?TFM4bUFZN2JINTZjK2FPQjl3Tk5nVGNhUFNOc0tKYlJ2eW0yQ1QwNnRjbyt2?=
 =?utf-8?B?dkFiTHlmNlBZYkFqcGtOMldBWnd4N29aUHlxeUd5TUVHYUdoSmJuSEVjZ1FD?=
 =?utf-8?B?TVVha0tSWGZnNURBaHhtd05JTGk4QVo0UmNDNWt2SDl2K3RuMS9WTDhXbGMz?=
 =?utf-8?B?UXNoV012YjkwalFGamZqdURlL1JKVFBEVmJ5b3BpSGtpMjJqOFp4NktRN1F4?=
 =?utf-8?B?MzF1SUpWK3U0N2xJeGdNNXlWRFBmd3E1cnpSbGVCSFREdWpKY1FsSHFwMkFt?=
 =?utf-8?B?a2g4UStpQWZZdTdBNXhhelo3bzZlelh1TlJmOWZTajRQL3cvMmZwUVRBc012?=
 =?utf-8?B?ZFI4RG8rblJuWEVxRVh6SW1Ub0I5UThwSzFsQkFjSTdRMWVtdURpN2dlQUcw?=
 =?utf-8?B?V1RlZk83dHBPME5DcllJN3R0OFNKZjdWRHJ1cDdtazhjNFJNZ1pHYzNzaDZV?=
 =?utf-8?B?ckJkWThzZ3JqYmxkT0dqaDdnWWJCdGFhSGxncFdhZFRZQlpNRnhONy9rVHI3?=
 =?utf-8?B?ODU2L3RFM0lMaldYSmVzTkt5M0lQNXVDTHFGQjBwTmphMWYydWp3Q05nTkZi?=
 =?utf-8?B?NWJiODk2TWVBS0FIRzB0MnQxaEF2UUpHQWszY0NZeHlLYkloR3dTazdteVFX?=
 =?utf-8?B?RDRHYnZIVURONUp2bXUyUnlDZXVTc2FQYU52TTFqSnZKZlZKYVQ5MC9zdzFa?=
 =?utf-8?B?U3BUT05WQUZvL21QZVBlWXV0N2RCbUJWS1hCUWxkcldNZFRNcDVsRmEzOVVN?=
 =?utf-8?B?aWN0WnR5YkM5S2xpMFRWUGl2RWZJSk00SlBwakVFU3EvN3Y4UDNGOURSbXdI?=
 =?utf-8?B?cnM2bkdlRGtNaXpuRS9qdXQvOUIrUTJpYStORGZvMTNXWStSSFBVR1Q4dmxF?=
 =?utf-8?B?dDk3SU1XTm9oQ3B3OWt5dGo4QVdGOVFNb3oreXRQL2E3dTd6QjduclBUMTFv?=
 =?utf-8?B?UDhya1VhbHdibENON2JRbTAwTHpyb3lqMFJsZDlWMXN6NG53VmlTMEdsNmV3?=
 =?utf-8?B?a2JmQlpUSWJ4M1N4Uno2Rm8zc05tQWpCRmk1SVBaT0NPc1FadjJaeWFqVzNZ?=
 =?utf-8?B?SGl3ZXg0dGF3TzJpMmx6VHhGK2Jhcm4zK2ZLZ2tkeEVMUDJTc3E5VGlIaGFF?=
 =?utf-8?B?U0pWR1p0VVFDVkxEYzA5RXd3OENQeGY4QjZ4b1JiL241UmRhaU9NR1R2WTdt?=
 =?utf-8?B?cFFjNWlSUnJlUXg0UlZ1bjcwS0trQnJNbENLWEc4RjNRVkpuWGdIcXp5VGJI?=
 =?utf-8?B?WnAzOFlraEZGejMxR3c3QXdKZDRFSmt6YWw0ZDNEczNYRkU5c2lRb0NWR2Z4?=
 =?utf-8?B?eTFncUpBOWlMRGFnTHJ1YU83VVpnbTg4d3hwbnVZWENkMCtUeXBieWNBZlBY?=
 =?utf-8?B?bVd0VE03V21zUkY1K3V3WWNzdlM3L1llUndlOFhHNGxpTS9CaFY3VThnSHl5?=
 =?utf-8?Q?HqIfl7yOZJXAFXWFf99ZO52Mo/JDVmRlUKo1A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVFJZHp1eGtSRzhRZ2dtNDl6cy9URlBXZlZPZ2RpTVZ2VC9rOWhWME11WFds?=
 =?utf-8?B?Z2hoWXkzLzJEN3ZFN3o5VmNkeTlHUm94cUZlbE9UUWJ3cTF3OEhWbVlKTnNY?=
 =?utf-8?B?VjRrS3E0YTlIdjlwQ29LTW5SYnlxbkpiTkJXR2QzckdsUDYyNjRkOWpIYitw?=
 =?utf-8?B?ZFVHMXhMZVJUVnJxOXhnR1g3dGc4a0ptamlvSm1ZRkljUlI4eFlNdDNZNjlr?=
 =?utf-8?B?bGwwV0tISWlKcGJjRytpMUlKQUpmQWhsTzdETThkUUJ1bzZHMlNwWEhreUNz?=
 =?utf-8?B?NTgwZ1ZrbnQ4NlVmTW9BdWFDczRiZFhLYVg5YnJXWXNDM0ZWaFBnWGxIdDZU?=
 =?utf-8?B?ektxMWlwZFQ0T2JVTTFlYnhLM0dtZEkwRHJ2ZkplbXpzK25TYlBwNFlRV0x6?=
 =?utf-8?B?a1pGd1ZzTHNyR3JQdHNabC9BdDFXc1B3KzNiUnAvR1NTRTcyY1loZmUwTkFX?=
 =?utf-8?B?VWlzQzRhMm5DMGM5clZpVjBzU1cwUiswbjMvZDJ6dWpJVUFrdllua1BlVWZX?=
 =?utf-8?B?UGRWQWdVWVV4WE0xRXdSamRpeHBQS3FsMmU0eTJtM04rY1g0c2IrbXpJUUtF?=
 =?utf-8?B?L05LSU1tb2E0QnN4aDFzME5zY25nL2E4Q0habnVCQlkzdUh4UFVPZjU0Nllq?=
 =?utf-8?B?aXhJZGxlaE5sZUROUzd2MlFieFJzVE5TV0tMZHlhMnlXZWRtczFJSmVSakU1?=
 =?utf-8?B?Z3p1T1NkYUNCSVRxNG1SajV3Qm5nZmk5R2NsY3kzd2kySDNmR0s4KzM5cnA0?=
 =?utf-8?B?ejdINmlyVzc0cklyZHR2M2htVDc1TGtYdXdpZTlETmpRYWpXR0tDbEFSY0Vz?=
 =?utf-8?B?aEtFdE1ZUThTbllUa1BneU9JTk5oS2dadkZxWkQ1N3V4ZzNlUit2QS8wNnZG?=
 =?utf-8?B?Qm82Smwzb1FKUERMSW5YRVFkZ2h6bHJZQWpsOFlyYmZWMkE2UENwRFdsVjRH?=
 =?utf-8?B?NjBpUVNXU1VXSDh5UFNoU1haNk0vOUF1OTNoS1R0MU5tOS9KUno2RjYvTnNp?=
 =?utf-8?B?WWhHbnRzNEVPV1Q5TmdFVHdXUWdJekhrblJhL0JjSng4SkhuZWlGRVRMN09t?=
 =?utf-8?B?em1PVFNXaDhFVjVtaXMwVW9JWjdIWk9tVVcvSEJzS1R4NmlLcnZDTVNiWFRv?=
 =?utf-8?B?U1JqYXVTaklwSzgwdk04NUxaVytkSkNqSkk5cEsya29CanNwb0FFZmxjMGNa?=
 =?utf-8?B?Ukt5Y0tieDJPQU9yZ3MyZC9IbENWVGpxYmNyQzdJWEF2cXMwQTQxci9DOGlB?=
 =?utf-8?B?UVVqR01XM1dvcHk5UU83bGNreTRKdmZaajYvOWhDNm1taS9sdHExYkw0YkhH?=
 =?utf-8?B?VHNiUm5iV0Q1RVVYcEpSN05kWG1DdzVUZCszT0tRdDFCL3phSExFL1g4eW1o?=
 =?utf-8?B?cU5RNVEzZ3RxekJpWkhDMVRUN00vTXY1RkNIbnpKWVhmSnN6dS9uZ3NkYTVS?=
 =?utf-8?B?VUc1WjJYSHltZW9iOVlEU1I2R1JFbmdPR3NpTk1YVDV5WFFmYW9vYTlSaERG?=
 =?utf-8?B?Rk9rS2lrSjBSdy9MTDRLcTdJUjZmOHJqd1ZjRzJWUFFLcjdTdmY1R0VMNzRi?=
 =?utf-8?B?VHQ5S0p5NE5zQlpBV1RjY01ZVk9tTEMrSWNFU3ZQRGJtaW52VTMyYi8wVVRr?=
 =?utf-8?B?cGlDTGloT3VjdGZBK015aGNEMDRXbVBIMDQyem1PSjl3NVJtRFRJVUw5dWg5?=
 =?utf-8?B?M2w5Y0VJMjdqZHl4aTd5c1RwQW9qQjVITVN3VXlPeGRUSnZNVnFUTmdXUktj?=
 =?utf-8?B?RXM1L2hVZlRwbTl2RmQ1VUg0LzNCVXdCS0txbnJ4QXdyR1FRK1pTN0poSWtR?=
 =?utf-8?B?S3NRVllqQlE1M1hpaFNpVmZyV0JIQUxLd1hmMjhmY2hNQ2tMd0w4VHJxZVhO?=
 =?utf-8?B?VTRKWmtHUy9BTENhRVFaSGhTeG40WG1PWVY4VUE3V1dsNHREd0pTZ2NTazZF?=
 =?utf-8?B?SXFieFpxRVJkTm1WS3VlbWh2UnVrR1E5dkl4cUpHajJkT1JTNFRHc2RiM2RQ?=
 =?utf-8?B?S05kYkd5V01kMklEZmUxMEhaMUZWN0F2c29BTFJUSWM5bVpUN1NWUmg1bUZD?=
 =?utf-8?B?MUljRzdpa3Fha244M3d4b0ZJSGMzWFhrVGNYSWF4R2NQUkxhblVSTDA3UFRu?=
 =?utf-8?Q?/LVIB4mJuyu0wYWCJ+6MFgZZ0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce827e2-234a-4795-9d92-08dda004e367
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2025 05:35:01.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCzGA/rWa140/llBsWY1lDp4PInspVLrdTlPN0s6924I2CmG1yW66pcBBCgE2ZWADV4RUVhPbTmVWNRyrvV2+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8183

On 30.05.25 22:51, Emmanuel Pacaud wrote:
> Hi Jan,
> 
> Le vendredi 30 mai 2025 à 09:55 +0200, Jan Kiszka a écrit :
>>
>>> Would it be possible to obtain a similar behaviour using evl ? I understood
> the user space processes will not be scheduled during the interrupt handler
> execution. So I suppose I have split the interrupt handler and implement the
> process waking part in a kernel thread. But what would be the right approach to
> wake the user space processes from the kernel space ?

There is no need if you follow the proposed pattern. This is actually
standard driver design under Linux, just lifted "out-of-band".

>>>
>>
>>
>> You will need to write an EVL kernel driver  
>>
> ([https://v4.xenomai.org/core/kernel-api/](https://v4.xenomai.org/core/kernel-api/)
> ) that implement some OOB read  
>> or ioctl which your EVL application can call. That driver will then  
>> block the application in the kernel using an in-kernel OOB mechanism -  
>> e.g.
> [https://v4.xenomai.org/core/kernel-api/semaphore/](https://v4.xenomai.org/core/kernel-api/semaphore/)
> . The driver also  
>> implements an OOB interrupt handler that will signal that evl semaphore  
>> (e.g.) and, thus, unblock the userspace thread.
> 
> Thanks for your message.
> 
> I don't understand the relationship between the user space semaphores and the
> kernel space ones. How can I map a evl_ksem to a evl_sem ? Is there an example
> code available ?

There is no userspace semaphore in this case. Userspace only calls the
driver service, and that carries (in-kernel) a semaphore or something
similar.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
