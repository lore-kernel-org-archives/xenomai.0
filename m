Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2288119BBC
	for <xenomai@lists.linux.dev>; Fri, 25 Apr 2025 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745557631; cv=fail; b=F+JqsDpEL0yWBqCBJ0wYwCUEDBQMtq6Vqj2Dd4jw/iqmt8V0SfifXxmEBkJ1hPVs1vJi16U0tEg4Cf8vFoLrooosf0qNad8qiAFPCpVv3uMPFEpgoM0Q1Sofh42l2pebPr9LmrW5hCvLS98cxU7y9oXocfbd+A6s72VYm1CHvf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745557631; c=relaxed/simple;
	bh=LWxvgAe+eX/bLF5Q4SKFhtg/cauPcG1mNR+FBgPtS70=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=YL7KjQOWip7++FWtRgFT2DtGRsgXIqrgCCLTSx3isq0U6D7NPZb+fdPgi79ps36d583NdbnnQ9XeLDASMZqC89+dsLx/qV9rEMoRT0JkBQj/P+ylG114T5eDFVTBcFZtr2soAcfjEdMAjOrFg77obdE/fXOCX63j/0FjexvccZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=horov2Te; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="horov2Te"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGqrL8w5v7w4JT0TtNuLeq7qzIgHv3v/fyUDJLopPFdIAIrwUy1zyiq0ZuUBbnqe8aR5VCdx+6GJelz9hh31wI+Mh5BtTpzXYTk5P7yS9Ocz/Cz70gsYpQtBrac0qCbU9n3/o9EvJsHaLplBVjQD+R7OKU4ApccqvtElQ5MRFiioWBJpbxk6R0vy4A8zLzz+2aZnMsdkpCyY72Ok6vl38Vyn3Z41fqvdEvEg2lW8sZRf5qRt/y2sb2me6dR0xhTsA97Z0yObEFqBf4WdKYedp/7gD3v2ppaxjGTzNSu4bjbl/MISa9VrHCtT5YuljAb4ClbD6MUhJxBidH+gy6JSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltjeqJlUrgEy6DGUuvs0I3I4diYSDAB4oP+PtQjNvDo=;
 b=fJYyGjagMjrq1g2NURKNaF9nSee8sH83nVPzWgegxf6PBnOoAcMiav+zEif2g3YHLfrWiHR1nsM8C2hXtFV/Yy3N3RsH0Q1hSWzpGLs9aKokfN49UTXAHl/aykyz1Zz4sOZDR8WAZ4/VTgcohtBk3y1NseDW/4/hRNYxx4XeulhwlUDD3APyu0zcUUUv9ynGxprktbF16T0g9aDq3QI+fS0KmcVj3AmKcXIm4kJYYDvemM5VYLQruoHjxfR+OwaokYQubK1eJYBrgq3GMtRu6eWJ/vZs0iyXyTS1vFLLsT7l2d3Oa3dTIdWgze3HKpLyyO6DnbFdxRootQ0TnsW3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltjeqJlUrgEy6DGUuvs0I3I4diYSDAB4oP+PtQjNvDo=;
 b=horov2Tez1lnnDgcWz8yZN7fxboj6OoWUbRxIvXFd3VBv9e0YjBiEAsjG1DXrY/Zw2aaho9z6N/aeZq/9qhtFzohSnccSA4a/XFiThU+Tyuk0C5R177dNIXQdrbrBpKIu9taT7Mipn9SFem+N0XY0eO7PcM0qqDqffpoU0c7pr8owNNB05pcvb7UuaX1tnD7dig/aQpsroHyzNXNopgR28vilVjnAx7nJJ2wQL5CiJrZb4EonTKDZGvTWrdDG29A6xVIa2GEwG/zQpTZfMUITSrSyAIWKfQBHZisieeTQoFmOZXwrGM2L7lafc/z59jHk1lcXq0QmYxtmdlgfWO2Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7366.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 05:07:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 05:07:05 +0000
Message-ID: <a81979a6-a1eb-4033-a0a6-488ef8e74409@siemens.com>
Date: Fri, 25 Apr 2025 07:07:04 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] lib/copperplate: Handle allocation failures of
 pvstrdup/xnstrdup
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a91afd-334d-4940-c4a7-08dd83b70588
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUl6LzZBSXh0Y3dudHNXTlQxY2g4REs0dmRjN3BTNGFSMnU4M21RWnJYenFr?=
 =?utf-8?B?bk5HYWczay9HeTUzdENZdVVDYU1mUUhoa0dCQlJQL2JxallFcjlZR0FkR21P?=
 =?utf-8?B?eU02TkZlNjNqaEtRYldlcDNtSEZpSFpCeUMwMmlpZzc3YnhyTVFzR1l2MnVG?=
 =?utf-8?B?REpYbDZYekd5NUJtRDVOM2ZFYzdXcUFzeHFaRjU5UDFLN0ZONCtTM1BUVHdE?=
 =?utf-8?B?Z3Bmc0RwWkpoZ3Y5cGNtNmx6Vk14aE5RbElScTBuZG9xN0tCWHJLL2FERG5M?=
 =?utf-8?B?VHFkd2lDakZKQmg3NVl6WVRsVVJaZ20vR0J0aW1HTkNGKzFtdGZJWUIyWktG?=
 =?utf-8?B?cjVIeUt5dTh0eUpYU0gxSEdYZGhnaDlNZWN3TWVtOFBaUXAwdkJ4UkM0bnEy?=
 =?utf-8?B?dnNFTTlqR3pody9hcmdDR1JSdkF5TnpiU0JPNGhNUW15aDV5aGR0TzFtMmFz?=
 =?utf-8?B?MWR2Z1V1KzRxby81dk9vLzdpMXdqWGpFampSNWdFWlV1cjIxc2xoc25vWThI?=
 =?utf-8?B?emxHV21EN044bFdSRy8wWUxQK1AzZmx6THhwcVB1Z1JiYkM5d25WR0EydzYr?=
 =?utf-8?B?QmNHV2lmMkFqQlNUQ2RRTXdNdksycEtLTjdUMFlUdngzbTRCS3ZEVXVhTGRM?=
 =?utf-8?B?YjhWcEQ3Zk5yRURJQitTTDgzTXh4bnlva1d4VDJkR2hhM01nTStjTDYxWGla?=
 =?utf-8?B?WmFlQzhNNUJZQ2lYNjRBdGVLaFk3NXg3cUFidlhpUnl2bUtoS0g5QldUand6?=
 =?utf-8?B?NlBvZ2NIV3ZQSEkzZ2dZMVBMcWkxWWNrTFZIYnR0T0RmWm9QK0RUaEFqYklD?=
 =?utf-8?B?OFM3WUNlSGp1N294L3BUTk1pNFo3eGNDT2VxRFcxRS8zK0I1dm9zcEd4SVdz?=
 =?utf-8?B?ZmZqditJajltTThpTlBPZmtxTGdmUFlXaHZSMC83UVJ0K2Z0RldEK2VNaTNx?=
 =?utf-8?B?OWFkeXhRakZqek5nek55SXhBcFVBdk82WjZzbTFIT2xFbC92UGZEWmRyTDFy?=
 =?utf-8?B?eEpoUUkzYUkyT3hTUlFGTkwwVm9qbzgyOTZsZU5rUWRNL0hXZEN3OTRXOWNM?=
 =?utf-8?B?MEZmYWMrL0pSVG9KSTg5QkZ5UHN6bmpkTU9PajFqbFZ5NmIvMHRGSVFkT1Ir?=
 =?utf-8?B?elpqRDZ2bVJKR3NDREQ4Mld4MDBkOTBlUVFQbTNFMVd6UGw5SjFzV2Q5a0Za?=
 =?utf-8?B?YnlOdlcrYjhIYmVsVGdsTmY4K00yN2hHU0VGZGk2VG1od1JBQmJvMmo5Q0l6?=
 =?utf-8?B?QU5jWHZGNmdJMUdzNmJqcVpQU2hxT3Q5L3dmRjZuK1RLeEpuQllDWVo3Q3M4?=
 =?utf-8?B?YXFMSk9oOE5oSlFpaWU1MVM0cjhzT2VUZTRKKytEK1ZmdUVGU3NiVnhRQm5B?=
 =?utf-8?B?bGk1dTVERVZGcEp3V2ZUcUdCbEhNUDMzTXIzTithZGx0ZVJxVTRBb2RIekJw?=
 =?utf-8?B?Mi9CQ2tYQkRtQWRDU1JQOHFadXZpZkgva0ZwVDM3bWtqejJBZkdyZjJNdlpX?=
 =?utf-8?B?aGdvamN0WFZ4LzhSMEo0RkpadTRvVk5YeVB4aHcxSzVkTGJsVjczUlQ2SDVL?=
 =?utf-8?B?TXZEdkpRY20xUW1NdThlYXNPOE1xUjk1bXdUMW45SFAwQlVDM3Y3OWZ3bzZB?=
 =?utf-8?B?b3dHS0F1OW9rdUlZdUNiTFdIUCt2YkhkWkNQbjFEOHIwejUrTUUyN24zVGdT?=
 =?utf-8?B?MW52SmZJM1BwNWtKK01NSEFXM216QmFjcEJBRHdPb2sxT2dETzE0NVVPMEhP?=
 =?utf-8?B?QVlBMldScC9yMHAzby9zb0hnQ0QySFZiM0hhVGN3bi9sZ2IwbEZ6bGNhNEZy?=
 =?utf-8?B?Z2N5MlhjcGlJaUJOdUNWVVplTE41Z25WTWZHNTdNUms3dzl3VUZ3SXphNFV0?=
 =?utf-8?B?MUlUUE5WYTZtVmN0eS9ETnl6bGYya2Z6NDlsbTBwSXFkUUxjVm91dFhEWkRm?=
 =?utf-8?Q?sGTEP2GF8a8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWc1Wmgva3NEME84QmFSZmtjVXFVY2pvT3I3d0JQVjM0Y3U0Yk9qdTIyNFZ3?=
 =?utf-8?B?a2tHZXpienhWbk9lQmdmcW5pazNBSGJKblorbkQwZHhQRmFzQ0lrRTZ6MVpF?=
 =?utf-8?B?NU5NczZFRTF5bmhLeWNVK1pac2xiM1V3Z042ZkFaMG1mZllROXJUM1RNdW91?=
 =?utf-8?B?WFhtVFJDbmFFNGxsZThMV0h5SGhWSHl5MUJvYnFEV29rTE9yV0RSVG1uNHgy?=
 =?utf-8?B?M0RtRGdOU0x4ZTZ1cWxvaW1mVUhnSW81dTdtQlJlQlhPeU5HdU9lNVhBcVBX?=
 =?utf-8?B?QkhHM2VKc0N1R0tSY3Z0aUhDYU5nS0Y3R2lIcCtQT3ZBVUlmVW5LRldTTnJR?=
 =?utf-8?B?UXZGOTk4VHhtM2VCSHM1VFpuQmc3Zjgxb1pFVDZmZVY1b2w2d2syN3ZQMWpi?=
 =?utf-8?B?M0RXOEZheUVId3RVUG9XUk5hWGpBajRrUFR5MEhmaWlKZzNlZWhhTGJLZHA0?=
 =?utf-8?B?SDJTZWprSHhnSHM0YmZLUFFiWDBFQk1EdVZ6TEt4NXhhM3EwM0wzbkp3a1lJ?=
 =?utf-8?B?VjVIcHExdnpYYlM2N3hQNGFzaW14RnhaUFJMRklaalNXQXg5V0IrSS9hWlhH?=
 =?utf-8?B?aE0rWlBEcGNrcW1yNWJJQldWK2tMYk9ON2d5TC9jSnA5VU44SG95d0liY0Fz?=
 =?utf-8?B?UVVKVDkyWHZrWmNIWHZ3eDh3dVlsOGJ3clJUOE95dVdyc2FCaXQzcEw0ZXhm?=
 =?utf-8?B?L3J6eUxVWlB3eVZ5OVlIOTExMjdpQzJScTlXbGZIKzlrUFVBdW9YT2UybGpE?=
 =?utf-8?B?RHEzajBSVFZlVHErOHFid3NCODk0aC9yREdvdnZKeDFjUjZNbFhHUFR6MmxK?=
 =?utf-8?B?TllIU2xiYXBvaHlKeE92b2diYWZzMGsxOTJqZWd1MnhhTFZ5eExMVGZOZjk3?=
 =?utf-8?B?YURPanAxWFUrZTdHU3dmbG1vSVpqdDJUc1hBc2dialZsMFA1dTBDYkt1L2hY?=
 =?utf-8?B?aE9rLzNVbXh0bWswejVDYUk0UGlybkwyQjRIVnpXOGorRGxhN0RhTEdZai81?=
 =?utf-8?B?NjU2NVEwL0lSUzZ4QzBsZ3pyR0d0VUk1b2d6eWxqcU81S0hTODJteTVRYVZ1?=
 =?utf-8?B?cE9WNlNBT0RpcjVLemFzaTlSSUFIRWZXMi9qbXgxcE1pcnhUVHFYTE1CU09l?=
 =?utf-8?B?UFdMcnRiTHpBT3FSRGFHWmVhV0tKMlRvUU1nUlYzaUJQVUVsVFMrZnJud2Er?=
 =?utf-8?B?M082bGxTRlZHQ0N4VXo3QjB5WDhnQTRSTzQxdUxyOE1tMWVZUldGVEVSUU5Y?=
 =?utf-8?B?dXpYRks1Z3ROSm1YWkd2MFllVXRoKzZ6eUQ0MWhWaHdSeW9MWFVpN1ZEZUNH?=
 =?utf-8?B?RUZEbEd6ZE9Qc0dsWGxQQzRsSkFRZVYyQVlOK0NMaXU4cmU2MmVzN0RNMXRJ?=
 =?utf-8?B?ZTlNSDUxVk1MU09XQ1BGNGV4bUhKSHAxaDJQekdmaitPait3MHBxZHY0N3Fy?=
 =?utf-8?B?RGhYRFhqNHliNVY2bUxtaHp2WURBUjY0VTkyUERYYkxscDNjNk9iNThsYlJJ?=
 =?utf-8?B?cnJwRWk2NFljSllmTUZZT0xvdHdmWGNwNW9SbDdpWnQ2ZkZUOGZUdWEvZ0No?=
 =?utf-8?B?dkNzUDgySGdJdUY5ZllnQStTaXNCYXBIb2d1RE1FaEo5dDZienNFWTVTVlU1?=
 =?utf-8?B?OVhvVlB2N09kZkhVYXhRTlRKWUZ6MXVHWW5EbjhYcEIrWStXTU9tR1V3eWc5?=
 =?utf-8?B?VUQ2bFNMVzBLRGJwOWR3YlZSWmFwUWdIVTVlZ2krb2kvQlc4QUtOL0MrbWRH?=
 =?utf-8?B?MmhneVFMOWdDSkpWdDFqbTVHT2tHV1FsbWFuL2lzb2hISFR0SHVwdEoyYzNM?=
 =?utf-8?B?WjlGRTZkcDNzSERNbCttek9FMkNxVmhRTG1DT0Mxb21tNXJTQ1Q0T3BjOWhy?=
 =?utf-8?B?NDBzQkpCWmF1UjRkTnBQam90ZEk4YkcwQVYyc0dqd3hEVng2MTRCdE0wNFRo?=
 =?utf-8?B?L0RISmc1a0tadmljTzNidkoxY1ZXT3hxMGNRQUt5TXdqY01CVW52Wmt1dlZF?=
 =?utf-8?B?VnhUdnR4WWFrOWlMdTJQTlJrL3VsbENDTndKQkVhT2syOUNLam5RZWpRZFBT?=
 =?utf-8?B?YXFZZW5kaGR4cUZ3SjBEeTBOaWpveHNiWjFTaVhabFc5U1lJRGM3b215NUxV?=
 =?utf-8?Q?PSLPQ5bur+b6SNFtU4WSeObeQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a91afd-334d-4940-c4a7-08dd83b70588
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 05:07:05.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOAvONnmAzhXsAgCZ82TRMHHIUdbjDq5OcXUwfk7FHDI2szvVCgUF/wIzWBudAnk8Mlry/feiXKM+7N8WvHs9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7366

From: Jan Kiszka <jan.kiszka@siemens.com>

Fail rather than crash later on.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/copperplate/cluster.c  | 4 ++++
 lib/copperplate/registry.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/lib/copperplate/cluster.c b/lib/copperplate/cluster.c
index 76ef5d4ce0..15ea4d36bd 100644
--- a/lib/copperplate/cluster.c
+++ b/lib/copperplate/cluster.c
@@ -369,6 +369,10 @@ int syncluster_findobj(struct syncluster *sc,
 		if (wait == NULL) {
 			wait = threadobj_prepare_wait(struct syncluster_wait_struct);
 			wait->name_ref = __moff(xnstrdup(name));
+			if (!__mptr(wait->name_ref)) {
+				ret = -ENOMEM;
+				break;
+			}
 		}
 		ret = syncobj_wait_grant(&sc->d->sobj, timeout, &syns);
 		if (ret) {
diff --git a/lib/copperplate/registry.c b/lib/copperplate/registry.c
index a60bf9877f..1a08998986 100644
--- a/lib/copperplate/registry.c
+++ b/lib/copperplate/registry.c
@@ -123,6 +123,11 @@ int registry_add_dir(const char *fmt, ...)
 	}
 	pvholder_init(&d->link);
 	d->path = pvstrdup(path);
+	if (!d->path) {
+		pvfree(d);
+		ret = -ENOMEM;
+		goto done;
+	}
 
 	if (strcmp(path, "/")) {
 		d->basename = d->path + (basename - path) + 1;
@@ -204,6 +209,8 @@ int registry_add_file(struct fsobj *fsobj, int mode, const char *fmt, ...)
 		return __bt(-EINVAL);
 
 	fsobj->path = pvstrdup(path);
+	if (!fsobj->path)
+		return __bt(-ENOMEM);
 	fsobj->basename = fsobj->path + (basename - path) + 1;
 	fsobj->mode = mode & O_ACCMODE;
 	__RT(clock_gettime(CLOCK_COPPERPLATE, &fsobj->ctime));
-- 
2.43.0
