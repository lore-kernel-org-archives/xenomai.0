Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD51DF754
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133580; cv=fail; b=M0WSuIgbD80NHf8L5NCIS1hZKHsnZV/9ZfbaAIMo/MvJvLn4CF+Mc9B5MAgOGQK89IS8f79qdqp0lc25Zwg4ZZ1iDmRAfUa1kxZk1LxwG5tH2bjnQqXr/HXHWy/GbAqc1KadyK072VF1CmWntvWBfK64sfsdVvVt8Z7kooJZitM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133580; c=relaxed/simple;
	bh=ifPqzDl0fXHw880yv9hRJDHHwgArD6+toNx/PxawkPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uFQ9iP8tNP7ne57SpJg7axMe1j+Noh835i3UNL7ZqI62VhufHNyP+ht2mTfQS4SKE6zsY3WFwiE1Aca65nu3dndNgxChCmzOqrCBWi78YS2xVj8yMcb/9SDVOozhKB/RtvRfq9ggeDZytG4NvE577+gTxs8ma2Ur73frd5/WyLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BN6UlWle; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BN6UlWle"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzOzu+nfIv+qL1aptcnJVYK+5rWcLkDMYlw/7tO1YFfYQ+8xVp1jnluQvYKoVBhPS/SHJWEZy6dN/3eRCNNYBHPlObjpjod6hbHkuo1taAK6v54SaE7EXCGf+rnOwjvEPgE05psLAGQpVrlSKzk7SuPSfpiJDzdoaHs6JG6GGb4Jemzjf2HLujem9K4ynE2jOzg3ZntCXKDt31hMgjiW9CLZO6qP5gwm9nH1Q4q6T1BOGy0+wgiw/rG1wCqzwZvAy0KJwvlPccneqdYh6P9YaICq2ovpu+tjnN9ujkamlFF7Qlx1OzuB91EBFamwirQbQDYNvKTutvsJRjo5lP081w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mPUbMfZSpa/vI5IjX1ETbKZn0IjkKJfG2QqJIdYLa0=;
 b=DITuF9lQHSBgTcGQp1iG+CqWMccsUqC8fCMTIP4yn8/oPNYX6aujrjRvTF72/4+iIVlAa/TuQkUKk06FE9Ep9Ku0Mlo5fQF0FYlpU6zm2Wbm5U7haztx6aDnlqjvReuk4hcz45TgU9i0DXPZ9po2kg+fBdvRZm69bg5qO0VLDyFlVTvh2bLJT4k3AyRgOC/oLLZnTlOQHs7rhXM9RdBAsi4e2owfv1RAlQMbhS8/3XvU1iLPYM3wMO2UJfPWaGooKD/R/o4B0dLZvr1Ah2pCHgsa37R2r6q5F8mvkherwzv1JpO6OjDKXKW73Img/y+dJ6Wnm4wUP8YIpq04dz2TTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mPUbMfZSpa/vI5IjX1ETbKZn0IjkKJfG2QqJIdYLa0=;
 b=BN6UlWleT27gKE2dUggRtNz1om1jyb7zNYvm+bVy7on1BV1E5J/PiQu8VYI9RuQ+HbOTtwo2tQyZYiCigFVANNccBCr6HII5ROD1H9r8oLzB1B2nJ7+UqcGYv+h2S9+StuuMxY51ZsM9w4DRKPyz365XG9kpWCdsG7JsGmUJSn36ibSZaHnlJdFR2Rc0JwTrErrq7EWu0gCbxovqBi86JmNFrIXjvo7pymqeLuDHOXjNX80MziqJVNvkI4h5Jv3nTvg/f6xnz2Iq39M5c7tgy9Om1hSuqJwZ05XiTEs5gYqXRxPveK7+x+3Au9Sa5nnLaHgM4hOju53Jahj1Pnx8Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5323.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 17:32:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 17:32:51 +0000
Message-ID: <879ad6e6-3f38-4f22-aa74-fa3862d85cb5@siemens.com>
Date: Tue, 8 Apr 2025 19:32:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Xenomai: Real-time Exception Handling
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev
Cc: richard@sigma-star.at, Richard Weinberger <richard@nod.at>
References: <20250408122817.626897-1-nikolaus.funk@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250408122817.626897-1-nikolaus.funk@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0039.namprd20.prod.outlook.com
 (2603:10b6:208:235::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c24815-0ded-467c-9abd-08dd76c36316
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anYwUmZuaEoxNjhoMmlVN00xa3hJUTNEWlJsa1RGMndvUkYxWHk0bitoRDRo?=
 =?utf-8?B?RlFDTXRZOXZxdVpuZGtyclRocklGMEZHWHRQa3ZhZDkxWUkyK1MrTERpSTJQ?=
 =?utf-8?B?NWxFSGxUNVllWDdoWGVZeGc5L211bXNFWXFBMnRoYUFBQnorUldHaDhiQ0hI?=
 =?utf-8?B?ZE80ZFdDWmFDdmpRU3R1ZWhjRlRqeUpxb0JJUitqVmZTUnVMNzZ2ckFEdHcv?=
 =?utf-8?B?bzlzRnoyZmZUUTd5cTdJaFlTUEpobVhTWTY5cVlJL1loL3Nla3h5WmhpMmR0?=
 =?utf-8?B?RUVSQTRESkhUVVUydVRCTTVxeFZ4WkFRaTU3VDM0bGtMZkZFQ3YyK3p6c1Y0?=
 =?utf-8?B?N0laQ2o0SWZuTHlyU1VzMU1CNEVhTkZrOXlEY3VPYjBiYmExcmlsa05rVm50?=
 =?utf-8?B?MW9lWXhOL2hxbFRKYmtBQUd6WWtBbzhEL09oaFlVMnVCL003SS91QTg5d3Z1?=
 =?utf-8?B?U2FVbXJZNWJkbk1jUXFtand1Qi8yL3duWWo5S1dlb3lGZ2VHTWFtM3N1QUVQ?=
 =?utf-8?B?MVJucllaWDIrZ24rSVNwS3ZBNFI3MjluSXRyVmxlRUJKYUhvS0FNOFh5alAy?=
 =?utf-8?B?dWozS1NMckZLVXpoNTV5ZHBNRnZEOEVyUXJEMUxJdXFPNWsyN0Z3akk0Mit2?=
 =?utf-8?B?RFE4bGxhamJRVzRxdEdCTDZJWG5rNFozcTB4Tm83ZXh2bFppVUZ2RWdNWkxl?=
 =?utf-8?B?Z3ZHN2c0NUk0WG5PMGI4cjVjRXVRUndFUS9CaEVuWCthSUQ1UnJsR1NSZUY2?=
 =?utf-8?B?aHc3VTg5cVNBYTFZY0tiV2lFN2w0Y1dEZStWNHRpWHBXa1orQmJxbHJFQzdt?=
 =?utf-8?B?azRrZ3Fha3UyeTl5dStHUDVNNzVUdUxYSW5IZ3dVektmanZWS3g2VlAxZ1k3?=
 =?utf-8?B?aC9IaWtBNlZtU3FQQW02aDFxZmloU2JUbmkyZG94Rk12WHdERVpjRmEyY3FB?=
 =?utf-8?B?UFh1ZmVrVmQvbitsY2F4UVFsNUltc2M3ZHFrTnEzWEovdHZVdDR5SVBCWW5i?=
 =?utf-8?B?bWVEWXVyc2hvdGdXN0Rkb1c5UXloRG16VHlIOWZaVkpUVVZXK05DRzNxdkFS?=
 =?utf-8?B?WVRrT2ErQVhlNEtSeE13YVVBZnhuWmdPYmllaTlNWGllTVptc1paYlBDY1Nw?=
 =?utf-8?B?ckVXWjM4bHVGRkZIUC9rM05zdVIySGFSMk84VnNZOTRzWTV3YVU1QUFrZlI4?=
 =?utf-8?B?MCt3ZmJBN095Rkg0Uzh5MnZTd0tSeFRJdkwvczgvT0lhUERUY2k2ejdZMEpj?=
 =?utf-8?B?MmFTaUxMS2YzeTNKTU1wQkFuWDZ2TnVydVRMZ3ZRbXlsU3c4SVp0SHZjN0pz?=
 =?utf-8?B?dzJ1YWl4dXhjYmpXa2RuMFpoUjNDekYySmhHNXhyUUcySjBuODNSWmxPWkJn?=
 =?utf-8?B?MU1haXB2c24xckFnYlgxaDJnVnZFYzc5bmxnN1g0dzJPMEZlUkxhWFR4ZWZ4?=
 =?utf-8?B?citRNGJ4MVNmQnpCMFdjbkVJeVdqSUY3a2FYQks1dXo0NVJYcE9JODY1R3Yz?=
 =?utf-8?B?WkFsd21Ib2RVa0Q4bUhrUCtaNlRoMzByN3lXOGJWRFVNUzFhOFZhTVBoM25B?=
 =?utf-8?B?ZFRnSUJIMGpPYkw2b3dWUEJ4Ym1DSjVnNmZZMFIvK3puLzlZUTNML2JtVEFV?=
 =?utf-8?B?KzFJZjgweUFGMWFyamErQXhRZkhiZ2tYb1g0eTA4WUhzZXJ1WXVjVVBGQ1Fq?=
 =?utf-8?B?eVpHcXhOSEpXVXJNT3QraHE4QVZKV2k5eFNxRXVOZXNSaXp2djlJVFVIMDAw?=
 =?utf-8?B?NWNYdkQ1OHlIclp4bm5vQ1prcVZWM1hlOUxBd3FhQXhpcnRkTmxCWWp6cFFl?=
 =?utf-8?B?QnlzdTJXVURHcVd5djhaZUUyN2JNNDhMRUl4dWVLRmdRZHpCcy8zYUlKb1lr?=
 =?utf-8?B?NXU0Tk9vUkRVZjF4UXJiZzRmQVgzOHh0RUd2N3J2Y1gwK0J4M0VKL1J1eXc2?=
 =?utf-8?Q?7yBT1rACoqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1N3V1ZTaitIVkp3UjN0NHFYeUtsSGVLOVZYcHphTUF5MjNvdlAySmN0bHA1?=
 =?utf-8?B?RURYSnhncElGZU0ySDNtUVJQd215QmRsNkIyb3pKaE5PSXkwWis4T2JvdStP?=
 =?utf-8?B?L0I0YWg4dURGZVJxbURsajdLTFlETjNYUEJCd21lVEFjNitNbXpMOXJRZ1p2?=
 =?utf-8?B?SXFJTDFGS25UZnR2WGlZSThnS0dCK0UzcGxnNXVoaXh6VDFmTDZQeFppQXZa?=
 =?utf-8?B?MVVoOWRyaEYrR2NSMkpnY2h1NGZ6b0FzM0xnelhpdXAvR2M5VS9YbHUreGJQ?=
 =?utf-8?B?bFpKSGoxNzlWMUJaazBqcHhXUndRNnNFdjZ6RFVvNzBIR3FPUFNpL2FqWVZm?=
 =?utf-8?B?bUpPUTRTWUVWcTlGV0FxM1cwT3dvdXRUR2pvUVdpT3FFS3Q1NWNhV2xpL2ZT?=
 =?utf-8?B?RnM1UWRLNVdPTG9HVkx4Nnc4QXY5YzhCNVhaUVdrUFY0bWlGSGlJeW9mRDZY?=
 =?utf-8?B?NTFlbGNiODQzdmdQZnBRTGI4SWF6VmJybWZldDlGN24vbzFla3EvQTEyTTN2?=
 =?utf-8?B?VDRJZGtwcVdHNXJWWnZQVXFUUU9LUVhXSzA1eUJzczZkNU1mYmdtdDZxNE84?=
 =?utf-8?B?U3dlRzM5ZGprVDloYXVuQ2M1Vm1SK2c0NlptNHZENG1sbURrb21Oc3N0WkN5?=
 =?utf-8?B?eHYzTDdBUnFFMlpMYXVwTm5VTG1UenR1SG5YS3g0NFFmTlkzYjZSb3NIWUMv?=
 =?utf-8?B?RmJSM2I3Zlp1SVdXSlhyQWpodk5odzhOWmErckVyMTdSTVl4WWMxRnBUdHE1?=
 =?utf-8?B?eWpaeXBEZGorNEEzMDBkTHhydDJlaFFZQTRSQTRTOVpqVnlUTitRempocnhi?=
 =?utf-8?B?d05VaGlGWndIcWVtM1BhQkkwcjBrR1hsRE9uWTlYT2hYYjZqTWk2c1E1Uk9O?=
 =?utf-8?B?djNRdStzQVFQVGpzZzNjMWVZbnJNVld3dUlaK1RXTVpDMzI3RGdNZDBCYmF6?=
 =?utf-8?B?d05SOEp4WWxBRXBqNGFmZDdFcjRVOHBLbCsxV2E2ajdaQ3lrdk10V3Qza3B0?=
 =?utf-8?B?Ly9QQnNHWVhFU1RwdG14MUJrWXZxMG45REdibUhZWklLZWdtNnZENVJVYXlx?=
 =?utf-8?B?ZmdNaWJyMUtqUmFvbHBRNTBDeTM2UzdTVmdVaWxXUkFHbU1OTS9UV0dPV0NO?=
 =?utf-8?B?M0dFMzY2cjZ1SmxxbkdvOVorQjVDVm9VeFJmdE1VR3I2aVRJU0ZYUHY4Z2U5?=
 =?utf-8?B?bThZM0lXcGI1VXhoQUlkdUEzOGlFNVlrMU00ZVVjd0dPUHpPMW9GcTE2REE2?=
 =?utf-8?B?MmxJbnNleXQwcnV2UVFxNDhrQ0I3MlpaOHFhT0w4cythaUJmQWZsZUlTZVp0?=
 =?utf-8?B?NzZXRXRwR2s3MU1qOURSM3RyQk9udStYOHEwZlV5TUVjaUZvaWxHRGp1WTVX?=
 =?utf-8?B?cThkdmJIU0lBYm4xSUVDdTlGZENYR3JDMEpKVHdQNmRNNGFtZzAyTmlDeWVJ?=
 =?utf-8?B?NlVrK2RzOFlsU1NzMFl3NFRRYUlmcnhKbytZQVZmTWhTU04wdVhCTmFxbVlp?=
 =?utf-8?B?RkRxd2toMTgzeWwrUHZxMzJWMUpHbThDMUNhakJQRUNEZmhoT2xVL2Jwa3Zx?=
 =?utf-8?B?cXpLWS9VUDk2YlhyMjlNQ0d1Njd5UWpsbE9vYWJxZ3dHT05NcXpnZVBNV2N3?=
 =?utf-8?B?YW5tVWdiSWpxSFlQYi9vb3I0WEdnY01RWEhiZ0s5S21qWXZoTUFyOG5sYTUr?=
 =?utf-8?B?eFNCa3RXbFJvaURlM2hUSURrMnVqMThWcFhSbktJZ2ZoU29oRlJmK2UzYTgw?=
 =?utf-8?B?Z05nbWphNWJYbTJRWXVpR0dxVWNDTnVER0JxTStNQTVqSmdNK0lSbktLb0lQ?=
 =?utf-8?B?RlhMVDVsMXkyZ1hDbG40RUdXT0ViaUJMRkJaOXNXbm5pM1kyWmNDVmRVQmpD?=
 =?utf-8?B?b055dG5TOEljV2I1ZnF2bkV2L0F3MnBxZ1pJTUxVSGxrZVJpTytqMlJOMFgr?=
 =?utf-8?B?dEF2dFhQUHMrek5ZT2FaUHBRWGVsWkppNE9aZ1BTQUtEa3pQbTZRd1RSUTV5?=
 =?utf-8?B?djVRdU1tN1BYSTBtaVdKeVBRWjNmUjdpYkh3Z1YvUHVKOEp5aU00UDl5U085?=
 =?utf-8?B?SEZwNUZmUzdOcTh0bVlSUzh3eVdYRzVaYlNRby9jWXQ3c3V6NmRCQ2FhMWU4?=
 =?utf-8?B?YnFlajJEa21xNnhxM0Y5T2tIUDhMMVRFSG9aK0gxQmJBKzErMDNnZ2hIK05P?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c24815-0ded-467c-9abd-08dd76c36316
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 17:32:51.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/abzQ/T7MM0WZ2ycbaObPdiFmy8VKNTBhtxKF9A3wVRjkP+HBinICqq8mxDnOk/06KFkkXMNRl631IOhMgZtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5323

On 08.04.25 14:28, Nikolaus Funk wrote:
> From: Richard Weinberger <richard@nod.at>
> 
> Currently, any exception that occurs in primary mode triggers a switch
> to secondary mode, and Linux posts a signal.
> This change allows certain exceptions to be handled directly in the
> affected thread while remaining in primary mode.
> 
> At present, only SIGILL (for x86, arm32 and arm64) and SIGFPE (for x86)
> are supported.
> Adding support for additional exceptions is possible but requires
> careful consideration, as not all exception types can be analyzed in

IIRC, we should be able to rather easily provide
ARM64_TRAP_ALIGN/ARM_TRAP_ALIGNMENT/SIGBUS as well.

> real-time.  A notable example is a page fault, determining whether
> SIGSEGV is appropriate requires deep traversal into the memory
> management code.

...on arm and arm64. It worked fairly well for x86. This is indeed a
very prominent exception that people may expect behind this feature. And
it is also a use case we have with our (x86-only) deployment.

> 
> Patches 1, 2, 3, and 4 implement the Xenomai-side changes for this
> feature.  Dovetail will receive a separate patch set. Patches 5 and 6
> introduce tests.
> 
> It is important to note that this is not a fully-fledged signal
> implementation.  The only supported use case is delivering exceptions
> as signals to the affected thread.
> There is no support for sending signals or handling block/ignore masks.
> The only user visible API so far is cobalt_rt_signal().
> It takes a signal number (SIGILL or SIGFPE so far) and a handler
> function with the signature fn(int, siginfo_t *, void *).

Did you intentionally left out the oldact parameter of sigaction?

> 
> TODO:
> - Better naming, IMHO "signal" is the wrong term and will confuse users.
>   Especially since POSIX real-time signals are something different.
>   Maybe "umex" for "user mode exception handling"?

Just "exception" might be enough and clearer. OTOH, we are reusing a lot
of sigaction and siginfo...

> - Document new APIs
> - Improve tests
> - Carefully select more exceptions

Yeah, that is the challenge.

And:

 - align with EVL / Xenomai 4 to ensure compatible features

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
