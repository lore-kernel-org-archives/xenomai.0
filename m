Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794399529;
	b=mqRL38X57kRu7ssFHd3QM9plhll5QuBexXmp0QZhe6uSV7U+yzWuXteloozMn56aSKMS
	 Kw84S66UByt8WIJumNtKfmNfpnOzKwFi7zNv1HbAEdVv7wL5KMTqEcP6zqPXYsPwpBoZ6
	 doJ/IQL8Uva9hjWRosOkkUel0ntZBkWb0tQvnT+WWszowowWvUi+AYLYr+HJpONRAMaYE
	 zE7VHDamlGCHjnbRb8pumRPuooorL84AUv4T1BWVb/biwTf0oJJlCP6nGUbMORuwg3dSG
	 Tn8tjgi0bF7gd+HeNOq5/x9GVmyz0edl0y067WeUCgrwq6234f0mp+xnd2UcBrYIoyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399529;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Content-Language:From:To:Cc:Subject:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=vq7Thy4Aih9nu8R8KmXK9QSeNq3KkAe92CDzdRidwEs=;
	b=j7zsGTHWiHDLjQP6RST14lWKnhVX05RfxxjCQ6mksDqLopa5E1kMb79x5qnr0Ob2qg7t
	 xAdedat+S1nqMZNPhdwSUQ6RPv/g0IGBtd2GwlsDMpJvq9dwfqk5xRVN7qAasWC0sV+OT
	 xVKoBV6c/rhHUQ12weUghNocmixw4PyVxikmhR4sSxIJbzoOaegarX3jB10JNUZa4kI4J
	 O7RZXfggGFPOZ85qofEsnleahGIyUoruSOZ3gkwZp3ZcsWEIcG5UVUSM9tYaVM86nhQjU
	 bL3Y4b0QK0nW/an6isCwAmI8VvT4M2JgHO+0dZz1/y9FOZbOOKOn00+UkxZj16RB2Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=L6PEYkjf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.14
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011014.outbound.protection.outlook.com [40.107.130.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37A606A321
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C37A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=L6PEYkjf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTlDNrW/JNBJEO+wC33Cve0fzcZdVoGJW3KLnEvshIyniwLQMxviBRM+W9EHtSZxzjQhMp2yBGup6sGlzQ6Lsy8/WRRhnD5Jtmt3Qd96RVzle7evzGOu9SEvQ3pMf8VxRVVb2orT6JnonRv+oi4rYS4T8Yx3GTc+x7gkm8PBMsnbeCpzkPHpYjOmaOkGicTwBpt/ZTWUENILEnfrYoec0EOs2OiB7TUJdZ5rCl7vupj2KoOyhBVTrFjygQrwMax58u2UliKvaxw/husAQwiO+qc1GNyf/LSVM+mQIs4J/MUxGnGEaD9ALF/n3XU8NH+tyLnTeZJMPLqhObrTFE1Jmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq7Thy4Aih9nu8R8KmXK9QSeNq3KkAe92CDzdRidwEs=;
 b=apFLEbfk4JyuRgU1XCqpKp0mzu1skjCYli44brUvANhTN+n3ZwS0X+aWdfcmXs9D6doZRJLfQXRtaoCjFKrKYStCtxmpWZ5Uf1YBZTGIgkONjKDrt6h1bShzB/xLwYuLOA0WErqd6/hLUXcEj8fN07QptvfZhqsvpyxvfFVm/VW98J1DjstgZOiibUOJssU59XX3nreGZw6t/cKST34j2EpkUI7NIDoiHBmaDoS6kAQ+gMISBiZppi+NUirb1n3qgswVBCOtKBm5pxkj+k5Xd5GpkxmdpkWi0Dsp2re32aDgZnpQHqRz+t/629fC7/yXSdIShD4j//AF5kTzlmAnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq7Thy4Aih9nu8R8KmXK9QSeNq3KkAe92CDzdRidwEs=;
 b=L6PEYkjfmKMW7NkEqtD9XVnFusQMiZSvmMzQLnKu2qNhKnkViybgXWJxLOkFwUu0ZDi7vzaqG3Nyo4cPGloa2DsyG2TBwMb2vswvRefirjDZxBACtVEgh3IiTd4VSlC6LJx8JE+DvigmjTJN7dgVrtRkuPy42fj5jOpAA9FGv1dLmc7j1pigBJoiZk8LbpUKgSu+1bV1dGtVYCZBerzMoNQ63Gr3Cp0rgjSWhX92/4OOxVqeIWH/PxZYZTBVYdYrQPqIWgntdHGACbrB8YYT7ZkeTeyBW7hqgtcze+rG1Pu8UWsYsANXAXvx7AY8RRvxNYVf3gAhnNNlfMudVa8t/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA1PR10MB8893.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:451::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:18:40 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:18:40 +0000
Message-ID: <18f772e8-118f-46f6-963a-58db46724e24@siemens.com>
Date: Wed, 11 Nov 2026 13:18:38 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: O_OOB ABI
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA1PR10MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6854db-5580-41e9-e2d4-08df3fedebd0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|6133799003|55112099003|56012099006|11063799006|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lge9I8lKw8IwcuaOYVEQW5OdHxlT3VHqG1nF8gFFbZPxkFlZ8R7fJlR+l77pW7kBtigVtOLTDQ9jXgP8N/Eb7pJswEQIr8bPixb9QqwgfeGao7vIlEEHBReVWWH1GJKT4GAPpfbGv6G63+/KRgeN7mMUCiJYYxHA3Lj2kMeKmsxuRVUjoAv0V/M5AueWhXfOXbQGsWBFicfs+re2pu7E67LYMEXKljsCREvkqGaOLpkroOQWAPjKYpUVgkmcqdf3JuvqL7vlQeBphWxg/O0yxEsjSiU9J7c2ojJpBTucvvuYEpSlsCzAQS2j5bezOcvNUEtfYSpq93mrNvdHVDCySEMqA8FnylMpgtOZg74oByv2eAxD1gnuVFmLihLMfDwxx/qbrchRGA+vp1VYYJWJTsbx038IQgoWYjYOVJhHI0mvDONodBGv57G8LphgW5ycnoUtkUI0lEFhEe2VlWOqb0euBNXzXdqxH1C9dr4vGdAC9PMNeGNnyfpii42gurghyLyvjPRbnGZJsg6Sjx7nxIiwYzz3RZCMlmPGxWIFdy2kJPEc7ugY++gTCegouZOTJSWMvMYCr+aQPOGsuKgxoxFQTAAde7pUMjWbScVez4gs1kZNBNmeFlK7nr0ZCf0jMvORoEPIh9bk/RQ5TAXMCRFBI5dYQFyMjdSt1is3lrw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(6133799003)(55112099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVNWTVN5Z1RENkJFTnpZWVdyRXlCbWFqQ3p6MDhCNXRESUI1ZWQwdzhNZUM5?=
 =?utf-8?B?WWwva1dmMEZ1aHg5OGFtZk4yYU5JclcwT3FrVjhRZEZmNEtoNjlkNVZ6aXFM?=
 =?utf-8?B?dGRPOW90dm5ETWNDaFVQakZRaHBZRUFKb0ZwTHh4ZW5YdDVORW1DMTVBWWVG?=
 =?utf-8?B?YjhmQ3FKU1Uzb3dqczZuZUJrcEhPNTBBRXhxN2dhSXdSQnRleGIvck54citS?=
 =?utf-8?B?K0Q1VkNHSTJ3RmdkVTFFRjdIcnFiOHZqNWFSeWxmcGxickoxckMrM3A1WFd3?=
 =?utf-8?B?NVYzR01acjN3dGZTQUpJdFlWY01Sa3JyTExqSzlxaVd3Rm9QKzd3VGxGM3Q0?=
 =?utf-8?B?bSt1THQxVGpKVmtqcDUxYmdsRkEvYWRQcGpNUytuTkRSMjlBeTEwNjd2bUNV?=
 =?utf-8?B?OG1sY0lhT2Z4UXpFTlBjVnA1aWY1aVpuZFdwTi91cDlnU0dZMlZMN2FvTjVR?=
 =?utf-8?B?YkhpWjh0bE1qc0RNc0ZaWXc4NmF6WWcxRHRGVjl3OStlcHhyeDRXaGpxTEZ3?=
 =?utf-8?B?TjRaTFhIbm5PUEtzSkFzbXdDS0RXN1NReC81Uk9ZdmdFdzM3R0swMGkybHls?=
 =?utf-8?B?NldTNlc5RzAwRzZUbk1pMThOcml6UEgxbFlSQTlaTkdwNmQ0aGRxeDl6Y1E2?=
 =?utf-8?B?MldUVGF5V3JnZm1aZXFlb2JMUGsxOGoyV3AzeFVxc25FdmtvMVdieEI3VmpB?=
 =?utf-8?B?Tjg0K25rK2ZDTmdWejNmY1ZnRWtid0RpRndmQkdZcHFvVkpITmh0aW5xTklV?=
 =?utf-8?B?c1hKM3pCQ0V4UzJHOU5aODgxVTllUEhxNklWWFRWaWs0c250a1FjRGp1aDVM?=
 =?utf-8?B?YnR0UlVSUHlxaG1CUzV0ZEY4WGtORFk1Wi9QOGZBSE1NN1NmMmpFVW9Sb0xB?=
 =?utf-8?B?bFBXalVlOEdxd1FRMTR1WG9kVEppbHVLckMreUcvOUs0SmdjeXgzVm1uWk5i?=
 =?utf-8?B?MUlaRHgwNnN2M29ZQ29WSWxwbm9vb0pYZVU5ZjUrY3R2TUdhb0NYY2dPSE43?=
 =?utf-8?B?UHd2dnR4TEVnRFRvSW5Kc2pKazY4QUdjUFRTeEZGMUVDZ2RZRXF4RUd3ZWV6?=
 =?utf-8?B?Znd2QVZZcksyM1V2R3FPSWF2K0dsNmRJdkh0eElzVWpMOUV1YkE0dFVyOVgy?=
 =?utf-8?B?NCtjVmhTeEN2SXppU0QvZXVBeEVKa01ETWE2Q25iT1dBaTl4ZThtRFpZeU1w?=
 =?utf-8?B?NVZKVTlSMFVtZmIzUXhyQ28rdVoxN0hudnhFTWVGeWtZNmUwUTJsQTh5QzA0?=
 =?utf-8?B?cm8zVWRjaXRzS0dFTWltTS9VckNXTzY3L2wyM0hpSkYwNExGaXpxYWI4LytC?=
 =?utf-8?B?L1J0Z3hjdUg3Z2dKMXpqREROMG9uUTBrazNFcnNXLzNBNzIvbnAzcG5FaHlD?=
 =?utf-8?B?TEJydDZhSHJ6TTIrMjVBQzhvaDdYNFBVN01aT1hQMXRTVkpRY2ljRXZUeWlM?=
 =?utf-8?B?cFpPYnkydHZhU2Vabm4rWGY0ODV2UnNhTlQxNTc0YjhmVjdWRzQvWmM2Tjg1?=
 =?utf-8?B?c0RMTFpETTFwQnlEeWJldU9wZnN3bjNlQ0FIajFBbjcxM0NCVjN3VmYvY1JW?=
 =?utf-8?B?OGR4OGJXMmY3bmJTRVczK0FQVE9CQkVGNnhVYldzamtaQW5iSzZuNG1NcGwy?=
 =?utf-8?B?N2NiZ3ZUWFlkWWNKVmZRQXdJYWx6WThJMjVQMkFZbjlJSUpUUnpvZCtQaGZh?=
 =?utf-8?B?bTV6Z3ZVMlVTb05GY09PQk1mTi9ZOVBSRzBWb2NBUi9CZkFRb1ZuZ1p0Nmwx?=
 =?utf-8?B?UmxHcklNN0dCbzRsNCtEQTA1QUY3NWF6WkhEcjl2bWNRa0w2ZmNHeXhMRjFR?=
 =?utf-8?B?Y0cxaHhMc3ZMQTRWWGdWQ1V6VlFYWVJHV3dTdFBhdjVQSTI1bU9JZkVmVzhq?=
 =?utf-8?B?cEJMMXkwS2J2YkZtcTZMdzdjNHhPRUo5TmhILzB0dnViSDJyY3JnMjB1eUZw?=
 =?utf-8?B?ejluekg3Z2xWNTN5YjZQbjc0endOT1U0SSsrMS8vYXdSaGhDRS8yZXhuNW9m?=
 =?utf-8?B?bDN4Z1NacnV4QmRxL1k3Q2QybDdCRWtaWXYyQ0VncmY5K09DbjU5OVV0ZWlM?=
 =?utf-8?B?RE9acVNDWXo5NlFuTExUV3BGaDNTdUU0Q3BCeTBURUgrRDVHZzRNd2I1NHZ4?=
 =?utf-8?B?c3g2MEhmZ1NWVGZURVNRZGpWZGxIcURqNmdNOEh3K0NHbkFkUGZYRTRPd2FZ?=
 =?utf-8?B?NXVqTXA3MzcvSFBrZ0xPbHhQM3BrMm5aNmdzR3JSZ0pLM0tDRTZ0RWxwSHNM?=
 =?utf-8?B?K25TcXFGMnZENjZ3dE9ONnpqbjJFRzA3U0dEaHMrZ3BSb3FPWjRIQmhqVndp?=
 =?utf-8?B?aFdsa2U3ZHdRWWVNa1F4WWZ0MkZhbXVjbm5nZTVid0VrL2NTYXRBdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6854db-5580-41e9-e2d4-08df3fedebd0
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:18:40.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSAEjhj9MNqHA7BzWXWW24qOHbFRtqIVSyV4Zkg9Rh90qjaNnz2fQ2ZU4wdzicUYhkahdcn3zBOqfGtt3Pw4fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8893

Hi Philippe,

FYI. I assume this is an evl-only topic - if at all:

"O_OOB changed from 010000000000 (1<<30) to (1 << 29) starting with the
v7.2 port. That changes the userspace ABI compared with 6.18 and ≤7.1."
(opus-5.5, while reviewing my 6.18 rebase)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

