Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795526321;
	b=2P9pvNkTA3Xl+5vikPUQOpzBC6ly0RZBdzgx3E5EjtTe7SFnuAxTwFhoqQa9gNdh2Ur/
	 eNmOsAGQIxIi5/VOHx9kIU/3yNFxS3rURgR4IaZ+rBgp3rYEyZ4drfklZzapdzogcg9I5
	 266XYgm6veFaSeMyqQ0gXhiAGGqtd6ljLKU5gqJ38y02wFpnK07ncLo8S8y2RUBgFA1wk
	 v16TIUkXBZkJW8OYjq17CUYnkRa1FVVhH8lfTo10jxqvosT3S9VmXbs3gMMbyj1S414Ky
	 i3gGcVy7JAIobmRGEyeSg1oZYkKV4FEdZSV1A4g7XIeYvffQTK63WYK6ihJ4r3eW0xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526321;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
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
	bh=sDzNsyo7Kp8lXGrDWsSdndpm8Q43Rz/8X/87Dz2EtXA=;
	b=nWvU2Q6lS3eCcIn06/AhPc0ne2GIZojKMJuKe92xxczlfm+JLKut5aX8r2B9hpqBK0ul
	 qrZuJarp868moxAvAfxGtRhX/z7Ulk5hSZCHHsm9nqEnxJ+g7wPy5JliEk72qq2MiWKb4
	 +SOyXjMaY+MvkalrR40AXAcApNy5jND99Z9SohIoMMvNPBcikoVNgzaNE2LDA3+fr7Wvq
	 qmNB9fhr8LlOIw8PJsESzGvcnReDVeAmeBQ+p4xPREFH6JAwpn8Esrzan78gYp+zhmMc8
	 kW5/IG5/wwctqXf0+3ypGOWZh9emyya/k/3u3wEkk61RFHbX8gLJjfCzUXWWjR8gJOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=HwDLBTyB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.16
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D8606A31E
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 13:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD8D8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=HwDLBTyB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSK5bQVH+M56vTndNMmYHmDtmBlDuY/9J1nXq/STd/FYW6WE71ZgRnPHE28vGCOcPzNY1iXpRa8pE5IapMGCUU9pc68562rImEzwkCAcuczyDEMirPsgN1eLypcAFPHRHf4ql8JyX0Y3QZQAzqDLrLpZh2sFAMRaiok9x6aj5kkCRqKw+z/PRpv43Ct7TdwZUFy3YHJoBLbXyyoC7oMVcaQhHnXQJ+n9LxOogDJ5nPmOwikT5wltz0A8JBB9vSxoL3oaIEywh92jvyPbxXa3ULiCyDbyU9HS0WFICtuDcXML3pXUJZUSck96dMjQ0tkC+n9PuGhY0nZGC4oCfJSB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDzNsyo7Kp8lXGrDWsSdndpm8Q43Rz/8X/87Dz2EtXA=;
 b=PolrQyJa62DHr8cR6IKgI9FpUrmFQYor57wu/19RJGMGCskbe9Yjq0Jnruh55xF1EpYjZVtR8HQWwiLbz36HIhfsnhl1f+9VADI+WRvw8kPL3KK/K+6+ahB3EkhErvBgb9fOt1k3oeKmfGKmgC0EQKvcYNpgr52mLfaWbVq5UDbo/dg8LEHMK28UgLGxLwanij+vCnga6m0RM2o0uNTz/Jf7qwIoW5VQ1VWLsJ2dswqKjl/oYqCDuGVdWcxvaE3KaY4iC84L6h7UIzEozSKeKU55UffI4bUDSwDFAcyeaLvWZo4euPFg8kkYKeqhhWTAvB2m5yxz4mTv+ZrOEVwa1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDzNsyo7Kp8lXGrDWsSdndpm8Q43Rz/8X/87Dz2EtXA=;
 b=HwDLBTyBCzc1S7nj97ZlrlDSZVfAhmynohU7BbatjPUzjMqTAAannqCJ4D/hN6Dnqu/3114Dhdau6r5vW9JSte/67T1PDf5CHU/qnBUBY/avOM41Jei3RQXFMUcvCle8I74uk5z/RxY1Pom7uFJahHl5Cgfct+hDakyeSXmUTfv9bp3IO1Qxra0sN/G1SMs4gZm3w86/0xKc+SG6sRtjDnEyWIB6GKKkOQ9wQyYhs4g5je/ACFqnS+p1QtZovZ1OII+fRRcwdXQXi3B4QU8C/ZJKm+bXxH21CJrnVRbYVEddt8AG7FLYVTVONReVi53Jj4vinqbZ6YzgxJqH/umt3g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS8PR10MB7425.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5a9::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 13:18:37 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 13:18:36 +0000
Message-ID: <856b463c-5e62-4ebe-b646-456539b0766a@siemens.com>
Date: Tue, 24 Nov 2026 14:18:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Mercury build fixes
To: Yegor Yefremov <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20261119071745.2409665-1-yegorslists@googlemail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261119071745.2409665-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::28) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS8PR10MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 55762d19-95cc-4301-34c4-08df4a2d7287
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|261102123227099003|261028144727099003|11063799006|56012099006|261009223027099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261021123027099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	49sG4HKBtcYhg53GmFQR63i9RMu/0oVXmb9Wou+nKiZfc9wrocna/wu5RCIvN4W2rnMjcF/fVIFIlTD5EZMhTOwofQpFVsgaeqe+wnMXTFpAIv0EqWrMliVgG/9dN5PsSZFlkA/QXLNtP50CBffhXBmXTg920sqceJpHO3QUOopYPLryKICTUzdqjRCepJ5ZRPsIpj/RsJ154SH25G7FZVVrJfmlirdq6B2vYmbkSQaaoBdOKJaCnE0oBIPnycbzDRrOb0oh3NbzSNAlKFSpPQRV+YijZtzNrHbguZEpTnfXE4KmtcnBVp3MLaykAPcepxJi6KpoFiML6N2eshFW/lGoB8byI3wlERXfN9T8gcnK7bupNm55J1zawVgwvcUXAE0Gt3wD6WmyIt3zKHXjirNYZApy6rv7/LpJRfssOa4yvSpumAH1fmJ0TsGvGwz6B5GQNnPpA6+4D3JAKYJIDyM7UxPKOzFa1LAb7lF9tAe2kwcgkpG+Q6FryCxgJS9FuOrPSCY7fwmorTOaGhVjIuzIcUJh3zCVyrzdj1ZgW4kgKcbjQ2ihtIlXx6IWbXKVlR4/haDSa68MFcOrA5UEBrW/XMRF4MlBoIHZo4k/ZELaSyrlJKgwqDR+taGkRCqcOc0ZxZLS2xZLAfnhEMB26m5kec7/6mB/G/osdWJh5II=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(261102123227099003)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021123027099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVljM1hOeEZiWktodndDamJaa2dHMkZqeFhaU1l3d1ZVR0lSTi9tUlNneTU1?=
 =?utf-8?B?SlZJcTg4QVRrS1NWandvdmRFVXFEYzc2dGFhckJLTFhjVEs2TzZJMStEUTZP?=
 =?utf-8?B?Y3F0bmtvdmZjYjZFQkZ3bDEwTTZNbXplU01XcGo3VERaZXJqSFNMbTRQNkNl?=
 =?utf-8?B?UmY1T2ZOTWtWZi9qbjZESXZmQVBmVjY3SkRVaHVJZ1JTWW82RzVaSnROUklk?=
 =?utf-8?B?YlZUQkIxVkkxKzFhU3JPQW9DYTBIRzRGTjM3TjFWblRzbTh4elltUHA3amVW?=
 =?utf-8?B?NXB2blVNQzhQREkyNVhKRmdVSVd6eU0vZ3FtTTRRT1V1U1lPK0hYNFdCMVBK?=
 =?utf-8?B?TGg4ZFVEdzVPY2NydG1weVQ1dzZycDdJRWNQeEV0S2ZwSGpscTdFTHUxZzIz?=
 =?utf-8?B?ekVMRXI4bm9EcFpTZ2RVampOZ0V5dHlLZmRBZzNpenoyZWxLenJ4V2prWElo?=
 =?utf-8?B?akluR0JvUDB5c0tOaW5OOVBCN2w5M0lsUkdQL0JqWHVCV0pxV1ZnOGwvaVJm?=
 =?utf-8?B?Kzh0bFlHSHVwNmtwU0l3SUVrbHpNcTFCQ3c2d0loaGRKa1FtUDlGejUzZW1z?=
 =?utf-8?B?U1R0K0twajd3cGpYS3UvbWNJdW90Yy9hWE1oZTFxdHJPQ0dqMjRjL3hHTm45?=
 =?utf-8?B?TFJaTTZVNXd0VFNtbEZsTjRkcGtvZ3JBKzVxbmtlYkU4SXB1VHFjYWw1S1o2?=
 =?utf-8?B?YlQ3eW1tWVY2K0M2a1BSVG56YVJGRUlNc0VRTDRXZUduRjdocVFndHFJWXVa?=
 =?utf-8?B?bStEcjVKKzFyTXZFNnp6WXhHdEJYZ1BMeEh3TnVLOFlxNlZGb1AvYmgrU3I5?=
 =?utf-8?B?a0dsclhia1o1QWl5Zng3VTVVNElZQWpOeVJ0aU5WTzJrd1NIZ3F0Q1h3MjFq?=
 =?utf-8?B?ZXM5Z1Awdld0cGEwZWlhclFDd1FrZ1pKMnFramp6ZSthU2ErODA5YStzeEcw?=
 =?utf-8?B?NkcwWkl4SnluQ2JTdnFjUzRiQ244OUV3bC9SZUsvV3k3Z2tHV2ZtZEZiS0lz?=
 =?utf-8?B?S25RY0RTNlhwMVhBaXFaalV2ZUNtOXI0WC83YWdSekp4TDZmQU9sL0xCVDIw?=
 =?utf-8?B?bGpSSVl4cFlNbXFDenI2RWhBc2VLaDVEdTJoeW5mbjdlTVlwTlltQ285YUFB?=
 =?utf-8?B?dWxPVWFNdWgvV1Q5WXY3RFFObitSQU9Va1BCcitqQVh6UjUvTDBWbVBFc3V0?=
 =?utf-8?B?bFlKVzJ4cjhXT1cyYWg2b1RZaElrK21YT3dwQXNEZmFuYVdYbkdudllNNkt4?=
 =?utf-8?B?Y3dvZWNQRVo0dnJVaGM0K2JOSUxqZVBZSVd2aGNCVXFleTk2VlFWZ2VXNUt1?=
 =?utf-8?B?ZUxKcXlJYjdiaFRLWXp6ZWowcTV1OStKVlVjZXI5VG4yN1VjUGJYa0tQTFlh?=
 =?utf-8?B?ZE5kTnk5S01talU2dHNGWlZhL0YvaTA4cFlSNmU0VERQUzVNVExSejdiWWtP?=
 =?utf-8?B?OGdwZTNIZnMrSjJKNTdDRWQ4Nmphb0tHK0dkTkIxZmZZenZqbDNmanNVWXN2?=
 =?utf-8?B?bitwZkhSbitCTldZZWpQTm1mVlpCNElQbjZwcnNoTG15ZStzSHVDdWlLYVpp?=
 =?utf-8?B?NXBjb1YwUXVMSUUrV3V0MVlPbDBiTUlPQVZwQ2tWZjdDc09aYVNiUDFGNWph?=
 =?utf-8?B?Qm5kWjlLOUxIN3RmN2lYRTFLVzA2U0dUcVJReXBZOXVyV0M3NHVaa3cxbHZZ?=
 =?utf-8?B?WktHeGVTYlh3S2Y1YVlZTzcwcVdUSTl0N2Y5OHJLM0FYZzFMSDNNMjZnS3Ft?=
 =?utf-8?B?bmRoZmRHV2lPdEZ2cXJJRm9FbGk5K1dwa3JVQkQvclg4TnpyY2kyeWhFU09l?=
 =?utf-8?B?U09CZWx1bG5PNVVVK011anAyQ0QzQ296Q0xzNThTMDFITUtyYlR5MnpScEx2?=
 =?utf-8?B?eEpHL3E2NnU0SndQMnVDSEpvUmRVc2ozSm96NkR0NU5sYVd4SktlOFNPKy9W?=
 =?utf-8?B?cDFrMmdobmJDamNrNFlEbGRkdmc4bXczMUREaEN5clBYdm05K2RXblVUbE5o?=
 =?utf-8?B?U3V2WUgxWnkxN0xrd2hSc0VtUzNNMXFsaWNYd3A4OWtyYTVzenZlYUVPTHdK?=
 =?utf-8?B?RVlxMkc5OXFaYk1BQ1kxd3ZiMXprblBDT0t2OTdoS01BelVLS05kMkFNZmt5?=
 =?utf-8?B?OTdZSHpkYkM2WllSR2tTL0VzNW9OeW5BVmt6S3pVYkJtWTBkcFNGTkgxR1Ar?=
 =?utf-8?B?aS83aEpWM2I0NFZjT3IydDQ0dkttcVlvSGFoTUFUS2FlU25GMFBHOXQ4OVdZ?=
 =?utf-8?B?YWRmYXJoUnIwWElTKzNiajJ5citmSStRYk5GeTVuYmRHbTZ1Nk56UThVL2NC?=
 =?utf-8?B?eGdEVFNvaGdNRmppa21NQS84RStlZ0QxYWlBdTArRnZXdjEzVWJSZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55762d19-95cc-4301-34c4-08df4a2d7287
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:18:36.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tkMU7TkXEymvZUZ4S5u4LS6SPMfJGQjtcYPJbrNtxfwnTTfpJ0irmOmYitYgZW8la/9n45yliyXONS6dLrt7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7425

On 19.11.26 08:17, Yegor Yefremov wrote:
> The Mercury core and its testsuite no longer build on next, as several
> includes are only pulled in indirectly with Cobalt, and pipe-1 is built
> although the Alchemy pipe API only exists with Cobalt.
> 
> The missing includes don't depend on the C library: glibc 2.24, 2.35
> and 2.44 and uClibc-ng 1.0.59 all fail on the same lines. Only the
> missing <stdbool.h> depends on the compiler, as GCC 15 and later
> default to C23, where bool is a keyword.
> 
> Tested with next plus this series:
> - Mercury with the testsuite, built directly with configure and
>   "make -k" for aarch64 (glibc 2.24, GCC 6), armv7 (glibc 2.44,
>   GCC 16), armv5 (uClibc-ng 1.0.59, GCC 15) and x86_64 (glibc 2.35,
>   GCC 11).
> - With Buildroot: Mercury with and without the testsuite and the
>   Alchemy, pSOS and VxWorks skins, for armv5 (uClibc), armv7 (glibc),
>   aarch64 (glibc, GCC 6) and a static uClibc arm toolchain.
> - With Buildroot: Cobalt with the testsuite and all skins for armv7
>   and aarch64, and for x86_64 with GCC 16 together with a 6.12
>   Dovetail kernel. With uClibc, Cobalt fails as before on
>   __OPEN_NEEDS_MODE in rtdm.c and on the missing <sys/auxv.h> in
>   parse_vdso.c, which this series doesn't touch.
> 
> The series also applies cleanly to stable/v3.3.x.
> 
> Changes v2 -> v3:
> - Added Florian's "testsuite/smokey/alchemytests: Fix build failure
>   with core !cobalt" from wip/flo/refactor-includes as patch 2
>   (suggested by Florian).
> 
> Changes v1 -> v2:
> - Rebased on next.
> - Dropped the autotune, sched-tp and pSOS/VxWorks GCC 16 fixes, which
>   are already in next (thanks Florian).
> - Patch 1: include the headers only for the Mercury core
>   (suggested by Florian).
> - New patches 3 and 4: further missing includes found when building
>   the Mercury testsuite.
> 
> Florian Bezdeka (1):
>   testsuite/smokey/alchemytests: Fix build failure with core !cobalt
> 
> Yegor Yefremov (4):
>   lib: Restore includes needed by the Mercury core
>   testsuite/smokey/alchemytests: Add missing includes
>   testsuite/smokey: Include stdbool.h where needed
>   testsuite/gpiobench: Include stdarg.h
> 
>  lib/boilerplate/setup.c                      |  3 +++
>  lib/copperplate/internal.c                   |  4 ++++
>  testsuite/gpiobench/gpiobench.c              |  1 +
>  testsuite/smokey/alchemytests/Makefile.am    | 17 ++++++++++++-----
>  testsuite/smokey/alchemytests/alchemytests.c |  3 +++
>  testsuite/smokey/alchemytests/event-1.c      |  1 +
>  testsuite/smokey/alchemytests/mq-2.c         |  1 +
>  testsuite/smokey/alchemytests/task-11.c      |  1 +
>  testsuite/smokey/alchemytests/task-2.c       |  2 ++
>  testsuite/smokey/psostests/task-2.c          |  1 +
>  testsuite/smokey/vxworkstests/task-2.c       |  1 +
>  11 files changed, 30 insertions(+), 5 deletions(-)
> 

Thanks, applied to next. I need to spend some time on backporting fixes
to stable, soon...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
