Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E362FABFC
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982836; cv=fail; b=uhrJhQmlj5FYDryPDra9NdZvD+g/vmKErNhAblRhSYrZaARPvZOiPtfW+0NHdDRr9mR0+kkRRqk4SopXZs8K2jLBOiFnqVxy5pIZ4KY0DyCm2z0m8HkO51x3V71eo8xCs0CVQQzhPD0L44CWGGpd9skpfRv4DVWO3kilzKMS9Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982836; c=relaxed/simple;
	bh=8FxQEk2rMhqjeAXcYxFFQJa+1QlEXQTk/lI0BwzOpVQ=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cCObTAvNDpE+9PPoajg9wDb/JaRMbxOOeUZpeA6YYi35pqEMxwffjguBiPAr9IUpT98n6G2s07A9HQyJuyJjwzWi+Z5vPlkFM/An6BNaKN/9F5F1WvY5rUKvWG8rBwdHE8Of+VIe0zx7J488wlxKNbsy8Uom02qNcJiaUYUIayA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WLZGowNV; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WLZGowNV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0D0heh6DjZPKievYx97vV7QMKkh7qQbQMz2EDPvccMGImbaWCyLEpMh4NNIp4noa5gs84t72UxK3/KXaX/QoKCDcL3/q0ylNWr3ah/+c3GKrlQE1wqA10hbifkw9osqYJ1WeEybzQHAiWPOEvnkp0Hoxcy5ZCgy3s2uDfeltFJXS4y4hMLKeX6h83WkyHzqj0itANFjyAqxr8kIZFQYLx3MVmMCWwoXaFOF2RHyRH4bRBb/BgM4yOzBcKxEEyOCpJ8vGXe2emRekspO2Gg6bnSECzY/kNV+m20kqyd/FTxKMp+8QbdOhAuJsnKqrvLkESLX6yQQ5oMQ67lvUR3G1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwrbQTROK05H5JwhzBcwoXIRMnPngGcdbP/9BRNukiU=;
 b=YVaPHsH5m+p2/6zDe3lbEinatyhkmwDmMvlQfa1j/CduSSBaMTJZf144W3sjKIuCQMcn/Ywr0e9IkYcd8Iuu/sx9rPt4dqcKm+lhUlwZTF2X30570MlIryUm37Ns9yyNg00nlZWbMzB1T8DumXAov7d+1QB3elUltf/m0gHTcAtgPsL1ywWYK+7cCnSbstCWccP2hxApC1o30zpZRgszSCeOo+g1j7fuWDyC57G0VHGUUjEZPEF2qqO/5GlG19n3rcqL2A58upv+QJgaiP3tLPo8/fi5LaODrCJAr8j1rn3oY4VTwlVXPPPQFvibH67nnlj0WsXcqAlPZhO5g6Qb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwrbQTROK05H5JwhzBcwoXIRMnPngGcdbP/9BRNukiU=;
 b=WLZGowNVf8VJfn4UMLvEOmMXI3eFmjUbReYp23oAdKxpBiw8yCDlO8WTlVcoS5a7qVs32ZVmfTqzlBCrLCAz2/nvLH9IdwOXN8NHEQaP6gRgJMnHK9Zt9Ohxa+m1PEF6fB0IbZeHrKmU2mDKZeMKAXh9xCyNXMGB635ah7ZaiFB/apmyGN9NnQskWsXnj3mcop2y/zjzRaWTSWWIWR1ElBpkbo3VYbak7ijH8i346s0SXk9PmervEHDhCTZUoywN/NPGnAIhpXBWBmhUsYaDYDMbzvatjp5YCEQV4ZukH3bgoWQqeR2oVeuhv6aUoRcbtIAZ+TTG5R7BVdSwaEufsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB4PR10MB6095.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 10:47:11 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 10:47:11 +0000
Message-ID: <170648d9-b953-4827-b79d-6b5f22c7ff96@siemens.com>
Date: Thu, 4 Sep 2025 12:47:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ci: check the device health
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, xenomai@lists.linux.dev
References: <20250904093014.2037482-1-Quirin.Gylstorff@siemens.com>
 <4ce03c2bc742b996718917fbc7872e341f0fb289.camel@siemens.com>
 <85b19acc-fd42-4a59-83c1-0063afecff62@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <85b19acc-fd42-4a59-83c1-0063afecff62@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB4PR10MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: e38d04fe-ff95-45fb-9f94-08ddeba066c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVREbm5SckxuZkRLSk91YXNtV1k0c1RsUGFWaW9KWHBhL2NkRk0yYXBvSmJO?=
 =?utf-8?B?Mk1Dd2pjQWlDRG5VWEpGYmNhSkxvSFFQcU9JMElmNWU2eld4WnRqdWN5UVBT?=
 =?utf-8?B?Um9SQUdCYmFFQnFhdjA5Mm9wYXN2QVBQYWYrMUlwWGFkZ1FacmRYY1RtNmRs?=
 =?utf-8?B?NmMwb2xxWVVEcUl5Q2EyQjlzVUZ4ZUJwaHY2c2g0Z3pyTHBueVZsc09ScG03?=
 =?utf-8?B?RTRKNUlmU0p0aE1VS24vUU80SWtrK3RENWVBbmZENFNMVUgrM2NDa0hvR0d5?=
 =?utf-8?B?TlU5UWZZa2ZFcHZVc0pZTHFIUjBqUVI4V0hSODNxUHVlSTdwemdnTTIxQnlN?=
 =?utf-8?B?TkpXZ0pld3ZWS2hEWGpabitVNElNVkdQYSs0TG1vSWo4aFcwSGVIdjdTcUtT?=
 =?utf-8?B?bjRGNS9aQXkySkxwVG55bWJwQk9sSWV6Nm93OU1ZeGRma0xXejJzdVoxamR1?=
 =?utf-8?B?UnlpczcwZFhoVXdQK1BmZURHZDZXUnpReENVVThpQi9SNDRqZWhoZExUaCtK?=
 =?utf-8?B?V3NsNHV4N0dRenQxSTBwQ3pvNnh5VzZYSm5jU2syMjdvSkhrQkdiU2ZDR0tw?=
 =?utf-8?B?UjN0NE40elQwWFFTT0RHSFhWbGNQczdCT1ZJSThESVg5U1o3TStHanBFaXpF?=
 =?utf-8?B?OGgxcDVYTGdIR2NjaU1CVldZYlloMHI4aFVHVmZBZ2FWOVU2OW9TZnpjL1lS?=
 =?utf-8?B?K3duSEE0Z2VDWDhheXdpb1Y5dVhXdVRodEpLRXhYVUZWWXVrM3lrNXhmTVJK?=
 =?utf-8?B?aVBEWlN0ZDhidnpFcXVpSXJ3Qi9OVTZwYkFreisvR2N6MW45SmtIZER6SDZr?=
 =?utf-8?B?LytzcWRISkRDS05kTVYzUmM2VW9SYUhVMktENHE4endlS05wZ2tRTjJTZ044?=
 =?utf-8?B?ek5PSFY5RER3QXBGdmVHbUo3SW9rTVFJZHloSFUrWDlrVmlQYTlsaTBUcjV4?=
 =?utf-8?B?YVg0djRlODlIM2Z2QmVHcFpKQ0dJRzFiZnkyWjVMUlIxTFIwZFJZdWEraWl0?=
 =?utf-8?B?c2RpY2RFYlFsNFkxdWRvMDNnT01nTDZGMVRjMVY5Ym9DUG9ZbEJndnFRV1Y2?=
 =?utf-8?B?YVhRclQyaTd6OGQxbmhtM092b3lVZWxoS1hxQ0ZkaEdFbGgyU2k1WE0zSlVt?=
 =?utf-8?B?dGhsa3dkSmVLRlhxTzh4YlliQXZPMy8xbkFkY3VMUEg1L3Z2U0JzdDQ3Ykds?=
 =?utf-8?B?ZWhuamtBaHBMbmJNLzdJaThzVXNLN0MxM2Y2Uk1tWUs3bFdYTFlUak9uNlQz?=
 =?utf-8?B?MFlnZGV5enhaeEFybEZGUCtYNHZwSnp4eHh4WEt3dTJOZFpxbXcrZUZEbklh?=
 =?utf-8?B?WnRuNXhLTHhTb3lGYk5XeFZKZkE2MTdhT1k4c3BIMkhDdDFIcjdENDgxemRI?=
 =?utf-8?B?OTExVVRaOU1XZ3FhTUYxOEN2RVNsaGdKbTlKejhNVFl5ejZFOTlzTG4rOFVz?=
 =?utf-8?B?TVV0ZThnNjFOOGxRWmFwTWpQVS8vQVMyb3RKTFo2VHhES2ZmRjRnbmJ2RXFQ?=
 =?utf-8?B?V1V1Q0Frci81T1FTa0F1Z0lkdWUwNGowLzh3MTRuSXVEWlpaSExvN05kVzAy?=
 =?utf-8?B?TFdZSlIyUGdJdUZSUVV5SU5QU1BFelhuR0hZVEpSa1B3UzZVbDVBd0JGdEY0?=
 =?utf-8?B?NEUwcVAzNzd3N1ZNSm5PNDh3RkJucWM4Y3pRcVJkV1UxdVJMSFJ3cVJIVkd6?=
 =?utf-8?B?WGlxRmlGRk1YUEc5YkMvMFlyNUdRTlNmOVV6RWd5eEkrcWpnbElQMzdMTVV2?=
 =?utf-8?B?QTdYNXMxV2t6R3lmbmxGVXh5eTVNS3JLWVNKeU02aTJVUEgrZU9nYmo0ZUNJ?=
 =?utf-8?B?RFpOQnVyMWZnTnJqSFVNUFU4czErTGNjTVFQWTJXcGVySG82emFNUFlScU9a?=
 =?utf-8?B?eUJUT251Y0NuN1FBaTcyZG1vZFZzeWNxWXNxUTRjM1h2bWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak9PbXQxYjVDSEI3eDVBL281N1htVUFqeGxwbTFUUlJYeWlMZlNhRm1iaGZ1?=
 =?utf-8?B?S2R0UmU0SlMyOFFJNFdUMWtnWCtUR0xUcXlNeGFrSHAwMHJhcnhQaHUySFVO?=
 =?utf-8?B?bkVEY3czRDJ6WXUvSzQzYXJ1R0FCWU9DV2hNQm5rbUtyZ1NabWl1RDNQS3J1?=
 =?utf-8?B?SzdkMCtSVXE0U1ErRlRoTmhwZzhLSU1DbWZyOHdCTFl5cFdLQm56bk5vVjVi?=
 =?utf-8?B?dHRCNTU4dDhRQjVBRit2ZFluLzg4MWhmR0NuK3U4bFliNFZURnhjbzd6WW5O?=
 =?utf-8?B?R2c3OUVLSGtCakQ3aThxM0hzL241ODd1cHFxcVB6U2h0aG52bWV3WDBoT2Rk?=
 =?utf-8?B?RHZGMVBSWjladmllTEFKWHVzSjVDeStveFhXRVQrL3hDNHRISXNWY0NtQUF0?=
 =?utf-8?B?a3B1R0huOUJ6UysyT201R0dHTGl0K0xwVjhkYjl4UXQ1R2F5YTdLcng4Q085?=
 =?utf-8?B?U1NVWTN0WlNqZGVYelVndHpnL2luK3daNjk3OTZ6cEhTMG1sYys2Q1NRMWYz?=
 =?utf-8?B?RVhmaXBWQlBEQ1FMMzh3UFF5YWRrYUhudzZNTWw4aFljU0VNZWJqeUpJMHFj?=
 =?utf-8?B?dHI2Vis0TmVyV0o3bHVxUGhDQzM5RmpDRTM1dVF2T3MxcC9qQ0E2cmtTZHNN?=
 =?utf-8?B?UWFZbkUzV0VwTHh6TWhBTGx0eEMrbnNjdDVSOUU2NEZXLzBEZXBOa1g3OVl2?=
 =?utf-8?B?bUhtVTZYTGNBV2JIZmc2V0h1OTBCSGkxbUsyK2U1WVpxYS9aUHUyUjJnekdp?=
 =?utf-8?B?OFE0dUtNR2JjNGE2bUVnOVpuNEdpbXU5Z2N4d2JFUDlHdE1aRnN1d3BnT0Nl?=
 =?utf-8?B?a3A5QXBRdGlUYTJsVDVDcEFVc0xBMkFFczNhSXRXaTF4LzRuSGVnZ0FTS1Zh?=
 =?utf-8?B?QVgzV1pqcUNVYUkxNWptMktpN0cyMXFYRU9YelBiRDdiTUh3RWMvcUdQTnlw?=
 =?utf-8?B?aCsyKzF6VVVtVnV5bzhmeElnT2lYYllkMFhSUEYxL1hTRzdFSk0vd2p2aDZC?=
 =?utf-8?B?MGxmZTFPT0lDTEpEUUJDK0FSQmlyZFN5NnJSTFRoVlF2TjhmclZQYm5hTWVu?=
 =?utf-8?B?ZUc0bVBJS2dGRzZTeGlSRnZYUmdFekcyUHZta1F6Lzg2eWNoMHFZNUorSjdw?=
 =?utf-8?B?WUJaMWo5Q09iZ2YwY2RXREJHSEZUQThQUU9SWGo4WHFBWUpzaEZiVWxhbFdF?=
 =?utf-8?B?VmM5RW5yZFFsajUxRHFQK0IyVTJXN0RTV3VzQ2hBdTJEQWhwTU11S0xTWEpB?=
 =?utf-8?B?QkV4b2ZwclA5R3NHK043RCtiSlpKaVI2ZjkrRSsrRjluWmxEOVVWeXZnb2Vt?=
 =?utf-8?B?M0dXZUxiK3U2YytSeHlHSlMwK01pMG9wSnJzQkxURWRvNmJjUDR0cXJOUzRU?=
 =?utf-8?B?QVc0dGVDTGg1VjdINlBPa0t6TzFvbnhrZGRrRjI3Vld0ZER2cURqR1lCNHNr?=
 =?utf-8?B?cTNmWlFad0RhUXBNZTlSWEF0VlB5MThncVBYQmZxUUdNQjlnRmxVR0hHUTl3?=
 =?utf-8?B?a2krd2JXd0tGQmhBT0UzU2lieWNsK095eEp5R3ZPcXBBTXVYSEorbXFhRDBp?=
 =?utf-8?B?V0tPSmNxTzNwTCtFWlgxMXNMVkZiOVhEWnQ5U3pKVGVZNXZ5Vk9pUC9NTElL?=
 =?utf-8?B?NmJUMVNRcWY4YmpGYjY0Z0dOMHFxNVUvaHRicW1iYmhZSTFBVEtzVjF1ZCtp?=
 =?utf-8?B?RW40STc4d1p5ci9LV1B6c0VKNDF0ZUJRV3RCU1NCSndPZS8xaVlYVy9DVDZs?=
 =?utf-8?B?N2pYbGd6bW5xeXRGTDNFQjJlaHkxWEwreDl6MGtOUE4vRHJ1ZUY0MEhEeFA5?=
 =?utf-8?B?YTk1MlVKWXNOTUZNT0poVlFIU05jZVp0MmgvWnVIckVWdU5KN0ZDMkE5ZUhL?=
 =?utf-8?B?TmNpdHZRYTlYTkpZQ1hGMjVYcEdFNzcram9uSk16TW5nNzVLNkVNbElyUExp?=
 =?utf-8?B?MDlPbEtvaWg3MFZqYit5WXVsR1NBQzVDalhqK0VSM3pONUxwMGZmYU5XU0xJ?=
 =?utf-8?B?cnVWc0Rmdm13eW9GSWdoa3JpRWZJczRkaXRJa2NmYkdVK2NZTU1qbUVSNys2?=
 =?utf-8?B?cG1NWWRLcWtvc3BramQyaG9wd2hoVXE0Uk95aXh4TTNKajQ0bllrelR1WEJP?=
 =?utf-8?B?T25tYXphNmVmdG9tVWFPKzRyeDhOblBKMy9XK3Izczl6SFdQbXE3TDM1Q1F3?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38d04fe-ff95-45fb-9f94-08ddeba066c1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:47:10.9716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGXOFJrj9rpDzbq2fW6CGryOQ0mMVDsyZvExI/NGU6Vs7hXJa5cLN7ETS2oNdxCEeMic3xfydydVX/UdmS89dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6095

On 04.09.25 11:58, Jan Kiszka wrote:
> On 04.09.25 11:42, Florian Bezdeka wrote:
>> On Thu, 2025-09-04 at 11:29 +0200, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Check the device health and the device state. If the device is not
>>> healthy or the state is not idle try for "WAIT_FOR_DEVICE_TIMEOUT"
>>> minutes until aborting the test.
>>>
>>> The default of the variable WAIT_FOR_DEVICE_TIMEOUT is 10.
>>
>> Hm... Not sure if I understood the problem correctly.
>>
>> Assuming Jan spawns ~5 or ~10 jobs for a specific device type when
>> pushing to one of the Xenomai 3 stable branches (or something else that
>> triggers a lot of test jobs):
>>
>> - One job will get the device and will run
>> - remaining jobs will wait (and time out roughly at the same time)
> 
> Right now, they will not run yet because of resource_group:
> <desired-device>. But if we removed that, we would have to take the job
> runtime into account while waiting for device availability. However,
> there is no reason yet to remove the barrier.

Unfortunately, this is not true for qemu devices right now as we have 3
less than when the Intel lab was still around but even then not enough
when a full pipeline run hits the test stage more or less at the same
time. We need a much higher timeout now, or we need to throttle qemu via
resource_group as well.

Jan

> 
>> - one of the remaining jobs will get the device and run
>> - all others will still fail
>>
>> Correct?
>>
>> Does that really help? Maybe one more successful task (when the timeout
>> was enough to wait for one test-run), yes, but is that enough?
> 
> The main issue this change is addressing is that NO device is available.
> So far, the job would wait for hours then before timing out.
> 
> Jan
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
