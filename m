Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649228FC
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771228909; cv=fail; b=bZI71PfTry76TFK/FYIFWkl0r4bJU0vZpsNDMzK+7xO6JKiQK2T+jEtTWcX6ibYqu+KhvyV8qqOudQWfRwDkxxJ6nkEfWJGqKthqJlh6GNa5oaOmQmkwQrDeZfsic+71JJ+qxDtFectF5jBuUfSoqLv/+dx7qmUUUd+4PMc69Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771228909; c=relaxed/simple;
	bh=kfp2Yupn6jOSY3bcME34e+HHmcsda15U3l1D4V1RnsM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pxDtU1mRfy93Syv/yH//bxpi0PVtKc3dzRtbCmZs3XGI4o7JMpBvJM1WIf8/37fSgUDb5cYuP21Znmr/gCRcf40v8RBKsE4T/8IQvZ3xzuz8veIO0trr14y0LTwoA7NlLru2AM0EEXMzLN8WZIFOE3cDQf939h291W77x/IY0Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xAhLzaww; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xAhLzaww"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMz1ioEcZXQF0v7cJr3ZPQ+qGrtip5e2BnDE3PzUgcwsmDzFjkx16fmeNxEjpeWIK36Iz3JoY+wBEXPgHBkJKRPhLaVwE1NQ+kXJOTpDN5zCAmL1E0swf9S/LSRwkKiwnrINhTRhPa0Bpgx/zuFexkxDSjqE1ZQp73GeEnw4gKeQttMf6+/BE5Pwg/egId32VcBEC0FmjHU2vVlc5PRt1XQT1g4k6Q78QLjzixuy8A4gEwxeiSfJVULzK22Hi+ot/3OdnCQ/rUOy8sZbBW4OKJdhmwOx/U4PXsEN2Q41IbXriX3czyogkwNXWIG/pVozUPGqiB2lcE0K3ltgdpKG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKgGBStVF/tV32mVWgCv0KTHXE9FPQQU93lE/w7efjU=;
 b=eoAm4Z7nMLY+z2Z4k1uobZy7SM1dkirBKoqMz9gqouHk9mfE9xrOqHjTpy3wecXUvG6sZgZsM7vdRK865s1DiozebGL3HX+VVWSywq/s0JPtNtj27p2V+7snsTdq8hdX6ODqTTnnZUllyJ/z1D2dv/ZHgVUk5zMvzNW9aYDO4tO4pHVxHvjcfJjJTuM1IBjim36HfQCn8zpIkEai90w9sSa0aNXfNpc12ksvy0CKew38x5wu358nHdV6XQtvIHPQYcei1KpyF+uhkFbqbxxLh0U8SNVgmmK7aO4WslJK5BLI41gl+MIjqcKb/Q1oaiA0eSORH2N5LacV/JWDw62OCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKgGBStVF/tV32mVWgCv0KTHXE9FPQQU93lE/w7efjU=;
 b=xAhLzawwefC2yFYE9vf2mUhgDt3m/tfVXhruKBsEOUJ8RlQ0CMFhgW655+DUoKOwt5MlkL3GNe1krqhGgy1HHEtiDSO4eHjsETQoUnz0PvgQEGEo6ShOdJdbiY8O4aBgnnOSQHMOmgEHCTA/oUOYj5B9H/Rr9PuRt9QlGwzXvtS7yJdwwPd/HYYLBtLllhePEJuKIPlOGmPEqJAqwXpQI5JBoGOlRIa3f6FKEOMuz9XCOGCdvpvB51e9086kAGcVi0mUTAJyLc7OgbFtvdeX3OA1KatWqk2zKP+RcdCrTA9BYzKIstGqTzTxlsFJz6rSzIFR2OsE4cTKKPKoH2Z/pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ed::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:01:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 08:01:44 +0000
Message-ID: <412b6023-5737-4536-be74-7818cfd8ce5f@siemens.com>
Date: Mon, 16 Feb 2026 09:01:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci(libevl): Trigger more kernel
 combinations
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260216075310.3106961-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260216075310.3106961-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bb8520-9bc4-45cd-c7c6-08de6d31a01b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXQ2dmFpMnh2N21kNnBkU0J3dUN0THJHN3BMZTBUV1dkYitxNlYzYWVaU1ZS?=
 =?utf-8?B?cUprRUhmbHJiR0xFWFNSVzR2Njh6RnJxQnpHMGdHNVdQalUxZnJKY3ZwVjVx?=
 =?utf-8?B?UHlsekJqQm5UWXNoRFA4Y2FFdmd3U3ZMZzJYMDluckpRNTJWVzcxeHB3NjBG?=
 =?utf-8?B?ZUpQYVNQZzVYREJaSjM5UlFsNXZsenBPdmN0QXY1ay9ycjlDMXZwY0ljdVg3?=
 =?utf-8?B?YTN1cTdBVEpkWVVaVERyUHd5ZzZSako1OXV2STVqK1dINFlibktmdTAyc2U1?=
 =?utf-8?B?TmNZTUhpVFRwRzFaSUNzTisrNUowSHpFbU1KcCtUb0MrWnlKZUpydlRSbEs4?=
 =?utf-8?B?cmk5enpKSm5rbkp0Yk1yK1JLa3dnZm04SEMySmptVFh5WWljNll1YXJISmdY?=
 =?utf-8?B?V2haN2xCaVRVdkdTTk1ZWjVvSmxZdkdaT0ovOHN3M2VmVzR1UzJ1OTNuMW5O?=
 =?utf-8?B?ZHRmNE1uVm5UVk5oQkU2WExEMTJRL2p3ZTBhY2ZJb2Z4cUVzL1NEdVZmcXd6?=
 =?utf-8?B?TG4xMklQRXU4M1RxcnJzQm0wUVltUWpQV011SWFMU2tDWHBYdTlkeUhXSElC?=
 =?utf-8?B?MlBSb3FwZmE2YUNWa3NWMkZPZnJwQ2pOOXRaZ3k3RkNycVNWWGRUQUNEbTN4?=
 =?utf-8?B?R2RIUzJaUDlwaGM0S2Q5bW52dnBnYVlqWENGMld1UGxKWjdWRWxkNTRKbXE2?=
 =?utf-8?B?Zko4N1VJbTFHRmZ3dkkzWkJ2ZWxFbDRyZTVQZjJ5TGpBcko4NUxMUE1qSGtS?=
 =?utf-8?B?dEx6ZXAwNk1aanR4d3p5ZUt1a3lsS0pqbzRKSmhpSGlmcGVLOW5VWFBTZnVm?=
 =?utf-8?B?SnhhcUtGbUlqTTRDdnoxT3NTREpEM2NNbkZpMEdtcVphby9DaW1rdDZqUXM4?=
 =?utf-8?B?NStNSXllMGpHVlVVaS8xTDZpWjAwVzJOWGcrV0d4UnIxQSt5L21udVVselV0?=
 =?utf-8?B?NGdac3hRV05pS2tJNVdOZ3JyZnN0VjZJVFMwOUc1UVppelJNOVc1MTd6eTMr?=
 =?utf-8?B?dnVnTGFKL2NaUDVLeVRJM0lzUHZpL0liQ2orajRQdDIrQ0JRM2Z0blRVbCtK?=
 =?utf-8?B?OVhEWnlPR1ZFZ2liNXhZZWlqQXFBeHdRZXlRNEEyTlEyNDVDYVkxSDl3alln?=
 =?utf-8?B?a1JmbW9FMjcvaDlJNnN4aUhodlJLcWFPcHVwQllJcjFNYlBKNjNDcmxuR2FL?=
 =?utf-8?B?d3dBM3hxalIrQ2lsQWM3Q1gzOWgvM2RuQ0VJSkpNSW1GZXNObEJCanhmY3Vx?=
 =?utf-8?B?QnhXMTRseGJPZDNGMUFuT0pqMFN3Tmtuc0paemdNMTQ0SGY2ZmJ5MXhaRURV?=
 =?utf-8?B?WGJkbTBPbUpZVjFFZGl2akYrYzdlM0Q4dXpiclovR21DaFhybHVsZ2s5a0di?=
 =?utf-8?B?ZzV6ejd3RGlDdFVYWEVsbWxkVjh5MDh4UzYveDFrR3VKRENleGdNSk8zVDVW?=
 =?utf-8?B?c1JWNU93eTNIb0JwblhQVTQyVm9leFEvaFdvTVVFVWg2SlI5UzdPWmhNN3U2?=
 =?utf-8?B?MmZFc0dhZzlRVTlqRitGK3hUb2ZXWld0VFp3OHNqYlRCeTJVVk92cUxQckQz?=
 =?utf-8?B?SUhlR2lqNnVETjh5SlA5VmxnNDBpblNmK3ZtVFo4UUVEVG85NHBUZ1luUCtp?=
 =?utf-8?B?bGZxNVZYeXlWTnJUSHgxWlhUbUVTZlcwNGVUMjdXQWJKUVdWdHJmSHlrenlQ?=
 =?utf-8?B?eVNodnpsWVJmRGRLYmVuOGsyL3JETWNhb2pNazRDRDh4VDNUYVpkbUJjSzB2?=
 =?utf-8?B?WktseThpVU9CaWc5S2NQbjRBZlJVMHRjaVc0bFVyd1BqWlk5NjFZRDZpdkY2?=
 =?utf-8?B?QWpldURLWUp4SEthc211UWQ5QjBmZEhXZmdsVEVMUGQ3L2Z1cllEU1BFUTNG?=
 =?utf-8?B?S3NsZ09VVGE3TjJjMUVwOW9qaVl6aktLTUZVVHI2ZDdza2R3Z2JkRUhRcDI3?=
 =?utf-8?B?MmpYVDRrbm9zUVVOQjZnTXBUMEdLU3dVRlN4ZkFLS2NFTGEzVCswY0FlOHVK?=
 =?utf-8?B?TTQ3K2lOL3ZsWDA4MjJGR2V1Mk5lQ1JPS2Z1K05HQU5rWGNncE51SDRScjB3?=
 =?utf-8?B?dG5lMFM5d2lJRE5WQVJHR2ZFcjZYdkNqZGdPa2MrdEV2MHlMM01lQVVrQ3du?=
 =?utf-8?Q?tERc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmsxNm9sL3B1MFFrY3hiZTNBVnp2RU9KWmdwek94OUNYeFRYaVhrZHFQd3FR?=
 =?utf-8?B?ZlBhc3BxMDNRZjYxd3Vra3YraFlHOCtjOVJuVlE5aVNtbUF3Vm81T1RQMDFQ?=
 =?utf-8?B?Wm1TRFVhbnhGSS8yYXFOc1p4cXdJdVlKWmxoZDRKRkxSdzM1YmF4blhKTEl5?=
 =?utf-8?B?cEdCK2dhTlRHaTV0MURhNlh0Y2Q5RUhjejJhaWxUR2N5dmkya3lBejd4Ykow?=
 =?utf-8?B?NWFISHZ2WXhDWGhhdWE0bGRrL1R5czdvaGJ1dDdWdVcvVU51cmZ2czN6QnRH?=
 =?utf-8?B?N3hZbkZSdnN5WUVmazR0NnFaYkNtWElEVE5kNm9vWC83cG5CcHdSRXR0M1hw?=
 =?utf-8?B?S0JZQmZYZm51WVgrZkFNbG5BV3J0RlcyVE5lcWJIeVptaDVPbklEUU9lSUZh?=
 =?utf-8?B?ZTdFbi9Mb2xSMVNmMlA4d2FHUm1vUU9GMDBSWVFURTJZaWRvalRLUXh2VVpP?=
 =?utf-8?B?TVN3cmFiTmFpbzhjMUFPNEViUWl5eC9ORFQ2WWpPUUpSQ09iQmw5b3d2NG10?=
 =?utf-8?B?WUQxNzdTRWlZZlM4M2dqOHFPQzBFOUxIdFRKUEh4OXVUem9SMVRGcUtDSDdv?=
 =?utf-8?B?TXJHZFVtOU1LK0d1d2Npa1FSVjlVNzZ0Q29HeHcyV0VVVkNDYzJJQlg4aXdG?=
 =?utf-8?B?ZStTb1pWK3I4amk5MzMxU0lTTnJjZnhCckwyNGdBbVRuY2FESDdrTFN0R2Qx?=
 =?utf-8?B?MDlweXNhNHZqOEhyb25SaGxob1RCS1loYXFZNVZZSEpwWWQ4LzdwUjFBSWZN?=
 =?utf-8?B?cGt0VHllUHY3N3NQd1pTQnlhQmVvRDM2OEpLYTB0NmxIb1pWNDZ0SWtYYk1j?=
 =?utf-8?B?S1paNHJHSURDZmE3dXQ5MTNKdTZnQXdtRDlHRGQxZmpiVHJGZjdKREllSDVx?=
 =?utf-8?B?c2RZVzl1cTVheHBHUnBQS1NEYlhrd2N2N1V1cGxtSUhyZ3FwV3NXN0YvV0F1?=
 =?utf-8?B?WjlLNDYzU29wa3c3cFU5OVI0eUROcFdVMW1JbTUrL0tsSENTTGI4YWhvM0Qx?=
 =?utf-8?B?dHhxZ2E2a0psbHBYKzJyNi9LQ1pKSDVudWRxbzJVSUZ6NFdQMU1VMGFEZ0Vl?=
 =?utf-8?B?c0phalVFbStFNlUzaDduZVg4NS9uTWZGd1IwTFBwSEQyZkJJYjJwNkQramNq?=
 =?utf-8?B?enpxVTZteHpwQzN5VXRIVkZwY2lYVThQdHBTUCtyaEpRTDAxZEYxTmJZZEVR?=
 =?utf-8?B?ZGlkZVpTb1V3aW9QR1A1N3RPaDkrcTlBZG43MklLZTM1L3VUbFFEcjlMa1NL?=
 =?utf-8?B?dXloeDFQeWdDdDlYcG5MUWxsaW9yZlZWa1lKaG9GaUhDNklvOGtiR3R5ajBy?=
 =?utf-8?B?alkrMFE1WDFNV0tVZU9qdlZFaEs4MU42M2dHZU1FUGxhQVc3M21HZ290OUV3?=
 =?utf-8?B?b3BxQ3dIa3p6Rk9tQVNvUnpJOGQyNWJhT2hyMlFWOGxTcVByS01hd3FxbU0z?=
 =?utf-8?B?QmdnMFBzL0ZKMDBxeTAxdStUVnVrcXMxcG52dGFSTzc3aVE4Z3JQMWFSd2w5?=
 =?utf-8?B?SElYSW02TjlPQVFGWG5VdnVuOTNRYlpYOGdDdGx1ZkFveHZlZW5OUU1Ha2JS?=
 =?utf-8?B?YnUxTVU5SThaZWo5THhGSVpsVCs2MXl0U3NzNlMxZyt0cUcwY2o4azJhdGhh?=
 =?utf-8?B?NEs5VGkyQjl5SS90YlVZeWRQRDlTbjB3V01DRWYvMWtzY2xVK1NvZ0t4YkRW?=
 =?utf-8?B?ekRadkExS2hPOXpVU3Jhc3hMc1hiUllMRVg3UW1IZUt3UTgwRUxZS0VncmUx?=
 =?utf-8?B?bFU5blBMV01GTWhqNXJXcXZ3c21BNkhIcXRwTEVoZWNTMERyVzAxTHozamxW?=
 =?utf-8?B?UmlqOXVyenBnVmJwVHpVRndNSStaWEJzV0dBdkg4a3plM2VaSGJMNzRocVk3?=
 =?utf-8?B?anFkUEtKSFY3VXNNSGlmR0RSNjZ0SWZVUWIxSklWRU5NZ2xCM2VEUnpwMVhi?=
 =?utf-8?B?YU1Yb0kxL0hMSldQQytNbWVaOThNSTR4U0wzTGpxYTVpUTBLZmVkVXVlZldV?=
 =?utf-8?B?bGNiUFgrc2VUUVBocldHTHl5SGo3SWVXZTBaZjZMbExVN3J0d20vQkpQdmtU?=
 =?utf-8?B?M0JTNWRRRExvMlY0Z0liT1c2eWh4QnFPUW1DTkVuWU45eGxJOVJROUoxUzZI?=
 =?utf-8?B?bXQrSE1rVWZGRm13djdWNkpoNXJiUDVjNzhlZHJISWlPSmk5RUhFQ242Qmx3?=
 =?utf-8?B?SXVFNW5VTGJYM2JjN20rZXN6U1VVaHJ5eERRVkhxWWtvS1lSUkg3OWJ0MWdi?=
 =?utf-8?B?NTc4K2g0UndqWHBCS0hmNERLMG9pK0U2M0xTMUtVUlQ4NXlaRTg0ai9HelBX?=
 =?utf-8?B?cnBVRDc3Wi9wU2l1VG5qY0EyS1R4MXJoQWRMQ2t6QlB1RGt6dU1oQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bb8520-9bc4-45cd-c7c6-08de6d31a01b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 08:01:44.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTTv4xUKtcZvBKJJCZYfjhI0kblPp/0wYYhdnug7aQKfqycHylE8OoCi7pufa0Iz/RyyyhTptxs6Ts4DYqoXcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7174

On 16.02.26 08:53, Clara Kowalsky wrote:
> The libevl next branch triggers a pipeline in xenomai-images in
> combination with all available kernels (6.1, 6.12 and head). The
> physical targets are built for all kernels, the QEMU targets just for
> the head.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  ci/trigger/libevl.yml | 3 +--
>  ci/xenomai_4_next.yml | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
> index bbd4e13..706303b 100644
> --- a/ci/trigger/libevl.yml
> +++ b/ci/trigger/libevl.yml
> @@ -18,8 +18,7 @@ stages:
>  trigger-xenomai-images:
>    stage: trigger_xenomai_images
>    variables:
> -    ONLY_RUN: xenomai-4/evl
> -    KERNEL_VERSION: head
> +    ONLY_RUN: xenomai-4/${CI_COMMIT_BRANCH}
>      KERNEL_VERSION_WITH_QEMU: head

You can drop this line ...

>    trigger:
>      project: xenomai/xenomai-images
> diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
> index 5c1c7f4..42d913c 100644
> --- a/ci/xenomai_4_next.yml
> +++ b/ci/xenomai_4_next.yml
> @@ -13,6 +13,7 @@ include:
>    - local: '/ci/lib/gitlab-ci-base.yml'
>    - local: '/ci/lib/kernel/6_1.yml'
>    - local: '/ci/lib/kernel/6_12.yml'
> +  - local: '/ci/lib/kernel/head.yml'
>  
>  variables:
>    XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml:kas/opt/debug.yaml"

... when you lift

KERNEL_VERSION_WITH_QEMU: "head"

here. That makes sense for builds triggered by xenomai-images changes as
well. Maybe split those two steps, adding head to xenomai_4_next first.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
