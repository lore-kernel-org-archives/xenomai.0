Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4E374C2
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231723; cv=fail; b=CzvgQ7Fm+aj+OKpwPsjfmFRjulkmp31fXus0ecUED7Axij98jEy5wOnG0nxeZnOZ2oFY2N9xHrXGEVMDrlmmv1FGISTGCFXzquhStAOLOIH/faBhCvD71Qf8mMXz+LEg0r+jWiySjXmEwTiBEK14czxGrHJoP/Ut1OmfkPu9PWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231723; c=relaxed/simple;
	bh=OTgmP4GkqN49tmlBlgwJrbW9LU6avjyFUTukTVtWxcg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5U9rEiauvspxUf4A2V2e6lm00QeXpbB3HaXj8obJET2N6r41uMc0ckaL/yVg0xlRxAc8eGwrc4qS28zk3aLQWGT0/QabulcvdffvT5LcQHTFT3nKbzzvGbRALmsBRNoIG4U6B+wAZgXHobPYlKY5aJArTe7odklyMsLMdgnQmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rWZjG5bQ; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rWZjG5bQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SU++faP336thmibu6mHG7/xuB3UMRx5WMDDhv97uYl/NACT15+JtmpPRJVk8rg8nEf3Q2KPTZplyBi+aNt526jf1m9R7WXzgpX4xFnOE0qCerw85OXUZJ7W4xSnzdYuZ0M6Y4sSGYEh2jd+Ly6KnimchsxFdsdbHsD9M1GcendNS2fyOdlcbTkBaP938Yo4OZEhi5yt2+qvDQy2BGp2VJIjn3ySWk95/4mfNnt3uU/ShBBYq3IJGqCfAPc9PURv87kGv8iQdCffM1DlbVmBwMfnVDy2WJULmzzuflpqNqg8WPufR8phpGfjRjUYb+Z1KQTTynE2ny1Gz9nkshenkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+debS8/E11HEtmHJjutwmzljqtrslpoHidXN+cOLDOE=;
 b=BaX/BPxjR5c0ZobGSeia3yyyLEh62/xBn4+qR+exylB3FPYBeCrQPE+5scnTo/h1/cH/d8PV54pN3kIieMd+JuUokPiqt0Ue6IUab5xmI738lug27N1YgvtNQ3zjgJkjePh0saD4yeRH8Pj1Yc03k1T4L2GOCjeL867AnvHXElrjWOb0sbf8w4tR54ZGBBbUcZ9L4HCMys6aUkuObVauxtSwIsKDVxHBNFDUBYpS1ID5bhUkHGzKTot+6+TUQR8V2QX3OWZBYKwsZrQb4s4y8hLpBhwJnE6RjSHKCnTLSRNpeMn03MNkRcNAnrp2mgEeXKv5T7WLEufPiVuMH902/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+debS8/E11HEtmHJjutwmzljqtrslpoHidXN+cOLDOE=;
 b=rWZjG5bQx/FGE/Lrb8yx5CuwfWe/Jtb+1yzNY+97mJFzTzxgdKZT/mP/Yjvl1xM9Q8jUFyRDobvaDP+GAthrg4eYyca58icpMzbiWxZgiPETKRbHVRYJet4uqov91QiuaYSt0mdT26msf+xdw4uCBX/pl4ovtCXSqstwgfsdZ/GObkWoASAcKGFU4yYzNNbcaVH/6wb0z9CGoK3L7vs3SvQgaMO8Z0IJjmhRgcz7GwflZNiyUeD2aW6tlA2v5X87q1rULKMXtFjYbsimpVA+jxwx0caiWngI8X7jIsyC+EKSmFGRavDvq/kqMAkTbIDiNKuRcT+BjSB7xrJS5FQK9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8976.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:567::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 15:55:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 15:55:17 +0000
Message-ID: <4292c52a-ffb6-48be-828a-c0726e859cd8@siemens.com>
Date: Wed, 17 Jul 2024 17:55:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v3 0/5] ci: add long-term latency test for
 next
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240717103748.161788-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240717103748.161788-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 36925990-88aa-4999-4e06-08dca678da7a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enRtZFo4ekQ1MkMwd2xLK0ZRQUlvRVBKTnY1TXRaSVV5UGV3bnFTVjdCQ2lW?=
 =?utf-8?B?ZGZqNDkyaEE2SjZBOEFHODFNMm0yRWlic3JBTm9nYUt6aU9kVTdYOUVhZjJZ?=
 =?utf-8?B?eEEyWDlZcCt4Wjlya0hQcTVIbTNKMkZDcDNFdnY5eVpwOU5XTm4vK1RHWXlm?=
 =?utf-8?B?MThGZU9XMVhSQVQwWlJXQ2pPK3VKR2pFOW9OTjVDY3pHdHZIeUU5ZW1vMTQx?=
 =?utf-8?B?L3ZCM0M4cmRLR0VwU0RqQXpMZEp1eFRncjBJeFQ2c3JxZHJReTk5MnEzZ3RE?=
 =?utf-8?B?d3JSTkZpcnpKTk1TWTZnbjZjcUNTeEFuQkxhb252bnhTaFNBeEczU09RVjJP?=
 =?utf-8?B?NXE4MFoxWDlmc0FKd0dqZU51anVYUHRQWm13NHFkUlA1a3FsQUpId05NbGhv?=
 =?utf-8?B?TDFnZ1FhaTNvaUFtTmZ5QVVYb3lOcDFNd0lHYnhZWDhYZjhrb1J4ZDRmMFYw?=
 =?utf-8?B?V0JJRkw1a21ISjZqRWpnZzd4S2NTb215ZkNhQ1p6LzUwcVYrV1FwOXd4R1pS?=
 =?utf-8?B?NXl4QitxUGtIZWN0ZDdjUlBtdXNDVEdZWUtwTGd0SWVUSCtoVFVJVURhbUww?=
 =?utf-8?B?KzdGbjU5RFJNT284b1BhR3U5YnpTSHBsMzJ5RWNRTlU0bVBhdUJSYU5FSGE3?=
 =?utf-8?B?cVluTjBsUk5LUkZtZzZJL29ScVV4c2JpTjRRRjNNNmhGSjZQN2YwR1g5TVJ5?=
 =?utf-8?B?ZzFEQllvdUZuSWdINnZPSk5GSUFTTUM4SnFmcVhISGdzUmhZNm9VOGdIVTVT?=
 =?utf-8?B?OEF6OGNVRk5lUFJqcnVpWitKUzc5RFdkS0x4cXJub3VxMEVaQTdVM0JONHNS?=
 =?utf-8?B?eFJYcHJxMWdFcjZwblBKSXQ1U2NjVTRQb2RvQWpqK2p3UHVqQ2JOUzNGb2tZ?=
 =?utf-8?B?TnpGMjRhTy9HSFZqeDlKQnZzUGtyd1Q4QW12NlY0ZWJMclhKUWJleHkvS0J6?=
 =?utf-8?B?MVhENHpZTU1VWlJ4V1ZaTmRIbW9raEJYaUg4YWFCdWliR3dCalo1NjZDbUUy?=
 =?utf-8?B?M3ZudVJzNGFGNDZ0NEhNVXREdms4OTltTDJOYWN4ejQyVVlYbHhUMXNOb01Z?=
 =?utf-8?B?YUw3TmJjeVRKa3M0SG5MM3dXWXBza2dWRUtZT0huRjFaNFloUHQ2NmZMN09O?=
 =?utf-8?B?Zi95Y1pla3dvbVloSDZZQWsybkhLNkttY1JpU0Z2OE8zN3ZLd004THY2VnhU?=
 =?utf-8?B?QkJIQTZpcHltWGsxQ2ZReHRqZkxiaXVxMWdyRXk4NFN4V3dMQ2JQUUR6b0ZN?=
 =?utf-8?B?M1B1L1Vqa0UyOFBrbDNNaXVnZGRpb1J1MndwOFFuRDdCeHp6MStlY3p3VGl4?=
 =?utf-8?B?WlNHazNGVUh2UW9ZckcrS0NWSzNWY3FwOEFjMHl4ekJmNE5lTTYrWml5Q1NR?=
 =?utf-8?B?OUNTN3FkUjUrVm1BQk1qTnZlWUFmK1FpOTcxQWJyTzlzQUx3WmlTK3hrTkRH?=
 =?utf-8?B?aFp0WStuU1lYbGxWd29QZTNabDZUd3lEMGRmWlNjdlAyakxWeldCMUFzZm9F?=
 =?utf-8?B?K3JidWNzeWJ1dFN6RExpWWpsMFV2L0xUTCtqeGQ2Nmx2QU44cVR5VXM3enpP?=
 =?utf-8?B?cXRpNlRycnRHSW54bXpJZGlJQzJYUW9pVVQ1SXFBLzB4T3AvYy82R0kxSXVl?=
 =?utf-8?B?cEFUc3NLQXNKelQ5UHFDZmgyWmlwNnBmcFVxeFBIdE10bU04MjM0WkdSQ2tE?=
 =?utf-8?B?TGVtbmc4c2IwUGhYQVIyblo3SThpWGdSWVhnWDNDZDVoNkIzL1FWYUVxNng0?=
 =?utf-8?B?dmJYZ0FsdUgwZlJjeFVVVTdyMWlId2wzV1NMN0dCNUxsT0h5TlNjWWx2aFZn?=
 =?utf-8?B?MnUvUkZiVzhYakQvQ2t3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VC82eGVwZFdMalNXYzIvQk01TC93T1JtZU5yWVV3VlhRdmQyMDR5bG9qMVQy?=
 =?utf-8?B?alJlOG9zbHF4SXJ2MFJWRElpalg2bzZ2RW5samRoNytwdUR2d29OL29mbDJF?=
 =?utf-8?B?SVNkakdHcnFUVVNETXlHaVNhcWZLVlQrK1lKWncvN2JKU0U4QVFzODEwSXBG?=
 =?utf-8?B?am8vVTZwc1pKQjUxUGZNalgyOEFyMElrQ3BNeHM2NW1yQ0pEYWxSemVhREIv?=
 =?utf-8?B?aTJ6WjZONDE0S3BRSEtneUwwcVdhRDEzaWp4S1ZuS2QzRFhZTE9HVU5LUy90?=
 =?utf-8?B?YjBFNjJJQzRMMFRnNkZLN1FyRnFya052eThlN1VobkxOV29yRmJONzBrakZ2?=
 =?utf-8?B?M28yaDJUZG1Da3drakF3cXd1TGo2ZGZNRFFRMmIrTjIvenpRL01iY0VPdjNT?=
 =?utf-8?B?Q1hLNzR4OUI5bVVwQ3dTWjBCZElNTkJvR2QxWDY5S2tLNzRMOVoySVVxQlhz?=
 =?utf-8?B?S2Q4TGoxL3Jwd3BhNm40dUlSdFMvY3lZSHlOYjNkZnpGQlpMNExuNFMwNjRQ?=
 =?utf-8?B?MlZkbHZVUm8zeUJCcUVUR3pPRUlVSC84MDVieG4yMzJGRW1MeWx4RnhqN1JH?=
 =?utf-8?B?UnROS0lQSlVQOEhSRHNxSjFXVTZ6TFlMSGNkRW5JVEtVR29jUWdLZmVJVmo1?=
 =?utf-8?B?b3R6bmZISkJUdnVtMldhcmVJWXlrSmNwY1puVktnTE1oV01QUU83Kzh3MGJY?=
 =?utf-8?B?Y2V5WnB1WjRrQUVhNW9kdHJ5SitnbnBsRWFPUEh2RFRWYTd4d0JsdFBOdCty?=
 =?utf-8?B?VC9yYnFQbHM4RG5zajdWNjc4aHhwMHR4Rm9zQU4vdlJNU1JrN21LTWVocEpr?=
 =?utf-8?B?elYvelo4T1dnRlNHb0tWV1h5N0Z2YkQ5WU5vbnJ6WWNVRmtwOXFRdDMrTERC?=
 =?utf-8?B?QVZvcG0wVVFvYys2ZytNMGFCdjhCdDdEOVA2TVNGd1QrVWFrQm55ZlZPc1Aw?=
 =?utf-8?B?YU02ekp0eFNoMDg5cllOM1UzVTJzV1lreXVGQzlOVjI3QVZleU1JbGROV2Zi?=
 =?utf-8?B?d0ZacWJOakJLUU9pTHdpbitmRVExVWVEZ3QvOGIzN3hxVGNoTmk3Yll0TkE3?=
 =?utf-8?B?UzN6d0t5NGxxVFViMldCc0VXTWswSnFvUnV5QUwwaXNETE1lNC82b1k2YXBt?=
 =?utf-8?B?bDFoRENST2VLRHd6bjluK3cwRjdLRldaMWN1U3hEcitJS0l3NnNZNkx2U0t1?=
 =?utf-8?B?Q1NtdWMzMTQ3dCtWU2xXdFJWVlVGeWEvVis1MDArWVozanE1NUtIMk1CQjdy?=
 =?utf-8?B?U1p2ODltNWhKZ2FoWE5sYTJJcFlQbDM5YksxeXl4UmNYN3N6THNYM1BJcFpJ?=
 =?utf-8?B?ZkZUUGhSVnkrdGRwSmFXY3lCSHppenVCS3duZVkzWXI0c3I0NnJ5Ly9pMzh4?=
 =?utf-8?B?UlFvdTFobVcvSzJneFBCbHVqZGtVYURtZ2h2TWs3bk00NkhxZCs3L040R2lu?=
 =?utf-8?B?c1lzS1ZKTmtkaDdWaVgwYUhNMk5TSVBpWk9BL2dCYUJyVmJHL0ozUXYxTEcy?=
 =?utf-8?B?Q3NBc2NsOWdyME1HekdsekxyN295VTZiSWQ0ZTVmSm5IbWh1T1hDWEZlTlVv?=
 =?utf-8?B?QzZxL0FBTlVmOWthSnlQZGQ3eXYxWmZPR2lSS29UbUkyQ3QzVkJVdzVvTDNk?=
 =?utf-8?B?WEx1WURFS2xTa1lsU1JnRlJWTkw1cmhoV1pUWDFCMVYrUUg5VWZxbHpnYUEz?=
 =?utf-8?B?RG40TVFsTFBvaHBWVDd1cWNUd2haY0RSNDdwNHRYbjJzWTJ3anY2ZEVkTERV?=
 =?utf-8?B?ZVEvblhHSjdmcW5RMTFzVkMwcjBOS0hNdTFLZm9jUy9zRnZHSllHWUlTYXRy?=
 =?utf-8?B?Z2VUclc3K05QckdFek1xaXF0T3dzZm95RHRJY3NqdTQ5aTJFQ1FJaCtIb2I3?=
 =?utf-8?B?a2ZMSDAxeGdScEVtM3puY0ZGejVXbnlydWNGbG51QmpXY2F2Zy92YXRwZFI5?=
 =?utf-8?B?RVVrYlJmRXFCZXVNM3pWZ0g2SEJ0OHVQU3kyVC9aNmx4S2pyeW9RYWFJald2?=
 =?utf-8?B?UjJGWTFKRlhGVld2RHA5dGpybDRUU0E3SWVUMldtMlY3T0ZMR1VnY3pZV3dq?=
 =?utf-8?B?dUdXMmxNSnk5VncvZExERE9tTE4yR1BsOXNIYW1ZMGtCTDIzK0gwUGU4SVAz?=
 =?utf-8?B?azJsdkhRNWhNMjk0YlZiL0hFeGowUnlEaFlBS0xYeDFpSTVRckIralY3UjB2?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36925990-88aa-4999-4e06-08dca678da7a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 15:55:17.2272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjGXVgDD9Fo0bTpD6F7vizOOSrRlVe0lLtbAhqD+Vm6ytx4X6BMKsL/tKXYbRiDIwRq6RreYGworE9DOqXDA+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8976

On 17.07.24 12:37, Tobias Schaffner wrote:
> Add a long-term latency test that only runs on physical targets namely
> the rpi4 and the beagle bone black. The test will run for 60 minutes
> and fail if a worst-case latency of 150us is exceeded.
> 
> The long-term tests are only run on scheduled pipelines. Therefore a
> scheduled pipeline has to be created in the xenomai-images project to
> enable the tests. Running the tests at night is recommended as the run
> will block the hardware targets for the test duration.
> 
> This series was testet in our internal CI.
> 
> Changes since v1:
>  * Test runtime is configurable using the TEST_RUNTIME_SECONDS variable
>  * Test timeout is calculated based on the test runtime
>  * Configurable maximum latency threshold per board
>  * Use lava-test-raise if xeno-test fails to make the whole job fail
> 
> Changes since v2:
>  * Move xeno-test job failing fix to front of patch series
>  * Remove custom xenomai latency-test patch as it's already merged
>  * Run default pipeline on every event except 'schedule'
> 
> Tobias Schaffner (5):
>   ci: let the lava job fail if xeno-test fails
>   ci: calculate test timeout based on test runtime
>   ci: Add a long term latency test
>   ci: Add variable for additional xeno-test args
>   ci: Add latency threshold to longterm tests
> 
>  .gitlab-ci.yml                           | 10 +++++++++-
>  ci/gitlab-ci-base.yml                    |  7 +++++--
>  ci/kernel_6_6_physical.yml               |  2 ++
>  ci/xenomai_3_next_long_term.yml          | 21 +++++++++++++++++++++
>  scripts/run-lava-tests.sh                |  3 +++
>  tests/jobs/xenomai-beagle-bone-black.yml |  2 +-
>  tests/jobs/xenomai-hikey.yml             |  2 +-
>  tests/jobs/xenomai-qemu-amd64.yml        |  2 +-
>  tests/jobs/xenomai-qemu-arm64.yml        |  2 +-
>  tests/jobs/xenomai-qemu-armhf.yml        |  2 +-
>  tests/jobs/xenomai-rpi4.yml              |  2 +-
>  tests/jobs/xenomai-x86-64-efi.yml        |  2 +-
>  12 files changed, 47 insertions(+), 10 deletions(-)
>  create mode 100644 ci/xenomai_3_next_long_term.yml
> 

Thanks, applied all. The fact that we are not testing on x86 yet is
likely worth to address on top.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

