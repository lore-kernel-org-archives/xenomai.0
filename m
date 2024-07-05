Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51915B98F
	for <xenomai@lists.linux.dev>; Fri,  5 Jul 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187820; cv=fail; b=L72AuGe7AWfL6lTCFZprxalQVv+ustgqP9ow0dLYip8bWsBGlLT12BEk+WIWznlei4lP4D7uECgeRKta5qXIk7yCrMpVNqrMqRkDG45/7k86uj4eHWT9i0WroBeD3DCmUdK7WAhE156aWqZPP/YvoCEY9xhRJ4M9JhLdmzukVrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187820; c=relaxed/simple;
	bh=femHJ6Shh20v5ppSzkMV4kQPmppLzQVUzDV65AEAxzQ=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=MM0LzhCsCAM31MBTBtVOcR9lBYSrVdDp83NBIvQKT3B2sswsxrP2g7j3FB1C8HojlywZoP9yRTuMDSDPq1SzHoj6iPMXPeUpg6gVpLjYJr3XzzQtJ9FKkS2RQX6h/zYOOIkYaZs90VsCydHiUAPQ7EYTQqDdMdolMFqKOxlz/pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DHcs8NDC; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DHcs8NDC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkpGvbOX/eUTNFUCg2AR6pKNKauwwI8ujjN08CeqqfwWjYWFvLa4In2FMhfUpgsJA1qbljSt/Gq8h+hI7XRdroxxt2FjVqQZnszJZVsi8ScsLGu/YWcFVaD9B2odqm1h3IK8dYKV5iMEo4vQw40tQd1GAcWdBRKntEl45mu7gRp1PZeMYTJyrTAovu4rKjZZfKzHNg1JdpDvfffm7VR498JvCJMyj+Sw8GIK0XY5RTmMUKW5juT6CVqOm8McIZrZbvxK9uG9zXDr4JlMWnpERQjRTeLKn83k5VOjqe9hVK/6XsQhiY8nhvs3O4VP1tusNMKGA0uBk7Ov2CZzqdEz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvWQ+2Jx8bTgPwFq9zOpXSRM29mNYUvDgo6gDxqlZK0=;
 b=TweM2w0CYasp6iDKAuWmRkZBpV0KJzGJMphspP8jtm7ePFdSYjPibYs7esF6/gFs7GXboS2aquLxNqgbZWHAZaaAyxze7mpvjHoZfMeK4eVWp2lBndGJ0s3HWcbSW/Bfqs0OWLmg61rtmpmgD00KhK9BPDCAtEeeY0PSUbAWz+H9Bf19S/rw+uravo2/jxHEMmx7VmY2olnW/9eEHvknAsqdF7zAx4xdSXxBcCCe4JuuyBOsxAvJpqbwFWoqSpfqyVSDcfBjAcnqoAaGC4LgbxVVLvfE8r0kTTte4WQdVgGN3nUmS1r5AFv9a5+jbGiVgplpzxS/z9t9yAedPvzn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvWQ+2Jx8bTgPwFq9zOpXSRM29mNYUvDgo6gDxqlZK0=;
 b=DHcs8NDCLPWpWxVm1VwSQrEvgg1bgIG9Wi1OoAp3Xw1n9UST7KikCI2vOi83pk9ePOGxuh97pDnR5aqfewGw7m2HKO/0pfhM+Sl2T0oIi2xKsyQt+c11NjxMSkGEWHgZmrbV5h2R/fEt2zjsBr7PXQE3K0fd+iw4dswdMm8c15X0IofwkIquT3tsG2tloeKwyfXx0acCHwABfk33fncA07jP2wJhENrsEkASbbfIjR8VhcddW9ts3qpP62ZGwIn2TUXMbV9NqaXcAhSP1YJqnGiHbsMq4NvlBLcexVVw06xKkDBycxXWJZKZJEc1//TRk/V4Kns/9AbW3H75cvn0ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6507.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:567::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 13:56:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 13:56:55 +0000
Message-ID: <8c2fcb29-5248-4bcb-a6b8-c115af35407b@siemens.com>
Date: Fri, 5 Jul 2024 15:56:52 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] scripts: run-lava-tests: Improve detection of
 failed jobs
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: d17570d5-8039-4f2d-69de-08dc9cfa543f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUdLS2JPM3Ivdis3RHEvTE0xZGdhZjB1NFRHdmIyMDNZelMvSlhDYWRMNVBt?=
 =?utf-8?B?NW5zRkNZOXBUOVpoNkhLLzVySEYvZnFvRUVheFVzWEx1YlFjRVpXZVhOWnpW?=
 =?utf-8?B?Ykhad1FzZFh5VCtLTzluRXM0RlkrZTUrN0Z5UkEyYmFBQzBORVBEb21OZkRW?=
 =?utf-8?B?Ym9HUW16dkliWm14YVc2ZEFmUUwrek9JOVJUdmNmNEJyK01QcFBrbWtRYTVL?=
 =?utf-8?B?eGVaTkFaaDIyZlE5K2RtVjk0Y3VCQ3d3OEpPdTZCUnVFY1BHZnNIRTZMazZE?=
 =?utf-8?B?dm15SDViSUZZYy9ObEFESi9TTjYveWNGV0p2dHlvaGxxNzJhaEptUzZjU3g0?=
 =?utf-8?B?Y21JMFlSMFR1b3kxTVkxWUdFNUxXUXRwajFYeTdFb3hsbzUzQmY0cmdTSDJC?=
 =?utf-8?B?Z3Zuck5nbm1pazlJekgrTXFsOTZqeTQ0UlVqUmg4cFhuR0llVnYxNm1XWUsw?=
 =?utf-8?B?WGQ1SzFYUUpQVnIxRjZxc0MwWmNnODhkWFdraVN5d1FoSHV4OEFhVTMzSnc0?=
 =?utf-8?B?a3RJdGFCRHlOSVd4ZlYrcyswVFJxQXM5NGp1MG00L0tVZ3czZ3JwenpzQjBO?=
 =?utf-8?B?bERyWDVFUkdQMWRkYndmbUxqWG43TG54U0xuUVFmNTA3TGozZ0Q5SVlVYXFM?=
 =?utf-8?B?N1lDaHYxRnp6OTd3a1JkZHNmaGdiZ3pZRnVsbFBsTW96V0NZVkZGcUkrWEtK?=
 =?utf-8?B?REtIZmFkcHpmUEx2RTZaazBRZVJkcGs5aUtoNUdoV0JYUHh5M2JUVC9FdGww?=
 =?utf-8?B?a3RDY0pYYjFPeCt5THQ4eWk4anArdGhFU2o0TFdvSUtzaUNNMDlXbDVOeW5h?=
 =?utf-8?B?M1lYYnI3a0R5WUhETGVRTEs3MW1NZjNhbWlnRE5YTmFadW41T05kMjExNzRl?=
 =?utf-8?B?akJNVVFKMVJRdm5GMWdXc2lCMk5ZdzM2aDhmYjBjTGVEc0tQZ2MrM0MvU2tX?=
 =?utf-8?B?TDNIM01PNERQZzk1TS93OXpYcFRDTUgzMTVlNGtjMEhoSFdQUjZRZVBCT3JN?=
 =?utf-8?B?ZkhvVEsxQjEzVi9rdEhIbXNqU1VUZ0RCbEFUN01GT2hpTFBST2RSVTMvWDhl?=
 =?utf-8?B?dVBoNUtVV1JIdnFSWkZ2cHJuTU5BS0haM2d5eUlYeElRYzdSVm9pYkljdGtF?=
 =?utf-8?B?UVRoMjByVXpERlozU1I1Y2luY2dwUzRScDVNSTdrdVFob0hqU0E4WWJwdWlY?=
 =?utf-8?B?Zk0zLzBkOG1zbUJveVA3NmRZa2NadGJJdFNTbUQyaEJ3bE5tZXRIdmRBVGxH?=
 =?utf-8?B?bzU0ZzhMNnlrR3Rkd3BxeVFEUGZLRy9kSlNORTNlaVd1UCtuM0NyK3lHWDR1?=
 =?utf-8?B?bkF5UTdPYW9OUnVBdGN6Z05EYzIxWGlIdmszazZMdEkvU2Z4N3ViZGRvS0dr?=
 =?utf-8?B?dWtoU2JBUThTRk5yOVo4OEE5STBCZklaUkY0SXJ0a1NnSjRhMzVLeEgrZmtQ?=
 =?utf-8?B?bTN3OFA1bXpIems4Mlprb3hnZzkwRHovS3FrQTNManRWemhvZFB4UGN5N0M2?=
 =?utf-8?B?WVliTWNMdzgrQ2FYM1huK01ReTlEcUgxSEpac1ZVT1hmZ1FaUDJ5bytTR2J3?=
 =?utf-8?B?bHlCck1hYlR4NHJXSHhudzFsV3hEbzhRZksxTWNtdXNYUHlsSXVzc0RsOXZW?=
 =?utf-8?B?cSthQmdEUEkvVkVjdU1LTWZIcnRPaWlCbnZaYmptc0pwam0vVG1FTWRXellk?=
 =?utf-8?B?RmQ0SG4zc1RiZ0NJYVJsNUlsdmJMYlpBOXEyL2RWOTlzY0xSelR6aG9jeGhm?=
 =?utf-8?B?MHZ5QktBSnRkTStyYjZKYWx2bG5BdVh6QzFZL1I2dFdzQ2ZMaDBWV1hEcTRG?=
 =?utf-8?B?d0ZvdldNbllSV3NPTmlzQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGxDSG9RbTIvNnVhSmtGU01XN0JXakF3Q2FscCt2Q1NUaWJMVTBFR0UzTzVn?=
 =?utf-8?B?R0l0VXpuQVN3MjRsOHlFS2hPaEtDSC9vbDFtOWlBSElkSi9JdnhYL2RabnJS?=
 =?utf-8?B?Z2huMzJ0V0EzSGh5K2EwczZrYitsR2dOT1hyWkVET283V0tTQjNOYzFCVVBN?=
 =?utf-8?B?dVF0UzlONmFCeUw3L0NUVy9xcEJxbFJIRURaRzk5dWY5Y1l6Q0Z4TWNuUmdx?=
 =?utf-8?B?cXNxRmxzK0ZXLzhoODJ2VnBUejRXRHF3UWFteU5rUVJUUGVoV0U2SVpidnVj?=
 =?utf-8?B?Z0lZdUFnS3hiTy9kMmpNNXhYVk5QdEdOSElxcmtMc1lSdTY5N1RQa1hTbVZ0?=
 =?utf-8?B?QkQ4NzdPZ3pzc3Q4Vk5qU01qdHhCUzd3cXpiSG9iVkdBMXVZMHF4UnJHc1BU?=
 =?utf-8?B?Ynp2OE1Ubnk3dWdsMEVvWk5pbWdkU3FPU05WTWlBVjJ3MzJLaFlSVVJmNTVv?=
 =?utf-8?B?b2dZK2pwNE1HZ0pIY0tNWGVnNGpwTXFoa01RMGVSejFzMjczWmpQd1ZjVVhS?=
 =?utf-8?B?V2xENVZ4WnR1b1NhTmtuVUJQUE4yeTRDYno1bzBRbEpCRGltRTdVcmZ4di83?=
 =?utf-8?B?WGFsaGUzNVc4VG5hZXh1ZVlDL2Q3ZVFwbWlqd3d0Q0FBbTAwRWN1U3M1TzMw?=
 =?utf-8?B?UE1vbjJ2dWdkRTdhUmx1ajVPb3ZKTG5CVEorR2NhKzh3eUNTdVpjcGhsNG8y?=
 =?utf-8?B?bUJtTjJJTmVDaHJjb3Jubk9BSk1TWVBaQ0Z3OUVkRXEvYjYyOVA1S2VqRzdL?=
 =?utf-8?B?eFR1ZzlZVVpneTk3RE9iQkVYZEx0QzVETmRCRys4ZmxGWENyVU1Sc0VnN1pq?=
 =?utf-8?B?d294S2dHdWZUdk5sYTgyNjl2eE9nRWlRYWY0T1lvL21GdGUxQUVIUWk0ZHNm?=
 =?utf-8?B?ZVlrNXBuTkloT3RDdXY3TW9ES0NCMSt1c2hiN0VhaVFnSEsveUJPUXZCZXpk?=
 =?utf-8?B?bWFmVmNqcmk4bDdkeFVMd28yZU5VMThXbDExVHUvTFluMGRnSGhJcnh3Rm5Q?=
 =?utf-8?B?RW5aN290bzkveGJjZHo1TXN4WE5ITnVXa0I2WEtHWDFvWFUvbEt3YlpOSU5J?=
 =?utf-8?B?Yzk3Y29SMmNML2JZcUlubmtFQ1Nld1MrQkZ3Q0U5MWFYQnZ3NFlVMUU2cTVX?=
 =?utf-8?B?SDdaYkdCS01kTFhWOU5JeDZ4QmVFZU5DWnQrWkFQUVY3NFBmUzlGVDU1VFdK?=
 =?utf-8?B?Z1pKcW1LWFI2M0lEY09wR2plSE5DalRyS0dZVUxIM1FUUFJZYUU4Z0hISHpy?=
 =?utf-8?B?VVd2ZFFRTFhlRnNoeWtWRWlyUUp1ZTVHaHlTSit3b2ZDSjRocDd2aHpDNGVj?=
 =?utf-8?B?a2Y5ajdWZE96ZDl1ckRkb1FucmFuTnRZa1BMeUsxbng4SGZGcjlNYm16OXBC?=
 =?utf-8?B?N0lhdzJ3VzJkbzdFTDlzMlNlK3YxQzhpU3hvSjNMMjQwazRNSG5pdWF0YjFT?=
 =?utf-8?B?TDlkZ1IzUnB5Z2NWZGNKV1VDMkVpb0E3M1FWd1F0K29sSmtIa1VKVVdXNlho?=
 =?utf-8?B?OUtCTUo1WHdSL2RSQW1TUXNLS3FxaU55VjFyUmpMaXhTUncyZnp3dkREVlh2?=
 =?utf-8?B?U29NRFhmdnlwWnZRQUF1Y0VMQklmcVBQdFJnNzBZc0FHMFc5TDZwQnl4RTk2?=
 =?utf-8?B?L2tLWXpnRjV6eXFGWndDbkJqV3VyUTN1VnZTOEpVRi9uUXRBZWRyNEtuQ0l1?=
 =?utf-8?B?NFl2N01MTjJvUlhXU3ErTFJkY3Y3aTlWa3VYQTJoeVhieGM0R1BXNDQ0ZFR2?=
 =?utf-8?B?dlA0NVNSN3hqU0tkTHpzaXh4Ny9UQ3Z5VThmTzZ5ZFhpaGw5THRwd3lrblZE?=
 =?utf-8?B?NFFmdmU2Sm1KcWNvWUlVbW5Sd3pxTFV3bTF1cW5sUTBvLzJEOWRQTGZXcjRO?=
 =?utf-8?B?MithVDVxVkZqS0c2OEhWdHBQUTg0SUNGc2tiY0F6d2YvK3FvdjJ6dW40bXZh?=
 =?utf-8?B?QW5uSHlvc0pXYlBucUNnU3dQVmZRQUxrSVRCSDRPWVdLdTB4dzVkcVNOUlBa?=
 =?utf-8?B?UU5wYW44VHhYaGl2NkpHNDhtcThzeVdvTk1zcExSclVBelBMcHYzU09PUXha?=
 =?utf-8?B?M2tMeWg2SEp4SURTU2h4bFRncndiWW5KK0NhWGV3amhINzRCU3J1d2IyMGpa?=
 =?utf-8?B?SGFuUFU5S0xRd0ozbUNnZ01WQks5UTU5SlhHMzk3cHU4cUhQVzEvRjk0cHhU?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17570d5-8039-4f2d-69de-08dc9cfa543f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:56:54.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRVH0Khpwses6yelrdryh3g0ki0iXv71EsgwfILBnUUIMFEBlitsT0ttByysgs4u6gXejOr135jctMBwx8UE5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6507

From: Jan Kiszka <jan.kiszka@siemens.com>

Rather than counting errors and failures, only query for the failed
testcase "job". That avoids reporting failures when some job was
successfully retried, specifically download jobs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/install-lavacli.sh | 2 +-
 scripts/run-lava-tests.sh  | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/install-lavacli.sh b/scripts/install-lavacli.sh
index 7f7a052..ae61497 100755
--- a/scripts/install-lavacli.sh
+++ b/scripts/install-lavacli.sh
@@ -14,7 +14,7 @@
 # with the lava master on Debian 10.
 os_version_id=$(sed -nr 's/VERSION_ID="([0-9]+)"/\1/p' /etc/os-release)
 sudo apt-get update
-sudo apt-get install -y jq
+sudo apt-get install -y jq xmlstarlet
 if [ "${os_version_id}" -ge "10" ]; then
     sudo apt-get install -y lavacli
 else
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 046d56b..d478a11 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -61,9 +61,6 @@ url="${api}/${auth}"
 curl --silent "${url}" -o report.xml
 
 # change return code to generate a error in gitlab-ci if a test is failed
-errors=$(get_first_xml_attr_value report.xml errors)
-failures=$(get_first_xml_attr_value report.xml failures)
-
-if [ "${errors}" -gt "0" ] || [ "${failures}" -gt "0" ]; then
+if xmlstarlet sel -t  -v "/testsuites/testsuite/testcase[@name='job']/failure/@type" report.xml; then
 	exit 1
 fi
-- 
2.43.0
