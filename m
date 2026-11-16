Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794857768;
	b=OgYxuGJ1kEQHoZfGlVleY4rB1KMZdAUMraQleZ1OAoU2IbNUFSXTYEOaVEaoXh3D3DZa
	 87PgjNUgV9Q7PHKL23bjChA4JYpSbTHiHJTmZBjrPHV/Cap+RxG+CXjJOK1s1n6/VKO1I
	 bcOiLfArvCXHBFheiz3sB6A2e45648yFa3044CstVhd1RA1egYE4A3JHrQVJZvO8CLP47
	 2mRQ+naSmLbq7iK9qEM7DwcG8Mdi0i/cSzwVl2lRxra8l5rddg2W46cJk2qr0mIz8vb86
	 RdR/HKsli5cNZC4c9AcVwyHXhpV6A79ZbyANoEQzIBYgNzW0FwkAIUNqQjtr+NZpLgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857768;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:To:Subject:Content-Language:Autocrypt:Content-Type:
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
	bh=xUyvReqDtvfGRN1MDNxyzOuR4izTQ0F8MmQGydTVz90=;
	b=z4xm9iUMbyqIFBwG60wJrTsX4ZzQM8o81ftDhJTj2d3185wwhAQCa4vjZT19N+/HPYPE
	 v8OZCyVyrRA51DH6cZ7mArv283yQo4VVs9lx5IBXBKBVDJOBrhMn4Q7xc4nJjUxTfiT5W
	 XI77uWuJhOR9HgfF4L4D1rVFMGZkQHvzOp9AYlqDNE+0lTW24Bm9tRTt7gCAbHN4y4dhs
	 pN/Ad+o7D/wLKZfMG7NMJFk6VEO9kCiWvzCtqyM1frF4YnJ56y5Cd4cod99HXF+Id6r13
	 F92KKOdMLBVCBsS5Kbwn5IYXhLz9LOc122+n3Qd+eKbwOmbIx7J0IUa0VURdp3BlsFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=yv3nO+Vl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.50
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A07606A329
	for <xenomai@lists.linux.dev>; Mon, 16 Nov 2026 19:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A07606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=yv3nO+Vl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaTPKQVxckcMwTLGGUVbcLsZFG2nZumvDONHx4MFwZFDbb6inWpo9J+Rzj0SEsg9XecGR+dDTGC/ealYEFcmFnoWSiNTyWBi6h0WHmH5cAc2xzD/ddrEZUHbvMVUWmIjp6O4CIe75JP3LXXaBhPris30oeAEVE5iUJ2qsWE91AhaA4Q5R9XDx+Crv3HLHHLNig3x/g9nxhK7PqiM/dlFLBvryYTLlAWqowjqYVdyg5PqgDStJwOdX6UDgl7Kr/r+iDOFaHdcaMF3Trhj4zi9q8BPxMm2XZbrwzJc42KNSGdvx84IpYRHhrwcnDfg1lPJbJbUZaXP+66Y5nDUND57+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUyvReqDtvfGRN1MDNxyzOuR4izTQ0F8MmQGydTVz90=;
 b=KYrLkNJm1djDZ7ogSUhfhVXct7Z+ByXZ3eIWMd+dBlyLduKgn9ejI4Mzy/8CrwrckLJDoERwzks88lkd5bqfc5liNQbz9dHc1N3AjRIajgSVCczhgg+WT1pcpNoJFeh/IlBmP4HuVkuVBo2X0hQGHxbTTJy5+b451YZXNOwBEbm8IC0jBwwRVN8TN/xiG/osYz3s+1KAWEqAqw555f4Hjs5mfWmHRRj2ZH5mNxUvFC4bt4ZHaGCdVbdaR0R8g9F+9pUYg5N/5gsseMFceg/4WB1wTJP8sdMDeqoaG+yclz9PQ0vEB8ZMWElFDNJ+QAC5jy79GxDWuR9VaWe7YPVVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUyvReqDtvfGRN1MDNxyzOuR4izTQ0F8MmQGydTVz90=;
 b=yv3nO+VlUrtg5uoQjlW8tEvjwioDlPxnko2l3rDmc/WVKppWTRRtqJuIIYl8zeA0W64+qlO+IiiPHJx7VRtV0j0UKCcKT+W6c3l7ngPury5QGs8bIQeLdxu+X7nQ1vsF62XBB9bI0nwwkA1L3WvENSKqzPrujrdIJF2AxrJiGyit38Y2qoYVkjPIz5ZdhWkk7C/aCQ/IBm2Gjstyk4hmPikS5VGBjZ//EOCaec6xyQnnH3OL1dsLDSXmqhf/IrUTs/fftjEuD6jFxRU+/Yh1oGz8hvOeS+/8uiABNGOQfBEs0gn1DleR5M+Nm59AkA1wYPOujeyh/Qh+Ogr4OrOcxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA2PR10MB9020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:426::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 19:36:05 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Mon, 16 Nov 2026
 19:36:05 +0000
Message-ID: <a0cb770f-bc4e-43db-a6ba-8214bcaf061e@siemens.com>
Date: Mon, 16 Nov 2026 20:36:04 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite: rtdm: Widen close deferral window on VMs
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0423.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::13) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA2PR10MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fff4f7-009f-458d-d79c-08df4418db1e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|260925022911599003|260925021911599003|260925021311599003|56012099006|261026121527099003|10067099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261022115727099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bpddtnNXzld+/lNGjSnA2ODs5ZyF8u6aO8KLK2bFhKyFsuoRSUEs7tOdOqrId37iBVstZDEsJEh22noUGORivRvQ69B7oRJrMcD9e4QxQZ7kvOm59jg8sDUUGs/XDUV7FkdyPzGtUfqa8psnvE2bwDkMY/sEjjACllkEYRytHzMlmQYHNlbXPUKe/DA+sSvK4ihW6C1vd4MOTSGNj0P9RB8WFTGw4RbxEKmsoqBOkSP90RkNvYHEMu/tkUBj2lEDpjhuvH8w1JgGZRZvEAZcaxeQUUReiZPbmNPK3B1OzaLE6UWvwnNGS+0VxqwUo3xlM2lCJojDwZQcxXkUGwcZK+4VeI7+OvqTtdI+qLy9MZT6mzmXiUY4/BYhs3WwSFt6S4Hdsmsh2VfETItyGAqN0xzvH+t7A4QCIAwfBC+PLp6WH0sHb1A7KLasEewOLm7vQV/BGArhVn/bdueZml4kuFHwTqNOKMq2JxwFQQGSRBseNvU6FKNJS38mIKYgyHwmkHnCixYbNX60kxR++wtpCSIkFHdREkJqFsx+I2p/68DsAa4EspoegIQWwiipMvV0POZ4yt/y7RH6ku7sY+IaxxqiyZMscVxXYfKYZNa3epmBzXJsdDHj4lJ2BLSbpBP6jZ22ni64pduD+74nbs/TqfEx53lQBYLDIzjWlswB9Uk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(261026121527099003)(10067099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261022115727099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym9JTFVaZE42ZGthQzQ3TzhmUmkzSVdUcUJqVmNoM2F4a1grZEs3WFB4RWc5?=
 =?utf-8?B?V2oyY2xkc0x0c0N3Ly9UNTUwa0NpVGNiU21YaDFTUkgyRmVmbFY2b0M4Wlky?=
 =?utf-8?B?RjhsNnhQOXV6UWZnakNoTDVFUDRBbHRVTU5wQkwzbzdzZDNWeXgxTXhlYjR3?=
 =?utf-8?B?ZEROWFBKWE4xOVR4dGJVdE94MUkxNDRCNDhrYTgvV0ova1I0Sm5XWkdTVXBn?=
 =?utf-8?B?SkdvcHBaRTRya092VFd4WkJWQ0JTb000TDhRRGsxbTNHdDJ4R041elBQdGxQ?=
 =?utf-8?B?K3UwQUt6aGlvN0tVT01BRkVkWkhnOVF5bXJqMy81TDV4NkxsTXdFcC96emdj?=
 =?utf-8?B?K01FTTRCZEdwUU0yL0d0aXhFbDlwaEU4cDVwNFZ5QVpvK0xNV0ZVMEV1cXVH?=
 =?utf-8?B?STdFNGxycllkSTdmUXF1RG1PSTNqb3UzLzJLVjlIVHFRYkVWZkIwRmRNV3JM?=
 =?utf-8?B?SFJCamhuMFM5QzZCSC9HSk5rcFNwNmVwTFB3Zk1LbjA2YVpqYTdzd1IxeTcy?=
 =?utf-8?B?c1hnVWMzUi82aXdLUUJvaXhWNkt2V2lwVnVucUJUdkI2K1RvNGtXdDNFVlhK?=
 =?utf-8?B?dndyaG9FL0Jtalc4anM5NEExcUlpUVFNMEE4WGRxdWZrcEVSM3hSUGpOL2tt?=
 =?utf-8?B?VUI3RkdrNHBEajVMbFV3SDdiS00zcENjeGNVQjc4VTAxdzRYU3Z1ZTRnRXlS?=
 =?utf-8?B?bGxGOGowNDkrUWtnakNUYThISFZxY3REUTQwNG40aEc4NWM3QWNHdHpDNnpx?=
 =?utf-8?B?VFh0QjFRc2FxcUJjMWc2Vllwa211cUExN3o1MnVLYmZORC9ld3dUdWd5cGVS?=
 =?utf-8?B?SnFpb3BmdlJSUGNJcjQvU3oxRDVSMTFHcG1wMktPZHRHTUovc1NqSThSaWNj?=
 =?utf-8?B?dWZhZWFUYXpiK1RDYzRwUmxMZVhpM1lYUkRaaEtDS1pYKzVKU3dPeHVSL1lx?=
 =?utf-8?B?aVlRQVM3ODB2ZWhLZDFDWVlNYi9DOUJQTlpRN0ZiM21pMlN3aE93WXdxbGh3?=
 =?utf-8?B?ckxrZVQzYWtvZ2xqRUVDeSs2ZmJ6bUw5RE5heFJab1I0MlRDRUhyMTN5YzNl?=
 =?utf-8?B?UmZKd3hHN0ZjZmVCZ0lxMVRkL2hxVmY4dTYxSGg2WngrQmpkd25YLzY3TkMv?=
 =?utf-8?B?NXVXSndCSVppY3R6WnlBNHF3TFR3OHZCbFlQR0Y2WUNWL2hVVFE1NWhNcUZI?=
 =?utf-8?B?QjRZQVRtMURmbit4OEhIQ3lHcG5ES2pjODFXVjNHWUh1QVhJbWFsNVVqclZL?=
 =?utf-8?B?eU5sMk9yRlZqWVJPUVBzWmdZamE2aHJiVGlNSkZ2MmlqN0g4VkE5Y1owR0py?=
 =?utf-8?B?TVY4RnZKRmlpSXF6K0h5NC9UU3FQdVN5TU5maSt2dUdRY1RiWDBuTCtkU1Fj?=
 =?utf-8?B?a2ovRU45eGM5S2FzSHprQ1ozb04xSlIxclgyK0d3dzFkcmo3aHdOWHRkZEgz?=
 =?utf-8?B?b3E3MmdiWTVRVjRRb2QyQURicUFtZFhxMytuM2dCai9GYWFyb1NVc3hCZVhP?=
 =?utf-8?B?Q0d1TUp5bmxJOTRpNHNoUzdtdjhGRzRISnJReVczbUZKMlNSZVIzSDVOTmtL?=
 =?utf-8?B?TGJiVDlmSllkOWl0SXdxaUlwL3RrbUR0bHFuSk9tbS9UYjZ3NW1ZY3o3Nkh5?=
 =?utf-8?B?bUNTK0tGcFFQdE56NkZHa2V0YjlMTUV2UFJieHdPY05oMmo1bW5QQUtCQlM5?=
 =?utf-8?B?YjBaNloyVGdyeG1pUUc0Z2NEUjd2SFZkeVN3OU9QOXN2MHViL25ZQWpwUWVM?=
 =?utf-8?B?OTlPeXNYeDVlak5YRUtqalJrcTlSYUpEVWZvZnY4MDI2VCszZFpVTDRxSStI?=
 =?utf-8?B?a2EycWFrbUFOWVFTaU10dno2VUJ2eUtpcGFTMU5BWHlUd1JOczFVMDdXN0pE?=
 =?utf-8?B?TUgvOXJlSll4L0tFbm1ZWmttZ0pGM0NHSDltd291NmdwYjFzZTB1c0NvMk1H?=
 =?utf-8?B?ZEQwVGtQS0Q3QWpvU0NJdzFYUXNpMjI2bVBXbk5yYjhrWmNHb2YwaEQvR0ZR?=
 =?utf-8?B?cTZnb2c5cm5qTjZvMzY4MGs3N0JDSEVUYjIxdTI4UUQwQkJrczZzZ2M2RUV0?=
 =?utf-8?B?RkV4Mk5nOGJtdnlSMWxma3BueXkrSlN6K2lmVkFrcEYwWlFWd2ZvekRyZzRr?=
 =?utf-8?B?bkZxU3RUMkJoOStCQ2NrVlA4aDNuNVRpSDBBdE51Y041M3I4MFVHaUZ5cjlk?=
 =?utf-8?B?R1NzM01HNlVDTHc5ZVE3N2xxUHpuNWphczJUK1VTaW51OHNubUdtQ2Ztdk1E?=
 =?utf-8?B?NnBUMFpRZ0FLTU5meDRHQm9iU0lDTk1nWHJaM0xqQU4vVmh4RVV1aWYwSGxj?=
 =?utf-8?B?N0ZiUkd0Vkt2MnYzR2EwV05KbUNBNTBEQWxRK0RqSXBXYUdCamRuUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fff4f7-009f-458d-d79c-08df4418db1e
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:36:05.6527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQnTNtn66p3hL+dV2i3kUh11xDDDEge5dUoldWVVAn5pna5CSc6PgdPcbJ9KBS6IKNNbIRzbnMR3dBMpox9ztA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9020

From: Jan Kiszka <jan.kiszka@siemens.com>

On slower QEMU setups, we have seen frequent timeouts of the close
deferral before userspace had a chance to stress it via an open()
request. Widen the window via a second deferral mode, a longer one.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/rtdm/uapi/testing.h       | 1 +
 kernel/drivers/testing/rtdmtest.c | 9 +++++++--
 testsuite/smokey/rtdm/rtdm.c      | 4 +++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
index 3674ae2dee..3536b2bc16 100644
--- a/include/rtdm/uapi/testing.h
+++ b/include/rtdm/uapi/testing.h
@@ -96,6 +96,7 @@ struct rttst_swtest_error {
 
 #define RTTST_RTDM_NORMAL_CLOSE		0
 #define RTTST_RTDM_DEFER_CLOSE_CONTEXT	1
+#define RTTST_RTDM_DEFER_CLOSE_LONG	2
 
 #define RTTST_RTDM_MAGIC_PRIMARY	0xfefbfefb
 #define RTTST_RTDM_MAGIC_SECONDARY	0xa5b9a5b9
diff --git a/kernel/drivers/testing/rtdmtest.c b/kernel/drivers/testing/rtdmtest.c
index b688abe85e..1add4bd0d0 100644
--- a/kernel/drivers/testing/rtdmtest.c
+++ b/kernel/drivers/testing/rtdmtest.c
@@ -77,6 +77,7 @@ static void rtdm_basic_close(struct rtdm_fd *fd)
 
 	switch (ctx->close_deferral) {
 	case RTTST_RTDM_DEFER_CLOSE_CONTEXT:
+	case RTTST_RTDM_DEFER_CLOSE_LONG:
 		if (ctx->close_counter != 2) {
 			printk(XENO_ERR
 			       "rtdmtest: %s: close_counter is %lu, "
@@ -111,14 +112,18 @@ static int rtdm_basic_ioctl_nrt(struct rtdm_fd *fd,
 {
 	struct rtdm_basic_context *ctx = rtdm_fd_to_private(fd);
 	int ret = 0, magic = RTTST_RTDM_MAGIC_SECONDARY;
+	unsigned long long delay = 300000000ULL;
 
 	switch (request) {
 	case RTTST_RTIOC_RTDM_DEFER_CLOSE:
 		ctx->close_deferral = (unsigned long)arg;
-		if (ctx->close_deferral == RTTST_RTDM_DEFER_CLOSE_CONTEXT) {
+		if (ctx->close_deferral == RTTST_RTDM_DEFER_CLOSE_CONTEXT ||
+		    ctx->close_deferral == RTTST_RTDM_DEFER_CLOSE_LONG) {
 			++ctx->close_counter;
 			rtdm_fd_lock(fd);
-			rtdm_timer_start(&ctx->close_timer, 300000000ULL, 0,
+			if (ctx->close_deferral == RTTST_RTDM_DEFER_CLOSE_LONG)
+				delay = 1000000000ULL;
+			rtdm_timer_start(&ctx->close_timer, delay, 0,
 					RTDM_TIMERMODE_RELATIVE);
 		}
 		break;
diff --git a/testsuite/smokey/rtdm/rtdm.c b/testsuite/smokey/rtdm/rtdm.c
index 2abbd6ceaf..9bc80669f8 100644
--- a/testsuite/smokey/rtdm/rtdm.c
+++ b/testsuite/smokey/rtdm/rtdm.c
@@ -166,12 +166,13 @@ static int run_rtdm(struct smokey_test *t, int argc, char *const argv[])
 
 	smokey_trace("Defer close by pending reference");
 	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
+			     smokey_on_vm ? RTTST_RTDM_DEFER_CLOSE_LONG :
 			     RTTST_RTDM_DEFER_CLOSE_CONTEXT), 0);
 	check("close", close(dev), 0);
 	check("open", open(devname, O_RDWR), -EBUSY);
 	dev2 = check("open", open(devname2, O_RDWR), dev);
 	check("close", close(dev2), 0);
-	usleep(smokey_on_vm ? 400000 : 301000);
+	usleep(smokey_on_vm ? 11000000 : 301000);
 	dev = check("open", open(devname, O_RDWR), dev);
 
 	smokey_trace("Normal close");
@@ -182,6 +183,7 @@ static int run_rtdm(struct smokey_test *t, int argc, char *const argv[])
 
 	smokey_trace("Disconnect on module unload");
 	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
+			     smokey_on_vm ? RTTST_RTDM_DEFER_CLOSE_LONG :
 			     RTTST_RTDM_DEFER_CLOSE_CONTEXT), 0);
 	check("close", close(dev), 0);
 
-- 
2.47.3
