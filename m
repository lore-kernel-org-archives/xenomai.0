Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5932E1F02
	for <xenomai@lists.linux.dev>; Fri,  7 Nov 2025 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533178; cv=fail; b=dE/VXrbt5s8nR+g7lSYzUBbrN24N5ka0Kp3GsCcxTDjnxfru3XP9iSg+yjKA8JcVrBbz1YW7G3p3aHrJB401/hneYGPM0rJw4uJ3xhyAaYO5UCsseM+On0gj2lDmH3q/B3GpJzYAHLMHymRBDeIO+JqEEj29/NB/cK4wSLx3r3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533178; c=relaxed/simple;
	bh=X3yzjsABEWmc4/J0v62tcmFlwY9DesvVos4OCaRAno8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ae5Ufs61cPbZG1Z1M+GKrNj87+s0AnodWUrmml4KNZcS9vrEcoVbxwVAJ5kldTfnMxV3Q4J+CZmQbtCKWEmyLYrukd/DbU1FaPa0+lq5PzA2cg4RCNc56ZKfVn+McfGMOh0W4SRcitqIxo+BpMRnr3Plg8xcybyN4Rw6sHJIfeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IyychbVr; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IyychbVr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebJUCp02NiYH6yXoOVkyIpArfYeOTpU31j/w9teP7KO7Ru9ayIiBxv9MDGUFac87n7agEUhaWF2PtMrEKE564X3xNkH43EVXoLPSb0RNIGl+AOm8PjhJpv9ceGAtgOJIGr0IRp6Gu0JzqBkeOFTvhNUSRLGBUTd76bW3h2yRaDWo5jZH+6rKCn9IV+MoSL9xurrRaeivRvjAtJlbhcGsNpRqzkhtEpCIASe0c9rPbXIFrIitD0XQVgl0eaoP/L6XxDYLC6XiGWicDXarECXn1ec8NHYVyLFxTwDR9DuwcTY1mJRBYfMctC+lZYAoXQOJUWzfufOVzHo6Mmrhx66dWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4q2lQBzPHRo3YoDqVg0PZgEy/yE0KiZJIfWJfR62d8=;
 b=iaHIrWymYSHr+j6g6Mp3b/R0qWhBOXbtmZyd/84ZIrp2bg+HTAgrByCMUpqWKXy2U53yuFw7Mb5r0S8A6HzrYBDOuqlljjbSmq13Q+LUa221mLC2obuQSjSqt5gGMlW8Y4TmrrLaAiY5S+fkFxvIrfUqzOEJUFuUBUNIGJlr1QnburPFCkg3NFuKm9HAQ3iOnI1XXQub36BUB4fWg8RQm4fCzmQw37ciLrqHvtF3C9iwn8AToBce+Fn61MxBf04VQdLn/jhoLrcGndv6HkljdgytMw8m6+v89N8oZmtRAnB3S3bDCncz7iK/DeukNtplBqYsnehad1eLNrqx9dme0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4q2lQBzPHRo3YoDqVg0PZgEy/yE0KiZJIfWJfR62d8=;
 b=IyychbVrBv5UQSNZ/VRleFy/d+3fk2e//vDQl3CPTJl6gXLRxtH7a0QOfRPEZywipczHYxQSJLh7LNipExHGbhOwQEB7XtneDFcfEweoywpzNR7L9Cm/yakGhuD0ueGt6NmX0vvira+oR5DZ9cduDWiyWHoqE4+XTlckvuCr5r/8bvE56uhkh4ZlFHXjoPEAqKioI8LQcJjaQP3emCXCFXxinTzEz4I/eGAQ0Rqu/HN24FKohnXfH8vOHzkjr+LXTSttIHrbIE7wXdugExPmU8kfPMyWtymB3SAnm/zoNZWh8ogcL47xK0Th3c3V+bdcYQOBXhB3PdpfT9a/M+xCkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8547.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:32:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Fri, 7 Nov 2025
 16:32:53 +0000
Message-ID: <85a9f8c3-d5fe-4c94-b79f-59229474d918@siemens.com>
Date: Fri, 7 Nov 2025 17:32:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail 6.1 arm64: Lockdep report while booting up
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <10779edbd5633fe1d8fb8df2bea3ca5ca53935cb.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <10779edbd5633fe1d8fb8df2bea3ca5ca53935cb.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 620254ae-a9ab-4c99-4dfd-08de1e1b4c7e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHpEdEZhRkVBSlgrQzVZYnBNV2dhdzhUL0RBSmJvTzhNNTBLZTdDZUZzM2Vq?=
 =?utf-8?B?T0thU0d6TlBlbUg3MkdERUhPcHNrS0RNKzFYa2pPaU05SmIrb3NhbkYrYU11?=
 =?utf-8?B?Y2wvRSs2MG5WekpjTWxqQjNSVnZRN3NSM01TaUl1OEJyWmxPYXNVOFVaVjV2?=
 =?utf-8?B?eGhBSWcvMFBtQ2lES1ZwdjJwV0htVjlZS2JlK0gycnFIMGtCYjlFZWhQTWdN?=
 =?utf-8?B?OFJKNEhlNXVuOXZZdE9RTU5HSnREZWJpQjZXUkpDNzFkT29WU2pmM2RKcHpQ?=
 =?utf-8?B?UVBYdUlOblVHdDdsQmg5VWVjNFhZTTUrZGo3OHJDM1FNSXNLZnFoNCtNOUt6?=
 =?utf-8?B?VVJWQzRPcWxVN2xuTjduWElITkZrUWZWcWZaYkJnS0dRaE1WSEg0YWRocEJh?=
 =?utf-8?B?bFhZbUEwMkxvbGZOWHlkSEk4czJ1elR3eS82Q2lISmF3WFVvWjJCOWxSMEVs?=
 =?utf-8?B?c2ZrT3kweWZvdXRGbW9NbXdwS3ptd21nVmNDOW5RVUxuODdlcitSSzZLMFk4?=
 =?utf-8?B?RTBXSDJ6ODR4ZStKb01hYklHb1dSZGRBRUZRYy85Z0tVampzdytWeG5oTWRC?=
 =?utf-8?B?dDFCVkkwS0luakxRMXdtcjBDR1BSTW5JaUkzYWthS2dBc0NrV1pDcThUUDNS?=
 =?utf-8?B?MzFhTk55K0JQdlRBU0lwTFc0RUQwNHdWRXdPUnkzalYrYnFFQzdJbnRTMUll?=
 =?utf-8?B?YWhJaVpmZkxSdUFYSFQvVGFSZTQ4aGdEbm9xREhEc0JlVHI2QXZnZEZwY1FY?=
 =?utf-8?B?VTRLWEhaYmcvRWlIUEo3elVJS2w1OTVpY25YODlONkpLT0tXdDJLRlBldlUr?=
 =?utf-8?B?YzZRdlZienVnYnFCakJIN1RlLzBSME13SVk2TEY1RjNHblVBQ01rVllNV0Ez?=
 =?utf-8?B?WmlZTkpQN3JJVzJNQ1RiTlYxSWlvOTBWNHEwL2pSQmV5bk40bmVQYnI0OE1S?=
 =?utf-8?B?WDI2d2JpWTQyOFBha1krbDEzcUtVQzdvWEd4RGhuK0tHNFdYRlJjNy9Jb1pP?=
 =?utf-8?B?MGN3ZnRQdGkySTdIbzlXQXB4YUJBSXZPQzFvWHEyZ1MwMk9DWFpiNThMUDZC?=
 =?utf-8?B?ZWRqcXUrdW9hQ01keVQxb3YxcHlVYTJPM3V2STQyVjA2TDY5Zyt6NjVJY0tt?=
 =?utf-8?B?dFNwYUlSUWdFUk9xeFVjMEJhMjQ0VkNYeW0wb2FaSE1FemptMUV5SHhQMEpC?=
 =?utf-8?B?UTFGK0hKaW5IOGNJeEtKS2NHcm81YWpuY0N5WkNybU1FUk4wWUFpNC90Q1Rx?=
 =?utf-8?B?ZG1XSGo2Q1U3Witta0ZNVWVJZUlKRmhuVk14Uk1aT0dndk9TRXptREErS0JW?=
 =?utf-8?B?a1ZlL1psbzJxL2RManFEeEhicTYxTzl2bnc4S0tYL0JQSU5NZHlEQlFSL253?=
 =?utf-8?B?Y0lnUVlTdzc2N3d4UkpqeGcyV2hGRFB6OEcxSEVkNXFSa2hpcWY3VElmN2V4?=
 =?utf-8?B?Sm81VkZLNkNyVmwzWDZiYnFKemNZMWtVdWdxVUdDekNBcENxY3Iwc1BDSWpQ?=
 =?utf-8?B?Y2hMTjJVWmQvM0RPazJYVUZSb2FGYkpMM2hKUzNyM1A3eHFoRTZGMURGQ21D?=
 =?utf-8?B?bHBPN0c1WWoyb3RsSlpXakZtaTViTVBkZk1URzJmelJQVjdOcE5vVzhhai9F?=
 =?utf-8?B?TVVSWEpFZ3JzWTI5NkxuMGlwVjZQdzJqc0tQMTI1dng2c2Q3bjh5dnRBZytY?=
 =?utf-8?B?U3RSYmVlOVJVQmlEVzBkaTIzNGJ0TitNYnMyQkFEeC8zczl3b0l3MjZLclR0?=
 =?utf-8?B?dXgvZ25oZkJJZG8xVUFWSVQzMWxXUEtyRHVEd0QydTdaYTQzRnBiNHllYURv?=
 =?utf-8?B?eVlObnREdXNwUytRdk1jc3RLbW90QTViaDBCbWJTQ0hBeUNBdGdVUzJTVnFU?=
 =?utf-8?B?WGRLN3hDNzBxb293UVFDK2FpTXFxenZ4TWI5WkZ5eFNnWHdaaStsVjZWdWwz?=
 =?utf-8?B?RGRkeTF3N0xlU2V4aGl2Mk9MbGR2UGpnSmxXSzI4WmFGR1hLM1ZCZHNwZ1pM?=
 =?utf-8?B?U1l6dys1bVVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0xKTUEvNkd2U0NZSU05cklsa0RSZFJnYktyS2FLRGlpUng3R2pTLzhndE1r?=
 =?utf-8?B?Z2FrSnp4S0ZKT2luSGxvY3YxQk9KSFJPWkVtVEt5TmZiQXlBdjYrakorSTRs?=
 =?utf-8?B?MjR0M29qUWgvY3RyTzZKbVlBd0NKMjNVZUpDaWtaYWRIRHp6VVczWVliaTUv?=
 =?utf-8?B?SE8wMFFsODdMQW8xd3BManVDdy9Sc2tVV3U2QkU4OTdGd2NqM2pmbEtpUTdt?=
 =?utf-8?B?TjVRTzFuTkJBWVRhL3FoT1UvWW94M1ZkbURETjFiTjM5Q3N5bmNHT3l0VGs1?=
 =?utf-8?B?QWhaS3JtWndZeFRDVzdFRUhORVp2Wkp1VnQxeE9BRnQzczQybWoramJhS1gz?=
 =?utf-8?B?ZkVuYlRQbWh6cUtCdkpzK3V3WnMwZDJoSlM2OEpuOGVQODJtbXc2ZStYZTE5?=
 =?utf-8?B?M0U4T2lnYUdlWEcyeTM1UUdpYmQxb0pWVWxteGpwcE40WWErVHd5aTFaLy90?=
 =?utf-8?B?aTN1SU01QlVNVWtlWWVjNnBXT2E2bVdhaEoydFJpRkhmVk82eDhiTHE4cWY3?=
 =?utf-8?B?c0ZBQ1QyMXI2dUJKdWxCV3B1Q0ZRMVh4TG5YenpyRGxmb0REVHhlMmFkR0d1?=
 =?utf-8?B?WUJkWWd3bld1V29KM2s0QW1RRlduRDlTbWV2QjQvdUl0YmNRUUpXdnJ1SDJv?=
 =?utf-8?B?cGN1bDlIZG5pMGszajdvZzJvNk9PaVBzT2FkV0JobzZURHI2bVJVT2srbHI5?=
 =?utf-8?B?RzU2djFWckk3UDRiWjMwai9FRXQyZmwxODhWaWhueWFCMk14QkhaclloSEhl?=
 =?utf-8?B?eWxTaS9nS3lVN0p1MHc5dE1iSDB3bTIzTHNpaGFHL2J3UWhGcWo5eWdiT3Vt?=
 =?utf-8?B?MGs2Q21vRUc2RUZLZmhna3RBT1A4WnFxZHBRUVVXZ1JRTlJKRkd6TlN6ZjdH?=
 =?utf-8?B?eTd0a2t1UHJvT2hyREgzR2FPR3ZCak9mS2cwY0hjM3d3TjFQbTM5MjNlSEVJ?=
 =?utf-8?B?azYycGFsYVJYdk9YZ3pRUytqbXkzNHc2Zi9LMkNjbFJaNStjUGxVQjBub3JO?=
 =?utf-8?B?a0RGdWI4TnJUUDZGSFE5WWdHQUE5T2RRZms1Q3ZGUFJ2bWZlZ2ZvS1JrTUQx?=
 =?utf-8?B?YVErVjQvd0V6MVNGU3B1TjRkUUppZGNNMVgyTjdDcFZPOWRoMTZZYTFLTWlO?=
 =?utf-8?B?RHFNQWtZaUVZVVNoeU9yOWhyUHlyNmJxc0gvMEt5Ujgybzd4Mzg3UmV3UWkr?=
 =?utf-8?B?TTlva2tiaEJBaEJrNDYybVFET1VXQTVocWYwK1EwbDlGall2SjMzaDdRNzQx?=
 =?utf-8?B?YzBvOUQyRy84NEdjQmowUEN1Znd6SDhvdHp4blplT3hyT0paYkpPTmtnek9p?=
 =?utf-8?B?NGFJd29EY0FWK0wyeStieVVVUS9xaWNVM1pwamtpUmViMmk5Z1dETGxCT0JD?=
 =?utf-8?B?ZXU4R3hnSzcxM241em01ZjFwQ2U4ZDlyZlZXWWdkQit5VXNDVHl6NWtmdVVN?=
 =?utf-8?B?STZjOTdvN1BYQkRCZ29iTXFIS1ZJMkdzZzNtVE9IRndKQTVSMTRKMnU2ZWFR?=
 =?utf-8?B?VjA1VE45cHhmUEZkMjBudzZqR0ZjSDMrcVE3bEc0ck96RDdiWjFSNjBWUlR0?=
 =?utf-8?B?R0xFeHpnSTVwVUdHMktHTmdxdC9uS2dpQW1zK1hhY0ozdFUyd0hoVEt4dXVZ?=
 =?utf-8?B?RVgzTWhLNUgrUnp0RWI1a0xuOUt2NEVadmVUK1lITWlMWHdHZWhudEdvYTUv?=
 =?utf-8?B?TFFlTnM3elFLWkxZQmttS044MkpXTER0N3dxY0tWQkVHUmNTK0dneVpyU2U2?=
 =?utf-8?B?eWF2dGc2cGxpblozbjVQZCtJYmV1eGpPMFF6L1luMjNBUThrRTFvbjE2N0l6?=
 =?utf-8?B?Sk0ybEYyWjNJZ1NXQVNjaEc3QUwwaU9NVUE1ajlpVm11d3JRM0pSYkg0QkV3?=
 =?utf-8?B?WE9XYnhPbXg5YmdHVm5wOHBrQXdmd3pjSkR3UjJCbmdDeXMwSnVha1M3bkk4?=
 =?utf-8?B?Q3Nkem9EMzVEYm5aeVFQeGZBeDg3M2JnSkM0aXhlR1d3SS9jSzJSRENEQlIw?=
 =?utf-8?B?SjQ1TzZiZGp2d1o2ZW5TRUtWNWNNRlBLbkJCVzB1Z1c1bjJrTDZwWndMWnVl?=
 =?utf-8?B?T0lEK0o3Nk92clJFcms3U0FkczQ3VVZObkIxV1RaYzRpZ1RYaHRTN1NKMDk2?=
 =?utf-8?Q?DJ/OeIy+TYRTbFFqcC7mRsTsa?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620254ae-a9ab-4c99-4dfd-08de1e1b4c7e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:32:53.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcGmJzcVEoDLX3YV0lyoBkziG4/KgxxtQroWHS7TcCnnk8fCzv+Nq63Ux+6uF8wmuW1/ghE/E7DX0ciViduVAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8547

On 06.11.25 10:05, Florian Bezdeka wrote:
> Hi all,
> 
> I get the following lockdep report on 6.1, arm64. The uart port lock -
> which is a spinlock_t - is used in (inband) IRQ context, which seems
> wrong to me as well.
> 
> Dovetail specifics start in clockevents_register_proxy(), where we print
> out (printk) some details about the registered proxy tick device. That
> looks like
> 
> [    2.054973] CPU2: proxy tick device registered (62.50MHz)
> [    2.055008] CPU0: proxy tick device registered (62.50MHz)
> [    2.055159] CPU1: proxy tick device registered (62.50MHz)
> [    2.055444] CPU3: proxy tick device registered (62.50MHz)
> 
> clockevents_register_proxy() is executed on all CPUs in parallel using
> an IPI mechanism. So we end up in (inband) IRQ context.
> 
> Input on how to solve that is welcome.
> 
> I should note that Jan tried to reproduce on his end as well. Obviously
> he was not able to trigger that. I have no idea why...
> 
> The code paths seems unchanged in newer releases as well. I haven't
> tested that yet, but I think they are affected as well.
> 
> [    2.218254] =============================
> [    2.218324] [ BUG: Invalid wait context ]
> [    2.218398] 6.1.155-cip47 #442 Not tainted
> [    2.218561] -----------------------------
> [    2.218575] swapper/1/0 is trying to lock:
> [    2.218639] ffffff80038e0898 (&port_lock_key){....}-{3:3}, at: pl011_console_write+0x140/0x1c4
> [    2.219156] other info that might help us debug this:
> [    2.219198] context-{2:2}
> [    2.219250] 2 locks held by swapper/1/0:
> [    2.219295]  #0: ffffffc009c7f4c0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x2ec/0x420
> [    2.219407]  #1: ffffffc009c7f5c0 (console_owner){-...}-{0:0}, at: console_emit_next_record.constprop.0+0x168/0x36c
> [    2.219481] stack backtrace:
> [    2.219785] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.155-cip47 #442
> [    2.219856] Hardware name: linux,dummy-virt (DT)
> [    2.219883] IRQ stage: Linux
> [    2.220148] Call trace:
> [    2.220177]  dump_backtrace+0xe8/0x140
> [    2.220241]  show_stack+0x20/0x30
> [    2.220254]  dump_stack_lvl+0xa8/0xf4
> [    2.220275]  dump_stack+0x18/0x28
> [    2.220289]  __lock_acquire+0x918/0x1fe0
> [    2.220308]  lock_acquire+0x1f8/0x324
> [    2.220326]  _raw_spin_lock+0x58/0x70
> [    2.220343]  pl011_console_write+0x140/0x1c4
> [    2.220362]  console_emit_next_record.constprop.0+0x1b0/0x36c
> [    2.220381]  console_unlock+0x1dc/0x240
> [    2.220393]  vprintk_emit+0x324/0x420
> [    2.220405]  vprintk_default+0x40/0x50
> [    2.220417]  vprintk+0xdc/0x100
> [    2.220429]  _printk+0x64/0x8c
> [    2.220443]  clockevents_register_proxy+0x110/0x120
> [    2.220462]  register_proxy_device+0x3c/0x80
> [    2.220477]  __flush_smp_call_function_queue+0x160/0x30c
> [    2.220495]  generic_smp_call_function_single_interrupt+0x1c/0x30
> [    2.220511]  ipi_handler+0x68/0x400
> [    2.220528]  handle_percpu_devid_irq+0x10c/0x1f4
> [    2.220546]  handle_irq_desc+0x4c/0x6c
> [    2.220560]  arch_do_IRQ_pipelined+0x4c/0x80
> [    2.220577]  sync_current_irq_stage+0x1c4/0x2dc
> [    2.220591]  __inband_irq_enable+0x84/0xa0
> [    2.220604]  inband_irq_enable+0x1c/0x50
> [    2.220618]  arch_cpu_idle+0x1c/0x2c
> [    2.220635]  default_idle_call+0x90/0xe4
> [    2.220651]  do_idle+0x2a8/0x340
> [    2.220664]  cpu_startup_entry+0x3c/0x44
> [    2.220677]  secondary_start_kernel+0x164/0x190
> [    2.220693]  __secondary_switched+0xb0/0xb4
> 
> Best regards,
> Florian

This turned out to be a false positive of upstream kernels < 6.12. It
was resolved by [1] there. Due to dependencies, backporting this was
likely never considered.

Jan

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=daeed1595b4ddf314bad8ee40b2662e03fd012dc

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
