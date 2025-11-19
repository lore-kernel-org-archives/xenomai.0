Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3A3702F8
	for <xenomai@lists.linux.dev>; Wed, 19 Nov 2025 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763530599; cv=fail; b=Lh/nzwN0yhdvp4NlCjNYFBTZ5Z73CY1pmrhfw0aFA70mrl+S5Ak/EznG3eZcdPMgG4WxoWvSANYIfdxcx/kqS4TI8lF3WeiSzIUpX77qqx41paTQCi5XVyX7+L+2kKe2jkxapYpXvX7PQbOJJuRbwjH9YYaOR/DY9lQykOE0m88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763530599; c=relaxed/simple;
	bh=aBjKQA8FReIcESaFYg9oN/suEviWtTHI1aCZqjmWtVs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3yc1Bo3U25S9/WBdRxI+1SWLIlr3Qzo6bnUyLMCz7wo9CUdb9Xt6EsItmu+NUVXQtfMoVBaLWmZmyjexGORfehpIr5GppoNwcNDqBjo5m0rTlQ0Ea+lFWNd7libODvcU9acTjy0pPyj+FXUdEnBBHzTxgH3WpTXmupjStTzSwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UZlphA6E; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UZlphA6E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPiQTejassqAqlfRslShbdEwHrw5kfct1znWnlUH5GnoZPW2K66N7IxNVgpkKV+yIe96B/c5IAgBU9uhbT65x03rk392ZEOSW8oaAnr7FYFakcj8SqsSC4QoO7da5aG2sTPZYyaXmOj5Lo6pwqKGlRq6TdujBRnRToXvfYFoFhiYEFdt5oA8A75M595fnoxz18cyaxMXlTsRaMIwJpB4UxgA0tdLfQfC2PhcEkxzRIDk7lVaVCgUdUVaacSvwdXuVn8QmfmYTgs5Q9sqmdtnwqk3QfOxrEvZ4NjvSI/3349KVdEaL4TV26MBqcW/gdgk3Nv01+NwE2CSM692mhFVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZvDIP2QAVf7pYX0lE2QbAEIozlewZWARGLy2UR8ZqE=;
 b=ET8uIDzT/8cRklkw6kHylaKH40vocctOZQBLL6pekliDaokrxbVG7Oy2R0hT0hOnTY/e53w0XEEKyfeutEQMkUap6l2Dw3cfi+clb85/VNex1cIY8jvlwn0S5SHW8fwxmX4TkOGHFC22Psz+z2t0AwqJ5l7ta3CVAegmkGLDyS0OZn2qNizoVf/Qe9A42OuG2LikcBA/ciebER+BD5iyjQXUi0l2wgcSYcFpdKCTkjEdUMZ/+QA6U/tLcgtzfa0FAMxCIKTEUS4LUZ82Dt6osOOoKHlz0heaVyeGFcMBSBYS7o3fgs9K45UGlDmEVbYHknjRocyZHSfSl/VQCZ1M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZvDIP2QAVf7pYX0lE2QbAEIozlewZWARGLy2UR8ZqE=;
 b=UZlphA6EvQpDABpzZ1VrZELxhphPqNRR9EU0tC2FIPVyGG5B9XQ/lq4LLsXF4+aXhH9+blsPjRzbwowh6ur3p2cOg9VX7GhFLQaU3nz4SGU0uujjPLZnDhYZHBv6UjpqR28WieIyeGzsXwO2pFN1Y/dEe2mlGQCN4QxuYgnPMmMqd20xA+dIJOdCgj68dMavEDXOaQXM8iEiE0fli8HYr8ge35mD+q8G2StJh2fmAZOwBmQKq9tRL9HygAAY03UWOaropgNMZ5tydjoVokJ67PbIctwT/mNlcXJf8osGSOgE+H02DBn5JTH+d34KtOyFblqlzWGDutsHqJW+z1Q81A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 05:36:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 05:36:34 +0000
Message-ID: <3871ddd0-b661-45ef-a147-7e2ae03d6688@siemens.com>
Date: Wed, 19 Nov 2025 06:36:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: multicast fails with rt_igb driver
To: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
References: <CA+K1mPEs3K7ymrnTMa2vmM4NWrdL-n-G41zxEYTJYBxq4F233w@mail.gmail.com>
 <CA+K1mPHMdS+vh-5SJBYQy79D8fK-MK+Z7Yv_CdmYBf3d1oL+gQ@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+K1mPHMdS+vh-5SJBYQy79D8fK-MK+Z7Yv_CdmYBf3d1oL+gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3708:EE_
X-MS-Office365-Filtering-Correlation-Id: eef75956-9a62-43cf-a7c1-08de272d99ab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnB5Y01rdW1RM1ZHMzFXSXdnWHRDY1JXZFpvSHByRVBMUHdvREtoeEk4Rklk?=
 =?utf-8?B?ZlJxZGZXNmNNVEVGS3pWUVQvaEFHUU5MRmllMW8xSzloNjVQMlFFNkNCNUN0?=
 =?utf-8?B?VmZiWXBTTTdubnYxNVd0TEpqdFQ3S0lEQzBnNHExa1ExazFoT29GMndUYTFK?=
 =?utf-8?B?Y3dGcXNhdkVQbTBKTHpBYnZQNDgycHM4M0wyZHBRSHZFYlpDdFg2ZHRybUs3?=
 =?utf-8?B?QWsza0dub1NnQXJncWpTN2lvNVNSdDA2dCsydlpieWtsWGFnSGlMdGU4NUVt?=
 =?utf-8?B?K2cyelo2bWtyZjFubmU0MzZFK2kzWDIxT3M5YzBPcVJTaGc3ekVqZXFmZUtG?=
 =?utf-8?B?ai84UkxONXdDaE9XcWo5RlpaV3piUytsdWtrMm1qSUNjZG5MUVhEZHNacENU?=
 =?utf-8?B?SVBKOG5nbVBwdGJhQnlLYWY5TlVQUy9XZHJBU254MWFJR2YrdG9tWW5EeExX?=
 =?utf-8?B?V3RCdCtldDVCQVlLV3BISG8rbU5tNVZ0K3h6dEYydHZ3cStxUDcxVlYvRjJo?=
 =?utf-8?B?dnUvS2RoaWMxTVFIczFtY0R6OU9obWpuV2x6WC9OaE40SzFDK1dqU0xHY3Nw?=
 =?utf-8?B?Tm1ZN09pTTlIOEpHS0J5RlpZMXB6M2lDV0V0TStuRnY1bjY3OVFsWFZtTVFF?=
 =?utf-8?B?c3R0YjlRK1huMUNTalZSRng2Um5Hd29oSm8vd25URmVld2JNS2RCay9jUFBs?=
 =?utf-8?B?TThUUnozQVhkRzNyY2kzdmlzbUEzSVU3RVFoTkVaZW1lbi8xc0c5dkhzTHM2?=
 =?utf-8?B?M2JWcWVYZ3JIMGZtNW5YNmNyQkhUWVFqTlJyK1lqaU5vRzluWk9JQzJoSGE5?=
 =?utf-8?B?aTh1eSt3UjZJQXBtQnI1SWRQOGhGV2hzUjZNYVQvbFg3WEdMOVNMMVFsSy9W?=
 =?utf-8?B?RXdrT1haaEVsOWg3SnVHQURwQm9HbWpPU2U5L3Y1SjUvRlJMSDc1VEcxQXNY?=
 =?utf-8?B?NDRoOWZOZjZQeS9FdlpyWEp0aEJtMmNqMGwxS2EwWXpLblBidld0WW9JbnVH?=
 =?utf-8?B?V3FPZkNoeGx6VWY5NHlpVVZNNXBWZWlQSHRPRDQ5QWJjSzRkSlVSdHVlOERl?=
 =?utf-8?B?RmpoMDQramNWUERwNVdOaVI4bUkwbkh2ZzhNVldqSWc3MGtaeTdTTE1qTVRq?=
 =?utf-8?B?L1JKVjNmeVRUS0FvcnpXcVJtYzdTcDM1dVpyYk9SQ3BVR2habHVGWllFNTdE?=
 =?utf-8?B?NmdDVjRjMWR0Z2RFZzZDTFp4TmNvMjRqRDRhNVFMekZKUHFMLzZsN2hDc0ZV?=
 =?utf-8?B?MVFLUHIyMDFHTTRyaHRLdVVmL1kweXFmRGd1ZFRNVE1ZUE9mSzFJaG9LYUt2?=
 =?utf-8?B?czVZRlQ4aDkrWmdvL0pKL0NuR0hHMzNxWmpyc0xQWlhmbzc1OTdVZThSUDVu?=
 =?utf-8?B?L3hpYW00V0FYM0QvaHFFdkZnQ28xVVdMS1dwUTRJOFAvSlRHOU9QUFZwbFpH?=
 =?utf-8?B?K1hWYVNjVExTakRUMnI2cG5KbDVyLzBLMlNXcUZXbjkyUGZWZ0szNUZsK2Ja?=
 =?utf-8?B?ZEg3RHloUU1oRjdSd2pRWHVqWHlBd2ptQXdKeDB3SkpwckJEOWVvcTAvMkVx?=
 =?utf-8?B?RDJKMTlYVG4raCtFbm0wV0MyMklqTUhuWFhMUGFOczBKMVZ5YUpJZk13ZUFr?=
 =?utf-8?B?WitDRmJscWF0V2FJTVJsVTlEaEhJNnpXdlZCK1Vvb3RaQVpIU09BdEd6OFNh?=
 =?utf-8?B?bStoZUhlM3pUWnl5QzdQMnFINkdEVUUybCtVc1BkY0RlYi9KOVo1VElGVzBS?=
 =?utf-8?B?aDhjTlVPT3MzcDZHVHBZMUxVeWsxa0xlcnFGMXUvV0hFUkZ0VEpqeXNNTm9P?=
 =?utf-8?B?bDBDWmlyRVllYm9FR21OVG9CeFNOTFYwUEE4WGdNOHNCRGFoNzJKTUNsM0sr?=
 =?utf-8?B?TVN2OTN3SFlnaWtGcENvVVp2dnJNSWcrTE85Yi9VZitSVGE5L29MQWRRTHFZ?=
 =?utf-8?Q?gXVWaY2ZrAu6Qt32ewvLTPHErOmgRjv/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm1XOGVXLzNhRVM1aktFemJ5bFUyU3VoZWJMUEswc01rNFdlOHgrdUJ1bnFL?=
 =?utf-8?B?Q1BSRzZSeFFJN3RnQXhBbUlFejQ5MnFNQldlVnpQTlhPZjUxNzNmenAvbjIr?=
 =?utf-8?B?Y3dxa1NFUnlVUENnNkwwaGFwa0hQZGN5cnZud0pFMFMzbEhNWkFBVXJ5TXEz?=
 =?utf-8?B?SDY0Q21PRmQySHduUjlVTU1rbk5zcmhNSFRqck1KdFpOUVY1ZWJJQ0wwazJk?=
 =?utf-8?B?VFgrcVFtZzVOZGl2VXkrM3ZESWt4VGticG9lMzE2c0hDYjFORjhDVUNHeDNv?=
 =?utf-8?B?QWU0UXoyY29abnpVbngvR2NWTzlBWDhMNmpYcVAycy9pRFZmV1M5V1pMVFp3?=
 =?utf-8?B?TUE5NnlROHhFZExJWU14Y0pCQ3hqbXpEb0l3MGhnWExMNGxQU3d3YTRqUHpJ?=
 =?utf-8?B?YVFiNHg2dHFmekN4ZjBscDVKV0NLTUlVL0JZS3N5M3l0NnZBMGtLNUdETVpK?=
 =?utf-8?B?dlV2bHUxSC9QU0pMODdScnJLTlRYdUpaeVlvaUdrQ1NlbnJYWHluVzdFR056?=
 =?utf-8?B?N1A3SFNORlhMYnc0TnVkQVZZVStLdk9OQ1RycDgwOFpzUFFyb3ZkUENBZHl0?=
 =?utf-8?B?MVZPcWxUc0IxNjBZVFB4eWUrb0picTBVRTIyQ1hrWmJVL1RBZXZvUlZ6TEhD?=
 =?utf-8?B?bWVLWmFFSDFEd3EvNEpZcTlTY3pqczdzUVd1bnVIeUx4eUFwSUJwaFNhc0Jn?=
 =?utf-8?B?SUdYRi9aMXRlTFZCY296S0xKWmpEdDdwRWNMTFQ4TFZnemNvY0lXU042WWdP?=
 =?utf-8?B?NnhVOGpkQ1RBNzcvcWxQVHFJcHFPeTZvU25KVzE2VmpXUGRuaW5DOTVUczRl?=
 =?utf-8?B?V3ErVUZZdW5lWXdFK1lqT3U2QTl3YXZ1WlM1SnRqSjhvQ1RLa2NpVExLSUZF?=
 =?utf-8?B?b3oxQ3ZSRDArR2pFNGpubjMzcnZYU2ZRVGxRQkRxMGdXaVgrNTBuMnVnYzZE?=
 =?utf-8?B?SUgrZ1MzSWhVd1poT3RXNFR6eDM3anlkMUxRbXpBdmpFS1Z5Y1RtVVF6Sm9q?=
 =?utf-8?B?MmthMWsrL1ZqaXFPMzRudzhTN2s1SWE1R3Z4QzFuWXpRdThWZ0RhaWFUWFRX?=
 =?utf-8?B?WXNNMDNvc0R1elBrSG91aXAwMzgyZDNRU0ZLemdRQUtMOTNaOGd5K2FJSTI1?=
 =?utf-8?B?ZXpUVEt1eXd6SFVRTm85V3hHK1JzT1JWcnFNZlU3RGtMK2ZveVFwWEhDMzda?=
 =?utf-8?B?bm5KZ2pudlIzdkZ0R0VyTzJsVVVVcnlCL1pRdHVhZFVWVDBpYXFBZklNSXNY?=
 =?utf-8?B?d2UyT3ZaaGk4eFBFWDJJL1NsSENuZ2pISkFkVGNHV1pHenVYUHYxa0V6OW9D?=
 =?utf-8?B?VTlaUno2bnZvZDJVTU1rUitxNTJlblR6MVd1VXNMOGlkbTAxUDg3K0hrNlZl?=
 =?utf-8?B?eGpDSTJNM0xmaGFaOFMvTnRmRktvM0NLRkNzUkplTXdJS3NqcWdxckN4aG9U?=
 =?utf-8?B?UzdxeXFMMm5VdDkramhTMVRJQTVTcVFvYTdEejBtYXJ5VldCbEVMUnZJYmJE?=
 =?utf-8?B?Yk5aWDRMNjVRTmNlRENtU29aaDBDOVNoUTNFREEwL3VQbEdhZHErekUrdzc0?=
 =?utf-8?B?OVpNUjlTZXFUbENBVUM1WTZtTnZ6ZnFrNE4rdWFEYTVTRDVmM29rNGIrNGdG?=
 =?utf-8?B?b0R4SytSVFVFUDB3bmtwU29IcTF0a2xLdW5sNHlzdkhpYWlFRUlHN2IzVmRS?=
 =?utf-8?B?V1JsR0l4VTVHMFgwNE92ZmxXclR3aWhTTlF4M0F4OTNFV0g0cVBVZ1oyQ1Zq?=
 =?utf-8?B?b1ZHSlVVYk5ZYWJVTGpaL3E5TnJEelNPRjladDl4cEVOYjZmMWdtanZIQ0Fv?=
 =?utf-8?B?NnJRMG9hcTAyTi9VZ0ZQUVdGdHFJR3V3QTJuZmZDQVFINzZ5eWJuQmVyZFV3?=
 =?utf-8?B?dzlBK3RCTXF1L3hhbFZFdUF1RmtXTHpUZmp0c3M5aHR3dHhmL1ovdnJrY1lD?=
 =?utf-8?B?Qkt0Sm5JdzFXdmdnUUlxN2dhdm85bFpsbUhERFY3ZXNDU2szL3hGQmpLT3cw?=
 =?utf-8?B?Sk1HWXYxa1ArV1RSWFpDd0J2d2cvTXFCOU1Ed0RPVXloSnIyWWVwSjZtR1pO?=
 =?utf-8?B?MTR6cExrdzUzUDlVOUpKNDhlSUFiMXhyamdyZUN1ckxleUFSaVoyQXYwVnBB?=
 =?utf-8?Q?7amhWBSv/tdhkhtgCMZf/zQ8x?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef75956-9a62-43cf-a7c1-08de272d99ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 05:36:34.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLkpECJTWYcY6fun6jNKLIY7zo/zZ4TWOh1JLIpaa8H4i62jFrzvR9ljou8T1FvoX7Z3u0sZDlBQ5FgA3/gJxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3708

On 19.11.25 03:14, C Smith wrote:
> On Mon, Nov 17, 2025 at 5:31 PM C Smith <csmithquestions@gmail.com> wrote:
>>
>> I am having a problem using multicast with rtnet, specifically the
>> rt_igb driver.
>>
>> xeno-config info:
>> Cobalt Core Version:  3.1.2
>> Kernel Version: 4.19.229 x86_64
>> I-pipe release: #21 detected
>>
>> My NIC is an Intel I210AT using rt_igb. The rt_igb driver works well in
>> general, it can receive Unicast UDP packets sent into the real-time port OK.
>>
>> When trying to set up a real-time UDP socket capable of receiving Multicast
>> data, things fail. Here is how I am configuring:
>>
>>    modprobe rtnet rtipv4
>>    echo "0000:03:00.0" > /sys/bus/pci/devices/0000\:03\:00.0/driver/unbind
>>    echo "0000:03:00.0" > /sys/bus/pci/drivers/rt_igb/bind
>>    modprobe rtudp rtpacket rtcap rtcfg rtmac tdma
>>    rtifconfig rteth0 up 192.168.0.240 netmask 255.255.255.0 promisc
>>    ifconfig rteth0 up
>>    rtifconfig:
>>    rteth0    Medium: Ethernet  Hardware address: 6C:B3:11:52:A8:5A
>>           IP address: 192.168.0.240  Broadcast address: 192.168.0.255
>>     ...
>>
>> My code:
>>   struct ifreq ifr;
>>   struct sockaddr_in addr;
>>   struct ip_mreq mreq;
>>
>>    ret = socket(AF_INET, SOCK_DGRAM, 0);
>>    if (ret == -1)
>>       return -1;
>>    else
>>       udp_multicast_socket = ret;
>>
>>    strcpy(ifr.ifr_name, "rteth0");
>>    ret = ioctl(udp_multicast_socket, SIOCGIFINDEX, &ifr);
>>    if (ret < 0) {
>>       write_log("IOCTL SIOCGIFINDEX returned: %s", strerror(errno));
>>       return -1;  //Failure
>>    }
>>
>>    memset(&addr, 0, sizeof(addr));
>>    addr.sin_family = AF_INET;
>>    addr.sin_port = htons(port);
>>    addr.sin_addr.s_addr = INADDR_ANY;
>>
>>    ret = bind(udp_multicast_socket, (struct
>> sockaddr*)&addr, sizeof(struct sockaddr));
>>    if(ret < 0) {
>>     return ERROR;  // Failure
>>    }
>>
>>    // Join the multicast group
>>    mreq.imr_multiaddr.s_addr = inet_addr("239.249.5.5");
>>    mreq.imr_interface.s_addr = INADDR_ANY;
>>    ret = setsockopt(udp_multicast_socket, IPPROTO_IP,
>> IP_ADD_MEMBERSHIP, &mreq, sizeof(struct ip_mreq));
>>    if (ret == -1 {
>>       return ERROR;  // Failure
>>    }
>> ```
>>
>> Its the setsockopt() above which returns -1, with errno equal to ENODEV.
>>
>> Am I doing something wrong in this code? I do see multicast mentioned
>> in the rt_igb sources - is it known to work?
>>
>> thanks,
>> C Smith
> 
> I put some printk()s into the rt_igb driver code and I have figured
> out what two of my problems are. Firstly, I neglected to say I am
> accessing the rt_igb driver from a RT Xeno application compiled -m32.
> I confirmed that the addressing of the setsockopt() does not have "32
> bit compat" code.
> When I hacked the addressing in net/stack/ipv4/ip_sock.c, int
> rt_ip_ioctl(struct rtdm_fd *fd, int request, void __user *arg), I
> actually got the i setsockopt() to execute OK.
> 
> This code should support 32 bit compat mode:
> int rt_ip_ioctl(struct rtdm_fd *fd, int request, void __user *arg)
> 
> So that the following 32-bit call succeeds:
> ret = setsockopt(sys_p->udp_multicast_socket, IPPROTO_IP,
> IP_ADD_MEMBERSHIP, &mreq, sizeof(struct ip_mreq));
> 
> No, I don't have final compat code from which to make a patch at this
> point. But that is contingent upon the second problem:

Would still be nice to receive patches for that at some point.

> When registering for the multicast group via setsockopt(), I get
> errno: "Protocol not available".
> 
> So the rt_igb driver apparently does not support the reception of
> multicast traffic at all. Is there a plan or a known patch to do so?

Unfortunately, that feature never came out of the planning stage, and
that for RTnet in general.

At the point you start to handle messages that target multiple
receivers, you also need to think about the case that more than one of
them should sit on the same machine. In that case, you could no longer
rely on the hardware replicating the messages for you, and you suddenly
run into the challenge of mapping the buffer ownership model in RTnet
onto such scenarios.

As that was never addressed, we also has no infrastructure in RTnet to
configure receiving filters for multicasts. You may only be able to get
multicasts by switching the device into promisc mode.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
