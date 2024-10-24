Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102011C9EDB
	for <xenomai@lists.linux.dev>; Thu, 24 Oct 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765936; cv=fail; b=BXC2Bz8N5tnWrOCldj5tX6FQsnWizNsRVqEIA8H8wTgE8miXSdNnUTxZxqeq4ZBUv+XKt3nePjZPyxTWsZTXo9VFAk1rdLfnnHToIb1PEyLd3GlCSLge3CqOgXqCOef526iBFMgRsitYSvx+pRtgDzohPa1TN0ACOVphwjchd98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765936; c=relaxed/simple;
	bh=Vn6hYwCB9yXDLH9Y2vDbTf2Z8KH5bLqblTXwWIJR0Tc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YgeL1ISCW5oRnSwf/RLl+o4haExn6EtwhSP9KlNXI7Vadv44fEShlM22EEOIhC6W/51Wx/FRv0dGHxa/X/UOFz5yJQF4NDjf4hjlyc1cMO0BzcFvssruLpn2MRVUakFXYZXimiSzemHaxmyHRstbATtdSdmpgikg59I4fjD08UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JnnmYxOG; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JnnmYxOG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrYsxC0yf2DTyMwdNVXhIgcZjspkXlb0z+TCurbf6CVPcLG48K+ip4B3OE0bXcMh0pIRTvXPkSFdDP6u6K48Lds/zufCqvoAy81FcuL+/DVNJfiKliufeR5cFm/qo+kgcEk/Gkzv4THS/flLLzyvntSSeQbGiEdatB/Xtv7M2OFcLgPz7+7qfpDUyQBUNg1DXI0teyDHml2CXkE5NhLglE2TbTKpyBHwQZA6MxR65CqtphseuIh9F0Rb1f3Zoms10KCBGboEN0QVkDerrXBnz7vUrfdWkfnelleYIlxanPGobcbgi/JhZRWBeWc85K1OpPtBwp5BoLNE3mW8drYbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwUE/liRmu40NHiRgDzBexSX0NFavnSsqyjO18dxumo=;
 b=VPlB1pbXFb4C7id4SevtnDyaczsZJB2DjSRbXeyZ5J8TUk/wdkPGeSqMLi2vClFabyhD0HapibGSnIxkwZ+QK4kq3OxF2B39QPTlAoJaXtgvFR2GoSIW6x12RvOuBNbzXS27iqjHM1UZtIkqCeH71hXHWs8J5uPCbMk1lOFrAZhq/JdN3L2Rgh2HHDs6ya4+YXRhybYakE1/4LSEk6MJ4H/14X96taiFR0A4bm9UtAldv07dMwxlQ9Wv3aih3Rd3Fn5MtvEgrec3fTqPCacUJGEa7o3wKbx6L8m5l/kcK+eronZS6Vk82S87d8CPQ6PycK3aWEJ2+FPpxRVtYN3m2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwUE/liRmu40NHiRgDzBexSX0NFavnSsqyjO18dxumo=;
 b=JnnmYxOGNV9vIkHOBh/wSvsQn3Vzmq4ArmHF8AqukaCHQRzvtTvErTi08z28aRmUfM/yWdDtipnJHyb0iNDQET4JCj6tvIs4xgsdnW/F3ec0KcMAdoeyjAiZEEMwJLFmRjVzcsm4bieF5yo7mQYv5UM8WhbAPWMU2/eBdbFFeJOPbh4xyldCYBHw/IwpBRselYmtfTm+N/4DcBa97kmwGVR1DRngtIHxH2o8qmfKdVfh5RxT4bzbZqWNQXPCI1/PijBJ9cdtPmOYERVkUVj0kiTD2zEfyfAyex15r2R0bV5nqemHSJo2s5YJF1erdRCqKWFsRNz2Pm3htV64QpBdbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Thu, 24 Oct
 2024 10:32:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 10:32:11 +0000
Message-ID: <f50c3f38-081e-40ce-b4bd-4729f51156eb@siemens.com>
Date: Thu, 24 Oct 2024 12:32:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt/x86/smi: Let setup_smi_state() return the
 workaround state
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20241015213251.2022553-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241015213251.2022553-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 2255c588-99e4-4258-5507-08dcf4171e37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnNIYUxwTHJhVVFzTDE5YitqcS9oNGJzd1JQZ3dmNnIwTW0xbjExZFdNcFBa?=
 =?utf-8?B?OW9pcFh4QkZ1MXBuSlVac0MrQkVYVDQ5RktyUGRnREZTdU0vcTlDVUpGeTRZ?=
 =?utf-8?B?WjRyVEtxV3BjNXpNQnhSc042YzFrYkh0T3ArdW0yVENnemRCZWh4WURiQ3hu?=
 =?utf-8?B?c1ViMEtmZ0tZWHBRS3pHTjF2alJFbU5MVXAvdStYVXJhc1Z6K3gzanVLMGFv?=
 =?utf-8?B?R2JvOFJxL2lGcVBueWxyOXM0NUpiZzRQY3k2UUtENUpRMHpqU2JzUmw4a1pv?=
 =?utf-8?B?akhZcHVncE1TMHZ2UUltV2JMdE82YXloekRSZDJlRzZsSDIxZFdrMGY4WEk3?=
 =?utf-8?B?cTFrMHNreEVGNS9sTkJ1enRBeFc0L0k1UGZCNW5DZEhHOEFuY3ZmREIzZkp4?=
 =?utf-8?B?dUJjRWtxY1VzcXoveXZpcnNYWHRaQkxreDc2dll5RUN2ZlJWUFBGRGpMTmdp?=
 =?utf-8?B?bXg4YTBYMlRBeFRvSER3bjNhYURERWdKdUdsRFd0SzJGUUNxRU1TSFZNZEl3?=
 =?utf-8?B?aXlOUngyUUZybDBGUTBFZWFPOTk2MDdZTmtuNnZNVHpuMTVRTzN5VXducXlD?=
 =?utf-8?B?MVZ0ejErL0p0Q1AzbUdvTEh0UVN5R3BHemNQekFsQlB4MGdqSzhPNGdxdDhE?=
 =?utf-8?B?ZWFTYXF3by80VzNlVHpQZDRnQmtsYXBkUDUvaFhmRFFlL1JRSkNiRjVqQWc3?=
 =?utf-8?B?R1R3NTRHNHVscTRIYzRNN1N0RW95dXlsRVVqMlZ3dklEYkpSVE81Z3VpZm0y?=
 =?utf-8?B?bmtobHlrTWNHSmtPYkJoK085cmNtTTk5T1I4bXkvOHVOMVF2bVM3NHIzeHBz?=
 =?utf-8?B?K0RWUjExLzM4aGN4cjUyNFlSaC9OMkptWXloS3kyc3RwSGUxY1NhTnU5ZVdC?=
 =?utf-8?B?b3lGZ1hHYmVwTWFOSE13c3ErcHFlSHVMMFhMY0ZoQTUvb1ZFNHoveTFWb1BG?=
 =?utf-8?B?UWYwNWIwTjhISWFEQkhpditxbTZRTHg1MzltRk52M2Y5MzhNbGFVaSt2L2hR?=
 =?utf-8?B?OC9yTDgwL0JxMEJRTWZkaTQ0UmVnTlFWQUFwVTlENTk2YWVHUDFIS0RIZnZy?=
 =?utf-8?B?RzE0dy9jandmejRhTTVZeWhYZzVpeFVaTjNZNGE1aE45RnFHU2hSUUdXTytr?=
 =?utf-8?B?b0ZCUHorSTA1MmJkVEhaWVVZVVJpZE84MW5EZklvR01ENDl5NkN3QnV2MmNs?=
 =?utf-8?B?YUJDMkhyYW1mYVRmWTNOZG03TUdVRWJ3SUVlcVVQNk1wR2dqWDBnN1B1TmhX?=
 =?utf-8?B?OVVGYXpNYndmU0xNV21iTmFSVnhBbnNGa0ltaXpXMFM4dFRlUW9WN0E2L0ph?=
 =?utf-8?B?ZXk0a290MlQyS3F4Ujh3QzhYTmxDMnlJNGRBT05aK25SS1RIMDJyR1JnY3Q5?=
 =?utf-8?B?L3pISkwwZytwdUFTWUEzUEk5Zlh1UXphdXFGRm90QW44Q1Z4YUM3aE04V3B6?=
 =?utf-8?B?dk9NMzJVUzNvNHNCQnVQNHU5dU5ScHNNbVU0L1RTVE1BNzFIbGF3Z2wwaWwz?=
 =?utf-8?B?c3BOSGZObUg5QnJnS0ozbDE4VWlBQnhEMmkwVTNZbnBpWjNJVW1yM3NIUmYx?=
 =?utf-8?B?czdYbkpmVDVxYjZRaldBNDlVM1JqbHBQOFhlc3FoYk9sNUhmN3ppaHdVOXBX?=
 =?utf-8?B?Tk55WUgvWklCQktMUUNjdzZZQlU4SXkyMGJOVHRaekxuOEkxZlFPWUxvTkhU?=
 =?utf-8?B?QUQwV211T2czNkt1ZCtxYkt1RnRucFc4NmlFVmorRXBtbDZWc3U4MmVPT002?=
 =?utf-8?Q?1R7CgeEr+RohXMysYhOyadyku5j4mI9l1iI0NXu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkFjTFdYWEw2Q0JnQ3BsbHRpSnVQS1diME9BZ3hEQXFkNC9LVno1ZzRLN3hM?=
 =?utf-8?B?SE1zOXlpZC8wbUN0N0JtQzFnVktGVHphcHhVUDJoRjJwSkxmM295RXFTUmNT?=
 =?utf-8?B?eGx4RzVCdWJKRk9DYTh0aHl2bTdUdW9OYlNiUGFsRnhRWXhMdHRyTXJXS2Jw?=
 =?utf-8?B?TUxjdFlyOXUweS9PeGMrNVRXdlpjclBQNDBlSEVPQTlkb3FoeStselV5QVJB?=
 =?utf-8?B?NHlmL1dpMnN6QloyaEpNazJhS3RSZWNSRVZUV3paYlpNcXVzcGZDWFA1a0ov?=
 =?utf-8?B?M3NRbW52dnpBZm5IRnJ5T0VJTUJqdm0yYW1UMk42N2VWUUE2aWgxYUF0S0ky?=
 =?utf-8?B?TDhLTWowaUduVzVVUnQ5UWUxcjNnV2g5amdqYit5NFFMUDBvam9Pay9QcS9k?=
 =?utf-8?B?clRoQVZyU0VoZ3JxWm8zUFlEZnNkUDNoWmtUNDg1a0FpdDcyWEtkbUhua091?=
 =?utf-8?B?eGxXVzAzTG9LUDFtQ2Z3MW5oeWZXMVZhTjNSUVVYaW5ZMUp0ajZUZVMrSkxS?=
 =?utf-8?B?aG9sSDdVMTR4ZUtYZkhWYnBMajI4ZlNrYkV6VUhYZW5rWjg4dks4dHh2b242?=
 =?utf-8?B?UWlTN3l6WGJMSUt0ZHp4N0R6Nmh4MWtSTUtHWC9ocnNNaUV1bWdHL2Vpd3pX?=
 =?utf-8?B?OWhOcmw2WXJiZGdDVjM3TlA1c0tqOHdjSDZSSzRnWmJETGtVQjNQSVk5dzZq?=
 =?utf-8?B?OC9wL09hMk9pYnlYUXdnZWxROVUwZ3ZvTDJMclBtZHVpWUtWdnlTRGFra2oy?=
 =?utf-8?B?MTFic1BuWldTSm1QSjhmM3AzaWVoSlZ5bkhnUmpoQ0Vqd2lkQlFSVDVWeXI0?=
 =?utf-8?B?SWZpbzk0cWpHdGlJd2prN1pjZlBEdWF6aldYNjdsSmI5b3NHTGd6ZTlJaGNx?=
 =?utf-8?B?Z1RoK0VPMFRGMVFzUEQ1T0phaHo5bkdHeVUrTTRNejJ4M2N2MWo2YWVDOXlh?=
 =?utf-8?B?TzNKTmV2R3BQQm1aSGF2bHAxVjFsdS92bG1NWStDVFZsbllMZDVXandYcmtJ?=
 =?utf-8?B?T3NudlVibUNoTzBuSE5GLzJJSUpOZnFZTEtXQ3pLVVdUaVFtMjRja1FXRWJz?=
 =?utf-8?B?a3dPejZmcVdSbHkyYkVGVXZuNFNEU2dKQytkYmN5cmRhVk01eWY2QnpQd2pm?=
 =?utf-8?B?cGkwYUh6RXhXN1RYRVlNK1VSWjNqdVhsL0UzMmowVGw4ejlLdXpPSzhxYU84?=
 =?utf-8?B?S2RONjVlV3hlY2pzQXFzV0cydDFCcFhFektQUCtQVVlBS2NoamN2NmNUU3h5?=
 =?utf-8?B?T3B6K3hyU2oySlA1YVBOUkhGMWZYeHVQRmpwUFNqSmhScjNFUHppUE9ZeXJY?=
 =?utf-8?B?aG5vSDYyYW1NK2FuclVvOVJyOExydTBzRUFhYzk2enRYMTYvakdkaDhLZnMy?=
 =?utf-8?B?SkNLbk9DaG5iQThPZWRhS01xN1FWUjJ3R2xhbFlLbWdMd3ZDSFZpWnZUY2pv?=
 =?utf-8?B?K0RseXdUTllPNjdyWG1ucmNZVHNUdGJVZUFhN1FBN291MC93RTdGT1JnaWJz?=
 =?utf-8?B?N3N4aWd2OGREa2tEak9jL3JjUHdXb1l3c21VWEZqQjhUVS9qbjBscHd5YnU0?=
 =?utf-8?B?Y01SRHhmTXlKQ0lpU3VWM3hGcXo4WnJqQmw2S2U2WnlwWUF2L3ZnVVQyNUJu?=
 =?utf-8?B?bGU0NWdyNUg0U2dFSmprclR4ZFdiUHgwd2JMZ25XR3FFUSs1OVFYa1Y4N1Yz?=
 =?utf-8?B?SUorUmg0V2QwZEdFNmNOQ0dGeC9MZW4wR09YZjh4WXA3cXdBU1pYMk5qSEN3?=
 =?utf-8?B?djBIU1F2bzFjOGdFS05ZSE5tWXNtTWZ5eFJzckZQUUtndllDbWtxc0tKaDFN?=
 =?utf-8?B?TXgxQUlTYnpwWE1wcSsrZnJDalhSQTdMb0Q2MkluR2pRYkx4UkFLVzY1QTZr?=
 =?utf-8?B?NDBQTWVIcWFqdnljV3BJTUJoNExGd0ZYTzgwTy9mWlhVSHhKWGM2cHFOamZs?=
 =?utf-8?B?SkN1Yk02NkJtd3ZGSFpiY0RXaktZUCtVNUhEN2NYS1dWRG0yaFV6a0ZvVmR3?=
 =?utf-8?B?MzRRY0RQWWp2cDJNeGhWWnhncllJNllTaWtHNmpvWDVoZm9qbXJvM0VReW9m?=
 =?utf-8?B?ZW5pK1locTdXcG41MldCQVkrYWJRYllXeEo2N2ZMYTNLUXJyTnNtbnM2MW5l?=
 =?utf-8?B?Nm5LYVc2bmN3UzFUeG5YTTcvWWZDTGQvK29DbDZUdXZLR2liQzJucXdDL3Av?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2255c588-99e4-4258-5507-08dcf4171e37
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:32:10.9722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9QfPIjYlC5KFnLieFyuTX/F+kA0FX2/bwtTPedLYwxUu9kIp+ayTQwHzo6cL6Y/sUm7YEDAZ5aQlrB5C5iiqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6014

On 15.10.24 23:32, Florian Bezdeka wrote:
> No functional change. Rework the static SMI workaround state into a
> non-static variable.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/cobalt/arch/x86/smi.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/cobalt/arch/x86/smi.c b/kernel/cobalt/arch/x86/smi.c
> index 87a2a3c4f..1ecbbb7d5 100644
> --- a/kernel/cobalt/arch/x86/smi.c
> +++ b/kernel/cobalt/arch/x86/smi.c
> @@ -39,7 +39,6 @@
>  
>  #define SMI_CTRL_ADDR	0x30
>  
> -static int smi_state;
>  static char smi_state_arg[16] = "detect";
>  module_param_string(smi, smi_state_arg, sizeof(smi_state_arg), 0444);
>  
> @@ -111,7 +110,7 @@ static const char *smi_state_labels[] = {
>  	"enabled",
>  };
>  
> -static void setup_smi_state(void)
> +static int setup_smi_state(void)
>  {
>  	static char warn_bad_state[] =
>  		XENO_WARNING "invalid SMI state '%s'\n";
> @@ -120,27 +119,25 @@ static void setup_smi_state(void)
>  
>  	/* Backward compat with legacy state specifiers. */
>  	n = simple_strtol(smi_state_arg, &p, 10);
> -	if (*p == '\0') {
> -		smi_state = n;
> -		return;
> -	}
> +	if (*p == '\0')
> +		return n;
>  
>  	for (n = 0; n < ARRAY_SIZE(smi_state_labels); n++)
> -		if (strcmp(smi_state_labels[n], smi_state_arg) == 0) {
> -			smi_state = n - 1;
> -			return;
> -		}
> +		if (strcmp(smi_state_labels[n], smi_state_arg) == 0)
> +			return n - 1;
>  
>  	printk(warn_bad_state, smi_state_arg);
> +
> +	return -1;
>  }
>  
>  void mach_x86_smi_init(void)
>  {
>  	struct pci_dev *dev = NULL;
> +	int state;
>  
> -	setup_smi_state();
> -
> -	if (smi_state < 0)
> +	state = setup_smi_state();
> +	if (state < 0)
>  		return;
>  
>  	/*
> @@ -154,7 +151,7 @@ void mach_x86_smi_init(void)
>  		return;
>  	}
>  
> -	if (smi_state == 0) {
> +	if (state == 0) {
>  		printk(XENO_WARNING "SMI-enabled chipset found, but SMI workaround disabled\n"
>  		       "          (see xenomai.smi parameter). You might encounter\n"
>  		       "          high latencies!\n");

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
