Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013014.outbound.protection.outlook.com [52.101.83.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BDDCA52
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781502369; cv=fail; b=j2iAAUOuPdR9c037tErvWMRuP+ohpOL5tSfDg0QbaWFcjaZSMA8jrYeT9Zdmm/Lve7Q6vSwD1yjHIv8v5ISB6TFosg3uiC+DGv+xLFqdLxPhPlF+bmmSa5wujPOw6x8u47JkA0UgnSFQIptytFPa4Ch7wnADHqn/QOfstbXEQBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781502369; c=relaxed/simple;
	bh=SXhiOAOhzPNYc16MAaMwrih6kvRvAmXiOJb+iHOWZ04=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=O7n2iSapAEX4RwmIpO3L3zAj/QX2J1Ae6I2QjZ1jH1DzP8d80aIKoW/QEDM/GpUzBmjienfLu60/FasAXXMOcvW/fScciU4Qm6b0cUgWWtTLuzhTwDxphmOAbStZId+B9dC6n02IEJxLfOaHyPTq/vfnE1raTgspBu4WOddiGBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qAeJnjcn; arc=fail smtp.client-ip=52.101.83.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qAeJnjcn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mfsn7ZDGpx/WJ5Tk/QCo9L5R//LUDsofpO8pShHr4I3GeHlbsdj9BBRd9m4j7Q7q21xWL22ZOmdVdTerv4jtFD4Ig0tE/4YgzKgUw6JAK1dNy8HAbyGP5YbDBojgA9QzR1A0dj8TGFfGebuPMZUJS5OneR51OGMoBTRqVTAonkKAxmvBBVKUm+ohs0e6VjPXf9QfXRwg+ao869ew4/59yRZ2e3CGusu8jkwdX3sXsatKLLhDtZKabZErpax2KByrcftM6U+wfM+AoBrjSbkejVNexMWMzzYMzwzUwU/ZGBN0nDa5dtkGuDCHXM4U1yi8N704JdicNjCgvh5gY4r2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXR4hIl6qbP5MzZD5Z6htMdv831U5saGX31YtYEM6tQ=;
 b=UCKsm3+zWTxTaBnkTWReviGzu8aMchPi6zKK28wKml9QgidkDN3v8Jj2BkeAMySgYW7VBkxNdYY+8f2Gzf1dLqvILpw/hjsxy+8qHSVyQ5zDm0QENweYJZzQvn0vUSuoxnYTupgNWAMrePhKq03JuhgNQQerzP8Bl47FGNvuxU29UaE2RRLuuZAPweeY7gKech3BFgr2D35zopc1C9cVVg8V49WluqnRBegGSdyOes+yalxZmsf45vEAuOtoK3J1NGqDlm01BYqPpQdJi/oaLSAM4bnGNvbnH9SGIGR+7GMX+raogUDsuN8KETiqAA425NWO/l8zvHw5YiU2BVLt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXR4hIl6qbP5MzZD5Z6htMdv831U5saGX31YtYEM6tQ=;
 b=qAeJnjcnDDsZpOB9MOskR54ExtP1Ml/tuZh/FWCns4A9/Cx6TQPiK4OalxZ/qJBLyo3oDmEWS4TRrGx1NO2PgrBqGOpXgEL9kyzpKplnpOQwz6t5sUkmvdM9cY30yNovOanZ2kc3bdL0V+e3feDTzcrcr2ZEifIWe/qgwLH/kdYxvPLxkr5SI8h6lmLsKKlrot1M3TU4M8IiqmFk3GNPrCL58CDgkQhXvHV4jtPG7WER30hOOdGsHpm6qyOSt3UJon42WIAzu/TNp/ymfYL1TVRNEpf2TyOykNUo9ZBNMtsLPzlpgP1f2e511PB9NUpjTXHoIJRPvbve+5ZalZFTvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6809.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:433::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 05:46:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 05:46:04 +0000
Message-ID: <8ed28071-2341-4322-bedc-df1929e3a125@siemens.com>
Date: Mon, 15 Jun 2026 07:46:02 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: Possible Xenomai 3 latency regression on arm64
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 210bf3c8-ae92-4f56-366a-08decaa16352
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|55112099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2U7iS0ZTXzUmmOu9+Pjso8iTGUYlu2jD3k+hkSNCke9I/HG0kerLric/ZafJSeNTTBVbI7tVwhQM4giOY7c094I2NJoCAVgpdbMcIjvT41FrF5vcZX+k7jrK0oFptAYEdXYoGuUX20ots2SD4Z/CROJKRCm0ykT9Vge0C/btpnCnru7MUlNJZeh9Taa9sFgAO9KpPW6P+/bUnalovoxevBr9jTCw6CyO0Tt5rMSfKn+ZnLs/2j/yqcWNfJYhG6SdwyLJaxhmiFSvrh1ty+6d8cwxTGbBPaxMMcpl6xRYWdxswHEwqi01CFMqy2/JggT2vBiFMWXZiRxdT7vzPQfrHlhfdni3R8PR6pHWrJ19CgnozKHCGioa5nmZScijHVLrwbGMkrWWVtZNbnTC3Kl7lZ0siUvyHNOVMJPjNVW2z1K4Q4D0V1SzBUfOaJVNmS//3EbP2ulRe5ZqkpFM1o/d6/2dSHY58dobFNyoAQzn0vrkTuU8a328eMoJ7krVHH1V5pZxUn7bSHodwaNDq7x8VR7creGF3zIGjjnlwrI2/K9gsy25P8E9ycfzskfpv2QlogKuhnbkQ6Wrb3DsENueqeYSqqNOejqxesZCYqdYo6t/lt7gjWULwg4HzH0oDKRvo8yCNpA2Y1Hop+ciTC+Ariv0tldZ3DsgKzj/GXBNyVYODOXFltAH9TlxyTCqPF6vFZ0vuIOc8VIEn2ufg8koFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(55112099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGZWMGwxc0NrMXhCTUxQNjJpMXNNbFRWYjJOT1VOeURjNHhNclhkZGl5UDlX?=
 =?utf-8?B?eVRDR0dUV2lwbWUwQ3NMT0VnNWZCaXA3bnM0VVA5U0RFZFU4QXpxK3U0Mzlp?=
 =?utf-8?B?NWtpUW5lZG1wbCszZlZvM3dFQlNVOS9VTnQxY05CaFNPT1FTY3JoMmFlblYv?=
 =?utf-8?B?Z1VSVjRsOXA1Ui9wQ3dCbDQyYmZqVUdYcS9rTGgxcW03L1R6ZmpxY0oyWlg5?=
 =?utf-8?B?b1hrVTRBdlZqanRVb2EzUXJqY0x4bDVsRWFuajBCWHdoU0NReERYSHZzTHZM?=
 =?utf-8?B?dzJRalZmbnc1Ym9HWmpMaThkWFEvWnhZR1g5UFptTGUxcERXMlJBSTc5WDNr?=
 =?utf-8?B?RlBTeE9DT3ZJY284cVRLTXRscUFIQXhmdlZRNkVqWXYzOWMzWkVtZFhIbmlq?=
 =?utf-8?B?em1UV004S3RvWlpHOGw0NVhMbEtPVTRFeHIzY1ZrUlJORXc3VFdTTXlWNVFN?=
 =?utf-8?B?bXYzM0FqOTNFNXk1ZlBpdmhLcVUvUVR6OWY5eUhsc2NKZ1ZIaTlxN1R0NXQy?=
 =?utf-8?B?ZTZLZWZVakJHb0FFM1pwZFFEempzaXJmUDBCdGp2VWFPTW4xUTNybHZBSmdR?=
 =?utf-8?B?Undxa2hUbjdlb2h6d3hKU2VRK1k3MUY4dXNpdlFYNFJQK1QwMHZWK1lqR051?=
 =?utf-8?B?ejNiMGVqUVRNRVpoVXJBVkl2amxpR0h2OVVxeTQraUFVak9wQWVEZVByWXcv?=
 =?utf-8?B?Sm9xTzFlZGhWT3FubXM1dEZkYU9PbU9peE45R25SV2tQQklwU0loTWVkclds?=
 =?utf-8?B?eVRxQ0pPVUlVb05iMmpHN0RNdi9mZFJJNElNRjBEWjRWVzBvbTNEdkRIb3c5?=
 =?utf-8?B?YmZtRFFLOHpDQlYyMkNxVkJxQmk4YUxjZk1XVVZPc3lkeWZjVkdSQzhhNTZo?=
 =?utf-8?B?dDR0d3lzRXlySFlGaU9uQlRjdVJ1dUEyMWhsTU1CSXNONU9mRGdSRzF3dWh1?=
 =?utf-8?B?RkkxMVpOQ1V3UGFVSVBMUWI5ZFBsTDk0ZWs5U3R4WXIzeEZOMk9tQW5vYXow?=
 =?utf-8?B?ZEMvSjlvbjdnUlpFaTBvWWdEL0FpVFpRMHI0T3VpbnVpdGtlQWdIRzRtVXgv?=
 =?utf-8?B?ekt6Qmc4Y1hFQnFRMHhCTG95U0RVbTdudTJJWGJ1Y2hzMGtaOU4xVFpPTVZu?=
 =?utf-8?B?M0VFbVVBdUVMc2Nla2xxc1ZKaXd2NVhBK0kxanpGYVdwUmNpWTVNMDBJbERn?=
 =?utf-8?B?c01YbDBDejVFblllWmVaR2E4aUY3NTc4djFER3pqRTkyYno2VkJ0eGV5MVJx?=
 =?utf-8?B?Z2ZVc3lhUVZGM1lRS2NFZmNaT3Bva1RRTlA1emFUNVcyOWVFUVlqbHBObVZF?=
 =?utf-8?B?ZmE0NXdyT1JxNTcvMjEyUHNRQmtES00rKzgyUTdNaTk1aytsQWpyM0NRckZP?=
 =?utf-8?B?aHNRU0RMc25tYWYrNVZHSWRQOW9DVkVBWW9VcjRGMkxpMkdZMDJjVDFoR0F0?=
 =?utf-8?B?eGxSdGJBNCt5RGw4bmtZd0ZSaHBoQXQwWFNJS1MrUlpjMTBSYit3MFVUSXc0?=
 =?utf-8?B?SzI1Y3JQK3B3ZkRHaC9rakp6MXNNaFhmTTFtWms5YWxCbGZER1lmQ1luYklt?=
 =?utf-8?B?YkVHQ1NORFdTTEc5ZDk5MzAxN0V5V3VqTUhwVEFXWkVBclAvL29xRU0rNUFh?=
 =?utf-8?B?WXZTamFrSEtndkxqV2JweWhramw2R0x4TnUraE5TTUEzRjhXSVhhVEtOQWR2?=
 =?utf-8?B?SUxsMG9vV01JOFJ1Mzc0MTBqcUJxTkkrZ1ZaZWw1M1RkUUU2YlNkZlROQUdF?=
 =?utf-8?B?Znl5Z2tJQnRxd0VTZHdGUXZCb2ROTzFjS1dWT1I2RkJtelF4bTJEWFcrVlpq?=
 =?utf-8?B?NU1TVE0xWkI5QUNEelJPTW9xTk8xbW5EOW8vNkw3dWFlbVNPVmVYeDk3WHpw?=
 =?utf-8?B?bDFZYzRKNmMvcXQzcGIwbjFkOEJhcEx1UHhORGZOblppc0dXa1RMZHlQNWVP?=
 =?utf-8?B?bHM3SFNkTlBjQ1I1NXBUc3M0bFlxTGw3MGNpbkowNllOWjhMNWUxaE4zQVlq?=
 =?utf-8?B?R2QzSVNFQVdZYkZtbDhYQ1NEWlRjQ3NpYTBNcWVyWWJFamdUNzNkalE4T043?=
 =?utf-8?B?NjBTSFU1MnJ2Mk9PWGJaVnZ5dWNYTTdQMy9YMVdrZENSeGNYVkJaZ2FwMUlE?=
 =?utf-8?B?R0hqaE13UHVjRERWNG1rbnhSUW1LbVhjSmt1b1hUZEtkRGp1bDBPNURQYzNm?=
 =?utf-8?B?QmozWXVLVzVJZWRDSTJhYnhhWVUvRngwcTd3NEh3bjFxaUN1TFllMmpyRm5T?=
 =?utf-8?B?c1lBektzTXN5eDhVTys1QW9Fdm8vRG80djhFdHR0RnQwdkF2TE5wbko4VXJH?=
 =?utf-8?B?cW96c3hDbXRadzAzOVpZaGY1eVdlSUk4Ri9Xb01rYS80VXN3alRPUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210bf3c8-ae92-4f56-366a-08decaa16352
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 05:46:03.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjM7VBE1qMd669hza3HbzUI+szKtGmmHhtrgVKSODRvrUosTlO3uqPnmjz9RcFmcyRY2n5U1i8fdItgVFvFUZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6809

Hi all,

it seems we got some >10% worst-case latency increase over the last
month with Xenomai head and 6.12 - that is at least the setup we use in
our long-running weekly test.

Tonight, the RPi4 test triggered by exceeding the configured limit of
150 µs [1]. About half a year ago, we were in 130 µs range with it [2].
x86 and beaglebone are apparently not seeing this change.

Those are preliminary numbers obtained by manually clicking around. Some
visualization of the final worst-case numbers over time would have been
more useful for this. Maybe someone has an idea how to transfer them
into a database or just a plain file from were we could render a gitlab
page or so. A trend analysis which already warns on constant increases
would be the next-but-one logical step.

But for now the question is if this is a real regression or just a shift
in how likely higher latencies became. Or was there some change in our
physical setup, possibly causing more thermal issues or something like
this now?

If it's a real software issue, what is causing this, the 6.12 kernel or
Xenomai 3 head? Anyone willing to dig into some more analysis, probably
first by retrying older runs?

Jan

[1] https://gitlab.com/Xenomai/xenomai-images/-/jobs/14848873648
[2] https://gitlab.com/Xenomai/xenomai-images/-/jobs/12189033381

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

