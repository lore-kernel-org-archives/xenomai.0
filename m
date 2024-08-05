Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684F13CF86
	for <xenomai@lists.linux.dev>; Mon,  5 Aug 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893204; cv=fail; b=f+7B9TNLehBAhxA0L+jpxzfcg72uQquyBKbWPemGQh6R85R6MPP7w7mSdaOFKAklVtWAhRH4ZMVa/vhlN028ALdrsC/ckDkV5v2my2OmCaiPVivcDckHeHH6KFpJ0gryF3qlA0UbpE8eJp849/fcRX8tbT/WET00HnnLplTpgR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893204; c=relaxed/simple;
	bh=2nRrVNFoXTOi2kjqf8jjq+P1pEp/tdFziovKRBTDENw=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=JbbraXIYxnvpsqXuTKw2FJSnRjYZ0SojpwVpxhayib4ayOwAAWUjnCVBbVVHqR5MP/13KXJFsuzSl8lVPSgYK+sSCPPrzPHX+yRx7rTr1MrSs+mjdBhGLmhPRyQjIGEVVpu3rgoax8H7fq+g0lPLW2ywWYKYGoh6UqxdJJGhLZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=X1k23F8b; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="X1k23F8b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uncob06YJ6ooxoL/k/xfjclOOQbpjwzoJnDKhjTNj8JDbkdKtso5m0T7f9sqXojzBIV29shpwbx+uShhDbYMJr0hXf2SMbLQDoJSutcOIKYi3BjoFtvvHVoeZQYPuxubbrkn2Om7hnaY7aN7I+rKJ5tsQ0mgkq+cHX4LILwwHSq1uW7cN0Dz3bSEGfs6JachcGwPEbTgx5d93jb4CgQ6B2KVeqTwWS+ZjeKs0GWNq8QCX2PW6fCx5FsSD+eFE/x0mezfor8zcD2XqcEEmjj9lNFjoSgQ6YeLbXo2+SmtvuyAXxGcYGTJKtN8JA2f0k5wL8RQB2aD4cO2cPAVxXFYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOIfGFeiFyuxi7kpmcCuqgu8QPiLrLp9UDPTS9ziwRc=;
 b=tG4qy+QppdYm4S8ip8ZgL7cuf39F2500x1WA7hp7Uz3rlN+g7wO7hkZXG5vCt0wRZPHt0gbE+xFlAuIFf+KRV0o6bi+qisZsSt3DQC+3XXCxMB2NSTHXIDRMlIs44EfShCUUTrsfiiWE0oWh7gB6ays9tVM7m4aYeh9lWkvTTgFitVEZ/WRlLoblJ+iBhhDRX42bG7+dgEoMz/gXt2J9YuCxVIQIg8jwfotOry104eeQ30/QySCpqrjeXoOfTWx/mDpkaHVVZaLGnf36UE27D8R9St+cp5ysRn7oKkVV6vQcZM4PxdIX3JS5+BeUB8LPHllKBi4pnrtXtMPEVyraig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOIfGFeiFyuxi7kpmcCuqgu8QPiLrLp9UDPTS9ziwRc=;
 b=X1k23F8bzxsOHndMw12dOh/lRsS3LbLklIO0IG/j7ymBbvZY1muCW2JLF3mEOo7JswNdRygLFYTIFzee0mtl7N1alIAl5NIAOYYz2u3U6XSQGI/PEr67VPD3Yga3e90YXld1NdojKyNM6y9uWJ9C4D6p5u+ZbaiAxfal+LuuVFKPXfYTzC5geFO40V3LOfp5yX9xblHopB4q1SM6hdRJpU0gPSRgjIEgh8+aKSBlyKK7djhm5DpTGJmLhcJvL1/d81nVkYXqTf/K8AlFXtea7JPTGlti/ivjGbTQRD4qZHGNH+SuMjmvu29mawaHeN4B02nNBSbK/prRkXYE+Kj9tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 21:26:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 21:26:38 +0000
Message-ID: <05a3e07b-a6b8-4731-9b7f-28556f48b0b3@siemens.com>
Date: Mon, 5 Aug 2024 23:26:36 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] linux-xenomai-3: Update to latest I-pipe
 releases
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: c4278534-7239-40b5-1e42-08dcb5954a35
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mjk0U1VkWGFrVHg5S05iSWZnT2FUVnZoU05GNHBhRjV0OVRmb1JSR2tKbStl?=
 =?utf-8?B?dVV3SFlYTkVTOG96NjNQZk16NjBQVkoydTVaUWUzSVlHU1BCU255Q05FRkli?=
 =?utf-8?B?MUxjV0RrRDRoQ2tpM1duVlkyeU5ZWWZkZkgyUitlUWN4VG85K0RVL0RoUm05?=
 =?utf-8?B?Nk0waFVuVDBtVWlaTHdBdmRmUUJ2b09Kd3Y2WXBIWkwwQy83aWRUM3ZxKzk2?=
 =?utf-8?B?My9qTTVoRjBucHdER0hpeUxXY3lTblZ1WHFlcjB4czUrM1dXUUhWbmRvdzhR?=
 =?utf-8?B?aE96R3lDYThIQm1FQjdNQkxYSmFDNFBQU3RaWDlyTEVjU3F3cVJnQXRPL2ZT?=
 =?utf-8?B?SUpQTFlZTEhTdHpzcTQyYXV4TytFRUkxQnVOK0N3VURNeG04OGpwVGkrWHN1?=
 =?utf-8?B?T2lXVThkMzVGSFZ5OXQvNjBiNVp3TExyRlN5OGlFbWQ5NmN1ZEx4NnYzUE5D?=
 =?utf-8?B?REhMQUNZSFRINGdnRmdCWno2aWxybEpGTnprOWhDb25zQjlRckxWTVdadHpY?=
 =?utf-8?B?OWFHV3FxQ0g2eEtCK3FvemgxeVZuWGR1am5HNTN6R3FsWWwwOFRySEhRUVN1?=
 =?utf-8?B?WWdoOUwxbUFVc0pjbGdHSkpFQzMrTXQzLzU5TWk0NE5uVFhXWVgyK2MzK043?=
 =?utf-8?B?eENjWWlrZ1YyMmdBbEtiZmNmOS93cHkrSlNOYUNkSW45UGUveFpDS3QrR3N4?=
 =?utf-8?B?U09rR25qMnBVTTFjc1lxdEVDN3dtMTUzVVBpeVlZZHBYVE1mWVZqQWJpRm9M?=
 =?utf-8?B?aUpuanI4NlZ6TTdyL3gwVVhoemJKOFJ2Y1k5UHBJQ2FHUTFYOXpNSzNOU1hH?=
 =?utf-8?B?bkY4c2FXOVNoc3lTS1FtalZtUmUzUGkrVUM2S3ZrTHpLU2hCNmNDK2Z5MzB3?=
 =?utf-8?B?emdQb0Q2QmNaYzRTZ0ZJZElhRUdDR1JHTlhMNDBHOUFtWWtsbW9TQTE2a2J3?=
 =?utf-8?B?QkZKZWkxcElEclg4eXVKVG1NWDNlb3FRL29TaVFBbGFQSHpJMzNzYmZlZmUx?=
 =?utf-8?B?SFdxMEtQd0dVOG9XRFN5bXhlSkp2VlNSRWxqRUJkUEpCK0dCNGVrTG9HKzh3?=
 =?utf-8?B?NjIzZHhUMXh5MzV6UzdhZWdjZ2FJVWZWK1o2NytKRkFzK3U1c1lyVDRNWWo5?=
 =?utf-8?B?bmdXazB4NnN2TExEVndSWWhNUlovb2Z5S3pTalRDNWUyVUdtVWFIY2R6NTZn?=
 =?utf-8?B?SHBGZUc1c1NCMmdNa3h6bVY4WlRPZ3pSUjBIRTdvSEwvV3Bvc2FaYWJFNUk3?=
 =?utf-8?B?VTU1Si9ySDUyK2w2a1l2Y1o5eEJFZUQ4MGlJTit2ekFGU1hlc3ZORlZKL0kv?=
 =?utf-8?B?U3gwZ3RxbW1yK01XYzQyVnJIZnhLRU9JbXFHaVFnb2FKR2tiaERzQ1FCNnIw?=
 =?utf-8?B?MkdNcGYvdTZrcWdvQXdmVlpGUGlmMDJ3YzUzN01YekhoNGJYT0VPQk5xaHhX?=
 =?utf-8?B?R2lNcU1FSHV1TEZCRHArU01JVkJvcEtoZ2JpRlhGNzMzdndkRk9PNjRxcEV5?=
 =?utf-8?B?ZTNrZWpEQlVLOHJ2V2QzNlQybUhMRk5haGtsSWN1bjh4NDkzZnFxa2hWQ3RD?=
 =?utf-8?B?UWFEbTYxN21peXFXWXBBaHgrV0VRQU9xRkNheE9wVytrRWtZVGRqYVIyNU9E?=
 =?utf-8?B?eFc5QlpXZUd3ZzRDRitjSjU1SVE0SEN5N2NrNE5yVlBYNTB5RFpBTklISFBM?=
 =?utf-8?B?THRjU2tkeTN3cUtBTUxhalgrSGVoMVN3cDFMdVI3cGUrNXMrZTU5bUhpNjFN?=
 =?utf-8?B?MDVROExFRGxxcW95NjZRSGR6OFQzcjNFZitwQmpRMmdROXoraHZZdnhLU2J4?=
 =?utf-8?B?c2ZOeVdvN3VnL1krNVZ2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWtOSlFmM3pTalhMQ1VjcS9hY0FjVFlvQVFNR05Hd05pczdUM2xlVGQ2UUZI?=
 =?utf-8?B?YnpKK3lEejVQa1FtQUtaZHZNK0ZENlVHOUlmdUJxYTc2WkFVaXdZVkF0c0Vt?=
 =?utf-8?B?eStkVTJRaG1YQ2kzbnFFd2JxeXJQL2o1TlArendYR0tZU2ppU2Z4Z25TL1VQ?=
 =?utf-8?B?blYwTWdnMlJFZElrRmYzaHdseEVZc1hhTFY0SnhzOVNmOEsyMTQzVERkT3pN?=
 =?utf-8?B?SE52Vi9RWm1id1ZVclppaWptNEpJdXllVW8yTWVIL093UkU5UkpsL1FmcWNV?=
 =?utf-8?B?eEsrNklURlNqa2hnWklmZXdqV280OE8rbU4zRlAyZ0dpRndtQmllNE5vRHZp?=
 =?utf-8?B?WE9xQkRrNnQ5aHlxZnluREUzc0NvRURhbjVsSmR1R3haWWl3RHNRaytOZHZ4?=
 =?utf-8?B?eEpxSU9rVzRpWnphcmljL3JEc3NmZ0ZCR2F3dk1KR3Z0RnlTQnRlOU5SVUlT?=
 =?utf-8?B?WVpHKzh3Q3JWR2U3a1B1YUVLaWw3NXFFUmZkTEt2a1FOa1M3dEkxUzBPa0RK?=
 =?utf-8?B?T0NGUlJ6SHczQ0kvSG5iR0hPaVpSMDJJVkxiVmpLbit6ZTZBM0VFN2x6R2lr?=
 =?utf-8?B?SUNjOU9TRUVCVS9wNnBhWm9mYWVMSFhwN2JpdGhYZi9FZ0xRSC9aMTBpc3BZ?=
 =?utf-8?B?T3NjOUE2bi9UdzNQT1ZYOTJjbGMvS0hQRTg4RHVwVFE2RDM2Nml3MWs5T3Z4?=
 =?utf-8?B?WnRvRTlEZEJicVg5MHNNTFlDUUs3RSthcXVpZERETFVVcFkwYnpubjRBQlFn?=
 =?utf-8?B?VGxHMERZWi9PODJLNGpQdndRcXlFSnY3QlNCM1NJbldDT0FjME1JTzV4VHlr?=
 =?utf-8?B?dnZvQVpjSTl5MTY3S0dyR3kveU45U001WjZWbHdZMWhSYVU2N2swaHp1Smh2?=
 =?utf-8?B?RGtSWEc1UnEveUc4M2JjOUxrZzNjNnNReXZabFBlclJHZkZSWVdTL3B6MzZ0?=
 =?utf-8?B?WDVyOEtpb1RyV242YmM2T2xOLzhGQUt5aEYxQk1OR1lZRWxxRjVLSGJRUEd5?=
 =?utf-8?B?MHhLMlNVM2h4V3ZRcnJVMnBKZEVOTGNobEYxeDlLdjB3RHVMSndwZ0lVcTlG?=
 =?utf-8?B?OUpXVjdPNm1ZWmtpSlMxQVRlNk15S1hGRFNidTZKenRJVnovSVlCcHVhSEFY?=
 =?utf-8?B?MWpXODFFVVlnZTMxNFg1NmwvZmY5cWJkRDBob05rYkQ5S1lScWphWDVMYWNx?=
 =?utf-8?B?TlpOcnk5RlhPVmgraUdGWmU1cEpNNHdBbVlkRmRzVHBmMUVZNE92bHFXYVhH?=
 =?utf-8?B?dEJhaTZGNTJuYlBPMjlaVEVoWkMzSUtqUitYekxrS01jOTM2V2xVcDE2NC9Y?=
 =?utf-8?B?bG5FT21pNW93VSt0dFhLL203VHEwSWh2bkl4ZEJNdk9HZ1Q4ZXpaSDVlZTRq?=
 =?utf-8?B?MUJmeldSdS9uQTZqM204Vm5QdGNyMHVUR2djM1QvNEs4ek9odmFjU3V1M2dq?=
 =?utf-8?B?ZEUvOUhxWjZkWVpqWmUwa0NQMlJCSjN1R0NiRWp5U29wZ0oxaXJMTUZnWWdV?=
 =?utf-8?B?WlVtdzd4Rkx3MEdHTklYVzd4bDFMSXJxQ05nYzg4Y3EzVUpHb0ZhZVgyU3Rh?=
 =?utf-8?B?ZERRNWtPQVcwM3hUNUY0UHdLNTRwb3EwQjU2YnVkVm1pcEVraDI2NzBEV2Zk?=
 =?utf-8?B?RXo0MWVOT2FKNURoV2lvOVFXTUdWMGhXcWlyellBU2RCd2NtRnNNQ2lJYjJC?=
 =?utf-8?B?SzEwd2FkMkxxbDBhYWc1RDZBeExoZkovNzlabEtXOU90Q0hVamF0UFNaZDJj?=
 =?utf-8?B?TkdQVzBlTGVnaVJHcjM0em9SRWtZVnNOM0IvZmJsaHpucnlPSyt6ZG1DMmls?=
 =?utf-8?B?YTJEQ3cvUEZGS01hQVhqcTJWcmo4SnRaZFhaWFVNZEl1MnRvRFZHTGdjcjFs?=
 =?utf-8?B?Tks3b0MxU1lKZHRkTlA4bUVZcENVV0JsVFlqbG1UeSsrd0hTYlZxMUpVSkJV?=
 =?utf-8?B?RUJPMHRZL0RJYUlBUDROdlYrYTB1OVJHcGdTNWtWYXppaFkxZTBwN09qK01D?=
 =?utf-8?B?djR3MXNxR0IreWZ6amQ3amJZaXNxbXgvYlRia2FGaWdrZjhTb1R1TjdoWU00?=
 =?utf-8?B?dDRpc2JiWTgzRDdQYzExTVYwOWJtOFZscU9obTZPeFZ4RkNQS0JxYUVMeTRq?=
 =?utf-8?Q?Kfw463tGhmvsoyf6uzZC078ir?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4278534-7239-40b5-1e42-08dcb5954a35
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 21:26:38.0709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCmKLcE44MhEasUCSbqw0VrFgzCZFDZKRVoBvoofm4WwBttfinmEXLKAnFrB6sDDXx92Bcy9DevpSxwaJC2zfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8876

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3_4.19.bb | 2 +-
 recipes-kernel/linux/linux-xenomai-3_4.4.bb  | 4 ++--
 recipes-kernel/linux/linux-xenomai-3_5.4.bb  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3_4.19.bb b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
index e6c56ca..298610f 100644
--- a/recipes-kernel/linux/linux-xenomai-3_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
@@ -12,7 +12,7 @@
 require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV:amd64 ?= "ipipe-core-4.19.266-cip86-x86-25"
+SRCREV:amd64 ?= "ipipe-core-4.19.317-cip111-x86-29"
 
 SRC_URI:append:arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV:arm64 ?= "ipipe-core-4.19.229-cip67-arm64-13"
diff --git a/recipes-kernel/linux/linux-xenomai-3_4.4.bb b/recipes-kernel/linux/linux-xenomai-3_4.4.bb
index 09ba2a7..e7a7e60 100644
--- a/recipes-kernel/linux/linux-xenomai-3_4.4.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_4.4.bb
@@ -12,10 +12,10 @@
 require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
-SRCREV:amd64 ?= "ipipe-core-4.4.302-cip71-x86-35"
+SRCREV:amd64 ?= "ipipe-core-4.4.302-cip79-x86-39"
 
 SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
 SRC_URI:append:armhf = " ${@ 'file://bbb_4.4.cfg' if d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
-SRCREV:armhf ?= "ipipe-core-4.4.302-cip71-arm-20"
+SRCREV:armhf ?= "ipipe-core-4.4.302-cip79-arm-24"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.4.bb b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
index 827cba5..5dced1d 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.4.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
@@ -12,7 +12,7 @@
 require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
-SRCREV:amd64 ?= "ipipe-core-5.4.228-x86-12"
+SRCREV:amd64 ?= "ipipe-core-5.4.281-x86-16"
 
 SRC_URI:append:arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV:arm64 ?= "ipipe-core-5.4.180-arm64-5"
-- 
2.43.0
