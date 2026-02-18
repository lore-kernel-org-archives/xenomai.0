Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C730CDA4
	for <xenomai@lists.linux.dev>; Wed, 18 Feb 2026 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399843; cv=fail; b=eChLBSBTGNgXHBOcRwVBBpV5JQmW9Y7ZGThVGaTuza9rWQ43PchY3+N8VRebMufZZzSkvCc2zRrhYoTKb+wpITAqadoSBaLfP6wEH2pX/pQZkN+wAHLxA4ziVqK+LpHKgHcDhfvF9x19zhN5foADYryImTNF211AzvIUvzfR4q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399843; c=relaxed/simple;
	bh=EecVwW2dqoWnV3hlva0WYsvFUUpuF+O0f9NB0MOqWWM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f92zQXOZDuwBLgkwIgxKiivYLAT+/s/QX/rfXTn95cra5CYqS2NZNUT5p91WgC14N25cXMl2Ew2vr0Uwzf1byotHQ7GJqCG6+By5QMnnE867IqfpbXvc/byZswfo7LcGE57lDk/fnNUYvoC4BFTgcaCs+eqmbv+eya/1BWnlA80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Ln8II/v7; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ln8II/v7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECPgGyLRj82EeP9P+ec67pBXApUCdgS1NplaHIDw8D7ge+qTTFQ+JfGzfWYLQMcJ1yl1IfpbBH2HNYrgeWjKoOmzIsqj1+d9jlowOs3SIhsR/9Oj786Jn+Ejup/QFswnUXHM/Y/JO+2CcDh4qZSWmJixhm199TlPqgdqGKyeX5B93sddUuuZdNbtIibWE/gAVWNruM1Og81YqyE/ndbx9sUPEij8WXSPYEgKquhT9H08R3v4ozT2hyNOhY+Kj4iYhxdcDKjJBS9CrLyIPwuqCMC8KjIGpWq71rjHEfxiLpXjYFM5Fd3VQckcmysYNzaoAgGn4xn0XLTBeV4oszfkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QHf466Nh0kRTfhITpfrLBY+XVsxDu9YhL5LnDeFBsg=;
 b=uU/dyhVBJh8hshFl9233mQkreNXt2ep0hyeHPayIES6m0NEioq46PXUBvRg9Jh1bD0HONVWI0Mrx8N4dc7LcegdqtP7o/KX1/cWZrJlMQEJGaLVO+OD0WZL+H+eoaYyiveHwgoe4zOi6tFWVnRVoOAma2P/djshLqJtE8JhFCEa4tUAo4rOEZlFp6jv6379taxcZpHNFWxfD/jD/L+H9AANdDit/E7qDkBL3RDxsuU1gGOAczU85ltLlEP35idmitSaGUtWf7Byk32dPWR9S5Iq5vVSJVElAkvre2jqDngrXRZ39JOb7S81cyp8RHfLSiaZ2OBB0JZnEdVtWfNEupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QHf466Nh0kRTfhITpfrLBY+XVsxDu9YhL5LnDeFBsg=;
 b=Ln8II/v7hgWNjiO1Hmu/1tF21YExr+MDpSwhdYFet3EWsAZ4smBwDoz46nk+CyzM5u92lWgvAmIvmny/h2ITbDcY3ihoF+wxLp9uMusVHBUiCLTMhtxU08+sWJ8aIabOF8nbdIP9zE5dIXQ0jpoa9Zw0OT3rIvd1zA/KzNquoj3+s4XqJdOTl2Z9SeMgqcQtE91iTEGbmVwE2OjmWQzGrEaNFTIkydR6LsOLOoPA/43OoNnban2cURBjde/jK+EWZiIgp9FkAL8YTGNG51kL/0CMNnRnl4P/jhBOjdnWnppnUhDZVUUn0ZUw0O2JV+cP4toQiw/sMX+5HaSD4WBaBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB8023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:405::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 07:30:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 07:30:36 +0000
Message-ID: <1d10a103-975b-44c8-89cd-7ac0d059f4cd@siemens.com>
Date: Wed, 18 Feb 2026 08:30:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Dovetail v2 1/2] dovetail: genirq: Add
 request_percpu_irq_affinity_flags()
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20260217-wip-flo-v6-19-dovetail-rebase-v2-0-45fc326a166a@siemens.com>
 <20260217-wip-flo-v6-19-dovetail-rebase-v2-1-45fc326a166a@siemens.com>
 <982c1b8b306d2abd81c88bc4669035957b664f2e.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <982c1b8b306d2abd81c88bc4669035957b664f2e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b2c422-6dbc-4f3a-858e-08de6ebf9bc2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFhHaWlFNDVGcjZJS1FLZXFpZ2R0RVBwajFUM0FMYzZCUW5Ec3dpY1VSdCts?=
 =?utf-8?B?OEFTUHBHam1ZOHdYTVNhams1STllUEVHV05HS0hqWHFRS0lIT0ttYjZ5ZXlU?=
 =?utf-8?B?Q2huOEh2bi9DVlNZUVJqcnlQZVlLWGFqdTFyRVhxWE85RzlZOXk4NjlKV01I?=
 =?utf-8?B?OTczSDVJY3haWlZkZ2t1M29jNVhCNUZxSlNnZkZidGdEbWVqTCtDRkplWTBF?=
 =?utf-8?B?dXNmamJTZDBSQ3JySEpQcm5lMVI4STEzSVoxT1l2djVIOHVRS3RzVGdhb1di?=
 =?utf-8?B?MTFuNDNER1pMM3Y0Y3RDWHJIL2U3aXlOOHZ6WW5wME5MQ0NlQkJDMnBmZjJi?=
 =?utf-8?B?M2FVcUJnajZZN2ZUYUFkK1pxMElCQnN5b2c1UEF6ZUdpUG1lU2ZmcytJelh5?=
 =?utf-8?B?ejBQcnBBMGlDSG1nd3BoNEJpSk8zaFBUWVBlNUkzZHQ2RVVjV0lIdUFyeW5k?=
 =?utf-8?B?VDd3am9kZy8wSXROLzNCSzdOdVB1cTRLZE8xNTNxVHVBWjV0RzQ3NElxRFNu?=
 =?utf-8?B?Zmc5ak9tOVBpdk44Tklkd0Fxa1JYL3FaQWwzMmVCQnRONlNqbVV2dE9vOCtQ?=
 =?utf-8?B?NmVLNWJlNXZrY1hpQ1A0TmE5K1c5M1BEQmdkcElZd1pkaHJkRm1ubmpodzdt?=
 =?utf-8?B?a09INk1pWUo1cUFxL0FLUnBxNFB0bTRkTUMvYVFhSitpaUFVRlliREM3d2dn?=
 =?utf-8?B?aVlGMjNVTUpTQUNiY0NFbGtVV0FvUXV6eDdvOGN2YS8zN1VVYXFJVFh1UGFq?=
 =?utf-8?B?RTQ0UVBaMklSZDNYYU1qVXdkdEhkTVU3QzMraEtHYUV1RmtNbStMM1NOMGpN?=
 =?utf-8?B?NjJUYmZMcnJKaWo1Qm8vbCtQcDdBbGlnSzc0MEpZVWFCVUxObWFrWDBlQTBY?=
 =?utf-8?B?RmJub1RGVmNOQ3J4Nzd0ZFdBdWlacGhDdVZpZ2pYUTErSDNicVFES2crRDdw?=
 =?utf-8?B?YitwUlVROG54L215cFRsMXYxcTM4Q1JyanhCMzNCTWp4WmNDcnRCa2pVUXBC?=
 =?utf-8?B?akRRcktoWGVsQzhKMnpudzR2UHF4ejkzNXlvQjlubWV4aW9iVTFYU091cSsw?=
 =?utf-8?B?aDRreVhoTTBMZmpXYzhoeVBFb2RFeGJJeXBBU0VVMG9wYS9oeFcyRkxwdS8w?=
 =?utf-8?B?cDFuRDJrQVJJVGE3RFdvVDVtVlJIdGFlYVV2S0Qvb1Voek90RDlFN2ZBT2hI?=
 =?utf-8?B?ejIzaGNDajIvQklTdXc3eWxzZ2ZJUm5ubU1pZmptUXNaSmlqMzZNaHlVOFFJ?=
 =?utf-8?B?NFVXdlNwa1g3U3VJTE4xTVFIbU1kaDJ3WVlzMlZnM1hMWFljdXBLckxmWkl0?=
 =?utf-8?B?a1pNYXhNcVVqRFplOXNiTC9Ka0lybGhYMGtzWmFqdVBPT0ZIVUF1RVUxTkZY?=
 =?utf-8?B?RjV6NkRJQ2ROV292bDdxNm8vMk81enFGTEJ4dWRGYUlxeDgrcXpETi9NaXdt?=
 =?utf-8?B?Sk9ScFRVS21CdmRyVzQ1NXJlcGRwRFJ5bXVSRTl5RE9ScXZsNkNKcmJ4TG5Y?=
 =?utf-8?B?aEVIOVRFL0NUcVNPV2tnZGlMYzJIR1VZd29WTUFhWmZaTTlRdXdzUmpXTVEw?=
 =?utf-8?B?VmVNcktGNUdoSWo2dmE0QUtKVmJWbk9KakZGdU9nUitkSTNwOUtUSWsrMWsy?=
 =?utf-8?B?alIrT2NRZTZINzVXZUNuSTYrMzQ0Sk15YzVNNUZiSDR1OXB2cXM4UzlWUmdm?=
 =?utf-8?B?Qktxdmhhck0wbll2WXlHMURaN1ZQZUx4TWRtaDhiWHRuZVpHUkNVM1ZmN29W?=
 =?utf-8?B?TmcvWXBic05sTU9xbzFpY0lXVDRKTUx5SXhSOTRreWhTY2Y3K05yNGVFKzk2?=
 =?utf-8?B?bEpLMVhGSG5tcVpoNmVlRFp0OWdhTXVQMk5EV09ON21ocFZjNDR5UUVKbFhk?=
 =?utf-8?B?OXRqK0NqcENrK3ltQS8xL1E1TXRPUFQ4SXl2NDFjNXU4dC8vQVhJYzQzRGV3?=
 =?utf-8?B?V0VRQmlsNEZCZVFwN3FIM2V0TjJwTHV6U1JmSS94QXl6T1FpSDRPR3MwR2c1?=
 =?utf-8?B?NTlUZlZ1d3lBRGNxVUJYVXBYZFd4cjg5SlhjeVA1ckZNOUYzZEQrNkFzQjJH?=
 =?utf-8?B?a01iTURKK3BMcTdoZXVMVG1QWldRbHlvOW1sTmlZdzg2ejRXOTExSExjOGFr?=
 =?utf-8?Q?tk8s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkV4eTJrQU1Pd2NVWjM0L1FUS0Z2Y2RaYjBoUm0yTHBLMHJWQ25vUkR0MUxE?=
 =?utf-8?B?enVpMmc3a2lOcEZKR1VsaFBhc1BjcnNvRXRrdjJ5WmJJWGU1TE5YZ0Zvc0Ru?=
 =?utf-8?B?TVo1aXpaSGk4Ty8zZThRVUdEcHZpQStCWEhOMVY1QzRvMlhuUDllK0duTk9T?=
 =?utf-8?B?MktZelJxYlFvOWpZQUpjS1pSMUYzNG5WMXU4SDNKR1Z2cmlKRGx3T0o3ZXh6?=
 =?utf-8?B?UDAzejF2YTRBSFRJZ1QxaUhJOFhDZ1kyY3RHSGRYUXJaM3FyRWd5K3c3eS9C?=
 =?utf-8?B?VDFBd3JLbjdOa3FtaWxwN0IycjlHMVR0aFFkWkx6bUVwK0EwQ2NsTGc2aWxP?=
 =?utf-8?B?M1A5bTN0Qmkxcis5WHBxUExtT2tFak1BNzZLYU00c3FpTEhuajIveEorVEZw?=
 =?utf-8?B?azdkcm4wd3BaTUxYWDdsVW9MRkorZS9seG4rc3hZNEhxNWQ3MGhnNUNpNGo2?=
 =?utf-8?B?aXNWL1hjNzlGdFJuVkczRGEzQUQvWHdTTFk1cHhXOE5BajhIa252Uno0cUhG?=
 =?utf-8?B?TUNZOEZOS0NVUFQva1NkbjVhdWFUNm5pdkhFR2syRGRmN0lHUG44cUl1UkZ2?=
 =?utf-8?B?SHZ1QnQvUjlTcGhjZW5vQTZnN0FXMW9tbEd0OUtsVCtsWjl6V2RVUWd3dGov?=
 =?utf-8?B?L0FFTXdPZ1ZpeWJXZ0tCV00zME1vVU9kdkh6aEpqZU1xMVBXclVDbis4Q0Nl?=
 =?utf-8?B?QVNuVytLKysxMTBSaEhEaHowa3hldG1TbTJkVVdZRGNRWS90OEROMC90aEdC?=
 =?utf-8?B?TVdiZGo1VDVLd3VrYjdhcnZORkltMGpqUzExU1E1eU52Ukt0c3hubktWV1g3?=
 =?utf-8?B?VC9KbkJ5WnViMXJjSm9WT3BQaWphNnZQMUpoSXN1TUZrdXRmbFM4WUlVSHhR?=
 =?utf-8?B?QzhFQUZjQzZEWGMweVNTS05kSjBEWW9xMG0yS0duckE1ZVF4OFRKWE9FMVJo?=
 =?utf-8?B?Y0pQRjN0anpraDJXQ1lnKzFvZkZ1RmRCbXpsY2NXRlRKenJ0cDhReVBDSnY1?=
 =?utf-8?B?bVIwYis3UHV2WVMrcEZUSjcrdlNGWmZCV2NkbFpOUlZjYnpSUVdYTnpiRmEx?=
 =?utf-8?B?TFMyOUYzbmJLQ1d1UUlRZ0p4dTlneVF1Q3BQTVZqSzJHdG9aRUZUQ2NrU0Vm?=
 =?utf-8?B?Rmk5V0ZZRWdpYkhNbG13cDVCUzIwT1hxWk5uL3l0V3M0QjBQZXdXNTA3Smtt?=
 =?utf-8?B?c3kzYXZxMUpHUkF5QmtqVE84d0dXc3V0aWFTcXd1NEUrUk43bE9PSjA5ZndV?=
 =?utf-8?B?MmFFbHB2dmdZRnBscy80bUQ0eGZ2UTcyWGhCVG5pVFZDbS9pWk5DdUNZUkov?=
 =?utf-8?B?UHdYaWU4aWxjZ2hZV2UrZWNyYkh5YjYzeG1nbFBhRGtpN3doT3VMczBJaWhR?=
 =?utf-8?B?MkdKVGJ3bjR0dk9aWFMwUFpJcm80YmdMclRqUEdMTFd2NWJUcUNFQzROQ0dV?=
 =?utf-8?B?MkxvQWl4UWl4OE00cDFQRXlzWGlXbVhpaEVoV0hUQjJBeVQvaUs4UTg5bExr?=
 =?utf-8?B?Ym1pR1JLcythTXJPSjlIQitNaVpDTTBNbEF1bTJOU3RpWjAzUlBaMFhzMEFU?=
 =?utf-8?B?Mkl0a0c1SjJKQmdtc216MXV0Yk1SUm9uYnlhQWZmV05vQXdJTy9Vc1Y3aHg2?=
 =?utf-8?B?bWpvYWpHd3pSaXphdEdOa0VwM3BiRGpQQUxSWS9yZ0VBSEh4SGlWalFyMmc5?=
 =?utf-8?B?UHZZTnZ3N3cxSVhNSC9XQTN4NlBpTzNXRmYzRllLSnFyNGVhVCt4RG4wTFdi?=
 =?utf-8?B?dTNlN1JnZEpEZjNiVEFnRFc2MW9ZR1hDUXZ3ekVsZDNyQ1NwY0xjb0hBWnBw?=
 =?utf-8?B?Qy9FeXE1cERONXpsQlpMeTZydkNONUlxRTg2UUVRNnJNc1p1Skd1U3dsRW0x?=
 =?utf-8?B?NHVDbDlETnhOOHRTZG5icVdKcEU1SHpRMXlKZVdpUHR2WlFiZ3VQQjArd3RF?=
 =?utf-8?B?UmNmSXNJMmF0MGVZYTdhTVAwRHowanExdkJKRGtHY3VlSFl4b2d4b2V3MUNW?=
 =?utf-8?B?cDJtc3V3UkQ3YUhGZStvcUdkQzJqdkFnR29yNkRWS1AveEtUVnFTeEJCTmt0?=
 =?utf-8?B?SzJGNjZ3UnlHaWZmaUFqY2dzdGZJY25lUCtPUDd1ZHA3SUdudTdsYU9UdlFX?=
 =?utf-8?B?R1kvMXRkaWVFYnZReFFORFFRL3dFUnk5MURteXlTbWdxRHg5b2tOaTlxNk1B?=
 =?utf-8?B?MEN1dWFZOW5yRlp6d1Z0QXJFLzlnWGxWQnN4ZnN3SlpPWTFpc0x6VEdtVkR5?=
 =?utf-8?B?eWpnTzRrOHR6SjJoSnJjeFdZbmhiYUFHejZzdXFsZXdJdHM5RHNPUUNuVFV0?=
 =?utf-8?B?aGFYTnROUDJsN2pJcjlNMnlCMWRlZWYwVEhMb1phT2N0MVkrZTZDUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b2c422-6dbc-4f3a-858e-08de6ebf9bc2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 07:30:36.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0v3wuVnYyRl6ac9ScxKSQYfhXtE0GhsFEAaZIjbd/59tuA83EPWHlZ6lWOHX6oJkJ2mJZVN5uVW7Y2gJ0Ffd7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB8023

On 18.02.26 00:05, Florian Bezdeka wrote:
> On Tue, 2026-02-17 at 23:54 +0100, Florian Bezdeka wrote:
>> cobalt / evl are currently using __request_percpu_irq() for setting up
>> OOB IRQs. In 6.19 the signature of __request_percpu_irq() has been
>> updated and 7.0 will remove the function entirely, so we need a
>> replacement.
>>
>> All other variants (like the upcoming request_percpu_irq_affinity())
>> are missing the flags parameter which we require.
>>
>> This could be backported to all supported dovetail versions. That
>> would allow co-kernels to switch to the new API unconditionally.
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  include/linux/interrupt.h |  5 +++++
>>  kernel/irq/manage.c       | 10 ++++++++++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
>> index bf0511b438c65e119af917763ce92a8f3bfb4c4c..6cd8ad02ffbd87f71869d6737fbc8c1ae477c1ee 100644
>> --- a/include/linux/interrupt.h
>> +++ b/include/linux/interrupt.h
>> @@ -213,6 +213,11 @@ request_percpu_irq_affinity(unsigned int irq, irq_handler_t handler,
>>  				    devname, affinity, percpu_dev_id);
>>  }
>>  
>> +int request_percpu_irq_affinity_flags(unsigned int irq, irq_handler_t handler,
>> +				      unsigned long flags, const char *devname,
>> +				      const cpumask_t *affinity,
>> +				      void __percpu *dev_id);
>> +
>>
> 
> Would be nice to get some feedback here. The affinity parameter is
> currently not in use, but would allow us to provide it in the future.
> Not sure if that will be necessary...
> 

This is what I was wondering as well... When would one need that? Maybe
in the context of confining Xenomai to a subset of physical CPUs? Would
be good to check that again.

> The idea behind were the upcoming 7.0 changes. The implementation of
> request_percpu_irq_affinity() could move to the dovetail specific
> variant and the Linux implementation can simply call the dovetail
> variant.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
