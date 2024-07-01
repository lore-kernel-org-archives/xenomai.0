Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228BE6BFC7
	for <xenomai@lists.linux.dev>; Mon,  1 Jul 2024 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818660; cv=fail; b=eVa1DxXs4p5WtbPpXJJdcaa5uq2DGbo8kF2ZVommUYUXz2KczN8bEkrEfctL9glkVKwJck55xrNLWPSrAZ44JU5GwD0Ce+dH0frGtotMaPPcUtHB1F2XY3H89s+NWamWkIgYA3bElrq29Y4VjbibAmveryLz1tJRCSfIS3+loqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818660; c=relaxed/simple;
	bh=twmBHpvICJRlfOu1VmKMQm+G0J3aASCGwJsI9es+Jfs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V9JmM9zcN63WTqDQhFxLJPZhaEH9lSUZa0oJnNGm2XIk60u8OBltrlxrbjj9NHggQhnEExNObP3LrTz0MLsPWQ7XUWQ2H5LaC1UckVYN6TFRbSkp4NFndlXlk9aipDd/4fdXoaiaglcunA3e0iMeO/FouVz+lCE+TvFpuJWOef0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xuE242nn; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xuE242nn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axzmT86TEgVjttEwQKf3xBYUkBh6U7ih8nPR+sDMVFyACAvf/w9SsHAHg28h0gaoAuxfsdXAb60Uw3hoaQZ8joZDbq/vmKLQrZdOS5HJ0lfXj3dQhSJ7IwgW4h39ye554QvcJsaCsCJk3fB5UjsnTA0CIYE+hVGnIDsGxf6yh0qLsS6pQ7lHqugOiAJbPpVTmDR0cYzhQ5z2BGPOPjKd4qRpvOL7eB3myD6Zr/n/l44uUxf7HcP+fjEbiQslsAKgPKwwcY41uHZNP9F410G1zViqkJD3gPEuEZTdL0UkWatiS7wlZyVPvoYewdQWZWS1YG2yIiNJONw02FwVOCSP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTV5DdD9hr6COnRwfykGTY8ZOndKHHOdTQuDMo3jQ2c=;
 b=cTlaxX/DVlS+mPtlxFRefYK2/nvI7ObkcIopnIFPOZrQ0qlR2S5k4IIHTh+cwJbampof1dlkbKlNz4SK0HfqDlw9grC5kV2omvTeelINavylyeE98hLeEjTksa8tkkJr9PWfjdj27JIAFR0vVkAe0rmWMrDuCy0X8KqHHxpca0yFegQDCcVtf/CUuKKd9fAynCr8o1E8zF5+jv/6cWLn/dsxzXjAk56OB1edm/Wl6f4D0+QmHM22l4md9cafznfZQ8JRsu48s0PD3WIgyDADfSb/MaNgo2r2WuIFnEDH3ASURUvNszprHvQswcPPbYVCeQuI5QxhDUlODRXPckesAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTV5DdD9hr6COnRwfykGTY8ZOndKHHOdTQuDMo3jQ2c=;
 b=xuE242nnkiR88LJQZmhHscKqNTfuc1TlO78LdSYxJuJb6ejWieNucMIbHNnmFRE8BCcks7UBZ4dxVCQyZjPpH2t6yfrBVB5Q5fcYYkcVbk89grVSaeKKzp0e/zcVgUV2Op7xiOwR0P/XVlyqttipty6xK3wPjkt73D8Ew+ZaTbEntAuANhEqk/bIRFFTpTtbR6ZViRkM2crOe/lCAZTV7YKRPoSX86ZhIFo3Ow7R9wzXt7LzBj5MrpnUAW0moEYQyFCgkIgcaE7ShFc1mP4ps/WT/ZrrakCme7dYdD9ub3Kt4slPZhO9Y4AvGn5Ks3PLSIN2YcZtWmraKnj8GFxThA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3480.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:132::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 07:24:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 07:24:11 +0000
Message-ID: <31c548fa-5b73-48d6-952b-2233fb3f0ea1@siemens.com>
Date: Mon, 1 Jul 2024 09:24:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Thread safety of cobalt syslog/syslogv call
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>,
 xenomai@lists.linux.dev
References: <10fc-66825100-3-27de53c0@198494754>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <10fc-66825100-3-27de53c0@198494754>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3480:EE_
X-MS-Office365-Filtering-Correlation-Id: c1839c1d-8521-4a0f-d4df-08dc999ecda9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0xkSWo5a3pJWkYvNnVVVmZTcUtKOEVZc0htSXNFL1hZRzZ5OW1TSE9OM2RF?=
 =?utf-8?B?OXYyUUhqemQ4RnpIR2t1bTl5d0Myc3ZodnE3bGI0TzAzWmpmWWw5M09xa0g0?=
 =?utf-8?B?aXZscis3UC91WHZJWGlBeTdQekJkUzdZVkFhUzlhQjVRWmRqYjRxR1FpQ054?=
 =?utf-8?B?N0wyVWRBRzFDNTZVUWJvM1RjUHQ0R2RkeXd0M09QODNvM1h6TUlFckY3Wjlt?=
 =?utf-8?B?NlkwS1ZuYVBULzYxZXZ2ZHJsNUdvVHNreDE2RHVkTE1lVk83MmYxV1hYc1J3?=
 =?utf-8?B?YlovMUtRWTJ6cUxyV3pRUjBWRCtKSFgrRURaMU9KMjVQU1VKSGt6VEgyZDB5?=
 =?utf-8?B?cytlUzJkTTY2aU1lRkt5K1BiV0d3SW04NGRtUFJyVTBpUzZqdkFXa3dhbGdu?=
 =?utf-8?B?L3BPZ3hFNTd2NWRMVU0yMkduZ0d0bWZSdjJoOXBycXcyRW9ZZzlGMzBBaGY2?=
 =?utf-8?B?T2llMXd4Wk9zeFJscUFMUG5kKzkzT2lVSmV2cEZwR3lVdHA5VjdJQUxiVVFl?=
 =?utf-8?B?NWtnYlRWYzI0ZUFkYThiY3ZkREJ3OEE0clo3UVJ5Q09FWS84cXU3UWRRNE1U?=
 =?utf-8?B?WFh2NEM1akVTUVhxaUtHNGh5alVGeGJSSzhxQnpDaXNqTTQyNTdpdFZUeFVt?=
 =?utf-8?B?VjFFRHlDMmhKQzVyc01Wdkpuek5iWTFZUDdVV01OTnd3MlBENXVVYVYwb0ZT?=
 =?utf-8?B?dm9LVE1OdzZiTk9iL1VWRU1aTEsyNjQvTW5uLzNXUFhwRkFCbytXSmxOMkpx?=
 =?utf-8?B?OEU5a25ESE9mN2JEUFV4YTVyMTJEOHVaMDdzd2ZoUDZpWGk4cTlIU2F6MENs?=
 =?utf-8?B?Zjd0dVREZWZqNHRSTmZ6a0d0SHJaS1hoMzZ6eWNXUXRuSHRGbjRkejNvWFFV?=
 =?utf-8?B?QlRZeVFFbVdYRDk4cWttMFdqenFkQWNSa2l0b2R4bmRocWdFZG5SYUJ6K0Nt?=
 =?utf-8?B?UHI5RkxySDMxZkRHanZzTlZ4YnJ3QjNuNmQ1bHFUcGUvQUg5T01zYkNITjFM?=
 =?utf-8?B?cDR1TWFqdE44RHpFYmYrMHpjMldKVjdWWFRFLzQxZWl1U2ZxbDdiYVkveWVZ?=
 =?utf-8?B?VWR2bkRuanBPK1liZlRzTnE0eFpWcFBVcGpzUVlZU292OEVtc0VIOXBKNFVh?=
 =?utf-8?B?YzlvdnhHUlVjTG45MTh2UDQwVUR4aVRWMUNqYi8xVVVwa1NUTUIvVXZyNDkr?=
 =?utf-8?B?REwxdWV5REcwMjM4VjZhR1NoR3p0aS9FM21tcWlZWXUvYTByK2hBNm02TzRX?=
 =?utf-8?B?WUo1MExDZk5ub2doc0txTm5VOVBJcU1UTHhRM3dyNUZHcnIwUTg5eUVaTDBD?=
 =?utf-8?B?eURCMzVnNVNDUEtoa0VMdkNRbG1VbU5KRVlrb015NzVvalJJaXBqb0tFTzlI?=
 =?utf-8?B?dnpuQjdMdlJnbCtqZlRpemNuSUN1aEJJelk3cXlLakVicGZCYzRyblpuNFZH?=
 =?utf-8?B?UkFXeGZ5L05DNG10VXZLQm9TejZxbGZXeFVzQVIxanQ2K3BQMmpSUE40Q1Vw?=
 =?utf-8?B?VlliTTZydXpVOHp1d05rQ2J1OXR2UVJLakRrd0drbElBN05Iek9oOFNmR0x3?=
 =?utf-8?B?elNQT0gvbXltNkQ0MVkwNkdiampPa3RBQkVsOGV5TmNaR0RQZC9PYnRtUTdl?=
 =?utf-8?B?K2dDd1hkdEZ4S2d3R1NBdVk2eEZIbTZUQ2FkNkpQbTEyRUZ6UjJqRDJ1cDVh?=
 =?utf-8?B?TnBzb093UzNBUXhQZ0ZzbjBSdnJCK09YNWZha0xrMVdCdFprQnA1ZGFkT1FT?=
 =?utf-8?B?YTlSZGE5eGpwMzN2MkdaVW5lUW44bGkrcG1GQUQwb0V2Z2NPc0cxOTFIZlFZ?=
 =?utf-8?B?UjZRL3F3K1VFaEpycWN5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzlpQm1obG4xVEd4amhrRktnVjk2R0c0bExWYUFMdklINTN0QVByYjA4RUhO?=
 =?utf-8?B?SlNhdGRxVWxkUEM1dXgvM3ZBWVVLeFZZNTQ1V1VoYzc0UXpzdVRPSHZGWHNW?=
 =?utf-8?B?Z2ttOG00TGgxNU5CNUpkWVovZHVnakxFejQxWFlMQ0piaG8rQnZZNkhEcHdk?=
 =?utf-8?B?K0c0MTdZeGRCWUZhNUlTM01GQksxNzFNNGFIM3E4UitMK2ZpQTViTzBSMUNo?=
 =?utf-8?B?b2JrYW9tY09XL0JEVWM5MWlXalYzSC96WTZjME9CZzNjMFZRb0lZb3ErcWVO?=
 =?utf-8?B?a1dRZVVFY3kwK3kySUdJUytvelVaYy8xcVloZGZNQllNanAyRFRaNjZLOVBl?=
 =?utf-8?B?ZFp5QXVUZ0phQ1ZUcHB3by9PNXo5SXdWWkpSNlRuYVRiaXdKUEp6eWVpYmpU?=
 =?utf-8?B?WEZkcVFaUStTcjl1Mi9IOGhWdmVjVE1nSTVvRXJ2V1pRbGRpcUZpVzJpdEVI?=
 =?utf-8?B?b3JXSFdWTEM1YmJ1bE5MbWNGMThxRnFzR2JiZzZmWE1OWXdodjA1bEllemI5?=
 =?utf-8?B?blA1a0FHY1l0VnNraytIUXBNMkpXKzg2emdPN2JaYTFpZDg4MGw1MFl1Q2FJ?=
 =?utf-8?B?azFQTEQ1VGhLWGtIUjVKWlNCd0tVcXFwejJrTWpidmE4V0VzVmMybmxoalc4?=
 =?utf-8?B?N0QwTlBoUnZtNEhtVEZEV1Zycy9EVjNkYm9ZWmNUTTNMbXVvcjBBMjJ1dTB1?=
 =?utf-8?B?WG43TlY1b3E3dnRNdE95ck5iNk8vaFZRM0JFeUpZbGd0YU51NExKRXpVTnBQ?=
 =?utf-8?B?UEN3cjFNWm5nL1FyZlcrR09aaWRFc1NwbmJLSEIwdEp1aDJEZ3M0WE51cHBM?=
 =?utf-8?B?ZlVaQnpsWTJrUnowOHh0cHQxMkNhdVBEbTZYNHpab2JVU2dmS2RtdzlZVTlY?=
 =?utf-8?B?Q1dmL21pTnFZUlE3NWo2b1NkOSthZE1xTG1jWjBiTnVycTFBZTRFTENyTUMw?=
 =?utf-8?B?S2w4ZUJwdS9QcnVJL0puQitrYms5aEtneDA5MW83YU1rMlBNY2JhR0JNWmRx?=
 =?utf-8?B?WFB0MWFDWUlaVU10TkY5ZlhWQ2crcGRyeWNLK0Y0WURUR3BoVkkySU5mM2JE?=
 =?utf-8?B?Sk5CM3MzTkI4WU1ieFI0VFhqTm5aWWllb2V0Ui9LQVNDdzQvUVJsTTcxQ0I4?=
 =?utf-8?B?ZWgvb3RaekF2UUxwK1h1eTBFV0RKSkxtTFRKbFFEaHNCeXh2TGdVZHhqUS9h?=
 =?utf-8?B?a0wxQkF4Q2luUDFyWlp3cXlEUjc0Z0h2Y1BvdzBzbEhVME0zbUorOUw0VlZw?=
 =?utf-8?B?ZG1LRk00NnlybDd5dGJ2SlRzZ2pwcVdLcXdZNktvb25Db1pjRTZVak1nR05V?=
 =?utf-8?B?MjRTeW9KUFFrMThtc2p3bG1COTFiQjkrOG5GaFVSbXdtRmYzeGlweFVIZjdn?=
 =?utf-8?B?MmdLazRjRERaN2FlcDRuWXZVaTUwZVo4WmVoS0hBQndmUmJXb1F3bUJtN0tC?=
 =?utf-8?B?YzNWRk1XeUZKUlNVTXBzQ3ZDUHpWSnZpRzc5Wjk0MGFkUC9KL0Y2TjlpZVY2?=
 =?utf-8?B?THRHN3BmdVo1UEJURUwwL3VuN2xjc0MwWEtzR2haWU4wT1dDWEN4NTlRMGZH?=
 =?utf-8?B?RC9KV2owOUx4bUdrYi9YTTFIZVF0cHdJS3hjdUk3SnA1c01ST2U1RDVBMTZT?=
 =?utf-8?B?Z3d4Mzh2YlFmTTZoTVlOWjVVUUczeEgzaklid3lrc3ppaE9SV3VHVmUyTHZT?=
 =?utf-8?B?NDRYb3BLVkRmSGVtOVc5bHNxb0loS3ZXYjNrSGhDZU5Sck03VXpEWTRXK3JB?=
 =?utf-8?B?b0pXUXZlWUVxQ2RDdTlWM05rNTNmbXJzdFJJWXllOUdrYUxCeFVKRnU5WFpw?=
 =?utf-8?B?VHVRM3VxOEpKWUYrYlVTZU5Lc3dvbzN3MCtHcHNwS0JxZ29yd0NyOVBMVGY2?=
 =?utf-8?B?MWJ3ZFhqOGdobS93Y3Evelp2RC8xcUZWenYrSFVzTlRBcVZkWkxjNnZpRlE0?=
 =?utf-8?B?RmxxazFRODkxQU4wYnFWcnJLL1RzVG1DWEJDY2VzbUxNQytEMU8rWWFOTVRF?=
 =?utf-8?B?Q0hxWmJzVGFqekQzRVZPK2tLc2Q5UytraTNnODVGS2lOdWpUb1ovalNsWDBy?=
 =?utf-8?B?bTc5YytXSUZFNDVoSW9KeWdibXE0Ly8vSUJSUkxIV1FNRXFMbkZaQlBNZzhO?=
 =?utf-8?Q?kV3B7eUG0GHhB4X3VN5sCnAKd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1839c1d-8521-4a0f-d4df-08dc999ecda9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 07:24:11.5427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EUOg7REQ1AqJDkl0BMQHDAwxW0nufwgHZ7Mm3i8syQXy59Pp7Cfqht7aQn6oxsZrq4UWY4zbpllf7G9kBHGZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3480

On 01.07.24 08:47, François Legal wrote:
> Hello,
> 
> I was wondering whether or not the syslog/vsyslog calls in cobalt runtime libs are thread safe. I observer strange behaviour in my logs under heavy log load.
> 

Can you be more precise in what you do? And which parts of
lib/cobalt/printf.c you consider problematic /wrt thread safety, the
printout to syslog or the wrapper functions themselves?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

