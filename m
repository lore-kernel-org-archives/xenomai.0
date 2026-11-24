Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795525206;
	b=0HyJYxcyBo4YjSSljdnohctuh5QPUI7leC/tYHMqucsX56crzVFPEbN1IlHAphY4NISN
	 PZEbEhahV0xzuoDYblSxuJG0KjZbrRPK+Tg3pFqWeszE5LGXtbX03RFnMt9Qe5RdnrzaO
	 OznHcLS1zoKxAagVb0Kgn9Z0WBHQy9nZbCjR6NOij8TFOIzEAE352+UvmNeeMA6qgwzQV
	 6qMaMhPfdBcGnE7k+0w0bzXjfl7Y0sdCalNPWXSDHkYzELsZj+4PphpoQg7AtnL4kE2M7
	 L8sI+Jjl+2m7fupJKCSy3osyvON3vUAPyE1HDIazVzUg/qVvaZxKpAHaE6FHQ+69KSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525206;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Cc:Autocrypt:Content-Type:
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
	bh=0P2sC7fZ13JmdhIvUovRTcCyIVuX+P8tJo0+s6/sTkM=;
	b=S5zkZXS9UXUfePnD0Qx7g29I8vAAkuIDR7Vir6PP2hn/ZUT85K/1MXZhEZhPvE1IK6Hr
	 WkSrl7eLjQRd9kQ0EBaCEgAFv0cIYApyETeCVPuF8IlDlE8VURWEHS2ZFWQVn8k7HOG8r
	 yjD7sKhvLa15YfBoYsXMaNW4uILdFtyZp5BulfiCPfH6lsQMJKz9UFise63M13OR4b8QI
	 LLoRk2fHQZXJkKg08Xe4OMh6kuGsfA4+rpMmIdGoW41ksi6BpbB25ZRfIq1vBs1HTwDjb
	 a1Xw9p+j5udmNmihqbM+cjhYY9m43KSU47xefGfM+29zmQXKzf0kpihlu6BeuKGXkAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=pj0h5oUq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.71
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46227606A332
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 13:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46227606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=pj0h5oUq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqXPWALDUuq+RVPxaBCaQFkfuRzZHY54OcjvWtpoL+iQPKpZMdQqRHIm/lH/lL+TnC543UbDUxPXf272OLSkpWw0qf2EEUXSdrYkR/qbxheEIRTCHH39R3mFsK8mSUhvf2HDrpTotdZHT7zF0vuIp7pi5cS9Zr9yGMjpER03knVxD8aUn/nT5l0aYiZ4b004KhaTsfSmH9wb69KYWC1LDXQIKwtXHllXDtGLUCZrMiEg0QZNjtN7PzHBx996tMF7p0aYJJwmPbbJWDdKVhqwJCk0cgE25C/rgz6A9HzBHcCPqRJt3vuXGJwHMaDrpIv14GeIyufiVJJSPrwtM2Fc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0P2sC7fZ13JmdhIvUovRTcCyIVuX+P8tJo0+s6/sTkM=;
 b=E8TOAiZtPvfD85t3JbzCaY4XTj2R1/MW5lPoREp2UWDVK7VvSxcycR0ItIosmNWc31/k0jNbBmJtWLQ2xMLAzou8GMjCeFIPsECcdxqa3VDxZUcZykxddrmemXXZlwwyreLMIxrK7nAP7wukZp8vqEdzX3elmO9xu7oUcrtsyQC8Utp9F1sUdm/GgBsKqGZepdTs8E3hYLON/VL2RkhPgUx/6/T5xzELQG6O0UmbDbWuLfjwmG0b86/hqZp1TwbtYP6H7pwIOnFj8iE9plRCimUBpnw+sztmH2esp3krxbYKxoAKI4W48NklR44d5Ko6o8dD3ZMPvx/csY24qhPFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P2sC7fZ13JmdhIvUovRTcCyIVuX+P8tJo0+s6/sTkM=;
 b=pj0h5oUqUpYPEz1TK3lNlMas5HLlZyuG+LgB5HyqKc5Zv+qYuI34+O/K5uKEc+phOy2vC0asT7Fay0mGt4b/x9PVnAhgXpu/u/DWuXy9fAA1uNhQKEtccpLehIlGGUBaImkjySgIMtn8P3jvQ71KRX+4v1VpK1vw5P6dzd5jF06YU92SVv65ov8bgz440GGFTfrlGQd8k1+dr/2kNU9W1Momz6QBOFK3zSCFM/TETOXOQ1WKj5qbLOjdlgQjEjFj2kMOuper6rDrln2GeuBmavfqG6xdePxuWdUXOyAtUFr+sANMfSScEFn4Fm98cCh2eG/a8fcjYFoiOnA7ERnDtw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA4PR10MB5609.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:262::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 13:00:01 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 13:00:00 +0000
Message-ID: <d0919a84-e71f-4e08-86e3-8900b30f9e5f@siemens.com>
Date: Tue, 24 Nov 2026 13:59:57 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/cobalt: Let __STD() and __RT() of mmap follow the off_t
 redirection
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::7) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA4PR10MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 6656d9b9-881a-4887-08fb-08df4a2ad91d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|261026140227099003|10067099003|56012099006|11063799006|261026121527099003|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261022075727099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	1xdHIBQBLNOsJomo817tMDjdApdZ0C/XU/5knb9Ul/y4SU4Cnbx8vcuK1TPZW0RC1wgdbx5INmeKmit1bNyS4gVvAORt4cfMxWba3CROhSiTiGLUsNQVzPQ2Wj/C+0i81CnHKkq0u3kGkToJNyyZufjKkNwK1hMBOWHismqzRD6b9NLJSuOYlQSrb6dV8xDlmY08vzHsHhmVnb1UUa4HAaF3+LSWoa19S9V9x+JCd3tG4ujITYenTeNkyVW/Yoy0WTfV8o2IHRntWfa5AgGkwQI4F644sk4KgaLCf3XbAZugG1/CiCJm6Z3JIi8OJxCDg1k9VnbvqOIYyGBj1LQg1yTAtHsgovOYXArd9O6bG8VHe5O3WILPxTCedxN4ZYvtZJSr+27BqRxbrAquKGqgraNZIXAuIc8EYDDBs8cUBg37/bfmFkSgoUUvxY3vCMN0dku3ZyZd+K8VLSZJBI7ZvoeGBKFTGket9rqRqozprnA4hB+Zs3eC0UiS9p22MXyTu+Jc3L79VR8VvDUf04ezgGzK2SwCaNRTvhneZak84aq7s2Ha/IF+oRtIf+ye2L+RizVX6/5vclPczrSerixUK8H17aHx9r/NhiAj/v4RjJbb0GM7FsOn5Q3QR8fxqzbHZk/+66/1zz0uvrZS9eahbqXkjvjph5gW3UgnZ8tUf8w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261026140227099003)(10067099003)(56012099006)(11063799006)(261026121527099003)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022075727099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czRBQzl0Zm5tRUVRT0tkdlBvRHovanFmNmsrMXJFcWd2bHdUNnB2amJERWEv?=
 =?utf-8?B?OThYVHo5M2Urck1hdlM0WlNVMnY1VlN1UzFwWjF0K21TNjkzN0Z0blhRWm5S?=
 =?utf-8?B?NlFSU0N6RitITnNRQTNDaWRnSXNKT2FJQWVzVXBBM1V2bkhDbWhuLzVqaS8x?=
 =?utf-8?B?dFYvdmRPK1lybkJvaStFUnpvTkR4YllpSHBEMlZnNE9QQjVWYk5JOHZISGxY?=
 =?utf-8?B?MFMyZ1cvYjdIV2pnNTNuRlBNK0llalRoZTVRNi8zQ003cnVrZk42cUZxM2pE?=
 =?utf-8?B?bFpXTElQWU5DNEcrR29sTVZWZ1dYR2UvTWNyMEFYZEVMbGtGZkNISmVhMlEx?=
 =?utf-8?B?UEVsSmtHbTlLS3Y5VzF6YkxwdUVFTkFzamdMaVhmSm8zZEJYN0FqM3Q5Nkha?=
 =?utf-8?B?NGlrN2FOVjJFOXFpSmI3L1FZY05iQlo0ZmJ6TWU0ZndMSFlJZ3pUZkdvazFL?=
 =?utf-8?B?Sk8wekZUd005UGVuSUtJM1lEeDlhcHBkbzNQcVJzTWlhT28rSTg2cnRFNXFV?=
 =?utf-8?B?aUpjeUppZndKUm95aWEyeTUvM05pL1lZUGlBT3ViZStDRytMdGpwVVJ3Y3Nv?=
 =?utf-8?B?UVlSR2VJOWt5WjQwVnJFRmhWaGRUQVdKSWthcDZENTFTL0JTZ2p1UzEyVWNS?=
 =?utf-8?B?aWd1WHFEQTZpQkl2aFdTb29DOHRROVJhODU3TTYrb0tiNERPUWdKc2dnZlZk?=
 =?utf-8?B?K2lLT0dKcEx4aVR1LzVaWlBnakRDTGovZ21NZHBHRlljSHhmMThYUlZPb0Uy?=
 =?utf-8?B?V2xwV2JDUEI4cHp1dlpPcDNac2c4TVUyTWVtYThlQkFDUDlwaWgrVVp1RDB6?=
 =?utf-8?B?RFpSNnRUMGRnQS8rV2ZSZmhlckZBMkt3M251S0lIK25QVjRPTDRrMU9RQ1k0?=
 =?utf-8?B?SUczQTlTV0RDZnUwZlQ4SGZBTzkwWmI3cTQwbUUrT3NKeGVUMW9KUE9hb0w4?=
 =?utf-8?B?ejdvWUlpZ0ZNKzhlNlZHbWFCZE9VRlJYVlR2UmsrQXdLcndYdkxyNi9zZ3Nv?=
 =?utf-8?B?RzFXSXlUY2VkT3RoYmU1L3NFTGFRaWhYMW5UKy9QVUd4aFpwa0ZVVWowUjlx?=
 =?utf-8?B?UXZnUjQrRWJhVUxrbFBmWlRGem1OdElOUkk0bENwRHBKY1hleXJ2Q1F4d1Ar?=
 =?utf-8?B?aDkyTGpCU0lhZXY3cHk5SUVrRTZWQWJURFVveTJzWUZxQm00K3FWL3pNb2Fr?=
 =?utf-8?B?bEQ0Qzd1d0J2Y1czK2p0eHdiV0owKytBQWJFaSsrMlhVa0JRbURYNEpvQmQ4?=
 =?utf-8?B?T056emd0Y09taEpZekxzUjQybStuWC92MXpjZE13V3FNa1ZlRU1uNXFNMndp?=
 =?utf-8?B?K2phTWFBRXpMS0pBRGFwSTErd25QdmlXaFRRZFQ5ajZXZ3JiZnRRcGI2SUpI?=
 =?utf-8?B?bTkzaGZkSTUxbWdaM2Jlb0R0MWkvdXd6OGF4U3FOa0RmQnN2aEJULzRnMU9o?=
 =?utf-8?B?QVNBSURWZm9VeVlXMzBibUdtQ3ZOeXhzQkxOT0NRTkxwWmE4aWFTWWthSUE4?=
 =?utf-8?B?b1JyYmRjenl1SUpDZVFTcmdzeXRncUlVRTJxL3JzSSsyTlNndFpCd0E0OEdy?=
 =?utf-8?B?N1BMZUg3NjF2eDYwc1BhU0tVUWJFWmZwUFhDTFNpSElONlVLRVU0OGN6Y3pC?=
 =?utf-8?B?Z29NeFd4Q2M3YVdJSHBMSno0bnhteTgrNzRseHV0NHQ1L2o5VzlVdFM2Rlhp?=
 =?utf-8?B?YzlsNUJtczNScXJvWFJ4UFU5V0ZpaDR0WWVaSDJKMHhsTy9mRDhBYnQxblRp?=
 =?utf-8?B?VnZ2d001VjJUdkU5YmVwUlBOUVNMck1XVHllUXpPdDk1MkxwTDYyb0h5K01M?=
 =?utf-8?B?Z29FTHNkTFJEMkV3SDhhbU5XdFBwVXRSdzVBTU5ESlFxMDhRTGtsWGdBU0Ft?=
 =?utf-8?B?NkhVbThabTlRd1ZqKzI3ZFNrZG0wYzZOSnBia2IxbzRHTHVybEVJa0JvT3p6?=
 =?utf-8?B?VW5QU2JmYktFck5PV2hPUXBRUDFhSnJhN25qdWV2Q255aVZEbXgzQlVKaFdM?=
 =?utf-8?B?eXpnbnhiemxhcUhMSXRCRGR0Y25YeWZ2WkNoOWxCcFJFcjkyb2VFbTNDZFpY?=
 =?utf-8?B?K0l5Q2VXbkh5anN4eUVSa0R4c0hyRERaVHhoYkhvYTFOUEZNMkhpN0RUcVgv?=
 =?utf-8?B?RkpPSjVBVWk0MmJxRE5GNzZ6bThkMXlMTFVrSU1jTURZTHFLQlFzMTd2OGNS?=
 =?utf-8?B?dzhmb29iaVh1QUZyTGlVT3NkRWFoMVZVVFhrZjA2WmZPTGRPNW84VHRJWDNi?=
 =?utf-8?B?SlVZaW9oL3MreHBwN0p6TnduZkxBQ2cvZTQxSGlKajdqTEIvNVBpU1RCd0JT?=
 =?utf-8?B?RVFCcFlXa3JuWG40MkRvVHBaK3d4RlpnSTgxMFU4czNCTDZsbkxyZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6656d9b9-881a-4887-08fb-08df4a2ad91d
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:00:00.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/I7Px7AxTbMsZxfbJo1kwP6sA2/d+zIUGRWYVjVFI53F6jSclx7DtiCgD/HyNRxkyD7T8p84Jr5XKZgDDC4Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5609

From: Jan Kiszka <jan.kiszka@siemens.com>

With _FILE_OFFSET_BITS=64, glibc redirects mmap() to mmap64() on 32-bit
archs. Applications get this setting by default since y2038 support was
added, as xeno-config passes it along with _TIME_BITS=64, and some
toolchains even predefine both (e.g. Debian armhf). uClibc-ng enforces
64-bit file offsets unconditionally since release 1.0.58.

__STD(mmap()) and __RT(mmap()) do not follow this redirection: they
expand to __real_mmap() and __cobalt_mmap(), declared with the 64-bit
off_t of the caller. But with the Cobalt wrappers, __real_mmap() binds
to the libc's mmap(), and __cobalt_mmap() is built with native off_t,
so both take a 32-bit offset. They read it from the padding word in
front of the 64-bit argument and fail with EINVAL or map the wrong
page.

Internal users built with 64-bit off_t are affected as well:
cobalt_unmap_umm(), the pshared heap of copperplate and the TLSF pool
of boilerplate all bind to the native-off_t __real_mmap() of libcobalt.

Add COBALT_DECL_OFF64(), which redirects the __STD(), __RT() and
__WRAP() symbols of a service to its 64-bit variant whenever the libc
does so, and use it for mmap(). This relies on libcobalt providing
__real_mmap64(). lib/cobalt/mmap.c implements both variants and opts
out via __COBALT_NO_OFF64_REDIRECT__: building it with native off_t is
not sufficient if the libc enforces 64-bit file offsets.

Reported-by: François Legal <francois.legal@eventlab.fr>
Fixes: fb2bd6e647a9 ("y2038: build: Introduce new build parameter --disable-y2038")
Assisted-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/sys/mman.h |  6 +++---
 include/cobalt/wrappers.h | 15 +++++++++++++++
 lib/cobalt/mmap.c         |  6 ++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
index e291f50ef..54c028ad9 100644
--- a/include/cobalt/sys/mman.h
+++ b/include/cobalt/sys/mman.h
@@ -28,9 +28,9 @@
 extern "C" {
 #endif
 
-COBALT_DECL(void *, mmap,
-	    (void *addr, size_t length, int prot, int flags, int fd,
-	     off_t offset));
+COBALT_DECL_OFF64(void *, mmap, mmap64,
+		  (void *addr, size_t length, int prot, int flags, int fd,
+		   off_t offset));
 
 #if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
 COBALT_DECL(void *, mmap64,
diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index 6d826eedf..9dd022a75 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -45,6 +45,21 @@
 #define COBALT_DECL_TIME64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
 #endif
 
+#if defined(__USE_FILE_OFFSET64) && !defined(__COBALT_NO_OFF64_REDIRECT__)
+/*
+ * Make __RT() and __STD() usable in combination with off_t related
+ * services: the libc redirects them to their 64-bit variants in this
+ * case, follow suit. Code implementing the native variants opts out,
+ * as some libcs enforce 64-bit file offsets (e.g. uClibc-ng).
+ */
+#define COBALT_DECL_OFF64(T, FN, FN_64, I)                                     \
+	extern T __REDIRECT_NTH(__STD(FN), I, __real_##FN_64);                 \
+	extern T __REDIRECT_NTH(__RT(FN), I, __cobalt_##FN_64);                \
+	extern T __REDIRECT_NTH(__WRAP(FN), I, __wrap_##FN_64)
+#else
+#define COBALT_DECL_OFF64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
+#endif
+
 /*
  * 
  * Each "foo" Cobalt routine shadowing a POSIX service may be
diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
index d30b1722d..bf8772f6a 100644
--- a/lib/cobalt/mmap.c
+++ b/lib/cobalt/mmap.c
@@ -18,6 +18,12 @@
   USA.
  */
 
+/*
+ * We implement mmap() for the native off_t next to mmap64(): keep their
+ * names apart, even if the libc enforces 64-bit file offsets.
+ */
+#define __COBALT_NO_OFF64_REDIRECT__
+
 #include <sys/mman.h>
 #include <rtdm/rtdm.h>
 #include <cobalt/uapi/syscall.h>
-- 
2.47.3
