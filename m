Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2941A13BADF
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345552; cv=fail; b=l5u9k+yqUdJUH6j7rke/Kc444bZTiqEdbLsGDHVXY5tCU9gTzMC9Ki93kWzh5NUJNf3ITHBH0fipytOR7hQr6kO/dbv6+F8B4J0Kd3DekMGA+PpdJeU552CaS161iqLL4w/mbSVM+78nLuH+2aO5yi1wIkRpuW6am+ThWMpOjTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345552; c=relaxed/simple;
	bh=YPXqQi3pwigEWbBAw9B5QmYNGsXvK0GdURGpPqowJ0s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rP4DcFbM4+kKjoUGoLXHAkpgk09UV7TH5V5snS3ogthsT+CDc3o6H7JrMJq88ThBgvPjVnOYwSLxNsWWP8O3xBXJjcGRSOax5M/SDrioTCVnVWzXn/mkOpBDgykf5SuojN+pgSZ3LYO1ctvdajp2R/Cf8FOmJj3f7rCwnF7Oa54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yikFuewU; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yikFuewU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voCaSKTFRfHFbJ/f8WcUTRJuEQwSWAI5pmQJTbZABy1Lsfh7qFAl8c83okddJS6DkFMpIcoHD1+QhsXoAVvAThq6BL1hNZOur0+pGMDrPbJ06sXnEo+KVAAi9vrHrI3R/vBy0Np3/3Y37xywahcwkj6UnMtLKqtmLtNY0RLSufcjXvKwmxxB4loXJtpfd6W/n1Gi8rvvAGDVf1TqCJ7QHnRFce5J4Ai4o6rmXayoFo24FdAGrPcnlE6Pt+5c0eUyJiTXaywvlqby3jCgd0oPyrCv42zP1u1iHnZct4l0nzi3r6OijyIGwF32FhWXN9GXJ2t0Lc8OiNlNIrYYDyWRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgqkySy5Yh9YsNxZu6CnEdA0bdQ1EQgUBvG+cac7xC4=;
 b=vRNe9xX8/Ppct9SGa/OzzekH0wN5lNXAx7TPeyljl6LjgReEN+4WukSvFSt68Tos4LkRVhsyYBBqbPIYbpiiZgE3m7poZVAAHGTCVgs34pKEdjq6iq55HS1FzLfZ1XwL4/+Q3auH9ArdBIxzydbAZPZ+0ynnYmxXn7yUphh0Px+AxeqQm6jOtzIPgACSVZeVRBc48oUYAILzQJQsLCDEJ2OhQBsG0XVsvc1RrOFnrhAn3hTlDv43rhGOOIRbqoQk4QcVBnuZ8MxpqKWGgTeyJ0YsMsMeQXY5bMgv+ODnE/buSJxreJ+9rdVok5NIsj0WVtHbTWR3poyZ1ERi+9dtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgqkySy5Yh9YsNxZu6CnEdA0bdQ1EQgUBvG+cac7xC4=;
 b=yikFuewUUhBLSI6ijbGXvyIYG017ee6SzGnN1u2LqkVrNFUUDch2C9xTLpk3rF4jkgX1kjDdQJZpBpfQBgntovqu7emEu7vsQG7gEOcCkjH0gnMGiZeE/SSOlUhsU6MGSdYTUOm3l4wKkYzfPR6jnOOu01dozedgpzTwPoNUHuk1+G0Wi2SkQFYLUv28SkFTeLgAWQFtmTIpWYGsS3Urxn5Hh/9EI3EbK3C80akaYwtsHCPFI/N5gPsdKonoOybXBLaqpu891RCS43M5cG8A5DsCjS2P4stG8lrNbhOjFQ7331p3a5FvGL+9eGvPFr65YjiNeRL9EBs3UefyglAOyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB9135.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 14:12:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 14:12:27 +0000
Message-ID: <c286a8a7-a2f0-4d50-9cf9-66a3779001e4@siemens.com>
Date: Wed, 8 Jan 2025 15:12:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Register corruption in syscalls on Dovetail > 6.10
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <9b141179a28d93ce9dfd3d1c560054efc5170a29.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <9b141179a28d93ce9dfd3d1c560054efc5170a29.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5d927d-1dc6-4644-0f77-08dd2fee7b1f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEd2b2JDSS9ZSHc5OVBvZ1BXa0dTVHBhcEdDRjhHaXF6bTN1Tk03eWcrTDBR?=
 =?utf-8?B?UVBER2tzVTJQbnl3RTlSemwyR3NpTFhzNnMwY2p4VHYxQUVxVmVrWFBSZzlU?=
 =?utf-8?B?M245em1RN2dZZ3Ewb2JrbnJhZ2J5RlY5VnlzNGFoVGk5dHV6Vm1HVlVoZXpt?=
 =?utf-8?B?TTczTTlIQXNEQ1FwTDY5c3hGOStxOGJSamo5aXNXT3ZTVGpkU3k4dlpESFlI?=
 =?utf-8?B?eEluSE9XU2FoWk5OMEdMNzkyTnNxalZoRXErVUNNN2hYRWtWRXVyZkttMkFk?=
 =?utf-8?B?UU9Cd3pxcTlSMWdScGVjU1hEcWFKZUxDVWpQWVNwVWdjWVcrZUJTM2E0M00w?=
 =?utf-8?B?NWQ4SkZJbkpDd0FlUlBHMGtDU2pkdDgvM1lIcW44NFcwU280RkZVV1g1MDNm?=
 =?utf-8?B?dmlpazYzektRSWdTdW14dEhLcGgvelFkN2xURzhlNm1jcms2YmVDZlpHVTEx?=
 =?utf-8?B?Wno2Ym5LSUhGaWRtNTVXL2pZS2VxVEVTclNTQnJzakV2TkIrTnRTOTJvZFZt?=
 =?utf-8?B?RDRyRENVNndYUklMZnZDSWlMOXB3dENieEp4Rm9sSWkzOFlZNnEzQUNpSXY1?=
 =?utf-8?B?clBNQXJYT1VqWThtS0VtRXZUbWZhTVJSR2gvZm1hc3JnZjU4S2JOekcrTEVL?=
 =?utf-8?B?S2pPMHByY0NjekN3MG1CWmZpT0pKZkJ0NnhIaDdPL0o1by9BYUxJVmZaWEpH?=
 =?utf-8?B?M0xJQzE3dXIxMWlEZTNsdnp6aXZMeXNnT2dKRzZRWW1taldwc3FJM0dpcGhF?=
 =?utf-8?B?ZGRPNWpXelpqVWIrejgzMDlNMlRCWFFYNVhUdHhmOWFoTStnRlcwZFJibUNk?=
 =?utf-8?B?MXJpU1I3UWZiTHdrNVdSVnJITkRQLytGTXQzRXJmNmFOaUJ3aFRFbmlXUVhk?=
 =?utf-8?B?b2VmUjBBWTRDQmx0UXZ3ZVRxbXdnODUxRWhMbEJmNmJQajFrMjJzSTB1RGhX?=
 =?utf-8?B?REg3UFFSWUd2K3B6RWt5NEdJUmdEUWczT1M3QW13UlIrckdOOXdaakF3dHF0?=
 =?utf-8?B?eFl6SEp3djVFTFFxaU9Sc095SXVJYlRJY0JZNjlhOFBrVDdGajBuaHdiajF0?=
 =?utf-8?B?Y0lzYmx1YkVGL00rR0ZLT255ai9DQWlLTGd6bVRzNFBnRmVzU3p3c3Y1UFFk?=
 =?utf-8?B?WFl6b2Q4THhMbGRWai9lU0lLYVBSUnpzVTc3UkgvSklhS0RWOS9mUlVPZUU4?=
 =?utf-8?B?OWlBeVYraGNadEtKVUJSQXE2VVdSK3l1TzlQR0dESWllT3poYVRCN0RleFNz?=
 =?utf-8?B?cGoyT3NLYnBmUFQvdGR0TWZGYldOY0pnTml3ZFowUmRMZXlNOVNQU3piNG56?=
 =?utf-8?B?NXBudzQyTDZnSTF4NFhwMDFtN3Bzd2pCWDZvd1BzTzVzYXU5V2xFSjBjenQx?=
 =?utf-8?B?ZWo0WnhvNDhsMklHdS9XK2o2YlZ0ZDgrSlJxbnhEdVo3NEdDcXVKUlY3V1pF?=
 =?utf-8?B?NlEzUDFKcDNJNlQ2eDNYMm1QRVdaNkZLRmVUQnFvMmZ3WDZVNnJZSC8ycEkv?=
 =?utf-8?B?RXBzNDJ3aDhhWmJtaXVPZDg1MjVWWkxZbzBnUDhDVkdpMW5tNnVRbThmS3RP?=
 =?utf-8?B?cjZFbUQ4NmtxZ2dJV1ZJUVZndHJSWWlRUVZibDB4RmlxV2RxNVJ5aVJmSUVh?=
 =?utf-8?B?VVZTWFJuU2JSTGFJdk1Wc01ZTVZMYUFkcjlULytTb1JkMUhmTXZPeHllYm1w?=
 =?utf-8?B?UWlHMFJKZWxtM0RsWlc4QXhEVkd0UkdWMmJSUTNRc29LeGI2WFJnSTJicTNU?=
 =?utf-8?B?WEdWT3ByMjJuTFI0MVZhQXdjSWYyaUQwYmJncUZCRjljRW1vYUJXOWg3dmVW?=
 =?utf-8?B?M3ZJZmRHWmE4Ujk3Si8wUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjBDWlFYOTNhN2NZd2VYTDlYV3dtNGljUWpiTjdpWmNDeE8yU3NJaFNJL2Z4?=
 =?utf-8?B?WG5XUkVibEs1ay9hcDhGRjZldzVWRzc1cyt6aS8vQ0xxbWtsOU83clEvY2dE?=
 =?utf-8?B?bDZRditzc0g4aldVanBNakRmWExOSnB6bnVBSzYxSkxnbFd3YWVhMVNNVTZL?=
 =?utf-8?B?VzRzQjVRMWNPUEt4OUdyVXhyVncyQ3NWQWlWMFNHWTNqTlNRQ2ZiZE1hdjJa?=
 =?utf-8?B?a0xKNVFJVGdxSkJZOENUUi9zeXUwRnkwc2dmSy9WSnVUeVM4aE1CTDhCbjA4?=
 =?utf-8?B?TG40SGE2akwxNi9hWDdRZWRpaklERkV3UVBHbXZWbTJsTDZ0YnA3UGlSb3lD?=
 =?utf-8?B?bHU4UVZSSExYYThZaXo1Y1pTM1NyOGo5aFBXb1F2azdCa3dvTjBOUmFOeWtq?=
 =?utf-8?B?Zk1HUFpBOFdocUVCOFI2bSswWmlzRE5LZnE2S1MzS3dld3I2UnBHL0h0Y1lL?=
 =?utf-8?B?c0hCUm5HeUVuZC9FbU5CUkQvLzQ2SmpkVmVCWTB5VUhaK0w1NzFqZFdqSTM5?=
 =?utf-8?B?aTJDWFpOSUVycW94ZkRBZUYzdGJZM2hGMTlkMXZSVDhzSnJrSmp0b3B0TXpw?=
 =?utf-8?B?NW0zc0JrUWZiUGVLVXFtM25obVdpVDVJL1ZiQmdUbnB1MnlmdnI3UFpkNzNP?=
 =?utf-8?B?VmFlUWZ2Y0dmaHJMcEt0bkxReG8wTkVtcVhSbHlFekRsQzhsL0JvTFdsUkNp?=
 =?utf-8?B?TEtRZnY0SEowVFVpc2x0dzhmU2tEeWUyMU81dDVWRjZRRjhERjE2WDVEWVpE?=
 =?utf-8?B?TjZyV1R3VHVoTW5IWmQya1RVRnFOVjgxN1lJb3U1VUNwNkpoalVYNDA4eUhU?=
 =?utf-8?B?ZHZOU2JzZmczVHZhQVJGSDY0aCtEcEtRRXRVNXBQWWdNcC90ZGdFU05OTXNP?=
 =?utf-8?B?V1QxcGVsL1JOdDdaYUE5WFRUdngxNlFxZDN6N3M2MzJBR3lsQm4rQkFmRnhn?=
 =?utf-8?B?MklrSHB5aThUcGRDWExyNGs4SFk5UFpSUGFqU3l2WGtaSm9tOWhkc2JxeHg3?=
 =?utf-8?B?YmFVOHJvK3o1T0Y2YjVWbEcyZ1BuZkJJR2FWL09xdndlYXIxOUJZd0FVTWhG?=
 =?utf-8?B?aTZSaEljTk1ESEdpL0w0WVloMTlKUkhiV3dINWdzNkF6eGNjNXNjazFkeUFU?=
 =?utf-8?B?Nzc3MHBnV3dweVNXTGNVRlJ2OExOS1BaVGZzNzJ4dU5JUEpFbWdQQVE5QXBR?=
 =?utf-8?B?azU3Tm92RjNjMzRVYlNxK2ZwZmZ1YzRTdTAvVnZqMnVrM1FCbzloTHBsd2dK?=
 =?utf-8?B?TnUraGNiWHR5bGZFMk44YjFMY25BQ3hXTFJKdDlnaGg5WDBEdzZSODloaFFP?=
 =?utf-8?B?WTFja3pXancrbFFyVHRBTDgvZkc3TTY1T0xPVU1OQW41cVpyeFdmL05neGVk?=
 =?utf-8?B?VFlUdXYrWFA5NmU4ZEEyaytUKzRTeWRWSEhCZ3N0ODRaV3EzYmJaT2txVVlF?=
 =?utf-8?B?TUY1dTJNOUoxdHR3SnA1cHBVRWthZ2V4b2poemZKU0JYT0puVks5Rkg1TWtM?=
 =?utf-8?B?Y0JoZi9vVG5ROFQ0eUJxSzVKREVIUDk0N1dyTjNpMlgwRC9uenNFbnFxbjdz?=
 =?utf-8?B?RUplNGw0dUZEbDFFT29VSFNMc2lDSVBEZXlaU2orWHpOS3FqenhRTUdUend2?=
 =?utf-8?B?ZG5KKzR0bFE5VHFWVk5aZ1E1azA5STRGMFJoM24zcnhmS3dUZ1dSdHBkS1hl?=
 =?utf-8?B?UjdxNXFjQkk1dUJmN1FWSi9CdFlTOUZINkRYU09xR3VwVWc3MkhZOFYvYWVG?=
 =?utf-8?B?NjhpcEREMjYzTnFGVnBkRGk2TDlLQUZWZVR0SXZLRHBIZG9GZStqczlaaDB2?=
 =?utf-8?B?SEpMKzRJbXlqZldRTTBDeWNVRTBHcWhqNnc4Y1F0M3dRVVZ4UkdrVHJHYWdt?=
 =?utf-8?B?cUtJZDRsOVFyaGVON2ZPakQ3VlFZMWt5M1EyTUNXY3Myd0tyYzFNWjJlZDZT?=
 =?utf-8?B?SjZTbXUrYks1cG9UR0FsYmdxdEZzRzhHKzFQeTY4ZndPeVI3THZ6SVczT0FB?=
 =?utf-8?B?Q09oNG9peXUrTVcwOHJXOVhqUTVCb1JCd3lKdk5DL0M2RUNHRUFROWJUTGlS?=
 =?utf-8?B?Y2YraHdqY0VrWXhYa0dsQXcrYnFwdFBPVlpVNHBDVFFQVDBlMG5xU2p3WmRV?=
 =?utf-8?B?RmxuTkd4aXBvK1JWZ25MOHovOVFQZUtFVUVQWk5hdldlWUZrdEQ1Vkh3aHRX?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5d927d-1dc6-4644-0f77-08dd2fee7b1f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:12:27.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDPoArAAhuK2N5PE1BUAKTBx6hrULkSE4GpgIaVvd6BFwCl7QvtBPU+uiVe1BJTKBYaqE7DA8ThQiBhQ4mDi5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9135

On 08.01.25 14:46, Florian Bezdeka wrote:
> Hi all,
> 
> while doing the dovetail forward porting to 6.13 we detected an issue
> within the cobalt core.
> 
> CI jobs fail/crash while trying to execute the smokey testsuite.
> Philippe and I were able to reproduce locally. Here is a summary what
> we found out so far. The issue is not completely understood yet.
> 
> The smokey test suite - especially the y2038 tests - are triggering
> several (page) faults. One of them triggers the following kernel splat.
> The complete test log can be found at [1].
> 
> [  265.656410] Unable to handle kernel paging request at virtual address ffff0000404666c8
> [  265.656463] Mem abort info:
> [  265.656475]   ESR = 0x0000000096000005
> [  265.656529]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  265.656554]   SET = 0, FnV = 0
> [  265.656571]   EA = 0, S1PTW = 0
> [  265.656591]   FSC = 0x05: level 1 translation fault
> [  265.656619] Data abort info:
> [  265.656635]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [  265.656652]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  265.656669]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  265.656735] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000004196d000
> [  265.656764] [ffff0000404666c8] pgd=180000007ffff003, p4d=180000007ffff003, pud=0000000000000000
> [  265.657948] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> [  265.658304] Modules linked in: crct10dif_ce cfg80211 rfkill fuse drm drm_panel_orientation_quirks ip_tables x_tables ipv6 [last unloaded: xeno_rtdmtest]
> [  265.658970] CPU: 0 UID: 0 PID: 1610 Comm: smokey Not tainted 6.12.0 #1
> [  265.659072] Hardware name: linux,dummy-virt (DT)
> [  265.659213] IRQ stage: Linux
> [  265.659437] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  265.659529] pc : __pipeline_syscall+0xf0/0x23c
> [  265.659574] lr : __pipeline_syscall+0xc8/0x23c
> [  265.659608] sp : ffff800082e93d90
> [  265.659629] x29: ffff800082e93d90 x28: 0000000000000000 x27: ffff800081fedf08
> [  265.659715] x26: ffff800081574598 x25: ffff8000820066b8 x24: 0000000000000001
> [  265.659741] x23: ffff800081fedf08 x22: 0000000000000018 x21: ffff800082e93eb0
> [  265.659767] x20: ffff8000819364d0 x19: ffff00003fd964d0 x18: 0000000000000000
> [  265.659791] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [  265.659823] x14: ffff000004942e00 x13: 0000000000000000 x12: 0000000000000001
> [  265.659846] x11: ffff800082d13c08 x10: 0000000000000a70 x9 : ffff800082e93be0
> [  265.659870] x8 : ffff00000766f0d0 x7 : ffff800082006000 x6 : 0000000000000000
> [  265.659912] x5 : 0000000000000000 x4 : ffff800082e93d90 x3 : 0000000000000000
> [  265.659944] x2 : ffff0000404666b8 x1 : ffff00000766e600 x0 : ffff7fffbe460000
> [  265.660114] Call trace:
> [  265.660289]  __pipeline_syscall+0xf0/0x23c
> [  265.660485]  pipeline_syscall+0x60/0xcc
> [  265.660566]  el0_svc_common.constprop.0+0x44/0x118
> [  265.660598]  do_el0_svc+0x1c/0x28
> [  265.660615]  el0_svc+0x34/0xfc
> [  265.660632]  el0t_64_sync_handler+0x100/0x12c
> [  265.660646]  el0t_64_sync+0x190/0x194
> [  265.660879] Code: d3596442 8b020442 8b020f22 8b000042 (f9400841) 
> [  265.688100] ---[ end trace 0000000000000000 ]---
> [  265.688359] note: smokey[1610] exited with irqs disabled
> 
> Findings:
> 
> [ @Philippe, please correct/add if I missed something ]
> 
> - The first version with that problem is Dovetail 6.11, 6.10 is fine
> - There seems to be a register corruption in syscalls
> - Disabling CONFIG_XENO_OPT_DEBUG_LOCKING seems to help
> - Philippe figured out that disabling XENO_ARCH_OUTOFLINE_XNLOCK
>   allows us to enable CONFIG_XENO_OPT_DEBUG_LOCKING again, 
>   at least when his toolchain was updated from 13.2.rel1 to 14.2.rel1
>   at the same time.
> 
>   I can confirm the same for the Debian toolchain (on Debian bookworm).
>   Setting XENO_ARCH_OUTOFLINE_XNLOCK to n makes a difference.
> 
> - The following fixes the CI pipeline, but we're sure this is just
>   papering over the real bug
> 
> diff --git a/kernel/cobalt/posix/monitor.c
> b/kernel/cobalt/posix/monitor.c
> index fb7fb27e9..874acd910 100644
> --- a/kernel/cobalt/posix/monitor.c
> +++ b/kernel/cobalt/posix/monitor.c
> @@ -289,7 +289,8 @@ int __cobalt_monitor_wait(struct
> cobalt_monitor_shadow __user *u_mon,
>  out:
>         xnlock_put_irqrestore(&nklock, s);
> 
> -       __xn_put_user(opret, u_ret);
> +       if (u_ret)
> +               __xn_put_user(opret, u_ret);

Is there a test case that triggers this user-fault intentionally?

Sound like we get the corruption also or only when taking an exception.
Did you analyze the page-fault path already, maybe even debugged that
particular call path?

Jan

> 
>         return ret;
>  }
> 
> Best regards,
> Florian
> 
> [1] https://lava.xenomai.org/scheduler/job/17450

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
