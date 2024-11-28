Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3952F88
	for <xenomai@lists.linux.dev>; Thu, 28 Nov 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796411; cv=fail; b=oAY3nKBQK31HaU8i5UFJ1/2/W6qvTV49ipvk++BBgOr0vqBtnl/Vhn/YInHCCMBOX6cqS9BEs10Vp3NvehNIkxJCW1SUf/i2qXuCraXdGCyq/XDBvJfQyBiex2so0fsBbCZ4/cnd+Dq2MzKo0ZsB4MIKYSJPCi75szPhrk02wIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796411; c=relaxed/simple;
	bh=TCFc/JewbY5caeXng++zEkb74BmlJKX+4/Gm+xZpYfI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CEArWQXFVN4UlUmLfoEX0FjBQ8WEzu5zt7SOf3P1GJm+reaOdfXg4nbwl8CYAF2/ccLdLL4lx/0zZ8V6tu48V3v9Kcjx8QfQvWkcXv4DBGF1NGDmUml4urbvA36vwFGQXP9xLUwRRnxzs7TdmW2rOgo5QUb/Qda6KvRq6VL2uyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=y3c4Re4b; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="y3c4Re4b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=up5VWp8fBabmVPE2Q0upXrz6FsRes4XiWqs/WlFK79EpCbexYhUj2NRvvxVkgzV9Y97saf/bLWQBRx70+W8jLerfVXUCeKI8zUWzAMA6gL4wF9NksKnj7i8ucq1LRYSaoB/1ljB2AzehxoyoSnH4kWjlx9omvZ2gpRprBGX/1pXoX8iD5CeOnN9HxDu9rYTgBe9XKdrtrUTX9XMRNC6+cPAlwqyWPd0LfKPtN0ZUIuTHMTk7e45yDqUy+bA5ddnAivfGuPZZALWOmGIhC0R/Vl8AbDk9bT67QnKCcOsm0uRcmEsUaZliNu+QmqhC5ZLpgjuqfs3ee0btDi2vv/4Hrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJEzVB/8Mj5xSAK/9STBgffPerCyS+8ltDe6yCdKSa8=;
 b=sJncTFsJABS7UCRrz42VPHy0Hz+O5FYsPNRohlRgGkzB4rTZvcmPzANyaacRieuGUJpfeMRKqSdj/xVSehTMW9Qyf2EkN7cRppYqZdwqgLF32J8hD6FX0pW6spXH1uycacm4bWGAE0OkhvEA8N+vhUzK5za7+4EtJPsFLqyZvl8r7cOoiDpcnm0L2wXTSU2CYsy8dgMNwmjjDPyETnwzZXeVPDwSaJexg8eMkCaBAqssFrLIbdD22AKkdpwudZsUXHWi+MTOX8/MHpeOV/jRqlCy0gHO70f5hez4JUZ1reAf0Zx6e/yScovUL7zKaNvj/XTb8H5j/RjR0+5Lt5ACmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJEzVB/8Mj5xSAK/9STBgffPerCyS+8ltDe6yCdKSa8=;
 b=y3c4Re4boC7oAeF/7POyDm+RRO1JqPIe3O3xOlzqVA/V/IL3A2brmu1Sfi/t+x35HXsEim0VaY7fR00BOptLt1PFXorWJK9ZYCm/GJtKGpy0S2xeewbrgDwLR+bb66E4kstfwavRYSylrnqU+gXsTOiNwI9O300XnwDjmCkY41F2phIGMNtRaYWNKcs0CUgm3oKj86NFF2zrhUB7KkKcdnUUUBWZIrRV9jVoQGgx6Bx5qG9ZT+bZjkxvq07b0kEKJ2bLsk2KQ4CZP+mFXPd4P6c7HRgEdANeVBd5fSJDFzY9Hgr/NDACisu9rGME3YKCDoowUfihU5kjOuT1vwwJtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8379.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.4; Thu, 28 Nov
 2024 12:20:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8207.009; Thu, 28 Nov 2024
 12:20:05 +0000
Message-ID: <804c4640-a65c-47e8-acb4-239421c290f3@siemens.com>
Date: Thu, 28 Nov 2024 20:20:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Community Meet-Up in Beijing 11/26
To: =?UTF-8?B?5a6J5a6J?= <anan@sinsegye.com.cn>,
 xenomai <xenomai@lists.linux.dev>, =?UTF-8?B?5a6L5YGl546u?=
 <songjianwei@sinsegye.com.cn>, =?UTF-8?B?5YiY5p2o?=
 <liuyang@sinsegye.com.cn>, =?UTF-8?B?5p2O6IOk6aKJ?=
 <liyinjie@sinsegye.com.cn>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>
References: <c2b78c66-a2a5-474e-91bf-5c4832763055.anan@sinsegye.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c2b78c66-a2a5-474e-91bf-5c4832763055.anan@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a3f9f2-6176-489a-0e4c-08dd0fa6fdbe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0VDYXV3MHhGT0xSSDh0NlBEbnVJODc0NkNpRXR0NUNxN1hWYTFLYkdXSDdy?=
 =?utf-8?B?TW5FQktjTktNYnZoUFZ0N1dXejNVOVh1TjJWYjVNZkw4MUh2Mm00M055MDh4?=
 =?utf-8?B?bkI0MXpseWp2ZG5tU29oWGs5TENFajErak8rckM0d3V2b3hnU1BpR0I1d1Np?=
 =?utf-8?B?aEFRTHNrZG45R0hETUdGMjJzdGFRWG8zelV6TWVXa0dCTjFwY0FINjIyTnE0?=
 =?utf-8?B?WFJ3eW1IZlpvTTN1aStydVRDZ3UvbEpSZlQ1T1R5NjZiUkQzN0FvK1N3a3J2?=
 =?utf-8?B?N2d6d1hXN3lla2QwdWFSR0lJenRVRm15djJndXg3VkJWNG5wMVkzdmN1TzNl?=
 =?utf-8?B?dGhFaFNjaDREM2d2S0EzWEtCamVseUIya0dLNHNiNFpQdXUxakhFdC9TbWtV?=
 =?utf-8?B?YjYzQzRzS0o5emV1RlprTHFEVXEvdkdjM3kzanQ0d3VVbjhVMkhNRksvMHZ4?=
 =?utf-8?B?NTcwZVdBNkYzV1hob1NPdDYva2VtWC9YcmowcDN3VU94L25iZml2RU9mdCsr?=
 =?utf-8?B?QXZLbHRaRE1mWW1mb2VaVUQ1SnNud1Z4ZXhiWmFqYjRNNnc5VjNNbytVeWdE?=
 =?utf-8?B?RVNWcG1sbjF6R1IxV3dEL3Z0OVhZZzB3bzFrUW1lUlNXUmwvZC92YjNlZGQ1?=
 =?utf-8?B?Vi9zbmhVa1lDVzNoTEJTNHhOemtXcWY2SHl5L3dEUzNxeFliU0s0WUtJMDht?=
 =?utf-8?B?WHFzWTlsT1Mra2VRZ29GdVRWcDQ5aVRhdXJ4RDZzY0dJSkZ0SWh3aEgwQThX?=
 =?utf-8?B?a3E3ZDRkSy8vL0MxbnZGa2VHcTQzV1FEUGZBSTA5MXFFZGVJcU9JSTNsUHM4?=
 =?utf-8?B?V0Y5YlFwMWhGTnU5YjIyWlEzNlFQU3NqMlNFdlhNczlGVHFWLytabG9zQVYz?=
 =?utf-8?B?YXhkd3dwWGlTaHhhdHRqUk9LQUVEMWF6UnpvR0hobktxalJGWTdxcmxEcFcv?=
 =?utf-8?B?MmZBUUREdXIwQUlOQ2l1aGw2WXZpbkJ6TEFRZnZkcjJsY1lCaUpSWWpMMGkx?=
 =?utf-8?B?MGFDT0YwdE5xZFVpWWRTUFZ4VlR4Qm04VEQ2TmFESlF0L0tFdUpKU1V0bGp4?=
 =?utf-8?B?SzQ4a3VTRGxkeExqOHphVnJhWEQ1RmtXL1B2SVVGVlBpeFh3dWNMVWhPMGw3?=
 =?utf-8?B?Rjhld2lKNFlxSGpQYXZuQnkxeHAvMmprNTFWRDJJd0oyVnNnUk5RdytxMHlh?=
 =?utf-8?B?eEpnWDFtL2JhYkcxSm5wNnNqM0RvNTI0eHRJSHlPa0MxMm80U0tPb0lGMm0y?=
 =?utf-8?B?NThsdzZVNmVGRm9uSTVSQXFIQUdSWHM2R3VOYnMrekFtMzNuWEd0OTBITWZH?=
 =?utf-8?B?RnJpK3gvZXQ0djJQMXdZR3B6ZjJLN0t0dkw5QWhpSGQzdHN2YW81RWlCcTdo?=
 =?utf-8?B?ZDR5WDFwYVU1NVVDMFRibmdaZ2VhNUR3V0VwTVorR1A2Uk52NG5QNzd3S3FU?=
 =?utf-8?B?YnhtZHRsZnVNbHNvMVF3alFURU03Z29CUGhRbnM5Y3lFdlVJRmI3SFBhTFU3?=
 =?utf-8?B?L0hydkFrSDVxK3FBK1ppSW1YbkFCWUkzY1JTWmdYZ1J4TG5SV0lyRWdJdmVl?=
 =?utf-8?B?ME1tL3p1OGwwT1M0aCthNzhmVHJNSVFqVDZhd25wUHJOSFl6cWdDZ0pGYVVm?=
 =?utf-8?B?bEk0TWZ3a043V3o5Z0RVa3RHdW1oZS9VTXZoVk1QSWNWWjlnZFNyZHIrRnNq?=
 =?utf-8?B?dktkMzFzV3VvRzFDRVYydkV0aU12RTduVEdHNmxpMXFvd05aUmdZZGpFWlFt?=
 =?utf-8?B?VHkyV3F3NUZFaGVxVkJ3djhteFJuZnQrTkRLdTJaRmJXRUczWDNrNEsvemND?=
 =?utf-8?B?bWJOTEo3UW1BQnpqaHQxdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2h3L2p1cURaandoaHY3dmZqNFJJVUQ4SmVyZ1V2Q3JobWdjejJkdGJpRHBu?=
 =?utf-8?B?Q21yNFBwUEVPK2RUYXRWV2hweVZZRklNamxYQTcvTVcwWHJhejUzYmFoRk5N?=
 =?utf-8?B?T2UrOE5PSGlNS1BUVFRyTnd6aDQ3TG5hM2VJVktPbDV4WGVmb1NmckdwRFhh?=
 =?utf-8?B?TmZtU0RoU3pWd1lWUlpOenFmYktFbGZNV05ZbUw4MkN0WHZ4SnlIV2ZKa1Jl?=
 =?utf-8?B?OGJoaDE2OWpNK2VYK2F2eGcwZWVZOFhzZ3pLNzBtM3BiaU8zeHo0UWhTb3Nj?=
 =?utf-8?B?K01aNlFHL2YyVE5QMWpMdXJiNkJoRVBteVdyb3k2WUxxVDFtR2V6RWVrVFhC?=
 =?utf-8?B?eGVNRGQ4aDR6cXpUc3h0T0FvdzZLL3BSSUlueUl3cnVCNW9JVTJlREM4ZGZT?=
 =?utf-8?B?ZDVYanQxSUljSVVYTjFoakhuL3YxakhoR3hyOUpDTkQrNW1yVXJhVjEzQ3VN?=
 =?utf-8?B?Rk1RM0RwUFAxV245a0c4NXh1VjJRVGZjZHJFakRsYjc4YTNTdTNPQWEvOVRm?=
 =?utf-8?B?WFY0RUNoV3lYaGh3RXdvaGdjVEdKVE1PVDFvVjZYMWdLRWYxb2k4SzNRS25l?=
 =?utf-8?B?QTA2SUx6TTU3MHA2dmVQSWlLQVBVU3VHMlVtSUp2dVV1QkM2SUhRVzlCY01U?=
 =?utf-8?B?YTJCOS9Hc3gxUEF1WTVsYmhwTjR5bFc1TEZGNmpXNElubFZXdmd4dTNKRUcy?=
 =?utf-8?B?SEV2b2FWUFUwWU00R3BGYlZkZlgxanY5TXIzdWhpdE9ZSm5ISUZISmRxKzJS?=
 =?utf-8?B?VEhqZmVtYnBxcUpKV1F6czJFZ3VTT0JaR1hGK0NDUHJKb2YwaE1ndk4zT1FF?=
 =?utf-8?B?MEpQa2VuazUwN1dXMGZaSkl0UWlQWE5VcWMyaHpKdVFTMmtHM2ZOL2ZTdnhw?=
 =?utf-8?B?b0xJZ3hqdkI2OW1Ubkp2eWtOTEZzOWxJRTE4Q3kraFdiTUVpMG5YcXEyT3N3?=
 =?utf-8?B?ZmIvK1ExMGorejFkcFZ0M3lKSTZ1ZDMzR2tUNWlQdEh4c082TmQ5aTBtckh0?=
 =?utf-8?B?ZTdpUHJCT09Hcnh6eHpZdTNyaXg5a3hnZjJGYjdQRDZHQ3QrMmJKZWd4eUY5?=
 =?utf-8?B?Q0NSME5xR2FMd3JCaDBXL0VBMmh5WXJWVlA4ZUg1NzhncE5BeW1GRHpsUWhT?=
 =?utf-8?B?K3pRN1RMaWF6M0xOeDJ6Uk11QWJQMjczOEN1cGEzMGI0WEFMSURoa2szdGVZ?=
 =?utf-8?B?VDVFRXMwM2xrNEIvWEtwczQ2bnV1RVdjV0ZqMzRWdUZ3YmNkT252SEY0VDJZ?=
 =?utf-8?B?UnorcW9oVmM2TElla0hQQ0R5VXBqRHdPZHZlUHNDa09aTVM0d2k4S29ZSmVY?=
 =?utf-8?B?T0hlVFg4S2pVT1BxSE9UZ09VWXdGTFNPTXFjMks2WHJVcXNVZlpTUnpKTVNE?=
 =?utf-8?B?eWxHT2FzR0NsRjZ3YmhUVnlEZVlpeGZYSUVvcHQwMkhZWkNQbm5udnRCR05Y?=
 =?utf-8?B?WEcxbnd3Q0J2RGY2bmE4a2JxZGR5STBSNEZFYzYrcTRlMTFUaHh0VnBWMXBX?=
 =?utf-8?B?QWluN2ZBR1NXSXduM1YyZU1tcGVNUVdkczVLUmFzcCtZZlFZZEtCcjFucWs5?=
 =?utf-8?B?R0ZuWkI3VGd6SndxTjM1Mzd0TThpV01HUHpzMSs1akVadDFvZnJWNkRNVVVn?=
 =?utf-8?B?VFBvNDhEZ2hCTGt5cnZocWRFdlNIaFByYnF4TWNIMVpHemlIYStPTldQd1dL?=
 =?utf-8?B?Y2xUREhlSkF2Y3QrL3l3d3cyVWpFR1pNQXhYKzR6MEg3eFVreG1MMVp3eldP?=
 =?utf-8?B?MEIzd0JZSll0QklFZTcwYWozcUhodTk0bmxRQ0VXa09tMXRqVy9VanN3QW9n?=
 =?utf-8?B?ZnhRQkpVN0J4RXJNc1B3b3F0M3RPejNnaVV4L0QwaGIzN3dvZlUxQjEySTlu?=
 =?utf-8?B?RUpYUlpka3dKY1pGZWRydmt1Qk45ZjAzUis0TVR0MzVjeG9kcUx2NVlwSnl5?=
 =?utf-8?B?RFhmemNGZXZURjZydmhqSHNKSndXclJxcVZ6UE1aRDlmMTNJOE9QbGQwR3ll?=
 =?utf-8?B?TUIzeHVpdGR6QzhORFhsaVFCQTROcXpFZEsrQnBTWFdUckpyVjh1TTF1M0Er?=
 =?utf-8?B?YmRBenpYY2ZIdWk4YzIreHBsMDEwYk1GS2c0TGs5SDVlaHhway9wZW9DbVJk?=
 =?utf-8?Q?X8r23rgCpt6arGjDf252W6mhJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a3f9f2-6176-489a-0e4c-08dd0fa6fdbe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 12:20:05.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dohjhAvSSdvlr0asRHuIYyjEqd9ke9df/JaC4qpb0XzHR001usJR6/by0l9rr2Iw/kL8lQb8PykzKOB7HC6DOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8379

Hi all,

these were (and still are) busy days, but I would like to finally
express my gratefulness to our sponsors and organizers of the Xenomai
meet-up earlier this week, but also to all speakers and participants. I
personally enjoyed a lot the presentations and vivid discussions we had
at the event! And I'm looking forward to intensifying our collaboration
in this open source community.

Cheers,
Jan

On 06.11.24 16:28, 安安 wrote:
> The Xenomai community is planning to hold an in-person meet-up, gathering with speeches and live discussions.It is scheduled to be held at the Institute of Computing Technology, Chinese Academy of Sciences in Beijing, China on November 26, 2024.Everyone can attend for free by simply registering. More details will be followed.
> 
> 
> Xenomai社区正计划举行一次面对面的聚会演讲和现场讨论，
> 计划于2024年11月26日在中国北京中科院计算所举行。
> 每个人只需注册即可免费参加，更多细节将随后公布。
> 
> 
> The meeting will have on-site translation and recording for sharing later.
> Xenomai maintainers will providing the latest news and plans and also will have Q&A and open discussion sessions afterwards.
> In addition, we are also looking for speeches from the community, in either English or Chinese:
> -How do you use Xenomai?
> -Are you doing transplantation or extension?
> -Are there any best practices to share?
> -What are your expectations for the future of Xenomai?
> 
> 
> 会议将进行现场翻译和录音，以便之后分享。
> 其中一项日程将由Xenomai维护者提供项目的最新消息和计划。
> 之后还会提供问答和公开讨论环节。
> 除此之外，我们也在寻找来自社区的演讲，内容中英均可:
> - 你是如何使用Xenomai的?
> - 你们在做移植或者扩展吗?
> - 有最佳实践可以分享吗?
> - 你对Xenomai未来有什么期待?
> 
> 
> Please send your proposal, including the title and a brief summary to
> jan.kiszka@siemens.com and anan@sinsegye.com.cn
> 
> 
> 请将您的提案，包括标题和简短摘要发送到
> jan.kiszka@siemens.com 和 anan@sinsegye.com.cn
> 
> 
> 
> Important dates:
> - CFP closes: Friday, November 8, 2024
> - CFP notifications: Wednesday, November 13, 2024
> - Schedule announcement: November 14, 2024
> - Event: November 26, 2024
> 
> 
> 重要日期:
> - 提案征集截止：2024年11月8日星期五
> - 提案结果通知：2024年11月13日星期三
> - 日程公告: 2024年11月14日星期四
> - 活动: 2024年11月26日，星期二

-- 
Siemens AG, Technology
Linux Expert Center
