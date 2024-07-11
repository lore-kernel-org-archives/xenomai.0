Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA53450FA
	for <xenomai@lists.linux.dev>; Thu, 11 Jul 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717866; cv=fail; b=ezZuXdHxKvw11f6A18jPHEsXmuR1TVLZ4xus6Dij0qgc/HaRXn7Ju91ZFRP5FhcPRr4J/ZjVZeEHKCqk3XR8T9FsC130DyREhqc1mqY1Ugss1o1MDuJ6TTrfceeTkPtDuz42MC3lJxI6Aqr4NN+w2pHsS5sFWGoR1N+u0WcjrJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717866; c=relaxed/simple;
	bh=wm8pfTehhfEVyWcuoc16Emi1Cjci9CSCntx6f2K2YeU=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=ciONUxm2R1e/i3I8q1tEVLO7txl48JkKxDr6XNxKbJX7K4+BYG27mjqasn3ODq5qBqvX8KAstFIA5DXtFsSAjUz4HfGOq9rN2NUaY8rI3WoenMW1S+SgOLVikd6pcZSgHVOKzO/OlZNZiPJaI81OlC+veNeXRAja/9Hnt3VuESA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Ku31WkW5; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ku31WkW5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyZgnROZWVm5k1QcZ0vMeGyPVooDZe1i3v+DDO/8Fg/cS6Q4EwKqGK92jAM8vl0q+0A9XmQYGs8knToU91Wf3cJA8fDEVgqXZr99gWpNz5gCauomoK1adKfZWpIHGAwpRiNsQ5xPsiSXU9qrLLSyfGrD6M/93DPl1K0Xqr9jUj8ayZh1g04gJweYEpqN17MQ95y0ymzAskN6cp6oMPBWApZ625LLB1GFYTw1VfTQC6erQzlY2s5lsyRLs5Kox2OqjfYyfaMwst+/MqGOa9aYiSf0ddSk7SMBdE15lsPRJQjSkyr71q4Dj93E7ZMsnMDeNeK87YbfsFOzSrGaAad/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np4Toi/ww79/B9Edbi/EZ1E5nBD472140nZJzQNqauU=;
 b=vyD/sJ9cBPSPVgZZ+UUtPNmtZOBqTgkzYBnYhucgJSIQHADEQx6nlnBmNWMeOZSEVEeclPGTE0g0Sfd754cfaS7nnTn7w2YTHXZaAZkHZHWNjwwbHCW7reS7Lm7PYmxUvF5VxYAAfT19K+UzJppdq7pQkauU84dOqxU0x/k539kj8Ss1zCUTPqDX+PGaWbvJKw0If55lLNZCo6Q9gkKIxAeAWatuyOSlUwQRp/0DsyOQPFCRj4i/ivrlnhHNmKykii671wW05uSLAO8DgmC7orvzI9iO3fDeJClcOF5FXht0nHACzrP1oEkeMPwO0QapoDOLSpplt1HAAZ59ko1SsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np4Toi/ww79/B9Edbi/EZ1E5nBD472140nZJzQNqauU=;
 b=Ku31WkW594MxmPUlOo550UTQcEyi2+x/rWzicRJBZA9y/GSnEdAE0Q1aBnG5dop0xalU7c2g3iqKw2jfAL7RlAgiCG95sArlnRMGQQqEj/oEdC4DoKQsjNYj9tmhpAWaf9A4ffzDJxX/VNFEEgr2Cev4mSEBjibmIRSuE23jBM+90OO9poiJKNYdsKYkxwwTAwYhJqP6uKKG0962R474AKXTG7TXcl+rUmYP3kf1wpFgoSUgYOGVdMm0E5CdaMVPxmPZzahubOL5/DIrgRsMGkNrS/MR4Q1fALHHTfsKAKmSu1IJStURN9XQcKVWgSPtsGGjWgDyJ/4yG5+M1H4IcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 17:10:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 17:10:58 +0000
Message-ID: <dc646d7d-1ab7-48ee-8356-d75908a3e12c@siemens.com>
Date: Thu, 11 Jul 2024 19:10:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.2.5 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:610:38::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: e21ae00d-1333-42c6-5fff-08dca1cc6e7b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVE1cHcwMWhmWXp2UFM2MmxzYzc3ZkhHTlhFUXlMMWQ0U1ZuUUFaa1FnRTZF?=
 =?utf-8?B?WlY5eFlXbUkvek5GOVppMGM2YjFhV2hwY3V4amQ3RkhmWnhBU0NUM2ozSmE4?=
 =?utf-8?B?WjhUcGVSU1dTbHl0QVVLK29yYmdFUWcxaVRpdDdhWEZjQ2FMeWkvUitYMGpB?=
 =?utf-8?B?K1lFUXlXVmEzZkJycCsyM2ZLNDNwQUJkL2F4K1d1L2ROMUlRbXpENzJOVEFo?=
 =?utf-8?B?Q1VjejdqK0psWmUwUUNsWmNKQmpkYVFsZWIxUWVUSFplbUc2dk00WUVrMGVs?=
 =?utf-8?B?aEo3SEdacXErdzkzeHd0dHFzMnRwOVRRclpQUVRXOWluSE5tZ0hiYUh1OWc5?=
 =?utf-8?B?elgvUDc0WlpOTTJtcGhYQURORU5NWEdDS2M2TFJQaUxDV1doN1UrTGRxR0cv?=
 =?utf-8?B?SnVqWlRaNU5XcWFLUWttUWd1M1lCNmVMMXBieUJwRUF4dGVua3k2TlRPd2hp?=
 =?utf-8?B?Z3dES2RITHVvQ04wdGVJWmZYQmdwZHVOV1lyUzZ0d1hSdWtBaTg2eDdieTNH?=
 =?utf-8?B?WGJsZlo5dCtLRzlFUUNHQzhWVW9uTmdDbElGaWlFRHNqZXlVeG1JbFk4czYz?=
 =?utf-8?B?NXFrZUxrb3NMNnd6ZFplbmpMbk9CWXU5UXV1T0hnVkxUWXcvVEZKd3FNUnhi?=
 =?utf-8?B?RkdPdjlnTUV5RkRtUmljSEl5WW1DRmtOQk4yNmR3ZEFFMXRrdEsvSUR5WEgr?=
 =?utf-8?B?ZFhmQXJ0K1VBc0Z4OVhsQlJBREpuRCtMQ3VtVE8za1JETXB1Tjd4WVFHOEsv?=
 =?utf-8?B?SzBwOTVXWHpzZzVKaXRGSk1qUWNUbzFGRi9na2dXcGJFRkxSUmQ3T2hvSW9a?=
 =?utf-8?B?VmpQbFJJRllac1dzazJCbUdBeWZoWmxMSlBsTmtpdThFZWhURldsaFA3Zmg0?=
 =?utf-8?B?UE5VbU0rL1JaclZRUlMrbVhvSDBwQ1lKZ0pvbFJicE9KV2M5NW5kU1lCN01S?=
 =?utf-8?B?aWlrMk9HcWpjcC80cFc2RE5NYzg4dmt4ZnlJNGVjOWhOWkRCUG4xNVpxNWRW?=
 =?utf-8?B?SGVwWkpNcnhheGtUWStLUGt6emFmbGp5N3loS25GY3VUY1p0RjlHRVNiT2Z3?=
 =?utf-8?B?Mzh2djM5cGU4T1N4TFYzMms0YlR0aTZ0dFdvb0ZXaDB3T2ZONWJCWTRyOGEz?=
 =?utf-8?B?OTIvbEI1ME1FZnRUVzcvNXlXMElmKzEvMWs0L3ZUM3BteUdyMHNNUXhjUkRT?=
 =?utf-8?B?ZnU0cStRSlViNlJJb1RZeTd4Ymt0N0E5Qnl5Smp4d1ppYnQvM3oxYzI2M29T?=
 =?utf-8?B?Und3NEt5SVJwZkR6czk2ejgrV0w2QVVQNTRBd0tkaXhqOWRVSzdRVHpCVGpm?=
 =?utf-8?B?NVdkOTBmWE5GaHFEZkVQOTBDbGNRZGVrMFg1eHhUQlRtL0ZRTmNER1NZUit5?=
 =?utf-8?B?MFFWKzB1c0FKWG05NkEwb0gveG9rRVgrTnhWK0RRQnU3Nkd6cUlRZGY1eHpB?=
 =?utf-8?B?WHlOREsxNGpTRFhmSnhvZm15VXBQVHh4NTBrWHNLN2RzSDJTZUczMkVRRU1W?=
 =?utf-8?B?MUlQUHZLeUlWdGpyRU1IYm9DZUJXVGpkd1lOdm9Eb0k1QmRTYjBIbG5janJ2?=
 =?utf-8?B?RXhtTzZWNkhIcDFGMGdVcVkrQWNZaHVGZERtZnFwWHk2RXQwdmdtbEVnZ1pQ?=
 =?utf-8?B?UmdWWHNNdlZidldjL3pLMllVeXdYT2hVKzFEY2ZnRS9sVmxldHFzOVVxWk9u?=
 =?utf-8?B?S0V2cXpDTUJIWk9DamoxQU1WSXMrQ09iRFJ5aGNRZER2Y0llVUZTc3lUZWIy?=
 =?utf-8?Q?4LAgryv7k3tyAu5qjY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlduNWhjZGtmdVZ4S3hIVUNLUVdqdnFWZWo5cnBsa2V4UWszbldxbUpteFhZ?=
 =?utf-8?B?YkNEWS9aVFNTc2IyQXZTcjc0bTYrL1I0dlNWQXFvQVlmSktQRzFpWUtMaFdQ?=
 =?utf-8?B?U2lMcjIyaWpub2NQYnpYZ2JzYXBSTG43ejJvNlNLdFdFdG53QkZVRzhpY2lS?=
 =?utf-8?B?OXo0Q1FTK3VNMnp0ZWdCMDBlbTlIQnRSRVZ6Tkc1a29JNmM3SnladWF3QThU?=
 =?utf-8?B?aGs1cjQ1UXlSU2Jrc3EvSXZFWENpNTVtcXVXcUYybVFkZi8zeU52M1VGMVZ0?=
 =?utf-8?B?dTNWd0M1L3RROFpCaFlXYmM4ZGVyU09uWGsxR1V6VmE4UVVjR2Z3NXRDNUtz?=
 =?utf-8?B?SlY3ZUEwckN6dm5FNmF4ejhBRkhmR1RqT0JuOEZpYXZGVGg1VVRYZFYySmZo?=
 =?utf-8?B?RlJXL21VMnV6cWpXaFM2RzNWaGlJUTZCR0lsWTNlbHpsaitnR2NLZHZUQWhB?=
 =?utf-8?B?NFQ4V3gxNWVsSXBlZEVnQ0lCTEttbVY0VnFkUEV2OGNpNERtOWwySmZMR0Zn?=
 =?utf-8?B?b0lDQkxNeWxSNTVTK3ZWSjRQQjAybDVPeWVHT0NCNzk3MDgzendtdS9ueGRu?=
 =?utf-8?B?eFNITHc2aUVadEpQWkhVOWh1YXlnWnpCNGJ1dDNhQ2VibEVzZUdiMHZXc3NJ?=
 =?utf-8?B?ZkpvVCtXZ0hUbWhkVFVyMG1QekxpRXdOdVJOM3JCNng5TS9YczlKc2tJQUhF?=
 =?utf-8?B?UW1EQlExdDU4SWw5UDB0SlVpemsvVDlCQnBGVGpsdXdtRmdMUlYvcWNZaDF5?=
 =?utf-8?B?TUJQdlJsMDl2UXBVYWxEVytLMDRJNGFTRkZGdE05SjBKSjBaeFlJOVZrdUdu?=
 =?utf-8?B?TTU0QytqdVp2Yjc4a2tmVTVwbXdqYzlMVHJLRVNubDFQeWNWQyszbEt2Mzl6?=
 =?utf-8?B?YlBBeklPaUV3ZHFBK3huY2Z5R3pPM2dPQUVVb21PblU1ODhnYzNRbVdCZGpz?=
 =?utf-8?B?ZkFTYzkwcWoyNVk0TTJlMUo4OEVibmFNWElPbjZ2Nk9KbXo3NmI2VUZKRUZL?=
 =?utf-8?B?Z3lrSS9FdDB1alQwK0RZYkhwNEpLRUl4eU5FY3JaQXJMb1hLWTNHaXJCOHRK?=
 =?utf-8?B?bDUybnQ2YjFvNmMyTmtNSUE1NGZtNWJhbHRkNGsvSEllbFNaZXJRQkRmWnVp?=
 =?utf-8?B?LzJubHArRGw4dkdsNENKM1ZEOElFdEdpdzd3YmU1RVBFeVlyZmd1Z1o2Ry9v?=
 =?utf-8?B?UmJvNmNsYXRENWR6N2U0WDYvcmxWT1Q2UWxnbUJCWEFEWHdrb3ZnVzJpc2VF?=
 =?utf-8?B?NHFJTXRjUjVZclUrcURXVGhpTTZzR1AyV3AxN3pRS2hzTytwSXpkS0ZUWVJz?=
 =?utf-8?B?TWtLNFJ5emt5VUNvak9hRUVnbWRJN0tnUG41MDN3NHF4aWY2UzVHZnk1K2pK?=
 =?utf-8?B?eUVCMUgzSDB3dys4U2FmWXZGZlJBNnNwSGFRaXViYWQxWldsZERKby9EK242?=
 =?utf-8?B?OERyeUFoMmp3dGFqT2xyMzlxdENBYW5oMjI0aWU4R29IYk95T3hmOThRaTBj?=
 =?utf-8?B?TUc1S3NvWHgyTHFQcGFFaXNhOXNPYzZYT0tlUk0yVm1tdmdOU1o0WnlNRUpJ?=
 =?utf-8?B?V0puOGZ4cmFjVmdVMVlUNG52b1BCNStYbGtGUU0rNU1XMWJCSmdhZ1JNZ0NC?=
 =?utf-8?B?UkZxUlBlNHdMMVh0V2pZdDFOMkN6L2FJdmlvYWVMWDNNZldSK3NITGwyRk1K?=
 =?utf-8?B?ME1QRW9wRWxkS21XL0YyTUhsZVk3dHVLeW1JNnFlY2t1aktyZ0pKR0JBdjVr?=
 =?utf-8?B?NVcyR1JPLzlvVkdkRWNQc1l1MnFhME5yTXJqTXNuVVl0RDlhY1d3QUt6cWZL?=
 =?utf-8?B?M203Qk9HUXFaclRWNDVrQ3MySkhqajJPaitYbFNBZ3JQY1QzWUJEOGJiK1pX?=
 =?utf-8?B?YmlHV2dyTktOZmZCZEV2VjV6dk8raXZPS2Y1eGtaV1N2RjhQckREbHAwVnAz?=
 =?utf-8?B?aFVNdUNyWWVCMm9SbGU2YUlib0cvbkVtNk1EVTR3bUtlUG9DT0Q2TldTTGlT?=
 =?utf-8?B?cDBnWDlOR0pNWUpJLytpdmdOYWdBMERieG1aU0ZSMFRwV0tSWDJvRDVqRUlh?=
 =?utf-8?B?SG5ldWJBelNDa0liajVHMVNXbzVFNXJNMGhTR0pUMEw4L0w2WXorTXZwNnBT?=
 =?utf-8?B?TUt3eHVkY3Nac2dGSE1ZL1lSbFllWVBLRGoyWVNPb2p0dGhXRWVsZzl0ZDJ2?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21ae00d-1333-42c6-5fff-08dca1cc6e7b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 17:10:58.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRbyRIQDWW1Ergku2rUFEs/RyRWx1RmQMh6OzkyK+W30kwv8xpY5WGhQ0o9OMCYOXUV0aaOKTUEUvTVdZzyPiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8378

A small but important update for the 3.2 series: This fixes building 
against latest stable kernels, 4.19, 5,10 and 6.1.

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.2.5/xenomai-v3.2.5.tar.bz2

Changes since 3.2.4:

Fabian Scheler (1):
      testsuite/smokey/gdb: Fix race-condition

Jan Kiszka (6):
      ci: Do not run CI for tags
      Make uncapped kernel SUBLEVEL available to wrappers
      Fix detection of dev_addr_set availability on 4.19 kernels
      cobalt/posix/timer: Rename timer_* functions
      Account for close_fd renaming backport to 5.10.220
      config: Bump version number

Richard Weinberger (1):
      cobalt/drvlib: Prefault io memory again

Jan

-- 
Siemens AG, Technology
Linux Expert Center
