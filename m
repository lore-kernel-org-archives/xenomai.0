Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA24158D81
	for <xenomai@lists.linux.dev>; Mon,  5 Aug 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860752; cv=fail; b=BYtPb/6Z7ArE0umXnyXLBOdk61wrcGnZ5JmFeActq7W6KWTG521cDjg/P/32k3MpL6w1zILPDXXQaDFIzwEpG88f5R0GMhJABsic92XkF8JfX4k3H1AV3kGJx7mPQVhaQIgn+CiAygAUDwtDVpzhH7RP0K7DyQUkGgNQd65XL2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860752; c=relaxed/simple;
	bh=FbFlpvFyvqTX6nYDn08oSgeZjyL/78aPglmTlujFnVA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qq1qhhqAc19mTNEFaFVSpWkPJ9X0G5h/OMmDagMYw6ImyuQUb6cQPXfjuJEXdpQy/BsqWb03N8RqziOeQmv1h0+9a7YFwRjCp1t1Yy3aSIEl6FoExgaClkjDEonybpgIHY4kaMs0TwH04YuASkaFe6pia4ji9yGCRCv0E9gyvrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kbOFbaP7; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kbOFbaP7"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id EBEF324000A
	for <xenomai@lists.linux.dev>; Mon,  5 Aug 2024 12:25:41 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on20625.outbound.protection.outlook.com [IPv6:2a01:111:f403:260c::625])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 04F5274003D
	for <xenomai@xenomai.org>; Mon,  5 Aug 2024 12:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYfPbH8nowsNNRE1tUn4r20l44ngP8IAW/kf/2YSW8Uj1qaRotQH7fe/bEE0JYYjBoVARgUijwej521pOdVpt2L7nwAXcHz9RJjwveJwQje5WWD5gg6+rRLjBYb81wkA6GyLXnMGyP/pjiU9QhXJNzA6J1Y12P51wRCFhotnYlnG3XUb/5hwHIOaDWZicqsd/NoU87wIbpJ4AU+PhEi1jihRIcMYCulEYfe2CsapQtmU4ZnSEC6SLwzbBzx82tCn2ulj+oSm1hYuj6pcIFSFuY8AGtWHnwCwApKgjOe/EK/bWhlgD5pgLtIKds3ELtRq4GimXq6ybkHdlFV5pcs4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YWlBtJqTqt+NgP1wivnwBkSQS+RnMEjvkndKhE0tEU=;
 b=yeOXpvBVUpoeJuX22bRAiJnsE91w4LtxVqKIOLi5W4jbaXcW4WecKzJ1AsAhNpeONzMT2kncGMyyHbDD3BHV1ePdk3ft+dXTp+8+7ePcT0LVxIfD5nYP7GKm3HKTBw3m9BVPosfIvoODpRtxQ5BN4qlmKfX4U2oWedFZcZrx8fFphNNtFKWxW5NN3F+v0OMDE2111l/KBbSzdbiEtaEjMTHxNc345z2IPOlxAxpm/Kj2Uct0kcnsC1Tek669aZqQsENa606bd72623e9OZII9pUqlI+Q3zvDmtF2pNWjUJIeQUvQvgWkNhcxpNj0xaimOMQZ2riiZySsI9sdDvwNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YWlBtJqTqt+NgP1wivnwBkSQS+RnMEjvkndKhE0tEU=;
 b=kbOFbaP7lRa+dGl6/DmYxzDgZs5ZK6B4RJgVyCotqzXryNktuWGpLLPZSGky4/EeLVrD67BaJfHKmCDl50jN+k6yx0b7rn5Q6ogm8BGeY+WXngYAaqEWcZ66LbkikOZ9/H0tHZ641yYXXuqacVmF+ioP+qePhkuT8WmMx+4AogqwQWd6zfZubwFg6J6GW4b3Lk3DQFzhMNW3o2cLKKFZ1Wb6VRRSZIKJfGJzaA2d35eizLBouwQLcdis4HOsSecU0kaIm4GiErPJJwHqy6uEGpudJFOaeJwmpC2mVNHXlpT+UV9UIYJd0TVGOcCAl46L/ahbmulRmsUZQBT2fa7xkQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:25:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:25:39 +0000
Message-ID: <517f6696-a485-4bc2-9db5-6f2b3daa3f32@siemens.com>
Date: Mon, 5 Aug 2024 14:25:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] kernel/drivers/net/stack/packet/af_packet.c: 32-bit
 compat support
To: kon <ksmola51@gmail.com>, xenomai@xenomai.org
References: <20240725235347.115933-1-ksmola51@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240725235347.115933-1-ksmola51@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a743fe-5750-4b8f-e1b6-08dcb549b747
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXJoaWQ3Wmo5QUNOOEhxZ1Z1NklZcnNob0JISDZBSE12SmJHRFpGdzVqZzBE?=
 =?utf-8?B?Sm9zbndOTnBYYU12NUtJUTUxL3BPMENYblhpRzY0cFVEUFFtNjJwYnJmeG1k?=
 =?utf-8?B?OFBJdjVWWkNQQTM4S0QxRGdlUW9LQXVIK1NFaFo4alRpeWk2azNZRDNrdU5w?=
 =?utf-8?B?T0FmZWZNMk9zTnQ3RWo0Y3hIOHJmMTk0YUt6QVhRbDU1ZHJ3L0R4ck9USE1N?=
 =?utf-8?B?aUdUVjk5eG9oa0F2SHNpcGNBSGVpM0RHZGRFNUpRQTcrQ0xXT211UWIvNjg3?=
 =?utf-8?B?U1Uya2Z5NXZMMVpqU1pRclFQNzA4MFZLUEYzSFc2cmxWUnNtSE10NnRSOGJm?=
 =?utf-8?B?VStrOU8yTTdiVFhoNUkwb0U0WGx5ejRwejArbm5GMU9EK01oVUdLOFU0Rmhh?=
 =?utf-8?B?OFN5cnpNQ1ZvSzY4MHlCQTB5a1ZWQzBwa1lNWlFMaUFIeHh4L285SmpyV0ZC?=
 =?utf-8?B?MFdpcXBUUlhGcmExL1BFM210bTE0bENOVHM5NzdMcGJUTGJvOGNlUHEzMzB2?=
 =?utf-8?B?L1F5MFpNQXZWOHhKODY4VHUxckJ0QnA0aHowc2FyYTNOQlRXVXVkZ2xlZGZq?=
 =?utf-8?B?eksyU3VHeSsrc0RMUTNHTEkxeHB1dFdadWxPODNKc2RJVzhEUnVYejFBcEtV?=
 =?utf-8?B?Z3dTYlZCQ2llbHplLzdTeHlzUXhIYnlXV1JRZW0rYUZ0bXZoMHdGTkduNEhH?=
 =?utf-8?B?cll4U3c4RUsxWHluMUtqdmxxZlRHZ1lETjkzWGRDZDhNTTE2dC9DaEtCU243?=
 =?utf-8?B?dHhhQTdEc2NzVlkzTVU2Y3U5RVZSTnh5VEk2eThPNUk2aWVyR0E3RnloTnM1?=
 =?utf-8?B?UFBjb0VFYmN1dlg0elRQYU9ia2l0amhoQ3FHYktacDFnTmcwLytLQ1dYRnhq?=
 =?utf-8?B?MkVOSndOdmJHN24vWUJNTWFIbWxUWUFQb3laZjdHMmI2Q0xrTEpHM0tFZXo4?=
 =?utf-8?B?S1YzcktLdmkyVGdRRlFZZ0E3NzNidmZNMERJYzVrUkdvOFhYTmd5Y1p6a2Jv?=
 =?utf-8?B?SEtzQVdaT0p6V1RBS1BlcVNzMHNnaGowV0dHV3h4RlNFdEJNTFJPdFErUlZ3?=
 =?utf-8?B?LzhpV3F0amlDU29CUjR5Sk13c213bGxmNjNPMFlTVXBJenVhS0JQQUs5V3BG?=
 =?utf-8?B?eitPY000QXJqRUI0OUlBRlpqRldxNUdSbUliNXV6TmluQi9CcTVqQytWaTVt?=
 =?utf-8?B?c01JREd6dmRzeTUzWENXL0dTelR6dFhqeFUzWjZDeTREU0J6TTcvWEtZT0VG?=
 =?utf-8?B?ZHpLZENhUWRaWUhuSVJKZTN5bEtXTy96UUJXNkkzQW1lN0V1S2taczNYL2Rq?=
 =?utf-8?B?SGREZHY2ZjJMNHpBNFp1N2RvbVVTZTNUQ1V2cWR0OGZyZFFlSEU3NzJuSnlK?=
 =?utf-8?B?ZlVOS3ZaZTFmY204RGZTZUdNUDZkMElxWVJxaTB4aGRuY3FEQVJTV2lLeVRX?=
 =?utf-8?B?bjVMMkd6Q2hkaFlTdVFRMURQekNhVmtrRWl0ZE4venNUTlRVQ1ZSeE1KdU1N?=
 =?utf-8?B?RzZXRFU4UEFVTmxuR2hQeVBHalRLU25manRnbWFIRWUwb1k4elhzTDMzaHN2?=
 =?utf-8?B?T1A1bi9rbTdQVGpHMjNXNkE2dUkxV2hQUFJrckZUWk5LR2p1bWI5bUUxVXE3?=
 =?utf-8?B?NDNkcEdZaEl0dVNZYXMxalZxZHdPbnVNbmxLNW5yU2plZHRZSGNhenFTTGl1?=
 =?utf-8?B?ZXZ0ekJYcXhsS1N6RldFSHhpdGhpNWpxZ0xBZkZIL0YweFFtcGdyc3VrTGNw?=
 =?utf-8?B?Tk5MMUFzaTdQM1d2ZTRpd21sS2YweWtUNGNuanlJcWYwRlJaNW15cE9KekpX?=
 =?utf-8?B?WlJtTjZXOGlnc0ZVSUhtUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjZXWjcrUVVFb0JSd3BsM0dsdkpMMVFEaXRrZ01MWEVBRmRZT3lreXplSkhs?=
 =?utf-8?B?QURZNDF6bHJkNU0wd1pldGFRSDVoSUlzVm1mZ3g3NVRuYVprNEUwSDFtNzZM?=
 =?utf-8?B?cncyVXFzRUVxcXMrdjY3VjBPbDJ2SnVhT3NtRG9YRFprSkljNHRnQWMxRWky?=
 =?utf-8?B?RWRCYTI5QXV1bVVmb05udmRpcXdiZm9rNVY3cUJNRmpqdnlhYUtSSjhMa2w0?=
 =?utf-8?B?UFVxN2hjVlJ6V3V1RW5KYzhsdzBrZGtEOEl6a3JIcTBaT0xIdnhvNnlEcTNC?=
 =?utf-8?B?TkpnTkhUdGZSeER3cXY1cytRTyt3UzMrNyt1YUZDN0FmQ25IcUhaQ0FBQXVv?=
 =?utf-8?B?ZTM2MUtmRUhYaWRIOXdVTFZWaXBiTEYzL2s3QXlCcmJ4Y0J6NHRmUHhnOWlW?=
 =?utf-8?B?bGNPYUltSnZ1UHVRYXB2dDhwN0lCN21uS0xzRWtmaGhLOGhub202MmhUSmJ5?=
 =?utf-8?B?dEF2Mkk5M0pHd2w4MUlQV1gxcWdlZG9pRmF1QWlsbStpb1dXaytzNHI1TGx4?=
 =?utf-8?B?ZjZmQzdMdnZ1VEM1dzNray9qSUdWNDVwL09ad2JEemhvQlhSL3ZWeityQ1Vn?=
 =?utf-8?B?ZmRqN3NTNVcwRlkwUmhvNXpVTVk5Ukd1MkwxenQ3RWx3b2RkdGlPbGx3RzRr?=
 =?utf-8?B?aEZlNlJ4NElnZjkyeERKTUhyMGJ5a21tL3h2RVdXY0RQeit3bmdtd3RRcVYw?=
 =?utf-8?B?NTNRWjFJQVJhNEFCYnRObENGR3JzNlNRUDVpeEVrcElkZnRtZjdMZlU3aE5N?=
 =?utf-8?B?YVM0Rml0QXBHeVJDU2FRcjB2OG9hK1RtbnZZMmF3NHdEcm5PdXVrd3Zva0dl?=
 =?utf-8?B?YzF1Y1NuNkI4cS9xTFRHamlJcTlaTFZoUzdnTi85cU9VMlJyZjVoODhDYzN1?=
 =?utf-8?B?SE1LS1ZudUlaYjR2YUp3SkE2eUx1WExZVWdxeG9senlSckhKSEttTTkzRTlF?=
 =?utf-8?B?OHNLS3c5aFhSdjFKWGE2ajBqejU5UVZzUFQ5NnkyUlE4WkZsV1hSWGNxMXlK?=
 =?utf-8?B?bmRJblVkcFJqMkJzZlR5T2U4N1dGd0JoMUUxMUlaUWI0UER3ckY3QWprNUcw?=
 =?utf-8?B?NmZCTWVPeC9uMnNHZFEvdE5DbUhrc3FNbW1XTzhwYmRZUjU5NmY3NXVKS21D?=
 =?utf-8?B?TVVQTXVEU21GQ2RxUE1zMjJnWEhieXZQMnVRb0M0UGdraFh0b3lHSEI4alFO?=
 =?utf-8?B?a2QyTmN5VHVYcW55ODdDK0J5ZHZXUWxQSGZ5K1BPRDc4VWN6WkQ4RktXN1ox?=
 =?utf-8?B?aDYyNFp1ZExncVQyajk0Ly9IMHpLNjVXTElmQ1k0emZTa0JLelJ5dEkzQlly?=
 =?utf-8?B?R0VLVy9xYnVMSExQKzFMYm4zNEl1cUlCMnBmS2pOa2YyRUFEbDQvaUdBSG9r?=
 =?utf-8?B?MjMySDlSaHJpdUVaM1F6c0x1bjFxZmwwNUxna1BxNStFTVNQMVFSc3BHYWdy?=
 =?utf-8?B?WmZHZ25KT1JPWkxhbzB3RlVaOHF3SGlLU3B5VVAyR2hqTUFUMVZmamtVeGZa?=
 =?utf-8?B?dzg1ekkzMTFaZWhBYzEyaDZmeG95SGR4cDJROHg4dXpFejVYVytTanRNOUV5?=
 =?utf-8?B?UmZUd2FlUlR5dXpQQmkzdlpiNTdMVGtOU25JWVd3dzRwNFBvU3VpM1liN1d6?=
 =?utf-8?B?VHNiUUdnQ1phdy9NRXdRT0tKRGZaR1dkQ2NvWUtPV0l4TU9FTkY3S29nY0hR?=
 =?utf-8?B?UE9GQTFMZC9qOHJRMzNQQjFaZzhyS1FSeVAxVHJkeFlSei9ZMS94ZzMzRnk4?=
 =?utf-8?B?Y3lUM1kzRVQraDNCaVNWR0hGTU9UNlBZUUpBbldObTNSWkg0UEIrZXg0dFA5?=
 =?utf-8?B?ekRpcmNoYTJRQmRvbVQwS3ozKzRRN0ZKVHRsNWxmVDRBNGxETE5kY3pOWTdL?=
 =?utf-8?B?UEVpVXJEbTNqaU4vaVg5b3hNL2p6YlIrbDl0L3JRakxlVHVGWEtJaHRCQjNt?=
 =?utf-8?B?T090N29uT1J1YU93R0JiM1RlVUFxa2pWWEQxR3RjeVB3dC9Kbno2Vk9qTEZC?=
 =?utf-8?B?RkN6WU5wZzlzc2pTVjFtVW9HMWpDWTdBZGZLOVhTc2FabmMrN3V5bnFEc1FE?=
 =?utf-8?B?NzArNXA2RG5hM0QrUnBpVUYyWmlndTJLUmY5K0JPOWdueW9oMWNqT1VqcmhR?=
 =?utf-8?B?bWx4T2k0VmZlYzA0TFVDWEhTRmhRZnB3cFdWMVB0d3k2SU10TWp3cDNqM3Z0?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a743fe-5750-4b8f-e1b6-08dcb549b747
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:25:39.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjZG407941b1DCRTPzfP7G0HOg8bjdDSdfnV45YqPC8IwnGNERjOzJ0alZ5Q+87pHKlhTbt5yVh1NC77uIYdKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7022
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=kbOFbaP7;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:260c::625) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")

On 26.07.24 01:53, kon wrote:
> From: Konstantin Smola <ksmola51@gmail.com>
> 
> kernel/drivers/net/stack/packet/af_packet.c: 32-bit compat support
> Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
> ---
>  kernel/drivers/net/stack/packet/af_packet.c | 62 +++++++++++++++------
>  1 file changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/net/stack/packet/af_packet.c
> index 6013ff9e7..3ac5f5f13 100644
> --- a/kernel/drivers/net/stack/packet/af_packet.c
> +++ b/kernel/drivers/net/stack/packet/af_packet.c
> @@ -29,6 +29,7 @@
>  #include <rtnet_iovec.h>
>  #include <rtnet_socket.h>
>  #include <stack_mgr.h>
> +#include <rtdm/compat.h>
>  
>  MODULE_LICENSE("GPL");
>  
> @@ -107,10 +108,10 @@ static int rt_packet_bind(struct rtdm_fd *fd, struct rtsocket *sock,
>  	int new_type;
>  	int ret;
>  	rtdm_lockctx_t context;
> -

Please keep a blank line between variables and first instructions.

> +#ifndef CONFIG_XENO_ARCH_SYS3264
>  	if (addrlen < sizeof(struct sockaddr_ll))
>  		return -EINVAL;
> -
> +#endif

Why do you need to comment this out? I would rather expect an adjusted 
size check somewhere, one that takes the compat struct sizes into 
account.

>  	sll = rtnet_get_arg(fd, &_sll, addr, sizeof(_sll));
>  	if (IS_ERR(sll))
>  		return PTR_ERR(sll);
> @@ -266,26 +267,53 @@ static int rt_packet_ioctl(struct rtdm_fd *fd, unsigned int request,
>  	struct _rtdm_setsockaddr_args _setaddr;
>  	const struct _rtdm_getsockaddr_args *getaddr;
>  	struct _rtdm_getsockaddr_args _getaddr;
> -
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +	const struct compat_rtdm_setsockaddr_args *compat_setaddr;
> +	struct compat_rtdm_setsockaddr_args _compat_setaddr;        
> +	const struct compat_rtdm_getsockaddr_args *compat_getaddr;
> +	struct compat_rtdm_getsockaddr_args _compat_getaddr;
> +#endif

Blank line after this block.

>  	/* fast path for common socket IOCTLs */
>  	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
>  		return rt_socket_common_ioctl(fd, request, arg);
>  
>  	switch (request) {
> -	case _RTIOC_BIND:
> -		setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
> -		if (IS_ERR(setaddr))
> -			return PTR_ERR(setaddr);
> -		return rt_packet_bind(fd, sock, setaddr->addr,
> -				      setaddr->addrlen);
> -
> -	case _RTIOC_GETSOCKNAME:
> -		getaddr = rtnet_get_arg(fd, &_getaddr, arg, sizeof(_getaddr));
> -		if (IS_ERR(getaddr))
> -			return PTR_ERR(getaddr);
> -		return rt_packet_getsockname(fd, sock, getaddr->addr,
> -					     getaddr->addrlen);
> -
> +	COMPAT_CASE(_RTIOC_BIND):
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +		if (rtdm_fd_is_compat(fd)) {
> +			compat_setaddr = rtnet_get_arg(fd, &_compat_setaddr, arg, sizeof(_compat_setaddr));

Try to stay around 80 chars where possible, e.g. like this

	compat_setaddr = rtnet_get_arg(fd, &_compat_setaddr,
				       arg, sizeof(_compat_setaddr));

> +			if (IS_ERR(compat_setaddr))
> +				return PTR_ERR(compat_setaddr);
> +			return rt_packet_bind(fd, sock, (const struct sockaddr *)(uintptr_t)compat_setaddr->addr,
> +						compat_setaddr->addrlen);

Let's indent like this:

	return rt_packet_bind(fd, sock,
			      (const struct sockaddr *)(uintptr_t)compat_setaddr->addr,
			      compat_setaddr->addrlen);

> +		} else {

You can avoid the "else" here because you leave the function from the 
compat block in all cases. Means also less indention below...

> +#endif
> +			setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
> +			if (IS_ERR(setaddr))
> +				return PTR_ERR(setaddr);
> +			return rt_packet_bind(fd, sock, setaddr->addr,
> +						setaddr->addrlen);
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +		}
> +#endif

...and less #ifdef.

> +	COMPAT_CASE(_RTIOC_GETSOCKNAME):
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +		if (rtdm_fd_is_compat(fd)) {
> +			compat_getaddr = rtnet_get_arg(fd, &_compat_getaddr, arg, sizeof(_compat_getaddr));
> +			if (IS_ERR(compat_getaddr))
> +				return PTR_ERR(compat_getaddr);
> +			return rt_packet_getsockname(fd, sock, (struct sockaddr *)(uintptr_t)compat_getaddr->addr,
> +						(socklen_t *)(uintptr_t)compat_getaddr->addrlen);
> +		} else {
> +#endif
> +			getaddr = rtnet_get_arg(fd, &_getaddr, arg, sizeof(_getaddr));
> +			if (IS_ERR(getaddr))
> +				return PTR_ERR(getaddr);
> +			return rt_packet_getsockname(fd, sock, getaddr->addr,
> +						getaddr->addrlen);
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +		}
> +#endif
>  	default:
>  		return rt_socket_if_ioctl(fd, request, arg);
>  	}

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

