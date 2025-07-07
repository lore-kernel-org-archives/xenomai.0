Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635421B9D9
	for <xenomai@lists.linux.dev>; Mon,  7 Jul 2025 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883428; cv=fail; b=oQeRbVZwALrvNxh7sgxTvnnEYp2qZ8++WHTDw9Dr967lQuKMb5aUrTOFNBhiRDupVvCIfo31e/Lt55O1OwVgaU/unsnwY3Y4iWKoUMvDwB3fEoqqU1WFcq0B1Jx2V4aU5Q7JfcDrw5mywL62xS/ZEmx0crwRkvoqr/cpvGs8ZOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883428; c=relaxed/simple;
	bh=XX6djyQTgSYJOCiAFqEjrRsOQ3PCqeiHd10+CJ/azfE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dm4izHi02AIeON4OLdVzRCR74wWQWJQggEaEcv+hFVPQ/Nbbi23EgZQYTp/Nh2rb3UIoL/p3RhYRKyqdy8gZBK8w6Re+sop1UL2ZZB7eGaJwiCcy21cpart1fRHb1MVKrxCvBBtgLayWsz1oe3IKhKHDYdnp4nDpbUTJ/L91XE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MtQrtJpM; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MtQrtJpM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAEHq3dpUoM9/zZdwg1Ebmcr/ZA5Ar7QfZPSJCRdfEjlwL24VlDaHAPMrEKRICxqrGZ8J0nKhVtR62oSytgW9Wvk7U7HclJ3o350I721XIE/i/OBAO2EfONNlOqCy26/EY1TdsVJva9SVXEl8kHSPUsDA0ijqOeANlSKTzAubSw8hLGWuieJQezyS9tsdx9gAOjvEWSxZ22hNtA92movLoeXi7zP0Flqsu5oOcFNvsj46RTOwSy6n93UsGyWHlRv4IN/Hf6UoH0vbN0kydN/pfU2GXmm/JVLl+/XhTOeBRDni8YMKUDHW7wV+Rrm1vbtyd1DLCN6LcoXkyqXwkgw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPuq1VnpJHgRUg5iXsLFB3uIOzt5Z7gQh/EnIdFKCWk=;
 b=QqDkKeVPZNNd0oW6q7raN5B5P5HThIjqYJCH7xzvubYCj3V32eXiEEQOlD9VlF9/X8vnUNLVccfZj4Syubmbri4UzOmRLbLeMZrOnSajOX0by7WT12DEkYxxlNWnG0RtMiFuouVH7NmHj4qD8mJUyCJ1/OuiTEHhgPcCoMa5FUo8eHRlqO9S8GEWujHHlqKFcKEWY8El+1hKijBTneYZ/mgIXgJghPpWUNs4GPy4GjsVDD//BFP2ZDObF0krdwh6NatWKFsvhp04tMoOlezuMOuV+KV+o2CkXjBwCgNcr8kxvvqhKetbY6OZR88xPVfuy6aF7f6RT0hkExNKQHEHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPuq1VnpJHgRUg5iXsLFB3uIOzt5Z7gQh/EnIdFKCWk=;
 b=MtQrtJpM6K5K8M2qOv+oMaZSe097hbd/M5djyNnnI2RSPIXJ/VQCif4Ve1OZVAQmNgQ6g+QC13f7mk2crjw6IHjN8ii/d5aIvci2vc3clGaREz3xrqFfr3KY/EDGbhYia+B/JIhfglndOM+sH2uE2awuNJpUxlO79BT0DB1E9iE7cfa6GN6zmsd9TlvK4s6zCnxVNi4AnrHLAFHVquyURbh3Pk4CtbfdIBb0pPJ0jLL8zBVRzwPh4wIv53wn6ag5zdvgZatRZ/FW258MnqKFUrWPs2T6onI4qotYmv1DWDAMvM6W44SSrLmAAVOFBUTGEjJlTJ551SbqRFo+WT+eng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 10:16:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 10:16:55 +0000
Message-ID: <588405a0-91f7-49e1-9bf4-a0789caddd51@siemens.com>
Date: Mon, 7 Jul 2025 12:16:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boilerplate: Replace strncpy with snprintf in
 ancillaries.h
To: xenomai@lists.linux.dev
References: <20250705135610.217774-1-aspirestro@163.com>
 <3de47756-65c5-4eea-8304-dc56f70aa8e0@siemens.com>
 <yq6xdecuqpn4i3sf2koy72wq24dbfx2qe45v7yrqc73vyrkysa@k7c3eazthgko>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <yq6xdecuqpn4i3sf2koy72wq24dbfx2qe45v7yrqc73vyrkysa@k7c3eazthgko>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: d1563ea5-8248-469e-857a-08ddbd3f6665
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkY2NUNvUExVT0V3NGpHdGRQb0VFUkhPejdDZWdhc2JTOGJ6aWh1VHZUVFhZ?=
 =?utf-8?B?dkkvMDRnbDFxNGlqNVp2NXM4a0Q3WW1hSHZQbmV3dVUzc0EzRFlYSEFhcEY4?=
 =?utf-8?B?ZXM1MjBBSU5GdTlQTnBlMC9zTkFYN1BmTU9zcTlUSmQ5S3JLK3AxWHppNUN6?=
 =?utf-8?B?YWtubERoTXM3YUcvQjUwOWxWYUhkLzJBMDVPMHVvUEJJcmpueU05cjVxcFdk?=
 =?utf-8?B?NUNzMDhkem1QTnp6dk92Z3ZicC9UOWp6MnluZEQ2Mm5OcTJXOU1XSElKd0Ni?=
 =?utf-8?B?cW8zQ01aYmV3NENhMmJqcWszd0NzQVMvMjByd3BLSnFqZlVkcGU0Vy9acGtF?=
 =?utf-8?B?MDlDR0VzYVNuN3ZWRVB2U3BlZlc5dFBqZkRVRE9aeFZXVWRzV0xjZkJ2US9w?=
 =?utf-8?B?clhFSlRzUUJHSmhac0hBUUUxeDFSUkdWRWtsTDg0M1lvNGdIWVVXRFA4bEJO?=
 =?utf-8?B?RllWdlgxcEFLUWxScUJzM0MvMGdzbHo4b0VPYWFOc2JGU24wenN1bFQxWmVi?=
 =?utf-8?B?KzRHV0ZNek1ZaDlhN3VQbEI2dCtTVWVUd2ViZ2xuOFdFRlVscmN1dmNnUHhS?=
 =?utf-8?B?UjYvOVhPcHJoQ3VkeXJoNUtDYVE1N1htSm1rNFJzVE9pcU01L0REblZXTW5J?=
 =?utf-8?B?RXdmZnZLSmJzV1ZKWWJoNTAreWV3SU9VUWZ1QS9TSmFlZzM0V092UUhxeUFj?=
 =?utf-8?B?TFM2SWY4MFl3QlVITHNLUG5rT0JsNC9DQ0c1SVd1VTBOWDBsME9ZSm14RDBt?=
 =?utf-8?B?cXlZcEwyaDl2VXJ4R2VwUzdiZmQ0bU9INDFGQXFPOHE0RGVpR2Y5WmtsbVJz?=
 =?utf-8?B?djR3R3pBSU9oVXpnWU9pcEtrUnkrY1Q3TkZjdlU0UnFFMDdRcW9Vc2xlRG1p?=
 =?utf-8?B?aW53bnFGb0FQYmlSNmlOcUJUQkRqc2RjL1dNcTY1djNsdmkxYVV2ZytTanVi?=
 =?utf-8?B?ZVkxVEVTQnJuekh0N0I0TDhSbzFZK0VNTGp6YlZJTDVPTWNRRXNndXNPZDJm?=
 =?utf-8?B?ZjNwK0xjVnpMTjEvS2lYMEJ6aE5KbDJncG1ickxTTEpvekdkdUJvUWpBUmhW?=
 =?utf-8?B?M202Nm4zOEVINm9MNnNKUVZMczhpbzdUUUhvL0VKb0JNc3ZzS0REUFVoNWJU?=
 =?utf-8?B?SzBzdzdNOUdmTXhlZ1N4QjdlMWF5MFVseTBEYllJYWxrbzlHK01xTE05OEdL?=
 =?utf-8?B?MFFRYTlLR0JFaGwvc0I1Sm9zako4M083Z3lMM2FpVC95ek5HMDMrV28xdXlP?=
 =?utf-8?B?R3ZkVy93Nnl4K05jZnZmYnl4enVrckpITWh6SC83ajVjNmdGSENFN3Qxc1dE?=
 =?utf-8?B?YS9ybVN2cjBxbTBESElremVsNnh2Wi9Pc3pLc3lkVjhvd1NmRVpnYUFpU0FP?=
 =?utf-8?B?eGNER3lWRDJ1SUw1ak1hZk1zRllJOHVzdi94VkpyY1pmUlJXME9aUkVTWTcy?=
 =?utf-8?B?L2YramRFL2tDK08xYXdXeVZtWlFhV0UrbHdDRStaYllGV0ovYnBicVN0Nmho?=
 =?utf-8?B?dHVmd0M1UzNRZEdZcEs3czVsb0tDS0E5Z0ZmR2ZiRnYxQUEyNzNCY0ZMNWRF?=
 =?utf-8?B?SDhjL04yWm9hdW9aZmhTc3VheHRYY1ViWWxIbnJsbXBCUzBZTEpxcE5xYllQ?=
 =?utf-8?B?cEtjT1J4ZFlEQ2hxTGs5VERLelVZNHg3bzBrY3ZhdkNOSkRJMWxSRVA0ZE13?=
 =?utf-8?B?Y1QyRUhEdlk4TW5wUmR5VVY0SGJRYm1FMjhDbUxUVW03VE9KbXgwNFhTVlB5?=
 =?utf-8?B?ZUlpbEJoRExDUURIT014SCt4dkx2QWZKeHltcTh4YzQ5SnE1N3p4eFB6V3hr?=
 =?utf-8?B?T01PcXV1eEtxQTFxdUdtZHdvUFFTK2pid0pteUxlRGdxdGREK3ZMZlFpV2Fw?=
 =?utf-8?B?Z1Ztc0ZrN1h5empkVzhNMFJxMHN0Znd6SmNHWHhJYjVoNHk2c3dUQ05RSjJM?=
 =?utf-8?Q?+uE6oKfJWfg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2JvRDQ2UmI3YVhBcnFJcnFjSzlVZVpMTm8zSEhVaDJmTFBRNjJmM0tmS2Y4?=
 =?utf-8?B?TDVpd1RuS1pJT2lnb0tKSVd1WG9URUZwTEJEeW0zNjJyMHk4TUpJRnFrRFUw?=
 =?utf-8?B?aWZFMlVJRG1nczBzTnh2NUp0cWVvQlNzRlpZRi9rdFdwMlJNR2xvOTMxeGQ2?=
 =?utf-8?B?Z2dRVGRqTWdhWGxwSFErSTFRZ1JyazljZHVMWTBSUkpuUkk2ZFY0ZzVJdDBG?=
 =?utf-8?B?dS9Od0JmUXpRU3ZueFJnMXN1cmNJYUk3RmgzZGFrMHpOak1qRE9BM0tZdE9H?=
 =?utf-8?B?bFp0b3pzcVo2TG1OZndud0hYU2FBcForVGxwMzVsS042bmpwcjY2WXhxVXU3?=
 =?utf-8?B?bW8waTNsUDFPSmNHSmt5cm5jVUdBR09BTDlINkNjc2d3TTlRN3BpOVVhYk5s?=
 =?utf-8?B?LzdWbzllWkNDOUMrWldSbThyL2xCNHplV1JGWW5zWm01MitEUmtEOXRkczY4?=
 =?utf-8?B?am9oSjhIYmNtT0lFL2hKeFRNd3RJaStGK2pXOUZTckRhc09SQzFORnZyOXdR?=
 =?utf-8?B?dHBZVTN3LzRac0hDUWIxbTYxaGhpb24rMTBxWXN6TW9tK21hZzRTbWlEZFhn?=
 =?utf-8?B?akN2dmp3T1F3STE3QTdmZWQwUWhyOXlYRUMvR2dTNEFoczk1NkFYSFdkU0x5?=
 =?utf-8?B?bytCRXRXb1hHTjYrV3R0MjUwWWc2WnRWZlJJdFd6ZjV1a3ZUenljdUoyY0dY?=
 =?utf-8?B?STYxQXpxVjE1R1ZoRDFSZHM1ejAveU8vQnpmOFdoa2t4ZlpQNjE3UTRqL1Z3?=
 =?utf-8?B?eDNCcmdyOTlRRXZ2R1czMEVFQmw3enZTbklQMTE0TU5mZW5WOHNVYzRZVW5H?=
 =?utf-8?B?cVdRcXMzQVQ3SURSdy9SMG8vWkdRRGx0K2NRUmcxSGpXVzF3Z1g4LzJwanZM?=
 =?utf-8?B?ZWgwaEdrejF0amluY0d0WkdjZ2hrNit3WXJDMHFwSUc1MC9yMTZNdjhpT2V5?=
 =?utf-8?B?U2dpMmJrb1BuSSttMDk2R01DbTNQUk1qQTU0MFpjZGdMSjU4UTMxT2JuMStJ?=
 =?utf-8?B?THJtRG5PRzBJbFJJU0FXZHJiOXFZU1BHUDZWUVVuWjRVK3krNmQxckgrbnJK?=
 =?utf-8?B?U05mZzhkb1U3bU9YbTIwVC84TUNyRFZINDAzbVpVZTc3NnZObWdvMkRYbE1C?=
 =?utf-8?B?S01BcFlkdUd5SkN2VW5UcVNneVh6OHZTWFRPT2lkZklyV01qZGxONGV0RjRN?=
 =?utf-8?B?S3lmMjh5Y0M2ZTNkY0ZwWmh5akVvcWdzd2hObFV2YUE5MTdmN0RmZVFCRitF?=
 =?utf-8?B?QXZCYmx3a0pObDdZTm90dmx0TThMaWNoekFrMU5RbjZXWTgwTnZ1dWg3cjJm?=
 =?utf-8?B?MnBMaWZvV2ZUa0ltcEpQbmU3SzNJSFRtbHBhZEljUEtBLzAwbWR5R1R0TkRT?=
 =?utf-8?B?dG5veVdpeERZM21HWDBucGxWcE9waGtsOUF2YW4zU1hQVlZ6Sy9LRE1YZVc0?=
 =?utf-8?B?ZDJ3alpQTGJuOVpnWWtKY2xGQnp2ZHVUZ05qM1lrTFJyQlVqaFBkNUlLd2tx?=
 =?utf-8?B?RTFYQzlpTmd6VHlZenJiSDBFWlZib1NZeFM1b3EyUVdiMnF1dDVQamVKSyts?=
 =?utf-8?B?aDUvcllzWkJMT0lJd0g0OGU4ZG82aEs3UTd1SmdqNWpoSWE4U1BWVDk5NWh1?=
 =?utf-8?B?bFZsQ0Y1TDhDUXNoN0Y2UjZXcXZzVHR6THBsTys0c3liREhMeXFKSTk3U01p?=
 =?utf-8?B?QUF0UjM5MUtOc3k0ODcyTGdaeUxTejJZdUJXK3ZkQzVlcGs4ditjalc3ZDJF?=
 =?utf-8?B?WnpBa1E2R0U1eWdaamsrQ0JjOWRvVXZESzdZaFdqRTFLZi9PTmRldENlVTVW?=
 =?utf-8?B?bFgwYlE3bEJWZmxDK2huZ2dBQlMyeWl6K3ZLb3hiTlJhTnBoRU9yc05yckNm?=
 =?utf-8?B?TmZHWjdHMFRSbnI4MTc3ZDdHZmxxVmluL2xna0xYQklTUVI5aDUya3ZJck1W?=
 =?utf-8?B?NDA3ZXAvU1FIQWhGWHNsd3FLVW56MGZCWSs2ZXBTS3pmbVhmaHFqKzJIQ0d0?=
 =?utf-8?B?SUNNT3J3WE9nYkhJQlhlWFMycWY2R3lxL1ZtV0dydkJwdmRLWVlabzYxdVpn?=
 =?utf-8?B?Nlg4N0dxN0tBdE15azNFSXROWGZjaEVsN0hKVkFxalo5ZTFadll4ZzhQRGlM?=
 =?utf-8?B?TU16WmV6ajdSV28wb2d3c3o5WnNuQUM2RW5jc2RldHhSZytlVStXZVNZK084?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1563ea5-8248-469e-857a-08ddbd3f6665
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 10:16:55.7347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+ZpRc9+xcr9UTBgIjrK5NDbOkEEKLVYb9/MiAjOH/J3g68qMlEuRAlBwI72+S5AD/PV1DRTtdK1lnxmWfCc0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087

On 07.07.25 11:44, Haiyang He wrote:
> On Sun, Jul 06, 2025 at 11:34:09AM +0200, Jan Kiszka wrote:
>> On 05.07.25 15:56, Haiyang He wrote:
>>> When configure with --enable-registry, it fails to build regd/fs-common.c
>>> caused by strncpy. Using snprintf instead of strncpy ensures that
>>> the destination buffer is always null-terminated, preventing potential
>>> buffer overflow issues and compilation error.
>>
>> Thanks for reporting the compilation issue. But this is not an overflow
>> issue, just a confusion of the gcc in Ubuntu 22.04. We are properly
>> terminating in all cases.
>>
>>>
>>> $ ./configure \
>>> --host=aarch64-linux-gnu \
>>> --build=aarch64-linux-gnu \
>>> --enable-smp \
>>> --enable-pshared \
>>> --enable-registry \
>>> --with-core=cobalt \
>>> CC=aarch64-linux-gnu-gcc \
>>> LD=aarch64-linux-gnu-ld \
>>> CFLAGS="-march=armv8-a" \
>>> LDFLAGS="-march=armv8-a"
>>>
>>> $ cat /etc/lsb-release
>>> DISTRIB_ID=Ubuntu
>>> DISTRIB_RELEASE=22.04
>>> DISTRIB_CODENAME=jammy
>>> DISTRIB_DESCRIPTION="Ubuntu 22.04.5 LTS"
>>>
>>> $ aarch64-linux-gnu-gcc --version
>>> aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
>>>
>>> The output of build error:
>>>
>>> make[3]: Entering directory '/root/xenomai-next/xenomai-next-build/lib/copperplate/regd'
>>>   CC       regd.o
>>>   CC       fs-common.o
>>>   CC       fs-cobalt.o
>>> In file included from /usr/include/string.h:535,
>>>                  from /root/xenomai-next/xenomai-next/include/copperplate/heapobj.h:24,
>>>                  from /root/xenomai-next/xenomai-next/lib/copperplate/regd/fs-common.c:27:
>>> In function 'strncpy',
>>>     inlined from 'open_heaps' at /root/xenomai-next/xenomai-next/lib/copperplate/regd/fs-common.c:248:3:
>>> /usr/include/aarch64-linux-gnu/bits/string_fortified.h:95:10: error: '__builtin_strncpy' output may be truncated copying 31 bytes from a string of length 31 [-Werror=stringop-truncation]
>>>    95 |   return __builtin___strncpy_chk (__dest, __src, __len,
>>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    96 |                                   __glibc_objsize (__dest));
>>>       |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
>>> cc1: all warnings being treated as errors
>>>
>>> Signed-off-by: Haiyang He <aspirestro@163.com>
>>> ---
>>>  include/boilerplate/ancillaries.h | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/include/boilerplate/ancillaries.h b/include/boilerplate/ancillaries.h
>>> index c8c209deb..8de353ce8 100644
>>> --- a/include/boilerplate/ancillaries.h
>>> +++ b/include/boilerplate/ancillaries.h
>>> @@ -36,8 +36,7 @@ void __namecpy_requires_character_array_as_destination(void);
>>>  	({								\
>>>  		if (!__builtin_types_compatible_p(typeof(__dst), char[])) \
>>>  			__namecpy_requires_character_array_as_destination();	\
>>> -		strncpy((__dst), __src, sizeof(__dst));			\
>>
>> What if we do
>>
>> strncpy((__dst), __src, sizeof(__dst) - 1)
>>
>> ? Is the compiler silent in that case?
>>
>> BTW, we have way more places where we are using this pattern, also in
>> userspace (lib/boilerplate/ancillaries.c, lib/cobalt/printf.c).
>>
> I actually tried this method when I encountered this issue. But it still
> reported the same error message.

But then why here, why not in the other cases?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
