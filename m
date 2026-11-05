Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793902490;
	b=dd6U/KCZBUXF3hqMnKjcFgBRWfwR4pR+O3D/pOBQNpEiopDAPBCK/iy+Hzv6mKZbzvyI
	 C51TlY1TjG/IToEZwpxoKcOCSCLFjJofsBUMjChAK3NCENQbGSdVn6Xa0aXqOxy3PbXj/
	 0dY0Vzl32KVEW/De8IRBKPkq9+TNC6hy7r8Y4iAH+h9gzQnz7r3Uor7bktzxJrKfPEF46
	 pt3efsg+7aeufRu2g/hdbX09Dg7x1ppuBrJfc7zXukgsnfCINOFxuhzYcb1regk6rcCec
	 64x9Ii2be38M86sZ3wCsEUqCfTb2WguisJzCukUUVgWL5qMjkJv2PkNfbsUjrzEwYyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902490;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=CeXZDEKEq1AtZhMCCDY3dVccUUDxnsENqJQ//W8QL18=;
	b=z1uFUNGIDCFbNaTiAnPuLa0PVkJb8BBkFY9q2u5exxflUZOu3wf7nSP+XVZJEASWjYnw
	 36oYdz1aK0BXaHgH4mrv92RyxcR/z1+CDks/LMLB0hXXVBf/tbojSloVTDPcGlOVAw51D
	 bFd3C95FVjdWsX4Fdnc64Pz+yB5XSZ8fzn2G+B57QR+xR4GIFwHdLFDmO7ZTh+aMMcaKq
	 NAcY6+4Wq9XNiQBg8/VOoJTvSIamvrlFPrKAtzHN9Up9fEAmFU/ThxcRpz28xgZssvakd
	 zUvb5OnPXU0OLSVhsHs1FKov5mx2W7DaDgZT4V0+LWoywNRhqZhd7+32tEL959gBr6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=dQRwBSgC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.28
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2F606A31B
	for <xenomai@lists.linux.dev>; Thu,  5 Nov 2026 18:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3C2F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=dQRwBSgC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9nbQviASpLRnFuHiYY4XStfDbx1/JM7ltITuNQjcl3GKlB//BR3Fj3HSV/8iBcgfalwM7mFi6uTkPUiEuOzkP47oBHs7DKXXiLkxsDQLhE3aMKqt7nQoYxkiThWTsikQ3JEuJndGMwWi0cPPTsaOcPIg1TXcpYbDpWqL4BNQKo4wWzyTviKFXoAqFC2B2OEwI9K4TDHqrUBW+LFRMoSZyj1krbMLUUZAhbc4VpuGE1A/RSGiVonFv8+c/ut8yJiFRvLyEF2ezMNuPy9rgmb+RxVlb92qnFE4HVcjMWgnS9qQdw6lvZ7jBLRtkZhiH2FaTqc60Md0lCRRieKwob2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeXZDEKEq1AtZhMCCDY3dVccUUDxnsENqJQ//W8QL18=;
 b=n3Qz9JWbk/91fE3wub8WQCGudClI98mBff+AWV21Mi47RXhpl3AHaeEIJ7XCjtrS9a8XCsaE7n7/R5RsrAEirOvNK2t5aKzjZHCWZyPE06iXtQ3SdEhvk7FRp94f+cvCiIn2UVdM3mp5LpNXql4IKNGewYuOs7fBRphZfdFhcOVS0y5fPn84oprMSPEBia5nv9W0p6id36b+ELCXwS3v1Rv9b/tCZQOMoBvwntd6R3y0Aw0PDwqyrYBUirDyTAizdXfMEQO+xAHLadLwpmANVd90kduWxfbOVNPjIjtBOsnLbEj7/l/YjxnSynx9qZFkSXVCdNqgI5eo8wGlnrJDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeXZDEKEq1AtZhMCCDY3dVccUUDxnsENqJQ//W8QL18=;
 b=dQRwBSgC9uayoKj6YpdT0acN8GbuzS1+kj0j9oTeQhJo8cMH8AKtv3Jieq3p98e5oIQ7C7X49PhLkMqjfJTqCrFumot2Nfo+UgXlNmOkfODmHewEY/YhAzhzSfJzP/WJZqa5s7bY7kwtkTDPDrWUiasRtqK65k17GEpZDKWg6tBs0Fn+FXxt0VIy0+kljFhcm48fxlHfu6sOMbjXBqPpDmTqgTnpz0xKFOZnYka+pldDFlcIc+zOY90c0c/VQr0VIK31BUtw6EsFDQDpB4YebZfgyDttGD7QYMSB8Z0tcuokyEuzspmkhhgdx2tniW4MsVA27ZpvjuJM+aR0SRWsKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by WA4PR10MB169681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:1d0:34::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 18:14:46 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 18:14:46 +0000
Message-ID: <30c95ff5-7064-4f03-b95d-8b55bd65e546@siemens.com>
Date: Thu, 5 Nov 2026 19:14:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] general: Add a b4 configuration file
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20261030-wip-flo-add-b4-config-v1-1-4d4edf0d1b50@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261030-wip-flo-add-b4-config-v1-1-4d4edf0d1b50@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|WA4PR10MB169681:EE_
X-MS-Office365-Filtering-Correlation-Id: 34480422-044a-4873-7c9a-08df3b68ac3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|55112099003|11063799006|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261009221227099003|261009221727099003|261021121427099003|56012099006|261022075727099003|261009223027099003|261009220027099003|261009223327099003|261022105027099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	udHCY0EnEP6e2kZpEeTvWxtvV+LNdvAGafDNNG8tdvmjG7lkCJNSEmUBKaedPJzmJVzpgr8bVwpSrkp0kVYyOtvWV47QOhn73rQMnaWYqM49ogS4Q0fXQDLICwyLAF6DIN16bEQQVj1e66C1isblGmMWXxPF5wfLINvWlA4PXcL+FJg+uNT0eaxHIi5fhxSk9XK1rsT5AC0BS/eeFt3RRXsoYwNS/zQz6xWQdZEw8Y7GVbkYXxkmUh3GX972BosfouCBW9eWphv9pzsx6Qmi0nr2pQgv+B4QLz8xkRdtDO2JgXVTH+RJCM3XuCPq0mgOczUsTTpOm4TUa1pa5gHSpb1OC7Fu+7r9hs5aGsoIvr9+hczaZviiCQBP2HdXPgCjtOFLEUe2DjA9KquE3ns942cd2l4FHHjV/vGu4Zl7YVdRWEf5kssFwv0XRhtIJ3JHA5G8IGEcGqKnY7g2KRj7UhmGeTZXzQACeFmEv1ujhRggYHN5OWlLFzhBxCJ/v3IbDGzPgYUrPtaDZUYHjIZhimFaYub3O4Hgl/ow0jiztRbt9Yg7yqeq+/B5m/4lDyshYVUDG+Im/XFgf5/ds988SBu3AzYjZI5OmAuB6yykne8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(55112099003)(11063799006)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261009221227099003)(261009221727099003)(261021121427099003)(56012099006)(261022075727099003)(261009223027099003)(261009220027099003)(261009223327099003)(261022105027099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG9rWjllUEhETEc4NExja1phdEdlc0ltOVhnMG9oVFN6bzMrbnlkMXFtbU5C?=
 =?utf-8?B?d2NLYzdyR1IyRkoxdDdWdHowMHo1dlFOT3pZTmJwY3ZzZXdyc2FIR21xcURq?=
 =?utf-8?B?eXZwL01ub0FFbENwSmZZa1RxeEpYYzJKa0JlSzZPaFNFamhJMGF2QWxjT1lR?=
 =?utf-8?B?THpKTkQ1Q3lNQTg0bVNRbks2RzVjeXJ6MVJMcmtUT3NHSTQvK1RZZit0RVNm?=
 =?utf-8?B?NzdncnhGMnRWUUY1dXBpRU9iTXNvallTUmVYMEtVZE00M2NYYzEwZnZxY1pF?=
 =?utf-8?B?Q2FhaENCWFV0YXdXTmRic0VvRFpoRUVLSC8yS0JoM3paQWRETVhrODJ5NTZG?=
 =?utf-8?B?bFp3a0FlMXNDelBrMHhBZ0E0WEZXdVFTenRDTmhTTHliTFZFR1dYQmlESEVw?=
 =?utf-8?B?NWc4Wk93SXQ0SDBhSDhKZU1wY2xCQjBjaU1kdWFTamFpYk85L2FSeDdTRGg5?=
 =?utf-8?B?OVluWnB1Q0R0WE82ckQ2WGZEeWJTb1BHYjJEUmo5VzgzTXpkTXE5RUNZKyto?=
 =?utf-8?B?cndQMmduUjJzV0JuUUxDd1A2N1hJRjQ3SnNsdTZqdGFXUE5idE5CWi9HQWRz?=
 =?utf-8?B?MXZiaG5RcFp1MWpUVm5VNkRQVklmUTJZT0FHT09hajlXT2t0RUoxTEc5S1Zl?=
 =?utf-8?B?eU1rOXpWbk9Ja2IzTTBTQlQ2TytwNnNmdzdyQlJiVUdYRFRRam1hOG9sUHE5?=
 =?utf-8?B?ZHg3WDBTWlpGbWcrMGYxVnF0NjBSNEQ1dEE2ZVV5RnpjdkU2Q0dCdEdEdnlT?=
 =?utf-8?B?djN4dlFFSGppUnBJMkxDKzM5MXFTc3NGN2QyODRmc3R4SmZmMTJNQVlKTlh3?=
 =?utf-8?B?QUVUYXUydFYvb0NKUk4xYkEvRHp3THdPRmpWdmpXNWs0alNJbEVlZFkvc25a?=
 =?utf-8?B?bXRJVmdLcFVKRWpNRWk3M0hNd1haTWRocHRMNlBqcnRmb3Y3WTRTcWw3cFNC?=
 =?utf-8?B?Zk9XUVowOGxaMWpuakQyZlJmaEQ1Z1VSU0xHS3B3Z2RTYmVhVjV4S09GS2Qr?=
 =?utf-8?B?OVM2SU1UVnB1UTJXVGtBKzBFOU83NnNOcDFVTjVidEE4eUc1WjE1SElmK3Bm?=
 =?utf-8?B?OEozRlEzWXIwQ0hqNHlGR0x1amdRS3lDOUtEV2NDVUFJZkV0N0tNQk02L3Np?=
 =?utf-8?B?bHl2d2NJT1FZRGQxZnF3SjdIb3NPNW04cmhja2g1Qm9VQ2dNaXdhbzFtSFph?=
 =?utf-8?B?R3dpV0ZNQ3pycjFlZTh1N21DWjBqdkRKZ3dUVkhLVjFIWHY1SzBCaEw1Z3kv?=
 =?utf-8?B?ZmdTREYybzF0VEt6Y3lPeVFIS0s5OWQ0RWtHUkFmVlM0c2liaWt2MmpDTTZD?=
 =?utf-8?B?R2E0ams5SkphOXlrZVVyVTRNcGJGSzBVTHRiZklIUHRGUFpzbGVjR3hkaU9X?=
 =?utf-8?B?MUFWV1pPdTF1MzI5QWVJcVNpdE5jaHdobU1Ya20xdU4yZmtHdVB1T2xuSXh6?=
 =?utf-8?B?MXFXMDdXaU5BSmhaWlBoRzg2T3RRcHc0L2JyZkpzRmt5OVdXcFhJWG1MVmVt?=
 =?utf-8?B?WUJsVFJvZHRYNnFGOFRRWFViSURwcjg3R2huVnBlaWdTNHJtNGc5S2lURU9O?=
 =?utf-8?B?N3BHMDdTbXhPdGFlY0EzOTVhVVBKTkN3WUdZTVBId1pkUFBKMUI2V1BGQXhR?=
 =?utf-8?B?QVhYNC9xTnN5VTF0TUJGVGI5bGlzQTFBTUJJcDNOMjcxemxiMjJDQnJGR1hZ?=
 =?utf-8?B?bkRjSHNtZmw3c294b25RTXVqOE5iSnRJV3pFWEV1K0ZESTVGYWw1K2t3QUMx?=
 =?utf-8?B?bkI1K1dyUVZGb0R0aHlUTWZxRllBV3BEK0FaLzE2c3BJZW9vZUw0dVRlaG1r?=
 =?utf-8?B?d1diVXdpSkczbXhETGtPeVE2MkNBb0pVZGMrRHdKUVY5YTdrN3dPSVhPcWQ1?=
 =?utf-8?B?QmZ6ZjhXZ3p2UDFlVzljTWptbUV0Vit3Vkd4cE9uYVlxOVZvNFJHSVBrZEFs?=
 =?utf-8?B?VWxvb0NnQlZzZVgrWk90Ukp4MUlqbjJKMHB4bjZMeDlnUFM2VW9xdmhackhn?=
 =?utf-8?B?bDIwRldMOGp4ZjZuVlpXUGtENVp6RGdTMWphRlRkejVsdzZCQWRSVmpBMXlq?=
 =?utf-8?B?WDJXeGJkbHFMd0FZeGM0ZGM2TEdkZ1ZsaWlxTXZ5U3NzMVhwTkVEUDdvaGlv?=
 =?utf-8?B?NjYwejRhdTVJL3drYnBCN0R1Q0EzOU1WSmM0VVJHazJDQUIwemQxOU5TVlJL?=
 =?utf-8?B?bVFyZm9QYysvYWdydFR5bzRDaUUyeXo4dHdhMkZOS1J6Z2cwaGVIMVM2MjBG?=
 =?utf-8?B?Vkc0LzVJUlhPbi91TEtwYWVNQXd6QzVpKzNjb3cvM0dUMTJUUkFFZGRNa0xN?=
 =?utf-8?B?KzZJYWdQc1owN0laU0M4U3YwMktlVDJEKzQ3dTcvWEoycjltcXc2QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34480422-044a-4873-7c9a-08df3b68ac3a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:14:46.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0v9fCw+O3QsE6TnihxAkePO/qIxlVHzB1ckBOQ/6DtxkdCnuHLWI+gOVUpR6yr+Vpr9QPuybEhT5WlWCL3j22Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR10MB169681

On 30.10.26 14:01, Florian Bezdeka wrote:
> b4 is a well known tool in the area of Linux kernel development. It
> helps you to manage and send out your contributions / patches.
> Docs are here: https://b4.docs.kernel.org/en/latest/
> 
> As the Xenomai mailing list (reachable via xenomai@lists.linux.dev) is
> hosted on lore.kernel.org, we can re-use that tool for submitting
> patches and managing.
> 
> One important step that needed manual configuration was related to
> the destination mail addresses. We can't use the --auto-to-cc feature
> as-is, because Xenomai itself does not have something like a Maintainers
> file - which b4 is normally parsing.
> 
> Adding a simple configuration file that provides this information solves
> that problem. No manual dealing with mail addresses anymore.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  .b4-config | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 0000000000000000000000000000000000000000..6e6bd54084d0ac1b6c7bfea9f64430f1e282e6ce
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,3 @@
> +[b4]
> +	send-series-to = Xenomai <xenomai@lists.linux.dev>
> +	send-series-cc = Jan Kiszka <jan.kiszka@siemens.com>
> 
> ---
> base-commit: 966862a41d31d28a4e81bb3850541758e7f8896a
> change-id: 20261030-wip-flo-add-b4-config-b35e7c841567
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
