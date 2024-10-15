Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D84C9F
	for <xenomai@lists.linux.dev>; Tue, 15 Oct 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986528; cv=fail; b=bqzHpo0yi6iFxEp0vJRquc7UnZOJxwMH4bAFwpx4eWvCu6UP2cxUUnWQBjILukKAiQRkLyU/VWfpkBxEwIlXaQ5lH4xytzoFl2xGNzUuIO28opq05QZgYaJzq6ZGyl+ADo+/j+uBROumBp1KJoweo1CiN+uIfGO76sswAoOrfjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986528; c=relaxed/simple;
	bh=Mo3m94sDLNfaDaJTe+StmeMjuyzGEnS5F4DqLPIqUng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L+b8Se3a66fsNA98sTjEBmGPv4GkkGArgqHWI+K2sh37QmCBFtlzD1t3YF9Kc7m8a2OFO+Z4vM5TDGYGR5b5wjJUS3IFKMrW4ONhcm6SrrDFMhMm0o8ZjVPRpnIZsZAENCUwXRQ4l6zQNdDPUq7guALmUfFt637BTwpH0mV8uRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gcBCiaDL; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gcBCiaDL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBBXE1ziHkJZSta3lrL9PUdD0dswZaVvUrgK+p5aTUouTUY8LQxjtCVLOEs7Arp6bwZPFxncreQgOoWGtquRgTCPKH3bGIj3eaWvafMsTCd2U5Dy71rUaE//ee2LRybgBsgKykOGUY2sWnN+K+OFFdYEVuw7JMcAjraIeZ7E+6JK5mvEP+1p0WuNNv3nQqhEV+q4BrNQo34igxEecmoZDda9dBEUgC9jeqjaqvKFkE7OI6tCO9Iu4ItmTYCnnCNVt9UZDlCk2mTODN1ZERPiASH1p6e6qjIXDZQkML8eEprfr9+C1MTFN7OXh6A7nIlGtKZkPuguh8Mxn9XQgUlXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHOmHTCnKomYpShss29gIuIC4RqpDwc2NLq/xpRQ1t4=;
 b=WnhKXetkWAam8OEVxhkgUabi5Bwurzm1CgAACBb8KPifO3MxyBsZJBdpYnC7Y6mibOiMRi/p38Rb4AqZ8zNg9xqP3yl/tQFAvWO2sP2P+lpZYhe1PUOC7rOgPNC93ae4twW4E1JOnMZAEi7wkb/TO14p+doDMb1VoQlWraybVGLm+jZgWvL6oRNl6HiyjLvZ6WiFbNGQt8ZmGg9/JsQ1uxs/D5ZM4mwgXMh5RIau9hh1OcbAA0kWbuJCzURjOs/fSPXscmD71NvZ22IveCfBtl6zPjBuO3GB/PSosoFeHG1RLjUOutyqfMXpeh6MZoBrAXo6hU/M43oBHWHwstXoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHOmHTCnKomYpShss29gIuIC4RqpDwc2NLq/xpRQ1t4=;
 b=gcBCiaDLiuAytTBTA/+i6IDMv18y+t/2FTalYdR9Q7u4MnhVedpkdXmyt7lBE6OKWnQICZZAateGFmiiZv8JtXYhZVlAekywSi2j9pWrruNwqVJ67dHsAuXUYSLUNm5f6YaCWOehMn8Y4kzAXQf4fLUehMUM7sB6LZQUYs208bUA9Hn3jPUunlZBfEj5WrP3lRGdFSQnbmgRvm+cPBb8L5Ebkug8cCsWgkKYpX5J1ybElq1+5jyw4hpzlkhNSK024uYxqvwUMVcZoMdNwg5pZEWEUKWgthSuobeqsrYZdiDLxXqcRKZWWTzaTqAqk0p8AK3PcWM8EFpHTwR7uu96hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7246.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 10:02:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8069.009; Tue, 15 Oct 2024
 10:02:02 +0000
Message-ID: <ad9d6b95-5f3d-4cf2-ad49-ede55cec7a18@siemens.com>
Date: Tue, 15 Oct 2024 12:02:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] alchemytests: Set cpu-affinity by env var
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240902131124.37844-1-simon.graber@sigma-star.at>
 <20240902131124.37844-4-simon.graber@sigma-star.at>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240902131124.37844-4-simon.graber@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0338.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d51e7e-c71d-4b2e-5473-08dced006aa1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXRxblV0NnJBSy9aRVVHT3lQcWNhYXExQ0IvVC9Xbjk1SVdWRlA1Nmd2dlY1?=
 =?utf-8?B?YlozM2JEb0MwUytMdHh1WDZCQndRVWhqeFE3R2NsWkZhek5BSEhWYTNIOHVx?=
 =?utf-8?B?V0VoOWx3dWUxNDVzZGRHNnU2LytVc3dZbVNad1puWU1ZaTdMZFJkQUtJTFM1?=
 =?utf-8?B?amFFeFN2TkN1c1B3Tk5ndHA5UVdUMll4YnZVanROM0dodENXSlIxVzV2T2hs?=
 =?utf-8?B?QTVRM2taVVVFTmZYcG8xT0xNOWlQckpMNSs4MFlFVEtaT3ZEeFBHWUVlNGFF?=
 =?utf-8?B?TEwyMWhyZlM3Mk9ReWpYWUFhV3MrSGlPMGd0T2swRStYVFpXSmdmMkFLNFFs?=
 =?utf-8?B?TzVOckFSS1lkSFJ0T3BWTFhxN1dLV21uV1NPanpaQ2l2ZHRQTUpIaVkyK2NV?=
 =?utf-8?B?L0RQK29OQjJrRmNNN2tVa0ZhWE4xYjluQ1ZhWGtlcUlLY2ViYU1kaWRuRVVC?=
 =?utf-8?B?MjdWRzIwZE4wRDA5Y29DMEZLWVhNa1o4S2J2V2E5N09rQjU3L3I4Z2VPY1di?=
 =?utf-8?B?YkMxYVhNNjFTd1BKbS9YZkxleE8vRXVyaDlEaUdXOXZxSUllMUprRFd5Y1l3?=
 =?utf-8?B?S3AvZFF3TDA1bW1OejB4U2dwV3RZOEVZdTlnRFhwQmNTMVVscTNOTVNqdHQ0?=
 =?utf-8?B?cnFPUXkyYlN2blNYYTZoUDVjZCtzNDBsTHhlYkVUL2s1bXJNY2NzVDZhN3J3?=
 =?utf-8?B?S1loUkpjV1kxUW8xd2FwMStYV2c1OW5wc1NXN3c1QXZDNGppZHM4ejVFeUFV?=
 =?utf-8?B?Y1crU0w1eGNFa3NZbTcxU1N4N0VQV3ZMWkNqMFpLMzBDc2hVNTl5TEROYUU4?=
 =?utf-8?B?cUR6NXJOWTEvTkZMSC9zVXZKekpYVXBDTHlOaFdDMWlJYi9MWlNLSzc4N2pW?=
 =?utf-8?B?TlFkV1hGRElMTFExVTRzMWt1VDAyQzAreUlrZDlpKzVBdWE5Uk5HM3JtRk5o?=
 =?utf-8?B?UW9lME92Q2ZlQy9YZW5BRURuNEtZcnBCY29XSFlvbXVzOXNyR1ZSTHhDRms3?=
 =?utf-8?B?c0kxWEpZTTJRdEdvUXhtMjI1bWpHWFpqTXd1UEg3NmRsalN3ZXlaZXBHQVAw?=
 =?utf-8?B?S2Y4QU5WMXlUS2ZMdEQ3NVJpOGIwWlNtYTJ6aXpsNjEzU0x1SERPZi9UTjg2?=
 =?utf-8?B?WWpXYzZyczh3UktoMGJUZjY4TXJyb3ZkSXFkZ1h6SXcwcmRQMERCSXp5NnN0?=
 =?utf-8?B?V0JOOGxZRGJsaDVGQVJsNjVnbk9tRUR1WHdKVWJ4ZTBwRTNkVmNZdlZXZlU5?=
 =?utf-8?B?TllGbldUcmxjSGZGY3BpRG92WUdRYU1yVGhBazVGWjlXQVNKdnN6dVZSTGs0?=
 =?utf-8?B?Q3B2ODZMSjQvekhUUUZTa3U4RTluRXk1WmYwemFzekxGYTZVSCt2SnFPZnVy?=
 =?utf-8?B?RU96MDVYR1lYYjNBaS9EcTZNNVFTcThwMXpyRnc1Sm02c3YwQ1h0SGU3bGFY?=
 =?utf-8?B?M0Z6L3oyc3B5cHQwTUlHeU0yM0U4M3NDM3E3aUI1WWRJTHZpZXJWeFQzaUJ1?=
 =?utf-8?B?a3czeGgvYmRSVXh2RXEwNFFYdmlIZlZBeThKeTJ4Q1d2dVU0T2lKNzdmZ3JT?=
 =?utf-8?B?VEw5VWp4YUhPY3cvT25mTiszR0lzYjdndkQxNWpudFE4REFMVFY0bnpHOG52?=
 =?utf-8?Q?aMp0ioqTi098rmeQ7lZG+QU9H3uKxdfF7Wr+/5iyFrTg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlhLYkFtYnFrVk03a1FJK2Q2dUdXVVpnNThhQTZUcEhjVVdrei9BOHJ2OVVo?=
 =?utf-8?B?bVlmWk5pT3VkUEZYb1h1dExEWUwvU1JNb2tuMDdwaklSVXpSNEl0b1lBTHFZ?=
 =?utf-8?B?bGpDUE9lQitCd0M0T2ZTWU1FRlI5YURhT1J1ZDlRZy9rczE2SHJNYVF0OGxG?=
 =?utf-8?B?Nk1Fd1pZVjRjTnI3Tk1ESFMwQjBkTjliOVVFbEpRcWI4eDhVSC96WXhRemVS?=
 =?utf-8?B?TVhwejIxbnN0WTRmVTNKQXUvcUJsNzByMFdOQWl5SUtSVU4xcExxMEJtZUhZ?=
 =?utf-8?B?c2Vwek5IdGxBUzFHYnB2czVxSytIcEJhNzBLYnJpd0lUYzN0MW9DbS9BdGJs?=
 =?utf-8?B?cHR1aVIzcGFwdlYyc0pWSTJtazVaVG5aRnBiODN2c21vV2JzenJsK3kvVmxl?=
 =?utf-8?B?RTFJQ0pjMlNGVEFaOU15bC92Mm5kZU5QWVdHSnMyYmgrUlN6YU5WSkgzSDJK?=
 =?utf-8?B?YkZHNWlvWUlUOUVaMW5OY1dXQStjalRLTmJocG5GS01PYWx0eVBWVGRPNnJx?=
 =?utf-8?B?cDJhUWxBZWlnQjVzZ1dWcFdCK3BoVWxnVXU4RzZxVW1BMkN3QUVzNjZUQmxP?=
 =?utf-8?B?amdiY2ZWZTFEVzR2emQ4a2x1ZzFpUkxMNjB0VkZ3VGlCQ1FLbjBXcWxzYi80?=
 =?utf-8?B?eEJhQnNLZFdVWWNjeGJrdHc4RjM0OUhnbVlLRnY0YnRKOFA1WXU4MkRBS1k2?=
 =?utf-8?B?MWxpbXFaOTJIeHJZbjg0N2FjVFNiQkdvTElXV29WaVlHRC9lK2VRVzRSN3Y3?=
 =?utf-8?B?NFJkdko1MlNwMU9zSS80cDNYU2xic24xb0w1cDB0ejduUHgxUlhHanJxR1RY?=
 =?utf-8?B?OWs2ck5wbkZlSEJFM1JkU3U4U1loaDloTTRHTmF2ZUV5dGxxZXFZU1IvRGxU?=
 =?utf-8?B?ZGdUbUoxdkRMQVdVS3hDWUhHYWl4dnIyMXkvWFNlcHB6SFV5YnpGWVNqYlV4?=
 =?utf-8?B?UE1ZaCtML1dHNy9QSkY1MW8wbEphTWNTL1RZSlRsREtUQ2NWSjhqekJ1eXRq?=
 =?utf-8?B?QUpXVjZBeWluRkpQMU5VdkdGTnBobFdLVU1yT3BtKzloc0h1alkxSnI4YkFD?=
 =?utf-8?B?WitsS3hMVEdUUlNYeXlzaDhOYTk3U3NsOHVDL2pHZUJCQXJyU2JVQkQ0U3RT?=
 =?utf-8?B?cmVpaWdjV09XZS81blgyMjEzUDBqWE5OUURCbVRLVVJuMHJKUWtkS2g5VTg3?=
 =?utf-8?B?d3hyMDloczlWQ3YzdVdtNERzVGhJL2I4MkRvZG54Z1JCcXphbEJnREk0R2FH?=
 =?utf-8?B?aFlQNHhNWTM0bUQrM0VOSHJOWTdHNlk4eFM3ZTZZOWdQdlRhV2oyYkxrNFdv?=
 =?utf-8?B?THFGdG5DRXh0U1ZXUElOOHR2V2VPU1pCaXpUcFBiQklQUmtLa1N6TnBmQ2tM?=
 =?utf-8?B?MzY3YWljUXBIaGk0NDRScHJsT3hQU3lBRUVzY1ZWR3J3WHdZNGxoNWV2dWhW?=
 =?utf-8?B?MTh4MEFNSFcyRUEyY3dJRmpGSS96VVpweXNKUDYyeHZEZyt0OFE1UGxMUHl4?=
 =?utf-8?B?T3R0SHRjdGFveTVUU2hhRWxCckt0RG5wVVRoUVRtcXdkRHY3b05USEJsVmZP?=
 =?utf-8?B?SkZFelJPTjMvdVNGUk96b0dKN041cmNQcnhHZjYvU2lGbUJWaFFJSWdmYU5i?=
 =?utf-8?B?YnVtcDRPWTgrMktGUWszUDdQL3RRSTJ2VHorNGhKQ2F2eXNkdlBjZ05qZ1hX?=
 =?utf-8?B?aVJLdHA3aG9ra29QREMxb3ByaGxwMjlSUDNtMWc1Y1kxUGhpRFBnQlAyZVBQ?=
 =?utf-8?B?QU1nRnMycEV4dHJseXp3bi9lS3hCaC82Ni9tRDNod2FFSTFpZm11M3N1VUpH?=
 =?utf-8?B?QUlrQ21ZaGc2cHJWcEFYQU5UcXNrckRTbHRIN0wzTnJrS1p5VktaeGZWUC90?=
 =?utf-8?B?K1JJM3RyZHZSUkNEUzVwK0Irb0IvSk84K0t0UWIyRzQ1NVdadk12R1plUFl1?=
 =?utf-8?B?dStPU2JET0krSGxYeEJzbW1CR1ducUpuZ1ZVVTdCdXFRaXVleHp3UGdRQjMr?=
 =?utf-8?B?a2VXZWZGZW9rdUYxVEtIOFZYYUlyaHhmTjZOdXZFMEk3TmhVajZpc3B2cUND?=
 =?utf-8?B?dnRPUzBuci9nVFQ5TVllcWhaL3V6Sk95Z0thM1VpTDZYMm9Ca09oSkxERXVq?=
 =?utf-8?Q?5+gVRf1PKJBFruV1RAzU2xknB?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d51e7e-c71d-4b2e-5473-08dced006aa1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:02:02.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCB+5fo/hel2j8vCeHW0QZza1gLkBUgrolpeWD/fdyE08/Y97jbBmlyViw6Uod0u27hZIdvSU4iWW0RsIthoPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7246

On 02.09.24 15:11, Simon Graber wrote:
> The alchemy test runner can now make use of the XENO_CPU_AFFINITY
> environment variable by setting it before dispatching to the individual
> test programs.
> 
> While not changing anything user-visibly, this stresses the new
> interface in CI and allows in a later commit to pass the --vm argument
> via an env var too, removing command line injection from this test
> case.
> 
> Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
> ---
>  testsuite/smokey/alchemytests/alchemytests.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
> index cf9f970f1..edbafe6e7 100644
> --- a/testsuite/smokey/alchemytests/alchemytests.c
> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <string.h>
> +#include <stdlib.h>
>  #include <smokey/smokey.h>
>  
>  static const char * const tests[] = {
> @@ -31,12 +32,19 @@ static const char * const tests[] = {
>  
>  static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
>  {
> -	const char *args = "--vm --cpu-affinity=0";
>  	const char *const mod = "xeno_rtipc";
> +	const char *args = "--vm";
>  	int test_ret = 0;
>  	int ret = 0;
>  	int tmp;
>  
> +	ret = setenv("XENO_CPU_AFFINITY", "0", 0);
> +	if (ret != 0) {
> +		fprintf(stderr, "%s failed to set XENO_CPU_AFFINITY: %m\n",
> +			__func__);
> +		return ret;
> +	}
> +
>  	/* Try loading the xeno_rtipc module as the pipe test depends on it */
>  	tmp = smokey_modprobe(mod, true);
>  	if (tmp)

I suspect we have some regression here as I see a lot of heap-1 tests
failing in qemu runners, see eg.

https://source.denx.de/Xenomai/xenomai-images/-/jobs/918773
https://source.denx.de/Xenomai/xenomai-images/-/jobs/918984

Could you check this?

Jan

-- 
Siemens AG, Technology
Linux Expert Center
