Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794572460;
	b=fvQOIqkNz/7EEt22H2FR+Jbh3wjo+ktK79op2rslIPBnnuew4X0MyyK1/j0aAjrAyUyk
	 3Sj7m8fgY+Crl1MN0CeCl5NpE9IMep0yxGI8NCe3X4LRVfWDVW2cCyrZEsjmLzXvaiXHD
	 UpWSs9fpukvF9mITTW5h8gzpN2B6FwBhtltoNUZv6x2DtmtVJMZoUj/XEvzEjwcwSmQ+y
	 o8cvQh2dZRAQkCIf+ZPYqskeVXJtTlZcXpCay1NNgUo6cGT87qB1Jy/IMXiBkA1BmHpTg
	 TPZYmAM6uF3lemYzFfJCA6hKoso8ryk1R/s8wthQR6n/wpN2ZXJ1MsGEMPm/BS8rxeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572460;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:References:Content-Language:In-Reply-To:
	 Autocrypt:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8VdfMOZDgeBM3Eavnzf2brBp0QPMDxz4GMqAr0KbzJU=;
	b=zt9hmfvQFdLNv11GqQZa8WXu55FugPw2C7DdXGjSyAht/v924CpMJLeShmgcXMtvltwR
	 7yR9kVKzgQWMggYADCOq9XjxdilZWe8rAGRkhpEk/9i8AhJyaJeyWsDNqfjNM1Dact/oQ
	 NMpCoFBSjfp3N4maPxEs8QpHqpbXkrkKxW1AsBVZ+e8z8g9kAWaR3wCYD8e9VdQmv3Lbj
	 PM30JvSgSkqATX7/JzMxaZkZTwyq5z00dYe9tFKox5DoLl28p8dEDSROfx+99FmkO55SN
	 WclbPjxkJZ403BIJ6yHRrKTje66OKEjJ3EE66qjbwv+rXe71BZs4d7oxbSWMPnBspSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=uOPCjsI1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.9
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CD660A2600
	for <xenomai@lists.linux.dev>; Fri, 13 Nov 2026 12:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23CD660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=uOPCjsI1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyP11CD3ODYkZNjU6VfKph3lrA1nPMt5FUEzIK7HKUkIvbCgjNpOiLvATx3ElckDUpS/dpqnpPEi/CDQqrRBwPG7cYS+Qf4T7fobOklhvMCch0ow/bEAOFcupIeDv54GFEMXScFWoC7HPlXyMII6i4bjhDB+wABkX888niV1YDNuXztCyzUwoVPZGi71JK7drnkKi5Iib+5whtIaJNb+FlZQJGyjZYxTQdF8oTE7HEI6ppexTpDcs+fH22Wkb6PbOut9Z/JlICdNxr1TISy4kAGMtl/atde169ENQpb4hX8RKpf3D/NINDkxPDBSO4PQUJ0CAobRWDQJYZwsWavhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VdfMOZDgeBM3Eavnzf2brBp0QPMDxz4GMqAr0KbzJU=;
 b=ANzFXBeZHEU3b2jgIwbYHY6FkZWVfK5wYX+PdHAzyxZ2nHLGkfr66wEIj40smCkCeEU1Z+E0mchfFUlAvy+VemBaUZC1Mocwi3/n6aEcB0tCw7jsyatPxQm0tml7N3g2Dt12i5cK8xwuz4G53NV3PBl69GQvPa3o/oYa9ysrXw0lxrmYf00nubtxycWj9uOelV1ZtYXXrzpos5Ocq2qERDGOV2l8gff+0rla0KMg4F7aBl5ztyHxWlw+QOPVtmY7/1KCYIIB/q40vzFTt1aLVZe3o3N9lcsZRAh7iCXSEJqaOdTyhs3t6Hls5P7cMOSfQAy9L/Wj2W+6gbtIiMS2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VdfMOZDgeBM3Eavnzf2brBp0QPMDxz4GMqAr0KbzJU=;
 b=uOPCjsI1/luGL7d4yxN+2Kdeca9jfghVHkNTYRgvuC8Z/Y+mw3B+Pvcs+eL/b1mT2dwgTbdJI+QNj2SBQ2RUZHoBBVv/udJLlelRqNxhstw228zkbvMJjwGRaYPRueJIcPn+5/4nHta4zmqN+4l2P72dqqioT2mzNacspRxhEOGF7P6Qu7UZdUFd2yoZBTiSzoH7i+qW7eGnXIxG66g92DmWUcK9dYiSmb6hG39YTVzB+QkFjLD4YJeYMM2r9qjECq+yNdmMTqF2fMcPvveW4fsuWoWQnM/1zwufRka5WLH3QhiquufOr4ATbBAxQ3+mfdmexLvcUfHpJiInzJmDFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB7372.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:604::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 12:20:56 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 12:20:56 +0000
Message-ID: <f0f8dc2a-bf6a-4a48-9ed3-4b3bc45b995d@siemens.com>
Date: Fri, 13 Nov 2026 13:20:55 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] Fixes broken mmap patching on 32bits archs
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>,
 xenomai@lists.linux.dev
References: <115efd-6af60100-33-36f80d40@101055323>
Content-Language: en-US
In-Reply-To: <115efd-6af60100-33-36f80d40@101055323>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 2867fbdb-9c3a-43d3-4c25-08df41809169
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|6133799003|10067099003|55112099003|56012099006|11063799006|261102123227099003|261021121427099003|261026140227099003|261028144727099003|261009223027099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	LT0GCsoQv6w3ziHfbKqoDvnowNL9XiCdYdievRROaOBvZpnc1A3f0yekFs6egbTEUQ3TizVm6zUjXORxzWjqEuc5VJbidbZHienupy97BY4EtkR2Hv3tUV2nn9KnaSlKDcAUmqVNNvjABCsHXqi6ncaX9l00cuiUn602L7/UdXGqD0/5hJv8NbzeGYrJ4abe709oo3MLN+brLQBPX0PmtRZcD9wEe2CG9EhOf5qX2DjFVKFaPxJ7aIfDU7PAeT9V02x2Tsp/XOKQRLG9G7MTmuDBbV3yawgeiZhpdZpzcGGwQs1aQvVDGbgOLSH5nNssbWsMnrVrsOgPFrd8xbdyP48pZly6OCMKW/G8TFHnDxS39C3KtmMa5BDvhZpJCIYTAxHAUrsnJBkIIbL9/wUdkAvxCgwcxwTCRmALdh1KIQjsU+pTYtcSlEjM11hT0/VsBmbowmq7htSvZI4hfpfwFxqI+nXWwUl29uZA7KxAR72IZQVaYZJTeBUpdS9X8wbTE8pUVSrpB9HdHmPfHI49gdImjwpcMLMsI13wsr0UbEtTWkLdPP/S6CmiDquqJXEUUQSlPvr10QyFKZ2f9IZSIGM9I7LQsaSWt8KOjHjak5oJ/dW7AEnFzUk2G2WEtkjteP4ctXCAVL040dBQ2dY6NZWJEN3Joe0rjrRhmV/mRLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(55112099003)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261026140227099003)(261028144727099003)(261009223027099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW4ydFRzaEJQUjd3U1hyUkx2SGoyZjVUTjFxdHVlUnBocXBoaHlnbktJamNp?=
 =?utf-8?B?a2FydlNDVWs4NUNzT3dNRi9XR2RGTHFnd2Y1aVorOVJZaG5WL2E5V2ZsekUr?=
 =?utf-8?B?Z3dTdGxnUUNoNTQwcVY0MDZNaEkxblZML29aRGc5U3FudEorK1NCTHI0L3Q4?=
 =?utf-8?B?dGM1SU1JajhzbHRFNnRGYUFsdmUyWE4wR2xMaTQxLzYzam5uZFNWZm0veGNu?=
 =?utf-8?B?azgzVXZWQll5QzZxR1YrMFRaVjBrK3docHc0WHRSbncxdmFWdkp3T3hzUVV5?=
 =?utf-8?B?bnozUk84aWc5M0NCOC90bGpwREtqbVRaSnVoZGVJUnNid243Y0VuelorRjlh?=
 =?utf-8?B?K3JWbFlXRm5ybXNzTTRDWTFnTjhSeFpGNGJzam5PS1ZMaXhpQ3RoaEQ2T0o3?=
 =?utf-8?B?RXhkaitIVUk5ZmRTWGtTWUlFWUpKYnRkU1c2STJWTGg1aFArRVVmekZwN1hr?=
 =?utf-8?B?UEg3Zit6YlRPdGVISzQxdnhOTnJGaEtlZUJ0NjFXQ1FXUkFoRi9VTzdOWHV4?=
 =?utf-8?B?bEFlcEVYdmxzK1RaOElUS3lmT2w4eFNDUlJ5Y255YkRLa2JSWS8zQ0FhcnNw?=
 =?utf-8?B?TzR2K3ZLWHU1UFl3ZXhUS3B5T29SekhQMU5NZEh0WkVIYU5MczhmMWdGMnJG?=
 =?utf-8?B?NXVjVGpndE5ZU3krYkNodlVlU1pzaUY5RS9MMWxBbHh5ODc4Q29FL2NXeHhM?=
 =?utf-8?B?YzZvcnFWVVd6MEI5Q3dsdDl4UE9uYU9mSm9lL0lOT1JiVW1RUC9CeTFzbWp5?=
 =?utf-8?B?MVk4WkIvQU5ac1hRSTN0NXU4U2ZoV1JIaVdyeVFMbzg1azZUYnE5M1ZTM0xB?=
 =?utf-8?B?NEpIOGE2UDk1eGZsOEpmeUZ3dnVLWjQyZkM5bDNWaFlsZTR0cWRGVHJCcHFa?=
 =?utf-8?B?dk9tQ0d5ZW5OOTMveFh1MTFFVklETCttTkdpelNWMU5CK05CNjNwbktGd05T?=
 =?utf-8?B?bnZBWDUxek1lN3VaaWdjNGE0MnVpL1pkTThNT1E1VEc0eTcySnVrVk5LbzF5?=
 =?utf-8?B?U24yMlF2L1FJY20yTExKd3didlRxNDVLQXFxa3NPWWNkcFREMDUxZW8rSDZ2?=
 =?utf-8?B?SW4xcFpJYWV2Nm12dm9tZkpWVnZXbU1yQzM0MXg1V2ZTanJYcGtBbVpra0pu?=
 =?utf-8?B?K3Izd0dzZzZlSnF1NkxodXpudmNhOUZKUGpYRk03T2JYcWdwSjl4WU00K2Er?=
 =?utf-8?B?cFEvT0haeUdTc1FOd0hTZ2ZYUUV4aWJ1VHB3cjVGSzFsaE03Q1dUM1prcXRN?=
 =?utf-8?B?eG9Fci9RdFZUWVA5M2ZYVXQzUHNFbmxSdzl3aU9CR2luZUdnN3FLejRGQ3NJ?=
 =?utf-8?B?a3UraGNMM0ZxT2JGRlZnWlhqSmFGTnkxczRqS0xrNDZqakxuQ25HZkVXaVN5?=
 =?utf-8?B?c3QwcEw0ekkxbXE0ZUJldnAxa3E4TVV0clllcVJqbEs1OFBlSEQ1VHZEZGwv?=
 =?utf-8?B?aHFHY2JDd3lreC9EZnZiYWVJZG84SnRiUmZ1QWZ5dE55OUMwd0FBRXFqenJX?=
 =?utf-8?B?VFVWakJnWUdBdWYyakxCNEcxVjBqV3BhRUtBa3FJbUN6enp2RFlITGZLZnVN?=
 =?utf-8?B?QTA1SHYxTGg5aG5TcFUrL0NHaTBxWlJWVlZpdnlhYVI2Yzd3WjNOZnkwRWJV?=
 =?utf-8?B?N3FPajJWR3hEKyttTnB1bXkwZTgrNTlZM2ZhYk1jZmZvZ1FkQXNFUEJUOWtT?=
 =?utf-8?B?Z09nMUNUWUlrQWZhcnNjQndta25MV2NNK3MyZWJJTEE0RTBYQ2NvV0pRbXp0?=
 =?utf-8?B?M253WktIR1ZFNVJxYUNLYnBvMnBYOWRad3Q3MUY1ZUpDaEVnS2srbFR3NzBh?=
 =?utf-8?B?NElGYW9YWVBMRjlzWFhXdG1RUkJGL25nREx0c1Vrbm43NnRDKzM1MjQwS0JK?=
 =?utf-8?B?dEJabWR1YnhlTTdPQmlkSkx5VFd1aFI4Zjg2NmI3NERpbU5KdGVmU0VLcjQz?=
 =?utf-8?B?VWEvbVBQRTQwTmpnSEc4eWFCU3BocXk0YW1vcjR4c21OcXhjMFRXdlBvcFlK?=
 =?utf-8?B?STQyUnVCNzF0eXFSYjlRVVp1VlpmVXUxNGdMVkRqVWcza2RYKzhSL2ExT0N4?=
 =?utf-8?B?OWJRQ01FNy9VRkg3VVZCKzRVVDB4NkRqekxVSHJmRUhUMGJ2RkhJWi95V2Zl?=
 =?utf-8?B?OEpobWRlVURQTzZnL3M4alVNRzB6YXZhV0hBTFJqRVQwWUdwbW4xU2hxTzhl?=
 =?utf-8?B?Vkw1eTdDcXdvaFdMMFd1UER5S1FIOHVQN2NZWlJOQ3N6OGRkdnNjVEsxNDM3?=
 =?utf-8?B?VmR5OGlYcVRtT1RwSjNBK1pOSlJVZVM4R1FablNGcERacU45TFdqdzFCZ2Z0?=
 =?utf-8?B?dGlic0pCZ3d4Y1dvcWQxejU4U0tSNDZ6R29nUDd6YVpRSkMzRUxSQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2867fbdb-9c3a-43d3-4c25-08df41809169
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:20:56.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tR7DXJIZDbsvV5zCZn+eAy+GaG0OoBarodpLSNia5NTx+bAXjHyhXPgTVJuco4Zoi3thYm2KDX0mDs2GhvjdEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7372

On 12.11.26 19:11, FranÃ§ois Legal wrote:
> mmap is broken on 32 bits arch when __USE_TIME_BITS64 and __USE_FILE_OFFSET64 are set
> in that case, libc translate calls of mmap to mmap64 because file offset argument is a 64 bit value.
> We fail to catch that with the decoration logic (__STD/__RT) and plain libc mmap is called.
> 
> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> --
> diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
> index e291f50ef..b6d650876 100644
> --- a/include/cobalt/sys/mman.h
> +++ b/include/cobalt/sys/mman.h
> @@ -28,16 +28,10 @@
>  extern "C" {
>  #endif
>  
> -COBALT_DECL(void *, mmap,
> +COBALT_DECL_OFF64(void *, mmap, mmap64,
>  	    (void *addr, size_t length, int prot, int flags, int fd,
>  	     off_t offset));
>  
> -#if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
> -COBALT_DECL(void *, mmap64,
> -	    (void *addr, size_t length, int prot, int flags, int fd,
> -	     off64_t offset));
> -#endif
> -
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
> index a5645a1d4..82c9aaa69 100644
> --- a/include/cobalt/wrappers.h
> +++ b/include/cobalt/wrappers.h
> @@ -46,6 +46,23 @@
>  #define COBALT_DECL_TIME64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
>  #endif
>  
> +#if __USE_FILE_OFFSET64 && __WORDSIZE == 32
> +/*
> + * Make __RT() and __STD() usable in combination with time64_t related services.
> + */
> +#define COBALT_IMPL_OFF64(T, FN, FN_64, I)                                    \
> +	__typeof__(T) __wrap_##FN_64 I                                         \
> +		__attribute__((alias("__cobalt_" __stringify(FN)), weak));     \
> +	COBALT_IMPL(T, FN, I)
> +#define COBALT_DECL_OFF64(T, FN, A, I)                                        \
> +	__typeof__(T) __STD(A) I;                                              \
> +	extern T __REDIRECT_NTH(__STD(FN), I, __real_##A);                     \
> +	COBALT_DECL(T, FN, I)
> +#else
> +#define COBALT_IMPL_OFF64(T, FN, FN_64, I) COBALT_IMPL(T, FN, I)
> +#define COBALT_DECL_OFF64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
> +#endif
> +
>  /*
>   * 
>   * Each "foo" Cobalt routine shadowing a POSIX service may be
> diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> index 00c1aaf4b..11a6e86e6 100644
> --- a/lib/cobalt/rtdm.c
> +++ b/lib/cobalt/rtdm.c
> @@ -542,7 +542,7 @@ COBALT_IMPL(int, shutdown, (int fd, int how))
>  	return __STD(shutdown(fd, how));
>  }
>  
> -COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
> +COBALT_IMPL_OFF64(void *, mmap, mmap64, (void *addr, size_t length, int prot, int flags,
>  			     int fd, off64_t offset))
>  {
>  	struct _rtdm_mmap_request rma;
> @@ -574,8 +574,3 @@ regular:
>  #endif
>  }
>  
> -COBALT_IMPL(void *, mmap, (void *addr, size_t length, int prot, int flags,
> -			   int fd, off_t offset))
> -{
> -	return __COBALT(mmap64(addr, length, prot, flags, fd, offset));
> -}
> 

The LLM is not convinced: On 32-bit arm with time64 libs, this version 
will map __RT(mmap()) to a variant that expects 64-bit off_t, while a 
caller which uses 32-bit off_t would rightfully expect mmap to be 32-bit 
then.

Its counter-proposal:

diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
index e291f50ef..54c028ad9 100644
--- a/include/cobalt/sys/mman.h
+++ b/include/cobalt/sys/mman.h
@@ -28,9 +28,9 @@
 extern "C" {
 #endif
 
-COBALT_DECL(void *, mmap,
-	    (void *addr, size_t length, int prot, int flags, int fd,
-	     off_t offset));
+COBALT_DECL_OFF64(void *, mmap, mmap64,
+		  (void *addr, size_t length, int prot, int flags, int fd,
+		   off_t offset));
  #if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
 COBALT_DECL(void *, mmap64,
diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index 6d826eedf..9dd022a75 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -45,6 +45,21 @@
 #define COBALT_DECL_TIME64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
 #endif
 
+#if defined(__USE_FILE_OFFSET64) && !defined(__COBALT_NO_OFF64_REDIRECT__)
+/*
+ * Make __RT() and __STD() usable in combination with off_t related
+ * services: the libc redirects them to their 64-bit variants in this
+ * case, follow suit. Code implementing the native variants opts out,
+ * as some libcs enforce 64-bit file offsets (e.g. uClibc-ng).
+ */
+#define COBALT_DECL_OFF64(T, FN, FN_64, I)                                     \
+	extern T __REDIRECT_NTH(__STD(FN), I, __real_##FN_64);                 \
+	extern T __REDIRECT_NTH(__RT(FN), I, __cobalt_##FN_64);                \
+	extern T __REDIRECT_NTH(__WRAP(FN), I, __wrap_##FN_64)
+#else
+#define COBALT_DECL_OFF64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
+#endif
+
 /*
  *   * Each "foo" Cobalt routine shadowing a POSIX service may be
diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
index d30b1722d..bf8772f6a 100644
--- a/lib/cobalt/mmap.c
+++ b/lib/cobalt/mmap.c
@@ -18,6 +18,12 @@
   USA.
  */
 
+/*
+ * We implement mmap() for the native off_t next to mmap64(): keep their
+ * names apart, even if the libc enforces 64-bit file offsets.
+ */
+#define __COBALT_NO_OFF64_REDIRECT__
+
 #include <sys/mman.h>
 #include <rtdm/rtdm.h>
 #include <cobalt/uapi/syscall.h>


I challenged it why we need that __COBALT_NO_OFF64_REDIRECT__:

"Why the time64 pattern doesn't carry over

- __USE_TIME_BITS64 && __TIMESIZE == 32 works without a marker because
  the native-time_t implementations are compiled with -U_TIME_BITS, so
  the condition is false in exactly those files.
- With glibc, the same works for mmap.c, which is built with
  -U_FILE_OFFSET_BITS. The counterpart of __TIMESIZE == 32 is
  !defined(__OFF_T_MATCHES_OFF64_T), which glibc and uClibc-ng define
  when off_t is 64-bit anyway.
- uClibc-ng 1.0.58 and later always define __USE_FILE_OFFSET64, so
  -U_FILE_OFFSET_BITS has no effect. On 32-bit targets
  __OFF_T_MATCHES_OFF64_T isn't defined, so the property test is true
  inside mmap.c as well. That brings back "__wrap_mmap aliased to
  undefined symbol __cobalt_mmap". Only an explicit opt-out by the file
  that implements both variants avoids it."

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
